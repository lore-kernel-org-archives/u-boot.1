Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E1CC25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 01:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C20587BC4;
	Fri, 27 Oct 2023 03:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698371064;
	bh=UQBG7kzUUsyC2n0cghcXpWzY+edu8uxwAbdHjbnh0oo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dOzDg6aKM8JH4frTist5JGvyXtlaAEAh8AXCfZtIUcBqbw6X95U5fDI4wYmkQUMUg
	 5Zu9LIDmFAYBd0QEFO5fI2a5KB0DZhdR49KSkSW8Om6jTpuCnXRhy8stdPZLGARxGm
	 3jQRgRWK3UQqFfIlwJRWo5uxQzHgMim8udMupt3j8RxRHyVWGkTcUBlIJnZZ1mRhOe
	 m9Cqo1jkIV3+XiW+XszUK3d9jefqinBPLLDCqPg3F5oN8S8F2O04k7B6r8E6djnwcT
	 pXCwxhhnS3CerCB6K8lC3MqP0bmcKtrbiebL2rVL+G0oI3uSay2ot0N+5smy+d+sq4
	 C/s+4ltuFts/Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6F05287BAA;
 Fri, 27 Oct 2023 03:44:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698371060;
 bh=UQBG7kzUUsyC2n0cghcXpWzY+edu8uxwAbdHjbnh0oo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ur3tlwm5ngZzqF7fKxsEnlr+3S+q9hsPSbivD936LpiTORlyBF1zaKG2tO1fl1li3
 OmLfvWGi1DTw5dsD5k5Dz2tx7aXy9szwBywfuSFS9m6+h9SXHvDXdE7rMWZbbtDR6b
 oPrXMz+OWrkFiwjv8NgA112Xk1v1NOnRUD33KiprIvd2H/PO+SqRxkVLJUfeCUWdD/
 7CREN/fgbSJrB3RcS4n5Fi+0c1nndI7XCswRGhRjg/aXlgSGT2RI+sY7GxNvH6LaHz
 77/qwpNMS8Y0Uz7HiLb1vB3l7Gg1O1lCL7Zct2Cw3AktbaO5EW935Db78YCZlWXuFG
 avze8qqCt5Tcg==
Message-ID: <8fd6dfd6-2ac3-423e-9380-e1139b98ab45@denx.de>
Date: Fri, 27 Oct 2023 02:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] usb: xhci: Better error handling in abort_td()
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.dev
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
 <20231027-usb-fixes-1-v1-2-1c879bbcd928@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231027-usb-fixes-1-v1-2-1c879bbcd928@marcan.st>
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

On 10/27/23 01:16, Hector Martin wrote:
> If the xHC has a problem with our STOP ENDPOINT command, it is likely to
> return a completion directly instead of first a transfer event for the
> in-progress transfer. Handle that more gracefully.
> 
> Right now we still BUG() on the error code, but at least we don't end up
> timing out on the event and ending up with unexpected event errors.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

I'll defer the rest of the review to Bin , he just knows better when it 
comes to xHCI . Please ping me if things are stuck for too long however.
