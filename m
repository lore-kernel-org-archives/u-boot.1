Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C23FC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0AD87E9D;
	Mon, 26 Feb 2024 09:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708937679;
	bh=Uj4XLypXgzVMjFqODvZfA9RN0HZHNlZaGgfGlv74bAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sEmDFmIKUihHQDYBDhvcEZdnUQGHYFuusUK2Y9cHwfFOHimcExJuqAqq6Dg71IY0G
	 4HsnjORp+kQ3eCpvSaYviKo29CHoZHCGMoCrtz/g2VLDKEutA9Rq7iB9wwDr4TGgw2
	 loFxsXTXPpGMCZinCSbsyPpsO4/md47PLqgjAIOdpQo9uaykj5XeTa9iw0CjnnHHOj
	 v4+GAQ8Uz7qZLCe5gZXNQWp+fpl+lufLC6HObPAmSmQxnqPh8/A3hkX1HA8xzEnz6x
	 LKEh8fv0yb6s6uQj9pAVHD9WhI5wx4WHaru86r6nSlIoJM8P5VVLhYq+YkDTb5ZtxB
	 jr+UlSM3MpCrg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1A3FE87DEB;
 Mon, 26 Feb 2024 09:54:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708937677;
 bh=Uj4XLypXgzVMjFqODvZfA9RN0HZHNlZaGgfGlv74bAA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cESCqionsK0F1tfHmglMJ0ZP/llIJg4alRZyFhAy3QXUgzCWQMXKwP909vdW/hA/M
 ryTdSwWk+/HcXpvgazadVzBFbyx59fLt9YnbZoV5iDPdMIarAbMfhylHwgy5qzWNZN
 wKvXKDWfjl0wJ26G1rE6AjC/rpyibs8SeyxTlX9wWC1F+RkOjD/2deaQ8s5wC/otpS
 7KAb31Hxi3jX8V1ifzJWQG5PR9RMjXXW9LwSByJRXvWs69h/vcpfi3NdKpXM0S8xUk
 Lk3mDDjeQYDrJYw2dIG6AfzJeHbbOz/m0A6eQTfi/9mRtzNS8g/5Jr+CPHRGipUzgO
 uuqlhw0qY11zA==
Message-ID: <a5862ce9-8977-47cb-87af-e8da1839867d@denx.de>
Date: Mon, 26 Feb 2024 09:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] reset: imx: Add support for i.MX8MP reset
 controller
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-3-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240226080433.3307154-3-sumit.garg@linaro.org>
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

On 2/26/24 9:04 AM, Sumit Garg wrote:
> Add support for i.MX8MP reset controller, it has same reset IP

Same as what ?

> inside
> but with different module layout.
> 
> Inspired from counterpart Linux kernel v6.8-rc3 driver:
> drivers/reset/reset-imx7.c.

Use commit ID of the last change in that driver:

bad8a8afe19f ("reset: Explicitly include correct DT includes")

I guess
