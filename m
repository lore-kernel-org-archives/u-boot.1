Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853F4E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F48806D4;
	Mon, 23 Dec 2024 14:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="npuruU8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F987806FB; Mon, 23 Dec 2024 14:22:21 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD9180655
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-54024aa9febso4543361e87.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 05:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734960139; x=1735564939; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVq25BhXWLfhDArOmLH4ZbhWxh1cTTbtkZQM7RKInZQ=;
 b=npuruU8x96VwmB47r5Es+APKPCek4Z5pwjhR1xYCayl8DPwzFSmUWIhM9VNuZl0WoO
 P0biaasy0SiRK7W2FiL/PffB25ZeRFbGD5A9BNWN4MiIV3LbC7WUSIKB/ilIy/AVSt0V
 P5jUbufIgRQRNbhrU9x4sZ6AL3KBCB7k7mLx7xkbzjwI85/vWNaWqr/dA5anWlXX/FXt
 DjtuVScTuNyF3krgu+TmhsREzt8MIELjpeDleCBPRBoVFw0jGLTvxN12cjXoYutf1ljF
 pEsMVJEzWdaD/pRuhC/pHcGhyvWrhUu+1fIZfkaqx4NOMAsnqVfueEK0o+gNcsqY0HXd
 BprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734960139; x=1735564939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVq25BhXWLfhDArOmLH4ZbhWxh1cTTbtkZQM7RKInZQ=;
 b=VXacBiFtWV3962SVm+nHDbNgUV8OOTYxkFKgstsRjIQAGFmYz/dA6mv05UC36HhkA9
 0XKZE85YzNIFpURIOzqTT8RXpWLGknQWldwe0JmKE1LNcwXhDPz2qJPI7vzEzUOAB/oP
 DCThIswjS+nyIcGp66ibZH5LgQzHPTVJ6lon+5zMEtNcGMJjJrUwK6XFGVyorscWhhQQ
 gL6C+zk6Qvy/fWBEKYqRURZIL1Y4JShoPapHlN1eLt5wQ/VEcd0CWDa/fJFmpsAtnHKT
 NBXKqZiMfLL+RWf1lBY5xxnkVA0b6pfeKnrkPKRWB4c9c+dnslSrUWq37t0z0NKE7//J
 Yzpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAK2vTSFxoDle60QSsD3z/wZ03pqpADHUYQ/JjH3QorLOfGD8qJdZIBSOJzdI6UdTIjGm76iY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0pSbzDv2MY+nGpE933azT8GaQ0VafSJt9aVAiHGo6rJs0ebZ0
 r5wYH63kmjG52I//qHvWlvZ9vCLGPdG4wk+0bOpMGz5IfsvSPe4uaPve0U5ZTBmE6I4S0mdpRTN
 CKjSJB/N33+IamluAgRXUxAcz+4I=
X-Gm-Gg: ASbGncu9dk8Ni4JcQSvrwiJbIDI0TIjPEt4rUx0s0ZWIpHxK40/NKc7Cfd4NgJJYApx
 lrG1sZaGr5pUhnOtO3yZCg2yJNf6bNncE6XtgvJozpfs8KyBus1jqeskJEDwKI/w3hHvh
X-Google-Smtp-Source: AGHT+IEBJ1VJSgkoNoAoGviSrR/MOAhryD2JKZn18EjceRRu3u9byqvCuWl9k/U/9y9gK4Qwn1Pnn5qAUy9OJJKtS7E=
X-Received: by 2002:a05:6512:6d3:b0:542:1137:611a with SMTP id
 2adb3069b0e04-54229533db1mr4927054e87.17.1734960138645; Mon, 23 Dec 2024
 05:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20241223025536.18588-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241223025536.18588-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Dec 2024 10:22:07 -0300
Message-ID: <CAOMZO5CtjKA9KK4wqODXd6dx+cK3geycqki=o185dq+HnLjKAA@mail.gmail.com>
Subject: Re: [PATCH] imx: Use per board ddrphy_trained_csr
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
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

On Sun, Dec 22, 2024 at 10:50=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Drop global ddrphy_trained_csr which maybe different with per board
> ddrphy_trained_csr. DDR TOOL generates ddrphy_trained_csr for each
> board, using the global ddrphy_trained_csr has risk that values may
> be not up to date.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied to u-boot-imx/next, thanks.
