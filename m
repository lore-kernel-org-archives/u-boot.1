Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197A6C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA3E87CF2;
	Thu,  1 Feb 2024 15:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1706799233;
	bh=69z7YqJJbNSB1O1YPTmd4AocvjylLnM5sbHiaZC1yuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+kdcS3DPSiRqrDpxrh3wwCqGfEdA46TmF5DZE7PVT0ZaxH1QO6n4H57H0C4Qs9O4
	 0uudZVkPtBiZ+QsoRxcf6G/hJlW/WD54cWp3bvMb/9sxpTb91NZuqjbbtUReFI439q
	 TJ1uK7ejfZvUi26oJMIU6EL4cO5t9EofrB5fpcye7xTBE2ePdcHGPomwBiV78X9ZxU
	 3Het8pDSXMG7yyz45Er0fgxFipjzFn72OqSGwWoo7TfwaEll7uM2Q9JWHZcNIIXNX0
	 Am63uTUTFY0bRwJ2LIt0w+DNqIo8gDT8xEOKEe0q+BaVFtM3HHQgmOj4R1SZ0KK/Y7
	 cxS5tzorn0t2A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C4515875FA;
 Thu,  1 Feb 2024 15:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1706799232;
 bh=69z7YqJJbNSB1O1YPTmd4AocvjylLnM5sbHiaZC1yuY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=v0zUBtcvzjQTQwzlK3pZ693JtpTSCwgrxlBrvLDpDz0tfQb2CO/7sdQJ8kad2rilF
 Bk9E5Hfudyk4+zokVOIbTxE2OOcKeLv6B3dkzPLmuAkoDKdJtkBMJANfxyy5ZuJp1F
 IrF8C/O3XvRwhRUj4xCxS59LJoJgphSmts3aw7PEqUij3su7OeqQ8iEifGi+tGqkc1
 tuMfng7+rIbXdMCrtCAANj1Fy4rOx5btEQNjQrSOsfgbfqvKiNxVCg7ldhTyZ5J+4d
 UTXKvA0vLQQldDVPKeeNPn2Kd3V8HkDY2Pmdm3PEjeNYQmpcyJskGGQ9C5JZ/lytIe
 dUnOFAyM7O14A==
Message-ID: <242c7bbc-42e0-48cc-90de-f57ae6c7cf59@denx.de>
Date: Thu, 1 Feb 2024 15:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] usb: ehci-generic: setup a bulk of phy when possible
To: forbidden405@outlook.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20240201-ehci-v1-0-bb506cb0f64d@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240201-ehci-v1-0-bb506cb0f64d@outlook.com>
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

On 2/1/24 14:16, Yang Xiwen via B4 Relay wrote:
> one USB controller can have multiple ports specified in dts, all of them
> should be setup to make use of all possible ports.

Is there an example of such a system ?

