Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93F6C27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 11:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 465688780E;
	Wed,  5 Jun 2024 13:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bH9NQr3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46AFE8833C; Wed,  5 Jun 2024 13:27:04 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D6D807EC
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 13:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wjq.sec@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-795186ae415so100711285a.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717586821; x=1718191621; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDY1aipJjGB/BqxxBZ4BKWza7WvHZ9wKmJrTLJkJQao=;
 b=bH9NQr3No+MzaGDQCXWfZKTHRpOcrxpe2UV/jJ8R/RJhyQ7PmkMMc5nZN2XC8EqMPH
 dRncGRrPeUTYpKjLGvuNt7C7PEHlzC1EdfAyolGgSqohxKdfc0f4QMVT5HRv72ehoWWB
 7F97YW3y3yb8EXEW7+M3H3gC5gGnSmtMdpTr6K2WkV3s0gz2nzdKGBPNL4McHkzFFq17
 YyVofX2VugtgoOHJWMJ0oH/gPOb9+DV9PBP1Kw++F69sBa+PWu8BwbMA/O3tXlhAPMlp
 QJEqUzN1ghuQK9yHEjEeKB+L8x7U1GNaujRG7nnz1djpS08nNdt5E5KKpGep4Ukaa4H0
 IpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586821; x=1718191621;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDY1aipJjGB/BqxxBZ4BKWza7WvHZ9wKmJrTLJkJQao=;
 b=A/pW1jEeVplyfvXjihPEWBVuKS0q+tTy3JIWET895Hwa3hfYgyOg5eB0GR2DHDCwzP
 JTk/XQXBbUyrAXRkMgKVByV/B5TJwo63qSBhRi0CRKT+iZKcnNY2S/CknQcMBOs6+/pC
 pO0Z3PQJwra/0ZreZIgmNfb5ke31Lez2O4z4nlRThoD90PMIMt8lrQ/2OdLb6pufGYdq
 76kzsBQHEaOHqcoY0NKVZZ9PhtkcUmN+IhMvgEhrbERqOG0qrbx38+cmxwy3GsvdJsq5
 xT7yPOzPoY8SivYk8aGKM39olWhTAE1JACzKNRF6RvK7UQavzOfH5mI/wdb/t9yUE3jr
 2DGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7G91krArnaKwxjAR5Uot4w/J66LHG0O3e4zeFO80b3QUlBwI7JSZ0u07wUp7TuvrngBuLsIHaOhP58Emgvx9hpmofZw==
X-Gm-Message-State: AOJu0YzV+wGJ+G/tVr/Tr4eDn2rAqAU3H2HPnxtK1mDCgLXuLtsfHyB8
 w/6sqLd7R1KGS1nvEerpeQJgVkl8EANU2ecTufNqH4Lcf849dcTYEASYeHED7u8Pzso2OI+sdPo
 WBgTrcEZDIr7KQ0/8Cu/B+eMkml0=
X-Google-Smtp-Source: AGHT+IEmAWrpfufRcd9Y2JSTbTZnJlFtO6Dc1KlUmDyDgNy50iabMK9ypUSPVPHxbFwRWKWAJdRTW0jCAlbjksq4J3k=
X-Received: by 2002:a05:620a:8dc:b0:792:bd20:422b with SMTP id
 af79cd13be357-79523d38759mr241100385a.26.1717586820539; Wed, 05 Jun 2024
 04:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAMn3X6NjqGmCeVT-X_d_btDKQQJDzz7CnTzOb=62np75VumhDg@mail.gmail.com>
 <5b08ad9c-8ed3-4877-b95d-f5d0ca693fb0@linux.alibaba.com>
 <CAMn3X6MJiPdB9s=h8wyNQ-=LoWcOMghj3K1KOk-V-pMvyen2fw@mail.gmail.com>
 <0d843d6d-3561-4a03-9fa1-94152551f935@linux.alibaba.com>
In-Reply-To: <0d843d6d-3561-4a03-9fa1-94152551f935@linux.alibaba.com>
From: jianqiang wang <wjq.sec@gmail.com>
Date: Wed, 5 Jun 2024 13:26:48 +0200
Message-ID: <CAMn3X6M-Lmmh9rH6k1E_+u2aOEyViwM9nb2f9=p_ZXD+s20d7A@mail.gmail.com>
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

Hi Xiang,

I just checked the second crash, the patch can solve this issue. Did
you also look into the other two issues?

Best
Jianqiang

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=B8=89 13:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Jianqiang,
>
> On 2024/6/5 19:00, jianqiang wang wrote:
> > Hi,
> >
> > I do have the crafted image.
> >
> > payload_00500, payload_00763, payload_00846 can be used to reproduce
> > 1,2,3 vulnerabilities respectively.
> >
> > Each image is a hard drive file and the vulnerabilities can be
> > triggered by performing the following operations:
> >
> >      struct udevice *dev;
> >      uclass_first_device_err(UCLASS_IDE, &dev);  //detect the block dev=
ice
> >
> >      fs_set_blk_dev("ide","0:1", 0);
> >      fs_ls("/");   //mount the first partition and list the root direct=
ory files
> >
> >      fs_set_blk_dev("ide","0:1", 0);
> >      char buf[10];
> >      buf[0] =3D 0;
> >      buf[1] =3D 0;
> >      buf[2] =3D 0;
> >      buf[3] =3D 0;
> >      loff_t actread =3D 0;
> >      fs_read("/a.txt", (ulong)buf, 0, 5, &actread);
> >      printf("fd actread %lld %x %x %x\n",actread,buf[0],buf[1],buf[2]);
> >   read the /a.txt file
> >
> >
> >      fs_set_blk_dev("ide","0:1", 0);
> >      fs_read("/a.txt.ln", (ulong)buf, 0, 5, &actread);
> >      printf("fd actread %lld %x %x %x\n",actread,buf[0],buf[1],buf[2]);
> >   read the /a.txt.ln symbol file
> >
> >      fs_set_blk_dev("ide","0:1", 0);
> >      fs_unlink("/a.txt.ln");  //unlink it
> >
> > The second and third may not trigger a crash however, can be observed
> > by inserting logging before the memset/memcpy function.
>
> Sorry, I just found that this issue was already fixed in erofs-utils:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/com=
mit/?id=3D884866ca07817e97c59605a2fa858a0b732d3f3c
>
> Would you mind checking if the patch above fixes the issue?
>
> Hi Jianan,
> Would you mind backporting this patch for u-boot?
>
> Thanks,
> Gao Xiang
>
> >
> > Best regards
> >
> > Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=B8=89 05:10=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>
> >>
> >> On 2024/6/5 06:53, jianqiang wang wrote:
> >>> Hi Das U-Boot developers,
> >>>
> >>
> >> ...
> >>
> >>>
> >>> 2. in file fs/erofs/data.c, function z_erofs_read_one_data, the node
> >>> data is read from the storage, however, without a proper check, the
> >>> data can be corrupted. For example, the inode data is used in functio=
n
> >>> z_erofs_read_data, map.m_llen will be calculated to a very large
> >>> value, which means the length variable will be very large. It will
> >>> cause a large memory clear with memset(buffer + end - offset, 0,
> >>> length);
> >>
> >> Would you mind giving a reproducer or a crafted image to trigger
> >> this?  Or it's your pure observation.
> >>
> >> Thanks,
> >> Gao XIang
> >>
