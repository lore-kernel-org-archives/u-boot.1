Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19B606A336
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RONmY8Nr;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FNiv/jVh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1357405DC;
	Tue, 24 Nov 2026 14:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7E-p4zXdzmaE; Tue, 24 Nov 2026 14:29:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D5B06405AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795530571;
	b=Ys+crBUjpECBMM1XkBmN76AnCQXgWW7g7pLdXQmD44dgpfb0xOWrCYe2IfJoAhz0kHK0
	 N7ifqROEHHcy58ZGcy1Wm1V7H0vAAjFBq5T2r0peXYM2iIubVPqTsW8Xu9av1TMiZ/3wW
	 13hGSqT5odVWFHzY3ltq8MWJBdYFTm22S9mku8k5wwuULeh+R0zuL6E9mxSZP13EpqNBD
	 UXctjWMUZ1+x3/3TZy0NCjE+1vTsilzUQolh7DozkQY9XNcL6Q0ivnIEJNh84xHawWShj
	 cwNEwCGuGmtsRqUqMZi1V0DpJVA98ocNKYJn9TrahHrWv/PYXiMKH6fSwHV6Xx6K4jA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795530571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CWHnU6fhKwo8p6uF/r4rbO1RZPpBeFXmF/4urUS40lI=;
	b=pAyHr3xWx98fRhmME3/upVguEcX310OZTSaRQiOMA+uVJcTt7U9LdwdpoHNC4/Bh18zV
	 GNUXGAyQiDgdXsaXjePmqx6ouhWjznNHQINzrRfSHBsl5dmEQIfDsUAAjJo0172K4DFXm
	 mDoyp10VPr4KLhFLHSUnbpZGKI5n72U75rNL8T0tIQw2M9PzrTpfvGGwKar8Gy6YULQvm
	 cUVdeSvxqyDWdtmjuynoQgEXp7oY6nT7tsLk/vMTasNM3DwlItitT2p/bE/svVJpdGNCd
	 j7RN2ZSJwoDZJxeymlwXMlpyyIfnxgi2hQ4quo4kdgLgONN1G2mbWoUYmKA/zoGcmlg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="FNiv/jVh";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795530571;
	bh=CWHnU6fhKwo8p6uF/r4rbO1RZPpBeFXmF/4urUS40lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RONmY8NrSj5Lu5JiQhNFtDxEGCm51Y8/NrAo2v6yQ7HxDfoKJcx6gWGSfpVU6xfCf
	 SYznjZPS8sRUcVMlmvfmE73LQAD5WTzQwFb+fUbwlo1/2zqxLjnps51/fkqf49azWe
	 1cO+rWH/uNNt2Gn5bzesU1loJMJ80FysbbmYdPB2wTebEiVBb26YZsaDmnmtmpbSbw
	 wqsV67c3grwqhpmtJehKy34tCuj8W/le0Sb1tR145yj98Nfk34Zw+eZ77kNsXzbeuY
	 0Eamu198JErnnVmAPyXsBcU9kORMMSP1tO+YQtKHNopOGiFNzZdfIxZa9foIE3LUIr
	 39gPaDSj0vFCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5B06405AE;
	Tue, 24 Nov 2026 14:29:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A5221C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F7B6405AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id btyFbV-hD9-1 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 14:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8DAB405AA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=FNiv/jVh
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8DAB405AA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:29:27 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-86103aaac12so3060130a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795530566; x=1796135366;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CWHnU6fhKwo8p6uF/r4rbO1RZPpBeFXmF/4urUS40lI=;
 b=FNiv/jVhESzF/ZwisH5JB8+NM0OrL+y7y6giAUfIBswnhxqBlUUsYivpxCS92FodB7
 kkVWUlGdGnLXH8AOarQy3M2CifP7xRHgdHokiJKy8WmO7oQlyt+CbgXQ4N/CByLS0aKD
 F/y075cfZqPomUD+loaSe7xI3FxsqK74K1d5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530566; x=1796135366;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CWHnU6fhKwo8p6uF/r4rbO1RZPpBeFXmF/4urUS40lI=;
 b=rUqkr9lV4Rg07tXhqyk97kz3uXEyi0gZtl1Pgq2KuP1z5WJa26BjUO3Lkz8HhXE7Rm
 B/S/tDhR3gTrhTAG4e3tlUMFEfLwDiSKnbMIIzvGKBx/uIL7ryt4GmsandmESR1tryaC
 OTXmZNsCE0jvi7FTw3dMhaPPOGI7Hl86+aZuGsEKgPv46tvsB7Bli70qY9f7s7YGxQco
 cbdyvumYhir9cqlqrztufXUNVU871CGSWQMsYDiYf7l3cwoYoGpvMxO5Ud/53s29kBCj
 OnH1f44nz3nNZAvzhRm5g6slvBfqTfrFeGPRJBDB/YYQJ2//J6zoFcEuDBH6Ws/bs/Ki
 I+xQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHD7BhsKoCB4ERgQaEdPDn/0xs9/zYCQQx5LXFKAqZsT4otHsJLcod80I0Qfhcn8US1+LorPtE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+NKT4FFxRXVxACBP348qGeARLJa96gGnS+ndomEga3WxR+6wdM
 7x7rR9ZF2b4ylK7UnnRD27x7Gu1DQTsAUwFcVBAqn3HeS13ftvGALZRwLXB3bbwU31c=
X-Gm-Gg: AZFdTZd7MwMix9SdGw4aK6Kn/eapkE+uslGDc5CkDP+U34hZm7AUYH5PdsUluTFEyX9
 ApGhNei5NCRMTO6QVOQrCzh0SOe6ZI9hr/4XLvffMPd8R6PFMG52A7YKCxiMdCHXQiPMO5Y4kIg
 FeRVJDKDZHo6DFtQZay35Rv0ISKdurffHS2Hc/rmaNIOg5hOFXusTy/dZO0vOfzNKIA7ZPdxdvX
 H7k9eeHJBqM3XVUK8H18ayEDPTcLWW/4aFxO5AJity1EwiAjEiI6t/VFf15Z2d3InmRyr+5pGkE
 Rl74TZSkWM3LFnqEO+YYMpu96mAB6sQlQqk+jasKFtQ45Q5Mty+kfqFx/xM+1gmpwLaJbkatn5u
 v9a+zToTo6hbivblPTICuN1Uw0NRbE4VcXSjaK+xgAB9rZRiLjnb0/KH11iPPqwdJtLF94W4aJZ
 w+W0UObqMFtYhMqsuXu1oqd/lAYUYbdHRxd6rG3jmUbXgr5dFoLQAaZ6WfQSXGqbh25nHlKGIru
 MH3C+MffJIPcq8RfdIb/wE82ZSEW2M1OJIU+xtjtTb+MafqjU3XymzgKK6CcxjIUczD5BfVa/WF
 otASDYOG1QC/Cxn9ZEo4+C949QkevrTdhVpYIYWrqlXSwRCKa5g0ur7+BFupeQN+UdyWfXjqguD
 JRy8PpsAGDq9qAgahfFCTPMj3rNVGKTvrNoK/vwDMVwoUuABYZeppSTS2CliknJ1yEkszTJujBC
 Fvvygm85LucZ8mxLq/JIAFOBy2TglxbEg=
X-Received: by 2002:a05:6830:4109:b0:861:5d56:bd27 with SMTP id
 46e09a7af769-863155f228dmr11119851a34.7.1795530566406; 
 Tue, 24 Nov 2026 06:29:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f6da9sm11185150a34.15.2026.11.24.06.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:29:25 -0800 (PST)
Date: Tue, 24 Nov 2026 08:29:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 mkorpershoek@kernel.org, love.kumar@amd.com,
 quentin.schulz@cherry.de, s-vadapalli@ti.com
Subject: Re: [PATCH v12 00/31] usb: dwc3: part 2, make the resynced code work
Message-ID: <20261124142923.GR3176972@bill-the-cat>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
 <79ec1874-3d7b-417e-87eb-efabafff9b75@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FIhciIoe/rxcH1Ed"
Content-Disposition: inline
In-Reply-To: <79ec1874-3d7b-417e-87eb-efabafff9b75@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--FIhciIoe/rxcH1Ed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 07:23:56PM +0100, Marek Vasut wrote:
> On 11/21/26 12:53 PM, Anders Roxell wrote:
> > Hi,
> >=20
> > This is part two of two. It applies on top of part one [1], which resets
> > the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
> > the build for every board that enables DWC3. This part adds back the
> > U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
> > builds and the gadget works again. It builds on Jerome's work [2].
> >=20
> > The two parts have to go in together, on top of next (794978160561).
> > Part one did not change, so I do not resend it. The v10 patches [1]
> > still apply on next.
> >=20
> > The resynced epautoconf matches endpoints on their caps field instead of
> > on their name. Five UDC drivers never filled that in, so each one gets a
> > patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-n=
ew
> > and mtu3. With those and dwc2, every UDC driver in the tree sets caps.
> >=20
> > Build tested one board per driver: every DWC3 glue layer in the tree,
> > dwc3 on riscv (spacemit_k1), RK3588 and RK3399, dwc2 with and without
> > DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc with SPL SDP, musb-new
> > on sunxi and in the am335x_evm SPL, and mtu3. 24 boards, no warnings.
> >=20
> > Ilias found a few bisect gaps, so I built eight of the boards at every
> > patch. Gadget configs build again from patch 21, the other UDC drivers
> > from their own fixup patch.
> >=20
> > Tested on hardware with v10, per vendor:
> >=20
> > - AMD/Xilinx: Love tested and sent a Tested-by.
> > - TI: DFU and ums on BeagleBoard-X15 (me), and on AM62p and BeaglePlay
> >    (Anshul).
> > - NXP: ci_udc with ums on an i.MX93 board (me).
> > - Amlogic: gadget and host on Khadas VIM3 (Mattijs).
> > - Rockchip: host on RK3399 Puma, same as master (Quentin). RK3588
> >    Tiger had two regressions, see below.
> >=20
> > Tested on hardware with v11:
> >=20
> > - NXP: ci_udc with ums on i.MX93, chainloaded from the vendor U-Boot.
> >    Three ums rounds, the host read 64 MiB each time. It needs usbotg1 in
> >    peripheral mode.
> > - TI: dwc3 ums on BeagleBoard-X15, the host enumerates it at high
> >    speed. That is where I found the event buffer bug in patch 16.
> > - Rockchip: host on RK3399 Puma and RK3588 Tiger (Quentin). The two
> >    Tiger regressions from v10 are gone, and he sent a Tested-by:
> >=20
> >    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma u=
sbdrd_dwc3_1
> >    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger =
usb_host1_xhci + usb_host2_xhci
> > - Rockchip: host and gadget on RK3576, a Flipper One and an RK3576 EVB1
> >    (Alexey). No regressions against master, and he sent a Tested-by:
> >=20
> >    Tested-by: Alexey Charkov <alchark@flipper.net> # Rockchip RK3576
> >=20
> > v12 only has the review fixes below, and they do not change what the
> > code does. So the v11 hardware tests above still hold. I also ran
> > dwc3 ums on BeagleBoard-X15 with v12. The host enumerates it at high
> > speed, and what it reads back matches what U-Boot wrote to the card.
> > ci_udc ums on i.MX93, chainloaded like for v11, works too.
> >=20
> > One thing is still open.
> >=20
> > Anshul sees a single "unknown endpoint event 0" line on AM62p during
> > enumeration. I got the same line on the X15 from the event buffer bug
> > that patch 16 fixes. I think it is the same on AM62p, but I have not
> > tested it.
> >=20
> > The branch has both parts [3].
> >=20
> > [1] part one, subject: [PATCH v10 00/63] usb: dwc3: part 1, reset and
> >      import from Linux v6.16
> > [2] Jerome's adaptation work: https://lore.kernel.org/all/2025112115381=
2.2076440-1-jerome.forissier@linaro.org/
> > [3] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v12
> > [4] v11 part two: https://lore.kernel.org/u-boot/20261107072224.3492260=
-1-anders.roxell@linaro.org/
> I tried to pick them up for next, but the build failed due to oversize am=
62:
>=20
> https://git.u-boot-project.org/u-boot/custodians/u-boot-usb/-/jobs/156214

I see two link failures, am65x_evm_r5_usbdfu which might be an issue
with SPL Kconfig / Makefile logic, and imx6dl_mamoj which I don't know.

--=20
Tom

--FIhciIoe/rxcH1Ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawWfPwAKCRAr4qD1Cr/k
CgacAQC49YmVd5hcUEDhikSmbeWPZdjuFWUO8+LOZBLCEIEmlQEAp4lD32+acNfh
e1nuQOmFXZzPxzkhwd/K2NJFRTS7GAk=
=ybMV
-----END PGP SIGNATURE-----

--FIhciIoe/rxcH1Ed--
