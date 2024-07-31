Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E0AC3DA49
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 01:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02B08841E;
	Wed, 31 Jul 2024 03:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OWpAx6GF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC4A88780; Wed, 31 Jul 2024 03:41:27 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F331F8841E
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 03:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3db23a6085aso262986b6e.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 18:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722390084; x=1722994884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZY5G9MyMOg92ThJj8l6v3QA1KQThVonzoJBFhxb0iM=;
 b=OWpAx6GFswP/nUMYzdqZmj8WHQv5eAvpN5DGHGLHxReODjkrpWRiFdETuApqR09RNR
 jwUBlXpGXScd5SLIT6YaFv754KyGiCWITipzC8RzVbUeViBXhf3AdYyEecBtYwApudm2
 52TYXWmmlpMxDmwxiF21A9GnT4BL/MSXFnyoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722390084; x=1722994884;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZY5G9MyMOg92ThJj8l6v3QA1KQThVonzoJBFhxb0iM=;
 b=inOUu0x97c5hogB4mcg5oBPhlAqeGc8rIhLeXvwRFELGwGbpP/jgCW4Zikpm4deEzX
 HIxsJtGIfdCvM20pqz05s06jMh2Tj4s7h0IMLywOwZJXvbErRvMzhnSaMAAR3TY/CLAV
 1BiMwkpftGWjUnLEqheI4HKEFuKpWIFHQF22nIkEI5J+rhEeDj5Utz40cwxgQ4OGQr7x
 Zhp0nLgcPyjtA7w67yh1HrsODogHKrEm3uFl1NILzfJAV6srLW3GBGnjYSLqRkJmoEcs
 BZMeIDXE4UtYRvCAVse8B34rtwN/+vQ/DmyWkkNURlTYiV+vI7f9xmSA0zEqlk8ZCt32
 U1Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCvZWDgC6kUACSTeN3LgP7guCDxwFPNsoXpt3Tqyh/oL3SM/TTkURZxWmGmUl3OGJFJulG34TGRz4MSlpcqK2ExpPiJg==
X-Gm-Message-State: AOJu0YzEUpr526x3F8R2akpyOB82QvxPsnoMPctl9QE2dkKjFuy6xBkp
 O8fppGq2f3lD4e92tRlpwXjjDVr0mdCxOBV69ciHMoFaQ/5XNhqo3vOa3+4ZbbE=
X-Google-Smtp-Source: AGHT+IH08Wa3mtBD+5Mu/XQnKzM1BozVuDSXy0Ga9U3cATsYOw86uktamfdhvlyWjnegsyzNqpmZQA==
X-Received: by 2002:a05:6808:3021:b0:3db:169c:96de with SMTP id
 5614622812f47-3db42d37592mr1913171b6e.16.1722390083700; 
 Tue, 30 Jul 2024 18:41:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653de269b1sm2533375fac.1.2024.07.30.18.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 18:41:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH v6 0/3] led: implement software blinking
Message-Id: <172239008261.3831478.7216405283004244043.b4-ty@konsulko.com>
Date: Tue, 30 Jul 2024 19:41:22 -0600
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

On Fri, 19 Jul 2024 13:12:10 +0400, Mikhail Kshevetskiy wrote:

> v2 changes:
>  * Drop sw_blink_state structure, move its necessary fields to
>    led_uc_plat structure.
>  * Add cyclic_info pointer to led_uc_plat structure. This
>    simplify code a lot.
>  * Remove cyclic function search logic. Not needed anymore.
>  * Fix blinking period. It was twice large.
>  * Other cleanups.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


