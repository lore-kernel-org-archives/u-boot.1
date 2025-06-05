Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD09C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 08:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC7B8091A;
	Thu,  5 Jun 2025 10:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="b1nkPeIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A8C81E25; Thu,  5 Jun 2025 10:40:07 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603A380050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 10:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8251505e0d=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557liCA012116;
 Thu, 5 Jun 2025 10:39:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 C56qMulXSgR/kF4dB8UbR+kDncp9oQpjlRAOw5NknKc=; b=b1nkPeImIDyEVIYZ
 8K9OW5GEf3lqrAqUgE5AERW5TDzXkKgLWV4jtultbTYvn2ENYi0bqQACoQDiPkKt
 ubP/BwHaMHX1CH5kZGwe9YITI52ucSQMKLSIK6YnMiF/1XSZCSVVCgngXAohgw21
 fnF7NZf+HPL2u/LwAdfbvBaPy6WX7nQfb2CXNtcSxXdTzYBlOkq3TiknahVMz7ib
 l+XYIBCLK/pZAhOiYZdyJutn5YyKuwOgjE3a0twlTfQf3dUhFxlOTfnerW9iGE1t
 oANlZYLhSiInNKDjoqWJPKk2LJKcj7ENKDJSrdEX2APLkUql6XkoRYnv66BhzJD/
 UTRklQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g93dfe6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 10:39:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AC3D440049;
 Thu,  5 Jun 2025 10:38:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C7184B93FD0;
 Thu,  5 Jun 2025 10:36:46 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Jun
 2025 10:36:45 +0200
Message-ID: <ab4f5f31-feee-401c-9444-77b8a06b4676@foss.st.com>
Date: Thu, 5 Jun 2025 10:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sandbox: solve undefined reference to pthread_kill
 symbol
To: Raymond Mao <raymond.mao@linaro.org>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Adriano Cordova <adrianox@gmail.com>, Michal
 Simek <michal.simek@amd.com>, Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Sam Edwards <cfsworks@gmail.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Philippe Reynes
 <philippe.reynes@softathome.com>, Daniel Golle <daniel@makrotopia.org>
References: <20250604154814.1856244-1-raymond.mao@linaro.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250604154814.1856244-1-raymond.mao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
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



On 6/4/25 17:48, Raymond Mao wrote:
> This patch is to solve the sandbox building error:
> $ make O=build-sandbox -s sandbox_defconfig
> $ make O=build-sandbox -s -j2
> /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to symbol 'pthread_kill@@GLIBC_2.2.5'
> /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
> collect2: error: ld returned 1 exit status
> [...]
> 
> Fixes: b989f9ed9fe1 ("test: lib: add initjmp() test")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2:
> - update fixes tag in commit message.
> 
>  arch/sandbox/config.mk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
> index dd9b7473fa9..9a61e803a57 100644
> --- a/arch/sandbox/config.mk
> +++ b/arch/sandbox/config.mk
> @@ -3,7 +3,7 @@
>  
>  PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
>  PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
> -PLATFORM_LIBS += -lrt
> +PLATFORM_LIBS += -lrt -lpthread
>  SDL_CONFIG ?= sdl2-config
>  
>  # Define this to avoid linking with SDL, which requires SDL libraries

Hi

Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>

On Ubuntu 20.04 with default gcc (Ubuntu 10.5.0-1ubuntu1~20.04) 10.5.0

Thanks
Patrice
