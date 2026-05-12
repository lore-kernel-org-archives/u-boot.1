Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB32CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 14:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8871383E76;
	Tue, 12 May 2026 16:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RdZ44EkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FB1803C6; Tue, 12 May 2026 16:45:07 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCB683F14
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8353c9f24d2so3021281b3a.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778597104; x=1779201904; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xF9IPsAWu8W3PZ463w8Ocl2Czu+YoHNw36az8sCGAWw=;
 b=RdZ44EkBPDNLBAnE0V2OTwgzAhxWVr9YXG8ctvepkOnfgTG5KiDwVSf3p6NX9pUuOp
 yWITrl1o6NGyF6R91zKAeHvsBNrlsoLo1zwTjcDMYcXvcfu3OUjnlg15nJTWGFi20yDD
 ULXsx4f3HtpwP/tbAJtvMjrSVdNlGLqWQDF3aUI1Kkxl9GhEiZlAcrVShD4e5sYC5eXd
 AEPAVLeepltzs5pz4/2dM2Evxfq0e6MYRlIRJEpjvkUph/ffby0sOe0W6Pyi3bwvl2cI
 H/oWj4RYCZMKfyfcSsv6E16+I9uNWdn2SmiZ78U6+Sbm/l22SKqS/Ot37p8YZTquSg9l
 0IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778597104; x=1779201904;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xF9IPsAWu8W3PZ463w8Ocl2Czu+YoHNw36az8sCGAWw=;
 b=TPY6kP4jtoq6mWStrajhOLZiVl3LHNASJwi8Wu/1y2be8rMyu/ny6afHC5ZAJ9W1VT
 dNBNwGPsCQlE5idc0tD9vo4nImsPrHM4ruUaZYdx67/pFDGAPUqGKIG+JVLNBHtfUcGR
 aJMQt+piml+P4bF9M61Eg9zLvhjhNImm8H3Yb6Ucyt1RxLhrwUQ3ruZwyAR52LxpGEM9
 +qysU4Q6Aip4OMCoEnjDVg6wndPxcvCrkUD8CxkcORfjU5GLgL0yPSOWii7TL0Fow0iz
 svDcAhbEuiU56U0Q1r9O1Q0sLaveU2qifriyuNwjijN00RGObZmHFKvRYf5NzQxSN3X6
 aKSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QPb/IyetK6plJoWPVThn+rT8pK2jt1UqviFQf9YPED1fAi03oB5/hwfICXw7rsHy0ZuH6R9U=@lists.denx.de
X-Gm-Message-State: AOJu0YyMZL3LEBkcCWQQ1xX3gegD4lodVvFYc/ZJinccbn5ia41FAUxV
 OK7MJug0XnLbDdCPxJh73PfdnIwSBgLVYrmg27r7/LE9ibd8dhfapqxy
X-Gm-Gg: Acq92OHtLBvvJhi9srEpPSIVfb2Qji5BuIwxQcOKo0meQ/zgWgPK8F23Bv389hjYASh
 szlF+aSbOxGIfU5tleOJTXSkr7ViNFolQ2pcc1kKsxKzdI3DIPskMY7QM6zzNcd9nm0QdOSPTVF
 7jhksR2kb73DsJkJbKDz/WdlSbvjX0R5PgUw1OOaKcuzzELCZ2Kk5d58/RGcKBTbuimdMJ0HZLQ
 Z3IHzbVfbrLYY00XTbs8WwzAG2A33F3WZEbDVLQGSYl0QfpITX7n+/pCeEcszZ6TwjtBL3SkKft
 nntmpc8plIcpFUrN1s0m4frPzEyqxznssBgE/0VsY7oG2ZpUMizQq1iNEBww3KaNNc941o2YBLB
 bu1CYaozbhFnTyDwk/MP1XZWf4gxqjuBpiieuMtcIRXn9OQLvLt4dI9knxQAH3d/PC6LZlkQMcV
 aKUr46tjn+DBjsryD7VsJvFetfEaGv
X-Received: by 2002:a05:6a00:348d:b0:837:a211:4ee2 with SMTP id
 d2e1a72fcca58-83eebe6bbc1mr3239145b3a.38.1778597104031; 
 Tue, 12 May 2026 07:45:04 -0700 (PDT)
Received: from [192.168.0.102] ([43.251.89.154])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8396594645csm24703145b3a.14.2026.05.12.07.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:45:03 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Tue, 12 May 2026 14:44:41 +0000
Subject: [PATCH 3/3] board/qualcomm: qcom-phone: Add poweroff command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-ufs-sm61x5-v1-3-c022cf988e89@gmail.com>
References: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
In-Reply-To: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778597082; l=1322;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=aaAqC35MCMYpLmylINSOSfAlM9rXfX0AFHjZQuduZ8w=;
 b=Y88fJgTD8JF/s+MF3FSvSprYtoc+hgx3Fhm7fgXQ2dxgvEkju11kPpNunvZUeWyy2HhYjA6W3
 hbClzKOlgctCX7YbMIRSxeQvwV4vrN0rPgIO+mkxRUt2Ise09D2aHRY
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
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

This command helps to shutdown the device directly from serial command
line. Or, the phone has to be booted into recovery mode to power off.

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 board/qualcomm/qcom-phone.config | 1 +
 board/qualcomm/qcom-phone.env    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
index d24094eefddb..e4727fa8b930 100644
--- a/board/qualcomm/qcom-phone.config
+++ b/board/qualcomm/qcom-phone.config
@@ -5,6 +5,7 @@ CONFIG_PANIC_HANG=y
 # We use pause in various places to allow text to be read
 # before it scrolls off the screen
 CONFIG_CMD_PAUSE=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_BOOT_RETRY=y
 CONFIG_BOOT_RETRY_TIME=1
 CONFIG_BUTTON_REMAP_PHONE_KEYS=y
diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
index e91ae3ecdfbd..f9911340295f 100644
--- a/board/qualcomm/qcom-phone.env
+++ b/board/qualcomm/qcom-phone.env
@@ -40,6 +40,7 @@ bootmenu_6=Dump clocks=clk dump; pause
 bootmenu_7=Dump environment=printenv; pause
 bootmenu_8=Board info=bdinfo; pause
 bootmenu_9=Dump bootargs=fdt print /chosen bootargs; pause
+bootmenu_10=Power off=poweroff
 
 # Allow holding the volume down button while U-Boot loads to enter
 # the boot menu

-- 
2.54.0

