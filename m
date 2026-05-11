Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FF1CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079468460C;
	Mon, 11 May 2026 15:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q2csuMRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085A18460E; Mon, 11 May 2026 15:21:38 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894E283E36
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-67b6a6bd7b8so8906081a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778505694; x=1779110494; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uNTCg8Ab4tOgiONwOOoV+SeK554bhQ6gNJGImjHYQyQ=;
 b=Q2csuMRL2vwAa/doKWurDAzpP2+VNzx6ykzX9B2Faf8HCCTKM3/m5TtnvC8bPEwM77
 gL3mJLXBMs6igQuzRGzv1AnsJGxRrOxUxqQebZzVME1+lN9mL/0xM5lm1E76w4YKFiXc
 k30+HWIvMXtPcl+NbKVh349GBf4V4imEAghiIesG7D3IiTkkxOWJDbPjGVRl9oSKIbxO
 DcPjCn5Os9pJaUQtOy8BeK+6rQfbHHDYg/uROQYMj/kth7WZTgXpX+W7P+tEaGpgMt8N
 PYxC2HYE+oI5YrV2FbAnsyzecC91ZD1hNbXAj3yBKYqbPFVKrekbWeiz8kUPtsdolrLq
 EGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505694; x=1779110494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uNTCg8Ab4tOgiONwOOoV+SeK554bhQ6gNJGImjHYQyQ=;
 b=hFoYGeqEDq2zbfDO9ECru9tBkjZsSlFVeY2PAmlLof+96QkFC06qLeLnS0vruP6oYQ
 S6OL6wPbczimMAwn3DAopbXyp0L5a5WYymmWTN/oOFU9mLDARcLFxvkDAdwPobIbjGHY
 O4ntyHSrsgn5VVmFGEV+z570BH0I4AHmKsu6ifj+0PHdA8Zgx44dbdsAgkqXUoZjLRAR
 CtbAUdfxXQMNdsSF1oXJDEQQo49nGmDErL52oUrQNP9zczOsK24JPWDjwx/oTjZB7mZi
 WzmeM17yQ6SGps0caeJc7sYLkrUBx1SPVcf2oVe0Qcnrb4g8cZXxuNSqPDj63FHC5XRf
 vRxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Xxqa9GsnBsh1PZczi/5O63M4+7slH4mcq/qSKkNisD3n1736Nz+Y+YZLrK3J+ryiics11Ru4=@lists.denx.de
X-Gm-Message-State: AOJu0YyKQVYCGcAJ33fztvFEUTLTKt+9o1LsUUjkHbZwtDRKUutOPm+G
 KwcIt53YFBEUyt8LxLhMC31Th2YoBN6l2osTtJbCuIDpG370ohYjBzex0rzJZGrkI/VG6HGpOJD
 EgWc3f1g=
X-Gm-Gg: Acq92OF3ypXmZmyN1tENlFWvAndWrbpMvgQRsdk68yNpsuJNtkYer8NluIOrbzUl0zN
 RzGhchHMvwU2QSZv1CFqLf7CY4PRideqTm2DLksLguy8CeIPjECPU4d1O7p9eO7ZXryM4IL1faK
 OrXkLCy3pIz6Q2Jj/gDL8bHTz2xwufzeYhHfO9zsgaDCUFsN6BAfN3xhs6m2daAs5XWsiiV9f/G
 91LdXl3ulaH7MQZe1MFCC0xLBSmRTnLk2SWjMH5ZYwH6RzwcwGAxNu44BdJx+sTFS6k4LfemSYt
 lz4pqg+pMXWQKms5OUwsn9h/yC2O1nSZNfNOY11iMZqzeob6pMu0ZV97+zZeq63xWB13Y4xKs2S
 fy1njQBFckJz+F3DW365gGJRoOenLGF6i+VxoVageNXWLU21+7mVszn/mhKFEczJSlEomJzf0IA
 MGy2s3YDk1BM5dQb+QB0IzXnNrNO2IMLPJ/8xNPeM4TGWMO3CZSBKZ7wtbdMEHgGfGlQ==
X-Received: by 2002:a05:6402:370d:b0:672:524f:525d with SMTP id
 4fb4d7f45d1cf-67e0ddf7bf7mr8336774a12.8.1778505693894; 
 Mon, 11 May 2026 06:21:33 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0b6a11asm3743741a12.8.2026.05.11.06.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 06:21:33 -0700 (PDT)
Message-ID: <2242137c-5cbc-472e-bbae-a11224e02fac@linaro.org>
Date: Mon, 11 May 2026 15:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/11] mach-snapdragon: add u-boot-spl-elf-sdm845.lds
Content-Language: en-US
To: michael.srba@seznam.cz, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-5-7d0e22aaaa8f@seznam.cz>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260508-qcom_spl-v7-5-7d0e22aaaa8f@seznam.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Michael,

On 08/05/2026 23:45, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> This custom linker script is required to produce a bootable ELF
> for the sdm845 SoC. An xbl_sec.elf must be provided, which will
> be put in a section in the ELF as required by the boot rom.
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds | 44 ++++++++++++++++++++++

Can you put this in a new board/qualcomm/sdm845-spl directory? Also
missed this with the other patch but the .env file can go there too (as
well as a debug config fragment if you add that).

>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds b/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds
> new file mode 100644
> index 00000000000..3740209d499
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +/*
> + * The boot rom uses the segment type to identify the xbl_sec program header.
> + * See https://github.com/coreboot/coreboot/blob/643efabd2af9f7ac/util/qualcomm/mbn_tools.py#L143.
> + */
> +#define PF_SEGMENT_TYPE_XBL_SEC 5
> +
> +/*
> + * The boot rom expects this to be equal to a seemingly magic value possibly specific
> + * to a particular xbl_sec.elf. If you're extracting your xbl_sec.elf from an xbl elf,
> + * you can just reuse the value; otherwise you can either compute it yourself or use
> + * coreboot's tool.
> + * See https://github.com/coreboot/coreboot/blob/643efabd2af9f7ac/util/qualcomm/createxbl.py#L638.
> + */
> +#define XLB_SEC_SEGMENT_ADDR 0x0000000014699000
> +
> +
> +TARGET("binary")
> +INPUT("./xbl_sec.elf")
> +
> +OUTPUT_FORMAT("default")
> +
> +ENTRY(CONFIG_PLATFORM_ELFENTRY)
> +PHDRS
> +{
> +	data PT_LOAD FLAGS(7);
> +	xbl_sec PT_LOAD FLAGS(5 | (PF_SEGMENT_TYPE_XBL_SEC << 24));
> +}
> +SECTIONS
> +{
> +
> +	. = XLB_SEC_SEGMENT_ADDR;
> +	.xbl_sec : { // XBL_SEC nested ELF
> +		. = .;
> +		"./xbl_sec.elf"
> +	} :xbl_sec
> +
> +	. = CONFIG_PLATFORM_ELFENTRY;
> +
> +	.data : {
> +		*(.data*)
> +	} :data
> +}
> 

-- 
// Casey (she/her)

