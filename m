Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB45C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 20:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08A587BE5;
	Fri,  9 Feb 2024 21:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S8LEx6aK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37E487C35; Fri,  9 Feb 2024 21:25:15 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE55487BD6
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 21:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-42aabb1cdaaso10616871cf.2
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 12:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707510312; x=1708115112; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iawnoqvvf4GqdwDIy2yY76BjojzyQfisWdTvxopAP8E=;
 b=S8LEx6aKZu67eEDQMRtZ/So41L+f+a0uuguPNaL+xEIGGzEYAliJvlIB2k8G/+Bfla
 1NTX0Qu9/02MxrMC1uXVDS9URhqHUITsZ3mqfWv/mkufCIjXQjCvzMwQXO92uWJIfmGg
 ip6ltETxu3c/hdgUY98NRgW6tb4DFfRXk3nr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707510312; x=1708115112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iawnoqvvf4GqdwDIy2yY76BjojzyQfisWdTvxopAP8E=;
 b=iRu2UKcwvtg1Kn7s0o27Qb9dNqu18My3rLEVo1TtxUc3vEp2H6YmxbB/fb2WpJyXrd
 U3ntVtpr4qLyZOkKHrkcr8ULa31eAj4GjhuWXtU/M3woB90yqngz60ok7U5iU87D1ly7
 674VPU/VJ3apSe/QbSEpqhFmPZEYRKulUrZtgu9SkoK0ab+mniTCiW4kWA9G80gg2IM1
 ONWCb8SOAw7M/VMGGaa8DZKznXVz0GOTvVN/utjJj8k1NNLeIl8umod4ge2skTy7SIKJ
 APXHnpMYa1/r/YDSkOHahsn+Vz4DrX8lqFlMnI3uq8hd/RAbMRq5/tLdvAakDdN03T/n
 3CGg==
X-Gm-Message-State: AOJu0YyqSzQlFmijOpSCCMq7hsABdBH1PVqtvNLjpbCzW8/wQh6n7iTH
 NPZYa3w7D+L7phPsH5IoY/BsLWqeA5T7gcHCL2I6fg1sc+h0enA4hkuwAljvlB6a8lI1AQgXvSS
 a
X-Google-Smtp-Source: AGHT+IEEI+FbLYjZxmCRdxPrXX+xNFs3R2XTrgVdxpDYHYnjxhOWy+11HNS3tiMLPzd5jZeu28NrOw==
X-Received: by 2002:ac8:4e82:0:b0:42c:5a5b:b340 with SMTP id
 2-20020ac84e82000000b0042c5a5bb340mr341557qtp.67.1707510312452; 
 Fri, 09 Feb 2024 12:25:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 b19-20020ac86793000000b0042c18b0fb1asm977997qtp.56.2024.02.09.12.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 12:25:11 -0800 (PST)
Date: Fri, 9 Feb 2024 15:25:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Selvakumar Velandi <selvakumar.velandi@olakrutrim.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Added FDT PAD memory size while reserving memory for FDT
 to avoid some memory corruption issue
Message-ID: <20240209202509.GQ1152441@bill-the-cat>
References: <CAJ-dvqwMWvWw0=34ZLkG37MwTRG1m_tabSi0zLkoHNY8CjR_PQ@mail.gmail.com>
 <20240209134027.GN1152441@bill-the-cat>
 <CAJ-dvqzoCPRtO4hczmH+ygU8pAUKMxAzRqegcD02NbTJo619Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ik9hUPpp7Bk3ZQCF"
Content-Disposition: inline
In-Reply-To: <CAJ-dvqzoCPRtO4hczmH+ygU8pAUKMxAzRqegcD02NbTJo619Pw@mail.gmail.com>
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


--ik9hUPpp7Bk3ZQCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 07:45:10PM +0530, Selvakumar Velandi wrote:

> The FDT relocation is not disabled. I am adding the FDT PADDING bytes whi=
le
> doing FDT reservation in the board_f file.
> Also update the FDT length based on the new allocation, instead of blindly
> increasing the size.
> Currently the size is getting increased even for the relocation disabled
> scenario also.
> So without increasing the physical memory for the disable relocation use
> case, the fdt total size is updated. thus causing memory corruption

Please explain on what system you're seeing this with, and how things
are configured and what else is required to trigger this problem. Your
changes to boot/image-fdt.c change things so that we don't pad the
non-relocated device tree (but we need to, we still change the bootargs
and so forth). And the changes to common/board_f.c look like we're
trying to do that instead, earlier? But we should not have a kernel
corruption problem unless:
- We aren't relocating the device tree
- We aren't relocating the device tree far enough away from the kernel,
  but this shouldn't be a problem on arm64 and riscv where the Image
  header structure tells us how big the BSS is to be and we obey that.

--=20
Tom

--ik9hUPpp7Bk3ZQCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXGih4ACgkQFHw5/5Y0
tyysFAv/bBcf3v7Bbb6woNU0LX283fubvwdl07w266yH2ECmifsZw7FU6k69apd7
q45+eqpj24C6CauG1bh8bxAgTYZgOaJKgTik4Hwj6GjGgU33j6NZWDRk1s4DKi/Z
uGUCNwBezGaa7JJ5tVfibVxZHlxqARrXCwJe/AtadOcTVF8UPHu1sE+FO7pWT8oS
3p3Nm+BFlbma61LBNpqoL55i1VYqJ29RYlee2dSooo2m8P4vv6UAWj+jtIPVqMzv
b/llDm/iwZE4BJXFRpDO4PWylZ2fVn6ej6lC2ZxxwvQjx1V5CZDpp4KIK6NoMt0w
dUP8iW625dhdjTTqp/s+LQE4gMl+yXm2CG94KDmzDafNJK39H9tjESn50gddRAGi
Ktg3nxZCtUIzPTjBZTpfv+7MedPNArraxFksQXgZvS3CcYsdf/Op+aqrwlsc9jVz
J2073OqWqi6GDREtkc5EHSt65t5FUAJ8zxZcNbnecsqkomEwKM+bca62vBNmxiIY
bZMAVxx/
=Q7im
-----END PGP SIGNATURE-----

--ik9hUPpp7Bk3ZQCF--
