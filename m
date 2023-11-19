Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30789C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9735F871DF;
	Sun, 19 Nov 2023 21:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XepBZMPD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vJTczgGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17956871DF; Sun, 19 Nov 2023 21:15:43 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A408A8749D
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SYMMc1w4Vz9sSm;
 Sun, 19 Nov 2023 21:15:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700424940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKBl7S4z1uK4giKs2olqHMpe5EhSIHT76eFWHDorj78=;
 b=XepBZMPD+V0SUyiqOCgYK0Uw7t07gTcsGHeB/PsnfBJn2dphAAMhxzCt+JQlAaqjWKBohJ
 VYwsV97ekbBpUHdPv4dgYul4rO4LCQlHOet3h2q40t9uDCCTPit2qWEfa8cewz5hffxipS
 rvitqD31sbUY6M2oFi12Xc9yDoiQRI/hb20PcOk4Bpn5FYDQajwXDghVNeoU0Ldu++HW71
 D98bX2b1AJjqQR7Mhf0f7PiXuZwAdhyngwKtJSedlvCXxftAQ1+fjpxJFkRPF6lojR1pYn
 kwBSoiU/ksPvL/J2+QY6Xiji1yjIlvXuvbhgeNs+6cIKPAFUndCdpTEkxz2bFA==
Message-ID: <90feb671-d939-4dbf-9a49-418fc9a56b23@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700424938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKBl7S4z1uK4giKs2olqHMpe5EhSIHT76eFWHDorj78=;
 b=vJTczgGq5Z9Ryt5LqbBrFwfhkbbVWshmzqSWo3WQOaaXBoGVEjsXhtde5y1QITNIkxiP59
 iaFfXHjZ+Qb8ncfUxrdyEgSZvy+sfiUAlZJsgJWqS2RhferfkGp+wT2J79Ee1tgRKDVvxu
 c75IdOf/rC5+HFPs1DLU4pvQcYYGVh699glHjWwYD0CkT1ud96S/Irbke/dxfug3JXos/p
 YT0M3avOU82pf0YtiKDeQbioiunS3gZ+TtGu/ANEKtCK5JF25sDEXToK3ceTkcNiAKK/+p
 PGXbkPPbj8AtSRzmNN8LRvJ+Xnh7mSfXbhy5BH2ay04+E84Nxtql+hOVBLprmw==
Date: Sun, 19 Nov 2023 21:15:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] i2c: rzg2l: Add I2C driver for RZ/G2L family
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Heiko Schocher <hs@denx.de>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
 <20231115174025.12974-4-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231115174025.12974-4-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ojadoh6zoh1epwf1sc97rc7dzi5s45qa
X-MBO-RS-ID: ec383eb0a31262bf0e8
X-Rspamd-Queue-Id: 4SYMMc1w4Vz9sSm
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

On 11/15/23 18:40, Paul Barker wrote:
> This driver supports the I2C module on the Renesas RZ/G2L (R9A07G044)
> SoC, also known as the RIIC module.
> 
> This patch is based on both the u-boot driver in the Renesas RZ BSP
> 3.0.5 release [1] (commit 7fcc1fdc2534), and the Linux v6.6 driver
> (commit ffc253263a13).
> 
> Support for deblocking the I2C bus is included as this may be needed
> after triggering a reset via the Power Management IC (PMIC) over I2C
> (the PMIC asserts the reset line before the SoC completes the I2C write
> transaction with obvious bus locking effects). If the SDA line is
> observed to be low during initialisation, we automatically attempt to
> deblock.
> 
> [1]: https://github.com/renesas-rz/renesas-u-boot-cip
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

The driver seems very similar to drivers/i2c/rcar_iic.c , can there be 
some code reuse ?
