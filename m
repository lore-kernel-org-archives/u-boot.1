Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513FCC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 07:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7DC387DED;
	Mon, 18 Dec 2023 08:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wgt2tjeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDCF87DE1; Mon, 18 Dec 2023 08:25:22 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A57F087DE2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cdaa16ada8so42388a12.2
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 23:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702884316; x=1703489116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IK+ADiv6RJioLn2TE34SiYKpwSEbF3I+hmtgTd3SEMA=;
 b=Wgt2tjeR1IZsS2R81AGKLO/9D95xfn/3OIfqjv4XAvrSgZhpnl1s+U6cgs64vbhwUi
 2hohqXZvKuPfsaLXz7KR0ND22uDYupck4eLw5RRhRDT//lqYgGVw9auLpNJdG8e+gpsv
 ATW8V6ffa0IROHNhUnMLWrv0Qk63vFcwUI9Fzn4UxvtaDJso8o3YV+A/tPJ87J/d+9Mn
 kmNTdKYOL/zDywAUXthTpy0WTFJepOgheUWjSZzOF5AMqoWxmxtbd59gniMgrsPmFSHR
 X7gR1VNxZHZvUvV3jFLeBWRXQI3aDAqqjfxAkTrbtOHbx+Vv16g2/AfUVcFvbKRaBM9E
 Oxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702884316; x=1703489116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IK+ADiv6RJioLn2TE34SiYKpwSEbF3I+hmtgTd3SEMA=;
 b=PCEIRwz9Q8xyd66+kIfuiIuKGRtiBcWS1RK2zHBMLGrk+1sqxciAPut5fGRcYymV6T
 K5G4PzykxPPQOsScCIus8G3uZX5An5HRitWo56SaEREMqqjAte2UnoFBqH9KpBDWu+Ew
 rwCuQAYN/62Ls+mPGsPy1sp82yhueHFLOCl/w+YUhGKLBI9cyh9FezB4xzLeW59cAkG+
 Fy+Y1ac/grxlSwK1njX/ow6Ksjo+Jkq/TiKpyucRdkLXHX7dYVSPTdePwD0U80Qbu3bp
 Pcj5kcmPASHbDY0JKculvYLj98dqRN84dRVf/LsIHJ4L+D31Ij2OigC3ZAfWo0U5jQRS
 CDag==
X-Gm-Message-State: AOJu0YxFizdr4R1Tr5f8Uw7gYlyJUzwY5gyggKOvxjcNCKt77i5olUxQ
 B7GW1hQwg0e0bVI2cJyesY+ZkjfKpQ4l0HiqdZeCqg==
X-Google-Smtp-Source: AGHT+IHmywZ4PlP3eUpeX6e4BfQ9fcNDDOFfxhC9f9mdok8+Cmp4s8vi4EOR/eoLxlL2jqP2SqKqbQ==
X-Received: by 2002:a05:6a20:8e13:b0:18c:5c04:a548 with SMTP id
 y19-20020a056a208e1300b0018c5c04a548mr9404568pzj.28.1702884315806; 
 Sun, 17 Dec 2023 23:25:15 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 nr21-20020a17090b241500b0028b8b269aedsm1038997pjb.57.2023.12.17.23.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 23:25:15 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 6/7] hmibsc: enable U-Boot Environment variables protection
Date: Mon, 18 Dec 2023 12:54:27 +0530
Message-Id: <20231218072428.1802969-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218072428.1802969-1-sumit.garg@linaro.org>
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable Environment protection with:

CONFIG_ENV_WRITEABLE_LIST=y
CONFIG_ENV_ACCESS_IGNORE_FORCE=y

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configs/hmibsc_defconfig | 4 ++++
 include/configs/hmibsc.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
index cef9e304b3a..656c9c6d0d6 100644
--- a/configs/hmibsc_defconfig
+++ b/configs/hmibsc_defconfig
@@ -36,6 +36,10 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
+CONFIG_CMD_ENV_FLAGS=y
+CONFIG_CMD_NVEDIT_INFO=y
+CONFIG_ENV_WRITEABLE_LIST=y
+CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
index b614dec7870..b228e035429 100644
--- a/include/configs/hmibsc.h
+++ b/include/configs/hmibsc.h
@@ -54,4 +54,6 @@
 	"fi; " \
 	"load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} /boot/fitImage && bootm"
 
+#define CFG_ENV_FLAGS_LIST_STATIC "BOOT_A_LEFT:dw,BOOT_B_LEFT:dw,BOOT_ORDER:sw"
+
 #endif
-- 
2.34.1

