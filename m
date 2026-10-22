Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C995606A320
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IJsRQZTE;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=m3cCs3+T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41E8481226;
	Thu, 22 Oct 2026 10:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l8mr9iVtRN1Y; Thu, 22 Oct 2026 10:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 850FF8124D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792664166;
	b=LLcaIdoKQoULDOMKo8wYVbrIp0YCAXABSyhqQ967yLsS+bEPTibxROdcKyv6SfoZIgT+
	 QyP5PFNLKmTdy98iHxCbh+RBz8j0qzYanXU58MiGpAGhWEk9DrEyKovTX9YfgvIrwWRit
	 xezXxNuHzCWvCtpKsbqnHQbMtdqgnZJabjtXwpbKWAB409IFBWh7aXxVNC1Q9ZIeD4HuV
	 7LhkxK/KVq2+p/ntEOvOn5pXuQDfxkV27D0Y/psLz60HjJv4yRWjR6VuHsDKYOdC10U9i
	 ggkO3kzStnhPWklkPqLLm9c9wJg/r35fMrNcJXiwU8EtaLu8lKRD3LyhAqboZT/xwpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792664166;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HzC49scBJziNeiVP3SRwbg218NcP3ZX2FXqaWdcCV0M=;
	b=LRhdLzIobYtzBHQxARICAgsPiU8yaiG8LFyEseyc/+xkNy5/WXFKvJgs0VcWHl8aa2Qi
	 Wdtrw4U0ANFBQ3gcFrErHE9NUdTzc2oxu56QhdidjSDO7leufVFynwxavrU7IzFD0clfD
	 M7os8yYjXHRwE3XWsAIs7Wc2EObA10spAju8Zwy5bOM+RYF3q2+tHa9PJ8nEMqgfHKa4F
	 5Lwegbb58UuahbvIF5KQxzOk4Bnom/DWIewwCY6/UyipxPkM/R3VZzNQMK46QBUjrl613
	 PsMdBryVzliSN19MNsIBHRljGxWuEk6x/Cw4MiSlOP+Qqvf6827kDseVKx5oIhmQWrw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792664166;
	bh=HzC49scBJziNeiVP3SRwbg218NcP3ZX2FXqaWdcCV0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IJsRQZTEAsrahPJ1uYO6VQsV7sc4s7XZa/Je0QU56valzH3QffXYE0OzXdFDrB9GN
	 7ZDJbGKABbCm7u41Z95ojaZwgUl330iZdABfVjVRPA1+DEbmg1nS2HuX/46QMBOZfz
	 UEcnMn0DrGp48Wl0IwsaQnEK8mkydw6zYTMiFOMUPbdjL9ZBEQxnPjXdMWzzwC41BV
	 T9sCp2mWHYG+qIUc8PP+K1o7EiMaDdih21ZxXdfwiSn3qf7AnuPvyARZoO5F+Wk1Qt
	 /aNa3jnET5swP0lb2W5mESSAVTucfuAiUyGLbj//Bsy+p7MeMjzqvYCbHu8H9iERlF
	 +NIfElsOf5biQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 850FF8124D;
	Thu, 22 Oct 2026 10:16:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 058FA356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F09A940409
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c5CVH8KAFRNW for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:16:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B1233400B8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792664165;
 b=GXrf7OwaJHUC6YFG+RCSua5YC/R0MWRG/hh5sFv4H1FFMvQx3+3btT9dh4viAvOWBj/d
 ZANtC8ETA3sVUZmMjnnrr/DeBeXcxFMXpkJsFyksb+osQFt5xWpmhnBWdDKcApq+px7zb
 YNPxhTNgdmFT20yj53B6w/nodYKt7Mv5sthl0wlUsPK8BoMtXMr0rrftlR0T0f+SAXrtl
 ShREYbbV9KPTv9/unBxWYNgiw6m8PDyONcr7G2K4xi1jshBNiWNHAwe+VUx9ThT3Xk4tz
 LdnZtYY+WxTEVuPydxcMSkagEVlOGV2IuHEkt2rw4BP7+jQyQmqvkaiwmuT+p/Hvp1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792664165;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=HzC49scBJziNeiVP3SRwbg218NcP3ZX2FXqaWdcCV0M=;
 b=ip8f5e4a1CL6eRwguRWpCDy8/ZbtW3FFGT3nAyZPGXghZHhNyMf12lwwIy7datH4tjl9
 1oxrMG9rDaMCTrZv43cI9rMyuwvf0gD2Sj8d80WPR8N876XpInmKKJtE6e2qJjT1XI5ME
 DXvpZHS2S0iHNPtFbx1if+BjHUXLVOxxRkcjUUJzOqEmCEdPnuwSF5PCvMaoZin+BX8fQ
 F6dUjNwSR7SPS5OSTjYswZ+4ax1AzYFHaN8e52i/yr5mNrtJJbSBcIbdBFwWXrhwWF8Is
 3gjMtc3H9WT/+TQxSdF32M/RZWxr0pvIRRaMFOqqqSK/pzRvW3lnZ7cwZVKLT10fFyw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=m3cCs3+T; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=m3cCs3+T
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1233400B8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:16:02 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso1054093f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792664160; x=1793268960;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HzC49scBJziNeiVP3SRwbg218NcP3ZX2FXqaWdcCV0M=;
 b=m3cCs3+Tezh8SpifGDr+ZR60WixrtQiiJjcJ18ltMh/D8+KAWCvdjjP1C+/Ki2pMur
 JmceYfniwwAsVL9gjcY+ElhyICIsX49B6dEn9EkQ/yUWNku9l2Wc3YsKmnwd9p9aNM7S
 IRHHq83NTauoKlAJKyQwh47Z/od8c+ialO9XVc5DXC36N0r1x8D8/mvBAqqBHftwjvVV
 yGaDIIPE4RTXY8mJIqZDXGrlG2tnB/bcF2OdXfopkXAY4niOfQf4empSzAdmUEcuSbdB
 zbk17bolrDrpbIlpWOyupS1Lhm+Vbj2379GDWbXuekWrOQKYLyv5AipvSsSFDST+1l5o
 A0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664160; x=1793268960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HzC49scBJziNeiVP3SRwbg218NcP3ZX2FXqaWdcCV0M=;
 b=S5WANZ2zliVIzuCkJ2/tS1fzYEqcXcAGxvgp8bfgYYBqRHFfrm+0UDHqHiVK62DPOz
 ItTlAbXXQW6n14kAJU+tQPszCPcLXmuZHmYkPGiML04RaBoqdu3SfWk47++zhRacf8X/
 Te9pyXVVjTgePLy1+/b/o+6z3x86Dn/LyQKKokPYdcRhyyRyIzASibwt1Cecba2nvrfM
 MRi9z4kugw9PqyqXeAGTIj5NNE3PkmtJQhhAu4Dg5lZQpZUiigaEJjKxbyYmO/H0TLLG
 NNZyiS9FnDycrpf6nIrIKzOhqqqUlM8ZhNdATDR43f5G2nWNFWzl6zvYAI96jEOQr8kt
 5kpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbHwPyV27TbRtz65dYgaV4t6Fn6G1VY+DrOCAMYHiSjKpb7XhlmmlHd/DVyLByrIoGnBIo+Mw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ67ng+477xsUOSa6KC1qx28MDABcwuwFNHpLJhdsach7dQCa7g
 yFPTZZVrzdLv2FD7f2SdA1L0U6HDxhPERT5rWi0EyDrpX/94kD4Bpi8vjSnxc3CjrfU=
X-Gm-Gg: AYBFou2vdQAOW8dtBk55Gb6bYelM8xs/1WMbrf1DAdiHjN0aJEUSyWJOzxHjyZxp9/Q
 5FeHNEH9uyXfxWt7IzdqF67aWu09Mq9E5C/oNd6nUyi3HzInLGpb9VXcub8d9ZEZg2mqMnLtcSl
 1/4SoR44Yds4VDGKAhvaXAm49SOLeCJUKDzOME0GNCVtWqpVjKvwu/kLBeSt03KNWaB8XFWu67o
 oEV1audGBTtie+ab7QqX07dQTzolDtQNvEyYyEYfA4RT/BUCyXCSGcXtkmookUCYYXQLeY+7ZwL
 bU18AtPN2paIag/Lu2nUfXg6/Me5x5SxL2rRPmt9xqDDc2q0IyVCP33GFqqWX//K47tZPLnpLs5
 NYL97P2cP8f6eRmYl/LGGfv8GKTfm3trG5fa3VEawH5ushBDMs4sguLIuHk96NbIBsO2WBNnyA+
 4FjpTW9AoHuCPIiw2ZpmYy1BSPGsmODmd5gZo+kChItgYHyN8N8w5WBqXkqKE0Myb9+JgswUiUD
 8u/xDHRI06YTE/Oio1pGycOOJ1f4xLWRw3qgYfGrT59umf3qDoSEenBs6NfTR91d9zsUK2t4RAe
 5Q==
X-Received: by 2002:a05:6000:2689:b0:48e:3fc:e393 with SMTP id
 ffacd0b85a97d-48e26423766mr10693555f8f.6.1792664160597; 
 Thu, 22 Oct 2026 03:16:00 -0700 (PDT)
Received: from hermes.tailscale.baylibre.com
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583ffa8sm11693939f8f.51.2026.10.22.03.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:16:00 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: "Kumar, Udit" <u-kumar1@ti.com>,
 Richard GENOUD <richard.genoud@bootlin.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH 1/3] arm: mach-k3: common: add helper to wait for TIFS
 initialization
Date: Thu, 22 Oct 2026 12:15:56 +0200
Message-ID: <20261022101558.2474326-1-msp@baylibre.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <51c23f5b-9ca2-4ebe-8f3e-72d22e404617@ti.com>
References: <51c23f5b-9ca2-4ebe-8f3e-72d22e404617@ti.com>
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

Add a helper to wait for TIFS initialization to be finished. Effectively
this is just a call to get_ti_sci_handle() but I think a separate
function makes the purpose of this call better visible.

get_ti_sci_handle() internally leads to fetching the TIFS version with a
message and response. TIFS only responds once initialization finished.
If a response is not received get_ti_sci_handle() returns after a
timeout.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 10 ++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 6e382efdb3be..480c90cfa65f 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -54,6 +54,16 @@ struct ti_sci_handle *get_ti_sci_handle(void)
 	return (struct ti_sci_handle *)ti_sci_get_handle_from_sysfw(dev);
 }
 
+void k3_sysfw_wait_ready(void)
+{
+	/*
+	 * Wait for TIFS initialization to finish. This helper is used to make
+	 * sure TIFS removed the firewall before U-Boot tries to unlock CTRL_MMR
+	 * registers and continues the boot.
+	 */
+	get_ti_sci_handle();
+}
+
 void k3_sysfw_print_ver(void)
 {
 	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 37ff98d89924..146b986febc6 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -38,6 +38,7 @@ void disable_linefill_optimization(void);
 int remove_fwl_region(struct fwl_data *fwl);
 void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
 int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
+void k3_sysfw_wait_ready(void);
 void k3_sysfw_print_ver(void);
 void k3_dm_print_ver(void);
 void spl_enable_cache(void);
-- 
2.56.0

