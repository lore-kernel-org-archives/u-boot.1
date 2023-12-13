Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083BAC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D7EF86A81;
	Wed, 13 Dec 2023 17:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GkXrG6fB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D0E986A81; Wed, 13 Dec 2023 17:27:32 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A694A86564
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ce40061e99so1200365b3a.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484847; x=1703089647; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRLV7dcukmoV+9bqHrymKFa4gL9JG2arsiuVDS54dlY=;
 b=GkXrG6fB/xaDNGAcvwvr3wN/ILZysVGmw8q8WxxDQ1bNC/yMvKq5XaCS2Ef1t2GBdp
 Bcsi/nvlW5Hwq9g8YHY7bFPhvlr3Zerh0i0rdZJ37a3J6Zw5EMXKmsCQC6WbSBqj9Ib6
 9U/hyqbEMIBAawhgr8MRTnavU39qZJy/bHJ5ajuaypOznGtbpPU3/p8UvQe4UFlbICi6
 mKcVu4/Qg4XAvXVMJu9DSfpzbdDdTiG8Cwwvz9K9yGaE/qbHomX0YIEesTUPYIcGnmK4
 Mfjtym336Y1tpIKSYruc8ke4xX/Oh08xBJE0beV47CvZblECfBnttuyCepn2GVSJsaVb
 hMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484847; x=1703089647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRLV7dcukmoV+9bqHrymKFa4gL9JG2arsiuVDS54dlY=;
 b=VvGv0Ew93Vb+1i27Tr1ErVGKGkFZiIo4TJ78OLoXqWg4MhGsahLFCcKswAd+GSUGOE
 A39ySxLGZCa3dWVK1wl2JfnMsR0RCMmueDEI19B0nLXXHnq1Ua67eUo5+QTi+yOIhjxS
 XzC+XmkUbNRZiSANn3BKfogpO5fFh4+2YkYdTkByUFdtV6Q88LIzBgmLwj+G4DTlo/vu
 lhcGsYfeRggZUDWjbxrk1sUH2OJ+K/Q9/8DpwZTgw6UHWZ3lNnxbrQNplkZaRKFE30rG
 yyDX0mSyQYTmyFnJ6e/8uahfdYYSH2UnPOMy4n4ND2XqtBxfdX/7wXdXWqubed/Vn31f
 EJiA==
X-Gm-Message-State: AOJu0YwQQRWAHpd8F7D36ujRdokkrvhB7ZPo3q6mbAvSKRU4mOH5WYpM
 PHSxFQy9+nxUnSYrj8RxOSlxobNvSUrqUOv9eIMMLMQxG0w=
X-Google-Smtp-Source: AGHT+IENUka/iPugeTzr2/XHBNj73ccR9D8AdzZcLc+vpxuxXxv9Y85d75BIxmENJoYGRcl+TK8pjndcGVpgjbMAyhA=
X-Received: by 2002:a05:6a00:b46:b0:6ce:68a5:757 with SMTP id
 p6-20020a056a000b4600b006ce68a50757mr17678641pfo.0.1702484846472; Wed, 13 Dec
 2023 08:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20231018191742.1303779-1-festevam@gmail.com>
 <20231018191742.1303779-2-festevam@gmail.com>
In-Reply-To: <20231018191742.1303779-2-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:27:13 -0300
Message-ID: <CAOMZO5AkSnVppVZf6aY+xe_qPnenpGcOa8n1Ex=tkuoOWVw4cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx8mp_evk: Add myself to MAINTAINERS
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
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

On Wed, Oct 18, 2023 at 4:17=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> I would like to help maintaining the imx8mp_evk board.
>
> Add myself to MAINTAINERS.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx next, thanks.
