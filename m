Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1942AC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 12:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B1B5882D8;
	Mon, 13 May 2024 14:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aHQwQB4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A24287D33; Mon, 13 May 2024 14:50:09 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F77882ED
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 14:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2b345894600so1141884a91.2
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715604604; x=1716209404; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXcNM42VIY1oA0DgFJUO+8tf+xZKjLq2nF6uRNLbGYg=;
 b=aHQwQB4MVdzHuXqkB9lxeOCMHwFa6tuxP8qqLu01WnNsR2TCtuLczDC8PfrllwRrm2
 n/4NIp6LhBLyxWD9SFVj6ysusPii1vl+u1y4uBNvSrVZY0kffctPVCJ9IIE0nfct9D4H
 1bqdtV057ORxdwiPW12wVVV+F0TNjCwjEP8ja5xZIKOyGRCYNHu4mkOp3wCbL978O2wq
 Y8JXU6KSQBYRMEohFC0H4HxSIoWltB4UxmnGuMfLaFvDiHhqp85Du5JoHLZkSopbsN5Q
 pIJeTvK2/8F3mfO9YMM/5X/OHtGPB32Nfrs+f3Rgf9LW4xTrlio32OP8In2+6xKKcBtz
 uDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715604604; x=1716209404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXcNM42VIY1oA0DgFJUO+8tf+xZKjLq2nF6uRNLbGYg=;
 b=SE4kv0KQ6WxxXzv1aK9b4pD0wn/zKxLz5u1G6+rwOes6d7DFW2aBNCmEZTHibNdpUK
 UNLbGc+A/QKKdSbO+xg0l0xSaJU8NCqbKGQrIpvx1xIIQ13tleux3UDZG1s/zFHLPAjK
 tJSR1pAaN3iKUTv7/+pTteJms1onCdw4FV8LKDUSEdPnD4EDVqjxOrG3zTvZi+YwanSG
 O3hA3R9tA9nj6R3vXlNKNqkXa76YvXfQXvaZQMQwOiB0rckxnxuDs4LcSPAqUmTnl8rb
 MRCy6inCGFWasXQL3zMm6NOBPxVFfk53Fm3L8qHsxmaYYSuJqZgCa+6dKDiD9f24ttwe
 CK5g==
X-Gm-Message-State: AOJu0YwPBAe5nDDQHFAFDAsx4EcxVFdAAXBs6rJcDy/NdnzjTfi3Lq1l
 54U9a4wyDfninSiRBmr5hQjcsIecS2hnes6UKFWR1KhBp9ydY4BKhJyqnnrWXAD07x5XtF3fB9U
 eRZaWyIr4iPl61+2P2e49roE6ShfQUA==
X-Google-Smtp-Source: AGHT+IFFvABWul3qireqnXfs6P/MveJkc6M0TlgxEia9BcfYCRH1XEY2N0hKJFRtqlix2abCpQFwNX61yzmevPC6Z/4=
X-Received: by 2002:a17:90a:5285:b0:2a5:3f1f:a1d1 with SMTP id
 98e67ed59e1d1-2b6cb7d0ebbmr9245619a91.0.1715604604067; Mon, 13 May 2024
 05:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240513032822.139706-1-marex@denx.de>
In-Reply-To: <20240513032822.139706-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 13 May 2024 09:49:52 -0300
Message-ID: <CAOMZO5C4_B9UeOXbodXqEi1ZaPTStUj4o2bJjPkWBh-qMEpkTQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Add doc/imx/ to i.MX MAINTAINERS entry
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Claudius Heine <ch@denx.de>, Stefano Babic <sbabic@denx.de>
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

Hi Marek,

On Mon, May 13, 2024 at 12:28=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Make sure i.MX maintainers are CCed on doc/imx/ patches.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
