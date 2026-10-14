Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070D3C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A56FA81022;
	Wed, 14 Oct 2026 20:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQqWDJa2oJeb; Wed, 14 Oct 2026 20:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9336C81000
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008031;
	b=Ireh8rrZ08zKlYMiBZ3dEBEZbByxF3XiFUnalKvDIPbI8dh9iBfBSksxGK5/Tg4zX/Wj
	 kSBF9dyohQQ3ucHj7NO1V4QQs5ojY6jsm3Rn9qgjHDRcsAjKWMMWliiuMhq/cMS6BsEif
	 gQBN6I96NovIAmEAIjJkby14aCptIImrNvDQybCcnXbSxc9Hn9KBsTDOLcvluAwNRxOwB
	 Y6d8/JjEWejaVNlEpk6wiRx57gRyXUJCyMUnG5D3qTqZjoHZcYsGSW80p1a2vi6Atotor
	 wRnWevtoIeUubeLzk6q4tv9lQsU+pIQ3UWYuyQm7INLFi1PygL14o5rwWz/n8V74mqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2Z2jSLWUeLXZHH1en87WfWTduCgBR58rHTjO686gYmM=;
	b=YKPZGSPEFq7A6ff0eXUSqRGboOjWZ+p+ZPePl9HGp1d5LfNAy9bWQOXKXMEaMJUGJkhB
	 CjFVD4kh7uP3PO00cWY8i4990WcifaeNn9LbhbTcPN6HDFCFNkxPRm/YOxkgX9n3Brwmj
	 2mmQ9Qg1miLMJbkxbkeja6m0kyru4LJ/qIJQroXgEZM1NT9TD7bwyXJlVou8o+WVNUyEz
	 yvK03sDHMEZN2UAwi3bjXe9SFrs4CPtUd2r/W+Ev3sjMBgMLLiw7N6goUYKtMdGiWACiB
	 P8XuuharXelx53RSddkQOfKJ3nX7JiyKCFSYCK6T2T3KWNvkMc0DezJkbCZnG+66szQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008031;
	bh=2Z2jSLWUeLXZHH1en87WfWTduCgBR58rHTjO686gYmM=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PnXwINMPj7ZpRHHvDcLBqsJQPo5cHrRubpzOaMHQxRX73K00SIuP6ZEElR5x1J1r7
	 +xLZfQ168mG00txBBScYMPI4cJqt+5UGkh76FsIiviK/6dIX2CU31eMuqC2JDOJG/V
	 VmB3MugUdN2EUDVlLwiYiJuqH9TeG/1E/0fnLIzGCT8NDud72Afsf5Tx/w42Cys8/w
	 cV/uhbmwZZK9t4fZeuSoGmYNERHFfhMOZgp5JzuPn/23Pmx/XEtg8gQxmrEEIXNZmE
	 QJRmr4WJmV6p8ax2YRlvw+VONwnLGk2syJSYReUOWsFZ12sw5TrWlLDeHAkpmOWpy8
	 mM9n82VxpPirQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9336C81000;
	Wed, 14 Oct 2026 20:00:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E1E02E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04B6340816
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id irWEzDCTv-9N for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 20:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A19040828
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=79.135.106.30
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792008029;
 b=cPFl38viPNHAg7R7pEiYjGCb0QxbbShbjVBl+lrvDRHUAk+acc+7A9D/3zqaXI4mZiE6
 Xue1IhJQFfiiPEItwhGPLpnw/j0sTxRoeGZErJQuKmvwSPyZt2S1imaGktQ64SG7MmElJ
 Aaz1bvZ+D05MPg23Qq+32Acee1KaMb2TlLActG7Wb+GLOgsvsaB94TFvaiNdFIiYLKf1h
 +NXCLuVQW69M3HLCnfrvCHu7hdWxBHdyRY32F3SMbTFwiw/j5q0JEnX8ugL2g6DJqaYBw
 H7FxDOXoqONpSssfRLFtb9yVbl75GgtWXjQAHyz96uIeWll7bIRuCOgMa7R6M618/Iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792008029;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=2Z2jSLWUeLXZHH1en87WfWTduCgBR58rHTjO686gYmM=;
 b=FKNmfGWkPriwjY2TS2KB9iPzJ2RHgBXksOIHJMSLNDWLME/otTt8A5baSkKBxID4U+kj
 zYQE0NwS+KHMsc8u2bsAvHlSw71eXhuWAcijWVm1Vp3LdOEtMGSMgMy+/fDiBb32JBsJ7
 BzF3sRG60yONyefpDw4JzhADi1J7ILW4uRy/jUpU4g1CSMdgMTevFvYbYwazVq349uhw6
 zBzBiSmH/SxFwNT8ltF7cDn61+uKJLmjQbGYbTYt24Ti0n0Y53juBTIsWAD30vzchu1EN
 Tph+nyL0fS4224YgPrUliISgl3TAkiKACzt+tms2TvlaweOSFVTTDeg8qElgb48fWGA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=protonmail.com;
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=V0eO8j9X; 
 arc=none smtp.remote-ip=79.135.106.30
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.30;
 helo=mail-10630.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=V0eO8j9X
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A19040828
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792008026; x=1792267226;
 bh=2Z2jSLWUeLXZHH1en87WfWTduCgBR58rHTjO686gYmM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=V0eO8j9XgVC/WvwSJEqopp6R+zBtL9RsKUzsMNHxRkFGtV7sUODj2jC7wMXzikJP+
 TjzOt3+wQfngzRcTru2Cq1MxVeiqRa++LhxW9snC/XS09ZxZR8VWn3EXkHSfYrkMRE
 D9riBDyd5jq6VPh5kvy2xBsKgR8x37rw4IKEhc+J8UnrMykrBhJQJRV7qXJTuc7bYq
 bJB2mXp8xcs36QFU+GJHP2rvmd/OktbQZKGCIvWVDxjuKMjGfDa+Tv3ICQA4XLATp+
 3Zf1FN2V70cOdUExVyDXVxWgTEeYRF+rkaNXnvfwmpxVBNJy4Lvh7JPQI5nS0T6doo
 seqCmepMMIytw==
Date: Wed, 14 Oct 2026 20:00:18 +0000
To: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Eric Chung <eric.chung@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: [PATCH v3 2/3] usb: dwc3: generic: add SpacemiT K1 and K3 support
Message-ID: <d5d2da6ee498956285086970d1d1196f6751ea3d.1792007916.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1792007916.git.DaveWK225@protonmail.com>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <cover.1792007916.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 63a61bf4fffeb49546339a7b37c47e99b646bf09
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

The K1 describes its DWC3 controller as one flat device-tree node with
the controller registers, clocks, resets and PHYs. It has no separate
wrapper registers or controller subnode.

Use the existing flat-node callback through rk_ops so that the generic
wrapper binds its host or peripheral child to the same node.

The generic glue handles the K1 controller clocks, resets and USB 3 PHY,
while the child uses the existing generic DWC3 host/peripheral path.

The K3 uses the same flat-node layout, so match "spacemit,k3-dwc3"
as well.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
---

Notes:
    Changes in v3:
    - Add Marek Vasut's Reviewed-by.
    - Also match "spacemit,k3-dwc3": the K3 uses the same flat-node
      layout (dts/upstream k3.dtsi), and 1/3 now matches its USB 2.0 PHY.
      Not tested on K3 hardware.

 drivers/usb/dwc3/dwc3-generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generi=
c.c
index 3f6e3d4085..2406f84461 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -753,6 +753,8 @@ static const struct udevice_id dwc3_glue_ids[] =3D {
 =09{ .compatible =3D "rockchip,rk3568-dwc3", .data =3D (ulong)&rk_ops },
 =09{ .compatible =3D "rockchip,rk3576-dwc3", .data =3D (ulong)&rk_ops },
 =09{ .compatible =3D "rockchip,rk3588-dwc3", .data =3D (ulong)&rk_ops },
+=09{ .compatible =3D "spacemit,k1-dwc3", .data =3D (ulong)&rk_ops },
+=09{ .compatible =3D "spacemit,k3-dwc3", .data =3D (ulong)&rk_ops },
 =09{ .compatible =3D "qcom,dwc3", .data =3D (ulong)&qcom_ops },
 =09{ .compatible =3D "qcom,snps-dwc3", .data =3D (ulong)&qcom_flat_dt_ops =
},
 =09{ .compatible =3D "fsl,imx8mp-dwc3", .data =3D (ulong)&imx8mp_ops },

