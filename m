Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23767CD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 17:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6473986A09;
	Mon, 18 Sep 2023 19:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FPBWxFA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD3186A49; Mon, 18 Sep 2023 19:37:19 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17AC8869E6
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 19:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6bd0a0a6766so3226670a34.2
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695058635; x=1695663435; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WcxY4t2/sp0bWTI91ij4dN3fv9yxemhuLl2fT7nm99E=;
 b=FPBWxFA79MTQ8tyz7ig5LegMXYCJT1gvNR8JifbZy3y8F/YZwVTm2IgAaK3w6Y4wXV
 S5OEye/kHGpAZalmIxKuUDWIhFS/dU3RFwEobAUj1wOAnfwV3G5l/juaeMoklf1wo/EK
 M8I0kmYjWblE8YXP1Xn5l8UH2mRR5ig+6JbF8NnLrlg6tjBmPQxjX3LkBs4of4UZtw7o
 tn9YrYCaiLkQBVDOrZHy9hnkS0vTjmgANz5xpHRsJvWA+o5XEWYZhqCvSkPye/dm92th
 mA9BQ92rUwXHPUqbLaHgLqVMz4WJkD1Aq6hVQte4GsmaAp3J6PaYcPy9ltjujhNDwZIw
 /RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695058635; x=1695663435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WcxY4t2/sp0bWTI91ij4dN3fv9yxemhuLl2fT7nm99E=;
 b=kGa7VGGfpDKF7Tj+OevJS9hxy0hOlF1xmHgJTh8UVsRlGDuzF/z2RbnSf3oh0Vti1z
 QtX6ldRGjvBXoSdEZI1BGXJrVn+E64BthxK4dAgRO+sz7jNC9sksyM/LxEFCfznfIoRD
 ZMtVy4jKi19evle63OUpriVu5HxUM6Y6I8L9REt4t1csxDAAgMBrkDKoIf1Y5cSLSCl1
 7o+BPJ0eqC+AEqCRnrbEwBiNuYG/YxHz9GGnw7WWq2mCKQUTMJAe8IrRza1Mixqs6e0p
 Rrrfmc6QVBxGZg5Uans0hxv1T1/t4LneTQeneV+k1Mm+TRlpHTwI28YYNtWKEykiSbQ6
 BsIg==
X-Gm-Message-State: AOJu0YxmCINnQX19xWL0cDBZqvxbUb9BNWEo8EHNPnhiC7CLLch+6DPH
 W5lFwTfw2A/yZAJQZPwy1vpkLB7oqmgqgNRQVI0=
X-Google-Smtp-Source: AGHT+IE6+k8N+TPjdEQC2wIULc3Uvu00hQPn8NVGUHiSqQvcvA/Os2DEW84sNO9dnlEMNvZuTgZN/gLweVSKvR7Jfeg=
X-Received: by 2002:a05:6358:7244:b0:143:61d:ffd3 with SMTP id
 i4-20020a056358724400b00143061dffd3mr11337877rwa.4.1695058635618; Mon, 18 Sep
 2023 10:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <64659cb4-8018-498c-b41b-e838877f62ab@gmx.de>
 <20230918141253.GM305624@bill-the-cat>
In-Reply-To: <20230918141253.GM305624@bill-the-cat>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 18 Sep 2023 19:37:04 +0200
Message-ID: <CAC928HYZJE0npaSTKxcP0csxqUzskuNFUBwWrR3PN4zEerOpPg@mail.gmail.com>
Subject: Re: Pull request doc-2023-10-rc5-2
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaewon Jung <jaewon8868@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

Il giorno lun 18 set 2023 alle ore 16:12 Tom Rini <trini@konsulko.com>
ha scritto:
>
> On Sun, Sep 17, 2023 at 02:14:03AM +0200, Heinrich Schuchardt wrote:
>
> > Dear Tom,
> >
> > The following changes since commit 252592214f79d8206c3cf0056a8827a0010214e0:
> >
> >   Merge tag 'doc-2023-10-rc5' of
> > https://source.denx.de/u-boot/custodians/u-boot-efi (2023-09-09 09:33:02
> > -0400)
> >
> > are available in the Git repository at:
> >
> >   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> > tags/doc-2023-10-rc5-2
> >
> > for you to fetch changes up to 8bd7d08407f986fe3c69f3e198f6f7152e12dea8:
> >
> >   binman: doc: fix reference tag placement for Logging section
> > (2023-09-16 18:17:25 +0200)
> >
> > Gitlab CI showed no issues:
> > https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17746
> >
>
> Applied to u-boot/master, thanks!
>
> --
> Tom

This merge includes the first version [1] of the patch "binman: doc:
fix reference tag placement for Logging section", not the last one
[2].

Let me know if I did something wrong in sending the v2 that causes
this issue. Thanks.

Regards,
Massimo

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230909135235.21242-1-massimo.pegorer+oss@gmail.com/
[2] https://patchwork.ozlabs.org/project/uboot/patch/20230913161633.999542-1-massimo.pegorer+oss@gmail.com/
