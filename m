Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7442C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 12:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA5280EFB;
	Thu,  1 May 2025 14:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BorR5yqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC398081A; Thu,  1 May 2025 14:07:16 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C7E38081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 14:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac34257295dso134188466b.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746101232; x=1746706032; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nNZq7GzOUZ10VqYZZTc4p8QHbCpktSDm90T8U4D8yQA=;
 b=BorR5yqAx/6iyXsdzWydTR8BODUKeS3a20tvsnn3alLoVWTKHpIE7KjjQva4AtSM5w
 cM2VN8s2RtyZkNEqgEfdhNhsliFwVOol38MqYGWY05ahsbltMh0/bN/eEcPdqDr7lZzg
 Xf2QmMNtmDkBoGoIxkjkPPV04gq11dZwRJAa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746101232; x=1746706032;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nNZq7GzOUZ10VqYZZTc4p8QHbCpktSDm90T8U4D8yQA=;
 b=bOcsdqbp4tzeI9j8Sz8mX8s7mMHsQ6nTR4Q9JXxDHbFu68MA/YOtdItxoLZa35b3lH
 Savs6zBymAaBG/lOuZwATl2SMWCIfyrsC4s3XREClhR3FUh9IVWvGT5o0zMZJONIti7L
 HJ3pAD4uMc/+GOfnnM2jolHE7ZhgIsrNiVjvFhlyB9q8UkNlKOEBRjGqaGmDgj7djL3f
 Fd2wNDe6H+xySs2pk9CTfPDXCAz5Chwzc6qvddwgGjv5RyJdZevaXgsqxRxtPmwK6P3X
 kNP12vTqbygp8DuBhpSF8chtzHlovGg6yXeJrPt6OhvkIthUasVJ6ank2fHzUW8XFQo8
 IdAw==
X-Gm-Message-State: AOJu0YwJKDy+sL7BvDbhl7WoLwvoiEefedR1Y4yi7ev5VUnvV8ePHcWO
 /h3+Voi1NklpF1YIFq93wGynYDOUUlOt5Eujey8P4OEoYTfEiJIks34Sh98mTGL5LGIe+ShmxYS
 J2d4WaUPKr4TLnRSmYe2tIMgm++ua4WkyJx1pdcX6HImQPWXLZg==
X-Gm-Gg: ASbGnctE56N66VD5Yi5BnNsTBAPygaLMIdL2z/siJ15LUt0QwRizwqGjIRqyCix/0e6
 hTUoD23QUAG96bLKwihNpqcHwnDo4xgM1FdflResfRgcaOyL3EPCGvhgKnKzAFC5RtdCctXBh3u
 12OXmj9cRk6xrXT3QuSxyLhKU=
X-Google-Smtp-Source: AGHT+IHa9crEUHAhAx9/pH9wbd1hP49hLPHvDcIp5qHG8O3CDImx3LDyej7Keo3K/S5kiyUzxM3wIQK3JwbIFXNzsxA=
X-Received: by 2002:a17:907:1c1e:b0:ace:c225:c71d with SMTP id
 a640c23a62f3a-acefb9da3b5mr220535866b.2.1746101232428; Thu, 01 May 2025
 05:07:12 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 06:06:59 -0600
X-Gm-Features: ATxdqUFlCV9JkwEkh0CSgCsF7eU3p4LbOPszI0y3puemkjiJmjIvZ4RhsHeAcRs
Message-ID: <CAFLszThj=AEg3AMEQCLaAEnB7jU2OUSx8DWk-rqj2D5L_Aa49Q@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/2a61f40d4a9f7eacce67a80ce79f916996c4196d

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=75&view=results


The following changes since commit aa96cda0a58f4d181b81a897b0b9fea3d9729478:

  clk: fix crash on clk_set_rate clean rate cache (2025-04-30 07:50:18 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-mayday

for you to fetch changes up to 2a61f40d4a9f7eacce67a80ce79f916996c4196d:

  video: Enable VIDEO_DAMAGE for drivers that need it (2025-05-01
04:33:30 -0600)

----------------------------------------------------------------
Support for calculating video damage

----------------------------------------------------------------
Alexander Graf (9):
      dm: video: Add damage tracking API
      dm: video: Add damage notification on display fills
      vidconsole: Add damage notifications to all vidconsole drivers
      video: Add damage notification on bmp display
      efi_loader: GOP: Add damage notification on BLT
      video: Only dcache flush damaged lines
      video: Use VIDEO_DAMAGE for VIDEO_COPY
      video: Always compile cache flushing code
      video: Enable VIDEO_DAMAGE for drivers that need it

Alper Nebi Yasak (4):
      video: test: Split copy frame buffer check into a function
      video: test: Support checking copy frame buffer contents
      video: test: Test partial updates of hardware frame buffer
      video: test: Test video damage tracking via vidconsole

 arch/arm/mach-omap2/omap3/Kconfig |   1 +
 arch/arm/mach-sunxi/Kconfig       |   1 +
 drivers/video/Kconfig             |  25 +++++++++
 drivers/video/console_normal.c    |  27 ++++++----
 drivers/video/console_rotate.c    |  94 ++++++++++++++++++++------------
 drivers/video/console_truetype.c  |  43 +++++++++------
 drivers/video/exynos/Kconfig      |   1 +
 drivers/video/imx/Kconfig         |   1 +
 drivers/video/meson/Kconfig       |   1 +
 drivers/video/rockchip/Kconfig    |   1 +
 drivers/video/stm32/Kconfig       |   1 +
 drivers/video/tegra/Kconfig       |   1 +
 drivers/video/tidss/Kconfig       |   1 +
 drivers/video/vidconsole-uclass.c |  16 ------
 drivers/video/video-uclass.c      | 193
+++++++++++++++++++++++++++++++++++++----------------------------
 drivers/video/video_bmp.c         |   7 +--
 include/video.h                   |  61 +++++++++++----------
 include/video_console.h           |  52 ------------------
 lib/efi_loader/efi_gop.c          |   7 +++
 test/dm/video.c                   | 266
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 20 files changed, 504 insertions(+), 296 deletions(-)

Regards,
SImon
