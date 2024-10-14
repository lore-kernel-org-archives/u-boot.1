Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B385ED1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0586F8907E;
	Mon, 14 Oct 2024 21:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bRBXCQdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FB389096; Mon, 14 Oct 2024 21:13:35 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FF3C8907D
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbe8119e21so37751616d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728933212; x=1729538012; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GGKz61j9sl2lj/pketj44zLtnfRMFPSZ6oCaHamR2LA=;
 b=bRBXCQdFfo4HsJZQbXrD1aCPKackfYC786hYIy0Yycsg94n5g07R0Bn1uGIJl1nO29
 V7NtCraWC1oAHUgDPFQp2fkuAjeGDglqDizGmAC4l2v9IaWmsKLDkRqGjCaq8VRceDbr
 fNZvEMdJtybQzViTsqJ5BOBuiFt2s7l7c98KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728933212; x=1729538012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GGKz61j9sl2lj/pketj44zLtnfRMFPSZ6oCaHamR2LA=;
 b=flE7uopKnTN0Macue2qu12aP6gw7ftY8ug1GxVafRWIbj+nMV4G7bxyAFoWqtcZ6uK
 J3iaCUd6wuF2NtKiJGZeovSGWZzECUWju/qne17CdvYoT/EvI7QfjVIckWu6Do9FIvAE
 JiVtGslvrzGXaiEF4TkuF6Cbf6wLHHajxg1qQa5JdBMRKlK05Kk1xvRPUERQXCrz0SWq
 4GfYv8+RuuUB8oVX9bf/bOqhMnL1isLRDdZqZ+fMvWrOMovD77yCYpLz7eA8sZc8ZA3L
 2BuW9xVHINbBdTaVNB7PoVvRFqz5IuiYE8ZCIgv/tC9eAXf5I48UPVI9abirs6v3IJb0
 je7A==
X-Gm-Message-State: AOJu0YztLE4D+6VnD5ijcHzWkMMeSU/al08hiMosf4hFmORVX5R4F0c3
 Tuos7lnQnzfcnpGGJRLj1gL1MFvOyz2qRiP/fY8VRANA/39rMrwGT6rbiQ7t8QUzmm8cLB4ULJg
 41u+jueQ/tZDKxgmKLo1YWY4fO/QcuNn/oBCo
X-Google-Smtp-Source: AGHT+IH4zFXMbAr1lc6NWI1k7yz4HJ6EvowSFhsK6tQGyqGfEDWDmJ6QD7z5n5UHhCyqsN+p4f/hFdychzgDVMvqQFY=
X-Received: by 2002:a05:6214:2d44:b0:6cc:339:c214 with SMTP id
 6a1803df08f44-6cc0339c31cmr136084626d6.6.1728933212319; Mon, 14 Oct 2024
 12:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhyRsAMfYeMKVjGRLHM3DFymHxnxVO0YNM_2G=CYvGmTJoYNw@mail.gmail.com>
In-Reply-To: <CAMhyRsAMfYeMKVjGRLHM3DFymHxnxVO0YNM_2G=CYvGmTJoYNw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 13:13:21 -0600
Message-ID: <CAFLszTjnye2UYPxEQhGREuG-x5G3PA9ejAMSJi2SWZK_nz7m4w@mail.gmail.com>
Subject: Re: ll_entry_count returns 0 even though the linker list has 5 entries
To: Osman <aibaykaro@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Osman,

On Mon, 14 Oct 2024 at 07:03, Osman <aibaykaro@gmail.com> wrote:
>
> Hello,
> After enabling CONFIG_FIT in defconfig the u-boot-spl becomes unable to
> detect the root_driver in function lists_driver_lookup_name(). The spl
> executes without issues when manually changing the n_ents variable to 5
> while debugging so i am guessing the ll_entry_count() function somehow
> returns the wrong value but i am not sure why. For reference this is the
> section in u-boot-spl.map file that contains the "root_driver":
>
>  __u_boot_list_2_driver_1
>                 0x0000000080009b78        0x0 drivers/core/root.o
>  __u_boot_list_2_driver_2_root_driver
>                 0x0000000080009c68       0x78 drivers/core/root.o
>                 0x0000000080009c68
>  _u_boot_list_2_driver_2_root_driver
> __u_boot_list_2_driver_3
>                 0x0000000080009dd0        0x0 drivers/core/root.o
>
> (gdb) x /8xw 0x0000000080009c68
> 0x80009c68 <_u_boot_list_2_driver_2_root_driver>: 0x800091a0 0x00000000
> 0x00000000 0x00000000
>
> By manually calculating (end-start)/size from the symbol addresses of the
> .map file i found the correct value to be 5 but ll_entry_count returns 0
> while the function lists_driver_lookup_name executes:
>
> (gdb) s
> 27 const int n_ents = ll_entry_count(struct driver, driver);
> (gdb) s
> 30 for (entry = drv; entry != drv + n_ents; entry++) {
> (gdb) info locals
> drv = 0x80009b78 <_u_boot_list_2_driver_2_cpu_bus>
> n_ents = 0
> entry = 0x80009b78 <_u_boot_list_2_driver_2_cpu_bus>(gdb) frame#0
>  lists_driver_lookup_name (name=0x800091a0 "root_driver")
>
>  I am not sure whats causing this but disabling CONFIG_FIT in my defconfig
> causes the program to execute without issues again. Could someone point out
> what i am missing here?

That is very strange. I can only suggest debugging it a bit more, e.g.
adding the code from ll_entry_count() into your function and seeing
what it shows. Is it a 64-bit platform?

See also LINKER_LIST_ALIGN

Regards,
Simon
