Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637C3CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 09:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C1884332;
	Thu, 27 Nov 2025 10:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cu8jLl/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB9B684333; Thu, 27 Nov 2025 10:42:50 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4CF8432D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 10:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c7660192b0so517060a34.0
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 01:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764236567; x=1764841367; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uipUWelYz+tQDh4ABs37yuTRcGGgEwRV3YYw6MtkXks=;
 b=cu8jLl/TzfIwzD1WaKt68HpDpTqwptOchgBh2PHOSDe9wCvC5y3r8PNLEboVJOlZDY
 NPsLhazRsZonkRwZXc+jVZEQGfo1/3s6YsahwfqZgTGBvIc7tZZ7MniEpKZalU/ZGZrf
 +81qgYgHJf6xoy6K/JjDyEwQHIKBkgrQ/JnVTqoxrz1y8dAGVnOacGnUiVmj2Qe/glJL
 PnH0kUxVVYjk0hhB3n3csJmo/1MwJLvlVcHycYlyDX/GYPMFzNsUBgY9TTIN5Z3xWYym
 jjHRJUqF4+GH0ruQLko4EhcMOkBp1mmqSss/1AGT94OigpKoq+182HFC+AsxoxZ8Oj/v
 G42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764236567; x=1764841367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uipUWelYz+tQDh4ABs37yuTRcGGgEwRV3YYw6MtkXks=;
 b=SEDVSxUcnkDPzitc5CWLBAZqQJ8I91BO0UxY4XjxtgnwwHgv4nUDbq82QKlJXKc2U1
 OeJU479cOvmEeANm55MROLiPqPMLCtMNR3wxWbIfiStObqLZB315sZR+DvrokgVBMkoT
 rM6EkgHTWVax3EHlGUcGjDxfvzonLmFQ1iefTRdyyHZZyJbv2jQKqENwf0gQpm9wqdb2
 /QWvwXPC/7zXvxoSsTfI5SRPXGjyMU8qHAjxQjj68NEUoyPivYttqGsMhpOEA1a+ixNn
 sMYDExx5QDJkeYDqPowAobuf6guBVRB4rY3f6Qs+3/5youvKkD9O82/MVsbMPzsyAVvj
 aByw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiIKLFdBEZ/xnBcZH9FZae0lhTm08C4wINpmu9v1niYbsT4xZgQ0Hdv2CnUSD4VX2D2N/tUlA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw33biMJZ+HcCQaIVRM4fwfyDjtqHvRfFTC6wJ27iVlrQ59Q7Ka
 H0vAyxplfb+LmIZkyzmFiM8fQEmPKwK3AZlRr4jL2ag01VvP8GeNbrGNIcR8U+ZkQ2uAR1tosSz
 Fw74/ZI7WtH/AHqTBbiEY5z1KOBy3oQM=
X-Gm-Gg: ASbGncv0DxnD65Ipij0xyagPo7UFGriPVwNP2FLKS2dPg0j51+2vtAh2mRWvVIHjd39
 h3lOqfi9qNqpWX0ZXnXDKelrKXiBoum9gDb7dDn91DLGMs6snNykD9z7TKu9rty8dH9ySXzPswU
 G2nHHoEOqvLvG6bu5DIS7in3O6a8DPd7CMcBejjPkMT3X0FK3TX+nid7Dm1xU+l1a5NnD81EdLR
 JZhjysKYiKK81IybQCIF2C98Ck7G1XEip1Cjkyf3VuPQEBVKUd/IK/GiM+cGUMWNh20z8w=
X-Google-Smtp-Source: AGHT+IG5C5Gk1WVmdORfB1IvVGDS+ZMa4EwR2gAHC2J9J+CIz4QoGJhXTJ+kqz97e1AyO2EWjDYCE+rz4noKNo+jDP4=
X-Received: by 2002:a05:6830:2647:b0:7c7:18e:913a with SMTP id
 46e09a7af769-7c799071e43mr11220171a34.19.1764236567044; Thu, 27 Nov 2025
 01:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
 <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
 <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
 <0c42e18e-60d7-417d-9b83-dea8ffd4a362@siemens.com>
 <CAN7C2SDH6g0PgDUsu8hEnEA4yr6z+YA5afWhK9-D7-7wBbe33A@mail.gmail.com>
 <b977adfc-f16e-4436-91eb-8824932379af@siemens.com>
 <CAN7C2SCiTqJDK2ZVjJ_859NEDg6tD3KWQqzVHqqmbyM8+aBvLQ@mail.gmail.com>
 <d4b1acef-fd8e-44d2-b583-450d4c61190f@siemens.com>
In-Reply-To: <d4b1acef-fd8e-44d2-b583-450d4c61190f@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 27 Nov 2025 17:42:35 +0800
X-Gm-Features: AWmQ_blvzk1WShzBs69nHddUJH8yPjbgZ_C0wh66zGcSBZZPgq-k1TfVcSyoLso
Message-ID: <CAN7C2SCQkBfbq1f7b6W2sm9Q-rtB3+5a5NUMOrXWCite7BTLNw@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, 
 u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
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

> My patches address master (of two weeks ago at least). Please have a
> look at
> https://lore.kernel.org/u-boot/cover.1763140421.git.jan.kiszka@siemens.com/
> (or https://patchwork.ozlabs.org/project/uboot/list/?series=482132), and
> if you find something that is changing in the wrong direction, please
> comment on it. There is at least one known build issue when you disable
> CONFIG_SYS_MMCSD_RAW_MODE.
>
> Jan

Will take a look more a bit.
Before that I want to confirm s.t.
You want all three modes to support combined SPL+UBOOT
aka u-boot-with-spl.sfp in A2 parition?
So simply speaking you don't want u-boot.img in FAT?

Thanks
Brian
