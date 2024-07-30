Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C608AC3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 09:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC390887BF;
	Tue, 30 Jul 2024 11:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ErI/hR2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E77887D4; Tue, 30 Jul 2024 11:57:48 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30FA1887B9
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 11:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fd69e44596so27634025ad.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722333465; x=1722938265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ETCNyOOsAKqnu8w73R4y9qUtds/kPFZgiGDrWYIQCLs=;
 b=ErI/hR2Rh+ta7+zI+Fneq7noiys8POBuCZdDcs/PaNh8PXolPdzpIPASsNoJcWrb5r
 tJ01oHJtXtjgXiq3zijA7NnxDykWTX04CmpYciKDAuxo99bAh5KEtfAkeaFrAU7A6NZw
 S82S6MsENCiS2a9eJ0mb4hOWLkCEK44P24Y/Bkh9tOMv5pMbRMbQqgJy5C51oZU30GnQ
 5V9ethRHHmOLd00Ev+XMgBTlZv2Xz53gDi1mB5XeYq2lDQDg7YUf/xaw49UrUgzUCB6A
 HdUCcPCpYL2CgwfIBaxbZ5fLjLCxHBA0vWpF5OJcu+3VTpros1KEN/KVx5bMfkqeKCCw
 AvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722333465; x=1722938265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ETCNyOOsAKqnu8w73R4y9qUtds/kPFZgiGDrWYIQCLs=;
 b=MiaBMQoYjvFIv01SnSvcVh4hkFViCuQ8u2ei87zEi5fAF80yaPSj7GQVTVJZX0no0t
 uTOln7sW0NMfXbUOrid76h0zmZxPd17e2QWbr0B9ryUdwuqw5jh28AQ9K2zeUOLGbqfj
 FY9mO1LQls3xBzFL1myfjf4B0anDQBs//H0nHtWVGNZk5Qdiy+ybL82eDCmkQPBvQB8I
 0kBo6WYgLuXuex1SleiYtu04jGs3Lwxy/ltiwuN9QTPxSQ90GuLJiS/b68Eq/ixRY/li
 cbQkY/iMsmeuw/41HVWH/MIKK/LXy1d7mTlpuWbt/maP/A3Q8Cgn0p+5Or9koccvgVby
 /awg==
X-Gm-Message-State: AOJu0Yxqdo8WaWMTdjRtm+BA7ke68SSqESgWFOy3Bxtp+dpUbqeHFUc3
 8FqJFPNodEKjpf3jTSaJc3Nv/P2VURMCHxUVbwvN1YhfN89d8dq2tV0ZXHLqluiuqnrImNxm0YO
 rY24xAq5l32wlhw3HmSEUY2Ox/WqxBUTAwfA7HQ==
X-Google-Smtp-Source: AGHT+IEGm32FXyqj2pkgair47iiUAQmfrCRtthwb8HTHXyLFz4h4TF5+j1LeQbB2MxUgVO1PzE4ZxBVAWNvFNhuVZ90=
X-Received: by 2002:a17:902:fa8c:b0:1fb:9b91:d7d9 with SMTP id
 d9443c01a7336-1ff37c111a1mr22350795ad.26.1722333464550; Tue, 30 Jul 2024
 02:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <4dee5a89157f3dd0e0a8d17ab6ff42292bb7ce79.1721910373.git.jerome.forissier@linaro.org>
 <CAC_iWjLpwGzyNqqgs0YVZpR4=Vncnd7V_DVDcONX9OweyrDWGg@mail.gmail.com>
 <a117047c-8429-4209-9018-b160e9373ff9@linaro.org>
In-Reply-To: <a117047c-8429-4209-9018-b160e9373ff9@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 30 Jul 2024 12:57:08 +0300
Message-ID: <CAC_iWjL=XZRVr0ggD+HAvP-Q3M7+w=4ePOqWebD=wohx17ff5w@mail.gmail.com>
Subject: Re: [PATCH v5 18/20] net-lwip: add TFTP_BLOCKSIZE
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Baruch Siach <baruch@tkos.co.il>
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

On Mon, 29 Jul 2024 at 18:18, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Ilias,
>
> On 7/29/24 14:29, Ilias Apalodimas wrote:
> > Hi Jerome,
> >
> > On Thu, 25 Jul 2024 at 15:59, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Add support for setting the TFTP block size. The default value (1468)
> >> is fine for Ethernet and allows a better throughput than the TFTP
> >> default (512), if the server supports the blksize option of course.
> >>
> >> I tested this change with qemu_arm64_lwip_defconfig. The throughput is
> >> now 875 KiB/s vs. 313 KiB/s before. That is still a low number, but I
> >> think we can't expect more without implementing the windowsize option.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  net/Kconfig     | 20 ++++++++++----------
> >>  net/lwip/tftp.c |  2 ++
> >>  2 files changed, 12 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/net/Kconfig b/net/Kconfig
> >> index 952690d677d..7e5406bb923 100644
> >> --- a/net/Kconfig
> >> +++ b/net/Kconfig
> >> @@ -69,16 +69,6 @@ config SYS_FAULT_ECHO_LINK_DOWN
> >>           this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
> >>           be configured.
> >>
> >> -config TFTP_BLOCKSIZE
> >> -       int "TFTP block size"
> >> -       default 1468
> >> -       help
> >> -         Default TFTP block size.
> >> -         The MTU is typically 1500 for ethernet, so a TFTP block of
> >> -         1468 (MTU minus eth.hdrs) provides a good throughput with
> >> -         almost-MTU block sizes.
> >> -         You can also activate CONFIG_IP_DEFRAG to set a larger block.
> >> -
> >
> > Why do you have to move the config option?
>
> It is moved from the 'if NET' block to the 'if NET || NET_LWIP' block since
> it now applies to both.
>
> Thanks,
> --
> Jerome
>
> >
> > Cheers
> > /Ilias
> >>  config TFTP_PORT
> >>         bool "Set TFTP UDP source/destination ports via the environment"
> >>         help
> >> @@ -263,4 +253,14 @@ config SYS_RX_ETH_BUFFER
> >>           since all buffers can be full shortly after enabling the interface on
> >>           high Ethernet traffic.
> >>
> >> +config TFTP_BLOCKSIZE
> >> +       int "TFTP block size"
> >> +       default 1468
> >> +       help
> >> +         Default TFTP block size.
> >> +         The MTU is typically 1500 for ethernet, so a TFTP block of
> >> +         1468 (MTU minus eth.hdrs) provides a good throughput with
> >> +         almost-MTU block sizes.
> >> +         You can also activate CONFIG_IP_DEFRAG to set a larger block.
> >> +
> >>  endif   # if NET || NET_LWIP
> >> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> >> index 78de0bd0dba..1fe948c84ec 100644
> >> --- a/net/lwip/tftp.c
> >> +++ b/net/lwip/tftp.c
> >> @@ -136,6 +136,8 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
> >>         if (!(err == ERR_OK || err == ERR_USE))
> >>                 log_err("tftp_init_client err: %d\n", err);
> >>
> >> +       tftp_client_set_blksize(CONFIG_TFTP_BLOCKSIZE);
> >> +
> >>         ctx.start_time = get_timer(0);
> >>         err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
> >>         /* might return different errors, like routing problems */
> >> --
> >> 2.40.1
> >>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
