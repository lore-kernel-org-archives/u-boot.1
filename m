Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11673C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCEB987CA5;
	Sun, 29 Oct 2023 16:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592191;
	bh=oiOePTZJk3mjOwFmtuBFh/I/NLzO9/6Xx/K68VXUxnA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cWHDD4orKVq21LZ8+TwxgXfMN2SMxQnMiIpt/PJtUb3DygkDLBjdtj7UdlRXcgVPu
	 BxJaHSNkrtkCk7kAnTcNqCO5qppT1uyNSVQYn9wdiYUWGX7gMJpOdGnB6zJVskM8zJ
	 3n31+kBlPUIiQRRWJ2+pNmiMmMz0AZCWv84OcjGze95qid9tC2QCpNrpkCcrvDlPu/
	 4FdW84WcYZ/xNGGlZuAW0GQycCOVgK6OjLv+lNRQj/LfCnScMV8nQU0MnFu5PJ6KQj
	 N7iJuxOK7nSISabxcoUi/HwZsAN/qpx5pYAxGK7Ox7zFLo/qtrzvAG0Ox+2UtHTDzS
	 8YwK7FWTSjY9A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6554087970;
 Sun, 29 Oct 2023 16:09:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592184;
 bh=oiOePTZJk3mjOwFmtuBFh/I/NLzO9/6Xx/K68VXUxnA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WwqSXI9H/CsUdabu0gkzBEDTwjl8jwkkaJ+wPJC1vSeTT1iBKTn0Z7hZhee6c2pTR
 +JRqt3YRs2QcQ/7KxLCGtlCGb+OXHbWmwBsrYL38J9I2gC8JDQ7AYeW6E2QIgzNxAI
 3kU9venrwGL2E0iYfU5Q3YhAZEHEfeT9TdYf2DvSk4xkB8QistbFNF1OJ2krjK/2Wb
 ldQp2SsRfjL17NczaeuCl//eVEqOaPH6SEXXAshw31RFtoYR1hOk50PGlLpNoVEeq0
 DRMkFSwVNYd/KHR52kIrA4z0vlr1id8TDvTFDGBQ9QYtI+kR51SVNARK33CHs5MCs/
 4+2O/XQhksc+g==
Message-ID: <1ccd86f8-619a-4a63-bcde-4d05bb3cf334@denx.de>
Date: Sun, 29 Oct 2023 13:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: hub: Add missing reset recovery delay
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-2-v1-0-9f793aa20fe4@marcan.st>
 <20231029-usb-fixes-2-v1-2-9f793aa20fe4@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-2-v1-2-9f793aa20fe4@marcan.st>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/29/23 08:09, Hector Martin wrote:
> Some devices like YubiKeys need more time before SET_ADDRESS. The spec
> says we need to wait 10ms.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Marek Vasut <marex@denx.de>
