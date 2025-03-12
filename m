Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2296C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 16:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 793CC8056A;
	Wed, 12 Mar 2025 17:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UJsid2Ci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 267BC805D7; Wed, 12 Mar 2025 17:11:22 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED6B800B6
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 17:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5495c1e1b63so6303e87.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741795879; x=1742400679; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhTikQDGN1aFXagEDi2cVscvgp098UgfxNcsIx3Nt/s=;
 b=UJsid2Cix45JJXJYsm7YoR/2Edi4YR/qqMw70MwiaR8BzZJE92jYww0xRaVsqrUGF7
 Svoamo0JvPWxpjw1j+nKKrQ+lvfXK0/FMMCI3bqHOGrjBqwRLVw+fGGEksINpSwrYwHx
 6PJEAWW6l0QVeLbtFczU9Zchd4CCbe/M+aCHU+hYdF+4+JdK9QJtHpBFxA8F3JIX9YXB
 ivBEjt8rXg/d8ZAtv+tpvWNFyz8Mwilz0hbWc4UT4Ol6PQ3m/0KbsCjc87imm1eKSwre
 QmbMYmpViCitXgSogcxBzIxkFBOwdVs4yhHIY8Qg8RPlgKjMUn5BOnIjW+ZE8sUrWznC
 PlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741795879; x=1742400679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhTikQDGN1aFXagEDi2cVscvgp098UgfxNcsIx3Nt/s=;
 b=poEzpe9o7BM2HihMjfkPithz8nobzWAZpGTcdfCGPsmuUgDfDEKe8o4jOLLU3LEb7H
 EOQ1FW/0egEGMZTjaduNaPcuzLNsakbe117JfLJx0EXZTLjVWRa6A0LMrkYI64GBQ6p8
 7o2VsE+FVQstNjI9AS5ENEiXEbz9z+qpzRm9Zf2E31QWalX7eZU+F4oA7MXZKa9i/D7K
 Xhb9kgCIeM9nDoDOqiz61tLo87ODPtHf54UAXkFHyI2UEGoLXgqkrvS+7/QbS8hvlQlm
 /upmx/bGsNxjKAf/tgN29agTf434gc8Fzdzw/DtttUSwuZQUe3T4YlpaNN9VYsi2WZEk
 hvBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7XMv1CKZHYxAyBVpdgfDRzBa7YtaeNuJCLa5hUvpZO/z9Arvkqp/EH2CIAHZYvpLnfjgN4Nc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/Ce7M+vtt8sMkeuOnJDntsrnKhmZSPEIcg4pRvP4hplkfBmtq
 gZ27TSDewUVsUK52mQllu89fB5/4vHFqMixOBQtKZw7AZbuiwmss+BGY49KNlUj/tBVf6nr0jq6
 bEEm8zWR92GrSeT7fzX9T2niKZJ0=
X-Gm-Gg: ASbGnctN7YcUJ3XRWyirG2StckPHQD9zrptP318qEomhXexDUGccmpwJIDcX8UFI+tA
 wj6WbOH7Jk9rKYsSPSzze9eDvrR2HlYm3FTLwOkUIz6dQqTBTARWDWv+Gcp+L1lt+PBjITOPeum
 UiuTEUsq6QjiVkSAOLggkahNycQfnqNlemDGjxr0PBupqWzanZEcUy/3XF+w==
X-Google-Smtp-Source: AGHT+IHHKL353pIaKpb7x9gYrISIF1V3TkVQqO449PzWvvFUe6WyuoP8I5vnKVXi8PlJeLzKeDuF/IjIBZPW3D2bd2E=
X-Received: by 2002:a05:6512:33c8:b0:545:9e1:e824 with SMTP id
 2adb3069b0e04-549abaf0ab6mr3475077e87.48.1741795878996; Wed, 12 Mar 2025
 09:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250310123621.389594-1-vincent.stehle@arm.com>
 <CAOMZO5BV1BBP-f++-NzjzEDXCG1-2WVjma8-e5zpi3yLKGeYCA@mail.gmail.com>
 <PAXPR04MB84599BAB4FADAC79AB75934388D02@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84599BAB4FADAC79AB75934388D02@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 12 Mar 2025 13:11:07 -0300
X-Gm-Features: AQ5f1Jpj5p6YWOeDTlGKwSBfnzQwyNw0lh9LLpilSIP4Hpb7wvjaq78WggMSJtY
Message-ID: <CAOMZO5BTGGU=fJkuxjgq++7+qw5maanjZ14p4=9_RhPdO85GgA@mail.gmail.com>
Subject: Re: [PATCH] imx8m: soc: cope with existing optee node
To: Peng Fan <peng.fan@nxp.com>
Cc: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 "tharvey@gateworks.com" <tharvey@gateworks.com>
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

On Wed, Mar 12, 2025 at 12:10=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> Partially right.
> But The issue here is to handle the case that the node
> is created by optee os and uboot should bypass creating it again.

Yes, ths patch is correct.

My question is if we also need to pass

  if (!IS_ENABLED(CONFIG_OPTEE))
      return 0;

As a separate patch.
