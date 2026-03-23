Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB18CF46126
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E2084099;
	Mon, 23 Mar 2026 15:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="YlPkgrxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D09E84114; Mon, 23 Mar 2026 15:06:46 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4C28408D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64e8c7f5082so3755851d50.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 07:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774274803; cv=none;
 d=google.com; s=arc-20240605;
 b=ZZ/XSj6VG+ku9GalY4eHHgmGdvicUF8xTjU9w7bq5clni0IRqq7b5dQgvJeVT8r6vl
 DjUW9Rd6rin5i0mJGE5aiopqrQ79pEM10kDDmGTinIVPj4jBUqfQvbsRJAGaVxGHjMxZ
 3gSYBpIwaXtNaEi5+CFJ3KfE0tAZxB605gF01eP+Ib1wkPSeuAa2Ctsw2FfcsAqYbofG
 0rvlL++/0aHXbscLBJObPuZi3WFJboQqucAS82aehWwEdu0aqXkFp9E/v0we11eWDu8Z
 iw+idFpvIhPdZRVZhnoUAQOPTR7WtkTWmC+K2cgLu6MC6PGZqrH95wb367St9okzjk/b
 +OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e3XAlBfczEfVipfZo11BZFzeDVrWkjSUEbgr2mBwwlQ=;
 fh=NdMCHlleW6/UV05/Kaj+Jp3sC5JOZU0FO/siHgghkk0=;
 b=C9oRa2nHgV2diB78979PIw8qAYZ0Mv8MfX+yww5aY6IX06mI79512KASO4uY2HAMKc
 vpwXRd6q5vmvhmlKpaEFFk6UFGwBJyszapaU/QFRsf45JzWJExNbD5D7eZzB86K8eM7e
 oWkcS8XwJPu13vucJA3N7HireH7IY1ArzWzbQ106LSAqAYv659Eq/9DFI76MD7+sbCKi
 NYXsR+SKU/8RW74GpOiCYZ39JVbzbfQInJ3qKteFGLUFN9mSQpgTHMYkJnJodSS7deth
 NzJeM1QBGEh9sBjJCpipylBM5KRJHGgpT5+KuQSVTL5dhGp5z/cAc0wqna81/eCyHmQs
 SkLw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1774274803; x=1774879603;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3XAlBfczEfVipfZo11BZFzeDVrWkjSUEbgr2mBwwlQ=;
 b=YlPkgrxhTEAE9R5UyiyKX5JkBHqgdG5b9HaJYg1bpdkO//dCuZQty6D68M0T2ITSCw
 WvGi5mWiS0xfCLnDVlBcEjlFPuzPypcx3iOKyVOOk8XoErGLcXp+r6pbiLj3xwxaBexP
 nN6DKdCgMwPCvS/KM7aY+r2O7hZpus12RxjJuGjR7L/TNTME8RyhedELumoanmre7d64
 yIsccsOHtFtpsrbdFGyHfWXHaNvdOLJB+/YsudzRjevw6gT+Glo1dBs8vJhp3BeInT92
 suvI1HIO15K+0xjHk8TswkHX5bnGI86FawDDylsQU7OZndeEx8eenb/++KE6mn5VrulP
 COBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774274803; x=1774879603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e3XAlBfczEfVipfZo11BZFzeDVrWkjSUEbgr2mBwwlQ=;
 b=K9mk/f/ptXfV2KRy3NwfKIYCav1bxtImQ771DfmD4yFwnc0f0hy+CYYNVLLH0efTAC
 UvJCFo56fx6xT+WEiDHjhusLi++N+Q4En6ts1fUFQeyfnmP0Bro7gIoqSXjXzd2ehDmp
 fN2nBOkIZLCjzobjOZ14f1b1LtTMLl5AdfO79/rTTOloZ4poWVy/J3VDXLCdEYONj9w3
 2vk1I9hgAfaQcul7aLIiyRwE/VMD/z9n+qEMlUegMVhoZcOAVndsFoQw6cgxbyKwAuuW
 uWnRWRobpzNDnxEaReP4XbnBhn2RByyV8X72zfUZjlY7AyA/5vr3lQpELVIs9Wjm7rkP
 m7EA==
X-Gm-Message-State: AOJu0YynyK3BvI+amiso10z6uEMTz6RDaunxbntXvrW4t7rwzUmkAtvc
 BNQ9DeHYDmisArjgFM5jPNtrgqm7IMByZ7B4wPhlDlIUwan45zVUX4LyOjbue4+deBErMyq1AZE
 hZMC1DmMoUiNQcZml3noG1Map38e6Li8BipZ+jL2y
X-Gm-Gg: ATEYQzxk62cPAmmBWqOnjPEuTZhbgQyFL+jlHHjg3AtNngRl1N7ezasueEvc7bl5n6J
 h8Xv9L2K+qq7Ex/xKqe9jJP/eff4cpASVB37L+jjXmgRDw8RvkFSuV8K41O5/4V9FhGY+m6VBOe
 wjbjGxuQhQroAmPmhzpRMr7vdslKHCmVhTFSdxy1SqA3M5BvDQxjpMBCMLyReYA0xr1iM2ZIEDP
 kY8lKmV93HoIWk8K4+lwimtAjGDRp59Dez8hW5DY8QSM1Pk3lkVMvsJxzZtNyEzrbSJVDhQtzAX
 x8Mjax6r
X-Received: by 2002:a05:690e:d45:b0:64c:aa84:762d with SMTP id
 956f58d0204a3-64eaa6a8e89mr14311608d50.7.1774274801266; Mon, 23 Mar 2026
 07:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251017035719.122911-1-vlim@gigadevice.com>
 <20251017035719.122911-2-vlim@gigadevice.com>
In-Reply-To: <20251017035719.122911-2-vlim@gigadevice.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 23 Mar 2026 15:06:30 +0100
X-Gm-Features: AQROBzA0O1bIghnS-1KLpjx2kvqkCsMKDXoNqyWFMzX1FluHAUuZpXoJBLOoA64
Message-ID: <CAHTX3dJbRkWmpQE_Q2bbhHBqqZiH9VAfwu-5t=N1thhBagL+Lw@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] MTD/SPI-NOR: Add new device
To: Victor <vlim@gigadevice.com>
Cc: u-boot@lists.denx.de, git@amd.com, venkatesh.abbarapu@amd.com, 
 dunaev@tecon.ru, han.xu@nxp.com, alice.guo@nxp.com, 
 Takahiro.Kuwano@infineon.com, trini@konsulko.com, tudor.ambarus@linaro.org, 
 vigneshr@ti.com, jagan@amarulasolutions.com, havish.mutya@amd.com
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

Hi Victor,

it has been assigned to me in patchwork.

Subject is very generic. You should say more there.

p=C3=A1 17. 10. 2025 v 5:58 odes=C3=ADlatel Victor <vlim@gigadevice.com> na=
psal:
>
> GD25B512 with ID C8401A
> This is a 3V 512Mbit SPI NOR Flash.
> Link to the datasheet:
> https://download.gigadevice.com/Datasheet/DS-00975-GD25B512MF-Rev1.1.pdf
>
> Tested on Xilinx Zynq-7000, on Digilent Arty-Z7
> Test result on cover page.
>
> Signed-off-by: Victor <vlim@gigadevice.com>

Are you just Victor? I expect you have a surname and a given name.
Please use both.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
