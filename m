Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C21606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nrbkaOz8;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=oRUjFn1E
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6241080AE8;
	Wed, 25 Nov 2026 10:59:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aoc-JPVU7Y-B; Wed, 25 Nov 2026 10:59:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A88A780CA4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604341;
	b=g5nhSRmLOEf2p0rpr/DiYV5iK0OLolQgrsjBvTSl2/isKej5Mh6bKvAVFKQwmGLIQyMQ
	 Njx+vH+Bo2DHeWEIk2S2vOIzMW2dyGfj8ydC3l/5mZwLrCwKQIhqTkSwES4j77ZG6402E
	 BtGjnRC3RIzh7403TmYiduvqvp7nI52U1MF9rI+JwNmMZsnPNduGrNj6XMa/242fom3yd
	 9oWL78iyhFMSNnLHzL9/T9wWY6OEMbgohBiZOajf4hkmg6STxvCTciWhJnNadHaTiLxB9
	 1yzXyfPRPJd/eEsMNsbOTmuTxfcvP1OAABUxghqiIFJFvLLvHI9It4YtbFGqPVHXOjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604341;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SnE+EftWJvAAJDP2mf7xyHcEw4ZpItkf9DSr3Ky+P4o=;
	b=TwC0PvUQmVSbjG/JwyKTsG0+D4y0P0iSro+TN7tZ1iq+kZedArnl6NwCv6DKxhv6e8RV
	 25PU225fWYp2Tq3lWFYV0p4pq98zATrlExKVJ/05krZL5wEbv7s+h60I5Ap7tkotwcogE
	 9+EGfG7Td6X0oDPMnqOLD7qBc2RXuMH9Kt2atC5nk5v8LJDRYOAqgFbz6ZYBpDEyRH6Ii
	 WuqyInDP75l/zRg48SJgHiRGBMi1vphstwhbGEAKp6OO1E66EOXimMV/ejlUR548O2S2+
	 tVkh/Wo74p/NKL+m8vwMGso0jbJoXkQEibCxD9sjmv0u7Emij+hDqqUD7oGBZYiO8Rg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604341;
	bh=SnE+EftWJvAAJDP2mf7xyHcEw4ZpItkf9DSr3Ky+P4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nrbkaOz8+ActlFCgzd4ywW500Aam8x416SaQmolyvr9e/4TRvz55drQsgjbRWCwg2
	 At70F1KHb6o2kmaiWt+SNg3CZUFurp97xWiPqlIChvlLo0EJXN0OPQI2bSHN6N89UM
	 2heJIUJGLSFU3ffakv8HLOO7CGXsn7VGj+59fdcnU9SzCZNG5dXqIgspMMwoQxm56b
	 asgU6K3N4yMmCZ0qm8OGAOhEqg7PtYoJLius6xliYjdcwAL3mIoINOWsk04lninc7c
	 cmY3EILpqcOCv+7dY2bkIVadLvPOY+rnlO8sRie0PxPCvOU9/0pEttOr1l+h4ru0rM
	 ueraNxGqC+UJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A88A780CA4;
	Wed, 25 Nov 2026 10:59:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ADE8325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CD39405A7
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DhJqrXLKkgbq for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C86840549
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=oRUjFn1E
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C86840549
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:42 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so4572394f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604320; x=1796209120;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SnE+EftWJvAAJDP2mf7xyHcEw4ZpItkf9DSr3Ky+P4o=;
 b=oRUjFn1E3sRsIumKbAdkOFgj0D4ksWEcqvr/OFY7OhxceQTe/oG2pAPZF9x5og2rzl
 GyPj4TwVXLyaUXgLmKLFmgOy4Fh1Iiv5VTcCpUbx3fgo3KNVrk3DsQgI9gPVelc67SXy
 pcz8uQmTE5/hVHp0f5G8Hb7t+8xcQgTrWSb9E1Stz5QhZU0zovPikVKaELEtG42NoJWH
 ZlmoATYD1BxGsPrQStTzsZcGlflV0ksq61An9ymTSoWleM2eNWRPUgmJ98gz+k+GB5/L
 Zq5V/J1yU9G13HxFBU2kQyAo8IY9Boo/xGsIwHbk0e4KIphRPzDTsUDnx2mOTeae6Z4e
 O1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604320; x=1796209120;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SnE+EftWJvAAJDP2mf7xyHcEw4ZpItkf9DSr3Ky+P4o=;
 b=jPWjtktSiyxKffGfcyum7h4uVzti511fG93yBaLh5RZbnA1+71I/7SUNpX9H6cGfNi
 I+hNOsKyRQoGUzluqZBPrMFWnSPAAiYEuWzeu6vdMIBCS4YFJy7cuGEfbrjKXV7/Ycoj
 0Iyx2O/SEjKdmcNM6KQSsKjgqTrukW9Vh19POGJFZ+SmVT5x7cnu9zHciG1suULaTukR
 b50YhrKyJc4bylMz79wZmcaIuIZtedknG28x2B6wj5ZTOj2OIrNCb7i/JADRACKJaXN9
 v+TjGhBHbGok4j56DCyxJWJw7S5j2xWcECykrHDYZwP2xLLyozES/ZwS4HXPgulPonBt
 cg1Q==
X-Gm-Message-State: APuU4Z9MqNy/gAYOr626LhEGvciVmr2BOd0TKbcQ2mmlXGm0GvePMOrD
 qYM/MTVeFMq4MXAuea2EQfj30Sf0G+/4b0qLc7lHdgUqO2bQ9QXqj8HaUYtc3kLVq4ZZJF3zEhy
 2+dCXQAckOw==
X-Gm-Gg: AZFdTZfnLmv6Si+/nWnLvGDDV/mqh8T8z1kaPy8Axz2Aa91/wIoiZfxFmRlw9TBrkjU
 JTL0V3I9gz3GOMir6USM+hrw6kc9fpcUWRDMEBP2VxfZ0X9OsDi1L949OLVKkwk3mFSyr8wCuMC
 rJsWi5Tf4xnhs5TGCfYRlUGTOF4/ckgsSX5G6pPGiXhhRraRCS7hn83Wjlnqq/3PuS+0i29rXrP
 dFm4S4rzWGfXnpQOxK/1XBbUEqFybQYOkoN1vXU+5YVXrhzuShNFm9NN8W1wJrs5IcMmrKjSPl7
 Klh1pwENjAqv/1YB1ymK+ZNqAZaeEdxD/fafC07z6HK6e369xUJPqnAFZavyNO9YPpnvByL1qJ6
 KVcSGRPrrUhiDnSTi198yMzaqkLo8hdE+JRLbVdtzioW9Zzh4AwknqHiZ8Rut/jQl+onf//BI32
 UZzm6wuL067fXNg1qzbHo8O4GVWq348zIAggor6SL9eRjBjM4E521TSPJN1HJDy4QHHisrbOvJe
 N1dhewm2sBp8w0fAGDBJ9FsAVITQWWLbQuQ2ruIGw+YgKqo5SbaHEPalvloeFEFrxTDkbx8XtKH
 AFPb87UqIiYpF1gUhXGyJqBjA9c92s0NyYDMix1eYXB9pLv1rrw=
X-Received: by 2002:a05:6000:2201:b0:4a8:663b:63e3 with SMTP id
 ffacd0b85a97d-4abaa976b48mr42671795f8f.4.1795604320529; 
 Wed, 25 Nov 2026 02:58:40 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb98b4dsm34179826f8f.53.2026.11.25.02.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:40 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:20 +0100
Subject: [PATCH v2 11/11] board: renesas: gen5-cm33: Do not set the PHYCNT
 HS bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-11-8d31a33a54d2@baylibre.com>
References: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
In-Reply-To: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Fiona Klute <fiona.klute@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
X-Mailer: b4 0.17-dev
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

rpc_safe_setup() and rpc_boot_setup() set the PHYCNT HS bit, which the
hardware manual asks for with DMA transfers.
U-Boot reads the HyperFlash with the CPU only.

With HS set, some of these reads never complete and hang U-Boot.

The RPC driver clears HS from its first flash access, but env_get()
reads the saved environment straight from the HyperFlash before that,
for example for "baudrate" in board_init_f().

Clear HS in both setups.

Fixes: 9d47a5a4d560 ("arm: renesas: Add Renesas R-Car R8A78000 X5H Cortex-M33 RSIP port")
Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 board/renesas/common/gen5-cm33.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
index f532daa16d5d..38ad2c745f2d 100644
--- a/board/renesas/common/gen5-cm33.c
+++ b/board/renesas/common/gen5-cm33.c
@@ -1014,7 +1014,7 @@ static void rpc_safe_setup(void)
 	writel(RPC_DRDMCR_DMCYC_15_CYCLE, RPC_DRDMCR);
 	writel(RPC_DRDRENR_HYPE_HYPERFLASH | RPC_DRDRENR_ADDRE | RPC_DRDRENR_DRDRE,
 	       RPC_DRDRENR);
-	writel(0x08078263, RPC_PHYCNT);
+	writel(0x08038263, RPC_PHYCNT);
 	writel(0x21511144, RPC_PHYOFFSET1);
 	writel(0x07070002, RPC_PHYINT);
 	writel(0x00000155, RPC_SEC_CONF);
@@ -1032,7 +1032,7 @@ static void rpc_boot_setup(void)
 			RPC_PHYCNT_STRTIM_BIT27BIT17_15_MASK | RPC_PHYCNT_HS |
 			RPC_PHYCNT_PHYMEM_MASK,
 			RPC_PHYCNT_STRTIM_BIT27BIT17_15_MASK |
-			RPC_PHYCNT_HS | RPC_PHYCNT_PHYMEM_HYPERFLASH);
+			RPC_PHYCNT_PHYMEM_HYPERFLASH);
 
 	clrsetbits_le32(RPC_CMNCR,
 			RPC_CMNCR_MD |

-- 
2.56.1

