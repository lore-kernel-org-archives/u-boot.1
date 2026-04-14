Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA745F9D0F6
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 22:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E5A838BB;
	Wed, 15 Apr 2026 00:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tnhD3QiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F0183936; Wed, 15 Apr 2026 00:19:01 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0240C80086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 00:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fwJb559cHz9tV5;
 Wed, 15 Apr 2026 00:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776205137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YInW/7AypNhHUKR4N8KVGnZuJlPfR91lqkQ2oy897VY=;
 b=tnhD3QiIs3xlA7uav1QvbD3EZ/2/JUWIv1CkL90G/JX/B+dJiKkPvGuaVQ1mlhSXJ5SAQ+
 s90j06HGilxFSuNhdvkNsG8eTchqeeHN4PcDfJt/Ely4+fTAPqNKkD6AeoIyeK9D3WFwgH
 TCehqGT2NnmU8/v9BBKBRppjvlbHIdmpRXzhyUO07Bs7iRjbY4FPXhVN5zFUvkF2aBnp1q
 cfEkTuSTUZUO+hBSGYiJIAVPjMxgf8nttZukm/+nVfXpx22T2MS5oafc4usdxEFABtn7WE
 RdbUrI7Fq5gsdepgY7KwVKtZ1fXU68Br6Tp0ua9VpHkwxw2j6yz67dIGILE3Mg==
Message-ID: <a0bb44a6-1805-4c0c-b7a5-0d9d31f9d6b7@mailbox.org>
Date: Wed, 15 Apr 2026 00:18:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] misc: Add RZG2L OTP support
To: Mathieu Othacehe <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20260414091422.16952-1-othacehe@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260414091422.16952-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 33d3b454d65bec4293e
X-MBO-RS-META: it74q3cynkkoy1espz6dh5otaea6ky88
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

On 4/14/26 11:14 AM, Mathieu Othacehe wrote:

[...]

> +/*
> + * XXX: To enable direct fusing through U-Boot, the trusted-firmware must
> + * allow the non-secure world to perform fusing operations. This is controlled
> + * by the SYS_SLVACCCTL7 register.

Is there some SMC call to perform the fusing via TFA ?

> + */
> +#define RZG2L_OTP_BASE      0x11860000
> +#define RZG2L_SYSC_BASE     0x11020000

Can this be parsed out of DT ?

> +#define RZ_SYS_BASE_DEVID   (RZG2L_SYSC_BASE + 0x0A04)
> +#define RZ_OTP_BASE_DEVID   (RZG2L_OTP_BASE + 0x1178)
> +#define RZ_OTP_BASE_CHIPID  (RZG2L_OTP_BASE + 0x1140)
> +
> +#define RZ_OTP_PWR          (RZG2L_OTP_BASE + 0x0000)
> +#define RZ_OTP_STR          (RZG2L_OTP_BASE + 0x0004)
> +#define RZ_OTP_STAWR        (RZG2L_OTP_BASE + 0x0008)
> +#define RZ_OTP_ADRWR        (RZG2L_OTP_BASE + 0x000c)
> +#define RZ_OTP_DATAWR       (RZG2L_OTP_BASE + 0x0010)
> +
> +#define RZ_OTP_ADRRD        (RZG2L_OTP_BASE + 0x0014)
> +#define RZ_OTP_DATARD       (RZG2L_OTP_BASE + 0x0018)
> +
> +#define RZ_OTP_FLAG         (RZG2L_OTP_BASE + 0x001c)
> +
> +#define OTP_PWR		    BIT(0)
> +#define ERR_WR_1	    BIT(1)
> +#define ERR_WR_2	    BIT(2)
> +#define ERR_WP		    BIT(3)
> +#define OTP_ACCL	    BIT(4)
> +#define ERR_RDY_WR	    BIT(8)
> +#define OTP_DUMMY_READ	    (0x400 >> 2)

What does 0x400 >> 2 mean ?

> +static int rzg2l_otp_open(void)
> +{
> +	int i = 0;
> +
> +	if (readl(RZ_OTP_PWR) & 1) {

What does this magic value 1 mean ? Please add macro for it.

> +		debug("OTP already powered up\n");
> +		return 0;
> +	}
> +
> +	while ((readl(RZ_OTP_STR) & 1) ||
> +	       ((readl(RZ_OTP_FLAG) & 1) == 0)) {

read_poll_*() .

> +		if (i++ > 1000) {
> +			printf("OTP power-up timeout\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		mdelay(1);
> +	}
> +
> +	writel(readl(RZ_OTP_PWR) | OTP_PWR | OTP_ACCL, RZ_OTP_PWR);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_otp_dummy_read(void)
> +{
> +	int i = 0;
> +
> +	while ((readl(RZ_OTP_STR) & 1) == 0) {

readl_poll_*()

> +		if (i++ > 1000) {
> +			printf("Timeout polling ready for OTP read\n");
> +			return -ETIMEDOUT;
> +		}
> +		mdelay(1);
> +	}
> +
> +	writel(RZG2L_OTP_BASE + OTP_DUMMY_READ, RZ_OTP_ADRRD);
> +	readl(RZ_OTP_DATARD);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_otp_close(void)
> +{
> +	int i = 0;
> +	u32 val;
> +
> +	rzg2l_otp_dummy_read();
> +
> +	val = readl(RZ_OTP_PWR);
> +	val = val & OTP_PWR & OTP_ACCL;
> +	writel(val, RZ_OTP_PWR);

clrsetbits_le32()

> +	while (readl(RZ_OTP_STR) & 1) {

readl_poll ...

[...]
