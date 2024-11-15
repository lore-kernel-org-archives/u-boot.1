Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16434D68BCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 17:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 201648912E;
	Fri, 15 Nov 2024 18:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T0bYFNEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93FC189156; Fri, 15 Nov 2024 18:41:19 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA7BF890D1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 18:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb51f39394so20229831fa.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731692477; x=1732297277; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WctNUWZC7iOAM8ROYFOedBBpwGTF+ZRz7x67GnZQes=;
 b=T0bYFNEXmG4Mt9sDsMPLIltdyNcdiiGkbODjci5YATCoDo9J7/gU9JUJ13xBk/Uv2W
 buPTUvE7fma6VY2XtHfUlhlOCt+/mVtKO2wNiisEa3Drh237q8EBW+4i9Q3EsrCwkd+P
 6RMZaudTEu6OEx9G1OG6tXGDKycQzxcdtKiXhW7Y9JVD1ikM4W+RvIV5XokmmIzfgoRB
 j51XGU41PNHGUMNbDJ9V5ymJWiK+XNts2lmjBRuK06VVQnAbDqPYYYlnr8N0NOEJEVC/
 dCcJFpZ1wQl8nHoLPcm6fVKTAGS01VWBotOoDGIbCWfvy9h2Hv3QyOuUTTL//5pa5UV1
 7lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731692477; x=1732297277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WctNUWZC7iOAM8ROYFOedBBpwGTF+ZRz7x67GnZQes=;
 b=NpBYSaWWKT3g0P+IKe9nKSs25WU7j7kwSNVsTQ2atJ2poNbZb16Fy6DeBbfWFmvq7P
 bHBQxE7e4hCPi/k8PegFoBDnqAhAreIZs9vTaE5uMEpXMqiKch1zqdPUWLRJEbUnW2rW
 bae1dM+swiVXPVR6l9X45ZkMviehSBWY1K9DqBek6hS8coC0N8Dfg7F2NWQGpbH7hL0g
 qsWD6PCa5eVPQRMxx90Pc6icCax01WVHzcV8jxjmy1O6KK4WNUAafccSAtE39QnCU+t+
 oPnsCqaP9FWv4whgyCEjVloZ98WbUKXsYYwCWQLfk6t6hAxZ0d0j2xVnhjyGUg6LZR5R
 8zXQ==
X-Gm-Message-State: AOJu0Yx/9sePQ7X2QkF2p7Gbm1yZZaqHyhfhZprgkseH6IMBv0TcivZW
 cnCQY5tLFGj2e2yammAd9eKn8oZn86evGH1tCUJU/5YIUN15GTTSG7HERdljtANJKgnOu64NVfZ
 oplSXwxRyCwoGqlprtWa7aHwLlAg=
X-Google-Smtp-Source: AGHT+IHIn7iR9THwIQhRGIXMrYiUWvhoVtP6Q6MmuyKrrPr3p5rgz02iULCsKwIzHLiLOxKDlKIbzt3F0Agb4YK97LY=
X-Received: by 2002:a05:651c:1147:b0:2fb:5060:7037 with SMTP id
 38308e7fff4ca-2ff609bdeefmr19225061fa.41.1731692476683; Fri, 15 Nov 2024
 09:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20241115165400.2486914-1-trini@konsulko.com>
In-Reply-To: <20241115165400.2486914-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Nov 2024 14:41:05 -0300
Message-ID: <CAOMZO5D7JKJ57OzRw5gj5vqPgv4ykfDH7_MWgU+QC2ATJ0+L=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] aspeed: Fix Kconfig logic on "DM_REGULATOR" and
 ASPEED_AST2500
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Maxim Sloyko <maxims@google.com>
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

On Fri, Nov 15, 2024 at 1:54=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> It is not the case that we can only pick ASPEED_AST2500 if DM_REGULATOR
> is enabled, but rather choosing ASPEED_AST2500 means we must select
> DM_REGULATOR.

Do you mean DM_RESET instead?
