Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30D606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sXkRnL+j;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=EtV9kphZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09F1460778;
	Wed,  4 Nov 2026 08:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xq6XNaloBI6r; Wed,  4 Nov 2026 08:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3547C60890
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782358;
	b=qi1z6c7Pc/86Fs+5WVsL5C24HMVoi88liXtjEjoi3pb07hwIyCzjsbSZkgj/Ia18ElYK
	 DDerOGZ0Fyv1Qdop739P99vr3TJBA8Br3T9tZioMMV7MYcnMzza3xsvWYtoxIMRga51I7
	 fkyTeGdrXUpMM94WL+XauLtqxWKVR1ljhjovqI4kXKmODIV0T7XwMmifYfmAaClLjk4+O
	 4mQTvK/QPqp9zh3T6s4nICuhVf750Cn3tRMErAOSnMkK42lOMrKkdm8abAWRrAompJMp6
	 U4q5kIay017x67AnazOikd2UlaW6jTkYrUNiLai+JiSGgwSVqPX61FlIcw67x9H9YcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782358;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yP+fN+M0TliDkq9pNH7Qa6MfF5414Zb23x0hMUZfQuk=;
	b=Wt1qhzQSYpNlU03NHClDnbQY+CM43+ZAO9cJb8TaWWfw8F5kjfXYeSsmqp8H27NOJMti
	 HWCKDotwClv86wwmQ9ulJK8+rzgWm58aoktnhZZmjpeLd1YA0Sg72TkGT+nXNLcofGmK4
	 Uet1NP6Ll9s7yeBYFZc/44P87Ap3scg3XyRNR2bSmdlXvH1nfQbmBRJ7iTJUCFjpy1mOQ
	 kzuwBVn7NL85rDgGuB97Mu0X8lPQWTDZRlJC+RW7lk+x/ShxaFHf4zcSUplCTysCnJEyz
	 uOTS+TmMFyR/w0e3gVeXIFpOLAbP/jLskKhABdv/M8opJM1n3IYfw1LzEaEVAX3dpcQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782358;
	bh=yP+fN+M0TliDkq9pNH7Qa6MfF5414Zb23x0hMUZfQuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sXkRnL+jPSbePeFFCbhXbvV5QOfKq9maatVmHc/8okIV3QkbKlFp3xFPRwPzaCdmj
	 o2PcXnTM4P6bhTazfqLeO1bmXRmAKGquQmQypHrDAjlk+5N2ecOV+kdW31p5yFpfvx
	 SyHrN8seYDya881Zp3B817wpcLBfUkcbELzHTZICySaG8zw+/z43xMaAYIlDbPS4Qy
	 ccQdIThSA4VXZ+deV2Qnes2CgnuWa50iRsCmArZdIMkgLPBVhftV9hHTILRYfxhLZc
	 qOf6E8R8ws/h2aXbPVEASByYx8FL8Nj4gl/LvivVYd2lPALIXNSn26cH1f8Krh4HH6
	 jLSHiOZ518Zuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3547C60890;
	Wed,  4 Nov 2026 08:52:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E3E502B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5FCE402C5
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BUE3KJVNgPNE for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DA1364004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782356;
 b=IR2UWDF4v5Pql/AAMMDdEwHm3nYgkGLdfjEQYyr3sRONsCywHiEdc3OWgPLTEaWosGqS
 mUzzXui/WvPueZu93YrNd6NDRvHbNeuUSfBC/m7Jb0MPlO0OhnBtL1O0xsLgvs9te5Zft
 DqiAg1fKIN2ki5A5l+78GubhN0ZRal1Dc5a0rsnYVtJaoMEQgNh5kVtwMBXtqYu88WLV0
 YKCvs7OwXuHt0APpiBrwySwlw1a1y2PS0bJBOPsg8d4KmomfDinUhf+BR/WmB/sNUIS9u
 BiVXUkdrN8i0kOxK54gwrzaT4MGyP4SbzgkU/aBfCx9mMI3VRDjIgD5GxkzI8XaZqxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782356;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=yP+fN+M0TliDkq9pNH7Qa6MfF5414Zb23x0hMUZfQuk=;
 b=gfYmw32IZ0cGNSgMRUfvTgsj0xRPO5ztM9ELspDNa1q8s94T/RJrlR4YM6iasgSKpcJI
 IRbqapBRq8I2J9sDZoxWzjQkZ+AjeUn5PvEuSXUfC+L2Jlf8wYyyWsGuSRzvwqCvrt9L5
 jE2oc2g1Nmiey0TlQAcwK4OK/MDLKSiAoZVtuQp9xtLO4MoRU884JGMXj+8C5NVfrJJ8M
 UxE85dmCzDuHdOYm+J5oEICr2uYs4ON4sOyNlyOJxYwlcTv3xTM68qLpxmAW/his4AyC9
 YB4XxqI/E5pKfRObstb/ker6tVTdV4ws5LNgrE2plrRmlBWlvdDcbhvNpLn8/9wlPww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=EtV9kphZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=EtV9kphZ
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA1364004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:33 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso3567915e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782351; x=1794387151;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yP+fN+M0TliDkq9pNH7Qa6MfF5414Zb23x0hMUZfQuk=;
 b=EtV9kphZ6vjMehj8xIqyhfVSr9OCJy8KvHDnXaaZDDjJ5F6oLLJvavQnB268hvEFPr
 OeTC+DT4IeOWrs1Mdhxt378K+10Ba7vf7f26RpKz+dg9geWNMnQVQsTEeF3x2T8pa93w
 LCwntO8PFBCMBNiX9UjZD6zPRuqTrShLiUPAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782351; x=1794387151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yP+fN+M0TliDkq9pNH7Qa6MfF5414Zb23x0hMUZfQuk=;
 b=2zudzomsU2Pz53HMj8CUbiar+i3W1/Y61MjT0P/kEC2We+oQZl5rzBAaD/xUNVAoA+
 r81fA0xdBivVt5pNvWy005zMfkCtTl5acY/r6mVI1P+C+9mu8aV3Hlj5a9pR9gf/LUYp
 SZQMkuwDiKW9PfxbIV8SasdivY2neiceihR1gvYenihWD8ZUgjZhRxMd2jUd2TvYSJ14
 Wm/PboHnqUJQ9theHDkHQ0BRlk9UBPmPl79wBlpy6egExR9ElIuttrvvZ4DsjnYqW54q
 XWNOB+GOHMDqhJNI7lA2/YiP0tb5FTSY/m5rnu2hvyY4C/b3+LVW691cNePxx81Px524
 JuAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzj+TMVcuk9yC8OQ+mzAo1Czl4Psj2dEWvfKZjIWgkt/y9PFfRX63m3kohFMzaHWJTImqNMVl0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z98QzqBs2nzzeUTJz6vXb15YD803qLdMXz3sZ8RhsvEdb29a+dq
 uUFcZ/jV8bix+4bBLnMAVBbCvpFqFlvw2Q29vN8nDvAdb7JHf7o2zDfbKrmuKuJC2TxBP/txWO9
 UttH5
X-Gm-Gg: AYBFou3aOVJcS4Glly/n5/c6bgaKU12hVAOpG6NZPPwaxwQa/MSAqvOM21pyR2CB3YB
 yYmPIQCEgkHYwqL8DvgSXe7HyLvprqDBtPhiP+S3ncwj73XNZTuiIBDK6riIIRxLPmb2ZwmAa7Q
 uhdrl+hetfvjwpmHQfYmirIL6dNPNjMhpe3pw0Be9HWAtsC45mOtmU5dV2drhOorbNugpykGhqJ
 RIA/v5kUJ/mhENbfYLrvDha4kXTxAKoxN+1JJjDpbfjT86Qjaw5zLoTQLmInKPfGDEu7ACnKF2f
 8Mk2ThiwRBPafmFr6a3nVwu0roxcZPnvKNBrTqhCt6o4qriGEfx0s9qArShlW+hiYDMvfGO+Pdn
 XvBaLbgHmN0ffZFys1iGn46p2wXeyLcYLO5xtqrqAsjpZrv77I5xiZdGMgJ4JmZMd5xslFvKFis
 sxYFaSlLx1yfF8/W+81SOCibGf9qewQle/urRrNI4H1AibyB6XG4Ro364QoQpAwKZwGoeaWV7Hu
 NxZtZvqTtVTLjfS0XlmzJV/gXaWQfV81bne0yhi70GTxEUov+KTOiWXjiS57LSzNZP4OkuDKDYR
 NEAh274z2TcX/2CPh76Pq+aqVICvvE86qfZ++EOWHuczmK07isZ8dQK7+oyGzyKfhM/zBvFyoRX
 A4gHamkSZAtu4u33jr1S975jziZ2yPvblOXIJBLsBA0O5i8nI
X-Received: by 2002:a05:600c:630d:b0:4a7:a309:6b73 with SMTP id
 5b1f17b1804b1-4ac150b2896mr332035695e9.1.1793782351277; 
 Wed, 04 Nov 2026 00:52:31 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:30 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 32/33] board: engicam: stm32mp2: support FWU A/B bank bootup
Date: Wed,  4 Nov 2026 09:50:05 +0100
Message-ID: <20261104085036.4012238-33-dario.binacchi@amarulasolutions.com>
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

Enable the FWU multi-bank update. The FWU metadata are stored in the
boot device, so point the "fwu-mdata-store" property to it at runtime.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |  6 +++
 board/engicam/stm32mp2/stm32mp2.c             | 40 +++++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig      |  6 +++
 3 files changed, 52 insertions(+)

diff --git a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
index feca4e7d5f26..a6d81e309f36 100644
--- a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
@@ -11,6 +11,12 @@
 	config {
 		u-boot,mmc-env-partition = "u-boot-env";
 	};
+
+	/* moved to the eMMC, when booting from it, by board_fix_fdt() */
+	fwu-mdata {
+		compatible = "u-boot,fwu-mdata-gpt";
+		fwu-mdata-store = <&sdmmc1>;
+	};
 };
 
 / {
diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
index 51274f6b9dc7..5f2db3a53146 100644
--- a/board/engicam/stm32mp2/stm32mp2.c
+++ b/board/engicam/stm32mp2/stm32mp2.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <event.h>
 #include <extension_board.h>
+#include <fdt_support.h>
 #include <log.h>
 #include <splash.h>
 #include <asm/arch/stm32.h>
@@ -146,6 +147,45 @@ int splash_screen_prepare(void)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(OF_BOARD_FIXUP)
+/*
+ * The FWU metadata are stored in the boot device, the SD card or the
+ * eMMC, so point the "fwu-mdata-store" property to it. The phandle is
+ * replaced in place, since the devicetree is already in use.
+ */
+int board_fix_fdt(void *blob)
+{
+	u32 bootmode = get_bootmode();
+	unsigned int instance = (bootmode & TAMP_BOOT_INSTANCE_MASK) - 1;
+	int node, store;
+	char alias[8];
+	u32 phandle;
+
+	node = fdt_node_offset_by_compatible(blob, -1, "u-boot,fwu-mdata-gpt");
+	if (node < 0)
+		return 0;
+
+	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
+	case BOOT_FLASH_SD:
+	case BOOT_FLASH_EMMC:
+		break;
+	default:
+		return 0;
+	}
+
+	snprintf(alias, sizeof(alias), "mmc%u", instance);
+	store = fdt_path_offset(blob, alias);
+	if (store < 0)
+		return store;
+
+	phandle = fdt_get_phandle(blob, store);
+	if (!phandle)
+		return -ENOENT;
+
+	return fdt_setprop_inplace_u32(blob, node, "fwu-mdata-store", phandle);
+}
+#endif
+
 int board_late_init(void)
 {
 	const char *fdt_compat;
diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
index 9fee56512488..0c71d1a48db3 100644
--- a/configs/stm32mp25-microgea-rmm_defconfig
+++ b/configs/stm32mp25-microgea-rmm_defconfig
@@ -14,10 +14,13 @@ CONFIG_CMD_STM32KEY=y
 CONFIG_MFD_STM32_TIMERS=y
 CONFIG_ENV_OFFSET_REDUND=0x940000
 CONFIG_TARGET_MICROGEA_STM32MP257=y
+CONFIG_FWU_NUM_IMAGES_PER_BANK=3
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x84000000
 CONFIG_SYS_MEMTEST_END=0x88000000
 CONFIG_API=y
 CONFIG_SYS_MMC_MAX_DEVICE=3
+CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
@@ -25,6 +28,7 @@ CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 # CONFIG_BOARD_INIT is not set
 CONFIG_SYS_PROMPT="STM32MP> "
 # CONFIG_CMD_BDI is not set
+CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_ADTIMG=y
 # CONFIG_CMD_ELF is not set
@@ -118,3 +122,5 @@ CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
 # CONFIG_UBIFS_SILENCE_DEBUG_DUMP is not set
 CONFIG_ERRNO_STR=y
+CONFIG_FWU_MULTI_BANK_UPDATE=y
+CONFIG_FWU_MDATA_V2=y
-- 
2.43.0

