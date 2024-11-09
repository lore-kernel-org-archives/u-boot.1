Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDFBD5E378
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4636388D90;
	Sat,  9 Nov 2024 18:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WYrMzq/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC88F8910C; Sat,  9 Nov 2024 18:11:05 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF05A88C0F
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso26731181fa.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731172258; x=1731777058; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQvN7mURO8Te0Sn+qkJB4DN0DnEwswY6RiNIvzOijCU=;
 b=WYrMzq/3bBsfHIupHG2GbdkfZmXq/mmVdH/lfl6rvzLHPys473G97j23Y1eg/jppcs
 egT0phq28xrRKTAY11aX73oA9/AR9hOP+GwQ8JGNMnX46PgBwYXOWz0Ax4rM+vUa2xsD
 Or9fx+moIlav7JErdPRNQ6l9pRHZIVgHIT43Y/vemN6GOcwn+x92+a5yPcjYj1+o/BR3
 D9lM+GsHa2WW3sndX5jQc4091TMCRnYp/AG/2IvciEQxPVNId3AJ6aOj8flsKsc7jAD9
 XLP5IofJnJzOnKOTNfr+9ypbIHNvFjzdZV3WnFMrJbTGQDRqdNs158jIjK7ZOLupM1op
 Q7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731172258; x=1731777058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQvN7mURO8Te0Sn+qkJB4DN0DnEwswY6RiNIvzOijCU=;
 b=dc9zTvJmwspfY7KJNscWLGK0MKi/KLF7seO1SWzTlLdQHfOmykHQNSp4f7gdS/nZ7t
 Ewn1T7BNyvZkc7iHnTnSYYCRjvYsKhb2z0lJlAXLkY6JMEB+Yvm5NfJExvhLNAezE8hR
 DRL0+E+0rJLLvCin8sOjKWgxi4iTEdp0/CL4OVw1LYMKAZW5sZEE3QODWQz0F5YBF1tV
 u/5VRHZa+P7NxTzUKC1Knx+aU2jyqTePKZK4+X1fd12Tl0EDb7Uf7UV22+qBZ9WJOX13
 tjYTWDKjCN0oXSeIw3cvNzNGvjirDWdRT2iihjeygV0ArO9qEVbM5Al0ZnnnrY45++hP
 Jqpg==
X-Gm-Message-State: AOJu0YytNyph4GD1mKsluOza1OTfjs3crm/ONJnsYfLdNt38LoFMEftm
 /8kN4rW8f59snMZY/Ozc0e3gxRcZkmJPA6Hs72vZQ3liFvYwrRAcmp3XfcWocm6LorHFuvifar7
 zkyfxhW4NRG9dScR9bp/GqKFXBHw=
X-Google-Smtp-Source: AGHT+IFactYn177vDb25BJJFcyrh0eUuOwCAtqA9F+oh0UjKh6qM67SG83iGg8ybYtFwKLXHjcl4a0laJDhoP1owINk=
X-Received: by 2002:a2e:ab0e:0:b0:2fa:bb65:801a with SMTP id
 38308e7fff4ca-2ff20268538mr30399531fa.26.1731172258021; Sat, 09 Nov 2024
 09:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20241104180203.110395-1-hs@denx.de>
In-Reply-To: <20241104180203.110395-1-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 14:10:46 -0300
Message-ID: <CAOMZO5Bu1NixqSKVhh1qoyd_mgocKOg=hT13x9ZVtaz=W+24CQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools: imx8image: add possibility to skip dcd
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Fabio Estevam <festevam@denx.de>, Gary Bisson <bisson.gary@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Mon, Nov 4, 2024 at 3:02=E2=80=AFPM Heiko Schocher <hs@denx.de> wrote:
>
> Currently U-Boot always adds DCD Image to boot container.
> On imx8qxp SoC it is possible to init RAM from within SCFW,
> and adding a DCD image type to the boot container in this case
> breaks booting (No debug output anymore from SCFW! Nor any
> output from SPL), so we need to configure a dcd skip somehow.
>
> This patch adds a new imx8image_cmd entry CMD_DCD_SKIP and a
> new entry in imximage.cfg "DCD_SKIP". If set to "true"
> no DCD image type will be added to the container.
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
