Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2699C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 16:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52A78650A;
	Tue, 29 Aug 2023 18:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dl5F8cLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CAB86510; Tue, 29 Aug 2023 18:38:44 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 583FA8650A
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 18:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52a4818db4aso5934448a12.2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693327120; x=1693931920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O6rrl7d94nQ3aQan2Rf7ZqhJycIsuwyJRl1U6Fq/Tq8=;
 b=dl5F8cLFlKMA7b/FWxmWShaw1j05SDZ1kD47XZ52/iGorBGeRyKZx2w1mzHOEkrnAz
 pYYsBXoYyUgFqLd1PKfpmMfb+pzf8/icXkf+KTaxQQAZL0vttIc4UgOyfjX/PCBdUBky
 QIxDHLifb4W4bW0YeYQTE9dNL6ZaCWXP7KmE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327120; x=1693931920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6rrl7d94nQ3aQan2Rf7ZqhJycIsuwyJRl1U6Fq/Tq8=;
 b=dGMBP61JkLA277DLlAsA3TarrU1fKadJ5viIxlIJLTxHtSuI3joM68R6JPLzrcIa+c
 5Fht5K1aKro3mRzwdBmsdGvwEdcYHJjAAEbDcr+Jpo/ICEcopfDHdOU7omW1o++Rq53H
 ZAZ7NIAH/kWEQj5FY796cyzfjnR90FHbxCLKHpYHWIFJe/j10GzEGtr11mfj3IZetu4R
 KyJUXO9s+PwvAuIe+XmMc1qD0OWsHPdSu9Edbanm8/Cfnax+R6It7s+SNfbEK3686PD1
 JWysHf3YxHNqYhiJrnxySIp5h6XjSzkl2nnGhIIz5qhw31PWLG+Kows0B4QPoQflL2vY
 VSgw==
X-Gm-Message-State: AOJu0Ywo/PBOJVWp3Iyxx5Dyg9usHxVMZGWdg1lWvdtwI7WmFZc1CeNp
 fQs6MXacI3YtkNtXgNXut3Ik2XMDtSpDUp34BCB1aQ==
X-Google-Smtp-Source: AGHT+IEGDIqBw9n/8mDiNIB/wE9lhnXB2iKnKCTutn5d8PT3DpqtqbWkTn0tOFWeqXmPpjncJvczbTitQDVnpT6l6yc=
X-Received: by 2002:a50:ef08:0:b0:523:3e77:7eb5 with SMTP id
 m8-20020a50ef08000000b005233e777eb5mr21769755eds.2.1693327119835; Tue, 29 Aug
 2023 09:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230828094628epcas2p39068c0277081701446115fec7584ab54@epcas2p3.samsung.com>
 <20230828094617.2060025-1-chanho61.park@samsung.com>
 <CAPnjgZ1YYHTe_7VZDyCe9OhrmhhdtnOn5szeXfrJma6=Ot39ZA@mail.gmail.com>
 <005901d9da2b$52f9ece0$f8edc6a0$@samsung.com>
In-Reply-To: <005901d9da2b$52f9ece0$f8edc6a0$@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Aug 2023 10:38:27 -0600
Message-ID: <CAPnjgZ05ELvn6HHRRSygxRdJrJGN9bF=PkdO_w5TCjA9koKZiA@mail.gmail.com>
Subject: Re: [PATCH] spl: bootstage: move bootstage_stash before jumping to
 image
To: Chanho Park <chanho61.park@samsung.com>
Cc: Nikhil M Jain <n-jain1@ti.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

Hi Chanho,

On Mon, 28 Aug 2023 at 21:46, Chanho Park <chanho61.park@samsung.com> wrote:
>
> Hi Simon,
>
> > -----Original Message-----
> > From: Simon Glass <sjg@chromium.org>
> > Sent: Tuesday, August 29, 2023 2:55 AM
> > To: Chanho Park <chanho61.park@samsung.com>
> > Cc: Nikhil M Jain <n-jain1@ti.com>; Marek Vasut <marex@denx.de>; u-
> > boot@lists.denx.de
> > Subject: Re: [PATCH] spl: bootstage: move bootstage_stash before jumping
> > to image
> >
> > Hi Chanho,
> >
> > On Mon, 28 Aug 2023 at 03:46, Chanho Park <chanho61.park@samsung.com>
> > wrote:
> > >
> > > For IH_OS_OPENSBI and IH_OS_LINUX, there is no chance to stash
> > > bootstare record because it will not return after jumping to the image.
> > > Hence, this patch moves the location of bootstage_stash before jumping
> > > to image.
> > >
> >
> > Please fix your implementation instead. You must jump to the OS at the end
> > of this function and not before.
>
> In case of OS_TEE/OPENSBI/LINUX images, they will not be returned to SPL so they can't get a chance to stash boot stage records.
>
> >
> > In fact I have a patch to move bootstage later in this function!
>
> Will you post the patch soon? Or it was already posted?

Not posted yet. I'll reply on your new patch.

Regards,
Simon
