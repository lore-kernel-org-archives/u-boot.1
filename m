Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA2ECD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 17:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D61588312;
	Mon,  1 Apr 2024 19:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ENijRb/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37CC88319; Mon,  1 Apr 2024 19:04:20 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3438830F
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 19:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431H4Ese009867;
 Mon, 1 Apr 2024 12:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711991054;
 bh=dXoPqp9fqp5KnVgkVyr4YwSI6wzP/R531/ymbuO0c2k=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ENijRb/r12nxcqSQhXyWDCSdOI1owNetmuWPG6OmDyR9ii2qR2Edo3s3lG96AT1wB
 a2aiwl7zf8Jfl9+lPkj5/YWbj4GbiLj2q/OCP8VPW/JC1TWgT7E1NubLm8jij4q7jj
 VRtPXXmrRkbTX5Tt2pJX3jrUrViJVNw7W6IEmFHI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431H4EeH002430
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Apr 2024 12:04:14 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 12:04:14 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 12:04:14 -0500
Received: from [10.249.129.130] ([10.249.129.130])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431H4AS1071624;
 Mon, 1 Apr 2024 12:04:11 -0500
Message-ID: <e28ebc8e-38fd-42ff-91db-4717bc7b621b@ti.com>
Date: Mon, 1 Apr 2024 22:34:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: arm: dts: k3-j721s2-*-u-boot.dtsi: Enable the
 ospi0 node
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>
References: <20240401-b4-upstream-j721s2-ospi-support-v1-0-20e4a0024db9@ti.com>
 <20240401-b4-upstream-j721s2-ospi-support-v1-3-20e4a0024db9@ti.com>
Content-Language: en-US
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240401-b4-upstream-j721s2-ospi-support-v1-3-20e4a0024db9@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 01/04/24 11:16, Manorit Chawdhry wrote:
> Enable ospi0 node for all boot stages
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> index a3ebf5996eac..132cd5a456ba 100644
> --- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> @@ -110,7 +110,9 @@
>   };
>   
>   &ospi0 {
> -	status = "disabled";
> +	flash@0 {
> +		bootph-all;
> +	};
>   };
>   
>   &ospi1 {


Reviewed-by: Apurva Nandan <a-nandan@ti.com>

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

