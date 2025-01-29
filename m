Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6E0C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C42B080CF4;
	Wed, 29 Jan 2025 23:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WOrGyQoQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HUkf/sQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1DC80C5A; Wed, 29 Jan 2025 23:00:36 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD32E80BAE
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Yjx0y2Ycxz9t1S;
 Wed, 29 Jan 2025 23:00:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738188034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d20Py3zSwwsYuM6YhZPflzVRcYi0ZhWfz0XGIBAG3n4=;
 b=WOrGyQoQ/0eG3TL/QCLKewQgjqzQituRgDgEcS1KuOMDLaKkK8bFdPp5pe/30Gpug88cC6
 BdoRuMqGRijHSVaGuTa6kT5DpAn2N9qOkqPYNz4Vwkb2E/epNfLpsqP6leZ32OEufhQw2k
 S5dRfrArrAhvpuXVI1upE6r+ATUEV/C3s8VkD0jnGyb2jqWkd4ryzVsBYoyNjtIyuhg7QS
 +QHzvAVH1g9ZKu4Yjy/6TUDIMGFH90WULVHcxPNbqNDnReihdlBFJoFu8f5mfszFOLoyhW
 OFV5dTixlZIxNSEUpeQVcT0gl6HPDzecL65II3bw4/5F+7hKTHPSaQ+4MW0EMQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738188032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d20Py3zSwwsYuM6YhZPflzVRcYi0ZhWfz0XGIBAG3n4=;
 b=HUkf/sQgZ8migs/Wvoy1H4qqjUC/ated1D6NbDIXF/RqjULwqVTBdzVw2bO4rlLmDTyQcm
 onB97BFvUpHNlcajHcp8C/aWG8osizeAlGqbVGNqMmRhD0W4pN7WHvIgW/2kkJjusJUgGW
 5hyC2EhCI+usTz6qlQhWjCvcQ7V63t3mW/GkaAe2bGIx+pNYxZC7X+91ON14IYSq0tugyY
 3aOwsEyYFU0Ssu62EvSm8GbVsXd8pP42MtgOAAuWsRgxv38Oq2X094SfFbJyI72yBuW4XY
 HOTLsfqSKQX+MalPXase/b1ffWx9mxbNqmRt8+NSzXR5IyNgYBCZRDIkP2Hfbg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
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
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
Date: Wed, 29 Jan 2025 22:59:19 +0100
Message-ID: <20250129220010.264635-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250129220010.264635-1-marek.vasut+renesas@mailbox.org>
References: <20250129220010.264635-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a3eb0efd19e0e7752a0
X-MBO-RS-META: 4ynj7o9fjy5uyeofxw6o7ci4fofbenef
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

Reviewed-by: Tom Rini <trini@konsulko.com>
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
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Raymond Mao <raymond.mao@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Add RB from Tom
---
 boot/image-fit.c | 1 +
 boot/image.c     | 1 +
 include/image.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 70080d1a6c0..c3a0fe77932 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2166,6 +2166,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
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
index 8a9f779d3ff..07912606f33 100644
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

