Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A7EC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3DBC87646;
	Tue, 19 Dec 2023 15:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="usfFhb9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A644487620; Tue, 19 Dec 2023 15:55:21 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FA18760D
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5d2d0661a8dso35626017b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702997715; x=1703602515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHQw+PH7k1/0pY9quZMtVHVaBXbSLml0/z2PHeJO0XY=;
 b=usfFhb9PTTDSmdqg8Hb0ndKox0/GuE4zTG5Cl+TZLsvwQ81hZ8vqRtM/SI6Icu9Rc2
 JZhBDpX54PE3WridS5gZYMQsXJ4DRy77/MkCes5gDMfzVo1fnp7O5vfNYQb2OFUMxjxg
 bWkwEiB5pRmyjMDuWsyWHdriiy+kCQjR7A7Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702997715; x=1703602515;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHQw+PH7k1/0pY9quZMtVHVaBXbSLml0/z2PHeJO0XY=;
 b=HA9iJH+z0KKSFQ55pytzHFDzu5LWWfT1Q+EFlWWmxg4zIH7vKsbJ8NIWHIVGe1Ht9N
 CMYkLB0YPrIVUf7pAA8bug4CVOn9P7r/vTI2W68J4xA3MxiNg4n8pwhz7PAShwd4SHm8
 LtAGoTjQIpJvd71cYjs9jJ+fa29Yq5TRhv3ZRuQoEREq/9Y40L4mmEj3T+Rl27RY3M+t
 2hKNiLaXwo7UYC4dFaNeD5CE3tf3BlRFxJOeLXw8g+eRZT6kSTfL4ym3mvADtkmai4t+
 KbzsyypaksopPHFfY8qQ45CSdZBscxsKGmAe4KygKjJq1aj3yyAJledM8xZDcMICtQJY
 7SeA==
X-Gm-Message-State: AOJu0Yz1/IYEw9StTnVLFpdmEATDbcfC0kmMTjxMMOPg7rutbHQwaCPM
 FRNjYz8LmJNAWkwv3trvKXLCxqL0naLP5XPTnBA=
X-Google-Smtp-Source: AGHT+IGfMG7QZEsrAmTx9CfdSkZmlrb+PhwBJBKLDGN80Z0mXHjI8l2ryOxNUOWFrlLawTFkWi/c+A==
X-Received: by 2002:a81:d541:0:b0:5d2:bb18:5834 with SMTP id
 l1-20020a81d541000000b005d2bb185834mr14049583ywj.15.1702997715017; 
 Tue, 19 Dec 2023 06:55:15 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a0df504000000b005d746ac7f6bsm9657580ywf.69.2023.12.19.06.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 06:55:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231216180804.173374-1-marek.vasut+renesas@mailbox.org>
References: <20231216180804.173374-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] get_maintainer.pl: Add --git to look up CCed in git
 history
Message-Id: <170299771337.2342388.6659714303467887607.b4-ty@konsulko.com>
Date: Tue, 19 Dec 2023 09:55:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sat, 16 Dec 2023 19:07:52 +0100, Marek Vasut wrote:

> Add the --git parameter, else recent contributors are left out of the CC list.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


