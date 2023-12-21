Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8ADC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6EDF878DE;
	Thu, 21 Dec 2023 17:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z7pHOwix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B30878D6; Thu, 21 Dec 2023 17:39:23 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B454878E7
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e96711fce9so834447b3.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703176752; x=1703781552; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjXA984ppisnuG9U0IM/r47QbXtm2EP8/lnWRfjyq7Y=;
 b=Z7pHOwixgANarLEMjuglMXKK4ORcPpGY7mYZhZpDeppCMXgObnskpexd9XUnmJmcyi
 gA2SpdwT5nIP5aZKoG+hFVETSPalnB9n0HFfS7ui0iEA2SCXhLTKE3cQFlqsGQdHHgxn
 HVxetVA5TKIsk0n2ka+rzchsT3UvYF00+1Aafbt49nwAUa3Cww+Gh4QelDJLAAUeHXzz
 /jl/fS/iS6Ga6+BlBg+KPx9roVsOSlVLgoz+ewNjVpTHpnRBho2b+GxFAvGSy28l9Ksd
 UV/TcBLaEbCxgE70oNApp1yT5U5jAv4jtjPZmI6uAZTByk8xINKjAH7lWv6UA3cfMF0K
 WcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176752; x=1703781552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjXA984ppisnuG9U0IM/r47QbXtm2EP8/lnWRfjyq7Y=;
 b=gA/Ig2QehqzPAymP4Na91xf2Z2oPqbmcEWMVVwLiY9ztUQOcBkqHANqXEvZG4ea91Z
 eMb5jUYUYGklddle1mXXbS1VRwr8/xTaA0QisaVkV9cP1PY0guwGym12nNxSZqD5AbBi
 0zg2NPOGBRmlok2q6Ko4LTXlLnwS5iXLHefk/mV7cC/JsriyO47LqwulfaprIBZ69XVx
 1Hqu1IlQeQEojKnMRJIaHPQu/5a20UV8NF0Gyl0LxH7FqKaDgyg4/dM4IUmPEiPzS5ST
 hyKWNc6jLGUBSiqU/yZziiHAnk+fSXt72HbNngR3PcBX3Zv1bo5ZC37CPCrmhPAXdgXE
 B2hw==
X-Gm-Message-State: AOJu0YytneCaiR2Nsy034SSEPkt4xYIyh6v9UUWxoIjhfRhttltN9pex
 UTrewgM0hh9rQgoxL/dOd7pZpnC5nUyISHGhbZnAwt0vfN8=
X-Google-Smtp-Source: AGHT+IGTOSpoih1v2EHZDiKVIBRQHJS70VGz36o3exnnl1RcH/um8KVgoxTNNlt+DIFyLjowC8VBBgF89lT+IsTIwGI=
X-Received: by 2002:a81:53c6:0:b0:5d3:8d73:9bdf with SMTP id
 h189-20020a8153c6000000b005d38d739bdfmr151405ywb.1.1703176752257; Thu, 21 Dec
 2023 08:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20231221155929.1762-1-anthony@loiseau.fr>
In-Reply-To: <20231221155929.1762-1-anthony@loiseau.fr>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Dec 2023 13:38:58 -0300
Message-ID: <CAOMZO5CxYd_kNZbiMJ11rhjt-MffmvDsJGqcHkPYMGMqTGE96A@mail.gmail.com>
Subject: Re: fw_env: auto-detect NAND characteristics
To: Anthony Loiseau <anthony@loiseau.fr>
Cc: u-boot@lists.denx.de
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

Hi Anthony,

On Thu, Dec 21, 2023 at 1:18=E2=80=AFPM Anthony Loiseau <anthony@loiseau.fr=
> wrote:
>
> Hello,
>
> Please find attached a patch proposal which modifies fw_env so NAND chip

Your patch did not come. Could you please send it via git send-email?

Also, run  ./scripts/get_maintainer.pl 0001-your.patch and Cc the
maintainers when submitting it.

Thanks
