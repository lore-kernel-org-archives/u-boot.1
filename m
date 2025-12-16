Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056C8D5E370
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 14:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33587839D7;
	Tue, 16 Dec 2025 15:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PmO7dD5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A796183A47; Tue, 16 Dec 2025 15:31:44 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2229883923
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 15:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3ec4d494383so3324873fac.3
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 06:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765895501; x=1766500301; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mM7nUVCDcT27E6jNcaIpivXxEQx7N6rrresEZTdDp4Y=;
 b=PmO7dD5fw8Hj9of6aHOKGjcFUX8hGF2y1NfeDhsRMoZXuUY7OHQH96sOSJVmrIdicn
 Im33h1ewDG07Ssx2BtF7FkfFVhybrXPmZWr2lmLB7NcM9I8whj4J9BIRgQGrJ4JOw9nT
 gt5tbZ1cEWhFU9SsbW+ddlldx67MmGOrdIW9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765895501; x=1766500301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mM7nUVCDcT27E6jNcaIpivXxEQx7N6rrresEZTdDp4Y=;
 b=GDPgjvV7ubylQjIlfW2u/Fra6cg/q3K5J/yqkUp1qOfG6HElZcxlFsykNsfzmfw8Ws
 d9qm/Id9Tj2bkQiPNhPQE9/PXHipxA+XDF997nlNTCNLxLgoJZDW9x+mjnE99KqHER6S
 E51ZXOXK7SGIOntNwRBaKe5Jj30avEU67pqVdd5nFGSOPo3f24t+a6O0W0DsgS64O06M
 ncAQW8y/w4NzfsPyWyK3sNRV8eah/0CwNoz3zjiHrYu/22RBfwTUU26bzAC64no7Opky
 Vg1VfDc+qTBa0OIckv8CNCvH3ByIjXzE0At1w+E3sJXXPw6MgRxUvWfKVA02fa+b+j0P
 +CmQ==
X-Gm-Message-State: AOJu0Yy3lD3XGoAqWTok9AMpMro6s1UxT+wQeqy4KsRwi04M9hNUYWNJ
 ak46DoUhDDM74EZmx6UiGBtrqcQU49uQ94jGQHil0bjgCviFOXlgnWAUvyc05uucQEM=
X-Gm-Gg: AY/fxX51dHYpB40AlRZcC8D5/ARAiGiw+pRdn+aiNyafE4a3mjawBDnevG1CXhwho6F
 r5DYPey8Xzd26zv5oT6jIT4UEi90766QRiUTfDLbIkdIX4WOxxuB+hW9ZxNPnkLQlAySy78AfAW
 vikIkwwDLLld3RnyPktOXypA++2tkoXrrtrIXD3bCbt8ivZHoa3HrUjCdR+xdnzt5N9/Fng71l6
 41JypX9vzCPwDATkoldeIGmHhTMT32cvxVbOe4voq3FQoHDMoRnqHOuAXI6RoB92GaVgfyRrQ3W
 XxfaXfLygbsBaHgoqrSwHcUZnIJjZ/nd8v762xFvhF6P2B713s/jUD05CrRP3sHmqyedwUQSIyW
 zwrYlggApOSIChuDwYUql5U7NnDVcI8eb9SgX4cxEhKl9acADQAonJ3JLHarELL96Frq6DOpVjC
 nbn3wDnj8Olu78NpTcCJGHcPoH4Paynj5FQXjHtDMNFyEdbQEpMWsRSl+CoBpA
X-Google-Smtp-Source: AGHT+IHMc77UUHVkN0VGsmYmzlSbiYN9BvdMAzN00vKpGCLwFX1kTKDxTU8P4PHVn6AaAkVEMoiSTw==
X-Received: by 2002:a05:6871:a18c:b0:3e8:8b6f:9d85 with SMTP id
 586e51a60fabf-3f5f8c0fcefmr5517795fac.29.1765895500696; 
 Tue, 16 Dec 2025 06:31:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f614e371d9sm1776941fac.17.2025.12.16.06.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 06:31:40 -0800 (PST)
Date: Tue, 16 Dec 2025 08:31:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Patryk <pbiel7@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Standard Boot integration - script validation before execution
Message-ID: <20251216143138.GX303283@bill-the-cat>
References: <CA+DkFDbQr40f2V8eKD5cSECVTM6aZyeZNxbZMqT4SeQJjMu3fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1bfbC0vpdBbJAi69"
Content-Disposition: inline
In-Reply-To: <CA+DkFDbQr40f2V8eKD5cSECVTM6aZyeZNxbZMqT4SeQJjMu3fQ@mail.gmail.com>
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


--1bfbC0vpdBbJAi69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 03:13:59PM +0100, Patryk wrote:

> Hi
> I would like to integrate Standard Boot on our custom board based on
> NXP LS1028a, as it currently uses a so-called distro boot.
> Normally I would just follow the instructions in the doc about
> converting from distro boot to standard boot, but things are in fact a
> bit more complicated. My board supports dual rootfs following the A/B
> update scheme, so I need a place where I can check the boot state,
> boot counter and so on, so as to set the final rootfs partition to
> pass to the kernel. That's actually not a problem - I can just use the
> bootmeth script and put all the logic there. The problem is that on a
> production system, the devics will be protected by the Secure Boot
> procedure, so the script to be executed should also be verified before
> the execution. In the current solution (distro boot), the boot
> command, first loads the script, then calls esbc_validate over the
> script header and if the validation passes it sources the script so
> the OS can be loaded. In current bootmeth_script there is no place (or
> I'm not aware of) that would allow me to do vendor-specific validation
> over the script. What would you advise in this case? Is there any way
> to "inject" some plugins into the existing boot methods, like  e.g. a
> plugin that would be overriding or adding some functionalities to
> existing bootmeth_script? I can of course patch the existing
> bootmeth_script with a command that would perform the validation but
> this would no longer be a generic boot method. Or perhaps should I
> create my own boot method?

I think, given how RAUC has been implemented (which in the "distro boot"
days was a complex boot script), you're likely best off making a custom
boot method.

--=20
Tom

--1bfbC0vpdBbJAi69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUFtRgAKCRAr4qD1Cr/k
Ck3IAP9OkF8RYt0kCZIJQ2CWUe/KlsBrSsz/KHdKVJP9Bj66nwD/XOppSOPL3lJ1
2XEMWN7WJtMXu8+80exP0Rru76jOugw=
=I8dP
-----END PGP SIGNATURE-----

--1bfbC0vpdBbJAi69--
