Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1507DC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B1682F49;
	Fri,  4 Jul 2025 18:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ok0jItvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21CAC82F6D; Fri,  4 Jul 2025 18:29:16 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DDBD82F49
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 18:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 564GTAS0319958;
 Fri, 4 Jul 2025 11:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751646550;
 bh=GD96hiU50+KHFRab7TD9S56pWSV8gU/gzS1LQ/BF6xI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ok0jItvBCrkDXDkW0NeoC3z9Nm9XZQWhywwRhCNZDEXZ2rk/cMchftJJCW87E+cS/
 OvmWVkWm5HjIqjOmVqNn7QN9Yd31TO2+c1OMUAOH4tKzgcDTeQs12cePwhGs34RE0E
 9GE+KPqg6uxhV8RD1ABmeN3Lklyf4zVZO2n/0fZ4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 564GTAjd1910911
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 4 Jul 2025 11:29:10 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 4
 Jul 2025 11:29:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 4 Jul 2025 11:29:10 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 564GT6LI3060207;
 Fri, 4 Jul 2025 11:29:07 -0500
Message-ID: <51e3b24c-d8d3-4633-8465-e9f0f95ad51e@ti.com>
Date: Fri, 4 Jul 2025 21:59:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: ti: Clean up formatting in rm-cfg.yaml
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <afd@ti.com>
References: <20250704091234.3218906-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250704091234.3218906-1-n-francis@ti.com>
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


On 7/4/2025 2:42 PM, Neha Malcom Francis wrote:
> Move to using the latest generated RM YAML configuration files generated
> by the K3 Resource Partitioning Tool which updates them to have standard
> formatting with respect to indentation.
>
> These files were generated from the untagged commit 41718bd5f915 ("docs: Update
> docs and move them to docs folder") of the K3 Resource Partitioning tool. This
> tool is packaged as a part of the public SDK and is not otherwise
> publicly available.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20250702105533.1533178-1-n-francis@ti.com/
> - commit message changed to include the generated tool commit (Udit)
>
> Boot logs:
> https://gist.github.com/nehamalcom/73c1c66d674c32f71a6ade8049c97d21
> [..]
