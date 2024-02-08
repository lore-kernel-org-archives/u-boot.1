Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71F6C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CA487E45;
	Thu,  8 Feb 2024 15:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k1vz6wL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8238887E36; Thu,  8 Feb 2024 15:32:27 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DE187E45
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29593a27fcaso485745a91.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707402744; x=1708007544; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sv20cOvrfKtZj8Dw9lgqOAXpb5TjtCG5gLLgsjy+y8I=;
 b=k1vz6wL672krSMY0OOHpF9o4DKdySNGcpdWEDaW7bBhPhbKICwwmNHMW1wQ0+XsWmP
 hs8Hl/OQbzZyT6aPjVxERG1Df/9yf1ZhJFVty0b5L6yw4oQa08BVuTAb3sYc2po1vOuI
 XAS60j/aJXd5bqz+s0cKWX56M7ITAEHFfd66/kyQIvrIOthwvBtDVdeCV1jAEp8igKwd
 vjhy2BT4YsHdXvw1ZKWGw8P2RDH1g4Uk4l9eHg+2rN3GcpYcpDTa+oYW1/PhUO1ajCZq
 2GGOrMhRcQygmqErtsQtVtiUnjKyMdm95hkLLcGjw+gFo4vMsE4xIaCoPjs4a2OIq9dF
 ToQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402744; x=1708007544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sv20cOvrfKtZj8Dw9lgqOAXpb5TjtCG5gLLgsjy+y8I=;
 b=ual7HWCXFnzE4w4DfgqE8sYQK1QnfLfsrRV+tLwBBkJaIWENfMDO3z5S7s3LwJPQ6R
 c5XZrJCJyY7cldkz+htHP34cJf8sc9WBJJZM4cdFxYcMIWUlZAbKksAWPswwk3s2nxOm
 +NoDvvFBj4QwAyIBR3wQc+v/uyOm8fLY0eO2EdyU5AgKT0Z5Tbk7mI3kmDQqR5j0177b
 6CR2j6uZGpDGi+07RRmfLat4lvCzJMlMYSNvxmXqdOFsLfayMpnQCCSNz37PA1WZkQ3l
 RLqeoRIsWnlrC4HWHjR/c1ML8pB07zBbNfNc5SVH+QBU+GrYKbyKWSmOM9cmyxMMFDwM
 J8Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJlhD9/UF6ZOjCRwUi++bhgUU4eF6wT2Iikb895FgI61/WI+DZQu0CGNekgMYSf2jmSQboITiwqKdJDuX9kL9sxpzt9w==
X-Gm-Message-State: AOJu0YygE2VhjaXPKJhemg2+dtlQ85BmET70om+CTVfIDVZTPPaHzr8T
 YC3QoLnVu2r6EqEjvlO7d7NCXBaBPQz0WNnKK5R/zY+CYk+9Jb+TQ5NsysHuVB02QqwkM3M4X8K
 NvfEcjIh1fxptzpaY58EZDeUYiMA=
X-Google-Smtp-Source: AGHT+IELj1PZYo8+SjygO7o1ZvibxddETxXrvuic8zSrP+uZdKAqV8qFfqsp+vOm2OwlrL7jZVxCxfZEgGnV4Uiok4k=
X-Received: by 2002:a17:90a:304c:b0:296:f78b:d9f2 with SMTP id
 q12-20020a17090a304c00b00296f78bd9f2mr2289531pjl.2.1707402743740; Thu, 08 Feb
 2024 06:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20240130145037.32672-1-othacehe@gnu.org>
In-Reply-To: <20240130145037.32672-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 11:32:11 -0300
Message-ID: <CAOMZO5DMym76mSyYMpNCw++YJ1K=PcFt6cGZKxEUKes3HGZmjQ@mail.gmail.com>
Subject: Re: [PATCH v4] board: phytec: phycore-imx93: Add phyBOARD-Segin-i.MX93
 support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>, 
 Yannic Moog <Y.Moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 u-boot@lists.denx.de
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

On Tue, Jan 30, 2024 at 11:50=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org=
> wrote:
>
> Add initial support for the PHYTEC phyBOARD-Segin-i.MX93 board based on
> the PHYTEC phyCORE-i.MX93 SoM.
>
> Supported features:
> - 1GB LPDDR4 RAM
> - eMMC
> - external SD
> - FEC Ethernet
> - debug UART
> - watchdog
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Applied, thanks.
