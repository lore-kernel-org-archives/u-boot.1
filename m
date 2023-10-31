Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F266EC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673C687527;
	Tue, 31 Oct 2023 09:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698739654;
	bh=J+rlrOp3ooYIKGiHfquMFLdjwUE9CpowIJyZ8F0qMAQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=TtOw5NnAsyB9MSTpcZ4IZ/ySQ+tKYggU3gQl6FksKpa5BQciNxft1HnaIo7WrMkEb
	 YRV4wOk02l6og32CE0j+qaKynR+9YbXgqe18rrUcFUmTbTiMxSlYOqP3CHiEV6Q142
	 wbsRzd7k1RNBZft+OPZl591sSioUO9Eudg3w8vOG6qfX3N6l3lq+Mv0D8UsAcd+KdP
	 SEHcYuvzai5lYK2/fKKgDtXb2AG07Is1Brwp4ElmrX+0ORdf8AVjnqtk0oA7vRGopb
	 oBrgyC25sws9Hm2ACcpJKuGqOAA97wT1aDussZbZNUCgOku9v1+5afv61LnyJhSQYZ
	 CAeHIVMgoRTEw==
Received: from [192.168.1.107] (82-131-157-32.pool.digikabel.hu
 [82.131.157.32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6C040874B0;
 Tue, 31 Oct 2023 09:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698739653;
 bh=J+rlrOp3ooYIKGiHfquMFLdjwUE9CpowIJyZ8F0qMAQ=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=zz3FKZ0PW3vRkaQLwBMqwuHm9Feh03VWPHONtjKYsnwk5w6YdMNK5CNNne8wLaCxk
 ScJSYq1WWADy/nzfc9VMvp5XUG6xwsrbFajw8IxWM+7rMiv3ZX1jmGIJA4ljTYfbPX
 QjRtjr6ijT4Y/u0YIsxxQZf7BUjSVF08+GRJEdsTu1nHmY/97yD0JgdpOwJzOe06iU
 ftvS23HsyP6Lp7fWG9vMwWpRL2BlgqEzFZJYUKb8C9OmcqhwFctPPzrTB/UiPO0VI+
 elWf8BnmPvsPptnPOnEu0rAeFf/Kb31PAQBeXXEQl/Jmuu4BQHci6soexW+aNSwivT
 YCCwU6UPHjL6g==
Subject: Re: [PATCH v3 2/3] i2c: Implement i2c_get_chip_by_phandle()
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231031073844.15683-2-pro@denx.de>
 <20231031073844.15683-6-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <77f4b708-f266-2c4e-8384-a070547c6e4f@denx.de>
Date: Tue, 31 Oct 2023 09:07:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231031073844.15683-6-pro@denx.de>
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

On 31.10.23 08:38, Philip Richard Oberfichtner wrote:
> This new function enhances the i2c_get_chip*() toolbox by implementing a
> variant that does not require a chip_addr. Instead, the desired device
> is pointed to by a phandle.
> 
> Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
> ---
> 
> Notes:
>     Changes in v3: none
>     Changes in v2: new
> 
>  drivers/i2c/i2c-uclass.c | 75 ++++++++++++++++++++++++++++++++++++++++
>  include/i2c.h            | 12 +++++++
>  2 files changed, 87 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
