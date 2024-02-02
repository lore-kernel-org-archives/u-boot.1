Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78384C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 16:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB04787C15;
	Fri,  2 Feb 2024 17:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="US9lMkY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A180387C44; Fri,  2 Feb 2024 17:17:43 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87CC287C35
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 17:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-42bf419a65fso634361cf.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 08:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706890660; x=1707495460; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYMiLXMrPo1LBo3uRsRhOeWrRW5l1TX6IGayzrO86g8=;
 b=US9lMkY3CiqH6H1+JA9rZCQPa2EKM4pd9R3oUOS0apMTvhEqEMkT+V/EmMwbuVzb+X
 CCfe4NxD7qMJVlyrdtBP7/Fdtl8NnLv7PPO5ccJhl8iErzc3NuJoeAiPsiSUP4PhyMaP
 FrjvTXR7GZGAOGdJPifUuRTlDQ2CicY9b5S1akkId/zDbpv8Vg3mFT1q+On+TV873wBC
 02mRAOvbSeZHwikXpTJevPl1nV5BVVA1wmc05cnWRbDZpYcN5ZcEd0qyIn0IzLNeJPej
 B8rDcrTC9op106KpnS8Y+9SxaWncUPGMk+RD6sekU9bDT1wdQmbNCzgZS6F7jTnmOp4z
 6Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706890660; x=1707495460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYMiLXMrPo1LBo3uRsRhOeWrRW5l1TX6IGayzrO86g8=;
 b=QfhXA1T+JnKrudfOZSsDqS/Pse85cfX0WVzLP6FSMLbYlLzPOuCsyUtvBiCCioFaCf
 KuEnbFy5niuEJaBrUNWCvudlnU/kiriB1XWZLfxNKC9NuSc5/Qb9qF7kouT1S2Ol5XO0
 mW+4l/kCtd0hueqVTe2xZ+/t3H/Xqcv310JBiKrddZkQ/5M44UJpR9Z2MXRe60gs8DoS
 fimvS37ff+q3VOKJQLCP+OEsbFMJcWJayVWGCgo1le3blTS6TWsLn1yrsS8zKcLAreLg
 PwuaQ27DibWtNsyq/zrWoDZMy9QxkrvByYvPQrZcbJZzI2PLrXcgHcsLtvrPZouOKv6m
 cjNA==
X-Gm-Message-State: AOJu0Yx2CINonoqBsDu84RUh5FuszRRdEKIa7fAhNiFYHRW1GewpubdC
 kASm8H+5oU5+ZPG1pLbnIwj8dbjaogsdrBuD/6dzU0QUHnztul4nvfkVWmmJNStqsKrUneey50E
 QBhfG7aRRHHNAbWfpWIs8Clo6NqsICWhT
X-Google-Smtp-Source: AGHT+IEZoVKjJ0OqpgMVFNJ7nBi50pt/AD0NbuBoDeZA4QbUOS/EaQ2rO5J1d4Kox1Ng31TAHXXAjoFwK3mwwvNLGkQ=
X-Received: by 2002:a17:90b:3511:b0:296:3d18:1463 with SMTP id
 ls17-20020a17090b351100b002963d181463mr2530786pjb.2.1706890639287; Fri, 02
 Feb 2024 08:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20240202160405.4126192-1-festevam@gmail.com>
 <20240202160405.4126192-2-festevam@gmail.com>
 <20240202160702.GD1152441@bill-the-cat>
In-Reply-To: <20240202160702.GD1152441@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Feb 2024 13:17:06 -0300
Message-ID: <CAOMZO5CupvpiGeQDSNve1xho5s7=CPiYWezs4O=fjmZVo_vTtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mx6sabresd: Convert to watchdog driver model
To: Tom Rini <trini@konsulko.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Fri, Feb 2, 2024 at 1:07=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> Can all of this be upstreamed as well?

I can try it, but that would go into kernel 6.9 in the best case.

For now, let's keep it in u-boot.dtsi.
