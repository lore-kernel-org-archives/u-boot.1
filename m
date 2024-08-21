Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804B6C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 15:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D445488DBA;
	Wed, 21 Aug 2024 17:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hmC6VtyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 275A488DBB; Wed, 21 Aug 2024 17:57:43 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A1188722
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 17:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a1d984ed52so425412485a.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724255860; x=1724860660; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IN3q/FaKBasIpaq47DkF278pBfOY5nGY8CpV9d7gVnw=;
 b=hmC6VtyZeX8k2UMAoZTutadlIDSK/ki8Z+p+1YdQVRCnBDbMIp7VNFCCDfDjPjeZF/
 2srVr4F4LNZLfCS4SPG6s/Ls2qy99WOxDMDBJ8/BiKBnDwq3a0/0fq8jTe3Ydz2bkrKU
 xh2/Vtmxuj47CIBJJBIkYFUM/HWR8wJ6I33vFXiikJSeM+VeG6vfbR2jAF1Xivcu/c4r
 +r04ci8N8XdteC+hiP3ISJLAPpKEBvww2UpdmEze1Su0PxFDHUK9R1NfYZeBK2FXJIrM
 lTfs0GHy3c9N07ziwgtA0xpye/8H7OCl+4YDvrKD320BvmAJk+aTOG3s5LGK61qizpUB
 KjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724255860; x=1724860660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IN3q/FaKBasIpaq47DkF278pBfOY5nGY8CpV9d7gVnw=;
 b=HrjLEe/UhLZCLhMEo5e0OQGimiY50MvwSP8ywaI2zqv57InUJH45C3s/0ooI/lA9Ym
 x08ywIytvSA7kQV+OrhTm/aaUA3yijZonj3qqxB5XIRlzs/hQtKyL8dfBHhHLei7FuQq
 0og2cvxH7mPT65T/d70Z/GCOvRBPMUFIcnZDOyKLvfMk9FxjbxHK4H9gfvZTeuugNGRi
 fAU2mDUIXpZJ5S9IhTiJr3pHPK35Ez4CofQVI+M5VAMOXiDcBShs1TzGa1POSIFRmLQ3
 pNLFXQJWUjUv7+g1dPTEx7AOtU6KLK+CRZI+1X1+86OOLaj0ffuShU9m3sgJtFvnE3cW
 JZjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxNQ6hX05IheZaNpEj3wDg2n9QtUV2qeN4FDinpiidkUS+GM5KO9LQRCOGEAa2QW8avBVR7Dg=@lists.denx.de
X-Gm-Message-State: AOJu0YzWiBn5shK/tBaffiU0XLE3mYBlnmkGYO4IRDSwgMTLJfngH6F8
 ZXB7NDuM6xG4QWhq6sJj84oU0NtoD2CDqMNQWSMalHlugJFWBm2jqrzBE1++uSKRd4L53lH4iRO
 SknRG6DonCyxzubNSisR57yk3qYEKBzrm5ecAKA==
X-Google-Smtp-Source: AGHT+IFT0PypEvNErsXXO8c1DABoh/XS+E2dfWiNCLJVhyWmUhAATAMim7T04IkqOTqJm2Pit1aZZtPMfjqwFdTMhlg=
X-Received: by 2002:a05:620a:1727:b0:7a1:d8f5:979 with SMTP id
 af79cd13be357-7a674027d6bmr345224285a.18.1724255859628; Wed, 21 Aug 2024
 08:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-3-mchitale@ventanamicro.com>
 <9b9bde7d-e640-4502-831f-be06288fd9d9@gmx.de>
 <20240821-smilingly-lance-c051e89df945@wendy>
In-Reply-To: <20240821-smilingly-lance-c051e89df945@wendy>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Wed, 21 Aug 2024 21:27:03 +0530
Message-ID: <CAN37VV4QLVJDwgQWKf7QMwvK8nzv03XpvJ3J7ajN08dK=SRiPQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] riscv: cache: Add CBO instructions
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Randolph <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Samuel Holland <samuel@sholland.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 u-boot@lists.denx.de
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

On Wed, Aug 21, 2024 at 3:28=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Tue, Aug 20, 2024 at 02:14:01PM +0200, Heinrich Schuchardt wrote:
> > On 20.08.24 11:37, Mayuresh Chitale wrote:
> > > +void riscv_zicbom_init(void)
> > > +{
> > > +   struct udevice *dev;
> > > +
> > > +   if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
> > > +           return;
> > > +
> > > +   uclass_first_device(UCLASS_CPU, &dev);
> > > +   if (!dev) {
> > > +           log_err("Failed to get cpu device!\n");
> > > +           return;
> >
> > Please, return an error code.
> >
> > > +   }
> > > +
> > > +   (void)dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_si=
ze);
> >
> > Please, do not ignore errors.
>
> I'm curious what the policy of U-Boot is w.r.t. extension probing. Is it
> okay to enable the option for Zicbom even if your hardware does not
> support it, in which case riscv_zicbom_init() would be expected to fail
> gracefully and no CMOs done?
> Say, for example, you had two very similar chips, one with DMA non-cohere=
nt
> peripherals and one that only differed by having DMA coherent ones, and y=
ou
> wanted to run the same U-Boot binary on both devices using a devicetree
> passed from firmware.
I think in such a case the config option can always be enabled with
the proper dt being passed by the firmware.
