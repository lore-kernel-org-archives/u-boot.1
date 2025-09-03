Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9121CA1007
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 01:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FBD83AE4;
	Wed,  3 Sep 2025 03:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RVbhl+6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5604D83285; Wed,  3 Sep 2025 03:51:01 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C0E83390
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 03:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cGlv535Stz9skn;
 Wed,  3 Sep 2025 03:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756864257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ne6dvLtwJwVUvhFRxiVfdn7H+RCohR0jRFqAv6t7slA=;
 b=RVbhl+6qDUxnMvVaZNcmVCYZAY7dFYLqNLdJoSzgymA2E9/Y1irYiwvFMqbGPslR/3ERLu
 LPgn5HxQK8GfiW52Ys4DcK1oBSVmOBLHpTzqp/YzXB3CyWWHLoE6v2PLFs9hMCUi7aOCxv
 pwa60Gayfy7GCUfQQdOEA3LewD8N2j1xLl07+N4f0JUN+5KVvXWZQP/vHlLYlBuPFlr/Mp
 bYC7bgAvxdcS/mwLb6AewW7g2T4IoGsX5tjWq67kCcGyAFAs7auco821kJmOLHNIFF5WGy
 97vctk5Gbvv2dvjWn3koeTtqJxnSK/IjdNYt+mUDhBVQ9zqt4Z8C1q+9htHdBA==
Message-ID: <fe7fc7e5-c328-44c0-85ef-ed78c3c8c76e@mailbox.org>
Date: Wed, 3 Sep 2025 03:48:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 5/7] usb: host: Tighten USB host driver dependencies
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250806145601.1664563-1-trini@konsulko.com>
 <20250806145601.1664563-5-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250806145601.1664563-5-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5ji4jbuftn1yowk1w8qcx95awhka95wo
X-MBO-RS-ID: 93a9a86e6166d001b81
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

On 8/6/25 4:55 PM, Tom Rini wrote:
> A few of the USB host drivers cannot build without access to some
> platform specific header files. Express those requirements in Kconfig as
> well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
