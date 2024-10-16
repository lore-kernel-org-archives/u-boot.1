Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906D7D2A53D
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 275B488CFB;
	Wed, 16 Oct 2024 20:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="LZ1ERI3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACB788C4A; Wed, 16 Oct 2024 20:33:21 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C3A88DA0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0019cf4dfa=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GDhLNj007049;
 Wed, 16 Oct 2024 20:33:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 oVI1gQzFUKbsTUyIawO8xDiG03qhZKXYN4t8VMoeY9Y=; b=LZ1ERI3nq2dA6Ccs
 zwY7LbwljAZe2Zm1UmvDztzlDPKJzclYgeoqz+f8shDAjk4iEPwDxcq7ortypcIt
 Bems93r+lR8yos7/CHiECiLDYXei+CRPTxiZThFt7ucHjWvybvz0lDF9bNX874Bp
 Cthxdzjw8A/N+PNBCYpx+Z6EskV73peV8NhIYe5mBGiBK5IBtYVx+f9eMO09k4Ry
 fGSzOMsPFXJdtcUwLX52GLw4kt68t1fsB2L+m/VdCpXTWU1t+0caskJ3LpTL2XwS
 hpJ0h3L028/LzLDxpFCNt4lmEo6+dTxaM/Ese4v4aIkMGF1GqElxJy0kMUDgSgmg
 DWN/bw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4282p19rvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 20:33:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 038CB4008D;
 Wed, 16 Oct 2024 20:32:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4F68D269608;
 Wed, 16 Oct 2024 20:30:30 +0200 (CEST)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 20:30:29 +0200
Message-ID: <2ca0e79f-db0f-4ba1-b170-b6b26cf6d5f7@foss.st.com>
Date: Wed, 16 Oct 2024 20:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] doc: clarify scmi device tree for stm32mp15 boards
To: <u-boot@lists.denx.de>
CC: Etienne CARRIERE <etienne.carriere@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Dillon Min <dillon.minfei@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom
 Rini <trini@konsulko.com>, Vikas Manocha <vikas.manocha@st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241011153152.1637303-1-patrick.delaunay@foss.st.com>
 <20241011173140.3.I62101ff6150618cf00b69bb9c5c8ce84eab7ecf7@changeid>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241011173140.3.I62101ff6150618cf00b69bb9c5c8ce84eab7ecf7@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Hi,

On 10/11/24 17:31, Patrick Delaunay wrote:
> Clarify the usage of SCMI specific device tree to use with
> stm32mp15_defconfig and with OP-TEE.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
>
>   doc/board/st/stm32mp1.rst | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
>

Applied to u-boot-stm/master, thanks!

Regards
Patrick

