Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEF4C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 15:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F24A086504;
	Tue, 29 Aug 2023 17:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZdKaoL5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D77386508; Tue, 29 Aug 2023 17:19:39 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA718864E9
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 17:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7605ce3122=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37TC3oEg012175; Tue, 29 Aug 2023 17:19:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=e2OR5bsxeDP0uYfdJtMuQRNoi7UTFpBxVX+LFy7TJz8=; b=Zd
 KaoL5FNDVFT+GarHDEImgff+/s/zLBWvSxdFDHweyvK/hHVoCTkToVINpsZdyA3N
 +l71yzr9WTWgDqhvmUdM9Ir1QHCJM6pzzlI5mr0C2ho+E6ZZfqxHVUXBo1mJFHNJ
 STIMznYFkEYTMrWpcyUyHjZ2KhD5q9vTSlJN+6r+UrdH5EoA99tQMQonEoo//w+I
 b9gvd4+NMS14mm2cwfd1B4NTXRn2Vrsp/eJqsH2Kz1QlGxJZMbzFJ3HCzkLoU0zq
 dIs9vaP+yZA04oofT54sCoPGAtmZsxy6exbBOb9TvNmhRh9CrXFnzbfP3vOw1VQ+
 8PcP5UyISx8ouP9C+Alg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqvbhagc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 17:19:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E1E70100057;
 Tue, 29 Aug 2023 17:19:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7D69233018;
 Tue, 29 Aug 2023 17:19:34 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 17:19:34 +0200
Message-ID: <e7e8f2cd-b9f0-96cb-a4af-fc729189a35e@foss.st.com>
Date: Tue, 29 Aug 2023 17:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] board: stm32f746-disco: refactor the display of the
 ST logo
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, yannick fertre
 <yannick.fertre@st.com>, Vikas Manocha <vikas.manocha@st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230820162446.616442-1-dario.binacchi@amarulasolutions.com>
 <20230820162446.616442-2-dario.binacchi@amarulasolutions.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230820162446.616442-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
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

Hi

On 8/20/23 18:24, Dario Binacchi wrote:
> The patch removes the legacy mode of displaying the ST logo and adopts
> the approach introduced by the commit 284b08fb51b6 ("board: stm32mp1: add
> splash screen with stmicroelectronics logo"). It was necessary to use a
> specific logo for the stm32f746-disco board.
>
> Furthermore, the previous version didn't properly center the logo, hiding
> its upper part.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>   board/st/stm32f746-disco/stm32f746-disco.c |   6 ------
>   configs/stm32f746-disco_defconfig          |   2 +-
>   configs/stm32f746-disco_spl_defconfig      |   2 +-
>   include/configs/stm32f746-disco.h          |   7 ++++++-
>   tools/logos/stm32f746-disco.bmp            | Bin 0 -> 18052 bytes
>   5 files changed, 8 insertions(+), 9 deletions(-)
>   create mode 100644 tools/logos/stm32f746-disco.bmp
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


