Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5210ACCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 21:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB838389A;
	Sun,  2 Nov 2025 22:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="L36ow6TG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lNz6YzNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7284838AE; Sun,  2 Nov 2025 22:46:21 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB51283642
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 22:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d07Zg3JlTz9t9l;
 Sun,  2 Nov 2025 22:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762119979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pYNBxBzftgmyeyVGX8U3hJB3HmUBNYSzbhvap8eWBAc=;
 b=L36ow6TGdO7T5i7zf4y2oYx0eD9HNOxmtlI33qx3Oub2TUmlq8yGbf8k9rc0QBVv23Il3r
 LNVPwxQSdUOcqhuawZPBlpOjEDgXmhPMsVFvcVlj/ffotC4FK62G049TSV5ELMyC9UfMcN
 KHYlYQZxoLWNkrC6GbLdutsmnxeeDYhSyPU6VwXI5xNF5D5yeL4lZSK6uF/MSVoZA8puBI
 Pl4NWVhspZcx13tBFVAtgZqo8v8Nu7zUKRw9Xb+DA24UdoPbZ2uyID1SlgdFy2FMr1PVQA
 spmkIBMLThTTC7C8WdY8VV1mKiGsXbKhBSSHmua1zrF8uVLBJKXe/kB6BX3o4A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lNz6YzNP;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762119977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pYNBxBzftgmyeyVGX8U3hJB3HmUBNYSzbhvap8eWBAc=;
 b=lNz6YzNP6GvArQGybcMfz0fhEI8ltBgm7dDWNwlBMEAF6gIlc4l8qEmDSGxPFUTiK1/71p
 cudo9k3S7OFgGMGPdIiaOVx/L2xS/8G6apens6DC/yINWLR02UVmYiOPGbh5CvTPzj/oYX
 7Je11AqZhQQkp/zOV5up9ZmwJAGewntlFnlwFId/IWTtTzz0gdyFkAo/phbxU5IO+gb46H
 fhtQ9aoPNCdBQuMQzy31ZpSiFU+o6JgMgsU3XQnEg5vNodSeVXbUMFE6Egjhp4dXzYz+Pk
 hIT5LjJbpKzX9ScpyASR5xdDN88EgaEob2B8F7ccPHnUXM0Ce6ATn/wjey+OJg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Enable DFU SF on all i.MX6 DHSOM and include
 dfu_alt_info in env
Date: Sun,  2 Nov 2025 22:45:33 +0100
Message-ID: <20251102214614.307069-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 45066f20ff4235f070d
X-MBO-RS-META: 8ai58r3j9qw59ujszxiog1x18e771sqg
X-Rspamd-Queue-Id: 4d07Zg3JlTz9t9l
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

Enable DFU SF on all i.MX6 DHSOM so the SPI NOR can be exposed via
DFU, and include dfu_alt_info which exposes the full SPI NOR via DFU.
To install new bootloader into the SPI NOR using DFU, it is necessary
to pad the u-boot-with-spl.imx to 0x400 Bytes offset first and then
send it to the board as follows:

"
u-boot=> dfu 0 sf
"

"
host$ dd if=/dev/zero of=pad.bin bs=1024 count=1
host$ cat pad.bin u-boot-with-spl.imx > flash.bin
host$ dfu-util -w -a 0 -D flash.bin
"

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 configs/dh_imx6.config    | 1 +
 include/configs/dh_imx6.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/dh_imx6.config b/configs/dh_imx6.config
index 01db41be2a0..b1eeb8901f4 100644
--- a/configs/dh_imx6.config
+++ b/configs/dh_imx6.config
@@ -60,6 +60,7 @@ CONFIG_MISC=y
 
 CONFIG_PINCTRL_IMX6=y
 
+CONFIG_DFU_SF=y
 CONFIG_SDP_LOADADDR=0x17ffffc0
 CONFIG_SPL_FIT=y
 CONFIG_SPL_SPI=y
diff --git a/include/configs/dh_imx6.h b/include/configs/dh_imx6.h
index 09354936d73..d849cb544be 100644
--- a/include/configs/dh_imx6.h
+++ b/include/configs/dh_imx6.h
@@ -38,6 +38,7 @@
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"bootm_size=0x10000000\0"	\
 	"console=ttymxc0,115200\0"	\
+	"dfu_alt_info=sf 0:0=flash-bin raw 0 0x200000\0"	\
 	"fdt_addr=0x18000000\0"		\
 	"kernel_addr_r=0x10008000\0"	\
 	"fdt_addr_r=0x13000000\0"	\
-- 
2.51.0

