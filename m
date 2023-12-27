Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E060EC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 16:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35AC287872;
	Wed, 27 Dec 2023 17:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yttP8Yuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA2187956; Wed, 27 Dec 2023 17:06:47 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE8D87872
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 17:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28c7c9b19f1so693580a91.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703693204; x=1704298004; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oOdi7vWMHRx1tVHbK6lzqskjQYsAQBGGHKSIySP62F8=;
 b=yttP8YuhV3WvNs34Ldp7Uw8XnSwho0CRFs//W/cZGD/9e9oaz27PJZMsWJzX+SVD5L
 9/F3ZDhMgqDOl5MJtK7b3W3uH/L3c/3pnHDzBW4gOcZXNitzbAENL6SETlopbCcuAHhI
 iblSZBuKOslvQ/mw878LsWYq82t4a64Nt+ZhDzjPNx49a9MIV5N6SJYJipJctppTXQsf
 Jif/3c6R6KXnvZQhg2N+Cs+uhxLMwRWlWvsrigDfTTpRvA4YWYXHWI0Hl+ufU0hFEgpn
 mpnjpynhzEvqw3SUpvay2WDY+ePw70USJ2rovYhLErQFRmUjSx6bSmd1EiNLuVoYAsz1
 AntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703693204; x=1704298004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oOdi7vWMHRx1tVHbK6lzqskjQYsAQBGGHKSIySP62F8=;
 b=YATuuIZ9L+27+Gmfeps1jfhgrghjNJiacoxeQP26mqmn26qA+nIzeT+nIt4P38T5z6
 zl0h84Dpazbtv11OKSAqwQCYCJK6CCtFhamyytRwBbnK5ScsCKNWHS7j7YcFyCkuJ5TH
 Kv7/DoQvbwPFHyfhrVILEsXAUMeaGhiGVMXEAK+n050bFsiFubiMLraUPVnbdGcJ3U9Q
 7ou2sQnXlDVp9kyv6IL+8fSL4v/+KIDoUV5ywCwWHfvd+yWAMwWFnTyaLt2/ohFTfJPk
 CJSr2Jj9du12Tv2/lE82OuMHZpsAENbhHpLIczqkwGyvjPu+ThczBFO8xg+AZcQe9BZS
 EQoA==
X-Gm-Message-State: AOJu0YzkGZBvvAujLM+rV5VZadhmwAOpCNi2cOiyaXA/yHTyQhtyYOHy
 BmHvZMLbJpCsZi//zxOsQ3DDTQohApDtZmb4MmZsHUNi7J5ZTw==
X-Google-Smtp-Source: AGHT+IF8lbRT0iWP2htu+eJiHuaaYDAWlTYBG+aAzu+L3DKcfL75gWpdGqs84ltvECTkIDbeEzWUJc+kJZJp2TzIdWc=
X-Received: by 2002:a17:90a:8997:b0:28b:d908:7b00 with SMTP id
 v23-20020a17090a899700b0028bd9087b00mr2522108pjn.59.1703693203846; Wed, 27
 Dec 2023 08:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-2-raymond.mao@linaro.org>
 <CAFLszTh7f2oy_Aw5Oq1m0Eo4h496dZenhBeYrW9DbB_FxnFADA@mail.gmail.com>
In-Reply-To: <CAFLszTh7f2oy_Aw5Oq1m0Eo4h496dZenhBeYrW9DbB_FxnFADA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 11:06:33 -0500
Message-ID: <CAEfUkUKWUA7Y=4oyo=E-yV-3hFc-dAyLykrZgfY6_v3HwuwKpA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] bloblist: add API to check the register conventions
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <sean.anderson@seco.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
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

Hi Simon,

On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg>
> wrote:
> >
> > Add bloblist_check_reg_conv() to check whether the bloblist is complian=
t
> > to the register conventions defined in Firmware Handoff specification.
> > This API can be used for all Arm platforms.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Refactor of bloblist_check_reg_conv().
> > Changes in v3
> > - bloblist_check_reg_conv() returns -ENOENT if OF_BOARD is disabled.
> >
> >  common/bloblist.c  | 13 +++++++++++++
> >  include/bloblist.h | 12 ++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index 625e480f6b..ba17dd851a 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -542,3 +542,16 @@ int bloblist_maybe_init(void)
> >
> >         return 0;
> >  }
> > +
> > +int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
> > +{
> > +       if (!IS_ENABLED(CONFIG_OF_BOARD))
> > +               return -ENOENT;
> > +
> > +       if (rzero || rfdt !=3D (ulong)bloblist_find(BLOBLISTT_CONTROL_F=
DT,
> 0)) {
> > +               gd->bloblist =3D NULL;  /* Reset the gd bloblist pointe=
r */
> > +               return -EIO;
> > +       }
>
> Where does the magic 4a0fb10b value get checked?
>
> The magic and version of register conventions cannot be checked now since
there is
a bug in the spec. PSB:
```
X1[23:0]: set to the TL signature (4a0f_b10b)
X1[31:24]: version of the register convention used. Set to 1 for the
AArch64 convention specified in this document.
```
Signature (4a0f_b10b) takes all [31:0] and no space for version of the
register convention.
This needs to be updated on TF-A and OP-TEE as well after the spec is
updated.
For now I will just skip the checking.

[...]

Regards,
Raymond
