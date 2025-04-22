Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B86C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 11:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159048197F;
	Tue, 22 Apr 2025 13:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745319632;
	bh=yY4t6PDwvKa+V9tNorFFuAn/AJHWAcZfSU4Ss1Dw/Ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=tiF/X4HEyezDWYFJUZBup+2EavZ3AowA2iBHznr1rH2nxFTLqSCiZmg2Vk8c8Gkn8
	 Y8z2y7AQKar4Bx90eyOBIREle7CnLKfqYWbX2pxGPI0DcRlkAfmn0VOWXhiH7vDqZb
	 gC0ELlmj80efFOiw+qMdAqJ/rU56RmNWEu9YTLW8VobDpsn9vSNzf9qBVko8OWxuCi
	 ePGPnSCWYEer8m8iDPtfJC3svje8ajuLh6VjK0Qo8CKx/B1Z7s9RehWA4kX9vZqtgN
	 2tq6h0RBz2Hrs3moqmDGtRi3HvPbwLgP56kZgsREiGSXu4ktTDA1qiARbz71yKzm2/
	 qcYwt6g63RW5Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F89B810E8; Tue, 22 Apr 2025 13:00:30 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14EB8197F
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 13:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="LD4drayp"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BBEB5102A8C9C; 
 Tue, 22 Apr 2025 13:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745319627;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=yY4t6PDwvKa+V9tNorFFuAn/AJHWAcZfSU4Ss1Dw/Ig=;
 b=LD4draypnZ+OHlxtMDKhWWqOF+sz7O0ZmTEFJ44VEX72rBRnibWzZiBY3KUr50bc7/XODo
 rxvB+FI0l/FIh27sX5laOvaWxeKnuzyvwp8WFEGsE4qRovmRoMtgRpmBqmwdHK4Luz+us5
 3o4JU17NbDiLOuIWR7BXygQDayhImlDatCVGi9SzmZhbzEUDT0u43oVIeTLj6iD7cXd0Tw
 qr5h83OMbm3PJ9I1nTQDCNBAD/7mOqtMVCAS5ceXQrK972HL53k7wJptvMmofjALqFTiGt
 ri0zoWiS1qD0KAUNpPda/zEH2qXFW+ugqeorceK3bRfDGkVJaVnfVoJ5ipcGCw==
Message-ID: <b2a48a0a-a6d1-9f6d-e704-5675f922184b@denx.de>
Date: Tue, 22 Apr 2025 13:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 4/4] drivers: i2c: Kconfig: Add
 CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, w.egorov@phytec.de, j-keerthy@ti.com,
 u-kumar1@ti.com
References: <20250422101957.1949448-1-a-limaye@ti.com>
 <20250422101957.1949448-5-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250422101957.1949448-5-a-limaye@ti.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Aniket,

On 22.04.25 12:19, Aniket Limaye wrote:
> Add a Kconfig option to disable sending Stop conditions between multiple
> i2c_msgs within a single xfer. Enable this config by default for ARCH_K3
> platforms.
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
> 
> v2:
> - CONFIG_I2C_REPEATED_START -> CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
> - Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-4-a-limaye@ti.com/
> 
> ---
>   drivers/i2c/Kconfig | 9 +++++++++
>   1 file changed, 9 insertions(+)

Thanks for the update!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
