Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D85C3DA4E
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 15:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C76E86B8B;
	Thu, 17 Aug 2023 17:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CtbzepRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49AC86B8E; Thu, 17 Aug 2023 17:57:35 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D99786B8B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HFvR0X004722;
 Thu, 17 Aug 2023 10:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692287847;
 bh=gUgXF+390nFCXQlhSi9BTxF8XUwooddwC2uPZkPYi50=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=CtbzepRToV4ZalqcKNnJcZmdzydFxK/TJVjz2csTOWT+b5Wz0EelOxC0KJoQIIZHZ
 sbc+BaQA5zyA+e55ZsU8X5ZKmL6ZF8bYA5Rkd5FjXYomVp5B8gvagaAb2gnF7l279J
 fcurELnFNhWVj/T9wSEHIdWihMgWTpX/qWq5VtVw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HFvRSd015498
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Aug 2023 10:57:27 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 10:57:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 10:57:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HFvRjV068224;
 Thu, 17 Aug 2023 10:57:27 -0500
Date: Thu, 17 Aug 2023 10:57:27 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <bhupesh.sharma@linaro.org>,
 <marek.vasut@mailbox.org>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <sjg@chromium.org>, <trini@konsulko.com>
Subject: Re: [PATCH] MAINTAINERS: Update UFS maintainer
Message-ID: <20230817155727.aoorzjdc44hzb2ef@unknowing>
References: <20230817120914.144240-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817120914.144240-1-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 17:39-20230817, Neha Malcom Francis wrote:
> Dropping Faiz Abbas from the UFS maintainer list as his e-mail ID is no
> longer valid.
> 
> Adding Bhupesh Sharma who has been using this framework working on
> Qualcomm Snapdragon SoCs as well as sending out fixes.
> 
> Adding myself as well to support in reviewing and testing patches.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Nishnath Menon <nm@ti.com>

Thanks for mixing my name up, but other than that, for what ever it is
worth..

Reviewed-by: Nishanth Menon <nm@ti.com>
> ---
> Based on discussion:
> https://lore.kernel.org/u-boot/CAH=2NtzyQgximynKuG45UUux715Du=WKKusm9-aQGHcUZsWzSw@mail.gmail.com/
> 
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77a8b0ac21..d19e1fd60b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1585,7 +1585,8 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
>  F:	drivers/mtd/ubi/
>  
>  UFS
> -M:	Faiz Abbas <faiz_abbas@ti.com>
> +M:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +M:	Neha Malcom Francis <n-francis@ti.com>
>  S:	Maintained
>  F:	drivers/ufs/
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
