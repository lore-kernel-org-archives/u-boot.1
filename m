Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92509EA4E24
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 15:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A0183F2A;
	Mon,  2 Mar 2026 16:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F350183F2A; Mon,  2 Mar 2026 16:43:10 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1C6483F2D
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 16:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id 48E2768BFE; Mon,  2 Mar 2026 16:43:06 +0100 (CET)
Received: from rocky.lan (dynamic-095-114-042-014.95.114.pool.telefonica.de
 [95.114.42.14])
 by verein.lst.de (Postfix) with ESMTPSA id E98B76732A;
 Mon,  2 Mar 2026 16:42:56 +0100 (CET)
Date: Mon, 2 Mar 2026 16:42:56 +0100
From: Torsten Duwe <duwe@lst.de>
To: Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger
 <mbrugger@suse.com>, Andrea della Porta <andrea.porta@suse.com>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [hack] help U-Boot find the correct PCIe inbound offset for NVMe on
 Raspberry Pi 5
Message-ID: <20260302164256.29af9995@rocky.lan>
In-Reply-To: <20260302135940.550e6051@rocky.lan>
References: <20260302135940.550e6051@rocky.lan>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 2 Mar 2026 13:59:40 +0100
Torsten Duwe <duwe@lst.de> wrote:

> This proposed patch uses the already existent dev_phys_to_bus(),
> which can dig up the correct offset from associated DT nodes and
> subtract it.

Just to make it clear, that patch is a necessary but not a sufficient
condition to boot the RPi5 from NVMe. The PCIe bus node above
the NVMe is generated dynamically has no DT node with dma-ranges and so
dev_phys_to_bus() still returns zero. In order to test NVMe on the
RPi5 you can either:

hard code the 64GiB value when building your private U-Boot binary:

-#define BUS_ADDR(a)         dev_phys_to_bus(dev->udev, (a))
+#define BUS_ADDR(a)            ((a)+0x1000000000LL)

OR use this tricky DT change Andrea has prepared:

--- a/dts/upstream/src/arm64/broadcom/bcm2712.dtsi
+++ b/dts/upstream/src/arm64/broadcom/bcm2712.dtsi
@@ -571,6 +571,15 @@
 				<0x03000000 0xff 0xfffff000 0x10 0x00131000 0x00 0x00001000>; 
 			status = "disabled";
+
+			pci@0,0 {
+				reg = <0x00 0x00 0x00 0x00 0x00>;
+				device_type = "pci";
+				#address-cells = <0x03>;
+				#size-cells = <0x02>;
+				ranges;
+				dma-ranges;
+			};
 		};
 
 		pcie2: pcie@1000120000 {

This pci@0,0 node needs to be below the pcie@1000110000 RC node so it
can "bridge" dev_phys_to_bus() to the RC node when it climbs up the
device tree and so helps it find the correct value.

AFAICS the proper fix should be to add some dma-ranges property when
dynamic PCI devices are created during enumeration/scan or make
dev_phys_to_bus() skip those nodes for the lookup.

	Torsten
