Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE6EF34C49
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 12:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E09839DF;
	Mon, 13 Apr 2026 14:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vdEO0RUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BCA483DC9; Mon, 13 Apr 2026 14:09:45 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 430A8839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 14:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso35202135e9.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776082182; x=1776686982; darn=lists.denx.de;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOVA4jbkHXz9nkWiI6IAmAo0bPvTZu69kvq99PyXMpU=;
 b=vdEO0RUzSRoX1uRZe8iKFus7NlVH8uRXJe7ZB+6/GthkQSnMbXJNupw7v5NY3svcet
 GCEnM6FI7/nbZHgliiGIUz3Ep/gLQz6Gu+HeXXezjaJCDTXZ6i7OVGAFak9ns7LQyGBy
 H3jyO+AYUuYLU7VI/JZHzzzYhCyStD+UFBEV0SK9BoaJKm1Ftvs5Pho6OBnPbOZbXTVI
 J4a39GPFI9RTRkXzZJmv35xGgyFfIvdxa3j7QGT9LApjJrVD4cUxI05+yBsR4xVgxdTc
 mWzIPEOGQmg7ooSqU/j8Qj43RmkL/hJG/RxYSt64PP1YDROi70u+adxVoTvOX7Vi6JSi
 vIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776082182; x=1776686982;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VOVA4jbkHXz9nkWiI6IAmAo0bPvTZu69kvq99PyXMpU=;
 b=dT3AU+OScoWfA4KyMplYqxWvtW1k7mPkqqTfmqA1WrSwM96PM/jTRFQkOyp+Xy4XgS
 1iKlFeKHSjZi+tiFBPpbKIzOCcSUER+s9C5eiucWb88CptI8MjpBv395TnATtnejJiRH
 jFwUdOsBIexQHh95cvni/jIgMh3VhUIEIT7DMjd+Nx39LhaTgr48JyBfRIwShLJn0LjH
 QJDTgbsFVLvL6JcCbYKW4ZU9Bqhbl125mD/n/iGLs53sHHdLp4N+CSLG/frhjMFop5lB
 ounFLDq52HddG6YDGbYjl7ZLEJtSTKcOnF8gN3bSldf5bG2vzPayr83vcdNOwGr89NX2
 MODw==
X-Gm-Message-State: AOJu0Yy4B0Y+wWdLSVTiqkQNwdx2FuelD5+kpI8Q7Fs7Rxab8pObNrbF
 9r75zQ3HqtCDb4AL/wcxCoMJwu65BKMVXbPfNLRYQlGnlsgIXQtLgGV4rMsJ8Py3wH4=
X-Gm-Gg: AeBDiesXXMOCtevu0ZV2SnrdopFpG6fVrkzVnpwsSFnJ5cncqxzRgQ6EsbMlQ3L2o9s
 Vq/u1qP7NxOaCADACLMQ2smpJRmzvD+8it7fZ7ybx7JdyFF22/z+kDpUdyjc2Yg3ZgidYdO2Bg+
 EJcGgWwvrPG8LNOgUBq8VPmVTK/nG84VhrgGT2G7d/HEhBOA3emuNSjhamqU8+F/78xBDAvXBpa
 aNM3lbl544lMnGafKGmqaVgoUk2wPzG6TTGMexijYc9IapdC6W72qGXnAVDrdF4Ovwg9J2Ivj9h
 6n0YJSd/cx+cS5Km9G22vAjFeTHWqoezac+GO5TpgyGZJuUt+Ipky5Algw1BUY7Ul36KW64ltIC
 ggDkzu/B0e9TnW56iHwaAd0bF+BAaUPC7ojkvmF14vCH7H/xdup1RjrqDUPjHiePUqmWg8nrkGO
 p/h86P+1i2i30XmUORyhqb6e9keTZs9+8aI1vBIDVcQkqfEsNt6jLcFr/e4ZRDjYccli63
X-Received: by 2002:a05:600c:64c4:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-488d686892emr158124725e9.25.1776082181155; 
 Mon, 13 Apr 2026 05:09:41 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5396293sm277577175e9.15.2026.04.13.05.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 05:09:40 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/5] drivers: ufs: qcom: Initialize and enable clocks
 before hardware access
From: Casey Connolly <casey.connolly@linaro.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260319-ufs_probe_clk-v1-5-08c085d6b15d@oss.qualcomm.com>
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
 <20260319-ufs_probe_clk-v1-5-08c085d6b15d@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:09:39 +0200
Message-Id: <177608217912.1177412.14533836406368185534.b4-reply@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3358;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=clubaUhsdbqqQiWQaIbRRsKigoo1UsZuIYQWn3ho3q4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw7d5nPnvll6nLrxhtV4w0ZSwyOT9seVRN2wO+ZQMvO7
 CvBe1JcOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEnk1n+CsZKmiZ/D666Ax7
 e6B41GX96SL7GIMORRaxnkgREGReupHhf22C85MY0dx92d7dVe5OGj8clr9hM1n0aN26W1Y/3j0
 W2QkA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

On 2026-03-19 15:07 +0530, Balaji Selvanathan wrote:
> Move UFS clock initialization and enabling before hardware setup
> to ensure clocks are running when accessing UFS registers.
> 
> Previously, U-Boot depended on earlier bootloader stages to
> initialize UFS clocks. When these bootloaders failed to do so,
> UFS registers became inaccessible, causing initialization to fail.
> This change makes U-Boot initialize and enable UFS clocks early
> in the init sequence, removing the dependency on previous
> bootloaders.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/ufs/ufs-qcom.c | 45 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index dc40ee62daf..c63e550c881 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -30,6 +30,7 @@
>  #define UFS_CPU_MAX_BANDWIDTH	819200
>  
>  static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
> +static u32 ufs_qcom_get_core_clk_unipro_max_freq(struct ufs_hba *hba);
>  
>  static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>  {
> @@ -49,12 +50,34 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>  
>  static int ufs_qcom_init_clks(struct ufs_qcom_priv *priv)
>  {
> -	int err;
>  	struct udevice *dev = priv->hba->dev;
> +	struct clk clk;
> +	int err;
> +	long rate;
> +	u32 max_freq;
> +
> +	/* Get maximum frequency for core_clk_unipro from device tree */
> +	max_freq = ufs_qcom_get_core_clk_unipro_max_freq(priv->hba);
> +
> +	/* Get and configure core_clk_unipro */
> +	err = clk_get_by_name(dev, "core_clk_unipro", &clk);
> +	if (err) {
> +		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
> +		return err;
> +	}
> +
> +	rate = clk_set_rate(&clk, max_freq);
> +
> +	if (rate < 0) {
> +		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
> +			max_freq, rate);
> +	}
>  
>  	err = clk_get_bulk(dev, &priv->clks);

Adding to the other comments here, since you already requested core_clk_unipro you shouldn't
request it again with clk_get_bulk(). Probably simplest at this point to just request all the
clocks individually for better or worse.

Kind regards,

> -	if (err)
> +	if (err) {
> +		dev_err(dev, "clk_get_bulk failed: %d\n", err);
>  		return err;
> +	}
>  
>  	return 0;
>  }
> @@ -561,6 +584,18 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  
>  	priv->hba = hba;
>  
> +	err = ufs_qcom_init_clks(priv);
> +	if (err) {
> +		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
> +		return err;
> +	}
> +
> +	err = ufs_qcom_enable_clks(priv);
> +	if (err) {
> +		dev_err(hba->dev, "failed to enable clocks, err:%d\n", err);
> +		return err;
> +	}
> +
>  	/* setup clocks */
>  	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
>  
> @@ -579,12 +614,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  		 priv->hw_ver.minor,
>  		 priv->hw_ver.step);
>  
> -	err = ufs_qcom_init_clks(priv);
> -	if (err) {
> -		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
> -		return err;
> -	}
> -
>  	ufs_qcom_advertise_quirks(hba);
>  	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
>  
> 
> -- 
> 2.34.1
> 
> 


