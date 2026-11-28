Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEA606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o5DmrNax;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=TMp01Kgv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5A0E60635;
	Sat, 28 Nov 2026 13:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NEbSv3XLO7eZ; Sat, 28 Nov 2026 13:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 334A46063F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871562;
	b=GwighkudDAas+W6BWCSqFppHZ6jVa9Gyk4EfGcy9b/7eBZ5WbawNk9pg4yGgSlsx9GwF
	 6HE3HUrFD1k1woio0BmuCKMJ3yJj/RlUv+uSN53zH0suv+A+S/acG0xqWy9zes52epUIb
	 0Wlv5yIPNf0/8LXjujuZjDOhpeoJaFQAAovRgI/YvoSfBAwovH46A39WNoGzA3B1M2jYn
	 MnpzSoOSsASTwgFhq5bXOIULU/88Qi+o3jdsdUUQnoTwgXoLkMFomAmrWjyY6Nf0pMsX5
	 njPDYcgsy8wy40QEamjDof2L0AljDAHn2QgijwVkqcMxc+rSRfZGDsa5xQwFcP7M7Yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vNltMFFia0/ISgbpA1kNxuawUPP5jBBjpjY3QFtIrEU=;
	b=Pgwn7ajuiw0DjKJoOsD9/DPQqu534xwl6b7N6mC8y3jfys4Wc6XKhMQ9YWQqSaEN9N3I
	 IkLTjX9+Y5BtVH4Bf0BiEq/uLh9XBb2zVTVRpXig+C332+/oMm/4hzLhDpr1hRKlx71HT
	 Yab6LAOgtPoJnXrGhJqSX1rUf5R1vpkSOXN92MMaXhET6E0RFuK8wvp5H8qdBE9Y82+gU
	 psSMmQYdduwJSfnzHzgzD9nv/olXVTC1iGiME3siqKp2/phNhl97Ff4BlL/PqbMN03HP5
	 FbX4saZaVilIcsfflKxH9Q02JGiyJXSlNC8dbsad4xWsQmH8guEyaJ4z30DDU+T1Sow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871562;
	bh=vNltMFFia0/ISgbpA1kNxuawUPP5jBBjpjY3QFtIrEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o5DmrNaxEA7is6i3sOtaWMxcvoPO1z8vrJwRlqGBSFgD4jIYvpKM9v5StLaQs3s2c
	 JVjs3XRafFiWi1gkb7pXQ/WfkVzP301eSG8c0S8Vnc9sHdkwYsIPz4c5GLsIoIDVj2
	 huZiUpO3RsQC2ZZrVHk6PzdPt99BcCA+/2FxbVl5b+Nzkv6f1tQH3rUO+NfTdSVT86
	 vcOb52RfcPqcDWoXDBKcXqg4T/ojptNLxfnHBmDOGiaA6Y5eJam3q9/1+6o7uklv2u
	 6630Q7Zd548FubzpHwj/jxOe79DMB9PDpSFL2Kj42LImdEtHbj21Jf4xbbUW0l0CzN
	 h6GANmK8zQxGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 334A46063F;
	Sat, 28 Nov 2026 13:12:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFE89BF4
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D63C8400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ViGMPrFo-DdB for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DD0414005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=TMp01Kgv
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD0414005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:29 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4bba5e17cbeso34341585e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871548; x=1796476348;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vNltMFFia0/ISgbpA1kNxuawUPP5jBBjpjY3QFtIrEU=;
 b=TMp01KgvSt8fKyqdsZOfS3l0P4L7ViIKocxem3NYa5uf4FmESivF57Fz7MjGX58lmV
 kS7aSHPYvtuRI9vrC4H/cm4HmLvBwUGhk3y7nn1vLpBm1L4Rpz3W4/go999Uy2J6XLBI
 phMndDxKoCmxuN4y+jhhsVi1IsfZle15f2usA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871548; x=1796476348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vNltMFFia0/ISgbpA1kNxuawUPP5jBBjpjY3QFtIrEU=;
 b=0IYOeBDW187EKIzOzWQtIUgW3sTSBoiTl7Vut+lo9e8zdUjb//NVYhhsv0jR7kfNxs
 P0yB2DQ+AhNpvQn0KYdusj1kRwMXNstSNQiZcSuW9gHSQ31wVJ6zhUhmh3yPS/QhMne4
 Ay8rHLF25UMtACeKtgvulwXPJFtba9cJ9Db1KCJj+k5hHgivHDN3B1/DXJm2gb3g8grt
 2LTMpD55cD5p+1ukGPS/t7owy76onMSQQqAK2zJioOpeuB34ApUmbnDncg//I9BJVUGK
 25hoQo5dpBwbPVbGdKKna07UT1Gunotqw7DE5GH6nEvAGZbjmNvMgM6ngSMZByYU31a4
 xJ4Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHkA9mGDmyxES8XSMjvdtmzToUuW7dcklyHJxYuP8zcqBoY5+HfwXVI8n1epEttDOcBJnJFwIc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9pjU1/Z8dpbLW55srLYCxYC8yXQO1dwzhwPWqiru9HCAgqsBYf
 0IBfUEMPSutnKC1n9AApStMf7mtmIbfx++++BC6zJhVcNtRAmOIuZdyDlRpe8juNXyVwQKv0x4z
 jqNmj
X-Gm-Gg: AZFdTZevYGIRergYh8AaLyY/NNOpT1Zz7FGFO2nZRfkBCNOFGdWbBnquSZBhul19ejR
 H7RxCE6Zo4PA8n0gXXzqpiW+oz0kvc8ehdEgkU5EhxXoi+1Gn0tELDKujltA8n5wxfLUttxhSei
 D9tCd22Jl8OOG5mnAZ2RyFsePnx5qyjNc19qAnVobbhUzehnBicZNSdgNvoaKMjDwJX5zFdAFGJ
 C3qhafeL0cfO+rFFqs7OmTH01+Wn0mP5qlzJNZi5pOKNn/ukbnHd9PLXotAtRY2ecZiHoyf93c/
 5x+9A7mAEKiNE2KdgqK/VJfWWbALi+fHYUr4GKYvRiWJxxQ+O7NNZ50VPtUpIs1b7+luq6GgErS
 U79+KaRqvyY+RBJ+lIMKdOfqmf6oryg3isb558cPURl3MOJKwG6wuiUzfgZ7L+kFDNqqdDmsY5h
 84LD/fZ1wTaOpy8PxCU4C4JPtOwlQB9vgJbjyZuc/Cj3wfaE0+nDMrH4BZ+ZNzlc7vqhJwC2rO9
 gLcxlTUaQbJEIlou8fJRTx51GtYn+g4auJJtB0/lGBeNeL44ImkFM2LcSmhVgBBY0rEs0xDt7tP
 oShkSIHgybAVYZ8KfPCdBMya2SNYHi3YtfnHRQJhtfVJhQjof+BAHfBN3qhpuFLdUthxISsfg0Z
 +LfkT0NlW/Wo77Y+oRmXp4pcLkEmQvk+PXxvW5QHO8QIr8ZZEhOsCKhvadwo6/5yFjnmygZakHw
 o7SGGQGvWfKqp6mE5rLJoIlFZUFw==
X-Received: by 2002:a05:600c:a088:b0:4a8:cb23:f71b with SMTP id
 5b1f17b1804b1-4bb8880b7bamr505211995e9.18.1795871547774; 
 Sat, 28 Nov 2026 05:12:27 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:27 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 29/29] board: engicam: stm32mp2: enable simple framebuffer
 for the splash screen
Date: Sat, 28 Nov 2026 14:10:46 +0100
Message-ID: <20261128131125.2141352-30-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the simple-framebuffer node of the Linux devicetree to preserve
the splash screen until the Linux display driver takes over.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag

Changes in v2:
- Drop a redundant comment

 board/engicam/stm32mp2/stm32mp2.c        | 17 +++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
index e15141677775..64fb44fd7f02 100644
--- a/board/engicam/stm32mp2/stm32mp2.c
+++ b/board/engicam/stm32mp2/stm32mp2.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <event.h>
 #include <extension_board.h>
+#include <fdt_simplefb.h>
 #include <fdt_support.h>
 #include <log.h>
 #include <splash.h>
@@ -218,6 +219,22 @@ int splash_screen_prepare(void)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_FDT_SIMPLEFB)) {
+		ret = fdt_simplefb_enable_and_mem_rsv(blob);
+		if (ret)
+			log_warning("cannot hand over the framebuffer (%d)\n",
+				    ret);
+	}
+
+	return 0;
+}
+#endif
+
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP)
 /*
  * The FWU metadata are stored in the boot device, the SD card or the
diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
index 73f8f7cf96b6..d5ae71354736 100644
--- a/configs/stm32mp25-microgea-rmm_defconfig
+++ b/configs/stm32mp25-microgea-rmm_defconfig
@@ -24,6 +24,8 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 # CONFIG_BOARD_INIT is not set
 CONFIG_SYS_PROMPT="STM32MP> "
-- 
2.43.0

