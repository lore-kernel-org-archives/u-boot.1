Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E674D3C538
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 00:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9F8688EE5;
	Fri, 18 Oct 2024 02:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rfs+9cuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC1588F23; Fri, 18 Oct 2024 02:17:43 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA02C88E81
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 02:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46089a6849bso9117821cf.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729210658; x=1729815458; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lovTfZU8YdBapZmEBoGlDxoke2weXZ2YXCoX8kXXrys=;
 b=rfs+9cuoeK5qkvt1ORe+e0eXCIYS8S/FwonZ3vx0GxdDkO2iX9A1EaZGsLXs8QBzbY
 RKr7m1AuLplzQr61mopNK0xv6r+CVge9RG6PvchY+lw/Rxy23wJB5NJyq8vxgLmneYiL
 AMjIn4t7eOaVql4n8YVh+mKPUQ+LH8E5a/LTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729210658; x=1729815458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lovTfZU8YdBapZmEBoGlDxoke2weXZ2YXCoX8kXXrys=;
 b=exmoZXeniKhnjZF4UuSf065JIOoyiCOpSwGAwYjExgzoHFc9+lQbR7j8ArkdjERyPb
 NYIKRgdgrndQ2S5LbBAwmabGTEHiaPvJxENfmptDcd8RtfwfBw9YJHtzDEb4CxmwSP3n
 h9UgFnKp6rcISv/DAPBlznWNFHnUEtYqNAfQW1KoVXnE3dJqzJ3KPb/Hqel7VxjB9PCU
 iJrxVpZ9t263UibrLB8wmQcQSKUDzhDjzNyJlDLMGr3IBVWmdEmRdFXpyQlRk/AkbfQB
 dba+aDeyVkIbJn0X/GiSHB4qWhhRTUJC3PbNpKorT4zsSb3la1pGtOUvPRVcKnO/FUac
 9hgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu9UjQ5GCSRDwRi+L7ss9Z2Y/6eNsJ36B0i0jF+X6kIrHRZ5xzl108X8yXGgeDb2MpEvy9uzQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzRVCLWctlXuvdw0fuF1iF3DQRtLX5axtvCZ4wbd8pGCWU34M9H
 Q2mLE9g/JRVvcWT9rqDNnELHiyYxZfk6biBtEPqbBarT18Wh/0KWdyqscreDdcU=
X-Google-Smtp-Source: AGHT+IGassvhU5UG1TiQgqhgVR04Vbq8cjSZrHMwR+WSpTjSrytumseEOQpkbgLtvvuR++KX57wlLw==
X-Received: by 2002:a05:622a:a08:b0:460:971c:7424 with SMTP id
 d75a77b69052e-460aece9f99mr7366381cf.5.1729210658446; 
 Thu, 17 Oct 2024 17:17:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460aea62c3esm1778421cf.80.2024.10.17.17.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 17:17:37 -0700 (PDT)
Date: Thu, 17 Oct 2024 18:17:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 06/12] efi: Use the same filename for all sandbox builds
Message-ID: <20241018001734.GR4959@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-7-sjg@chromium.org>
 <56ceb77c-efcb-40cb-a497-0952a8457950@gmx.de>
 <CAFLszThLt96h=+28HaD3LmUk-wgj6mnQFav40ndxTxXVZDQw7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z0FfRePV/tcwn/sI"
Content-Disposition: inline
In-Reply-To: <CAFLszThLt96h=+28HaD3LmUk-wgj6mnQFav40ndxTxXVZDQw7g@mail.gmail.com>
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


--Z0FfRePV/tcwn/sI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 05:23:19PM -0600, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Mon, 30 Sept 2024 at 17:23, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> >
> > On 26.09.24 23:59, Simon Glass wrote:
> > > Sandbox is not a real architecture, but within U-Boot it is real enou=
gh.
> > > We should not need to pretend it is x86 or ARM anywhere in the code.
> > >
> > > Also we want to be able to locate the sandbox app using a single
> > > filename, 'bootsbox.efi', to avoid needing tests to produce different
> > > files on each host architecture.
> > >
> > > Drop the confusing use of host architecture and just let sandbox be
> > > sandbox.
> >
> > As I already wrote in
> > https://lore.kernel.org/u-boot/ae1cf1fa-766e-46a0-8ef9-2c2c7af73d9e@gmx=
=2Ede/
> > this patch should not be merged.
> >
> > bootsbx.efi does not exist in the UEFI specification.
>=20
> If that is of concern I can get it added. Let me know.
>=20
> >
> > Without this patch I can test that shim work and grub are correctly
> > loaded from a distro image. This patch makes the sandbox misbehave.
>=20
> Why don't you do that with QEMU?
>=20
> If we want sandbox to do this, I could add a way for sandbox to select
> its architecture. But this patch is correct, sorry. It is basically a
> revert of your patch:
>=20
> 3a0654ecd0d efi_loader: correctly identify binary name
>=20
> Let me know if you would like a selection mechanism and I'll see what I c=
an do.

I'm confused. It sounds like Heinrich is using sandbox to test on
various hosts, how U-Boot behaves, without relying on "just test in
QEMU". I don't see how this disconnects from your usual request on how
to use sandbox for further testing. What is breaking for you, Simon, by
us saying that the host instruction set determines what we load and run
(and so, is portable whereas saying "sandbox" is not, between x86 hosts,
arm64 hosts and riscv64 hosts).

>=20
> Regards,
> Simon

--=20
Tom

--Z0FfRePV/tcwn/sI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcRqRoACgkQFHw5/5Y0
tyyBfgwAk4F01wTi7vP7VfxFEv3Zj6An0Flyig33RDvabTwOU5wc1Ucws8xfZLU7
6WW86wCJwSfdWZZSBZQphh9lmYehDsY09u3oqF4658jo65YfNYN/ckMp/Kx9P0MV
kifv2sEPx0MCVoEPgQzYxlOtEF8E/63VGyHP5ox8jg2mBw8dH6BR/RO45oAeaVAB
zlrakeF0zNPT7OWRENI3ZQLkFPwxsqYJTleJ+tu9DlqMHxVM24sQXOicquollrd8
b1LQATt/4wOE/nTO/xlLoGCL9jtbeDstRQmHEgjwuMulL+XYviMhGVDaeez5GAhN
Kx/Wwo3w0fz1SUcYz9es2kgWyICCiBUUFbv3ks7B6ZN5zgER5Xh8SV1O2aLIwlm8
8WRL+LyFBz93nXxjwMqodPA8OBBI/feZ5pncwd6J/3CVa5h1UjxrwOKXJvihic38
ZIkTObEHjWxk/2UTl5zfI4s0ja61kjSyG1UVN0Onq9KoFh/hTfdeLtFcldkFiBLd
w+YkQWWr
=8uBH
-----END PGP SIGNATURE-----

--Z0FfRePV/tcwn/sI--
