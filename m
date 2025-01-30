Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F70CC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 818F5820E8;
	Thu, 30 Jan 2025 14:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BTy4Oj+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D32820E3; Thu, 30 Jan 2025 14:30:14 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC7680805
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125fc93c8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UCf2ZA030596;
 Thu, 30 Jan 2025 14:30:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 4dJtNCmYc1tkmOmRwO2ydOqgm6ZZR0WOHYXXY6CP/Ds=; b=BTy4Oj+TlMyjWBnO
 Fqbauk9TgFbobaExJ4+WifL74ga0PS3TxZztog40h8tmKpHsBryEXxhWK/1BMu3m
 NlAxkzl58a21J9VfxThgL4jfgjpF5jgJnQJLJ0AhTk6DjWpzXxSpb8RlIlBiXJWc
 s95VeDOQairdCItN9qVzBEjSknfOS6tRVNMe/BE1LX2+wGCFNed3gwl/sXDBmI19
 FHmIwWq5nHva4l0S1Mb9309y9ZvcqYNXMUT6Fv2U3HrtSCx+05SZL5Q//GRPVfQk
 9zFT+KEOqhmLieHaKQHsbxFIYeKiw3T6DU9vjNore2scLRWj5c+kjM4JiDA5N/W5
 zbjQJQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44g8ne8kkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 14:30:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0EEDF4002D;
 Thu, 30 Jan 2025 14:29:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C64362AFFFE;
 Thu, 30 Jan 2025 14:26:26 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 14:26:26 +0100
Message-ID: <6032139c-f077-4d53-a660-91a5947624ff@foss.st.com>
Date: Thu, 30 Jan 2025 14:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] board: stih410-b2260: Remove
 board_usb_init/cleanup()
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
References: <20250123144718.1139824-1-patrice.chotard@foss.st.com>
 <20250123144718.1139824-9-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250123144718.1139824-9-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
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


On 1/23/25 15:47, Patrice Chotard wrote:
> Since DM_USB_GADGET is enable for this board, board_usb_init()
> and board_usb_cleanup() can be removed.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> Changes in v3:
>    - add RB Mattijs Korpershoek
>
> ---
>
> (no changes since v1)
>
>   board/st/stih410-b2260/board.c | 29 -----------------------------
>   1 file changed, 29 deletions(-)
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

