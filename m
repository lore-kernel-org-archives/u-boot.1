Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36780E9538F
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 12:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4815E839D5;
	Wed,  4 Feb 2026 13:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eGaO3KTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41773839DF; Wed,  4 Feb 2026 13:07:43 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D70CB83015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 13:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-794d58b892cso32862777b3.2
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 04:07:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770206856; cv=none;
 d=google.com; s=arc-20240605;
 b=lGpf39F31TydWhcGFuA32e49dgJeX4nWyuK2xTe1m4lliTqa+LJhGIDKgRN3Zs2j80
 Vh77cZ5Y3jBmxvmdH9c6uf3Bt5i2yU22veAKpzLx9QeU7BGxvwJTPPs9eG0vPrwzlTSI
 iUStK/dlwETMB5vWt6KM83i/S2FmaClDcQ8k8Ik0yFoD5ElOMoWx9cdPPuvtKP5LKNme
 0eNHQrD2hzXTCvAs1OwYQ1AkgIJaRAPws+YyC9vBVYVDdKbmVGjGwotqPdiaOjb/x0kT
 7ndDble2xZv93VhB5MR9cJYwOC0jBIaHU0ENbX9BuPspSdxAN70HzDm+LO6NjfQMZH3O
 b/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PAGPSzNGO+4q7JINtNJsNiKVrSPTPsAZfM1QFKZBu1o=;
 fh=NLhmJuLtHMXzeRHYH/wmny2cHxumrXuKly/sBM+RE48=;
 b=Qox+01yFdzVjnNLQD94iemPtImsYq7OwUog6R3Y+jyKzOTakVTfQMlLhHUXvkS5cMa
 O7W5QslIHt1UrpH0CdBKzlix1SZESBYSnQdaZIa921WOOv6gY/qE7PGjRPG89Y3lqiy3
 /7Und1DDITRcwkAy7e5tX/Zm9ElJ4zoeURIdM/9F5gc3sUFWNmIe95jJGJDHbu+kgHGd
 rZ92K4kEIE83liAvWt2tCiP/LtRTgLcV7+z2Kbwl3fAhQUO7Wn9X5xMFPqgJBdhehYuk
 u33YHf27cJtKdCNTClNUWS64w5N+VG8jV5k9Ne19UykxQVaQgVuoub5GtlCQIzXV/0/C
 ceUA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770206856; x=1770811656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PAGPSzNGO+4q7JINtNJsNiKVrSPTPsAZfM1QFKZBu1o=;
 b=eGaO3KTtQwXk7gDFsWiJ3rQ1DqaG6zrSmNuMGPX090YGqf6Rtd3HfHCc5LW4vbQvkQ
 PkH8jTHYB5tAtgJ4Yqo+ytxmgWTDwMa9bHRdue1mMn/pCELZkeDhaTc4Kmd+vYbzXwKZ
 L6JMy5s38rxVl/H3gW9nOlaL3yB/FVD66tB3yruj1xOk9RblIvM8VrRI8vS3mkkLA+Pf
 c8W3YUUw3wBxDCk9g1/2DQLVWhROSmRclqtCA9bI4vA7ar5J7s8FcGwZQ+TKSxvSq1fi
 rc28I89MduQ6gx45Lkvf3SGpr+srI3E9QesLnp91Hjr2FjPwBj7LhC6ZcN2G6JqEw/Ql
 JrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770206856; x=1770811656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAGPSzNGO+4q7JINtNJsNiKVrSPTPsAZfM1QFKZBu1o=;
 b=kNvYcEUq2myqrGQ3JfpNERqI4XTgAPixVUuBEtneox1zS4uHJXAVSUyNsn25kl2InW
 A9Kgkr14tYa5ILRbVd61TupTDFbA1rQxryCY2zt4NevKLOqgxDAGPNQe7oLqp4nw91a2
 ap5bVC9fUWze5WwreDijS/d7KqfuKKf/yfxi3/uftVfH6H6cWmlypFBhgnupXRFXoCUj
 ikCu35g+eIMhpNC0tMupDaAUvo+gsNf1jZIUYUnlVrupUVsq/lCps02opEk+O1eOMEVy
 u2UHHZcE2Q5I0Zb2RPieA56RcVKiwypjg/lEiVWgX0s29PjUhSvNt5lEjvJRStVC4QgC
 VjLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2R8fje8BjSQFfxJHv9iuaVqe/malcAWUnhQUEXFBvO8UCtTozqBRVE1TSiLPsOt8reHTBvRM=@lists.denx.de
X-Gm-Message-State: AOJu0YwxQgrU8R1Vsw0ju3zhxQUkpPWadYumy2HxMZOisO0T3WXuRoI1
 3IB5B2Cip47i6I1CXCXbaRtNHSCRSm+ALCJEBYEDUGARhQrrQX90mKIjZlei9zEtIiIbcwLDyjX
 vug1sWzTSzPoD4EFBnHh7VrE3wcwjy+Qyq3mRrbQiYw==
X-Gm-Gg: AZuq6aI16CY9ypja6h9jEU8AU/69xlLX7oY9gN8fNSfhIQY8U/i/c8VrF3urAgQMfdB
 lXtT3S8zHsyLXsqk++yjV4HpeVt0Bfm3gmKH+sbKSxksLJsOs839vBqaWe+iFLSiYd8FjCZbTVu
 MCiDxVpXPeeQH1xrBj8GScXeNcKup03gjkSqiFXTvVsqaJsv/nK8YFNbDZiy0OQmH73f/qQzMU9
 bTyWG2dTcAr19QyNlN87zQfeuOEE0cE40ItRlMSKVw32G19BnUYZhvY9TzN8PDyNQ0L7mwenMUm
 517qpon/zUv7HNiwbpW4jBTqMfDAE8b6pe+45j+s+FkYg376yfoL6jAQOgl7q1dJpPZXmfouTnP
 bPIcKWi7fucdUPK9NpICoOj58GKZTzUOmnuLvhMz8QVYiwQscWKo20FDpM9SBHAHd1D9Xj2/Kc/
 evyDfl5xQ5oN3NaD7tztaeoCxzeWWC1DQaO5fkvacphGrCmnR8NTlmp5WmV0tbt2razzEWZUsEu
 Q2mxCCEgV255IjUD9LTEXu3n3H6oRiTNO8Ay1VkLzAJp96SpYSm+8TH1ubwnskWddMtJtKddvqW
 vTeYIBbYO3wsgH/F141WnB8OFuLhjkCW
X-Received: by 2002:a05:690c:4483:b0:794:7866:2611 with SMTP id
 00721157ae682-794fe63f594mr27065577b3.1.1770206856530; Wed, 04 Feb 2026
 04:07:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770105470.git.michal.simek@amd.com>
 <620c169fb271be3ca6de3e8aea498fba7aa36d99.1770105470.git.michal.simek@amd.com>
 <GV2PR05MB11941E99EBCEFBB6D8F523E6F839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <92c5c4f6-05fd-4c65-be43-b5125030cacb@amd.com>
 <GV2PR05MB1194157700C5D0ABCF1578C64839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
In-Reply-To: <GV2PR05MB1194157700C5D0ABCF1578C64839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 4 Feb 2026 14:07:00 +0200
X-Gm-Features: AZwV_QizlaUA-eMQTtldIYPsVfHAOiJQ00D3crbrhVlBKPbZZG5HstfjNeFTM9g
Message-ID: <CAC_iWjJm2uBi33Xm36tZ7Z4j3dxBirOagsTJGuuiLKebF+LfQA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] efi_var: Unify read/write access helper function
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Michal Simek <michal.simek@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "git@amd.com" <git@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shantur Rathore <i@shantur.com>, Tom Rini <trini@konsulko.com>
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

On Tue, 3 Feb 2026 at 13:29, Maarten Brock <Maarten.Brock@sttls.nl> wrote:
>
> > -----Original Message-----
> > From: Michal Simek <michal.simek@amd.com>
> > Sent: Tuesday 3 February 2026 11:10
> > To: Maarten Brock <Maarten.Brock@sttls.nl>; u-boot@lists.denx.de;
> > git@amd.com
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>; Heinrich Schuchardt
> > <xypron.glpk@gmx.de>; Shantur Rathore <i@shantur.com>; Tom Rini
> > <trini@konsulko.com>
> > Subject: Re: [PATCH v6 2/3] efi_var: Unify read/write access helper function
> >
> > Hi,
> >
> > On 2/3/26 10:44, Maarten Brock wrote:
> > > Hello Michal,
> > >
> > > Why are the new function names non-symmetrical?
> > > efi_var_to_storage <-> efi_var_from ...
> >
> > Ilias was asking about these names in v5 review.
>
> I'm sure he meant something different from what you implemented.
>
> > I am ok with this with a small nit.
> > Can we rename efi_var_read/write to efi_var_from/to_storage? I want to
> > make it clealer what these functions are used for
> >
> > With the changes above
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> I think Ilias meant to use:
> efi_var_from_storage & efi_var_to_storage

Yes , thanks for claryfying this

/Ilias
> and not:
> efi_var_from         & efi_var_to_storage
>
> >
> > Thanks,
> > Michal
>
> Kind regards,
> Maarten
