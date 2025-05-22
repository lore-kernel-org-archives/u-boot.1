Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E4C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 13:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E41C8309A;
	Thu, 22 May 2025 15:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RS8e3wZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA3D830B5; Thu, 22 May 2025 15:08:26 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C368006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-327ff195303so66646361fa.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747919303; x=1748524103; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSuN/IDcovl+n6Nun/xce6iv4JGoA2lSNMzugk0evTY=;
 b=RS8e3wZFs/CBjnzvD6IjdPD0q2CPYGO88/Ojwl/CGzN5+lHsi37bz3x0Kuz80+T+Zs
 ae45mKyjonVHaBbFH62yS0j9HDJz36bozYlUYvp0kAwSdiYO1MG6heFgmZ0Rjbb11Abc
 9fhOyROuI7ovsbJsBS/eKVZGYwbdGqEYcwRIL4jVZGCMtEbJprcUThVeram2sePXGO8+
 Q3/xCFWR2U1uaxTiZhuGE9UAooR4+72ZN673nu06LkBznigtwQhR6t88QR3dOBPVOykq
 oQEYSNYiM7dnwia72+M9cVDXjiNhVsgES+pm/zg7XLMAy8JsiIDDbsN1FY3fXiimSfuC
 NrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919303; x=1748524103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSuN/IDcovl+n6Nun/xce6iv4JGoA2lSNMzugk0evTY=;
 b=IgIvum+xH0Dx4x3ysl8DNhedLCtpcRX7olqzn5XhHXcjwgROKUuNd2OmaGZkBz0hDs
 hOziCcMxy0OFHSkw/nwfEDBcVpDDt99rYYjN5+0Er72RZbZpAZua6f1JVMUcpk2oCCW0
 HwgeQM71rusfK88nUp57AAAxGJ5Iika+An4ltYHRf88FPcPystdItlkAgQnLEvzg+n4o
 Zx30lAw5TqEyzMt+YZeTEa6G3yT4iga+mUeLaSz6HqfCcVa1GkAUllieNEKon1faQV9f
 hJwQdB7XsGKy19rSx4CE6sk5UIfrgvmuy55omtF2tpoyDe5lUWqW9zJcyEqu2pB2uouO
 ++FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOWVcIpNgs2ABtu70tp0c432p4zz1Ez0r+m31K79OH+thJnlfxMc9j4FOhmrDJOuvKElN6gZY=@lists.denx.de
X-Gm-Message-State: AOJu0YyJIUoJhp0UpbMl4+NNha6Us15/O4B/xZ1+EiUnQr/avVDKXUpe
 oLd7Ou66P/XeuceglcQbJ13XswCAL5l5+FSIB7UOM4U5ZxRDe2hoDK6JNWoJCXK15ZAAkZcu1GE
 H4bCU4ZDbcT9U7Ukez4iFk7q8JEbSE7w=
X-Gm-Gg: ASbGncuuL0f9/oz05sK6pYnzkQGPUn0SKaGao09qQyPnPxCut9sr0WiMghmlmrmsSnY
 /tKqG62pL5PUA9qxpdrXJA8QOTMdAooatw8/YZ+6wYYOxSm2XOW2FnEMackHNAVqBpuqyN34aFR
 7ruDyNIr3d88Ts4qLkjD786Yh5niqwCg/L82criQdyHdNSnaF+DYx33xM4jWRaxlk=
X-Google-Smtp-Source: AGHT+IHcRY51CWauF064v9TtihRrcasOuwtxxObLav8VLDs9kRK2xgMQH4yZ9neyY++b5SX2vNbtJhgTgzwQ/XKOl7Y=
X-Received: by 2002:a2e:a98e:0:b0:308:f0c9:c4cf with SMTP id
 38308e7fff4ca-328077aee22mr111806591fa.33.1747919303376; Thu, 22 May 2025
 06:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250521110908.1665170-1-festevam@gmail.com>
In-Reply-To: <20250521110908.1665170-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 May 2025 10:08:11 -0300
X-Gm-Features: AX0GCFuCc0UZHUQtRy9VXeoiMv9pV9yx_1KNnfXnx7JHOAJ52tFLxluejXC9xrc
Message-ID: <CAOMZO5AgCh6_e0ObQJYkfrmp_vKvvcohJhHVyhjgUAo6Pg4Hdw@mail.gmail.com>
Subject: Re: [PATCH] caam: Fix CAAM error on startup
To: gaurav.jain@nxp.com
Cc: trini@konsulko.com, peng.fan@nxp.com, olaf.baehring@draeger.com, 
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

On Wed, May 21, 2025 at 8:09=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Olaf Baehring <olaf.baehring@draeger.com>
>
> In rare cases U-Boot returns an error message when intantiating the RNG
> of the CAAM device:
> =E2=80=9CSEC0:  RNG4 SH0 instantiation failed with error 0xffffffff=E2=80=
=9D
> This  means, that even when the CAAM device reports a finished
> descriptor, none is found in the output ring.
> This might be caused by a missing cache invalidation before
> reading the memory of the output ring
> This patch moves the cache invalidation of the output ring from start of
> the job to immediately after the notification from hardware where the
> output ring will be read.
>
> Signed-off-by: Olaf Baehring <olaf.baehring@draeger.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
