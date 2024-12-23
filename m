Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F25E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 823B9806D4;
	Mon, 23 Dec 2024 14:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JnpKSD1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56ACC80713; Mon, 23 Dec 2024 14:21:50 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE1B80655
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-54020b0dcd2so5526021e87.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 05:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734960107; x=1735564907; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0C/e5N6W1TLCXJfDjL5kYZGoBd7a3Jc1lvn6vzkGCwU=;
 b=JnpKSD1Ibk/oN5UrcQPygt4VOF29mgJuJQpFfaDtF8AT/5Ga61/pT4GlPLu7Ur9wf4
 l9ru179yjr6g97Y0ybKlq0NNlF7eln7dj9uGhBOU55CghyUPcBwiRq/mxIsZN7yskSMl
 x412bZ6z7b/bI00z+TgsDP1EbaMsEQlvDxhtmWGfb/I5hArNTu17EtvXtvZJuk2NWqM0
 X9DMvEr0CSnrApI6/Z126WwaBCfzm6ndKL5v52jVb2IaGL9hD1zcjkzoKgpWJKMKV7YI
 /+2a5QOVRwtJNWWXSOTYAwenoFOcVP7cuK5ByWpJxgMTB2Euabmf0mh23PuC8g5DsFEF
 /gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734960107; x=1735564907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0C/e5N6W1TLCXJfDjL5kYZGoBd7a3Jc1lvn6vzkGCwU=;
 b=ras2ghAylOfIdJTw18KpxGpiqk+/1AODcqoeUqM0o6jQDigzv8Ih1Td1mMjeXDLAA+
 B2OfEPZsfZK9t12/iEcCivaCBpkjMnaJszXnyn/SRSwje+7gnOQoi7969gQhNom0ACZ3
 FJfNtQiU906/xMG9u1Ppeju+41B6wFkN1PaHrB7LYcjNncAQxeTM/cRkb/Q3oCx5hhxM
 jdxv7DD6SgsqrWWi4+1oozL5J/ie1lE08Ehd/PaQJDNuK9xPHWqpYaPjM1TZ4juLTgqH
 tmQZgKquEzO0qeUdfeJ6ATbI8fUWkxWqqO7n3RfuqIXRDnSJfOM1eDL/s//95adIYsax
 mU0A==
X-Gm-Message-State: AOJu0YyLncFnKCbj4b8YFx+YZNva3Z/kUYmGII/5C6h7T519fRasLOgV
 flHtdFXsAlWNXzKS0JnzY6exoM82gITnlAuijQe71wih1nYVfDwmaXEnkUW0UmWzfZAR9WitWe1
 ttAvc4TR5IUUFbNSO8Wyq+w3kbr4=
X-Gm-Gg: ASbGncu9xKm1GTBL1TUxA//722NrR6xXMAiZ4bzHmnF9MG9TdLkYAA6x9CKMOk0UkUu
 7WJ5xaN0ZBRfD46Z5+c5PUThp2iIDi3F+KyncL4ta3zsO8asXFMiHdXgpbolDVivS1ZtR
X-Google-Smtp-Source: AGHT+IHH3CrGE77lKqQ6cZbJrUFLug1uQfmTW0kCUeijsf4DIqB/EVNiZOLpT2yeIaKzR6Gi0ZVSx8Lvvf/+ttdGXb4=
X-Received: by 2002:a05:6512:4005:b0:541:32e5:654c with SMTP id
 2adb3069b0e04-5422133b6d6mr5301625e87.17.1734960107122; Mon, 23 Dec 2024
 05:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20241223024104.1425680-1-Meng.Li@windriver.com>
In-Reply-To: <20241223024104.1425680-1-Meng.Li@windriver.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Dec 2024 10:21:35 -0300
Message-ID: <CAOMZO5A_jtrpgRcD9sa7ffb635JECA=ftU5RUukQ8s=9XScJ3g@mail.gmail.com>
Subject: Re: [v2 PATCH] net: fec_mxc: add DM_FLAG_ACTIVE_DMA flag for FEC
 network driver
To: Meng Li <Meng.Li@windriver.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 trini@konsulko.com, ye.li@nxp.com, peng.fan@nxp.com, 
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org
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

On Sun, Dec 22, 2024 at 11:41=E2=80=AFPM Meng Li <Meng.Li@windriver.com> wr=
ote:
>
> From: Meng Li <meng.li@windriver.com>
>
> When FEC network card works as the prime one in u-boot, and is in
> active status, kernel might crash during booting up stage, especially
> working with grub. Because the DMA of FEC is still in active status, and
> copy data into memory if there is network data received. In this case, if
> kernel allocated a part of memory that has overlay with the memory
> used by DMA, kernel memory may be destroyed and cause kernel crashes.
> Because before kernel boots up really, u-boot dm_remove_devices_flags()
> can call the remove callback of FEC driver with DM_FLAG_ACTIVE_DMA
> flag. In fecmxc_remove(), phy power is disabled, so there is no data
> received. In this way, it makes sure that there is no DMA action, so
> that avoid kernel crashing occurs.
>
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

Applied to u-boot-imx/next, thanks.
