Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512FAC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 10:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C39A871CC;
	Fri,  1 Dec 2023 11:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="NMXnGW3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D130875FE; Fri,  1 Dec 2023 11:05:59 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B76E5871CC
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 11:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0699fcb2c2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3B170Ako006209; Fri, 1 Dec 2023 11:05:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=sa9baaoEFFB2DDCxrLAawjeDUt0oi/8TScTDjHRK2dM=; b=NM
 XnGW3Au5YQpCxPfbXxcq3YYkmVgPAiEJa3aYgYmk4C3qI9RryHC9UNjQsBMktamk
 UVeZEtBGB5BH+VQ//wnZrSp2uFAycFyX4jRlBFdZgP9UBiDqtIkXqKy73N5t7ntS
 gzTu9/coXF9Qvd9o+wjz/edv/S+uD6lEu3PF70UxvDl795EaayFP+kH6Iefwduyj
 CJbXU61Mp7Xne/RDGSKVWGp/DVaQ9/w5qG8tCBEnd6On2OTpks4fiDNBuq/qKyFZ
 3odVZI4xJ+blWGzhoj384cyo235y7bfPq7jXKdxUlCkgGYdoHRFPuxssWdpuU8zI
 YLMDnXs+jMbIQYru40og==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3unffbekcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Dec 2023 11:05:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 46998100079;
 Fri,  1 Dec 2023 11:05:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3F54D214D14;
 Fri,  1 Dec 2023 11:05:55 +0100 (CET)
Received: from [10.252.6.183] (10.252.6.183) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Dec
 2023 11:05:54 +0100
Message-ID: <4e22ffe4-c275-43de-a8be-3a1dc9f931ac@foss.st.com>
Date: Fri, 1 Dec 2023 11:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tee: optee: don't enumerate services if there ain't
 any
Content-Language: en-US
To: Etienne Carriere <etienne.carriere@foss.st.com>, <u-boot@lists.denx.de>
CC: Jens Wiklander <jens.wiklander@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
References: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
 <20231129123753.1906956-2-etienne.carriere@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231129123753.1906956-2-etienne.carriere@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.6.183]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_07,2023-11-30_01,2023-05-22_02
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



On 11/29/23 13:37, Etienne Carriere wrote:
> Change optee driver service enumeration to not enumerate (and
> allocate a zero sized shared memory buffer) when OP-TEE
> reports that there is no service to enumerate.
> 
> This change fixes an existing issue that occurs when the such zero
> sized shared memory buffer allocated from malloc() has a physical
> address of offset 0 of a physical 4kB page. In such case, OP-TEE
> secure world refuses to register the zero-sized shared memory
> area and makes U-Boot optee service enumeration to fail.
> 
> Fixes: 94ccfb78a4d6 ("drivers: tee: optee: discover OP-TEE services")
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>  drivers/tee/optee/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 5308dd58ce..47f845cffe 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -139,6 +139,11 @@ static int enum_services(struct udevice *dev, struct tee_shm **shm, size_t *coun
>  	if (ret)
>  		return ret;
>  
> +	if (!shm_size) {
> +		*count = 0;
> +		return 0;
> +	}
> +
>  	ret = tee_shm_alloc(dev, shm_size, 0, shm);
>  	if (ret) {
>  		dev_err(dev, "Failed to allocated shared memory: %d\n", ret);
> @@ -185,14 +190,15 @@ static int bind_service_drivers(struct udevice *dev)
>  
>  	ret = enum_services(dev, &service_list, &service_count, tee_sess,
>  			    PTA_CMD_GET_DEVICES);
> -	if (!ret)
> +	if (!ret && service_count)
>  		ret = bind_service_list(dev, service_list, service_count);
>  
>  	tee_shm_free(service_list);
> +	service_list = NULL;
>  
>  	ret2 = enum_services(dev, &service_list, &service_count, tee_sess,
>  			     PTA_CMD_GET_DEVICES_SUPP);
> -	if (!ret2)
> +	if (!ret2 && service_count)
>  		ret2 = bind_service_list(dev, service_list, service_count);
>  
>  	tee_shm_free(service_list);
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
