Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB634C5B56A
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 18:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27DC980EFE;
	Mon, 10 Aug 2026 18:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFJC8uIucaOS; Mon, 10 Aug 2026 18:16:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4119380EF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786385805;
	bh=z/5sRlB8g7eLYXLtXjUsLn45aDyshoSsEvsDrfAaA0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sobsMKEyxoQtnNXjocMkFKZ3pxNo69uoelaQiPRBjGkappK0Kobw3R1XNklxIHQeR
	 /MK9IflkajM+rFvBYGCIQWZJec7Nah2dKltgzP1LbivdBc9uyHB2svC03V6dYiWelQ
	 Zx0hAeDIS5oG1Y0e4o4Ljq/5Dkl4ByI5U2r5I9fdSUmu051z7oTo7hu7HEjwa+g8ov
	 o5w2UpwOrhvWM+beHLW3ybl72Be77xq6RD/i8YmskehcN0UdgCBi6CcYzqnmP+0QQ3
	 BrnyQfUQF4vqxbGLAJN3tiA7CahJMMa8CmhGIahs6BSqerpTn7abEAbh81ATCswiaA
	 yUtzLfzariGpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4119380EF5;
	Mon, 10 Aug 2026 18:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 727F710E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 18:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5896280EF5
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 18:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ME5llcSOwAIE for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 18:16:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6C7C680EFC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C7C680EFC
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C7C680EFC
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 18:16:42 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4a427e628a9so543934b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 11:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786385801; x=1786990601;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z/5sRlB8g7eLYXLtXjUsLn45aDyshoSsEvsDrfAaA0A=;
 b=nVBlVGTJiWjjNiSIO/n945nkmM7FflvhXkCn1/KDZpPCQE3/oMMPu7PVsYdx2KcqqJ
 v3LPAbnuY3h1xga1t/bg/vbv45K23pqGHrSpD9U45WtYONGdjmVKoGbo8xPT8WUipqo8
 EhhkLTo5G0olG3IVh8OPKe6tZCa/ZjcNvBAdMqbpYch1baKipex16PHk4pIh3ji/FmhM
 Y+9ouB07wITQqAmooZDUm6BP/peqWB2NFq4ruY/B4VvQTgYbJQcKEapwsmnneNRHiSTN
 GzyZF1dUebOLf+2zomhmzrhZadWhJ1WwmHhQ323og3ng/qca9VIBb8SLBwqmWBY73MTA
 IXgQ==
X-Gm-Message-State: AOJu0YwgIUhWf35qDnbBjD309Hkz7VZXVg5KDuCTNC+crH00mWdBOX2c
 vZhoFo1TI3Idw6UCX3Q8bzZsNpt35VeJGi/ogFQ/hBbbibxObIYKVYZJhWPt4EHA4Hk=
X-Gm-Gg: AR+sD123JvysvEsYo/u93CoM1VDvqTHqZyTRmjFS3pyHaxrtUQQK0OnHNLouyFSSdrl
 W8hxulEOxr4oYaxlbQy5c+JeBF8yB7jFn9c/wZ4cpzdT88s/HExEp9WWu6llC+OH9S5WIi48XdQ
 SoWeKtr/JFpVvlyEz9KtF/yrk7Ux61VXql+4neI9On1NOhn7Bfxc0P/kc9WvFBqDF4KH5z0r5kT
 F64EKMXESUiY1qRCuWwJiJo2OJQK95ek1R2Irczk6lvHk9qhhhWS2UWUrTdUAKYR7ufavU1pCF/
 BrF0UfgPvbsUyyIFl2LUFOq74X78EeDRAfINwKErWZvc7gVFIY0MR+v/7gouaTJpllvZYajuifc
 JNgw/MRg0js+VXwLHHlXw2rsAjt2e5xwJnn/YYgKc9LcvaqYZZWw6Io9tT97PvIZFpMQrstzR/r
 2W1P7frixYsyMf/DpH3FubTK5NMaB1lvBhwNeO7PNGMc/96u7RGlgP347FQZR2babLRX8Ys0Y/n
 e9aK4qjybAIGbLMqMmgi89swIVMIWgy2xYL/UedrGVWD5nVOk9oP4Sw9x+/VLD2jROfad/ZMlCT
 TngS/4hL4a0PSQCXRcwK
X-Received: by 2002:a05:6808:ec3:b0:496:301:36b9 with SMTP id
 5614622812f47-4b1e73077c5mr1628041b6e.0.1786385801191; 
 Mon, 10 Aug 2026 11:16:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b1af5e4fe8sm6925972b6e.12.2026.08.10.11.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:16:40 -0700 (PDT)
Date: Mon, 10 Aug 2026 12:16:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] boot: image-fdt: suppress spurious error on expected
 reservation failures
Message-ID: <20260810181637.GC1160436@bill-the-cat>
References: <20260810-suppress-fdt-res-error-v1-1-e9641eb0aadb@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tdaEb6PJw9yJqrWD"
Content-Disposition: inline
In-Reply-To: <20260810-suppress-fdt-res-error-v1-1-e9641eb0aadb@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786385801; x=1786990601;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z/5sRlB8g7eLYXLtXjUsLn45aDyshoSsEvsDrfAaA0A=;
 b=tP/69QQssPEY/JSlH+Qc2/Ik9iduAfY5ZOUCchQIarjVBsgsfFL7EHqKT8HOPW94W4
 6BjLRMKgkr2xgROhBscO4hpx77JQN4okto+S0gPKc1r4QG4i9GzZo0RpaWoBptgVIe8d
 JuBxAFNvjwCxFIbZiY7T1Cl8vCjG3509xEmX4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tP/69QQs
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--tdaEb6PJw9yJqrWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 03:04:53PM +0530, Balaji Selvanathan wrote:

> Before commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb
> reservations"), boot_fdt_handle_region() filtered out -EEXIST and
> -EINVAL when reserving an FDT memory region, treating both as benign.
> That commit added the free/reserve toggle but dropped the filter, so
> these now print as errors.
>=20
> -EINVAL in particular is expected: when a reserved-memory region falls
> outside the available memory LMB knows about, _lmb_alloc_addr() returns
> -EINVAL. This happens when a carve-out described in the kernel DT lies
> in a range the platform does not report as usable RAM, so its
> reservation fails with -EINVAL and prints:
>=20
>   ERROR: reserving fdt memory region failed (addr=3D91a80000 size=3D80000=
 flags=3D2): -22
>=20
> on an otherwise clean boot. The region is still described in the
> kernel DT and Linux reserves it itself, so U-Boot failing to track it
> in LMB is harmless.
>=20
> Restore the old filter, scoped to the reserve path: print the error
> only when freeing, or when a reservation fails with something other
> than -EEXIST or -EINVAL. The "free ||" guard keeps free-path failures
> always visible.
>=20
> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

This is the same as:
https://patchwork.ozlabs.org/project/uboot/patch/20260627204851.1151419-1-j=
onas@kwiboo.se/
So I've added people from that thread to this one.

It seems to me like the last message there wasn't quite everyone being
in agreement on the next step, so, what is required next at this point?
This is clearly a problem in some cases, in terms of "scary" message to
the user which isn't meaningful.

--=20
Tom

--tdaEb6PJw9yJqrWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanoVggAKCRAr4qD1Cr/k
Cg3pAQDswrG+YbiQCbqqGwnyI077pcNUozJ6yN7ZSdVyftIukAD/cU4LNfEPRaF6
LjjrahAj1rJF5KxqF2tUoQNS46PyqgU=
=eznE
-----END PGP SIGNATURE-----

--tdaEb6PJw9yJqrWD--
