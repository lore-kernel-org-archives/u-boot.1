Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DE4C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 11:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3363388261;
	Wed,  5 Jun 2024 13:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FrG67GEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC198833C; Wed,  5 Jun 2024 13:39:39 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4514881A2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 13:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wjq.sec@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6f93c24d1f7so950492a34.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717587575; x=1718192375; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9UFVB55H08GsTooap2ILqoHEaQbMTx7rQAbtDfDe0U=;
 b=FrG67GELLD3pDfxkLic0jxxwaYqViVXMbmFtozh88LVnVBZrZYzj2HOGPlf9ghTEh+
 Fd+eK7pCYT4i7hEgHkd63oc607geZQnASSB01afXwInQ0dqv9m2Q9NNrkl+p/uKi3wKI
 lPOJz5SjaQ7OskJiBRZ+Ajkq8duOLSkALPAxjiadaLRdusN3YRzBcxH/lZ8ohdCBqQnC
 8lKDQQlQo+YZeGB30V0ufbMIlkdHTlaAnjjVZqeAZquLnUloZIH08L3TGZos/SLtgxOu
 kBKrqbd7OV+Py1R6zJJglIx2KUuQDLjL6IoxLH/z+mmdN5uKoVkUSFRA/HZ9OKOxk6B5
 T9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717587575; x=1718192375;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9UFVB55H08GsTooap2ILqoHEaQbMTx7rQAbtDfDe0U=;
 b=ut1Qs7ZUsqeX5kMOJL0oO4QOXz7IAXoeECnmrR5hFnr+aRoIz9DZLo3R9JQ+NbWKYm
 XkPUMXbvr58WC2qcFtofaHkpo6MnQKlOkRaGmbeTAmolPohfiIJABuTHqKlhNLnRh+GB
 /AxW3KYBAr70GkE9+iy2S7urGy8llay0zOtgWp1It7Pnz5G8h201rbGtrGKlKzPowoi4
 LFAyeYkxT0dnVts4gFwJp6Sf0z0+nGveuS4gk6prE8f4qXiN1+02VDETBP9IuASj3fg9
 6rW5r3TYKQFzNSjgk90MbuIcyL5ro++KazL/hUeb8eSr9c7WBSinNEwpn3HJNeCWqSO4
 gDLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU76HHU349jYPkLVNwa6hMdKRwsdpIUGQjbVrz77f6+r3cUtcNzgfWW8Tyl3tyFjNZ+xXl1o5bbjTnHWcT67GgnUfw24w==
X-Gm-Message-State: AOJu0YwcdtehRP4e47f55jU5B0uJzW7a214q3pmwyUp/3+41Wdoew6SI
 9zX0qTftypIIaL5DR6VVqn4mL+xaQL8gpzhuLpmW+m5012uaTYygarpa94h5cKmKLSjHaBskgoH
 w19tyOc/cfwf4c8zKZMwmiN7N570=
X-Google-Smtp-Source: AGHT+IH4evIkE/SkL4vlqt5PqGdxpkUOfrvbY2xRMCDTeSAHpZ08XKYRWj+oXp82VVmpmt31DNFnm9IKBoOIRngaUGc=
X-Received: by 2002:a05:6830:10:b0:6f0:e4f1:7a47 with SMTP id
 46e09a7af769-6f9436b6fe3mr2402236a34.28.1717587575516; Wed, 05 Jun 2024
 04:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAMn3X6NjqGmCeVT-X_d_btDKQQJDzz7CnTzOb=62np75VumhDg@mail.gmail.com>
 <5b08ad9c-8ed3-4877-b95d-f5d0ca693fb0@linux.alibaba.com>
 <CAMn3X6MJiPdB9s=h8wyNQ-=LoWcOMghj3K1KOk-V-pMvyen2fw@mail.gmail.com>
 <0d843d6d-3561-4a03-9fa1-94152551f935@linux.alibaba.com>
 <CAMn3X6M-Lmmh9rH6k1E_+u2aOEyViwM9nb2f9=p_ZXD+s20d7A@mail.gmail.com>
 <e57884b8-701a-4ca5-adce-1b3a0b4b8b2e@linux.alibaba.com>
In-Reply-To: <e57884b8-701a-4ca5-adce-1b3a0b4b8b2e@linux.alibaba.com>
From: jianqiang wang <wjq.sec@gmail.com>
Date: Wed, 5 Jun 2024 13:39:23 +0200
Message-ID: <CAMn3X6MNJka9wVJooUEn2SXZaY0Y2ODhmo3c9+Fo=zgeqmoksA@mail.gmail.com>
Subject: Re: Several potential vulnerabilities in the filesystem
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Huang Jianan <jnhuang95@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Could you please forward the issues to whoever is responsible for them?

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=B8=89 13:35=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2024/6/5 19:26, jianqiang wang wrote:
> > Hi Xiang,
> >
> > I just checked the second crash, the patch can solve this issue. Did
> > you also look into the other two issues?
>
> I'm only responsible for the EROFS project.
>
> Thanks,
> Gao Xiang
>
> >
> > Best
> > Jianqiang
> >
> > Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=B8=89 13:18=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi Jianqiang,
> >>
> >> On 2024/6/5 19:00, jianqiang wang wrote:
> >>> Hi,
> >>>
> >>> I do have the crafted image.
> >>>
> >>> payload_00500, payload_00763, payload_00846 can be used to reproduce
> >>> 1,2,3 vulnerabilities respectively.
> >>>
> >>> Each image is a hard drive file and the vulnerabilities can be
> >>> triggered by performing the following operations:
> >>>
> >>>       struct udevice *dev;
> >>>       uclass_first_device_err(UCLASS_IDE, &dev);  //detect the block =
device
> >>>
> >>>       fs_set_blk_dev("ide","0:1", 0);
> >>>       fs_ls("/");   //mount the first partition and list the root dir=
ectory files
> >>>
> >>>       fs_set_blk_dev("ide","0:1", 0);
> >>>       char buf[10];
> >>>       buf[0] =3D 0;
> >>>       buf[1] =3D 0;
> >>>       buf[2] =3D 0;
> >>>       buf[3] =3D 0;
> >>>       loff_t actread =3D 0;
> >>>       fs_read("/a.txt", (ulong)buf, 0, 5, &actread);
> >>>       printf("fd actread %lld %x %x %x\n",actread,buf[0],buf[1],buf[2=
]);
> >>>    read the /a.txt file
> >>>
> >>>
> >>>       fs_set_blk_dev("ide","0:1", 0);
> >>>       fs_read("/a.txt.ln", (ulong)buf, 0, 5, &actread);
> >>>       printf("fd actread %lld %x %x %x\n",actread,buf[0],buf[1],buf[2=
]);
> >>>    read the /a.txt.ln symbol file
> >>>
> >>>       fs_set_blk_dev("ide","0:1", 0);
> >>>       fs_unlink("/a.txt.ln");  //unlink it
> >>>
> >>> The second and third may not trigger a crash however, can be observed
> >>> by inserting logging before the memset/memcpy function.
> >>
> >> Sorry, I just found that this issue was already fixed in erofs-utils:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/=
commit/?id=3D884866ca07817e97c59605a2fa858a0b732d3f3c
> >>
> >> Would you mind checking if the patch above fixes the issue?
> >>
> >> Hi Jianan,
> >> Would you mind backporting this patch for u-boot?
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >>>
> >>> Best regards
> >>>
> >>> Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=B8=89 05:10=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>>
> >>>>
> >>>> On 2024/6/5 06:53, jianqiang wang wrote:
> >>>>> Hi Das U-Boot developers,
> >>>>>
> >>>>
> >>>> ...
> >>>>
> >>>>>
> >>>>> 2. in file fs/erofs/data.c, function z_erofs_read_one_data, the nod=
e
> >>>>> data is read from the storage, however, without a proper check, the
> >>>>> data can be corrupted. For example, the inode data is used in funct=
ion
> >>>>> z_erofs_read_data, map.m_llen will be calculated to a very large
> >>>>> value, which means the length variable will be very large. It will
> >>>>> cause a large memory clear with memset(buffer + end - offset, 0,
> >>>>> length);
> >>>>
> >>>> Would you mind giving a reproducer or a crafted image to trigger
> >>>> this?  Or it's your pure observation.
> >>>>
> >>>> Thanks,
> >>>> Gao XIang
> >>>>
