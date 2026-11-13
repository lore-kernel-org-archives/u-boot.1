Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9F607C359
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WXjqjfoD;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=PshFnEDO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B2E540DD2;
	Fri, 13 Nov 2026 17:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8PK5XtDc9J7P; Fri, 13 Nov 2026 17:26:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55F0640DDA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794590760;
	b=VWNIUpv/EOb3LWDafLBCi6LfvynSpUgJw1r5PTYGuT0Xy5XIDDhq3DsqEmDnZf2SqL1l
	 VlFbGMJQHyCTbRuloz226O5W3UxB8pRMrBJMLjtgFbIG5xGgOZn/A2xuFdkER5Q2SQHX4
	 mGUGukUlY//OOjHasC+ZcppypHq7YNHhHPHkdfhIzQ8lE2satGS5fj0ByGvx2bZzC8kqs
	 9uezHl5h4g9uKF0aFXJnJzHP+11HCrB+tkJL6Ou1LxmTbJYw3M6Vs30SaUTINxa3LMJ4d
	 zKzoRMk2jrfD+NWSz5kJ07aOgr0sg9iLet+Sord1pXuDSCQxn+N3UdD6UVwB9mlARKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794590760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CySH78AmOHiOHjlPTOURhLpqas5SEJNpPr2JeqSZLVc=;
	b=KXrMchbgbpfQ40GT4Xg2ehDCBpxC2SbJJyroNoNLo7BYLM75DTD3HsrZifeJKuc15ok2
	 udLn3DU8lYMQSueUjK7hqRolvp5/ayCVSBOovzXL1t4vjUOs5mjWoiLWQcjTr4xP3Datz
	 h8Rf/0/mFauTMabkPjr2fk96bOF7ZWVOOlVl7prvNFTLlknStG/W0U7+02OrmKTTxAav9
	 StgQAAYvl5NahstFZl4wERc+3VjUbV7oHzfDlbwM3p6ktHS0iSDWyzqWVF3Mfnkg1tPU8
	 arrIHKdH1AsEkhCyOOtYxkxs6CBNMAKidDjrikHbQOQDFRxFmErw1Zc9nVcPrAE2XLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794590760;
	bh=CySH78AmOHiOHjlPTOURhLpqas5SEJNpPr2JeqSZLVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WXjqjfoDdq/aeqtO0eaGKCZyplVXoE2FA3i9MQEAIQpcBbVPGNuYKsOPdgLqbPFDV
	 64NLv1fwFaghIec5jDqQivitjcnch+s/ge1PdaM3qsaOO7T7yjxolRi6rI+ZGHEn4b
	 OTKN6aymVTzLtnvdSLzj8DLmc4AEYadymEJDN4DrVQJLSzSBwhXAyvYa0r9PyYojge
	 zeD/BbGk50AE5kOlDohdHUszLfE3GmaVh4ay/Kds5azOYgmczYy3EbkTxyUa7znPI3
	 1BL8+GDlXqWaDPPh8l7FGNlKjVxRpejgj5Qv2WQhHlGr1vpUmDiuUwh9SgNGT9AZ64
	 fAW2KMSQSz67A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55F0640DDA;
	Fri, 13 Nov 2026 17:26:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5052B2E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 425E56066D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSTRxpKH2tjK for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:25:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E448606C7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=PshFnEDO
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E448606C7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:56 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so8091915e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794590755; x=1795195555;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CySH78AmOHiOHjlPTOURhLpqas5SEJNpPr2JeqSZLVc=;
 b=PshFnEDOvIW07OI351wo4Uttvd7ArAkFE8+bz9nht3X9T6/pPzeoOxCjNDB/AmOHZn
 nANIi1kD/qjO/wPS3Vh855k+3StdmLEJFcAgbNCql82A3QmM2bdfPQF3NsrtiBfYjYx0
 GJQ7DiPryTODeXZOFotDz4e8Q3KcL8IG34m6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794590755; x=1795195555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CySH78AmOHiOHjlPTOURhLpqas5SEJNpPr2JeqSZLVc=;
 b=Is9N5U7n+RU06iXv00/DfOKPaIxHZJrRs68ILZbjQbKg7AEi7UM7aW+kPvYQ1rU34W
 z3tvPNVh6ChtDD0Mhpsu9j4VXr+v0+Z5GU64f4DQhtKZa9ItnYMzKC49f1xLCQDra9l5
 SyFi+MR2pNazt5B1QX7hvfEJ8AhKdxIChH4WS6Clc9CSSFmsFy2VKFLfSZyyoltMfddt
 bYmsWii2dmDJeqfCIkgArDXMMn33BZy9K7EC/lj9U4HzvcCwM7ISRU6nBX3eLdfXYX4R
 4YH+nD/nAO6PbaVv3kHYdAycGcLOF3pf/yKiD3b6cqxfW6fBv9gH9zK74heINwMguPbf
 o3dw==
X-Forwarded-Encrypted: i=1;
 AL+hErEtL3lk7oiF03Sw/7hrDlCqPaNGrmafcVbTaTW42I0pOH6kU3AG2gpImIEGpfnRKjbqtX7Duig=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9SCxg2oyBVlE1InLdWVJkcHwTUIeOVntLpNwre31v/qMO3Fdtx
 gsVenDPb55ztpM9rKcKsxoT6NV7I+HyWAXjeS/2m/2eweOC3bsZValGtipU0zf1/XbPEPlqAoBk
 xz2rI
X-Gm-Gg: AYBFou0yTe4ZsMhjhh8UNDLlEfnrMRvb4ou8mzbl4AHpVexQ/l2tZmYGP1zRH6Mf9k5
 pLIdoC+hMXgGY3DmHAKb217Gf9O+enLlSs9vgIxd+7U/wdiionlak9GAvpwsvmk6T671w6fUFFC
 jB5N4B8o1bPgV++ROIoUG9RgvX/+Wfwn7el2ASNDra48nmu7VFxMxSv2kRUTgGpsJJTkUJvG5WN
 ic4+3ngDJ3gvdsoQi0pkgchiNo3LoT1VUv4FjuCoEpJ03Zb1DUzqrnIi/ZT9AcQTRwYQ5VXK6k0
 iSXislbcaNOHGZnT5Ivs0eiUh3pNNU+eGAGNhjooIeUrjAn3r0EIW1/GwFXymJwo+MGwWdBrasu
 wVdLiI7tL02eEtggeKZPy/VLx9L6mx7U/0v1w1Z6uKKMoCDFPsYbV8yLgmHjunXx/7DEkQFurL9
 UGYb3nvSPHfF6q/PQ/sl8GkPum+VQPdFLQD5sCeMgQcixF5QCdisty95nKi6P0dPEvSF0lxMWpo
 1uXLFRvLM+Wa3q4c7PNfIvjUQI7Hb7R0Vsa4AhmWxzTNGDfuBZYOG+dKlfJUY7ygU6NrFQGNi/w
 /5VWZLJJyZw/UbAHAHlapl9boOTYOogfPAN6UhO/1FgIjXUDll8YyEdUEx99vw6M1mjBV2OcJ9h
 NFDWwlhz1aAnMZLIocowV5JVxzmKEvjCjC2jRoxPZllnaIBNs0YKfNDlgY1+pd6f7Dd7S3ts1xS
 p7qP72fqWVkdUhnP347acIs5/ApA==
X-Received: by 2002:a05:600c:c84:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4bb55aa3a2dmr73029135e9.31.1794590755084; 
 Fri, 13 Nov 2026 09:25:55 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm7312526f8f.0.2026.11.13.09.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:25:54 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] configs: stm32mp25: enable the LVDS panel of the
 STM32MP257F-EV1
Date: Fri, 13 Nov 2026 18:25:00 +0100
Message-ID: <20261113172541.473641-2-dario.binacchi@amarulasolutions.com>
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

The LVDS panel of the STM32MP257F-EV1 has a GPIO backlight. Without its
driver the panel fails to probe, and so does the LVDS bridge:

  stm32-display-lvds lvds@48060000: panel device error -19

Enable it, and raise the maximum framebuffer resolution to 1024x600,
the resolution of the panel, from the default 640x480.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 configs/stm32mp25_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index e55ca2e3f0f5..02e5efd1f48a 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -95,8 +95,11 @@ CONFIG_DM_SPI=y
 CONFIG_STM32_OSPI=y
 # CONFIG_OPTEE_TA_AVB is not set
 CONFIG_VIDEO=y
+CONFIG_BACKLIGHT_GPIO=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_LVDS=y
+CONFIG_VIDEO_STM32_MAX_XRES=1024
+CONFIG_VIDEO_STM32_MAX_YRES=600
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
-- 
2.43.0

