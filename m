Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A83DCD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C22846A3;
	Sun,  7 Jun 2026 21:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PF05PIez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E48E84099; Sun,  7 Jun 2026 17:46:09 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0049683314
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DBF8600AE;
 Sun,  7 Jun 2026 15:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 227A5C2BCC7;
 Sun,  7 Jun 2026 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780847165;
 bh=txoiKjKHY5n9xoLeSUzCvso5z9aTZyzI+Ue/GnowSvg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=PF05PIezYrkRpO7R6YuG1kDbtDo+r0YfchPp+YZIp3afiwBM6uS5TVuhi1Qnx07Sr
 iblVh0CpIom52nA0zL0l+DVn3OrvGUxBKF4KO6KRxbvw1w9nKWhAJ9+TPFJwtXqP3o
 cL+sVmMAiZX4WiuoI8J+mFlG00eRHkiHkf2+TImkibz508Jd5pSym+lGyaAM9OV+1H
 paOZCQs+WxFTCHntBqTTu46PbZqP9+N2Er3M51qKu/TC36zxfSQ0XnVlqmGdUejgKJ
 0MHTXfGzLMoDac5KYEzeC48HGuNlxx3J5UNLUNRD0DZe69+bvUE3IFYlpgHfJv3gM6
 Iwpee2zNP9wDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1A33FCD8C8C;
 Sun,  7 Jun 2026 15:46:05 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Sun, 07 Jun 2026 18:45:34 +0300
Subject: [PATCH v2 4/5] ufs: document the UFS command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-ufs_tool2-v2-4-f79ff26ab18c@mobileye.com>
References: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
In-Reply-To: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Julien Stephan <jstephan@baylibre.com>, 
 Udit Kumar <u-kumar1@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 briansune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5620;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=UqfUn4vtl9eznAqacasc9WxEIng/kmK1nog/UheviOw=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqJZI6RFUe+gFZxMT6550TVhjUorw9LgipNV/8H
 JNou3m3RLmJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiWSOgAKCRCfmumUluiO
 OVuTEAC+ALFbkN6a7dbT4nTletyrclbc7q1YeenaCI4uaQUwcbge8O1RnvdyYCvr7dj4G8E09v2
 DMUZqbGqX79Z7abjwszMhb3vUggNJQ6j6/LyXiH+mEURe6QnzZBJZJcrlEq5R/O2b3tiWeBbdUD
 EgsgqbsB9b/TnB6SyLOXJKLMazJzTdfV1ELWGWlfHy+huhNX/zlR29DaMPI1kxD8SBkx//mJ/+g
 k7NyvmvZ1os4oBkuoa1Edv6DLvzUkdMb4rcSvXSRcQ19ABzRTEIjl0W1aAQ0dbq2vZ3+dOUO+sM
 UTlbdbpW+t18D3DG6AOzuw7P6sjQ7vJvwTtsxzOiG/PZMarrU8qnWHKN/tnev8iRUZ9TqPhUCQ5
 /ewZCjdNSZrP7wperPl05SLXXQTI09zWY9k9G5XJWw9J/3Xmf9T/lhwYDA0KGCOr9cYzS3TbXLF
 8AG5xb/lBLZn1IPMwpeiyFgy8XhHHn/jABqrsHlZcc2jDH6MI2LxMxAzYzsH1H+PmmM+6RYsnMF
 sT5zfSkWKbWhSkQOtSUNS6Q/rpQymewZ75tuMGzqwUzHOU63dDT1rGpqFBiILtz4T4UZwFmQi94
 3jg7tjLJGxTvDtVFqLLuTTbQJHAAM0vDvTweP7wn2bDS7tP0AxdjNaCfP1AgHLPT4tLpIeZE6fx
 TJR1PWI+XXNjbOw==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:17 +0200
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

Add documentation for the UFS command-line interface.

The document describes the available UFS subcommands and their usage,
and provides a complete command-line reference for configuring and
managing UFS devices.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 doc/usage/cmd/ufs.rst | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/doc/usage/cmd/ufs.rst b/doc/usage/cmd/ufs.rst
new file mode 100644
index 00000000000..1553bc28935
--- /dev/null
+++ b/doc/usage/cmd/ufs.rst
@@ -0,0 +1,226 @@
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
+    ufs set_lun 4 num_allocunits 100
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
+Set HBA ID
+~~~~~~~~~~~~~~~
+
+::
+
+    ufs sethba <hbaid>
+
+Use an hba id differs from 0.
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


