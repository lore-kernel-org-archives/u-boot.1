Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C5ECF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A35F886DF;
	Fri, 20 Sep 2024 10:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kjIfoPRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6733488B64; Fri, 20 Sep 2024 10:04:52 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E2087C69
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so14588825e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819486; x=1727424286; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aZQzJrIu+ajuJyuOtUgfP5sJOHHTe4IrOuPyCiwuFf0=;
 b=kjIfoPRZADsk42N4vavNqYO0OY8/GZoSnv5J+gbYrD7pXmJQmDIgjjEDdvuokTxN2F
 Iu5Kg38phieUBpDVrSyRye718ZBs9KhiIOWpgWYzeuJUhA3TdDzaBD+LUqrD1UWDesch
 bI/xEEsTINa4bkAq6KTIPGNLWd8mRuL11MWY3WZqEnpgd2QtzdD2WQTCCQmrx9pek+d3
 bp/2mi3NGPgknD7ceFWez+Afk0264HLEDyI/NcMCfI6Xmq2U3N/EWAzx+WDnSt/6clfZ
 iLYqstriGsBO5xqDGC1SpFV2hmuIsPCHXi68Mz6WMJhHlGtoZ1fuLm80pQrT5eACe6xT
 ncww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819486; x=1727424286;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aZQzJrIu+ajuJyuOtUgfP5sJOHHTe4IrOuPyCiwuFf0=;
 b=DUosu4neXAZfTaAtwJK7MCxNX7oKw7QbssMfv+XwAS/hoNxBThMh6KEpJPCPrm+kZP
 JzaJnOM33mh8AZl64vwO1s9WPnOZZAGew/kJtugmUX5gJlcjCpSPt3QY6U8tBjXxSIDm
 9lHdw72/+D/7uQhyun56ARhS5TjQ87qbBPDKEyAcWeTkUZhskRoCqR383ocLh6L8OWE9
 CraNOfrVVZ4gvSr+Bhb2itH7Urc7K2CXLSPH0YlnNVSy9P4VzOeP3XPv5ldtVMMmUOHF
 GgWPJQVlm87tZoocmBTw4hH0d2xaIWGKhKBJbhA6tv8rJDkDLANSYQ6Mq9xLc9GIxAw6
 1Nlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW18uKOIRmnoq6xGQ72yk7QyN2/POll3eHVzpv9XpnANCAQ1mPL/wOIuivPaCBsPUrTxmUs+vw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzw/S1McUqhWF6tZ9JkH3FWLz0pOBEEVjenfqaTw11M32vL+6KC
 cpas9OotkPwOTJQw7Ez1WW4aPWYGjaQpdk7oPgJmB8bmqtlUOdOmCsSm2mz7kmo=
X-Google-Smtp-Source: AGHT+IGyA/Ec//IEuQhvpjAOsZpVSdnH8VbHE7NRfrcL/blzez/fsbZYt/N8PcdeawRMgsmO80QRoQ==
X-Received: by 2002:a05:600c:3b17:b0:42c:ba83:3f01 with SMTP id
 5b1f17b1804b1-42e7abe8495mr13471035e9.8.1726819486247; 
 Fri, 20 Sep 2024 01:04:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f?
 ([2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754a6643sm42692165e9.29.2024.09.20.01.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2024 01:04:45 -0700 (PDT)
Message-ID: <947bdbd0-4cac-4f2a-a30c-921767b13bee@linaro.org>
Date: Fri, 20 Sep 2024 10:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 09/13] ufs: Sync possible UFS Quirks with Linux UFS
 driver
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
 <20240920-topic-ufs-enhancements-v2-9-65ae61e73eaa@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240920-topic-ufs-enhancements-v2-9-65ae61e73eaa@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 20/09/2024 10:00, neil.armstrong@linaro.org wrote:
> From: Bhupesh Sharma <bhupesh.linux@gmail.com>
> 
> Sync u-boot UFS driver to add all possible UFS Quirks
> as supported by Linux UFS driver as well.
> 
> Synced with include/ufs/ufshcd.h from Linux v6.11 release
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/ufs/ufs.h | 193 +++++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 162 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 555f8a6857d..a1006b80e88 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -712,38 +712,169 @@ struct ufs_hba {
>   	u32			version;
>   	u32			intr_mask;
>   	u32			quirks;
> -/*
> - * If UFS host controller is having issue in processing LCC (Line
> - * Control Command) coming from device then enable this quirk.
> - * When this quirk is enabled, host controller driver should disable
> - * the LCC transmission on UFS device (by clearing TX_LCC_ENABLE
> - * attribute of device to 0).
> - */
> -#define UFSHCD_QUIRK_BROKEN_LCC				BIT(0)
> -
> -/*
> - * This quirk needs to be enabled if the host controller has
> - * 64-bit addressing supported capability but it doesn't work.
> - */
> -#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		BIT(1)
> -
> -/*
> - * This quirk needs to be enabled if the host controller has
> - * auto-hibernate capability but it's FASTAUTO only.
> - */
> -#define UFSHCD_QUIRK_HIBERN_FASTAUTO			BIT(2)
> -
> -/*
> - * This quirk needs to be enabled if the host controller has
> - * 64-bit addressing supported capability but it doesn't work.
> - */
> -#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		0x2
>   
> -/*
> - * This quirk needs to be enabled if the host controller has
> - * auto-hibernate capability but it's FASTAUTO only.
> - */
> -#define UFSHCD_QUIRK_HIBERN_FASTAUTO			0x4
> +enum ufshcd_quirks {
> +	/* Interrupt aggregation support is broken */
> +	UFSHCD_QUIRK_BROKEN_INTR_AGGR			= 1 << 0,
> +
> +	/*
> +	 * delay before each dme command is required as the unipro
> +	 * layer has shown instabilities
> +	 */
> +	UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS		= 1 << 1,
> +
> +	/*
> +	 * If UFS host controller is having issue in processing LCC (Line
> +	 * Control Command) coming from device then enable this quirk.
> +	 * When this quirk is enabled, host controller driver should disable
> +	 * the LCC transmission on UFS device (by clearing TX_LCC_ENABLE
> +	 * attribute of device to 0).
> +	 */
> +	UFSHCD_QUIRK_BROKEN_LCC				= 1 << 2,
> +
> +	/*
> +	 * The attribute PA_RXHSUNTERMCAP specifies whether or not the
> +	 * inbound Link supports unterminated line in HS mode. Setting this
> +	 * attribute to 1 fixes moving to HS gear.
> +	 */
> +	UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP		= 1 << 3,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller only allows
> +	 * accessing the peer dme attributes in AUTO mode (FAST AUTO or
> +	 * SLOW AUTO).
> +	 */
> +	UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE		= 1 << 4,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller doesn't
> +	 * advertise the correct version in UFS_VER register. If this quirk
> +	 * is enabled, standard UFS host driver will call the vendor specific
> +	 * ops (get_ufs_hci_version) to get the correct version.
> +	 */
> +	UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION		= 1 << 5,
> +
> +	/*
> +	 * Clear handling for transfer/task request list is just opposite.
> +	 */
> +	UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR		= 1 << 6,
> +
> +	/*
> +	 * This quirk needs to be enabled if host controller doesn't allow
> +	 * that the interrupt aggregation timer and counter are reset by s/w.
> +	 */
> +	UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR		= 1 << 7,
> +
> +	/*
> +	 * This quirks needs to be enabled if host controller cannot be
> +	 * enabled via HCE register.
> +	 */
> +	UFSHCI_QUIRK_BROKEN_HCE				= 1 << 8,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller regards
> +	 * resolution of the values of PRDTO and PRDTL in UTRD as byte.
> +	 */
> +	UFSHCD_QUIRK_PRDT_BYTE_GRAN			= 1 << 9,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller reports
> +	 * OCS FATAL ERROR with device error through sense data
> +	 */
> +	UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR		= 1 << 10,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller has
> +	 * auto-hibernate capability but it doesn't work.
> +	 */
> +	UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8		= 1 << 11,
> +
> +	/*
> +	 * This quirk needs to disable manual flush for write booster
> +	 */
> +	UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL		= 1 << 12,
> +
> +	/*
> +	 * This quirk needs to disable unipro timeout values
> +	 * before power mode change
> +	 */
> +	UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING = 1 << 13,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller does not
> +	 * support UIC command
> +	 */
> +	UFSHCD_QUIRK_BROKEN_UIC_CMD			= 1 << 15,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller cannot
> +	 * support physical host configuration.
> +	 */
> +	UFSHCD_QUIRK_SKIP_PH_CONFIGURATION		= 1 << 16,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller has
> +	 * 64-bit addressing supported capability but it doesn't work.
> +	 */
> +	UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		= 1 << 17,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller has
> +	 * auto-hibernate capability but it's FASTAUTO only.
> +	 */
> +	UFSHCD_QUIRK_HIBERN_FASTAUTO			= 1 << 18,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller needs
> +	 * to reinit the device after switching to maximum gear.
> +	 */
> +	UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH       = 1 << 19,
> +
> +	/*
> +	 * Some host raises interrupt (per queue) in addition to
> +	 * CQES (traditional) when ESI is disabled.
> +	 * Enable this quirk will disable CQES and use per queue interrupt.
> +	 */
> +	UFSHCD_QUIRK_MCQ_BROKEN_INTR			= 1 << 20,
> +
> +	/*
> +	 * Some host does not implement SQ Run Time Command (SQRTC) register
> +	 * thus need this quirk to skip related flow.
> +	 */
> +	UFSHCD_QUIRK_MCQ_BROKEN_RTC			= 1 << 21,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller supports inline
> +	 * encryption but it needs to initialize the crypto capabilities in a
> +	 * nonstandard way and/or needs to override blk_crypto_ll_ops.  If
> +	 * enabled, the standard code won't initialize the blk_crypto_profile;
> +	 * ufs_hba_variant_ops::init() must do it instead.
> +	 */
> +	UFSHCD_QUIRK_CUSTOM_CRYPTO_PROFILE		= 1 << 22,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller supports inline
> +	 * encryption but does not support the CRYPTO_GENERAL_ENABLE bit, i.e.
> +	 * host controller initialization fails if that bit is set.
> +	 */
> +	UFSHCD_QUIRK_BROKEN_CRYPTO_ENABLE		= 1 << 23,
> +
> +	/*
> +	 * This quirk needs to be enabled if the host controller driver copies
> +	 * cryptographic keys into the PRDT in order to send them to hardware,
> +	 * and therefore the PRDT should be zeroized after each request (as per
> +	 * the standard best practice for managing keys).
> +	 */
> +	UFSHCD_QUIRK_KEYS_IN_PRDT			= 1 << 24,
> +
> +	/*
> +	 * This quirk indicates that the controller reports the value 1 (not
> +	 * supported) in the Legacy Single DoorBell Support (LSDBS) bit of the
> +	 * Controller Capabilities register although it supports the legacy
> +	 * single doorbell mode.
> +	 */
> +	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
> +};
>   
>   	/* Virtual memory reference */
>   	struct utp_transfer_cmd_desc *ucdl;
> 

Ignore this patch, it's broken... I'll fix it in v3

Neil
