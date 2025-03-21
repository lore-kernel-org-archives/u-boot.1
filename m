Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5138C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 12:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65019803DF;
	Fri, 21 Mar 2025 13:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KWsRajDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9668B805C8; Fri, 21 Mar 2025 13:32:37 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F0F8001F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 13:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5497e7bf2e0so2123881e87.3
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742560355; x=1743165155; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyXj5cJ/XMHlG0+9WTetSyIgUhapKnd2Z2gbGMnSCdc=;
 b=KWsRajDVdv95gQ7xo2qh7KiqkmWpsjIjY/p6uwWn9ISdbiBxlNRPVcpjhipKxR7qi0
 pjg5exBVN/5dY4HszBBj/bQ75LFmeYAaYuLTLBnGBskyGOzIsclS/772fqaGrJjL8TaF
 0CmA/E6071e1gY00I4ZHuFqmk4JI5MUXvsXX30lqVxMEfUxInCSTmu9qVTDaaeVv4LQh
 oAF0M+g0w+9G+WTrwcEJ6GEi8R/wLOWCnLXUewTlalx99fP4dqDjZOCt0Dzj8G8tcxQw
 BB9+YkekH4UtDyxXeSE2Mg3yCq889lUgo1n5CjUo2xMh0WlEsl+9XnL/xhd2GnNT8U9z
 6GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742560355; x=1743165155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OyXj5cJ/XMHlG0+9WTetSyIgUhapKnd2Z2gbGMnSCdc=;
 b=MhUOfvnZT1p/+WPwFSl7PYbxzQlU9Oe1MwxLTpC9XQJj7L+KxDLiQwu5krRrfbCHLw
 07t9eIBW/owJryNXfDcN+bPpIeQI/J6H5NFwEpMcWD9+ZgcyYaq/YBnrmGdYucuJDXxS
 eGWgN6Kp7CkeOxymq5+RMKJGYkvnTxflMM08cooHhjJfl/4UDaJOmnFsURfg+kqd0NaD
 X1p89XKLH4NFHYcxASNpXilB94D0lbqM0uTT4naLDEilBh0v8AAQmtyauw6xqjFlFf9E
 5tGxG5Wp0qAboGGYdaUvkN0LTb9BOdCt2bZDtRLg+64zc6TUagYXs3fThrCHciTW0yKH
 f1jw==
X-Gm-Message-State: AOJu0YxqFhq8Ypud/Gbs039EEC4Y8wSMbRU2e9l01Zzbfn9g2YF/Vx4+
 +b50jXhkr0cXtOuNUZtZ6tM43K+GYMzN6FErrQDn8sByh6J8XgDYrTkOX4cEAmy2nxG9k965LJj
 pLfU/7dCXH98cDHoVmWLVE++EPw0=
X-Gm-Gg: ASbGnctxbwPMNBAR1ytQk/tpWFgDM4x7qQGr3lyIuxh4fuyqN4h3DDHT4zGOa78jJeE
 IW6Tn2L6r7Z8QK0BAzwcsss9SkolFjAl6AhvsncsoRojKiwysPXVV5yIrjj3IkKFpivEsOpUVip
 Cdl2aJiCDYdBNySWimtK/BZZqZf2ZW98uStTNyQCAJEeL9n41XuG0UkRFTpg==
X-Google-Smtp-Source: AGHT+IG6zpWZgqt+rm6DcKFSzCPna8eA5/lNY4I2rqBRMrExPwJ4ddL8d4lXvsOEZzcmOPypzFXNoKbW/kB7KLSyeio=
X-Received: by 2002:a05:6512:1152:b0:545:2f9f:5f6a with SMTP id
 2adb3069b0e04-54ad647e35cmr1021693e87.14.1742560354583; Fri, 21 Mar 2025
 05:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250315012916.399442-1-trini@konsulko.com>
In-Reply-To: <20250315012916.399442-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 21 Mar 2025 09:32:23 -0300
X-Gm-Features: AQ5f1JoXKq_KnLUdUDsX0NZHvYor3xr8DRY3BI9hRrxq296-gFZele9TRK8ka-8
Message-ID: <CAOMZO5BbeQUexJ2o92yaxqSK84U8t7RM3+tH6D7LhYRavqSzvw@mail.gmail.com>
Subject: Re: [PATCH] phycore_imx8mp: Rework some of the RAM related Kconfig
 symbols
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Teresa Remmet <t.remmet@phytec.de>
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

On Fri, Mar 14, 2025 at 10:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> As the code is today, we get a warning about "select" statements on
> "choice" options not doing anything. In this case we can easily fix this
> by dropping the select line as the following choice statement handles
> things correctly. We also drop the "default false" line as false / n is
> the default.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Teresa Remmet <t.remmet@phytec.de>

Applied to u-boot-imx/next, thanks.
