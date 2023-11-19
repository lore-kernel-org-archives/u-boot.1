Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC99C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B41874ED;
	Sun, 19 Nov 2023 01:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ij2BGVP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2FD870D2; Sun, 19 Nov 2023 01:44:15 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC0687446
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-da0cfcb9f40so3230674276.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354638; x=1700959438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=25WPOGfZnuoxd4M+Kv2flpYcLZfSY+MTwezFGM7NaKs=;
 b=Ij2BGVP+rQvtFugW0DEMdTWKf1LUihyrviN1yzZWieBzLRgue1M4EVrxT0pa16Z/6E
 d9uPsCk5etCBjDwIr/FUnbZ/Qkk1Vsxe5G5NjK96crkCcZgqVXLWx2QL11HAYu+/a6ZN
 zpYq1rrYHpIsC7TSi13XAq3rKUl6xrfc8OVKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354638; x=1700959438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25WPOGfZnuoxd4M+Kv2flpYcLZfSY+MTwezFGM7NaKs=;
 b=a3DPyZFhOkxU6/Z+XEdOg66gY9sqQP8HYfExXvLN+NGkx1UHqI2PyU6qzKcb9yYtOT
 zCib3ea226Bvj3aL83tF067lZv6FY+OOCLUbo/CKqNuWq/3TYiL/kWgexUe/rUl5IGKQ
 YvWf4H7339g1HHlvYftWMuhhRrns9cFTlVFkGZx50+iNzhnlirf8EQUyri0RRX/RYQdA
 PbzysRk34uQOlZ3NK21P+zGH3EAkjZ2zIVyhzqHlmWT+7rnoRijblfYPv2ZrYdU3AJjc
 mRcaLYnzXADX8B+QsfeBdD3ac2RBXUuCr0AKZpK5A7fPrg3+4SsX4uyrGrnyB0LSjnt5
 +G3A==
X-Gm-Message-State: AOJu0YxNLMpi947t1hH6qRcASts030LBmNBH5ubRVKzSIR219jAkSBAA
 aveVSRqXbRFbViOIXMqt+80FJJtY4p471y1MGX/m5w==
X-Google-Smtp-Source: AGHT+IH1+9DzJZf3GW8+z3cOhcODmXEO3doUw93yoIZwy47bnubEBLa7JfKUPC6booEhJLdR6AzkyWROlfHPr6+QaiY=
X-Received: by 2002:a25:cfc9:0:b0:db0:279e:5ce3 with SMTP id
 f192-20020a25cfc9000000b00db0279e5ce3mr3199876ybg.13.1700354637896; Sat, 18
 Nov 2023 16:43:57 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
 <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
 <CC91949C-3BBF-452B-906F-93520A314858@gmx.de>
 <CAPnjgZ0sgCtPXa5ZOOpW-zyCnVm_cNU3OyDjzPercdY1=Y1_dQ@mail.gmail.com>
 <20231103192548.GR496310@bill-the-cat>
 <CAPnjgZ1QhQ0Kx7S8nof4Hs6cX9b+tKyMOyzg2dod-WvjOkoMTg@mail.gmail.com>
 <20231103201341.GU496310@bill-the-cat>
 <CAPnjgZ2LnT=esHGNRf0RNCPaf1BNhzA+QxWcQbjnBfy9B3QUuQ@mail.gmail.com>
 <20231118191508.GL170968@bill-the-cat>
In-Reply-To: <20231118191508.GL170968@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:01 -0700
Message-ID: <CAPnjgZ23jZX1Dt-vdQFH-=+CvRUZdoeB8Du577swDhnukeF+Tw@mail.gmail.com>
Subject: Re: [PATCH v2] smbios: arm64: Allow table to be written at a fixed
 addr
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
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

Hi Tom,

On Sat, 18 Nov 2023 at 12:15, Tom Rini <trini@konsulko.com> wrote:
>
> Splitting things in two again..
>
> On Sat, Nov 18, 2023 at 10:10:17AM -0700, Simon Glass wrote:
>
> [snip]
> > This is the bug report of trying to boot into U-Boot on arm64 with
> > more than 3GB of memory.
>
> OK, so can we just please fix this, for v2024.01, in a way that won't
> make things harder? Fixed memory addresses aren't the right choice.

It actually doesn't use fixed addresses. That was the previous
version. I believe this is the right fix, until...

> We
> need to have the discussion about memory allocation/reservation
> elsewhere, outside of this patch, to have something that works for
> everyones use-cases. And possibly a similar discussion about when data
> structures get populated/updated.

This is the thread that needs to be started.

But just for the tables (SMBIOS and ACPI) I would like to use
bloblist, as is done on x86. It keeps all the tables in one place and
provides allocation, etc.

Regards,
Simon
