Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F17FC98306
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 04:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F48D80C6A;
	Fri, 25 Sep 2026 04:31:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHJ1ND0-H3Do; Fri, 25 Sep 2026 04:31:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 999BB811C6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790310705;
	b=RIn2LK+737X9TIvzqB2YwrC1BFPYuecF9CX2OdJ5qzpl3G0b6wm8Cf8TY0uKuox4z28/
	 4zScOkVz9xckZpqfXydEBCJBWAYfMKSkR1HYMn7Oik65sXdxt4T6arJ7+4XS9m3nq9shj
	 Mo+kxfSXND2FEhCrD1lbEC2XrJb6FuBvijcOIuNmR2GYDs9C4g7yhunMeuAjUF4e6KqwS
	 qPReP7eDgllvcRjQE5F9sbBWOWPVAaJgHo+SjbeFuzHs8oYEShw812l4OPabA5twdqiEW
	 bf0N3EUs29X6tVdgmduLGFLldKXUqsY9J58C1rmhE9ELI7kvAcu6jQgREDmfd/HxWXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790310705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cUhUKp7TVzH1tPHLUNHhQKG3lZUADoaXyqd2xTvY4VI=;
	b=qMlcq+Qyb2au5yaCq8vW6Y/CwWC+LdyOaH4IHquBZ8gH+IQ0mo6/9i1U3O664PXBnLwL
	 uBhaNDhcrj4nxQaZ0zvbGGkf0/0VZS+o7ZEDoQFY3bRk437gfByQnyt80nbkaQLjCHpc0
	 Vd3Rhi2U6VzNkgOz6qyC5VWH4unbc8kxCB7sdyEKPoha2Sdt62OrSS7lN6Lii3whHSJRM
	 uO1pjc/fTAo+CljxF6yJumGasqF0Y12Ic1U9TMzUAJzJ0UvSNWoTgUMc8vrT8plMnPPqc
	 fCS2EfZX4xHClLAUCWYDyeBxM1yesEXS28jNmBeJMLYtwwYJI+ggwmLkSurusN+raDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Jsno3ZOu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790310705;
	bh=cUhUKp7TVzH1tPHLUNHhQKG3lZUADoaXyqd2xTvY4VI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulxDcuoa7kpgz6WOviap1kBVj9C+9HKikW3lnT9zTx7Xf4kbOb+y97VCczWRCgLjX
	 /uW9AGzeuphHxm01n6/6IKBJDnZT+nRYQJ6JrPN0mM1klthVsq7g9x9z+0kXXxYty0
	 L4QTEQE7Iza0dGklcIje8JqB6ebpmYkubIaRbWTE07lri2SdUdoBBrGz29RlylpZrn
	 3hsjGoiuBYALBk4wssR831MHBdExgpzRZVVeRjMzPPFIUWZyW/f1qhzOQI7F2XGQId
	 9qqnrlvchWGyeiMXD13uS4aIKYmhFBqLkLp3m68pAl16r3N0ujDFtDTHYUR8/fyJUo
	 SMuoP9LPzi7eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 999BB811C6;
	Fri, 25 Sep 2026 04:31:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 243FF355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 04:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EDBB811C6
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 04:31:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9wqrDbT62s8P for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 04:31:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C162280C6A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790310703;
 b=EHw004E2eRtSh4MJKcQrae1DS4zi4WgcgbRWXDV934dBTkHCaTBbsQvw2BbmMP2/kZ50
 RLgRMpaDy7YSz9U8v1OuwqDX3NvkaPgru1bpYdF5FnEje3p6yHL/Jw1303MdG4sNZtpo+
 w4IZu+yxQFPq4iBk2vKVBK3KYSgYS4ou4F+3u/ghnKJgmSg56bXBv4u9Qs0PYt3RZPd0A
 ScEnFUqI1q2sc0ma+p49zQehymk5Ed2OhL2PEm7L+Vu9NL9+u9j3NHqOTGF15oTHxWFYo
 NAOHuInUJtLLRDW23YXN9j9rzXpQ5GEFdAQm6RrXIost43ARqhSQa2TR+P5oMvLHDjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790310703;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=cUhUKp7TVzH1tPHLUNHhQKG3lZUADoaXyqd2xTvY4VI=;
 b=f6X9svyfGHHUIt2xF3u6JjaO9ucqGFeLqktRmikGuNFwir3/p/E4vdY360xrKnh4GqF+
 3DHX3Y+F1vGbwhJ5AhfAYHaWQ4lZhWcJR0lXdPdwIOHtq0ewLyoJV7VGtcrzBMvdcULRU
 lvAde+Ny6DX8z32GfWYcM4syBqUONUsQRf5lGzY/7Z6w/MCnpc4YEQuj2PkAKvgXGfsfN
 a/f9sSNoCe6UilzgIfUjZP3RSaYW0iS+dUKHTOVVTYRSR5elrqIJzwCoiqKVBdR+btKCc
 EDCZARW1jwYu2oAfqdn1dyUOgfmMOgLaO0H0X8WGzrPyaPVlIg0uOuJFc6yXuBdGhnA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Jsno3ZOu; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Jsno3ZOu
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C162280C6A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 04:31:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 58319104752; Fri, 25 Sep 2026 06:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790310696;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=cUhUKp7TVzH1tPHLUNHhQKG3lZUADoaXyqd2xTvY4VI=;
 b=Jsno3ZOuNtMLc/TTshuF0XkT0GJkFtCrBPS95O5NOb/bHsZdqJw1+d3bqOx7c3dyAf6R3s
 VLb/cGp76Y1l2AS8rYaYuubuuZyr0b0Yu4wtEPWNDJ8asAu1Q03WZ/pKgwjdiPAEWAgOeg
 no9f52EDtks0P13IuregwifNNb3owMVdDe5rgx61yXnru1yabgi84PYJcex8Izdx24yxbk
 mH6uynTKoCE9Iynp7sq5o8M+V+yG10zIiljIOrHFHynYxxfgmCqBm/K3ZHY8oYBp1wV7Ht
 tUBa8P2x8OMRa32boVJqbgDGmY4Nc0iW4b7xYsQNi4MRBQgyKwjzqy7DX0MbGA==
Message-ID: <24f21e3c-f596-04b3-912f-6a78a182589b@nabladev.com>
Date: Fri, 25 Sep 2026 06:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [SECURITY] MPC8xx serial RX buffer overlaps SPI descriptors in
 DPRAM
Content-Language: en-US
To: Jaeyeong Lee <iostreampy@proton.me>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, christophe.leroy@csgroup.eu
References: <179024275173.70674.16356876476594066413@proton.me>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <179024275173.70674.16356876476594066413@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Jaeyeong Lee,

please use the new list:

u-boot@lists.u-boot-project.org

added the correct list to cc and dropped the old denx one,

Thanks!

bye,
Heiko

On 24.09.26 11:39, Jaeyeong Lee wrote:
> Hello U-Boot maintainers,
> 
> I found an overlap between the MPC8xx serial receive buffer and the SPI buffer descriptors in DPRAM.
> 
> Tested version
> ==============
> 
> U-Boot v2026.10-rc5
> Commit: a06e89ab05eaa2b8344d521319399333cd760ae5
> 
> Relevant configuration
> ======================
> 
> CONFIG_MPC8xx=y
> CONFIG_MPC8XX_CONS=y
> CONFIG_SYS_SMC_RXBUFLEN=64
> CONFIG_SPI=y
> CONFIG_DM_SPI=y
> CONFIG_MPC8XX_SPI=y
> 
> Summary
> =======
> 
> The MPC8xx serial driver places struct serialbuffer at the fixed DPRAM address
> 0x800. The size of its rxbuf member is controlled by
> CONFIG_SYS_SMC_RXBUFLEN, which has no Kconfig range limiting it against other
> fixed DPRAM allocations.
> 
> The MPC8xx SPI driver places its receive and transmit buffer descriptors at
> the fixed addresses 0x840 and 0x848.
> 
> With CONFIG_SYS_SMC_RXBUFLEN=64, the serial receive buffer occupies addresses
> 0x814 through 0x853. This overlaps the complete 16-byte SPI descriptor region
> at 0x840 through 0x84f. Receiving 64 bytes through the SMC serial interface can
> therefore cause CPM DMA to overwrite both SPI descriptors.
> 
> Technical details
> =================
> 
> drivers/serial/serial_mpc8xx.c defines the serial DPRAM object as follows:
> 
>      struct serialbuffer {
>          cbd_t rxbd;
>          cbd_t txbd;
>          uint rxindex;
>          uchar rxbuf[CONFIG_SYS_SMC_RXBUFLEN];
>          uchar txbuf;
>      };
> 
> The object starts at a fixed DPRAM address:
> 
>      #define CPM_SERIAL_BASE 0x0800
> 
>      rtx = (struct serialbuffer __iomem *)
>            &cp->cp_dpmem[CPM_SERIAL_BASE];
> 
> cbd_t is 8 bytes, so rxbuf begins at offset 20 in struct serialbuffer. The
> serial driver configures this address as the receive DMA buffer and uses the
> Kconfig value as the maximum receive length:
> 
>      out_be32(&rtx->rxbd.cbd_bufaddr, (__force uint)&rtx->rxbuf);
>      out_be16(&up->smc_mrblr, CONFIG_SYS_SMC_RXBUFLEN);
> 
> The SPI driver uses the following fixed addresses in the same DPRAM:
> 
>      #define CPM_SPI_BASE     0x0840
>      #define CPM_SPI_BASE_RX  CPM_SPI_BASE
>      #define CPM_SPI_BASE_TX  (CPM_SPI_BASE + sizeof(cbd_t))
> 
>      rbdf = (cbd_t __iomem *)&cp->cp_dpmem[CPM_SPI_BASE_RX];
>      tbdf = (cbd_t __iomem *)&cp->cp_dpmem[CPM_SPI_BASE_TX];
> 
> With CONFIG_SYS_SMC_RXBUFLEN=64, the resulting ranges are:
> 
>      serialbuffer base       = 0x800
>      serial rxbuf offset     = 0x14
>      serial rxbuf start      = 0x814
>      serial rxbuf end        = 0x853
> 
>      SPI RX descriptor       = 0x840 .. 0x847
>      SPI TX descriptor       = 0x848 .. 0x84f
> 
>      overlapping range       = 0x840 .. 0x84f
>      overlap size            = 16 bytes
> 
> The serial receive buffer reaches the SPI region whenever
> CONFIG_SYS_SMC_RXBUFLEN is greater than 44. The Kconfig option currently has
> no range constraint for this boundary.
> 
> Reproduction
> ============
> 
> 1. Configure U-Boot from CMPC885_defconfig.
> 2. Set the following options:
> 
>         CONFIG_SYS_SMC_RXBUFLEN=64
>         CONFIG_MPC8XX_SPI=y
> 
> 3. Initialize the serial and SPI drivers.
> 4. Write identifiable initial values to the SPI RX and TX descriptors.
> 5. Receive 64 bytes through the SMC serial RX path.
> 6. Inspect DPRAM addresses 0x840 through 0x84f.
> 
> A reproduction using U-Boot's structure definitions and fixed DPRAM addresses
> confirmed that all 16 bytes of the two SPI descriptors change after the serial
> RX write:
> 
>      serial_rx=[0x814,0x853]
>      spi_rx_descriptor=[0x840,0x847]
>      spi_tx_descriptor=[0x848,0x84f]
>      overlap=16
> 
>      SPI descriptors overwritten by configured serial RX buffer
> 
> Impact
> ======
> 
> Input received through the serial console can overwrite the following fields
> in both SPI descriptors:
> 
>      cbd_sc
>      cbd_datlen
>      cbd_bufaddr
> 
> This can cause SPI transaction failures, timeouts, a U-Boot crash, or invalid
> memory accesses during subsequent SPI processing. Corruption of cbd_bufaddr
> may also affect the memory address used by SPI DMA.
> 
> The confirmed result is the 16-byte DPRAM overlap and descriptor overwrite.
> I have not yet reproduced an end-to-end crash or arbitrary memory corruption
> on physical MPC8xx hardware.
> 
> Regards,
> Jaeyeong Lee
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
