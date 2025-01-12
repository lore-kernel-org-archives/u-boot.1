Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB46E7719E
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3655801F5;
	Sun, 12 Jan 2025 23:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qyIR/yKW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gWiXhCZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B13B580602; Sun, 12 Jan 2025 23:38:29 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915EE801B6
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YWVfW28z6z9sbg;
 Sun, 12 Jan 2025 23:38:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahKnaIeBrqQ124zDVmsSVNnmZs4orfpvgtT5La0QSto=;
 b=qyIR/yKWyaJkDdjyeECu4H7/QikL7tZ/A7yUW1xEptPyBwqQ/1BbY3PRKPeb+hRFnK2cxL
 8UlR3EavLQ4s9hhTEOulKl/zQuxhbDRYJuf7o6JVUYDTg37jajXl6UBGvCS/ih3oQpfpyM
 vtPdwwrvSwyV174KfAlJhIJ6mzdL237l6ZUDIZsiSYWlR6JjhhJzlnyqhmbwbEBDRhTd3P
 n3OE8Gxnxtwbwy59SLXDCmIxwzgIRRxqNV2qee/D4VTRjIDgmcbqlwmpr0xsV6T4ATWLWr
 n0r0s36vsTeotGlOnaaIzhRA769QXSLZn/IQ+2NaXq7fHn4hMv80PoKkNvbUlA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahKnaIeBrqQ124zDVmsSVNnmZs4orfpvgtT5La0QSto=;
 b=gWiXhCZyZZldWz4ae/A62uo1RQBxkNe/vVY99uWWASO+gX14Dysg4PUcEzlIMMQi+Smq9c
 pNF3ufnlc2UQ6Txwnf625K+Z4aKmj92znq2eVG/mR+yZMupHMPdZ2J6HK7WqLzcpTrTWJG
 z0BKY18LXNPag20Vmmb7PasqHCBVIQXujYXjRC6cmvbBaqZk47qIztJKsdPIyHI+7ADfLT
 Y9fDCBWqyTJA1iWKEQu1arn6yHN4XfiZyAHBuSHZCAiYPsVafx7gJfrbVeLftnwp34T+zF
 mqWMIdj7FnkaX1xU3Oc26pup0awQX1TQC57qQg9Q0VuHjjucfW9lh9PAf5OZDQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
Date: Sun, 12 Jan 2025 23:36:58 +0100
Message-ID: <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p6r5aipdjcwpxep1fo36xr188ycf65jp
X-MBO-RS-ID: 4c7ae684011c399e934
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

Add support for starting TFA from U-Boot running in EL3 as part of
fitImage boot, so the user can start U-Boot in the highest privilege
level on the platform, bundle TFA, Linux, DT into a single fitImage
and boot such a bundle as a whole.

There are two main benefits of this approach. First is the ability
to run U-Boot in EL3, where it has unrestricted access to the entire
system and can act as a useful debug tool, as it was always intended
to be used. Second is the ability to easily and safely update of any
component in the fitImage, be it TFA, Linux or DT.

The boot process is similar to regular Linux with DT fitImage boot
process, except the TFA has to be bundled into the fitImage. For the
bundling instructions, see below. The TFA is started as a 'loadables'
with custom U_BOOT_FIT_LOADABLE_HANDLER and armv8_switch_to_el2_prep()
handling implemented in board code, and performing the handoff and
boot in case the TFA was loaded.

The loadables handler is optional and meant to set up any sort of
handoff structures used by the TFA BL31 or perform any other setup
that is needed by the blob. The custom armv8_switch_to_el2_prep()
has to implement the jump to TFA BL31 with return to U-Boot just
before booting the Linux kernel.

Example fitImage image and configuration section:

/dts-v1/;

/ {
    description = "Linux kernel with FDT blob and TFA BL31";

    images {
        kernel-1 { ... };
        fdt-1 { ... };
        atf-1 {                  /* This is the TFA BL31 image */
            description = "TFA BL31";
            data = /incbin/("../build/plat/release/bl31.bin");
            type = "tfa-bl31";
            arch = "arm64";
            os = "arm-trusted-firmware";
            compression = "none";
            load = <0x46400000>;
            entry = <0x46400000>;
        };
    };

    configurations {
        default = "conf-1";
        conf-1 {
            description = "Boot Linux";
            kernel = "kernel-1";
            fdt = "fdt-1";
            loadables = "atf-1"; /* This is the TFA BL31 loadable */
        };
    };
};

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Cc: Raymond Mao <raymond.mao@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 boot/image-fit.c | 1 +
 boot/image.c     | 1 +
 include/image.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index db7fb61bca9..3b6d7231aff 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2167,6 +2167,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	type_ok = fit_image_check_type(fit, noffset, image_type) ||
 		  fit_image_check_type(fit, noffset, IH_TYPE_FIRMWARE) ||
 		  fit_image_check_type(fit, noffset, IH_TYPE_TEE) ||
+		  fit_image_check_type(fit, noffset, IH_TYPE_TFA_BL31) ||
 		  (image_type == IH_TYPE_KERNEL &&
 		   fit_image_check_type(fit, noffset, IH_TYPE_KERNEL_NOLOAD));
 
diff --git a/boot/image.c b/boot/image.c
index abac254e026..139c5bd035a 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat Device Tree ", },
 	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
 	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
+	{	IH_TYPE_TFA_BL31, "tfa-bl31",  "TFA BL31 Image", },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index 0a61dfd556c..3adb7219809 100644
--- a/include/image.h
+++ b/include/image.h
@@ -232,6 +232,7 @@ enum image_type_t {
 	IH_TYPE_FDT_LEGACY,		/* Binary Flat Device Tree Blob	in a Legacy Image */
 	IH_TYPE_RENESAS_SPKG,		/* Renesas SPKG image */
 	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
+	IH_TYPE_TFA_BL31,		/* TFA BL31 image */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
-- 
2.45.2

