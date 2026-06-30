Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4EEC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 22:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07D1884B6A;
	Wed,  1 Jul 2026 00:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="IGIKJ7BI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEFA684B59; Wed,  1 Jul 2026 00:26:06 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD37684B48
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 00:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8319C117851; Wed,  1 Jul 2026 00:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782858363;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=UalBjiiSbjMkaJqfwsf4KYNiWtTFjARauk1A9D22sS4=;
 b=IGIKJ7BIp1PR34USWBO/30V8wxf1gKxqe7eY/DKtt7lhP+LKEAsakHuijy8nrA24iR3iqz
 XggJZwGSj5zRUr+ZNlmMqsKEQas9dnPqZv2jcUDg1pHXlx3kV0Z404n7qbUx+miIKopZXu
 AH91uZ3gUHfeSmq8wWxnrHo0TfU81CiFPZ8Ze84AsKfFB/4ardNFVJK6fYJ+Dieai99zfW
 UxeJBrUbk6lvqFAz017fnvgywF8UaG0SpbfdiHf6V6EF4nOrw8JJL5zLeWRHbZCgMJ9k4G
 3BoDXZGyRNqZpKnqzitg5q4TaRxuVBqJdjUKvm0EJF+Z8HpNrkvvgbUPDjpNEg==
Message-ID: <cc09b04a-fa33-4580-93f8-181e3c0157cc@nabladev.com>
Date: Tue, 30 Jun 2026 12:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 63/64] usb: udc: re-import udc-core.c from kernel v6.16
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-64-jens.wiklander@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260629084507.3254232-64-jens.wiklander@linaro.org>
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

On 6/29/26 10:44 AM, Jens Wiklander wrote:
> From: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Delete drivers/usb/gadget/udc/udc-core.c which was imported from kernel
> v3.19-rc1 and replace it with drivers/usb/gadget/udc/core.c from kernel
> v6.16. Keep the name udc-core.c for now.
Which kernel do you refer to ?

Commit sha in the commit message would help too.
