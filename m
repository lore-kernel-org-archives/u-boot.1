Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26579CCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 10:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330938409C;
	Tue,  7 Oct 2025 12:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ilx2mvnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55E81840A2; Tue,  7 Oct 2025 12:15:20 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C0B8409B
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 12:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joaomarcos.costa@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A15044E40F4C;
 Tue,  7 Oct 2025 10:15:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 74DAD606EB;
 Tue,  7 Oct 2025 10:15:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 276E4102F2121; 
 Tue,  7 Oct 2025 12:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759832116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sqCWzw0qQXrOqZT2GXBKXkeLW9f6j6mPKL9V0KgQOaI=;
 b=ilx2mvnpaU5RNl7c3sAXwL2Gpf9gBsbL5wHSnijZNaFQ960m6Hues2T1HX3pSPzVSZVq3u
 phBEippszao0gIe/pXgPQ52oz9s84WZe+sfR+o8M2cOHWq2aVp4tUHn8/JT6W3iZ/zBuWu
 /ldeds8IekJgVZrrQWoizpZw9O/WFTxy45UlEAL+5xjvMQq9wDFYc4aXNw7PdSHD6GO8af
 wNJLuxvTvhyavGed4GTF+03DpIh+oQK4sbb6EJ7OLKETvdoMFm12xhtJbzisdr0BNnbLb3
 J096iNqdG4C7Ecr2/kroa9drsBd3XzNul4T+LdhOVUa1L1PUWI3O2t9kI+8iEQ==
Message-ID: <ba744b2c-336b-48f7-9296-9bea67ee7428@bootlin.com>
Date: Tue, 7 Oct 2025 12:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/squashfs: Ensure memory is freed by using unwind goto
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
Cc: Joao Marcos Costa <jmcosta944@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251002-fs_squashfs-v1-1-d72e624dd056@linaro.org>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <20251002-fs_squashfs-v1-1-d72e624dd056@linaro.org>
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

Hello, Andrew

On 10/2/25 12:36, Andrew Goodbody wrote:
> Returning immediately from sqfs_read_nest is not consistent with other
> error checks in this function and can lead to memory leaks. Instead use
> the unwind goto used elsewhere to ensure that the memory is freed.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---

Thanks for this fix!

Reviewed-by: Joao Marcos Costa <joaomarcos.costa@bootlin.com>

-- 
Best regards,
João Marcos Costa
