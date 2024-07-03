Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337CEC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 17:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9464088814;
	Wed,  3 Jul 2024 19:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tSmQ8od9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC9088842; Wed,  3 Jul 2024 19:17:23 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A0188835
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 19:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720027041; x=1722619041;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5VChqJLL/yfEmuFDvyDFUy8Tjd03lPRiwB4HFJJXzjg=;
 b=tSmQ8od97yW8ZcUDt6SISXJvWTEvo7Pj/d8t4zToGVZ1o3MJYJ0sRpcRQvWgd7BW
 tAfw/doGsz72dWFgq5ITcV4gk471SpT4DCnfZiDk5UjHDyCVTleTUBzeQjdfFwVL
 DVvwWnPxqBrBaqLKxZwaCdBsVUoPWHOJlfkiCbRpn58=;
X-AuditID: ac14000a-03251700000021bc-d4-668587a0ff4c
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A4.C2.08636.0A785866;
 Wed,  3 Jul 2024 19:17:20 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 19:17:19 +0200
Message-ID: <685c5646-bdef-462f-b287-dece856ceab1@phytec.de>
Date: Wed, 3 Jul 2024 19:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Generalize PHYTEC Overlay Handling
To: Daniel Schultz <d.schultz@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, <trini@konsulko.com>, <m.othacehe@gmail.com>,
 <joe.hershberger@ni.com>, <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWyRpKBR3dBe2uawap2U4uWtR4WD6/6W3za
 +ZjVYsbNaWwWL47NZbf4tmUbo8XUSZvZLd7u7WS36H6n7sDp8f5GK7vH7IaLLB47Z91l93h1
 YBW7x9k7Oxg9+rtbWD2un9nO5HH8xnamAI4oLpuU1JzMstQifbsErowDLdtYCjZwVfSsn8rS
 wLiSo4uRk0NCwETi2KGFjF2MXBxCAkuYJJpnrGWGcO4wShxfeJIFpIpXwEbiSmcjE4jNIqAi
 saFrMitEXFDi5MwnYDWiAvIS92/NYO9i5OAQFrCWOLKrEmSOiMA+Rolrh3vAapgFYiQm/frM
 BFIjJGAlsfCPOURYXOLWk/lg49kE1CXubPgGNp4TaMzk38+ZIWosJBa/OcgOYctLbH87Bywu
 BGS/uLScBeIZeYlp514zQ9ihElu/bGeawCg8C8mls5Csm4Vk7CwkYxcwsqxiFMrNTM5OLcrM
 1ivIqCxJTdZLSd3ECIo2EQauHYx9czwOMTJxMB5ilOBgVhLhlXrfnCbEm5JYWZValB9fVJqT
 WnyIUZqDRUmcd3VHcKqQQHpiSWp2ampBahFMlomDU6qB0TrCb5XqxllhFjfStr8s2Nyn2F/F
 YhZvmeuwe572nEmHDQRcmBcbi9iZ/dpzYeMURRneHfWv17ibpr7ev9ws2Z3N58inx/PKuljO
 PrrFsqZFcb34/zfXnhxYcXcrc8/X2U+FRb6t5fDQUJy24WmX5bfYDcwb8njrDvaturvhcdFN
 89+LLzrM8lViKc5INNRiLipOBAABHgS7pAIAAA==
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



Am 03.07.24 um 07:41 schrieb Daniel Schultz:
> The overlays are specified in the bootenv.txt file that is loaded into
> the environment. Then these overlays get loaded and applied via a script.
> These scripts for loading and applying devicetree overlays are identical
> for many phytec boards.
> Create a common overlays.env that can be included.
> Add support for devicetree overlays to phycore-imx8mp and include the
> overlays.env for phycore-imx93.
> Rename existing environment variables according to bootstd doc.
> Move MMC boot logic into a common k3_mmc.env file and include the new
> overlays.env file as well.
> 
> Benjamin Hahn (5):
>    include: env: phytec: Create env file for loading and applying
>      overlays
>    phycore-imx8mp: Add overlay and bootenv.txt support
>    phycore_imx93: include common overlays.env
>    board: phytec: renaming of variables according to bootstd doc
>    include: env: phytec: renaming of variables according to bootstd doc
> 
> Daniel Schultz (4):
>    include: env: phytec: Add common mmc boot for K3 SoMs
>    include: env: phytec: k3_mmc: Apply overlays during boot
>    board: phytec: phycore_am62x: Use k3_mmc.env logic
>    board: phytec: phycore_am64x: Use k3_mmc.env logic

For this series,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
