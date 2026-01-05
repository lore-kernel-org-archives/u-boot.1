Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9022EC79F9D
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C80483E7A;
	Mon,  5 Jan 2026 16:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nINsqtWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E98483E7F; Mon,  5 Jan 2026 16:20:25 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA4283E76
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so11118365f8f.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767626422; x=1768231222; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2HYpGbixQrYB0VD8C9FlpTZDqQE2VMP+THHUxNtTjeU=;
 b=nINsqtWG5PSXCeW9Mf2mMFp/KJgDNDB4Nyp9YMIgG9aOQsUBKoCJCMGO777QjuTo6M
 zsCmggj9mQ3sarEJEBqeWRQQoxc1zYkvPYQWDXG6jdbG1xygAgNLi0hZJLGx76Oa2KCj
 8D2kgSGcxqan8H0sLl5gMsEAoSg+eSsmyLrM2ZTjfA+swHkvFnEZuKKHxatpyudod98+
 15wFseqVYD5LTWQlPymeyZgySvFxE2R7zFQlDVNdc2b1kNSz7DHfvFMc3y/+Lw+UGdAa
 hJ+GlNZETL+FNhtZefMgt9q9HYrSAI4PWPu2t8/PxmVkEmvC58iq5VUD7YIuHCU5wJXB
 6EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767626422; x=1768231222;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HYpGbixQrYB0VD8C9FlpTZDqQE2VMP+THHUxNtTjeU=;
 b=Hg19P3aWAlKBmCj1OsIIzejowDf/oj7wZw4Fv5MLVLPPo+GTOWuR0dgQJJ3A3ssajX
 6V010UgHXJgqREK8l7J2wznAwX8OXdvriiCoAE/EUQsHvviO4uo0sGPMvqUNNr3xFe3v
 fy2qJFqOCrMcDJJGpyfXaAA8U4DVukevWbBCfqOeQTbbd2ba0vRz8eEY3Ln1wPnynaVn
 SnkmwoTXdXJG/xnI1VO2mhQ4ry0cNwEm5U6Tzt8Xuixf+I0XyQMmp66gN5jXzuIbzj9K
 b9Yd2H8qfLpWV97nEPAmE/pSbYo5eo3K2+7nU+4pa2cRMul1f4lSjbj7T3/Ccb+W6qxN
 RuCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIvOE+y7SmMYdFP+jTyOaLhpNHLD/QWUpgPSnrdcJlrRM9kTNw4JG3pluARbyHJIa0u9d0D5U=@lists.denx.de
X-Gm-Message-State: AOJu0YwDHkNw0XRlxMCQS1jDfdprIfuaKnkx4+MfLEbLmqp9YJepEV0J
 xQArDItgGLEgnXOhgkOn+OQgjW35T0mo3j0ltmQZeCQHqM7LWgtOcFGYqFldvlmtZso=
X-Gm-Gg: AY/fxX5du3xZdZKSpWCsZOrP8XJV00IzbOtTTrdJc7xXVw2wsIS2Axa0XNqDrFhK9r2
 TxYeuOS/I/8woH5enEkukxMkANRgKR+/3SdZMCzjuajEfaGduOk8wab1M24nxKVQktEr1PKUFon
 /JQRDMwMyE2kgx0SgrTkZl8GKRpNnaXfqDywBE1ysk1NTzccjOR8SPPM7rj67ctbBP12ZLwGBFU
 4Ri5lIPYuPpxjvgcjBfI9ddR9WzwBwZKoBEuFUjuBri6js/KNkxLdamx4T0nEEgl4G3B6aBonkm
 5Tof3oss2Ok7mK4GDlIZYC31jhPRIpDvhAefMECPnACbLcAATlIMmWhnfof8tEh/cREKAsSsmRb
 VAZBklvjT1DDCiiCOV7svC/rrel0Mu6Q0FiNlj17ArPbbzlyfsMW9yS+InRRTgAH9tcifTPIVMG
 5IlHILo4VsBQ8Bm4L6w2Znt4VBbs4DGuIItEQ1XeKfwhebYWMSwplbpHpK3Rl5Tjg=
X-Google-Smtp-Source: AGHT+IHmE5JwUAru/wlggCks+J0xaou7CdxgyWjpzRIs4icmqvT4wiMr0NlaPwr0viec4Ald8XPOGw==
X-Received: by 2002:a05:6000:1786:b0:431:342:ad42 with SMTP id
 ffacd0b85a97d-432bc9f56d0mr150134f8f.44.1767626422127; 
 Mon, 05 Jan 2026 07:20:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033?
 ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca57019sm67763f8f.37.2026.01.05.07.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 07:20:21 -0800 (PST)
Message-ID: <aa3ea5e2-d0f3-4af0-b181-0e93b5dd8a8a@linaro.org>
Date: Mon, 5 Jan 2026 16:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/5] scsi: ufs: renesas: Refactor 0x10ad/0x10af PHY
 settings
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
 <20260103002254.183357-4-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260103002254.183357-4-marek.vasut+renesas@mailbox.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/3/26 01:22, Marek Vasut wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Extract specific PHY setting of the 0x10a[df] registers into a new
> function.
> 
> Ported from Linux kernel commit
> cca2b807c227 ("scsi: ufs: renesas: Refactor 0x10ad/0x10af PHY settings")
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/110eafd1ee24f9db0285a5e2bca224e35962268a.1741179611.git.geert+renesas@glider.be
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/ufs/ufs-renesas.c | 37 ++++++++++++++-----------------------
>   1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
> index c8fbe61901b..b2edc3b5497 100644
> --- a/drivers/ufs/ufs-renesas.c
> +++ b/drivers/ufs/ufs-renesas.c
> @@ -130,6 +130,16 @@ static void ufs_renesas_indirect_poll(struct ufs_hba *hba, u32 gpio, u32 addr,
>   	ufs_renesas_write(hba, 0xf0, 0);
>   }
>   
> +static void ufs_renesas_write_phy_10ad_10af(struct ufs_hba *hba,
> +					    u32 data_10ad, u32 data_10af)
> +{
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ad, data_10ad);
> +	ufs_renesas_write_phy(hba, 0x10af, data_10af);
> +	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> +}
> +
>   static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   {
>   	u32 timer_val;
> @@ -204,29 +214,10 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   	ufs_renesas_write_phy(hba, 0x4000, 0x0000);
>   	ufs_renesas_write_phy(hba, 0x4001, 0x0000);
>   
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ad, 0x0000);
> -	ufs_renesas_write_phy(hba, 0x10af, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> -
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ad, 0x0000);
> -	ufs_renesas_write_phy(hba, 0x10af, 0x0002);
> -	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> -
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ad, 0x0080);
> -	ufs_renesas_write_phy(hba, 0x10af, 0x0000);
> -	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> -
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ad, 0x0080);
> -	ufs_renesas_write_phy(hba, 0x10af, 0x001a);
> -	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> +	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0001);
> +	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0002);
> +	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x0000);
> +	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x001a);
>   
>   	ufs_renesas_indirect_write(hba, 7, 0x70, 0x0016);
>   	ufs_renesas_indirect_write(hba, 7, 0x71, 0x0016);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
