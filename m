Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08F3C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A5E280DAC;
	Mon, 28 Sep 2026 10:13:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xaITEG8YMzPN; Mon, 28 Sep 2026 10:13:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2604180D7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590432;
	b=Zy5RErjIwiHwTz1OUgp3Q8gooE1WFGUgJJ6omk+vz94t52EnDTj+rv6S/jlMv5ocylbm
	 lzsIli457pGRQ7fTlQU8RXeXv0pjh7c2t7gGpnf1sZ1X4qxcbAVpyd6c0LFnzRD+2apvw
	 6VA5fMvayM4V9gWGoChjO1N1HUlmF7yp5t6IAsNyjm0P+hclK5lO0XdvMPEdg9mkETxN8
	 HsgdLaSty0Dt4igZT/dGpitJVyhKmjvdGpkjkq3fHqDYV3UEpG0aZPmyNgP9zI6/ZI3cf
	 RCGteWvAkEz8WoAa4OiXA53CbeGaE3tX7x6jV6NOSb2TiJzfxqVjtymJJbfvjuPAPzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590432;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BxBA/1p5lgcHYESH4GtNVnmYWPbFreEkmn0Nn68wI+Q=;
	b=qkAIVJifidWy+xX5GI00gpi1f9ysGso+I4u3H36CRrx9+PdcLTQLZPUFS+N1M7hKoqSk
	 vVmm5t3t6AMbBS2bD3pT5QFEdWikUJPZWWjbAPvoWMs/OfmnmKHSSMsRm2pjHmDJXlRmY
	 ZNm8t4TrvK3Uydj+YlB1rBS7EQ/1nu6BOvNnTZopzkrZWcrhn2MHtbBYZU5ZdOib+jvVk
	 NYcJf2OhCONUlcejBolCwROVmJsWMg/4AsyMCHb9+1i+qIG/gLFU4gPgC27Mbdo7HkTU5
	 OVr04nZmUl46j1csWY41NsfSTYYL8Q1OphmNVS+6O5uawSOk60EcG72hsRfb/vKk8sg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590432;
	bh=BxBA/1p5lgcHYESH4GtNVnmYWPbFreEkmn0Nn68wI+Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gBGTZ+v+Fjzd1FZOMIvtjiAhCc0o4noWwyMKPUx05A5jZqesnLde0gmNDePy2WfkL
	 e437nab62vlcihGDedpAyPccZ/QCx9QplW4Pej9YG4By10ViFSikTG7NQIUiBB2h71
	 K8qlfmeHvaTuFmZelHEfg8IGsJfbIBc2mffTCMWGZqrWeyYmGMQ1GKoBn9PZdAEfIP
	 zM9BITnJ8QFk+77vMBLzLd/Mwyg6pKzexS0FcPlTpmDB211PbSZhpqxQbzpLQFqQ0f
	 AAEXjG2bWBVDHS96QA1dnPcPo8kx1+fMm1fzmr28m46zN1tQVSZBPPcgPSmJWXZVQk
	 6CzCrncpB28ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2604180D7A;
	Mon, 28 Sep 2026 10:13:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 16BE2361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF34B60681
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FOiCizkgoLKo for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B355E6067F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590429;
 b=LRdotQxh+SFrwVIaw47m48FTfZ4e31e/2kyZrwW6fukcMFCmeheoNCEiX3xGe5ABh3hb
 2f/Xz8OMKMmfhcJqdiJpoZPI/pujEt7etKk+0xplMp+1FAXZYFg8cwKNA1KCwDJ93f+ae
 13JC4sqsbTMC8f6BC5ekT5uuX7OzzoblnpwhQ+IO8cHTYLU9qQGDxSDko2Ib9+6uq9L5H
 KiNILQJ5EB9kXWqVbmTg2ug+9H2sGUSeQTPfrwIVjEgrqdHXN6RfabaJ8spM7lzVuzixH
 LnSAnhKI2JdOZT0v4myN+2aLZYkho5NsDiQCDrptJ4/F2HIwv3WgUphiRlRxa6iuXeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590429;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=BxBA/1p5lgcHYESH4GtNVnmYWPbFreEkmn0Nn68wI+Q=;
 b=OdlL3EdfF9CGk3iDSghWujODR9LVTV3uKpNfj+7bqfyBaQfpDzKHxrUa6KoX1RctdtQz
 x391M9545EeRzyIvQhvtWxJecXsd4cA03Gc0HgO+ud103WuNBnh7g2UoUQNaXRvKPY4c9
 8oDAD47/UVIyRbPbfV88qb/CRDk3K643fKd6rNwZC1UWg5C/PPsZnM+iBnLfta6WK7Tjw
 cpW1qWtKhG/SY1cUy8oRbIHSahxpRPKM9pAmfoz3y+HC6JmXl3d728i8zWHdM0dS+O87g
 68xHlWMVLoV/oKooaHviKJ6u+0E8SSlYD3MTArqRlNxB2EfrSkOtvI/xRVj0mQdi7Fg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=PPrSJClG; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=PPrSJClG
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B355E6067F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 98FE7B0059B;
 Mon, 28 Sep 2026 12:13:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590425;
 bh=035ucvoyETl7C7Kbkln6ERkjNvI+fKfi9rwfUw+D/5Y=;
 h=From:To:Cc:Subject:Date:From;
 b=PPrSJClG7VUDRl5PRtzI428ztld5PcEBYfSMzds83+d4AXIWmvlVspRwVZNavZpgU
 lLXOQE0IK62MB+A4mdym/0Tr4WhhrJUO5DdM1S4dNVg3mfjcIY3EN4P1nAonRJZZHQ
 /QtufQ7wtN4Oeru7/BkDoyRBJJiAQSTb+0y3zhFBpV6GXasnJkxAc8FkEmeY87r46/
 7aW/g9yHFakHe1I+6QpUVah9gjePsnivsOD3Vt08Tp7WfrRfkcDjfstlM3608WjxQI
 YKu4j8jDlb2iwbY+hLj5QUtdNvOr9Dpxuz1yKYwTghMKpxEW23NhFRZg+qLpwD7FfL
 WWHmBnfBwEyeQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 00/10] board: lx2160a: runtime SD 1 lane configuration for
 LX2160A boards
Date: Mon, 28 Sep 2026 12:13:19 +0200
Message-ID: <20260928101330.881662-1-vjardin@free.fr>
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

v4 builds on it with incremental patches to ease reviews, but with
many reworks:

- No more command that re-groups the lanes at the prompt: the MC has
  already started. Use hwconfig
- hwconfig values are named based on needed cases:
  serdes1:split becomes serdes1:100g4x25g (patch 2)
- Use a table
- One patch per new mode: 2x40GE, 1x40GE + 4x10G and 1x100GE + 4x10G
- Rewrite documentation
- Add and apply to nbxv3

It is now mainly tested on a Nodebox v3
  setenv hwconfig serdes1:<mode>
  saveenv
  reset

- print checks using lx2160_serdes status 1
- in Linux, with the matching MC DPC, DPL: each case has its netdevices

v3: https://lore.kernel.org/u-boot/20260916211549.3432913-1-vjardin@free.fr/
v2: https://lore.kernel.org/u-boot/20260914170417.3052423-1-vjardin@free.fr/

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

Vincent Jardin (10):
  board: lx2160a: serdes: drop the split subcommand
  board: lx2160a: serdes: rename serdes1:split to serdes1:100g4x25g
  board: lx2160a: serdes: set SD1 with a table
  board: lx2160a: serdes: report unknown SD1 cases
  board: lx2160a: serdes: no SD1 config once MC runs
  board: lx2160a: serdes: add serdes1:2x40g
  board: lx2160a: serdes: add serdes1:40g4x10g
  board: lx2160a: serdes: add serdes1:100g4x10g
  doc: lx2160a: document the sd1 hwconfig option
  board: nbxv3: apply sd1 hwconfig before MC starts

 .../cpu/armv8/fsl-layerscape/doc/README.soc   |   7 +
 board/nxp/lx2160a/eth_lx2160aqds.c            |   4 +-
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c           |   3 +
 board/nxp/lx2160a/serdes_split.c              | 588 ++++++++++++++----
 board/nxp/lx2160a/serdes_split.h              |  16 +-
 doc/README.fsl-hwconfig                       |  61 ++
 6 files changed, 556 insertions(+), 123 deletions(-)

---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: for-upstream/lx2160a-serdes1-v4

-- 
2.43.0

