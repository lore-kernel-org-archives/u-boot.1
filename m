Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAD8CEF177
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A4BA88ED5;
	Tue,  8 Oct 2024 15:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728395495;
	bh=mz+MLSy9NRhu32wW1wG9M+GcttChJeHih87wSLsQtRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AARzHX9uaaWEugzk6OtRQwZyG4J3GFZ7lRX6wk7B5P3BQ6WdUyuSxVZZ74yZ3RRT0
	 J3D3M8jycfG8XG9zqFASWmzbYj6P7HFlu/5v8SQgda7ftzPrtK4zmJEf3CbSorymX3
	 8D3KMHxQBvvCidZfdPQ5Y0kf0F1GBFG3PHyWgG5j812RHU+Na9BmrfM+yV+R/DKLAT
	 kRzLG0xMrS/r708ndq69qX5v9h+rfKSbZUVspTNDevEHZLZu6ZGmPaz9cU8i/CKh6B
	 k0bHMSmMRxVNkuH5ffMlHT1Am5hcV1lPyOSjjZF4CtE+/8A4adLTFVUccWbtM7Uwbg
	 h6jkYFy/VASTQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9CAED88D39;
 Tue,  8 Oct 2024 15:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728395494;
 bh=mz+MLSy9NRhu32wW1wG9M+GcttChJeHih87wSLsQtRg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bndv9pGdgEYlXAgywsewnUHz51cyj6zn4VjUVLOnFrrfPxYBnzC64SFdyPeDUb8KZ
 dTaebgp4ztulhPInQPKS2v9BPIpx8jGHnHHiUm5wMHdM8Au66sJ6RmNEyNVQ7Mmwyf
 O35n+uK7JPTxkfFrutpTz+IUgn/9Efpt+URiMfP4hmp7IJpTr8sdijCalaXbM5gtEY
 /xV82TP9sjm3Co4gVlZtfN9YVESMplMmkW36FpwgiSnwGbt2OefqZV4A9EkE7idepI
 gXrohXkmm+ejleSJyB6b3cfp83Kg4qmXQKhl85akZCrsqlzCN8UiNRXuGdUJetyGF4
 MO/uEtTRhx+4A==
Message-ID: <f3a4c5ad-5549-4dcf-aff4-a5e3031c2dd8@denx.de>
Date: Tue, 8 Oct 2024 15:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] usb: onboard-hub: Add i2c initialization for
 usb5744 hub
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
 <20241008045808.28757-5-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241008045808.28757-5-venkatesh.abbarapu@amd.com>
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

On 10/8/24 6:58 AM, Venkatesh Yadav Abbarapu wrote:

[...]

> @@ -95,6 +198,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   static const struct onboard_hub_data usb5744_data = {
>   	.reset_us = 10000,
>   	.power_on_delay_us = 10000,
> +	.init = usb5744_i2c_init,
Keep the list sorted.
