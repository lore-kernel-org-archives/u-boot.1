Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBABEB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 11:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6739988F6F;
	Tue, 10 Sep 2024 13:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Wi2dZprD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFA38902A; Tue, 10 Sep 2024 13:37:12 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41AA988E82
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 13:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48ABb3nL039655;
 Tue, 10 Sep 2024 06:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725968224;
 bh=AK5zNt02K/WHLo1iufq4MOneuD4pop8+1JeQ/wKVZv0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Wi2dZprDe04HJXohCmML9BTSKNvA7C0EjhQnno9BZ4/dzI1lSaZ/LtXJzNwnzdbt6
 9KCJgmiVgomVKltwxsMXnhfQ0TLTSe6rYvuuTr4WeZlSBVOr9icq5GWZTinPMntIvo
 l1Pp9nTmDMmQ3Tra66uH5ZFMV1HJ5oDVVP2Q3Fp0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48ABb3ba066952
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Sep 2024 06:37:03 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 06:37:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 06:37:03 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48ABb1tM113882;
 Tue, 10 Sep 2024 06:37:02 -0500
Message-ID: <966d1ebd-b1cd-4472-972d-3f1a1f1afd48@ti.com>
Date: Tue, 10 Sep 2024 17:07:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] MAINTAINERS: Add myself to the list of UFS
 maintainers
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <20240910-topic-ufs-enhancements-v1-13-3ee0bffacc64@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-13-3ee0bffacc64@linaro.org>
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

Hi Neil

On 10/09/24 14:50, Neil Armstrong wrote:
> Adding myself to continue Bhupesh's work to enhance and fix UFS
> support in U-boot, especially for Qualcomm SoCs, and help review
> patches and maintain the UFS subsystem.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ab39d91a55..14809c057c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1707,6 +1707,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
>   F:	drivers/mtd/ubi/
>   
>   UFS
> +M:	Neil Armstrong <neil.armstrong@linaro.org>
>   M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
>   M:	Neha Malcom Francis <n-francis@ti.com>
>   S:	Maintained
> 

I am okay with this!

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
