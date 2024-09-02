Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DE3CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 18:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DBE488C9F;
	Mon,  2 Sep 2024 20:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725303552;
	bh=ed8+2RiuJzBcRkrpfCxrgVSUAztuo01zE3GyKFnPlwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=myHVHg/depXU1AAKhRcnLED03FjEhJuZyqsEtp+xRn878B2lEFlhxwckSdJgSWMKu
	 Nd8jtLZ7WgWZjYXX84WU6HF4O9XYjXn0+UjGHd/99lV9SdFhQiE0AjPwu1zoOlj20h
	 7XOC4wfUGPyXNnVBCUujBQsXcPtN3SPbctT3r24Lm1Am+3Ds3pl27aN9rV0kjXJ/ZX
	 tqW2LeWrZkXcAz5mkMmWX9sLHu+eFBXgVQUZcEqBuh8qG9eh5cAA9PB+kroff6XbMe
	 nFkfiqaK6O2PrsUAinPxptmBP4WPcX9VFKbL4T7bcqhbEzkXxUkb9notrlYxb7wdHE
	 6nObH3/BYEKXw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A09BE88C3E;
 Mon,  2 Sep 2024 20:59:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725303551;
 bh=ed8+2RiuJzBcRkrpfCxrgVSUAztuo01zE3GyKFnPlwc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vBF266YKG56ubuQOsHezNcJd+kwLEa01FPIqONeb/38tGRKohtLq8qbWJi2rVatZo
 XCx72YpvmoNaSSCQ9M3jw+vf5AODh8di6ZTQNWDOnKYh5/Axa2q5a7t8hkLD+dTUq/
 lV7P8FgR2JD+aLjYaddaFAq94sPVHdzxDwcEcJ65T0nk8D/pZ1PY6lvXOppqhP75z4
 kNlNFW3a/wtHvVcq88QkxBs59lq5hSzeF9vpX1zwzHikASLei2o6cHSJToMjAcCcea
 2vAP9qNy1Re/YxoyP+1PG7LiSlQc+9tbUljujlbPd5BuvvIyhJJmVOXJssIliG4DCc
 aKi02Upj7F7gw==
Message-ID: <5dec905b-bd7c-4379-9e62-8e75a75880d5@denx.de>
Date: Mon, 2 Sep 2024 20:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
 <20240605100221.3571-3-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240605100221.3571-3-venkatesh.abbarapu@amd.com>
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

On 6/5/24 12:02 PM, Venkatesh Yadav Abbarapu wrote:
> Use the regulator API's only if the config DM_REGULATOR is enabled.
> Don't error out if there is no vdd regulator supply, as these are
> optional properties.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/usb_onboard_hub.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 2f6fb71935d..0cfaa90fce3 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -30,16 +30,22 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   	struct onboard_hub *hub = dev_get_priv(dev);
>   	int ret;
>   
> -	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
> -	if (ret) {
> -		dev_err(dev, "can't get vdd-supply: %d\n", ret);
> -		return ret;

Handle -ENOSYS (regulator support not available) return value here and 
you wouldn't need all the ifdeffery.
