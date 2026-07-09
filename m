Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFECC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 04:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D945184A51;
	Thu,  9 Jul 2026 06:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MuacxASg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E0484A6F; Thu,  9 Jul 2026 06:03:50 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1534A84A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 06:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8454160043aso1388956b3a.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 21:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783569825; x=1784174625; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bqc4nn5dH/4ZsKP8axt2cJk05nqspIKLc3jCJraKR3Y=;
 b=MuacxASgSl4PoJiH3+Vpb6a391mAjE4B6ovs1dg+dCRuWG0/9jYXrYG7LIamU01W5l
 6dIxDNMAd6IgzFPYy7H5LQnVAazyw0warqOiPE4IWxxZ+6rkIONdBcfIRzhdXXCCeNsh
 u06G8NsJ07ePYwmxFhG51ILFTC+66r5riWlA67+yYK2M5zoNGg8OfZ3VZd4eyh8v/lhj
 RqnCQ1bliaQyXpArRG9y9mmYHGJeOvO6dEbg3S3GXQ11iWcNJNlG5pW3Got/wukOxgqL
 vEaeeQ2GnLieUH9q4lS5p+UFK96kEfui4MdQ/v5QJqu6pYuiI40KEC1wN2DyLJscOzgU
 g+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783569825; x=1784174625;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bqc4nn5dH/4ZsKP8axt2cJk05nqspIKLc3jCJraKR3Y=;
 b=O0YWi94SCNR/ueySlv7Ge1m+b6LeAARo55UlalEeyNWhvVjP5hBk1zfkZL7UhDF2I4
 LTuMCmgw3NqA7CmqNUErsKmd763GOQ3RpkZloFtzfjVoyEBiPePJdq0c3whkU324KeST
 ZURbmNwKULluD6PjnY2qcAuRVv3/53+eHVAtKFp9VmEIuwOhs8TkNqWh1zrcFmrkomJ3
 tK9Yht3EvPxi6CrwCF5ZlsBsGXWdv2zNpuQOzjcKkVDjl8dnrnrWsY3nPrkdNlxdeQs/
 8Ho+PGnKtxGriKF34bT4XElbUbSwrWDY/8VBQxIR65P5uDdhbngT35LArLmoEzgxn9uk
 QL0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpF1bFX+WG3avK+oOVYCk51OgxfFL4UGlSbCgkakGRayN2eS0gE+yS+SZBOhMRppPbRJz1PSTg=@lists.denx.de
X-Gm-Message-State: AOJu0YzSEWlZYtDsBHsvwTh0A+oh2QEyqg3Y/7YgtXoZn9jUnk9xPwVw
 LDzBBXsIz7Janqc5YTAE0hUQzupyEwRsMw1sU5H0Cge3N0B4rYfS70Q1+/FDWR7kE2o=
X-Gm-Gg: AfdE7cl4Ylp3r4F83gcXn07sEFL4Yy6q/z6/h1DwEZ3b/Lc0EHjrqoRFI3T++Qd0cqM
 CWRRBa2Oe5SKMmQ3iBnXzXjq+hLe6NCKwujcbaaPKMKoyqYnlp/K55IY6KEfzIfVlEIlKoCJS1f
 uGr+Q4qBfdLJ0AAgCbQbxoy80DK8++PLpYLTnCrqsFDYho2Usq8/J5GcX4N+j3pHnokyRIYYM2N
 KOKSddAaU5jUobxMm0M8T6iybtNSgMiwXGmN/gzBiLiQYhA5n7qFGZC95QWErfkyy1PtldRKbT/
 7DG02iosHvY45eObbfZB4Pl0npNjKDOLJ3VhLoj6J2/n5dMEnbjkrxaGkksWkoUD2Z5gk3Byf3Y
 bh/B0UJtNqSLEOi1VTHALab7lN0Ci5ztOxwIiYS0HOvZpLrzdRtfWFsYKZj5s3HgF/Ap+Iz7BLI
 QjO3LmP3gzuy8p/XePaO2r3ziXzBY=
X-Received: by 2002:a05:6a00:1493:b0:848:5d9b:687c with SMTP id
 d2e1a72fcca58-8485d9b6c08mr647953b3a.54.1783569824663; 
 Wed, 08 Jul 2026 21:03:44 -0700 (PDT)
Received: from [192.168.45.141] ([112.212.195.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84848939b38sm1616671b3a.10.2026.07.08.21.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 21:03:44 -0700 (PDT)
Message-ID: <48cde03b-5032-4863-b44a-a401dc793cfe@linaro.org>
Date: Thu, 9 Jul 2026 06:03:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: sa8775p: enable GPLL9 before SDCC1 high-speed
 rates
To: Royyan Zahir <royzah@gmail.com>, u-boot@lists.denx.de,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de
References: <20260708170228.621618-1-royzah@gmail.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260708170228.621618-1-royzah@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Royyan,

On 7/8/26 19:02, Royyan Zahir wrote:
> On lemans/sa8775p, the SDCC1 apps clock high-speed rates (192 and 384 MHz)
> source from GPLL9 (ftbl_gcc_sdcc1_apps_clk_src), but the driver never enables
> GPLL9. When SDCC1 is set to such a rate the RCG switches its source to a PLL
> that is off, so the CMD_RCGR update bit never self-clears and U-Boot warns:
> 
>    WARNING: RCG @ 0x120014 stuck at off
> 
> Vote GPLL9 on before selecting it as the SDCC1 source, mirroring how
> clock-sm8250.c enables GPLL9 for SDCC2. GPLL9's mode/status register is at
> 0x9000 (lock is bit 31) and its enable vote is bit 9 of the APCS GPLL vote
> register 0x4b028, matching gcc-sa8775p.c in Linux.

Nice find! Thanks for fixing this.

> 
> Not hardware-validated for SDCC high speed: the board this was found on
> (Qualcomm IQ-9075 / Lemans EVK) boots from UFS with no SD card populated, so
> here it only clears the stuck-RCG warning. Build-tested on lemans.

Can you test file access on an sdcard perhaps?

Balaji, Varadarajan, Sumit: could you confirm this fix and maybe send a T-b?

> 
> Signed-off-by: Royyan Zahir <royzah@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Thanks,
// Casey

> ---
>   drivers/clk/qcom/clock-sa8775p.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -26,6 +26,9 @@
> 
>   #define SDCC1_APPS_CLK_CMD_RCGR			0x20014
> 
> +#define APCS_GPLL9_STATUS			0x9000
> +#define APCS_GPLLX_ENA_REG			0x4b028
> +
>   #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>   #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
>   #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
> @@ -90,6 +93,14 @@
>   	{ }
>   };
> 
> +/* GPLL9 (SDCC1 high-speed source) is not enabled by earlier boot stages. */
> +static const struct pll_vote_clk gpll9_vote_clk = {
> +	.status = APCS_GPLL9_STATUS,
> +	.status_bit = BIT(31),
> +	.ena_vote = APCS_GPLLX_ENA_REG,
> +	.vote_bit = BIT(9),
> +};
> +
>   static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>   {
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -130,6 +141,9 @@
>   		return 19200000;
>   	case GCC_SDCC1_APPS_CLK:
>   		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
> +		/* SDCC1 high-speed rates source from GPLL9; vote it on first. */
> +		if (freq->src == CFG_CLK_SRC_GPLL9)
> +			clk_enable_gpll0(priv->base, &gpll9_vote_clk);
>   		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
>   				     freq->pre_div, freq->m, freq->n, freq->src, 8);
>   		return freq->freq;

