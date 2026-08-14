Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E43EC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 03:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 703FE60688;
	Fri, 14 Aug 2026 03:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4tTfh9769UcA; Fri, 14 Aug 2026 03:51:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69ACE6065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786679512;
	bh=q1UEb7MwBcPXW0XRE3/oGZBcOBB1TI973yiWSVleRag=;
	h=Subject:From:To:CC:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fDBWVALNurHiRM7Fsompplvwbp7PObx7K7vpBWDskOdhg2cWFsudJljiEwfA5q/1y
	 foQMbcd0MmCBawMFs5LZwxLHNxbyr7Ou99uaQJez8dysMrusuYDoNuCvpLAmGaa22/
	 qqrzNvTpxnXaYp+lRfLBvfEJsfHL3mtyGcjullBilXBdrrxSoTKHTxEBzHxVoYgBtu
	 zSKoMMxJaVSYvALH1PoBbuBgTuGoJD91Y13wjwN7TdhOR6cChGiaNxHWcm/AK1P45L
	 5Q6HrgKYxyWE63jS/Mz29RPOwjwhQtpv8G3h3tLUb4lE/LAq4EU13RyXqtjb/Bpz/Y
	 HLw72/p+t1KwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69ACE6065E;
	Fri, 14 Aug 2026 03:51:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9365223F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 03:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 683224006A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 03:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KTYHr4BY2hFr for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 03:51:49 +0000 (UTC)
X-Greylist: delayed 963 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 14 Aug 2026 03:51:47 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A4AF34005A
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4AF34005A
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=q/LzCRTr
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=sam.shih@mediatek.com;
 receiver=<UNKNOWN> 
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4AF34005A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 03:51:47 +0000 (UTC)
X-UUID: 3681087e979111f1b1788b6acf885367-20260814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=q1UEb7MwBcPXW0XRE3/oGZBcOBB1TI973yiWSVleRag=; 
 b=q/LzCRTrG3VzwoVXKisLZ6icI5R+ogJ7Hx97zxQbVwOMSNNdUck4Ugm+vcUZhsrXMb4M40smqF/ic8o2VsvA/nORdg5b6vDC/QKN4va2Dh8gQY74dAcc2Ij3c7P3pEdpaK84sLwy8wCfKH1RJsCE7z2gMtF+4NVxxhM6OG4Mzdc=;
X-CID-CACHE: Type:Local,Time:202608141135+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:2373709a-6163-4596-b9ce-3542153f8c8c, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:7db8b62, CLOUDID:e365cc68-4741-437d-a40d-86b5e0a4b59c,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|836|865|888|898,TC:-5,Content:
 0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3681087e979111f1b1788b6acf885367-20260814
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <sam.shih@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1312679370; Fri, 14 Aug 2026 11:35:36 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 14 Aug 2026 11:35:35 +0800
Received: from mediatek.com (10.233.130.16) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Fri, 14 Aug 2026 11:35:35 +0800
Received: by mediatek.com (Postfix, from userid 10015778)
 id 39C60200C6; Fri, 14 Aug 2026 11:35:35 +0800 (CST)
Message-ID: <88d78ba663bfe4770a1432289a7cef9bf9ff4e23.camel@mediatek.com>
Subject: Re: [PATCH] clk: mediatek: fix reprobe regression
From: sam.shih <sam.shih@mediatek.com>
To: David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Julien Stephan
 <jstephan@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>
Date: Fri, 14 Aug 2026 11:35:35 +0800
In-Reply-To: <20260813-mtk-clk-fix-reprobe-regression-v1-1-ed259968c2b8@baylibre.com>
References: <20260813-mtk-clk-fix-reprobe-regression-v1-1-ed259968c2b8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: git-send-email 2.45.1
MIME-Version: 1.0
X-Mailer: git-send-email 2.45.1
X-MTK: N
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi David,

Thank you for the patch.

I have tested this v2 patch on Filogic SoCs (MT7987/MT7988), and I can=20
confirm that the issue regarding the clock usage before relocation=20
(e.g., UART early console) is now fixed. The system boots up and works=20
properly without the previous regression.

Please feel free to add my Tested-by tag:

Tested-by: Sam Shih <Sam.Shih@mediatek.com>

Best regards,
Sam

On Thu, 2026-08-13 at 08:10 -0500, David Lechner wrote:
> Clear the MediaTek clock provider registry after relocation. This is
> necessary for a couple of reasons. If any clock probed before the
> relocation, the registry will contain a pointer to pre-relocation
> memory. Also, all drivers reprobe after relocation, so even if we
> had a valid pointer, it would be to a clock provider that had not
> been
> reprobed yet. Clearing the registry ensures that all clock providers
> are re-registered when they are reprobed after relocation.
>=20
> Reported-by: Sam Shih <Sam.Shih@mediatek.com>
> Fixes: 8ef0ad4c7a6d ("clk: mediatek: use registered provider for
> parent lookup")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/clk/mediatek/clk-mtk.c | 18 ++++++++++++++++++
> =C2=A01 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/clk/mediatek/clk-mtk.c
> b/drivers/clk/mediatek/clk-mtk.c
> index 13c248c93a6..849e8a196e5 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -1130,3 +1130,21 @@ int mtk_clk_probe(struct udevice *dev)
> =C2=A0
> =C2=A0	return mtk_clk_tree_register_provider(dev, tree);
> =C2=A0}
> +
> +static int mtk_clock_reset_registry(void)
> +{
> +	/*
> +	 * When U-Boot is relocated, the static clock provider
> registry is no
> +	 * longer valid since it contains pointers to the old U-Boot
> memory.
> +	 * Furthermore, all devices are re-probed after relocation.
> Therefore,
> +	 * we need to reset the registry before any devices can
> probe after
> +	 * relocation.
> +	 */
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(mtk_clk_providers); i++)
> +		mtk_clk_providers[i] =3D NULL;
> +
> +	return 0;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, mtk_clock_reset_registry);
>=20
> ---
> base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
> change-id: 20260813-mtk-clk-fix-reprobe-regression-6ac0c072600b
>=20
> Best regards,
> --=C2=A0=20
> David Lechner <dlechner@baylibre.com>
>=20
