Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55D1C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B30B80EEE;
	Thu, 27 Aug 2026 19:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFJrX_HyV1nN; Thu, 27 Aug 2026 19:54:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860440;
	bh=AtLV9F9pot9mvugoJht2NsqsHeGDgJ2EMiGTGGZSMf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lmmbxg2xEUV8rjrH+8joGZtspgTzYx4ZN2doXX+z6Hmy/4p5IwMBBsxPIcRPXYegw
	 /lN/N1lW8RlxV8T/JPhOp5vr8nohNFKD3TuSDQkFMNCJmiGl18TE9CkN3DG2s7mq1T
	 fKHjdTR09AdkiuiVDYsRc7KX1V5eDzOSLefhPS1UssQ/TInXmiuFml806nNuaMFeaK
	 7yK/1wrmzP8mYOj0u/ZsDyhwJC9dUpUE6WoyLDlt5qS/60/XlwnWFDQAeHQEJqOw4K
	 rvj3ddw4WaAVOOlpFbmNZNC6K/sKDu92pCd9hxj8XFc5sfRWq2kM3WTnO5gqEw4Qe6
	 fT0Tvm0kOEf+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB14B80EE3;
	Thu, 27 Aug 2026 19:53:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E492D75
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA14160816
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FYcy-uZqvfQa for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:53:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.174;
 helo=smtp-42ae.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=QRejMFtf
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [84.16.66.174])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D23B46080E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:52 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzK75XlzvX3;
 Thu, 27 Aug 2026 21:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860429;
 bh=AtLV9F9pot9mvugoJht2NsqsHeGDgJ2EMiGTGGZSMf8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QRejMFtff3g7isfY94QqWqZaw6/GU1xnLW4Zes94CjTK3qqBNcuWYYDRFk/e1AXcC
 WFKLwmTKZkDB4uLWYx+MJ5yUKxdDCr17DyV7QdV/U64dbulgUmximOisPrFooizm8g
 sQmO2mYUm0+Klt7KkbSebuX1R1itdRBQ8gHGD9OEJna62pbppHdfTVoRPeOFuM0wNR
 pGKKaimPy/WiWKY1q+1db2rSWPDSSb20l/9DIVWX6ouq61Cu149Hx9RyRqfcL8RFfY
 opvtt+OHbLiXFgLPRPgKZMypn87hsdWxc7QKe32srhoXmpNiyUbjAMaONq+Cp8p0PF
 QR3Yc0WHl79Gg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzJ1HkvzRND; Thu, 27 Aug 2026 21:53:48 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 27/45] doc: chromium: update links to slides
Date: Thu, 27 Aug 2026 21:52:55 +0200
Message-ID: <20260827195313.129994-6-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

The first link doesn't serve anything anymore and the second doesn't
offer a link to download the slides.

pretalx is the service used by the LF for their CFP and hosting slides
and talk abstracts.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/chromium/overview.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/chromium/overview.rst b/doc/chromium/overview.rst
index acd9ab8bfcba..97e2777691c8 100644
--- a/doc/chromium/overview.rst
+++ b/doc/chromium/overview.rst
@@ -44,7 +44,7 @@ Here is some material relevant to Chromium OS verified boot with U-Boot:
      - Author: Simon Glass
      - Presented at Open Source Firmware Conference 2018, Erlangen
      - Describes the work in progress as at the end of 2018
-     - Slides at `OSFC <https://2018.osfc.io/uploads/talk/paper/26/U-Boot_with_Chrome_OS_and_firmware_packaging.pdf>`_
+     - Slides at `OSFC <https://pretalx.com/media/osfc2018/submissions/YBHYHA/resources/U-Boot_with_Chrome_OS_and_firmware_packaging_Rju11gX.pdf>`_
      - `Youtube video 'OSFC - U-Boot with Chrome OS and firmware packaging' <https://www.youtube.com/watch?v=1jknxUvmwpo>`_
 
    - "Verified Boot in Chrome OS and how to make it work for you"
@@ -57,7 +57,7 @@ Here is some material relevant to Chromium OS verified boot with U-Boot:
        spring (`HP Chromebook 11 <https://www.cnet.com/products/hp-chromebook-11-g2-11-6-exynos-5250-4-gb-ram-16-gb-emmc/>`_)
        and pit/pi (`Samsung Chromebook 2 <https://www.cnet.com/products/samsung-chromebook-2-xe503c12-11-6-exynos-5-octa-4-gb-ram-16-gb-ssd/>`_
        with Exynos 5 Octa 5420 in 2014).
-     - Slides at `Google research <https://research.google/pubs/pub42038/>`_
+     - Slides at `Google research <https://elinux.org/images/0/05/Glass-chromeos_and_diy_vboot_0.pdf>`_
      - `Youtube video 'Verified Boot on Chrome OS and How to do it yourself' <https://www.youtube.com/watch?v=kdpZC9jFzZA>`_
 
    - "Chrome University 2018: Chrome OS Firmware and Verified Boot 201"
