Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3F4C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACBE88157;
	Thu, 28 Mar 2024 12:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D53548810E; Thu, 28 Mar 2024 12:56:31 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C330188157
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 12:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id F1C4BBF5;
 Thu, 28 Mar 2024 12:56:27 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 12:56:27 +0100
Message-Id: <D05D4N00QDKO.2PJ7VW4BNGQ11@kernel.org>
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
Cc: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Neha Malcom Francis" <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <bb@ti.com>, <nm@ti.com>, <sumit.garg@linaro.org>
X-Mailer: aerc 0.16.0
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
 <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
 <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
 <D04LUAJJ6LC7.1JVGVTJ0UCMVR@kernel.org>
 <062f7c42-7088-4813-a2d6-ecb7ab22b4ba@ti.com>
In-Reply-To: <062f7c42-7088-4813-a2d6-ecb7ab22b4ba@ti.com>
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

Hi,

On Thu Mar 28, 2024 at 12:18 PM CET, Neha Malcom Francis wrote:
> On 27-Mar-24 8:03 PM, Michael Walle wrote:
> > On Wed Mar 27, 2024 at 8:01 AM CET, Neha Malcom Francis wrote:
> >> On 26/03/24 19:18, Michael Walle wrote:
> >>> On Fri Mar 22, 2024 at 2:10 PM CET, Neha Malcom Francis wrote:
> >>>> Clean up templatized boot binaries for all K3 boards. This includes
> >>>> modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION=
 and
> >>>> UBOOT_BOARD_DESCRIPTION from the files that include it to further re=
use
> >>>> code.
> >>>>
> >>>> All k3-<soc>-binman.dtsi will contain only templates. Only required =
boot
> >>>> binaries can be built from the templates in the boards' respective
> >>>> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This all=
ows
> >>>> clear distinction between the SoC common stuff vs. what is additiona=
lly
> >>>> needed to boot up a specific board.
> >>>
> >>> I appreciate the cleanup. But as far as I can see, a board might
> >>> only have one device tree. How would that work if the uboot proper
> >>> must support multiple device trees?
> >>>
> >>
> >>   From the discussions that took place in the mailing list [1] the con=
sensus
> >> seems to be to not focus on multiple devicetree support as it leads to=
 confusion
> >> for downstream users.
> >=20
> > What are users in this regard? I don't think you'd confuse
> > developers.
> >=20
> > Anyway, I'm planning on upstreaming a TI board which will have
> > different memory configurations and different variants of the board.
>
> I am assuming you are reusing an existing TI SoC?

Not really yet. It's the j722s.


> > And on top of that, it will just be a base board and there will
> > likely be some carrier device trees (overlay? I'm not sure yet).
> >=20
> > As far as I can tell, you've put the memory configuration into the
> > device tree, so I'll probably need to switch between them somehow.
>
> The "k3-<soc>-ddr.dtsi" file will be present in your k3-<board>r5.dts=20
> which makes sense, the memory configuration depends on the board.

And one board might have multiple configuration depending on the
variant of the board. Typically, one board is available with
different memory options. i.e. 1GiB, 4GiB and so on. The actual RAM
chips can come from different manufacturers. So all all, I presume
there will be different RAM settings, i.e. different
k3-<soc>-ddr.dtsi. But I have to switch between the setting during
runtime because there will be only one boot image for that board.

> > Also, regarding the board variants, I'll probably need to choose
> > between multiple device trees. That is invisible to the user,
> > because u-boot will choose the correct DTB according a board
> > strapping, which btw. works really fine, see for example
> > (boards/kontron/sl28/spl.c:board_fit_config_name_match).
>
> Again, this is assuming that there is some HW blown register available=20
> for the board to use (or in our earlier K3 case, the EEPROM) but that is=
=20
> not necessarily true every time.

No, that is of course board dependent. It is just an example that
there are boards with more than one DTB.

Let's step back a bit. Right now, there is
  k3-<soc>-<board>-binman.dtsi
which is fine. But it seems, that TI is heading towards a common
  k3-<soc>-binman.dtsi
which is intended to be used by all the boards that are using that
particular SoC, correct me if I'm wrong here. Now the problem with
that is that you hardcode the FIT configuations which are really
board dependent and assume that there will be exactly one DTB per
board, i.e. your "#define SPL_BOARD_DTB" etc.

Thus, what I was trying to say is that you should split all the
board independent configuration (dt fragments) from the board
specific configuration.

And again, of course I could just ignore the k3-<soc>-binman.dtsi
and just use a suitable copy "k3-<soc>-<myboard>-binman.dtsi" for my
board. But as I said, I'm not sure, this is the way to go and I have
a slight feeling I will be asked to reuse the "k3-<soc>-binman.dtsi"
when I submit my board support.

> >=20
> > I don't think it makes much sense to hardcode your generic
> > *-binman.dtsi to just one FIT configuration. I'd rather see a split
> > between generic things which are shared across all boards and board
> > specifics, like the FIT configuration. I mean I could just copy all
>
> Correct me if I'm wrong, but my understanding is that you would want to=
=20
> add more FDT blobs in the *-binman.dtsi correct? That is still possible,=
=20
> adding another "fdt-1" and "conf-1" in the
>
> Something like this in your <board>-u-boot.dtsi,
>
> tispl {
> 	insert-template =3D <&ti_spl>;
> 	fit {
> 		images {
> 			fdt-1 {
> 				...
> 			};
> 		};
> 		configurations {
> 			conf-1 {
> 				...
> 			};
> 		};
> 	};
> };

Then you have the information at two places. One being the "#define
SPL_BOARD_DTB" stuff and the other one being in this additional DT
fragment. That is really confusing.

> provided you have the support to handle this multi-dtb FIT. But as far=20
> as reusing the k3-binman.dtsi and k3-<soc>-binman.dtsi goes; you should=
=20
> be able to do it.
>
> > the binman and tiboot3.bin and tispl.bin magic and put it into my
> > own "-u-boot.dtsi". But I'm not sure that will make things any
> > better.
> >=20
> > -michael

