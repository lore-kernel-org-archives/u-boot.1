Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD69CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 10:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D362A83FEC;
	Wed, 10 Jun 2026 12:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="EoMHBCkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C67884701; Wed, 10 Jun 2026 12:24:32 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAEF807C4
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1996111763F; Wed, 10 Jun 2026 12:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781087069;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=PcEdL7E/fMmU4G2TK0etv5ReO/BlDlJd4H8+r6LraXQ=;
 b=EoMHBCkzY4xxI90Cae7lcHwFBHq7ZI5cupZ5d5NANXto5JlX74gTclBRiuqNmRQnK0CQIl
 0wuT05+1r2VuWsuibOMD5WxQFXK2cpPJz1ouiVOdxG9ZTKzcna/Lp1qZ0gH4sCoFsl0YM5
 0b8uvQq6nGsZ7B2JpmeQii/RFvkoSH1uqUXkMPhDREDh/+8kkLR2aQmY+8uTbhQfAfhauj
 4iZht4n8z/KyMr53IAdX8VyvpgOsneGbULvhMqP+FCCFdxmkNoJ/uMqJ8wuZUJcVSPdw/K
 XEjp2M7Tr/SsBFKWfGY0MY2chrrXVzUDFMzx3ei8rkkpMBI1HvLhHVuQxreioA==
Message-ID: <34c964a1-8afc-2aa1-50b7-a6e58f9f0c60@nabladev.com>
Date: Wed, 10 Jun 2026 12:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] i2c: geni: reset controller on NACK to recover from
 invalid bus state
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, u-boot@lists.denx.de
References: <20260602064322.2409171-1-aswin.murugan@oss.qualcomm.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260602064322.2409171-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Aswin,

On 02.06.26 08:43, Aswin Murugan wrote:
> During i2c probe, repeated accesses to non-existent slave addresses
> generate consecutive NACK responses. On GENI I2C controllers, these
> back-to-back error conditions leaves the controller in an invalid
> or busy state, especially at lower bus frequencies (100 kHz and
> 400 kHz). As a result, subsequent transfers fails and valid slave
> addresses are not detected.
> 
> Currently, controller recovery is triggered only on timeout errors.
> However, NACK conditions (-EREMOTEIO) can lead to the same stale bus
> state.
> 
> Handle -EREMOTEIO similar to -ETIMEDOUT by issuing a command abort
> before starting the next transfer. This ensures the controller state
> machine is reset and the bus is returned to a known good state.
> 
> This improves reliability of i2c probe and allows correct detection
> of slave devices under repeated probing conditions.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/i2c/geni_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
