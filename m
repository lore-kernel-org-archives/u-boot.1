Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C1AF94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D1A83BC8;
	Wed, 22 Apr 2026 03:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aI/Iq6FW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77495805D7; Wed, 22 Apr 2026 03:16:17 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F33C841C8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b788a98557so9439595ad.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820574; cv=none;
 d=google.com; s=arc-20240605;
 b=JUjUgr/vRs4Ex5rMHKVZ1GTANJdJW0nSOSrZdgwwcA5htWPAiGscJIU+jcrp/D2ncN
 wVCr+nBWIVLz3u/57H2nSyFBtzFSiKXZHPUfIru2XaNSaLG88GPwdDCBphX+5BOxe1qN
 +lxhvSdnZ4bDBHkEVsSgDCwtlaVYKB9lUV6tocGLDg951PXOlAEgbcVoYcvpMAtnL4Ux
 PsUBlTa5mQWce/myvSxHW+I32K92JnCU7SJ7/ctO5lHPexkfpbV6xi8yf4ZLZSQn8has
 d+3nbbVg4/lkVAbaMyAh+4Bx/ry8RqCBTSSKZ4Je9ceq01JlszRWHZuT9QTfCwQ5PMUR
 T5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CSAEZh/kFb5Oqu8HKLIhg1j6lG45Q2sMZrTStpaOHqI=;
 fh=s5k+GXS5xpLDRTh8FeQDL4pYyUAXQZOxB2tgRxoo5BI=;
 b=BH3BGS8DGq8HZ3TemtgWEYpXylT4Vn++cIrwGC0aDUww8rYKGMatyAFh3Gy7LoR8j2
 aGxVa6PquEN1qwA63Kx4s3JrHvRXozcCNiR9gQd5Yn6CHRjfpi4KZHT97dLdOR4QBaR3
 xPzggGOx7SpoRXOh4Br/GZgZIWnz5m5hIHc0hGNEDUC42QOeZlNl1kN0IIdIwN+NZDlY
 RyoNQhPDJY4pZ3kciFBwvJdXSL9Tyvy0iocEgcPcrFzlr84dkd/uXSfImyxa+PdnH351
 3VdQoW1Tce5nyxZxae6QN7+mdbZ9yGWQbw6Z7DJfgicwbWcr8H4WQeV+azBPvXu9fvwV
 dOHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820574; x=1777425374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CSAEZh/kFb5Oqu8HKLIhg1j6lG45Q2sMZrTStpaOHqI=;
 b=aI/Iq6FWsx3KfPxqAdRdQ2YAXNbs+Kg0FLTLUh+vBPq1+s08cVLA58YiWtWeYAZy2w
 mXviN5E7RI4Xj4l6Pl2rq5RbNCbHvTH9VYjMfRXchcCFP+CtmoX+MoJ4A3yoqZrMEgR1
 5OaSeVfxH4ymLVz+DQAtDUFoJuXP/dLNx+mZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820574; x=1777425374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSAEZh/kFb5Oqu8HKLIhg1j6lG45Q2sMZrTStpaOHqI=;
 b=mfE8joW6Ve6l1jCGHOLxzfQgxUd5q6y6xSGpFqGFiD+uwfGUjAdVK4AmE0XC1bAsl6
 +kFPEZydAV5weNrCCyZMobhqJvQ9TR2+eaEqIYOSdhyWEyvVqA4MYcg7tmX462C0vmo/
 1ImhYa3aHAW2VhV7tTM1yULOgCq04OhijUR1gkMcnDj9L85LcYRbw36eG3EcnwurqQoC
 28hs1cPpY/wMlgJ0fP8KFBqi17esQG7s0yuvd2SMaAjsJHtnbzanaYTPjz/Izdi8UjHL
 9TRgwoPYE6lboz4L88M09deFDVATxPV75LUWAbilXuu1bmTAPkfdM9liuEbjShLWBkf9
 wT1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1oNZZIJOlY2H2cMOvrSzpcSbIs7PRyAaxOEo/TwT8gNVKrCCC2Y8KyqHXGFENbJuMmiW9vKE=@lists.denx.de
X-Gm-Message-State: AOJu0YzQNxFSxnXfBQLD0FWrmk9fmbxaqzBysL8bP/JIOzZfydR2EHur
 X2nB3lbTGPU5ldvu3UNxq76KSSA2mY0rBlPRJvhDwMpcAb58PaVRwgP9hHXcIxIe90d3lfI82F5
 sTKdgrDsJ0Dgk0DKpuFyS49EEagMxYH8OU9Q9RpCZ
X-Gm-Gg: AeBDieu63QkrmRebFNhJV7uUO43xRlpQrwZ+uFFxkipQn1kcyCLH74lntaiqUIQoBC9
 GizofHBFzal/7mq2HYN54cNBZKcVfTNZzaW2/zxjbqcCQGjxx73VnrXyYYLssbHnl2bwC8cGrFi
 midksyLpy37GtrW4qaieonj9c811XJC94ZtNCA+Ru07CajI1Y/dlx1FlhUc2TG+wORPudSu0mO4
 3tQ8vK8u8xSmhoDOnYAkiIdcyuGRVQBoaCqHLMYfmA97Td1zvp21EMoiztagGiptRwqDiFQM0Fq
 5MoE4KcoWSWIBvJ4N3Lr9tHfIl68/kw=
X-Received: by 2002:a17:903:8c6:b0:2b0:c45a:bc2 with SMTP id
 d9443c01a7336-2b5f9eddc7emr220647045ad.16.1776820573566; Tue, 21 Apr 2026
 18:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <CAFLszTjTSUOy9=d5NpgsP63dQp7UXuhpqg4wFwnXgWJzD74_6w@mail.gmail.com>
 <3462e9ac-e882-4145-88d2-a553cd1c3cb2@cherry.de>
In-Reply-To: <3462e9ac-e882-4145-88d2-a553cd1c3cb2@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:15:48 +1200
X-Gm-Features: AQROBzAf7xRrS2jGFjqKPDeXJlQGBkjZ1ouw73iZA-qYk-KC9aErTq7E8ZpDLWM
Message-ID: <CAFLszTiPWDtL4Xz2RpvGenr+8smgpq_E8rjuZ2qAqriTGU4OMw@mail.gmail.com>
Subject: Re: [0/6] net: migrate NO_NET out of the networking stack choice
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: foss+uboot@0leil.net, u-boot@lists.denx.de
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

Hi Quentin,

On Tue, 21 Apr 2026 at 23:06, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 4/20/26 9:51 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On 2026-04-20T11:36:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >
> >> This series introduces a new NET umbrella symbol with NET_LEGACY and NET_LWIP underneath.
> >
> > Thanks for this cleanup!
> >
> > Re SYS_RX_ETH_BUFFER, how about moving the extern for net_rx_packets[]
> > to net-legacy.h ? (is it used with lwip?)
> >
>
> That's not the only thing making use of SYS_RX_ETH_BUFFER.
>
> - drivers/net/fsl_enetc.h uses it as value for ENETC_BD_CNT which is
> used in drivers/net/fsl_enetc.c,
> - drivers/net/rtl8169.c uses it (if defined, otherwise defaults to 4) to
> create a static buffer, see NUM_RX_DESC,
> - include/net-common.h sets PKTBUFSRX to it, this in turn is used in
> *many* places, including many network (assumed Ethernet controller)
> drivers, net/lwip/net-lwip.c, net/net-common.c (with net_rx_packets
> array, used all over the place), net/net.c, and net/tcp.c.
>
> So seems to be used for both NET_LEGACY and NET_LWIP.
>
> Simply guarding the "#include <net-common.h>" with
> CONFIG_IS_ENABLED(NET) won't do as many files currently expect some
> functions/macros/constants from that header to be defined.
>
> Another option is to ifdef PKTBUFSRX contant and net_rx_packets array in
> include/net-common.h. But it's used in arch/sandbox/include/asm/eth.h
> and drivers/dma/ti/k3-udma.c which aren't clearly dpeending on NET being
> set. All defconfigs enabling CONFIG_TI_K3_NAVSS_UDMA do not modify the
> default CONFIG_SYS_RX_ETH_BUFFER which is 4 (according to
> ./tools/qconfig.py -l -f CONFIG_TI_K3_NAVSS_UDMA
> '~CONFIG_SYS_RX_ETH_BUFFER=4') so it should be fine for this driver not
> to have PKTBUFSRX defined (as UDMA_RX_DESC_NUM will then default to 4).
> According to ./tools/qconfig.py -l -f CONFIG_SANDBOX CONFIG_NO_NET, all
> sandbox defconfigs have network enabled so maybe
> arch/sandbox/include/asm/eth.h is not an issue either (or rather, for
> later :) ).
>
> With
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 69b6316c1ec..0c260873c2c 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -20,7 +20,9 @@
>    *    alignment in memory.
>    *
>    */
> +#if CONFIG_IS_ENABLED(NET)
>   #define PKTBUFSRX     CONFIG_SYS_RX_ETH_BUFFER
> +#endif
>   #define PKTALIGN      ARCH_DMA_MINALIGN
>
>   /* IPv4 addresses are always 32 bits in size */
> @@ -132,7 +134,9 @@ static inline void net_set_state(enum net_loop_state
> state)
>   }
>
>   extern int            net_restart_wrap;       /* Tried all network devices */
> +#if CONFIG_IS_ENABLED(NET)
>   extern uchar          *net_rx_packets[PKTBUFSRX]; /* Receive packets */
> +#endif
>   extern const u8               net_bcast_ethaddr[ARP_HLEN];    /* Ethernet broadcast
> address */
>   extern struct in_addr net_ip;         /* Our    IP addr (0 = unknown) */
>   /* Indicates whether the pxe path prefix / config file was specified
> in dhcp option */
> diff --git a/net/Kconfig b/net/Kconfig
> index e712a0dd2ac..deab340f26b 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -279,8 +279,6 @@ config TFTP_BLOCKSIZE
>           almost-MTU block sizes.
>           You can also activate CONFIG_IP_DEFRAG to set a larger block.
>
> -endif   # if NET
> -
>   config SYS_RX_ETH_BUFFER
>           int "Number of receive packet buffers"
>           default 4
> @@ -289,3 +287,6 @@ config SYS_RX_ETH_BUFFER
>             controllers it is recommended to set this value to 8 or even
> higher,
>             since all buffers can be full shortly after enabling the
> interface on
>             high Ethernet traffic.
> +
> +endif   # if NET
> +
>
>
> And building sandbox_defconfig with CONFIG_NO_NET=y, the build finishes
> without any issue. So maybe that's the way forward? I think this would
> be better as a separate series though, what do you think?

Yes that approach seems good, definitely a separate series as you say.

Regards,
Simon
