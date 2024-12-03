Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D4AE74AC2
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 16:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA91B893F9;
	Tue,  3 Dec 2024 17:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733243464;
	bh=uHg6a0CKwhk31d9naAs5Bd5d5yea3R1O8WtzJTqifQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3EwMuEO18AtRK24FV55ZMugmBbC/4gvcDqHJ6y9hGvdQyCSyBR5llJSS62IZ5R2c
	 aTtmXwv0KcwGABjvoIdiyLVT0Pq+mYBksHgHu7u9r4KQnb0W9gZDOTQnXmIgakzlIE
	 +kzEDEtVsyVkf3E8oGWL7SijTqRYikADgazyhlVVaHQxmoCsFzI62GHFeObCLXLsbn
	 PL5cXIArCcrLwn9zUcYvwoH4TvLRKe8b103zfmmdrhRY5boeCaVmou/wULSghPAj/b
	 3yrp9qcDXooxIcvwsBq6+Y6yrJ+flneNISDyBqpxCBlGRlu6sUa4Y9xRiPRodarU6A
	 +Yb8Sj/4Gpqpw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B8FA78926A;
 Tue,  3 Dec 2024 17:31:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733243464;
 bh=uHg6a0CKwhk31d9naAs5Bd5d5yea3R1O8WtzJTqifQA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PyxCE1OXPb/5bRWSNTrSr1O60M1i3wRIuFTrqqLoFY2jMDr11iBOO+TMXVMoLYoCm
 IXRUsJ9AJC4Tr4HoHNrS65i1sw57ZxfN0SRyDc47DrI9FMciPjsvxtD6eYMnuDBWym
 89KQHNKzq/M+KqdzOfLhOiOwflRUcIm9cWitgNaSDCEMuMR/wxaLoW1yza2aWns+I3
 i2i5Q/3P+9qFKbz9itFB9t1ePGinfrQubI53yCrwapuP6nh16OMBs0brXA+0zMJWkX
 NZeAvqjvQVamVVqs3xOzuZgJuApl+KHESvShxx3N8brRqjOslc87sPokushhDmX9pw
 Q6mwEN+Qxqdww==
Message-ID: <05739e08-f83e-48db-9c83-cf93f394bb6b@denx.de>
Date: Tue, 3 Dec 2024 17:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: onboard-hub: Update the bind function based on
 "peer_hub" property
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241203044950.119197-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241203044950.119197-1-venkatesh.abbarapu@amd.com>
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

On 12/3/24 5:49 AM, Venkatesh Yadav Abbarapu wrote:
> Add the bool variable "peer_hub" and set this only for the
> hubs which have the "peer-hub" property in their DT nodes.
> Skip the bind function for usb hubs which don't have "peer-hub"
> property.
> 
> Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is already probed")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/usb_onboard_hub.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6f28036e09..0a8fac38ee 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -26,6 +26,7 @@ struct onboard_hub {
>   
>   struct onboard_hub_data {
>   	unsigned long reset_us;
> +	bool peer_hub;
>   	unsigned long power_on_delay_us;

Move the bool here , so it is not between the two delay descriptors.

>   	int (*init)(struct udevice *dev);
>   };
> @@ -178,10 +179,15 @@ err:
>   
>   static int usb_onboard_hub_bind(struct udevice *dev)
>   {
> +	struct onboard_hub_data *data =
> +		(struct onboard_hub_data *)dev_get_driver_data(dev);

Is the cast necessary ?

[...]
