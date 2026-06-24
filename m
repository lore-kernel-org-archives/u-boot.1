Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6E7CDB481
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 14:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6840E8460E;
	Wed, 24 Jun 2026 16:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BbyYS/FX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF46846E1; Wed, 24 Jun 2026 16:18:17 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB61A80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 16:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B96D9115034; Wed, 24 Jun 2026 16:18:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782310694;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=XybosXxkI8C6prTyIFBsD7AYxpuSmo0xE8TQyHcLSX8=;
 b=BbyYS/FXWXqcMkaZM9Pjo9lu6XeqHieJOYaaA/FuyOKsni3gg8TvkiguGjQcSIY1uitMVl
 GjXAWMymhC8xPVv0Ej4T7wThSFz9i4uhI4fcfgCbVwCJIgu1YmHzqjqaW2+Jh78D5d30CJ
 Heicg4oMN1QCc3XHm0c/mA+i8fIpqOk4UeI6TJT7aPggPdbhR02JnAaHo1hei5SvtTd4yP
 0+0Eu27FqxpUsJ71PeXnUavkaySTxAP81RdzKNsuS3iFrSNVNCSMYKycg3cGDDyB/sfo4L
 1QXN0HLkez4ebKnktZfaSgWd5ObaX/vZpNaeIAR1/nuXc0iCGLUcvlU1j1D76w==
Message-ID: <d42f8d52-3be0-c079-e012-30d226e81a26@nabladev.com>
Date: Wed, 24 Jun 2026 16:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] crypto: fsl: Hide CAAM_64BIT symbol behind FSL_CAAM
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
References: <20260621024038.404454-1-marek.vasut+renesas@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260621024038.404454-1-marek.vasut+renesas@mailbox.org>
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

Hello Marek,

On 21.06.26 04:40, Marek Vasut wrote:
> Make CAAM_64BIT selectable only in case FSL_CAAM is selected,
> otherwise CAAM_64BIT shows up in configs of unrelated platforms.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/crypto/fsl/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
