Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F3606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a8tzYNCu;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0mCLdj10
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71C51407F9;
	Tue, 17 Nov 2026 12:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cXRSLFacMCfw; Tue, 17 Nov 2026 12:27:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78B4C407E6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794918464;
	b=sHg6+9LovwP6USRmdde6DK2yK6y9m/NxkLHFy5Ze81/3PPBVanFr+4eU0OnJruUd9IQB
	 cPjGfKn3JlvZYOt9JjLoDSNpzYD73pOHYdsaUsvh60dzKHpfdpE8i5Zq/wsAqk9m0WDOp
	 biHQh1I3xxhvwnKCI3WzJoRfdKrDuqs8K11lFeCCNoZUV8GADU1MHy6KNPh7OjZkjIQhf
	 HNeTJizzg0Vhwufw3SYDlw9yRzgvFv2p3CBtmXwpjELnY05dq7XbzcPCZXSzPVXvNPJ2M
	 jAb95mRZmsC+DswEj5eeEkeevcZG9APcU/iWopndBWqZqmMMOKoAfJ/4Fve76EZf98w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794918464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7OSu7iPWS0z0R78bPDC336EEC1vU6JDJmkvUdjzVbsM=;
	b=cPU0lePezuOq7pMzj6ap16R9cBZQ32+qiWqpFrZ0/IdwkO95HjhNodceEavGtl+eOOpQ
	 IAEJeTjpJx0b3Nkq2RaHy7J3cFqZRkoXjq0UsEdJ8UF8Jw3WeVS9JyfQiHtm2MMmLKsvG
	 CMLXnRYnpQOERO1qf35Tk+6WLq31PMKtZYirOsVX7wjnUHGLYKYG/8CIgI6JWs4WmoKM4
	 LE8yMYV5B2Xsvn0rXU6jN/zND0QVRp2Coi292q0k18AgXvzKxKcbhj/2+r2xt7QqsLYJp
	 kPQ8SHGbqM7/ZyyZEGqTPJF6rrwGFJs/vJoOCwSZyKO8Lw4BsNOgGjLvNnMz70O5OdQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794918464;
	bh=7OSu7iPWS0z0R78bPDC336EEC1vU6JDJmkvUdjzVbsM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a8tzYNCuv/+T61hwZDh/En/dkR0D+sfwoP/+h3vlWosGMKxRLM4eaxVtgz/0u6U6q
	 JUO3tHa5EV8jxu6bgTH5ABK/Y3K4hhB1ipLAUh56mfjmCDwUyPogyv6XFHRmTAB/ya
	 UzFBkks3DLQZxFnmPlNhN1OGUgC3MRh7nlh6qBQvKnmGQ8GFrqRImnosXXlCgoJKp6
	 luBEnUMNp53EbU0sYaSuIkV5iDVfEhEsO2aatNwlJHZYXX7ASTIzKikKyO2hES4Qg6
	 q9X9fGaALrWx1EOPIhIZsJ1YaNx1WBgJcqy1I8NrSFnA6yNLg3a3lBPnhhaF36Lrw2
	 /QmlmB8SwnKjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78B4C407E6;
	Tue, 17 Nov 2026 12:27:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CCBD105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83CE740308
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ge2EcNhnRhXg for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:27:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 757AE4008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=0mCLdj10
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 757AE4008B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:39 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so3369984f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 04:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794918458; x=1795523258;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7OSu7iPWS0z0R78bPDC336EEC1vU6JDJmkvUdjzVbsM=;
 b=0mCLdj10rrsdxX4B5usd4Iww/pu8obR2bCjE/J/TWTHr2yHsWuFrhfDhw1k2fWapJF
 PMtzkOMPUId4RfytjBVmhMxZEK5NrcDI+YS1f/rb+PGhuJhUpIxdb2Zxqj953up15HPh
 kGkdYKQh0Et1jtHu8/3bQ5SIv7EoN79ouoo9xWkqChm3baelDbRaUFYc6iqsRssW7N1M
 Zpfp/vGaFLgcWlSWxTbOP+JzGhXolKV8eafsHox2EzfGwJwbNhnoiNy0BPW+Z8WS2RGi
 wAKhXLu6O378EgkY4nVbygQFA3ZlzyFQxmhFqdnD/K70rKU5YwnkQAxALpLEYzL1mdc6
 2o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918458; x=1795523258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7OSu7iPWS0z0R78bPDC336EEC1vU6JDJmkvUdjzVbsM=;
 b=kynPbYXgoC283/MVo2DtlWVbUHx8DvrSNjv3T5qRGhBvziLrW4Dzr47MtGhUlTsCIi
 HZtEYVil8imxqmTNs37qFXrrioJ4nUk7I6+gnS7DgESb3kmqEQFcbmkTcYCCtkLs4/XR
 15ISRIvBbxUsO1FdfXuiG8G/ZnYqC8beH4RM526KhnqEA/e3k0r8QyfGnqsV27vjg/M5
 7H231kTeEUazR975HP8f60xY4p12KIBSFi1de7yHzluT/KdsqPrSTS8AVVkpAgRJ4xNK
 8xuSE1cZiyv+O0109/G1Yh+jk1YCj7J5+DX7NXAqJAaR9amACfuKQUv6JiqCpuIymnh+
 i64g==
X-Forwarded-Encrypted: i=1;
 AL+hErFTzjlzb69uCaHPlqPy/8CXvRO/LIgUUnaR3hUhA7bnt/hIo5uU3L9E7BhW5FNHLYQbqN5s5WE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8wDyNdCcRJ7EuiRHVZsohTwJRaIHCncjnT0azHEEfaMio+qmaa
 wldCD/vlaPisVduOjs6LF2uKfjLfDstxEyYXFSG1XMaoyjBssG7M+iEq
X-Gm-Gg: AZFdTZeXT40FuRrlGmm4NEbB7bbPv+myDVOd0utREhk+9ELhgxJilEN+G0SKkWzuyMg
 kkLr5OLyLftGwhhV9+Q6mUgEFr1XZLGJVeyDz+zpQl1HzcMhTf6LrarvgAewiGtn8lzSluXqGTp
 7/j+0N9cLcFBf7NK9m+1E/uIrMIo4peA/qbxFEZpT1yQPeaG68svZsId+HX/nibYgsPObAp70Hy
 xV30YpBoX8YSZeKaRCCTiWJSnQ/Q0jTbZEZHGilhfeiuzfb91ydo58dJWUZPyy53IWkXhMHe/p2
 +PbLIsZOAf2d69wpT8R76he6CAjyLGkt3e9NoLqK7JYxVxT01kdgVxzxwFP75qaEsHrB48jP5sm
 +mNiq5H2EB5OarVCdmswrTHgUrPy0ZppMksyWpo2kyUa5pBK54qLDMFM/RFHN1I54lHZBOvzvBi
 MmdGQAwi2LMoUIr9/wv822kRnJxF/MAFGO+LzpfDFvnHn7jtI5GILg4ekvtqLYZNw5ja766E5qR
 YLN00BcqSNER55NNTmpQQnUUNg1WgELCQhhv57eVynLjtAyZvsb/qU7wGGfYjT7a8w0z6hnQo6y
 b6Z5JZR0x2Wqlcyjd3H9MAbcYqdbmgWsUGD0ke+6b3jZIM+CL1cwthW19FV/d0B2Mvniyltnz45
 it4O+P46r9iM+TVbafNkOHv56MepBLEOGM3E=
X-Received: by 2002:a05:6000:25ee:b0:490:b23b:802d with SMTP id
 ffacd0b85a97d-49c71d475ddmr25740192f8f.37.1794918457955; 
 Tue, 17 Nov 2026 04:27:37 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-92-103.ip49.fastwebnet.it.
 [93.34.92.103]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a33c344a58sm5243151f8f.34.2026.11.17.04.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:27:37 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>,
 Vincent Jardin <vjardin@free.fr>, Martin Schwan <m.schwan@phytec.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v12 8/9] doc: develop/driver-model: firmware_loader: document
 new FS and FIP API
Date: Tue, 17 Nov 2026 13:27:13 +0100
Message-ID: <20261117122715.7983-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117122715.7983-1-ansuelsmth@gmail.com>
References: <20261117122715.7983-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the firmware loader documentation with the new
get_fw_loader_from_node() and request_firmware_size() API and the new FIP
config.

Provide additional example and description of the new suggested order of
operation on dynamic buffer allocation with request_firmware_size() and how
to reach a firmware loader device.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 doc/develop/driver-model/firmware_loader.rst | 95 ++++++++++++++++++--
 1 file changed, 86 insertions(+), 9 deletions(-)

diff --git a/doc/develop/driver-model/firmware_loader.rst b/doc/develop/driver-model/firmware_loader.rst
index 2d11a74d5e2f..d4e8063e9d72 100644
--- a/doc/develop/driver-model/firmware_loader.rst
+++ b/doc/develop/driver-model/firmware_loader.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
 
-File System Firmware Loader
+Firmware Loader
 ===========================
 
 This is firmware loader for U-Boot framework, which has very close
@@ -13,9 +13,17 @@ and binary) from the storage device in file system format into target location
 such as memory, then consumer driver such as FPGA driver can program FPGA image
 from the target location into FPGA.
 
-To enable firmware loader, CONFIG_FS_LOADER need to be set at
+FIP firmware loader can be used to load a firmware from a specific FIP entry
+referenced by the specific UUID into target location such as memory, then
+consumer driver such as PHY driver can load such firmware to make the PHY
+operational.
+
+To enable file system firmware loader, CONFIG_FS_LOADER need to be set at
 <board_name>_defconfig such as "CONFIG_FS_LOADER=y".
 
+To enable FIP firmware loader, CONFIG_FIP_LOADER need to be set at
+<board_name>_defconfig such as "CONFIG_FIP_LOADER=y".
+
 Firmware Loader API core features
 ---------------------------------
 
@@ -23,11 +31,11 @@ Firmware storage device described in device tree source
 -------------------------------------------------------
 For passing data like storage device phandle and partition where the
 firmware loading from to the firmware loader driver, those data could be
-defined in fs-loader node as shown in below:
+defined in fw-loader node as shown in below:
 
 Example for block device::
 
-	fs_loader0: fs-loader {
+	fw_loader0: fs-loader {
 		bootph-all;
 		compatible = "u-boot,fs-loader";
 		phandlepart = <&mmc 1>;
@@ -40,20 +48,31 @@ device, it can be described in FDT as shown in below:
 
 Example for ubi::
 
-	fs_loader1: fs-loader {
+	fw_loader1: fs-loader {
 		bootph-all;
 		compatible = "u-boot,fs-loader";
 		mtdpart = "UBI",
 		ubivol = "ubi0";
 	};
 
+(FIP loader follow the same exact implementation by just using the
+dedicated compatible "u-boo,fip-loader")
+
 Then, firmware-loader property can be added with any device node, which
 driver would use the firmware loader for loading.
 
 The value of the firmware-loader property should be set with phandle
-of the fs-loader node. For example::
+of the fw-loader node. For example::
 
-	firmware-loader = <&fs_loader0>;
+	firmware-loader = <&fw_loader0>;
+
+And firmware loader device can be reached by the use get_fw_loader_from_node API:
+
+For example:
+
+.. code-block:: c
+
+	get_fw_loader_from_node(dev_ofnode(dev), &fw_loader);
 
 If there are majority of devices using the same fs-loader node, then
 firmware-loader property can be added under /chosen node instead of
@@ -63,7 +82,7 @@ For example::
 
 	/{
 		chosen {
-			firmware-loader = <&fs_loader0>;
+			firmware-loader = <&fw_loader0>;
 		};
 	};
 
@@ -117,6 +136,44 @@ compilation is required for both driver and FDT.
 File system firmware Loader API
 -------------------------------
 
+.. code-block:: c
+
+	int get_fw_loader_from_node(ofnode node, struct udevice **dev);
+
+Get firmware loader from referenced node
+
+Parameters:
+
+* ofnode \*node: node where the "firmware-loader" phandle needs to be parsed
+* struct udevice \**dev:  pointer where to store the firmware loader device
+
+Returns:
+	0 on success
+	-ve when error
+
+Description:
+	Parse the "firmware-loader" phandle from the passed node and
+	probe and put the matching firmware loader device in the dev pointer.
+
+.. code-block:: c
+
+	int request_firmware_size(struct udevice *dev, const char *name)
+
+Get firmware size from Firmware Loader driver
+
+Parameters:
+
+* struct udevice \*dev: An instance of a driver
+* const char \*name: name of firmware file
+
+Returns:
+	size of firmware
+	-ve when error
+
+Description:
+	Get the firmware size before reading it to validate how much buffer
+	is needed for it
+
 .. code-block:: c
 
 	int request_firmware_into_buf(struct udevice *dev,
@@ -151,4 +208,24 @@ instance:
 		return ret;
 
 	request_firmware_into_buf(dev, filename, buffer_location, buffer_size,
-				 offset_ofreading);
+				  offset_ofreading);
+
+Example of request_firmware_into_buf API from a "firmware-loader" defined in
+the device node and dynamic buffer allocation:
+
+.. code-block:: c
+
+	ret = get_fw_loader_from_node(dev_ofnode(dev), &fw_loader);
+	if (ret)
+		return ret;
+
+	buffer_size = request_firmware_size(fw_loader, filename);
+	if (buffer_size <= 0)
+		return buffer_size < 0 ? buffer_size : -EINVAL;
+
+	buffer_location = calloc(buffer_size, sizeof(*buffer_location));
+	if (!buffer_location)
+		return -ENOMEM;
+
+	request_firmware_into_buf(fw_loader, filename, buffer_location, buffer_size,
+				  offset_ofreading);
-- 
2.55.0

