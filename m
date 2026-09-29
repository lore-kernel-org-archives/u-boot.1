Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E3CCA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 467B3607D7;
	Tue, 29 Sep 2026 19:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWMhrxumatbW; Tue, 29 Sep 2026 19:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E8F58605D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710468;
	b=YDKytonnv4Yoeqyv2RkDrgk9fqoTgVM9yKpXgWgXv6ThMgiTgzGW2608W29mtRX6Lj7S
	 1kNe426HCoqqcsl/0NXMIwPvcnhW/krc1ltWHi6zeNQIh0+WXGYF8ibM5o2UwvC69aXG3
	 H2on42iODoSCeXun5mep6ei7W85SrPuuXoqbtQlfpw49UnvU/60VtzFLlfJH5EW7pmkW1
	 C3GEpsqc4icEU/wCuZZ3C0AKUQLJZDBVcnvzdq31coz/JxZSW1HqT0pX8SlqtxMI7PVwH
	 4lPhjxMmo6xUM7e3nytgjMmM8x9Nd2bQYH5gqlx9pL9E1meFPgsZL5LNego24SL2rJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PZBe0/JEx8k86RJ6j8RKzQrWzeGqfOkiY0m59PP3cPM=;
	b=FE9jeqxHBGkboN9MDE7kpwHLEk/9iiC+T06lDK0L3OJceFuZePWVTCK3WqQCopNkpuEu
	 nwS5KtVqH4dl8M4lN7Uv91+VF3MlNpZIpSmobe+eA0xCxvmOzB3hJWVY2D2YQTaZSjaPz
	 tbCBy5t/v/3q/JY5SaG/8VzlXtlnb+wt9YW+sFUQJKC3A/rInYKIrW439Lmq6yQ8hHQr/
	 6vr4gOBjbs9KykGxPnv9mPc5/glcuiVCLwiZJmRKt6dt6oa2oycFe+AEOuoYZDTEEyjDU
	 sX0VFdoQCwal1gbij43LuLK+wzN2b2DFpmAxAZ4jJdAuDY7ueAUOf0/Fsk3DqHVHxmQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710468;
	bh=PZBe0/JEx8k86RJ6j8RKzQrWzeGqfOkiY0m59PP3cPM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eLEoM5E+V0d1Qyw26W1pwKHZuDynCmfIAuwA/3jxkbml+WlQo7O0y33vDNZ1SWNEX
	 Mdw8NYzAgi8SN8bMplp4m+mJNKcRJHi37kn3KB1dTfwzJP47L6CbeggevGevTmAwNi
	 GEMbDhKOknl3YmcZWbqZT4pKP1wUouPPVJ1w/PCvfiTd/fMGiMBQjbfIfwZlzO60Lr
	 cwUFN/yQ6v/YfXnoyUVE9+gfL5LTziRdGaY8XKjiX61VTH6t/07ZPaKQHM9H2vFQOO
	 8Nawvobm1PQpYe0JIGRF26NYiBbtNqqtUbt9qM26SB+m2OMw8pOTVFDEzWup7A8k6+
	 kRBe19S101pbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8F58605D7;
	Tue, 29 Sep 2026 19:34:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D4953D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6E1C407AA
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:34:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QTX8o_GZWx5K for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:34:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5DDA340715
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710449;
 b=oYUdY6J8iSCQY7x8ga9x/fxtZc3IkvXWQof/7oCkb4NOlJNPnFvzQ0lxvHkQOOQEQID9
 ORZxGxPVnX+MlQSdhXvQBoOYnKluOqWdHV/A+Hz/q0wGHVoRi2dlAuerZ6WB3RustWY9q
 e9Kq56ck+wchfCHTyFgq1MQ0Ljt9Lp83EUDNjaaSQv8eafzMMn00pDr3tmqmcX+MhxBrA
 rbtpz4uyODky5hueUxcr9ffS2zhYKIiFpUX9mhXXPIi0z6BtqG8NHu5nvRRp3bWsIsNNO
 QHUnb6/pm1O1Z0cpw8NNSUztiSEadkF46WLTvh82UTSrR7HzGhziM56555d9jP7Fgog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710449;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=PZBe0/JEx8k86RJ6j8RKzQrWzeGqfOkiY0m59PP3cPM=;
 b=iyZnP46EgX9ZtM9N+1EzEj5D+9iI1oUoKIDPiGqQR6M1zn5U476t4xn0CAL/8owyH+We
 AnvnECvcgcM6XdAAb+8r+eGHOqur25nxAm8QQ6fl4/PGidz2OiACUbYKuCkSUpRFxUEgU
 AMKS/ubb3JxOqLOG+Bern2BHRwkUPo89akhpbrgd1Gt8xukTwZscU+qhgagQ2OlI1RSTZ
 yQXJKtMfDmAMzolcZJx6mgWsozs7CoIb13aKWJg63XV+iiOFXfcDc9CDbnhl4zpw9xO7Q
 MsbasZu6guw7rIZs7M0Ekp3m5cytlFYH2MT1aL/mzNQ1wtCOYnU0jbhEzyAePWjEFnw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=KyET5ePK; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=KyET5ePK
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DDA340715
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id B243BB0051B;
 Tue, 29 Sep 2026 21:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710445;
 bh=kIK8KAuKng82nTgkxb9+h6eTb6f+oRCyKGOahH1WUZE=;
 h=From:To:Cc:Subject:Date:From;
 b=KyET5ePK6zQbMnRJ5XUAaAKnlAtbIUb1lB5CpTziNx9JPpEPB1oOHe3PFbbd96zRn
 rui0EGfLM4JcTiKWCgyyrWTxaclcnAxfblKmtKBh4GfXk4ERrIhjs45WUBa3JG5SbB
 uteXR9515M8Le58W95RBHhXubcn82bfTeKr5sHGNahVYTzpDLjb6QWgBN47LyFYhYc
 44cVDxSzc8fVHxCehoD1T/+uuU/ssqN0piumQm5kQE4X1wHMOGSgc5XIQjZb1sqEOW
 7nX89SdwQ+EKbbzXWlY5fy+mVoZ1o3SMu+49lkRXrny6p/TBcAEmEhFrYN7LBxGzlQ
 UHIEzervwx+rQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 00/13] board: lx2160a: runtime SD 1 lane configuration for
 LX2160A boards
Date: Tue, 29 Sep 2026 19:59:32 +0200
Message-ID: <20260929175947.1379710-1-vjardin@free.fr>
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

v4: https://lore.kernel.org/u-boot/20260928101330.881662-1-vjardin@free.fr/
v3: https://lore.kernel.org/u-boot/20260916211549.3432913-1-vjardin@free.fr/
v2: https://lore.kernel.org/u-boot/20260914170417.3052423-1-vjardin@free.fr/

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
 board/nxp/lx2160a/serdes_split.c              | 538 ++++++++++++++----
 board/nxp/lx2160a/serdes_split.h              |  16 +-
 doc/README.fsl-hwconfig                       |  63 ++
 6 files changed, 520 insertions(+), 111 deletions(-)

---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: for-upstream/lx2160a-serdes1-v5

-- 
2.43.0

