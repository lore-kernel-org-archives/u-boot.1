Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A14C27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1ED88300;
	Wed,  5 Jun 2024 16:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YvnoRhho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A079D8836C; Wed,  5 Jun 2024 16:08:24 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E6788250
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jnhuang95@gmail.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5b2ed25b337so4208754eaf.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717596501; x=1718201301; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NS9X0ttGI1QGn/y/kBtGJPvmJqB/K9WQNk46ZATcEBs=;
 b=YvnoRhhoHn3gRPQZBFJPthHQfwta0sq1SbvAaB5w/h44t3oofHE8qyGSws6BWxh+Dj
 gwvv4NMjVAkBYa1f0kjxL4XtPPyf3+7eUYGumsbivnw7qX4XA98pLaGsQqaOD/5zvn/R
 eeRqkCrgequn/u/WsygVrevwQaupfIWB0NShOSe1Mh0H+dr+j0i8+yMb9n8hzKAmQl61
 2B0zOUhKDD90VzRnkNccFB+UYl8ho0LlE4dO7KkZF9uxZoEnA9hXHaKFsBC/X2ShFKL9
 LTBEOuACg8UhRRc7kesNRfUstCrEjrY8apead19Pf3ulqEsrtvpB0rY4XkwgBQFKitsy
 93IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717596501; x=1718201301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NS9X0ttGI1QGn/y/kBtGJPvmJqB/K9WQNk46ZATcEBs=;
 b=EzZlp2cxzQPHX3f6AvqWxMtstu3x3AuYwpU/WQxsjZxNnFraI7M7iokOVUrN+4TZ3D
 k67/bTUstrcRa+xp7ltTxziNTVQcDhRpLu0bBytqPeei3gFd+1HtSfyDcXT8xCd0AGmp
 41JXnOKiWI/+UJUKGHcVLsx4HkcxYZiMayg1mZ0XrG/zZWs8raigqP7JvzE40IDezcAd
 YrJMrcP58EeeH5BLYg74duyYlZRs38sKia8gdO4BPZWBMYHKlnT/nGet4MT0ERYXBu1/
 pMjbHUUt7eTvGW3sFcbFsytIXvWeM5d4ZR3Q8YIsvnda4g5t7SrnruxpF4hKsjAC/t1Y
 WQQQ==
X-Gm-Message-State: AOJu0YwC8XF/WmN1Jh1hG3swGZW+9YCP96l3scfOaI+fbGbIXXlnmqZt
 pMYPFJBae/MoIL0YNoDdVwz31j6h4rQtgdhKo2e9Eb7b8ldK+MPs6LghdtX++IR0BWfglOXgJlg
 VzTaATKM2yv1TKf0SN1Zh3fcWhqY=
X-Google-Smtp-Source: AGHT+IHr9FCjiyG+iRVecCuS/QVNq7f+ZtGuhMUY7fUoWnTBezUJPXfqSes763O1mbVzoVaqX/09OZQt6eGp+z+sspM=
X-Received: by 2002:a05:6358:7e45:b0:199:520e:f1b6 with SMTP id
 e5c5f4694b2df-19c6c7afe43mr305866155d.19.1717596500533; Wed, 05 Jun 2024
 07:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMn3X6NjqGmCeVT-X_d_btDKQQJDzz7CnTzOb=62np75VumhDg@mail.gmail.com>
 <5b08ad9c-8ed3-4877-b95d-f5d0ca693fb0@linux.alibaba.com>
 <CAMn3X6MJiPdB9s=h8wyNQ-=LoWcOMghj3K1KOk-V-pMvyen2fw@mail.gmail.com>
 <0d843d6d-3561-4a03-9fa1-94152551f935@linux.alibaba.com>
In-Reply-To: <0d843d6d-3561-4a03-9fa1-94152551f935@linux.alibaba.com>
From: Jianan Huang <jnhuang95@gmail.com>
Date: Wed, 5 Jun 2024 22:08:14 +0800
Message-ID: <CAJfKizoD1=DwDYYF_5RzL7jNz5q19t5ZH2sbGBw5GNv+5MwhoQ@mail.gmail.com>
Subject: Re: Several potential vulnerabilities in the filesystem
To: Gao Xiang <hsiangkao@linux.alibaba.com>, jianqiang wang <wjq.sec@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On 2024/6/5 19:18, Gao Xiang wrote:
> Hi Jianqiang,
>
> On 2024/6/5 19:00, jianqiang wang wrote:
>> Hi,
>>
>> I do have the crafted image.
>>
>> payload_00500, payload_00763, payload_00846 can be used to reproduce
>> 1,2,3 vulnerabilities respectively.
>>
>> Each image is a hard drive file and the vulnerabilities can be
>> triggered by performing the following operations:
>>
>>      struct udevice *dev;
>>      uclass_first_device_err(UCLASS_IDE, &dev);  //detect the block
>> device
>>
>>      fs_set_blk_dev("ide","0:1", 0);
>>      fs_ls("/");   //mount the first partition and list the root
>> directory files
>>
>>      fs_set_blk_dev("ide","0:1", 0);
>>      char buf[10];
>>      buf[0] =3D 0;
>>      buf[1] =3D 0;
>>      buf[2] =3D 0;
>>      buf[3] =3D 0;
>>      loff_t actread =3D 0;
>>      fs_read("/a.txt", (ulong)buf, 0, 5, &actread);
>>      printf("fd actread %lld %x %x %x\n",actread,buf[0],buf[1],buf[2]);
>>   read the /a.txt file
>>
>>
>>      fs_set_blk_dev("ide","0:1", 0);
>>      fs_read("/a.txt.ln", (ulong)buf, 0, 5, &actread);
>>      printf("fd actread %lld %x %x %x\n",actread,buf[0],buf[1],buf[2]);
>>   read the /a.txt.ln symbol file
>>
>>      fs_set_blk_dev("ide","0:1", 0);
>>      fs_unlink("/a.txt.ln");  //unlink it
>>
>> The second and third may not trigger a crash however, can be observed
>> by inserting logging before the memset/memcpy function.
>
> Sorry, I just found that this issue was already fixed in erofs-utils:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/com=
mit/?id=3D884866ca07817e97c59605a2fa858a0b732d3f3c
>
>
> Would you mind checking if the patch above fixes the issue?
>
> Hi Jianan,
> Would you mind backporting this patch for u-boot?

https://lore.kernel.org/u-boot/20240605140554.1883-1-jnhuang95@gmail.com/T/=
#u

Thanks,
Jianan

>
> Thanks,
> Gao Xiang
>
>>
>> Best regards
>>
>> Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=88=
5=E6=97=A5=E5=91=A8=E4=B8=89 05:10=E5=86=99=E9=81=93=EF=BC=9A
>>>
>>>
>>>
>>> On 2024/6/5 06:53, jianqiang wang wrote:
>>>> Hi Das U-Boot developers,
>>>>
>>>
>>> ...
>>>
>>>>
>>>> 2. in file fs/erofs/data.c, function z_erofs_read_one_data, the node
>>>> data is read from the storage, however, without a proper check, the
>>>> data can be corrupted. For example, the inode data is used in function
>>>> z_erofs_read_data, map.m_llen will be calculated to a very large
>>>> value, which means the length variable will be very large. It will
>>>> cause a large memory clear with memset(buffer + end - offset, 0,
>>>> length);
>>>
>>> Would you mind giving a reproducer or a crafted image to trigger
>>> this?  Or it's your pure observation.
>>>
>>> Thanks,
>>> Gao XIang
>>>
