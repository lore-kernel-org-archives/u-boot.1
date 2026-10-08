Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAE3CA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67AC960872;
	Thu,  8 Oct 2026 22:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aIZy7AUXXYVY; Thu,  8 Oct 2026 22:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6AA7A60832
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499375;
	b=TnGMcaILNumQ69onNUrRt+/gPaQraj30pmlTEylljz8RvyYpN88qgPSaFXlmnbsIprZ2
	 yYEH+ScAI48jmODQ0Jtj7OEM/IbffMTdvX4ZAJWqJhl0zhQRmXS6QddX9X2BQwm2DkRYD
	 8eZrdQ51usP952+TKYhwE6ObokbNZuppqhMWhl61yDSrkvvgEd3sSGhgjso+DNUz2tF+Q
	 4ArjudbCRVI7VI6JVOua363UQ+OSkPPO9aS2ISdp46bwKKk5cXXaDOvhe+tgFq3U0qKHg
	 OtA3jicYjFdRwhxQ7TW2G4W+HB377KX5cK8Q4HduDeJiVG97pIlYW0eF3ggSdhRH6Cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9QqFODfA1V4No1Gu699XZSh7YDSGLHVtGwh34+xSceg=;
	b=pHl9N4I1DNtxbESI6j6z3aqp+Z9gIUfHES5khvitkx9E2JQRDIogTKyqtQdmn/MWhrEO
	 b2WbnA0Vmj6OqRJAHrNkst/mfP0yfxc/RZw0mtXUsXzFTaMFf7JhkUK3b4KbePiibSRvE
	 uzgBQkB8tBAiS/+5N40fAfMRJ8DQAxTKF7iU0o0IFkgNDNNsTo4rQdAYm+uvy6f9i2Pyl
	 MzCYJTbC45uruW492AUWoAr0H4oK4BL684ReR/tFFQoZ7vf0Ap9P0GRxHlabs90HIlnGJ
	 xKkHTA5KxCDx6XLcZsF0Foqtbx3PWSRjeyFvV4ccextiEkWELYsnEdYblm4KKa9h3uw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499375;
	bh=9QqFODfA1V4No1Gu699XZSh7YDSGLHVtGwh34+xSceg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cUHY/LopOjD16ZjpKyk3I17Czim/uOd2F7K94wWDBioe7Vaf4EP86mgOAVjhaID7j
	 PLYhJpw9YKtcH+f/TPXTF+Q2MvmmdeT6mbrDc9EIjg+mT7w0rUriMo8QXRt27wtqjs
	 fGGa+mbMWopKRktTUKgins4hJx5GMfh5/uN0hDh3v9tU44EJxuaQK6pApSfsGR3+xI
	 Uuojn8IZB9o08Nh99JIsi0LI70II1dI+O3GTj7rG+0T6snETGMbEwMKzGcmG+8SPdR
	 VztKi6CAPWY9g/tnJxbvYTZB4GhEncbYnuPVmlegItZr1wfRlQVk9f4MmSkWr1PLyc
	 aITGcSb/2NorQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AA7A60832;
	Thu,  8 Oct 2026 22:42:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13587228
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB4978122B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nvcFJ2AaKtfF for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:42:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9352F811F6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499373;
 b=rVNByhuF5w8C7F/d0XI2LccV9yBJelQaY5ADvdJ2rwv6FH8ZoLaLDpYUHq2hoPakIBUo
 /qoUxiWTlgaUfNZyAsLTA//UFlp+y3mcs6Tgl2SzHphP/NbVTcaq79KZLjL2LLc7TzGP2
 wbSNnRiOt6ij7rSWpJzJBG9fd45zEmajVRoS9AL2rZuIyhMY8rssr23WBNnZtR/N8NzpO
 IGe/bnp4jhvzoJ/DgKAdIQtp8QmUkAHQ62sAoEzDem1iBVLWGEczDbuZKCDwxYg65SkQf
 MbElgiiDtz+gYO2Fj8vNA7tKR8GVW4zNnb4kGFIdIg3xEPn4txNvIHBFFtCv8jpH95w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499373;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=9QqFODfA1V4No1Gu699XZSh7YDSGLHVtGwh34+xSceg=;
 b=Sitf1wFKu5Owx0UOXZmZETlPIAvfOaHO7mMEfXSYY14KldenplnJlaKyNutvVYK7rqwM
 PbPzjjn21xbSoz/Kk8vN6XDxMtGajCNgnr28wDHPm/l0rgvlkR6VKPUWzXkt9nYgjcqqA
 tWOSCw6IA7EN9S4HP31hhTtgfXdluNyCZFopwFtJ4oUJqp6gwfZXhPpraZodoOhWYFprv
 4xfauLOgIKNgkBGe+VZgGqyxMzVdGdfKMAaJelkOF9m1Qju2MCpEHHYY4SSGso83Nx1pc
 IPLPXGUyjLf5IrdZ3fQu86sPVXBbdh0G+NNHAX8B/f7uk8DZioyK8GiVKGUnMfW1PvQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Aq3OOJX6; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=Aq3OOJX6
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9352F811F6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 968A4B0051B;
 Fri,  9 Oct 2026 00:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499370;
 bh=eQ5DXd19DPHUPZHqBYReJ+BknBLWMmb3Ijc8HZDWUsw=;
 h=From:To:Cc:Subject:Date:From;
 b=Aq3OOJX6Pljqrl2faI+YIM0JvPBLJkHF33khZtl46B+YCubHiAmH/vJQX+7BEyqtD
 IgtY1K4obJAJN+a5fAETH4T9CyeIILJPALEM4XehmCRSb4Q/MLieu6N2czDLcfM3va
 T/+b7ywHVdRIAuOHFxCuZ/dlU0IbK+Til9sl+7Moq5LNlEY5Vh2HaMLAjjcrSNLBfC
 x2eTxnHCmV7SWFPRwiqcjTYeHb6WZH608alcp/SRimVIK9RsF/0/5AJ7vl8QUQyYjN
 hz2qrjz+ZfxvJW3qOsqUDadBKQMrjD6pKEHg3Vn03TYr6tK+N6nvgRzB3BQfslRezQ
 wuwg/y7LuxWtg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 00/13] board: lx2160a: runtime SD 1 lane configuration for
 LX2160A boards
Date: Fri,  9 Oct 2026 00:42:13 +0200
Message-ID: <20261008224228.512353-1-vjardin@free.fr>
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

v6: https://lore.kernel.org/u-boot/20261001204731.1774613-1-vjardin@free.fr/
v5: https://lore.kernel.org/u-boot/20260929175947.1379710-1-vjardin@free.fr/
v4: https://lore.kernel.org/u-boot/20260928101330.881662-1-vjardin@free.fr/
v3: https://lore.kernel.org/u-boot/20260916211549.3432913-1-vjardin@free.fr/
v2: https://lore.kernel.org/u-boot/20260914170417.3052423-1-vjardin@free.fr/

Changes in v7:
- rebased on next
- 8/13, 9/13: Reviewed-by from Vladimir
- 10/13, 11/13: reset only LNE-LNH (Vladimir), Reviewed-by of 11/13 dropped
- 12/13: 2x40g from protocol 13 or 20, one column per dpmac,
  follow the lane order of the RM for the mode names (Vladimir)

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
 board/nxp/lx2160a/serdes_split.c              | 532 ++++++++++++++----
 board/nxp/lx2160a/serdes_split.h              |  16 +-
 doc/README.fsl-hwconfig                       |  70 +++
 6 files changed, 521 insertions(+), 111 deletions(-)

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
branch: for-upstream/lx2160a-serdes1-v7

-- 
2.43.0

