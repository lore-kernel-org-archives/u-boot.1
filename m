Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2294BCDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53005849EA;
	Tue, 23 Jun 2026 09:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NEJkNH07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2833849EB; Tue, 23 Jun 2026 09:38:12 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31203849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 09:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66077e90382so5433167d50.3
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 00:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782200289; cv=none;
 d=google.com; s=arc-20240605;
 b=Fd0s1P5ePAs05zbDw6U+Y3L1ERAr8y9o1q7KlIrCco16AZL0aHscF2NGhQOMs/T6rQ
 kAi5QvucHt+Bp3/yE4qlL8noL1aqFgUgL1Sn56THbmFzVx+BJvwjPiMX1ybrt3wwPV7x
 6KFAuKxS8/aBJtPZnoA73t/n2qwT4CJt52Dn9Dz5uIIeAYh4EDpcR5uxt3K2xig0rZIp
 XzSJ7z/4JiZSzspDQeOIefQMFxii4wXOiIwXKicj+tKeRhWzC9ae6KOi3AEH6K1fgAj9
 8ks7WQCjGzFGX4eG9/sVmHI8Qu7yeYffbT8KdEzn8i7ur0F0qYvFDJ/PMh81L0jd+y4j
 qCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IZQsrb3lQovu2C8cYbz7vT5m3lLwSASUeuDg1VgjZDg=;
 fh=qIPUQDxr7/D9Glya6VmbaeqKMpW6VFkTmvflRuei2oc=;
 b=TNYBjuKd0s0qvEClx0uSrOi3rAMIqma6LgodNqIprR0qsCw0ep5z+tvVNsHJpG9We7
 +uRrgIGTbONFvvRYvawOl6MWMpo0wIqg1Vu0ABlfVm3EynXB8IoElTpcI8kvBdDoqwxo
 pZqTPQGAVd5hyRYIkNcTVCLnfOxB8B0s8V2gWoctYNxZnSrGj9YXhpTVJutwm/aotUec
 nK4z5W3xEroEXPPzXSBBhe2l1az/4SQOJbo8guPMuwLPS2eDAaSlH6yaJYavCUWRHYRq
 tpL1R0W5aTp8O71a8LREai+6ZC9B+Revg7myoU8Vb7kt5T7ic1pT/a9vCZPK7GABSV5Z
 Gfng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782200289; x=1782805089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IZQsrb3lQovu2C8cYbz7vT5m3lLwSASUeuDg1VgjZDg=;
 b=NEJkNH07/MmyrbzvLgwQB74zy7t7MVzfZ76GlUA9v9oaJI8HYRF3UW3n37aqCZURRY
 l+I8sDnyi7IJCoRxv/vvlB0nU7oRwsz8DY/nIGXbCnhjXEzIC7yYgdYZn5Uhf4GSk+/U
 zezJfE6jgngdyvHniZC+WVu8S9fNCb4d2+9RyzLcHJWeWXgY3A83hBseNA2oN2O62nCC
 fGiskBn1JsnQbnemFYLBCu73MUwHzsdm50fKsRrw2w75V96U45iMceSYDtLmaEyInZEn
 nV7XyBGZLHgQP+OgZxuZK8o5MpIPszKyxdRs1h0ZrmWydbN8+2GcNLMtQsWtlEcPe78I
 T6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782200289; x=1782805089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZQsrb3lQovu2C8cYbz7vT5m3lLwSASUeuDg1VgjZDg=;
 b=d+dTIzxjJqpzy/utYFhvb+EUkm+e/iHGpplvFNV5EsUcUhB8iHvFU1O5YiqOmqSnt3
 whGBXbKihZEoeTiM8k94VQGk0BNierANOS56Lv277E52PnW+kSO0wgtkGZBwVHVaBSPO
 avwu53dkA9MnWmCbr2/inGMFQpHDPyuACt4ZKmzAjK5fGUgM1OmY8Auc1YFQ5+1ZHZ6C
 Oq2tqHnzSiSz4ZudpLcMzod0sKUloVNk1xZdIdvYsWWpuK4I85Inc6JKgDfcb+ppUH0P
 zqAW8LWo+AvSK1gevo2YoKVWt4tjgwLtuyYo+Fvw2fvmT7Us4rvXbeh/TddBz8q5D+Ww
 u/TQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJmQlaJxM6jytX3jjjzNgoWZSFEPRiR+yYn/koBfDdZ1KrPzMsJwQi0K6DVBcqeG+I0FAMEHc=@lists.denx.de
X-Gm-Message-State: AOJu0YzweXns6fB9LFa8HxUtxMgTCuMoDWi4t0BH3kFg8Ja8i8DhAF2z
 NSTkFUDQv3YSfvp6YUdV5OkuNTlt5Nug5y5Q/3W9IC+5SHBasHpdA03fDtSLRgJRPjEsNqCn5pd
 BWyaisGxbOcWvoWmO4aT6zLrszkJHGurFilnvPeQTBg==
X-Gm-Gg: AfdE7cniKo/kLQa5Y/7LElJaijB5bU47FjbBCRVqm3ZeZE9vM7i/B4hURL8oUAXwAET
 uiKw2YJbEhAzi8sQZbMnWSA4jNA9RAAY2CYMC22O8/b3yItkglvX7eGdnNsTciVgtqaV6LUFMcc
 3CVlAETYjTFI580CiqziMTf9GSyOG07g14V35XaV8j4vseAHr+8J2in/M59r/T7h0bPVouir2+1
 Xjs78BWrOb/w1X91UMXekwi6bKhXDV3SWLwUFPqXlydHKOoD+ZzwM6lZ2Z/RmauBXKPIvxfvKdz
 QEVH9Cj+up+qObmAwTMshHDPu+oO3bkqDJ1O4uxRv56RcTSmUBcqXb0/VU2kUv8VguZ2motQIrN
 +dsJdKWSHImkGGxpfdh17l/YJ9trvamUUPr/2nN1E9dQ9Krixe/SQgn7iiJeLQ9ZahP0d6fRoyE
 z5e6D/eYx7m4WKS9Owwb669EK0WEL9eXZMvEnqmAuHXM+LLgn9Ou6M6YG9CsrnKeLG97w5pGhHz
 w3Il7kI/xcmqfjKz55xuW2xctD+9m8iWDoNiH62941eyBaiBpG5WyPLt8vryofHl2F82LFRDNin
 3ulYNdd8uZRJw9sxxYkDTenqOiEFRzwTjP6v8yZcvO+AcZzSPDfb0rHYxdmChR6m0JFXRWVAS6E
 zeyAlNQ==
X-Received: by 2002:a05:690e:130e:b0:65d:dca1:ff89 with SMTP id
 956f58d0204a3-66312d6ee7fmr12848536d50.12.1782200288861; Tue, 23 Jun 2026
 00:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260619231719.3823195-1-rs@ti.com>
 <20260619231719.3823195-2-rs@ti.com>
 <CAC_iWjLszH6_c4DXFV2qqQoyhEC9R7emeOKoBO4WvEn5Zza2SA@mail.gmail.com>
 <DJFTGZ0I5LGG.218A8NZ1QBD6G@ti.com>
In-Reply-To: <DJFTGZ0I5LGG.218A8NZ1QBD6G@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jun 2026 10:37:32 +0300
X-Gm-Features: AVVi8CcZTT-mmU_P7GtuMBBwvddiNi9CbqPyRHlCk711LDa2A7-HwOkHSWS8fok
Message-ID: <CAC_iWjK+ceFGMkdH0QmkDXcxu8YxD4uDr3dUgwpmajS8+pw9sw@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] board_f: add a board_setup_dest_addr function
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, sjg@chromium.org, u-boot@lists.denx.de
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

Hi Randolph

On Mon, 22 Jun 2026 at 22:15, Randolph Sapp <rs@ti.com> wrote:
>
> On Mon Jun 22, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
> > Hi Randolph
> >
> > On Sat, 20 Jun 2026 at 02:17, <rs@ti.com> wrote:
> >>
> >> From: Randolph Sapp <rs@ti.com>
> >>
> >> Add a weak definition for board_setup_dest_addr, as a way for specific
> >> boards to override the gd->relocaddr address before the relocation
> >> actually occurs.
> >>
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> ---
> >
> > board_get_usable_ram_top() can be used instead.
> >
> > Cheers
> > /Ilias
>
> It *could*. Just felt a little weird to artificially restrict the usable memory
> because the stack just barely runs into one of our reserved regions long enough
> to break a dt reserved-memory allocation.

I am not sure I understand this without an example. We always relocate
to ram_top for now and that's why that function exists. I've already
started to clean up the relocations a bit [0]. I don't want to add
more functions to tweak the reloc address unless necessary. Generally
speaking the reloc address should not be board specific at all imho.
If there are areas that we shouldn't use they need to be described in
the DT and the core code should look at that. I am ok keeping one
function to change this, but not more. We also have
arch_setup_dest_addr() which isactually board specific (look at
arch/powerpc/lib/stack.c which is the only place we define it).

>
> Initially this was proposed because there are multiple runtimes with their own
> allocation techniques that could potentially take advantage of that space. If
> it's still preferable to use board_get_usable_ram_top though I will change it.

[0] https://lore.kernel.org/u-boot/20260617074846.84362-1-ilias.apalodimas@linaro.org/

Thanks
/Ilias
> >>  common/board_f.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/common/board_f.c b/common/board_f.c
> >> index fdb3577fec09..d9d09ac94bf2 100644
> >> --- a/common/board_f.c
> >> +++ b/common/board_f.c
> >> @@ -328,6 +328,11 @@ __weak int arch_setup_dest_addr(void)
> >>         return 0;
> >>  }
> >>
> >> +__weak int board_setup_dest_addr(void)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >>  static int setup_dest_addr(void)
> >>  {
> >>         int ret;
> >> @@ -362,6 +367,10 @@ static int setup_dest_addr(void)
> >>         if (ret)
> >>                 return ret;
> >>
> >> +       ret = board_setup_dest_addr();
> >> +       if (ret)
> >> +               return ret;
> >> +
> >>         gd->initial_relocaddr = gd->relocaddr;
> >>         return 0;
> >>  }
> >> --
> >> 2.54.0
> >>
>
