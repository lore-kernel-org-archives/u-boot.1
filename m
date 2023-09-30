Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14B7E748F0
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 23:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7ECE86F24;
	Sun,  1 Oct 2023 01:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lWhHf1QK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27FE9867D6; Sun,  1 Oct 2023 01:00:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177B9867D6
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 01:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696114849; x=1696719649; i=xypron.glpk@gmx.de;
 bh=Q80LlRAPaL84L4E9fcjF8sk/WTVEylnEo0bA/2Tm6ic=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lWhHf1QKOMbONG2i0qEa8JEY847FurffrmycL47khbMq21ke7d02t8jUo39oxkAhcu8QKLQcf56
 yObaiiiU4nUjFTB/sBDLrd3VS6J/IiVv1RADwO6joDO5k8Y3Kiee/0jRTB/bDJggPPP2Ps51K5pv0
 CinJsASurp+0iYugbuuJdFsv8JUB8yO7Wq3dLxJZQNzlEMJBpZHz0C8w9w3I+WNYlLyD32S3Oo6Z9
 JHdBctBmDDxjbub+SzjaMMOFvLucimp2ku0TufS1Ph5bvFyIF1pddPZMgc3/V3Chd25Pma83jc1FD
 tqX0JVKwHm74q6Zph3A3y7PZRazwEB/kLFWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1qlcUf3948-003L0r; Sun, 01
 Oct 2023 01:00:49 +0200
Message-ID: <a4cb0baa-fa92-44be-81de-941866904d9e@gmx.de>
Date: Sun, 1 Oct 2023 01:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fs_loader: Fix alignment of fs_loader driver
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Cc: Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20230930204546.515776-1-seanga2@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230930204546.515776-1-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Oe3EK96EOJsXc+RbvGKn9btNq3f7GbIPreUSb/l5UXVqaHgytsi
 ODVh8AKD4vgNdwDYO7vmF7sEb7m0X9HZX/P0jkRtWUchT2PqcfASCqhCyd9IrynscUGOXBG
 xKfEDh3OaAZQamL9d6jVzev4cbTPCO19puokRocGi/dAbJ6jmbSf23+90qdDia31BwA4UdR
 p5wvKKHAPrOhckYMG/mjQ==
UI-OutboundReport: notjunk:1;M01:P0:41kBs+LTBtk=;yzap6/9qaP5hoiAvd9pE3qnZ+WQ
 fgYo+mzzswUxWjQxUZQh3/cj713fUAXovlYLbvJQ7WoZVbItqqed/IBklNhuIW2dLFRDpt5A3
 1OeVuuSn5FIQSrZ89FVqI/LkAx8dDu0YhaF/Gg+PZUGKNgVe+T7aG8jSadtnorP11U1ii6XHq
 x3Ven+rnkbw42g1Im+qFbMdD8vOLj1LcucXfZCh9f3WWvgPy+YUCl5ZcNscIArvPL6VOWd0Pa
 zKJ9K/Kk5+s+vQjAUEJx7Y/4hyQ//clhWhm6hSQU4QqJ8Z/LC6kNeYH0XkuI2VtitAVnphruh
 R9zALdxjf7NfxweBXGAVrGobwRrWTFO43rc+6DAvnT5aVUCkI0XmcRp2/fey26AYVfNsMzaUW
 H0vzWhNghNzJQKoszNIDSWaLOQhsL7u+0ZI5l6yxkxSyaZXlwbyblTb41D5PlOxkW1UaV/8A0
 Ck+YinLiSX2lip16bhIxRTZIER1f4obJkB0fIwKUJ+PdQxgDl7trCd4Yd7fhaNtLs/bTOcgmi
 hfGVbVd7XAQ1NdzeLV6gAgen5P/xSMfFJoO58beJOMw0wWOOPyvBM0bk+SYmi67DinAUeANWX
 g3sTqX5RPOmjS8BxwLJTzLQYhooBisAlylnGewDpGEaUOpf/7Khf254o0VcCLeOqIArMp8Wkc
 8K0C2KJUan2wXM8cIEwb2m0+R/gSmk60zQHk1pDybkiWWTUVVi48/U2tftxyED8j09ZwXOTv1
 oZfHsx7VohfoFPdtOuGtehGIbGbh3BFRr47i95Lk7CUKLb+oIcpkHu/EzJO6BzW6LGAWSRRJ/
 V2WesfkqZA9LAjK0pn+UKoMQdELxpO/e6c9s9+9eGqWMOtPlmfPXTVkyHtCs42pTlFh/pywLH
 RdviEs22Sb1IO2TzcpIrZO3vbT//RchCqBZfkle1AVvXGIOuAwRX6epJ1NYO0LYaIdlZZYt8u
 2ILuoQt67GVpqdjBMRhZWSCfTp8=
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

On 9/30/23 22:45, Sean Anderson wrote:
> DM_DRIVER_GET will redeclare the fs_loader driver without the correct
> alignment. This causes GCC to use the default section alignment of 32
> bytes. This in turn creates a gap in the linker list due to the padding
> required to achieve the correct alignment, corrupting all further entrie=
s.
> Use DM_DRIVER_REF instead, which doesn't redeclare anything.

doc/api/linker_lists.rst describes this problem.

We are using DM_DRIVER_GET() a lot and DM_DRIVER_REF() rarely.

I have seen that ll_entry_get exists since 2012 when Marek introduced
linker lists into U-Boot and ll_entry_ref since 2021.

In which use cases are ll_entry_get() and DM_DRIVER_GET() really needed?
Or can they both be completely replaced by ll_entry_ref() and
DM_DRIVER_REF().

Best regards

Heinrich

>
> Fixes: 0998a20cfc6 ("misc: fs_loader: Add function to get the chosen loa=
der")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>   drivers/misc/fs_loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> index ccf5c7a8037..1ffc199ba1e 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fs_loader.c
> @@ -316,7 +316,7 @@ int get_fs_loader(struct udevice **dev)
>   		return ret;
>
>   	/* Just create a new device */
> -	ret =3D device_bind(dm_root(), DM_DRIVER_GET(fs_loader), "default-load=
er",
> +	ret =3D device_bind(dm_root(), DM_DRIVER_REF(fs_loader), "default-load=
er",
>   			  &default_plat, ofnode_null(), dev);
>   	if (ret)
>   		return ret;

