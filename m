Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF544CCF2CF
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B853360672;
	Sat, 17 Oct 2026 17:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yj5ZBIJNaUGo; Sat, 17 Oct 2026 17:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1119F60675
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258395;
	b=oCwJ/pZulnNwHktcWLOCSSorevRmymMzHuyCii/WJpTbvY+LaxTztMb4BG5EEYK01cuN
	 Dk6CnSZgeadIwSWeCpVoP30m3zrOMQqkyEooqXq+PV9PinXrU2j78q9zz/0kmMQA2xHQj
	 YIQabmbSIu4wNMQm2iOWvqqPE9KRdZXi/IDQwq9Brm4K3HOcXEz+w/aFwdBehrCYLrWC8
	 ctOeEZTRKp+ki9ku8RRuaJJQYRM3b4xCofLOGXDepy3KMrzuMu80HzEBStHl++G72+wGU
	 xgVL3q5GrmfnH4YvZsXT3rQ5OgmnYW4r1CSBEVKs5np4EkFmoA8HD2Ohs18GhDCeq/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VhMD9CX7gENjDxR5Bds8Hr1j82MAVGNei7LBLz3baAQ=;
	b=efRYc23RMDthx9uxKyPYvD6SmQvFhIuJ3Sdo/VJK1eIW3c67s48E5jNn566s9Vs4Rq1I
	 Pu2vGFXN4wRKO/L5W+5fqRoBaHuVQMO8LH+9XKX/r2UMT3zHtsyKKfv1oyn8gM+UnngUo
	 uafCzZWVnVG+rcvJolmvarC6B24TBznvILLyi1eE48F38cUUp0wInBXO3Wbd4IiiuptDl
	 P73iD5rVXLDZyIW80opx3iCYY3+WjNb7wkXVrj6pMoWP68TR0TVNgYaRhJyp0Pj0J9eli
	 v6jYr8i9bwpj1lPcKbFcI3xTX+KAr5HY4R3LP/2ux8m53LNXAkBI8NtcX//QC6e84yA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258395;
	bh=VhMD9CX7gENjDxR5Bds8Hr1j82MAVGNei7LBLz3baAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zGXqoy9LrUd4RFGNzqa/zRyFgZHidu/A92VC2H7lRURFAxOen50kq8RMMLEUDw1Hg
	 PyifmiF9DN/sQrq33jdi5j+FMjL+XIUNXumgdkzOgceqGLY/+nb2t8hJE19x/2XkDZ
	 +MD88yvXZ+3Ru0L3Y3apUe9Blxh33yV5fLZegbx3NTNhDFXc38SjC8ZmDVSwt+U0HG
	 PjbtS7YtPiRFXk7jRg6TnSslCxEjGBdsqzJtR+Qpmvdwuy0O+lgAoH3Ca4nodgXJT8
	 ii6cztlIKlZXQfdtabhyGleb/OxgGZgczMIKdh9VaGlrWcVjnp1rVuJWs7mtrD4b7U
	 IJ672tONl0HzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1119F60675;
	Sat, 17 Oct 2026 17:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BFCFA465
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A60B740846
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zimdEE-5WjrJ for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:33:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57BFB40845
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258386;
 b=daPvFaHLxW6rg1jdWmBmBe7kk2rme3JPh5UCUHsRDdMuS74Z9hYD/4BZtSvBGfzN7miZ
 +c6kHX6lxwSFisZWJ89A0kP4qOemabgfaVHkQlJPy6fW9bKEjXFegz7E5T5bSpbMFewg7
 Rxd7zL2U9pRRefMMlPsZweKrxbL52w7HQa/hW6lmZu5w/027iWKVCm8ZOiDYo8RrQ/xZ5
 JCrFKP4qBahZIRNO3fqtDhixr14FCayncqkYBW/rJ+7bFf5+PB+zicngJQHAvGREOfiaK
 e0y7HTXkCg/XJlEdi3g+cZJ3Yz5rWowSF4MPKIFaLEIj1Bdwqo26lv3F6rgOycNKYnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258386;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=VhMD9CX7gENjDxR5Bds8Hr1j82MAVGNei7LBLz3baAQ=;
 b=kq23Uj3waXs70BBnydbyttGiY2JlfiD5+eTejf+7Bh6TD8tegGa8Zm85CuS6JkbVoaDA
 aAGwVUsEEqg6MdNCGSKLtDP72ZIeg1VAEjDMQCj0rkFNaiuzFRtVPMaDILSxvZLmvhtHW
 4KClbWjK10QpMvaTgSfTiWF9FD6tvKbok3uuHBCDY7krZzn53Sdw2Ntlv83iNwJDmmWnO
 qO/G53tAN5BkPU8r+0qDSJjocKI3++AIuZKu5EDhFE0vZnWc9XisJeedchrWV1PC2WsQR
 L76Wfru3zCeZX3aPjO/YFvibn6vg3rho3hTO3xS78oeZ2NShzdV7qIZlW3hz75HP1qQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=bqYP32V2; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=bqYP32V2
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57BFB40845
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:05 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j6TRL3fD5zKp3y;
 Sat, 17 Oct 2026 19:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhMD9CX7gENjDxR5Bds8Hr1j82MAVGNei7LBLz3baAQ=;
 b=bqYP32V2twAA1RQQ+PMEtys06KUtasvYizupaqiMvOZT+wRcYv4nVRFTXk2x1iDXLaZrKV
 03XIZq50iSeQR5hQmY8ikCWEdsByaJ/cFtsXpOCRraGuFO1rwOOiXvrRhT/1JKRINcqATX
 KP002BqW7vbDVxolsMpD6f1diz5BfLIh+wfCLLl0Dsr19ceHoF7/ngrhWMvC/ISTPUyRl6
 hmniadRa/UFj6gSkG9/oCLgaKr1ChKztA1Tt6+J1IBZN9ffzPaHdS9Kx4JTEATfOJpC4Dc
 zYGUTzPWT74v3eUJf9Iyau8kVPkcu0EotnKZEVY/0xPktMTJSvU+CgcqErRmCQ==
Message-ID: <283d1b1c-16de-4ff0-a57e-a54b4239b118@mailbox.org>
Date: Sat, 17 Oct 2026 13:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/26] usb: phy: add the usb_phy helpers needed by the
 resynced DWC3 code
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@denx.de, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-4-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260916123826.517181-4-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 048314d7b610de0162c
X-MBO-RS-META: zt3esxgmkjd3nhbs5d14zkx3as4pfu5t
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/16/26 2:38 PM, Anders Roxell wrote:

[...]

> +static inline int
> +usb_phy_init(struct usb_phy *x)
> +{

Please call the phy variable a phy, not x .

> +	if (x && x->init)
> +		return x->init(x);
> +
> +	return 0;
> +}
> +
> +static inline void
> +usb_phy_shutdown(struct usb_phy *x)
> +{
> +	if (x && x->shutdown)
> +		x->shutdown(x);
> +}
> +
> +static inline int
> +usb_phy_set_power(struct usb_phy *x, unsigned int mA)
> +{
> +	if (!x)
> +		return 0;
> +
> +	/* TODO usb_phy_set_charger_current(x, mA); */
> +
> +	if (x->set_power)
> +		return x->set_power(x, mA);
> +
> +	return 0;
> +}
> +
> +static inline int
> +usb_phy_set_suspend(struct usb_phy *x, int suspend)
> +{
> +	return 0;
> +}
>   #endif /* __LINUX_USB_PHY_H */


-- 
Best regards,
Marek Vasut
