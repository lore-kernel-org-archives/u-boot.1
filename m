Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC2ACE7CE7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F698916A;
	Tue,  1 Oct 2024 10:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AzFvALDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD6B8916A; Tue,  1 Oct 2024 10:49:14 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8502E89141
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c896b9b4e0so3139592a12.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727772552; x=1728377352; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2PIDDjxYusNej2HIgqUJg0LtDJ0WXBXriuK9l4ggH4A=;
 b=AzFvALDEzs8jGBz+XRmg4tuSR83LDqol2AJBitrf33T7seHhocP3jhlS0PyU1yvJFI
 pQwV+KJRCqt5h7szrTr1FWloyGP9T8lE9mJ4JTNkOeCrO9eT7GYv5+ZFT1Z0QzXXQU7d
 Rp9HlbrRPmBPV1789dDEqlY8gsyqw7t7fwpyEljoaKObiAu+iOd7m9BQQKNKRuPULwIL
 JtG9XzwCbg7TeyfIncGKXRnCrIMOXothCIyn6fLZ9xYHXmvSCx5ubvL5nECezG3OfHVC
 PSfgcr5nDxQSokXkUPgewRkkHX8d1if7oHrVSil+U3WZUWWaKx3QFAr1ptJeyuuT5Gh0
 g3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727772552; x=1728377352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2PIDDjxYusNej2HIgqUJg0LtDJ0WXBXriuK9l4ggH4A=;
 b=BpAK5v8ROSTLis/ovq9TAYZiAIYMJ4AJoGgfvBh1OKqKyFOIudmiiZBwFO3iZMgWPr
 9fhC0grMiS/NfmzxFsj3qhTWn1KSXPnn04O/E230JlEToyB+VVvEud6n7qHUDXOUaDJF
 cR36ufmC/SdbcSFHBtczgrXYzpf8ORpbWhjr9t4/Rn7QcQDB1woookB1WWfYLJGpl6dU
 kZiVDOV9QZHToyUIygS26kxng6CuNQMWG06UUp3cYskw5XHEFcC8OS+FBDF/lwi71Of6
 EL3OVIT6uUbq3du24xOv6K2fKOqJLIxIWJTBwZNlFKLh2gEgYWwSz6aKTVFqFgg4DXe1
 uxzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMpp+JNuyBH4gJnXUyzrQKh1fJIcUbSZKN/VBZuGucyOydpWeRCvh62Lkmg+RxheoLS2Mt35o=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5KXw0Zzt0MbS6ZiEtmZdcehPztqnCttHE3a2y0FJ9fSe0Qoh8
 E4i6mjqrWg/h5jRtUif413fArXorz6pqVms8WMFoB+YG6zg26xDL0dxlC5pm3krFb7PSF0iDamp
 oxsfMXiSWs8rbS0KDXtHz4XLwu8F/faXO+BHShA==
X-Google-Smtp-Source: AGHT+IGR3CVlhSzp37GNa5B/3B4LiMer0mBfu0OOnemYkHTwhjlWGCaq2Fr3opqlQqo3zNIMLIyFQywWAbQiXsU7DKQ=
X-Received: by 2002:a05:6402:3494:b0:5c7:2209:e937 with SMTP id
 4fb4d7f45d1cf-5c8824e51f3mr11790332a12.12.1727772551938; Tue, 01 Oct 2024
 01:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240916152025.75789-1-sughosh.ganu@linaro.org>
 <172688637179.2451825.4736403690225486599.b4-ty@konsulko.com>
 <d08bf82d-b26b-4cc5-8448-229f001fc0a6@ti.com>
In-Reply-To: <d08bf82d-b26b-4cc5-8448-229f001fc0a6@ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 1 Oct 2024 14:19:00 +0530
Message-ID: <CADg8p96pCAudQ5mECN3JJA_LP4PdV5ct2wDwHRZUv3twm-iHwA@mail.gmail.com>
Subject: Re: [PATCH 0/2] lmb: rework logic to validate load address for
 network commands
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
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

On Tue, 1 Oct 2024 at 11:37, Vaishnav Achath <vaishnav.a@ti.com> wrote:
>
> Hi Tom,
>
> On 21/09/24 08:09, Tom Rini wrote:
> > On Mon, 16 Sep 2024 20:50:23 +0530, Sughosh Ganu wrote:
> >
> >> Rework the logic to verify the load address so that address re-use is
> >> not an issue.
> >>
> >>
> >> Note: To be applied on next, on top of
> >> https://patchwork.ozlabs.org/project/uboot/patch/20240913073251.2286529-2-prasad.kummari@amd.com/
> >>
> >> [...]
> >
> > Applied to u-boot/next, thanks!
>
> Can these fixes be applied to master also as the failures are seen now
> in master as well?

The lmb patch series has not made it to master yet. How are you seeing
these issues on the master branch when the lmb scope is local ?

-sughosh

>
> Thanks and Regards,
> Vaishnav
>
> >
