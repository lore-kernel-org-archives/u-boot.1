Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9D9CDB46B
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 08:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F7B849CE;
	Mon, 22 Jun 2026 10:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JLQhCO80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B484849BA; Mon, 22 Jun 2026 10:13:39 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7170849BA
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 10:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-662f479a22bso3544218d50.2
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 01:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782116016; cv=none;
 d=google.com; s=arc-20240605;
 b=JQo+vlUhxWzy+bFmnCa+Yjkbj0v2h8E54JQ70v+hk+I+BBN0iiOCNZU9gERKxS+Ibq
 N8E2cyaCoivQ/YG10+6C66+cZ5m/5Detn0Y3vsnj9/kMZoK4YRxhoFiYxipTrLKhjM7t
 niutICOESr0BaFYyGcN8oLfgPWzZ47WUqJtqYGl+2uAhAnc3+oVt6JzHj39oqIO8WDTh
 JY575EBBCHr4NYo6CJ43x8AUG+uIS29OFcWYr2CFdhPFz3fHAqddLekckLUJSGnwYc+K
 DxIRVDYkC3SECQb6dPcC1U4raUrmABxoyHJI39JpC2ZFm3jhRfsFO+xO/SEHG/ofa6Ov
 isfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PyfV7+SWE7alFfZdDTuMOEFNk1q2VugN4tGRbnWrRjc=;
 fh=hMREXa/XB1UsMwBai1gdiBl56tNWJYphnT8/qa0Dn+M=;
 b=MM6uNQ1/cPI8RoBwiNmirWI9OoOyaCVswwzik9h5ruTad7fHikCz2Oydxs6mEC9xmS
 DpMEPlfdqM9RmNnYNxVeucJH4fVFigT467xXHKBWhQERxGzBhNnU0x0/b/m/ZowyyRoC
 JFaEYPGq8wI+/67kfrRe8EkQn4g+mpXzlrsong3aVX8D6DGyEN8cSPrr7QaN8piJyWVB
 gyRj/CCU8l3BYQJFwMsLAyTrK6rjxMulZYI1Fe8VlA9NE7+bQMHpNywhSV53MBraPc8F
 +Qw8tweLi6ZOcXq7qHc0COilkoe9jvWpoH2ZH8NjeuQmK79g7DXd8dzRfW+72XqFeQKN
 Z1GQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782116016; x=1782720816; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PyfV7+SWE7alFfZdDTuMOEFNk1q2VugN4tGRbnWrRjc=;
 b=JLQhCO80RSHJ4R+xBtO4lr0H6TrcQdzQXB4eUU1XPUNOhsvsH/Ni5k3C1y8wLuhF9z
 4ak5HKQ0tu96TwB4tU3sGSNTVRXr//ZbfniRoQB2/UT5+0RhmBDtVl895iw7Oj8pS50u
 TD8VnKysw9Q0XwWZD2TmmzuTrYsqjNzRM5E51z+CP8H99hKre7XYNhoT0d+VpTIMwmB3
 NIi15RbtjU6i1QUhv1OqUYhqRttR2N9kFEolLv3F0F14LsTtCOBLJK2P9eP9S6eRM9rp
 yJBxCWnHigGV5/QFZX4n6bEKRZ5xTAZMWalsFzSLrbjJ78rBCCd0630xQhzbGY+yhhG+
 luoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782116016; x=1782720816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyfV7+SWE7alFfZdDTuMOEFNk1q2VugN4tGRbnWrRjc=;
 b=tKZhANi0ncYofB09SyELVDQ98qr6FesprgCttNBgL40iKptaKLhAhfgg5XI9+RNTdd
 QlutV3XAgV9SGuvw9RMH5gKSxzBqAubeCVc8rxXfntdIy4fxoHOvuuNQSzw49wpzsP5n
 af6PkkCpCkAmfNj04djRGEOIV4z9ccAljtMdKLfEvMMRWmgs5jD8wQkbu4g3XjSyzFq6
 u6lefKjcRrUrmxCXuj1FS5zLRslP9P/VyZ3mE7t3A4zKiHr2XFcHuVeKcUmO2kh31GF2
 c5MoRlshQs4x+RDlmS16SJA2rwl994M92tIkAHw8Ar8uW/OqOvaoFBDMsefkf6GTldII
 nQdA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4uBGKKec0vQwLu57R81A8pyjv6YPS5HzpoBuAAcOctVs3iW++VmfZ13eYb++kODCg8zAefsA=@lists.denx.de
X-Gm-Message-State: AOJu0YxEm+zWtQVEKLw+I+6DuuGqCYeFkpFklebK7NxjB1OiTAf8hfEV
 +XxcoRxJbqZxEzbajWMGjDUtBwoINmBAVbsKZBIOJO1fJD+0gM5THlRTn/r2bnMMnNZGyfXQGge
 l3IGevucfscoa8vFKWqgeCQtTa6L1W4+gm96r0j6zQA==
X-Gm-Gg: AfdE7cm+5O1AXEgrL1jiK/0Mfq/FacJnj1jz/LtRE/BDRxk0/3qYlm+aipzMukefRps
 qfw7PP15jRviDIK5mExIEPnJv3jsdlCMabQtbPVk5xWyvXzMjDCobIfKQHEysPW3VEdIyE/tY6a
 bSMnWBB8XxmOIphuu7xf7TPfuouJ0g92FQwGLLVqpN2jI9REqCQrJSw8z1yq+9dS+P3qOhDdZsR
 G+1Gn92fnESb7VChaWJgyTUEyuA6u1wYbd9qXYLI9D5S0w52oIM3gGW2ooxd28JaQugjMwqlMfj
 GLHksD9HLCnwDRbiMWudrmBNFAelSL6TMaKE0/byX/mQWIXCQ8NHzFyy1SsXshrP7P8E+NvMm7S
 961qTto/qgfh+LzSOcqqLepm2l+s2c/BIBo7YLF0eyiDitkY80mdvLiscaq6bFaAGPVUGU3h1fB
 bE/cSQQqRYRD+muZMerJboM70+F067SfrPWcCOeVMqLS2UdS+4JGir3e19swYNeuemN2PIhndIw
 w5jUl0Qx/H/unzNlgVtn+Vrj2RdywnmYeuks2jg58V7abrhbcHFoxcXwGO371Yu0V46turAJnOt
 Lgq+ZjNJdCiJYh3RV2ThqbiGAOdVjYkuFOVxeEmVOYzzUYcSAZwMNu/W85jiXEB4SlMJB0E=
X-Received: by 2002:a05:690e:4087:b0:662:df6a:e38 with SMTP id
 956f58d0204a3-662ffb9fa2fmr11129581d50.9.1782116015714; Mon, 22 Jun 2026
 01:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260619231719.3823195-1-rs@ti.com>
 <20260619231719.3823195-2-rs@ti.com>
In-Reply-To: <20260619231719.3823195-2-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jun 2026 11:12:57 +0300
X-Gm-Features: AVVi8Cey0CzEhgjngZCRZwtVGaaDEQ0FLA66v01L9NoHShDJR3v89r-C_CNdTJQ
Message-ID: <CAC_iWjLszH6_c4DXFV2qqQoyhEC9R7emeOKoBO4WvEn5Zza2SA@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] board_f: add a board_setup_dest_addr function
To: rs@ti.com
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

On Sat, 20 Jun 2026 at 02:17, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Add a weak definition for board_setup_dest_addr, as a way for specific
> boards to override the gd->relocaddr address before the relocation
> actually occurs.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---

board_get_usable_ram_top() can be used instead.

Cheers
/Ilias

>  common/board_f.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index fdb3577fec09..d9d09ac94bf2 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -328,6 +328,11 @@ __weak int arch_setup_dest_addr(void)
>         return 0;
>  }
>
> +__weak int board_setup_dest_addr(void)
> +{
> +       return 0;
> +}
> +
>  static int setup_dest_addr(void)
>  {
>         int ret;
> @@ -362,6 +367,10 @@ static int setup_dest_addr(void)
>         if (ret)
>                 return ret;
>
> +       ret = board_setup_dest_addr();
> +       if (ret)
> +               return ret;
> +
>         gd->initial_relocaddr = gd->relocaddr;
>         return 0;
>  }
> --
> 2.54.0
>
