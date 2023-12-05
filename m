Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228ACC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 11:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFA886CF4;
	Tue,  5 Dec 2023 12:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512A486C72; Tue,  5 Dec 2023 12:48:47 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF65186D0E
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 12:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1rATuo-0007xC-VH; Tue, 05 Dec 2023 12:48:39 +0100
Message-ID: <92a3e3b4-6f4d-4ca4-947f-db905f328d4c@pengutronix.de>
Date: Tue, 5 Dec 2023 12:48:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20231202035511.487946-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hello Simon,

On 02.12.23 04:54, Simon Glass wrote:
> Add a script which produces a Flat Image Tree (FIT), a single file
> containing the built kernel and associated devicetree files.
> Compression defaults to gzip which gives a good balance of size and
> performance.
> 
> The files compress from about 86MB to 24MB using this approach.
> 
> The FIT can be used by bootloaders which support it, such as U-Boot
> and Linuxboot. It permits automatic selection of the correct
> devicetree, matching the compatible string of the running board with
> the closest compatible string in the FIT. There is no need for
> filenames or other workarounds.
> 
> Add a 'make image.fit' build target for arm64, as well. Use
> FIT_COMPRESSION to select a different algorithm.
> 
> The FIT can be examined using 'dumpimage -l'.
> 
> This features requires pylibfdt (use 'pip install libfdt'). It also
> requires compression utilities for the algorithm being used. Supported
> compression options are the same as the Image.xxx files. For now there
> is no way to change the compression other than by editing the rule for
> $(obj)/image.fit
> 
> While FIT supports a ramdisk / initrd, no attempt is made to support
> this here, since it must be built separately from the Linux build.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

kernel_noload support is now in barebox next branch and I tested this
series against it:

Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de> # barebox

> +"""Build a FIT containing a lot of devicetree files
> +
> +Usage:
> +    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
> +        -f arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
> +        /tmp/kern/arch/arm64/boot/dts/ -E -c gzip
> +
> +Creates a FIT containing the supplied kernel and a directory containing the
> +devicetree files.
> +
> +Use -E to generate an external FIT (where the data is placed after the
> +FIT data structure). This allows parsing of the data without loading
> +the entire FIT.
> +
> +Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
> +zstd algorithms.
> +
> +The resulting FIT can be booted by bootloaders which support FIT, such
> +as U-Boot, Linuxboot, Tianocore, etc.

Feel free to add barebox to the list. Did you check whether Linuxboot and
Tianocore support kernel_noload?

> +        fsw.property_u32('load', 0)
> +        fsw.property_u32('entry', 0)

I still think load and entry dummy values are confusing and should be dropped.

> +    with fsw.add_node(f'fdt-{seq}'):
> +        # Get the compatible / model information
> +        with open(fname, 'rb') as inf:
> +            data = inf.read()
> +        fdt = libfdt.FdtRo(data)
> +        model = fdt.getprop(0, 'model').as_str()
> +        compat = fdt.getprop(0, 'compatible')
> +
> +        fsw.property_string('description', model)
> +        fsw.property_string('type', 'flat_dt')
> +        fsw.property_string('arch', arch)
> +        fsw.property_string('compression', compress)
> +        fsw.property('compatible', bytes(compat))
> +
> +        with open(fname, 'rb') as inf:
> +            compressed = compress_data(inf, compress)
> +        fsw.property('data', compressed)
> +    return model, compat

After Doug's elaboration, extracting multiple compatibles is fine by me.

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

