Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B4EC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 14:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54ABE83B85;
	Thu, 10 Apr 2025 16:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R3yryEpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60DB583C02; Thu, 10 Apr 2025 16:53:30 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07E7083B4F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 16:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso181708066b.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744296807; x=1744901607; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I/S4YRZOjBx0w7jjACHKYuhK8qy4SF8i5tKg+QfgDIM=;
 b=R3yryEpy37tFfHM2qvyQFA11Kk6HPF0S/ab+pR1EjC+ALQyYla9X58ekK2a4p50IME
 ZWoRkV1/+6Qpb+zwk3F1UbZ/6ZgEDAHk2yMyY6WSJVy3mcvG6Ag25XWCPyOk2nMrMPIr
 SoPceKyZiJ9bLwZ4WrShKomsCnwvzy2gKWImM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744296807; x=1744901607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I/S4YRZOjBx0w7jjACHKYuhK8qy4SF8i5tKg+QfgDIM=;
 b=cHEG2R7Jco6UeHyyebI4hrbcYs8gy3oneA33/1SzBnwZhXQ6DX5bGLJpl+mm6Hcp5Y
 NWW1ZYjOud28EIK0TfXTyKHWOwhyyWinb6zWA9DZ58kfOw/nPkHVs0uUxTfRs8cjAUW1
 GQJcWjrTzzJ51THXlqo+cwbkbuRIM6AcJGcVUa+GMYxra1n0YKR81ktrY8LsKpCDHiSN
 HpqwLupPt17ZBxnQ3M9VFqx1WTWJeG13pXm8pgu8R1l5cPEn19h9vSiZqFnWqBcA3dHf
 io+DMDr+6+9VBdJ+tN0nSnBFl3eBH9RViknFrQ18qcaDhKinEwXg/O8ItCAwEvL/T8vz
 sVDw==
X-Gm-Message-State: AOJu0Yx8O2MPmpYrjJhrgfDpKlu57H3N2luCvZh44InvZ/g8/YWJ1Bpu
 jfvjYejwGsTaSPU5hTZX+q/bdRtBRJvejhGDjN1ZXyrBHjBHW7jPbwdmSbIZUm4x5bQw02IvlQ1
 mgRxN2RyjSzOlwLa8kLiggiHHDiSVeMGu56Cp
X-Gm-Gg: ASbGncuMkuwo0crgNoeSpmn2UZyriKOmCAj6ZETkaSpsPoa5QLp3HCxgoHcSAMWCN4q
 GBVQZJlXNV757QASppeHqrMSPZiliqJo+Pd1snlgXi87arAuNjaQYvss/6WsP0Ykt59gk47KgXq
 7jYqs6v0E0QCn4paOANefeqynxoT8edUaczA==
X-Google-Smtp-Source: AGHT+IHgV8MmZmkh5vH1M40p3fg6Lz0QO5SHBGh/O1dRgAAazxe26VIbWfkBZ10JnXS1YuNX4Mdzv1NuMk9ojv5/CKI=
X-Received: by 2002:a17:907:944e:b0:ac8:1bb3:35b0 with SMTP id
 a640c23a62f3a-acabd194ec9mr261350566b.20.1744296807217; Thu, 10 Apr 2025
 07:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250304130947.109799-1-sjg@chromium.org>
 <20250304130947.109799-6-sjg@chromium.org>
 <874iywgye3.fsf@baylibre.com>
In-Reply-To: <874iywgye3.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Apr 2025 08:53:14 -0600
X-Gm-Features: ATxdqUHaUETYiHOj0th3__AWQBJyCoFtH5RXiJs6t0omnl99x0frj6edASdAUCk
Message-ID: <CAFLszTh=+gC3Uikx7X6qSo6w_eRQZF-xNX3M+0PfKRS+O-xVAg@mail.gmail.com>
Subject: Re: [PATCH 5/7] binman: Workaround lz4 cli padding in test cases
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Mattijs,

On Thu, 10 Apr 2025 at 03:27, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Simon,
>
> Thank you for the patch.
>
> On mar., mars 04, 2025 at 06:09, Simon Glass <sjg@chromium.org> wrote:
>
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >
> > Newer lz4 util is not happy with any padding at end of file,
> > it would abort with error message like:
> >
> > Stream followed by undecodable data at position 43.
> >
> > Workaround by skipping testCompUtilPadding test case and manually
> > strip padding in testCompressSectionSize test case.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Tested that this solves issues when using lz4 1.9.4.
>
> This patch solves:
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/38
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>

Ah, I'd forgotten about this series, as I applied it to my tree a
while back. I sent a v2 for Tom[1].

Regards,
SImon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=452114
