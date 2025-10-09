Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB343CCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 04:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A568386B;
	Thu,  9 Oct 2025 06:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="DbIJcGE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C7B8386B; Thu,  9 Oct 2025 06:13:10 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4466083A8D
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 06:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D11AF1031CC; Thu,  9 Oct 2025 06:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759983187;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=kpw7n9/88o8UaS/8Cwgef3e24VDXMvwcuSEE775Ehwo=;
 b=DbIJcGE6FvYQfDjcva0mXbhczdozeSBbCmIqvGFGC/M/42fryDSX7cRu95gq22nMDz8JUO
 vTPGjaPs3vZsQuVsHuHiYHyWzImk7mHJ4RGrz8bOqYxXyQUSLPjUYJ6MFrFu4jiP6swB7M
 gcHhioZdA9QPUvN69N2XtpgcOvjZkPhj70mNhseLM45OH3mlC4NE1+5zLp6f5dIwPu841M
 nqMJrQPgZNKDeerspmj6PqHEuQ3UGshiZcpmAXQeWEnF8RGfvymiJ1y5jygwA+Hmg4BQxA
 JKcQPgv6IGpUqPCSkAQHG2ps3rqXZ7bkv/JxBy/P5l0owahQOmBw7wS/Q7RLJQ==
Message-ID: <670f49e7-2a11-6d43-e26a-45db97894073@nabladev.com>
Date: Thu, 9 Oct 2025 06:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ubi: extend support for LED activity
Content-Language: en-US
To: yegorslists@googlemail.com
Cc: trini@konsulko.com, sjg@chromium.org, ansuelsmth@gmail.com,
 u-boot@lists.denx.de
References: <20251002113550.2803053-1-yegorslists@googlemail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251002113550.2803053-1-yegorslists@googlemail.com>
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

Hello Yegor,

On 02.10.25 13:35, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Add LED activity for ubi_dev_scan() and ubi_volume_read() routines.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>   cmd/ubi.c | 4 ++++
>   1 file changed, 4 insertions(+)

Applied to u-boot-ubi

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
