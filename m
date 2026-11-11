Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2D606A320
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w386mlMo;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oErfy2tV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D70660AC7;
	Wed, 11 Nov 2026 06:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z_ogjPjHffqr; Wed, 11 Nov 2026 06:46:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9573607A8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794379591;
	b=D5Dmk7jjKVU25gAWgPYyf/eSVQfbd2t+5ZSxqcsVNcfzacu5bzA6f6TYAxJ+B2Vp9ka9
	 6NWT9zh3u8NXD7BDDz00rNo5hTx3ivTlYNKt00Q6JdVqxPlIfmwQKv/SfZUjsd+A3eMyt
	 kQDb7/383n1L6F/x1iGIpXdoCu4v8FO3upvPP4s42heQ5j1isJDuIh6D8cKHX42qBPi7R
	 qg4dpP+rlhV3OYngHADF6oQ+eHrwIGpnM8++Xypn9UmGTWBdSlmF+nYFguoYn+ZhbV9nw
	 mdrx/fPdYcCl/T+8l+AcXbg5T232+yVHCTJ/CFmkrxwVSHjO7xzth4SxC09yqKmOnYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794379591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IMyQSUtP6b0HP4x7JhBbto4VX8Wisazyfaqlhchbif0=;
	b=VIlhQONPXbETfGuFxuLtX0uEgWucLM7dk1BjiWF4ckGkiviP8Z/0LFj7BgqHsTgNQjk3
	 EEnv/fUO0iNk6E18byhzLtSpqmADerjvR0aGTnPkR5NaAbmm/ms4Rs4g44O7faXdbc1AF
	 0wOD8SKpjgYjA1xOvnw19tUUY6c/0ddfnWvYEq6KC1aEBoQCEDauYenROB7aKJQ3Lm06k
	 uYNINIcW89JvwWL9+/h2bZ49iRR1hqKM+j9vm/aC+eKqA8mgfx5EF/PjBWHqebbuYsqDJ
	 iMq+VuGp/bUGx9mXe7zPp+rxVZlxSVQu9MuU/30P4V0c4RrE081VgIOIQnNLuaD1B7A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794379591;
	bh=IMyQSUtP6b0HP4x7JhBbto4VX8Wisazyfaqlhchbif0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w386mlMoi/sAF9NOparDFb90IsXHpwzmjJaor83rcYC6f56gtRSXX6mRe4tZK0dgk
	 yr5ad0tCaZ2VAzN2fBmYFAt1AXD8KJoqHL6803jo4qJzKrOcbG7fp6qYsQKcykkeyJ
	 CgI5g1iG71oTP/PxgBcSqiNMYDlWYncm0xDP5yAMArGqVOZFhVA5PRPwSEiNtK10h/
	 gUGQDVreAbOaVuvVMdP0gqtyiACPwkTOwGSCWCaA5za5jYLn86kbpnVpG4pLVCkMKb
	 byU7mjn8GASlqe4f6MOHRCUgVFz7tRPcAoOfn5TH30146WJ/jAP4Nons8LIL9ovoC4
	 5wccqMzgL8h+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9573607A8;
	Wed, 11 Nov 2026 06:46:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EBE27731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 06:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD14940318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 06:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sAp5SefSHUAr for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 06:46:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 73017400B0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=oErfy2tV
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73017400B0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 06:46:27 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jPYvh3CQLzKm53;
 Wed, 11 Nov 2026 07:46:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794379584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IMyQSUtP6b0HP4x7JhBbto4VX8Wisazyfaqlhchbif0=;
 b=oErfy2tVmb25Ov1SMKqaEfQXdQ08MXLFAC7E5RTN1VRyMcm1kv6/wYbYyEeAKjOfSjV+2W
 li/kcOP13ao47tgogbtbY8Etbh9xXyfS9tS2ocAQIddMLDsYo5d9hR/x/nVATIRENpsAVc
 Zukk3hrGr8zu7tp7KbSIFbb4J7/MOFVePmgoXzVGhETwahhAS0BtLtGIzRtPGv/APdF6z0
 bpYfQMG1bgZ49lFr0K7ACMO0n7P9CyAsMyJWisPyAZAx0EcphfgoPj+AwA6ZK/Xp2Gsb7f
 8EXKtx75SbiCuAnsC9Bv0FkH5JPR3k2DoIP0Fb529ipwWTZiDQZyHs0q5itc4Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pci: pcie-rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes
Date: Wed, 11 Nov 2026 07:46:05 +0100
Message-ID: <20261111064621.496174-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uyze96iknxbtr4yuyja89tka1romcohr
X-MBO-RS-ID: 6c8ce21e1d7d8211649
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
Max_Payload_Size (MPS). PCIe specification indicates that the MPS
must not exceed minimum MPS of any element along the packet path.
Add a check to warn if MPS is ever set larger than 256.

R-Car Gen4 Reference Manual, chapter 104.4.8 Usage notes for MRRS
(Max Read Request Size) states:

  Please set "Max Read Request Size" to 128 bytes or 256 bytes.
  If "Max Read Request Size" is set to anything other than the
  above, the transferred data will not match the expected value.

This limitation also seems to apply to devices doing DMA reads,
i.e. issuing MRd TLPs. This limitation can be triggered by using
non-HMB NVMe SSD with Max_Read_Request_Size 512 Bytes, for example
Crucial P5 Plus. Any write to the SSD (MRd TLP issued by the SSD
controller) longer than 256 Bytes wraps around at the 256 Byte
boundary, and the same data are written to the SSD starting at
offset 0 and at 256 Bytes.

Limit Max_Read_Request_Size to at most 256 Bytes for each device
connected to this PCIe controller to avoid this behavior.

The symptom is a read from the SSD which wraps around at 256 Byte
boundary. The test for this symptom can be implemented by writing
512 Byte of random data into the SSD and reading the data back. If
the read back data repeat after 256 Bytes, the device is affected.

Test:
"
    => pci enum

    => pci
    BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
    _____________________________________________________________
    00.00.00   0x1912     0x0030     Bridge device           0x04
    02.00.00   0x1912     0x0030     Bridge device           0x04
    01.00.00   0xc0a9     0x5407     Mass storage controller 0x08
    03.00.00   0x1912     0x0014     Serial bus controller   0x03

    => nvme scan
    => nvme info
    Device 0: Vendor: 0xc0a9 Rev: P7CR403  Prod: 22323A68A6D7
                Type: Hard Disk
                Capacity: 476940.0 MB = 465.7 GB (976773168 x 512)

Before:
    # Display SSD PCIe capability DEVCTL Max_Read_Request_Size
    => pci display.w 01.00.00 0 0x38
    ...
    00000060: 0010 0002 8fe2 1000 2810 0000 f844 0045
                                  ^
                         EXPCAP DEVCTL MRRS 512B

    # Generate 256B + 256B of different data in DRAM and write them to the SSD
    => mw 0x54000000 0x1234abcd 0x40
    => mw 0x54000100 0xfedc5678 0x40
    => nvme write 0x54000000 0 2

    # Read data back and print the data
    => nvme read 0x58000000 0 2
    => md 0x58000000 0x4
    => md 0x58000100 0x4
    58000000: 1234abcd 1234abcd 1234abcd 1234abcd
    58000100: 1234abcd 1234abcd 1234abcd 1234abcd <--- faulty 256B wrap around

After:
    # Display SSD PCIe capability DEVCTL Max_Read_Request_Size
    => pci display.w 01.00.00 0 0x38
    ...
    00000060: 0010 0002 8fe2 1000 1810 0009 f844 0045
                                  ^
                         EXPCAP DEVCTL MRRS 256B

    # Generate 256B + 256B of different data in DRAM and write them to the SSD
    => mw 0x54000000 0x1234abcd 0x40
    => mw 0x54000100 0xfedc5678 0x40
    => nvme write 0x54000000 0 2

    # Read data back and print the data
    => nvme read 0x58000000 0 2
    => md 0x58000000 0x4
    => md 0x58000100 0x4
    58000000: 1234abcd 1234abcd 1234abcd 1234abcd
    58000100: fedc5678 fedc5678 fedc5678 fedc5678 <--- correct content
"

Ported from Linux commit f0a5c6bd797c ("PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes")

Reported-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/pci/pci-rcar-gen4.c | 111 ++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index b1d43b2e7aa..89a3772870a 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -400,6 +400,112 @@ static int rcar_gen4_pcie_load_firmware(struct rcar_gen4_pcie *rcar)
 	return ret;
 }
 
+static int rcar_gen4_pcie_post_probe(void *ctx, struct event *event)
+{
+	struct udevice *dev, *bus = event->data.dm.dev;
+	int pcie_off, ret;
+	u16 devctl;
+
+	if (!bus || !bus->driver)
+		return 0;
+
+	if (bus->driver->id != UCLASS_PCI && bus->driver->id != UCLASS_PCI_GENERIC)
+		return 0;
+
+	if (dev_has_ofnode(bus) && dev_read_bool(bus, "pci,no-autoconfig"))
+		return 0;
+
+	pcie_off = dm_pci_find_capability(bus, PCI_CAP_ID_EXP);
+	if (!pcie_off)
+		return 0;
+
+	dm_pci_read_config16(bus, pcie_off + PCI_EXP_DEVCTL, &devctl);
+	/*
+	 * R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
+	 * Max_Payload_Size (MPS). PCIe specification indicates that the MPS
+	 * must not exceed minimum MPS of any element along the packet path.
+	 * The controller reports Max_Payload_Size_Supported (MPSS) 256 Bytes
+	 * for header type 0 and 128 Bytes for header type 1. The PCIe core
+	 * will not allow MPS to be set higher than MPSS; warn here in case
+	 * something went very wrong in the core.
+	 *
+	 * For details, refer to chapter "104.1.1 Features" in either of:
+	 * R-Car S4 R19UH0161EJ0140 Rev.1.40 Jul. 31, 2026 or
+	 * R-Car V4H R19UH0186EJ0140 Rev.1.40 Aug. 7, 2026 or
+	 * R-Car V4M R19UH0217EJ0110 Rev.1.10 Jun. 30, 2026.
+	 */
+	if ((devctl & PCI_EXP_DEVCTL_PAYLOAD) > PCI_EXP_DEVCTL_PAYLOAD_256B) {
+		/* Controller MPS should already be 256B or less. */
+		dev_err(bus, "MPS over limit, DEVCTL=0x%04x\n", devctl);
+		ret = dm_pci_clrset_config16(bus, pcie_off + PCI_EXP_DEVCTL,
+					     PCI_EXP_DEVCTL_PAYLOAD, PCI_EXP_DEVCTL_PAYLOAD_256B);
+		if (ret)
+			dev_err(bus, "MPS update failed, ret=%d\n", ret);
+	}
+
+	/*
+	 * R-Car Gen4 Reference Manual, chapter 104.4.8 Usage notes for
+	 * MRRS (Max Read Request Size) states:
+	 *
+	 *   Please set "Max Read Request Size" to 128 bytes or 256 bytes.
+	 *   If "Max Read Request Size" is set to anything other than the
+	 *   above, the transferred data will not match the expected value.
+	 *
+	 * This limitation also seems to apply to devices issuing MRd TLPs.
+	 * This limitation can be triggered by using non-HMB NVMe SSD with
+	 * Max_Read_Request_Size 512 Bytes, for example Crucial P5 Plus.
+	 * Any write into the SSD (MRd TLP issued by the SSD) longer than
+	 * 256 Bytes wraps around at 256 Byte boundary, and the same data
+	 * are written into the SSD starting at offset 0 and at 256 Bytes.
+	 *
+	 * Limit Max_Read_Request_Size to at most 256 Bytes for each
+	 * device connected to this PCIe controller to avoid this behavior.
+	 *
+	 * For details, refer to aforementioned chapter in either of:
+	 * R-Car S4 R19UH0161EJ0140 Rev.1.40 Jul. 31, 2026 or
+	 * R-Car V4H R19UH0186EJ0140 Rev.1.40 Aug. 7, 2026 or
+	 * R-Car V4M R19UH0217EJ0110 Rev.1.10 Jun. 30, 2026.
+	 */
+	if ((devctl & PCI_EXP_DEVCTL_READRQ) > PCI_EXP_DEVCTL_READRQ_256B) {
+		ret = dm_pci_clrset_config16(bus, pcie_off + PCI_EXP_DEVCTL,
+					     PCI_EXP_DEVCTL_READRQ, PCI_EXP_DEVCTL_READRQ_256B);
+		if (ret)
+			dev_err(bus, "MRRS update failed, ret=%d\n", ret);
+	}
+
+	/* Apply aforementioned limits to downstream devices too. */
+	for (device_find_first_child(bus, &dev); dev; device_find_next_child(&dev)) {
+		if (dev_has_ofnode(dev) && dev_read_bool(dev, "pci,no-autoconfig"))
+			continue;
+
+		pcie_off = dm_pci_find_capability(dev, PCI_CAP_ID_EXP);
+		if (!pcie_off)
+			continue;
+
+		dm_pci_read_config16(dev, pcie_off + PCI_EXP_DEVCTL, &devctl);
+
+		if ((devctl & PCI_EXP_DEVCTL_PAYLOAD) > PCI_EXP_DEVCTL_PAYLOAD_256B) {
+			/* MPS should already be 256B or less. */
+			dev_err(dev, "MPS over limit, DEVCTL=0x%04x\n", devctl);
+			ret = dm_pci_clrset_config16(bus, pcie_off + PCI_EXP_DEVCTL,
+						     PCI_EXP_DEVCTL_PAYLOAD,
+						     PCI_EXP_DEVCTL_PAYLOAD_256B);
+			if (ret)
+				dev_err(dev, "MPS update failed, ret=%d\n", ret);
+		}
+
+		if ((devctl & PCI_EXP_DEVCTL_READRQ) > PCI_EXP_DEVCTL_READRQ_256B) {
+			ret = dm_pci_clrset_config16(dev, pcie_off + PCI_EXP_DEVCTL,
+						     PCI_EXP_DEVCTL_READRQ,
+						     PCI_EXP_DEVCTL_READRQ_256B);
+			if (ret)
+				dev_err(dev, "MRRS update failed, ret=%d\n", ret);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * rcar_gen4_pcie_probe() - Probe the PCIe bus for active link
  *
@@ -449,6 +555,11 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
 	if (IS_ERR(rcar->pe_rst))
 		return PTR_ERR(rcar->pe_rst);
 
+	ret = event_register("pcie post probe", EVT_DM_POST_PROBE,
+			     rcar_gen4_pcie_post_probe, dev);
+	if (ret)
+		return ret;
+
 	ret = rcar_gen4_pcie_host_init(dev);
 	if (ret)
 		return ret;
-- 
2.53.0

