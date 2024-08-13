Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD9AC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB638895A;
	Tue, 13 Aug 2024 06:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522823;
	bh=Nd6y2KpzOjeo3kHBhCbQddqgiOjyi98fxhZFVTydSlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xYsDAENt8Agehz2n6Kdm5HoyTSqQ+9wO6k0u5jN+4BvysF4EsqARnqObDW5+aQzdu
	 r28xxio9kS8Bdbe5LjqG3E9gYik2WrsFJ6A4rU3yaz8HGeukceAl1BOdIKQKlSDSfl
	 dmgV7z2jRK/i5XNIleyTSeJhA5dMkcRL3+g7Y1vXOsg0atxX4OaqrgXLqPYDfQFmdC
	 abx21HEP/ikyBkMLDaQrAPnUbnhhTbTAS56GW2DW4mYGHrKwWQpaHsHwvvIsthmsrG
	 DRR4CKWPuwuFy7nEkYNyPIphbo02F4VYzmrNQcQs0MttedsXD/l6xEdimOQgZNk4PF
	 hHc8Natglt9eA==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2FEFE8657F;
 Tue, 13 Aug 2024 06:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522822;
 bh=Nd6y2KpzOjeo3kHBhCbQddqgiOjyi98fxhZFVTydSlk=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=fdCgiRASdeDVafOOdIvRS8qjD8zM1PU/es9uT223x6R9mo/geDZxBLKND+ZBjgmQB
 fZUyyISqphGtlYvKKE+N3hWXJ/arXtjWeAfXTAwFQwFfPU3YPNc83v9r5zsc1R5k2w
 w6cmeWnZr9ENwqO6YALeD08Q1d+oZNTDNsDyzWolZdiVvaoQKZ+bm8176nrrH+QGIf
 mZaZB284qAuV9yGd2lltN1h5NrKIfYWkVVoYw0cxAxCzLxiFx1GvsvhVjV9UXjGhie
 H5siYJUxleF5cX/FFNrtn3pULNujHhXlVP02XyjbKGQS767VRnxdw5qyOPwh7Z5Im1
 FyO6jTbhwNkrw==
Message-ID: <b073215b-c8ef-bcc2-a5e8-181ca0a47031@denx.de>
Date: Tue, 13 Aug 2024 06:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 17/18] i2c: Remove CFG_SYS_I2C_MAX_HOPS
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-18-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-18-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Simon.

On 11.08.24 16:50, Simon Glass wrote:
> Now that this is always 0, remove it and the associated dead code.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   README                 | 10 +---------
>   cmd/i2c.c              | 23 -----------------------
>   drivers/i2c/i2c_core.c | 37 -------------------------------------
>   include/i2c.h          |  7 -------
>   4 files changed, 1 insertion(+), 76 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
