Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCA2C56207
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B72A1607DE;
	Wed,  5 Aug 2026 21:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YocQhyGrScxU; Wed,  5 Aug 2026 21:06:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CDAE607EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785964006;
	bh=/C2LlJji7oSeHvn8iICvJ8Y8+MxEdT54DmDDWosFSME=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0FUwAuX45iMTOSIh95zlZ5ay2k7qS5u5LcUHvadNo+WG7ilQGvgeOWgz/jUzZQdiW
	 CwVPCi8SB1NkOKekPRGcVpAobxW4kmIjMJBUDE47IE9pYgMD91f2uCTVo5/z05dniD
	 UNuWBJOxYSrF2KcxuuB1P/oxXEbff2yImwlG6PTIH7fVV82iYCcpV7aST9wwRrsv0j
	 96ac9N/J1TCL/3mkzrmTLIIYMDJl8fN7kf62ZM5SrKgm9GJxIzHg2+xfOJd7bTGbFB
	 OE+4H83pc2uZZxGWw9LWtzAaXjkkhwusY3NYAq3nZOjMAQK31al03LUGy0GLHQ6GhN
	 2mYEXqfAnWjjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CDAE607EF;
	Wed,  5 Aug 2026 21:06:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B997218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 20:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3244780DAC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 20:43:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L1PuVqF2GweG for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 20:43:02 +0000 (UTC)
X-Greylist: delayed 838 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 05 Aug 2026 20:43:01 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 26BD780D48
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26BD780D48
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=23.83.218.249;
 helo=poodle.tulip.relay.mailchannels.net; envelope-from=smoser@brickies.net;
 receiver=<UNKNOWN> 
Received: from poodle.tulip.relay.mailchannels.net
 (poodle.tulip.relay.mailchannels.net [23.83.218.249])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26BD780D48
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 20:43:01 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@smoser.brickies.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9794F3E196F;
 Wed, 05 Aug 2026 20:31:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com
 (trex-green-6.trex.outbound.svc.cluster.local [100.111.249.226])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 5D7C73E0D41;
 Wed, 05 Aug 2026 20:31:15 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@smoser.brickies.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@smoser.brickies.net
X-MailChannels-Auth-Id: dreamhost
X-Troubled-Eyes: 1828b1321cedd65d_1785961875494_3042009925
X-MC-Loop-Signature: 1785961875494:1775165664
X-MC-Ingress-Time: 1785961875494
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.249.226 (trex/8.0.2); Wed, 05 Aug 2026 20:31:15 +0000
Received: from localhost (21.239.30.34.bc.googleusercontent.com [34.30.239.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: smtp@smoser.brickies.net)
 by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4hFhrf6434z103S;
 Wed,  5 Aug 2026 13:31:14 -0700 (PDT)
From: Scott Moser <smoser@brickies.net>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dustin Kirkland <kirkland@chainguard.dev>,
 Dustin Kirkland <dustin.kirkland@chainguard.dev>
Subject: [PATCH] dm: pci: fix uninitialized fdt_pci_addr fall-through in
 pci_get_devfn
Date: Wed,  5 Aug 2026 13:31:13 -0700
Message-ID: <20260805203113.46567-1-smoser@brickies.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Aug 2026 21:06:43 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brickies.net; s=dreamhost; t=1785961875;
 bh=/C2LlJji7oSeHvn8iICvJ8Y8+MxEdT54DmDDWosFSME=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=BzpfdrLVHpaRSL0jck1uMrC2evl17KJMHi5+jj0dGkGWvbxLfkFhgt7p7y0IXLGJ+
 87roNPKF/ue9/imFX3mrGN/R6hfSYFv3RnlBdakEZtz/DHfavkDwjyPNopxplkEWpJ
 mM1ZYHlxUDVky8u8zEPGfnllKtqUOEUe5ez8bXrxUk+7PgeanZgxGEvl+WlskFgijE
 8rVBqKVU/Kh4Fs2dNG9afVx+22Gn01VLz1u0Aak6zFqtC48pkUIwh6ernoU7hHIDIA
 YVV42yoctdFo4VA98HWFTlO1n6Wvs2+OiNyFCm68HrCDpJ032jqljCMXnSIWEZIsJg
 P49USKL3rpOvA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=brickies.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=brickies.net header.i=@brickies.net header.a=rsa-sha256
 header.s=dreamhost header.b=BzpfdrLV
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

Concretely, this fires on Raspberry Pi 5 (BCM2712) with vendor U-Boot
v2026.07 when the tree is compiled with GCC -ftrivial-auto-var-init=zero.
In that build addr.phys_hi is zeroed rather than left as stack junk, so
pci_get_devfn() returns 0 for every DT-declared non-PCI child of a PCI
bus. The Pi 5 device tree includes one such child under the second root
complex -- the rp1 simple-bus node representing the on-SoC RP1 south
bridge as seen from the OS side. Under zero-init:

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

The only observable behaviour change is that DT-declared non-PCI
children of PCI buses now consistently report -EINVAL from
pci_get_devfn() rather than a value that depends on stack state.

Reported-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
Fixes: b52142004fbd ("pci: Add pci_get_devfn() to extract devfn from the fdt_pci_addr")
Signed-off-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
Investigated-by: Claude Opus 4.7 <noreply@anthropic.com>
Co-authored-by: Claude Opus 4.7 <noreply@anthropic.com>
---
 drivers/core/util.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/core/util.c b/drivers/core/util.c
index fa893485..57006554 100644
--- a/drivers/core/util.c
+++ b/drivers/core/util.c
@@ -20,10 +20,8 @@ int pci_get_devfn(struct udevice *dev)
 	/* Extract the devfn from fdt_pci_addr */
 	ret = ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_CONFIG,
 				   "reg", &addr, NULL);
-	if (ret) {
-		if (ret != -ENOENT)
-			return -EINVAL;
-	}
+	if (ret)
+		return -EINVAL;
 
 	return addr.phys_hi & 0xff00;
 }
-- 
2.43.0

