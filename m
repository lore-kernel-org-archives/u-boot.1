Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C394C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 10:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C5C787811;
	Fri, 22 Dec 2023 11:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X0XdHBx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 850568783A; Fri, 22 Dec 2023 11:27:08 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D2E876FC
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 11:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BMAQolJ070074;
 Fri, 22 Dec 2023 04:26:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703240810;
 bh=XdDWne4Fo5SX8+gQKIBo/t1XS/7NfMA1m/peANGgWYk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=X0XdHBx3Q5s0ZznBXWOQVcpA8b/xxHd+o7YY6pyNIFf1BwU1Q74TqUYWhpQrE+r7I
 TkIP6s/9OWm5pJgNFWnty3mUWw3cLH1E2fbeceaGGemzQZFlUU/5AfOEj3g9Qp7uNO
 8vCbD72bp55BtKwLMs2hwcvxZBCH+ctKD6ErgRwM=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BMAQofT121740
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Dec 2023 04:26:50 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Dec 2023 04:26:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Dec 2023 04:26:50 -0600
Received: from [10.24.69.31] (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BMAQiv4084936;
 Fri, 22 Dec 2023 04:26:45 -0600
Message-ID: <4ccd7db1-533a-4243-9087-7e7c2e85b917@ti.com>
Date: Fri, 22 Dec 2023 15:56:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] Introduce ICSSG Ethernet driver
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
 <6d9456ec-a483-4721-8713-626aacdc9f81@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <6d9456ec-a483-4721-8713-626aacdc9f81@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Roger,

On 20/12/23 3:29 pm, Roger Quadros wrote:
> Hi,
> 
> On 19/12/2023 12:11, MD Danish Anwar wrote:
>> Introduce ICSSG PRUETH support in uboot. The ICSSG driver is used in TI
>> AM654 SR2.0.
>>
>> The ICSSG PRU Sub-system runs on EMAC firmware. This series Introduces
>> support for ICSSG driver in uboot. This series also adds the driver's
>> dependencies.
>>
>> The ICSSG2 node is added in device tree overlay so that it remains in
>> sync with linux kernel.
>>
>> The series introduces device tree and config changes and AM65x
>> to enable ICSSG driver. The series also enables SPL_LOAD_FIT_APPLY_OVERLAY
>> for AM65x in order to load overlay over spl.
>>
>> This series has been tested on AM65x SR2.0, and the ICSSG interface is
>> able to ping / dhcp and boot kernel using tftp in uboot.
>>
>> To use ICSSG2 ethernet, the ICSSG firmware needs to be loaded to PRU RPROC
>> cores and RPROC cores need to be booted with the firmware. This step is
>> done inside driver in kernel as kernel supports APIs like
>> rproc_set_firmware() and rproc_fw_boot(). But as u-boot doesn't have these
>> APIs, the same needs to be done via u-boot cmds.
>>
>> To make sure icssg-eth works we need to do below steps.
>>
>> 1. Initialize rproc cores i.e. rproc_init()
>> 2. Load $firmware_file from partition '1:2' (root) on device (mmc in this
>>    example)
>> 3. Load the firmware file to rproc cores passing. i.e. rproc_load()
>>    taking rproc_id, loadaddr and file size as arguments.
>> 4. Start rproc cores. i.e. rproc_start() taking rproc_id as arguments
>>
>> The above steps are done by running the below commands at u-boot prompt.
>>
>> => setenv start_icssg2 'rproc start 14; rproc start 15; rproc start 16; rproc start 17; rproc start 18; rproc start 19'
>> => setenv stop_icssg2 'rproc stop 14; rproc stop 15; rproc stop 16; rproc stop 17; rproc stop 18; rproc stop 19'
>> => setenv firmware_dir '/lib/firmware/ti-pruss'
>> => setenv get_firmware_mmc 'load mmc ${bootpart} ${loadaddr} ${firmware_dir}/${firmware_file}'
>>
>> => setenv init_icssg2 'setenv ethact icssg2-eth; setenv autoload no; rproc init; setenv loadaddr 0x80000000; \
>>     setenv firmware_file am65x-sr2-pru0-prueth-fw.elf; run get_firmware_mmc;  rproc load 14 0x80000000 ${filesize}; \
>>     setenv loadaddr 0x89000000; setenv firmware_file am65x-sr2-rtu0-prueth-fw.elf; run get_firmware_mmc; rproc load 15 0x89000000 ${filesize}; \
>>     setenv loadaddr 0x90000000; setenv firmware_file am65x-sr2-txpru0-prueth-fw.elf; run get_firmware_mmc; rproc load 16 0x90000000 ${filesize}; \
>>     setenv loadaddr 0x80000000; setenv firmware_file am65x-sr2-pru1-prueth-fw.elf; run get_firmware_mmc; rproc load 17 0x80000000 ${filesize}; \
>>     setenv loadaddr 0x89000000; setenv firmware_file am65x-sr2-rtu1-prueth-fw.elf; run get_firmware_mmc; rproc load 18 0x89000000 ${filesize}; \
>>     setenv loadaddr 0x90000000; setenv firmware_file am65x-sr2-txpru1-prueth-fw.elf; run get_firmware_mmc; rproc load 19 0x90000000 ${filesize}; \
>>     run start_icssg2;'
> 
> A whole bunch of commands are required to get ethernet functional.
> This is not at all user friendly and will be a maintenance nightmare.
> What worries me is tracking the 6 different rproc cores and the 6 different firmware files to start 1 ethernet device.
> This will get even more interesting when we have to deal with different ICSSG instances on different boards.
> 
> What is preventing the driver from starting the rproc cores it needs so user doesn't need to care about it?
> All the necessary information is in the Device tree. At least this is how it is done on Linux.
> 

I tried removing the need for these commands and implementing them
inside the driver only. I am able to load the firmware from driver using
the fs_loader API request_firmware_into_buf(). It requires changes to
dt. A DT node called fs-loader needs to be added also CONFIG_FS_LOADER
needs to enabled. In the DT node we need to specify the storage media
that we are using i.e. mmc, ospi, usb. It's upto user to modify the
storage media, the driver will take the media from DT and try to laod
firmware from their.

For loading firmwares to rproc cores, rproc_load() API is needed. Now
this API takes rproc_id, loadaddr and firmware_size as arguments.
loadaddr is fixed for all three pru cores. firmware_size is obtained
from request_firmware_into_buf() but I couldn't find a way to get the
rproc_id. For now based on the ICSSG instance and slice number I am
figuring out the rproc_id and passing it to rproc_load() and
rproc_start() APIs. Please let me know if you have any other / better
way of finding rproc_id.

Below is the entire diff to remove these commands and move their
functionality to driver. Please have a look and let me know if this is ok.


Save New Duplicate & Edit Just Text Twitter
diff --git a/arch/arm/dts/k3-am654-base-board.dts
b/arch/arm/dts/k3-am654-base-board.dts
index cfbcebfa37..c8da72e49c 100644
--- a/arch/arm/dts/k3-am654-base-board.dts
+++ b/arch/arm/dts/k3-am654-base-board.dts
@@ -16,6 +16,13 @@
 	chosen {
 		stdout-path = "serial2:115200n8";
 		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
+		firmware-loader = <&fs_loader0>;
+	};
+
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		phandlepart = <&sdhci1 2>;
 	};

 	memory@80000000 {
diff --git a/configs/am65x_evm_a53_defconfig
b/configs/am65x_evm_a53_defconfig
index 2755d7082f..c53e938abb 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -112,6 +112,7 @@ CONFIG_DM_I2C_GPIO=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
+CONFIG_FS_LOADER=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index b2f1e721b3..2d19935a41 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -98,6 +98,7 @@ CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
+CONFIG_FS_LOADER=y
 CONFIG_K3_AVS0=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_HS200_SUPPORT=y
diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
index 40ad827e49..1c4edeb7b7 100644
--- a/drivers/net/ti/icssg_prueth.c
+++ b/drivers/net/ti/icssg_prueth.c
@@ -227,6 +227,10 @@ static int prueth_start(struct udevice *dev)
 	void *config;
 	int ret, i;

+	ret = icssg_start_pru_cores(dev);
+	if (ret)
+		return ret;
+
 	/* To differentiate channels for SLICE0 vs SLICE1 */
 	snprintf(chn_name, sizeof(chn_name), "tx%d-0", priv->slice);

@@ -355,9 +359,11 @@ static void prueth_stop(struct udevice *dev)
 	phy_shutdown(priv->phydev);

 	dma_disable(&priv->dma_tx);
-	dma_free(&priv->dma_tx);
-
 	dma_disable(&priv->dma_rx);
+
+	icssg_stop_pru_cores(dev);
+
+	dma_free(&priv->dma_tx);
 	dma_free(&priv->dma_rx);
 }

@@ -434,6 +440,181 @@ static const struct soc_attr k3_mdio_soc_data[] = {
 	{ /* sentinel */ },
 };

+struct icssg_firmware_load_address {
+	u32 pru;
+	u32 rtu;
+	u32 txpru;
+};
+
+struct icssg_firmwares {
+	char *pru;
+	char *rtu;
+	char *txpru;
+};
+
+static struct icssg_firmwares icssg_emac_firmwares[] = {
+	{
+		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+	},
+	{
+		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru1-prueth-fw.elf",
+	}
+};
+
+int load_firmware(char *name_fw, u32 *loadaddr)
+{
+	struct udevice *fsdev;
+	int size = 0;
+
+	if (!IS_ENABLED(CONFIG_FS_LOADER))
+		return -EINVAL;
+
+	if (!*loadaddr)
+		return -EINVAL;
+
+	if (!get_fs_loader(&fsdev))
+		size = request_firmware_into_buf(fsdev, name_fw, (void *)*loadaddr,
40524, 0);
+
+	return size;
+}
+
+static int icssg_get_instance(struct udevice *dev)
+{
+	if (!strcmp(dev->name, "icssg2-eth"))
+		return 2;
+	else if (!strcmp(dev->name, "icssg1-eth"))
+		return 1;
+	else if (!strcmp(dev->name, "icssg0-eth"))
+		return 0;
+
+	dev_err(dev, "Invalid icssg instance\n");
+	return -EINVAL;
+}
+
+static int icssg_get_pru_core_number(struct udevice *dev, int slice)
+{
+	int instance, num_r5_cores;
+
+	instance = icssg_get_instance(dev);
+	if (instance < 0)
+		return instance;
+
+	if (IS_ENABLED(CONFIG_REMOTEPROC_TI_K3_R5F))
+		num_r5_cores = 2;
+
+	return num_r5_cores +
+	       instance * PRU_TYPE_MAX * PRUETH_NUM_MACS +
+	       slice * PRU_TYPE_MAX;
+}
+
+int icssg_start_pru_cores(struct udevice *dev)
+{
+	struct prueth *prueth = dev_get_priv(dev);
+	struct icssg_firmwares *firmwares;
+	u32 pru_fw_loadaddr = 0x80000000;
+	u32 rtu_fw_loadaddr = 0x89000000;
+	u32 txpru_fw_loadaddr = 0x90000000;
+	int slice, ret, core_id;
+
+	firmwares = icssg_emac_firmwares;
+	slice = prueth->slice;
+
+	core_id = icssg_get_pru_core_number(dev, slice);
+	if (core_id < 0)
+		return core_id;
+
+	/* Initialize all rproc cores */
+	rproc_init();
+
+	/* Loading PRU firmware to PRU core */
+	ret = load_firmware(firmwares[slice].pru, &pru_fw_loadaddr);
+
+	if (ret < 0) {
+		dev_err(dev, "Unable to load_firmware %s at addr 0x%x err %d\n",
+			firmwares[slice].pru, pru_fw_loadaddr, ret);
+		return ret;
+	}
+
+	dev_info(dev, "Loaded FW %s successfully at addr 0x%x Size = %d Bytes\n",
+		firmwares[slice].pru, pru_fw_loadaddr, ret);
+	rproc_load(core_id + PRU_TYPE_PRU, pru_fw_loadaddr, ret);
+
+	/* Loading RTU firmware to RTU core */
+	ret = load_firmware(firmwares[slice].rtu, &rtu_fw_loadaddr);
+
+	if (ret < 0) {
+		dev_err(dev, "Unable to load_firmware %s at addr 0x%x err %d\n",
+			firmwares[slice].rtu, rtu_fw_loadaddr, ret);
+		return ret;
+	}
+
+	dev_info(dev, "Loaded FW %s successfully at addr 0x%x Size = %d Bytes\n",
+		firmwares[slice].rtu, rtu_fw_loadaddr, ret);
+	rproc_load(core_id + PRU_TYPE_RTU, rtu_fw_loadaddr, ret);
+
+	/* Loading TX_PRU firmware to TX_PRU core */
+	ret = load_firmware(firmwares[slice].txpru, &txpru_fw_loadaddr);
+
+	if (ret < 0) {
+		dev_err(dev, "Unable to load_firmware %s at addr 0x%x err %d\n",
+			firmwares[slice].txpru, txpru_fw_loadaddr, ret);
+		return ret;
+	}
+
+	dev_info(dev, "Loaded FW %s successfully at addr 0x%x Size = %d Bytes\n",
+		firmwares[slice].txpru, txpru_fw_loadaddr, ret);
+	rproc_load(core_id + PRU_TYPE_TX_PRU, txpru_fw_loadaddr, ret);
+
+	ret = rproc_start(core_id + PRU_TYPE_PRU);
+	if (ret) {
+		dev_err(dev, "failed to start PRU%d: %d\n", slice, ret);
+		return ret;
+	}
+
+	ret = rproc_start(core_id + PRU_TYPE_RTU);
+	if (ret) {
+		dev_err(dev, "failed to start RTU%d: %d\n", slice, ret);
+		goto halt_pru;
+	}
+
+	ret = rproc_start(core_id + PRU_TYPE_TX_PRU);
+	if (ret) {
+		dev_err(dev, "failed to start TX_PRU%d: %d\n", slice, ret);
+		goto halt_rtu;
+	}
+
+	return 0;
+
+halt_rtu:
+	rproc_stop(core_id + PRU_TYPE_RTU);
+
+halt_pru:
+	rproc_stop(PRU_TYPE_PRU);
+	return ret;
+}
+
+int icssg_stop_pru_cores(struct udevice *dev)
+{
+	struct prueth *prueth = dev_get_priv(dev);
+	int slice, core_id;
+
+	slice = prueth->slice;
+
+	core_id = icssg_get_pru_core_number(dev, slice);
+	if (core_id < 0)
+		return core_id;
+
+	rproc_stop(core_id + PRU_TYPE_PRU);
+	rproc_stop(core_id + PRU_TYPE_RTU);
+	rproc_stop(core_id + PRU_TYPE_TX_PRU);
+
+	return 0;
+}
+
 static int prueth_probe(struct udevice *dev)
 {
 	ofnode eth_ports_node, eth0_node, eth1_node, eth_node;
diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
index 25272e850e..f17fe8bf58 100644
--- a/include/linux/pruss_driver.h
+++ b/include/linux/pruss_driver.h
@@ -114,6 +114,21 @@ enum pru_ctable_idx {
 	PRU_C31,
 };

+/**
+ * enum pru_type - PRU core type identifier
+ *
+ * @PRU_TYPE_PRU: Programmable Real-time Unit
+ * @PRU_TYPE_RTU: Auxiliary Programmable Real-Time Unit
+ * @PRU_TYPE_TX_PRU: Transmit Programmable Real-Time Unit
+ * @PRU_TYPE_MAX: just keep this one at the end
+ */
+enum pru_type {
+	PRU_TYPE_PRU,
+	PRU_TYPE_RTU,
+	PRU_TYPE_TX_PRU,
+	PRU_TYPE_MAX,
+};
+
 /**
  * enum pruss_mem - PRUSS memory range identifiers
  */

with this diff, user don't need to run any extra commands at u-boot.
Once u-boot prompt is reached, just running ping / dhcp will suffice.

>>
>> => run init_icssg2
>> => dhcp
>> k3-navss-ringacc ringacc@3c000000: Ring Accelerator probed rings:818, gp-rings[304,100] sci-dev-id:187
>> k3-navss-ringacc ringacc@3c000000: dma-ring-reset-quirk: disabled
>> prueth icssg2-eth: K3 ICSSG: rflow_id_base: 8, chn_name = rx0
>> link up on port 0, speed 1000, full duplex
>> BOOTP broadcast 1
>> BOOTP broadcast 2
>> BOOTP broadcast 3
>> DHCP client bound to address 192.168.4.58 (1020 ms)
>>
> 
> What about shutting down the interface?
> I believe this has to be done manually too?
> 

Yes that is also needed.

>> Thanks and Regards,
>> MD Danish Anwar
>>
>> MD Danish Anwar (16):
>>   net: ti: icssg: Add Firmware Interface for ICSSG Ethernet driver.
>>   net: ti: icssg: Add Firmware config and classification APIs.
>>   net: ti: icssg: Add icssg queues APIs and macros
>>   net: ti: icssg: Add ICSSG ethernet driver
>>   net: ti: icssg: Add support sending FDB command to update rx_flow_id
>>   net: ti: icssg: Enforce pinctrl state on the MDIO child node
>>   arm: dts: k3-am65: Add additional regs for DMA components
>>   arm: dts: k3-am65: Add cfg reg region to ringacc node
>>   arm: dts: k3-am65-main: Add ICSSG IEP nodes
>>   arm: dts: k3-am654-base-board: Add ICSSG2 Ethernet support
>>   arm: dts: k3-am65x-binman: Add ICSSG2 overlay and configuration
>>   configs: am65x_evm_a53: Enable ICSSG Driver
>>   configs: am65x_evm_a53_defconfig: add SPL_LOAD_FIT_APPLY_OVERLAY
>>   tools/fdtgrep: Include __symbols__ table
>>   board: ti: am65x: Add check for k3-am654-icssg2 in
>>     board_fit_config_match()
>>   Revert "dm: core: Report bootph-pre-ram/sram node as pre-reloc after
>>     relocation"
>>
>>  arch/arm/dts/Makefile             |   3 +-
>>  arch/arm/dts/k3-am65-main.dtsi    |  49 ++-
>>  arch/arm/dts/k3-am65-mcu.dtsi     |  13 +-
>>  arch/arm/dts/k3-am654-icssg2.dtso | 145 +++++++
>>  arch/arm/dts/k3-am65x-binman.dtsi |  85 ++++
>>  board/ti/am65x/evm.c              |  11 +-
>>  configs/am65x_evm_a53_defconfig   |   4 +
>>  drivers/core/ofnode.c             |   2 +-
>>  drivers/net/ti/Kconfig            |   9 +
>>  drivers/net/ti/Makefile           |   1 +
>>  drivers/net/ti/icss_mii_rt.h      | 192 +++++++++
>>  drivers/net/ti/icssg_classifier.c | 376 +++++++++++++++++
>>  drivers/net/ti/icssg_config.c     | 469 +++++++++++++++++++++
>>  drivers/net/ti/icssg_config.h     | 195 +++++++++
>>  drivers/net/ti/icssg_prueth.c     | 654 ++++++++++++++++++++++++++++++
>>  drivers/net/ti/icssg_prueth.h     |  89 ++++
>>  drivers/net/ti/icssg_queues.c     |  51 +++
>>  drivers/net/ti/icssg_switch_map.h | 209 ++++++++++
>>  include/dm/ofnode.h               |   8 +-
>>  tools/fdtgrep.c                   |   8 +
>>  20 files changed, 2555 insertions(+), 18 deletions(-)
>>  create mode 100644 arch/arm/dts/k3-am654-icssg2.dtso
>>  create mode 100644 drivers/net/ti/icss_mii_rt.h
>>  create mode 100644 drivers/net/ti/icssg_classifier.c
>>  create mode 100644 drivers/net/ti/icssg_config.c
>>  create mode 100644 drivers/net/ti/icssg_config.h
>>  create mode 100644 drivers/net/ti/icssg_prueth.c
>>  create mode 100644 drivers/net/ti/icssg_prueth.h
>>  create mode 100644 drivers/net/ti/icssg_queues.c
>>  create mode 100644 drivers/net/ti/icssg_switch_map.h
>>
>> base:commit: a6f86132e30a407c7f96461df53c62fbe52e2b54
> 

-- 
Thanks and Regards,
Danish
