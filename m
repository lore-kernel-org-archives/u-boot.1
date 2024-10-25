Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1BBD0C61B
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB088902F;
	Fri, 25 Oct 2024 16:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nB+euswN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C6E8902F; Fri, 25 Oct 2024 16:48:54 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEAA488C66
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb498a92f6so22068211fa.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729867732; x=1730472532; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2o66jcYTQufeuQxLXLIB0JRg3VL/FfKI0vEXDd/J9IY=;
 b=nB+euswNL200kcXLM3ki0+hLZB/cgDqwO5i0ROIFinBWVzdnxBcp/xI5IENg6W6Uy1
 cMozV5cWW1EJSnM82rM+bVtAbnrkdKsslwhxgw5eqAF69Az+toHULY1wnWqK9RypR56T
 XaV9Nt36/X/mKQnxXbjeBrgbkmxy7Jn1zCrwSk3OxYn7/xj6MbCb8EB0dCzWJl3SpNp5
 Ef5Vd96XUiwsLyc+Zo7jjk6wMhhdIZBMslXVFdqSri+oIvU2bl2z3fJoPLkqmzHohEYq
 WKFErcXoth2YsuMCPC7gsrmAXt/x06OIzNM5y9ok6VKfFsXhQYjeoh7oGHO4hp3dRqB3
 J7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729867732; x=1730472532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2o66jcYTQufeuQxLXLIB0JRg3VL/FfKI0vEXDd/J9IY=;
 b=gPe3YHobiJueJ/HzxacVZVAdisvKwnxGdETxAQQsnwEPVp/0H12CUBUFc/7zwuKNs0
 wW3LYuiR19VQf2/X3esuCCeuKpC7ZLPoQiGewX+Lxm2w7e6XgK+pHUI5xsGfpzJGsGJX
 PahDQfNAl2iPD8FZ8txiofDoOk5lv4ASmAFW6eycda8/KBlw77EwkhVuoAUoWeXeKCEz
 ni3euPvACjBaIA3e2aFDTQ4Dy0T10eEsVj6AE4oBEP181J14rOTjomp59o7kLE9Q8rE8
 sHHcFXxVHvPHdWf9imeyCTxBOVrGKZWLpTepfG58nw47eikNHVgmTVEDQyz61edNJuJc
 LVlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWicBK1BmUToNC9BOGEuqy5y7L0YcgI40cjiZoaVnuWSB+gECjjhX62ZDbst40wIHXTlKfr7Vw=@lists.denx.de
X-Gm-Message-State: AOJu0YywcT6EtvEvGRaOFzdTvAYleHHg+0lauNxeXLLZymx8K9OVmY1b
 +4jsyOEY4VWPrpTd77y3sp8QP/L0Ilp11ls122uUcXpTJx5XpqcM9z5g1fRI9vuvJpRu+2FltPn
 NveQzrXl8K+mkUjCywghdsPSQUwE=
X-Google-Smtp-Source: AGHT+IHQYRIJXso4ga1ZjFjdoRjS2CjulJxtgOr8FD4TILZNho4ONY4RCcn1w0U56KnkFpt+VcljgTHAXfx9Qh1+o3k=
X-Received: by 2002:a2e:be24:0:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2fca81c2448mr41528441fa.4.1729867731949; Fri, 25 Oct 2024
 07:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241023-imx93qsb-v2-0-1843ab1a4d5a@nxp.com>
 <20241023-imx93qsb-v2-1-1843ab1a4d5a@nxp.com>
In-Reply-To: <20241023-imx93qsb-v2-1-1843ab1a4d5a@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 11:48:40 -0300
Message-ID: <CAOMZO5D+xin38JOPyhAshdAFpDFXeNTiYVm5NaiQ4byxVST0KQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] imx9: clock: Add 800MHz fracpll entry
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

On Tue, Oct 22, 2024 at 11:59=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add 800MHz fracpll entry to support DDR 3200MTS.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied all, thanks.
