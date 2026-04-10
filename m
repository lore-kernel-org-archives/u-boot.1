Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EF7F36BAC
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 05:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014CF84105;
	Fri, 10 Apr 2026 07:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ep1K0yY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ABDA8414B; Fri, 10 Apr 2026 07:14:51 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032E783D8A
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 07:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65075c2ba66so1944804d50.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 22:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775798088; cv=none;
 d=google.com; s=arc-20240605;
 b=VgZmheJou5PcZi9d47OS6aBQKKeSy0T8G+cPHHdLcrYlkjaqlLzuNT4LlpyER3nyAb
 R/VaqeEWEmIvHPEBLWxcBMP2OKKEXwm/4HcnCDs+BgzwYAGtCrxs/v9rS7JW68JxpzYP
 qRr4qzoU6Wuasje7qLNtpDqU1EJ61lMDhpu5Bzn7qX5JtTj4tPcPGP4PXHcLw482KK87
 oo38XSXzqyXPkR2Sfwal7qEpO0ouxkhfAnlYCJjj2VK2IbFSu7q2H7nkR1qm69mhEs9j
 x9v9s2mo0m57BPwK/t2vX5qf9MJ0eab+pWrEPcPpnbTxRB+QWk/HqC/mI2KTuG//41WR
 kRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7jHRhQl9aBXQYS9YuTL/Gpw5RnXacDZuCXpLZTvSjSQ=;
 fh=/0hjioE5/K9C5VQmCMSBo3isAEW/+N8uMv5xzGRydtA=;
 b=hZVLNlxHjm/7C511iGfMYtzSo5T7e7agCXHPCkb8ubhRQu29Ne2LbeZ7S16+GzuIMo
 j2Uew2+4gqlRoBaz7m1FN3aclNhyuMKQ2p/zVRasuXFBRV28JBllwQgJ6wEGEq2LZbV6
 oaJVmDgpn4fxRzOrL9lKzYWXx5Demf+ad9yMxFodostQZJFNVXniP7TjaFujwPQM5lGc
 S9g3Cx1iggBfyeZvnFcX/YrZdRh6oOlR7PjOLMpwDILR7YoDhTJ2qmpL4mMBMdOJGdHS
 2fbmsNLvR9UBJc83tb5kQZRiJwPZosrrAqbmxbGhIw2XlDMbnUE3RiaArgCwCtVxjD3E
 heKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775798088; x=1776402888; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7jHRhQl9aBXQYS9YuTL/Gpw5RnXacDZuCXpLZTvSjSQ=;
 b=ep1K0yY7WvtmTI7p77sAjWCbeE4TeGkE995QhaJMzWuMp4do6sc5/8QnRiCH+G0711
 BYm6/Jul/jxJLVKIFTKeSwJ5JQQ4qp3tnGDXEAM7/vQfDvH0CosJGp4TKVhV55qByHTQ
 9g2Lf/aeCXAmBzYDYqFBVbAMnPinpshdmv+B6Dhd/3rKybSM51XbnPk5NmX7pwqXU8oL
 k0khGzwhyIvGxsWZkbe/MD2ozHpKzeuyor10edIV9khZlmVJH63XFgOKPyG6g4+OkM/D
 02Wy7eGIfsYOUkzwEGisMAaX6NYSJVZvzOEvAMXKmpIwnKAwnXjbxW5i59y8EISDuOz+
 /IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775798088; x=1776402888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jHRhQl9aBXQYS9YuTL/Gpw5RnXacDZuCXpLZTvSjSQ=;
 b=lfvwonj4S+rxr5bbaiT/4gyKZH3CTJVDzz6mi7r3esIMSq+aMxIXUlszcsiPgR21CY
 Uow+9kS7hUcA/enelJ2GHmfWgmKLcm5XVV09h9OPV4X4F6p9pjuXmTXdtJWk+9MOgDSZ
 ml6Y7KRzytRoEnqHauoulYo1/EXUE3ZQ55SCeIZoP0aVX3KzaQz4VWZsy4CEp8dYVxa1
 tuREq3QcK4oShe3HwMSBs42W43UApCqN+xrNj2TG1jPeHBYV//3D1WjBWatarVvPs9Fu
 JMBhSI7PGwyTtzT/qQTacfT/4F5SW33RQy+uQSANeehSysERzdbapOR3xcsOKs9KLCf6
 G2fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU73kPPAffgZ+FK31Ob7EbSJ+ty7JOxjQKZW832jjZ3C/mAqAMRyVnoM2/nHUc4AgV43ihqVUo=@lists.denx.de
X-Gm-Message-State: AOJu0YzlLJQQ4ypFQwRc7HF1DTiej6prxLP6R+Ge50l79smYpptADZvE
 5K9EBlVFry+aeCXYk/NhWiHzpBmjGxWWV1c8sC+jpLzwkqhR7/tF/SG/BHn4TueSoldQ0P+qEQC
 VMWtd+7XhWf2bC3jQEVLhk0YpPZAafq+0k7CLZOzjRQ==
X-Gm-Gg: AeBDievNDlV/I0WCUBkshCSHOmmSyIZEu2A4eERbL1djRhUVR7v0tmJnhqtCbRKxmsQ
 MJyyz5J72cThU0+l7AlBXrWIJq8SzF+VqcMjZaVDBUmzR6FHNHDlLKbPhTW/gleyiSnhEvz5U1F
 XRlD/pVpMpLcEByvJAqOsRhv2o7MZUMAXZ7JhaYWNi1lLYi/IKlSKloWUXaWc1jmFnvTiVn9mhH
 9iGkijeuR7ZD91BiDG0hyjy5cYx30cetvsQXZyo+OvtVVEoRcoroJjF7ccZ4xx70DUsjEeyABsl
 dVuz7sY4Aqs6Hnay9/e3ijXn2OwIYKanwAJUQKT8kLAVUbGUvvIDTep36TOjlAGf7saSA65YdW7
 RYiyFydcEyCs9Q88GNyZk4l03J2VMZHIP6Rp0JCFDCfB4N9N4bnkXEiMB6nD6uI3xNGEj+FQddG
 xx5/JEgiceL9UiFj0r77a69qcV9RxUvx0jfTUyzno0lu5uokA3FeN4mucUJb5uwBi3cu48nKN4T
 Ip+8w+4pBoHUYqy1rJNcaNugucHIyl9p40b5YHvGq6YGTBAgU36qAAWR1AmX1ycRWcbE1V0xcj+
 YHvWcLL5uKW8MeFrRycTnKQ2Up7sn9U5wxFyHe88SKsyiX+1sbyw7A==
X-Received: by 2002:a05:690e:4393:b0:650:19a8:2ae2 with SMTP id
 956f58d0204a3-65198a89af5mr1209810d50.25.1775798087768; Thu, 09 Apr 2026
 22:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-4-ilias.apalodimas@linaro.org>
 <CAFLszTiWwbPFYfMByEAff55AK72mhYXBG_V6AxNkBXx7hQFDbA@mail.gmail.com>
In-Reply-To: <CAFLszTiWwbPFYfMByEAff55AK72mhYXBG_V6AxNkBXx7hQFDbA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Apr 2026 08:14:11 +0300
X-Gm-Features: AQROBzBsDKOaJ4C8wsEaC88du2xxOHwnMYOn3W99NxF2N-hj-WkIQvnvYralC80
Message-ID: <CAC_iWj+6UEMRVcsxFWA1w7-8QmLt4T3KVCsnU18ezx4WYx6xtQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] common: Clean up setup_dest_addr()
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, u-boot@lists.denx.de
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

On Sun, 5 Apr 2026 at 15:03, Simon Glass <sjg@chromium.org> wrote:
>
> On 2026-04-03T09:01:02, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > common: Clean up setup_dest_addr()
> >
> > Right now the function does
> > - Re-adjust the ram_size based on Kconfig options
> > - Set ram_top
> > - Set the relocation address
> >
> > It also does not set the ram_size in case ram_top grew
> > from it's initial value. But ram_top and ram_size should
> > always be changed together.
> >
> > So let's make things a bit cleaner and move the ram calculations
> > in their own INITCALL
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > common/board_f.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Good oppty to change the debug output to lower-case hex and drop the 0x

Thanks Simon, I'll change those in v2
