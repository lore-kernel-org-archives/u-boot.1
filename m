Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73954C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 012FE877E2;
	Wed, 13 Dec 2023 17:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ab+FIn5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1FF986564; Wed, 13 Dec 2023 17:27:02 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F918782F
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so1144597a12.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484819; x=1703089619; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J50STkWp+8UHvw0TSviH/Da2vFEJnfO4JAD07+X8KzU=;
 b=ab+FIn5rjSMGFj2VLvIGigilUHjqoDOYO2bzbKwo8WYgJGMvNcERoemEyEfP8jQp04
 V5t9ekBBHf2sr0PJL2Jt5QHy9kOdPzxSx8e1V28CQXUqXAD29V0chpPFYaMotQze8aAr
 enrbdBEE1sjzd70vbtdBddVkvdCBOG5x3P+KXjpJE4eZZRcaXHrZmLnP/nGrl1tudywt
 Z2tOSurP3xUflRMmaAi+VNYUp/wkH1k1LmUzP34gVbB58zrdrVjk2eWNgjGcuNcNqbYD
 DIBZjzB9K9XlDlCTSIUk2SCdvOl4c12Um7slLGcNuBjGLcG7ZjuiduQVpAaU7HVMYiJA
 qVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484819; x=1703089619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J50STkWp+8UHvw0TSviH/Da2vFEJnfO4JAD07+X8KzU=;
 b=B4BXTpfC8vxj5M7L0L+MKXBDdq7fKk3KZKT55mZB0Dr0IRrFUX7tWAjmLesUNcdOU9
 Y690n0j75cxGJoQymabiPnCdmvMWmgrCzA15/hk8TzIdsxesRWyiX7w7EeUQvcwGWdtS
 i1542OqAdanYkqkKsiJ3w8XCYXu7YCCCqioZRBJKwDL0+w3IFTUGB9qBvSQktKb5ltid
 fkYXsQhvzqToaZUEMwOrNLNArqgQXQJHBKdWM6SePhBF3pCNaZf5Wm7AIcTrAqTQdOlk
 1ILdefw80GN2ClzBt58Vh3KE+x2pDzabWrJD6Qp2bsmTiqUKYBKtEBn634p603o76Gdf
 x9Cw==
X-Gm-Message-State: AOJu0YzaeZEvK04uxqrfwJct9Gro1wHRT24kRaJD5LFDs707zBH7j8Wy
 5nRTEC9wQM3WWPzyyanJwmlbwak09zviO4YaR16Fol9nr/s=
X-Google-Smtp-Source: AGHT+IFk+hJBlKPmgZRf+RU26y/AvF9gYsFElcR27WQ8D08P2V+yNZNVMnznK6szb8r/GdMy59lSL7ZJnSX5L3x9HJo=
X-Received: by 2002:a05:6a21:78a3:b0:18b:a1d7:a736 with SMTP id
 bf35-20020a056a2178a300b0018ba1d7a736mr18428264pzc.6.1702484819022; Wed, 13
 Dec 2023 08:26:59 -0800 (PST)
MIME-Version: 1.0
References: <20231018191742.1303779-1-festevam@gmail.com>
In-Reply-To: <20231018191742.1303779-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:26:46 -0300
Message-ID: <CAOMZO5C+BrgSQdmHhPj9_qUqz7Vqi0SrS69N45E80F_Fa4f0gw@mail.gmail.com>
Subject: Re: [PATCH 1/2] imx8mp_evk: Convert to DM_PMIC
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
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

On Wed, Oct 18, 2023 at 4:17=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Currently, the imx8mp_evk uses the non-DM code to initialize the PMIC.
>
> Convert to DM_PMIC, which is the recommended way to access the PMIC.
>
> While at it, fix multi-line comments style.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx next, thanks.
