Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFB3CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B18B880E26;
	Mon, 28 Sep 2026 13:42:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KB7cYUGQJCYt; Mon, 28 Sep 2026 13:42:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 57BDC80DDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602920;
	b=YdRGMiLBvO9Vu0uEt+3reThS8i82HEwe2iCuL2BilelUHl4iORXNzLckymXEpp1X1nl4
	 Kz4l2sWLb2bhqXc2HbtGPziAsTn95IOI9PTE7ZLwfWzU0DPFxrhRPULjqvUYNaFDHf0LT
	 IWtQBVmnjcljJ65alQbl1VghfN7Xff5iKO/x+FaXriSv90+5lyYV2XL0Fcw2uPWhJ2kTT
	 zUun7O7YGMGGRtFv/zDQaQYy0b9/G+Nb98H5i6+UKWfwkuYMma75VJsIRED+wY7h+2oef
	 y31wj4kfmT5CWrkUaxqtBfgKivIOJ6XfCiv/k9RyozM/MG5rpoyw8PR3d4YNDOo2qgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602920;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oO5X6fpp2E803WEDf8keMAgJjYIDBQB6qsrhf+so0Oc=;
	b=ViHg6RF7lvck+gZcuK/ZZWRrS6Qi2zNXXU/zRTHZ/oheGYE/4TGqhyUYAU6HFmh9pi0M
	 cdGzN6Gy91qz2gGJfCCi6DC1vuB/sfZtGZXTwZEu8p1MN/Ii5XNcS+rJvID+8ipKh8ibW
	 Nx2OCK6XjYSLwuNP4a+t4LN2DqHFWyhfDtRPAX2oB7nBFC3YHReu+TmUG1xEGZxixT2iP
	 tQM7G9cW6w9nbFU+00P1ZsZ9+MFVETa758GHehtr2KFxw7F7VeF9AKxOOUfc0GAd6uUBf
	 1aWS2IdcPIHwggq/MXJU3GjReI4gjobfwFAec0bLdiPak6XGjPnvhCtkkeh0Xb13qBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KRRERba2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602920;
	bh=oO5X6fpp2E803WEDf8keMAgJjYIDBQB6qsrhf+so0Oc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DTZQnTdD66Ejl5Pt2ULIvEvubJZLGpYXNQFWS3V7DAOowMGK0pVC90aVhr1Mwwj+W
	 n8GFmIBW6wrfL4yl3mrQS5fdpTmM9jgSLGyMWpL1EK6KZt7WIV5jzGawagq1mjfEo3
	 fxzKNAgQYWUlFnVsl8Z4vdxntbt0BnDZ4l3R8k3BOA52fAuDEP0O0dn/x3/aXSXX7s
	 BEOk/HJ+G7jL0b6ddBeu92AyEdRs9aeh3UpPWTCgUdsqYktmO0dYcnOr0gmPkunk3D
	 CJ09qFVLAo8CQDgLr2c7nD26PoT4iwxkHGukLsPtmzhtocXnKnYVCEoJ7ntRTG/kEX
	 Ng85T3oPrCPzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57BDC80DDF;
	Mon, 28 Sep 2026 13:42:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A13F6361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CFFA80D9E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11rEoPwRf1-6 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 08:38:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 768B880C84
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790584706;
 b=CVe/AHGXjBSoPy7R6ZejhZcOQQsKP8DN9iloZTcT1cru6/lgQn0RHkyc9Bk10h9vQG2/
 MedIaygMf4X6LCOF+xq+++RiMlxwj6OKvVeWFdgYkEDpxjKn0+eiVpYDcmgj9OTAZHEuS
 q6aNZ2gCgV2Zn+7NGDknb95OD/TvzMxrDK++evYwrRlV4rQPawEDeLmoWlzKRnoIfIEcG
 4agXRmrmWYOICxtn78Dv65XoW7cMwEz2e3cxNBqL7mpw4eDUpjvgnNuhkubgv9gSXC4PK
 2489IZRdJfTx7J/6zzIiOMBz3fijh6inerb034qPKqjhi/KB52SZWNN33kVAW/qGpuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790584706;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=oO5X6fpp2E803WEDf8keMAgJjYIDBQB6qsrhf+so0Oc=;
 b=Z8PvpQN4uH1F70Ss0+d2/3qDrvBTW8M+xs0RgredT56XBhpnJHmUKkqZMGetOZ2rSG6p
 3jUjEVaaXwUzk4w2bJuwM4ma6zIdSMIs4MMoS2eXyrWSxvllAi/ZMuPHQWd+gIEfLC8pC
 xHGUZfyCUPCFe/GzyCN22cHXa4S61K8kqx9WFR34caBCkqauHf0fhz2OzwHZb4CoN0PZr
 nl4NaRNDPxu8XULSv7hJJJ1BsgAdiMmCCGZeCQb8fSqnAvQxwQ5bUiJD3YwJOJZBksD61
 T0lvJ2blPyiDkGBRk/P4HnbMH0PPfu8rOl/h1vEDOUf/aRhw4XtnCsBtPhawJ/skAug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KRRERba2; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KRRERba2
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 768B880C84
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:26 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912df756so21775725e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790584704; x=1791189504;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oO5X6fpp2E803WEDf8keMAgJjYIDBQB6qsrhf+so0Oc=;
 b=KRRERba2RANPnzzDewPlY7mwNoF9VaZoAdHUrHziwGmkrBZwK0GunLdBiw47KN0LDg
 yvToRyPWeDe3g4M/ARcIvAOhbkUgwBBGgMfN6odZU3GgVwdMLno4Ug3vL+BhhOmskNwb
 y/rGUAxVLvvxKjUqYYmD54JA1TVgmP5MEjoxUVrjjereqqLRECUnfnSwTAyu6/dz93Hf
 3JR1N2tP0OA1CdIA8sLc7IWYvHDnRiVCErosKPeKhJL+tNM9RL++Qjd0EwOcy0ZQXaGT
 VtNvqkBCN1UKVwLP3KYogSKJ9vJqhZoxjmvdxL/DNghNa6bm7rFUQzYyD1WYlmTh5b9b
 qsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790584704; x=1791189504;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oO5X6fpp2E803WEDf8keMAgJjYIDBQB6qsrhf+so0Oc=;
 b=Y3vIp0K6CtZdTbI8BKsxE4VbpYTzMEEhlPSelTkhzF6GxzdxBtm1nSz0uWGDzQVdLB
 V1qigjgFdtwhUsMBKcFDvBevt1GBQJ9Q5MuZ3pT7S7XIbQI7oI6qiz/I0G7dsdRWacvG
 ErU4s8RuOG/xzGaYvVQznHkEHnfIbsbliWm2cGLCGuWvwKzpFwb/lhVQNlgruvQ0JfW0
 pWLhMSV/BUznh31mLaW9HlOUv7911x/cP1uzCPohnDF7E9d6o6WFvEw5dgtEOPy4WUyZ
 rD6cLcfjwt6GRxM0+iVyo4AZitZwThpkhblLCF9Uk0FMcliRDh1W7gH53Uiy20W96UxY
 bb2Q==
X-Gm-Message-State: AFuF++mvUVv78sLZoRpACrAbxPx/cab6AepTa0ikrXfPU2nVPAiPEZfA
 jN7VpjklRAYyM0CjivSqDMUFdzu7RMO3oGwJxgAzbuuLTIIgS+bMihjQmg2Hl1HfTdLVUg==
X-Gm-Gg: AYBFou1A4mrK4ex7rahrPcjzjs8of36kGGYyAZReBsiTyytCd43Yu5+8JDXUBMTv8yS
 vE39eKF/ex08IfAxQi9MsPhe3NstOgGHend7bnGmxQFabJ4l1s6l4aWSPZOvtWH7ptrtuGjn2vO
 Qhu9XlNWbzn//S/qo3GAnJKeP83wkTQJLhXdIrZguV+okTHvWcV15F/nFA8h/j8hkRH9NXDKMdb
 LtyakMDKEfnX/8HLMUsSPNbhqltYMo1fenCQnZaAq1zmxlh/ad6W4KK2KY4q7bg4OiJmbeCBIgF
 HOn7Zsy8eaG+fA/FdAd1Rmw7UhJts6hmirgZqDKAi8DDC/eZ25Acv6KQn7rjIVp5zVt1S9pCOrt
 7htrFBgsTem0uFT+GW98xpCxvWX4msBdjJzcp7vLprAyrGP1AS3rZAe8CXHiZKziQEvujg+NNjb
 UC81uNbFqnqJOrc9J+Q69PnpQklX3oRaGvtE7fH4iyGZhhWM4IMomBOlOJkrrP7QAwlS6z/RAg3
 Ejn9UP85YapPvVf8EXc5XZ/M3SmypA6ytuc4l4/Hr70XUOb0kdym6j4hFqSfkJJVS+gWZZlsW+v
 +WLWQSZNivB6Or+MCXEM/4xjr0Eg8PgnAQs5PoNTTiQVv+GXbK82j7FswdfdOfCY/z7l6K0HQGe
 DhzebZPlVOyzZlXcSft9/mg==
X-Received: by 2002:a05:600c:638f:b0:49c:ffab:551f with SMTP id
 5b1f17b1804b1-49fe66d8112mr211080005e9.22.1790584703863; 
 Mon, 28 Sep 2026 01:38:23 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-c000-0ddf-e9a2-82c8-47dc-7bbb.ipv6.o2.cz.
 [2a00:1028:c000:ddf:e9a2:82c8:47dc:7bbb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00179c729sm191700405e9.15.2026.09.28.01.38.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 01:38:23 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Priyanka Jain <priyanka.jain@nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>
Subject: [PATCH 0/3] fsl, powerpc: Fix SPD read and appended DTB alignment
Date: Mon, 28 Sep 2026 10:38:17 +0200
Message-ID: <20260928083820.62352-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Three generic fixes found while bringing up mainline U-Boot on a
CZ.NIC Turris 1.1. Patch 1 fixes the DDR code used by NXP boards that
read SPD over legacy I2C. Patches 2 and 3 fix linker scripts for
mpc85xx and the two CS GROUP boards.

Patch 1 restores the legacy I2C SPD read that commit 98dfa70f84f0
("fsl: mxc: Drop legacy I2c") turned into a stub. Boards using this
path otherwise get an all-zero SPD and either fail with "Error: No
valid SPD detected." or fall back to built-in timings.

Patches 2 and 3 move the _end alignment padding into the last output
section with content, so the appended device tree lands at _end, where
fdtdec_setup() looks for it. They also remove the alignment immediately
before _end, allowing the existing ASSERT to catch a misaligned image.
The padding fix is split because mpc85xx and the CS GROUP boards are
handled by different custodian trees.

On main (6c246142f39) built with Debian GCC 14.2, the appended device
tree starts 4 bytes before _end on turris_1x_nor, P1010RDB-PB_NAND,
T2080RDB_NAND, MCR3000 and CMPC885, and on turris_1x_nor also with the
kernel.org GCC 14.2.0 used by CI. With the patches it is exactly at
_end in all of these builds.

All 83 PowerPC boards build with the series. For the NXP Layerscape
reference boards, patch 1 changes only the six configurations that use
legacy I2C for SPD; the other 54 produce identical U-Boot and SPL
binaries.

On a Turris 1.1, patch 1 makes the SD card SPL built from main
(v2026.10-rc2) initialize DDR and start U-Boot, where it failed with
"Error: No valid SPD detected." before. turris_1x_nor built from main
with the series booted from NOR and started OpenWrt from the SD card.
That boot also needs "mtd: rawnand: fsl_elbc: Select NAND_ECC_BCH"
from the LTO series for next. Without it, turris_1x_nor on main stops
at the NAND probe with or without this series. The other boards are
build tested only.

If this is too late for v2026.10, next is fine too.

Josef Schlehofer (3):
  ddr: fsl: Fix SPD read when legacy I2C is used
  powerpc: mpc85xx: Move alignment padding into __u_boot_list section
  board: cssi: Move alignment padding into __u_boot_list section

 arch/powerpc/cpu/mpc85xx/u-boot.lds | 2 +-
 board/cssi/cmpc885/u-boot.lds       | 2 +-
 board/cssi/mcr3000/u-boot.lds       | 2 +-
 drivers/ddr/fsl/main.c              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 6c246142f39fe0b406a730010010a66e6e926cbc
-- 
2.54.0 (Apple Git-157)

