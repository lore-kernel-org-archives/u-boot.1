Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B3AC369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88AC680F9C;
	Wed, 23 Apr 2025 16:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q9rXlbIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6F880FDA; Wed, 23 Apr 2025 16:08:58 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFCA80944
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3f9832f798aso4565820b6e.2
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745417334; x=1746022134; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TYOix0ZFQ1Q2ZBUNsuUGQvvZjj5xpAUQgbUpRI5OeJE=;
 b=q9rXlbIqoyY3lUVirSM9knNyTqgIQedJjmtIa8ZgzMIpvrddLuRoAcKOzS/mp0Skja
 Y0etyCLDdv8kwP2UWokCLmbc2alw9vqhsunWCBy+v/9n5sQ5tHfPAUf+V1iteiuIyx6d
 QFzzvZOxSwAvKpwDVN1V2K802AjcJGdE66/8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745417334; x=1746022134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYOix0ZFQ1Q2ZBUNsuUGQvvZjj5xpAUQgbUpRI5OeJE=;
 b=aYaMxmlj4WzXFSfrud6c85VK/f/DJkzv6PEtq3XPQj3QgcBn/RgsZPMpOh/A3tTFAs
 BPX36nefliqUP6SCuBa5imo9RgH2NXrTKofu5Uf3raAi6o0fjhYFBZ/Tyd3FHDGWeqJp
 yM3wxnj+9SiGOwEt0FtB4i+9BhnV39oPtVf2TGSHBq9JF4LTAlj4an/v4X+ysmHC5BpA
 KEwZM5cwZIp+55D+DWVP/y6tOMQ2rGCL/8WV1mbOGBRpHIhyU6650o+KgC52eBnRzG10
 4ttPoW9GSMJ0MpbMbT81KXeYPy//buTm+NC02GupZfH8f1j7LaO4qZT1ioyuMDZHozkH
 SxOQ==
X-Gm-Message-State: AOJu0Yxq1DXCnOd8G2vaf3PsGhgmM9uIE4Lqh5mkdToRcf784v6hp3Sa
 o2VTFwemr1gjAN6RLKYZpNczA0/ONUUUVxrtrR/9Cn1d1Olvj9uPpyJuQdchYoU=
X-Gm-Gg: ASbGncucXRxZkEdoieBTPoFm/cy+9luxGtoSEBaq+Tm6cdiZOgjF/zVj7W5iVSlP9BQ
 8lgMTo/uNSL2rnwcGRynpDwPike8vYFzpR7L1IXXquvyqZHIFmQ/J5XkC1j2elboo/xsDu5XTyK
 W2qD0Z8nZ31/I4ifkv/SKIsMBURTsYIjtp0bec19rrnD7Z8Thco5usOBhYqIrbQH89Hkgj4PJoa
 KXVCUedoldFCONTHmRkbJ+7mNF11ebEgyYjTCN0hvtI7fXSOM4Nz0VxlgLDrjQkZFQ2Myt1gBo9
 5sjHBFTHTeB4yeR6QFz6rFOEShBVlDph+ftybqBj+deL/a3FdG5euXbD+P2JFj/BBsUWqQAjl60
 5FA==
X-Google-Smtp-Source: AGHT+IEAO6CZKO9N5REgmj/oAaAOaMyOiVH6ZVVwu1LhlPwCTAm333ly6j0H1NF1t/PT6gdXkLIgTw==
X-Received: by 2002:a05:6808:6a94:b0:401:e5e0:48db with SMTP id
 5614622812f47-401e5e04ddfmr1556404b6e.13.1745417334078; 
 Wed, 23 Apr 2025 07:08:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401beed7401sm2627994b6e.13.2025.04.23.07.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 07:08:53 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:08:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Maintenance of Python tools
Message-ID: <20250423140850.GE5495@bill-the-cat>
References: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KKeVO0qqpQ4Dy/oj"
Content-Disposition: inline
In-Reply-To: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
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


--KKeVO0qqpQ4Dy/oj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 05:39:30PM -0600, Simon Glass wrote:

> Hi,
>=20
> Tom has indicated that he would like Patman to move out of his tree. I
> suggested on another thread[1] that I maintain it in my 'sjg' tree, so
> here is a new thread to discuss this.
>=20
> I have already done this for the qemu/efi/coreboot scripts as Tom has
> NAK'ed patches for those.
>=20
> For the other tools there is going to be quite a bit of churn, as I
> would like to resolve most of the many Python warnings.
>=20
> Given the shared source between the tools, it would be easier for me
> to do the same for buildman, binman and qconfig. I am thinking that I
> might try a move to allow Gitlab pull-requests for reviews on these as
> well as the mailing list, if that is useful.
>=20
> For tools which need to sync back to Tom's tree (i.e. not patman), I
> or Tom could do a pull request every now and then, omitting any
> changes that relate to pylint.
>=20
> Please let me know your thoughts. The timing is good as I am going to
> be sending out a new Patman feature in the next few weeks and it is a
> few thousand more lines of code.

My biggest objection to all of this is that you should NOT use
sjg.u-boot.org as that perpetuates your abusing owning u-boot.org. As I
said in the thread, it should be under https://source.denx.de/u-boot/
somewhere and you should be the one to own it there. They should be
managed like normal python projects and we could "pip install" what's
needed. But yes, I do think them being managed like a regular python
project instead will make your life, and also the rest of the
communities life, easier.

Un-bundling binman and making it a standalone tool might help make it
easier for other projects to utilize it instead of reinventing the
tooling themselves.

I'm not sure why buildman and qconfig would need to be pulled out, but
if it's just a matter of a "pip install", sure, fine.

--=20
Tom

--KKeVO0qqpQ4Dy/oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgI9GoACgkQFHw5/5Y0
tyye5Qv+PEelSBf14tgcSPDLxczODWXgZbUGj5BqB0qSlFMZn6DhkUFaUW5Haoy6
2qDUdsxfCjlRK+KqmCI7/nq+7D9Gj8Ue5Rpee126Gv4Vl5oHtAAJGaVM2Gu/kfrw
0cApLZArm8olAs1HKEu6GF4OV8AG4uZxiwT6C5Ei1Qru5LN2KcJsFVFcNORlX7x7
U308FzguE1GONC5fgywi/Kg2MqwrWXf7UWHiZ9l6Zj5+YIQSRhPEG1DYm34l4E8P
ji38/tRoA9tLaDDnVNw6R+9ZX4G4/snoUz72U60px0dMkIn5HxWJeF2BhjuUoVdG
5up/NQA+qDw49D5MuhVlpynrjPhEfOphK61uWGJ672Hek70fIRrUYMoIhtY0LU0N
fG1PAl3/i4+j3ZjoxvRGU4lWyFPO8AfpARoGiSzCcHaWLXZupSFSQ1QvmXnSZChH
L4wNEoDseFRjR6OSws9U9o/sGfz8POGOgUkPYwHl8tZYj2ZT3vIG/yJOXUnJKEiW
UdsgIdqJ
=tEk4
-----END PGP SIGNATURE-----

--KKeVO0qqpQ4Dy/oj--
