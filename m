Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5822C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EA5E88CDC;
	Thu,  2 May 2024 15:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="eikDoM8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9CA68839A; Thu,  2 May 2024 15:16:55 +0200 (CEST)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9162388370
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 15:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail2; t=1714655812; x=1714915012;
 bh=xRs0D9+ixib3yOD3wSPxVscTW5L5y1QZPUUjiGE7uWs=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=eikDoM8jSfLDh+4aQMaDfxU/6bLZXKkzQlrKjjUnI2qKktFIKOprMc+c3VTjOEat3
 RELdNEyugNi+zaQF8i4SrZqCnuYu7zw1xLIKwTfcldevXigxphlzgYkoi+ceN5kUcb
 zU39bGMnuR5ucyy3z7gGyO/sjPsAjzr9CutE2Ho2pzXY7QG7LBBG1PJViAiWtS0w+z
 iXDwy1xFYj4ZzdOaiwNKTRrrG3tkJvsvIV/uGxto8H98MB5dHRprMphI8hyVN0Bnpl
 neo82D7nIjqeIMLkONGjuaMqAQMUMiUEqH0Z0OnCh/M0bDT8kiu5qcetycfpYnAyHs
 ZQld7O/JXiFIQ==
Date: Thu, 02 May 2024 13:16:47 +0000
To: u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Sam Day <me@samcday.com>
Subject: [PATCH 0/2] qcom: ehci: enable core + iface clocks
Message-ID: <20240502-msm8916-hs-usb-clocks-v1-0-eeccf483b68d@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 1d15e580c77c820e80c360616c276a6bae8b1c40
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 02 May 2024 15:17:58 +0200
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

These clocks are mandatory, as can be seen in msm_hsusb driver in the
Linux kernel.

The appropriate HS_USB AHB/SYSTEM clocks were added to gcc_apq8016.

Technically there's other adjacent SoC families that can use the
msm_hsusb driver with different clocks, but only msm8916/apq8016 are
currently making use of it so I think this change shouldn't break
anything elsewhere.

Signed-off-by: Sam Day <me@samcday.com>
---
Sam Day (2):
      clk/qcom: apq8016: add support for USB_HS clocks
      ehci: msm: bring up iface + core clocks

 drivers/clk/qcom/clock-apq8016.c | 31 +++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-msm.c      | 37 +++++++++++++++++++++++++++++++++++-=
-
 2 files changed, 66 insertions(+), 2 deletions(-)
---
base-commit: ff0de1f0557ed7d2dab47ba976a37347a1fdc432
change-id: 20240502-msm8916-hs-usb-clocks-34bc22b03f3d

Best regards,
--=20
Sam Day <me@samcday.com>


