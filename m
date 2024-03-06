Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A399FC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 12:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5B287FF5;
	Wed,  6 Mar 2024 13:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mAeckpsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2864879BB; Wed,  6 Mar 2024 11:46:31 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D898780A
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 11:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-jain1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426AkGjW081058;
 Wed, 6 Mar 2024 04:46:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709721976;
 bh=N3r3o22cZp6UGq3BDpvfKea4IrW5oGJAaIO7/7jeh5k=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mAeckpsi9KVpmIly4uZ4fXcXGg+Wx1WNuNnTkqmgqvu2bqz0iNM71eCKyaiME2ULf
 Sud3oTvqYvBxefTpBqiBIHyhQU9tdu2qLWR3FFpvCexkJYB0re9Mgmk8ySlyGU2k2O
 E4HvjJUT5Ume5s2XSkDSeq6VInpg/EHsjSBVHaL0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426AkGaA026852
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 04:46:16 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 04:46:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 04:46:15 -0600
Received: from [172.24.227.70] (a0503533.dhcp.ti.com [172.24.227.70])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426AkAQb072616;
 Wed, 6 Mar 2024 04:46:10 -0600
Message-ID: <323cfe8a-ab8d-491d-af98-db839bb90484@ti.com>
Date: Wed, 6 Mar 2024 16:16:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] video: Assume video to be active if SPL is passing
 video hand-off
Content-Language: en-US
To: Devarsh Thakkar <devarsht@ti.com>, <u-boot@lists.denx.de>,
 <sjg@chromium.org>, <agust@denx.de>, <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
 <20240222130811.3878567-3-devarsht@ti.com>
From: Nikhil Jain <n-jain1@ti.com>
In-Reply-To: <20240222130811.3878567-3-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 06 Mar 2024 13:09:02 +0100
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

Hi Devarsh,

On 22/02/24 18:38, Devarsh Thakkar wrote:
> If SPL is passing video handoff structure to U-boot then it is safe to
> assume that SPL has already enabled video and that's why it is passing
> video handoff structure to U-boot so that U-boot can preserve the
> framebuffer.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  drivers/video/video-uclass.c | 4 ++++
>  1 file changed, 4 insertions(+)
Reviewed-by: Nikhil M Jain <n-jain1@ti.com>
>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index 3571e62ba2..7b5d1dfbb3 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -404,6 +404,10 @@ bool video_is_active(void)
>  {
>  	struct udevice *dev;
>  
> +	/* Assume video to be active if SPL passed video hand-off to U-boot */
> +	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL)
> +		return true;
> +
>  	for (uclass_find_first_device(UCLASS_VIDEO, &dev);
>  	     dev;
>  	     uclass_find_next_device(&dev)) {

Thanks,

Nikhil

