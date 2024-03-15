Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2334DC54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 12:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7DA87FCD;
	Fri, 15 Mar 2024 13:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e0RsaV4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C169887F3F; Fri, 15 Mar 2024 13:19:14 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792AC87F3F
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 13:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-781753f52afso113100985a.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710505151; x=1711109951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byvDWsXZlxYx9nciRDGhKZEBZUvb9LJJmO0ntWcaMrY=;
 b=e0RsaV4BUuvztLXi3CR2tgndOKzXBxiyT2TLKmige3DVcBjg/ldW0Q7sTn1IhnItx2
 P8Wy4S7vsM0iSlzx1Th9mLrIx1h5HgYG1obIRg/w07JI1maxtb3jyjwOst8EiV1ARTlY
 BWOwzdnxD5hAIJUaeP76HGoW0xc3se6ziXVEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710505151; x=1711109951;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byvDWsXZlxYx9nciRDGhKZEBZUvb9LJJmO0ntWcaMrY=;
 b=uFKcEbNgtY5lDLgSbFUCsomUX8E7WEF78KIu0wtFnx98WrNtvqrDbvUIbGIAEaNOSG
 Q/kQ+w2HeXmwe70dua1K8zzGSe05VnAqQOX4cTHMdJHZJuH81foFx2qtVRnKX4tT88QE
 Or/e5LFanXh2gDyO0L8VmSs8oyLP3cOSdN/4L8zZuSn2olimP6+D6esJndE08GPS9s6A
 znaZbqiEgNJh1mYopvlQCDkzBKjeUfMWZnXLb76vZV6+8uW1WTF+DZDeStUumbrgqBW/
 9kg1zc/C3ZQjMkMTXWBp5WmR6CpDE0ZIHeZqxqqDEh7qePmELCAzKsfPmun2yNcLLe4O
 wnqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKqwJOKtwa4rfKWJwO/OYJaCQ2yehlqPwRzc1ohweWvN4bkdZ4xBj6jA3kk0bK5g255nHrhN60GGExCMJsjY6KiIwkoQ==
X-Gm-Message-State: AOJu0YyYUYcNVET8bXofjjub76cH/OTj+fs7zuDsxpPD1FdFCS5ffije
 ZCvJr3sw/q0wvuV2rGA0deaF1WLhS6OlK01wO9m19Qq+llrNXxvbwc1ju2IsMsFyyJYr/C3isF8
 2
X-Google-Smtp-Source: AGHT+IEsStxnD/weZArOoNs5MtxzW/LhKtXob0VfFF197XFdxLu40UdFMCcd0WdYYgV/MUBlmj6H+g==
X-Received: by 2002:a05:620a:145b:b0:789:e917:ac9e with SMTP id
 i27-20020a05620a145b00b00789e917ac9emr334279qkl.47.1710505150912; 
 Fri, 15 Mar 2024 05:19:10 -0700 (PDT)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:7f::1004]) by smtp.gmail.com with ESMTPSA id
 vu24-20020a05620a561800b0078874565b40sm2009011qkn.30.2024.03.15.05.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 05:19:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20240228074311.500761-1-heinrich.schuchardt@canonical.com>
References: <20240228074311.500761-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] Dockerfile: build fiptool
Message-Id: <171050515025.774434.655790127484196358.b4-ty@konsulko.com>
Date: Fri, 15 Mar 2024 08:19:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 28 Feb 2024 08:43:11 +0100, Heinrich Schuchardt wrote:

> Fiptool is used in a binman test. The test is skipped without the binary.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


