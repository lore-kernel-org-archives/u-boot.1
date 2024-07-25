Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31E5C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538E386D4C;
	Thu, 25 Jul 2024 16:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PM2SFHAX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C1187CEB; Thu, 25 Jul 2024 16:28:38 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0F386464
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52efbdc9ebaso37996e87.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721917716; x=1722522516; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFYFaX9Z63UksvXeEOhqSqBtzbkkEEgWrW3GpKbkgeo=;
 b=PM2SFHAXjp8Rfi8EkMfESEEsJnrfPKPs4CnLGQD1s2xt41R/SJxdYVkl4zh2nwl6/Q
 T0gF0a3o2hYYZJ+gLxxF9qli/0bJrwN4DO8rCZjlgdXpix781bpLX/b4bwLrXM+iqONw
 xOy+KfnfW28XaqKlOlv+G6IjOa6ffUo+F6SJxibQMpvgxgxHCZosubY9Fq2xluKCdB+O
 yjEXamQqLtTWFElWtWznd45P5Y9fa09ODaP/3zi/2k8CaGn5N9rExcMyf4nOBFcUVAwv
 5Xxcq+k5K4OCWQKTdWcD3UeCfvdTbZ+4+LAmt8ooYmlAAPHXEp00kxY9P/g60VKGwbWp
 l3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721917716; x=1722522516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFYFaX9Z63UksvXeEOhqSqBtzbkkEEgWrW3GpKbkgeo=;
 b=dhZQg431+LwWFNo9LuhpiX10EkBqiJEcmzn7cosItbovQfjWqI/C4o3PaXY833mbr6
 0osU1CKdBwWFi/Sb1PoOE6SgBT9Fq30+id0wW4faJVOApNhiVkAwik4C85SX71kOkqre
 oKG+pWjRiZxxI/4Zrc+FWS7WfE1Ls1fSUedHX49lb/A1Je1GBF9YiWwx9CCytnFX7CAj
 K0hE+Q+LLkhr9NkqnRg2MHOh05ZmFx7P0BpziYgA1C6dKWT1RDfkXCRx6LxFU5oVvyCh
 snClqae2n1wD9VafAT6ngLela5KYIeW/f3y1UkWkH7yajUmLn38YumR1hlJNRd4g4Wte
 FXaw==
X-Gm-Message-State: AOJu0YyZ5zHHcrtdv1ofBlJMimhJI6ZVgFiPJ/GDS3qPNlwbBrMLrAoV
 RbVTadRsuZS8hxEszx4KuCM7WCy8baYgFFi9hIYxYjeLXa7FVIyMdnO03RUJfE3SDIMtR1SiY7L
 WQIbJqCwHAfZwKxP7PknQV4nUqbM=
X-Google-Smtp-Source: AGHT+IEvjMRnLzHasfIGFTWQ41vUagHJIOpMNuYCXvrvONr6QvFWqD/rppgzcieuAlv1RxUOwQzAMcnSV0FNzw9u+YI=
X-Received: by 2002:a05:6512:1291:b0:52e:93d9:8f39 with SMTP id
 2adb3069b0e04-52fd5274c76mr1126048e87.3.1721917715610; Thu, 25 Jul 2024
 07:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
 <20240725095331.14245-8-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240725095331.14245-8-Zhiqiang.Hou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Jul 2024 11:28:23 -0300
Message-ID: <CAOMZO5A_FH2Jzz9cRewaCB6VTdQm87Ea6kb8XFdb-6FCbGoYmw@mail.gmail.com>
Subject: Re: [PATCHv2 7/9] cmd: cpu: add release subcommand
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 sjg@chromium.org
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

Hi Zhiqiang,

On Thu, Jul 25, 2024 at 6:32=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>=
 wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add a new subcommand 'release' to bring up a core to run baremetal
> and RTOS applications.
>
> For example on i.MX8M Plus EVK, release the LAST core to run a RTOS
> application, passing the sequence number of the CPU core to release,
> here it is 3:
>     u-boot=3D> cpu list
>       0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
>
>       1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
>
>       2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
>
>       3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C

This looks much better now. Thanks for fixing it.
