Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DE0CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E1CE409F4;
	Fri, 16 Oct 2026 09:06:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KL8pitKz8rfC; Fri, 16 Oct 2026 09:06:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 477FA409E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792141596;
	b=IqxWgnUtcgar9AmfcpaP4OxzafRxDOa6KtgvQlM+8dIP8bJhnA3bmPMLQ2sDMXkSbZDg
	 Epj/ONVaBOZ/vhP7Q6t+IBHTZZICM1CHtN65Dlrt3GzvYBYNM0EUrLLw9fBxheiUG73kF
	 05ZhclgMRKClcgVRDF5uRMaoN8L+BMTbfSq1FjLPrxGmbVSqdGNuNU+vIzZm5GvGql6nF
	 BgNpm/ATSK1Rs8IepsgV3CDxdkZTL4LTURv7eQGU0PkxWf1xzmSwLTZ2lk+8lj7M0Yzxz
	 v7cve4RENWYcb4uglWeV+3uVPudQdmIDTt25zbuTMXLHoDchkRqP+8lEbPDa0PELxmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792141596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=07BT0oh+46yR+W1hGGcdMTVoExjI21f3Lncyal9KDP8=;
	b=SC1PB7jlwJWnnXp4VzwfPljhtevNZ4UCC3P1ZNPfTiBd1aTHz3UeZosaz2RIqiqF7/LM
	 cgSvqQaVIlkjyc2F+LEuMsJbQd7AjB5JT3ox3JIF92RkSQ++tXPnM8vhmsargksVzOKOf
	 G0yqzYGVgGyFNfZsjAt9PNdSjbQ4U3GR85kh+Ut1ngqyGowFZzpvmYALvJnl85a1Mo0IG
	 /BFhCjxLOIchKTStwko33FGiCYlciaAkGG7vUmITFNffomIkApQx5iYLmjbJntmUy1hQy
	 5rY9uHzIRikce2tDzSdG9YPB8crJpPFqVUVBSdthwjFREIFNEyJHH9W2RUvtE+5fAYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792141596;
	bh=07BT0oh+46yR+W1hGGcdMTVoExjI21f3Lncyal9KDP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qWiDP+OZc77kp3eozhX52myyYuBSScVUw1dhtAJ3sX4gBtRi1Mb9G5YnyX/bmO30V
	 zA4A21MBN1LGFkKZFVffnU5McAqz9Of2Y7EHnUgV540rhV8JEMvIvbw8sxvfSJ+r5L
	 wz4NatSwkfX39X5O88qcYsWQWDwbZ8RCguh6ajr1+LY8ZfW7gQ9v+gdMnSTQEGcgdx
	 1rS1gh9vaqyVrm1bwc9noZN16WKCgkZYvUWENvFgSTWzF597UgrM4j+hNyBri95rZK
	 yUNogznre24HcCXEWJ3RPceKS9D73Ebyv0mf5TrUeVAfowd8mgyUx1rsIpHH7hQv3J
	 mAakviTyNt+nQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 477FA409E8;
	Fri, 16 Oct 2026 09:06:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 68EF8920
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B2EA40100
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1xHJNUwsZtqD for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E84614022A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792141589;
 b=BEr4H2zEgo/n2SlQxuvhdqPzXM9F8qi3Irp04EizjGe2pEPEth5KPMfSSKseBO+AxAcY
 rdb6ER68dKHBncfpmCmvTek5nTEZoVSck9SEu3ooxDh07LqHJ/NJkmtEGJe4moh1B1l+9
 OVPm78cGPDwLGZf9+3SNbDOBll1098mIuEkja6MchF2IhC0GJRR/VtR61LriEvMWSN4Br
 2hSyTdis3PKxE0az0vWGjJF1YFUuFMOQDOlHFtEUbYg3lTeoRp8S0/auGPm8kiRCPrrl8
 j8txQ2AQpiBLqx0NCoSq/M+WxP1tIFJp5ypCwqSDLnXS7WXSpgqJTzH8hTuSWacgiEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792141589;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=07BT0oh+46yR+W1hGGcdMTVoExjI21f3Lncyal9KDP8=;
 b=FXSkZgmWJmGOi+cEvJFJwWsvppbXQyGmTta+WZRoCynno3rl2VuNaNnrSDEp7f7ZlqBu
 AlDYHTB8mD3Sp8lVQzolke5OVNPd9xsMsbv5NR4/Y6xmkU6HuVymOSEhOGKwMR+WQjDvt
 1gERfHWK80+AMuYgSIBHniAz/7R1fuBhIPgaqQo5OxNErds23MUU9zZUrxVyuN3md7pD/
 6BI+haDNC0zWcbjfa2kuK22207cXe5LNQk37uTVzGCV8Oz0X8nfsreRr3ICQT4q3/ilBj
 GIEYOqzqaFPvuLd1O3+F/NLUQhT4ww563PE+qacET6VKo+AM+4dKgrFzDHk3w5Th8HQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=psloRTra; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=psloRTra
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E84614022A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:28 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so43752355e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792141586; x=1792746386;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=07BT0oh+46yR+W1hGGcdMTVoExjI21f3Lncyal9KDP8=;
 b=psloRTrayXLKAfPjTCDGxWwtuMEBWVs6AgEdMF5Ev1AF3TSAuerup4t8B95lXwgods
 WUKi2+PBNsee/MpA5d1XblXDfbWGBDLwLEYZHdySuGM6QBChkHm97Fqb7FA9Nq/i98ar
 kyaZxMMAEDruEx6hW3fC6FxljOPofddH0UUvvmmpqM6hU0utJE+/Pb5pA2LMxHYZ7mdg
 e/ADM4DCL5hRBOxDy8Uqat/ffWfZWeARaMNe+lueNXY/bPVlGrPI0AGnYNtWvExJkxYk
 IeHgF5lWerckaLEyML4ySlaGYl4KZNUzZzITuZs+dySGouuTcG9xt7lU4OsozKRIvqy/
 DCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141586; x=1792746386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=07BT0oh+46yR+W1hGGcdMTVoExjI21f3Lncyal9KDP8=;
 b=nCTp5ZihRlI/YeHa9FghZ+3BUNA8hXjRXCITucxH3cHm5a4UssadIZg6rMLADfxNox
 BKXgf90ii6N6DUIui8H7CMkMrIHKEjHDsZGqhbKUyQgjvmbxWLct/VcfRK/71aXC21wt
 dotSK87ZxarvorTak80DP0mk3XtDx7JctJZ7jgioeCBgoEs97Mrwph8oF6EbhoN6jdg5
 +LuEpdyEQyxB9QNb1IKZoaT85H/h+6aMjqSgIIXB7iO1D8QEhiGYe/tEmRwrl4MTJiOr
 sHt1mC6khZt3MwADA61z2ZQVPklPNTJh6Z+qhUybY7JBWK3wVmc3HNBhmppua+lr9WTw
 CMpw==
X-Gm-Message-State: AFq9FYILkK8mNmbqufAO4Zr+wnW/CapiAMsK62YqVFjcYRNUOQYe0rGX
 oIfzr5dxXr6ezxup2pdeQwAiWn2k7c4OepJfavfyuGq6GqdLVAVg/+VQ4hgyiKKQ3GQ0G2vVctF
 P+1tE
X-Gm-Gg: AYBFou2ZKMpSSpmiistX+MjBShthBwZCfh6LeVy4OpalLjfR1qglxi/q0KWWEL7LK5x
 6ineurr5DcS6cI7ZUMSkvsy4FnPBBeWnvg/Gyzqefq/gtuznQ9gixIPkVFekMkbc0/yML0rJDiz
 TgYDHEepdDRcvX5RGiHdVC5l7ZtfuvdnEXJgrRAcVIKShF4QYAae6/Y4VezMa/NrAXhkEVtdu0P
 jv92c5gEWQhRDR/M19/eSpQ/WOJOicKGnxfEtKzPkykwMWh9jApra45RIC8dfSK2Mx9yaG9Ial/
 2RF4Y+pDdc4GJTZPZcIa4VSpXRhHvcE/tAIb5cLcpKM82Ft7xUkIsjG8MbJYyRvT47xNLd+lqEf
 3J3neGisvHiACg7sOHIMT1mKf9iFO0xlF49jKnvtCr2Zv8TTbF2DLWiqgeBG7v/awcVKVEUkfvd
 +fmtCQKD1MHlSS7fidFbrBU/mi7ZDqyOz1CmShDjKIqWt5Zf14fN+j1jCJ5tFsZjO6wCHr7BWAw
 egjViDoerkm5OM=
X-Received: by 2002:a05:600c:1c19:b0:4a1:d1f7:bf4 with SMTP id
 5b1f17b1804b1-4a1d1f70f91mr14590735e9.12.1792141586038; 
 Fri, 16 Oct 2026 02:06:26 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm121287685e9.0.2026.10.16.02.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:06:25 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 16 Oct 2026 11:05:53 +0200
Subject: [PATCH v2 2/5] arm: mach-k3: am625: Wait for TIFS initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-2-c7ab53f79b34@baylibre.com>
References: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
In-Reply-To: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=msp@baylibre.com;
 h=from:subject:message-id; bh=f/I+IRDh1Gee+z8j8hOp871bB9mcx06hVzsn5jkrD0o=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyLL/5O3fgljiVVLmH9LuX9q9Ou9D9QPd35JY8nIcKFy
 5vTQfdTx0QWBjEuBksxRZbOxNC0//I7jyUvWrYZZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jBi4OAVgqlu3Mvz3vWi+scZ6GWPi4ggZsQOrdkovz/nq6POKM/Tu7wtMC67LMDKcV1nwdL9
 2K4vo1NNqCSnnmEv/TbrfZlTvYXfYdvpN5WeMAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
ctrl_mmr_unlock(). Note that spl_early_init() needs to be done first to
setup DM.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/am62x/am625_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index decb50bf853d..9358f406ee21 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -158,11 +158,12 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	spl_early_init();
 
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.

-- 
2.55.0

