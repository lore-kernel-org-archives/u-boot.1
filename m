Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A846DC36019
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F1B88E0F;
	Tue, 17 Sep 2024 14:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mf+j+X1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72EFF88E0F; Tue, 17 Sep 2024 14:30:44 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6C788DAC
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f75e5f3debso36984471fa.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726576241; x=1727181041; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WDGhQ8WXyTjicZfvFPd3IrEcTXYc+Uk0KEpWk3RVJA=;
 b=mf+j+X1ezvG5FxE9XrQWT89llC+xmKkihE69Xa75kMAuyRMj42/MmER0Suieq1VUxs
 1J203hE6eKUMAfFy/78AamrjaqbpczjNga5bPwgosqLxNE0AwcXrSNAF5lSPX/fdsLww
 FeegWxLH0/MPK7fMW8g1SZ4YssHK7H53uYubrSNPb/OH4mk9enU/oD4XYCTbrl3cDBc6
 JX3Plcd5IDhNx74QCT0/kt0cup1uPLTA0shFkwe8dZAUKOWhFZrGbvQ8Rz/sOGz4dNr/
 MNHw75u3LVIvYFSFEkCZDLVx8uShAZN2HxWt8sAyYDeFuCE6o17b9kkxWUCAmnDYrxh5
 nD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576241; x=1727181041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WDGhQ8WXyTjicZfvFPd3IrEcTXYc+Uk0KEpWk3RVJA=;
 b=CC7qXnHOgJMy4tEW2zeYYersPmnFXAc44laiSp3dXU5IoXBbuqkWkj/5RJGrKFm5Xs
 0lhIJ4arJr0JlrG4JT9Q+sXV2JHvrKDOvRBuGpJTpzZy8QSyqzLBsOfzlA9mOaPOwHGE
 LqT2c+aH+VdUTTWUtTIQ2vxR4m3pJ+eD+m0loo7ZU3sE/iMcleOQXLq3dRnnx6HP80KY
 zMF6QCtlFM+QqkDxzTnushdXquGgLHioHCbbB9pTrpkuJs6bBc2JpHo4XCzOs/ghAvoC
 lfFBbLZSxydXA/z2DcaONOBp2twzDSpq600mU1T4Punw93zutn9CCgnVCUFI+PZbnvlc
 JESg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmiGdGmMyAXgxzsxpHbpia+E1LjD7EmgCiSWt+1edWR+pzm21ExXZjT9ZqVQLuHf8h93aJ8yM=@lists.denx.de
X-Gm-Message-State: AOJu0YyYb+8YmPYqzjsSwH2UR6qjWW4uto7toVLmKVIDE9uhWh9KtUQW
 zs3L/UargjDqQOYSolrsGcD1WkE7xQkDWzmruA4XwH/lLg+pP4oYeu+3gVNyYnKg5Irpg+KKAO6
 n4+aBg1pXy5cM62kiTwmPzU35oPo=
X-Google-Smtp-Source: AGHT+IGZKEx4UgYCb3CLOrt0VN1xz0QzeUXq4ilUOYeEtHANKhYA1HipuOK7PPtoI8yBOy9DIqP1HJrlOdKUY4lX3Nk=
X-Received: by 2002:a05:651c:1541:b0:2f7:baac:fad7 with SMTP id
 38308e7fff4ca-2f7baad0325mr71341fa.39.1726576241043; Tue, 17 Sep 2024
 05:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-12-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-12-4fe8effc937e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 09:30:29 -0300
Message-ID: <CAOMZO5AN7jFTmNZxmCGY7G4ZZR7JHczC7imqanNVH5ycv6K+rA@mail.gmail.com>
Subject: Re: [PATCH 12/21] imx: generialize disable_cpu_nodes
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

Typo in the Subject: Generalize

On Mon, Sep 16, 2024 at 11:31=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> disable_cpu_nodes could be reused by i.MX9, so move disable_cpu_nodes
> out from mach-imx/imx8m/soc.c to mach-imx/fdt.c and update
> disable_cpu_nodes to make it easy to support different socs.
