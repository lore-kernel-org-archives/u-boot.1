Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0799CCA5FE7
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D79560D97;
	Fri,  2 Oct 2026 21:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjSehlumoet1; Fri,  2 Oct 2026 21:31:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 922D160D92
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976662;
	b=ok2cuRFnvPH/ENvanUYgBj+cqfugom8eKLkmQtT4j4/R1zhK4d/lp5N1is/Jxlz/vGor
	 wQXevw/mgOX86XVC9y5j5/MV43oIw2yGvyLrHqhXMjM3yCawh3f0gWtY8/g9MXTIXBXuN
	 yeqDiBq4zmkGfS/p+GyEjwOcx7c3/Cn7m1zRpYf8eSTSu1uP3w7AIddz987D2wFFXDbhn
	 jvDVBm1bvK6aVNG0VT0KhMLDQG3fUgI1px67AzYjcFptWEz6izAJ2cnfntnf8TISwxCkI
	 yi+BcE0ZhjYXJjr2xLTq+0RcRiDhY0BNYbBKA8lm4feSL/QEJFWcUhIbSw8lXkG3Q/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tzZJB+0n/8VgvfOcihvRdeFOBymK88aG8gIbynhAUmA=;
	b=i90RnT7Ij3cqW7nv804yQlUdBWibNkzv/efwohZQsjLzvOfwkmm+GvFtG7W/faCrn0C/
	 AsH5FvSOMZaL0jYZcGLteHR7iUFqfwQJfCdNW8PNW/leJ44DmWala+5587FCRdMIszgU3
	 j6cWZpB5tK8vqhGZctIMq3pIiEd/hkaQz9rlfK4+Hffmrdgcp7zu668eIBh2Id7ryQTwe
	 aCdRYnnXAf0K2JmKrmpq/KEMQgT2cHvmm/7cTcl3VAy91miGJ9Kwidv8O0FvgV6EZDtgG
	 pJ8LdqWQfkhMqEMuj3Y9KGoMx+Ee0h1JXUX8SI4Jq/S81g3Zz9L499j7zU5PHlPLnRg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=QdKifS5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976662;
	bh=tzZJB+0n/8VgvfOcihvRdeFOBymK88aG8gIbynhAUmA=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZs4KIS+L18CdID1GzKQ0UvekkaCP1RMLMu1u93ATGOQ6zuhP04GHy5/hmmpgCGA/
	 S0z7AZAL/sVYYr+n2p/kyHxnLLQ1bpvTl2Q6z3+3eD9256oXhrgVp7NDzg61e/pxA5
	 MJ1uB/rN4tpeFieiolzlJ6kYKYuBrm6riVuz2OtlWq/sh5OXkHcJnQBJmTht7IISSU
	 xrgkN+tVy32uDcJXVkuGrM6jvZZn/tS8rlr0w6ygt6qzb5PeLkpj4wuL8giyaZa9k+
	 x+0VvtXVDqYOyu5D6h/ymFf+vhtheiyydrD4CDaS1Q6EwMF57rqIR/ZBaGFbtnDOhR
	 91cxavxlpZ9jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 922D160D92;
	Fri,  2 Oct 2026 21:31:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 33A36179
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1956F60D92
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLUeT8oqu4UB for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:29:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3837C60D70
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976595;
 b=ZiCvn/DKW+RdHsvkZtn7yonrA7ghqNj9wG80RHpjWumb8A5EWOj5dnTHucEIKJohvcc9
 fp+dnzseui9CLMHYuIxbQN06iowJLVuSZvadT/DNxFuh1kUFwXIwxCJ+mlN8SFGMooJNT
 ifv+evVECSybl243wSKUc2RMvF2k9JwkJJmoVSuYVfqmD8dWssXipPw4IZF/Y7XKjENcE
 2H8TmjR7GDQqpFXB6n/2qc438iF+mrbHcvTzemjRNDU5Uhp+VHtYWnXme0iO6Ryc0XUJI
 hCFoID35p5wblOjc+g5e0j9gbMxe8b9QPP/qbsGZYGOHxahVtmEGSj0n/ySZWKH5P9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976595;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=tzZJB+0n/8VgvfOcihvRdeFOBymK88aG8gIbynhAUmA=;
 b=K7R3+kEb0bj5ep3HQLYyobxzlqVTxGdeEIUJVeZxmbuJvYQv69o+PgfrBCGttHzF0vmy
 FisIaGdhzt9gpXD4PFgHMiOf3Rt817Br2skUvE8FGCMvsI3ZYTXzyozWz/I956g+NVIRo
 S1LbDM+ZdaCQpIuHEWmH4lQxH4eQJOda/CTa8yY5VADXVmGoNBcbBCUCJ+nSt1+Am1lvU
 01DopnB/Slm4j2o70g5p2WgM7DYOHfVcvw7eLX3kMgheABQuyvQLEDd5VokevWd6R2cfx
 DKVRMWqUMPE1fiD4eHEijwRH+KARxAHUxpQkfwuCk4RLlOInvGt3VzKvXBSfH4hBx/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=QdKifS5y; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=QdKifS5y
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3837C60D70
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976586; x=1791235786;
 bh=tzZJB+0n/8VgvfOcihvRdeFOBymK88aG8gIbynhAUmA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=QdKifS5ymaD2o+DtgszVDxs4gPKDZZR0zv7HZKmdxzDVgYNcY7v2KBB/ZK65f8q3x
 QSW4i56eskdARXyaH0aQ2nFd4qhwQtkx4WXIJ9cKBygqxHZXrguiVR8s13ETa5lcxV
 0MquOKqo4xi7aGMz4W31hdOBgoIgRwE1oC3h5jJ9rNA+wSU2ZM1RaJKHZIF7T+FhvA
 DECtqo6bs0JcOG/hn2LbpvgW5NBBRFMjIcnhLRJ9MklhzDOJPRYULfrJH8PF7M1tvc
 a16uIIHYSH227WzioNcdqu9FhvissVMXBQDSOeAMesM93ovTsRX2f4bEG2Li/vLqB/
 vNBizw6sQEeNQ==
Date: Fri, 02 Oct 2026 21:29:41 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 3/3] mmc: k1: do not release the shared AXI clock and reset on
 probe failure
Message-ID: <a00ed2e7d78b57722496ffb58f1e2965142f456a.1790975596.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975596.git.DaveWK225@protonmail.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: ac16d250e1d9332cabeddb8739ef3090466c1d6f
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

When the probe fails, the driver releases its clock and reset bulks.
clk_release_bulk() disables every clock and reset_release_bulk()
asserts every reset, and the first entry of each is the SDH AXI bus
clock and reset, which all three SDHCI controllers of the K1 share.

One controller failing to probe therefore stops the bus of the others,
and the next register access to any of them hangs the hart. On an
OrangePi RV2, whose device tree enables the eMMC controller without a
max-frequency, the eMMC probe failed in sdhci_setup_cfg() and U-Boot
then hung at "MMC:" probing the microSD controller.

Keep the clocks running and the resets deasserted on failure.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/mmc/spacemit_sdhci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index fec95e3bd7..c191d78067 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -640,10 +640,14 @@ static int spacemit_sdhci_probe(struct udevice *dev)
 =09spacemit_sdhci_phy_init(dev, host);
 =09return 0;
=20
+=09/*
+=09 * Leave the clocks and resets alone on failure. The "core" clock and
+=09 * the "axi" reset are the AXI clock and reset that every SDHCI
+=09 * controller of the K1 shares: releasing them would gate the bus of
+=09 * the other controllers, and the next access to one of them hangs.
+=09 */
 err_reset:
-=09reset_release_bulk(&plat->resets);
 err_clk:
-=09clk_release_bulk(&plat->clks);
 =09return ret;
 }
=20
--=20
2.55.0


