Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D4C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505AF8799A;
	Mon, 22 Jan 2024 13:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N+Evrssz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72649879E8; Mon, 22 Jan 2024 13:59:16 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529D0879FA
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cf9e543562so153838a12.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 04:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705928352; x=1706533152; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBCy9ldY/PVqkbAe1II8b9xlnjraYe1NMOdaxYqK0BI=;
 b=N+Evrssz9SNV5gkOqpRFJaMgydl6u10lwQ77yELZ3mjxQgieac/0RKMTXmXTeMpMIv
 DCI3S2afs79Bf70b/AhvCZtVXruZSyd2jwF2RytD4mpXdhge1avDCXQu/gWhMqXjOvYL
 +87B9dYKk/dYPQtOMBRZRUjyzanWVI72QcCkugj6/wclk+69wNFJor8hYSdGQQi1akQF
 SjPk8wxEgHQ/m/UfMyyrZfnow/DkInRBl9YFZysK+kJ+lR2ZKzmkzd02NeCYGXbEmRUA
 Pcnd15hsx/D5OO0/VJi/o//SocaAhMaA7l9LTyl7qeB6ooEuOlvmJe8AYH4wqIh8NzI7
 WaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928352; x=1706533152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBCy9ldY/PVqkbAe1II8b9xlnjraYe1NMOdaxYqK0BI=;
 b=TiGdorFFUYDQrWxmpjk+19Qgl4kofdm4QnnuwJKrx+gZ+OY4HgrsZxrxMGe6UYpgNM
 lSoQIrflBW9FNZC+qirkfyPfxpLz8APSIR5HpKDBx9hKlNYjuY+e9Pw0axggyr/PxZrd
 2WLdf99pa+Wkgf7VMAQFQCiG2jA5FJHtbwrjhfN3hNbyg1Yv43DehMlEYCgdWh414TiC
 ThFtTHy8Zr/IpOC7xh1dM3BNPdMx4wv3dL2HSrCiJiGsx+EHXvic75yegde7+R8MYhXE
 0Sot4LEhiipWTVAT3VOIHKTrug9Qi0Tbta488U+MdjZ/5pE6hQH/4nyUtq910EAFo0tz
 STwA==
X-Gm-Message-State: AOJu0YxsqzfXs4wV4nwzjqIrE6UrPpkXJsVHUEOjz5x/EcKKoPX/dwUs
 wtt3IxUwNL7kqQaXzgmyYgxqZtK5nerCK8ExO7mfF6QpRNhboWCnoH62rZICfWbhWi6j/zhAvdP
 9KIIoJh5ZY+SKmn53YkIZOW17qa8=
X-Google-Smtp-Source: AGHT+IF2IBGsxyM4GpFFtgs7O/2eiMaV0Sj/1bOle0592Y2Ox5+CaUEgaJflDfZQlU97nfdlwYDMHDo2PAev4utkvuk=
X-Received: by 2002:a17:90a:c286:b0:290:19c1:103f with SMTP id
 f6-20020a17090ac28600b0029019c1103fmr5238104pjt.1.1705928352528; Mon, 22 Jan
 2024 04:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
In-Reply-To: <20240120003610.124981-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jan 2024 09:59:00 -0300
Message-ID: <CAOMZO5AQatdGbYDxLd9UaOGqvfZnBTp+R8NrQMUcJ2TJX54fFw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Fri, Jan 19, 2024 at 9:36=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Linux 6.6.y with KASLR enabled would print the following message on boot:
> "
> KASLR disabled due to lack of seed
> "
> Enable the 'kaslrseed' command so a random number seed can be pulled
> from CAAM and inserted into the /chosen node 'kaslr-seed' property of
> Linux kernel DT before boot, thus letting KASLR work properly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
