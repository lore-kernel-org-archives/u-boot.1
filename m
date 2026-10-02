Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCD8CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A1868137C;
	Fri,  2 Oct 2026 21:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62i9qq08sjKG; Fri,  2 Oct 2026 21:32:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 28A808146D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976728;
	b=LXe4BuAap4mo+3j/xZAT/g2CEone8MN/oASU0C4rMROvE0xaJQQa7aIFUarcSyQCYspI
	 vG6XD7uQfuBEEmVY6+Cro8rs+iEyS54lG1oAtMiT1zBbTEoPxQF2tA6G7Jw1fCQQvmKNr
	 LPbd/B5wHjtOnPz7WbKfFS5/elD5RaKsegnvsnsOp88C7+HhMYaA9wlSg1Q8dyQJP7qgS
	 Wd007NHDFVfHUJFS8P7ieo2s6mkAdpXqVP05/iFABw76eKbtaWRLMpjWxZoYjy0rAGndv
	 xBRaBRxZREpgN7TcN/y8qze0hojmSfzBDe1CZytbhjl205H4/VBxeUkgPxXFPUMuO8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976728;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YhT7SCb0wfSERMaGHsqW6gAxYEEKe5nw1ERyCtNGhzE=;
	b=QRsVw4uV1miQEhZTGnfvM1D40xwV8LobOlVhL3vFItsd9fQUd+jPBAuGXU/oziAYzgUN
	 nCoInRgDbcQlMnUB+mnNmRkr66XYRSRJoNYX85Ih8BakKoYVcK8ctmi+9pzDUWhX+JHkx
	 Nj64+spZGnXgkCIs2wNaRhPN6i0KbRPlIMGfc8Jr+ppQW/j4hGrPoSKu9qhG0Y+7oPBMi
	 uqopuKVEmQqSBVV2gUTv2JFwFrZN33UdR53Eac1qL/IXI3cqjIhF3IYn7Z+LZx8Cd1puJ
	 cd5psc40LtVG9pTu7iOGv4nvNHTZArkjTkTyFs3ZxlaZ4BuEJFKTvwtO1SVp9pSoY3Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="JE/fK2vL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976728;
	bh=YhT7SCb0wfSERMaGHsqW6gAxYEEKe5nw1ERyCtNGhzE=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UsVk3ARU76u0wZ7wrFeML5SQzmLjzZzxBRawG4TUrJ1pYRPbZC/HHGBFnTBro4+26
	 3M6iXkR4Dq8cn6+TCkuLNB/FQKsNkvPjRDvo6BIHkRArueOR7ryaiea1N1x2TuLnpe
	 eYb9VwQn3Ftxgw849S/Lpgp/l1/Nh9onx4DSJRLjVcm4qO9f/oJzVTw7Cab80pdfxF
	 dgoa2ph4i+nouc6w4gIUqCDGu0rQzHG5mreSl40f30uMO1Yl02AZF/7ghLTJot/Ndb
	 5KZcg1Dx8HnfSnqDpgm07w/I41rOLfaI6qpwjMWS+5oDFrNjra+HUJlo8I5FUjSNqP
	 eEeWg9w6bKoMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28A808146D;
	Fri,  2 Oct 2026 21:32:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A488C34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A197E81422
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KHnuv6x7zXkk for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C12B9813EB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976694;
 b=tR3rpwF1rMAAcbJEgIT3LdJ6LNx1zsg7J7fE6tcR3DKwTJS90awGJxOnFLEl8IVAQaQE
 tYiNoCOT3DMewGkcpmdSLVhQzFaQpt6PpH6zn9Lb5vr0BTHkXPOklVREEWjKnpvoDjpJg
 bwyLgFiv8dm/uIX8aw6dvHpekr03AdZh6RQSKh3Orxur32hLhvC2Lxpfonk/xannprl30
 fw8/vGa94a5q79TwPKTXUe6c+XtmJhIFc/ec/dIWM9SaqoE1drziTXgXlo/szqgMhd7rn
 2BecuJLkYfudcUup6iMhePr6J+aCC8zZ6EQtNjpgOZ6c+g4E4v4ccVgAPh/CobJS/gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976694;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=YhT7SCb0wfSERMaGHsqW6gAxYEEKe5nw1ERyCtNGhzE=;
 b=DeqIEfcDmWaGGSc7GPlMQnfGuv88E4sHLu1iLG258KL0i9yvJhCAuogHp0joAy6y4mvl
 ux2zBP6DFJcaquUB3Z9aOUGbZNtkVMsaWp2G0iQgiCH4XoiilMUmPE/Ac8KmRtiDlHuGa
 XEP3qxHpY9htnKo8giaoBCvHQ67Jkpq7cClPCjIb3oSTlcnk9IP+0eZtYqANFQoYVg8E5
 Mf4FmuqAC7Tu9rjycn4NjJ8Y2mW1JPCuWgvVgurNPfFNfnqnZiNaGo+kk7iRFMEIPpVYQ
 C8IW5pHUOoqFybp/BJX0wnn4QokP2gNW9qyg3n+Xyjd7dfXhEMTqA9EH2y5dkXrAR5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b="JE/fK2vL"; 
 arc=none smtp.remote-ip=109.224.244.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.18;
 helo=mail-24418.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=JE/fK2vL
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C12B9813EB
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976691; x=1791235891;
 bh=YhT7SCb0wfSERMaGHsqW6gAxYEEKe5nw1ERyCtNGhzE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=JE/fK2vL65dpb6P5l9WHNyKcadP+Ehuz63/+WD1Q3lFg+MtXK019JLoA9rXqgmK9b
 yXSb85CA8nIc3nKusv9IkRfsx9IwcdP/4vXhuXgX0FC1gQlm7L0jDYRksb6mrFXXCE
 XU2w0JHKoxDoM7N/tej7djYzGP2ynKIpKkc89sowHFgmrqtzQVJ7vKWcUcjE1Eb0EA
 qTV64rBA7SCQq+btuRiu/rPgkz4r5t8NJCjwK+yNGluYj1lRYBgowYHcB2POnp3j+M
 fW5ryKD1gCRt41RQ9sSHscwdWZI0R9jaPXlX8FHAmA/dLawGlNoyXIJ7JDyObdBkbe
 cpUQr5hiTUpWA==
Date: Fri, 02 Oct 2026 21:31:27 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 9/9] pci: spacemit: do not fail the probe when the link is down
Message-ID: <bee14dfeb671f9b8c951879cfaa4160c0cdc16a6.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 73fc3b1d5178d3aa5378e40e5d8d58a80918da9f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:32:02 +0000
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

When the link does not come up within the training timeout, the probe
returns -ENODEV. An empty slot is a normal configuration, but the
failed probe leaves the root port unusable, skips the outbound memory
window, and makes every later lookup of the bus (each "pci" command, a
boot device scan) probe the controller again, repeating the whole
bring-up and the one second wait.

Linux's DesignWare core carries on when the link does not come up and
only refuses config requests to the buses behind the root port while
the link is down (dw_pcie_other_conf_map_bus()); FreeBSD's
spacemit_pcie driver also treats a down link as non-fatal. Do the
same: report the link as down, finish the probe, and answer config
reads behind the root port with all ones, dropping writes, while the
link is down.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/pci/pcie_dw_spacemit.c | 53 +++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.=
c
index 9b299ca17a..61c759172d 100644
--- a/drivers/pci/pcie_dw_spacemit.c
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -338,15 +338,18 @@ static int pcie_dw_spacemit_probe(struct udevice *dev=
)
 =09pcie_dw_setup_host(&pci->dw);
 =09pcie_dw_init_id(pci);
=20
-=09if (!pcie_dw_spacemit_pcie_link_up(pci)) {
+=09/*
+=09 * An empty slot, or a device that does not train, is not an error:
+=09 * the root port is still usable and the config accessors keep
+=09 * requests for the buses behind it off the wire.
+=09 */
+=09if (!pcie_dw_spacemit_pcie_link_up(pci))
 =09=09printf("PCIE-%d: Link down\n", dev_seq(dev));
-=09=09return -ENODEV;
-=09}
-
-=09printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
-=09       pcie_dw_get_link_speed(&pci->dw),
-=09       pcie_dw_get_link_width(&pci->dw),
-=09       hose->first_busno);
+=09else
+=09=09printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
+=09=09       pcie_dw_get_link_speed(&pci->dw),
+=09=09       pcie_dw_get_link_width(&pci->dw),
+=09=09       hose->first_busno);
=20
 =09ret =3D pcie_dw_prog_outbound_atu_unroll(&pci->dw, PCIE_ATU_REGION_INDE=
X0,
 =09=09=09=09=09       PCIE_ATU_TYPE_MEM,
@@ -430,9 +433,39 @@ static int pcie_dw_spacemit_of_to_plat(struct udevice =
*dev)
 =09return 0;
 }
=20
+/*
+ * Nothing answers behind the root port while the link is down, so do not
+ * send config requests there; Linux's DesignWare core does the same.
+ */
+static int pcie_dw_spacemit_read_config(const struct udevice *bus,
+=09=09=09=09=09pci_dev_t bdf, uint offset,
+=09=09=09=09=09ulong *valuep, enum pci_size_t size)
+{
+=09struct pcie_dw_spacemit *pci =3D dev_get_priv(bus);
+
+=09if (PCI_BUS(bdf) !=3D pci->dw.first_busno && !is_link_up(pci)) {
+=09=09*valuep =3D pci_get_ff(size);
+=09=09return 0;
+=09}
+
+=09return pcie_dw_read_config(bus, bdf, offset, valuep, size);
+}
+
+static int pcie_dw_spacemit_write_config(struct udevice *bus, pci_dev_t bd=
f,
+=09=09=09=09=09 uint offset, ulong value,
+=09=09=09=09=09 enum pci_size_t size)
+{
+=09struct pcie_dw_spacemit *pci =3D dev_get_priv(bus);
+
+=09if (PCI_BUS(bdf) !=3D pci->dw.first_busno && !is_link_up(pci))
+=09=09return 0;
+
+=09return pcie_dw_write_config(bus, bdf, offset, value, size);
+}
+
 static const struct dm_pci_ops pcie_dw_spacemit_ops =3D {
-=09.read_config=09=3D pcie_dw_read_config,
-=09.write_config=09=3D pcie_dw_write_config,
+=09.read_config=09=3D pcie_dw_spacemit_read_config,
+=09.write_config=09=3D pcie_dw_spacemit_write_config,
 };
=20
 static const struct udevice_id pcie_dw_spacemit_ids[] =3D {
--=20
2.55.0


