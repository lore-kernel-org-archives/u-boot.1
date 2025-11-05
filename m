Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5BFCCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 05:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7416883968;
	Wed,  5 Nov 2025 06:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="QGt/Fq8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9897B83A2F; Wed,  5 Nov 2025 06:53:27 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE50C835B3
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 06:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 61CA6108E16; Wed,  5 Nov 2025 06:53:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762322005;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=VemKHlU4cK9fTTrTSDjXn7CPZBMz1EntANDPJrzHlys=;
 b=QGt/Fq8EisurYhR1ppzsUgNKXbe4oIjvGk1YNt0CVxuqEAdem0aza5LmJR7TQCAQe9qGso
 14pJmMFbUhlQIR4upGXDyxw9/7OF4ohFfIAAma8mAFoElJ3gzmIvblEF3kS3xtNXYzLG0s
 SfPESzRpcjDm7pVR3F6sVQwBw9OLjoAtAYRPJlwpvKvOXfi9YWPOD4gOO/9+O6JeotwEKq
 RNjC/W5qwlYlJxOsC3qJwX3bzFFCyJVDH6y1VpNo9dxECsuGYf7jhQuNdl9YRFGSd0WMJ7
 7u1TzS4RTQZg6P6adTkr858bEf5T4CFXfz7HcEZzzYJliQmPBPv+fHm4+YZXLg==
Message-ID: <8454d5ff-d8df-fda2-8e2a-de989efe6cc6@nabladev.com>
Date: Wed, 5 Nov 2025 06:53:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 3/3] test: gpio: add test for gpio-line-names lookup
Content-Language: en-US
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>
References: <20251104174458.3385564-1-ravi@prevas.dk>
 <20251104174458.3385564-4-ravi@prevas.dk>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251104174458.3385564-4-ravi@prevas.dk>
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

Hello Rasmus,

On 04.11.25 18:44, Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>   arch/sandbox/dts/test.dts |  2 ++
>   test/dm/gpio.c            | 11 +++++++++++
>   2 files changed, 13 insertions(+)

A commit message would be nice.

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
