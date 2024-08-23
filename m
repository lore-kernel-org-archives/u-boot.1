Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E0AC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5857C88A3D;
	Fri, 23 Aug 2024 21:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gKiwe9wq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 927F788580; Fri, 23 Aug 2024 21:13:20 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72CF88914
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f4f2868783so16308591fa.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724440398; x=1725045198; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpnQXsGx2el6y+wpFriGJmruvDLG+7cVwLIpKtrb/Z8=;
 b=gKiwe9wqkOeYxRV7hQoUWerMmMfOYeHfRHS7IPiyJsQxO4LT2xFp0a4PpyMhZrF80E
 lWSvPOb9gIAjitZ2C2fiPZUHSdzMfKttFifCF0uqM5l/ff7N+nOSoc6BJ9VryDo5dngg
 Kh+EerOoeUiIX+hpCRLUntpnkXnYWHsxDLtgJqDwa/66mA6PJipwOU/Hlxa1jmpqLMPj
 vVmXgg6SByPj4af8irAZVmLMeOsM4JfWJeo9EqBFDX2fiRqycTiMWW+RMo0ZTQwtoNJq
 6CQphqUkUYc767+9GK4e98csZFnRL5wl/zXMVjhKz9rtghy9k89Fm7v+06T4zB6bZJfm
 C9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724440398; x=1725045198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BpnQXsGx2el6y+wpFriGJmruvDLG+7cVwLIpKtrb/Z8=;
 b=OIPV9QZjat1tZ9KzKGsTTXLf+CH9gb538sJ6rjaRbq075e9cSp9FGEG/h7Sgu9WlxR
 AMf4g9U7+ZqnHujMpCnjR+rJWmi0f4sWHUAFRiodgQEBrkiPJWGJCbtadWOhV80jx6hR
 lE7Gkftm+d14tRVzmZeXWjnuUNmXFh3S/EVMP2MhKASSwS/erd/cswSRaRAbDoFFEEX3
 UIWWjuM8TYKzzBRmy4P8ZsHhiZgYmfgl8+lMQDM8zXV5rYiPWqwLXWL962v2gphFa2/C
 Ha6JOudZmoCHoUJoF3GZhdsdQHsRJ6Tinlz1kY1mkcnmvBbjIGmVIW6q+6lnP7RNihq0
 zHWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWV/zwLLnnHxVbjUCK55LLwMwNDqF+K3vvM7MNCp2vXBAALVmbMD1HfaWvDsg0UO+EZvEjn2w=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu6QfeITNV0rqAKC+t/SIVpVvvRE9Uugc3jAvu3yXR2pyaBgRx
 tyKn9clwdNJed1ZmKjdxcXhDoVLRt0YGn3/fQHcS9xB9IEgqfqEkFLlU1WHPUdPOPTZttvGcggo
 BnivhIgEPxDFPTjNzhTYE1hVvTiA=
X-Google-Smtp-Source: AGHT+IGThCvcOKQEhknoOBT8hH181QNnnRpB4BLZzPzi973FPzBOne0nN+A2Mnp3OIL09Ko/fHZATSX4xR/2w9g7oes=
X-Received: by 2002:a05:651c:209:b0:2f3:ee5a:ab8b with SMTP id
 38308e7fff4ca-2f4f494246fmr23410791fa.43.1724440397478; Fri, 23 Aug 2024
 12:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240807141655.4165667-1-max.oss.09@gmail.com>
In-Reply-To: <20240807141655.4165667-1-max.oss.09@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 16:13:06 -0300
Message-ID: <CAOMZO5Di_zfrDDcLGKYXagRALj5+4iNL_5P_+==JHbACJXpgXQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] apalis/colibri imx8: enable additional features
To: max.oss.09@gmail.com
Cc: Max Krummenacher <max.krummenacher@toradex.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, Aug 7, 2024 at 11:17=E2=80=AFAM <max.oss.09@gmail.com> wrote:
>
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
>
> Enable and use additional features which have been added to U-Boot
> on the Apalis iMX8QM / Colibri iMX8X boards.
>
>
>
> Andrejs Cainikovs (4):
>   board: apalis-imx8: add reset code
>   apalis-imx8: enable i.MX specific BOOTAUX
>   colibri-imx8x: enable i.MX specific BOOTAUX
>   colibri-imx8x: enable i.MX specific SNVS configuration

Applied all, thanks.
