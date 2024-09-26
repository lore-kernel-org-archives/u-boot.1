Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD0ACCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 05:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7E888C8F;
	Thu, 26 Sep 2024 07:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y6jBoAB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 476E98891E; Thu, 26 Sep 2024 07:02:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ACBC88CBA
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 07:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48Q51oOF008417;
 Thu, 26 Sep 2024 00:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727326910;
 bh=jTA/Yo+N48Xv2vDs4E4mCr5WvdBtTpsavZoqHu3t4H8=;
 h=From:To:CC:Subject:Date;
 b=y6jBoAB6I2+D4R298SSBnWfhkq1Xqw0CAxfMZrML2F8YgpSuGEhSX8BCyoakudzPD
 mg9kCa5teO/hroPZP8NmDVFQ1ckfGCqKptOw3ZsIO6ZiuaMTHMN5SQW9FRLTGT7P6l
 IQ2GsOTl8ugM+vfJ6faFuwz3JjVhqXj/Hze1L1RM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q51o0g052507;
 Thu, 26 Sep 2024 00:01:50 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 00:01:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 00:01:50 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q51nsA097349;
 Thu, 26 Sep 2024 00:01:50 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Jonathan Humphreys <j-humphreys@ti.com>, Sjoerd Simons
 <sjoerd@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>,
 Chintan Vankar <c-vankar@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] doc: board: ti: am62x_sk: Add document for Ethernet boot on
 AM62x SoC.
Date: Thu, 26 Sep 2024 10:31:38 +0530
Message-ID: <20240926050138.1028982-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Document the procedure to enable Ethernet Boot on AM62x SoC.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on commit '4386ab9118e7' of origin/next branch of
U-Boot. 

 doc/board/ti/am62x_sk.rst | 196 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index b9d35244d44..a1a4d5c52bf 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -291,6 +291,10 @@ https://www.ti.com/lit/pdf/spruiv7 under the `Boot Mode Pins` section.
      - 00000000
      - 11001010
 
+   * - Ethernet
+     - 00110000
+     - 11000100
+
 For SW2 and SW1, the switch state in the "ON" position = 1.
 
 DFU based boot
@@ -316,6 +320,198 @@ When using dfu-util the following commands can be used to boot to a U-Boot shell
 
 .. am62x_evm_rst_include_end_dfu_boot
 
+Ethernet based boot
+-------------------
+
+To boot the board via Ethernet, configure the BOOT MODE pins for Ethernet boot.
+
+On powering on the device, ROM uses the Ethernet Port corresponding to CPSW3G's MAC
+Port 1 to transmit "TI K3 Bootp Boot".
+
+The TFTP server and DHCP server on the receiver device need to be configured such
+that VCI string "TI K3 Bootp Boot" maps to the file `tiboot3.bin` and the TFTP
+server should be capable of transferring it to the device.
+
+**Configuring DHCP server includes following steps:**
+
+* Install DHCP server:
+
+.. prompt:: bash $
+
+  sudo apt install isc-dhcp-server
+
+* Disable services before configuring:
+
+.. prompt:: bash $
+
+  sudo systemctl disable --now isc-dhcp-server.service isc-dhcp-server6.service
+
+* DHCP server setup
+
+Run the ip link or ifconfig command to find the name of your network interface:
+
+Example
+
+.. code-block::
+
+  eno1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
+        inet 172.24.145.229  netmask 255.255.254.0  broadcast 172.24.145.255
+        inet6 fe80::bbd5:34c8:3d4c:5de4  prefixlen 64  scopeid 0x20<link>
+        ether c0:18:03:bd:b1:a6  txqueuelen 1000  (Ethernet)
+        RX packets 2733979  bytes 1904440459 (1.9 GB)
+        RX errors 0  dropped 3850  overruns 0  frame 0
+        TX packets 796807  bytes 84534764 (84.5 MB)
+        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
+        device interrupt 16  memory 0xe2200000-e2220000
+
+  enxf8e43b8cffe8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
+          ether f8:e4:3b:8c:ff:e8  txqueuelen 1000  (Ethernet)
+          RX packets 95  bytes 31160 (31.1 KB)
+          RX errors 0  dropped 0  overruns 0  frame 0
+          TX packets 89  bytes 17445 (17.4 KB)
+          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
+
+  lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
+          inet 127.0.0.1  netmask 255.0.0.0
+          inet6 ::1  prefixlen 128  scopeid 0x10<host>
+          loop  txqueuelen 1000  (Local Loopback)
+          RX packets 85238  bytes 7244462 (7.2 MB)
+          RX errors 0  dropped 0  overruns 0  frame 0
+          TX packets 85238  bytes 7244462 (7.2 MB)
+          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
+
+Suppose we are using enxf8e43b8cffe8 interface, one end of it is connected to host PC
+and other to board.
+
+* Do the following changes in /etc/dhcp/dhcpd.conf in host PC.
+
+.. code-block::
+
+  subnet 192.168.0.0 netmask 255.255.254.0
+  {
+  range dynamic-bootp 192.168.0.2 192.168.0.5;
+  if substring (option vendor-class-identifier, 0, 16) = "TI K3 Bootp Boot"
+  {
+  filename "tiboot3.bin";
+  } elsif substring (option vendor-class-identifier, 0, 20) = "AM62X U-Boot R5 SPL"
+  {
+  filename "tispl.bin";
+  } elsif substring (option vendor-class-identifier, 0, 21) = "AM62X U-Boot A53 SPL"
+  {
+  filename "u-boot.img";
+  }
+  default-lease-time 60000;
+  max-lease-time 720000;
+  next-server 192.168.0.1;
+  }
+
+* Do following changes in /etc/default/isc-dhcp-server
+
+.. code-block::
+
+  DHCPDv4_CONF=/etc/dhcp/dhcpd.conf
+  INTERFACESv4="enxf8e43b8cffe8"
+  INTERFACESv6=""
+
+* For your interface change ip address and netmask to next-server and your netmask
+
+.. prompt:: bash $
+
+  sudo ifconfig enxf8e43b8cffe8 192.168.0.1 netmask 255.255.254.0
+
+* Enable DHCP
+
+.. prompt:: bash $
+
+  sudo systemctl enable --now isc-dhcp-server
+
+* To see if there is any configuration error or if dhcp is running run
+
+.. prompt:: bash $
+
+  sudo service isc-dhcp-server status
+  # If it shows error then something is wrong with configuration
+
+**For TFTP setup follow below steps:**
+
+* Install TFTP server:
+
+.. prompt:: bash $
+
+  sudo apt install tftpd-hpa
+
+tftpd-hpa package should be installed.
+
+Now, check whether the tftpd-hpa service is running with the following command:
+
+.. prompt:: bash $
+
+  sudo systemctl status tftpd-hpa
+
+* Configuring TFTP server:
+
+The default configuration file of tftpd-hpa server is /etc/default/tftpd-hpa.
+If you want to configure the TFTP server, then you have to modify this configuration
+file and restart the tftpd-hpa service afterword.
+
+To modify the /etc/default/tftpd-hpa configuration file, run the following command
+
+.. prompt:: bash $
+
+  sudo vim /etc/default/tftpd-hpa
+
+Configuration file may contain following configuration options by default:
+
+.. code-block::
+
+  # /etc/default/tftpd-hpa
+
+  TFTP_USERNAME="tftp"
+  TFTP_DIRECTORY="/var/lib/tftpboot"
+  TFTP_ADDRESS=":69"
+  TFTP_OPTIONS="--secure"
+
+Now change the **TFTP_DIRECTORY** to **/tftp** and add the **--create** option to the
+**TFTP_OPTIONS**. Without the **--create** option, you won't be able to create or upload
+new files to the TFTP server. You will only be able to update existing files.
+
+After above changes /etc/default/tftpd-hpa file would look like this:
+
+.. code-block::
+
+  # /etc/default/tftpd-hpa
+
+  TFTP_USERNAME="tftp"
+  TFTP_DIRECTORY="/tftp"
+  TFTP_ADDRESS=":69"
+  TFTP_OPTIONS="--secure --create"
+
+Since we have configured tftp directory as /tftp, put tiboot3.bin, tispl.bin
+and u-boot.img after building it using sdk or manually cloning all the repos.
+
+To build binaries use following defconfig files:
+
+.. code-block::
+
+  am62x_evm_r5_ethboot_defconfig
+  am62x_evm_a53_ethboot_defconfig
+
+`tiboot3.bin` is expected to be built from `am62x_evm_r5_ethboot_defconfig` and
+`tispl.bin` and `u-boot.img` are expected to be built from
+`am62x_evm_a53_ethboot_defconfig`.
+
+Images should get fetched in following sequence as a part of boot procedure:
+
+.. code-block::
+
+  tiboot3.bin => tispl.bin => u-boot.img
+
+ROM loads and executes `tiboot3.bin` provided by the TFTP server.
+
+Next, based on NET_VCI_STRING string mentioned in respective defconfig file `tiboot3.bin`
+fetches `tispl.bin` and then `tispl.bin` fetches `u-boot.img` from TFTP server which
+completes Ethernet boot on the device.
+
 Debugging U-Boot
 ----------------
 
-- 
2.34.1

