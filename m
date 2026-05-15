Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE00CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2285B847C8;
	Fri, 15 May 2026 20:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eefNc+VQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B151B847C8; Fri, 15 May 2026 20:10:32 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B16847C4
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ba6485d219so1266935ad.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778868629; x=1779473429; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xF9IPsAWu8W3PZ463w8Ocl2Czu+YoHNw36az8sCGAWw=;
 b=eefNc+VQmaALzzM6XmcEeWzqyGHcmNjjM9y/6XH/Dc7NEQsEqFWGSCz9ui4eD2KykO
 F8faeE1RHxDVGot34i9xJGs/gBY83QdPo5nL1pUsg4RExSFeSo6VW0WePxK25dEgdKn2
 jvI7PRp6xSOVxZVh0JX3l7RdKFLJyH5KODR+H4meXtThmdkAz7tIb+1p76KD3jeB3b9J
 pAi19Hf4JRQnL9cuItl4J4cGeq7Z9iLuYIxxihWJmSCbFutY9Cak+O1NEVIGcU4Cx0Pv
 zVYDAlyU9xYoMUOfuzZ06Oox+AqQR564YJ3aXJbXILIVSpEJFMNkBNk0UFT5FpfL9B/I
 7ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868629; x=1779473429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xF9IPsAWu8W3PZ463w8Ocl2Czu+YoHNw36az8sCGAWw=;
 b=KbZlEv8+j1lgEMJ0RfJBxtm+q4lE+Gw1Recai1bsHmjZmyo+lDLqZOF4k9Fman+Fqh
 YVPz2Iv2oUxg4lTg7XWp+9GozRxmLZ7r3JkzQ3vlLqbfbnSBXQTJsKJW4yjzdTlzOPw9
 9ZTi8aEuUL+i9oAqNs78NZDPu0Rb5Gmvy2RvNE8+AYNJqG0qHWcobfEJV7OX6gub+x+y
 l56V4JphB31MlSw4KIN6SdhHW/+DHVHueZwJGhcfGtHxbNqtCrlreSHnwFbYSXskNNLv
 H2OvCUHIOirH5AdgstYSDemX+BymsfBrC3+eqkpl9x2FDKh3X8VU/s6QHkQbZW3LnSJA
 uyBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9niuU/VRkVMK2OWZpLJ7oXRoS84GQ3FSAJjtJ/lR2dHuTsbzDKeFu3RqjBGbT/BvhdXBoDdt4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6kTWai3XPdnqrc8KjJd2SXIbq8RUt9lkax+FuOLYjsMCNMKe1
 QjGNAWU91SERakOLk+9AW5kuedAQrRBfmPr+ceXKuiVmGWC9e3c8GnlB
X-Gm-Gg: Acq92OEfFWuSp9XP8S8Sp0libyZCWLBJ3+ocJwGI7A3lKvP0y5RJSWeEgkHjx8+d/Jk
 qLmX1cLtvWaHGEvDoacqlXvNL7IX/D0u2TB7xs8UeJ9tXiF/nkLfYenY0RL2IXleBaAZw/Y4kHq
 8Yln2r3pXxcUHljqGI11vX6UjnVQg/G3kZ+BehtDov+8xP/kUBIVsqHg9VVBgUxCDaspVcFASnJ
 WqGpDylkvBdcQUSPvf7VdxfoCJurbWb+8rMabBlHnvHZWpuwR/3mnCOqW7Q9EmWDv6z/GhpQJAR
 wrO3gwGux7Ug/kGDZ+f0tIF8G+G3Fv6Q/ncgbtwhQWPAb9WTpYkWpVDANySIz9ABrCYo+d+gGKs
 Eq8GNaIaqBJX86MN+rl9/sSxHKcC0v1jAOzHYWLWuf5CsPKhPZ6/7d8pnJgcXNV2gOxgyqmmQuT
 crZTCqgivmcwUGmr8knRdgFVYH/ex6A8H2OjRGKSc=
X-Received: by 2002:a17:903:3ba4:b0:2b2:ccfb:8387 with SMTP id
 d9443c01a7336-2bd7e9769edmr60382745ad.28.1778868628859; 
 Fri, 15 May 2026 11:10:28 -0700 (PDT)
Received: from [192.168.0.102] ([43.251.88.142])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2bd791e0b11sm42338535ad.18.2026.05.15.11.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:10:28 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Fri, 15 May 2026 18:10:04 +0000
Subject: [PATCH v2 3/3] board/qualcomm: qcom-phone: Add poweroff command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-ufs-sm61x5-v2-3-0a35d083d2da@gmail.com>
References: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
In-Reply-To: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778868606; l=1322;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=aaAqC35MCMYpLmylINSOSfAlM9rXfX0AFHjZQuduZ8w=;
 b=QGhBy24+X7F8e0/Ga34XhcFtTFuGpiKHRNNp4HgT5NM74CYwF4hwQPl6+B6f1FrxmR2QJDSRr
 aNu+u7bOIqsCOLcCQhg0ngoERGglfPNCR+CpH8lPDtmWPBR5FfDM6Ji
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

