Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA2C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C2280FEC;
	Mon, 17 Mar 2025 04:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742182303;
	bh=hP9uCR3yzF/MFUF6xjYAo2XaQDuDwIFuuWVMo1NbXeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fs4rU4NO9HJMb5aOvspw99/nKON36ka8Ju+QRBihMnwdcgwj6alFFoL6V1BOAn+zy
	 XJZUGRr5q7xIZ123O3UkgvjxAvbIKfY8QMJ6IiBTVivXjGkSQ5pSUe95aeKXjkGW9V
	 MDfDiS7J3iZlbqmq+3xdl+aYw/eJxSgeph/Ifoo5PAjnahQdgrfuARACGbT15fe5zx
	 15WZqgyHyUXqgXbhnfC8OMd0tQcrIl0O6OA0XzzGhRMvMjyDgcNp9VO74sMd+Zn8OO
	 YFEbTobp1rdAfQMso7Qes1dyVe/QA+wSwgQQtc5Q6u/zkEwi14an55nIJ8sRf0FH1y
	 njT0KKcjKcBaA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED54810F4; Mon, 17 Mar 2025 04:31:41 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CBF880F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="LbcRnBng"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1FC80103D1FFE; Mon, 17 Mar 2025 04:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742182297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=hP9uCR3yzF/MFUF6xjYAo2XaQDuDwIFuuWVMo1NbXeQ=;
 b=LbcRnBng6BT6mGQkk4rjHr3X1UWfLnQqvpGoy6IsDnel8m2dlrIH+4iWLxeN1MPrA1Jp0U
 3M4kN3G1mLf/FPL38AWJAqna1a2TOA6dKMRM82oh4/kb9cooJa06RvaLMk/L+V36EUF356
 /DhqrPazFDV4tPWghWdCNZalRPNOJJ+uEumtDB0kCtY2Wlhk0Q3ddyQ3PBj2iDD8oa/Ho5
 Ds3hltUojfXPpq1/TbFF32tdh4OVB1fNwZF+BQxB+Cn2x878UhznBv0ntD4wTpkJn70YoP
 ER2JYjrrUW3fnic4UUEASHwkAN+/yJzB+HK2k+Ts00zKp07mEYA0mOiGJWUjMg==
Message-ID: <f40e5f42-3f29-448a-8c2b-76945f1ccc1e@denx.de>
Date: Mon, 17 Mar 2025 04:21:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] Add Starfive JH7110 Cadence USB driver
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20250306062032.50314-1-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250306062032.50314-1-minda.chen@starfivetech.com>
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

On 3/6/25 7:20 AM, Minda Chen wrote:
> Add Starfive JH7110 Cadence USB driver and related PHY driver.
> So the codes can be used in visionfive2 and star64 7110 board.
> 
> The driver is almost the same with kernel driver.
> 
> Test with Star64 JH7110 board USB 3.0 + USB 2.0 host.
> The code can work.
> 
> The Starfive JH7110 has enable CONFIG_OF_UPSTREAM. The dts is
> from kernel
Applied all except

[PATCH v7 8/8] MAINTAINERS: Update Starfive visionfive2 maintain files.

Can you please rebase the "MAINTAINERS: Update Starfive visionfive2 
maintain files." and send it separately ?

I already sent USB PR, you were on CC, so you should see the 1/8..7/8 
patches are already on their way to u-boot/master .

Sorry for the abysmal delay in replies on my side.
