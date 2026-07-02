Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EDBC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481D884942;
	Thu,  2 Jul 2026 12:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YBLPgep7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992A784994; Thu,  2 Jul 2026 12:55:07 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF42C847C3
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so3215199a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782989705; cv=none;
 d=google.com; s=arc-20260327;
 b=qrRfwzABSS3pq7M/wL+aByFWXKn1cGjOmQHNXIvi34L8pNkvYdXMWmt0MHbWYPu9do
 5qECATiEM9aH4LuzyZ5k/AOYtlP+jCM+R7FOlq+AtvzCASNG423BqzqD7iBlHFtsaSOq
 pBqAuG42PHxl7lOFqC33FZViWg5DhZ+wfepx9ZoumNwjav06ivhhzLFjFSq/DhscBB0o
 UeHNBO9J7tTbc1mpDr5POmKJqcuM/AgGeBbttftr0qhhcI9qAFOCJmDLq+Oj0u5KWLll
 PRfojfCqrKaaNCRpZzSsMOQts9yg7ftpY8Rjbf/l8Z86zBxMayXqZUMSro5soTcrc53S
 AD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6wgvGDtv5MnNRe1X+aYTdnEQFFKIlkOV3EQ/l/2ZoKM=;
 fh=HQTfuPblmOkXa5cHcQbeseZ/97zAN5mfkrsqcBd9jYc=;
 b=k5ut2nsAl5uXTFLPSxtvAxzheA5cTxsi63sTcCB01cUKxyT4MW3W+Kq10TSW+Rwjv6
 Q3dKQPrMJ+H7lgrBsMN8ZgYmdk8BaSFAii+nrncY8bKD+DO9Z3S2pfBQmfe9tSEVXZJg
 gMgJ7fOQOSFSTWHspvXFlf1LLXaBXtkNxasKuCxrxNNpHKsYSa9CWSybIQda9k16gvSH
 XN9c90OLtQFX0s/Y4YqabnZlsxOLaaM8rjFaMeXDXwm4pqXgNf7/8QHLJ7mf821E/yt8
 CGq5P58CBglD+y8i7Ijlj2gdBRhashza6kULMEhGblQ4H3/p6hFttBuLNp7ka+oBhLsr
 4uMQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782989705; x=1783594505; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6wgvGDtv5MnNRe1X+aYTdnEQFFKIlkOV3EQ/l/2ZoKM=;
 b=YBLPgep7GkhDemdojAWqZpSUpJcaLuyGMF563TB7vTO9tDlVy3nehmnTi8LP7Px56t
 LasErsx9Lt63auWb1yDuegsL4jnCqwI/zFVQst1p8LbakvLiP5aERPSMLjSlJ8LVl/18
 5rWDoT/fm/s6WcOs9BNAtRq/ByQntW5sw/NeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782989705; x=1783594505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wgvGDtv5MnNRe1X+aYTdnEQFFKIlkOV3EQ/l/2ZoKM=;
 b=s8nfA2nBQuoZkL5umUPedHQV6R8XRImiPVE7zywm5atNe+gO+JWZXsGGs/geqB/59v
 Dk5H9n7ZjLkAYUAp7LYpbo/ZJHUa7QpL0A+9rEbmPUZ9FwgXDaAdxr/eHZy+lyG9AdEs
 Qpu7Rr7QZma35ifo4lJas5OrHSakFZW6+9xAQJ93Xb2w4bwX+tAGUwPObw4DEmOXeqpF
 niFe9hQnFzyBqYQlRrhrfgQQLBjeucyr7hwbihOUH7tx1N/FWUFcbVnuMO10/rKsbAGJ
 ljKX/iCd51GjoNEvzCucKopP8z21dNg0KkQPbEnKS6tDLvjVKJSItA4khZY2tQZhxaNW
 iRWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQEjgFndmd2Wj5OceXRo8FE7V+r3C48EEcdLXH/8XmqLUzcy96X+YNKoysDTY/yWBX9/zeE/w=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4lk3bhcBizYUVtPIA1uTXbED+x1S42Pb5/eX2L+Bl9Y9t8Zup
 5+6vpHorqdU95JUPY+dz57xv0c9eUJLQk/ckjEM2T9ttcMcGbUv/EsO/VcAYlo+9nhwiExXWHJl
 j6EKGXY/QT/AN4I9ZEtI2S3hUIXLjFxIcBUAQFxFC
X-Gm-Gg: AfdE7ckybN9XzX7yvgRL9Hkn9zTeJOZ4f5w6OXC5JRoT44ET669lsL4qb2JLbmuvAwn
 AYbn2Pdrl6RSMwsJGWLWY0OZFU7pJiuJOi3zJucpIlFK06E6xAk/bN5UsH2vANCIxoAslGd1TRC
 FaroBAcg0NtD0HRBZ1U7IKpN6duyLxWaFDYQw/tNYCTyfBqRq5afoF1dQS2TioidO7fTXKhn2f7
 K65mnWYvqMZmT5D7l7iTtMyk5ZJsaEZLnKhwBaBU2I+ETozv8qfzoVQl5lHMJNAEENiPDF6UQ==
X-Received: by 2002:a05:6402:a6d3:10b0:698:adfe:fc09 with SMTP id
 4fb4d7f45d1cf-698adff07e2mr580296a12.33.1782989705120; Thu, 02 Jul 2026
 03:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-8-me@ziyao.cc>
 <20260701174940.GP749385@bill-the-cat>
 <1c9f6db6-4307-4860-851e-be46ce2382d6@app.fastmail.com>
In-Reply-To: <1c9f6db6-4307-4860-851e-be46ce2382d6@app.fastmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:54:49 +0100
X-Gm-Features: AVVi8Ce4toF4BIMvbyE_atzRzNj8erviiCqjp5Uuar5rBBI8HWih0hxQcC1nmSY
Message-ID: <CAFLszTiKvhiUJ+nckx7yMm8pzKCY3hQypX23r2xwmphCmX13BA@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] LoongArch: lib: General routines
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jiaxun,

On Thu, 2 Jul 2026, 10:24 Jiaxun Yang, <jiaxun.yang@flygoat.com> wrote:
>
>
>
> On Wed, 1 Jul 2026, at 6:49 PM, Tom Rini wrote:
> > On Wed, Jul 01, 2026 at 11:17:59AM +0000, Yao Zi wrote:
> >
> >> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>
> >> Add some common library routines for the architecture.
> >>
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> Signed-off-by: Yao Zi <me@ziyao.cc>
> > [snip]
> >> +#define CACHE_MAX_LEVEL             3
> >> +#define CACHE_MAX_INDEX             6
> >> +#define CACHE_OP            GENMASK(4, 3)
> >> +#define  CACHE_INDEX_INVWB  0x1
> >> +#define  CACHE_HIT_INVWB    0x2
> >> +#define CACHE_INDEX         GENMASK(2, 0)
> >
> > I was expecting checkpatch.pl to catch the double space here, but it
> > didn't. It did warn about a few other things in macros, which should be
> > checked out at least. And that comment applies for the whole series,
> > along with a manual check for other spacing issues, thanks!
>
> Those style issues are mostly copied over Linux kernel counterparts, should
> we leave them as is to ease kernel rebasing effort, or fix them for consistency
> with rest of the U-Boot?

Oh I missed this - if it is easier for you to maintain by matching the
checkpatch problems then it seems OK to me. You could mention that in
the commit msg so people know to ignore the problems.

Regards,
Simon
