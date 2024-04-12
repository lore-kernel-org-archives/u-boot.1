Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CB1C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 15:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4E1488020;
	Fri, 12 Apr 2024 17:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mailtundra.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailtundra.com header.i=@mailtundra.com header.b="anoxzftf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E8B8881CA; Fri, 12 Apr 2024 17:54:56 +0200 (CEST)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7A487EA8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 17:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mailtundra.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwleeds@mailtundra.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailtundra.com;
 s=protonmail2; t=1712937292; x=1713196492;
 bh=dNZlZkubsa0f6Kp+PhZ8t04voLPR2TpBB3cpK4xlAuo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=anoxzftf9395AWNcweVXqU7q1JgO+h1+PADDb5KS5xx//Rk6GFoS7mxbVgk3/aOv2
 t0oFJYnQRnZ/u3ftRIPzYhCG05VXVhfwJrD6jXKsopCsDt7rDDJT7tvJB9+b1OT5xZ
 p0ls3nbocX0HjWRGfjvorzU87QHv18jkCcNcXYxNpCbgNvYu9XWNy5pgSzdO99T+HD
 +Dy8aPtHGigS0gLYUwEO5E53XoozyQnodyZgt5VzfuPTKB0bxmxjAsCI7BynGAhzzH
 g/twTrSMHwlsAi7Z7HWkSoQWy8g17K1a82Pacbf1lSyy28j3Cc2/4bOACDbwF3cBuE
 Yt//9YuhCXy+Q==
Date: Fri, 12 Apr 2024 15:54:37 +0000
To: Igor Opaniuk <igor.opaniuk@gmail.com>
From: mwleeds@mailtundra.com
Cc: mwleeds@mailtundra.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] zfs: Fix malloc() success check
Message-ID: <8lIRr3dbYRwsHsoM6-2NglI1f0-7Hf11XjddBZNdS3lhUGfoNZDpGBuk53TC40fO6ZzBbuUcp9YvmvNo8-wt9vRTJzmXGOZsdegS6wMwdhA=@mailtundra.com>
In-Reply-To: <CAByghJb7nkhZqeGqJxbs9DujSJP02tvCmD20zor8U5KhwD9PMg@mail.gmail.com>
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
 <20240407014743.13872-2-mwleeds@mailtundra.com>
 <CAByghJb7nkhZqeGqJxbs9DujSJP02tvCmD20zor8U5KhwD9PMg@mail.gmail.com>
Feedback-ID: 106267484:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Sunday, April 7th, 2024 at 4:22 AM, Igor Opaniuk <igor.opaniuk@gmail.com=
> wrote:

> Hi Phaedrus,
>=20
> On Sun, Apr 7, 2024 at 4:00=E2=80=AFAM mwleeds@mailtundra.com wrote:
>=20
> > This code was hitting the error code path whenever malloc() succeeded
> > rather than when it failed, so presumably this part of the code hasn't
> > been tested. I had to apply this fix (and others) to get U-Boot to boot
> > from ZFS on an Nvidia Jetson TX2 NX SoM (an aarch64 computer).
> >=20
> > Signed-off-by: Phaedrus Leeds mwleeds@mailtundra.com
> > Tested-by: Phaedrus Leeds mwleeds@mailtundra.com
>=20
> It's an abuse of the Tested-by tag. If you are the author of the patch,
> that obviously implies that you tested it before sending to ML.
> Signed-off-by is enough in this case.
>=20

That makes sense. Sorry I'm a bit new to this way of submitting patches and=
 more accustomed to pull requests. It seems like a minor thing though; shou=
ld I re-submit the patches?

> ---
>=20
> > fs/zfs/zfs.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
> > index 1fec96cd5c..14779dee32 100644
> > --- a/fs/zfs/zfs.c
> > +++ b/fs/zfs/zfs.c
> > @@ -648,21 +648,21 @@ dmu_read(dnode_end_t *dn, uint64_t blkid, void **=
buf,
> > if (bp_array !=3D dn->dn.dn_blkptr) {
> > free(bp_array);
> > bp_array =3D 0;
> > }
> >=20
> > if (BP_IS_HOLE(bp)) {
> > size_t size =3D zfs_to_cpu16(dn->dn.dn_datablkszsec,
> >=20
> > dn->endian)
> > << SPA_MINBLOCKSHIFT;
> > *buf =3D malloc(size);
> > - if (*buf) {
> > + if (!*buf) {
> > err =3D ZFS_ERR_OUT_OF_MEMORY;
> > break;
> > }
> > memset(*buf, 0, size);
> > endian =3D (zfs_to_cpu64(bp->blk_prop, endian) >>
> > 63) & 1;
> > break;
> > }
> > if (level =3D=3D 0) {
> > err =3D zio_read(bp, endian, buf, 0, data);
> > endian =3D (zfs_to_cpu64(bp->blk_prop, endian) >>
> > 63) & 1;
> > --
> > 2.44.0
>=20
>=20
> --
> Best regards - Atentamente - Meilleures salutations
>=20
> Igor Opaniuk
>=20
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk http://ua.linkedin.com/in/iopaniuk
