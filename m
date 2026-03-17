Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45544FF6E8A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 22:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A54A68412F;
	Tue, 17 Mar 2026 23:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V729UwrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118A98413A; Tue, 17 Mar 2026 23:15:28 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF3E684113
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 23:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40946982a78so2449268fac.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773785724; x=1774390524;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OOqTgglO9k53cJ5g4FYzLWfizwn2THCBMtTCr+3VoVI=;
 b=V729UwrSLq5lpFU3SuiUM1O+X3ZAvep3v0QBpADC6Iu3uWiXeBDZJupZNLSyYT/lp6
 /9uGH3rGhrp4T6I/jtY200OvR6/G+GtHztjXAgNmILcAeLW/fZKeD8qiEpaunopBRYoG
 HUhGXwWNbu7v3Mh9tcyCpaQPi9+AeEJuo7HyxgOKpNqFZL3BN6k7vMrMFfjL3bw22I4u
 cD2yLYgYeA9fIOx2X4mFLrxuQvnpIj/XGIxkpW5Kht1llmXRSVUPX0cALjWqyXnmPHbi
 WGePQ4RwkHh2VXewZM6y5VunKq3cxKlPyeFbklwRNR4iCYjlIbU261/90C5jXxSPu+sg
 /aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773785724; x=1774390524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OOqTgglO9k53cJ5g4FYzLWfizwn2THCBMtTCr+3VoVI=;
 b=o3T3wOaVbeuo6jHFYcBuWI2PD2+Vl703S7fVjlkeFfpNUJ8LQA1yS4PVUQIkvNSnsL
 jemmb22xmGUyYFYiiSTsJKXK5JBjZN83r7PFkrpJoLptl6oad/fmMlX3E236ooXuAUEi
 oS+ni3UKC7Byqxblv1XpVimtbH0OuI8gU6DpZbVQJHnx6wqQhWEGetpjQerFvrUGTmRQ
 5Lbacqz56kwINadaNQ5TJiWy9BWl9RnsDb8mFrBjMPaoze9DUUz9WNr7dM/6wfBq9JMN
 eu3Z6bgdl8NlgWQGS5rA05NER4yxm7BlmJdvmLVniEL1WH74z8OMBDp1wg/18e+EuuMT
 I0HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXIMx3eg0/DjWIFVUvPAV+RKBc248p/Uo1fcoXEZlpotNodNMo3ygdu0phhEKjUJdShtGfYsY=@lists.denx.de
X-Gm-Message-State: AOJu0YxOoRA6Fire8KuC1MOeea6bPewpbrsLBCj3huE5z8QlIophYKCa
 po37vjTw1CT3liM/SsxeUn8uyXmcuBeN2EYDxq2n7UKk4vwZPsaFt5AXbv6678xcOnY=
X-Gm-Gg: ATEYQzx0dpADeJCKybL06KX+P9SeobxPK18BOUDw2Ug+CPGgV3a2ODcrpPZYpeZX+lN
 /BBkEZKJFa18CIrsjRNXQwXQrhlC+qn53TBsphPQ+NH6fAdIWxgyFobL5gMWsofj0iQ8WCJ7OOp
 FpIQnlYuNWO2m+ofMYvak9z0nbVqPCCVrysRJhdFBaVIchVbqkcfE5VAdAFY/xoolhskGDZh9xP
 0qa7rSFGhG10QhzIoTtsG4J1l8Z06VOWbx0lGs3pPwJtyBbBRd9tuVHAXKn77iwACdKcRw0UqrN
 iLyXDC5RGfHFz2qXT5cHK9QTKnCnkfPISmN5Ccc1REufsYPcsjdmOpMriWeZEYK1960HR7IF3qj
 zloNCKaey8ruS23Gkjbj4FEqfmM3b2bRT0OO0Vl6ELpIVBuTubMvKYZw3Qv/yAMHyW2HaO0Hyst
 pzsXe8poHLZDkh/hguNJDAurmmG/AkJ/Dc/ZWrDXwncfaQUSZVgKsXm0lPkKXrcCAmv/KNjVj/m
 3pITfo=
X-Received: by 2002:a05:6870:a79b:b0:417:3cc0:8dc9 with SMTP id
 586e51a60fabf-41bd3fcf713mr646822fac.24.1773785724428; 
 Tue, 17 Mar 2026 15:15:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:2fe3:965c:6248:c9?
 ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm990543fac.1.2026.03.17.15.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 15:15:23 -0700 (PDT)
Message-ID: <b1a12617-ec95-4730-a994-3354c5747d78@baylibre.com>
Date: Tue, 17 Mar 2026 17:15:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drivers: ufs: ufs-mediatek: implement clocking
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
 <20260317-mt8195-add-ufs-support-v1-9-7d731ec438ae@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-9-7d731ec438ae@baylibre.com>
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

On 3/17/26 9:24 AM, Julien Stephan wrote:
> Implement clocking.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/ufs/ufs-mediatek.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
> index 5d882904c84..31916f72c86 100644
> --- a/drivers/ufs/ufs-mediatek.c
> +++ b/drivers/ufs/ufs-mediatek.c
> @@ -177,6 +177,18 @@ static int ufs_mtk_link_startup_notify(struct ufs_hba *hba,
>  	return ret;
>  }
>  
> +static int ufs_mtk_get_clk(struct ufs_hba *hba)
> +{
> +	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
> +	int err;
> +
> +	err = clk_get_bulk(hba->dev, &host->clks);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}

Why a wrapper function to call a single function?

> +
>  static int ufs_mtk_bind_mphy(struct ufs_hba *hba)
>  {
>  	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
> @@ -317,7 +329,11 @@ static int ufs_mtk_init(struct ufs_hba *hba)
>  
>  	ufs_mtk_init_reset(hba);
>  
> -	// TODO: Clocking
> +	err = ufs_mtk_get_clk(hba);

	err = clk_get_bulk(hba->dev, &priv->clks);

Couldn't we just do this instead?

Or do we need clk_enable_bulk() too and that is missing from the
helper function?

> +	if (err) {
> +		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
> +		return err;
> +	}
>  
>  	err = generic_phy_power_on(&priv->mphy);
>  	if (err) {
> 

