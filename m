Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722BCCCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 04:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED2E8386B;
	Thu,  9 Oct 2025 06:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="DhFCnfdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABF68386D; Thu,  9 Oct 2025 06:11:52 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C7683869
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 06:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 80586100210; Thu,  9 Oct 2025 06:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759983110;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=mhCzetlfqLsZXfj2yOwaZ7xgPPi/7VmHYzdPmqAqg9o=;
 b=DhFCnfdIyPp4zFvnzOFNeM5b4tBZf61C7FafwXMR46+tY45JIw+2KopmSqcdhg0E06LLUQ
 GC8JBUV64BEIe9gVhCLhHuS9coYZlNT2M9sbZtWEjOJu30GghuSkPZbCBXd1qzWO7DplLK
 TMtmDbGF4A0hBb18VyFu/vUauetp39RZCwZzCF4mKP+5+TJfEoO56IOIA0zSobdiJQWSze
 BgWV8LlquZdXlVtuiUrFiDuGFn78BSComw2fOvpdShOIbmMOwAvZBsKzU4EPpOIIcohAWB
 z91157KzmUFAu3DMVMMmiPGkZJEuUwDn2ES+DLLZZ4hT55CeYNO+f5/TNgxIuA==
Message-ID: <b17aec83-faac-b2ff-3166-5d765c59cd1c@nabladev.com>
Date: Thu, 9 Oct 2025 06:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND PATCH] drivers/mtd/ubispl/ubispl.c: limit copy size
Content-Language: en-US
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Tom Rini <trini@konsulko.com>, John Ogness <john.ogness@linutronix.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20250917091417.545-1-b.spranger@linutronix.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20250917091417.545-1-b.spranger@linutronix.de>
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

Hello Benedikt,

On 17.09.25 11:14, Benedikt Spranger wrote:
> The fastmap VID header is embedded in struct ubi_scan_info. During fastmap
> scan, the header is copied into struct ubi_scan_info, if valid. The former
> code mixed up the amount of copied bytes and copied more bytes than
> nessesary. This had no side effect, since the affected struct members are
> uninitialized at that point and overwritten later.
> 
> Limit the copied bytes to the VID header size.
> 
> Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
> Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/mtd/ubispl/ubispl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

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
