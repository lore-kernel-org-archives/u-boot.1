Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396A607C359
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UwWX+dK8;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=npVa4uqG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43A808146F;
	Fri, 13 Nov 2026 17:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XBFmg1mRoyYw; Fri, 13 Nov 2026 17:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 45BB28145C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794590762;
	b=ONBSvdrQ4LzKwzJC4pBZH8/cEBOPTsma5+wBSEl48cywtZq/6VXBx4QIFAB860Ez/ace
	 nk3JHxHCLbNjin5kGeJXdFkWWc7DF9hN5aS5oBJANl7wqu6X1cqfCq06P44BOXR2+w4jk
	 X5Z9nU2yZa3bnnKSE+uZmLIxAlt3O1d4du808F0wAYihyFC/qWzsZV24MakmyDtjp4txw
	 ActJ9GzRk3SKnjX+UAPOk6kNx5bLhs4kDo4lXPqYnjfWDjirl2h94BzL3IFoJpgtNqMjg
	 nhWzEb063CXUGUEPed02q1b9/96S5NWVYcg9AyBsZc5k1qwsOk9dYTsc+4dNj5UCZ8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794590762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=e+7MgdkOWn4OT1I56qQJ7izj8btb7dbfmMat2sf6P1Y=;
	b=HvRO/Uvt50CON7+zY3Ru8qG3q+3JI+pUGhrvAAu/PSHy2f54/srnLc1N04ybjfaILP4l
	 5XsDrWzBfO9gi2ul427nxKrba0zRxDwF02S/mgu+KtwQ5qLD1XczWHo7f5G9lulO8NfG2
	 SopaQOZXu9N4uJ4ikox7kdcV9NWPTMt5Bic1N5vGfoIz9Uvv6TpBHAJ/ZnxsAyg4O4UEj
	 HGI8GmCx2xhDaYgEgK+47FkLny4HjyxzvYJMITVjVSvXE9g3HRWz72dvP7W0AL0w7HSuO
	 gqeHMzXN6GrutYhirkg/2DuIXcbwUMLj0mnzqijCdyo8RBrSUZr7nKM8r4gNtXXYhNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794590762;
	bh=e+7MgdkOWn4OT1I56qQJ7izj8btb7dbfmMat2sf6P1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UwWX+dK8sQT2q2EHj7FX/Ywg5syLJ3CKN1EYB3Wi65nYj9ykGfXdLiOAmuqhMXlki
	 8AWEde8HjQOpfa6rszQDiMqD6PywauBa7bZAchRPrJgeGyFQjDWqBeVKL0UNZGyjO4
	 /rP95FP21HSAYCH4H46I+SNNszj3ZsydbnOs6X7TwGoKNW8/xzQVRkBn/6Ue1g84KE
	 i7ImIlsgxu3flH2Kcm5tzQm2I/H3HQr0B7osqgGijLp/B35RuCtvZ/YwoX2O3eIXX1
	 9L8Mxes2zv6eEmpxKvpFqNnoC9Aa0jnKbTr/ja8MIobl1Uq3gOcWcqi5l3xWXLYHFL
	 LgtoebB6YV5gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45BB28145C;
	Fri, 13 Nov 2026 17:26:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3D8E235
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA9B5606C7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:26:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWLRI1WfQduk for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:25:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 634B46066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=npVa4uqG
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 634B46066D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:58 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so482685e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794590757; x=1795195557;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e+7MgdkOWn4OT1I56qQJ7izj8btb7dbfmMat2sf6P1Y=;
 b=npVa4uqGL8zosRlHLJ58rISXSHj5xGG6ryjeoa9jBn2KQ5FtGFGeI3ZDM9MWizs2FC
 u6RhpqsxAt3JwgmHHbo3yVKT6hGzTZ7csqkIS44/oVyH4OWdrx5GY/l3Zlg5Qa4jePJT
 5rJvXPONOW/Pq2fhC6evTkpA9SZOJ3n+sR77s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794590757; x=1795195557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e+7MgdkOWn4OT1I56qQJ7izj8btb7dbfmMat2sf6P1Y=;
 b=Mihh91Tpr5hD1ncspwh9E+bx99bzeReNRV+Zmof9jTYLprHaVHzyGUae5mhMg0gjfY
 44ViMqqUUL+I+1VPJcPu5ti2FGpx7g5xK61E6qCZ3ny7yt9ugp6ItAzSxBOaYa5z1GKi
 QSqFExanjMabYu86mRCmssOt4fSIPohFubrMuTneCA7dLGTSYpoZfunZbOoIlnw08qnT
 9bRUeOHwA1K9JDcPBopNFT++4ELqP28zGEPGLaXKNReUMa8B/e8kNU1oSb3sNPXTeOC+
 JWA8FxgzgGa/lCVPblyFYA5eb2MSeBe5AyiZd4z2IlrAAvZ7N27qYco7n0H6GwSElxN5
 K+xQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF6/prXVPikBhB7YStdZewMrkwXLOYtNoVQnWbDAGkirLlIoefHcPJD29X0TwxLTriBxKa72Tg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9tUIfB2gPC2cXToVdZifPgZ3EI4/B6A2JaFHXS7OZnbHOHw6cR
 G94PqDIEvuWgQtEG+ezGHzJdc08GcbRn7fYPNH0u6RVQLG9GBzAMUWCmDuQuOFhihkkxHeVJXHS
 ArPOB
X-Gm-Gg: AYBFou3wfMVv0RljMXn+e7Bh1UefdQPH2vmsFwf3HsJUbwM9VdRPH8KgBKdGNbi4oEE
 F3AUUXg4X0rloAf3r65x4hA69DfsUOfZBeDfnGPvjz1gKX5vwMtFIFJ0MnyBWIkCkQ4oObjQvZY
 dw9jGztOf/ohkSvkUAXKhNQScNRA6huGnHWH7SK9ISDHODMPuqil9FEahcwfq2i6kcHS1TAGk/Z
 hZf/mjst+mB6E4ec4emOexMLN9/VWz2w7r63m94go0gAN+JN2ygIziRgKT5BjEadC9T+1qnFp7I
 GztsZ6glFZWQzaLUNE5DBG62XyGFwMI7GGB0Y1ARjspPjAmvP3qiRXXl/0eK/kmvABFu+ecWyB6
 KtLsPSQu7RriYJLWtvXOUg164R/ZEdj9jAhmFuvNFMy3USfkENKlc/Rn5Euld4hCsCePwQ+pmb9
 /1Z7WkAJqROBvuRY9ks3joG+CA4W0r1xQExeXYEngOPGC/znEmDh3XjaRHxKjlNcEF3xbxZSWAV
 m14Ha39xpK+8wR89knnxoAepgOc24gDsa71i4lJ1d5pB/D7KNt11lj6ExP3btISZgQcohMIjuyY
 Mm2Q3UyEKPvXe0YPPoJnL9bhtXiJrCVPgTHPh/Ne3q8yBtO5CQLWIkw/+099nRqCaU8MgGqkW2K
 5i/NwOxW/0E9WqSmqny/hOcXPyV0KdsfRTu0BY+7IyDKh0WE4R6tDzWFPdq/s8xAUkZmrzH3SYT
 03Yous+EZXWhS9cxYD4qVLK2ij+Ns=
X-Received: by 2002:a05:600c:1daa:b0:4ba:2bfc:c8ab with SMTP id
 5b1f17b1804b1-4bb55a4801bmr71205445e9.15.1794590756798; 
 Fri, 13 Nov 2026 09:25:56 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm7312526f8f.0.2026.11.13.09.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:25:56 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] board: stm32mp25: add splash screen with
 stmicroelectronics logo
Date: Fri, 13 Nov 2026 18:25:01 +0100
Message-ID: <20261113172541.473641-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113172541.473641-1-dario.binacchi@amarulasolutions.com>
References: <20261113172541.473641-1-dario.binacchi@amarulasolutions.com>
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

Display the STMicroelectronics logo with features VIDEO_LOGO and
SPLASH_SCREEN on STM32MP25 boards.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 MAINTAINERS                           |   1 +
 configs/stm32mp25_defconfig           |   7 +++++++
 include/configs/stm32mp25_st_common.h |   4 +++-
 tools/logos/stm32mp2.bmp              | Bin 0 -> 7802 bytes
 4 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 tools/logos/stm32mp2.bmp

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b38ffee2886..fd0ea1b8c633 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -689,6 +689,7 @@ S:	Maintained
 F:	doc/board/st/
 F:	drivers/rng/optee_rng.c
 F:	tools/logos/st.bmp
+F:	tools/logos/stm32mp2.bmp
 N:	stm
 N:	stm32
 N:	stpmic
diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 02e5efd1f48a..79019d3101a3 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -35,6 +35,7 @@ CONFIG_CMD_PWM=y
 # CONFIG_CMD_LOADB is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
@@ -95,11 +96,17 @@ CONFIG_DM_SPI=y
 CONFIG_STM32_OSPI=y
 # CONFIG_OPTEE_TA_AVB is not set
 CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
 CONFIG_BACKLIGHT_GPIO=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_LVDS=y
 CONFIG_VIDEO_STM32_MAX_XRES=1024
 CONFIG_VIDEO_STM32_MAX_YRES=600
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
diff --git a/include/configs/stm32mp25_st_common.h b/include/configs/stm32mp25_st_common.h
index 0b0267ae99b0..3a5b65c813ea 100644
--- a/include/configs/stm32mp25_st_common.h
+++ b/include/configs/stm32mp25_st_common.h
@@ -25,7 +25,9 @@
 #define STM32MP_BOARD_EXTRA_ENV \
 	ST_STM32MP25_FWU_ENV \
 	"usb_pgood_delay=2000\0" \
-	"console=ttySTM0\0"
+	"console=ttySTM0\0" \
+	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
+	"splashpos=m,m\0"
 
 #include <configs/stm32mp25_common.h>
 
diff --git a/tools/logos/stm32mp2.bmp b/tools/logos/stm32mp2.bmp
new file mode 100644
index 0000000000000000000000000000000000000000..03ae80c816472f1022923d749e9cdc8a326f6087
GIT binary patch
literal 7802
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

literal 0
HcmV?d00001

-- 
2.43.0

