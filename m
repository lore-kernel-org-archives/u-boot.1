Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18314C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 08:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A1228334D;
	Mon, 11 Aug 2025 10:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754899494;
	bh=F3vCVxz9VPA7QR6qjnxW9zNpDsUewGboSwcvL5upM7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s2iLqNeo7Gw3Gc3vovXwd2FRrq15qcZ9HzCKoAVRQfQWmqn4hIbHVLydIv4pKGJMS
	 xwmJ16apthb9I196ischVpqg10IRAZ6qFUkLJl+BXHuW1JF7q8HQfzQ1dTMSIJNPGl
	 KM+uNaA5g12HopZbi+GbpdG2GPXrGU346un7ITz9/nAHIpUYvqMWK+UdmULGJYWx5i
	 uFvwdQHb4h8S61bUsUz5UMWtdLYk4nQLWX7lB2WqFGOYeoDyDiBHIjnABOA5mpY9KG
	 8P8z1JXGr2feyk08e1/9BDl4hPIax81XaxRoBGjDNrk81xvu3ppWuJ2RkuZmPd6rzB
	 jMHR8zMQ5/otw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B4BF8338B; Mon, 11 Aug 2025 10:04:53 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE0F83322
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 10:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="IRdBTG8u"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA70C1038C11C; 
 Mon, 11 Aug 2025 10:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754899490; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=F3vCVxz9VPA7QR6qjnxW9zNpDsUewGboSwcvL5upM7Y=;
 b=IRdBTG8uMBIbuVv8vIeRiGvEKjAG+Fkgh+ymyXDOvMkHhY1XGQGvb1wThievSQH4MIwi7e
 VGPSGhkBg6GH0DN5rv5MN2cGFYOWQygqmXiBCCeMNEnvjMfSK4g2Jk0M+R5DpFohvFZyev
 y68TNRRq9p1dqprDdRbsoX9wNOGYv6iQTeiNZ6GiR/m3iZGrKL1obT1yGcHbCSz6Neu8kH
 iXSqZkGJpfNvGV4Lj5LV2rHGvuqxJBD+EyKVpREhVkqgegbMzsJtM9DM+lE6ubSwi/78PI
 TIdn3EMpXI3eC06G2E2yEB8IE5ivMGJH/Ayzyeajyh6pO0n5/+DhDh8RxT7jKA==
Date: Mon, 11 Aug 2025 10:04:48 +0200
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v6 0/4] Add Onion Omega2/2+ board support
Message-ID: <aJmkIGM0wXfGV1Oq@antares>
References: <20250807075653.356088-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075653.356088-1-pro@denx.de>
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

On Thu, Aug 07, 2025 at 09:56:49AM +0200, Philip Oberfichtner wrote:
> Add support for the MediaTek based boards by Onion. Commit one to three are
> rather generic, whereas the last commit adds the actual board support.

Please don't pull any of this board support series before my "Simplify
image size checks" series [1].

I inadvertently made the two series cross-dependent. I'll make the
separation more clear in the next versions.

Best regards,
Philip

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=468251&archive=both&state=*
