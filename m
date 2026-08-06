Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDD9C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 01:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2383E4088E;
	Fri,  7 Aug 2026 01:50:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MSHcsJgzJQfM; Fri,  7 Aug 2026 01:50:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49EA64088F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786067424;
	bh=RjbEtiwdkbH6lTRW7ZIQc48QywZcRrJXOg5/F1FPLgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VmSvIuNrolnl4g81Nok7ECGP+AU8XEBCtCaJnFXUmQi5t0GQxZtnaD+PYpiBATvwh
	 9fxm4+saWkEC12iOVomjGnQq6gYinYAjouFL/2EsOOOc01SO9JY610O5pfbqA4qYFr
	 HDl25244HGKZ55rs4MJwDPLHjKwP3dF+FCuvCLdAsz0afbLYAZzolmGdfVYi7BhFMa
	 BsWpWLnIbR7R6S46FFjwRevEaJK9F9sg+erQlV84inahFiwJxM2RrPdx2Uh1jTNuvX
	 JFxBSKTE3yOgKMKUftZ/5duthE/G9xgaz6P265KCIMbqeP/lAfk/KHkpaObNMP0V4x
	 7nkb2UV9tDmNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49EA64088F;
	Fri,  7 Aug 2026 01:50:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BFB6392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D7DE4085E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:18:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OrCtQoYkZbRa for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 18:18:45 +0000 (UTC)
X-Greylist: delayed 78310 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 06 Aug 2026 18:18:44 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E029C4083F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E029C4083F
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=23.83.222.40;
 helo=cornsilk.ash.relay.mailchannels.net; envelope-from=smoser@brickies.net;
 receiver=<UNKNOWN> 
Received: from cornsilk.ash.relay.mailchannels.net
 (cornsilk.ash.relay.mailchannels.net [23.83.222.40])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E029C4083F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:18:44 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@smoser.brickies.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id E8FDB462A4A;
 Thu, 06 Aug 2026 18:18:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com
 (100-111-77-141.trex-nlb.outbound.svc.cluster.local [100.111.77.141])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 9C0B646294C;
 Thu, 06 Aug 2026 18:18:42 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@smoser.brickies.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@smoser.brickies.net
X-MailChannels-Auth-Id: dreamhost
X-Exultant-Little: 152ac3a352d635de_1786040322764_215777674
X-MC-Loop-Signature: 1786040322764:3999777313
X-MC-Ingress-Time: 1786040322763
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.77.141 (trex/8.0.2); Thu, 06 Aug 2026 18:18:42 +0000
Received: from localhost (unknown [206.169.177.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: smtp@smoser.brickies.net)
 by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4hGFsG2qZFz1QJ; 
 Thu,  6 Aug 2026 11:18:42 -0700 (PDT)
From: Scott Moser <smoser@brickies.net>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dustin Kirkland <dustin.kirkland@chainguard.dev>,
 Scott Moser <smoser@brickies.net>
Subject: [PATCH v2] dm: pci: fix uninitialized fdt_pci_addr fall-through in
 pci_get_devfn
Date: Thu,  6 Aug 2026 11:18:18 -0700
Message-ID: <20260806181818.197191-1-smoser@brickies.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805203113.46567-1-smoser@brickies.net>
References: <20260805203113.46567-1-smoser@brickies.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 01:50:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brickies.net; s=dreamhost; t=1786040322;
 bh=RjbEtiwdkbH6lTRW7ZIQc48QywZcRrJXOg5/F1FPLgw=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=d6BS9/9++/SmCTN2S53tpvWK99AU3087pFD1jJgTFOL2NImDobG823kFBrp/6tWFM
 KG7z3r+K36eNFYO3VGJt1dSYIJlfJLDQUL07AHN64oO8KeT7VFTsaGNleuHwS/zFAa
 DGA5iTmW1ObMbb3Kd8B/DA0tHJBivL+qNGpT2RVcSapZ4cVR1H2HvynR8NAB1RtJHs
 ryowqDJyZ7+4iHL+UbPsTK6IFVNa7goaGylMzM99E4bM9Cn9+hffr8G0BEklZ+ieYf
 3kdPfIz7gZV9tqPditts8sxkYKn3tJPjETL2yikY+i/VUwDv+HyPFIlh1qm/KwkQjW
 iyk0bELg9L+Mg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=brickies.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=brickies.net header.i=@brickies.net header.a=rsa-sha256
 header.s=dreamhost header.b=d6BS9/9+
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

From: Dustin Kirkland <dustin.kirkland@chainguard.dev>

pci_get_devfn() reads addr.phys_hi and returns the low bits of it as the
requested devfn even on the -ENOENT branch, where ofnode_read_pci_addr()
has NOT written *addr. The C standard leaves that read undefined; in
practice the returned value depends on the compilers stack layout and on
-ftrivial-auto-var-init. That value ends up in pplat->devfn (set by
pci_uclass_child_post_bind()) and is later compared for equality in
pci_bus_find_devfn() during PCI enumeration, so an under-determined
value produces an under-determined driver-binding outcome.

Concretely, this fires on Raspberry Pi 5 (BCM2712) when built with GCC
-ftrivial-auto-var-init=zero. In that build addr.phys_hi is zeroed
rather than left as stack junk, so pci_get_devfn() returns 0 for every
DT-declared non-PCI child of a PCI bus. The Pi 5 device tree includes
one such child under the second root complex -- the rp1 simple-bus
node representing the on-SoC RP1 south bridge as seen from the OS
side. Under zero-init:

  * pci_uclass_child_post_bind(rp1) sets pplat->devfn = 0
  * pci_bind_bus_devices() of the second root complex reads vendor at
    bdf 02:00.0, calls pci_bus_find_devfn(bus, 0x0000, &dev)
  * pci_bus_find_devfn() finds rp1 with pplat->devfn == 0x0000 == the
    requested devfn, returns it as the pre-bound match
  * pci_find_and_bind_driver() is skipped; the RP1 root port is never
    bound as pci_bridge_drv and its downstream bus is never enumerated
  * dm_pciauto_postscan_setup_bridge() then writes PCI_SUBORDINATE_BUS
    = 0 and PCI_MEMORY_LIMIT = 0 on the root port; Linux flags the
    bridge as "bridge configuration invalid ([bus 01-00])", the rp1
    driver fails to enable the endpoint with -EINVAL, and every
    RP1-hosted peripheral (USB, onboard Ethernet, ttyAMA10) is
    non-functional for the rest of boot.

Under the default -ftrivial-auto-var-init=uninitialized, addr.phys_hi
happens to be non-zero stack residue that does not collide with the
requested devfn, so the same code path just returns -ENODEV from
pci_bus_find_devfn() and pci_find_and_bind_driver() correctly runs the
fallback. The bug has been latent since introduction; -zero exposes it
deterministically.

A "reg" property that is simply absent now consistently returns -ENODEV,
matching the documented contract in include/dm/pci.h, instead of a value
that depends on stack state. A malformed "reg" property still returns
-EINVAL, as it did before this fix.

Fixes: b52142004fbd ("pci: Add pci_get_devfn() to extract devfn from the fdt_pci_addr")
Signed-off-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
Cc: Scott Moser <smoser@brickies.net>
---
 drivers/core/util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/core/util.c b/drivers/core/util.c
index fa893485..57006554 100644
--- a/drivers/core/util.c
+++ b/drivers/core/util.c
@@ -20,10 +20,10 @@ int pci_get_devfn(struct udevice *dev)
 	/* Extract the devfn from fdt_pci_addr */
 	ret = ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_CONFIG,
 				   "reg", &addr, NULL);
-	if (ret) {
-		if (ret != -ENOENT)
-			return -EINVAL;
-	}
+	if (ret == -ENOENT)
+		return -ENODEV;
+	if (ret)
+		return -EINVAL;

 	return addr.phys_hi & 0xff00;
 }
-- 
2.43.0

