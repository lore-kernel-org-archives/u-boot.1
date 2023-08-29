Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89144C71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 16:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA918651C;
	Tue, 29 Aug 2023 18:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VYkCxJBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C01CF86504; Tue, 29 Aug 2023 18:47:55 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F4486515
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 18:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe27849e6aso7226561e87.1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693327672; x=1693932472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sa4xXlYe4g+Ppzc4qxAJhaMlSaJ5aoZ14YjPQ5Orb7E=;
 b=VYkCxJBntch3nFLCI/ZYidRhPpIIbnQajLicTjAeLA2q+PC2rS2o7ksA6ZVMjjGy0M
 mC2C2q3UeUSW8YF7948Y0fWemNOlJiDY7HVvV745nbkHPCBC0DFvnbYUulijmuWpyzHe
 XbY38j2TXmdgK4dQDpVHmzzDsHCfyCqSP6XSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327672; x=1693932472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sa4xXlYe4g+Ppzc4qxAJhaMlSaJ5aoZ14YjPQ5Orb7E=;
 b=CKlEw1rZcrLHEieM4sPo95DgW34WVDTZmXitnh3VdC6DXkYjfpMeVJyGBg1cDYujmO
 VSGnVUHEa51mF54m9C8NkhEtc63Q9lHBigeo3R+ZnqZIZbHZPFctRHwRmen/Bo2/mFSy
 s72bviyVUndpbmlK0Xed8fq5AFJmV97TwBOUyD7DT7U23aIMX+a35HzvLR123tkP5Vnh
 1gBlzQiAe1oFclTxkFUKDV53GyDI3Sq0MNekftDc54nhKniev9Ei8XR6BWS9R3pQuaJx
 rpGK3+LTLJZJuFuHWHgz45W8E/yrWBA6lQrkbRRDgz2htfzjWqzb1PY7nKdEoFBRsFsu
 ccOA==
X-Gm-Message-State: AOJu0YwCEMdMwODorXvLubjsOSgJJY00lKxiq59lHu8G/+y7dhpK6kRG
 5TpZDXIN2iY2gjYDwiKUFBats1Z7fS6SRFmwhLRwEA==
X-Google-Smtp-Source: AGHT+IFutzua7G37hhXaeByeYtWghpXdWlhMVMtxvYlrMV1LQZ/b+25I1dLh4QmwgODFNl5RnjREZs/kOeSVRB84NE0=
X-Received: by 2002:a05:6512:3d8a:b0:500:c709:5845 with SMTP id
 k10-20020a0565123d8a00b00500c7095845mr1123263lfv.4.1693327671960; Tue, 29 Aug
 2023 09:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230829065427.16727-1-heinrich.schuchardt@canonical.com>
 <20230829161720.GF3953269@bill-the-cat>
In-Reply-To: <20230829161720.GF3953269@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Aug 2023 10:47:40 -0600
Message-ID: <CAPnjgZ18=1M_xn8Usz-DBFksnUciztPZgotX7Qz7syLu9sbkgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: describe Kconfig fragments
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
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

Hi,

On Tue, 29 Aug 2023 at 10:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 29, 2023 at 08:54:27AM +0200, Heinrich Schuchardt wrote:
>
> > In the 'Build with GCC' chapter mention Kconfig fragments and show how they
> > are applied.
> >
> > Adjust the formatting in the configuration section to consistently use
> > italics for file names.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  doc/build/gcc.rst | 35 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 30 insertions(+), 5 deletions(-)
>
> We should really restructure this file as there's very few gcc-specific
> parts and the rest is also true for clang.

Also, let's decide how we are going to manage fragments. I replied to
that thread again.

Regards,
Simon
