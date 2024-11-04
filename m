Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F34D132A8
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 10:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0E488C0F;
	Mon,  4 Nov 2024 11:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6kfbe/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE828885D; Mon,  4 Nov 2024 11:19:28 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 378A688C3E
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 11:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.belisko@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb58980711so35018081fa.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 02:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730715565; x=1731320365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NYHYbQcwafiim1FoKS6gvURO4RVfJ9kqJLxTnBPoBZk=;
 b=E6kfbe/Yj9/xiq/8yS/UfHXn7mejbIrJqstkg27JLlbhYyICaVUz7gNeX4WHRIu4tV
 0m6K9kzLGYyxEDzbvWgBP6mGO1+L/7JlZkipQsEHpERGoxEChmXv3Vx1fTw3FHKgaDRP
 MkcEECLBDrf46xVg8Kfs3nCXlTXmB+Oq/QrSz6TALUOf4QaBx2PqBYKEHvWv/SBE1MCV
 +OY1CWa4ZGO7quOlUFokoN4/2aLHXvnDwlqNStNqm437pfpvYG1ddyrz2rxgyEnBOGJ3
 0ftUJvKHbxOnOm6D5m/IZxBkfQ4ZLNISyyhbfjZJkbtgEj6qj4ayZpWUhqvsGgFTmCxm
 tJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730715565; x=1731320365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NYHYbQcwafiim1FoKS6gvURO4RVfJ9kqJLxTnBPoBZk=;
 b=Js22Tm7zG8qto4f73sINUNObHtaEbPCR9YRL63Biq37FMbXdJ6LZhXqvDZ/XTk2DRY
 WKoPbKfb2dnmh0JbrTzW/Zx0Nq/GShvxEtkTWL/kI7GiqgXMFuoOBcQZQD6qFBp9V3IQ
 XbZNdl13Gtw1wjg/nbUdsY1H0RvnIhj8efIdbrmBjOelGWUtRaJmmwNJuBkhzUmAml29
 HFHM+7PslDUe1JYmpXDjBX1+E3dXa4yS/YmfIzDQSo6rlU14+mWElpHqC+1JvIm+iWWx
 I7F5EQuivLPNXPSh1wm05l26uhe0KLa0c+aLe1SlXNM4knHnotoS2pFvND7ejFjXfrXt
 hBZA==
X-Gm-Message-State: AOJu0YyVsAJjsPvNorinvfRuIqe85OrUUwj7lPq6zN1gxLY0Bjmdja73
 48/Ejh2uFDm2kzjtvhRnSoc5ASyrjUYzHwE8Vt2lRi8MJ8ejcDEtC4N61yqd42EdJemV29PXH5r
 aiOdr1XcEAzXZ1mgHleW9I/2Wh+U=
X-Google-Smtp-Source: AGHT+IGszRm3gvUUKDiM4itqTi/hEYg22TTRbaXUrjWESuJlWowW77S/eBA0TRa9iTpDwsdnls9z7mhabusBs3vPPuc=
X-Received: by 2002:a2e:4c01:0:b0:2fb:4ca9:8e2 with SMTP id
 38308e7fff4ca-2fcbe062390mr106503721fa.28.1730715565019; Mon, 04 Nov 2024
 02:19:25 -0800 (PST)
MIME-Version: 1.0
References: <CAAfyv37co294aQKffpt0ce=ajYutBrcnU23P=pi=s6YN5gT3Fg@mail.gmail.com>
 <7e901715-35bb-43b9-9471-d8f4573cbf61@kwiboo.se>
 <CAAfyv36fkumDdFkh_vBrYnc-YKjT5Q18hAcje8+2FHtw7Vw7tA@mail.gmail.com>
In-Reply-To: <CAAfyv36fkumDdFkh_vBrYnc-YKjT5Q18hAcje8+2FHtw7Vw7tA@mail.gmail.com>
From: Belisko Marek <marek.belisko@gmail.com>
Date: Mon, 4 Nov 2024 11:19:13 +0100
Message-ID: <CAAfyv36ydh07vEN44kGkZ5jphZXyBr=qmfNymYip0eseTdX8SQ@mail.gmail.com>
Subject: Re: radxa cm3 2024.01 mmc write error
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Wed, Jul 24, 2024 at 9:38=E2=80=AFPM Belisko Marek <marek.belisko@gmail.=
com>
wrote:

> Hi Jonas,
>
> On Thu, Jul 11, 2024 at 10:33=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> =
wrote:
>
>> Hi Marek,
>>
>> On 2024-07-10 21:26, Belisko Marek wrote:
>> > Hi,
>> >
>> > I'm playing with radxa cme and mainline u-boot 2024.01 (present in
>> > scarthgap yocto).
>> > I realized that mmc write fails all the time like:
>> > =3D> md.l $loadaddr
>> > 00c00800: ff7ff7eb fffdffff fffffff5 ffff9fff  ................
>> > =3D> mmc write $loadaddr 1fc0 10
>> >
>> > MMC write: dev # 0, block # 8128, count 16 ... mmc write failed
>> > 0 blocks written: ERROR
>> >
>> > 1fc0 =3D 8128 is according to rockchip gpt table u-boot env partition.
>> >
>> > Is there something I'm doing wrong or its regression?
>>
>> Please try with latest U-Boot v2024.07, following fix has been part of
>> U-Boot since v2024.04-rc2.
>>
>> rockchip: rk35xx: Remove use of eMMC DDR52 mode
>>
>> https://source.denx.de/u-boot/u-boot/-/commit/ebe293bae79d8c64d9cd428404=
4e25ddadd074b5
>
> Thanks for the tip, it resolved an issue.
>
I've added a small u-boot change to store redundant u-boot env. Basically I
split the env partition to 2 parts. When I set env in uboot like:setenv c 5
and boot board with fw_printenv I can see the value is c setto 5, but when
set env in system with fw_setenv a 1 and reboot board such env doesn't
exist. I'm using u-boot 2024.01. Are you maybe aware of such issue?

>
>>
>> Regards,
>> Jonas
>>
>> >
>> > Thanks and regards,
>> >
>> > marek
>>
>>
> BR,
>
> marek
> --
> as simple and primitive as possible
> -------------------------------------------------
> Marek Belisko - OPEN-NANDRA
> Freelance Developer
>
> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
> Tel: +421 915 052 184
> skype: marekwhite
> twitter: #opennandra
> web: http://open-nandra.com
>

Thanks and BR,

marek

--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
