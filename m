Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBBEC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 11:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E1187F43;
	Mon, 19 Feb 2024 12:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VxG59Yau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48DB987F43; Mon, 19 Feb 2024 12:48:43 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A326587DEF
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 12:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-607d8506099so39576957b3.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 03:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1708343316; x=1708948116;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rQxtp8hDw56jJYfrr6QeO8UQFoTG2XduyT8V/pX9xQ=;
 b=VxG59YauwkxtTSUI3Go4e0dSbEhU7MZytJ1eXUY2jKYMtthXCxpkA0KR4NWW3UW5U7
 8Zr0Z1A6qFSMUOMAfywZ39V22PdHWDXKVMaKREyyKdP3u7kNvDSJ/xJNYu2n3VX871cr
 TCkUDJ6jqLUFwmsf7if5r6GsbbpuTatFT0ltE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708343316; x=1708948116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rQxtp8hDw56jJYfrr6QeO8UQFoTG2XduyT8V/pX9xQ=;
 b=DGPg8oEMC8kU8b0TvsqIFfzp55EBYOQeaWfSy4tSlnf7zRInHUz9KwSgTyB3kJdJtw
 as80AA1b1bbJNTM1jJXtdm4XTsSHdn5w9rQ1K6fx6ZEbfvaRR4qPYrlrLElXjORGqiuy
 75CbiXulRVtvVdm0dOPP+yFIxYrU83o8YHob9dBoP6s5+BZqok6WcsR/v7UWRSboV+vc
 Bos9OkeRsyOOMh0F4uHLttLOAojskajHFI6RPdzQn6RlriObXaINeft79MDZ4sAFOXgz
 Qru+nc+ffUPY68DejZnwwBGXzKMW16dL4Gh1HXBn85j/H9/TDySPhHoShJHBVpCa0E8p
 a/Rw==
X-Gm-Message-State: AOJu0YwVpOFBRHHVw0gLaLP3avGLpoyluW/ZvpwVQtf4vyFa4kx3rYdu
 4RTczMjBk8wgIHwryLygCKICixMJq8BFV5N7YI+OW6w7mhSVZ4MX6cK9nap7fug3nqfpKUY7YFF
 OXuQzlh4nHLo2cU79/As8RNI4U8G3hcKywoPosA==
X-Google-Smtp-Source: AGHT+IF3/quip4bahD7lAP6wMz345qwujeXoPatygecQK559WnCg4sX1W1+QLzGUHSf/slhnjURpUIptUbRWs07r7/8=
X-Received: by 2002:a81:f00b:0:b0:607:9202:3fd9 with SMTP id
 p11-20020a81f00b000000b0060792023fd9mr10487637ywm.41.1708343315700; Mon, 19
 Feb 2024 03:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
 <20240130044423.1391251-5-venkatesh.abbarapu@amd.com>
In-Reply-To: <20240130044423.1391251-5-venkatesh.abbarapu@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 19 Feb 2024 17:18:24 +0530
Message-ID: <CAMty3ZDt-JQra+F=uUt1vynATYugHJWZFK4-AOjP3oQKohENbg@mail.gmail.com>
Subject: Re: [PATCH v10 4/8] spi: spi-uclass: Read chipselect and restrict
 capabilities
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
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

On Tue, Jan 30, 2024 at 10:15=E2=80=AFAM Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> wrote:
>
> From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>
> Read chipselect properties from DT which are populated using 'reg'
> property and save it in plat->cs[] array for later use.
>
> Also read multi chipselect capability which is used for
> parallel-memories and return errors if they are passed on using DT but
> driver is not capable of handling it.

Why would the SPI controller need to know about multi chip select
capabilities of one slave time called spi flash. We need a way to
abstract the slave capabilities from the controller point-of-view.

Jagan.
