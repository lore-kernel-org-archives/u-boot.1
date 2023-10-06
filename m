Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3F6E92FDF
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 04:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF4286B8B;
	Fri,  6 Oct 2023 06:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ezlMXlvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B51986C37; Fri,  6 Oct 2023 06:40:53 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F2386504
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 06:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3964eeTD093264;
 Thu, 5 Oct 2023 23:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696567240;
 bh=sCrXgFjjU9yy+W0F8Q4HquLfjj9gQC/CL/nCfnxMivU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ezlMXlvHn4p8cHY6c+ncuJBRenqibV2STmhUpKv9rzi70xejfztGSnJ9l0joYrnZh
 6RvAJvc8dVnY7AUwMex3BlFkHyXpqrqcvD/9zvrVOojtsFP7k8Ugb2T85Vu9KnnhjN
 JkVUy6jFqjow+wloSm5bBIGmlQZyl0xTXgdQqgvQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3964eewY042435
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 23:40:40 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 23:40:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 23:40:40 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3964eap9026158;
 Thu, 5 Oct 2023 23:40:37 -0500
Message-ID: <86e12e35-4544-4472-b1fc-571caecd5da7@ti.com>
Date: Fri, 6 Oct 2023 10:10:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j721e-sk/common-proc-board: Fix boot
To: Nishanth Menon <nm@ti.com>, <trini@konsulko.com>
CC: <vigneshr@ti.com>, <m-chawdhry@ti.com>, <sjg@chromium.org>,
 <jonas@kwiboo.se>, <afd@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>, Roger Quadros <rogerq@kernel.org>
References: <20231005181514.4054241-1-nm@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231005181514.4054241-1-nm@ti.com>
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

Hi Nishanth,

On 05/10/23 23:45, Nishanth Menon wrote:
> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node
> as pre-reloc after relocation") A53 u-boot proper is broken. This is
> because nodes marked as 'bootph-pre-ram' are not available at u-boot
> proper before relocation.
> 
> To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.
> 
> Fixes: 69b19ca67bcb ("arm: dts: k3-j721e: Sync with v6.6-rc1")
> Cc: Neha Francis <n-francis@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks for this patch!

Tested-by: Neha Malcom Francis <n-francis@ti.com>

(Tested on J721E-EVM and J721E-sk)

-- 
Thanking You
Neha Malcom Francis
