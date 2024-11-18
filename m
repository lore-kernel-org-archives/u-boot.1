Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD838D10F57
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 05:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26E08918E;
	Mon, 18 Nov 2024 06:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t4UTVRJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12DE89294; Mon, 18 Nov 2024 06:12:19 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 693928914D
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AI5CFxD3587055
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Nov 2024 23:12:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731906735;
 bh=KB4hkRNfuV/TG2UXUxN1jhQgA9N0bgqzSkQHfp+ni0k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=t4UTVRJb9fHCaj+tOUoXn/CIlOOyNiviJEtSsjYCg6tvyNIXRz6YfxD8REVj72Wlm
 ks9y3wSFvRoLgVlDa8RBtdCWOombXHz6a6KTVZfV5NvEQI8U0fHdGikau/g1CpqSOZ
 qtvrBAIC6vYAngoMQZoe8jbrtcQzqnc3mQCctv7Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AI5CFbj079819
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 17 Nov 2024 23:12:15 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 17
 Nov 2024 23:12:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 17 Nov 2024 23:12:14 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AI5CEYE017556;
 Sun, 17 Nov 2024 23:12:14 -0600
Date: Mon, 18 Nov 2024 10:42:13 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Aniket Limaye <a-limaye@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH v3 3/5] misc: k3_avs: Check validity of efuse voltage data
Message-ID: <20241118051213.gylueeryq3fnurfb@uda0497581>
References: <20241116071615.839623-1-a-limaye@ti.com>
 <20241116071615.839623-4-a-limaye@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241116071615.839623-4-a-limaye@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Aniket,

On 12:45-20241116, Aniket Limaye wrote:
> From: Reid Tonking <reidt@ti.com>
> 
> k3_avs driver checks opp_ids when probing and overwrites the voltage
> values in vd_data for the respective board. The new k3_check_opp() can
> be called from board files to check the efuse data and returns 0 if
> valid.
> 
> Also add the same check in k3_avs_program_voltage() to error out if
> the efuse data was not valid.
> 
> Signed-off-by: Reid Tonking <reidt@ti.com>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
[..]
>  
> +/**
> + * k3_check_opp: Check for presence of opp efuse
> + * @opp_id: opp id to check if voltage is present

Could you document vdd_id as well which is another input to the function?

> + *
> + * Checks to see if an opp has voltage. k3_avs probe will populate
> + * voltage data if efuse is present. Returns 0 if data is valid.
> + */
> +int k3_check_opp(struct udevice *dev, int vdd_id, int opp_id)

Regards,
Manorit
