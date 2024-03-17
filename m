Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D107C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 16:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB2A87E06;
	Sun, 17 Mar 2024 17:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710692561;
	bh=EbZm3rVdKPwU+yIx/o5aFdLsK9ERT+VfrYMegUsrzr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sY7FTkn5799lpwYkFNcRkl3e8WLd+9z2Yrlo1AGIFVTksTdgzXogq9JG3sbqBq8Ld
	 2tFhCmvY3MT5btpgzrCz9zRZKPXkrujjpSu22gR6eMed5oHepg9ftV243IYH2CUpeV
	 UB+75s3WSv6FyTBYd/lxNMhtR8XlXghig1zsuBSfqNYwV/ChpyFr4NMbNZRK0CzWBU
	 +alj/NbgXBil0bdqIw55RqTujSy0JIV+/mxa2jDDeMBSfGqWiELicxTzXvLm4sJDef
	 b4mVWOngivIVEjFaIpmFlXATLR5XWZ6oag7zoIPH16TWWI9bsY9/A5BiJeUG9+u7KZ
	 5eVAj38oE+4yw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1409A878E9;
 Sun, 17 Mar 2024 17:22:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710692559;
 bh=EbZm3rVdKPwU+yIx/o5aFdLsK9ERT+VfrYMegUsrzr0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lk3lETITsjpTPMlTr22P84bl0NFJeD6q+krpKg5I6L6nQzJs/t6TKEloHUNPu232F
 Y2o7aVKqftdu1Em/2Bq0kBQet75i/FutIKIA4D4s4eX5X8tXbElQz8nX+G3Xzs52Di
 q3zf8fqDEoV6fIY5LGXPFPyM/NiL75tx4g18l7+TSc/UVFvxW1MiaYUp0F3KIWwGaL
 XhwGd2evexjcc1kZtD3Y4EWmkY01R6s/whAmEHLTZsPrV8CQ9YZR0MXjmvds4s3LId
 jpuib24AlFagnt3/mOBBrl2xKjN9O5YgYcaxTdKMyvq9cTADy52gAmUi3EpJvN6zc+
 PoCSRpZibBuDQ==
Message-ID: <b994d7ed-b7cd-4725-a682-b4a1c0aed33f@denx.de>
Date: Sun, 17 Mar 2024 17:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] usb: xhci: Abort transfers with unallocated rings
Content-Language: en-US
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-3-d3f4b8384f68@jannau.net>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240317-asahi-keyboards-v2-3-d3f4b8384f68@jannau.net>
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

On 3/17/24 12:07 PM, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> Discovered while trying to use the second interface in the USB keyboard
> driver necessary on Apple USB keyboards.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Marek Vasut <marex@denx.de>
