Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098E5E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 16:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403358036E;
	Sat, 21 Dec 2024 17:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jQbsfbux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA4E80381; Sat, 21 Dec 2024 17:25:41 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1DDF80243
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 17:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30167f4c1deso26810131fa.1
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734798339; x=1735403139; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMHLPD0xJc6DlaAug5m7QGGWmsx2SqQ2HwBNkWACmew=;
 b=jQbsfbuxmKbdE7JX9ElqVF23HAQcQ/DPJi1cWklTKW0452VG7OL5Tb9aMjSy017fQT
 bcrUkZfViZlyf6KP9gxpudNbIdbS/q3IR0BjOTvMegdNy+PnP/QOV5LA2chGjoHwx/TK
 9OjMEIzPQzyY8g55/wgunv5Q1erl1N9EjieQlw/yigUGt1IMjrhYwt47qA6kiebVxG96
 2ne5v2QHXg2azcEzuHAcpx22kQFtP1VDDrMt76rkeD8MHAenwHs9sX0dgM0Mue3IVCQh
 fUa4g1K9OyECn2+EpHInDDaKwYtL0RD0V3YiVKNa9Q0NjKMtvwZJOoOdD4irPddHobCV
 Aibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734798339; x=1735403139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMHLPD0xJc6DlaAug5m7QGGWmsx2SqQ2HwBNkWACmew=;
 b=P+pfNvKy6Wbv25wCc8nPTEx8aQx9t4ThJXvE3GuQ+PZIIS4L9hxhX8ode2M3suTt8t
 4kUIehjilX7iEnZN/qXokjCwkALis5/7wgNidXiWsJD71P8X5D0nM1WdPOhkG8CfnK49
 lBfq11zlhKPPfS/EFPFyC0iNLM7OEhOv9IFMKv3kXvCoHpk4dUzNjPZGtRoFoj87PXcf
 uMvA+X3I06Mhg+EBZLKOoJSj+zo/NSNi/bRDoDlyCZHPiKKfpIOavGSRBXMUMyV8VkmW
 ewUDzc9DENSUl48truIBM4RVbBYxu9VrSMz6XUvFaF41vMIBcow4LNhSUHK3yY6SpBbm
 FenQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ6hQEv0X+J1xfymfPy3ZjIdA4SSQFK/SdCsrTe1PeNwu2zPWbGJfJHXXcsdtrsYw1AQPlpj8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzl+IzuzUdI0kYWU6fz6UTaAmhEIO+2IZPFbDoRXJMk6jRlMrN2
 Ppolw7bLXM1l0etvqMViPXKxrkGdOnhbsDLMeKdcKIoZMRiIbAHHXyHhBN38xFeh+vv03OjJHEW
 NY4S0b6093ULehUL9UammA02zbZU=
X-Gm-Gg: ASbGncunxJ0YD34bfIGcwNUtemJyVE83f0LVBn7xgsTaCM9hWqpITp6yqdYPqkQwcrO
 PzvMZKVlVeni/VDD7zay3nIrXoEHkxQjPRUu1oh1RcBU7isvUeAXrwsuVa5n1xxSsrbHC
X-Google-Smtp-Source: AGHT+IE9OTfIhRVDr1vitYnLacUEbqyNu7oK0xwVqjUSOLueAJRJlobD4D4si2g/rPksu2repdCyej+ak/petINSpmY=
X-Received: by 2002:a05:6512:1592:b0:540:75d3:959e with SMTP id
 2adb3069b0e04-54229524793mr1986145e87.5.1734798338681; Sat, 21 Dec 2024
 08:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-7-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-7-ba81dfd8e369@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 21 Dec 2024 13:25:27 -0300
Message-ID: <CAOMZO5BTCVAX97inrxYJfUY0vtABwd+y9GUn00JUJfr+Dgaz4g@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] clk: scmi: check the clock state/parent/rate
 control permissions
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de, 
 marex@denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
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

On Thu, Dec 19, 2024 at 11:55=E2=80=AFPM Alice Guo <alice.guo@oss.nxp.com> =
wrote:

> +       debug("SCMI clock management protocol version is less than 3.0.\n=
");
> +       return -1;

Nit: return -EINVAL would be better here.
