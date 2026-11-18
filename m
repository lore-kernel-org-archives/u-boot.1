Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05241606A330
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bq1g6ayq;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iQbYHzVx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C256860883;
	Wed, 18 Nov 2026 08:55:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FOFMluimYZS; Wed, 18 Nov 2026 08:55:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A2186084B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794992118;
	b=SPY9oCUcnCZuR5m7WLglKLe61LHfpPmbJazcM/9xn/CC4kACbfYq9oYPg2/JHriwLfwY
	 is9xSO2FjGY7cgsjjlgy67qaDIq51oDvWku4/uP8KUVbLqTGHcc7n9Q8xbxQvySYamU4l
	 +ebLUGQ/XuQX0O8eGyGJw9ahgzxq1baM3cYUksoTBxOqPCG8PniunV8OJWt8eecsuaLTe
	 xqYWWXmKJgcyWXplHE/4xix4dNYv86BhMsnFxUl85l+iqDkulFKXaage9g62kUlFQMhhH
	 VglXzdKd0UZhfn2t7spQRRYTdp01Fi/qfv/gdYCvAl8MrUuNoOOhCkS8e/bSB4Q4Muw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794992118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RO+PWHPODxyUmLhbyjZ8ddb6OP4/1o+eYjk+Ao4vwq8=;
	b=li84wE81jGIKUtT+TVVa69StYm/X6Pmp1VDyH4Czk6o8M2331MbZ5U81nw+BkKpsL1mB
	 5i0uxWXcW1tzsLsV/Rb5uIe3Md+yKJ7UuVQbM7WW+/zgpmRG/lAUo2q3QPeLvwqCBSId+
	 i9QYOS7TQAHZf3U9BdKSXeVimMGLeLKHU4BG1ZVCRF5uznrrFPhl6TRcaV4uvkaWLaeHT
	 PTxoyqBUTyQ4dWARo9rxYcTBy5Is6HG7u9ZMGizIvr0US5seuN0KKO8f+Coq5VoefF0L+
	 mN6lCemITmfi6Mw7lR7kK8n7dW6ncRSoHfXXPeEMvSMae3CFZACJqqMuZG5Rr3IVPWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794992118;
	bh=RO+PWHPODxyUmLhbyjZ8ddb6OP4/1o+eYjk+Ao4vwq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bq1g6ayqbV9bBBU8UYojplj0JphXE9FXhUPyGyL7VVQZCHhX1JC/1BkWA6d7afxPz
	 LQp1LtARgMfn0Zu7Lay2Az2nQ459O8xxh4NPSWDHCU/MOoakIENdzMlv9sPQjnvvh7
	 +4//17O6pUI/BG5sGJ24YcWzCYRH35vfX2GJr1MNFURo59wkXEiHWQ+aX4rJZu3z0h
	 wQmZNpvbplzwp/tFlcDNVjAWmH1u1mgkA2QvBiRcrGKZ0jQNScycHlpxJe9+xUB5WY
	 cfDwz/2RHAQ0nbFYCqc299sSzbB7J9bqqRiDoKM4ERhMKvj2fuvVVODOGxdZ+Zgdse
	 jQCFlKNPftxog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A2186084B;
	Wed, 18 Nov 2026 08:55:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 87F1D61
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E86E400BD
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ece297GR_3oj for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 08:55:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3B1B240060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iQbYHzVx
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B1B240060
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:55:15 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67c58f18765so442046d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794992114; x=1795596914;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RO+PWHPODxyUmLhbyjZ8ddb6OP4/1o+eYjk+Ao4vwq8=;
 b=iQbYHzVxsymuBrEUNm2TLvr/HcByQpKFEiKgG149sp5njzBFWDFPMq7bNCSKsE5S7R
 IfCyqC8IPLSnnG1ti0t4xIFSp3o5nb0aEd/komHq+5ySwTzHpc7shSFuY/1jAhKRxHyk
 uG4ntUzETKZNvorOQezBvTzDCjsugOOoVxn1DfVo/Lxp4Xg1umMjdIGB91HqMnWpZm/o
 vxZ6zu8ll0GiYAaheLXeZpxD8I56f5JiYt7IFlz0vKChJP+hp7UbBy6cdo5PX6LOfj7X
 Ur8/H8ud1gOS8cqdaJr5iMnIHVurrlHsRcfz2Lof8YnsLSvpBSOK4yyE2CXoAY2B0fYJ
 dbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794992114; x=1795596914;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RO+PWHPODxyUmLhbyjZ8ddb6OP4/1o+eYjk+Ao4vwq8=;
 b=hOrfn4VqZc8soxWXE6LJo6qlQpSuilwyp1UNVAIuPOWggXtwUMSIy2tWO86xPXuwGQ
 hnYPiwqtFNE2kuQxRxQkYl87MClYKtBzIueaVRTJ4tWUST5iB/G7JyFOxbOuPF9pi7HN
 aIdVXKp0me8Kck7pb4mrIfg3pxHI/m4qDyA9M7COnOhnsMHM4MP11VtZuqTTHSMuNTME
 E2r+tYZC7+OqxlTCuvixAUd8rEl6yX7qIcBQV2dXu0xZNXRaMUW1EX6ZYM1JJbt6QNUD
 nl5b2JdOi6BMEpL50XKvVza/RatRWAW0W+YpXQe9UJsPzbNJxnxCJ9o/AP5TGqMc6c+v
 e0Hw==
X-Gm-Message-State: APuU4Z8p99qizbvL5aZiY2LwZRVdzT1faN7iL8dI5I32COZEEUewjQ0K
 CMsD0F+xQznCmfs+AVpdvWPLiuc75aiKpO6bNU2iXjKnb/Fa8bzdUoA6FZJ2qUHxbQ6DJxpm2Sa
 Uvd2I0RxkBV27J1oBWavKHl5KaedzlswQRVdxM6bAug==
X-Gm-Gg: AZFdTZdJyIjtPWEOwDGGg0QeNbSMyEMAiEgPaQ4YxfdiIGq+g8KhKnD/QQBWCU9xP6Z
 MnAO4Bqmi4HEyAtvj3TzKD4pmmg1N6qEWzKDXhJp4SG9Bho10kAWJvcPjgb7WCcYjuJZkhcpjua
 WAvNonbFub60hmbOsMfz8kWVBYxdRKJaWtXh6X4bhTWXvVc5YROAcRTkEL70wW2bfIrOvuOiHZK
 /cBX0geq9Ew7hN3YOSdmrBhBcEJM4rVVr8xewgf9h2J4hxHBz5kZJ1NT/Vphmh3kwa533N+//B+
 HeQ4qYzDcwZLm/yrE4h9RQ7YJJrdcm+1eSObRGB6XEh6QNBPNooiDfFKJCjJtreSHtCF/HPsW6b
 HzaLrOoR7r1Kpl+y3OZ01EPcohF/Pbqw6j6rcpkbKHiACk7BGtaqWVOD6ivybemZ9YqyHEBUnYR
 A5e9d91cIlpSkF+RNMvGtuRI9dNnfowxxe3OZ2+89la91DLc1erDhe960c99Coey5MyUxufXppI
 v8op2PrCdNI0R/38e/tj4jz6GwK2dz8q3efhMDkkpCSeyFSkc8Z1SGzHLCyiVDzSe0ZLKZ9OHAU
 mGY4QYvpnfp6Mu4TBpvI+sL3+qdNudCBROiAvIUsqQeFQo5PuJtY/2uaLZZEjDiz4X9E3t/lN3N
 cuwUgq/8YHaUe6SVHmkVgv01YlS6Lq9iRxi4vbBcnM2hr1bvqT00uoRKLlGcuXm9klAdxzDF62I
 uaIU3r5Y6wH6XzbXKChxY/JEK3H/sEvIndN8Vze4vBors8g/LhmiH/BVYzOG9qkTC+QL5grV8=
X-Received: by 2002:a53:c603:0:b0:67b:fe08:465d with SMTP id
 956f58d0204a3-67dd403e5d0mr575366d50.106.1794992114490; Wed, 18 Nov 2026
 00:55:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116174416.3488353-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261116174416.3488353-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Nov 2026 10:54:38 +0200
X-Gm-Features: AclHuK9VRhpOg0TbVCu2TONnUIxFFZ07WqaEuSh-4C9vnwyzbXWABChXxaV-vWk
Message-ID: <CAC_iWjKtAEJLK=uvcEb=t5zn8y1FoG0yOEN0HiLUiQW9yDu1pg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 19:44, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/tpm/tpm2_tis_core.c | 22 +++++++++++-----------
>  drivers/tpm/tpm2_tis_i2c.c  |  2 +-
>  drivers/tpm/tpm2_tis_mmio.c |  2 +-
>  drivers/tpm/tpm2_tis_spi.c  |  2 +-
>  drivers/tpm/tpm_tis.h       |  4 ++--
>  5 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/tpm/tpm2_tis_core.c b/drivers/tpm/tpm2_tis_core.c
> index 1fdf8cfa319..0a2201df19c 100644
> --- a/drivers/tpm/tpm2_tis_core.c
> +++ b/drivers/tpm/tpm2_tis_core.c
> @@ -37,7 +37,7 @@ int tpm_tis_get_desc(struct udevice *dev, char *buf, int size)
>  static bool tpm_tis_check_locality(struct udevice *dev, int loc)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> -       struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
>         u8 locality;
>
>         phy_ops->read_bytes(dev, TPM_ACCESS(loc), 1, &locality);
> @@ -62,7 +62,7 @@ static bool tpm_tis_check_locality(struct udevice *dev, int loc)
>  int tpm_tis_request_locality(struct udevice *dev, int loc)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> -       struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
>         u8 buf = TPM_ACCESS_REQUEST_USE;
>         unsigned long start, stop;
>
> @@ -92,7 +92,7 @@ int tpm_tis_request_locality(struct udevice *dev, int loc)
>  static int tpm_tis_status(struct udevice *dev, u8 *status)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> -       struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
>
>         if (chip->locality < 0)
>                 return -EINVAL;
> @@ -118,7 +118,7 @@ static int tpm_tis_status(struct udevice *dev, u8 *status)
>  int tpm_tis_release_locality(struct udevice *dev, int loc)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> -       struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
>         u8 buf = TPM_ACCESS_ACTIVE_LOCALITY;
>         int ret;
>
> @@ -172,7 +172,7 @@ static int tpm_tis_wait_for_stat(struct udevice *dev, u8 mask,
>  static int tpm_tis_get_burstcount(struct udevice *dev, size_t *burstcount)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> -       struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
>         unsigned long start, stop;
>         u32 burst;
>
> @@ -208,7 +208,7 @@ static int tpm_tis_get_burstcount(struct udevice *dev, size_t *burstcount)
>  static int tpm_tis_ready(struct udevice *dev)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> -       struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
>         u8 data = TPM_STS_COMMAND_READY;
>
>         /* This will cancel any pending commands */
> @@ -218,7 +218,7 @@ static int tpm_tis_ready(struct udevice *dev)
>  int tpm_tis_send(struct udevice *dev, const u8 *buf, size_t len)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> -       struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
>         size_t burstcnt, wr_size, sent = 0;
>         u8 data = TPM_STS_GO;
>         u8 status;
> @@ -301,7 +301,7 @@ release_locality:
>  static int tpm_tis_recv_data(struct udevice *dev, u8 *buf, size_t count)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> -       struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
>         int size = 0, len, ret;
>         size_t burstcnt;
>         u8 status;
> @@ -403,14 +403,14 @@ int tpm_tis_open(struct udevice *dev)
>         return ret;
>  }
>
> -void tpm_tis_ops_register(struct udevice *dev, struct tpm_tis_phy_ops *ops)
> +void tpm_tis_ops_register(struct udevice *dev, const struct tpm_tis_phy_ops *ops)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
>
>         chip->phy_ops = ops;
>  }
>
> -static bool tis_check_ops(struct tpm_tis_phy_ops *phy_ops)
> +static bool tis_check_ops(const struct tpm_tis_phy_ops *phy_ops)
>  {
>         if (!phy_ops || !phy_ops->read_bytes || !phy_ops->write_bytes ||
>             !phy_ops->read32 || !phy_ops->write32)
> @@ -444,7 +444,7 @@ static int tpm_tis_wait_init(struct udevice *dev, int loc)
>  int tpm_tis_init(struct udevice *dev)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> -       struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
>         int ret;
>         u32 tmp;
>
> diff --git a/drivers/tpm/tpm2_tis_i2c.c b/drivers/tpm/tpm2_tis_i2c.c
> index 93efccc7757..a358014ea2a 100644
> --- a/drivers/tpm/tpm2_tis_i2c.c
> +++ b/drivers/tpm/tpm2_tis_i2c.c
> @@ -92,7 +92,7 @@ static int tpm_tis_i2c_write32(struct udevice *dev, u32 addr, u32 value)
>         return tpm_tis_i2c_write(dev, addr, sizeof(value), (u8 *)&value_le);
>  }
>
> -static struct tpm_tis_phy_ops phy_ops = {
> +static const struct tpm_tis_phy_ops phy_ops = {
>         .read_bytes = tpm_tis_i2c_read,
>         .write_bytes = tpm_tis_i2c_write,
>         .read32 = tpm_tis_i2c_read32,
> diff --git a/drivers/tpm/tpm2_tis_mmio.c b/drivers/tpm/tpm2_tis_mmio.c
> index fc62dcda9ef..679abcc107c 100644
> --- a/drivers/tpm/tpm2_tis_mmio.c
> +++ b/drivers/tpm/tpm2_tis_mmio.c
> @@ -70,7 +70,7 @@ static int mmio_write32(struct udevice *dev, u32 addr, u32 value)
>         return 0;
>  }
>
> -static struct tpm_tis_phy_ops phy_ops = {
> +static const struct tpm_tis_phy_ops phy_ops = {
>         .read_bytes = mmio_read_bytes,
>         .write_bytes = mmio_write_bytes,
>         .read32 = mmio_read32,
> diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> index c433e8088ac..3ca2d6f6b12 100644
> --- a/drivers/tpm/tpm2_tis_spi.c
> +++ b/drivers/tpm/tpm2_tis_spi.c
> @@ -187,7 +187,7 @@ static int tpm_tis_spi_write32(struct udevice *dev, u32 addr, u32 value)
>         return tpm_tis_spi_write(dev, addr, sizeof(value), (u8 *)&value_le);
>  }
>
> -static struct tpm_tis_phy_ops phy_ops = {
> +static const struct tpm_tis_phy_ops phy_ops = {
>         .read_bytes = tpm_tis_spi_read,
>         .write_bytes = tpm_tis_spi_write,
>         .read32 = tpm_tis_spi_read32,
> diff --git a/drivers/tpm/tpm_tis.h b/drivers/tpm/tpm_tis.h
> index 93f622f2910..32d4f9200ed 100644
> --- a/drivers/tpm/tpm_tis.h
> +++ b/drivers/tpm/tpm_tis.h
> @@ -110,7 +110,7 @@ struct tpm_chip {
>         u8 rid;
>         unsigned long timeout_a, timeout_b, timeout_c, timeout_d;  /* msec */
>         ulong chip_type;
> -       struct tpm_tis_phy_ops *phy_ops;
> +       const struct tpm_tis_phy_ops *phy_ops;
>  };
>
>  struct tpm_input_header {
> @@ -265,5 +265,5 @@ int tpm_tis_init(struct udevice *udev);
>   * @dev: TPM device
>   * @ops: tpm_tis_phy_ops ops for the device
>   */
> -void tpm_tis_ops_register(struct udevice *udev, struct tpm_tis_phy_ops *ops);
> +void tpm_tis_ops_register(struct udevice *udev, const struct tpm_tis_phy_ops *ops);
>  #endif
> --
> 2.53.0
>
