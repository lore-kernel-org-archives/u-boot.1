Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772ECCAC587
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 20:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F371980B9B;
	Sat, 13 Sep 2025 22:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PgfftoQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BC082AE9; Sat, 13 Sep 2025 22:43:59 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4102809A5
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 22:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cPNYm0Rvnz9spD;
 Sat, 13 Sep 2025 22:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757796236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CH3BhHwrcuby0md/yyRJNvqmjQTD9M+vnaXXIlEw1Mo=;
 b=PgfftoQ4BDPMXK6eI/IWCUPDhqKbBiF9fobNGEkfS+EVxd2Ki67XoEsbCxNEaYxBDyKlJO
 f5Ua1dw6MC1HgewN1FD7PHHh/mnwIWAhBJSEmZQ0mWJb8muaD2uV4YolIhpV/ZkGsg+BfV
 ddklfNQSOmxB5kuH1xpBsVLvFKYCMHt/odf/OavyubPBRlQentv0nMYsG7ylBywi838hXf
 9O5JDbTK+Y5haOQWxiD5qui8MkH/7ERFFUN8OKlauwfLBZWO6fHOaM2z6fVOZS2QVF5Afj
 /AJZYpx1DU8Sm3tkUw1MpeVZ4Qa9Qb535bXJW/1JwiPgYWXKU76mjsYIUsimeg==
Message-ID: <b0bbed76-6388-40b1-8e3f-44f60880e4ab@mailbox.org>
Date: Sat, 13 Sep 2025 22:43:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/6] usb: gadget: bcm_udc_otg: Remove unused driver
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250911215404.3955132-1-trini@konsulko.com>
 <20250911215404.3955132-4-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250911215404.3955132-4-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2cfea760d034c042149
X-MBO-RS-META: thc5ueawngwo39umxfud1zs4odgk5rcu
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

On 9/11/25 11:50 PM, Tom Rini wrote:
> This driver is unused since the removal of the bcm28155_ap board in
> commit 0f6807e77b07 ("arm: Remove bcm28155_ap board"). Remove it.
> 
> Fixes: 0f6807e77b07 ("arm: Remove bcm28155_ap board")
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
