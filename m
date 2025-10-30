Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA3CCCF9EB
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 03:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0F5835B3;
	Thu, 30 Oct 2025 04:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iYSKbqlE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rMEvaycp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 936F083655; Thu, 30 Oct 2025 04:08:03 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D98E832BC
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 04:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cxpvh5SD4z9ss7;
 Thu, 30 Oct 2025 04:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761793680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dMaAFuTfYTe55QIOH4T1RE5Z02uuuqHceAzSGop7hU=;
 b=iYSKbqlEH069sVdF4NlnYX7c23c51X6DIrezopCgpRtTB1aCHt7lbceHkqPjIbWNk1sk1J
 iZe+7EuDHPMnJv3muQLoTc/aE4nbL2c4dCM+UlHqubpUKEIukQZLvxqr+T+X+WpzRi/uoq
 33YHDh7fIdp8po7m7nUzfcEQlmhnJD8OR5xu1BDPmqSsJrIu3o8t091LPT9jtS4MV9D/hR
 ICFr6frf0ftEvJgA9aSZpujulZZa+0W8SRu/sDtse1iQtPd4i7R4fe/HWQD6lwe8JpFr3/
 1odXRedNLVXuapZeuV8EAcV32sBrv3mDv20MasvnnPBcVQOdiTTdx33BoIjbkg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=rMEvaycp;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <cc1ab3c4-eba3-46e1-b6f0-08b78676aa6c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761793678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dMaAFuTfYTe55QIOH4T1RE5Z02uuuqHceAzSGop7hU=;
 b=rMEvaycpuL0nVC3D3RDyvKZcDH4B7keES8LDuIXlwSzEXpwnbiFj1sRiUuOCVGIXxR83Ih
 0zqjV5JuzJFT4ns4zo2oiNj0+DED3DRVbY/RTFUfoGNtTiOVIfCiB3wEQCMmn3f7fUghhc
 pKkCEV/AECYQouhnJ3WvPAM1DhV5gul22zZofuRFw7SioQ4vfOCFtqePd21QZl+To9f0YE
 YjtlHrKsS6lzQ97Yr4D3hwz/4h7en0ryEA+rZpn1M4EnN5pIENLXX5yXLO4E3EplevYJxy
 UtJk3uiWB1Ywr65hU/rPVxGB2LRf813fDc4gHDgaS6RVtdEoBLloVJwCg5JOHQ==
Date: Thu, 30 Oct 2025 03:21:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] net: phy: aquantia: use generic firmware loader
To: Weijie Gao <weijie.gao@mediatek.com>, Beiyan Yun <root@infi.wang>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20251014121318.453701-1-root@infi.wang>
 <20251014121318.453701-5-root@infi.wang>
 <b0e62d688e281cc9b8144db23b10a143b977f523.camel@mediatek.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b0e62d688e281cc9b8144db23b10a143b977f523.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: smumjfiih6391ygf4ur5ektkkd4yhq8g
X-MBO-RS-ID: 9a05ad500d12c5c454e
X-Rspamd-Queue-Id: 4cxpvh5SD4z9ss7
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

On 10/15/25 2:43 AM, Weijie Gao wrote:

Hello everyone,

>> -#if defined(CONFIG_PHY_AQUANTIA_UPLOAD_FW)
>> -static int aquantia_read_fw(u8 **fw_addr, size_t *fw_length)
> 
> I think it's better to add a weak function, e.g.:
> int __weak aquantia_read_fw(u8 **fw_addr, size_t *fw_length);
> 
> And put the default fw loading logic into this function.
> Overriding this function by board allows using firmware data embedded
> into u-boot by binman.
> 
> It's useful in case that firmware data was damaged in filesystem.
Is the firmware GPL that is embedded into U-Boot GPL too ?

Be mindful of the licensing implications here.
