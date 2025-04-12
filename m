Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAD0C369AB
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 20:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BD01829E2;
	Sat, 12 Apr 2025 22:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744491242;
	bh=QsPdZAAxDkf29Zec7IJ8q/PXOXWwNnoGDFfHXYS3FSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kMjp7ZdAQxPJXB50PftjZnX/sCAmOXF+xT8ZWnMzUM8oc+5tnz5r5nNcvvWjzmaAQ
	 WjQel6NWQEV/mIKFs84qBn4wqRfwZK7xvGqU6kTtUUlZfeGevlk6mDcCP/yP1LJM0L
	 3GnbbEy99BE2z/Sry2fzRPPmXzltEEpDYe7LZekmunzk0Ovc+sx1jmMz9AI65WSnp2
	 MB0APNPVvKDFq1tBg/X45vMuwG98I3e01JKSXqsMbqse3u2qhh3C23Zp5m8L3d35/f
	 C9oIC2h20KWklR60mdS0wyqmZaxr1r10NVJkji+iTlDg+xIZZOTBQTtGdI/O/+K0e4
	 TJMw1hBVg6AtA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C01C282A33; Sat, 12 Apr 2025 22:54:00 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D81B6826AD
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 22:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="S163y2C1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 004FF10275AD0; 
 Sat, 12 Apr 2025 22:53:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744491237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=QsPdZAAxDkf29Zec7IJ8q/PXOXWwNnoGDFfHXYS3FSc=;
 b=S163y2C1XEv/yNlVjAUuzDCstvxXe8ad5LWVSGoPzm1okj0wx3KeA+TxgsMCJUzEDgWtFM
 3mxaZ4sKkGR+Qd56GNc+hU2d/nTyfcjqZvcqyj2bjcEXkYLLKvHaKaTF5MdxP1TwLkvqPM
 RPVFTHGQzsFGWRqbulamf6QlbI35/PIPmX5pJYTziPD6wLw4+B1b4Mz8ALxN4oYZw2/fT5
 Du1u18BRpcw0S/EaSQllERUgsh+OFnJG7PdvziWliYOSYouOVLr4IR+cSRV2AsF7w8q6jl
 2OEEG0d8SStV3lwjFAGvDVW3U7qZsqdIoX0nr+jqwCgPFXcgtQ/gpinD/ZUPUQ==
Message-ID: <4ffec9c5-1faa-4156-825d-c72478eb032d@denx.de>
Date: Sat, 12 Apr 2025 22:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dwc_eth_qos: add support of stm32mp2 platform
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Erik Schumacher <erik.schumacher@iris-sensing.com>,
 Greg Malysa <malysagreg@gmail.com>, Heesub Shin <heesub@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Philip Oberfichtner <pro@denx.de>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <20250411092721.331518-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250411092721.331518-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/11/25 11:27 AM, Patrice Chotard wrote:
> From: Christophe Roullier <christophe.roullier@foss.st.com>
> 
> Add compatible "st,stm32mp25-dwmac" to manage STM32MP2 boards
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Marek Vasut <marex@denx.de>
