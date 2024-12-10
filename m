Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1C9E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 17:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD90802DF;
	Tue, 10 Dec 2024 18:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="qWS15Tx4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA32802E3; Tue, 10 Dec 2024 18:17:28 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B768A80288
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2074364ab7=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAD5235026243;
 Tue, 10 Dec 2024 18:17:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 rnxsu1BIfQD+GSLzppQLNK2Z1aU6g528q1B7AS1MLAQ=; b=qWS15Tx4aSz7XWn3
 yygqdVYjMj2L4tc5m6lZSYz/8QzzfhaSdkOw4CzYMeU4Lby21TTinEp+ZV3ucc3T
 UaoJ0awNlJNhWeSruFGzJFqQu22Ec3bQiOFFiOLkg3xClYTi6fBEziPNUIGM6QEs
 FB/tL/U3bvY0FE29K4kwjUWwQBdUnZLgwSatQH8MgfjhIHpxqqmqAc3VlkSbUzKl
 iUHUkC2HnoOEidDTqA2vnWV8KhMN7uFtvzz14u95wJcgxMzdXmYbDHBjDy5/RZGQ
 xRw+p4mFbVadhpLBYOe0TJXzSG4GuzV1dAnsN62QiiuWSOxkR2ng/uPvGAWIXgQe
 4UVtyA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43cek1ws4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 18:17:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9D37E40048;
 Tue, 10 Dec 2024 18:16:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F27132727E9;
 Tue, 10 Dec 2024 18:16:08 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Dec
 2024 18:16:08 +0100
Message-ID: <81878c6e-b9e4-46c2-a374-465317e2e889@foss.st.com>
Date: Tue, 10 Dec 2024 18:16:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: onboard-hub: Update the bind function based on
 peer-hub property
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
References: <20241204072520.213949-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20241204072520.213949-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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



On 12/4/24 08:25, Venkatesh Yadav Abbarapu wrote:
> As the "peer-hub" property is optional, don't error out just
> skip the bind function.
> 
> Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is already probed")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Removed the peer_hub variable and used the return value.
> Changes in v3:
> - Removed the else condition.
> ---
>  common/usb_onboard_hub.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6f28036e09..7fe62b043e 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -183,7 +183,12 @@ static int usb_onboard_hub_bind(struct udevice *dev)
>  	int ret, off;
>  
>  	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
> -	if (ret)  {
> +	if (ret == -ENOENT) {
> +		dev_dbg(dev, "peer-hub property not present\n");
> +		return 0;
> +	}
> +
> +	if (ret) {
>  		dev_err(dev, "peer-hub not specified\n");
>  		return ret;
>  	}

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>

Tested on STM32MP157C-DK2 board

Thanks
Patrice
