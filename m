Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1683DC25B47
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 03:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3373487AD7;
	Thu, 26 Oct 2023 05:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698291815;
	bh=bbBoAb8Y8Yj19VTyQ6qgbNjw6fddbbHms4g04mTjRKU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=at+CzGtwMByo0rLOIYQ5Pj0DV18SJkc4S8oHwRwG1CCmGkB19AdS0wD1zLXoT+0XD
	 HUwCsEtdeM4947nfHTpVBueWIIazMZ7Jk+cVDHKKYegFk7fg3oeBNrV9J4xl6JdE1V
	 2ugUs5zKZChXaYH88+74C1dinuh2ZGpXypLZQ7K1SDfWMSnqDgQX2fckV0bss2r7kK
	 5j7Eot4a5OBxlNKafYPKmfDUOVSV4Q7ppqcUf9884Ca8A9u24ubs+PlLLhs3uLzaDx
	 A/lobG5QfAwa5dzxGOO30weGt8ONumzBtWph3Yd2tyNY+zC8MQ9Rn+H4W5sRGqxuP9
	 3y/XohOJjPryQ==
Received: from [192.168.1.107] (fibhost-66-250-177.fibernet.hu [85.66.250.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D399087ACD;
 Thu, 26 Oct 2023 05:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698291814;
 bh=bbBoAb8Y8Yj19VTyQ6qgbNjw6fddbbHms4g04mTjRKU=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fw+sLdXsa4Xi/0ieRWQrbZRXWySorr2bX/23pqh4uIcrmQd0kn36AzrsxZgmrfhl3
 aOxLQGv+e+lH17ZpCL0KuCxpC2wp25FC6qTQMInbxWveZIDf9Prnm791Yu66IA1slI
 O7tZy7T912LWCcbuoV+32H36OQJxlpIhCcaKxBJAB/mhJLFo4wbxHIaM8gmPd1rxWO
 /xwbPKa0i59ZU+JDa/KxwL3wRXfdXcHRgLLvQ4rTi+BZybjtpCWqQo81bIO/B6K452
 fB0z2/YnLIOfbmarCkPttxsbEWG9yA+Tej4MYwhwd4IM+GTtpbHc9h6iPqdg1Os4D2
 OOObFkcu9qt9A==
Subject: Re: [PATCH v2 2/3] i2c: Implement i2c_get_chip_by_phandle()
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231020090227.16634-1-pro@denx.de>
 <20231020090227.16634-3-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <5ca2bd83-26bd-15eb-ae0a-edb1a06d156b@denx.de>
Date: Thu, 26 Oct 2023 05:43:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231020090227.16634-3-pro@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hello Philip,

On 20.10.23 11:02, Philip Richard Oberfichtner wrote:
> This new function enhances the i2c_get_chip*() toolbox by implementing a
> variant that does not require a chip_addr. Instead, the desired device
> is pointed to by a phandle.
> 
> Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
> ---
> 
> Changes in v2: new
> 
>  drivers/i2c/i2c-uclass.c | 75 ++++++++++++++++++++++++++++++++++++++++
>  include/i2c.h            | 12 +++++++
>  2 files changed, 87 insertions(+)

Looks good to me, thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
