Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8401CE69E81
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 19:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3ACC8946E;
	Mon,  2 Dec 2024 20:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733167419;
	bh=UISYFOZ3tyTq8W+k79U07qkjYTqQJg8G6CqsPyCcCD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DUtmBiB56HeVGQSN/6gtymQ+MxA1aKyG/03G1JMd1Qyc9gFXR8rCcPE5CbJIsb0Go
	 ZmaO/8lpgqkhO67XGfJUIIdvYZlzCIWTZw/D9KbLKDT0q14vkggPE/4BLeh7pfVm8s
	 PI9whEla5iJyx6+xKQzlwFGMfb0sTnTW3HX8CUqZvZ48DVK9c/OtQqFybhAGjH3Tsd
	 peFJuqhyRS6+jY2iSagoEsOLI4TXT+wb2xlUByoq2JhgqpNJP1Btm4SVW3decXH91t
	 2T8xGr06Ugp3Ked20g0VDu8ofwUjxzQLv2PAd/8DvmAyRo1TMF7K98/i0WvftdezE6
	 fs2R31jgEcKMQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A3BF589246;
 Mon,  2 Dec 2024 20:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733167418;
 bh=UISYFOZ3tyTq8W+k79U07qkjYTqQJg8G6CqsPyCcCD8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=u+n4Jnc8oZKJ7kLdRSQt5RcV6zI8p/nVZj8QjHgZeu0vdor6tlQKY/rLVY7VO7MJa
 oZCrKMRNdkoJBmX/R1Fj/bQB2ClxkgYtSy/QtqFZFXiWqtMToN+QS8x0WbrQAa1ADz
 4h/EqM0mYwjB6AA6/P8LRQI20f1YqRLddPK6XrTXRYHGINrszPd7fQ7K0HOm6zAI7f
 B80GqaA/zVVnBshFqyx8MCNTGBN6ABeTcKhTwcTwUh6OIBpbWiD8spoBDokqKJFwS3
 b/86mOEgNq4yDsbkV61XOkCfBOj/4K9GEKiUcQICSZshxH6xOeiudGw+e2qzfqML6J
 hNK+FIB97OyTA==
Message-ID: <c2edc02f-8b79-44ec-9a59-e5336d741d1c@denx.de>
Date: Mon, 2 Dec 2024 20:08:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/4] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241202172950.35460-1-cniedermaier@dh-electronics.com>
 <20241202172950.35460-5-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241202172950.35460-5-cniedermaier@dh-electronics.com>
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

On 12/2/24 6:29 PM, Christoph Niedermaier wrote:
> The env variable "SN" is used to store the serial number on DH electronics
> SoMs. New SoMs will use the variable "dh_som_serial_number". To ensure
> compatibility, these env variables are synchronized. This is achieved
> using callback functions.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Marek Vasut <marex@denx.de>
