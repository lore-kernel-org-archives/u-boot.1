Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34D9C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F270C87C82;
	Sun, 29 Oct 2023 16:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592190;
	bh=BU8U6R0c15CvJccRkvD1thlVlwUhL/AmsQt5f4pYess=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cowteszRWuJli3y38D+GXjIsrVq+9ypuN7P1XBjfch9PbgAsS4U3/wIs1528n1HBU
	 kPpMD2YC2ySU83u8m2TNKhKCGCCHHDh7vZKwmXyET6I8jOVgcsictoj1/LcNGOxBFO
	 12428NMpjGMp9vkOuXA0osMRr3lvBkgxsq4u0aQ2tayAdOQxhRoEKEfxqnSU5HaEQO
	 u2q+dcH6epu3U8jTmTc+mOhEssYJnYbTF9C9ql0T5DUgOuehaCjGk3k+XiNQwULIae
	 xd/cbQHM+NN/ETbvmqRG30SUtNXee6exNvRd5fvCplVW4Lrurxg6GvZJgt9hx2c0kU
	 zvjbANUCRT11Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 22858876CC;
 Sun, 29 Oct 2023 16:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592182;
 bh=BU8U6R0c15CvJccRkvD1thlVlwUhL/AmsQt5f4pYess=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZaMI5er03yJd6BvcC+DlemqVIOJ0c+csV7ADzH2hyUfW6KYHRBisDfDs1nYrF6H7X
 uq/PfBWTG49jw0Rl0fQGA4opoEFE6vRnOU75L/aA4iAIFlLsvJLw6r35w7xVGe+gl0
 eb4jGSW00CsSrkgRTSKaGowbQqhRyHwJKInGFpXrntUIF79Exdrm3uxYSAMX30ydE/
 en6REeX1oj4WySikBnw6befQ8oeG380wRVzLhhBtdQ7k/j+u1jjZnKJfBSeDYDaQo5
 1WXfxMv0Zc2Gx6hBszViry+7L1QCMgYD5fick/3k5SZDtpq9YchZnDC6OROl3MKKy2
 Bqr9eDwM+XaSw==
Message-ID: <1f5dd916-f4dd-4030-8908-cb6eb3c21753@denx.de>
Date: Sun, 29 Oct 2023 13:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] usb: storage: Increase read/write timeout
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-3-v1-0-0153210a7f55@marcan.st>
 <20231029-usb-fixes-3-v1-2-0153210a7f55@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-3-v1-2-0153210a7f55@marcan.st>
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

On 10/29/23 08:23, Hector Martin wrote:
> Some USB devices (like hard disks) can take a long time to initially
> respond to read/write requests. Explicitly specify a much longer timeout
> than normal.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Can we make this configurable with e.g. env variable, similar to 
usb_pgood_delay , to avoid affecting existing users ?
