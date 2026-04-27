Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1767EFF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F4283BC4;
	Mon, 27 Apr 2026 18:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o9VLDlCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E57983BC4; Mon, 27 Apr 2026 18:12:58 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9648B83AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 18:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebasjosue84@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba922426c5cso727444566b.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777306374; cv=none;
 d=google.com; s=arc-20240605;
 b=ePiSkFGwesjjS4REi5ICwPioc3RfpQqHX2Kl3SXTj5+uhYlY+SlHU1BGJG15rD5A6u
 b9TyOr2ditU1JoJx/haglPgttPsrM3tlUz/Jm5u+MRnKp3KTnUj6B9Z8elOUwGlInjqy
 tMofquA/FZL8Hqo9mb63XOcCieTYBfwc/EB4m2iOr8yGfYejeGo3queraoUYwvdF1Z54
 p5YD2HyUTinFz1Z49zxtPhJD1mD/lNili84v2nNbrG//CjbwW7kJcYTgmqGNuiA60FZL
 Eb6OwapAZqneqQ9zsW956SwnAPYXScSdtwcRpzJ4d70C9krbwZYZ7/0PQ7ZYsFvXnAAr
 jVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JI9gLvGwKMShBy6VCIgyB2QFqC0rDqqyhOjiSmVT5Hk=;
 fh=0vTB6WDZAGeR9Y8d7CYreXA+SC8xMKymREvy/g+8Pt4=;
 b=hkUNDPBzbj+Bl7Vw0r3FAG4YlQhcUQH0Se06xuQrBwwyLbhqA8lSqOa2BKF/azUHSJ
 NV9lr1SS/CWn8kY+Qkcxh122w40D4ByDn1lj73VQZd1lC205DuoNc6nkKBGsIws703kP
 xFQQJiMP7vcLNxvW+Rk/qqhFQPeJZv772iNYFTccnabcq6Mag3naLhnOBOLYBn76u0wH
 pSFeGdKnDUSF30hI4OGNy34uXRkIDuQjsUGyt0eb/fJ3DoeKTm9AlpUYtx40gxM3jv1p
 iUsEjH066JBFg6KNYFLukGpww6XR9MKP7w4uFkxuIA3zbZGpFxJK/tpg/eQzl43mJWnI
 7LpQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777306374; x=1777911174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JI9gLvGwKMShBy6VCIgyB2QFqC0rDqqyhOjiSmVT5Hk=;
 b=o9VLDlCotYflToOzglgNEX0gdkUtrxoJJA6W6wA6QaUC6jqkkXJ3o6nnAxZgEqLiK2
 1BfeDgfdI/blO2+YFGM6VJJIeT8Iug4z57tOVxNg20zuaQb5GmptuQNGj/i8F7ME/8Vb
 XiCjtjNyovULWRHWbSVTD8ITGD652WhrDo+Ky0uzs6ytbLoggCgPAl4P1BA9EfF1sdgl
 v50Z5n+pwqINJD1Ecl7KTpAjvao8VXRzuUzuCoCpLkrjfzLRAk53urnVNJBpxrQjeUZC
 0q2QW9ol0O+rxhdQNpXfHLK2bqNGzvUMiMlm16qXABxY9IzKibqymmtbOZ7deN4grruu
 UtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777306374; x=1777911174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JI9gLvGwKMShBy6VCIgyB2QFqC0rDqqyhOjiSmVT5Hk=;
 b=qDv8IsUPs1FOX0zzvjWp47cauaSSKkl4y6wuNE9W3GbmjAWfwUNzN/MushZmb7omig
 vQfp7dSOJ2AXJluRGgWNFyvpyY9Gk2ACKjVKOwuMcKjVFEltoadud5rhuXcUJ24R3YaI
 u/2WwRVhWkLxOmR3WMCuCbiuIRypHWe355/XoK5CIsipP0grUFJexNY7XBa/VeuOHXm/
 EcVSB5l7OzAPf19yJk4XcH499T46V7VDGtjA9koXtLNpqPaqRQ/0QKiZKe8fbwXdegKn
 oA4jnXnZVXbgSWU6xFG3gbekJtDJPxACuQyIiwO90n1W4alNrVIoYh2Z9z3ze/+saIJL
 GYAA==
X-Gm-Message-State: AOJu0YwwD465klUdJwRVcOgZzmDZXMaSAFJhTVwAcuipCy32bRXPOnoi
 vljDcVi3fr3nAzn7///QLw8jNSf5VTaRdOtgOWPInJROvwGeTXiCEF0XW4Wdg/1CeO5+Aql+4SO
 CGvofW5N9xOGLdVtyJvPq9FjE+/w4cDs=
X-Gm-Gg: AeBDiess9FA/YmpGf+XnoVt0A4aiEfR4JTbr8/Ck9BrrBYkvmv1Zh+IbTuuEL2yCCX1
 w67Ce1AxSlyiQGRnx+tPyvCHmU5iDVYCwgl1Yd4LiWknCaWgicZNp/RIRijvBV00OWEW9m46ZDT
 qGGurSdKBWHhkBXQLH9PmezI3ooJRtuCs0gDWyIZ00Ci5daT184kWGNTsBvTVfN76uMsKrL/b/i
 Al10ORinWSKtUltfv54V2GscM/auzeNPgWAYHxi8og2DFfV0q6vKpGg6mM0Au3+q0IK5wt9NLRr
 vixRRUDyeNAIZ1NL4YwDcktEcSeK1A==
X-Received: by 2002:a17:906:9fd1:b0:ba7:b198:7d25 with SMTP id
 a640c23a62f3a-ba7b19881a3mr1822324366b.21.1777306373932; Mon, 27 Apr 2026
 09:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260409164440.323405-1-sebasjosue84@gmail.com>
 <2a90ad52-4a9f-451b-acb9-b9b576fb348a@arm.com>
In-Reply-To: <2a90ad52-4a9f-451b-acb9-b9b576fb348a@arm.com>
From: =?UTF-8?Q?Sebasti=C3=A1n_Alba?= <sebasjosue84@gmail.com>
Date: Mon, 27 Apr 2026 10:12:41 -0600
X-Gm-Features: AVHnY4Jl-3ZQEQCtYCboj9kkZqSj0MTnJVdhZp2fqHId-0xC102NdexXyPHb2xU
Message-ID: <CAJD=UNdkXtgNPr+hfweiC2yZ7_5euA=SxgThARLtU0er0+9bFA@mail.gmail.com>
Subject: Re: [PATCH] net: nfs: fix buffer overflow in nfs_readlink_reply()
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, jerome.forissier@linaro.org, 
 stable@vger.kernel.org, nd@arm.com
X-Mailman-Approved-At: Mon, 27 Apr 2026 18:30:18 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Jerome,

Thank you for the review and for adding the patch to your net queue!

Regarding CVE assignment: the GitHub mirror does not have Security
Advisories enabled, and Tom indicated the submitter should request one.
Would it be possible for you or the U-Boot project to request a CVE through
your CNA channel (ARM/Linaro or otherwise)?

Thanks again.

Best regards,
Sebasti=C3=A1n Alba Vives


El mar, 14 abr 2026 a las 10:03, Jerome Forissier (<jerome.forissier@arm.co=
m>)
escribi=C3=B3:

> On 09/04/2026 18:44, Sebastian Alba Vives wrote:
> > From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> >
> > nfs_readlink_reply() validates rlen only against the incoming packet
> > length (inherited from CVE-2019-14195), but not against the destination
> > buffer nfs_path_buff[2048]. A malicious NFS server can send a valid
> > READLINK reply where pathlen + rlen exceeds sizeof(nfs_path_buff),
> > overflowing the BSS buffer into adjacent memory.
> >
> > The recent fix in fd6e3d34097f addressed the same overflow class in
> > net/lwip/nfs.c but left the legacy path in net/nfs-common.c unpatched.
> >
> > Add bounds checks before both memcpy calls in nfs_readlink_reply():
> > - relative path branch: reject if pathlen + rlen >=3D sizeof(nfs_path_b=
uff)
> > - absolute path branch: reject if rlen >=3D sizeof(nfs_path_buff)
> >
> > Fixes: cf3a4f1e86 ("net: nfs: Fix CVE-2019-14195")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> > ---
> >  net/nfs-common.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/nfs-common.c b/net/nfs-common.c
> > index 4fbde67a..72d8fd82 100644
> > --- a/net/nfs-common.c
> > +++ b/net/nfs-common.c
> > @@ -674,11 +674,15 @@ static int nfs_readlink_reply(uchar *pkt, unsigne=
d
> int len)
> >
> >               strcat(nfs_path, "/");
> >               pathlen =3D strlen(nfs_path);
> > +             if (pathlen + rlen >=3D sizeof(nfs_path_buff))
> > +                     return -NFS_RPC_DROP;
> >               memcpy(nfs_path + pathlen,
> >                      (uchar *)&rpc_pkt.u.reply.data[2 +
> nfsv3_data_offset],
> >                      rlen);
> >               nfs_path[pathlen + rlen] =3D 0;
> >       } else {
> > +             if (rlen >=3D sizeof(nfs_path_buff))
> > +                     return -NFS_RPC_DROP;
> >               memcpy(nfs_path,
> >                      (uchar *)&rpc_pkt.u.reply.data[2 +
> nfsv3_data_offset],
> >                      rlen);
>
> Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>
>
> Added to my net queue, thanks!
>
> --
> Jerome
>


--=20
Sebasti=C3=A1n Alba
