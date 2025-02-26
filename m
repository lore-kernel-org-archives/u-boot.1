Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F3EC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F0480F88;
	Wed, 26 Feb 2025 23:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TCPTk6zX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9214E80FDE; Wed, 26 Feb 2025 23:04:18 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6142180F12
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fc33aef343so687327a91.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740607453; x=1741212253; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W9No1fciq+nUAvR8Gofhryc3qFzOK2yiETDsVEmgzpM=;
 b=TCPTk6zXaU23HjCQJgm+GtaYOw1Mw8iYGPz6QzZu5HLdGwYXAFwAB8JwzhzkDmZwQc
 mHZPpWF+bG9wCn9Uoxju7DifnqxulDnHaDWRNKefEWoa+Xy2XB+OFwNi4/a7G+zD5Df6
 wjsn7WAyyp1Ke0ApfuqujhzBVLze+iuzBvGJoQh2rlZLbRYTG1/ohVsg0bnAIvTOSdzq
 qMtFeF4omCuXkjNHabnHRJ/kq8NJeOuz6X/dObGS/Eig4CAyngs//Dio0+aotuEuba7p
 TLGUDMZbWdAIKAIKHJhiZfyRGw3K0kzpMyrG1s34p46WcugQ+tmUHyjg0hdZ145WOxVB
 AuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740607453; x=1741212253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W9No1fciq+nUAvR8Gofhryc3qFzOK2yiETDsVEmgzpM=;
 b=RRbPOut73Ufy5WYBj29xtb09DbkFQSXxdu/M3HgWb7BC4XR5vKPLcpjLYPUwB1+hrl
 s0hZkucqPl6IRy577bhTkJ/uhI57i9MDWrR3qltfn6avZdiZS9/VrtvgXIqdZrlnnk1g
 OYP0VxpWm6BfR+/GRvXdczUgyMlomgtKP/JuNcTooqjRHd0TPwPi1ndD6Ts46VqwQEFm
 p/w1TF1fR9NMYFN3JYEXr/GaR2G+ZOcbL/FGl25EgVBvrSJAFOcoyVABmRyMknPFcY8e
 tqpKd+zSTUxJLTI7Ey5047TDfxnF0HJLIhWBk7VGJQ+RkHCgO6hjf+Su2Upt5nW3ONft
 B4sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdwEm5T076rX3cEjChvm0/2W6iyJY66rkDClVRtjBuKuPv28Eh+QKo7FrU6ndxNMY9IHv9Al4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1N+KeRMC2gLX+66gc8lDLp+tPioWX7jrbHNYNhuw6fLZl1sSi
 wnkHynfXFoVf5PvAo5spaE377Ep45UjZcff+yb8aS26BoLaeoZSQfBksBgwHujU0gKumJPh/5RV
 Fd81rChMllKQ7TBtm9F+1i9GIOk+lWLrHc8v4kQ==
X-Gm-Gg: ASbGnctd6zLdnDq8ylr7o+AXHslw9pJuNh1Mu9Z2i46LCHmmJOXhwcY3+IMZGqq5Z9E
 gmHNozIozyEi7J2iaJ/mBR0GbwQmIK23C3GVBCEsoWWlVE298905HkOiWW6uiMBayuX3k8XYZQM
 XFOY5A7XfGgg==
X-Google-Smtp-Source: AGHT+IHppS4DrV2pSHpr8kzMzwDSxrbHFvPdPEutqhyyv+ivCx32VHQghcSDFLttE07CzrD+EaaB4Rrl/b9HuPzYgOw=
X-Received: by 2002:a17:90b:4c08:b0:2fa:1e3e:9be0 with SMTP id
 98e67ed59e1d1-2fe7e32cf3emr7341340a91.19.1740607452948; Wed, 26 Feb 2025
 14:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20250203220825.707590-1-raymond.mao@linaro.org>
 <CAC_iWjLYqUucPThnuYPP_Pr19BQfQPMv4AY5XHDnJ8Pi_=hfhw@mail.gmail.com>
 <CAEfUkU+292wu7gdbj-BJoj9oWdt0SuUOeHtF3hv_uOyvjG20DQ@mail.gmail.com>
 <20250226153929.GK2640854@bill-the-cat>
In-Reply-To: <20250226153929.GK2640854@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 26 Feb 2025 17:04:02 -0500
X-Gm-Features: AQ5f1JrQpa9sWGC1DqdcGNDocNIxKco3FfTgUdE_6cx_XvKduYhlf6lCxdJIXW0
Message-ID: <CAEfUkUKMKcqrJ1Ty1=1-mKNGB4Fiy3J_XciX_SZb0z2H8c8nWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mbedtls: fix incorrect kconfig dependencies on
 mbedtls
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
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

On Wed, 26 Feb 2025 at 10:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 26, 2025 at 10:25:22AM -0500, Raymond Mao wrote:
>
> > Hi Tom,
> >
> > Is it able to merge this series for the upcoming release?
> > This series includes the hotfix for the building failures when
> > WGET_HTTPS,NET_LWIP and MBEDTLS_LIB are selected.
> > But it is rebased on one of Simon's patch:
> > '[PATCH 01/19] mbedtls: Add SHA symbols for VPL'
> > https://lore.kernel.org/u-boot/20250126184333.4058848-2-sjg@chromium.org/
>
> No, sorry, I did not realize you intended this for the v2025.04 release,
> I though it was for v2025.07. If this is something we need for the
> release then please rebase on top of current master, thanks.
>

This series can be directly applied on top of current master 'Prepare
v2025.04-rc3' since Simon's patch was merged.
I ran on the CI with rebasing on the master and all tests passed.

Thanks and regards,
Raymond


> --
> Tom
