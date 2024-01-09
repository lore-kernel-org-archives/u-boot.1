Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEB9C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 15:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43FD687807;
	Tue,  9 Jan 2024 16:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EbHxbrcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD1586EEC; Tue,  9 Jan 2024 16:44:08 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72DD7878CB
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 16:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e4d64a431so10119205e9.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 07:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704815043; x=1705419843;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iScU+EujS2rUnqz5IiIYIsIvjMzXyod/9Mp7YnkcFNA=;
 b=EbHxbrcypL7jXp+etGOv3e30S8hRF9cR003afc36mzNgTN3gDOL9ZY3FC7BNleN/Mm
 87wU03u/4xCDqiCF7BvsAAo7hIf/54LzV+2SS+06juimlgu4oo6epsLSR5bSOQy5wXSz
 rzPt44HC2mL00MPRmDT0x6x1oeF19Oi4rfHXUkvE0asDlUpO8KqK2NUXozySFwvkW5s8
 kiaW0OrrKlszVu6iXYvD6oZcgIOuMhFWC4k42Mqxkebm9YBnNyA2KeWjnAwsXRh5enCr
 Ay3rJ0EyoQG3XySNEOSpAFt5VE/gFxj8cqnEJIIc7cPpdn0/77tMN7TNlcH6ChtKIyQ2
 Kr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704815043; x=1705419843;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iScU+EujS2rUnqz5IiIYIsIvjMzXyod/9Mp7YnkcFNA=;
 b=tAxW4MTc4rh0fWpwDlaJe7dpCpOLlWGmZ9mdOsOEKPDzLSQbJE3KizKI9chnp822vn
 +IhshIaVhDaGPHAfSmz1l8tq2B5CKQXIKfPma3mHqTvZXqAIqt4YerutTrQWpCpIvDKG
 uRrmXQpfu/AIuuj9r1zdfvEAnj9tkrXUkHeVwKGMnHVWqVqZk1e3qI6C/9F19+YXKR7g
 VAHgUF/xqU6GzYwv0Hbs1asE1JeH0JbxXFR4siw2H4VzOg9toCLknydPieeV2Oogp6m2
 LtjqmmGxV+ZiMxt+df8367EVKz99yFOAyQjz9USwZ8ljcyee/AzZsrVB9KkOYUzdl2K8
 0WVg==
X-Gm-Message-State: AOJu0YxirdGx482zLWAIaxbwF6VFhvsKjLyXQ6fVNE/eAPPTeJibS3A+
 Si2R37tIToXcgYZTJNKbXRg+42tKzFbXeg==
X-Google-Smtp-Source: AGHT+IHE/9z3gWoxDwS9AkKupMrPY3Tl8GjLjOtasgb4dLw/kATXbK6ZKZGhrOBcS5qzqiafxN5yuQ==
X-Received: by 2002:a7b:c043:0:b0:40d:8fd1:6111 with SMTP id
 u3-20020a7bc043000000b0040d8fd16111mr3441605wmc.116.1704815042271; 
 Tue, 09 Jan 2024 07:44:02 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 fj14-20020a05600c0c8e00b0040d83ab2ecdsm4269197wmb.21.2024.01.09.07.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 07:44:01 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Ion Agorria <ion@agorria.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240105072212.6615-1-clamor95@gmail.com>
References: <20240105072212.6615-1-clamor95@gmail.com>
Subject: Re: [PATCH v7 0/7] Implement fastboot multiresponce
Message-Id: <170481504146.868549.4022925880644870483.b4-ty@baylibre.com>
Date: Tue, 09 Jan 2024 16:44:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4-dev-6aa5d
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

Hi,

On Fri, 05 Jan 2024 09:22:05 +0200, Svyatoslav Ryhel wrote:
> Currently u-boot fastboot can only send one message back to host,
> so if there is a need to print more than one line messages must be
> kept sending until all the required data is obtained. This behavior
> can be adjusted using multiresponce ability (getting multiple lines
> of response) proposed in this patch set.
> 
> Implementation of multiresponce leads to ability to dump content of
> console buffer which, with use of "oem run", allows to entirely avoid
> need in UART.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/7] fastboot: multiresponse support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/85fcd69dc2c03025648a1b1b511c1f10abf87c1e
[2/7] fastboot: implement "getvar all"
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/475aa9aabee7ab472341d755cc339f1345d5f49e
[3/7] common: console: introduce console_record_isempty helper
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9ce75f49127858d1aa36d455a869137e4d36681b
[4/7] common: console: record console from the beginning
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/90087dd076d42c196de3506b6fa4d052f0869670
[5/7] lib: membuff: fix readline not returning line in case of overflow
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/e58bafc35fe37491bb3546299593dcc054145adb
[6/7] fastboot: add oem console command support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/16f79dd4cd624de0ee336dfeeac6db954f99ae68
[7/7] test: hush: dollar: fix bagous behavior
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6c2f753f4ad3dcee60190949d1286736a6d51d17

--
Mattijs
