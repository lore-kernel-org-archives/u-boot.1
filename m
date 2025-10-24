Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14EDCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 20:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EBC83621;
	Fri, 24 Oct 2025 22:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBDCB83678; Fri, 24 Oct 2025 22:43:21 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6D082E34
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 22:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.255])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id D23B4B220074;
 Fri, 24 Oct 2025 22:43:15 +0200 (CEST)
Message-ID: <c9cb52d6-98e3-47a5-9efc-a5dccfde91a4@freeshell.de>
Date: Fri, 24 Oct 2025 13:43:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] doc: Fix typos
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>, u-boot@lists.denx.de
Cc: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Alex Shumsky <alexthreed@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Jonas <mark.jonas@de.bosch.com>,
 Mattia Narducci <mattianarducci1@gmail.com>,
 Ricardo Simoes <ricardo.simoes@pt.bosch.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yegor Yefremov <yegorslists@googlemail.com>,
 mason1920 <mason1920@use.startmail.com>
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
 <20251024151219.100970-4-wolfgang.wallner@br-automation.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251024151219.100970-4-wolfgang.wallner@br-automation.com>
Content-Type: text/plain; charset=UTF-8
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


On 10/24/25 08:11, Wolfgang Wallner wrote:
> Fix typos/wording in various files in doc/.
> 
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> ---
> 
>  doc/develop/devicetree/control.rst     |  2 +-
>  doc/develop/driver-model/fdt-fixup.rst |  2 +-
>  doc/develop/testing.rst                |  4 ++--
>  doc/develop/trace.rst                  |  2 +-
>  doc/mkimage.1                          |  4 ++--
>  doc/usage/environment.rst              |  2 +-
>  doc/usage/fit/beaglebone_vboot.rst     |  2 +-
>  doc/usage/fit/overlay-fdt-boot.rst     | 14 +++++++-------
>  8 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index c25b98683f8..634114af59a 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -288,7 +288,7 @@ The full devicetree is available to U-Boot proper, but normally only a subset
>  Using several DTBs in the SPL (SPL_MULTI_DTB_FIT Kconfig option)
>  ----------------------------------------------------------------
>  In some rare cases it is desirable to let SPL be able to select one DTB among
> -many. This usually not very useful as the DTB for the SPL is small and usually
> +many. This is usually not very useful as the DTB for the SPL is small and usually
>  fits several platforms. However the DTB sometimes include information that do
>  work on several platforms (like IO tuning parameters).
>  In this case it is possible to use SPL_MULTI_DTB_FIT Kconfig option. This option
> diff --git a/doc/develop/driver-model/fdt-fixup.rst b/doc/develop/driver-model/fdt-fixup.rst
> index 974c09031ed..b547daf79ff 100644
> --- a/doc/develop/driver-model/fdt-fixup.rst
> +++ b/doc/develop/driver-model/fdt-fixup.rst
> @@ -45,7 +45,7 @@ An additional problem with the device tree in U-Boot is that it is read-only,
>  and the current mechanisms don't allow easy manipulation of the device tree
>  after the driver model has been initialized. While migrating to a live device
>  tree (at least after the relocation) would greatly simplify the solution of
> -this problem, it is a non-negligible task to implement it, an a interim
> +this problem, it is a non-negligible task to implement it, an ad interim
>  solution is needed to address the problem at least in the medium-term.
>  
>  Hence, we propose a solution to this problem by offering a board-specific
> diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
> index aa7786c99fd..3a2b496fa00 100644
> --- a/doc/develop/testing.rst
> +++ b/doc/develop/testing.rst
> @@ -28,7 +28,7 @@ run. Type this::
>  
>      make tcheck
>  
> -You can also run a selection tests in parallel with::
> +You can also run a selection of tests in parallel with::
>  
>      make pcheck
>  
> @@ -39,7 +39,7 @@ are run. See :doc:`pytest/usage` for more information.
>  Sandbox
>  -------
>  U-Boot can be built as a user-space application (e.g. for Linux). This
> -allows test to be executed without needing target hardware. The 'sandbox'
> +allows tests to be executed without needing target hardware. The 'sandbox'
>  target provides this feature and it is widely used in tests.
>  
>  See :doc:`tests_sandbox` for more information.
> diff --git a/doc/develop/trace.rst b/doc/develop/trace.rst
> index d3c8628d124..16635d6d238 100644
> --- a/doc/develop/trace.rst
> +++ b/doc/develop/trace.rst
> @@ -354,7 +354,7 @@ Writing Out Trace Data
>  ----------------------
>  
>  Once the trace data is in an output buffer in memory there are various ways
> -to transmit it to the host. Notably you can use tftput to send the data
> +to transmit it to the host. Notably you can use tftpput to send the data
>  over a network link::
>  
>      fakegocmd=trace pause; usb start; set autoload n; bootp;
> diff --git a/doc/mkimage.1 b/doc/mkimage.1
> index 75b6b48a0cf..c705218d345 100644
> --- a/doc/mkimage.1
> +++ b/doc/mkimage.1
> @@ -208,7 +208,7 @@ option and the format of their configuration are listed in
>  .TQ
>  .BI \-\-secondary\-config " secondary-configuration"
>  Some image types support a second set of configuration data. The image types
> -which support secondary configuration and the formap of their configuration are
> +which support secondary configuration and the format of their configuration are
>  listed in
>  .BR CONFIGURATION .
>  .
> @@ -396,7 +396,7 @@ when used together with -K and/or -k options.
>  .BI \-\-key\-dest " key-destination"
>  Specifies a compiled device tree binary file (typically .dtb) to write
>  public key information into. When a private key is used to sign an image,
> -the corresponding public key is written into this file for for run-time
> +the corresponding public key is written into this file for run-time
>  verification. Typically the file here is the device tree binary used by
>  CONFIG_OF_CONTROL in U-Boot.
>  .
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index 5553a629e42..0143f81f2c0 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -213,7 +213,7 @@ updatefile
>  
>  autoload
>      if set to "no" (any string beginning with 'n'),
> -    "bootp" and "dhcp" will just load perform a lookup of the
> +    "bootp" and "dhcp" will just perform a lookup of the
>      configuration from the BOOTP server, but not try to
>      load any image.
>  
> diff --git a/doc/usage/fit/beaglebone_vboot.rst b/doc/usage/fit/beaglebone_vboot.rst
> index 1298ba1ae08..b15399441ee 100644
> --- a/doc/usage/fit/beaglebone_vboot.rst
> +++ b/doc/usage/fit/beaglebone_vboot.rst
> @@ -473,7 +473,7 @@ you sign::
>  Here we are overriding the normal device tree file with our one, which
>  contains the public key.
>  
> -Now you have a special U-Boot image with the public key. It can verify can
> +Now you have a special U-Boot image with the public key. It can verify any
>  kernel that you sign with the private key as in step 5.
>  
>  If you like you can take a look at the public key information that mkimage
> diff --git a/doc/usage/fit/overlay-fdt-boot.rst b/doc/usage/fit/overlay-fdt-boot.rst
> index d687e98ea2a..f5af6d9df05 100644
> --- a/doc/usage/fit/overlay-fdt-boot.rst
> +++ b/doc/usage/fit/overlay-fdt-boot.rst
> @@ -19,7 +19,7 @@ Configuration without overlays
>  ------------------------------
>  
>  Take a hypothetical board named 'foo' where there are different supported
> -revisions, reva and revb. Assume that both board revisions can use add a bar
> +revisions, reva and revb. Assume that both board revisions can add a bar
>  add-on board, while only the revb board can use a baz add-on board.
>  
>  Without using overlays the configuration would be as follows for every case::
> @@ -97,7 +97,7 @@ Without using overlays the configuration would be as follows for every case::
>  	};
>  
>  Note the blob needs to be compiled for each case and the combinatorial explosion of
> -configurations. A typical device tree blob is in the low hunderds of kbytes so a
> +configurations. A typical device tree blob is in the low hundreds of kbytes so a
>  multitude of configuration grows the image quite a bit.
>  
>  Booting this image is done by using::
> @@ -117,7 +117,7 @@ Configuration using overlays
>  ----------------------------
>  
>  Device tree overlays can be applied to a base DT and result in the same blob
> -being passed to the booting kernel. This saves on space and avoid the combinatorial
> +being passed to the booting kernel. This saves on space and avoids the combinatorial
>  explosion problem::
>  
>      /dts-v1/;
> @@ -164,7 +164,7 @@ explosion problem::
>          };
>  
>          configurations {
> -            default = "foo-reva.dtb;
> +            default = "foo-reva.dtb";
>              foo-reva.dtb {
>                  kernel = "kernel";
>                  fdt = "fdt-1", "fdt-2";
> @@ -209,9 +209,9 @@ to be writeable.
>  Configuration using overlays and feature selection
>  --------------------------------------------------
>  
> -Although the configuration in the previous section works is a bit inflexible
> -since it requires all possible configuration options to be laid out before
> -hand in the FIT image. For the add-on boards the extra config selection method
> +Although the configuration in the previous section works, it is a bit inflexible
> +since it requires all possible configuration options to be laid out beforehand
> +in the FIT image. For the add-on boards the extra config selection method
>  might make sense.
>  
>  Note the two bar & baz configuration nodes. To boot a reva board with

Thanks for doing this work,

Reviewed-by: E Shattow <e@freeshell.de>
