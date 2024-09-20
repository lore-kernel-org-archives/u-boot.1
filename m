Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897CACF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CEF288C7B;
	Fri, 20 Sep 2024 18:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PTewK8sg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31FE288CDC; Fri, 20 Sep 2024 18:04:09 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E14988C7B
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7191f58054aso1798547b3a.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848244; x=1727453044; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Krl3SyBjCPtWxXv5zWpDekGfRB1jQb4/40MjR59ADXU=;
 b=PTewK8sgoNV9nmP9wD6HzK3gsjrUrdsGFzsAQdS7em1jdncuOiZnrnP0eW0C59u2zB
 OEEHpE7sakVJtBzBq8EfLCVF1DDoAnzTuqJgdKexIj4d8uOZaO5Ah3lBXhmZK4n8qg2c
 zUddDS/CUShafoNfc8wtBn3eu458JC+0lT1X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848244; x=1727453044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Krl3SyBjCPtWxXv5zWpDekGfRB1jQb4/40MjR59ADXU=;
 b=YjegaqDlaZfT0BXL8Rx1HaYANH0Dd9smPzir1Oujg8V+GrVQuQrKrh8BNdAxEy0GUv
 9IKGw3lhbYUriPEvj5FQ4NvEL3B1xwcwoMn3Ufr6D1ZiXziGfkXVU7qwPy9WWylWx6CS
 75+PwJNOERtU8S+ChDeHi9X7Ab+yQE4r4key3RdqLEkDIfbZ4Z92FbW4rZfBE+QjxDMO
 sWQtP7Znt8CN2Fy6a3uaiqN5yNGDVo4mdvk1V4SZkc3sF5hoGGIm6I7o64arI7ffwdUA
 QU9D+yQsQ2NhD1cxzLeu4VEfmCm1Su3KzsbddA8/bNDjpwaIZ5qPK3AATNeDrpv42k3C
 6fHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkvPNvStZZkRnUuDxkwJOSSNpnnVUmyFKuWAHdw1jaG5p/0SzNMNNN3DpFUAIo27N2d9OYTBg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyd+R4bltUhPMEFZNzxUY33Z8T3g/YQz1H3eUyaf1LLlPdm2Fjq
 8v542yYVOa1PHDvYByjWRw1i5TduowzxoJBtgGFHxKiKojEi9NojR0Q9zInvYgX4OuGSmBzzXoi
 RPZN8tyUbp5R6yHzi+piV9ChB35mG2SOAReJw
X-Google-Smtp-Source: AGHT+IHkpJfGpsN1IOkDCYqIqcU5uNgM6re194yRwcwa1g8cKxWRD+ZopUXCr5wJE0mz77liDo/7AAktwZScSDuygFM=
X-Received: by 2002:a05:6a20:63a3:b0:1d3:d5f:d9d9 with SMTP id
 adf61e73a8af0-1d30d5fd9dcmr3292245637.4.1726848243982; Fri, 20 Sep 2024
 09:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
 <20240824092716.1042696-10-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240824092716.1042696-10-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:03:50 +0200
Message-ID: <CAFLszTi0hCQP5Pzb0kB8bduGiQm=Kqn97u4CjF=0kmLzxVGAnA@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] net/netcat: add netcat over tcp support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 24 Aug 2024 at 11:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch adds downloading/uploading of data with netcat.
> Client/server mode both supported.
>
> How to test:
> ============
>   netcat-openbsd=1.219-1 from debian were used for a tests
>
>   a) Load data from remote host.
>        * U-Boot listen on tcp port 3456
>        * PC connects
>
>      u-boot: netcat load ${loadaddr} 3456
>      PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb
>
>   b) Load data from remote host.
>        * PC listen on tcp port 3456
>        * U-Boot connects
>
>      PC:     netcat -q1 -l -p 3456 < image.itb
>      u-boot: netcat load ${loadaddr} ${PC_IP}:3456
>
>   c) Save data to remote host
>        * U-Boot listen on tcp port 3456
>        * PC connects
>
>      u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
>      PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb
>
>   d) Save data to remote host
>        * PC listen on tcp port 3456
>        * U-Boot connects
>
>      PC:     netcat -w1 -l -p 3456 >image.itb
>      u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>
> xxx
> ---
>  cmd/Kconfig          |   7 ++
>  cmd/net.c            |  34 ++++++--
>  include/net.h        |   2 +-
>  include/net/netcat.h |  20 +++++
>  net/Makefile         |   1 +
>  net/net.c            |   9 +++
>  net/netcat.c         | 181 +++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 248 insertions(+), 6 deletions(-)
>  create mode 100644 include/net/netcat.h
>  create mode 100644 net/netcat.c

Reviewed-by: Simon Glass <sjg@chromium.org>
