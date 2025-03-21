Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBECFC36001
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 13:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24AA8803DF;
	Fri, 21 Mar 2025 14:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ejuf+VVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762A3806D8; Fri, 21 Mar 2025 14:19:22 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676798001F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 14:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3913fdd0120so1174715f8f.0
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742563157; x=1743167957;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3n9JGL7k33s5bE+2UJ83UeoR9PHPuZ4R4vorfRQJDM4=;
 b=ejuf+VVp8cWM/lsqHcAc9yhms/v7exiK6/amn0tX2S4d7XQDt4JgOnsJuwg/mHIafV
 5wJK7prGRfzT2GaQSv11HwBNELIMXNcEhvK9Cbe8kln2sSQpyei367gUtGFJDoRCDIWY
 syfrGSb1LjHcmy9KUyJT0OsqBTHQyzMLTutRJIR/3RKvEYpucxIAsZS/Iaj6cYK9P2fB
 DNQZr7dVnNcXT9+j17ySr+7RXNuYxBu6gPKrXEGwvcGIFNhRR/MwSWjSOKYitFL06hBT
 jC+hO+37+RzLSVnt6wzVbKQXNlmPUFQtMOI9tUWRIeJykFCFESFMlg0zCltkRH3jSAFZ
 yJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742563157; x=1743167957;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3n9JGL7k33s5bE+2UJ83UeoR9PHPuZ4R4vorfRQJDM4=;
 b=nd8NWyg4gkRkdOA0SmVEvSTFsQ9U85A0KiaUkklMMMYDT2hhps25ntoqcKCxZIcDRI
 +w3dFXk1LZev6UKYsNt4KeM+uc9+WB1m/3W4UXS182Um2Vax2EcCnRr3Ww+IiAqYimii
 Kut6RvBzgW2bi/nPxffjYmqS+wSed5NKsPOMrwgCUwLhecIJ+gCYE8XEFDmE4fJW58yc
 utbqWhlEKAobiKYF7oGtwIUB/SqF4NGgoBA1tb9YPSb2BdsBPuwA9CrdK+vSPNXq22fI
 RQHDWXREAj3SgbjPFaJVRxQCRJ4K9LU22tv9qK7y/9E0jAV5aLUe7ddjexSbYMDzJDQj
 ynoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2idK/RH0C+n8kQcG7o//nrohtSt2DaORJTGnuuvpoT5oWKPCrbWKQTnWMNUvjUiTyb9wu5lw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz151CRgI4fm4ONkLBcLycx/FVHtWnaQK4Meewl0XaIMaFf8uPd
 Nx3MeMWYTIaveeKyUoZMSQq819JPP3xLAnzj59Qqc4+LUs96Cr5xPpY8sD4oGgo=
X-Gm-Gg: ASbGncu+gO9A6GZWXV8LeHMTRFS1ZMyXrYRFhcVGh4LHt5rQuOEigGgi9i0hUhYCGG8
 6pE694SdXUBzLelsY/dWdOZ8nyrqQnoa6qV3Bv0VORebYlw3GZyKFkDiyXyTEiG7YTUqPEY3lzi
 hLbNdJDsG/+Wvs0QUyFIGohfjAI9olKIMQDvSk4WC7vnNl5WnWy6KCXdMi2Cm3H1jck/CgSaxXc
 4d2yzEeO1ZFkeHs64IuOOQcCPPYV9wjqIQ6w2w5xUfsHKxdj2CUZcBlf96YlHvIRli1LweIIhmA
 mZ+GR3m3LcJbgxUBYDc9VxCPPMivuRru+4Pajb1Zvp8qgA7KliCxVuU=
X-Google-Smtp-Source: AGHT+IEbE8bhJZM1486BmqrekCHMEjCeFmKfKxJQs0Qk/lkwG9qu4lusu+aDoHU1rQz7MGF3z9Bxsw==
X-Received: by 2002:a05:6000:18a8:b0:391:2889:4ea4 with SMTP id
 ffacd0b85a97d-3997f8f617fmr3290831f8f.9.1742563156787; 
 Fri, 21 Mar 2025 06:19:16 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b260fsm2321603f8f.43.2025.03.21.06.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 06:19:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Subject: [GIT PULL] Please pull u-boot-dfu-20250321
Date: Fri, 21 Mar 2025 14:19:15 +0100
Message-ID: <874izmfrn0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Please find the following fix for master:

Usb gadget:
- Fix NXP UUU tool compatibility regression with dwc3 gadget

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/25275

Thanks,
Mattijs

The following changes since commit 7ad543619463e8817b3044041ac74749a217bbe0:

  board: verdin-am62: remove spl_perform_fixups (2025-03-20 08:02:12 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20250321

for you to fetch changes up to 0916053ebc566245b06d0a179533f6622b6ad392:

  usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool (2025-03-21 09:37:40 +0100)

----------------------------------------------------------------
u-boot-dfu-20250321

Usb gadget:
- Fix NXP UUU tool compatibility regression with dwc3 gadget

----------------------------------------------------------------
Marek Vasut (1):
      usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool

 drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

