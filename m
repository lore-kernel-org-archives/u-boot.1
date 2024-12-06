Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B52CE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 09:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBC58963C;
	Fri,  6 Dec 2024 10:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S4ueU2IX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B159389644; Fri,  6 Dec 2024 10:41:10 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9AB89639
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 10:41:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B69f4HJ037990;
 Fri, 6 Dec 2024 03:41:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733478064;
 bh=T/G1tkd5oAhTg8HPCuLpmErVox1AOoVpEOnvsytHcKw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=S4ueU2IXcjHdopgJfYYr6efUAZ1xJRwNCDY0MZWk4n5CZv3Sqm9klV0AFzAFx/B53
 dkSJnxihVk+V48g/sQoFL9Vt6gKLpU2qk83h7UgaO2vv/xKkSzyvVTcDSYknZa3cA4
 wSex8D3kPReeKe8cOlRyuI0wGi04sEBty4zxgkPE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B69f3os094445;
 Fri, 6 Dec 2024 03:41:03 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 03:41:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 03:41:03 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B69f0Kr121359;
 Fri, 6 Dec 2024 03:41:01 -0600
Message-ID: <2b049fc6-5fcb-43b4-b0df-f63da9f6f2d7@ti.com>
Date: Fri, 6 Dec 2024 15:11:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] ufs: core: sync unipro.h with Linux v6.12
To: Neil Armstrong <neil.armstrong@linaro.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <bmeng.cn@gmail.com>, <venkatesh.abbarapu@amd.com>, <u-boot@lists.denx.de>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
 <20241120-topic-ufs-cleanup-v1-5-a5cef54b1cdc@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-5-a5cef54b1cdc@linaro.org>
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
> Sync unipro.h with the version found in the Linux v6.12
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
