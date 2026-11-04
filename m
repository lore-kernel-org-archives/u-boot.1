Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C61606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=drH/Z0tV;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=AlYwQ9ee
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C39D78118E;
	Wed,  4 Nov 2026 08:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a7lvF0wm4pDS; Wed,  4 Nov 2026 08:52:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0F1081185
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782361;
	b=eQCfV64w9oShzCOxPslPVIlnqVitlfRRORz9XuwCDxr7/BfhDwmRti3+LnWlvT3kJCXT
	 Cmpflzuk3OHrUCSj2H95HOWvzGpduEi8ikJcFFbDHm34agGYBvl/95Y8vLQzK1tuXjVvy
	 9WzV31C8YxGktocX6fjHS+5D+hANFt4tlG3W5fo4vLtPasmQ5PXlJceE/6niLUXHByjTV
	 H9dGnCMFyPB6yIHulFDby48Vexmv5+/MJsny1r+g46IYsdJHCN9zvQrCjgwz0TzLsOzk4
	 DNpHNzNB62cQ2TuQeV8NeSSqDgNiS7OGwqIXy+PSeG2gKun/WjaZGoTvU4oKPcWJS9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=c96l0s85rIWpNnP1q3C+dLPOML3HBxA+iHIY61uP/cA=;
	b=d3xoCGmbiapxUkKkCyFAzRHbWrLqGWz5o9bAb0O4u68iZP4L8vzmeAgYSAYr1pYczRSs
	 pUOh6HVHBKIiyz9svfYATk2mtftcB9F4WD0k2dRUI7EeMTbNIwSSm2XbPLUVWPRiBVr3a
	 I0nzEeKUAvsNGu+gtutbF3Edxry/5F6OA1vw0I93K5Cok9l/OhcJVciaq2rjehba/M4g4
	 DPDLv3zTgPei8/6l3MgSioJIUvUVq0tZ7PRg1dWO2OvXm8D94amo3Jn4OMLIgOxZxO79/
	 /umgVVivwjd4fr0c/Tj+V686OpnhLgKE/Y6ELAnZhO5x5jjsCi56nmlCpoO5N2QJ2+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=AlYwQ9ee;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782361;
	bh=c96l0s85rIWpNnP1q3C+dLPOML3HBxA+iHIY61uP/cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drH/Z0tV77GS00sPyk6Y5JRF8kdSo/6A40HTNFxSBuu1VJcU9ax5zep60bP2CyLaw
	 A5hELG2hmV8ZXOXl7L9dGRed2L4YhXMqcEVx0VOHv7Y6cXwUQL+8kH3prPNtngrcSU
	 JlgEp+W2CC3/yg4vPtkCbnw+ldUeSstvtRIv6f9bu9PsaegZWqLloYkMkAGBi97dEl
	 YbrMJLPwBaJAZqjVz2+VV+9iczS5Uelp59t7TrdGUtw/Cb6fTgwxxlBiBWe2DXZsZO
	 Sc2Tcj3AY0zfe8vocWkLLH4I2sHqCh58Yxld+Qfes8QVxpQFXNYv8Iv++XP6rgtmYQ
	 eSc8YmcnsRJBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0F1081185;
	Wed,  4 Nov 2026 08:52:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 873952B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7921D81185
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bac_hilFDXDw for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BC7081194
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782356;
 b=OqGyihUX+rlSq+nSh82jf9dTA6gNjhjG58ZgM1Ed8+nPwUg0LhRn8kf0S4rNssBbBD02
 BE6vFa/xUzMKns5QqUO6xwYniapIG584F3m76S5/TUkjFLPdSJkNTDH4cr61YC106VdGa
 04l5ivYZQ+8X9iw8IZt4UALEX10xN/yNag6X3ARnfZXhTqES/KjaXgv0rXWabFGCd0Fjg
 UtaZvgvzmzDMIoNN2hzIfgUG/MtrNa3+Jc3k4uIxokbwcQtyRDgP0lbCQx5tBSVB0spgx
 Q/uXS3R0Scvp7bN6FojxMFuxpLbZxaJ06dQAIxiQvIakXVqG+rtxspW6fxA8wtqIyRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782356;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=c96l0s85rIWpNnP1q3C+dLPOML3HBxA+iHIY61uP/cA=;
 b=iSTPZFAqJgalVvKrvRFktFHPSU27uLtqXYNwADLa6uzss5puwEBTyzTFbzE/Zpy9Mznz
 JY4nLSWW706488eFEtlJv9zbqEyYZFUclb81V8WD5i3+ZqCvTdESE//tfeeSp+9QVnq5T
 t8CTEP4GzlBhofAmQq6+qGFYjHAXxRVd7Rjh26L0A1DpZXzcnMNeg+Lfa6XZi+/JzyF+B
 2spa/rl981euJ5OJ1C3J2hbywuB5+R1++gORUdS7EqKcPx3XL05ccXHAwyRjHh9cONWVC
 JPsqF8xuIkHQsJ/8wQwI4oUGf0z/LHoa6S6nJisQIe62G5srMSdkSapuNupQP/Z7ECA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=AlYwQ9ee; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=AlYwQ9ee
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BC7081194
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:35 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so3840225e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782354; x=1794387154;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c96l0s85rIWpNnP1q3C+dLPOML3HBxA+iHIY61uP/cA=;
 b=AlYwQ9ee+8URjJY+3x5D1T8f1lS5vUnF9WzruI3GIGBy6sd8oMOKyjn0oQWY2jqIEO
 uCuQ4Z6Cfdm5Ni+rlVDyG5kYbvXKSE5kKUhRVB/HqwWD1b2WSY7lnaV0QDKia+4fxcSI
 2U0SEdHvuFi22VtOpsDWmcjZazPnZMwmRNhzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782354; x=1794387154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c96l0s85rIWpNnP1q3C+dLPOML3HBxA+iHIY61uP/cA=;
 b=hJEt8y88wvz7+YMjIimWigQZEduItfzk9cOLvnhdXNWevpGUHihmfLtWJnS4kMiJBw
 24Z09epO5v37/p4nwO+xvWdG5OMdmwHm6O5hBhfUWuwtxPevFna2Oiuc44+kWWgTHiV/
 HdMAbmpu2BF9OEQyuLH+Qi5119MHBtJwpyeXImy78hol5RYLXCx7+ZS1A58TWMYl7/By
 FZuKpGsrvwJeUAmLkll/tJzASQgZAWejiAbb14KBZbGMuUQW5eEx2wykeijzfV5qq2Ve
 4IWNIT2BGHr90dxT0NppthBAuMF6jZm/S4dbYfhr/ODxPVMwrW7+R3UCyWarIbhc9abA
 HSag==
X-Forwarded-Encrypted: i=1;
 AKwUvByZwVJRtxBK1aSzAwe/x2W8eD3MFgjFoPTIsPNvFaGx13RzyGVQGAGdsWgbTvDhZb/mqNiRRNg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/NKzkfPYUnzWXy9bV8aJ3XDqpZAO5Q0nVLK8jOPtIZeGbd+dr4
 NZmr4/Zu95/uaTNs2ulfMAVwAJ2+0EiMagVFuaAO6UN6i6u/WC6Zi8jL7AopwiV0P0g=
X-Gm-Gg: AYBFou3IeaGf+aMSMiP3gS9t6k43Tw3iqsEy3Q0kwUHezd7SezKER8yNaBrLqGZ827g
 OTcOSVIHUM9NhPCfvlQhhNg7WV/SWNsAfvUF+KHtVNdiuDRTuGBXE1lNuddE6c6G3cvIQB0/rcp
 nf/SqyLPW9UvR0Mclputb+d+xf+TPb7s08b7RzfZr1ootRw/HI/nd2fHA4TSQckOen0z1zp87vO
 KLbmAUJdCiDz2Lz/QtJ+hV3NcD2hwkW9wKemEDzrf9q41wQWdJqS5qcTRYEAgjx0IN5NV0RLbn0
 6mkigDcpK1VC39E05/MD/qYu0L9IR1EFEaf/04ZyVFudqsacIUlcRPxVaLbDzX71Q/kNiHc0iaT
 eNcOiNEXSf9/N5hYLRYxribZUyagBqSCDVA6W2WZjbOvaPoF8dyGW5QTGGzy0tdGHJJEpaum6Ei
 qGcco3d4Uj/5t2pMsdcDluQR/eCU+S/uq3MneJgdojPJR69JTLpxsXV5J3QEusQWDHHV9o2pGRj
 N6LHrQs5biekkvzDBydC+jTKa1rnOMC32+xgCD0YUgA2HMAfT7tCI3O7REa/7ORfnulSCSDTchf
 GLeg8ClNyAd33ABirOP7wXTAZZzuUCfkst4FrUnBWk8ds5xgs7PXB/3lwLL7GskPeIlrSe4BCbD
 Z8z0xu2chm3qc9f2ctc8yfDZEZIAT
X-Received: by 2002:a05:600c:a012:b0:4a3:59c9:a747 with SMTP id
 5b1f17b1804b1-4ac1793fb0fmr351407045e9.17.1793782354054; 
 Wed, 04 Nov 2026 00:52:34 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:33 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 33/33] board: engicam: stm32mp2: enable simple framebuffer for
 the splash screen
Date: Wed,  4 Nov 2026 09:50:06 +0100
Message-ID: <20261104085036.4012238-34-dario.binacchi@amarulasolutions.com>
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

Enable the simple-framebuffer node of the Linux devicetree to preserve
the splash screen until the Linux display driver takes over.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 board/engicam/stm32mp2/stm32mp2.c        | 21 +++++++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
index 5f2db3a53146..a7149fd88fa7 100644
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
@@ -147,6 +148,26 @@ int splash_screen_prepare(void)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(OF_BOARD_SETUP)
+/*
+ * Describe the splash screen framebuffer to Linux, so that it keeps the
+ * display on until its display driver takes over.
+ */
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
index 0c71d1a48db3..6665b0aa8f03 100644
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

