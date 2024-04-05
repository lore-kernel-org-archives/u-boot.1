Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F67C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBF6884BC;
	Fri,  5 Apr 2024 18:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MCt2qsXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3D6884C9; Fri,  5 Apr 2024 18:49:08 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1939883E0
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2a49986efc0so8360a91.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712335745; x=1712940545; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1ul37aD5eVWAqFNHXFNh2YhLrvqMicV0w/f8xpIjUU=;
 b=MCt2qsXdDxUQGO2m7HqFOXWO7dKLAzr1Okxo+oPl95tG4/D4R2pdovZiTDXIKXKlry
 QVjzcAc/8Uq1UUBSI61MDSLgiEu/eBq3W8s2NCZcbDZ1IviFVW0uf4IqAKf94noPS00m
 E+t7Jitps+X2PmDu8CMFHLvqUAyMKcOX9qpoi4QkqqsoHBmKSQMz0QqkBY6vus5MB0DV
 RmR53AubRwSgAAUfR1HPbhU9SJcNomvWC0gH9PwK4TDPIHBpu/Rv0ovDliSboUmbFPrQ
 vVSyQGKRcmW6DeFe3EsHBJjv14W0YkbrHk8Ldb3jfhVhdpyhoQDrT4UgL6Lesc/P+BNl
 EalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712335745; x=1712940545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1ul37aD5eVWAqFNHXFNh2YhLrvqMicV0w/f8xpIjUU=;
 b=RHheS+M4xvXajwQ3rUQM2Q72Y0ZF1DvHDIn/i+HItNAJnMmDstShR3/941X0HiQkdk
 aYWCFkbrzCIdP/TDcZwuUUTaSKz5imVKeQeJiMOFtTQGdqpVO4L4TW+w3q1O0IacY5dK
 /rVDyGL8QDjYXeqy/hqqKT60uDOibd8uO2O2dDsIl0lCEuiS1vlPa9mEDb8IM4D9hZ43
 d23UO0ZMf2fTKHhYXQVswel9ZtuqkXDzLacl7x/3bYgi7S1V7TsT0DoYn7LErJeUV45x
 3MVyohrAzkjL7ZaZ1da0kGjxfUm3mOQlCnoK9FUQjN6JQwvG5167A7Yd0EhLFYz4QQN2
 jM9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYcXDDa4982oKqOad3XMFEAlBsVE1HqhSKEWSkDQL8zt4JZdDSL1cfpVN3wpEcOVuBpcBS6z7a0TCTg0FflO+P0NnmvQ==
X-Gm-Message-State: AOJu0Ywc2Y9kV7LG7FoorU/Uxoey7G3ZdAb5Ci9Jls8yNt3Y8JJLoY2g
 KaVlVVkfM/sbkTy+E395G1h1lg+J5/DKblK4n2PbtfBzzDy6jl/0MqqsXl10U9JV05U9ofk4rCV
 L7t4Zgvkr2eTEJzeyO178DxsmCWY=
X-Google-Smtp-Source: AGHT+IFW93JV+Mr3crsiJmsugXmnjnfM7MY8aEBkk93UWvJNTUnany6qRRpmkqooe1CyvGEOb/aYhmqKEOF3Yz+Cp1U=
X-Received: by 2002:a17:90b:1946:b0:2a2:2b5f:3010 with SMTP id
 nk6-20020a17090b194600b002a22b5f3010mr1906528pjb.0.1712335745320; Fri, 05 Apr
 2024 09:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240330213555.2889619-1-festevam@gmail.com>
In-Reply-To: <20240330213555.2889619-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2024 13:48:53 -0300
Message-ID: <CAOMZO5CxSeX9xzd8Lzw1tRoiKv1Z=HZ=rxB+QFE7yEoFATrt+A@mail.gmail.com>
Subject: Re: [PATCH v2] mx6cuboxi: Fix Ethernet after DT sync with Linux
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com, 
 u-boot@lists.denx.de, cgmeiner@igalia.com
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

On Sat, Mar 30, 2024 at 6:36=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Josua Mayer <josua@solid-run.com>
>
> The i.MX6 Cubox-i and HummingBoards can have different PHYs at varying
> addresses. U-Boot needs to auto-detect which phy is actually present,
> and at which address it is responding.
>
> Auto-detection from multiple phy nodes specified in device-tree does not
> currently work correct. As a work-around merge all three possible phys
> into one node with the special address 0xffffffff which indicates to the
> generic phy driver to probe all addresses.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> [fabio: Added the changes to imx6qdl-sr-som-u-boot.dtsi.]
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Tested-by: Christian Gmeiner <cgmeiner@igalia.com>

Applied, thanks.
