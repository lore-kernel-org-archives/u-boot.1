Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C0DC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 974BE8896C;
	Tue, 13 Aug 2024 06:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522604;
	bh=N9p/CDOT/XnbuL3ctWrLm4VUWHP35/O20/HLOJxuhqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=SxBHz35isZZSf8qNvjbJd2VkKWp6s3unarAJIRi5eZiZvEFZ53nHukg4DPeKKIyEY
	 MizlORVp9rAt56FMirSCbDcYR+pRvI9gCXML4JMSTEUEM8D61ZGlzldwGcExVkeoxi
	 W9AUUnyaiv3QfsyeDWp6a45sOW0+JBNsQUfi4c98GqZJ2J910D7HNuTPaZIUMtV2AQ
	 yw0bfDhzc8cvruD60pYRcQ36vdvMwC5pVeiUtyYQ8m0kX861DDKJq3OX+X4I6VWEh9
	 odb6fXHcNNJXUT90sGTsjJ+icT7ukfqJ7ujqIn4AUrE9PEtQHQY+m7ePuTL6fqulwR
	 n2t6jXEK2wzPg==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A3E858895A;
 Tue, 13 Aug 2024 06:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522603;
 bh=N9p/CDOT/XnbuL3ctWrLm4VUWHP35/O20/HLOJxuhqM=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=QzS9kQgTigNOz3ZSKm7q8v3PrFBzH0XdZrhC83Hqmm5nhIOLwL1irmnK3IlF/VXMZ
 vuhfjV4E0GFoxuhQ5CmIam/KJxOj/+XvdTcXGO5YdBvg7HO5aIF1ytL6OIZs/tj5+0
 QDczu78oLaGblUYXe0IPXZxgvHzTZdZp0GdyX8Ju2pXxtzc2SM4jtXoJSSsRhMuK/N
 HpVE9AhMdYdX+di1ust/4OaXudqeU/8sgQwsX4XZ+7VQQmYtLK+cYMM1Wx5nPeOBYy
 u1/Z0yBYGvYkgwwqirWKe/h8iM4Vq8JP+Axuf83mnNIgCG3NQP9FHJBcZm/biPdMh7
 3LYgDjSyugSnA==
Message-ID: <2f841d47-a074-30e3-fc1b-3626471acb7a@denx.de>
Date: Tue, 13 Aug 2024 06:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 16/18] i2c: Drop i2c_get_bus_num_fdt() and
 i2c_reset_port_fdt()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-17-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-17-sjg@chromium.org>
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

Hello Simon,

On 11.08.24 16:50, Simon Glass wrote:
> These functions are 11 years old and are only used by one board. Drop
> them.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   include/i2c.h | 18 ------------------
>   1 file changed, 18 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
