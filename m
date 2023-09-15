Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DC9CD37AA
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 21:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D600E86529;
	Fri, 15 Sep 2023 23:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694813514;
	bh=Qr+ryZz4EVl48yJBCuLKcQbmP5CA772IpVQzM/97xQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2h01LFKuPdgyrB8zXxnrjjSR4DGEtYpfy9pMH/aZbZw69gU+LIAIn7Z27Ee2gWL9
	 MlOuvziMCCp8II7gigN2xPUubmiiERvzA3cTKlLjRo1Lg8zsLQWBbIO2FPxAqYcZn2
	 hSw04tH42fmP6OMqQsv86UQ2XuCdJcPxsufyXChAOa/h538rLduJ/uEBzZsEmJR0Qx
	 q8mtT1d48JRXwOfbv5xoyYOfPM6kHJTWjBqKdcbh9m6M4CL44dS4sJiGhg3hHuh6Ev
	 Evk2u60LAhOOXtWIlWt04l7Jv8+8uQj1T4GKZOhIBMejNLCnbp7hiGJFe5PMwnOKRg
	 egQ8Du4gmwguQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2638D864DD;
 Fri, 15 Sep 2023 23:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1694813513;
 bh=Qr+ryZz4EVl48yJBCuLKcQbmP5CA772IpVQzM/97xQw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NDOEyufkKdAcCjTrc4JItvRxgzLhN3jqup1g8Ip4NiIGhcmSlRuhYs3wj2gsyiudn
 /QcUUQiVxUyGH6J/ZNca5YwRIE7Y4j0/K9xw9orrJNxSkIqHqjfmFHtKsPZTJWUk0M
 KZLTBbskgTv/Rh+ZVtR2hjBKZEcWQvxSxv7Vu1QWYC7fDh6/stIWnmDxBi3XMqi6yc
 s5HRBZVuWkvisOxFrRSIrYY2CGTC3/C9JXeC4KGdYwrGKUrKBIt9vGNQ1mZ9bzAWx2
 7vUNxQ8KKOaCsueZnMO3ibHmY2vkHq+H3mC/QuH8mpXI7ZMnX8L/ZZoWIb4EWFH6sL
 al/cKFPcwlU2Q==
Message-ID: <4c9658ca-1cf8-e985-8ced-28061a449ca2@denx.de>
Date: Fri, 15 Sep 2023 23:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: ufs: Change Bhupesh's email address
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, n-francis@ti.com
References: <20230915181442.3403172-1-bhupesh.linux@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230915181442.3403172-1-bhupesh.linux@gmail.com>
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

On 9/15/23 20:14, Bhupesh Sharma wrote:
> Set my current personal email in the MAINTAINERS file.

Why this change so soon ? Did linaro raise any concerns about the 
maintainership ?
