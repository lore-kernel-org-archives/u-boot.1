Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D1AE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 17:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A288036D;
	Thu, 19 Dec 2024 18:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="boSawTzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E7B18035E; Thu, 19 Dec 2024 18:51:14 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F33802EF
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 18:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so76033185a.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734630671; x=1735235471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZwr0zk8NzTtji1H2r5q633+CqyXXcYmWT2/LR3Empc=;
 b=boSawTzuQlkL4jjFHLH6lNRvr3qra2VpnZgFRl/uOI9SyGAsOI9Ufmma8H0fP61zhb
 Q086PjfbZkFl54S/c7DqyNxmQw6MYi0P+NU51uutaO6328fFCAnmIiObgMARjlc8o6oX
 7FRtk3Q8S1I6Hmer79VUeqweqrXwaVtjHMlpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630671; x=1735235471;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZwr0zk8NzTtji1H2r5q633+CqyXXcYmWT2/LR3Empc=;
 b=AMwRiHlXfSmirKDM2/Q+u60agiaa9uD4uiFL8x38lRUd5L0mQECKpFzWyZia0sUcaD
 fVlUZlpq7jGngYoHQAsNDd2R3FB5uJXkjhEEcs60utOVUmVsNi6vUgalRkRYjtbVOs76
 47hU974QQVP67ErDTjKL2Ew2mPSP7FFAyBBWb/iN4Wwg4XhzgI9LlgajQbXQYrbfp15N
 cblIMr2pfsmc9U5eWbShdG8/Es2mB5ExqIP6xZqRlNuIC/d7RhBC7Hco9NuIsHtPM62M
 5D+UPssSxTx0e6po/fEnkrlYPIOF5EfK6sKQctyEETlYzYGz4/Q2s7ssV2LgWqBp0l0s
 8JNg==
X-Gm-Message-State: AOJu0YzQMmMvDE/Tgb+qD1V63z99NLxtecygWZDaOPYIjSZTYT1O3aSO
 udSycLyLaWNXaCcWFftXXJ7+szGNIsZCPgRCyXj7ipzbZ7jIB/ypmw/RfOEdwrImhExBGhLkBKA
 w
X-Gm-Gg: ASbGnctHVnnDsKU1s0GAr8UelZgycDtex99NHQNZdJBnOeGWDLVhXazuwDtQfJEeEeJ
 WPDLJwQhu0QEH3SMY5YskWaiq7ssnHBwKwOrRFy2WGtHEBF+6NoxWPUherqbek2jhDxMlhI1COZ
 Y6umGqsRJGKy5gN5Fle0c5erE9X0NSnIghqwuKTdwFK8gbC9PsA5UKCRzuAnVikdT1PEOIIQDwi
 DuxJQGNp7fsB3INA1K4MppdMWcC4fXsi4IZ1ep2xh7ihH/uiTWZagU=
X-Google-Smtp-Source: AGHT+IHvSecf6WWZd5aWqYj7mMJf07xfQyj5+X9vGYa4M6BU3pFml2WiymftpAiGFqG4XM9pNo6H0w==
X-Received: by 2002:a05:620a:4614:b0:7b6:fdb9:1be6 with SMTP id
 af79cd13be357-7b9aa9038cdmr568063885a.29.1734630671118; 
 Thu, 19 Dec 2024 09:51:11 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478e33sm67004685a.76.2024.12.19.09.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:51:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org
In-Reply-To: <20241125175421.1181907-1-paul.henrys_ext@softathome.com>
References: <20241125175421.1181907-1-paul.henrys_ext@softathome.com>
Subject: Re: [PATCH v2 1/1] tools: binman: etype: Allow to replace 'NAME'
 in node names
Message-Id: <173463066928.3644953.18265874259418870773.b4-ty@konsulko.com>
Date: Thu, 19 Dec 2024 11:51:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 25 Nov 2024 18:54:21 +0100, Paul HENRYS wrote:

> This change allows to replace both 'SEQ' and 'NAME' keywords by respectively a
> sequence number and the name of the FDT to provide more flexibility in the node
> name for the device trees included in the FIT.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


