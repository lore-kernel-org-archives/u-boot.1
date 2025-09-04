Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5480BCA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 09:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E51C83A7A;
	Thu,  4 Sep 2025 11:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="FA56ToUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D5683A7A; Thu,  4 Sep 2025 11:28:16 +0200 (CEST)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E7CA83804
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 11:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
 s=kas202509031142; t=1756978092;
 bh=Y3X9yBTMFgK3eUM8Xf/75iq+xe6J3twmprC1TxHK5R4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=FA56ToUnqDLGsbz9tHQ/8RF3LdYXWboo4pl9fSAflIWVybAa/Z7MLncPqb87tMiNu
 x6/R7xRfK4jRVyiqCntoRLOiS2Z3VPd3WTsd89dAjaCKjMP/OuKDf1ElM1giXtwwLT
 vVCCL1MEpVfuQEJ5ogtQydcg86nUVaOnWX3ybj3K765kSEJapP+OqyHUNLu79PSxFU
 a9j55VMuot5xcXbxhbI8fyDduSBpvn+KLblPfQpgNNJQhSftpMX9rBVTlLAaYYfoi4
 WomXAYaVimoJenD/Ia3uE2uHCvDCeqVSDI8DkEMYXMjRIdSULeb5t/ITDM28+W3Yea
 iaN2rkNbW0YaA==
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id A35947720FE7;
 Thu,  4 Sep 2025 11:28:12 +0200 (CEST)
Date: Thu, 4 Sep 2025 11:28:11 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>,
 "Lucien . Jheng" <lucienzx159@gmail.com>
Subject: Re: [PATCH v3 2/5] misc: fs_loader: allow using long script name in
 request_firmware_into_buf_via_script()
Message-ID: <20250904112811.5a104f4d@karo-electronics.de>
In-Reply-To: <5ada4f98b8d09bd78915bef278dee780de5d7fa2.camel@mediatek.com>
References: <cover.1756885599.git.weijie.gao@mediatek.com>
 <038e8258c903367dccd9c7cd1adb51bcf2bdf307.1756885599.git.weijie.gao@mediatek.com>
 <20250903133600.52169228@karo-electronics.de>
 <5ada4f98b8d09bd78915bef278dee780de5d7fa2.camel@mediatek.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: +++
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

Hi,

On Thu, 4 Sep 2025 08:23:28 +0800 Weijie Gao wrote:
> On Wed, 2025-09-03 at 13:36 +0200, Lothar Wa=C3=9Fmann wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > Hi,
> >=20
> > On Wed, 3 Sep 2025 16:38:30 +0800 Weijie Gao wrote: =20
> > > Use cmd_process() to remove the length limit of script name used
> > > for
> > > run_command().
> > >=20
> > > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > > ---
> > >  drivers/misc/fs_loader.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> > > index 87acd385e23..6a6796c1931 100644
> > > --- a/drivers/misc/fs_loader.c
> > > +++ b/drivers/misc/fs_loader.c
> > > @@ -232,18 +232,15 @@ int request_firmware_into_buf_via_script(void
> > > **buf, size_t max_size,
> > >                                        const char *script_name,
> > >                                        size_t *retsize)
> > >  {
> > > +     char *args[2] =3D { (char *)"run", (char *)script_name };
> > >  =20
> >=20
> > const char *args[2] =3D { "run", script_name };
> > does not work?
> >=20
> > I don't see any need for a non-const 'args' here. =20
>=20
> We'll get compiler warning if using const char *[]:
>=20
>   CC      drivers/misc/fs_loader.o
> drivers/misc/fs_loader.c: In function
> 'request_firmware_into_buf_via_script':
> drivers/misc/fs_loader.c:243:33: warning: passing argument 3 of
> 'cmd_process' from incompatible pointer type [-Wincompatible-pointer-
> types]
>   243 |         ret =3D cmd_process(0, 2, args, &repeatable, NULL);
>       |                                 ^~~~
>       |                                 |
>       |                                 const char **
>
OK. But at least:
	char *args[2] =3D { "run", (char *)script_name };
should work...


NB: The right fix would be to change the argument type of cmd_process()
(and all functions with similar semantics...) to
"const char *const argv[]", since cmd_process() need not and should not
be able to modify any of the strings within argv[].


Lothar Wa=C3=9Fmann
