Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A786FC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D29887D3;
	Mon, 29 Jul 2024 10:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n7DNEPLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42365887CD; Mon, 29 Jul 2024 10:45:31 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228C687A55
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc34722so6884244a12.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722242727; x=1722847527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oYb0NN0YZkMTzaP1Bph1yiS/fXySkzJteRhAcHQTN0s=;
 b=n7DNEPLB54SACkQT1PpMYmQ5xlkDUnqI7Ihc+3/UdSrz030OguiI6vE4hQv7HWJeDW
 Ybih2/ca425acJlO54nh8lIXmBob0ST2alvt3/w4EQz4O6pNnwg53I6Fsb9XGdbYWN3H
 Y4F66bGiotio7eYE9cbACuH7Owcn9QC2PBmUXJpGgG2mOJlICBFG1hLRFB6kRLuJNxYC
 /62F6GhlpaKp6H6WdDv5BWTIq49+tQyUj7iVvJe2Tn0YZE0FsX6HYasa+a6okD3qit3z
 lqDhWJDLndf6veLSE8d13fr4mmzWTbglQXCOAryugndLQ/11F8F1cqS7C5093WwqgPzr
 3sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722242727; x=1722847527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oYb0NN0YZkMTzaP1Bph1yiS/fXySkzJteRhAcHQTN0s=;
 b=PvmQjt9801TdDnW38/nZu3ZC6NSNPuCfnL8eJaJx92oQ8vspWZ3VcB826JguvzwymY
 uQNY6UpJkc8cjMn2bW2/u/5Vn2/eMmM33FMjSNIxHOcCZ32TN97j7oTkH+NqSNHWDopm
 PFvrWiQnEQvghV4r1GIBM3RCfiFu2MyC9xDCwO8nzwKNrbNzKmWyi0lyDYuVAL5QRHUg
 7jwWu5BRSqMiKuBiOvPaa+qQFqdTSbLpwcc+PEObQOO0pSw2qDL5jU7tzj4iUZ01wPuh
 IwAF6fDF8WVSt1b6FWqmVOUGMj7Kxwv0i484oVAHv0ApoySerQA3g5+B+EOP+greIBMh
 IZxQ==
X-Gm-Message-State: AOJu0YzhTD8AgUM7mZ+FGeEKf8RPvJs+S0uIwbS2tmOazMvsVnZilN81
 m+liHJEZhIufSFh7KRFoKZWC0VjmOTgjZLhevEOp7iHO7kcjTGLKA+sdtSMaG7N15eT84IOxfuf
 PSJFdGVnFTvufkhoz4NQVmS6oc0/38b5apvJY8A==
X-Google-Smtp-Source: AGHT+IHEqKLF8hioy422QT9FqQf0yRtkRlpkTUkc1Go9gEm0YctCMrPC6VbP6D9Fa/PQCbhIjO+01VPYrYKQBlFojmU=
X-Received: by 2002:a50:bb49:0:b0:585:5697:b882 with SMTP id
 4fb4d7f45d1cf-5b016cdb714mr6975054a12.3.1722242727530; Mon, 29 Jul 2024
 01:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-26-sughosh.ganu@linaro.org>
 <CAFLszTg+5teQs4m++hX2wEDh1O7wTjPSK-2ogceFv1R=N_dz-A@mail.gmail.com>
In-Reply-To: <CAFLszTg+5teQs4m++hX2wEDh1O7wTjPSK-2ogceFv1R=N_dz-A@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 14:15:16 +0530
Message-ID: <CADg8p97svCoSq+2dz6tUYBGssn=-BNLQGGxgco_kUPzcf2Xa4Q@mail.gmail.com>
Subject: Re: [PATCH 25/40] sandbox: move the TCG event log to the start of ram
 memory
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The TCG event log buffer is being set at the end of ram memory. This
> > region of memory is to be reserved as LMB_NOMAP memory in the LMB
> > memory map. The current location of this buffer overlaps with the
> > memory region reserved for the U-Boot image, which is at the top of
> > the usable memory. This worked earlier as the LMB memory map was not
> > global but caller specific, but fails now because of the overlap. Move
> > the TCG event log buffer to the start of the ram memory region
> > instead.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: New patch
> >
> >  arch/sandbox/dts/test.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> > index 5fb5eac862..1e1e9eaeb5 100644
> > --- a/arch/sandbox/dts/test.dts
> > +++ b/arch/sandbox/dts/test.dts
> > @@ -78,7 +78,7 @@
> >
> >                 event_log: tcg_event_log {
> >                         no-map;
> > -                       reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
> > +                       reg = <(CFG_SYS_SDRAM_BASE + 0x1000) 0x2000>;
> >                 };
> >         };
> >
> > --
> > 2.34.1
> >
>
> It looks like this will conflict.

Can you please elaborate a bit here. I am not saying that I am not
open to a different solution, but I did not get any CI errors with
this change.

>
> Please check and update the memory map at the end of
> doc/arch/sandbox/sandbox.rst
>
> Separate from this patch, I really think the TCG event log should go
> in a bloblist. I can have a crack at that if you like.

That can be taken up as a separate activity.

-sughosh

>
> Regards,
> Simon
