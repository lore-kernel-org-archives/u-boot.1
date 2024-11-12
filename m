Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E33D32D92
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 11:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6FA88FBA;
	Tue, 12 Nov 2024 12:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="df+5ov47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8C589431; Tue, 12 Nov 2024 12:21:01 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B20D88E42
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 12:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=104698dab8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC8eDR7015347;
 Tue, 12 Nov 2024 12:20:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 ByEcfjPYg0Kw06IszMP32pAnPEPT0wc4fVGhGD+GTuk=; b=df+5ov47/0erPVAv
 /QtG6j7r2UNzwJ7CVmpDwcJ6W2fa0LzRDRV33Pz9CG3NXVa6Ym2wke/Sg8PeK6uM
 QQyEBI/l11348WAhsydtc2ubTYGEQ3DnPLwIu/gOwfmO9ULQnqi4i2WEwv4oU9qc
 RhB388nT5ZFgVRGx0Vfkfw82wZHK4KbdIkKhNYySy4cTNzFdPEbsPbb1YhcsntrJ
 YtjKjM4hh8yLz/Zff4sEJHm6phbbZdRhZ6z1yg5tGjryxjWLr+n1VX6j8g7LZTKT
 HqAfOtREsDOnLXZFTBHufYyfu6Ob+kCrTnNEe2kFR3p6WLyfaxLBzsVGJwoMDP23
 4IReuQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42syggkgrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 12:20:55 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6E34640076;
 Tue, 12 Nov 2024 12:19:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2AAC929FACB;
 Tue, 12 Nov 2024 12:18:55 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 12:18:54 +0100
Message-ID: <e27167fa-5d65-40b4-92d7-27bfcba1e2b3@foss.st.com>
Date: Tue, 12 Nov 2024 12:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/25] st: stm32f429: Drop old LED code
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241102221737.547938-1-sjg@chromium.org>
 <20241102221737.547938-9-sjg@chromium.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241102221737.547938-9-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/2/24 23:17, Simon Glass wrote:
> This predates the LED framework, so drop it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   board/st/stm32f429-discovery/Makefile |  1 -
>   board/st/stm32f429-discovery/led.c    | 39 ---------------------------
>   2 files changed, 40 deletions(-)
>   delete mode 100644 board/st/stm32f429-discovery/led.c
>
>
Thanks

for information LEDs are also defined in device tree: 
arch/arm/dts/stm32f429-disco.dts

     leds {
         compatible = "gpio-leds";
         led-red {
             gpios = <&gpiog 14 0>;
         };
         led-green {
             gpios = <&gpiog 13 0>;
             linux,default-trigger = "heartbeat";
         };
     };


but today the CONFIG_LED_GPIO=y is missing in 
configs/stm32f429-discovery_defconfig

to restore the LED support on this board


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>


Thanks
Patrick

