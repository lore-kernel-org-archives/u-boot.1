Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AEFE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 09:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DACA89645;
	Fri,  6 Dec 2024 10:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cOcTOh+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B445C8963C; Fri,  6 Dec 2024 10:43:00 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C37B389655
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 10:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B69grvP2084789
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Dec 2024 03:42:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733478173;
 bh=NCiauMNaGhP4uzgX2Do92XuCYZZ0q7JN5E6/qtnNGEc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cOcTOh+o6ni+/OhkYm7HNvcTASjnQhA0tbOtepyqr4DY4AGDVI442I8WTv3tta252
 K2f/140pISijvJ9vYegT3Gztkldvy+J+eoQtkfrsivw/jbG1lLY1tSoEnvt5AqH9Tr
 N6YGbXXSre6y2Pj5Aa6oNsFDuLnyzp3lpx78CJ9I=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B69gr1Z095498;
 Fri, 6 Dec 2024 03:42:53 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 03:42:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 03:42:53 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B69goqr123867;
 Fri, 6 Dec 2024 03:42:51 -0600
Message-ID: <1264338d-8a4d-4df7-9c2b-ed55d8d247ad@ti.com>
Date: Fri, 6 Dec 2024 15:12:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] ufs: core: sync ufshci.h with Linux v6.12
To: Neil Armstrong <neil.armstrong@linaro.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <bmeng.cn@gmail.com>, <venkatesh.abbarapu@amd.com>, <u-boot@lists.denx.de>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
 <20241120-topic-ufs-cleanup-v1-6-a5cef54b1cdc@linaro.org>
From: Neha Malcom Francis <n-francis@ti.com>
Content-Language: en-US
In-Reply-To: <20241120-topic-ufs-cleanup-v1-6-a5cef54b1cdc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 20/11/24 14:52, Neil Armstrong wrote:
> Sync ufshci.h with the version found in the Linux v6.12
> version commit adc218676eef ("Linux 6.12").
> 
> It adds new defines, and moves defines to the same place
> as the Linux header.
> 
> No functional changes intended.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Acked-by: Neha Malcom Francis <n-francis@ti.com>


-- 
Thanking You
Neha Malcom Francis
