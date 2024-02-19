Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6EDC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 14:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B30B87F1A;
	Mon, 19 Feb 2024 15:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708351964;
	bh=Jraf4vMPpfAsW2gNzuy8vtAks2tAz7UX6HprKzRRa7c=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OKPYrsobxe2ql3Vl22T/C0s2lPmHbj988uKYPkR0MkwrwbR0RmkVxP6Fm5mBiJ9hh
	 lAvhrUO51n778xv9f88Y5qY3JbKY1j5m3K7BIt08iUtXCz/CvC/bmve48KgcZ4vOZI
	 JkaKCznTohzYCXGDaxsPlhlzVlzknAwv2yk3X9FKQRZrjobXPIN33ayNqUKvWferJE
	 kk8PVeDgKO2iIQ9qWpS105ycJxNOo0uxDhXnLKFEql8HEWkvnNfZzheGFu1ETWYeYr
	 2AEx++2hoYZxxRpftL6/w9UDuXOSuXGqu6oqZxXQP2tduydsrQoK6Heup6/VNgOv5c
	 EtZYvowFVMnmQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6344C87F1A;
 Mon, 19 Feb 2024 15:12:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708351952;
 bh=Jraf4vMPpfAsW2gNzuy8vtAks2tAz7UX6HprKzRRa7c=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=G35c08XS0m7xYholNRK6Bp3g7wyUjl60sjNWUI53F6vcPYuVnRAePmwQIrPS79E+Z
 ydE0yW/Wp3f6Ys2JEALWnIQskcbCOZO7g0fcz26uhRv/2m3JN6zWPx56jiXNUH/W6B
 lsLwZtnH1ebwMv6E4A8DCQPsbQ+shc907tltewfFx+e9b9rq4hnQovat4BDsGZlJOc
 LvQHtegEEJ8TWHDV9BNOrZaYr5Q7BjaONq6akA2D8vWUaV1dPVuSmO3qcWB3TXEKd8
 /Cx2jD5w/zSSRGLCNJXKhdGt0fYmSaYNweBtbdxXwJ1HV96kCqXjEn9mp9ZfnaZoP+
 odeBO2AmfejGg==
Message-ID: <ab6edb25-2d18-4f65-bccb-f14ced184636@denx.de>
Date: Mon, 19 Feb 2024 15:05:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] usb: ohci-generic: ignore ENOSYS and ENOTSUPP
 errors from clk and reset
Content-Language: en-US
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, u-boot@lists.denx.de
References: <20240219115925.12675-1-piotr.wojtaszczyk@timesys.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240219115925.12675-1-piotr.wojtaszczyk@timesys.com>
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

On 2/19/24 12:59, Piotr Wojtaszczyk wrote:
> If a machine doesn't have CONFIG_CLK set the call to clk_get_bulk()
> returns '-ENOSYS' error which should be handled the same way as
> '-ENOENT' error. The same applies to reset_get_bulk() and 'ENOTSUPP'.
> 
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
> Changes for v2:
> - Changed logic style from !(== || ==) to (!= && !=)
> 
>   drivers/usb/host/ohci-generic.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
> index ceed1911a9..8740094afc 100644
> --- a/drivers/usb/host/ohci-generic.c
> +++ b/drivers/usb/host/ohci-generic.c
> @@ -28,7 +28,7 @@ static int ohci_usb_probe(struct udevice *dev)
>   	int err, ret;
>   
>   	ret = clk_get_bulk(dev, &priv->clocks);
> -	if (ret && ret != -ENOENT) {
> +	if (ret && ret != -ENOENT && ret != -ENOSYS) {
>   		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
>   		return ret;
>   	}
> @@ -40,7 +40,7 @@ static int ohci_usb_probe(struct udevice *dev)
>   	}
>   
>   	err = reset_get_bulk(dev, &priv->resets);
> -	if (err && err != -ENOENT) {
> +	if (err && err != -ENOENT && err != -ENOTSUPP) {
>   		dev_err(dev, "failed to get resets (err=%d)\n", err);
>   		goto clk_err;
>   	}
> @@ -72,7 +72,7 @@ reset_err:
>   		dev_err(dev, "failed to release resets (ret=%d)\n", ret);
>   clk_err:
>   	ret = clk_release_bulk(&priv->clocks);
> -	if (ret)
> +	if (ret && (ret != -ENOSYS))

The extra parenthesis are not needed I think, the rest of the patch 
seems OK, thanks !
