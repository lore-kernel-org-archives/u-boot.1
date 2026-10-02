Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4F1CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9866A81374;
	Fri,  2 Oct 2026 21:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RdDqtHJe3ML1; Fri,  2 Oct 2026 21:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E4B8F81372
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976661;
	b=snQqaCV0Q+0+0EvVTsAUYwrJH915OMXD93CN8+GcAj7lDkGiOYzmNalJmbHwu9Xia9ww
	 YJkgNAk/7OG1mfdVPYzqhtX0BNFeOtgsA5xH7bZogENeaWSnKBnQ8uHhrKwtvMAdohVAy
	 dz0cKjnUeJH4TjgZwYBUyxLvzENAkHGmkmbG3aQIoZi1r+2po2DCy1TSpwSHVGklN7CRo
	 Gjqxy/1OGXmyetkz3tZyp1ypFbrZ14jRG5TDi+zyGYrdj2wkeYo2/VsamhUfvnEEVywKk
	 v8nnlo4K5uGJHF+stoUdxxpjG6KG+1+0VuPpVuJ1wWHvEtVCiwW27q9LBoepcKvAD4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5Y8J6g4PGEqa1Zc0naNRZiHYei/res8zPr37GfU0QFk=;
	b=PVMhzIpXNCRwd+YEQArjkNY5YblWyr3+f+PMl7UdwEUOL77eVNHsM2/1YXLqac7teTs7
	 0w/vFYCR4XGb92MAfK5U8TaTrNty1e0aUWpF4T1M/6uSeXe/Em4fFZPY+n4G8TMqlSn5e
	 OtdQf/m/7MT/gsQZQtiNjQglj2kvijC5O8IyPpAWdZO8br3ogiSlnoYBjeAG1zB9TV6Yg
	 NLgstJW5vxWXFexmD5lBmf1rwLfMqZZf6+vq2KvfFWB5OWiaVoO6anzovlkHNEYJuvx2G
	 noRGlVZgU89DohQNuft66TbU++jXC5SnHZLboVEzKrVCKh6A0sS88ZtssM7ifvb+qHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976661;
	bh=5Y8J6g4PGEqa1Zc0naNRZiHYei/res8zPr37GfU0QFk=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wlEMIorX67fDeiyX3gmCdFAbDIQ5n4Ie9QfCZQWytTt7CtGWLybo9HCcLo6zj633m
	 QmdnKJ7H4gdh5ecwe/72f6+HoKPytT6sMMO+oPr9gEluRPCZAXW0ap25Uy0nSI0oZS
	 dUXZrDxb7UWloKd81hOb+bGdTeZJv0d+47CmgLF1bouYuxHu4RhKaYdYvwa/tb1SFa
	 gUt/SOTtRcLtSr2Zxcjt8yuUB5Ex4g1qDxytCYM/9yF6fftM4odyloMbklr1ORuq5p
	 QQNk6L6pFSCLN2UO8qXP6fBwu9xmkZcLJ2SC1LDHH5GsGtdj7Eav//G/U8E+xv8Pcq
	 fI997ns2L78LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4B8F81372;
	Fri,  2 Oct 2026 21:31:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BF6D34E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F23E240590
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:29:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D3ihIjmIx28v for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:29:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0875740585
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976589;
 b=tgb6dfcdQXeXTuPKoHUZ2sqnbK08lsrCGPjdKUO1eMobNAhX+4UdIuSfY2GGLLDikrJG
 E++KGbUjpAqr9kZRloMXqrOm2NNVaiqLSUmpkQMsRYE7mLEFVpaxkDAPoZVER3W+gqCZ5
 5bIzOFuoiLxUwXMqOBj27kqaUXtH0XfEzmtBUb0WEwUsAaq4KWN5jAvSA8SlqNycOSsGo
 4UQgXMbI2Kg9z07xHiDF/yyjF7FdaOHg/roLiLjytRvwl2Fr474B1jzFguoHkBsXyYtOz
 max+DTeTqqzde7RlI+1xlq6oS1XryWjbcoacXy7EPd2HcRpEwWQFcmoXDo83Cgo3qNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976589;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=5Y8J6g4PGEqa1Zc0naNRZiHYei/res8zPr37GfU0QFk=;
 b=jv8c6jVNd3FmofjyaWzltmuTFihaygdYUsE95EjIi9xu3e/c2hWV4VFSnimikUuHaIH8
 QYGZtAF3UAEkn0CzTGV+cWcL/aQGDaZrK7CrvPCn3H1gbPT836ZDVQ+hZAyJ9EH603k5D
 xP6hs36Ut9sKWn3+fjxJLoYaGDO2x3GnZqnJp9+RwMuATSFpcr6RvJ3nj2ZMnvTzKsZP6
 xlcuDhpuJocNIWm5JDMs4KMOmAiPs9aFOazsJCXUQ8i7Q1iYuPkDSih0Q7u4WYUf+mz6b
 Zsi7jvjd4bhLv6gehi8PTZNllM7+2PVRPUUh92or6vBOgak9hqo+McH0a1Av7CNWx5Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b="ozqW/JHT"; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=ozqW/JHT
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0875740585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976580; x=1791235780;
 bh=5Y8J6g4PGEqa1Zc0naNRZiHYei/res8zPr37GfU0QFk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ozqW/JHTPY0IKqF2DgBW+cy5gAOKqpkVZaZDSL8rGEhMJqUt5IbIN7a9RUeSE/8LD
 kEUOBfwqzYr9tVM9ijkEh+N3OZciJT0LE1Gr/2XCoaofsZmhTLn0rWQz3A3cxsaxa3
 ANYp2tVE1w6URnpmtTt9JtC2f/K/CCUE0+Cl6UAjcFwZvcl3750ARjLbLCV0uDhnCQ
 0uGZfXKefnzUhN0UEjBZPGRAAi7KWsT0bdrg701NhJhkSO9ftq0jbh/6uNtv92wGjd
 0NxoTyEhVFhH3NmjqQHC2LrqRnSECArJf7WqOaoGhNSwhQ3+khj6hUPREwuiphwwHJ
 Dk0WpYcYsK6UA==
Date: Fri, 02 Oct 2026 21:29:35 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 2/3] mmc: k1: let the SPL read SD cards more than one block at
 a time
Message-ID: <a93aa8e53d5ebf81a61be873d935c4e37cf5179c.1790975596.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975596.git.DaveWK225@protonmail.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 3cea765de1d7f02ef782840b69af6045cf7a467f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:30:59 +0000
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

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/mmc/spacemit_sdhci.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index bbd49b76c6..fec95e3bd7 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -324,16 +324,6 @@ static int spacemit_sdhci_wait_dat0(struct udevice *de=
v, int state,
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
@@ -574,7 +564,6 @@ static int spacemit_sdhci_probe(struct udevice *dev)
=20
 =09spacemit_mmc_ops =3D sdhci_ops;
 =09spacemit_mmc_ops.wait_dat0 =3D spacemit_sdhci_wait_dat0;
-=09spacemit_mmc_ops.get_b_max =3D spacemit_sdhci_get_b_max;
=20
 =09ret =3D clk_get_bulk(dev, &plat->clks);
 =09if (ret) {
--=20
2.55.0


