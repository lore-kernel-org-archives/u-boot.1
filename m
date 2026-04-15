Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36132FA0C3D
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 07:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB60783D8A;
	Wed, 15 Apr 2026 09:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="cQzIWizo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A0F28407E; Wed, 15 Apr 2026 09:42:32 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF4C83936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sam.shih@mediatek.com
X-UUID: a4ce9bfe389e11f1ae70033691e9ac7d-20260415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=k2AckXQWidPEBLtM9u29FGeCBCTPI2jgUDsEEQhy0Tk=; 
 b=cQzIWizou2UAcW0bodh3BkvKarjaKy6bnceOS0fIIZEyxLrmKJ2yB9dfJBlz+k5GDGt4f39/cyKhcadcBLH3Hqj4qV/phta4BZWYG6N482rVIiko2n5/5YP6rxMBhKsrBeV/eUfZZN1WqE61rcgYwRm/Pgbxe3oqDexpJ7RU2mA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:521c62e0-91b1-421e-b21e-6e2e818e11a9, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:b2a7f594-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a4ce9bfe389e11f1ae70033691e9ac7d-20260415
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <sam.shih@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 907304191; Wed, 15 Apr 2026 15:42:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Apr 2026 15:42:24 +0800
Received: from mediatek.com (10.233.130.16) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Wed, 15 Apr 2026 15:42:24 +0800
Received: by mediatek.com (Postfix, from userid 10015778)
 id 27026200C6; Wed, 15 Apr 2026 15:42:24 +0800 (CST)
Message-ID: <cbf94c5bb1dbaa6c6efbbdc37be93a2858d14685.camel@mediatek.com>
Subject: Re: [PATCH 2/2] clk: mediatek: fix parent rate lookup for fixed PLL
 clocks
From: sam.shih <sam.shih@mediatek.com>
To: David Lechner <dlechner@baylibre.com>, Weijie Gao
 <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Julien Stephan
 <jstephan@baylibre.com>
Date: Wed, 15 Apr 2026 15:42:23 +0800
In-Reply-To: <abe54929-2f66-4a3d-b08c-65a03cc32fd3@baylibre.com>
References: <fc7c50ebff2932b5f0a237c3fc492aefba3a0292.1775786729.git.weijie.gao@mediatek.com>
 <91c2295c6677a94ea34089a52a93487d8ff7caca.1775786729.git.weijie.gao@mediatek.com>
 <abe54929-2f66-4a3d-b08c-65a03cc32fd3@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: git-send-email 2.45.1
MIME-Version: 1.0
X-Mailer: git-send-email 2.45.1
X-MTK: N
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi David,
=20
Thanks for the feedback.

We will follow your suggestion to move the grandparent_dev declaration
into the else block where it is used. This change, along with the
other minor formatting/cleanup adjustments, will be placed into the new
patch 2/3, so that patch 3/3 is limited to the functional fix for the
parent rate lookup of fixed PLL clocks.


On Fri, 2026-04-10 at 11:07 -0500, David Lechner wrote:
> On 4/9/26 9:13 PM, Weijie Gao wrote:
> > From: Sam Shih <sam.shih@mediatek.com>
> >=20
> > The refactoring in commit 00d0ff7f81bf ("clk: mediatek: refactor
> > parent
> > rate lookup functions") introduced a regression where fixed PLL
> > clocks
> > using mtk_clk_fixed_pll_ops are not properly recognized as valid
> > parents
> > in the CLK_PARENT_APMIXED case.
> >=20
> > Fixed PLL clocks are implemented using mtk_clk_fixed_pll_ops
> > instead of
> > mtk_clk_apmixedsys_ops, but they can also serve as parent clocks in
> > the
> > APMIXED domain. The parent lookup function needs to check for both
> > driver ops to properly resolve the parent clock device.
> >=20
> > Add mtk_clk_fixed_pll_ops checks alongside mtk_clk_apmixedsys_ops
> > checks
> > in mtk_find_parent_rate() to restore support for fixed PLL parent
> > clocks.
> >=20
>=20
>=20
> > Also refactor the grandparent lookup code to extract the repeated
> > dev_get_parent(priv->parent) call into a local variable to keep
> > lines
> > under 100 characters and pass checkpatch validation.
>=20
> This sounds like an unrelated change. Let's split that out into a
> separate patch.
>=20
> >=20
> > Fixes: 00d0ff7f81bf ("clk: mediatek: refactor parent rate lookup
> > functions")
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> > =C2=A0drivers/clk/mediatek/clk-mtk.c | 20 +++++++++++++-------
> > =C2=A01 file changed, 13 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/clk/mediatek/clk-mtk.c
> > b/drivers/clk/mediatek/clk-mtk.c
> > index 4adec4457b4..26db60dea7f 100644
> > --- a/drivers/clk/mediatek/clk-mtk.c
> > +++ b/drivers/clk/mediatek/clk-mtk.c
> > @@ -207,20 +207,26 @@ static ulong mtk_clk_find_parent_rate(struct
> > clk *clk, int id,
> > =C2=A0static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv,
> > struct clk *clk,
> > =C2=A0				=C2=A0 const int parent, u16 flags)
> > =C2=A0{
> > +	struct udevice *grandparent_dev;
>=20
> Putting this here is fine, but we could also declare it inside the
> else scope instead since it is only used there.
>=20
> > =C2=A0	struct udevice *parent_dev;
> > =C2=A0
> > =C2=A0	switch (flags & CLK_PARENT_MASK) {
> > =C2=A0	case CLK_PARENT_APMIXED:
> > =C2=A0		/* APMIXEDSYS can be parent or grandparent. */
> > -		if (dev_get_driver_ops(clk->dev) =3D=3D
> > &mtk_clk_apmixedsys_ops)
> > +		if (dev_get_driver_ops(clk->dev) =3D=3D
> > &mtk_clk_apmixedsys_ops ||
> > +		=C2=A0=C2=A0=C2=A0 dev_get_driver_ops(clk->dev) =3D=3D
> > &mtk_clk_fixed_pll_ops) {
> > =C2=A0			parent_dev =3D clk->dev;
> > -		else if (dev_get_driver_ops(priv->parent) =3D=3D
> > &mtk_clk_apmixedsys_ops)
> > +		} else if (dev_get_driver_ops(priv->parent) =3D=3D
> > &mtk_clk_apmixedsys_ops ||
> > +			dev_get_driver_ops(priv->parent) =3D=3D
> > &mtk_clk_fixed_pll_ops) {
> > =C2=A0			parent_dev =3D priv->parent;
> > -		else if (dev_get_driver_ops(dev_get_parent(priv-
> > >parent)) =3D=3D &mtk_clk_apmixedsys_ops)
> > -			parent_dev =3D dev_get_parent(priv->parent);
> > -		else
> > -			return -EINVAL;
> > -
> > +		} else {
> > +			grandparent_dev =3D dev_get_parent(priv-
> > >parent);
> > +			if (dev_get_driver_ops(grandparent_dev) =3D=3D
> > &mtk_clk_apmixedsys_ops ||
> > +			=C2=A0=C2=A0=C2=A0 dev_get_driver_ops(grandparent_dev) =3D=3D
> > &mtk_clk_fixed_pll_ops)
> > +				parent_dev =3D grandparent_dev;
> > +			else
> > +				return -EINVAL;
> > +		}
> > =C2=A0		break;
> > =C2=A0	case CLK_PARENT_TOPCKGEN:
> > =C2=A0		if (dev_get_driver_ops(clk->dev) =3D=3D
> > &mtk_clk_topckgen_ops)
>=20

Best regards,
Sam
