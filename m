Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C8606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vGAArhgu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bP5kTAb6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B23F640A55;
	Fri, 27 Nov 2026 13:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tr2EShiA6f5G; Fri, 27 Nov 2026 13:25:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AEBB340A52
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785950;
	b=aBie0Qfqa2zJqKJabVYG+Uht0WFFhk+ut0BWb0j4qFHVPJg7Yw0eXL82Vy+Ov1UfTkFA
	 qcGSL5nNZ2SuzHyhomnBwRSe0eDzbadeRHwKkOyOnIv+1wETyKDaqO6O+mVriwEy3mQXF
	 YzNGdfqPkALb4kQF80SQMtXBohDsFGl71gx2slyykvt8Lv/ANgi9XEOfGroArCKrb1n9a
	 A1qTW7H0irIhTmaccY0lCMHbXTVLASYjwb9uOlc7xUiVSdeTr8GVpo3s95wmVSjho0pM8
	 f+0AXUvA8Qq3RpdicMk314OHLWHcUtNx5ZS8vEYY+yeHdjhq72Ct7uPVbCk3fjs7RKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=2INmCJqNyMH7OSBXH7wQ2k3EjCqN0rDf7HBjMt8gazQ=;
	b=cWOr05fCiP8MCdCKvi3CfTit67635FBt+eH0vzNLZ34WTrx2rprJIbztb5QUyY3zPQtM
	 Dsl0KA8xnXTDQnYI2np0IDDPpbyCV24AVI8ruQKrTmy5SCe7hf+N5z9FPtJa16iJ1SRbm
	 lcPGRi0/zzZeUHWTDc1Qt2Bf3OWHFSLMsx0+L+4OiQUOd01JI/kqPT6b6jqbVEQM4VFA1
	 1n0xLX7DYVtbk3I4/POOortjSPZo2x+Qdzi3mxY6MBJC/CCrKcGIW4o3lv8RsT7EncN/B
	 apUqYBp6O0jVPHiERbg98JOc+Xw2v5sddIqNFSRmFZBknRwGcwR5CRxOz8qVxg1ucnw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785950;
	bh=2INmCJqNyMH7OSBXH7wQ2k3EjCqN0rDf7HBjMt8gazQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=vGAArhguanjlW+/f5N+XwGzCvTl+oEY2igcKxG8aysrlk4fY1CmnOSYCBTn9HTqEv
	 3dSKmw1EM6c4m7tJcfN37wu/5cYPioe8S70926QrPb3wmY5X7/7uaQQ0c3u/HzlMcd
	 bm3nqS9ORuEMxAb2jCtP1a8VNxuli7fmBptYsDV4cCquuzAa8ECThd1f0vmYVdH2/e
	 eJYpLIabM47V9jSTMqJHgTZlLXlGEbgqPjSBP/ZMFAvzhBhVyIvP/h7CqHG7nIK916
	 2YER8YxFws0n5X0grj3iCu8qRW0I1uWDllEGH9kiRLsCnu7hwTl5gx3Yid2ixFq/Ko
	 pHdfHo71Dvl1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEBB340A52;
	Fri, 27 Nov 2026 13:25:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A01D5373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91B04811ED
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTi6X3hFdpzC for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:14:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 954688117D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+ricardo.pardini.net@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=bP5kTAb6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 954688117D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA0A860D74;
 Fri, 27 Nov 2026 13:14:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F02831F00899;
 Fri, 27 Nov 2026 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795785253;
 bh=2INmCJqNyMH7OSBXH7wQ2k3EjCqN0rDf7HBjMt8gazQ=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=bP5kTAb6IpyiYKlEdvt6crnMEMN87HdsVYJAeSRTLDk0CByirEIv/T+bTlJE+cmyM
 KOyXXwABY+wcwpri9UZUTE9b7OohALlvsELx1aO8qkrlibeKNAsEuowr/JCbnDB3iG
 oGL8+G5cLLI1CSmwWyX9g61mFqGKyiRL5sihSFOrNCgYqrIvrAUAQAkHSiUjWvKNfB
 Hr07X3ydsG7a5kC5RUyk5eZ8zCvWtM4RXy5O9AOZ+XFcxb58p+9NsM1OxlGlSbS1xG
 tdBxfa9m0CqzpZgApOmVd6yj8j2RPefiKQyA8DS+h01+yr9Apwivw3e25IckbYAZdD
 rPr2Rhjae7Vnw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 80F044B7E7;
 Fri, 27 Nov 2026 13:14:03 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Subject: [PATCH v2 0/4] rockchip: fix on-board SATA on RK3588 and RK356x
Date: Fri, 27 Nov 2026 14:12:57 +0100
Message-Id: <20261127-rk3588-sata-fixes-v2027-01-v2-0-dbdf7770972a@pardini.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANqBCWsC/32NzQ6CMBAGX4X07Jpu+bF48j0MhwKLrCaFtLXRE
 N7dAnePk539ZhGeHJMX12wRjiJ7nmwCdcpENxr7IOA+sVBSVShVAe6Vl1qDN8HAwB/yENPtAhJ
 B16odUJq8RCXSwOxoN9L/vTnYv9sndWFb3IyRfZjcd69H3LwjhLL+F4oIEqgsOqOp0gPq22xcz
 5bPloJo1nX9AdPQxWzYAAAA
X-Change-ID: 20261024-rk3588-sata-fixes-v2027-01-892bf10a3512
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ricardo Pardini <ricardo@pardini.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Heiko Stuebner <heiko@sntech.de>, Julius Lehmann <lehmanju@devpi.de>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3009;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=DTCo8lpu7MajxLVaWrDtdaiCkp3xKbvJsTY1bbfUMJg=;
 b=owEBbQGS/pANAwAKATteP+Oex+3pAcsmYgBrCYIZOIH1R92sqFQBsRn+vi0qly7E7kBXh/C7G
 gBAum6PI2KJATMEAAEKAB0WIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCawmCGQAKCRA7Xj/jnsft
 6WNDCACiX5V0RvoeuCyyiPWH7VSMlx5boJhhVNgrEIeCLYqRwGehHHRh2v24wAQ9G4NyYjdd1WV
 R7AXby9nCd1UPdwdJSaNnJcjCIxGE+E10IVwMswIGo30Sj3cvo9YCh4f4TsnSW2d8qCLeYbBjC0
 nLty4GLiKcqpa8q17zWQPXQoctbFQ6+aRcqjoF94YWGfzl2MWEhTW1AKo/A0mh9BvzBPHpIsgIX
 DfEhbgOvWufrbzaH4dyFweXlOy0GCF82PqUcNztEN2cW7MqHo0NuAMdJpmcTIkZKdTjRbJDpI2j
 uz+yLLWVJOUAewAM97zkffGGwrtW5CHTjF5NPMgaEBZGjLNK
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
X-Mailman-Approved-At: Fri, 27 Nov 2026 13:25:43 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: ricardo@pardini.net
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This makes the on-board SATA controllers (dwc_ahci) work on RK3588,
and on RK356x sata1/sata2 again. They currently fail to probe, and
fixing that exposes two more problems once a disk is actually used:

A: dwc_ahci only looks for the PHY on the controller node, but the
   RK3588 DT has it in the sata-port@0 subnode, so probe always fails.
   RK356x sata1/sata2 have the same problem since the v7.1 DT sync.
   The PHY is now found like Linux's libahci_platform does it: the
   first PHY, ignoring phy-names (1/4), of the sata-port subnodes if
   any, else of the controller (2/4). The binding allows one PHY per
   node and phy-names is optional, so RK3576, RK3568 sata0 and TI DRA7
   get the same PHY as before.
B: AHCI reports disks one sector too large since the scsi +1 fix [1],
   which breaks e.g. UMS when the host reads the backup GPT.
C: sata2 links at 1.5 Gb/s only, due to a wrong GRF offset (see the
   RK3588 TRM); Rockchip fixed it in their BSP kernel [2], and the
   same fix was sent for Linux [3].

The misplaced write in (C) lands in PHP_GRF_PHP_CON0[2:0], which are
the PCIe link reset grant bits, and turns on the one for pcie3x2
whenever a combphy is put in SATA mode. I don't know of any effect
from that, but this series stops it too.

Tested with an mSATA SSD on sata2 (combphy2_psu): scsi scan, booting
via bootstd, and UMS all work, with the link at 6 Gb/s. Only tested
on RK3588.

[1] https://lore.kernel.org/u-boot/20241026-fix-scsi-disksize-v2-1-bc6be9a6043d@devpi.de/
[2] https://github.com/rockchip-linux/kernel/commit/2f5fe2c0bbd4fa95102aadd60da1100989103aa0
[3] https://patch.msgid.link/20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net

---
Changes in v2:
- v1 1/3 split in two, getting the PHY the same way as Linux's
  libahci_platform (Quentin):
  - 1/4: always the first PHY, ignoring phy-names
  - 2/4: only from the sata-port subnodes if there are any, else from
    the controller node; stop at the first enabled subnode; replaces
    v1's "ata: dwc_ahci: fall back to the PHY in the sata-port subnode"
- 3/4, 4/4 (were 2/3, 3/3): collect Quentin's Reviewed-by
- Link to v1: https://patch.msgid.link/20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net

---
Ricardo Pardini (4):
      ata: dwc_ahci: use the first PHY, ignoring phy-names
      ata: dwc_ahci: get the PHY from the sata-port subnodes if any
      ata: ahci: return the last LBA from emulated READ CAPACITY
      phy: rockchip: naneng-combphy: fix RK3588 SATA pipe_con1 register offset

 drivers/ata/ahci.c                                 |  8 +++++---
 drivers/ata/dwc_ahci.c                             | 16 ++++++++++++++--
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |  2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)
---
base-commit: 934995f642a21ca7f35fa9aed5f061394fcba243
change-id: 20261024-rk3588-sata-fixes-v2027-01-892bf10a3512

Best regards,
--  
Ricardo Pardini <ricardo@pardini.net>


