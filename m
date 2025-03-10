Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8FCC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 18:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A79580107;
	Mon, 10 Mar 2025 19:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YN3KLIJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89BDF80F77; Mon, 10 Mar 2025 19:33:17 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D0D800D7
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 19:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 08CEF3FCCB
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741631557;
 bh=aUqL9LLjmBAPdUdqknAdxfUbT+AMaZ4CP44GTCggekA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=YN3KLIJ/rJHGxyuJnuw0zk8wcIABHqiYbuZ2N8sQcPy5QnRWIti/1/2POV/zPOIMl
 zDOopwIZc146pfUGBxTbUQtT2vauGYjzsS8dZAlVAjw38o6qVfh55+Ks1YihF9cexh
 92PqpLWg9IHTjk9tL7PwFiFqVj1Rx0R1E5o9CilSf3WyBwDoud7ph1Czg7/0a7wefa
 tuQ0zYEIbak2Nrrd1TQW2pHYa73MGdJS6T+B6FxY0XUpNvaGuSYThwk7FDNHBg0TOW
 RqOax7m6ed5U4H9bpFH+EM3A4XcuGvG38j8y0JAU1Qf/Iei11BR4iawIZ1RGvAF2GX
 q4nas6mkVdu2g==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac254e4b515so384991266b.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 11:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741631534; x=1742236334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aUqL9LLjmBAPdUdqknAdxfUbT+AMaZ4CP44GTCggekA=;
 b=dI8rrem+vFYEMD8h5b6Uh6B1VKj/Pibzfms9Ek5SaKAP7U4oHj9572yJ2DUZe0wfYF
 eaaf7e+izHiCZT17kx8srinKjXiPkrp2gxZq7w04IR+T6+Zlvp61WMafvVZrpaSVxVKn
 1HvvIk07ebCRydKSsKim9vP5RTrZyLVMYIoEm4DkY7h6vMmrs2CDGG36wy8jbaqIByoT
 eDYs2Dc/fM3u3yFgzWJ8hrs/RelVX8avp3fIG396/pPiYrXGGUsS1jiQyvbKSPJa+Bx9
 eq6cUm8ICzPLTVceWZoXYw1Vg4mdYxZs+NirMr+8rDUOufm3RNAwJS6TAW7S3v6DMAbT
 YRRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSDjE2jlGPxwxO/ZrUA289Q4kDz4cNbyOlvJFZZ2QZIDb7cz16qUaKBDC7o1xG+IKNjro+x2s=@lists.denx.de
X-Gm-Message-State: AOJu0YwEvo3p0ltm7572Cdo3+WVKlwVB1aP+Fn8KPvONRe5v4yl6Qvdy
 1Y3VWvgzJUBESg4RJ+kQBSrR8ScYU4jBGUm8NZXcG41cMIUi8taUBDqAveAf/qS/shuUcXGHNDH
 gFw+UGEAE0VFEvwPZVXcZePcZWCWj7n5A62UA/27o87u1rPJB3zpBoIERxeCPJOUeCjQ=
X-Gm-Gg: ASbGncsFqBzy6kwn8LoPJAdLCDzwbGGkdh/ixlwLvPLVH9jC81/Qmz2Ra088EMgx7xd
 OPl+L1wlEY9Uzw5yV7NjfE6lTN70aerBvnhcPAMp27gpkqV1UALodaj1Q0ACopOGNDBhL/PEFHW
 hS0Q3XfYKl9FEPoXqMBdPsj5kAL1DtQj1HtOA8u2iYUgJR8y64v+YVEfmrzeUbH8/vA1SRzVl7T
 JuQXAbPhsPgTcqczywSuTdBn4jxLj2+xEyOz8QN5NJVu9x/vo4qtll4ra9tOI34GF925Hh97xUt
 xxqxbEmqEUeUSyBghMGpnl9fgyw5AV5TOJaDIGzqgR7DPRfRq7vvPvBOXIDCatj602hfAXwIWGP
 yaEFbUJlH0p2a
X-Received: by 2002:a17:907:1983:b0:abf:6a26:3d91 with SMTP id
 a640c23a62f3a-ac2ba4a34c4mr61860066b.10.1741631534548; 
 Mon, 10 Mar 2025 11:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYxSMQkdaYDe3EPpAuk/LPjhOxmq908v2cy3zAPxc06EX/m+AG8fSFXekVudAlsc23ZmUF7w==
X-Received: by 2002:a17:907:1983:b0:abf:6a26:3d91 with SMTP id
 a640c23a62f3a-ac2ba4a34c4mr61855466b.10.1741631534023; 
 Mon, 10 Mar 2025 11:32:14 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac287653c7esm353912066b.84.2025.03.10.11.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 11:32:13 -0700 (PDT)
Message-ID: <a2fe2373-08a9-483a-bdd9-9158f739898a@canonical.com>
Date: Mon, 10 Mar 2025 19:32:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: miiphybb: Update documentation
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250308203625.1317615-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250308203625.1317615-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 08.03.25 21:36, Marek Vasut wrote:
> Update the miiphybb documentation to match current implementation.
> The static struct bb_miiphy_bus bb_miiphy_buses[] array is removed.
> The example is updated to match current Renesas RAVB driver, which
> is one of the miiphybb users.
> 
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jim Liu <jim.t90615@gmail.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Michael Chang <zhang971090220@gmail.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Parvathi Bhogaraju <pbhogaraju@microsoft.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: - Fix language bugs
>      - Add RB from Paul
> ---
>   doc/README.bitbangMII | 66 ++++++++++++++++++++++++++++++-------------

It would be preferable to move this document into doc/devel/ as .rst file.

>   1 file changed, 47 insertions(+), 19 deletions(-)
> 
> diff --git a/doc/README.bitbangMII b/doc/README.bitbangMII
> index 05ab20376f3..78b4ef880cb 100644
> --- a/doc/README.bitbangMII
> +++ b/doc/README.bitbangMII
> @@ -1,39 +1,67 @@
> -This patch rewrites the miiphybb ( Bit-banged MII bus driver ) in order to
> -support an arbitrary number of mii buses. This feature is useful when your
> -board uses different mii buses for different phys and all (or a part) of these
> -buses are implemented via bit-banging mode.
> +The miiphybb ( Bit-banged MII bus driver ) supports an arbitrary number of
> +MII buses. This feature is useful when a driver uses different MII buses for
> +different PHYs and all (or a part) of these buses are implemented via
> +bit-banging mode.
>   
>   The driver requires that the following macros should be defined into the board

CONFIG_BITBANGMII=y enables the miiphybb driver.

>   configuration file:
>   
>   CONFIG_BITBANGMII	- Enable the miiphybb driver
>   
> -The board code needs to fill the bb_miiphy_buses[] array with a record for
> -each required bus and declare the bb_miiphy_buses_num variable with the
> -number of mii buses. The record (struct bb_miiphy_bus) has the following
> +The driver code needs to allocate a regular MDIO device using mdio_alloc()
> +and assign .read and .write accessors which wrap bb_miiphy_read() and
> +bb_miiphy_write() functions respectively. The bb_miiphy_read() and
> +bb_miiphy_write() functions take a pointer to a callback structure,
> +struct bb_miiphy_bus_ops. The struct bb_miiphy_bus_ops has the following
>   fields/callbacks (see miiphy.h for details):

Please, add the description of struct bb_miiphy_bus_op miiphy.h and add 
the file to the API documentation. You could also put the example and 
the programming guidance there.

Best regards

Heinrich

>   
> -char name[]	       - The symbolic name that must be equal to the MII bus
> -			 registered name
> -int (*init)()	       - Initialization function called at startup time (just
> -			 before the Ethernet initialization)
>   int (*mdio_active)()   - Activate the MDIO pin as output
>   int (*mdio_tristate)() - Activate the MDIO pin as input/tristate pin
>   int (*set_mdio)()      - Write the MDIO pin
>   int (*get_mdio)()      - Read the MDIO pin
>   int (*set_mdc)()       - Write the MDC pin
>   int (*delay)()	       - Delay function
> -void *priv	       - Private data used by board specific code
>   
> -The board code will look like:
> +The driver code will look like:
>   
> -struct bb_miiphy_bus bb_miiphy_buses[] = {
> - { .name = "miibus#1", .init = b1_init, .mdio_active = b1_mdio_active, ... },
> - { .name = "miibus#2", .init = b2_init, .mdio_active = b2_mdio_active, ... },
> - ...
> +static const struct bb_miiphy_bus_ops ravb_bb_miiphy_bus_ops = {
> +	.mdio_active	= ravb_bb_mdio_active,
> +	.mdio_tristate	= ravb_bb_mdio_tristate,
> +	.set_mdio	= ravb_bb_set_mdio,
> +	.get_mdio	= ravb_bb_get_mdio,
> +	.set_mdc	= ravb_bb_set_mdc,
> +	.delay		= ravb_bb_delay,
>   };
> -int bb_miiphy_buses_num = sizeof(bb_miiphy_buses) /
> -			  sizeof(bb_miiphy_buses[0]);
> +
> +static int ravb_bb_miiphy_read(struct mii_dev *miidev, int addr,
> +			       int devad, int reg)
> +{
> +	return bb_miiphy_read(miidev, &ravb_bb_miiphy_bus_ops,
> +			      addr, devad, reg);
> +}
> +
> +static int ravb_bb_miiphy_write(struct mii_dev *miidev, int addr,
> +				int devad, int reg, u16 value)
> +{
> +	return bb_miiphy_write(miidev, &ravb_bb_miiphy_bus_ops,
> +			       addr, devad, reg, value);
> +}
> +
> +static int ravb_probe(struct udevice *dev)
> +{
> +	struct mii_dev *mdiodev;
> +...
> +	mdiodev = mdio_alloc();
> +	if (!mdiodev)
> +		return -ENOMEM;
> +
> +	mdiodev->read = ravb_bb_miiphy_read;
> +	mdiodev->write = ravb_bb_miiphy_write;
> +	mdiodev->priv = eth;
> +	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
> +
> +	ret = mdio_register(mdiodev);
> +...
>   
>   2009 Industrie Dial Face S.p.A.
>        Luigi 'Comio' Mantellini <luigi.mantellini@idf-hit.com>

