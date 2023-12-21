Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAD7C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 15:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DF287707;
	Thu, 21 Dec 2023 16:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ehy0SJ6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32EFC876F3; Thu, 21 Dec 2023 16:03:13 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B905A8784D
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7811dba1d5dso54361885a.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 07:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703170986; x=1703775786; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vzhL1CNF/GtIjFqiRkCKu84DMSsIHvBfILmp15Ovodo=;
 b=ehy0SJ6X/9odQZQXuuQNUbuVoSiuts8VnyZTOtWD7a+guEZ6VWBvUqW9PYp7kXlWzJ
 0mqPsSGxwAgIalMXYMnhvVijNyhs0wTUZNj9tT/jLjQXgTYoL4WTBAHLjPRAiaSohVFZ
 XQTMpnL6ExGDbVzTTbTDXHdC6GNJlnsi01V7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703170986; x=1703775786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzhL1CNF/GtIjFqiRkCKu84DMSsIHvBfILmp15Ovodo=;
 b=e1aiDtQI11VDxb0XO5VUohGlLK+HV2UeWANiVEomdLHu39exGGGfACfWHwuC/NbTJg
 uVFc7rYgCwgd5mUTeT5Zmuw0LSHQmFz+aiES4XG7HlIawWFsi+vAX2xN2sy02VUdOa+x
 VgCLz3HwLqxSi6SIEbp34gOWRMf5MxRtlrwEM4Ovv2qT5EtOEHyacPaawMoHtB/qKMXA
 fJFqu+jmBNcRuOfvacVhRdEfQ44nMvhDsek8pJTUeVKrCBrFvEg+BMAVGitfOjLvyuFn
 tj7Nv8O1/kGLqzcgrdkgEFh5CzqWpyQBNZu+Ht/W2v5Lihe7F2p30T1h/ZCSRgrgLif+
 oTUQ==
X-Gm-Message-State: AOJu0YzedJxtocP9/nrjHy64egl0q+p5P6jleoSOHRh42nMmG/6vmHvK
 kNJOx/Xi1GVLMm+uX5EuNHap4w==
X-Google-Smtp-Source: AGHT+IH2T3dGiN0C5aP4u9zC0TstZ1j2XiS7ijtQH4XIYR0nutW3N7nlmNuYmPDz0eHJPyl90hpMYQ==
X-Received: by 2002:a05:620a:8311:b0:77f:f7be:c0f with SMTP id
 pa17-20020a05620a831100b0077ff7be0c0fmr10537493qkn.139.1703170986427; 
 Thu, 21 Dec 2023 07:03:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b007811802ab6csm705479qkk.39.2023.12.21.07.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:03:05 -0800 (PST)
Date: Thu, 21 Dec 2023 10:03:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>, Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
Message-ID: <20231221150303.GI2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4ZY9V1aDvdWQ9aT0"
Content-Disposition: inline
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
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


--4ZY9V1aDvdWQ9aT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:

> Prerquisite
> -----------
>=20
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-boot repo via:
>=20
> $ git subtree add --prefix devicetree-rebasing \
>       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree=
-rebasing.git \
>       v6.6-dts --squash

So, I've played with subtree a little and I think this is the right way
forward in these cases. If anyone wants to take a look at how this works
in practice, take a look at:
https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-devicetree-r=
ebasing-since-v6.1/?ref_type=3Dheads
In that tree I started with the v6.1-dts tag, sync'd all the configs (to
have an example of a normal commit) and then did a merge of each tag
until v6.6-dts, so provide some history. And git log looks like what I
want to see, the squash commit has clear references to what we are
getting and I make a merge commit that says what I did. If you pull the
tree and checkout the branch, all the code is right there already,
nothing further to do. Same with tarball releases. The only thing I
don't like is the size growth there, but we'll reclaim some of it when
we delete our obsolete bindings, and then obsolete dts files.

Maxim, please switch (back, sorry!) to subtree for the next lwIP
patchset and just not in the prerequisite steps what the subtree command
is, and make sure the docs have an example of what future re-sync
"subtree pull" commands should look like. For CI testing, you'll have to
do that to start with and just not include that patch in the ML part.

--=20
Tom

--4ZY9V1aDvdWQ9aT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEU6AACgkQFHw5/5Y0
tyweNwv9GPNGi1q4UgzH+4hZFGzC1HD4SBZxReQIVFQVC7HtDQPhjziAbLLGSgmP
dNKJu4ihiNoWdZTtHHC9yvIkW+wLnE6SRryFz+x0xbSNiifeH9ub7Z0Go1Q8xJ4S
/htugcyBkxTkf+yUtcXS4qYyiU6vq7k38BGBlC46n9bOrCxcOIPqGUogsIOhPbTb
c+/ofjTn0aW24L4KFz7n7EevOdFGmPeMbEBYPEg/WFTT66n385WI3LIr+rF8oTDF
nic4c5B1pn3q8G0VZ9BHqe0uIti8U5kOunudrAB/104vbmgoBRlkbQxqt9kZZz2G
sy3/A5CU5Dv8nh4cEq/d4XsYnnKRdNaqhUEpUQ8V7OYPQxk2c1CqxhH/RSHxYDNV
t5bv3XWzmrnIhGglQP84Z/RIOj6GpRfRL2guSaiDWWe7XvHQ0iFMNeXl4fPg3f2q
3avYplnShTXMeKO8KQEjTKDPhw7ca1KqApH+kgmO+vt7CK2ptB6NW7MhWDukKooS
HWTQNiRs
=NLGW
-----END PGP SIGNATURE-----

--4ZY9V1aDvdWQ9aT0--
