Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FD0C54FC6
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 22:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F0B8876E;
	Tue,  3 Sep 2024 00:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXZiuFv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 553D488754; Tue,  3 Sep 2024 00:06:38 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B0988C3E
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 00:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71430e7eaf8so3683361b3a.1
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725314794; x=1725919594; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQvFDjNwunhgkAkIuXx3mo/EQ/aZNIicWg3EgyYN0Cw=;
 b=QXZiuFv7CQ3yiRH3Gzt+O5VDbZgMKrf8dUd3F5DWQ0jDOagYsKX6qRmoJ8hKDUp4Oy
 VKNMpDUZr852sssn21DP1PLvYtS+9uJBsAiyAJ0JyvP5yiSrteMmvpkUEFSlpIAE0ZDU
 A0IBQ6ZVOyr8YVyODTUQQh52PiEPRMv56lEkJe6S5guRUk3QcBaE+dbJjTIGZJ4KSEuW
 akwpcrcy3h5GZxm7ot3/5XYjgd30fi1/C/2+1OkwV9xaQVAiPULL4cXSrDG/NjDncNMs
 iVBPLE68P4CQz1WtDWjXi/q6b7JlNMEaS0pRZTTPN7K0XgYmeY4imScapBUqsw0GWqWq
 QrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725314794; x=1725919594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQvFDjNwunhgkAkIuXx3mo/EQ/aZNIicWg3EgyYN0Cw=;
 b=m0lL5jgkdm9b4mYfiMat5rFUuKSY+eOzQrtkIiyGDJhIISCn0a/pljYqD3bc0JefKz
 IFRMlzdC/KQ54z1nTqKSQ8tBfcTx9+prugRmmvAdHlrAX5GRfq8XtWJMNeUO1KgMxG8C
 Vi0uXHCuxTS08X5kUAxopkhEhZ8+qXGcJfyZnOQ/uoy77DjyXaweOhij4+khZsXAklJq
 PNXohg0+fvSqZqCzF4J+xvlv9qm+cuBbTeuNplyFRHTEBVHlNnrFFA/Sp0jiJ5wwGWRn
 QHWizbw9nDYNtl+IHajtdMSB2dJ9VOXEhgIrIE4bec7ET2SGpaBHEaxd2bgTJVLfg4z0
 Ptvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhUlsnxpJCWjknFv84Ra57gzIF3m2yXCqnQxso9s2a27vnIsJpf+ifH/jNnZEwLd4WL2Uv6wc=@lists.denx.de
X-Gm-Message-State: AOJu0YyPTiigeEeHF8q2T+GS36wsalo9A7OAodrWAXNDgJp8g+RI5LKx
 iUrpuWfJhXuAdUCorIVmTbEQb449menaFIlFBPN1kBdZMtr5ylv8cFp9dx2RcAeKfnPgkniFhez
 AYtuZXe8/YxPMYxlIiH0KBMgBejA=
X-Google-Smtp-Source: AGHT+IF8w+7Hu/uLVOv77l9bYDPQG1Q13EPZzzE1RMkYCsR1FZahYSP6Twqti70ixvOsYhaXym6MdbH/VRgGBNs4AWs=
X-Received: by 2002:a05:6a20:9f89:b0:1c6:fb2a:4696 with SMTP id
 adf61e73a8af0-1cce100b917mr15552807637.19.1725314794279; Mon, 02 Sep 2024
 15:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
In-Reply-To: <20240828100452.2143873d@wsk>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 2 Sep 2024 17:06:23 -0500
Message-ID: <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Lukasz Majewski <lukma@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>
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

On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> Hi Simon,
>
> > Hi,
> >
> > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam <festevam@gmail.com>
> > wrote:
> > >
> > > Hi Lukasz,
> > >
> > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski <lukma@denx.d=
e>
> > > wrote:
> > > > Unfortunately not - this change is only for properly setting start
> > > > address of the u-boot.
> > > >
> > > > The _real_ problem here is the symbol placement generated by
> > > > binman when we try to define the image as a single one.
> > > >
> > > > Moreover, this change follows other boards with imx8mm processor -
> > > > ./configs/imx8mm_beacon_fspi_defconfig to be specific.
> > > >
> > > > The "fix" (for which I'd been now probably opt) for this issue
> > > > would be to generate two images with binman - one for
> > > > u-boot-spl-ddr.bin and the final flash.bin with the former one
> > > > included (as it was before SHA1:
> > > > 37e50627efacd8dae18b564e9d8886a033e181bc)
> > >
> > > Is QSPI boot broken on i.MX8MM?
> > >
> > > I am adding Adam and Mamta who have tested QSPI booting on
> > > imx8mm_beacon and imx8mm_evk, respectively.
> >
> > Note also that I sent a series[1] which allows the symbols-base to be
> > adjusted, if that helps.
>
> I've seen them - but not yet tested.
>
> Thanks Simon for the patch series.

Is it still broken with this patch series?  I have been traveling and
haven't had much time to test.

adam
>
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D421010
>
>
>
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
