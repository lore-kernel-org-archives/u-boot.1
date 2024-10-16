Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66909D2A53E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB8888BBE;
	Wed, 16 Oct 2024 20:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PCvGqEZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62BFA88DC7; Wed, 16 Oct 2024 20:42:56 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A88088B8F
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb584a8f81so1829991fa.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729104174; x=1729708974; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUfohrmlL38p439DWBTlou4hatWmaFoG+6kU/ub9eVs=;
 b=PCvGqEZSgeY39iX8u5Pyp+BHt7plh7QKO2LlQ4FSk33xpZWOZEHJNvavSh7AsH4eSE
 cTxZudY3611QhIeJwfw34BgiZuWL5sPsz3E8UQalVG6xCZMSnCoKJ+5Bze38gt6K9/kh
 uAaS3rrQH7BMhgrZ2iz8ktfbWzgH9P2yLGO1sg9MpDj/23IZNFRSZiJVzhwc/JYABZBa
 mPP19DcvRU6kJ/7Q3bap5yrkbV7aJfMUEHrwynaBmTWN4ORBf6CwOtkLJI6LFexLWcjD
 8Zp7q88koVgcFqX5Fa0D3Tyegh9gAUf0JPGMclebq36pZHvjvtXRNoNZ/x/gs4d9FeNX
 lHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729104174; x=1729708974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUfohrmlL38p439DWBTlou4hatWmaFoG+6kU/ub9eVs=;
 b=Gnk4Io+RL6hsSiKcmIHeEBgalpg3HSbX4lwaUnqOEwB5FIkC7FoaPPCnWQXKVopv/f
 /CNo4dP6dWhguUyZndeNDodaG1vADmkBAPqhLlMTgWfdd86BeOr5c0iQl4Vh+aQl+ST1
 hR5mNwVbT4nuakwieBSYOOsnOOUFabn9TgjJtFoWHx5V5gHDwNuR7voZupbTzFpz/MWy
 /y3EJXexyq6DYwajPDawkEo3ZlaIvw0rXFd1mjiqtOdtnMSIRwSN1pEHX0nN9Zm1yzez
 f0Y8eqPUj1knV5xfZovNUsQ1fV2QVzNWCZdS1RlZCBUTdd3Tvfo6fE4M9y0DOXRVSsdj
 pmHA==
X-Gm-Message-State: AOJu0YzDRExDe0RRg0guyiXJHR6bYUU+fD+x3txc3NwZxgB3Ypz04to0
 CVfMlbgixC1gEVv0H5M0/93HoatgIVohyR6ZAnZ8aGXI2A7Rz9FwdeJX9NQkABQXJ2Sdy36irOr
 7SKa/BzjagKBtz0zhe6iA9t2RT1k=
X-Google-Smtp-Source: AGHT+IGapCDTHTYjjuc//5JvtaU5F/EQWOUfoOkyJf9F8DfF+o0nQeJOpkYW7iyLIvv3mozRqC9JuOG7mEQTa6g/JBU=
X-Received: by 2002:a05:651c:504:b0:2fb:5f9d:c287 with SMTP id
 38308e7fff4ca-2fb61ba31bcmr32504811fa.32.1729104173314; Wed, 16 Oct 2024
 11:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241007120002.25690-1-marex@denx.de>
 <CAOMZO5BX3EvcGAJjKNt-vX9+9se9nzmf19_-4f4gfS59C9Q8Sg@mail.gmail.com>
 <d87b9fc8-5bdb-4e16-a219-51d05230bc80@denx.de>
 <CAOMZO5CGjRXC8kqq8FhDW133Eiw0319we+D9rgjvrs14DMYk-A@mail.gmail.com>
In-Reply-To: <CAOMZO5CGjRXC8kqq8FhDW133Eiw0319we+D9rgjvrs14DMYk-A@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 15:42:42 -0300
Message-ID: <CAOMZO5DWaBG=XS+GyP-dCy0kXOBQzwq3BWh4P9uZgbJ6ivDagw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Lothar Rubusch <l.rubusch@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
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

On Wed, Oct 16, 2024 at 3:34=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Tue, Oct 15, 2024 at 5:22=E2=80=AFPM Marek Vasut <marex@denx.de> wrote=
:
>
> > This should now apply on u-boot/master .
>
> Thanks for the heads up. This will be part of my next PR to Tom.

Hmm, still fails to apply. Please check.
