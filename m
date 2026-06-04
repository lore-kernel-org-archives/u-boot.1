Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB597CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F018849D1;
	Thu,  4 Jun 2026 14:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BRPnLS3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79228848A1; Thu,  4 Jun 2026 13:26:01 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2720A848F5
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 13:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EAECF43938;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF948C2BCB8;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780572355;
 bh=UG147QJ/1EDViGNnJBafZcRlOikFZQ3ndXo+baJrY4o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=BRPnLS3ss5QXED+QLZ+I3NvlVf4RmG5srtZV6J/uHXA71TJbXu/EcAMzRkrF92Atv
 ON+psd9fZJDkmrsQYgYn+1+i5yt04WScdKGJPruuBaVKdURn5GGtWIPiVs3jZb5J3R
 jPsP0QHMb17Ojgqs06j+Zo83jqRYtlfwZpUhNCFAFNDw3Sxfpx8nTwizidHL02qrfe
 ytqbKDQBJ6U6ymtQuMTsRren+cceCIt828RElKLc2Fo+QpbN6CiHw12mO022lRTZuO
 pfmVgyfCMXdf2qj/hup1W4jgQTBi4DI+QPMptLkdsZj2fufNB0jcsSNrEMKRwBzg6W
 c3wQTOsrCbBvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C82D4CD6E6B;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Thu, 04 Jun 2026 14:25:54 +0300
Subject: [PATCH PATCHSET 6/6] ufs: doc/usage/cmd/ufs.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-ufs_tool-v1-6-741ed00232c0@mobileye.com>
References: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
In-Reply-To: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5344;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=aYK6ZZSX72OkN7quuRhfm9mWdLZJuSfsa5D3xewp+Zk=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqIWDA+8z/Wkg1Ynl6qeA7WekjPR/KOhs7P5F2P
 tu5ckMzbGSJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiFgwAAKCRCfmumUluiO
 OeSqD/0cZuFChlVjhrrWfnsN04JgM4djQctOJomIXCvSmUjmi1ituKCQWRVODi9qerVDmV4q/c6
 c4SOrTzzrvZi3bLxoGeoQ/tJYQZWwbBSffNhLBiUZsHvaDjD77c1VVLZXVtYrN3qaCEwn98rSOo
 8BRuo1zp0a5uLXbqxnOmmZKcmdwmWuvxrOH6ZLWhj2vcE5kDJRlCc+fAV/rKaBbs0el14XdppIJ
 /PRNvPwJckdyuH7AJk4+ZzZHUX3AIY8Im1d6u6C6C+z5XWT8nMfbIf5wnIvWxi0etKDRdlji8kL
 ehyQzzjogDP2AG4F4qg/w/G0lQagIiOL7a/QRDVNA2agWexQ0hdIh4jXUgX331+QqwiH0/yZtm7
 AMi9zdCA6JNFOrtFvGc19eZvJrlw2z3niDQAOJV6v0wsZUd4zGzFWU+dvwpC6y3uPGGBMNqSw0j
 i0/BFwvk9fVGHDAuNuu0JY4nx9qNihJttBjIxCHb16v4V4JEsRO5pjqRf4cyv89Yt5SBF0/JOaZ
 SQR5m9E0bSjfdHAwHJ/HQj/RX0Qwo4IMLuh4EYC/gio/njokCmH5iBBqddBHRTB8j8wl9bWLLYh
 DpSp1rMgosWXLn25Og3AU60Gfo921yGtzlfpmsl6Wx99WXV7S7WiB6wbk+HQMPO+3Fr9keycfoa
 9c5Cse8iwU7FIQQ==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

Documention of the ufs tool.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 doc/usage/cmd/ufs.rst | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/doc/usage/cmd/ufs.rst b/doc/usage/cmd/ufs.rst
new file mode 100644
index 00000000000..a6faf4b1347
--- /dev/null
+++ b/doc/usage/cmd/ufs.rst
@@ -0,0 +1,217 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+ufs Tool
+========
+
+The ``ufs`` tool provides utilities for querying, displaying, and modifying
+UFS device configuration and descriptor information.
+
+Features
+--------
+
+* Query and display Device, Geometry, Unit, Configuration, and Power
+  Descriptors.
+* Display LUN configuration and calculated capacities.
+* Modify LUN, Configuration, and Device Descriptor fields.
+* Configure WriteBooster-related parameters.
+* Query common UFS runtime flags.
+* Commit configuration changes or clear all LUN configurations.
+* Decode and format descriptor contents for easier debugging.
+* Provision UFS devices using exported Configuration Descriptors.
+
+The UFS tool header definitions are based on the JEDEC JESD220E
+*Universal Flash Storage (UFS) Version 3.1* specification.
+
+Usage
+-----
+
+Query descriptors::
+
+    ufs query [lun] [idn]
+
+Descriptor IDs
+~~~~~~~~~~~~~~
+
+::
+
+    0x00  Device Descriptor
+    0x01  Configuration Descriptor
+    0x02  Unit Descriptor
+    0x07  Geometry Descriptor
+    0x08  Power Descriptor
+
+Configure a Logical Unit (LUN)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    ufs set_lun <lun> <parameter> <value>
+
+Supported parameters::
+
+    lu_enable
+    boot_lun_id
+    lu_write_protect
+    memory_type
+    data_reliability
+    num_allocunits
+    logical_block_size
+    provisioning_type
+    context_capabilities
+    lu_num_write_booster_buffer_allocunits
+
+Modify Device Descriptor fields
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    ufs set_dev_desc <parameter> <value>
+
+Supported parameters::
+
+    descriptor_idn
+    device
+    device_class
+    device_sub_class
+    number_lu
+    boot_enable
+    descr_access_en
+    init_power_mode
+    high_priority_lun
+    secure_removal_type
+    initactive_icc_level
+    queue_depth
+    write_booster_buffer_preserve_user_space_en
+    write_booster_buffer_type
+    spec_version
+    manufacturer_id
+    periodic_rtc_update
+    device_version
+    psa_max_data_size
+    extended_ufs_features_support
+    num_shared_write_booster_buffer_allocunits
+
+Modify Configuration Descriptor fields
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    ufs set_cfg_desc <parameter> <value>
+
+Supported parameters::
+
+    length
+    descriptor_idn
+    conf_desc_continue
+    boot_enable
+    descr_access_en
+    initpower_mode
+    high_priority_lun
+    secure_removal_type
+    init_active_icc_level
+    periodic_rtc_update
+    reserved_HPB
+    rpmb_region_enable
+    rpmb_region1_size
+    rpmb_region2_size
+    rpmb_region3_size
+    write_booster_buffer_preserve_user_space_en
+    write_booster_buffer_type
+    num_shared_write_booster_buffer_allocunits
+
+Query UFS flags
+~~~~~~~~~~~~~~~
+
+::
+
+    ufs getflag <flag_name>
+
+Supported flags::
+
+    deviceinit
+    permanent_wpe
+    pwr_on_wpe
+    bkops_en
+    life_span_mode
+    purge_enable
+    fphy_resource_removal
+    busy_rtc
+    permanently_disable_fw_update
+    write_booster_en
+    wb_buf_flush_en
+    wb_buf_flush_h8
+
+Examples
+--------
+
+Create LUN 4::
+
+    ufs query 1 1
+    ufs set_lun 4 num_allocunits <size_in_alloc_units>
+    ufs commit
+    scsi scan
+
+Update WriteBooster configuration::
+
+    ufs query 1 1
+    ufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000
+    ufs set_cfg_desc write_booster_buffer_type 1
+    ufs commit
+
+Clear all LUN configurations::
+
+    ufs clearall
+
+This command clears all configured LUNs and commits the change.
+
+Provisioning
+------------
+
+To simplify UFS provisioning, the tool displays the memory address and
+size of the Configuration Descriptor (IDN 0x01). This allows the
+descriptor to be exported from one system and imported on another.
+
+Provisioning workflow
+~~~~~~~~~~~~~~~~~~~~~
+
+Source system
+^^^^^^^^^^^^^
+
+1. Display the Configuration Descriptor::
+
+       ufs query 1 1
+
+   The output includes the Configuration Descriptor address and size.
+
+2. Save the Configuration Descriptor to a file::
+
+       tftpput <cfg_desc_addr> <size> <filename>
+
+   Example::
+
+       tftpput 0x8ffffc610 0xe6 luns.bin
+
+   This exports the current UFS configuration, including LUN settings.
+
+Target system
+^^^^^^^^^^^^^
+
+1. Display the current Configuration Descriptor::
+
+       ufs query 1 1
+
+2. Load the configuration file into the Configuration Descriptor buffer
+   using XMODEM or TFTP::
+
+       loadx 0x8ffffce00
+
+   or::
+
+       tftpget 0x8ffffce00 luns.bin
+
+3. Commit the configuration to the UFS device::
+
+       ufs commit
+
+   The imported Configuration Descriptor is written to the device and
+   becomes active after the commit operation completes.

-- 
2.43.0


