Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D396606A332
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ISGkefQc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aab4emVc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FE0F4064C;
	Mon,  9 Nov 2026 04:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4PvNxCLKHwNu; Mon,  9 Nov 2026 04:34:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3BB7340672
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794198843;
	b=rU8NeHJ86PkUSVZ6Zk0XkOj2ApB2EvdN4Lg8pmgHswWYEMsaJJyZs+t6PHxbMtTkb712
	 dckPhqW+pvZDRw8ycTBslGhHEPqk/s1NvVIXJETT0SbRBd4sKoBRA7edBFw8LgU1/pqNK
	 CGqARV8ro/ApOCBQiCgepCXVMEo+z0Isqj5IbR6HCeoKupcpl5pFDq4FPLz1EWLqRRPnY
	 Lc9+2DXOq0wA7gJF7yiShxu8Ji7qHfnQCjVHlIdlMVjP1MysF2BNeNKDi170vsHzM5rAt
	 evK4w5Dtsj8/9byMp0YLmE880FkLGAt3UI8fdHR8COorl0pI4trTzApKyukaFgFlK7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794198843;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=rLkKpqrj2PSfSd5iKr4z+CQnZ7OMIOekeQo6kJE9sYE=;
	b=NVv2b6gq0pJT6BMQ99YC5khdESGXcvNjNnr0wMM0expgu0KJ4FsP3DME8hsgpUkuk60r
	 i+DMjSQbldn76ymzrh/VysG2bMbmie4H2y4q6xf18kTYAc95RlqKHkS93zoaYvuhZhFRq
	 ESKeITGrDkYRULB6J5cpqs/t6AXxQRM/MyFp3r6g8xa1s//T6yQpHdlYZyRIM6Y8Qw4la
	 hR9yP3wP6h/iJ5KcdIjprr7ms9DTAhuHtnGwrH52P6c8wv28fcSy9ZrTSKj9/rZdxh89w
	 tNW/orxBOdPv1N8BlHv6J8VbsUmmlb0CgdMi8EwRsUfLM0WhJ/T/TkBPkHzb/dYztoQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794198843;
	bh=rLkKpqrj2PSfSd5iKr4z+CQnZ7OMIOekeQo6kJE9sYE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=ISGkefQcqGxaneALdRyqiavgUdqXO4f/bC8UL36MoF4e1TyEltGsXw1TpFAut37Bx
	 LcG8Y3nYPgHjFvMs9ZIKqocpuqJkQKfc9wHFSULo0bBXcRATxLM3Y++HC40Y+mXNvK
	 fAp+t1c+uDdSAoPXE7qVLXkqnPwq9WYTDYaBWx6UJNpVvIQoun1POmpq9iEXUEkktM
	 xoCVdGrUVR48OMCb/IR5m0+MYIHD+7X9VuiNjfg9VogiHYGv2/8deBVaQO08rxiioI
	 JhNbEqdcfpd8iyLOjgVVvdRFILpcNGpVFEaAI0S1z2myMEC9G6FZ+9lHSsI0A7R9t2
	 XSP/Xl+3A+9SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BB7340672;
	Mon,  9 Nov 2026 04:34:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78F0F361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AE98605F1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 012hAj_LztMr for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 02:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C5F9C605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+ricardo.pardini.net@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aab4emVc
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5F9C605E8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E66640966;
 Mon,  9 Nov 2026 02:58:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B2C991F0089F;
 Mon,  9 Nov 2026 02:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794193081;
 bh=rLkKpqrj2PSfSd5iKr4z+CQnZ7OMIOekeQo6kJE9sYE=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=aab4emVcdjSum28qF788g4oYtKi0zISt8vqFTMHEo6oynBZSqxOVhOYAj/OU2YRd3
 lnaR1/mPQp+2aru9KbkD8eBkvqiQ3meYfsdpzohC8AiQKUy5aQafuph93PH99gy/pr
 rQtozZofAH2Hnwz/APiYpncepIbS/h7fW0KjUqsPbip9ImrZnrEOsjL87F7ayyaByr
 B0hyaZdeMjvKvxrTb7zAMj+ILKuBKBYjOAZLWclSq3x+rikl7vul3YebIiI7K4GhI2
 fWV3nbGkm6CVQyDS8k6/d+gVNSrlUNYmgyvXqqTK8eH75HaD191dM3/86/PGqfE+JQ
 Djkx348jJxpBQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 45D5B48251;
 Mon,  9 Nov 2026 02:58:00 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Subject: [PATCH 0/3] rockchip: fix on-board SATA on RK3588 and RK356x
Date: Mon, 09 Nov 2026 03:57:57 +0100
Message-Id: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALU28WoC/yWMQQ6CQAxFr0K6tsm0iI5ehbAYoGg1QTMFYkK4u
 1WWL/+/t4JJVjG4FitkWdT0NTrQoYDunsaboPbOwIFPFPiI+VlWMaKlKeGgHzFcfDtjIIwXbgc
 KqayIwQPvLP+H+3Wzs83tQ7rpV4Rt+wJDovkDfgAAAA==
X-Change-ID: 20261024-rk3588-sata-fixes-v2027-01-892bf10a3512
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ricardo Pardini <ricardo@pardini.net>, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Julius Lehmann <lehmanju@devpi.de>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=MSfvXvaN1DR4S2bn3IrJreOSPijm7cdZ9zFFwCNgR60=;
 b=owEBbQGS/pANAwAKATteP+Oex+3pAcsmYgBq8Ta2q0Xm/pIA8t68QYybo2hckYSbZ0NrqqZJw
 RHcq9yYhaCJATMEAAEKAB0WIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCavE2tgAKCRA7Xj/jnsft
 6YJIB/9TbhQ9TqHz9M0RL3b3FE+d+URlHBnkIfgn/NifOmDW93f9gTQH44RKVNDfziXpxClw+uA
 QmmZKaeijQnrdBvcyhAWt8adpjphfnticNx4bSYDd5TezVvrRH15QfMXS9ZQMFkesaYvvFubCa3
 sv0MDVZQFfo+CYEj5Qj2Lcgn2Sote5dERN/np9g+2IdRxQL2sns6GBC52sKW7IrmqZTY7pNR5mL
 Hz/I3F/mi2Moyd3HtsrRjWlJFLEaR1TXu/FUrXApNoO9eF/G5r0OGPwxXkln2/knImVfMQP0r3T
 nw8BcDmKzWECrG/SlHXR2g1H+8e9vCLyPBfFzgmNqK7YIie3
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
X-Mailman-Approved-At: Mon, 09 Nov 2026 04:33:56 +0000
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This makes the on-board SATA controllers (dwc_ahci) work on RK3588,
and on RK356x sata1/sata2 again. They currently fail to probe, and
fixing that exposes two more problems once a disk is actually used:

1: dwc_ahci only looks for the PHY on the controller node, but the
   RK3588 DT has it in the sata-port@0 subnode, so probe always fails.
   RK356x sata1/sata2 have the same problem since the v7.1 DT sync.
2: AHCI reports disks one sector too large since the scsi +1 fix [1],
   which breaks e.g. UMS when the host reads the backup GPT.
3: sata2 links at 1.5 Gb/s only, due to a wrong GRF offset (see the
   RK3588 TRM); Rockchip fixed it in their BSP kernel [2], and the
   same fix was sent for Linux [3].

The misplaced write in (3) lands in PHP_GRF_PHP_CON0[2:0], which are
the PCIe link reset grant bits, and turns on the one for pcie3x2
whenever a combphy is put in SATA mode. I don't know of any effect
from that, but this series stops it too.

Tested with an mSATA SSD on sata2 (combphy2_psu): scsi scan, booting
via bootstd, and UMS all work, with the link at 6 Gb/s.

[1] https://lore.kernel.org/u-boot/20241026-fix-scsi-disksize-v2-1-bc6be9a6043d@devpi.de/
[2] https://github.com/rockchip-linux/kernel/commit/2f5fe2c0bbd4fa95102aadd60da1100989103aa0
[3] https://patch.msgid.link/20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net

---
Ricardo Pardini (3):
      ata: dwc_ahci: fall back to the PHY in the sata-port subnode
      ata: ahci: return the last LBA from emulated READ CAPACITY
      phy: rockchip: naneng-combphy: fix RK3588 SATA pipe_con1 register offset

 drivers/ata/ahci.c                                 |  8 +++++---
 drivers/ata/dwc_ahci.c                             | 13 +++++++++++++
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 934995f642a21ca7f35fa9aed5f061394fcba243
change-id: 20261024-rk3588-sata-fixes-v2027-01-892bf10a3512

Best regards,
--  
Ricardo Pardini <ricardo@pardini.net>


