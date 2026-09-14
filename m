Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E9EC88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 17:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82F064055A;
	Mon, 14 Sep 2026 17:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CtdOo_XI6Y_E; Mon, 14 Sep 2026 17:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AAA6740532
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789405485;
	b=MkeuhFdBSKS8g+ZYej9HaMrTFgb1O2maFbdWEKcmMQIwJQj1tBGc2Woui5cBpglvnRjL
	 V7GqU+NyRMdq8NZ9lk26cN1rSwrxYmI0j5UTOWW3uS4WbaqVN0L7RFu6CSimyKSHGX6JU
	 XQjG9etDyDHzejf50R3WMiq6OE6MkgGc+3ZuAYqsUNb7nYm+weGoTkUUbB4grS+Mrfy25
	 fnnvq+o5RAwF4nA8Hrv7V+tqwUMLth5pXtXCTKhMiRHWH2t+ljk2qx412HD66JzZBZZFV
	 zWzi9twrh12f1cqeyn8RxWQTHh2M9yuHApsMqUiHdom2AViFHBsPpqBc1mFFSSDZcCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789405485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FlxDbAMxYB5WDfCrWkjLAIgXTfbES7Azq0aGy4u3Wew=;
	b=rVKeLjaphno2pOV9WYJONJXdRyhDpQXKntM5iDXIve0dBir1EuUIoYFmEY9yC/dQBM53
	 31+hB/p0hcsmykzIBjNnXPW3Z14nJNd6ZMpSO0Y088ZrYA51ExntuQKAca4AF80F5QwbB
	 dfQkqPrJM+IBF+dQhVgBPIjuEcBAfe7UybHXzy4H+bezAPyyGqBTibTmzzaqsbR7SA/Gq
	 dLii2KF+RSxZErfJ0ieYRGijsY5gqN0WPD8fC1axTXy99Q1BUQB9rJArePMYE4JjOFeby
	 Ik3UxQjaxvlD3ROkd75TCxDFaWZTXTJ7wmsXluboWy1Q2n0Hgy74yk5e/nrraCvH2AA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789405485;
	bh=FlxDbAMxYB5WDfCrWkjLAIgXTfbES7Azq0aGy4u3Wew=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oo0WpVoFrYYup8R3UCE1qIzruDj8TMuHpWAdEN5I4MOHliiZLOOX/Kl77eAM++amn
	 HnyAXWZG+eIFoimfLvehyr8dLj7js1FVgSqBWp/IXb/hI/m2ZqrLEIPLDCSwtfx7+v
	 CrRTlYXGFiLsdsGdDu8HIrdMuJpdD5nQdaR7HhAqeDnWU7K/qrL7KwASINGuNBUV9R
	 7jngxguWFVim71vsCQb8Q64nkYCPKKLEVtJY6mrCTeW+CxIAUnmOy7O0aUY6MP2F8h
	 QUA0qta+LIBBR4kFQklL/JT6zKoKqm++kfbc3aw8NvRBFWKTq232QJfFbXdpkcJ0fI
	 zqJflI0j9aKWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAA6740532;
	Mon, 14 Sep 2026 17:04:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82789259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7472D80DCA
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Efzk_wSS5tGL for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 17:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B0EFA80DCE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789405483;
 b=Gqm4GrlQUgDHAFBhehnNQdsVXQjVLLh3C6lk37zQUtFqLsWYwgE8iBTbz/CkQWJ6MkLr
 cBQlFavdSTVqs2wI6kJNy3i9ecVoYaGpv3VWBHVHJ926X3JARFzYFkPAUCO8roS0nk+UE
 qiJIMW/YMVSoQCdmt9hpWkldTAIMZws0iICpLFGeF+QlERFk6kI34Q9K70F2cxtGctY+G
 Tg9/qYyxCYvN8/pHxiwJEHvaxVqB1D16hPHDTJWENlgPyFMdd/sM1ajrYI0fc1Eako2/X
 TywVMubfChZ3QTavt4SmBwm56ZSxh4RyjaiMfg4ZdD2DwAjQNi48zBHSqySjPcGaWYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789405483;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=FlxDbAMxYB5WDfCrWkjLAIgXTfbES7Azq0aGy4u3Wew=;
 b=lCE6L9IN95MwknQ2M1RXrckUVAvfKQ/j8cu8CTbzK0uHvU+Ph7Tu9chboJR8b4tVkf+r
 jWCPImnJRQkqOtGhSfzc4U37QJtieQpw7zGdYYtIAXlFK71/a+a3lHK9hNdk06Pv0Jq/0
 8RIM5eMfCnTIpE49tp/rHNFHTFoOLPQHv2vIxRmAajWW+TzrbbmEdfcZBtT5k6wSNNRMT
 9z2iykhdra5YJIJjidlrFhshcv2W5jzZcFnNgKsLr8iZBuge5GnSy/pnOYSZOAzhNs7xq
 uzVXqZQMjtHaq4wG5B+znH86LkD3d1MVBYY0c5cyFULEb4uHnz0SB+M9UdMqMhm6Csg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=NAP6zgBP; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=NAP6zgBP
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0EFA80DCE
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id CCE24B00539;
 Mon, 14 Sep 2026 19:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789405479;
 bh=2HlKjyoTjuohJyB8YOER1/iK+9/mEMLRsxYu1aQeDEE=;
 h=From:To:Cc:Subject:Date:From;
 b=NAP6zgBP0q5Jo1AxtmmvqHE8PqRHxBfd0YoX3M3MV/fUszDXiW1cBa7n+kQ1DrRI7
 VpONxyh+3sKOEhZwvU1wOvo5tasAK/7BZZ0BhhorG5BdDgd+twtM4+M/e1abBwWCQG
 ScrnuOak9mbNnHNTV+jvaTPJGpv3bARg9IQkkt6UoyAUlq0qJ0AVr2DC1oErMcUmV6
 dJkOLGTxK5WukqIzi4IvyazcIhQsC2xswcgCvrtcvuFHZHyaMl05wEIA6p38+4KIed
 YyRmNJGeLYlXeALjeOfswYwoz8rvxNJWpGwmVII0HQzxcFh4j0a1trRleioLAv+j4U
 qdTFLQ5TDmA7g==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Tom Rini <trini@konsulko.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 0/5] board: lx2160a: runtime SerDes 1 lane grouping for
 LX2160A boards
Date: Mon, 14 Sep 2026 19:04:12 +0200
Message-ID: <20260914170417.3052423-1-vjardin@free.fr>
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
  lx2160: add lx2160_sd1 100g4x25g and lx2160_serdes status
  board: lx2160a: convert SD1 2x100GE to 2x40GE at runtime
  board: lx2160a: split SD1's second 40GE port into 4x 10G
  lx2160a: add SerDes 1 mode: 1x100GE + 4x10G (mix)
  doc: lx2160a: SerDes 1 runtime lane grouping

 .../cpu/armv8/fsl-layerscape/doc/README.soc   |   10 +
 board/nxp/lx2160a/Makefile                    |    1 +
 board/nxp/lx2160a/eth_lx2160aqds.c            |    9 +
 board/nxp/lx2160a/serdes_split.c              | 1117 +++++++++++++++++
 board/nxp/lx2160a/serdes_split.h              |   61 +
 doc/README.fsl-hwconfig                       |   25 +
 6 files changed, 1223 insertions(+)
 create mode 100644 board/nxp/lx2160a/serdes_split.c
 create mode 100644 board/nxp/lx2160a/serdes_split.h

---
base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5
branch: for-upstream/lx2160a-serdes-split-v2

-- 
2.43.0

