Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78556D374A2
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D761789011;
	Thu, 17 Oct 2024 16:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729176392;
	bh=ZDr9+ow6HnxzaxupdOD7rc5HySsZJlgx6BYtfkICBKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K+gtjwil4Z3ZF4o1OGV9KHbs/h+oICvcFLhKlsBoiEEA2FuA5mZ9FRYyubZxRA/6T
	 kUNeowG1MpavWL/gfFbx2Q6ERtQ7OijmjjtBHcFzctOPmVTNNq8gvxlqli+SMswW9r
	 Y9HMPHumpNwLfiI3m2m/cQPPciCJ/BBa81CWbDd5RGmphYGGX47i3q+z7IGgxn9EYu
	 t2vpbYWxddyErvbdVD03kabYM8QJ0/02L/wj6dntCcVVlf+x19G2FyTEuigz8HZs9Q
	 tTQX1d5tlr3Uxt617PbbuLnRkneXoBI7VnR+vztSi2yyRtrsvj9q9uFDsyNUpyApY9
	 WhR/HZeU5xvmw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4B9C4889EB;
 Thu, 17 Oct 2024 16:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729176391;
 bh=ZDr9+ow6HnxzaxupdOD7rc5HySsZJlgx6BYtfkICBKE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kweydOPTsKaPusp2xa9YYMFVZvbtcLNEXRVQ4CvSAXidE/j0ZCjr2eTDPTYHQ+clI
 R4nZ1c+EUBPjbit4iw3hhjqPN6RqKIjLaiFKPAhfbiXC5LE3Mf49EVe7bSi1Cy8IP+
 FywVc8D61KCZTkJXGGI2NgVZ9cVWOHdjO1lJGUNw5y339LDNQmZK7IcWswS0jv7oCJ
 Zc4hd8GJo7bxI8gQ+n3fqvRZnUcUj9OiZZqwLrWhRDXgfwiVzK47fbnJM8NmE9pfPK
 QanLUyM3UxdJoA6teO4f82KgPoIYK4wIllgDJ1yqUeVI0rhlGI+n7/ACraCvMWmqMP
 mV8DJg2fVLjpA==
Message-ID: <21febc56-7224-4af0-a0a1-4eb707a3f94b@denx.de>
Date: Thu, 17 Oct 2024 15:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: use DR_MODE_OTG when dr_mode isn't
 specified
To: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
References: <20241016-topic-usb-dwc3-dr-mode-otg-v1-1-4fda56072723@linaro.org>
 <c6b7e22d-2d84-4577-a2e4-d15363a45993@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <c6b7e22d-2d84-4577-a2e4-d15363a45993@linaro.org>
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

On 10/17/24 1:07 PM, Caleb Connolly wrote:
> 
> 
> On 16/10/2024 10:26, Neil Armstrong via groups.io wrote:
>> The USB DRD bindingsa at [1] are clear, if not specified the dr_mode
>> property defaults to otg, and this is how Linux behaves.
> 
> I guess this is (kind of?) a subset of
> 
> https://lore.kernel.org/u-boot/20240621021135.1600847-2- 
> caleb.connolly@linaro.org/
> 
> I need to respin that one...

It would be good to include that information in the commit message ...

>> A cleanup is ongoing on the Linux Device Trees to remove dr_mode when
>> set to "otg", so take this in account and do not fail anymore when
>> dr_mode isn't specified in the glue or dwc3 node.
> 
> Definitely an improvement over the status quo heh
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
... and eventually synchronize the DWC3 driver with current Linux kernel 
state of it.

