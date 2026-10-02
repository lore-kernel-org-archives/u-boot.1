Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1682ACA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFC4360DCF;
	Fri,  2 Oct 2026 21:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hGitlIWUylfu; Fri,  2 Oct 2026 21:31:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1AAB060DCA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976688;
	b=G88HGBHqqbm95cAW20lJ/WcRhhkEQZgZyTaDaiZpPhqC2L2K/rnXyacYpSrlDz7YSHKg
	 inmOhb+KujAqQZq8dUeF+PbM1FJtta4MVoQ/GKCPoVXBEzqAIv9yFBZ1fflrqbhzCiEuU
	 oAkAW/hxcG/Q8xNXQk/kT/NYlmwFt8Thov4XKfYoVI8f7kVAZ+dIJzz724IW84H9rCNVq
	 3mccsaALnpgtqRQVaRffNAJEw4S8Jyqx9m9mP2xIn9Q2TVB3jsgXsD6C4DM7Xq+nkCdoz
	 JQQhSNowdNNfSIfjqXbIbd1dKKvxzXtrlfo/X3RMap1aOHLfhxWqKuMO1MFeGdSMGSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oAAlnwDzEXo7cxU1QjhSd6BKwqKUe1nstcqbO2MOi0Y=;
	b=dk1GyZ4xVEDbwnR0XPF2GhCaFBOijl2OhBdTWp06X7h/HF81skNj5zqVoo+FHSD364Rh
	 pm2hcJcZ0S5sw5LhNzEe8L7qDZwyKb2oOISwMVOKN53z7CkGHk0FJbR8S6byD6epMMRjr
	 QeZ5BXMz6q/w9yqm1o63uY8WoxnwsqF8t6B93CbkOBc5//joj7eBfaT2JTngCg1Em6noe
	 zNiWLghjzRvVtqcUVfbSIBykQU80QXqgc98O/KTE8pLaBFpEdRIqJz+CVCQwuM6jao3+W
	 gzkvT9ZUKClppkS6jGITSr5S/UZ8HlK2JU0QxGeitNpRj+em/dpI3ot+PpmUbBYoZ4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=uolGFRkK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976688;
	bh=oAAlnwDzEXo7cxU1QjhSd6BKwqKUe1nstcqbO2MOi0Y=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIAkV4c8BkxEv8fiDid756IVxpJ8TEnT8jvYEQExJq3NOZUkTTFovlCtml1qwo0oN
	 lohMPYlqH7eQHrn92gYqrbDwM9uZFL7PFPPd0l3Js9Q/8keylcuk47unQFooM3Z9tq
	 K8QCEIA3k7Cx61sG8dRhXRbCFgb2UgtaZkElBxG541xUAnQcG2bPKne1lZw65uGCl/
	 O9PRm2dmyDZimtyPHMSEFyOO3DKNg+IE2GXUotMYqKmD1ymstoZFf0EI1uOHP1oqgr
	 u8QuMiEczkkdaBoBbKFIIHPZFtZKj64KAGwp4gM4thiRbVt7Jys2N6feeQxl1zv5M6
	 Rc0wooqT4v4qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AAB060DCA;
	Fri,  2 Oct 2026 21:31:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E44234E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81C8B60D96
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Np_Eid-PQGhD for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:31:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C8E9C60D92
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=37.187.220.204
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976668;
 b=kwAbxYLsg8dFmlFf3cDgC0/opnF5YnqE7B0MvSqP5yvy57gA6mRLgQkAE+FcNF11rhCi
 pJtXBDnkNAgCa8oiT1Au4UvRS4LNkgTW0voy96oLE80TXN21upRq1Az+SamSTQNzsh6rh
 9moUT1IntlRmAbZb+EjnAORgoKExTn5kUT0nMB9Ct8CxBrVAuuo+3cnvyk0aOECeVySbR
 Ry6UC9tQiG4u37OW4/7/VPPE4X4dIIsjTqDJZ0Udj4+XEefCzAS+PiyYzCY1m2/LpSN54
 trv518SVUiefRiOiKB2WOmikkMSnxC99ndHL4Fz93LmTzhyhJChIJj0ZG1fBTCqJkcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976668;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=oAAlnwDzEXo7cxU1QjhSd6BKwqKUe1nstcqbO2MOi0Y=;
 b=JH9agFPuoNttwwSYhhwIExPl28rdrTuXy5Pd5Xt6N4r3Oe76Z6azeZvfYmOOHCVQHBzs
 yPITI1juMjxlzfZL6Tep90fQzfbR1aoGLLK/IzSWFD5SNqrSMp41ugYsS3Qj9vaBM3mzK
 RpFjJHMzT/9H+OawVUHi/CBn4xXyCtKjAqAaFgfWcL1diRyjsyMDiKPHQgm4oF0CbyTXQ
 /1FhtdPaorpj9nZpQ1SuvAT1GIVT34qt6expS2BfWsddJgx0U6Tu++dHK+62jFg0rlgIm
 pOQpGArTmP5p9FUw+JE/20CocXwgm2V239TyHD0tOWJJZVCwD/VgdnWEYaz90u/S9wA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=uolGFRkK; 
 arc=none smtp.remote-ip=37.187.220.204
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=37.187.220.204;
 helo=mail-07.mail-europe.com; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=uolGFRkK
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com
 [37.187.220.204])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8E9C60D92
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976659; x=1791235859;
 bh=oAAlnwDzEXo7cxU1QjhSd6BKwqKUe1nstcqbO2MOi0Y=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=uolGFRkKPDeZPpbu5E7SoncSwwNYS5efB6dotjiHRqCYtWFxxuxbjfnfVD/lONSB1
 M/2U1w+1i+wkz0n0b+bfn292C1y74tYcZ84d1ownx3g12N4B8CZA8cV8bbGHJCcoj6
 fPoxmE6QzKQRyMamOO1Lz8FHinJr2+4jA1HVHarhvewUSzFjDiwHPKcJKjJ8smw2w6
 UJzbRlcM9vhJK48fT6VGJk3dbljNbLrGs4g3WrDRvPi9gkWJcVcRSX5ibsCP13hQwB
 7zJfiC6hMzvx0yPv+OiE5QZqv/pE+qWjatNDKjqq4wYt10C99huwNJW8JCXiPlUI4Q
 mn2mFsnk373hg==
Date: Fri, 02 Oct 2026 21:30:54 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 4/9] pci: spacemit: check clock, reset and iATU setup results
Message-ID: <fc3c34a14be221f72a3e861a9b8bf82df88113c8.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 2d52e826920362a38328d3980c5165678a6d753b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:31:20 +0000
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

clk_enable_bulk(), reset_deassert_bulk() and the outbound iATU setup
can all fail, and the probe ignores all three. A controller whose
clocks or resets did not come up is then accessed anyway, and a failed
memory window is reported as a successful probe.

Fail the probe with the error instead, as Linux's driver does for its
clocks and resets, and undo the clock enable when the resets fail.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/pci/pcie_dw_spacemit.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.=
c
index b85de73ad3..5e0871986b 100644
--- a/drivers/pci/pcie_dw_spacemit.c
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -230,8 +230,18 @@ static int pcie_dw_spacemit_probe(struct udevice *dev)
 =09spacemit_pcie_toggle_soft_reset(pci);
=20
 =09/* enable pcie clk and deassert resets */
-=09clk_enable_bulk(&pci->clks);
-=09reset_deassert_bulk(&pci->rsts);
+=09ret =3D clk_enable_bulk(&pci->clks);
+=09if (ret) {
+=09=09dev_err(dev, "failed to enable clocks: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D reset_deassert_bulk(&pci->rsts);
+=09if (ret) {
+=09=09dev_err(dev, "failed to deassert resets: %d\n", ret);
+=09=09clk_disable_bulk(&pci->clks);
+=09=09return ret;
+=09}
=20
 =09reg =3D spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
 =09reg &=3D ~LTSSM_EN;
@@ -317,6 +327,8 @@ static int pcie_dw_spacemit_probe(struct udevice *dev)
 =09=09=09=09=09       pci->dw.mem.phys_start,
 =09=09=09=09=09       pci->dw.mem.bus_start,
 =09=09=09=09=09       pci->dw.mem.size);
+=09if (ret)
+=09=09return -EIO;
=20
 =09return 0;
 }
--=20
2.55.0


