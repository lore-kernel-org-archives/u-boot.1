Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B3BC46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 12:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BC987AFE;
	Fri, 29 Dec 2023 13:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hx1DbbyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2861787A78; Fri, 29 Dec 2023 13:05:40 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E67687AFE
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 13:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28bae84fc2eso1218358a91.1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 04:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703851535; x=1704456335; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVFBGrzsabw9Sb++toQd7fQ2nNWxZthbYPTn6BZf4go=;
 b=Hx1DbbyFHYbT/4SBBHG/wGgIFsFGfKhORc/M7p196OFwkva6s318UlcSwQbuI3hwbR
 y0RbRO2nKaDV9vTboWFUXvNwnbZBycIm1BDxHfgsKI62Qn3Gnj5dYQVcbhcl6yEyqxaY
 6bs8xfkOjD3hUkMMkIaKv+ni3b5cNUhlqfRhxk9tZVsqbaoE16AbQ0QpL6IyXk1pHkWe
 ewgrGzuJL/GYZ6jS1x/3OQ9+ssD8c+sXrmuyMmr0fp7IuO5Crh46+FYut7c7Vv/LvJN0
 VMIxQHemnWDh5nl+MHYoHb7qr+vgQJrTI26ZUVK2/lqup+NmAEE7aGw3pqZ7NUSbkur0
 d9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703851535; x=1704456335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVFBGrzsabw9Sb++toQd7fQ2nNWxZthbYPTn6BZf4go=;
 b=q4F9kyQrXjKiwEiiXPOvUtBq70KX/yHHrVF1ofFpZ/u0t+7B516b+Mc3+7/VdNlU61
 WEth90jWHqrh/9BsZH5xg7/fRsW9nQUFHQXNNUZHGnYhf5ZQginTxt91It7NluEWGGLY
 nsKCffb0mpydN1oIbudBze+bpnUH/TAjZMVlmUhSnoZpGWpNdHaMykenImJSB9yMZcOi
 akRiUhXtBUAToTpxx4CURwZ1DdPHTgtVol25rVaAI+AIIerzV46V70Gl5aakl8nb72wY
 JJWFetQr2Pwh1PzT0JULx0YtuG6zFE1GxBxvymwJPJRTFWampFLd15rhCNNhOGLuYcQ2
 WBAw==
X-Gm-Message-State: AOJu0Yy7mTCz8LX1T1lpLVCK7yTTvKz3o6lMCgbgd4KJVd7wAfuWKwmD
 OwzYwvwfzeN9mdpVWKXnlb8/LhpZvgOtqet97Ik=
X-Google-Smtp-Source: AGHT+IHzPNFxx+GGf/1NfSn7FjWZPBQwYgozKQoNm8pOMIuYVJIGmAMJ8h/dOPNTZzLieBBDVBd6r8fN1dVgnLBYRRs=
X-Received: by 2002:a17:90a:4b0f:b0:28b:9a2d:c1c5 with SMTP id
 g15-20020a17090a4b0f00b0028b9a2dc1c5mr17635503pjh.2.1703851535308; Fri, 29
 Dec 2023 04:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20231229111701.10696-1-othacehe@gnu.org>
In-Reply-To: <20231229111701.10696-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 29 Dec 2023 09:05:23 -0300
Message-ID: <CAOMZO5AUyFzzYqk2cZV=W_+-EmY_zNaT2EyjWdLcMKodvZ4kHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add imx93-var-som support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, u-boot@lists.denx.de
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

Hi Mathieu,

On Fri, Dec 29, 2023 at 8:17=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> From: Mathieu Othacehe <m.othacehe@gmail.com>
>
> Hello,
>
> This v3 adds support for binman and documents how to build and flash a
> bootloader for the i.MX93 Variscite Symphony evaluation board.

Nice work! Thanks for adding i.MX93 binman support.

From a glance, the whole series looks good. I will take a closer look soon.

Cheers
