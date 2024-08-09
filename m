Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804E7C531DA
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 19:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 417B688C36;
	Fri,  9 Aug 2024 21:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BwSYbQUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC55288C39; Fri,  9 Aug 2024 21:46:09 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BFA888618
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 21:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d9e13ef8edso1739629b6e.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 12:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723232765; x=1723837565; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OKVQJWBDpxWaB7vl+NaAe4IgNmu4KtDybrIKAPLmXWQ=;
 b=BwSYbQUbql3VIod9mVhfK91FfyYJrJSIvlbU5rUMvVkfDTmVZCk5JKdgCDFM9ZZXJG
 yfIpkXb63UXmY9AD7kwJ+ERu3p6sjygUTq5ZC5NS47bq9kSsJZznJs1jnxxpbBKPeq3K
 vNpFjQyVVjByMviAjK4RBXujbxHKHXNExyB/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723232765; x=1723837565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKVQJWBDpxWaB7vl+NaAe4IgNmu4KtDybrIKAPLmXWQ=;
 b=I4TQx7JpJnmQUzrrruvvcStV5Ak+FIfpo3yEMBW8r9ClLjjQwJqXRd/wBk5xOfk7eM
 +cG7cckoVRNxntJCqdFEyJbiKFttVFYfPjkzbebihR7saaIkGtjb3OilSaygoAk3a+qm
 DCblK18PrRtkuauBKpp705Xw/FOvO8/8uZJs1zWWmm1bm0GFRtAjJ4jBhctqlLQST1Nw
 E8pm4vcOJ0wuQQVmpp3Grf1mSh0k2Rm6mH1CmwEdawWXphJdRD2CBVI6RchjYeW4eead
 We85/wNxvJtjgb/F1l36LO2Mx17uWkPYpTXGX8PkachF5bUo16k2aNTYttqy4brax0mu
 P54Q==
X-Gm-Message-State: AOJu0YwS8JvpGBVeTdm9WaS6EobB+3Ri67pvOUC1/8t5sYn4UHPAFrQc
 6Qqfcb3ac1T5ZIL/US5fNyXxNrAgS6hruX/NVCaaqxwxxGrJol/JA6EpX0Mn1NU=
X-Google-Smtp-Source: AGHT+IEgWBb3RpskodcWLjPxNCnZQHtIN7khwuo3og8c8zH47sp8z2UO3P9IgK2P3cRrJBh1qB12hQ==
X-Received: by 2002:a05:6808:1387:b0:3db:251b:c16 with SMTP id
 5614622812f47-3dc416e3ac8mr2653854b6e.42.1723232764917; 
 Fri, 09 Aug 2024 12:46:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd06069f05sm35758b6e.4.2024.08.09.12.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 12:46:04 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:46:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v8 00/23] Introduce the lwIP network stack
Message-ID: <20240809194602.GX1626301@bill-the-cat>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <20240807204400.GJ1626301@bill-the-cat>
 <2a23d370-82a0-446e-8ab5-00fa9005fdbf@linaro.org>
 <20240808172454.GQ1626301@bill-the-cat>
 <44d9347a-974c-41b3-a6d8-00f4d1b86adb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8628pnV4/bdeaWmn"
Content-Disposition: inline
In-Reply-To: <44d9347a-974c-41b3-a6d8-00f4d1b86adb@linaro.org>
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


--8628pnV4/bdeaWmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 03:19:02PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/8/24 19:24, Tom Rini wrote:
> > On Thu, Aug 08, 2024 at 06:41:02PM +0200, Jerome Forissier wrote:
> >>
> >>
> >> On 8/7/24 22:44, Tom Rini wrote:
> >>> On Wed, Aug 07, 2024 at 07:11:44PM +0200, Jerome Forissier wrote:
> >>>
> >>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add l=
wip
> >>>> library for the network stack" [1]. The goal is to introduce the lwI=
P TCP/IP
> >>>> stack [2] [3] as an alternative to the current implementation in net=
/,
> >>>> selectable with Kconfig, and ultimately keep only lwIP if possible. =
Some
> >>>> reasons for doing so are:
> >>>> - Make the support of HTTPS in the wget command easier. Javier T. and
> >>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to =
do
> >>>> so. With that it becomes possible to fetch and launch a distro insta=
ller
> >>>> such as Debian etc. using a secure, authenticated connection directly
> >>>> from the U-Boot shell. Several use cases:
> >>>>   * Authentication: prevent MITM attack (third party replacing the
> >>>> binary with a different one)
> >>>>   * Confidentiality: prevent third parties from grabbing a copy of t=
he
> >>>> image as it is being downloaded
> >>>>   * Allow connection to servers that do not support plain HTTP anymo=
re
> >>>> (this is becoming more and more common on the Internet these days)
> >>>> - Possibly benefit from additional features implemented in lwIP
> >>>> - Less code to maintain in U-Boot
> >>>>
> >>>> Prior to applying this series, the lwIP stack needs to be added as a
> >>>> Git subtree with the following command:
> >>>>
> >>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.sava=
nnah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >>>
> >>> For v9, I think it would be good to do a CI run with NET_LWIP default
> >>> and seeing what fails from that too. There's a few problems still
> >>> leading to a lot of failures, in that case. Thanks.
> >>
> >> I pushed my branch to GitHub [1] and there's a failure in the
> >> tools_only_macOS job [2]. Any idea what is going on? I tried twice and
> >> it failed twice :-/
> >> Om my Linux machine, "make tools-only_config tools-only" works
> >> fine.
> >>
> >> [1] https://github.com/u-boot/u-boot/pull/635
> >> [2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D9105&=
view=3Dresults
> >=20
> > Alright so from [2] going to the job and then downloading the raw log (=
it's
> > huge, firefox gets mad for me), scrolling down until it's not the git c=
lone we
> > see:
> > 2024-08-08T14:36:30.0865130Z   HOSTCC  scripts/basic/fixdep
> > 2024-08-08T14:36:30.8641660Z   HOSTCC  scripts/kconfig/conf.o
> > 2024-08-08T14:36:30.9645180Z   LEX     scripts/kconfig/zconf.lex.c
> > 2024-08-08T14:36:31.0545650Z   YACC    scripts/kconfig/zconf.tab.c
> > 2024-08-08T14:36:33.2374910Z   HOSTCC  scripts/kconfig/zconf.tab.o
> > 2024-08-08T14:36:34.9997050Z   HOSTLD  scripts/kconfig/conf
> > 2024-08-08T14:36:36.5552790Z generated_defconfig:7:warning: unexpected =
data:  # CONFIG_SANDBOX_
> > SDL is not set
> > 2024-08-08T14:36:36.5666380Z generated_defconfig:12:warning: unexpected=
 data:  # CONFIG_BOOTSTD
> > _FULL is not set
> > 2024-08-08T14:36:36.5724560Z generated_defconfig:13:warning: unexpected=
 data:  # CONFIG_BOOTMET
> > H_CROS is not set
> > 2024-08-08T14:36:36.5742720Z generated_defconfig:14:warning: unexpected=
 data:  # CONFIG_BOOTMET
> > H_VBE is not set
> > 2024-08-08T14:36:36.5752700Z generated_defconfig:17:warning: unexpected=
 data:  # CONFIG_CMD_BOO
> > TD is not set
> > 2024-08-08T14:36:36.5772400Z generated_defconfig:18:warning: unexpected=
 data:  # CONFIG_CMD_BOO
> > TM is not set
> > 2024-08-08T14:36:36.5788060Z generated_defconfig:19:warning: unexpected=
 data:  # CONFIG_CMD_BOO
> > TI is not set
> > 2024-08-08T14:36:36.5792360Z generated_defconfig:20:warning: unexpected=
 data:  # CONFIG_CMD_ELF
> >  is not set
> > 2024-08-08T14:36:36.5828400Z generated_defconfig:21:warning: unexpected=
 data:  # CONFIG_CMD_EXTENSION is not set
> > 2024-08-08T14:36:36.5840470Z generated_defconfig:22:warning: unexpected=
 data:  # CONFIG_CMD_DAT
> > E is not set
> > 2024-08-08T14:36:36.5938540Z generated_defconfig:26:warning: unexpected=
 data:  # CONFIG_ACPIGEN
> >  is not set
> > 2024-08-08T14:36:36.5974000Z generated_defconfig:35:warning: unexpected=
 data:  # CONFIG_VIRTIO_MMIO is not set
> > 2024-08-08T14:36:36.5985430Z generated_defconfig:36:warning: unexpected=
 data:  # CONFIG_VIRTIO_PCI is not set
> > 2024-08-08T14:36:36.6045140Z generated_defconfig:37:warning: unexpected=
 data:  # CONFIG_VIRTIO_SANDBOX is not set
> > 2024-08-08T14:36:36.6053060Z generated_defconfig:38:warning: unexpected=
 data:  # CONFIG_GENERATE_ACPI_TABLE is not set
> > 2024-08-08T14:36:36.6068760Z generated_defconfig:39:warning: unexpected=
 data:  # CONFIG_EFI_LOADER is not set
> > 2024-08-08T14:36:36.6088140Z #
> > 2024-08-08T14:36:36.6121560Z # configuration written to .config
> > 2024-08-08T14:36:36.6130190Z #
> > 2024-08-08T14:36:42.5830900Z scripts/kconfig/conf  --syncconfig Kconfig
> > 2024-08-08T14:36:43.9105630Z .config:284:warning: symbol value '' inval=
id for AVB_BUF_ADDR
> > 2024-08-08T14:36:43.9121120Z .config:285:warning: symbol value '' inval=
id for AVB_BUF_SIZE
> > 2024-08-08T14:36:43.9142940Z *
> > 2024-08-08T14:36:43.9172380Z * Restart config...
> > 2024-08-08T14:36:43.9257450Z *
> > 2024-08-08T14:36:43.9288610Z *
> > 2024-08-08T14:36:43.9332910Z * Security support
> > 2024-08-08T14:36:43.9366750Z *
> > 2024-08-08T14:36:43.9399770Z Build Android Verified Boot operations (AV=
B_VERIFY) [Y/n/?] y
> > 2024-08-08T15:35:07.9280210Z ##[error]The Operation will be canceled. T=
he next steps may not contain expected logs.
> >=20
> > And indeed, most of that is "normal" if we look at a current build for
> > tools-only on macOS. We're being hit by the fact that the host CC isn't
> > gcc and is llvm and https://github.com/llvm/llvm-project/issues/78778
> > applies, I believe. Now how do we work around this? Hum...
>=20
> That's an "interesting" bug...
> =20
> > If you go an change "# CONFIG_FOO is not set" to CONFIG_FOO=3Dn in
> > configs/tools-only_defconfig, I assume your build moves on?
>=20
> Yep, it does.

OK, good.

> > This is
> > valid syntax and fixing a more generic issue we have on macOS today.
>=20
> I am adding a new patch to v9: "configs: use syntax CONFIG_FOO=3Dn in
> tools-only_defconfig". It means one extra step when syncing the
> defconfigs though... It is just a simple sed command but perhaps you
> have a better idea?

This should be fine, there's already a number of configs I have to
un-sync when I do a re-sync.

> Thanks again for testing and for your help,

You're welcome.

Tom

--8628pnV4/bdeaWmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma2cfoACgkQFHw5/5Y0
tyzqywv/SC+KhgQTigpzKFcHgbiBHMTYBQzELon1Y8w7oaeUcEU4OBgln97ClSSE
izBiwwIR541b/dQHUyz4aZ8bWDkTdVcP1f/WYyMr9EPgWq/wZg8cYBPOPm0vimO1
Qo9qVX0TS638n8L7NdtM1AOxWxvIa0Ug+HNB3+DzT/ce/WiMuOAIOVViJYbHnIun
q4FYaL70jD6KXDZrvrFIzY5EqkTOzCgEJ6SDqVYJ0wIIj7CvFjfoeHD9TFWgyoxk
YMhoujVQiSXgqfd6OqNPR8EkASJ0VDLc4rd89dsk82swbCMkWz9VYXag3T8xXBBa
0heMkF39k2clK+M05O0vzQQXjEFJRf/jVrwkmSm6GaZfKL2NFc2KGpTqBhGkjCmm
M1c9ZIGSDmnRM4VE65obkjW0z8WVKQPN5N9G9prEnlqnPerZrJqYsg2MubnDdG1x
UZvqusS7wmChjqEQ5+g+aUgKW1h99BToxuRMbYKjlIkatfIsri6cnOAqbTln3mlD
VTq51YUr
=XPau
-----END PGP SIGNATURE-----

--8628pnV4/bdeaWmn--
