Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B63CD32D8E
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 10:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B7189428;
	Tue, 12 Nov 2024 11:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ykrDmCPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37EA388A3C; Tue, 12 Nov 2024 11:54:33 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2F788A3C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:54:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=104698dab8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC81aZX028152;
 Tue, 12 Nov 2024 11:54:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 DRK+clDQPRD4kpho0KNV/90HxTKfQoVcKHBEgf5XkiY=; b=ykrDmCPegd0uelSM
 16nrCpX7HNDKOP00jqN956LiyhBxKdJqoDwXwzFA+fEW7q7jRFRE9mhAYRJel8pR
 PvrmvHDmuRg+Pb72J3NRy4XoBMdo3D7geLl6AFILqj6My90S/t+iYI0vS7eSpDqO
 kF4gysBC+GjjEHMhf36yQNSz7FYwd67wNb7BRSTkZ61/4VCJzE1mheIhzr6XetrT
 hQohhbWeQT432pp0ixZ9FDQMTeSx2IHV+P/F5ZKc2yKKcrn0kHkg0750PXLaipko
 NBm1hoG1h2n2pO/yf9YTQ0ZeUUnngr7RQBaNAf7hUHj1UO76GH35/9n7WfzPA2Dl
 dzbGSA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42syy1km9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 11:54:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4E4DC40056;
 Tue, 12 Nov 2024 11:53:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5C086287715;
 Tue, 12 Nov 2024 11:52:45 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 11:52:44 +0100
Message-ID: <40bfaf76-e65c-46de-a4bb-430423f7bb44@foss.st.com>
Date: Tue, 12 Nov 2024 11:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] lib: uuid: fix uuid_str_to_bin() on 32-bit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
CC: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Raymond Mao
 <raymond.mao@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-4-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241103224223.195255-4-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
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


On 11/3/24 23:42, Heinrich Schuchardt wrote:
> hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
> Use function hextoull() instead.
>
> Reported-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Fixes: 22c48a92cdce ("lib: uuid: supporting building as part of host tools")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	new patch
> ---
>   lib/uuid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 19f33dd1477..538a1ba6aa8 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -313,7 +313,7 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
>   	tmp16 = cpu_to_be16(hextoul(uuid_str + 19, NULL));
>   	memcpy(uuid_bin + 8, &tmp16, 2);
>   
> -	tmp64 = cpu_to_be64(hextoul(uuid_str + 24, NULL));
> +	tmp64 = cpu_to_be64(hextoull(uuid_str + 24, NULL));
>   	memcpy(uuid_bin + 10, (char *)&tmp64 + 2, 6);
>   
>   	return 0;


Tested-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

