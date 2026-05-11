Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9A9CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 11:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B66E801A9;
	Mon, 11 May 2026 13:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NrudFXRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D72E8341A; Mon, 11 May 2026 13:38:10 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C078800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gDd5B58CZz9tjP;
 Mon, 11 May 2026 13:38:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778499486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ps0ZxpqbQmilVqu4s3w+VcCJLIsmrCbhrSiH1EyVeIE=;
 b=NrudFXRf61Cc73CBEqyKv5KOUS2VvYQUk5Vh0zwt5XQYT/ujPBksoW2qzLI++sumVGUeXZ
 rxAxJ2i//PlXX/DNUulZedwcLMamrkXRNKxjV3cuMpjTNdycEmj2wGSBHOY57DRVzEUy2E
 c3DjI5BHefv+8oxXMj06KqJAbsNDE9ROETxIlo8ZKreFwqk37hDcuzUiAp2/W9zX4NOE/f
 u+ZXOE9noCFttS5dGe/yx4u1HHm8IhLUNLLIrv3LB7HcTlsRZgNez9dC9ubhSHF+s3fCux
 CYPwhTao2BjRGwcNVGOAu4z4v7njfve1Lhsd2i1UlP1K8ydAmG4uR9i105RbuA==
Message-ID: <144800b3-e8d0-4b60-843c-c844e98f56a0@mailbox.org>
Date: Mon, 11 May 2026 13:38:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: gadget: f_acm: Fix memory leak in acm_add
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
References: <BESP194MB2805271AD5DBE47B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <BESP194MB2805271AD5DBE47B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: sorjeearhhfg6qk35dqez6tk7wf1x7yo
X-MBO-RS-ID: 94e21adb64214c863bf
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

On 5/9/26 7:22 PM, Francois Berder wrote:
> If udc_device_get_by_index fails, the f_acm struct was not released.
> Free it before returning the error.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Thank you
