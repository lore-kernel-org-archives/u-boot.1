Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCCDEEC2B7
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 00:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B33183642;
	Tue, 24 Feb 2026 01:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C28CB83935; Tue, 24 Feb 2026 01:37:49 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A398063E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 01:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vugQV-000000001Yr-22eO; Tue, 24 Feb 2026 00:37:23 +0000
Date: Tue, 24 Feb 2026 00:37:19 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <aZzyv1sUrnm2PKBc@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217181358.GE2747538@bill-the-cat>
 <aZTBQykqCt7H8H4W@makrotopia.org>
 <20260217193534.GI2747538@bill-the-cat>
 <aZTYk8E6r4S5zo_Z@makrotopia.org>
 <20260217211853.GJ2747538@bill-the-cat>
 <aZTqyRfqYe1iJ9EY@makrotopia.org>
 <20260218155839.GC3233182@bill-the-cat>
 <aZX2APcJvmU4XSIy@makrotopia.org>
 <20260218203314.GG3233182@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218203314.GG3233182@bill-the-cat>
X-Mailman-Approved-At: Tue, 24 Feb 2026 01:47:47 +0100
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

On Wed, Feb 18, 2026 at 02:33:14PM -0600, Tom Rini wrote:
> On Wed, Feb 18, 2026 at 05:25:20PM +0000, Daniel Golle wrote:
> > On Wed, Feb 18, 2026 at 09:58:39AM -0600, Tom Rini wrote:
> > > On Tue, Feb 17, 2026 at 10:25:13PM +0000, Daniel Golle wrote:
> > > > [...]
> > > > As the existing code expects the whole image to reside in RAM and only
> > > > take care of validation, decompression and relocation, I had to extend
> > > > image-fit.c to use the image_loader to only load the parts *from
> > > > storage* which are actually needed, and if possible, load them directly
> > > > to where they are supposed to go. Imho, the code is simple enough to
> > > > just look at it:
> > > > 
> > > > https://patchwork.ozlabs.org/project/uboot/patch/ab7837536e4567b90d7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org/
> > > > 
> > > > At this stage (because I first wanted to discuss the general approach)
> > > > the patch still skips some parts of image-fit.c, which is obviously not
> > > > acceptable for upstream inclusion, but good enough to demonstrate the
> > > > idea and also try it in practise.
> > > > 
> > > > Ie. the 'goto storage_loaded' has to go away and all of image-fit.c has
> > > > to be changed to equally work on RAM-backed or storage-backed images.
> > > 
> > > I was talking with Marek to recall some of the details about what we can
> > > and can't (easily..) do today with external data and he remidned me of
> > > something. So one big concern here is that we have to be care to not
> > > re-open things like:
> > > https://nvd.nist.gov/vuln/detail/CVE-2023-39902
> > > or otherwise allow for mix-and-match type attacks by having some sort of
> > > partial reads allowed.
> > > 
> > > So a specialized partial-read of FIT images, in full U-Boot (not just
> > > SPL), is something to figure out, but may also invalidate one of your
> > > design goals because you do have to authenticate the whole image, unless
> > > there's something both secure and clever I'm missing.
> > 
> > The idea here is to have one or more IH_TYPE_FILESYSTEM subimages which
> > do not have hash-* subnodes at all, hence, if there is anyway nothing to
> > validate and they do not need to be loaded to RAM (ie. no load address),
> > they can be skipped entirely, even if listed as 'loadable' (which is how
> > the parser in the kernel currently knows which filesystem image to map;
> > we could introduce a new property different from 'loadables', of course).
> > Everything else which is part of the selected configuration node of
> > course has to be loaded and authenticated.
> > 
> > To compensate for the authentication of IH_TYPE_FILESYSTEM subimages not
> > done by U-Boot before launching Linux, the dm-verity root hash passed to
> > Linux via cmdline should be part of the signed configuration, eg. by
> > including an image of IH_TYPE_SCRIPT modifying 'bootargs', or by coming
> > up with a new image type specifically for that purpose. Or, even better
> > but a bit more involved, include the dm-verity roothash in the ITS spec
> > instead of the hash-* nodes.
> > 
> > In terms of security, anyway only dm-verity makes sense, as there is no
> > point in validating the filesystem subimage if what is validated then
> > isn't also what is used -- one could quickly swap the storage device
> > after U-Boot has launched the kernel and before Linux mounts the rootfs
> > (from storage!) ending up with a different rootfs than what U-Boot had
> > previously validated when authenticating the image.
> 
> Right, OK. What I was thinking about, but Marek corrected me on, is
> about where we may or may not have problems about authentication. So
> long as we start by reading in the whole of the FIT (which excludes
> external data, being external) and start the authentication with that,
> we should be fine.
> 
> I have some other questions / concerns still, but there's also still a
> number of other emails I sent that're outstanding. So, can you please
> link to an itb that would be making use of your proposed feature? Being
> able to examine that would help me be more precise in my own questions,
> thanks.

I don't have any option at hand to host larger binaries anywhere public.

If you know any service which allows to do this for free without
requiring a complicated and personal-data-exposing sign-up procedure,
please let me know, I'll use that.

Meanwhile, as the content of the large data blobs probably anyway
doesn't matter for this discussion, here is the decompiled FIT structure:

/dts-v1/;

/ {
	timestamp = <0x69987422>;
	description = "ARM64 OpenWrt FIT (Flattened Image Tree)";
	#address-cells = <0x01>;

	images {

		kernel-1 {
			data-size = <0x5e4cdb>;
			data-position = <0x4000>;
			description = "ARM64 OpenWrt Linux-6.12.71";
			type = "kernel";
			arch = "arm64";
			os = "linux";
			compression = "gzip";
			load = <0x44000000>;
			entry = <0x44000000>;

			hash-1 {
				value = <0x5e864feb>;
				algo = "crc32";
			};

			hash-2 {
				value = <0x1029dbef 0xda4938de 0x16eda8c5 0x9c0fffc2 0x1a4c458f>;
				algo = "sha1";
			};
		};

		fdt-1 {
			data-size = <0x7d10>;
			data-position = <0x5e9000>;
			description = "ARM64 OpenWrt bananapi_bpi-r3 device tree blob";
			type = "flat_dt";
			load = <0x43f00000>;
			arch = "arm64";
			compression = "none";

			hash-1 {
				value = <0x331fdfaf>;
				algo = "crc32";
			};

			hash-2 {
				value = <0x4930ba36 0xe594a76b 0xcf6ba90b 0xa8c92ae5 0xdc68ed66>;
				algo = "sha1";
			};
		};

		fdt-mt7986a-bananapi-bpi-r3-emmc {
			data-size = <0x405>;
			data-position = <0x5f1000>;
			description = "ARM64 OpenWrt bananapi_bpi-r3 device tree overlay mt7986a-bananapi-bpi-r3-emmc";
			type = "flat_dt";
			arch = "arm64";
			compression = "none";

			hash-1 {
				value = <0x59209fd3>;
				algo = "crc32";
			};

			hash-2 {
				value = <0xb76ad9bb 0x9619b789 0x8e920f02 0x27be0a3a 0x6154b007>;
				algo = "sha1";
			};
		};

		fdt-mt7986a-bananapi-bpi-r3-nand {
			data-size = <0x46c>;
			data-position = "", "_ ";
			description = "ARM64 OpenWrt bananapi_bpi-r3 device tree overlay mt7986a-bananapi-bpi-r3-nand";
			type = "flat_dt";
			arch = "arm64";
			compression = "none";

			hash-1 {
				value = <0xaeedea4c>;
				algo = "crc32";
			};

			hash-2 {
				value = <0xc47f4473 0xcf3eb99a 0x284f63a0 0xb508857d 0xed829f97>;
				algo = "sha1";
			};
		};

		fdt-mt7986a-bananapi-bpi-r3-nor {
			data-size = <0x4be>;
			data-position = "", "_0";
			description = "ARM64 OpenWrt bananapi_bpi-r3 device tree overlay mt7986a-bananapi-bpi-r3-nor";
			type = "flat_dt";
			arch = "arm64";
			compression = "none";

			hash-1 {
				value = <0xa3898f18>;
				algo = "crc32";
			};

			hash-2 {
				value = <0xc45f4ad9 0x30273fbc 0x6721b946 0xa380aca1 0xc9bbd5a4>;
				algo = "sha1";
			};
		};

		fdt-mt7986a-bananapi-bpi-r3-sd {
			data-size = <0x36b>;
			data-position = "", "_@";
			description = "ARM64 OpenWrt bananapi_bpi-r3 device tree overlay mt7986a-bananapi-bpi-r3-sd";
			type = "flat_dt";
			arch = "arm64";
			compression = "none";

			hash-1 {
				value = <0xd0cb47a7>;
				algo = "crc32";
			};

			hash-2 {
				value = <0xb62232a8 0x23113c8a 0xc6973ef9 0x1748f275 0xe6e423fc>;
				algo = "sha1";
			};
		};

		fdt-mt7986a-bananapi-bpi-r3-respeaker-2mics {
			data-size = <0x5b2>;
			data-position = "", "_P";
			description = "ARM64 OpenWrt bananapi_bpi-r3 device tree overlay mt7986a-bananapi-bpi-r3-respeaker-2mics";
			type = "flat_dt";
			arch = "arm64";
			compression = "none";

			hash-1 {
				value = <0xc8d3f33c>;
				algo = "crc32";
			};

			hash-2 {
				value = <0x29e3a558 0x75e9a9d8 0x34d88eaa 0x5c134e78 0xa05deef9>;
				algo = "sha1";
			};
		};

		rootfs-1 {
			data-size = <0x1005000>;
			data-position = "", "_`";
			description = "ARM64 OpenWrt bananapi_bpi-r3 rootfs";
			type = "filesystem";
			arch = "arm64";
			compression = "none";

			hash-1 {
				value = <0xde4b8717>;
				algo = "crc32";
			};

			hash-2 {
				value = <0x13535da6 0x7fa95cda 0x9331dc1 0x1cd01dd 0xaea3701e>;
				algo = "sha1";
			};

			dm-verity {
				block-size = <0x1000>;
				data-blocks = <0xfe3>;
				algo = "sha256";
				root-hash = "61b01a3b94d7e1166ed34bbdf60a65944f49fcebced531d5cdc98b8b65b2a898";
				salt = "73a9020ed5a88a54f8392dd1b141a6def3072461061275db72ef18e6e1851c6c";
			};
		};
	};

	configurations {
		default = "config-mt7986a-bananapi-bpi-r3";

		config-mt7986a-bananapi-bpi-r3 {
			description = "OpenWrt bananapi_bpi-r3";
			kernel = "kernel-1";
			fdt = "fdt-1";
			loadables = "rootfs-1";
		};

		mt7986a-bananapi-bpi-r3-emmc {
			description = "OpenWrt bananapi_bpi-r3 overlay mt7986a-bananapi-bpi-r3-emmc";
			fdt = "fdt-mt7986a-bananapi-bpi-r3-emmc";
		};

		mt7986a-bananapi-bpi-r3-nand {
			description = "OpenWrt bananapi_bpi-r3 overlay mt7986a-bananapi-bpi-r3-nand";
			fdt = "fdt-mt7986a-bananapi-bpi-r3-nand";
		};

		mt7986a-bananapi-bpi-r3-nor {
			description = "OpenWrt bananapi_bpi-r3 overlay mt7986a-bananapi-bpi-r3-nor";
			fdt = "fdt-mt7986a-bananapi-bpi-r3-nor";
		};

		mt7986a-bananapi-bpi-r3-sd {
			description = "OpenWrt bananapi_bpi-r3 overlay mt7986a-bananapi-bpi-r3-sd";
			fdt = "fdt-mt7986a-bananapi-bpi-r3-sd";
		};

		mt7986a-bananapi-bpi-r3-respeaker-2mics {
			description = "OpenWrt bananapi_bpi-r3 overlay mt7986a-bananapi-bpi-r3-respeaker-2mics";
			fdt = "fdt-mt7986a-bananapi-bpi-r3-respeaker-2mics";
		};
	};
};
