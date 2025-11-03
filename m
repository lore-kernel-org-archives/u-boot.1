Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC0CCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D182836D1;
	Mon,  3 Nov 2025 14:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NivVwzWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D8ED838A5; Mon,  3 Nov 2025 01:14:12 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125F883642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 01:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4ed101e8486so54505581cf.2
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 16:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762128849; x=1762733649; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Unfd/OgoDQVlb37zMuiPry9XQVolNRTCQu+fg+mRqCc=;
 b=NivVwzWirylSdeg0/nRMMVpqk9oBJRXmxsar7JgX6JwxpuHn9Sz+K7yugLd3U3m0gX
 X/PD1drqX3ja3HGDv1niHg5Xn94jkuUfkEs8fs7FPC+TpdhKEOSOdBgEnuqzprryXZih
 HFcR4QP/jGQ4H83/ci6dSxDvpOZNngntKO5mbkfL/uE8iX1skQ5VuLlU27C65INj0XUf
 Ufb/VML/NT8SQSAU+etYgvYPwuTmQzj/lpO+ZSoleb+p7eJ6IN3hsprqeXuVuNTJp2tQ
 P+n/bBFCcM25mT+TCw/JxOaTxfKz0J7KC2Hk72qoCbzWpc9B9cHTUZQJSCdLfVl+/1aa
 HGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762128849; x=1762733649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Unfd/OgoDQVlb37zMuiPry9XQVolNRTCQu+fg+mRqCc=;
 b=FfS/pCNFYDlnWoVaW0Atw21s9L4LJlP3cezDXqtOO2ZadlJKh3DI6e4nXvXxJ/qTry
 gASewv4iH/VX5koIIaQQjFs5PCfofXNLEovDkwhCntySUCkQyuvZuwZtD1Wt8PRUFzep
 zl37tKJo1GqRYXz7zAwjXK16L9os0twrNLn327h8FgUxt6d/Hp1n1Yxif3tGNC8+LHeA
 QnZMVPXYzNF54C5rhKgYPBklVcZ3MqrXcuPvjDf3w5GQr/7jATDuZdLztDF6zHotME11
 NsfQXGtk/EvhwsDCH4YsILBlUE6LWz5X73ZRvlPXflllMy5GEfA+1wMMxHobORfm5CuS
 OfRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWIbjKDtwww+ypYzbaMe+WH3soNGIKt6TrmuozXwSgtau93jFS6p1fC3sZIXQ6KxgQSc4XHco=@lists.denx.de
X-Gm-Message-State: AOJu0Yys7ksPW8caon7fBCiDzkUNAfNsXTb0jNpJ2hhHS9diP5X1anUn
 9JvzmEMOUGXpyYwe7orPO8Tx9NCmxcW12SXcz8mi/L1U/iH9nz3cMYBiihjnMbHpjYNP2kwFuPe
 aLp8vXvP1z0q9KnbcY3193MX3XaaQ9Jg=
X-Gm-Gg: ASbGnctLuq/uI1mGPYroj3LAcruy7Wg8YSojXVPF9ijSaJRDtG91lustZH10wW4ZuyJ
 Kj7Am+vqp9AT7xossrd2g8n9C9WSu1blLVGJiYS5PRvHgZgi4vDDx+Peq/9PC4aZl6e11dZyCRl
 dZdWj4fDeOqTez5LrLtSSTVFL3zXVMBx+FzMrbvrgJP2da7I+/asFYex4IGqTiD8fEAumqLnmBi
 7kmI8gwkP5I9Gr5PWxemEATJwPc5lBjReGOo2xFpxbMsNDzHVeI06IN001yerjzHxabIXaVLY/K
 y6FJdX1lBkQsHhTm7/i055b0xnimlA==
X-Google-Smtp-Source: AGHT+IGxaunjyyxiP8eAE1Qpun3jW7pHXVVCQXu+Z56neret4qsbbC+6pNOmXdwv8hfaf8xyWb4+JWRX4dt2IRb8yU4=
X-Received: by 2002:ac8:578b:0:b0:4b7:a8ce:a3fc with SMTP id
 d75a77b69052e-4ed3100938amr137173391cf.66.1762128848773; Sun, 02 Nov 2025
 16:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20251006124915.13647-1-lucienzx159@gmail.com>
 <2f894c99-3279-4d8a-8e09-b002a73d85bb@mailbox.org>
 <0c7f155a-3bdb-4d4b-8f2d-3b79eec3cbc2@gmail.com>
 <a3e748e8-8785-4f74-bed5-5fd1c517d44f@mailbox.org>
In-Reply-To: <a3e748e8-8785-4f74-bed5-5fd1c517d44f@mailbox.org>
From: Lucien Jheng <lucienzx159@gmail.com>
Date: Mon, 3 Nov 2025 08:13:58 +0800
X-Gm-Features: AWmQ_bnhlFINM_koTzTesT0UNvMDWBEYeExS8h8hcw4rc9udV_yCCd6nh67_LlU
Message-ID: <CAHvkZ4ZS+Nv=Nueqfve2ujJxwD0RgruQGi51TH6YNFqiEZd3Pw@mail.gmail.com>
Subject: Re: [U-Boot, v2, 1/1]net: phy: add paged PHY register accessors
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: jerome.forissier@linaro.org, skylake.huang@mediatek.com, 
 s-vadapalli@ti.com, paul.barker.ct@bp.renesas.com, 
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, 
 lucien.jheng@airoha.com, Frank Wunderlich <frank-w@public-files.de>, 
 Daniel Golle <daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

Hi Marek

On Mon, Nov 3, 2025, 1:15=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.org> =
wrote:

> On 11/2/25 4:34 PM, Lucien.Jheng wrote:
>
> Hi,
>
> >> On 10/6/25 2:49 PM, Lucien.Jheng wrote:
> >>> Synchronize paged PHY helpers with Linux v6.17.
> >>>
> >>> Add support for PHY devices that use paged register access by
> >>> implementing the following functions:
> >>> - phy_save_page(): Save current page number
> >>> - phy_select_page(): Switch to a specific page and return previous pa=
ge
> >>> - phy_restore_page(): Restore previously saved page
> >>>
> >>> Also adds read_page and write_page callbacks to the phy_driver
> >>> structure to enable driver-specific page handling.
> >>>
> >>> These helpers allow safe access to paged PHY registers by ensuring
> >>> proper page selection and restoration,
> >>> even in error conditions, which will be used by the Airoha PHY driver=
.
> >> Are there any users ? If not, this is dead code.
> >
> > I have checked the latest Linux kernel, and these functions are
> > currently used by several vendors, including *MediaTek, Airoha, Marvell=
,
> > and Realtek PHY*.
> >
> > Therefore, I believe these APIs are not dead code.
> This is U-Boot, are there any users in U-Boot ?
>
> If you plan to use this in a new driver, then please send this together
> with the new driver.
>
Got it.
I will send this together with new driver.
Thank you

>
