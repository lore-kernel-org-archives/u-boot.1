Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E58BC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0178877B8;
	Fri, 22 Dec 2023 16:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q/eExMY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEE0877B7; Fri, 22 Dec 2023 16:46:23 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280C387874
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7812750f665so87207685a.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703259978; x=1703864778; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ISKj8DG8xg91j5/lFfAOmdaPlNr+VtYllr2Sg5I9lFM=;
 b=Q/eExMY3jFKQuqXtNrxSHK2yO0ezz36InSqA2JZYFGpaob/qZwW7OfXxZbeZLbbr5E
 vnqyGg+vv4uVIAOnoLFBwdMmli/O6gZo4bf6Wb/+GaauZdbQkznzLGan1ERuXb2mg+fr
 Mh/pSWwb3JLq6AorSZNATESXUp30rSpxzp1+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703259978; x=1703864778;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISKj8DG8xg91j5/lFfAOmdaPlNr+VtYllr2Sg5I9lFM=;
 b=DWwx+1sg6Mb1v1THPqKBdfNDdUieQWagj+9hzNTjXF9mQbP01XFwkpPuq9Emquwc/R
 VgjIf7+pvGj8XL0eQsxcbEAQxlJlzE9FdM1kpiFINNSSVWZBvA6ftSc1RmhF623rFOeM
 lSZAfwlwBUgWh03Ccv3FCkA/dwxHRm5EHuibtY4ghbTXzzI6TiN74GfDARxy33WHlj6K
 Nz6z9XVbXm7JQPSK1xzvjQ/GnuNHW4F4FCtVCIFizrTWZHMLcxV8bKcf+topYpQIgZqz
 hHJRtZM/jx4At0SqCulW5CUMxzC5IfXvw1Z8i/i0CpyiJztaJCncGVfLeK4q5M8Zdde0
 KuJQ==
X-Gm-Message-State: AOJu0YyUyIW7KU1lcDZ0ncKTEFxZtp/gxRl3yxslpkB2/p2w5Zxme/9w
 iNJPDR8Jjt23OUTGcsn/dfZwHIj9+74AEg==
X-Google-Smtp-Source: AGHT+IGH7Taj8Fu25GNbBFH3bI1U2YLH3U6yEN+itL5fD0hcUJyGIT82ZSTEty3viQLv0zeyt4o2OQ==
X-Received: by 2002:a05:620a:319a:b0:77e:fbba:6450 with SMTP id
 bi26-20020a05620a319a00b0077efbba6450mr3677140qkb.47.1703259977922; 
 Fri, 22 Dec 2023 07:46:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a05620a144100b0077fac9d9c18sm1436251qkl.88.2023.12.22.07.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 07:46:17 -0800 (PST)
Date: Fri, 22 Dec 2023 10:46:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within
 U-Boot
Message-ID: <20231222154614.GA2652760@bill-the-cat>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
 <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
 <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x628JJcQGeBoA+o5"
Content-Disposition: inline
In-Reply-To: <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
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


--x628JJcQGeBoA+o5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 04:38:01PM +0100, Krzysztof Kozlowski wrote:
> On 22/12/2023 14:43, Sumit Garg wrote:
> > On Fri, 22 Dec 2023 at 13:48, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 22/12/2023 07:12, Sumit Garg wrote:
> >>> Changes in v2:
> >>> --------------
> >>> - Patch #1: excluded gitab CI config check and added commit descripti=
on.
> >>> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> >>> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> >>> - Patch #5: s/U-boot/U-Boot/
> >>> - Patch #6 and #7: Picked up review tags
> >>>
> >>> Prerequisite
> >>> ------------
> >>>
> >>> This patch series requires devicetree-rebasing git repo to be added a=
s a
> >>> subtree to the main U-Boot repo via:
> >>>
> >>> $ git subtree add --prefix devicetree-rebasing \
> >>>       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/device=
tree-rebasing.git \
> >>>       v6.6-dts --squash
> >>>
> >>> Background
> >>> ----------
> >>>
> >>> This effort started while I was reviewing patch series corresponding =
to
> >>> Qcom platforms [1] which was about to import modified devicetree sour=
ce
> >>> files from Linux kernel. I suppose keeping devicetree files sync with
> >>> Linux kernel without any DT bindings schema validation has been a pain
> >>> for U-Boot SoC/platform maintainers. There has been past discussions
> >>> about a single DT repo but that hasn't come up and Linux kernel remai=
ned
> >>> the place where DT source files as well as bindings are placed and
> >>> maintained.
> >>
> >> Thanks for doing this.
> >>
> >> I really suggest to store information that kernel DTS is directly
> >> re-used, thus DTS backward and forward compatibility matters, also in
> >> Linux kernel sources. The point is that sub-arch maintainers should be
> >> aware of it. I don't think that as DT maintainers we can efficiently
> >> keep an eye on it. Maybe create a subsystem profile and include it to
> >> maintainer entries of such affected platforms?
> >>
> >=20
> > From U-Boot point of view, currently we have the config option:
> > "CONFIG_OF_UPSTREAM=3Dy" per platform which means directly re-use of
> > kernel DTS. So U-Boot sub-arch maintainers should be aware of
> > platforms which get converted to re-use kernel DTS.
>=20
> I was speaking about kernel.
>=20
> >=20
> > I suppose we have to relay information to kernel sub-arch maintainers
> > who aren't the same as maintaining U-Boot counterparts. How about
> > adding U-Boot ML to CC for whichever DT change gets submitted in the
>=20
> And every other project? Just setup lei filters.
>=20
> > kernel? Otherwise adding U-Boot sub-arch maintainers as reviewers for
> > corresponding kernel DT changes works too if that's acceptable.
>=20
> You just entirely ignored my proposal without addressing it... ok let it
> be. No, CC-ing U-boot maintainers changes nothing because as I said, I
> want kernel maintainers and contributors to be aware.

Maybe an underlying question is, what kernel maintainers aren't aware,
but should have been already? Then we can figure out how to address
that. For example, with your Samsung hat on you weren't aware that
exynos 4/5/7 DTS files are cared about by U-Boot, but are now aware.
Samsung platforms are only recently becoming more active in U-Boot as
well, so that's all understandable. On the other hand TI folks know, and
I expect the K3 families to switch over to this series ASAP, and STM32
and all of the AMD/Xilinx stuff too.

--=20
Tom

--x628JJcQGeBoA+o5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFr0MACgkQFHw5/5Y0
tyxEggwAqSD/KoOaRzTKhQvBn+pV5/XEx6bJqGkwHpulBqA7WUP+fG50tE9QwNhO
dBlUIRnj7Kl58n5Rz/awLNaHXJY1W8d+djrdR84myDAYpnme2svygZvTaLPwdMgW
YjEw+ZI2rBx2aV08Eo2YfmtiKb49SY/vym5J1O2iAxn5hcSbJP+XxCTxBbX4HYe1
kmSBHMTsST913g+Y3e78DrpFVBvfJSCuZcw6usIMaP0Cmc4JfyGmMKX4Md63hTo/
3d1RwIYOjEv5N0X9iQ6nJ4Y4u01frfyOKLMTKmg9WXZP+NtobZb5/aPvpKYYEIJZ
0GPJX+nRd40089qZbib0eJ7yoOgE4kW1z4qWVA+7+omZ3ScDwBggoaoPkncz7U4Y
/+c2C9jFozEy02e7Tc3Tk2xS/+dqB46K3s6XlkcMzSWuaUBvvDY2IDhs0xHwe9Oa
Z4Bcwn0DC6cQid4h26jTXJGzJUKlG/0vcuUsDNLApzA07YmL8Zudf8eZX0wmBj41
raZwnxl8
=HIdB
-----END PGP SIGNATURE-----

--x628JJcQGeBoA+o5--
