Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430C606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U1aYp0XN;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=YWfl+DuN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F29EE60D8C;
	Fri, 27 Nov 2026 16:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRdh_OqSrZ1m; Fri, 27 Nov 2026 16:15:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA15F60D89
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796154;
	b=VpEjmJk0RrwhshzY1a4YmY5RFIvxNP2+3ahaXm6S9obyRFfAu6D3epPCg4GHaceNykL+
	 fLJqJiCT1S/HzURJjYx+fvWvsona40TZimICsbeZRKgGPUIz2+d1d8xHYWeMPbYy7iCRQ
	 5WFOzyz/j4m7y1KZ7LWASOzH70duLbXbIJVZzxi2Ue0sSmzxSnWGnlqhuOQJ0AVLHl3So
	 sgHf8w3i785UmX4VMu1IgCvNl1XEzZFiCNzws8SVsflZ/JtFM4asAaaHTm9vdWHNtSdMi
	 wAs4K0QdL5PsBAjHdjYb1Jp/tC1DUv3k5Yy67hRJYDas2uWCvYX8/b/bcmvyRLGnJkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2YpABl80k+q/Gxdvuk82CXccN9waM7AhauWhrvQfnU0=;
	b=nbg1HYzz2FpWdBM4FarDGTOkkBQc0fefoi+Qyw64bIcRK91RSGv0mkfbbFAf52mFPEPg
	 v4AnRQ3YM4gMWIWu17J4WK4AAev7AMuZMu44V2xSWdkTjrbGcTdRMYyeVsWvhwQ8lRzv7
	 BpdlOtLSOggpZUSt8AAFN46YsM0dxdnaPAckfh5yV/LSH0UZJN8JwouP00zMEM55YbegE
	 TxVb/kISKLLsdE97ZvaKrnRxDNNizyBK0HwW6GnaB1XQ0NMVcdcHafy2ckYkkZFhvSob7
	 /Ot9nBdevqN96d5sByNnv7TpWTcCxTvlwAVTYWI8UBIP+Mg2GkpnU7vrqP2gFz3rLyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796154;
	bh=2YpABl80k+q/Gxdvuk82CXccN9waM7AhauWhrvQfnU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1aYp0XNHYlL/z9E5yAg1TGsb2AsojT0upCFTEFbXO3h7fHaoFYJTuxQky3dR2+Rk
	 e77YenVd5BJz0DBmrnAjbdZFGB1tbfSmuaPYhvgoC9u3p6d93dnM5KZt3WSEjAkb+X
	 tSYO+qjZUtQFljngKJhIXAiQmrlpjy4wPBvb0QLPj1t0WahVqIIu6D1050XH0r7ep+
	 CrzvMy/5of7aF7reVPeahTOQ2lBw/4eZk1ZAKmWWePYtKWSP3PsGzGKLrNGKnEoylz
	 Olfdl6OzqgwL2Bmb+vSZ3uvB2HEQsw0043VZU7zCLk7lG0VYGkTQ+BpnazZXzi4n09
	 dbIR3Eh4SqWmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA15F60D89;
	Fri, 27 Nov 2026 16:15:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 866711C9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 787E540593
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sT-PckZLbmWj for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:15:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7699A40579
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=YWfl+DuN
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7699A40579
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:15:48 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so7785712f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795796146; x=1796400946;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2YpABl80k+q/Gxdvuk82CXccN9waM7AhauWhrvQfnU0=;
 b=YWfl+DuNWJIbmzd79mYe2bo8Io9P9k+H7XiyabXHtDftwOP+tiQoED2jYUDc0zYC6L
 FsNi3AGdagMv90PYbY/TOa7cCvgoEpDc6/GVFaVaNKOKa05/CS0c/7niHkE+aIJqiRRO
 +PoomIV/uPSRiCxNLXaStW8mRVFOif9CUbuhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795796146; x=1796400946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2YpABl80k+q/Gxdvuk82CXccN9waM7AhauWhrvQfnU0=;
 b=blkgMaKGDCAXaFXJBNn9Ctw4A0cxVjQ6B9FNEpsZWfnrU0m2pzMK2Ubdi/Drm5nTU0
 nUoF6HcJUnu34nFLAR77GQ7SNJBJvcKu/Cl0hrE4/4jwiaOE8GlhmODPxElMn+EYqBKA
 laC4veEv5GL8jK4iGkl+h9MU47txIylXA20i5INd/vBOEbTCLw9aE1wTTh9HhZjp/H5u
 lgJXsJ3CnTfH6H54ML7sOUD1lvXSLEfHeYAtTvaqpABHaX2qMp5vFIVs7Mo37rcdMK9J
 r02OKvA0CMC8+NFM2esl9IzaQJ7IZxFKG7rOT8C6Kjr/Fy1ZfAN02htdtNWgJ1nkJjqQ
 HxIA==
X-Forwarded-Encrypted: i=1;
 AL+hErH+qVAOCBpayjOPMOdhvcJi+Id9wFOCJDV/Bierfy/Of8P93GT3Oly+aPu07cwNgxE/a4CID44=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+VNG35sF0m61qK5Pfvqm5R0A7l3T48ENBxbTj7ox9nNURBg80D
 cbYCCouRgrL8HYqSNDzkPPLMF95rtoMX9S+usbaOTHSAKY0E8tgEM83zkJ9fnyDkNqs=
X-Gm-Gg: AZFdTZcmZv9S1QaHjH87IXAELeXTZSum6oRaGCYQQkl/9KSn7bdvWbvgWjuGz2tlAfX
 EBRM/m+zVmgddAfr69vOg6zRn0oQSxJ7pgqGGxnXgjmBi8m2ObHXzhoLnXuLuZidf7y38mui038
 llVOr2TnlHvkkY1bWN1BFEc3cUToJzeorIlnI+KRYAr9ksmpg4uo7oY21BmmpoExwC6w0fKCo1N
 yzGIf+Szk2D5+AhyZ/gts//DnC5/6a6x8inrSu9wg1jrCyt5kjS72eq8ArgJGFkLnedA2mXdSCw
 U6EY4MgL4XXFQJcVp5VAU3EwBg66rOkgvnkjc9pypa1V1Q68kSaXgKGr8uknUxsMhFfApejhjKS
 GFee8+mLjv7LGpLlZgqcz5qxp0DtSkrSDh2EK0JhHREZ/9o3J/uWVBL+FyfbNnpyndXeaVshDaH
 1iwP9HqK/LU+1PUMbrw1rKN3a6KETDRb9T243+yRhTUBrvenX1kwc1lNeD0/KBFDP2yGPPbFU86
 QDYJF9/jKTGsD1ZNbNexTZ8+KZmh81RacwLLmx7eS9y/DJ+XW++hj+SmyhV9ZVggsWG4WbXyudK
 EqMKIx5xVbjCTIY7WSCnC5I9k18gFjp0fvhLCyBszUklUStxnmHHIhnp4MHoHhRu99bTZJoRnEn
 2zkL88c9nXPdggMybwJIp4EK2YJI574Tfo7YZfohJxECVEGeRVGeuLJgKIMfORW4N6QPsJdhKio
 qgTp6okEVl52Zixr04nPT0UZnykA==
X-Received: by 2002:a05:6000:4b03:b0:48d:ff71:dd9d with SMTP id
 ffacd0b85a97d-4abb2ce4d3dmr49637752f8f.23.1795796146310; 
 Fri, 27 Nov 2026 08:15:46 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a68048esm50338987f8f.29.2026.11.27.08.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 08:15:45 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com,
 Yannick Fertre <yannick.fertre@foss.st.com>, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 1/2] configs: stm32mp25: enable the LVDS panel of the
 STM32MP257F-EV1
Date: Fri, 27 Nov 2026 17:15:19 +0100
Message-ID: <20261127161542.1907090-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127161542.1907090-1-dario.binacchi@amarulasolutions.com>
References: <20261127161542.1907090-1-dario.binacchi@amarulasolutions.com>
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

The LVDS panel of the STM32MP257F-EV1 has a GPIO backlight. Without its
driver the panel fails to probe, and so does the LVDS bridge:

  stm32-display-lvds lvds@48060000: panel device error -19

Enable it, and raise the maximum framebuffer resolution to 1920x1080,
the one supported by the display controller, from the default 640x480.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Set the maximum framebuffer resolution to 1920x1080

 configs/stm32mp25_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index e55ca2e3f0f5..21fd2023053e 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -95,8 +95,11 @@ CONFIG_DM_SPI=y
 CONFIG_STM32_OSPI=y
 # CONFIG_OPTEE_TA_AVB is not set
 CONFIG_VIDEO=y
+CONFIG_BACKLIGHT_GPIO=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_LVDS=y
+CONFIG_VIDEO_STM32_MAX_XRES=1920
+CONFIG_VIDEO_STM32_MAX_YRES=1080
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
-- 
2.43.0

