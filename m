Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DBDE7E639
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099CD86D4F;
	Tue, 26 Sep 2023 16:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GLYIRDrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224F686D91; Tue, 26 Sep 2023 16:05:08 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F38F286B93
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59e88a28b98so125525887b3.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695737104; x=1696341904; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YxMcEwbcxcZzBaPuCreNjWpPJa4uFhwQZiqzC137WfI=;
 b=GLYIRDrdpNXEylTRQhP1oWz8dPojk8rHlhn/de/8LqiCGkPfOhMNCNSyFE37XXbzK0
 fn5GCDolGDxv9mj+DucJnw3oeKf50ib1lZCX0SB25G8kQWgHoeqMOQQUXX+k4mE+O002
 Nng/RAxJw3KrA3a16RsuvNc392RXJHNDqiFGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737104; x=1696341904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxMcEwbcxcZzBaPuCreNjWpPJa4uFhwQZiqzC137WfI=;
 b=QJ2waGMjE+t6vtDAAJzA03O8EniXmPUEhMgta5Ox70qWedofJSOPAylwPL21StVZQ1
 KvBfDwVtEa7b9I67Imy4o8EXWwZ6PTwP+FWV2NMw4hE9nQ5eXLXjsInm8YtgF15KexhQ
 cfVAy8EBhcdU9aB/KLkK8N1kf9aa93pwpRhf3bOtGezz5Lle4Rgpoq6Vvhg6NuzOLZlo
 L0zSfyYdLlrY8kYbWff6O3Eb3tl650R6ofXJvF4G3HQCDbN2YnAx+xY8Jtv/yNFQ6jix
 7YHxXNE2rFhcRlWcsmjlerHfveEQrzQa/hga8lZSTAVp+fB6ggDUz701XYjXVuq1B0DG
 tbzw==
X-Gm-Message-State: AOJu0YyWn1EQmSqrKckszzyltjsf80Or+41GRLKLv2uQmFqBGlYyZ5UR
 HWJ3ldu5imbsVAGLtmz7bsWL4w==
X-Google-Smtp-Source: AGHT+IEBkec5OVt0ljar7+UP9NQAq7pztM3i2160eqncyeQbtlF3T5R208ve/I2UjO1E7YKCo/ar1A==
X-Received: by 2002:a0d:d657:0:b0:59f:5293:9936 with SMTP id
 y84-20020a0dd657000000b0059f52939936mr2084677ywd.16.1695737104497; 
 Tue, 26 Sep 2023 07:05:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a080-e51b-f064-cf67.res6.spectrum.com.
 [2603:6081:7b00:6400:a080:e51b:f064:cf67])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a814a09000000b00589c103d00asm3011603ywa.79.2023.09.26.07.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:05:03 -0700 (PDT)
Date: Tue, 26 Sep 2023 10:05:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Stefan Roese <sr@denx.de>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH v3 38/38] pci: serial: Support reading PCI-register size
 with base
Message-ID: <20230926140500.GU305624@bill-the-cat>
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-39-sjg@chromium.org>
 <20230925201709.GP305624@bill-the-cat>
 <CAPnjgZ1_i1ehK055tJHDq2uAFRpu1BHsUrwVucZ2R2Upt9GPEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d+qcFbDxuruU1khU"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1_i1ehK055tJHDq2uAFRpu1BHsUrwVucZ2R2Upt9GPEA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--d+qcFbDxuruU1khU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 05:37:32AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 25 Sept 2023 at 14:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Sep 24, 2023 at 01:25:23PM -0600, Simon Glass wrote:
> >
> > > The PCI helpers read only the base address for a PCI region. In some =
cases
> > > the size is needed as well, e.g. to pass along to a driver which need=
s to
> > > know the size of its register area.
> > >
> > > Update the functions to allow the size to be returned. For serial, re=
cord
> > > the information and provided it with the serial_info() call.
> > >
> > > A limitation still exists in that the size is not available when OF_L=
IVE
> > > is enabled, so take account of that in the tests.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > So on platforms that end up here, we see consistently:
> >             eaidk-610-rk3399: all +224 spl/u-boot-spl:all +224 spl/u-bo=
ot-spl:text +224 text +224 tpl/u-boot-tpl:all +224 tpl/u-boot-tpl:text +224
> >                u-boot: add: 2/0, grow: 3/0 bytes: 224/0 (224)
> >                  function                                   old     new=
   delta
> >                  fdtdec_get_addr_size_auto_noparent           -     124=
    +124
> >                  devfdt_get_addr_size_index                   -      72=
     +72
> >                  ns16550_serial_of_to_plat                  316     328=
     +12
> >                  ns16550_serial_probe                       132     140=
      +8
> >                  ns16550_serial_getinfo                      84      92=
      +8
> >                tpl-u-boot-tpl: add: 2/0, grow: 3/0 bytes: 224/0 (224)
> >                  function                                   old     new=
   delta
> >                  fdtdec_get_addr_size_auto_noparent           -     124=
    +124
> >                  devfdt_get_addr_size_index                   -      72=
     +72
> >                  ns16550_serial_of_to_plat                  316     328=
     +12
> >                  ns16550_serial_probe                       132     140=
      +8
> >                  ns16550_serial_getinfo                      84      92=
      +8
> >                spl-u-boot-spl: add: 2/0, grow: 3/0 bytes: 224/0 (224)
> >                  function                                   old     new=
   delta
> >                  fdtdec_get_addr_size_auto_noparent           -     124=
    +124
> >                  devfdt_get_addr_size_index                   -      72=
     +72
> >                  ns16550_serial_of_to_plat                  316     328=
     +12
> >                  ns16550_serial_probe                       132     140=
      +8
> >                  ns16550_serial_getinfo                      84      92=
      +8
> >
> > Can we optimize this in any way? I'm less concerned with full U-Boot
> > growing by 224 bytes than I am by TPL growing by that much too.
>=20
> One option would be to have two functions in each case, one for the
> address and one for the address + size. We do that in some other
> cases. I have to admit I somehow didn't notice this large size
> difference, although I knew it would have an impact...it is so strange
> how the compiler changes what functions end up in the image willy
> nilly.

Yes, please take a look.  But note that it's not arbitrary, setting
aside the EFI application build, we garbage collect things that cannot
be called :)

--=20
Tom

--d+qcFbDxuruU1khU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUS5QkACgkQFHw5/5Y0
tyzsygv+ODKHOOfz5fFTOY5mNYqrf+W4nmIUVs3jFAa6urmgC5GGrRz3msPEC9oe
fwHLmqguqjr2k2hiMnD891c3iOSuY7ncwKIkqkaTAVsvck5j26hQ6ECK8hMPmYLb
qeACJkdUS+Plbw+R/lfvN7Fa60ktyFiIuE6f9LCch4aeKi6QHEO7u3RVkPIFupUT
2KuC0cAoGrkM8qDg0vBlV9SePAbmmfOPysdn7+btOtZtByPmrJM6jwIP9sLFS+fl
Z0y7AWKVismFdQ8Lma3mXliaAQMzUN2hXJnaqZ3gwSyYENwjN1zio0WFDw71IT9g
1pVTNodYga2d2semuvCdAtHKDPc6gl8l6/gIgLyEq7X/tbbsp5UQszP0QcjxG60l
hW5IPxYdlIpobem7a/8TLeXiyjF7k3D/dGByz4J9IZJY/gRTHr6a5UDe+9H/K7ng
/2IY0/6gcv5pwJutrkW/hJqxfqxmlUxPfUOULTk9ZZUyS6WCRM++WSb8emWqHpKC
n1lLcfWA
=IdNF
-----END PGP SIGNATURE-----

--d+qcFbDxuruU1khU--
