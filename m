Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CCAC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 09:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83E587BFD;
	Fri, 26 Jan 2024 10:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1706262122;
	bh=gwTVgNJAND9q3b2yRnFZtIxdNqEWsWZzJVdbk1C2jF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hjhl6Bv649CTe0hpJCP17ueilXVrLdaFYIdciMV3RablyCDLqrfG11qRkGItycbIj
	 dBaPZsvzd1xyR8kBJTpAP0yHj0pMN1iTVnAZHhBSIyUEW7qRb0t6WjinKd2yHHK0FC
	 CWQxpXssVinuhkaJPyF2u7f3g1Y1Doxkw5Xj4iGwxcFQQ9gT32QQMzCZOXHn8XU2t0
	 J3aIVPl4C2xNC+SzH/5xJYMdymAsj6ZXiR68q669ZM/sNzrJc5l51bjkCFydXcEidl
	 P/UNX8eJkP+4RXW1Yy9K/zVxw27HY/vcNtsmR2BTQbsgfXaydtS9elIaDN+RBGbODy
	 As+zNcl5dWtWQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BF07F879DF;
 Fri, 26 Jan 2024 10:42:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1706262121;
 bh=gwTVgNJAND9q3b2yRnFZtIxdNqEWsWZzJVdbk1C2jF4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DIfupdFIT+dzVdjH0A1tvB5M1HandXEzMJfiDtBw5OkE0nd+OKzJcpmNw6Vov6ly3
 8N3PgC9RXVQaqQEmWCe4jHCzTqqE3lZ1yo8lC43iYtv5/3f8DhGpRwQNmP/u1HCR0E
 BdO3Ucb3PF0uxqHayCeH8BF8h2tPmYN4UzgmYIzGFaoDwJO+bnur8WSE5EnncrZ5o0
 cPqZISkrXs7LmIOcXUUOanzLV7Wy3ZZaiQA++3RHRxbzdwLAGJ9cwy10Xj6DRqfIsh
 HKPOifwm26M1Qi4zSCM31wnC1pAnTlcvfplHIuHg7Xo99QK9J/ibeNo0+fybZVcWss
 HQRhz9jZgIjVw==
Message-ID: <5251a588-7eff-4029-b121-55d1ebe05f4b@denx.de>
Date: Fri, 26 Jan 2024 10:29:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] usb: ohci-generic: ignore ENOSYS and ENOTSUPP errors
 from clk and reset
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, u-boot@lists.denx.de
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>
References: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
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

On 1/26/24 10:25, Piotr Wojtaszczyk wrote:
> If a machine doesn't have CONFIG_CLK set the call to clk_get_bulk()
> returns '-ENOSYS' error which should be handled the same way as
> '-ENOENT' error. The same applies to reset_get_bulk() and 'ENOTSUPP'.
> 
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
> 
>   drivers/usb/host/ohci-generic.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
> index ceed1911a9..28512c081f 100644
> --- a/drivers/usb/host/ohci-generic.c
> +++ b/drivers/usb/host/ohci-generic.c
> @@ -28,7 +28,7 @@ static int ohci_usb_probe(struct udevice *dev)
>   	int err, ret;
>   
>   	ret = clk_get_bulk(dev, &priv->clocks);
> -	if (ret && ret != -ENOENT) {
> +	if (ret && !((ret == -ENOENT) || (ret == -ENOSYS))) {
>   		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);

This simpler form should work too I think ?
"
if (ret && ret != -ENOENT && ret != -ENOSYS)
"
