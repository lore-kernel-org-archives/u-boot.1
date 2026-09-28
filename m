Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39028CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB1F680E1F;
	Mon, 28 Sep 2026 13:42:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4dAs_1QX7M60; Mon, 28 Sep 2026 13:42:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 83E9980ECC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602942;
	b=JvHpGHecEaAx3ktquHzI1TA2omIR6FcLSmlfunuKthQfDIkEPwW/d694c8n9Slm2AYik
	 L9VeoWOW/J69MKfXpvP9swWGM0sTHDWEppzgz9sdXflGXdtiTOjkp5YM9HfYYVjXZX81D
	 f7YF/H0MqM/twEeZRE91oxzTVpmapgYK2MDO0sbbzmaa2iYWcoZlEPPvW8I58K//4aLF7
	 SlHiJ2I7M+S0G82QVMYVBUnpvMeH6FXaL052IjMFOB7RIwN550zMwRfb1kvi8my54sj8k
	 LS2dUOXCyBsMTIcypK+8cPTV+WGzqQfQwu+h6K+LSKuSGkq2p4HOaSyw1lBampDl9nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SCt/C2sTgG0T7j0PtmxsAXmfAiAylZxGVv2p/iY5S5o=;
	b=cRCu4h7z8aLSUUTUsGdUnyqHA/xhY+DPtSGiR4v7bsEZTA+ck/BShYWcRVwWVwZnBP3d
	 cK9EBvxitGyc4Z5ykw7rgql8DHiqTCNBImkpgCwx8UmoGxztv3NyRxbu8AtIMwLt9hN3p
	 A1rbeHf4Lgrm6GTJaQjOa5tzbYqY3cyzaGrtvJKYUdxso7Se9OkbF7Ebk/F3JgY30soWY
	 KnU6SRAXgVijKIpAF6/TM4R1OB8vsp5663SX0+wPMiO0GJ+5qO7v9f04QDoeEEyoejfSv
	 DZEMwxlo+nkYy86aS3T3LkB/1/quG590JnjcpueuygCf1YoF1GcjBySbO2kn6pQ8cvg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602942;
	bh=SCt/C2sTgG0T7j0PtmxsAXmfAiAylZxGVv2p/iY5S5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJNxkaW+Z91Krh1NUXo+XtoSzrYdBqLotgHpIrOM4C9KRdWrxFiUriT0riiPi8F+c
	 S8KawlZC+cXKANMYKAFeUzDs2QVnIG/oZzCB9LEsKbkwClKqX+BJcVyv+c+HSNDFVG
	 b5byldKSQyZdVi9Zap77Se98xp71scYmxdZtHlIKJhQYNV5XmBKTDRFpl/xrESHtlR
	 0q9DPiatwzImP2wucRVeL7TlSfP7JPTD40ouzF/t6Z3ES+lHrHL10nLQirz0jcVkLf
	 5g+tiYVQJc0w1uWANR70sciUr7bQFpk9Y6qSI/hiTjELnzstnJ3yuv1M2J5t2No1x9
	 jaO/3f+TH+94g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83E9980ECC;
	Mon, 28 Sep 2026 13:42:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C00763D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B176160601
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDSVskQulEVi for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B29B5605E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593502;
 b=H7BHS8LizjipGUqMQP5BZIWWeJPorlPyyOcYKiqBKzOi3+8B0Fj7n8VLVvz0KAA38IFk
 V6d/Q+Po312PCt74Urlw0OE8SB+lSWEmsO5B3SKRASXa7juGZt/9RL4bCktFMa6pxvMhS
 Lx+vaabeA+m2NGQkWlSEC5Cmdeb7+VQUasXyXRJd3V8/Cqxd4monOuJ9wmMEY3WUOfiQM
 rpZRS2dmkxjvBe7QtR6SFhjFZ+DGh2G78WKhHkYPx98rLRDFC2l/sYbVaL4hC6kIUYPJO
 ymZm3nV1+FcGZKSZ+Z9NDyQsG7/9iSFjIMBwQLVZyB00IVoFigpp2q1ffZKCKASQ2Jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593502;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=SCt/C2sTgG0T7j0PtmxsAXmfAiAylZxGVv2p/iY5S5o=;
 b=ewDfX+LMWzYuBd1EM4mUfEodechKS+Syd87LdeeoMkhNsLA0MhN79t2u1IcFne6yAJcJ
 pgIX3boOsc8Frdnwmwdf5r1A/Ocd+eLr04ks/0ctCrc4BcppRt40aajMPMUzcu8QweH7Q
 Wm1A7Uqwtxad/SCv2e0Wsfzd3A4vJmq3VoYGAkAW6DPKOY354DZ2hBfGmtRmnIebosIwa
 sP7fqwZlWGpKk1L2HKj89j5PYPmAF+pKAsqk+4f6J4RhrPomBX06tXgZdQn5+9maO0skT
 g2yK8NdM2/uMmpZv/KrxLTBpdWZYpuM5zgeO2fuJsO4N905lnuzQGea9f2K8lSa/MRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="HCb6/OpA"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HCb6/OpA
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B29B5605E4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:01 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so13050245e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593499; x=1791198299;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SCt/C2sTgG0T7j0PtmxsAXmfAiAylZxGVv2p/iY5S5o=;
 b=HCb6/OpAJWesV+KqoKWeW1lDJGPg9hevqOZEj4M9H5l5kw//o4rLKaGUgpSt9hoK6y
 roQS7KQ4M6XtHbgrscb+3OSoPlU211QyBkbPSJwvaQenu+G/jjOYBMgtgkgJ7LONHdcg
 r58fO6FWM/cMIsIE3ctEXhEcehxQaeXI7qciRj9Bg3UdJ8hR/d+eBRETDeCpn7I1FNkF
 YYEtKztD6gvcVzF/xu7I/qLLVzZNMFJyxwDo11ATptcx5iSnw0+4+6bskjuc5GK9f4hj
 mRiBk6H8xZO6+9VJg5d61g0H0N3uGzQLCD9I/GIRZPtqvqmrF9sEAItaTc1ca0TEEh3Y
 Hm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593499; x=1791198299;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SCt/C2sTgG0T7j0PtmxsAXmfAiAylZxGVv2p/iY5S5o=;
 b=tdFIOMMwcWStbQDrKgVtF3i2UJOUbKCJ97SgkDj8shxo5KwR3HySaxFZ8ceh5sAGNq
 Vc2kCnQU+aNEgWa7v/z+X80q3tyO9GnxHPWnu5aWZ5bsVaOULR845JQnEz9g9ASOF/Ig
 PPsUaPxMVDt8w31KLuXVQ16y2H+S41zOfjfdrMVSvdWC9wynLw3fqxllmktkRttBwAJV
 Re1yHmbAZEo3Fzb7mtOMVotmSTxBA6LOdJosA4u5KZwP/5BlxzY6nI6cfPXUEpb5hHuh
 +DHKDXs6qHy/W48lOefzfBI0vg6JD1jF8ycbAGOzXW0iAQ7B8lWP65GlWbjG781GM46f
 3aAg==
X-Gm-Message-State: AFuF++mrit9UhpV1nxLLFsXDvP4SnsU1p7xNtrDKdHsw1cvu5LnuAz0G
 7fTvZBPz2tqDMtg/JooYFmGQu5uImWbQDSsRK3yoYCCDVHNJ8uMlGr4KvNibz9rZTiY=
X-Gm-Gg: AYBFou2vDghzVoYEmpPchUcffzZtFfboROQGPI5mhe9tG7BFBmtebIIRQ5Oj9nKuWfZ
 hA4JFUF2Db7k9RLKxFOrXrXYq/OuQWQ3kT1B1pS17GS2wZJ0nOCeKyQCR6TYBhnKBD74rGyvAVO
 k0J9O+BpBUOIiLhaBxjF6qfme1LqkGI6ALLHmW58hLGWojre8V1c6AxD5FwzWFrMtX8IBdFXCtG
 8xklOoE6Sy7X9K0tSip1zoivADg43mPYF5gXSO8nfFxIoO736oWkdaU3laL6ApiHE50UzB+Ljpr
 +7asMSAHow4vnrOvptO+/wqW9K5kRSKpe9TuLlSZWnKdkYCKGAx7tx9V6N2XoXFN/Hw9ccTXJgx
 YVE2jS7CntT2FFawKnwFZCbmaFF8HA+hKD6KLsrzu35D9C41VMwGl4PteL67sHELlSsWhsbRqBU
 gtdfrhHnH1lXz0iL/K+XYiPmRwfp86ffjEsNXCNE8HB22Ny3wEobtW0mFkVyphKw9A+lMwnX6hG
 KCrA5OUBWCwfbwetfwFG+qQbW4cawjhbrbmwEUtn3+FO3Ko1y6g7zdI7UWBl5nzUHnkuhkNDH/h
 w+jI1fiopkLkgUwf+LXOTiEd/NNs01J22J1eenlX78CKrOgYECg=
X-Received: by 2002:a05:600c:a16:b0:49f:eddb:bcb1 with SMTP id
 5b1f17b1804b1-49feddbbe6dmr183408845e9.25.1790593499010; 
 Mon, 28 Sep 2026 04:04:59 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.04.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:04:58 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 04/13] board: nxp: p1_p2_rdb_pc,
 p1010rdb: Drop unused SPL gd copy
Date: Mon, 28 Sep 2026 13:04:25 +0200
Message-ID: <20260928110434.70686-5-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

The SPL board_init_r() of these boards points its gd parameter, which
shadows the global gd, at CONFIG_VAL(GD_ADDR), clears that area and
stores bd, the full malloc flag and, in the NAND TPLs, the location of
the loaded environment there. The SPL keeps running on the global data
that cpu_init_early_f() set up in the initial RAM, so nothing reads
this copy.

The next patch makes gd LTO safe, and gd can then no longer be the name
of a parameter. Drop the copy and the stores to it instead of moving
the global data to CONFIG_VAL(GD_ADDR): on the P1/P2 RDB SD card SPLs
that address is 4 KiB below the stack top, and the 8 KiB environment
buffer of env_mmc_load_singular() would overwrite it.

No functional change: the SPLs and TPLs lose only the stores to the
copy.

Tested on CZ.NIC Turris 1.1 (SD boot, with the LTO build of this
series).

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
 board/nxp/p1010rdb/spl.c     | 9 +--------
 board/nxp/p1_p2_rdb_pc/spl.c | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/board/nxp/p1010rdb/spl.c b/board/nxp/p1010rdb/spl.c
index fc26cef2cc8..7c36026a55a 100644
--- a/board/nxp/p1010rdb/spl.c
+++ b/board/nxp/p1010rdb/spl.c
@@ -60,22 +60,17 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_VAL(RELOC_STACK), 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)CONFIG_VAL(GD_ADDR);
 	struct bd_info *bd;
 
-	memset(gd, 0, sizeof(gd_t));
 	bd = (struct bd_info *)(CONFIG_VAL(GD_ADDR) + sizeof(gd_t));
 	memset(bd, 0, sizeof(struct bd_info));
-	gd->bd = bd;
 
 	arch_cpu_init();
 	get_clocks();
 	mem_malloc_init(CONFIG_VAL(RELOC_MALLOC_ADDR),
 			CONFIG_VAL(RELOC_MALLOC_SIZE));
-	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 
 #ifndef CONFIG_SPL_NAND_BOOT
 	env_init();
@@ -88,8 +83,6 @@ void board_init_r(gd_t *gd, ulong dest_addr)
 #ifdef CONFIG_SPL_NAND_BOOT
 	nand_spl_load_image(CONFIG_ENV_OFFSET, CONFIG_ENV_SIZE,
 			    (uchar *)SPL_ENV_ADDR);
-			    gd->env_addr  = (ulong)(SPL_ENV_ADDR);
-	gd->env_valid = ENV_VALID;
 #else
 	env_relocate();
 #endif
diff --git a/board/nxp/p1_p2_rdb_pc/spl.c b/board/nxp/p1_p2_rdb_pc/spl.c
index b07f481fbf9..6db77682e3c 100644
--- a/board/nxp/p1_p2_rdb_pc/spl.c
+++ b/board/nxp/p1_p2_rdb_pc/spl.c
@@ -72,22 +72,17 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_VAL(RELOC_STACK), 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)CONFIG_VAL(GD_ADDR);
 	struct bd_info *bd;
 
-	memset(gd, 0, sizeof(gd_t));
 	bd = (struct bd_info *)(CONFIG_VAL(GD_ADDR) + sizeof(gd_t));
 	memset(bd, 0, sizeof(struct bd_info));
-	gd->bd = bd;
 
 	arch_cpu_init();
 	get_clocks();
 	mem_malloc_init(CONFIG_VAL(RELOC_MALLOC_ADDR),
 			CONFIG_VAL(RELOC_MALLOC_SIZE));
-	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 
 #ifdef CONFIG_SPL_ENV_SUPPORT
 #ifndef CONFIG_SPL_NAND_BOOT
@@ -102,8 +97,6 @@ void board_init_r(gd_t *gd, ulong dest_addr)
 #ifdef CONFIG_SPL_NAND_BOOT
 	nand_spl_load_image(CONFIG_ENV_OFFSET, CONFIG_ENV_SIZE,
 			    (uchar *)SPL_ENV_ADDR);
-	gd->env_addr  = (ulong)(SPL_ENV_ADDR);
-	gd->env_valid = ENV_VALID;
 #else
 	env_relocate();
 #endif
-- 
2.54.0 (Apple Git-157)

