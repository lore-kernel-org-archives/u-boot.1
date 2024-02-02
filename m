Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29FDC4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F0087C76;
	Fri,  2 Feb 2024 13:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="I0rrj5ee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 950358753E; Fri,  2 Feb 2024 08:59:30 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E2487876
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 08:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706860767; x=1709452767;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cZjBE1ZgCt4LDaRSrJGzJ5B/CZjSaqBZmBWEnygvWu8=;
 b=I0rrj5eeCXlL2yyvO6cq6qicuCje56SWacXYSTVY69TD0DEU/oWpIlKK/LqwNfyA
 waRPfIyBEFaouwvLcHm0ztJqg0TJuIFGbtdDBk6PZsPplo+LNbTJ04uum1+p52FO
 ajxubS+c0tRjwvyllF/BlXpj8Te3QcmDhCJRXdeFEtc=;
X-AuditID: ac14000a-fbefe7000000290d-b6-65bca0df6f2c
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F8.B8.10509.FD0ACB56;
 Fri,  2 Feb 2024 08:59:27 +0100 (CET)
Received: from [10.0.0.19] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 2 Feb 2024
 08:59:25 +0100
Message-ID: <6b162651-df07-4ddc-a763-ef75cdfee4b1@phytec.de>
Date: Fri, 2 Feb 2024 08:59:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <u-boot@lists.denx.de>
References: <20240129091314.925120-2-w.egorov@phytec.de>
Subject: Re: [PATCH 1/2] board: phytec: am64x: Add PHYTEC phyCORE-AM64x SoM
Content-Language: de-DE
CC: Wadim Egorov <w.egorov@phytec.de>
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20240129091314.925120-2-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWyRpKBR/f+gj2pBivnqFi83dvJ7sDocfbO
 DsYAxigum5TUnMyy1CJ9uwSujL5bx1gLFjFVbOm6wNzA+Iyxi5GTQ0LARGLO/edANheHkMBi
 JonPy6+wgiSEBG4ySlx+IAhi8wrYSKw+so4ZxGYRUJF4tek3M0RcUOLkzCcsILaogLzE/Vsz
 2EFsEQEpiZedG4FqOIDmWEjcfMsHEhYW8JZY8WUa2F5mAXGJTc++s0LYqhJTZ5wHi7MJaEnc
 2TIXrJVTwFKib4sxRImFxOI3B9khbHmJ7W/nMENcqSAxe9tkqFfkJaade80MYYdKHNm0mmkC
 o/AsJIfOQrJ5FpKxs5CMXcDIsopRKDczOTu1KDNbryCjsiQ1WS8ldRMjKLBFGLh2MPbN8TjE
 yMTBeIhRgoNZSYR3pdzOVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtS
 i2CyTBycUg2McdxH12r+bzpxz+SmTFii/dWLcicVbig9+j2/vVjXQ942bs2C5KwDrn2L972+
 H7GjtiBj1Qf+i40moTrtFY+WLfTOZP/E3PyF7ZCHAd+PxZuenPGUaAhIb5i9+I2D0f0r2k+m
 PL+U//RnK4Nlrci6w/PlHWcsnbtmxnE9R+WQv2/SXLPe3dRnV2Ipzkg01GIuKk4EAOlPvSJa
 AgAA
X-Mailman-Approved-At: Fri, 02 Feb 2024 13:31:24 +0100
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

Hey Wadim,

just trying to give you feedback through the archived mail. (That's why 
the content is missing).

The R5 config has 0x800 as value for 
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR. This offset wasn't changed 
upstream and the TI EVM still uses 0x400.

Regards,
Daniel

