Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FE0E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 18:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3F780511;
	Tue, 31 Dec 2024 19:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735668800;
	bh=6bH6hRa8B8UY7++PWZWqA/Z2DEtk1PjDCJJfdHPl85s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cFL256ZKGg7W/roMNqk4mow5TI/ZMf1JWLwiw2svN2/vfF9V2CN/sOs8LxwIG4I5D
	 eTZTBSQ/ZqLA0DzRSJUuSO7h/OjrUqYCKhhU+sniJZ9FGXfQDw5sGi/UNe8JeJfj4Y
	 pkoXVhHFS3otDdweU4Gwu1wba6RaOhUNDZvThf7yMNRzlFHgPmWVM4C6WsGBieERTT
	 zamVvwl2V9OA6dArtPKbsVff7UcxvFadFVhMYeNZuhS9YjfY5X1anAv8vQcHUTX4zq
	 lquhat9Dob9yZgUhTHVANDmvwBYByzagSAaoJIwh/IezmcsGspn4PT3AQ2Xx1nxbON
	 cZgffTDWgD5IA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEAE9803CE; Tue, 31 Dec 2024 19:13:18 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C2DD8039B
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 19:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="GWLk7nq6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DEFFC10486D91; Tue, 31 Dec 2024 19:13:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735668795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bH6hRa8B8UY7++PWZWqA/Z2DEtk1PjDCJJfdHPl85s=;
 b=GWLk7nq66GHBCwTeBNWthxHgfUBP2EQiYcWOJwzUKcKW+qgiyPOMsMFZAgronVVSgQ3lTM
 4yyvFXMMPaXsIPbvJNqi1g2s5B5c4QvgbyiCfR4pSaUPHQ4FMrGwME8WrFyrWOPmMep+Ky
 MJJK70PuS46WZ10IfmCBvwXWY7QRYczSJTGLh9DatQ0jQXdqQQ31BTWPQ/rr2syntELtTi
 HnCzcEweMD/3UrJkeqOuRmDGwvj8n3N/8nMQuSdJHXOzzxERbddFReZs2W+hHbHdenUF09
 kQJEoFQpKtTSZdoliYJKQhlIpPTyLBo4kQSqkr6pjN18qEX44l8JGj9sJSBm8g==
Message-ID: <6c650cc7-8403-4d4f-b5b5-b4816bafd187@denx.de>
Date: Tue, 31 Dec 2024 19:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] usb: dwc2: Extract register definitions to common
 header file
To: liujh2818@outlook.com, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-1-12cd9b8a2358@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241230-dwc2-dev-v2-1-12cd9b8a2358@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> The same registers are accessed in both the otg and gatet drivers of
> dwc2, and these registers are repeatedly defined in these two parts.
> Extract register definitions into a common header file to reduce
> redundancy and make the code more maintainable.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Junhui Liu <liujh2818@outlook.com>
Reviewed-by: Marek Vasut <marex@denx.de>
