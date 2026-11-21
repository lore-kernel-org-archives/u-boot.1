Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DC606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kBsWt/6Q;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OxkfOfWQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BBFC80E52;
	Sat, 21 Nov 2026 23:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxA8kYJX8bD6; Sat, 21 Nov 2026 23:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9592480E4D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795304122;
	b=McjF5DJxVx9Q9zLaR9Ps0lzGhzaNXPS+JFMNthRAxQofiU+uHfsgwSE9CoC9FzTHXvoJ
	 zasXNJWW7ppi5UvcqCh3xjwH91mW9J/GxQeyqF0DxPYQUS1z0ovPdDaQMQ34N4kvlN4M5
	 gdakwrVYKy0ewrbEZKThBxZyigR0xhHgTBZvihkHVWsca55rGcvEM8WVqSWbefGgQyE8/
	 LLobfVPK82V2hfZtNFhrRwOeX8tOPW+OxjcE0FS3koIg8zem99Fj/oRnY7GKwSJGCgL/+
	 J3T1KuTb5bKLrePP11r6XwvwE2nfPQf5/Gov2EgJnV64FmRku6I/5EWcHH+tCNb+fow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795304122;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YfDLipuEU/sC89s3BtxVSko+H2BBPF/B3OkWXqfT45Q=;
	b=kIMWQM5uEzzEb0i4JjKu/mosFaeFx/G4pmUxttVOQRw90vQ9LLQPJpjawlq6b53NgvpK
	 m1M0oofUVKR7WwtnsB3vNpGexGqd9Qb+Br5LTq3yAAe/37bw/ijVLVKdJHH0KVbs9OAzz
	 bVOBfDx414njRETUvfEnZarPpKjx6A5zJji6l+oDCE0w9W/thE+ItJuGfxtRbp16ai68a
	 4OIwedRdH/zr4ca/3sN2MptZPudJZBa0Qe7KsiUY2U9rc5c25qSvG7t7DVE8K29itB5nm
	 v4Wa73SAoIfo3flqDVgZxua9OYnXnfkl9BnKUiSCQ899mXqqaj1ouQvTC0P2r/iXnNw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OxkfOfWQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795304122;
	bh=YfDLipuEU/sC89s3BtxVSko+H2BBPF/B3OkWXqfT45Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kBsWt/6QLUFGmFZ8c0DsRbI1dknA3zSNsLuLcW9vIS7/H/f3B43KJYgV6W5Uxm6jl
	 gkkckjARwKnKSDMV6yqG/qZWc7WjKYlZ8dRn0m1aOpxqUIw3ukpPRy2q9UbgVypjSb
	 34IFqvOkvTE7Qt+ryx3AuJ9dZAMfR2/3d7ASWGwmZc1gJUJYn6AD1gKt5nrFNkVaxD
	 W8CC8XF71i+e2tdJ324WO1d4geg4b0PM0EBlUlFbtUPyYm0CFT/2ZZOutRV0ZPTpPM
	 8GRuOFoTImD1B7oJ5JAd/VR7Ceda0vu1tq4ri98T5va9hDDcUD+LfsqivNOyBek13t
	 uz8R6Kqtyc8fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9592480E4D;
	Sat, 21 Nov 2026 23:35:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 45F9D310
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 23:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B7E780E4C
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 23:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRbVmSh27U1y for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 23:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E21A680E4E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=OxkfOfWQ
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E21A680E4E
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 23:35:17 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795304115; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:i1qccQT46cDcT6axi2h9lmO3Lecm
 ZkuMp8P13Yh4I+9w6gpOjsVTwxajYsCTe273Wvt6X05/BbQnnxW6L8Yv4t8v1BtZg33fH6TGHlk
 nGb76PNqpUlWBTzHj0CK14tt37dBg9za8SmB5otz2Qi9TpcI9SUqw33K1dkwDx5Ce81+wlelvP/
 KBjY8kYbJBvfEmVXbaOz9fKCnc1JYjqHR+h7mtj3FgBasNZLTuwwV/NQSLRdjVu5TVDPnR0T+bs
 uDC3j+JMnKE0h7ccgF2AGFFOiQ41AzrErw7av/zx7ywF+pcwk6rODzJnP9hkFu64u3ilv/6ltrj
 uALq87Gtbn0Obg==;
Message-Instance: m=1; h=sha256: D1KMvmMNCs/djg5QxDzyWQ0JtMF6/Fhrsfrtw/+ar9I=:
 3h56XvX+WzLOZi++9n9m5zCWUuLZT0sxuJSclIBFxwE=, sha512:
 zOuHtyX3WHNIOquL8BnenVgecfz01ce3bAwKBBKp0p8PENEbor6wEs5/LJ061so8B/Fe3YW5QVXfDD0DHPpZfQ==:
 mL5punoukD2TKIAr5qniQlWsL8VM3cRN5ZWAkJ3v2m2oMD9Rxph+aGXj1lXFzcJk7bLaAfhJItt0MMjfZOZJng==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795304114; x=1795908914; i=xypron.glpk@gmx.de;
 bh=YfDLipuEU/sC89s3BtxVSko+H2BBPF/B3OkWXqfT45Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OxkfOfWQtMXo840mKgIskKJBhkTztzYgh8QO2yoWQDzxwqh+B5/FYDuOenhyK6xP
 jcSz7a8pWDjmk40rJmaLWSuSIIfQxd0PAoqI5glsEVZJOCPwymZK2oYc7ISM/qZWq
 UJh6xem2J+oGfz3SaWSfzMGsV59okcQvUXnNVRiRaIJw4b66jv99CfgvJcskVEh/b
 Lp2NGhtaY8V2oP1xwFMa9YL7R9oQy6GNQb7gYVSAsVeUY+N5R20SOAV9MyIDa8IXt
 mMpCwCO0llf3pFPVEnJ4J/KIcwFyGCftozI4+7rL4Pch1wWmCvHVLqisOLcNI6JYv
 rDwegEpdghf4Xev2OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1xxoQF33MX-00WF9c; Sun, 22
 Nov 2026 00:35:14 +0100
Message-ID: <b1344e06-fd93-40e2-b065-b0d803f15800@gmx.de>
Date: Sun, 22 Nov 2026 00:35:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] timer: provide the counter end value
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 u-boot@lists.u-boot-project.org
References: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
 <20261111133029.2538132-2-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261111133029.2538132-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Bhb4n/Kqc3ltyY9In7vD+zTXn6T3oFzQMfDEOikf4uZKOBjcV9
 fz2ju9hY5khaOWDeCVg8FZtTbhQz/wpJLkOkrVO0WzmOqXiY06SfAqeCOkSzoBMO+cKI+7r
 0M0fJz+wkE89W8DHZ+F+mw7vkD4d3oA6emBsjLb+z5MKVDQDqnswhJkxt985geSahAPPRHx
 OfuRnitwQL5lU/owIJkIw==
UI-OutboundReport: notjunk:1;M01:P0:dx+ABbO1EQ8=;+jr/q3eem6zHMz8PNFRxq3VQUtg
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 14:30, Felix Moessbauer wrote:
> The timer is usually a free-running up counter, but its width depends on
> the driver. Some drivers extend the hardware counter to 64 bits, others
> return the raw 32-bit (or narrower) value which wraps much earlier.
>=20
> Add an end_value member to struct timer_dev_priv holding the last count
> value before the counter wraps to zero. It defaults to U64_MAX and can b=
e
> overridden by drivers in their probe function. Provide the getter
> timer_get_end_value() in the uclass.
>=20
> Also add get_ticks_end_value() returning the end value of the counter
> used by get_ticks(). Without CONFIG_TIMER the generic get_ticks() extend=
s
> the counter to 64 bits, so U64_MAX is returned. The function is weak to
> allow architectures overriding get_ticks() to report their end value.
>=20
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Changes since v2:
>=20
> - added this patch
>=20
>   drivers/timer/timer-uclass.c | 15 +++++++++++++--
>   include/time.h               |  7 +++++++
>   include/timer.h              | 10 ++++++++++
>   lib/time.c                   | 13 +++++++++++++
>   4 files changed, 43 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/timer/timer-uclass.c b/drivers/timer/timer-uclass.c
> index 8305f06d318..e784025884e 100644
> --- a/drivers/timer/timer-uclass.c
> +++ b/drivers/timer/timer-uclass.c
> @@ -27,7 +27,8 @@ DECLARE_GLOBAL_DATA_PTR;
>    * the input clock frequency of the timer. The get_count() method is u=
sed
>    * to get the current 64 bits count value. If the hardware is counting=
 down,
>    * the value should be inversed inside the method. There may be no rea=
l
> - * tick, and no timer interrupt.
> + * tick, and no timer interrupt. The end_value member of struct
> + * timer_dev_priv holds the last count value before the counter wraps.
>    */
>  =20
>   int notrace timer_get_count(struct udevice *dev, u64 *count)
> @@ -48,10 +49,20 @@ unsigned long notrace timer_get_rate(struct udevice =
*dev)
>   	return uc_priv->clock_rate;
>   }
>  =20
> +u64 notrace timer_get_end_value(struct udevice *dev)
> +{
> +	struct timer_dev_priv *uc_priv =3D dev_get_uclass_priv(dev);
> +
> +	return uc_priv->end_value;
> +}
> +
>   static int timer_pre_probe(struct udevice *dev)
>   {
> +	struct timer_dev_priv *uc_priv =3D dev_get_uclass_priv(dev);
> +
> +	uc_priv->end_value =3D U64_MAX;

The missing piece in this patch series is to actually set the end value=20
to the correct value for those drivers that don't support U64_MAX.

Most timer drivers that only have 32bit hardware counters use function=20
timer_conv_64() to create a 64 values. Some have implemented the same=20
logic internally.

drivers/timer/adi_sc5xx_timer.c - u64
drivers/timer/altera_timer.c - timer_conv_64
drivers/timer/andes_plmt_timer.c - u64
drivers/timer/arc_timer.c - timer_conv_64
drivers/timer/arm_global_timer.c u64
drivers/timer/arm_twd_timer.c - timer_conv_64
drivers/timer/ast_ibex_timer.c - u64
drivers/timer/ast_timer.c - u32
drivers/timer/atmel_pit_timer.c - timer_conv_64
drivers/timer/atmel_tcb_timer.c - u64
drivers/timer/cadence-ttc.c - u32
drivers/timer/dw-apb-timer.c - timer_conv_64
drivers/timer/goldfish_timer.c - u64
drivers/timer/gxp-timer.c - u64
drivers/timer/imx-gpt-timer.c - u64
drivers/timer/mchp-pit64b-timer.c - u64
drivers/timer/mpc83xx_timer.c - u64
drivers/timer/mtk_timer.c - timer_conv_64
drivers/timer/nomadik-mtu-timer.c - timer_conv_64
drivers/timer/npcm-timer.c - 0x61A800000000
drivers/timer/omap-timer.c - timer_conv_64
drivers/timer/orion-timer.c - timer_conv_64
drivers/timer/ostm_timer.c - timer_conv_64
drivers/timer/riscv_aclint_timer.c - u64
drivers/timer/riscv_timer.c - u64
drivers/timer/rockchip_timer.c - u64
drivers/timer/sandbox_timer.c - u64
drivers/timer/sp804_timer.c - u32
drivers/timer/starfive-timer.c - u32
drivers/timer/stm32_timer.c - u32
drivers/timer/tegra-timer.c - timer_conv_64
drivers/timer/tsc_timer.c - u64
drivers/timer/xilinx-timer.c - timer_conv_64

E.g. the StarFive VisionFive 2 has starfive-timer and supports 64bit=20
UEFI. So here your current series is providing the wrong value.

For all drivers marked as u32 and for the npcm-timer, please, update=20
end_value in the probe() method or better add the missing=20
timer_conv_64() invocation.

Best regards

Heinrich

> +
>   	if (CONFIG_IS_ENABLED(OF_REAL)) {
> -		struct timer_dev_priv *uc_priv =3D dev_get_uclass_priv(dev);
>   		struct clk timer_clk;
>   		int err;
>   		ulong ret;
> diff --git a/include/time.h b/include/time.h
> index f5b86bf70fe..5318346dcbd 100644
> --- a/include/time.h
> +++ b/include/time.h
> @@ -158,4 +158,11 @@ unsigned long timer_get_us(void);
>    */
>   uint64_t get_ticks(void);
>  =20
> +/**
> + * get_ticks_end_value() - Get the last tick value before the counter w=
raps
> + *
> + * Return: last value returned by get_ticks() before it wraps to zero
> + */
> +u64 get_ticks_end_value(void);
> +
>   #endif /* _TIME_H */
> diff --git a/include/timer.h b/include/timer.h
> index 091d8dfa228..e0e2e8bbf90 100644
> --- a/include/timer.h
> +++ b/include/timer.h
> @@ -62,6 +62,14 @@ int timer_get_count(struct udevice *dev, u64 *count);
>    */
>   unsigned long timer_get_rate(struct udevice *dev);
>  =20
> +/**
> + * timer_get_end_value() - Get the last count value before the timer wr=
aps
> + * @dev: The timer device
> + *
> + * Return: the last value returned by get_count() before it wraps to ze=
ro
> + */
> +u64 timer_get_end_value(struct udevice *dev);
> +
>   /**
>    * struct timer_ops - Driver model timer operations
>    *
> @@ -88,9 +96,11 @@ struct timer_ops {
>    * struct timer_dev_priv - information about a device used by the ucla=
ss
>    *
>    * @clock_rate: the timer input clock frequency in Hz
> + * @end_value: the last count value before the counter wraps to zero
>    */
>   struct timer_dev_priv {
>   	unsigned long clock_rate;
> +	u64 end_value;
>   };
>  =20
>   /**
> diff --git a/lib/time.c b/lib/time.c
> index 0e9b079f9cf..d9bce303e6d 100644
> --- a/lib/time.c
> +++ b/lib/time.c
> @@ -111,8 +111,21 @@ uint64_t notrace get_ticks(void)
>   	return count;
>   }
>  =20
> +u64 notrace get_ticks_end_value(void)
> +{
> +	if (!gd->timer)
> +		return U64_MAX;
> +
> +	return timer_get_end_value(gd->timer);
> +}
> +
>   #else /* !CONFIG_TIMER */
>  =20
> +u64 __weak notrace get_ticks_end_value(void)
> +{
> +	return U64_MAX;
> +}
> +
>   uint64_t __weak notrace get_ticks(void)
>   {
>   	unsigned long now =3D timer_read_counter();

