Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556F1C982C1
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 21:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB69D40729;
	Wed, 16 Sep 2026 21:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FVfkOOjPEGCR; Wed, 16 Sep 2026 21:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 02AAB40434
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789593370;
	b=dZAIrpEr1ROlLpVKWxkQ85IRPZItO2+zQfHJafQnbxZrp5e3YjXSPRavkX3cotaZx0Ry
	 +e7UzZGdqQnX3fF1ks9gG5m+JCF7TC4C+1SEM8wLufK75utNwxmvl5KTI3/8Xg9mXiM4K
	 5Hc7XsiKsSPbi2hFxGh/JT1wu6GWgwO5DrPVWBelvpv98itafPzK1FnldAe7fDkcYmHA1
	 uR8SbnswhfGKRwj/CpqXkxZFYpYD6HIMYGZeczyALfBkKQkZzc37Fhj5DwZg4X/HYte+8
	 EOnV7fNN3STk5z5n/2I2qcNwN+Ls0gxm+k+XYpGxmEFomY9OiroqQjcAazV6pFKmUHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789593370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dJRWfkLi65HXzRhX9IWYXdibYnwwhrMSXWLAvNHyXDQ=;
	b=RduNjGGdS2GLZh56Gruuuaby3n3up+to3CDH+sLR6DsJeg73T0PHKTdwiyd4m2He4ID0
	 QsDz+fAUrIYQCiyP/GGbnvb/M8AxbtrkZLLL8oK93DvSrEVGwzcT54gKLDf3DFs2TMfni
	 +MZccsxSQZmVlpnv5HJ8kgqOPm0XhoSx5e/fBi8i0ZkwxBquliBr6YX/6JJsZ7j7EzLHZ
	 Y+Mtb0meuEfX/vuQvmaiUDVC6YaHOc0p4tXEDj1cs+kFb19F5/T/HL1XAeFKPUMt3aP9z
	 ZneNH/+w9toTeT5w6uEk0banDuzjiFLAhie/qCUhSfsZE7FtXk/nUbhubsmR+YZ6tHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789593370;
	bh=dJRWfkLi65HXzRhX9IWYXdibYnwwhrMSXWLAvNHyXDQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jNyriHNjjx3OK3cPnq1DjRngzJxC04aqvxUfYby34ro2R04dlCS6O4Q2dIv9aLbyo
	 eYbwkTxyBMC/Jwc82We12ABhpf0BsHrAYRm/H97EMigpGbsf8s7RYV9avrOw55+kfz
	 sQE+BaAiDwDSzfZBKHqQFH0gbywsKlfIEg6wb+YjTNYKp5AxmEFnUiC146/bjlrhkD
	 NCEpqtSnvYMPxXyL+3znjfVPA7VSWSDF3GHs6xINqNb1JNXOdGt3YUWVy+z/15nSjR
	 BxFN/ZvyOGl8vEE2HKiZc9HFJh20YV6f+mWOsEiA71zT6KZFO6LzcbFlCWreSMV5Jw
	 B8gf7CvpVIBkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02AAB40434;
	Wed, 16 Sep 2026 21:16:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FD0624D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9AE380D98
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JWmBjFPMVVlB for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 21:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 645B680AAD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789593367;
 b=izi8EP5RaQx9XNxEU/AnZjb7qxbIK42XDQKcHoEmGHlssd+X1wdPjSDa7PBWRoo4azZE
 ODLbKXzVJOnS+LHdw+PUF02uSmLRnwxMzOqovMpzQ93tX5C0jQlNVyzxkgw4nMww3maIM
 yZuPhjpNsizzqHy3/32jrQWsF25uFcBqVXJQnl13z5BPS9OdYD1lIRGCEybkEfVgW9Fif
 PMT0P4euCWYZFUvdAIzz2XyaLrMLIg979QGdRxa3LpM01H9N5f1+2AWeFv1uR0xMs/jz8
 2R1B0jd2/o3lGcB5ocacTdazRmf5OUirzeaAkzvX6f8WDkgv4I4seCSu2u0tP80WSig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789593367;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=dJRWfkLi65HXzRhX9IWYXdibYnwwhrMSXWLAvNHyXDQ=;
 b=fw8z1s7mQ6A4iB+jpg+iu/0HvpLVSYHRoVxUjVF+kfcDkEO3M+y8X9LnH74MbXTPDin/
 bYZ46/XlyYNv8kW+OTpvoqC5XcsipFdiINtyZEyyzp7v7iOmG9t9uTyGNkoA6ib/ALB0A
 xaPkjx4StJ19SjDBtcWbEIvThUPxwv9bezYiGKU9gV3AtPrjRZ/eLqejQfzkPSPoFQmOk
 ghFpdESEQkSaElZD/3/HRoA2XqxB4gREM+tCmfEEY6wDfm5vh9UNuzIKlIXYgus7THvci
 NJp1yv9RwwLDZEzmTsJ7NEUgCOBkfOOHGcpKmSJLgSiYsCpzf8DsEDOcESNlYhJXjpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=e3uOKZ6N; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=e3uOKZ6N
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 645B680AAD
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:16:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 9A723B0054C;
 Wed, 16 Sep 2026 23:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789593363;
 bh=T9yOoF5y/niJBp3jU4GtN+gJZ9a1G8fVGFCwyN3NvFw=;
 h=From:To:Cc:Subject:Date:From;
 b=e3uOKZ6Nl8bS6mgIPSUOzDkFIEpLLrzVh9aPKtNcs9dja7tSOAsfnGGGlhadBbaSn
 fheYFAZ7btJC/XbOO7Z+Ga9o2Arbz8gAfv0lTQSmBGbvgi8ku/qyMcvq980kHTul5z
 UM2RKR/GpuSM38U2WjHBkoLRG8RJ9Zt8PvjuAT/0sW6ZAjc07uXoPJ1GKM4qJW3u25
 GUDOCTu8UVAPu5/SeA36+mS/8bUFNngfe02a2v1KzW8FS1+RePE2ziRIvIg2hcN/H8
 ZsmdU/0i9eaoi8Akq/MR0TEcnFr4xmiSvmQdlb6nB9lTAJ1DE1Mka7zUhq3fKTClcN
 Ae8y2GiIdyMzg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 0/5] board: lx2160a: runtime SerDes 1 lane grouping for
 LX2160A boards
Date: Wed, 16 Sep 2026 23:15:44 +0200
Message-ID: <20260916211549.3432913-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


SRDS_PRTCL_S1 is latched at POR and read-only, so the RCW fixes the
SerDes 1 protocol. These patches let U-Boot re-bundle SD1's
8 lanes at runtime, before the MC latches the converter setup,
without changing the protocol number the RCW advertises:

  lx2160_sd1 100g4x25g   1x 100G + 4x 25G split (patch 1), both PLLF
  lx2160_sd1 2x40g       2x 100G -> 2x 40G, no split (patch 2), both PLLS
  lx2160_sd1 40g4x10g    40G port + 4x 10G split (patch 3), both PLLS
  lx2160_sd1 100g4x10g   1x 100G + 4x 10G split (patch 4), mixed PLLF + PLLS
  lx2160_serdes status   read-only view of any SerDes (patch 1)

Each mode is also reachable from hwconfig=serdes1:<mode> for the
boot path.

Based on next: the 100g4x25g split itself is already there as
035d68fc36b5 ("lx2160: add lx2160_serdes split and management"),
this series only builds on it.

Changes in v3:
- Incremental on top of next, where v1 is merged as 035d68fc36b5:
  v2 mistakenly re-sent the whole file as its patch 1 (reported by
  Vladimir Oltean). Patch 1 is now only the delta: the lx2160_sd1 /
  lx2160_serdes command split and the 100g4x25g naming.
- Patches 2-5 unchanged, rebased onto next

Changes in v2:
- The mode-changing command is lx2160_sd1, lx2160_serdes only reads
  (v1 had both behind one lx2160_serdes command)
- New patches 2-4: the runtime SD1 conversions for many cases of
  split (2x 100GE -> 2x 40GE, second 40GE port -> 4x 10G,
  1x 100GE + 4x 10G)
- New patch 5: hwconfig and README.soc documentation
- Mode names say what they produce: 100g4x25g (v1: split), 2x40g
  (was 40g), 40g4x10g (was 4x10g); 100g4x10g unchanged; same for the
  hwconfig serdes1: keys
- Rebased onto main

Vincent Jardin (5):
  board: lx2160a: lx2160_serdes to lx2160_sd1 and lx2160_serdes
  board: lx2160a: convert SD1 2x100GE to 2x40GE at runtime
  board: lx2160a: split SD1's second 40GE port into 4x 10G
  lx2160a: add SerDes 1 mode: 1x100GE + 4x10G (mix)
  doc: lx2160a: SerDes 1 runtime lane grouping

 .../cpu/armv8/fsl-layerscape/doc/README.soc   |  10 +
 board/nxp/lx2160a/eth_lx2160aqds.c            |   2 +-
 board/nxp/lx2160a/serdes_split.c              | 716 ++++++++++++++++--
 board/nxp/lx2160a/serdes_split.h              |  40 +-
 doc/README.fsl-hwconfig                       |  25 +
 5 files changed, 731 insertions(+), 62 deletions(-)

---
base-commit: 826ac8d2dc500fcc780647357032fea493e1f9bb
branch: for-upstream/lx2160a-serdes-split-v3

-- 
2.43.0

