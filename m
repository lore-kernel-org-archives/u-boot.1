Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62EDC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 21:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630558186D;
	Mon, 27 Jan 2025 22:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738015118;
	bh=jW7QIYLdmM0Al63Bg7A6a1tj8yzE8bGLRIM1GhbEUlo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIMh83ypK8jodolcnDabOK9R1vKDF61ZB6NVaukjvz2gpHEFAWWD2QH+J2h5KoUgq
	 g37kPfPISlO2sJBokgnU0X0MolE4aj/m3KBLWhKgGYZo35wS3KZ2NcL61CBjebBm0V
	 r5qX/AxeGZs0LYo03pgtnXa409solWnqXW0RPBe4aQlrSpoDguwVr9X4HjgVDcJe6m
	 MXI82aPyUHS9pFm/glJZwojNrlDn1ZLMRb+FEbPepyZEUGtpL/kUXLbk3/VP3nsdUi
	 OppYxrRXAeQfNr//8aPXDzgTIn2SeHNTKBAF6nNMHTVt1dBJUk25g1r6jxsdWgUyn4
	 mZzWDqzYonKXQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC2F812BB; Mon, 27 Jan 2025 22:58:36 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64BEC817A5
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 22:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="cTQ/fou2"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 33E8D103802C0; Mon, 27 Jan 2025 22:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738015113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jW7QIYLdmM0Al63Bg7A6a1tj8yzE8bGLRIM1GhbEUlo=;
 b=cTQ/fou2BcMFKyb0Xi2XAP39UcatTzHCxvipRxmQaE4kJo9FP4dB3RLlaZO3rYZaaC9xY+
 MjA9g0/alSkOFE4PrPXa9z9rbdbOI4DV4eOgp3QY5zMyJH+g2YCk3GLEA665dYyAgj9D8a
 pr31kDATKFmoVrMjk1qdpR9pfCAC4Mim9S2ouSoeZh6twlBYUH92oxRLHSKD6FT+9uO5dl
 h7hs7WfWv9aajJOCS2y5z1iHCJwba4nMyyoptNve1Vw2F85sKLWe8iIgnr79b1Ov/BLiPI
 jF9zj+5pEi/zocYYGgiWvU9NIe4GJvQ0TKMYUicvzGnQrWxw7uwbu22gru27Zg==
Message-ID: <10f183b5-8f40-4908-9865-46365b7f21db@denx.de>
Date: Mon, 27 Jan 2025 22:56:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] usb: cdns: starfive: Get dr mode from wrapper
 device dts node
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
 <20250123010112.78924-5-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250123010112.78924-5-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/23/25 2:01 AM, Minda Chen wrote:
> Cdns core driver also get dr mode from wrapper devcie dts node
> to make it is same with Starfive cdns USB Linux kernel driver,
> Starfive 7110 OF_UPSTREAM is enabled
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
