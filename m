Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A52606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xyS3dcbi;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=kMKVGyEl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2116A60828;
	Wed,  4 Nov 2026 08:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ms9Q8TNRA2Jk; Wed,  4 Nov 2026 08:52:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4683D6080C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782342;
	b=isWGjjP358VEVmY0L1TaW/y1++KB8fVU/0+mcobzJag9z84sYgrvUCdLh0TzIqd3EWNB
	 qZZnbMXU9CV52el3tnrZZJLDFYthESyq+62VtQvDBVs3kUAtd7VCMS/33+kTfK8lDpERQ
	 Q8M0YUko6thD09v8HywlH2rtpafS3aocplAl7Zn3SiZE/qn1w9dUTeM1fju4aMWUs2VTM
	 +XNh4vz9YbAxJBmdWZ49DUTyo3hJ6WoSgofFb0Tcib9szYHgp6t7jD4G3C0d3FipIUYU/
	 QFCvFSZgynweqi5g7KSYYOe+2wQYCjKWKeyQjiw8Fl0wik8AUxdBeElUBNz+l7FDojA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vT6ghzmaE7ELYPVoLk6cwLL50q63O4REQRGU03AquHE=;
	b=AK8LJkEjDUISWsfqnDgJPjVwVbf9jk4gZ+kIicKc8wxqOUGCpbF0HnEnKiZVJvSEIYpy
	 DS8fF/0iY7o55Gpm8cP5a1LjGDXsFbP8n0Gzj1tQg87KoW7377Ls/gK9++th8sPSQh32O
	 NmR2tgR1F29yDPy7HtK9dOWj1591Pa0bFdQYNH5Pt6HIcRfe9o5XBMSCd/IYReav5TVue
	 tIJd7D8LAbKRjL9HjK9sCThm+HxrRDCAhHFpt/D46g4dEGzXPkthIMrM/QUScj1gGXSjH
	 G3+ju8pxk2bYaSwzEMzsUo5EV836yjFLohTH4R5L7b3553Fb1vgEloJLB4q/2q2Ee9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782342;
	bh=vT6ghzmaE7ELYPVoLk6cwLL50q63O4REQRGU03AquHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xyS3dcbilPjPqRVBkB9NtAv9krbmmMSKo/bqrbPs5NjSOppAiATqoU/ppeiRUO1rG
	 xlJ1bNozleN8cxe1XCe4GCj862l8jkWViR1A4EhHWRg8xycZZUW1igIf089Kz0eQBs
	 Z82aCBE/zy8l/rOReqXlfaucO11Woi/dytG9aQgX/i978K57etB+UVg7A5RJ9Os9LJ
	 WTZvDkxDvpD7smjMZASNNjo293rabu6TytQh6hi0k4BtYPVUf8DwjNDoMxl6HmK9ql
	 EsJ5g24GQepNjfFTg8IjjRFNFH8u386/XzE3vEivgEpcR0viDFLjRpVd9yTb+4KRBy
	 Ve7eF8v2oQmtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4683D6080C;
	Wed,  4 Nov 2026 08:52:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A4652235
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A35C4079D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJkypR5t4cJe for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3288940778
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782336;
 b=gs2fLyadwo+ks//EX3pd6HmDVSvTHekJ/cxgecIoJlFy1onUyMUP/Yb4sT6krC6kLGSf
 qvMK73TOF85VB91rsepws/IUBhkHblsT7qPe5gHzlQUMPDc6EjnpT1NZFnc2BwfsOxCs1
 +qvZSknrf2A9ceL/JlAgKUjj18GWS0s4TiD5naONwhJ0rRc0hL3lbUHSnBi5n6CnkjwH3
 74J8ENPNdjUO44TUNQaoQxsYdQDDVV4NuM/RFT9R536HyeaQk4RQro9Ku068AonZZQpEL
 UU67pMuDsoKMg8QYudRSmmywAsKod98Y2FDYTX8V6LSl85mwEw3n0UKN20EWtyA7Lfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782336;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=vT6ghzmaE7ELYPVoLk6cwLL50q63O4REQRGU03AquHE=;
 b=nikiOHXEMJcvXKmzhAs0uYScYPBNTQ2aKLOAl2UfZ/ldQpfURXZWsIvlWiD2fQxnSEXO
 HefS1K0KDL0onntbe397+oXqzF+SrpPXDXLrGAPrPqcW02S7FKYy2cWFN//ttSzmpU9vh
 SLf8yka98yAE5g6da1vNxNt5SL4hoT+8fe5ZB9gQkYVHqMWXgtFnOIUv1UNF6Qisy11kP
 Cy422AoOoHelRCdiTacbp0tKTAFBn9GVfuoLO6G9TKh8C2YHq4bx4GGHqoz/lK/5S5SQT
 HTqIdypj89PeB8dPf1LHBtBWtE2/LPQXURcxKsfcU+s5MqGPHPpyKQhh8MjitCl1uaA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=kMKVGyEl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=kMKVGyEl
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3288940778
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:15 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso2755315e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782334; x=1794387134;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vT6ghzmaE7ELYPVoLk6cwLL50q63O4REQRGU03AquHE=;
 b=kMKVGyEltiU7BeyGRy5aIj3eOZHffGxoOoL8b7qFDeEKOPMyhEKcjyczgjuALRtpv/
 8PalSXMBS0iQYDTXyt2r4wWv4CWz51SUmgRtVLQtusn20D/L9061r9fof67Ng0D+WY0O
 1j31rE/5z0DZPeZ2+34gpd0UXq+cZhdui21cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782334; x=1794387134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vT6ghzmaE7ELYPVoLk6cwLL50q63O4REQRGU03AquHE=;
 b=JBcZ53RR5EptdKRcOMn0lD+Sp++BbCoViy80e83i1jvKKsI1J6B9UOEy9hexDefjcr
 +sjVOaxZ0DGvk8u3L7R5tQDC/2KxWrRTyPkNv1gk7dUrDbsREzVm3G1EpkzWn4fT5BAE
 XbfOk/gBjYSGbKJgDHfC0jI79eRHe4pPNXAnaxX2oXdGYRX2x3EsvON28G566An3H85u
 wS3EOabSg81GZeYgHArLcgonc0NuwQzbyE8t+kZpiXXw8v24p/glnhZv6UqgO+14/ZbD
 xFhf/UD7pvGusjSUVCnWWSB1us8HvAwMMqhM0g9DVQjIJtdOWZD/GpG6LcO20slZCW1F
 3SMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwP2xf7ZrnXJTJqTY5n31SNGYussbfa/qLGrCKNvj+Wp6jlrvJ6iOoKIX7rrMaOh9YEB+VpWJ4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+9dRMDQzKrUSHO24bV/YK0/rwr9bLhffTQRubjCwmlVzZGMErz
 EWXtgIekjXRmfEz4PGLVJtlrJvwgo9EyH3WXg4qFoL/wB8vFIOIyxm3Ic9o6qU1WwuE=
X-Gm-Gg: AYBFou0sQKkz5NGApddahbV8sOIE6xma9G4Qgs3EnsDjectA+v1pUZ3o3e3WK1x/ACW
 +OT8i4+q5eu4EjPXzwVHBm+FV8TElt/rbN1OeMWAzkrXj52LlezocdpqOWCrpUzS+BCs6+3oaRU
 hGvTwuzP1o1S91Txz7GCxplt7rFNRXWXtu8qQpPMq5kZBLDRi53Y13BtNDXd27bIjT0jJoP8po/
 fITO8ZcGHjfhQOPMjDu12Ap6egZUF9wA5QhlCtlJfEYWSacESYpfbeSlULko3Yko2PAN39zrS/c
 nHq4JEGt61mCbM0gtrkSfMt1RZNDT79HC0f3ZByiQS7W/fPUo8Xje0sTW6FqiDgpeStjpRBAnW5
 gkLZHcg2cd9Lt8UlAHGQH4zxkpY9I9rPbW1rz0xdjVd0GKC+t04rE6fmw6oDfsBEI4OgTVlm2kg
 xzllXoSo2DF27Mco9A7oqGEhTJ8CV+VphC16ZJLfg6eLDFOGk2fRGID6Zp+A1zharKF0iJ5js1L
 vzC2IOlvTx2Sg92CXxsnosiYXbiFXfKtgPQ2hOaS1QX3arkRONtIz5ppnE9k7sgCsImPzH34kYt
 8wxpPA7Cg9i23y2N3WihlvBJ5icb938unejH6sKmW41PjUgF7jjDiEvJa+d7wwtfmM8gYK3x55/
 lnMa+91HRKTgcN5rEzOU/N1bKCrheQepwhbJ5ZJNgzrRDriDC
X-Received: by 2002:a05:600c:6087:b0:49f:f099:6fb1 with SMTP id
 5b1f17b1804b1-4ac17753befmr347711305e9.15.1793782334061; 
 Wed, 04 Nov 2026 00:52:14 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:12 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 26/33] configs: stm32mp25: move FWU A/B boot environment to
 common settings
Date: Wed,  4 Nov 2026 09:49:59 +0100
Message-ID: <20261104085036.4012238-27-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The distro boot environment booting from the bootfs partition of the
bank selected by the TF-A only depends on the FWU multi-bank support, so
it is not specific to the STMicroelectronics boards.

Move it to the STM32MP25 common settings, so that other vendor boards
can use it too.

No functional change intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 include/configs/stm32mp25_common.h    | 20 ++++++++++++++++++++
 include/configs/stm32mp25_st_common.h | 15 ---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/configs/stm32mp25_common.h b/include/configs/stm32mp25_common.h
index a334b47b555b..7eb5c4ffc00f 100644
--- a/include/configs/stm32mp25_common.h
+++ b/include/configs/stm32mp25_common.h
@@ -86,6 +86,25 @@
 #define STM32MP_BOARD_EXTRA_ENV
 #endif
 
+/*
+ * With FWU multi-bank update, boot from the bootfs partition of the bank
+ * selected by the TF-A ("boot_partuuid" set from the FWU metadata),
+ * falling back to the bootable partitions if it is not available.
+ */
+#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
+#define SCAN_DEV_FOR_BOOT_PARTS \
+	"setenv devplist; " \
+	"env exists boot_partuuid && " \
+		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
+	"env exists devplist || " \
+		"part list ${devtype} ${devnum} -bootable devplist; "
+
+#define STM32MP_FWU_ENV \
+	"altbootcmd=${bootcmd}\0"
+#else
+#define STM32MP_FWU_ENV
+#endif
+
 #define STM32MP_EXTRA \
 	"env_check=if env info -p -d -q; then env save; fi\0" \
 	"boot_net_usb_start=true\0"
@@ -119,6 +138,7 @@
 	STM32MP_BOOTCMD \
 	BOOTENV \
 	STM32MP_EXTRA \
+	STM32MP_FWU_ENV \
 	STM32MP_BOARD_EXTRA_ENV
 
 #endif
diff --git a/include/configs/stm32mp25_st_common.h b/include/configs/stm32mp25_st_common.h
index 0b0267ae99b0..cb679eb1be22 100644
--- a/include/configs/stm32mp25_st_common.h
+++ b/include/configs/stm32mp25_st_common.h
@@ -8,22 +8,7 @@
 #ifndef __CONFIG_STM32MP25_ST_COMMON_H__
 #define __CONFIG_STM32MP25_ST_COMMON_H__
 
-#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
-#define SCAN_DEV_FOR_BOOT_PARTS \
-	"setenv devplist; " \
-	"env exists boot_partuuid && " \
-		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
-	"env exists devplist || " \
-		"part list ${devtype} ${devnum} -bootable devplist; "
-
-#define ST_STM32MP25_FWU_ENV \
-	"altbootcmd=${bootcmd}\0"
-#else
-#define ST_STM32MP25_FWU_ENV
-#endif
-
 #define STM32MP_BOARD_EXTRA_ENV \
-	ST_STM32MP25_FWU_ENV \
 	"usb_pgood_delay=2000\0" \
 	"console=ttySTM0\0"
 
-- 
2.43.0

