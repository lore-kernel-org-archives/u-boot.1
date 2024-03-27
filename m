Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEA9C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52E18809B;
	Wed, 27 Mar 2024 15:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DEFF8809B; Wed, 27 Mar 2024 15:33:31 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D787880B9
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 5A6CD5E8;
 Wed, 27 Mar 2024 15:33:27 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Mar 2024 15:33:26 +0100
Message-Id: <D04LUAJJ6LC7.1JVGVTJ0UCMVR@kernel.org>
To: "Neha Malcom Francis" <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <bb@ti.com>, <nm@ti.com>, <sumit.garg@linaro.org>
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
Cc: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
 <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
 <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
In-Reply-To: <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
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

On Wed Mar 27, 2024 at 8:01 AM CET, Neha Malcom Francis wrote:
> On 26/03/24 19:18, Michael Walle wrote:
> > On Fri Mar 22, 2024 at 2:10 PM CET, Neha Malcom Francis wrote:
> >> Clean up templatized boot binaries for all K3 boards. This includes
> >> modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION a=
nd
> >> UBOOT_BOARD_DESCRIPTION from the files that include it to further reus=
e
> >> code.
> >>
> >> All k3-<soc>-binman.dtsi will contain only templates. Only required bo=
ot
> >> binaries can be built from the templates in the boards' respective
> >> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allow=
s
> >> clear distinction between the SoC common stuff vs. what is additionall=
y
> >> needed to boot up a specific board.
> >=20
> > I appreciate the cleanup. But as far as I can see, a board might
> > only have one device tree. How would that work if the uboot proper
> > must support multiple device trees?
> >=20
>
>  From the discussions that took place in the mailing list [1] the consens=
us=20
> seems to be to not focus on multiple devicetree support as it leads to co=
nfusion=20
> for downstream users.

What are users in this regard? I don't think you'd confuse
developers.

Anyway, I'm planning on upstreaming a TI board which will have
different memory configurations and different variants of the board.
And on top of that, it will just be a base board and there will
likely be some carrier device trees (overlay? I'm not sure yet).

As far as I can tell, you've put the memory configuration into the
device tree, so I'll probably need to switch between them somehow.
Also, regarding the board variants, I'll probably need to choose
between multiple device trees. That is invisible to the user,
because u-boot will choose the correct DTB according a board
strapping, which btw. works really fine, see for example
(boards/kontron/sl28/spl.c:board_fit_config_name_match).

I don't think it makes much sense to hardcode your generic
*-binman.dtsi to just one FIT configuration. I'd rather see a split
between generic things which are shared across all boards and board
specifics, like the FIT configuration. I mean I could just copy all
the binman and tiboot3.bin and tispl.bin magic and put it into my
own "-u-boot.dtsi". But I'm not sure that will make things any
better.

-michael
