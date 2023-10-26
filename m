Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E31DC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A241E87B6B;
	Thu, 26 Oct 2023 16:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EWnr4/d3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EA187B2D; Thu, 26 Oct 2023 16:27:56 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8E586484
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6bf20d466cdso162971b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698330472; x=1698935272; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bI4xo1NGHWultiKXSMMmYiLoRGDmPK/DKVDLbX2C4QY=;
 b=EWnr4/d3XOHHoZLLdLudXokj8kqvGpAmIe4ER4p6jJn9RC/4JGDxkd1FQCFQlMidiV
 wTdDN8eAXswTSoxU+0FVqAgY+7Ilug3L7muBMQgZaQa9xdVdCUY/px3plebkAx9pe+dc
 YZLcLQ46SCV+IrSF4rd0aEsw5jwJDTx4e9qg+ZO2KdYhvgxsXPzQttHAeQcnX0BqecX1
 bmy+LvQbTyIs+t5a4gQuvo2Ju6cQk5Sptr6/sJemnr/VUtRmo1qQhVJMbNfG96x7lx9j
 b8PIm3LlEH5NO9cEKjW4EAb2BEr7ETZFhJUEvtJcQHy1m41Qy6/tMxhVw/58wUXO15mS
 F6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698330472; x=1698935272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bI4xo1NGHWultiKXSMMmYiLoRGDmPK/DKVDLbX2C4QY=;
 b=oOU2ZlcL9MICEoE5fMyy69VXizHGC+7P0jYP4M4atK55dp9Z+IzsQ8qoilylKDgsej
 Cw0cHkm3Sp/PGF/NsY2dDzrAc5jg0salNHEQhx+h8XBb1z6Nqca5bxxwdOh26p/l5bZx
 OAWzXk9Tbtr2qAZtzqCV7PwrkANGPD7UoFBiq43ib2lcKJlHFRONR7W27msKZK01BHtx
 llC2nrRnDDTgfdiEJG2+VOwPU+BEeJjdgigw3ixnTnkP/Ekuldl0Bn2mup9RtB6qGzEh
 dBI+3zqAaNcBm806oSEObT6MsUlnRelb9JdEZm4Crodk5o5aSuUbYnGhVGT08OlZ7pMj
 stwA==
X-Gm-Message-State: AOJu0YwasHQHf4ld8iNa2oqQpVxSTvLnH7QQKYWcKuOEYI4wlfsMS/vd
 Fz16KRTDsGFbxoLETXYmNyWQQVUqDA7ZiDB3DYY=
X-Google-Smtp-Source: AGHT+IFQKP6qWnpnuQQe1sq+XuHstnuAmq2xb0w0zbLsXN1uuAP4hWIxFV9Sn4pKE250i1B1enrjldkZxtAHOEtAI3Q=
X-Received: by 2002:a05:6a20:9392:b0:163:d382:ba99 with SMTP id
 x18-20020a056a20939200b00163d382ba99mr21617657pzh.5.1698330471835; Thu, 26
 Oct 2023 07:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
In-Reply-To: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:27:40 -0300
Message-ID: <CAOMZO5CLhN9h+r2YDD8k_Czjoqf=OyRLxzed3kb_nQmg+Qjgsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net: dwc_eth_qos: add i.MX93 support
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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

On Tue, Oct 17, 2023 at 6:45=E2=80=AFAM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> Add support for DWC EQoS MAC on i.MX93.
>
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
