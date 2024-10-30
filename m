Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92C5D5CCAF
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 14:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E53E88F83;
	Wed, 30 Oct 2024 15:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730297852;
	bh=HVxu76fBGmkbX35tANcfVxDAhz0u1JfwuGd9w1lyvyM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tj67w7H/fOjF2G341Y+xil6S3aZi6wBZMnCSeWqSY4ZU7k2xsVbQZAHROhYxRbO1O
	 aH04ga/14PD6O31JIwFDSpR/vkzPk6NdNQ/WgUTaNhtk4sLjztxtWL6JHXJY7vLCly
	 qgRYTf4hjLfOo7M8UH9LMi6heaGmktRKvNJtdvZ1+BfXVJCWEDZwsBBzSpgA/fEVoV
	 9cyh9dIpyLNNxHd/8LfivS3VURe4z8lkukxcJgnBoFLrFkjGafXOZjkL62uwVEE9J+
	 5VycqMimmNLVQ+TeOMEYFdn8+c56WQh7IZVR1QTLSBhpVAgvCD0ktonTY/t9Qn9WDr
	 nrxmZY5xWB51Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1441F88E65;
 Wed, 30 Oct 2024 15:17:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730297851;
 bh=HVxu76fBGmkbX35tANcfVxDAhz0u1JfwuGd9w1lyvyM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=u1nAZ4edCMte1Z0GQ8JoY4vqxacmumguR0ztvGGFD67CxY5HGfMurhSBY0zGM3Ux1
 JODgMkCpQpJ5bLkjrNNU6RPtWU+mXxdFotrObYXBEBYXIOXBEOD3S/KaQm/D2CKKhh
 Pa5MpLRuPtFv4a2WsJnIsnxWoT0MXs9w4bLpHXd0ZAVUBIa/PI87T1AxValLTJs57P
 RFKqzYyGupZD/2SGA1bFcfGy3akqIHW7QvxcGIj+upoikcl8SlGJcQRDBX1i1q+i1i
 +cha5p5EGejA2+tf/oH92TNVReFZf7GLEVEUquQ8fViDeVghR8bz1CWm7xvHNWFyY+
 6eCAhBHopvxaQ==
Message-ID: <7597cf81-8c60-4dce-8fba-9181910c3247@denx.de>
Date: Wed, 30 Oct 2024 13:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add tambarus as reviewer for SPI NOR
To: Tudor Ambarus <tudor.ambarus@linaro.org>, jagan@amarulasolutions.com,
 vigneshr@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20241030110221.3321315-1-tudor.ambarus@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241030110221.3321315-1-tudor.ambarus@linaro.org>
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

On 10/30/24 12:02 PM, Tudor Ambarus wrote:
> I'd like to get Cc'ed to u-boot's SPI NOR patches to help review them.
> The ultimate goal is to have an aligned approach in u-boot and linux.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Acked-by: Marek Vasut <marex@denx.de>

Thanks !
