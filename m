Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F1BCA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F1A83622;
	Fri,  5 Sep 2025 15:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dqgYX3iu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10AD8386F; Fri,  5 Sep 2025 15:31:34 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE49C834D4
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-55f76454f69so2027610e87.0
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757079092; x=1757683892; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiYCq4WPRDF55dw8dmkCcnklz6OPmQbmq5aMpzcWKe8=;
 b=dqgYX3iuPQS80ihsMe2kqaYEq7E9viTTj9KREW98huzcPDozaVwgMLnDKOgsXX0xax
 o7G0nnRAloJYn5KMelrvwzjBz+9hjudL6KL1DRmCZugsp/CL2qeEDzsksNJ0SDiv64P6
 jGW4VfzR84EZhSfTgXxyOaxEflTp1Nkz4RVw1wmierSOlV9F/TvVnXJf4rRvWRrj4qfu
 jo9FL0SAhOFI1wF7/zBlfmh6wTBJl3+gO5Md3d+uLL/GNGTgEEIJKtk4DgmCrScSs4Qt
 qqhai2RoD0+pqmKf/Fhonu/Lqcu0jEtcX12j4znku+bCgZ3p3D/aN8qPLih0YWB77yMf
 tTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757079092; x=1757683892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiYCq4WPRDF55dw8dmkCcnklz6OPmQbmq5aMpzcWKe8=;
 b=oAD3kdjuz9nXhyaR6b0FMuGq+xaMi29yZd6m3EQ201+zLQnDmllvx/EbKdcGM8jLGi
 96bR90AAIwyBVP1FCix2lNx54mcWVzZoyTpLMl9DuXd5F7LSqVun3sYLC4NRLCzOI+lG
 S8924a1BAnBgARPEMDEYZIzRF1F3RqgKxnCHsT71VIrTQfZLIig4pevRYx67baUEIu7v
 9V+soQ4D4Y1q3Ni0H7i+VUYKxlOgsEM0741s/k/gecyYmdg/2S4cg5NE6nex7wf1a+IK
 itxxpt6m8iyFWGhj3yqRhJiVsxGQkKVQbZ2uYnRrkSSzN8I5J+qDv37eJuXTWgG1iWhJ
 9Hlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDS80fj5rs1LVu5SnmiKPR1cY8BYeK4kr/MYi5u8IjcLu/bQLe6WeHGjEZ/hTyvYxuR8lcA/s=@lists.denx.de
X-Gm-Message-State: AOJu0Yzxp1o+MMV0as6rtfaPfXxhhWwS2CuNMVmhsL1QKszDwdYcHRuk
 rYCkS58dp9cNGsoTE2zVfNuIe3UoKdRvZtyePtKiv1Wc9vgdcuRJYWKa1krPfdSJSlLR2tPHdLd
 9LM+MHT+vqxrYcfK65aW3gW6rfECcPsWl7w==
X-Gm-Gg: ASbGncvudHp1z3zDSsp17b7hIliZUTAp5IAGv2CmVbi4jRG5gSeQ/3y7aHwjOXzdc85
 oZh7FLCvbik9XXaTTYbSPqYTKi0NIUy8oTeI8p5Tfs4V0YChsPWtLqzUlObbg1ejOYf8N8hb8uz
 BQMHYu3lo5/Rs641hT/4PF6N8VOkiAdZWDDKfho3bj7thTVdQo5BmQ/2pOm5Dm4yMKBfsXZMzIq
 mdeQCjqzNoiIMz3PKBnVpnwLNDOl6joW1Dvp8A=
X-Google-Smtp-Source: AGHT+IFVD39vIU36Np4M3+7fD0cXkEwSnkj3GJjo/WWn2/po6ErHxw2Patx00IeKrmyN6hRG1TzUlkpq7r2MJQGp2s0=
X-Received: by 2002:a05:6512:2513:b0:55f:6a72:5679 with SMTP id
 2adb3069b0e04-55f70906104mr6806140e87.34.1757079091986; Fri, 05 Sep 2025
 06:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250825135504.193004-1-frieder@fris.de>
 <20250825135504.193004-12-frieder@fris.de>
In-Reply-To: <20250825135504.193004-12-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Sep 2025 10:31:19 -0300
X-Gm-Features: Ac12FXzwZUySwTTca7j2T0UPkskF92iegnEXYI2nbwMEs_en0XNPTxfDU2MSONM
Message-ID: <CAOMZO5CuypDzi+vLgLoLzEdO5CHYODprCmaFr5tknwbZE5MXiQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] imx: kontron-sl-mx6ul: Switch to OF_UPSTREAM
To: Frieder Schrempf <frieder@fris.de>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, 
 Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Oualid Derouiche <oualid.derouiche@kontron.de>, Peng Fan <peng.fan@nxp.com>
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

On Mon, Aug 25, 2025 at 10:55=E2=80=AFAM Frieder Schrempf <frieder@fris.de>=
 wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Use the upstream devicetrees instead of the local ones.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

There was a build failure because the in-tree DTBs were not removed
from the Makefile.

I fixed it and applied for next, thanks.
