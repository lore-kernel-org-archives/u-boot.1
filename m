Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879FFC52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 18:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5E988BEF;
	Wed,  7 Aug 2024 20:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZAEmAwDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A7D288BFC; Wed,  7 Aug 2024 20:05:55 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7E3883D2
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 20:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f00427236so15068e87.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723053953; x=1723658753; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/d8gZxdQCTPmNYHeyFFxvImAryM7d8YWNgHeH+0nUw=;
 b=ZAEmAwDgmcxIGPM1wkLcIalPByIv8mIf3gTZJElJL75f0IQVmwTtLz+BhKWUNffuhM
 1Zo2268lahpo1/oVRUlzf31vP06+0mZk7+CSl0GhzXkSKZrdA3Q0/tkenwLvKezSP3Lu
 aBLqqyIYgMgfNTTPOQflJ4qEN1xKhEm3ZEgV22T6tzhtzSSbctGe9nmNjcud0TgHTqaw
 czNa7vC80HDjLU4+LKATOxjma3rSj8NVWFyGUG13Jv+Enk4DsCLfnf76UQ7Qnpk+T0lv
 /9IGKDJPFQP6uTBVEnMRCCY1qDQ9dFQcQNfE6541jhzMaC7GojxuXejDsGS7SmR4HjM4
 OjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723053953; x=1723658753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/d8gZxdQCTPmNYHeyFFxvImAryM7d8YWNgHeH+0nUw=;
 b=o8xPFN8pYqtnRiD1jIcI+TlHCGZD28gEWyczarrN7bXkrzpK1LciiJyvLmGvRKYwvm
 ubcPUluk6SMY5A+kIh5FxaVhI7hxZoIRGsZApsa42AeIxaMBTHlGdyWZbkkNkVh8EELc
 53MbVKZMBS4Qv0sLZLy3b8avPm0lbXWvTdTbQeOEqr7hn3inB1aEQV5SjYBEBkp3UIP7
 Fz11aLaAm5SQPXyAfer4EqfWGf0CC/qVFt8wIuVvfCpav1J6cj74jgB1sxWd1AyJZwtj
 qmjcP40mseEaR8fp3ezLIe18+y3dcajvza/ShqevJqHD5ejkq9i0gpzyvRyOQw0NT020
 Z7Ig==
X-Gm-Message-State: AOJu0YzwZ6hvaFwIlTfZ/31dbFyKb3HXslncDksoovatcNHUrlHMDwGm
 vzVaCx3NiqFbzfc8rSrRluQJlSMhkvFPnlTqxloOvu9hK/9DqajF0BPg1pgoAe1OfyBoxB0PY04
 hs+RHnTEo51UhsnUJY8a+xPmDPvs=
X-Google-Smtp-Source: AGHT+IGcN8ywhYU+veKX6HGe4wj4Ba+4Oy/pSyT5BMdERzd6G4s3nUbwpAZiqC/UCLZfPxRLy4uS4vkZaMNyInrgXuo=
X-Received: by 2002:a05:6512:acb:b0:52f:cfba:403c with SMTP id
 2adb3069b0e04-530bb36b64cmr7318907e87.3.1723053952522; Wed, 07 Aug 2024
 11:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <38486335f3ec7990124f0224108a967641f7dca7.1723050310.git.jerome.forissier@linaro.org>
In-Reply-To: <38486335f3ec7990124f0224108a967641f7dca7.1723050310.git.jerome.forissier@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Aug 2024 15:05:41 -0300
Message-ID: <CAOMZO5AM6Mteg+c8MgT4u9mboef=FdqTjTxhVDn7_QWVg2=WWw@mail.gmail.com>
Subject: Re: [PATCH v8 06/23] net: fec_mxc_init(): do not ignore return status
 of fec_open()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
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

On Wed, Aug 7, 2024 at 2:51=E2=80=AFPM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The fec_mxc_init() function currently always returns 0. This does not
> allow the callers to detect when for instance the PHY initialization
> failed due to the port being unconnected. Fix that by returning the
> status of fec_open().
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
