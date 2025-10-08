Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76CBCCA472
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758B083D77;
	Wed,  8 Oct 2025 15:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="bLbGCR0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C644683F6D; Wed,  8 Oct 2025 15:55:27 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9598C83C91
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1759931724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4kdW0j8LfTg3/6ZMEyqCTLeKN8L2vip3D9WboqmA3s=;
 b=bLbGCR0+nTux5t/OfvomDbPUbOgX0k+ynmvrqsOdaN+GbbMAYLAW+QgAnUhlvZyeyx2bJx
 9LRGezVQge/ba7D9huiyToGxhTzR9t/RLBTw+HndAgLULqo1Kqp9onzQU8sgfY2pJGP2uf
 MJWdJlqTdUAfHvf87YJEXkgc85IogCMXcSzur2N6vnZHB73gP9s+TfrxWq+KS75MD380/s
 uEjeEz3qmWPkK3FEfaAfY8UQFcki4VrdkGWYzVUMbzizAO/pJ9TX/CIIx7mws8SROR5Dh8
 G1IF2SN3LvEAKEaDF7VAp1G6RUeRmEn8Y62Xl0hlzNvWjkLcYQGLwV9vCLY2fg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 13:55:22 +0000
Message-Id: <DDCZQ7W6SBTB.11KBGFR01N96M@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH RFC v3 2/8] mmc: meson_gx_mmc: add minimal non-DM driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>, "Tom Rini" <trini@konsulko.com>, "Peng Fan"
 <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino
 Galvani" <b.galvani@gmail.com>
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
 <20251008-spl-gx-v3-2-5999637df4b9@postmarketos.org>
 <d6b85855-f55e-4699-875c-86cf0200011b@linaro.org>
In-Reply-To: <d6b85855-f55e-4699-875c-86cf0200011b@linaro.org>
X-Migadu-Flow: FLOW_OUT
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

On Wed Oct 8, 2025 at 1:33 PM UTC, Neil Armstrong wrote:
> <...>
>> @@ -67,7 +69,7 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>   	 * Other SoCs use CLK_CO_PHASE_180 by default.
>>   	 * It needs to find what is a proper value about each SoCs.
>>   	 */
>> -	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
>> +	if (IS_ENABLED(CONFIG_MESON_SM))
>
> I'm not a fan of that, technically while we keep the socs separated the
> driver should be generic and not rely on the soc config.
>
> I'k ok to have it in non-DM, but in DM it should still use meson_gx_mmc_i=
s_compatible().
>

I'll drop this for next revision then. Shouldn't change anything
anyway, given SPL uses non-DM.

Best regards,
Ferass
