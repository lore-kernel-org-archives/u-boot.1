Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3113CC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 04:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA9258885D;
	Mon,  5 Aug 2024 06:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722833619;
	bh=JKFcTcGYgi2LMqxl3pLCS9NeNQbCCIx8xvV+Q3SaEKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=kbsQDWqpz1kc4Q8etb53U+1GMWFydQi9JSIP8PKvOYkQpAAI9nuRuBvLj5dvvnzHR
	 U7yMdUSx4Onn2iczib4bLyQPN08KVGyfYKzmauTTJprz+P0TLrXvSmleCs2btr8FF7
	 UkgOuUDxxdZAj2BkuP9q55VCVmB7Hye2J+h0ycoG6cnTbeuaCUM90+pm38xz+7qYZL
	 1LEAiI6jLW+KUeybJ2vmj/ejKXZpQzXCPkhJT2o4ATKCuucb5IL2kj0soDGQ3zACsH
	 8SeQlp6550Zha6vaDBvy8G/Gt8R3Si+ml24sz6CEgdqAWtGOuWYQQSCTHrjSNl2DBC
	 32K/sICMXLamQ==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6143088027;
 Mon,  5 Aug 2024 06:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722833616;
 bh=JKFcTcGYgi2LMqxl3pLCS9NeNQbCCIx8xvV+Q3SaEKE=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=TW+GFz1sIzTl2GxU0yiXSwLBOwP75prV+MRuVh9gc2g5U8NfjuSWilUCU4V8uWvq/
 cRcf6J8gAcgbbMsHKHioMB3g1U3lreBpfmXceIdH2alp9iJxHUQr7JLrFFUjGpfLIR
 thWHA/Y+pxCmGQPVK1DRQrKNMVT/smphZvA7EMQXGFL1ACI5X3xKIYUnKP3GI1aLmw
 DnR6+PBTNclNbuqoHXJ2EO43a98KdXipnDmbaQAR0HEeXnHBX/akyYYc8w+MtUULJA
 QPHqrFUeRnKTvymdINcTna0YpG2j6exAbWAEUo6+jNSiQXpfn6U3/ubJlecmYR16e2
 EhN+ytlfhe45Q==
Message-ID: <54ecf652-42ca-8982-8eee-ced124aee221@denx.de>
Date: Mon, 5 Aug 2024 06:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] i2c: samsung: Drop s3c24x0 specific code.
Content-Language: en-US
To: David Virag <virag.david003@gmail.com>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>, u-boot@lists.denx.de
References: <20240802191920.132133-1-virag.david003@gmail.com>
 <20240802191920.132133-2-virag.david003@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240802191920.132133-2-virag.david003@gmail.com>
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

Hello David,

On 02.08.24 21:19, David Virag wrote:
> This has been dead code for many years now. Remove it.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>   drivers/i2c/exynos_hs_i2c.c | 4 ----
>   drivers/i2c/s3c24x0_i2c.c   | 8 --------
>   2 files changed, 12 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
