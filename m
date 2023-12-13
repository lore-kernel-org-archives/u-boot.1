Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E136C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E0287830;
	Wed, 13 Dec 2023 17:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aWPGti6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2118785C; Wed, 13 Dec 2023 17:34:01 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D03874CC
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d35259e8dbso1705725ad.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702485238; x=1703090038; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaXU5oAYEfUSlp2K6G1sKAvrqjHWvSrMVZ/oN6WnAkM=;
 b=aWPGti6UmBgZNRGfRprnf9V/rUsPkP8FFZZG1i0o+FenKdfrAjxgtMTMDwWXL0KVi/
 e2BHDxNfXy6YLo3evVGvd2l4YntM+p+P5p+v0lNmEwhywSftKUKw2j1J9SkTpbzAUDwn
 UEJMt4f+bthVPqNMO+cjPuBA2WMj42tSbX35D6uQhMsH61RjsIJqdugvCRHmUNYpeuAY
 NX9k8HMKCJvH7qikiUoxrfhuPQy7VX+L1ZhGoa0lztFuO9qLIBTGTvwrCdm2KfY8RTt3
 yLFP7bN1nEybCG/sUlnYwK+YyVObbCYqImXiTKrD/BsiJrOWvaQvD+64jefG/nFok1Kp
 EJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485238; x=1703090038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xaXU5oAYEfUSlp2K6G1sKAvrqjHWvSrMVZ/oN6WnAkM=;
 b=mpCBloZ3EWswudboMXv695m6oYHI5Ljs2wMoGY8OsBCA7xnbRP+D6LIOjrp8RtfURD
 /nSe0p3i5TE1+tCvARntoY93rEysktQE1AayqCRJFklauX19mebkis2cMKWWU2XsGQbd
 HnCSqso5ub8pmhCO9or+b2n2mBKs1DzOX3oL9BMbbgtOrN44kinUupfDI2edBBkdbL0B
 8FWd1i71X6973zuWQN0wVQg0IQPO3FRNBJqD4HHuab7CRMylq5Q04PyTZ6xSLZgN39Mt
 eLKzTVxHZTpsuKqBLRkzoG1JNC3KXrsz5Deu8GeiPq+8Z+OvUPcAqdqXx8G/PzQkjsju
 WKVQ==
X-Gm-Message-State: AOJu0YzOExyVcE7kvzFs62trAFf1O3osErsdkFjmEbCv+H2AsRFRB1vk
 O4DqjlFgojpIsd0ZX0ZMZa3h8CmVkYQg6Fm6zyw=
X-Google-Smtp-Source: AGHT+IEah06urVLLE238C38i6eHVXJeesNMjnMuEgkr4sCXKFKqRHjC5Ajj/qUut8jjQ4MKQXJoEXpIqeTAjUIccRV8=
X-Received: by 2002:a17:90b:3909:b0:286:f169:79f1 with SMTP id
 ob9-20020a17090b390900b00286f16979f1mr14198419pjb.2.1702485237764; Wed, 13
 Dec 2023 08:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20231103230054.64372-1-festevam@gmail.com>
In-Reply-To: <20231103230054.64372-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:33:45 -0300
Message-ID: <CAOMZO5COqwvci3KuPBsT6wvG3HgSyN8X0Y4heOPoaU51M-LDEQ@mail.gmail.com>
Subject: Re: [PATCH] imx7d-pico-pi-u-boot.dtsi: Fix aliases indentation
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, egyszeregy@freemail.hu, 
 Fabio Estevam <festevam@denx.de>
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

On Fri, Nov 3, 2023 at 8:01=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> The aliases are currently indented using spaces.
>
> Fix it to use the standard tab indentation.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx next, thanks.
