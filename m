Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AABD1AD54
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 12:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A313488CC5;
	Wed, 16 Oct 2024 14:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729083225;
	bh=2nto8mQnjKAitxRvYFP+fmbAWUj9DQ9P63AmfyzHkuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w7fZnRv7Ti57uvde6+d66g+DgSBroH86SFQ1hXh+15kzqZA1Ar1JVWXdxNgz8TIxG
	 6XWEJiddPmUhEPKDjyy2VlKl3dCuAeafdkNjJBmmMym+LqZNFCIwIU8znfIa2QkMnz
	 OTBAIYX4H/wgSsgV8etsWCA+aiAcwGqFibbCwNIHMkzEBmG7q7KFCtnJl/d0aK+ieq
	 IoI3RBMb33C8xdS3RHTejyapcyKDedLWsPNa6SstWNSDWxdoqonHl/oRhY4Lb/kI5O
	 r8alwH8GjPE8r1X6YWg3YDvGkVu74Sy8wNZ8jC2y4gbuemsRJxTJCv730vfu6X0Duf
	 jz5XcF9Qlh+8w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AD676889C3;
 Wed, 16 Oct 2024 14:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729083224;
 bh=2nto8mQnjKAitxRvYFP+fmbAWUj9DQ9P63AmfyzHkuY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sJsZnmwP5fesC07LIXXfqefdLKitrRysr3HOtkP0pZKp/GmZWZV8xrRhdSIjzKVFW
 5cZ8AzdRgIBUCN+Xb8wN7EQIlZ2KiuxlwQpb+nWO1rof3wT+275RdO/7A1icd/kNKo
 4szIyFcluUXti9bk24mjAio5/zW/y34RkjHw1MF105wm+mKKqMAxTAgeNcs2MxASZb
 UG9eNJBrt2UyaeQ492t2OTsOmZFg5itgYeUCcW8NU1MDAhFmVCXTq2BtrXT1FwV3sL
 sC07ODsASAUb9QgNrAuJ4U/YJMjTgG459svHd1zQWESboWuneBsSZLY322LjDoI2+J
 0g5PQeGqtzPcw==
Message-ID: <e4585dc6-5c1f-4c6f-a696-49d31626a431@denx.de>
Date: Wed, 16 Oct 2024 13:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: use DR_MODE_OTG when dr_mode isn't
 specified
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20241016-topic-usb-dwc3-dr-mode-otg-v1-1-4fda56072723@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241016-topic-usb-dwc3-dr-mode-otg-v1-1-4fda56072723@linaro.org>
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

On 10/16/24 10:26 AM, Neil Armstrong wrote:
> The USB DRD bindingsa at [1] are clear, if not specified the dr_mode
> property defaults to otg, and this is how Linux behaves.
> 
> A cleanup is ongoing on the Linux Device Trees to remove dr_mode when
> set to "otg", so take this in account and do not fail anymore when
> dr_mode isn't specified in the glue or dwc3 node.
> 
> [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/usb/usb-drd.yaml
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Is there a matching Linux kernel commit which implements this behavior 
in Linux ?
