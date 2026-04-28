Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BD2FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2A784656;
	Tue, 28 Apr 2026 16:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FTOdM2V4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDF9842A2; Tue, 28 Apr 2026 16:12:35 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5BAD8460D
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-56a9a7e762bso7558953e0c.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777385550; cv=none;
 d=google.com; s=arc-20240605;
 b=dvKdtWhjLd5L91yCddXDObTGTYQfxblUka897RZyoZy4w2zMNY2HgkJdSYHOC/uvHY
 dRpgfelW4Hr2rqUm8pytXwd8Wgw19Zv3euuUf9dIjBhHKHOMgV1ICW6K46j/PqJj451e
 AkKrz7cWifu7e3vt2IgDO60A+UI1pTbJNUsfVDHOldKJ+B7/ypQz8vbW6kZPVtI/Z+5l
 tXi7Ag9x5dBqM52IbD5eeCViWjnBwyyCXk4DpnuoRnBZ9tcedQa+kFQ1wz+KkW4o1sx+
 Z6VF8+D6ZMgoRmF5gAunK1RMRqZ/7bmMHvEOz1iuxe5ilMrFFPtYUSvSrYEUuy+wj12x
 bcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xiEK5ZRwN4orV/wRlbfvIu6lHKGtsLYk+ilus9PrRp4=;
 fh=LieQItRDdrseeqnkSnYbGqnH9zTYBnDdrJyz4vjdYPc=;
 b=Pz3PSKJfbx+fuu1vh9qsulSrBsugIjjzTvHwxCQp7QS9TFBZU3F/0rof1sfFwqUNvu
 6X6VCOhAg5T05gv8ushP8slaQ5UI+CT9wD38sBeR59WNkYWadfZidqmuwUJXEW2WUNIk
 ZlLskJLhJOt6V8lNfZGqJq7aUTqftSGKvh5wM5B8Whm+UibbgWNYUSA6S6E+u3T14BU8
 yl8bgK8ZVTjCykqYuq/IKrYxmbCVbjDAYdfoxJj/ZE7KDGGoSJYMMxweclm1dypv8wVq
 i8/qlKgsoSN7VWIN/6nu792xMPmEFdCb1UvW8Pv+LO4AIsG9NQ71udBkXVFmdGmiJbz/
 2vcw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777385550; x=1777990350; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiEK5ZRwN4orV/wRlbfvIu6lHKGtsLYk+ilus9PrRp4=;
 b=FTOdM2V4sM2AUREwhN5TFbtm36+Ir4ax1yCgZj+M5XaRR2VaEIVjj3T4B+USx1MjJE
 1axGBFkg7+ESpuSPG1CQLl5Z2HJHIDIigsyjA/24AIn6w5Qg21cmhB5ClcF3bHA3hAuZ
 UvGbURsdnQhISZzlCeK76eXH76L2WQvvng/Qu6ndcSfMBmZG3/cqqM+MfkENSQDF0txj
 b+lo3OhgXz6c/pQGScSG8Rlk1CAEKmCs84fSetACjNda1IKE+Op91p5SnHexAVHXTPxB
 RAus2HB7F9Tps5BKv01C6BZzLeSTB9Fsega1rr7y2NhjIp8TkGdhbBFOyUFrng+fpmkd
 KO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385550; x=1777990350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xiEK5ZRwN4orV/wRlbfvIu6lHKGtsLYk+ilus9PrRp4=;
 b=Suwf0DAvnotRi5DMDOro4cHk26/3/GPFu0OmfqfLxsUCo5egM9jS/AhOQLBKT/i9Ly
 xZjVa6oHo8os8Edd9zjndEavpFntSuXbGVW667XWJoc91lGZ8ayoImdRfkcCR7+KDY3j
 jaiwxpJ/F9wk6OAxcBrdjzzVcEeUIBfncTEu23DCHHlHuipVkSRbKJd5TX+Y/HbkHi57
 V4B64KaHa82ZIIB2EjXqdRcGM/G2PjIogJd/f2NVn4squmA7qzsttpfmS9F0t9CY0RbH
 r5P4UFKcJYESLPVBh/fMZMNJbvsBp83leOHoDNgsYqI3GD1bQe94ZYrDDzqdhLfPW/DH
 58oQ==
X-Gm-Message-State: AOJu0YzScMLrH+Mm6NQYl/j3T342ayuYVId3gwOkWTOq/fJNom9E8+YT
 Rgf92BDOvJ5rlV/dAMeNzBiPFHXtY2k+YL/M+Ot2yOHIxRglLnyPR0B4HdavCBp5VbipDce0bpm
 g/3mWjn4cx2y60j6vIPLxvI0wu/CwwiY=
X-Gm-Gg: AeBDiesrNpTQzOHHi5+zzI8GjuuxqZCWQbEqycu1TE4/i7Vq5HXPS3pTXSWyyVhM1mP
 FwYkjHwYCF/AKOayZmnvTjDCWX86CVA1s6LOzNIsMiwSI9TJVrzDb9lMu8g4Hz0uiOI9bzz/tAk
 ANLGR61OoAhqVtEKQiOK9j7VoExVSzOCBa1j80t29O/+IodaHNEd0Kxo4Rs+H0m/qROS8XTZScn
 bxfUnV8DT2uRkIjaY2I3ftEcoOqyy3GWBfvEUn6D1oRAEL+dHcZluhoALoho3cGoKDLq+fgECU+
 75rrhnu1SNJlpPqQqEU=
X-Received: by 2002:a05:6102:f87:b0:610:eb3d:bb2c with SMTP id
 ada2fe7eead31-6280c91b935mr1589419137.31.1777385550423; Tue, 28 Apr 2026
 07:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <87d4cc89-e60a-4365-b6c0-efe5b20d0c7f@online.fr>
 <286a02e2-d026-48bd-977a-d8df3c9d98c5@online.fr>
 <fb7a128a-1408-4595-a09d-2f2fecb311b4@online.fr>
 <CAMDkj5xG2s85GUc_dgbJ-Jp+qypXet1B73FCPVbYxAOj7HurMw@mail.gmail.com>
In-Reply-To: <CAMDkj5xG2s85GUc_dgbJ-Jp+qypXet1B73FCPVbYxAOj7HurMw@mail.gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 28 Apr 2026 10:12:19 -0400
X-Gm-Features: AVHnY4LeMb1mRz99VSPt8ElFE3mGGyVPj1NcStHYwPN6YQuN81AiFVLdkmVdUHk
Message-ID: <CAMDkj5x1Rm+pqfKMjudwsZ+_FOSkZMcOOnq+YBK6QADKx87wFA@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL
To: Vincent Legoll <legoll@online.fr>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io, 
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com, 
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, 
 peng.fan@nxp.com, xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org, 
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org, quentin.schulz@cherry.de, 
 samuel@sholland.org
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

Hi Tom, Leo,

Do you have a chance to pull or merge this series?

Thanks a lot!
Raymond

On Wed, Apr 15, 2026 at 10:32=E2=80=AFAM Raymond Mao <raymondmaoca@gmail.co=
m> wrote:
>
> Hi Vincent,
>
> On Wed, Apr 15, 2026 at 3:04=E2=80=AFAM Vincent Legoll <legoll@online.fr>=
 wrote:
> >
> > Hello,
> >
> >
> > Is there something we can do to help this series move forward ?
> >
> >
> > What are the next steps ?
> >
> > How can we get a fully booting board after this is enabled ?
> >
>
> There are two upcoming pinmux and SPI patches that can support U-boot
> proper, and eMMC support is on the way.
> If you're using banana-pi, it may not boot fully since SPI NOR is
> missing on the board.
>
> Raymond
>
> >
> > Thanks for all the work !
> >
> >
> > Best regards
> >
