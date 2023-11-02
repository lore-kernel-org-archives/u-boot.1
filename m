Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2772FC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F51877C5;
	Thu,  2 Nov 2023 15:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698934075;
	bh=qSZV3mUY1oNwl1e3kOpiIdt9dB3gdUpsihmVZMR6C1o=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DoNha0RBxytxWDjl4h9H3mTkzZPYKPtyTleAvbNKWKQp5uxN1LjlZbpMneHVLbbsu
	 gz/Y3fb7I8EN2BEXC/ZKGzLgLKT09aJeDpTr4/rIss90DbwacmytDE91BhHWmCTFyK
	 uKI4JILLutCw5P6yVPFVkNNMWTMoR/PAaJIBpOLojDXnhpjoHNql5WDPkYtovIHNQK
	 3sLEASL4nQp64bayJca6d3x0wPlV7RyP7qKhPn/GHK5XvZdQOXhgnluNtRdZqUshIz
	 f7MTYRGpnwsC+Al5HM9Rd80bCLL1GG/ELNHG3M7qIRcRB1RxrszfyVMWyCqSjXlLCK
	 mt8xBF2MjYB9Q==
Received: from [192.168.1.107] (82-131-157-32.pool.digikabel.hu
 [82.131.157.32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A6D19877BC;
 Thu,  2 Nov 2023 15:07:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698934074;
 bh=qSZV3mUY1oNwl1e3kOpiIdt9dB3gdUpsihmVZMR6C1o=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hqnFf5kOaVmmzotBCXxfeBivwrrAZMZWtuMpav+60sRMdxSjQSTxT1tEE9Vgb+DMP
 FvWo2SkmFEuTBDrjfBwXIZcxezIxtnPWSDsAZzkk8EU8cV+WY3zxLBJ4hxOk6xieKS
 7fdK7E6pFhQF51pKqee0u+FXHhdO+in/1AbrGoWHfPWGoMP6jUr6+mMF1KAoEfnP7M
 +cCmSuzSWML9NaNR+jd9VBuTLyCOWjmBENyu0eKfwHjN3InN76gARbsz8VIJb114FH
 yyBNSQelAY0AmFipxeFgTO7zI/ju1UcsWCeKAt5/wO7CWQgk+4f4IzfSEC0qpJDEp3
 fynWnnTH1RpQA==
Subject: Re: [PATCH v3 2/3] i2c: Implement i2c_get_chip_by_phandle()
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231031073844.15683-2-pro@denx.de>
 <20231031073844.15683-6-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <613a1e1e-e08a-178f-41a6-b47f23089fa2@denx.de>
Date: Thu, 2 Nov 2023 15:07:42 +0100
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

Applied to u-boot-i2c.git master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
