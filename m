Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88943C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 19:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB9187B34;
	Thu, 28 Dec 2023 20:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fp9TtUNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBB887B48; Thu, 28 Dec 2023 20:48:24 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B88ED87ABA
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 20:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bbd9cda1b1so261019b6e.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703792900; x=1704397700; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuBniDVNVXNFhbMj9GqRH6+3uFkvYnVn8Q8JTMqr3TY=;
 b=Fp9TtUNJj1CTQ5fvYwrPKeGaGOiuedDdLkmQh0TpPFQq32YtZgXsqRlEXn5j8ewdjz
 h/mYwD+8vm690TSsQ77pVuQOPkKoNUQ3FU0IhxGtZaf2AFXMDtoKwt8oyNDKd3AFS9sx
 kzEeVNkGz9JM3vpxvMq/y5URqmTwLZn7ttvng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703792900; x=1704397700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kuBniDVNVXNFhbMj9GqRH6+3uFkvYnVn8Q8JTMqr3TY=;
 b=Soez4PSC/BRPl2Op/B64xvxCNdotg6JxVxj5+Ke3dI+0QSNuXNQeTAzioLwY4YCLO2
 cE8Fv4Y14z/RWG1iVjVDXn0c7t84Iomne5jdnyqxx47YWIMHkRAeLMvjEMjCh90VZkYS
 8UWQlv0FJ1stgqazdz5NIiSGET5gPhN4ZyQdS2tZaVxF/y3bJ0Uibsb4XTh9pOAwcRpE
 +49dt07cXx55Cg5FckZYTBtxF7nl2glG/xBoZ7sPjl8suxjamNsROJCdi7lN6kJoZwA0
 98kWZ/kp4O5RYQKig6mmpX+VgD1E6E6IP9bLGkhRyACskkVEe9AP1GwmjLphnPSD5O6F
 OCiA==
X-Gm-Message-State: AOJu0YxYJ5l9chJeJG6B6e+ystYlHBVVNO8jdpk+sk4sQ7toZTmVixpq
 Ij93PlSjBRxOEvrjib5SdSfhQDcbk27stCaYlI0Fyfn7neJr
X-Google-Smtp-Source: AGHT+IFZn6P16VOMrp9AvfTOTaptLJze/mE6WjR1Oi1CLdVHneXPeMDIgQegSjeB93zryK36VbynIAdjbwZgPFyV6tY=
X-Received: by 2002:a05:6808:f89:b0:3bb:dd16:a709 with SMTP id
 o9-20020a0568080f8900b003bbdd16a709mr453514oiw.42.1703792900414; Thu, 28 Dec
 2023 11:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20231228180154.50473-1-clamor95@gmail.com>
 <20231228180154.50473-4-clamor95@gmail.com>
In-Reply-To: <20231228180154.50473-4-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 19:48:09 +0000
Message-ID: <CAFLszTj0QfuQA-1XO7nmRP9JUZP_Yt8-gOK8wcVmCgvT=csmgQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] common: console: introduce console_record_isempty
 helper
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

On Thu, Dec 28, 2023 at 6:02=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> From: Ion Agorria <ion@agorria.com>
>
> Add console_record_isempty to check if console record buffer
> contains any data.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  common/console.c  |  5 +++++
>  include/console.h | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
