Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1849C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 12:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18EF287F7F;
	Mon,  4 Mar 2024 13:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OAVA9fKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E95587F85; Mon,  4 Mar 2024 13:27:08 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D459087CBA
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 13:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4725acb539cso1165492137.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 04:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709555224; x=1710160024; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lqtb+sOeHz0eVl2w0Iev+xDqOXiEiNbePek3NATE098=;
 b=OAVA9fKIrTmEoLmK6heq67Ugo45tAuCwSihbcPK8mj1t51ek0hYGQvAsIfep/lEz/6
 iwHO+2+AGHLzyS3TNybeXWs5NjOvV7a2ZNieO4lx1HxgNpWbiNnSD4eRDfNer6VMDYnQ
 9OJlDmmju7MpaIMU/VGPbTM+IKch5oJdeOE8vKUCGzhrp/zYIX9NxHfivJ1WwaaSPXKg
 4zbis8i8RyX51cnr8KWlyuB7XCPuQ+lKz8Z36ZTXqW/fRbl7ZtKDn+OO/PWQk4E1p+Sa
 APBfBTJv+a5lQvQoGzYaigZKYI1BjhF4y734qNW8lp84DcBPMVaKrj2tHVA5NdoIGTPL
 nm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709555224; x=1710160024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lqtb+sOeHz0eVl2w0Iev+xDqOXiEiNbePek3NATE098=;
 b=LFlWsbTRkDEiSA8njCt8B2bHAzHBtp0wrP351qZ1xJvAjxXT+Cc/Vq6ZJMalR+C0rr
 Ayyn9vUSrAgAxP3X9DKHMtid8MRvtI0TMLe8BQ6QydomBHhukXETjwrzef5NnTbZRZX1
 Gj75QQ6B/GSEbVHbAFuwqJT/6Z+izWgXaEXqPYZP2d90Rc6+XR/XyLtAQvggyUCFl0WY
 iDWlxRNxU/+IEl42HTytDVFXi1c9chlQag4e8U1o/w+n5oChZym+KxTFz+agwCW+2t16
 a6adCMoHw6ca+j07XhBYSXcs+dRC358yaq0jPBl14IfK/Kj7/BioVhGtFR7K39knKnLJ
 y3sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmK5r3SftTuDnpDUqt4OoZXBFjwrdoIWjwVDfmA+zjO5xobak6Fzz2+2r7EooyRUcfGtfLryimV+hIzaERaIeXdtBKfQ==
X-Gm-Message-State: AOJu0YxQ00Z1sxcwxvXqXlzVthskgKbQSLRSnr0VpRnGDN3kltgkBrut
 phBL59GmVuiY6x84zLMdbmMqNLG8/UahUDIqFA/af72Ap3TuHsr+bx0MEA8Cw9LfCOTcIFNIYro
 16cCZajKd1hT5JCaYFznPiU7iwnGZaofjuHYljZI2q4iIaJdJT1M=
X-Google-Smtp-Source: AGHT+IERE0bcQBi5R8ufa/1cjDmYbHhCKX76L5AcIMtUx2ERr0Z8TOFm+P4hQUGw8bNsQmVI4YQUB1iDLn/MTsPzDx8=
X-Received: by 2002:a05:6102:35a:b0:471:f1a2:13c8 with SMTP id
 e26-20020a056102035a00b00471f1a213c8mr5067198vsa.11.1709555224650; Mon, 04
 Mar 2024 04:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
 <20240205-am62px-wip-rebasing-v3-11-04cbb42eaa6f@ti.com>
 <CAFA6WYPxXM5d=kpRTmEV7+8gYhgQr-rbX8hp=raOXmC79fSu+A@mail.gmail.com>
In-Reply-To: <CAFA6WYPxXM5d=kpRTmEV7+8gYhgQr-rbX8hp=raOXmC79fSu+A@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 4 Mar 2024 17:56:53 +0530
Message-ID: <CAFA6WYP8qbi=QT52R7z+C6h-Zhkh7koAvx=M8dbw16pL1ZbBcQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] Makefile: remove hardcoded device tree source
 directory
To: Tom Rini <trini@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Nishanth Menon <nm@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Hari Nagalla <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Fabio Estevam <festevam@gmail.com>
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

On Mon, 4 Mar 2024 at 12:10, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> + Fabio
>
> Hi Tom,
>
> On Tue, 27 Feb 2024 at 02:49, Bryan Brattlof <bb@ti.com> wrote:
> >
> > Some boards that choose to utilize the OF_UPSTREAM directory for their
> > device tree files will need to specify that directory instead of the
> > traditional arch/$(ARCH)/dts/* path.
> >
> > Include the correct path to the board's dtbs depending on if OF_UPSTREAM
> > is selected or not.
> >
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  Makefile             | 18 ++++++++++++++----
> >  scripts/Makefile.spl | 17 +++++++++++++----
> >  2 files changed, 27 insertions(+), 8 deletions(-)
> >
>
> Can you pick up this patch independently for -next since it's needed
> for other platforms to switch to OF_UPSTREAM? However, if you are
> already planning to pick this series overall then I am fine with that
> too.

Please consider it's v4 instead.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240304121257.3551104-1-sumit.garg@linaro.org/

-Sumit
