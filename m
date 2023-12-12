Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48005C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 15:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A55E387495;
	Tue, 12 Dec 2023 16:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jVFy6Y2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12CF86C67; Tue, 12 Dec 2023 16:43:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0828746C;
 Tue, 12 Dec 2023 16:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702395795; x=1703000595; i=xypron.glpk@gmx.de;
 bh=hSp8whzAE77P2LjJkJ01eRKqR1YV8zRuwJsQ3exo0G0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=jVFy6Y2jE1wLgVQX3/TlVnfGnVkeMLZx9C5X9KJD6PWcieeMqEkPHDwcXCrcx9C/
 EEsHJK2UTXNJ0fc5o/t+GhXNYfbkWMmb+MzBYQ39NBAhTCnDoSQe227O3rMhBemPv
 Aa8WRJDLUAh28nzVAZ4rDVWnOzuC5W0gJvJ2ytEvH5BpMEPCnCq4Ss9yOm9y3GFyv
 VF6qhmkvttTX5zqREOJzubbr3cxbLwNqL3Y6i9OUglgHQErbEhastJbSSZLveE5GI
 XTtqFRq5mHpgtQVRZF1IcWdnKBEwuzFA0PGMTJJSPHngYl+1YbWbO9oqv43+hxcnv
 Ob3iQbw9GYD6CQL1Ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1ro3Yi3yFC-00b2Js; Tue, 12
 Dec 2023 16:43:15 +0100
Message-ID: <51c47679-32d8-45a7-9d9a-4c534ed98c32@gmx.de>
Date: Tue, 12 Dec 2023 16:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal: FIT support for extension boards / overlays
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 Andrew Davis <afd@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wD6sgO5TdpL9eS2zKxVZGeWQzNDIUJ8yKn6bRqAjZQSy4T+JR9Q
 kDvv2R3rtujoNnSUCo+U3fMhbIt3oH0g3Lx6T5noa5vNXWatO+/cfqVIhH7GI7o+t+MNPFG
 WmrtoRukDGevVlyuJ66nlBVlwWnxT317ULKPTxAACwGmQZeL7w5PVhGQPppt7LDEDOxVDke
 a8dUWnNjInA7zVUAXER6Q==
UI-OutboundReport: notjunk:1;M01:P0:HjmHjq5w2FU=;8Yo2TTdNAp/uAPRtn696iQfv9Ml
 dWRv3G3YFnOBuxY8kuPuJa6LlfH58gf5eWGBBk1Y9l+mI2K9BYDwXTAsURGbbdyK2zgzF0IUh
 4xNFU41WZyjwZmLk0b1vaFeU/Ya9llK4ae4kbzYEKU14uisOawMABl5iqCK6X6aSWevpCPnsP
 Qf71t/mokuMsQ10miAMI6uxIX2+9z8PNwlmVE1+mBnGkPpuQ6XexfS3NYqAdA4hF9JznUjvKR
 s69ZRik/VazpO04ZZoOHDeEHYEAswiYEY1lc2+DFPspijzly36fOoBGIv0BmtSsMweLbVWps6
 M6IsTq+EsZP5y6x0kjMFm516PF6D+y1nFRwnbjHqWYGWGxNx60dW7wYANRgEDQ6ZOEQspY4Ss
 sgydD0FhvYidso3cze+jV9d4qVSRAySBpAUBkVbogxu42ZQAy7MdWSQvGHZOszg2xo6MicuPd
 NlxQvz0ZqNLjZeIWngTojpLL1LGMgbvdxQxPhN/o4doL89+dIPJqeq16r8u5T1K6GZwYzGt01
 Yd3IE0KXo38lkVjHvMx8MBoI098g+/8LEocQKt9oWdw8iwymgOqg7Z2JzndCGvgh4LDQopfnh
 Viqb6SqTlwE67tItQvWgN4oPzwZ7JVZpcWBJkigPQvQhvysRvq6YK0M27wK9oEoTZ0kSRZF8L
 go+JdN25S7Cg7pN/4VsoGwebk64lJCID7YyeW4aZzC5Owpj3iBaVABgVB0XhAQB6tEdJiCqXg
 rezCyd/gvXCW23c8zOexfCHdMfzlxXmYHO8Qpfc171Jts3zUexka7mqke73Tfe3h76uYqDpaV
 H3zFYeQ9hRVTayH46+ZC7P/r6bWiSqgvgevI6TykYXqjMR162BvXQEHSfiE4pFnxPLzfMT0uA
 nptnyJGAbhjdvUTVia91jUV8fP/LLffMaUXQBBxn55gYA3P6GQzyJvrPpZ7jjplNL/6IeWnSK
 pTPztJGQAB17DfM+EVyhjA/XjEQ=
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

On 12.12.23 15:05, Simon Glass wrote:
> Hi,
>
> The devicetree files for a board can be quite large, perhaps around
> 60KB. To boot on any supported board, many of them need to be
> provided, typically hundreds.
>
> All boards for a particular SoC share common parts.  It would be
> helpful to use overlays for common pieces, to reduce the overall size.
>
> Some boards have extension add-ons which have their own devicetree
> overlays. It would be helpful to know which ones should be applied for
> a particular extension.
>
> I propose implementing extensions in FIT. This has a new '/extensions'
> node, so you can specify what extensions are available for each FIT
> configuration.
>
> For example:
>
> / {
>    images {
>      kernel {
>        // common kernel
>      };
>
>      fdt-1 {
>        // FDT for board1
>      };
>
>      fdto-1 {
>        // FDT overlay
>      };
>
>      fdto-2 {
>        // FDT overlay
>      };
>
>      fdto-3 {
>        // FDT overlay
>      };
>    };
>
>    configurations {
>      conf-1 {
>          compatible =3D ...
>          fdt =3D "fdt-1";
>          extensions =3D "ext1", "ext-2";

Shouldn't there be braces around the item list?

How do you specify optional and required but otherwise unrelated
extensions for a configuration?

>      };
>    };
>
>    extensions {
>      ext-1 {
>          fdto =3D "fdto-1";   // FDT overlay for this 'cape' or 'hat'
>          kernel =3D "kernel-1";
>          compatible =3D "vendor,combined-device1";
>          extensions =3D "ext-3";
>      };
>
>      ext-2 {
>          fdto =3D "fdto-2";   // fdt overlay for this 'cape'
>          compatible =3D "vendor,device2";
>      };
>
>      ext-3 {
>          fdto =3D "fdto-3";
>          compatible =3D "vendor,device3";
>      };
>    };
> };
>
> So FIT configurations have a list of supported extensions. The
> extensions are hierarchical so that you can have ext-1 which can
> optionally have ext-2 as well. This allows boards to share a common

ext2 seems not to be related to ext-3. Do you mean ext-3 optionally
extending ext-1? How would you specify that ext-n is required for ext-m
to work?

The sequence of applying overlays may make a difference. I cannot see
that your current suggestion defines a sequence in which the overlays
are applied.

> SoC to add in overlays as needed by their board. It also allows common
> 'capes' or 'hats' to be specified only once and used by a group of
> boards which share the same interface.
>
> Within U-Boot, extensions actually present are declared by a sysinfo
> driver for the board, with new methods:
>
> get_compat() - determine the compatible strings for the current platform
> get_ext() - get a list of compatible strings for extensions which are
> actually present

Do you expect U-Boot to have code that injects device-tree fragments
with a compatible string into the control FDT after discovering add-ons?

Why can't we simply write the compatible constraint into the overlay
definition (fdto-#) and enumerate the overlays in the configuration?

On some busses detection is problematic. Two alternative add-ons may use
the same SPI address but need different FDT overlays.

Best regards

Heinrich


>
> The extension compatible-strings are used to select the correct things
> from the FIT, apply the overlays and produce the final DT.
>
> To make this simpler for the common case (without extensions), we can
> allow multiple FDT images for a configuration, with the first one
> being the base SoC .dtb and the others being the .dtbo overlay(s) for
> the board:
>
> confi-1 {
>          compatible =3D ...
>          fdt =3D "fdt-1", "fdto-1";
> };
>
> Comments welcome.
>
> Regards,
> Simon

