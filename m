Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE299CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 551826066B;
	Thu,  1 Oct 2026 20:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LVrS3tKowF3; Thu,  1 Oct 2026 20:47:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5C2D060612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887676;
	b=I1p09FT9kbOlSJfLgfenDfuSdXx0qXBwGLhqsx0Bi2VIGA4O4w6cQmL1IdXbhvZkejCB
	 5UJfiB+UeKGCPkjP8DDRmtuzRwf2iXRUByJYZIzygqosMw+2AgM5d9HpLdGNAOi/iN6hR
	 cQg9eV5F46gquDUr6h7nsTz5/n8GXDDAUu3FHmt0Iu1b6j1uTSxzhvE8rwZ3PKsMr8gf6
	 rPY8YpF3J4sIPZ+J3m9k0NA1vEZiJlQGZO1zzdgiW98xEqtjhwSUlC/7Tl0tO619f60Qe
	 43XQpfIQ4EIfGDPGw45gmkSlct1bV1D0mOoaWeoQ9tAzQ/8Ng2ujy5D59jWoQNCrp0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=61bOHM4ASsIr13/8UWzdNTH7bKRC+XdyCfxYMdY6oN8=;
	b=c3yBbt/qspHHEkrZW+A3PGsCSnXscja69dcmE6pINXGMBhkDST6/gjXZhN4pU2R4oFQG
	 lnTDERpKgfD2rL5bYUyiFKNX9EYOnh8tPjgOH/i2dupQUPNiATVaUnpgoRQe+5NdBXe8B
	 sg1X+jSvYZQ0td9v2mdDQy+8jEcGynunZBcMILtD++FeeRmnxJJ/EomTENmtZVBYU3dZP
	 nmIxoB2ib7uNkVBoSINTEcvxE/n6abSt6Qsq+/opWyynb9TRTsWjZxtH2glsz/Bs8TDz9
	 bcSvEO10tq7g33DnMDwKEO81B/uXuizjXJx2Lc8FYlbpvebJ7G1+daNcm7cclEZ0y9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887676;
	bh=61bOHM4ASsIr13/8UWzdNTH7bKRC+XdyCfxYMdY6oN8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YK+CMvV6SgGpHndT51atu0OgApR/YSTVP9us3I/RRdesq/5M/K5yu7Bd6jFTBmpMo
	 evVRncKTl7MLoUymID8wI8Oq85s8uWnZb5M3T3C9xceroFMqXeEMAvgsh0q+5gLTrv
	 aKZQqJr20OFUzV4bHXfuD5yTKVSDM3//UpcKoNGXYsWsxOktNvEFshsZzKZfjon+ek
	 Dl6+hfb9BDZTrgxf9RDNVkf4MeWtQJOUgvxAqofj/sJaFXSGJfqMl5AL2AjkKkocr0
	 pghalplsEPLdVoa8+t9iR6shFVr0fLlaUaW5PZGdX+Fiwt357FDGw2MO96gnrBB0Xy
	 Ix5Iod3c6XHlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C2D060612;
	Thu,  1 Oct 2026 20:47:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B08233B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E555F407C4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:47:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K0W4_pNIut_f for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:47:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E7D11407C1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887674;
 b=lmrPuuZor5yb9tqrhAXSI++UV22Ihd0MtC6WZu8n03OXgwdnIDIWILof7DNqISvmArZW
 S8fiLN4mKFOG2H0a2P5178qJJ3X4BJqwawoC+3pVsl9RH7sCGf+OE9a868K8/+E0gzteF
 CmMOIaeMCQD0FpYcdZCgh0TSFnAoifmqZZ1pUOr6lSeCt6VqMcBQSfVD/zejLze+4o8kI
 McTVXmNJe09S4hczd6p+7cfkXnWpan44RWGNRJycWzpgyIM49mCjdekm2cioVUsLoKV7B
 O8Bi1ZBixUBfrzqj/FTmJXzTZvZqozKEjM9zNus6nWl8USmf4j+Y+OwwXSaSRBN9MCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887674;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=61bOHM4ASsIr13/8UWzdNTH7bKRC+XdyCfxYMdY6oN8=;
 b=Snmb3HeB9tRLh12OrRqIyI+7g9k5uL8wEwEPlVsq3lQilhDfp6ZMNzqBLJtiGQ6Zymmz
 0z2SNLj9KePEynDksZBmK30yp+fo3gSmOT+hfFw5aLZl+WloH8ruFlix0jPyQw4cY81ZS
 MPKN0FDlmpX8Av625kVRHqBON21e/qRWJ+QBlmDMlXYL/D9H13JIImKozqX2mZS1S60lG
 CZ5LjTwAhLppkacA87tZpdh2iFEhS98Oq85EzmZoa1DCU46JPs8fVXtkfASDirGkXn7RH
 kscMneeFB8VmZqqSIEQu+NI+Z7yrLsyLiSHTj0qhO/J0GwPxU9GD0YBNeJBFCxyBK3Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Qs18A2fI; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=Qs18A2fI
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7D11407C1
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:47:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 562C6B00563;
 Thu,  1 Oct 2026 22:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887671;
 bh=tjlgy5lNDAqZLKi8tXi8WmDRay0BfSLBnpL4QjwClLE=;
 h=From:To:Cc:Subject:Date:From;
 b=Qs18A2fIi1QEyHPXT8Hs1mz7l7mcuvCFUFxtO/waHHk82MBW3DtLEO5aAl7vZKrku
 w1Rlv72UPcrpn2OJJeLV8lEt8zvEOo1VL2nT5oTlnTnkmYh+IUwYQIwiWC0QRayBeF
 Kv001/SBZfDWz6QGx9dQEb9rbFbSq2+4/p8xZeFgZW7Ne6jSLfQfyoZz8wxM8q2lpu
 WQ70EqafFpW2rt5r+Cb4WoacU/InBJwxFJQXN2AptBo6e1/MsbkCdezHBDYOKgqbVW
 HkYB9DE1P9D8JefJr38lpnpSFM2dhLO0E+SCXAhWsXBRbZMh6APEbgfa/8qWtpI/L0
 d54fns4NWE6xQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 00/13] board: lx2160a: runtime SD 1 lane configuration for
 LX2160A boards
Date: Thu,  1 Oct 2026 22:47:17 +0200
Message-ID: <20261001204731.1774613-1-vjardin@free.fr>
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


The 1x100GE + 4x25G split of SerDes 1 is in next since v1, commit
035d68fc36b5 ("lx2160: add lx2160_serdes split and management").

This series builds on it with incremental patches to ease reviews,
but with many reworks:

- No more command that re-groups the lanes at the prompt: the MC has
  already started. Use hwconfig
- hwconfig values are named based on needed cases:
  serdes1:split becomes serdes1:100g4x25g (patch 2)
- Use a table (patches 3 to 5), and enter a mode through the one it
  starts from (patch 9)
- One patch per new mode: 2x40GE, 1x40GE + 4x10G and 1x100GE + 4x10G
- Rewrite documentation
- Add and apply to nbxv3

It is now mainly tested on a Nodebox v3
  setenv hwconfig serdes1:<mode>
  saveenv
  reset

- print checks using lx2160_serdes status 1
- in Linux, with the matching MC DPC, DPL: each case has its netdevices

As agreed with Tom on v4, the conversion of README.soc and
README.fsl-hwconfig to rST will be a separate series, after this one.

v5: https://lore.kernel.org/u-boot/20260929175947.1379710-1-vjardin@free.fr/
v4: https://lore.kernel.org/u-boot/20260928101330.881662-1-vjardin@free.fr/
v3: https://lore.kernel.org/u-boot/20260916211549.3432913-1-vjardin@free.fr/
v2: https://lore.kernel.org/u-boot/20260914170417.3052423-1-vjardin@free.fr/

Changes in v6:
- 3/13, 4/13, 5/13, 6/13, 11/13: Reviewed-by from Vladimir
- 8/13: 40GE needs PLLS, only 161.1328125 MHz PLLS reference clock is supported (Vladimir)
- 12/13: same for the PLLS reference clock (Vladimir)

Changes in v5:
- 1/13, 2/13, 7/13, 13/13: Reviewed-by from Vladimir
- 3/13 (new): rename SPLIT_POLL_US to SRDS_POLL_US
- 4/13 (new): halt and reset of SD1 become helpers
- 5/13: the table only
- 6/13: report an unknown serdes1 value
- 9/13 (new): enter a mode through the one it starts from
- 10/13: skip logic of the reset added
- 12/13: reworded, PLLS reference clock, no list of boards

Changes in v4:
- rebased on next, incremental over v1 instead of replacing it
- 1/10 (new): drop `lx2160_serdes split`
- 2/10 (new): rename serdes1:split to serdes1:100g4x25g
- 3/10 (new): use a table to set SD1
- 4/10 (new): report invalid serdes1 names
- 5/10 (new): refuse once the MC runs
- 6/10, 7/10, 8/10: resp. v3 2/5, 3/5, 4/5: add other modes
- 9/10: v3 5/5, rewritten doc
- 10/10 (new): apply sd1 for the nbxv3

Vincent Jardin (13):
  board: lx2160a: serdes: drop the split subcommand
  board: lx2160a: serdes: rename serdes1:split to serdes1:100g4x25g
  board: lx2160a: serdes: rename SPLIT_POLL_US to SRDS_POLL_US
  board: lx2160a: serdes: move the SD1 halt and reset into helpers
  board: lx2160a: serdes: set SD1 with a table
  board: lx2160a: serdes: report unknown SD1 cases
  board: lx2160a: serdes: no SD1 config once MC runs
  board: lx2160a: serdes: add serdes1:2x40g
  board: lx2160a: serdes: enter a SD1 mode through the mode it starts
    from
  board: lx2160a: serdes: add serdes1:40g4x10g
  board: lx2160a: serdes: add serdes1:100g4x10g
  doc: lx2160a: document the sd1 hwconfig option
  board: nbxv3: apply sd1 hwconfig before MC starts

 .../cpu/armv8/fsl-layerscape/doc/README.soc   |   7 +
 board/nxp/lx2160a/eth_lx2160aqds.c            |   4 +-
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c           |   3 +
 board/nxp/lx2160a/serdes_split.c              | 548 +++++++++++++++---
 board/nxp/lx2160a/serdes_split.h              |  16 +-
 doc/README.fsl-hwconfig                       |  64 ++
 6 files changed, 531 insertions(+), 111 deletions(-)

---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: for-upstream/lx2160a-serdes1-v6

-- 
2.43.0

