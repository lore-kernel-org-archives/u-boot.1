Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE018CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 10:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1BFD88229;
	Wed,  3 Apr 2024 12:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Moag7xq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D7F98822A; Wed,  3 Apr 2024 12:35:19 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B549188225
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 12:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433AZ0xX057866;
 Wed, 3 Apr 2024 05:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712140500;
 bh=HCn/1spb/eSnt2dwRu2FIxqf/uLv+8wH/qhXPq0O4MU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Moag7xq2d9Vtgfds7j9H1bNbxun3g4ssienoo5sEt805+DpH1YPYKqur1RobNEEij
 1Wr9v5IYduOctxChATqSdPRfbOv+5CvJb8GSGUK3G9QKTbpDeLKelDmLvuUhcomFR3
 9qJYclBJM0m5Sl0Z4EJrr+WxcWehBkkEKzXOu1lk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433AZ0Yq118989
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 05:35:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 05:35:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 05:35:00 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433AYx20104429;
 Wed, 3 Apr 2024 05:34:59 -0500
Date: Wed, 3 Apr 2024 16:04:58 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Michael Walle <mwalle@kernel.org>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <bb@ti.com>, <nm@ti.com>, <sumit.garg@linaro.org>,
 <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
Message-ID: <20240403103458.mn2xkemiyymidipo@uda0497581>
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
 <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
 <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
 <D04LUAJJ6LC7.1JVGVTJ0UCMVR@kernel.org>
 <062f7c42-7088-4813-a2d6-ecb7ab22b4ba@ti.com>
 <D05D4N00QDKO.2PJ7VW4BNGQ11@kernel.org>
 <2e817727-524e-47e5-9f5e-2ee13d99a9bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e817727-524e-47e5-9f5e-2ee13d99a9bb@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Michael,

On 11:02-20240403, Neha Malcom Francis wrote:
> Hi Michael
> 
> Sorry for the late response.
> 
> On 28/03/24 17:26, Michael Walle wrote:
> > Hi,
> > 
> > On Thu Mar 28, 2024 at 12:18 PM CET, Neha Malcom Francis wrote:
> > > On 27-Mar-24 8:03 PM, Michael Walle wrote:
> > > > On Wed Mar 27, 2024 at 8:01 AM CET, Neha Malcom Francis wrote:
> > > > > On 26/03/24 19:18, Michael Walle wrote:
> > > > > > On Fri Mar 22, 2024 at 2:10 PM CET, Neha Malcom Francis wrote:
> > > > > > > Clean up templatized boot binaries for all K3 boards. This includes
> > > > > > > modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION and
> > > > > > > UBOOT_BOARD_DESCRIPTION from the files that include it to further reuse
> > > > > > > code.
> > > > > > > 
> > > > > > > All k3-<soc>-binman.dtsi will contain only templates. Only required boot
> > > > > > > binaries can be built from the templates in the boards' respective
> > > > > > > -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
> > > > > > > clear distinction between the SoC common stuff vs. what is additionally
> > > > > > > needed to boot up a specific board.
> > > > > > 
> > > > > > I appreciate the cleanup. But as far as I can see, a board might
> > > > > > only have one device tree. How would that work if the uboot proper
> > > > > > must support multiple device trees?
> > > > > > 
> > > > > 
> > > > >    From the discussions that took place in the mailing list [1] the consensus
> > > > > seems to be to not focus on multiple devicetree support as it leads to confusion
> > > > > for downstream users.
> > > > 
> > > > What are users in this regard? I don't think you'd confuse
> > > > developers.
> > > > 
> > > > Anyway, I'm planning on upstreaming a TI board which will have
> > > > different memory configurations and different variants of the board.
> > > 
> > > I am assuming you are reusing an existing TI SoC?
> > 
> > Not really yet. It's the j722s.
> > 
> > 
> > > > And on top of that, it will just be a base board and there will
> > > > likely be some carrier device trees (overlay? I'm not sure yet).
> > > > 
> > > > As far as I can tell, you've put the memory configuration into the
> > > > device tree, so I'll probably need to switch between them somehow.
> > > 
> > > The "k3-<soc>-ddr.dtsi" file will be present in your k3-<board>r5.dts
> > > which makes sense, the memory configuration depends on the board.
> > 
> 
> k3-<board>-ddr.dtsi* (e.g J721E EVM vs. SK boards consume different memory
> configurations.
> 
> > And one board might have multiple configuration depending on the
> > variant of the board. Typically, one board is available with
> > different memory options. i.e. 1GiB, 4GiB and so on. The actual RAM
> > chips can come from different manufacturers. So all all, I presume
> > there will be different RAM settings, i.e. different
> > k3-<soc>-ddr.dtsi. But I have to switch between the setting during
> > runtime because there will be only one boot image for that board.
> 
> This is a runtime dynamic DDR configuration support you are describing
> correct? This means you would be including all the supported memory option
> DTSIs in your k3-<board>-r5.dts correct and probably do some board magic
> code in the SPL DDR driver to choose the DTB. How is this affecting the
> packing of the final bootloader which will anyways pack the whole R5 DTB?
> > 
> > > > Also, regarding the board variants, I'll probably need to choose
> > > > between multiple device trees. That is invisible to the user,
> > > > because u-boot will choose the correct DTB according a board
> > > > strapping, which btw. works really fine, see for example
> > > > (boards/kontron/sl28/spl.c:board_fit_config_name_match).
> > > 
> > > Again, this is assuming that there is some HW blown register available
> > > for the board to use (or in our earlier K3 case, the EEPROM) but that is
> > > not necessarily true every time.
> > 
> > No, that is of course board dependent. It is just an example that
> > there are boards with more than one DTB.
> > 
> > Let's step back a bit. Right now, there is
> >    k3-<soc>-<board>-binman.dtsi
> > which is fine. But it seems, that TI is heading towards a common
> >    k3-<soc>-binman.dtsi
> > which is intended to be used by all the boards that are using that
> > particular SoC, correct me if I'm wrong here. Now the problem with
> > that is that you hardcode the FIT configuations which are really
> > board dependent and assume that there will be exactly one DTB per
> > board, i.e. your "#define SPL_BOARD_DTB" etc.
> > 
> 
> Correct, but as I mentioned in the earlier message, if your board supports
> more than 1 FIT configuration, you can easily extend the image and add more
> configurations.
> 
> > Thus, what I was trying to say is that you should split all the
> > board independent configuration (dt fragments) from the board
> > specific configuration.
> > 
> > And again, of course I could just ignore the k3-<soc>-binman.dtsi
> > and just use a suitable copy "k3-<soc>-<myboard>-binman.dtsi" for my
> > board. But as I said, I'm not sure, this is the way to go and I have
> > a slight feeling I will be asked to reuse the "k3-<soc>-binman.dtsi"
> > when I submit my board support.
> > 
> > > > 
> > > > I don't think it makes much sense to hardcode your generic
> > > > *-binman.dtsi to just one FIT configuration. I'd rather see a split
> > > > between generic things which are shared across all boards and board
> > > > specifics, like the FIT configuration. I mean I could just copy all
> > > 
> > > Correct me if I'm wrong, but my understanding is that you would want to
> > > add more FDT blobs in the *-binman.dtsi correct? That is still possible,
> > > adding another "fdt-1" and "conf-1" in the
> > > 
> > > Something like this in your <board>-u-boot.dtsi,
> > > 
> > > tispl {
> > > 	insert-template = <&ti_spl>;
> > > 	fit {
> > > 		images {
> > > 			fdt-1 {
> > > 				...
> > > 			};
> > > 		};
> > > 		configurations {
> > > 			conf-1 {
> > > 				...
> > > 			};
> > > 		};
> > > 	};
> > > };
> > 
> > Then you have the information at two places. One being the "#define
> > SPL_BOARD_DTB" stuff and the other one being in this additional DT
> > fragment. That is really confusing.
> > 
> 
> Hm... maybe. I personally don't see it as confusing. Even when picking
> between multiple DTBs, you will have a default DTB in any case, marking that
> as a macro wouldn't be confusing right? We'll need to get a third opinion on
> here then, I had seen your ping on IRC [1], putting it here for the others
> as well.
> 

As I see it, it's not like we are making the fdt-0 non overridable, you
can still override it in your configs to make it cleaner if you want for
your board template, I don't think that -

tispl {
 	insert-template = <&ti_spl>;
 	fit {
 		images {
 			fdt-0 {
				... 
			};
 			fdt-1 {
 				...
 			};
 		};
 		configurations {
			conf-0 {
				...
			};
 			conf-1 {
 				...
 			};
 		};
 	};
};

is not doable. It might be a bit duplicate but if I think about it but
we are not losing out on extending the templates for multiple DTBs even
with this design. I know it might not be what you want but I feel that
for single DTB it's really convenient with the macro stuff and we don't
have to override any of the other binman nodes.

Regards,
Manorit

> > > provided you have the support to handle this multi-dtb FIT. But as far
> > > as reusing the k3-binman.dtsi and k3-<soc>-binman.dtsi goes; you should
> > > be able to do it.
> > > 
> > > > the binman and tiboot3.bin and tispl.bin magic and put it into my
> > > > own "-u-boot.dtsi". But I'm not sure that will make things any
> > > > better.
> > > > 
> > > > -michael
> > 
> 
> [1] https://libera.irclog.whitequark.org/u-boot/2024-03-28
> 
> -- 
> Thanking You
> Neha Malcom Francis
