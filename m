Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015CAC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DAB04083F;
	Tue, 21 Jul 2026 07:28:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUu6iuf_IYaF; Tue, 21 Jul 2026 07:28:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6CAA40827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784618891;
	bh=Tg4Iqh6ufJjBPsRpeCIxF1O34hDY5WDd38VtPOQlljw=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rZ4y5wFgLqih+qEKTaUUv1RueGQP2igzY2CvVIKf1IBADV3aw5xmlD0rYY4jRXMdP
	 BHxpl7JYc2PgoXFDrcA2ZOqytTVIhvA4dRDPJdEoFDpeyIzs5/mdpUxPiWsoyPK1ib
	 EuXAitLdqSUWtPQEA2pDapvehXl7s5PzClIeaP94oSvQLOttwR6AcsXL80pAU+adJp
	 pYLwWS6LEkdveHgdzfBVhQUpCDEKtR0gnZkKx/74t2hEXf39EErBWXHn7o1MAzVH+F
	 yKsNut/+oRepHuodwUKpFIJPHlD6CZnm0Z9kOMGm8WjP9WlKZ7xxIJfD0hD5txdW5E
	 067WJ7jTylwhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6CAA40827;
	Tue, 21 Jul 2026 07:28:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 808751099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6654A40827
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:26:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lks2bvLbffRp for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:26:56 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=neil.armstrong@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 15B294080E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15B294080E
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 15B294080E
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:26:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69173803F6; Tue, 21 Jul 2026 09:26:54 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B2FC84659
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:26:52 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso29992215e9.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784618812; x=1785223612;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tg4Iqh6ufJjBPsRpeCIxF1O34hDY5WDd38VtPOQlljw=;
 b=A2InhfS9tO/QBwQUdBULHIpiiYS6kS1udorUzpLNehnDuDHsuO60SyXaHtidLmPwhf
 y1XooGVXIwfo73iGVT+C29e0VsLd2U8xMP3EWYfdtHiSCOom6AAebfA4sQkkRcNcjETm
 apSIlQMVt+Uydx3Gl+XUd/Lvzu+Irnn7tZkg71UMHPnx8ul2QLQU55ZK1J9fR6cKhf0N
 PARw0QgFA7UqrZ98AWCvREgRaIghm1DBbtHs2eT1EbfbpHm9CI/shd59dESPNjlAZXRN
 oziob/xGxWCDTmlzuqhkbd79rk1K3fw9XU6VL00ykN4xmPULuAN6amVsDkXBTua59GMM
 L2JQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUV54QHB7sYwcmbCBrDwXlFWhcEp8HnApzcNUHmmh3tYXccVT7K93bgWMSU6edv03DxR4bUfg=@lists.denx.de
X-Gm-Message-State: AOJu0YxszfpGtL3OoHTzLZkMHZYumnIHWlTaZqnQQgFvX2RVIEYVUU44
 tzuiYMfZrq3KfO4j9pkSl+UfVQ9anEeQye+7uZIB7deXmrNtuBtGkbV6tQf+JjuXSco=
X-Gm-Gg: AfdE7cl4bStlFXbmV39acVejh8M8xiRZJlkFHDtZsz0DEwFb3jV/JCzU/TV5tU+ibFr
 NN1ZGDcVHwQuXH/R66tuwoHQcB5bFpPLJTeEasT7B4kHM4uAajnLXs01FtCz7RaxkK5pn5fbJhd
 6WTvl/zIKpWFuqoy717hfQsfPOlBLDDDBaeC90LGu9MKb8rny3J9D18J2hQn4t4pVSDxMuTP/5j
 nAZazspYOgeIIBdaplVYs8TwBGGmNx/E6ef2OoakStGJ1DTeHz0z1Q07kduWBGDUAaqrn7yDUCD
 pHitwEbzlBynEi1p6jfiwaoKm8m3AZnHRgvc4XIJNqohXyviIa2vNzx7lgpMJaksXM7KyAI6XIH
 Y/vynVSgcbjgH+yVLf+HPYD5m6lKqJ7Y+0+pymUy4OfF/uz0ccfwz6fVsUmVjFmS4tkfEUU1y/h
 6HraMzVwxr3gESO8VxsIX/x2mz47qnCu7kYi1IrYtBScvQh5NVO50VLT/CEqeOxuiCI1E9
X-Received: by 2002:a05:600c:4f54:b0:495:4815:2c54 with SMTP id
 5b1f17b1804b1-4954a41303amr193263685e9.34.1784618811576; 
 Tue, 21 Jul 2026 00:26:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1?
 ([2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49564011868sm63244485e9.3.2026.07.21.00.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:26:51 -0700 (PDT)
Message-ID: <b0bcf3b3-83b7-4a01-9fae-5e135f2dfc66@linaro.org>
Date: Tue, 21 Jul 2026 09:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/36] ufs: qcom: use clk_prepare_enable_bulk()
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>,
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com,
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Mario Six <mario.six@gdsys.cc>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Andre Przywara <andre.przywara@arm.com>, Thierry Reding
 <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
 <20260720-casey-ccf-upstream-july-v1-34-8fece1b0333d@linaro.org>
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
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-34-8fece1b0333d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:28:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784618812; x=1785223612; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tg4Iqh6ufJjBPsRpeCIxF1O34hDY5WDd38VtPOQlljw=;
 b=o/NmZCDwyqQRMlucbT7PU5MoCwcj/1m9nGnPaVFp1vX/LjjQM94LZCZ6wMNv7WIAzM
 09CF2fNOXqsAP83JBrYjID5U4EGri1CW1UWFZWB8GwZ3GohU+JiJThekr5Cj97NvHfoX
 wSJaNt+ui/XtCcpWOEkAXnIjQKbceTGHcyG899WrX7dZMs2J3moAd180iT/x576ZaeFD
 VAt5CiUEzmWASGDDVdEG+1/qutbw5rb3nhVKuk6A0EnaIEQwxodjO67jcRQB0xjP67Oc
 J2labX1r/5ZWxT8Rs+AVLTP/oycKw5VJTnTu8eBtUjD1cCVOQ8bZdoSCaGtd4YTSY6JH
 o1RQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=o/NmZCDw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="o/NmZCDw"; 
 dkim-atps=neutral
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
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/20/26 18:41, Casey Connolly wrote:
> With CCF the clocks have to be prepared before enabling. The CCF core
> will do this for us but it's much better to be explicit.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/ufs/ufs-qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index f5f5a6eb110c..3656c3861cb5 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -38,9 +38,9 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>   
>   	if (priv->is_clks_enabled)
>   		return 0;
>   
> -	err = clk_enable_bulk(&priv->clks);
> +	err = clk_prepare_enable_bulk(&priv->clks);
>   	if (err)
>   		return err;
>   
>   	priv->is_clks_enabled = true;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
