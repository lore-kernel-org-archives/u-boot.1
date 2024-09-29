Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9FBCF6495
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 20:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF6B886DF;
	Sun, 29 Sep 2024 22:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KQC9RWq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4C8886DF; Sun, 29 Sep 2024 22:53:34 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5193881A2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 22:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5398e33155fso1172845e87.3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727643212; x=1728248012; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cyxnpyI499rk5RwpHQav+x3bXOj7mDItbvg0XWCsdU=;
 b=KQC9RWq2agfwVdQyGYHByNwP9HLVvbzkRWAqlOgQfQwF6CMM7mo4MIyanN0uS4csf6
 IQlUT8TdWjBFk27KnIxCntiLht8u9uxCsJxiWs2AujVPknzErZNrvg6yn11lCPpXB+Wd
 5XX2WnpHS7B7TV0lqQcFaGAaxnLVdGHu0LWuvH9vcn0SLVok41debD74l+IDe1+S0BqC
 q2gPsmwUCRGXredB6FOw/0VvvwkRH0j0PkLVFV/D3j1nNRK5+UPhA5RBplpmHNqMDYz7
 sg9nejYjtttUdL7GG+/h4Cydqr/zrEJpTjzNSEIpGteGKr6oqRXKXM2kjjEFpw7ByRMK
 hDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727643212; x=1728248012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cyxnpyI499rk5RwpHQav+x3bXOj7mDItbvg0XWCsdU=;
 b=mJrsLoi0mLvloSey0+9yFfT0uNX3j25c1YFFyLO3uvOzCSCVQn7JfN8ULt5H+cKZ7w
 mj27rAAtGroJ50VioWNAQPXGA7im+uSz5XUadLLQO6WJJEcgO4cUGyf135QVIfzquOGV
 7zXK8O+o12gwOMB4TpFR82KY5Awji2++6DVVIRi4x8BicWNCY4adegEgBYiM7eXKC9RN
 bvfMOy5IDiJSBAmXvwQZL54SYCRqUndGjx0Tn+NpNQJXJnivoIW6qpqR6BMgaw5IWRhz
 k2JbepeNTESlT/YIenNLM1dbWOFtao4nCt63pbg7d1J8xqTAL0Jy+hpDgQ7Ze93sYZ0A
 2yog==
X-Forwarded-Encrypted: i=1;
 AJvYcCW40xEL3LbJ4KwG8oztLMCoVhKH15u2EYLyuvwWkHrRjJZld/Rri2LOqEqu80CVRDo+xlg2jkc=@lists.denx.de
X-Gm-Message-State: AOJu0YxI3OhnFLjB6/KEhn7IdZzZaCWlFyPmvYvAbbRUZSfaOKlHfC+W
 NUIoVyHJOZB4jd4jTEU2ptDXoeoSm+3/Ij+ihhzXNJq4SkOk+8M+V3IUD1eR0p+LW/YjdqtuZV4
 aEK5puVOieHrADnrdYCiC0tWSTFjGtQ==
X-Google-Smtp-Source: AGHT+IElxEZw+JQsaV8sKgwfulZrfy9x+BDuuhTkT4FhsIhUHtEXeA1iRwLtQVT3Y5OgZ0y6HLOOZqHP8ssa020cdGE=
X-Received: by 2002:a05:6512:3d9e:b0:539:8f2d:a3bc with SMTP id
 2adb3069b0e04-5398f2da516mr1741002e87.49.1727643211750; Sun, 29 Sep 2024
 13:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240927124237.47-1-brian.ruley@gehealthcare.com>
 <CAFLszTjHkmT0JcgcZ6Yn69q27Pe7YhvwuXc0bC0N+agmpPtCfg@mail.gmail.com>
 <20240927204046.GW4252@bill-the-cat>
In-Reply-To: <20240927204046.GW4252@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 29 Sep 2024 17:53:19 -0300
Message-ID: <CAOMZO5DAUD3WR5z8ZxPkVhnv_2VZpYaHRziEvZ7MHvwooNS8Jg@mail.gmail.com>
Subject: Re: [PATCH] binman: add fast authentication method for i.MX8M signing
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Brian Ruley <brian.ruley@gehealthcare.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, ian.ray@gehealthcare.com, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon, Marek, and Tom,

On Fri, Sep 27, 2024 at 5:47=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> > Please can you coordinate with Marek as we need to sort out the test
> > coverage for this etype, before adding more functionality. I did a
> > starting point, now in -next, which should help.
>
> Well, when someone has both time and understanding of the tools and the
> frameworks, we can expand the automatic tests while still having
> functional testing as people use the feature.

Do you think this patch should be applied as is? Could the tests be
handled later?

Please let me know.
