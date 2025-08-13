Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE6DC87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 09:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98C2083253;
	Wed, 13 Aug 2025 11:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zHfDHgCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08CC83236; Wed, 13 Aug 2025 11:16:33 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088DD83253
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 11:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7e849d7a28eso382463885a.3
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755076590; x=1755681390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H2JL2kc5hOEInHJzY5Qf/yrcTquJkmmAKjl1j6zIIto=;
 b=zHfDHgCITrT5eKfzk+vPMk40dJi36c5XgGTyCrL10Q8QxGi3xDvQyzcK1ERDapFYXI
 iUr4LhpyrzCYdi3NpItBTKaqm18EQylvTYDA2AUroyI4LAY/pg25Upve//m2+vhtjGd8
 dv7JsSo5urLooPXwmlX3iCbtwK9Rqst2T8WYXAbLcgtcW5xIEsgYJLgoOVUjPW9/DdbR
 cxmWCDxtNofzojJAmIEoqisD0dElGDG3EabmZ1hdh55J9qPH4mwANmxn8ADA2dZ3f/Q2
 k6TwmX0jJOE2MZnE8Hd7lw+ezapcXQkJBf3y4AS9XV+Wv/4HbHiy+JZJRKxkv7r2ZeG+
 oMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755076590; x=1755681390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H2JL2kc5hOEInHJzY5Qf/yrcTquJkmmAKjl1j6zIIto=;
 b=Gm9P4L2fz7vf1/yIHrwKk5dOJNdsaCMD0YFX/lSkktzkjr+XR0HM4ANQfo1ei/RBce
 JgPlAPWwSk6kk7yZdEbeJGHuwFEmbftcFwcNXkdeZYfym1VYpkp7IUBuR2vnsAmh3d1M
 LpBJ0A5wE6MclCwiohMCF9QPQMWqi/OZrZBBJEklH1XtO39WlTn625NVZx1V6ujpV0si
 lFCzfs/NQWR7MiVR7zkoONoUNbJNpjpJeB6rC54xOJqbzFWEl/h74QlxyPYbHBRgfzUO
 qSMb105rNyDg86CtTrtTpwNqtORjDlPR/Ab4k/EEKRYzBYkOhFmNIRh8qfo5PFt8MilY
 vjzA==
X-Gm-Message-State: AOJu0YxR/Qc8DLKiGf1lICMlw6W5YOWa1cUt7XIJmbe8qyzHt823rLtI
 HPn4lyr1sv2f8ssdwwXe8fiX9cLHfv6CDPxEvos9BEkWL/2OZkbtAsENgh7rkBVSMfNWKxRn3Ze
 Wk59rOWPt8q+IuRLouVlGJOqrY1pl7gpQJ6KLo0q39A==
X-Gm-Gg: ASbGnctypfgG8/uUmUggOKv1CjLcVmo1GF7tl8UltIe4+GRIvAQx4axKI6eL7Ilpx9i
 hMUM1QWuyGVqALu5gEceGL9CCRW+naYdEhqPxfT0nXr4cSFqlNf5JlU0GuVMy0OrKAJBx0whfI3
 X55GbwEw58NTX3lH0rVKx6cC54nNOSCZkOj2Rvyh0HtRUMxdgfziGfE+W+QZAcRLXb6pbUlvSn4
 EDzrcX1
X-Google-Smtp-Source: AGHT+IEP2suWKMapBe3Sus6ymBvA4gFV817rqdAj1Mz3nJV47G4bimKCEVR5bdVl2E8tTAj5hFQkYhcsiXu1KoRNPdE=
X-Received: by 2002:a05:620a:3bd0:b0:7e6:2f06:aca5 with SMTP id
 af79cd13be357-7e86535f984mr259097785a.61.1755076589716; Wed, 13 Aug 2025
 02:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <8397369a-9b0b-4798-9c30-3a81165657d6@iscas.ac.cn>
 <CADg8p94SHLtb3OcNN4KxppLgLzQc_J5SZMfuvz7n3sM051wztw@mail.gmail.com>
 <aeeacdc2-9b61-4129-be49-823680278df4@iscas.ac.cn>
In-Reply-To: <aeeacdc2-9b61-4129-be49-823680278df4@iscas.ac.cn>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 13 Aug 2025 14:46:18 +0530
X-Gm-Features: Ac12FXzWdvvKLFv5jp4lD0QHd7qS5o8xjtDh-_2vB9P0XFymuSHZokJB1zExVec
Message-ID: <CADg8p94w8wUhQirgiWvkJV5ax8NPqdaHhi+Le+WUCcab+w3_Cg@mail.gmail.com>
Subject: Re: riscv: v2025.10-rc2 fails on QEMU with "Failed to reserve memory
 for fdt"
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: u-boot@lists.denx.de, Lukas Auer <lukas.auer@aisec.fraunhofer.de>
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

On Wed, 13 Aug 2025 at 14:20, Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>
> Hi Sughosh,
>
> On 8/13/25 15:58, Sughosh Ganu wrote:
> > On Tue, 12 Aug 2025 at 20:47, Vivian Wang <wangruikang@iscas.ac.cn> wrote:
> >> [...]
> >>
> >> Retrieving file: /Image
> >> Moving Image from 0x84000000 to 0x80200000, end=0x81e88000
> >> ## Flattened Device Tree blob at bee8f640
> >>   Booting using the fdt blob at 0xbee8f640
> >> Working FDT set to bee8f640
> >> Failed to reserve memory for fdt at 0xbee8f640
> >> FDT creation failed! hanging...### ERROR ### Please RESET the board ###
> > Looks like the FDT is part of the region reserved for U-boot image
> > post relocation. That region is marked as no-overwrite, meaning any
> > other allocation attempt to the region will fail. Please check the
> > relevant log below. The relevant code is in
> > boot/image-fdt.c:boot_relocate_fdt(). The code gets exercised because
> > fdt_high and initrd_high are being set to all ones. This was working
> > in 2025.07 simply because the function call's return value was not
> > being checked.
>
> Thanks for the troubleshooting. I confirm that just removing that line
> fixes the problem.
>
> TBH I don't understand what the right thing to do here is, especially
> whether copying the FDT a second time is the right thing to do here, so
> anyone else taking a look is still appreciated. I *think* it should be safe?

I am not sure what is the correct thing to do here. Like I mentioned
in my previous reply, this was working simply because the return value
of the lmb allocation request was not being checked, which is
definitely not the correct thing to do.

I see that the setting of fdt_high for the platform was introduced
through 52b984369fde ("riscv: qemu: support booting Linux"). This
commit is a good seven years old. And I am not aware of the context
for setting this value, which seems to be discouraged as per the
documentation.

@Lukas, would removing the setting of fdt_high and initrd_high cause
any issues when booting the kernel from an FIT?

-sughosh

>
> Vivian "dramforever" Wang
>
