Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18EECA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 18:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0AE4406D4;
	Mon,  5 Oct 2026 18:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qiKBKxF4AP4O; Mon,  5 Oct 2026 18:04:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BBEB0406DA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791223468;
	b=F8jJ/XXWn11koZNV658M9ElCjUEsNX6OpcfxnfuMQVwKEiy/qq6ePxNABAus8PeKRyZQ
	 zOvlEYPu5GyRx+oJ/nxpa7UNDGrP8hSiUOLU+jp3tGmtFK5RqpAuZKD0wxaozAi3vvxrE
	 M17D6VJeThKjeB+Xgdep9+IQPx3AmQk4RtOgitpidrzS/gc3N88yjCU8d3+05aYWJfTQG
	 Jibo0O9oE6tX3pmG2cZV8eAMKqO/V2t8159ts/SrR6ADcSCIP7E7kpR2lN78dMH1GTewn
	 HfNqLpFda0Jm7bSI9dILQI6u2VzE27b/yFN8jj3PuE4Vd/ZfBkUk8Pbl15DECTyReqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791223468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2RCa0KF9eSUGIBDrDyFxWFLGKGTYt1eIRYJrhlB8ZSQ=;
	b=pV+AD9lTu0LiinA/zwcfHuUNzxIYXzPeGd+SqZl52VpzEvZV0+e7pVV83lteFYcsP3//
	 U/6I3rLMk0UY/sMDmDyCqIAqqewbagCu3QTrXLeL6ZB9ZVmcCl6BFcM+DZhbD3OgGLLEa
	 huLGDoeRIfMBSa+lwUAAIjhIR+ciODBYt1a9cAiS5A9o7FNzhStfkr/OJZMklBPhJl9In
	 oT7110y8h/4wrKaP+Yi6EwsKhahLRO81/XPq5tQId3efiyD9iTUwZpqSnx3prQuCAWcpb
	 kR5+Ouk1bVULv7YRwBWkOc337yE/fddZabYN8cip+11VSfKLlYTJywjihouQ/NwXOAg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791223468;
	bh=2RCa0KF9eSUGIBDrDyFxWFLGKGTYt1eIRYJrhlB8ZSQ=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XANBF7XU07wjCnRWaRW3Y1N46NZIA3qmr/6xUejNLOgWuSlj4tqpK16dDrPcwEmFR
	 eJfJkFrIiwX0lJnG1a2x3ML47QdLyMHin7ujDSBy/GvE4Nv93BkwX+ulUL+qCM+4dc
	 nWcuKBRXnvxEi7PTZ4gFisy+rYxt6vTvvHEjNarhLAQ6pZa0oFQjXjKWuY1gR0eUgM
	 FiXBESMHtzN0yiNceN3YUfolbdHMTryjGYw9TjmxANEUq5DlDhud/IA4VpefvHnMCj
	 75JA3IeJYhKGkmfJ56l9R3q/chdPIOt55ZGckKWhfHXfCNbt6ze822/fuSg5JGfPwM
	 UZOyntBhjLW2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBEB0406DA;
	Mon,  5 Oct 2026 18:04:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D31E22B
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 18:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52DD360740
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 18:01:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8OhEjJABkco for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 18:01:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8519E60730
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791223294;
 b=MKfOwGblfIDThD7R58XPKofFyUMttHl9VGaAydTl+/0S/a0LJFRZ7sQKHBAtPhhx1JdD
 /bbLXKQJtX0tNmEUE1z+k44xu+kH/VRKnn0Nu9TttuWPAwnkDq1dknn/I4505qNlhy+z2
 ZxC8zOcCegY+kbsvqB1YLPRYc7vMHGzOB1hYCpR0D+lvBoJkq1yCr7aYoJ4FN8U7lJrUt
 U8oMzMG7XaNJFGzoGEe4OJP85sqdjIqIfpW4ko9koWoOw7sS620G+VMsiyAH71VEJs3oB
 ahoAQfdOTg2RlHutXqjSLrXaMSrl95GodvSGFUv0uyvYn3Hmd5TsAhn+2XjY+G7cR4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791223294;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=2RCa0KF9eSUGIBDrDyFxWFLGKGTYt1eIRYJrhlB8ZSQ=;
 b=tc2WslGGt+4Xj7eE6nxsSoK+0ippeCIAvrfNy5fc7K4QgWKqlbB8EU7YafrR9MxmW0dN
 +KtFwJrYqnaf5p04hQu3+iDaZuqRSdUjPo9XHINjVbxQjFYxs7D0io0WwrY/yxwE9exUr
 zht1oO2wf+UVaMYjXEVBXyn8AIdnYLOcsn69r+siD5y2WgRKSGNynT4jqWhUd49B4QDzx
 PCTLIwo9Tq5LKHhDGjcBD2s6FXfKsu77zaKvjKZ38a0TYo2m89MkiYubzkaGV7o/+dm04
 qnx48jqw3PA3oKCO01jHPbUIPVZk0AZ40n61dmTKTOkWCZMbuxhgEc1zkB1v2HzayUw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=o5O24T0i; 
 arc=none smtp.remote-ip=79.135.106.118
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.118;
 helo=mail-106118.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=o5O24T0i
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8519E60730
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791223291; x=1791482491;
 bh=2RCa0KF9eSUGIBDrDyFxWFLGKGTYt1eIRYJrhlB8ZSQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=o5O24T0iRKmw5qM0b6SCEMVa+Z2Va+2bhTVagBY3hFlShT0Eoy59nmTOT7cy+mefB
 HiHnid/k4e8KIQHYrc+XQO2CtgjdbHjX0uMfs1aqxKQFeMW0dh7i30FjTwlq7dM4ta
 RSPmXktvmDn7maP32th2htG6AdXsL2zImyleM39p4CGUe814l/IPfEvErPejmSlGYt
 YXxNaDnFwJsxZDYiUSZkqrK6ELt7/cZugjxyi5qpf7iDEknB7h424pbuWbBtcY8cmk
 9fC/xyFR9DA6NBxs7WLAJPcVaMdfnihk/KUpLp6VnUsQ8/1KAh1u6FHb7r6aLxqJvn
 9ZhpRr+nKdK+w==
Date: Mon, 05 Oct 2026 18:01:25 +0000
To: Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one block
 at a time
Message-ID: <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
In-Reply-To: <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: dec3198e754e344f3f5a3358871f29c8ff632a20
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

spacemit_sdhci_get_b_max() limits every SD read in the SPL to a single
block, so loading a ~1 MiB u-boot.itb from a card takes about 2000
separate commands. The controller handles multi-block PIO reads in the
SPL: the OrangePi RV2 has loaded U-Boot from microSD with them through
the v2026.07 and v2026.10 trees.

Drop the limit and use the host's b_max.

The merged v13 cover retains the v9 changelog entry choosing single-
block SD reads in SPL. This reverses that deliberate policy for the
recorded RV2 SPL boot use case; no general multi-card reliability claim
is made. K1 does not advertise MMC_CAP_CMD23, so the MMC core sends
CMD12 after a multi-block read rather than requiring CMD23. Additional
card models, cold boots and transfer-error recovery remain required.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Validation: unchanged executable change from v1; exact-base source
replay and checkpatch pass. The corrected combined integration, with
separate clock/MMC and DDR relocation fixes, passed SD SPL/FIT and
automatic NVMe EFI boot on the 4 GiB RV2 in a warm-boot trial. This is
an integration result, not an isolated test of this patch.

 drivers/mmc/spacemit_sdhci.c | 11 -----------
 1 file changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index 6488ae0fdb..4284553177 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -324,16 +324,6 @@
 =09return 0;
 }
=20
-static int spacemit_sdhci_get_b_max(struct udevice *dev, void *dst,
-=09=09=09=09    lbaint_t blkcnt)
-{
-=09struct mmc *mmc =3D mmc_get_mmc_dev(dev);
-
-=09if (IS_ENABLED(CONFIG_SPL_BUILD) && mmc && IS_SD(mmc))
-=09=09return 1;
-=09return mmc->cfg->b_max;
-}
-
 static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
 {
 =09struct mmc *mmc =3D host->mmc;
@@ -574,7 +564,6 @@
=20
 =09spacemit_mmc_ops =3D sdhci_ops;
 =09spacemit_mmc_ops.wait_dat0 =3D spacemit_sdhci_wait_dat0;
-=09spacemit_mmc_ops.get_b_max =3D spacemit_sdhci_get_b_max;
=20
 =09ret =3D clk_get_bulk(dev, &plat->clks);
 =09if (ret) {
--=20
2.55.0

