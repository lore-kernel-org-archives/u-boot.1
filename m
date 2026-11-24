Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57484606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y/enInX7;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SXev+RTL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 316D260801;
	Tue, 24 Nov 2026 10:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bv4uRDhNolPf; Tue, 24 Nov 2026 10:36:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 21338607E0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795516602;
	b=i66tMCdUuziqzkRhMwRGavlgL11Ylre1p8SsP9W5T1BAxza58iOHTxoRHgJCzIRTGeid
	 uNGbF9B8QA8ZYCMIfqhKQquMUf7hqVse9Czd7qQJwLN10rNWwHo48IUrni5z+z1woPh/s
	 zjn8LxazXcyQmaicAkBmxDKQQE7d0or8PY7f3hDbdALUnrDcajY24VaJXO61obRO4HH7L
	 Y019PduE5QUGaOf3xEuZgaPuyaxYxkFZMFyE3kG108MqGeNbAWFFRsr7pcCyDE0X3+8fz
	 uJs5rV37qSN1xB1jEXs0jBLw4xpdoXhxNuAYLeQliER2zXECH4YX9KNwWOQJi7PVbUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795516602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mdAGW5VUMhBtTzY76iNPDMyIDuAsaKydvX3zcIExBaE=;
	b=O+Uo6WYkJyy/Xhnk2fkvMMKoiIINF90zw5yZgTllduflmumIXUs9mhIMhCTAZpMrOusK
	 BUHCNHxA3TuthYrfwcnhFrD8BjZFx9vll9asatfz3zr807NVU6GTiwXijy/fTzFyF0PA/
	 9XL/XR8ff88hooqIFkuL2SLf+jnN0Jj9pt/VkMLvNqkPPJ0A1qijBr4kvwxWIweVuWPFo
	 JqDr59m/b5qlLQL9kZeWwwCCel432DBBENep2Y5wt5ahz7TzhlFb5141/7XDFBpWsIapX
	 HJFGtgitiN0Lk8izXLKckWskNHd8klc4d1UGSWpeuHoJZUfQ7Xk2zEU/kfpRYE4rsIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795516602;
	bh=mdAGW5VUMhBtTzY76iNPDMyIDuAsaKydvX3zcIExBaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y/enInX71l9dCpX0oFMJ9B2lAVbKdEwI3p9qBB3ZBDWSsXfktd7Ps5Bp27lLRqS96
	 8cosS90mZSmAZOThebaoFcflmAYKDMoTr4O7qHEg8a71XBDW+r3weGbtL6CFfrCy62
	 Ar396AVlj+1inZNIJRput34HMrh9bcZQm1TQWWL2RmKQToPXcxnVkNUDMzLFqKcwNW
	 4f29yRssSX++oJ3APILHXf/i/3bScblVTuWU+GpIo7YSO+G14+vD64h6NW9SvQlD+i
	 SF5bhHEC9Ojq7XF1O+eAQIFLUNhVrYtbZmh+GZBpndgFbSiGS8T8koV9v2AXHWpHUA
	 0I6zFrkPPHoOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21338607E0;
	Tue, 24 Nov 2026 10:36:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE52A1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF4684074C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwgOTuTpsOkc for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 10:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD15B406ED
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SXev+RTL
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD15B406ED
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:36:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A74FC41A84;
 Tue, 24 Nov 2026 10:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999C11F000D8;
 Tue, 24 Nov 2026 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795516598;
 bh=mdAGW5VUMhBtTzY76iNPDMyIDuAsaKydvX3zcIExBaE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SXev+RTL4fsiF3N4cOeS14fmDaDqm3CGgeSTzcY0oFOgtwLXBOKu/S2ndX/PHiOEj
 EHNS9uROXTYlG/fyU7iE2AUW3bmV5Lnw0yiG+6kN0if122dDJ5rwK6tfEBvKSoHCYk
 wN6CYIfUXoYDoKIMXn3rZulRLXb6M+3UHX7VeQGYsUu3J5k26k+FXLsr5AF3zAi3qT
 klVr1lpvy/sQa9rGr4UjC7hoKmq6dUpLGuC5BvFURmueo9xcCkjNZgSgubVmlxCTQC
 Ei+s9SzryiC4cQAqGgBBJGy99zaXuosXmfDL/O9EYY3ymKYYkOdX+QCxLzv0duDPfv
 JqNNDsTCupotg==
Date: Tue, 24 Nov 2026 10:36:32 +0000
From: Yixun Lan <dlan@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] clk: spacemit: k1: Use generic CCF enable/disable
 callbacks
Message-ID: <20261124103632-GKA245721@kernel.org>
References: <20261124-k1-clk-fix-v1-1-fca6382fdf48@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261124-k1-clk-fix-v1-1-fca6382fdf48@pigmoral.tech>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Junhui,

On 15:38 Tue 24 Nov     , Junhui Liu wrote:
> The custom enable/disable callbacks look up the requested clock in the
> provider's clock table, handle its parent and call the gate operations
> directly. If the ID is not found, they still use the caller's struct clk
> as a hardware clock. The gate operations then interpret it as part of a
> struct ccu_mix and access invalid register mapping data, which can cause
> a load access fault.
> 
> These callbacks provide no K1-specific sequencing. CCF already handles
> clock lookup, parents and reference counts, and dispatches hardware
> operations through the registered clock's callbacks.
> 
> Use ccf_clk_enable() and ccf_clk_disable() to look up the registered
> clock by ID and delegate to clk_enable() and clk_disable(). Return an
> error for an unregistered ID instead of accessing an invalid hardware
> clock object.
> 
> Fixes: 3aa2882a3e1 ("clk: spacemit: Add support for K1 SoC")
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Looks good, thanks for the patch

Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
> I found this while testing SPL pinctrl support on a K1 board with
> Anand's GPIO/pinctrl SPL support series [1]. CLK_AIB and CLK_AIB_BUS,
> which the pinctrl controller requires, are not registered in SPL.
> After retaining the SD pin configuration nodes in the SPL device tree
> and attempting to boot from SD, enabling these missing clocks caused
> SPL to crash.
> 
> The custom callbacks crashed without indicating what operation had
> failed:
> 
>   Trying to boot from MMC2
>   Unhandled exception: Load access fault
>   EPC: 00000000c080a378 RA: 00000000c080a4f6 TVAL: 0000006b0000306e
> 
> With the generic CCF callbacks, the same test returns an error instead
> of crashing and reports:
> 
>   Trying to boot from MMC2
>   Enable system-controller@d4015000 failed
>   spacemit_pinctrl pinctrl@d401e000: Fail to enable bulk clks
> 
> This makes the clock enable failure visible. The missing SPL AIB clocks
> need to be added separately. This patch only fixes the callbacks.
> 
> [1] https://lore.kernel.org/u-boot/20261123193714.5096-1-linux.amoon@gmail.com/
> ---
>  drivers/clk/spacemit/clk-k1.c | 58 ++-----------------------------------------
>  1 file changed, 2 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
> index 20b8595aa3c..ae2bdcbd18a 100644
> --- a/drivers/clk/spacemit/clk-k1.c
> +++ b/drivers/clk/spacemit/clk-k1.c
> @@ -1501,66 +1501,12 @@ static struct clk *k1_ccu_apmu_clks[] = {
>  };
>  #endif
>  
> -static int clk_k1_enable(struct clk *clk)
> -{
> -	const struct spacemit_ccu_data *data;
> -	struct clk *c;
> -	struct clk *pclk;
> -	int ret, i;
> -
> -	data = (struct spacemit_ccu_data *)dev_get_driver_data(clk->dev);
> -	for (i = 0; i < data->num; i++) {
> -		if (clk->id == data->clks[i]->id) {
> -			c = data->clks[i];
> -			break;
> -		}
> -	}
> -	if (i == data->num)
> -		c = clk;
> -
> -	pclk = clk_get_parent(c);
> -	if (!IS_ERR_OR_NULL(pclk)) {
> -		ret = ccf_clk_enable(pclk);
> -		if (ret)
> -			return ret;
> -	}
> -	ret = ccu_gate_enable(c);
> -	return ret;
> -}
> -
> -static int clk_k1_disable(struct clk *clk)
> -{
> -	const struct spacemit_ccu_data *data;
> -	struct clk *c;
> -	struct clk *pclk;
> -	int ret, i;
> -
> -	data = (struct spacemit_ccu_data *)dev_get_driver_data(clk->dev);
> -	for (i = 0; i < data->num; i++) {
> -		if (clk->id == data->clks[i]->id) {
> -			c = data->clks[i];
> -			break;
> -		}
> -	}
> -	if (i == data->num)
> -		c = clk;
> -
> -	pclk = clk_get_parent(c);
> -	if (!IS_ERR_OR_NULL(pclk)) {
> -		ret = ccf_clk_disable(pclk);
> -		if (ret)
> -			return ret;
> -	}
> -	ret = ccu_gate_disable(c);
> -	return ret;
> -}
> -
>  #define K1_CLK_OPS(name)				\
>  static const struct clk_ops k1_##name##_clk_ops = {	\
>  		.set_rate = ccf_clk_set_rate,		\
>  		.get_rate = ccf_clk_get_rate,		\
> -		.enable = clk_k1_enable,		\
> -		.disable = clk_k1_disable,		\
> +		.enable = ccf_clk_enable,		\
> +		.disable = ccf_clk_disable,		\
>  		.set_parent = ccf_clk_set_parent,	\
>  		.of_xlate = k1_##name##_clk_of_xlate,	\
>  }
> 
> ---
> base-commit: ee1b3477e3af6af1ae9b8f98bc84d2cc6f32a3a6
> change-id: 20261124-k1-clk-fix-f918f7b26001
> 
> Best regards,
> --  
> Junhui Liu <junhui.liu@pigmoral.tech>
> 

-- 
Yixun Lan (dlan)
