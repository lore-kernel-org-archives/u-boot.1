Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C55CD98ED
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96DBA846B0;
	Wed, 17 Jun 2026 09:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EARrV+kN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024D984895; Wed, 17 Jun 2026 09:41:59 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A05FE838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso35909865e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781682115; x=1782286915; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=goMe+g2fPv3EYJuQfMYuWFAuMu2FQQLm54IC2Wni6Ss=;
 b=EARrV+kNToxOmVsGP8VQpoQ4maXqvDjK6CATbrB5oZ9JDRwA7Vzqtt6f4kA7yWT2uW
 OlJGIvMTOG6rDkG8hSGg6G60khe0ndhEYHQQyLfgc8GxqRPt+BkNb3SGEdbGeQVo7GLx
 Ui3qh2yPatTrKQjt9fEFt9pGSTdGfW2i1Hi5pwO7ScNUz9Bwj2ZrsVYw2YCz+ZWLKtIG
 qpqZsfFbULCPL12kNWbmyYGMXG1j/a+R5IV/pX2t96s3vknmnO2BcF3Wx2/GFgR4bjbR
 A97JkoNrv3jXNXClJu5aAOrpfU96TMn2+yxCILowr2M2Nl8hU5xkoNVxp+xnfXtmu/lR
 hMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781682115; x=1782286915;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goMe+g2fPv3EYJuQfMYuWFAuMu2FQQLm54IC2Wni6Ss=;
 b=gaNC0xOpqCqh1I5mjwlyath5JyVmxSNJEoge2qdseVxKaxXw+zjkgaEHcWMIY9BbGl
 vReRCNOs+V9A3TunM+ABR4WCqux74sNOeNOigjKjD4yofCyQ+UhsAWXjNZa6BzpVd6kV
 S3h9ieILUnl5FVz+eKquxGF/qqnNwqKpYknpz0gwPWCOTw+SYYPJvjTESnfXJt6cWTVe
 HQoYEznW2A/L9HgThD8nW6pmzSQcaPNCy3LOEoD55J5Bkj42BItKxeNewW+MuavFNVy+
 sDDXKgAXWZs/s+M71IJDNP57qHYO/0Eie8/yc/dV63VMr5/9i5uBnyoZ6RIA+xPc9U5c
 yK5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dEzRsXD036UDkrzQfbqPlRdQkoJIJM11nxpYskdEsoFJDLXRmL0YJuaFRvMleAjBh/WOnao4=@lists.denx.de
X-Gm-Message-State: AOJu0YwaC2ml/qMwpkIdKHiCLyZg/0DfENSsOeqkPzNECXcZ6sNAeAvr
 9cbkG0pQmRGqvDzQeYqbzQSdBco+BuwfFx5r70MPnRkH/6Hoszuwk+45fRTVk+/dhNQ=
X-Gm-Gg: Acq92OFz65rQRqlWnSc7Ak5yhhQx/LZFaWvgPYgzTp0RP6u0VvfXMc00zS2RvFwPJW5
 Y5ExiwOdVBDBbFHzjLPPJg1Taz1cmscM6BbyIpgcnqSUPR4BaxD0dE58B/5LF3zG0RUU3/Nj08l
 cGV/q2g4w/y828Y8bGPS30kZ6pa1qOGaU2iaAH30QLzMmqJvOFLiqD5RUOttK4M+FK6TKHZCQDP
 ltJdanIsVuoHtPy98WuLqYDbNHrBX8h6tu2Dntlcd5IBVZb2uFzyUwnLOTIkvbwgtL45X5LHJ+7
 Q1lfXGtwY+Inj2iFm8D+lBsCqpy7LBulxhlcuE/GoOhGSibknCu1PqmAXadtnpZd9hlveoCLYgT
 PXvl7mVzzCGa69dtYPGyjZNV200p2i/pzVfb0GM9Dw7NOkeKC2qUEF+6UIU+D535CSU4grXq6Q/
 Rj21feKpF5sUqEF60l5EwgjA==
X-Received: by 2002:a05:600d:8496:20b0:490:e180:2ed with SMTP id
 5b1f17b1804b1-492333e8f34mr29297055e9.4.1781682114933; 
 Wed, 17 Jun 2026 00:41:54 -0700 (PDT)
Received: from [10.12.4.106] ([212.133.41.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a45b30sm130176075e9.2.2026.06.17.00.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 00:41:54 -0700 (PDT)
Message-ID: <3ed2c692-28cb-4ae0-910f-d022d9b7e73d@linaro.org>
Date: Wed, 17 Jun 2026 09:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] usb: tcpm: fix inverted poll condition in
 tcpm_pd_transmit()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>
References: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
 <20260617-tcpci-dwc3-v1-1-b824fe1e9299@nxp.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260617-tcpci-dwc3-v1-1-b824fe1e9299@nxp.com>
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

On 6/17/26 10:23, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The read_poll_timeout() macro breaks out of its loop when the condition
> evaluates to true. The current code uses "!tx_complete" as the
> condition, which means it exits immediately when tx_complete is false
> (i.e., transmission has NOT completed yet), rather than waiting for
> completion.
> 
> Fix the condition to "tx_complete" so that the poll loop waits until
> the TCPC signals transmission success/failure/discard before
> proceeding.
> 
> Without this fix, tcpm_pd_transmit() returns before the TCPC has
> finished transmitting, causing the PD state machine to proceed with
> stale tx_status values.
> 
> Fixes: 1db4c0ac77e3 ("usb: tcpm: add core framework")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/usb/tcpm/tcpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
> index 3061b466d7c..d6c0be82333 100644
> --- a/drivers/usb/tcpm/tcpm.c
> +++ b/drivers/usb/tcpm/tcpm.c
> @@ -207,7 +207,7 @@ static int tcpm_pd_transmit(struct udevice *dev,
>   	 */
>   	timeout_us *= 5;
>   	ret = read_poll_timeout(tcpm_transmit_helper, tx_complete,
> -				!tx_complete, false, timeout_us, dev);
> +				tx_complete, false, timeout_us, dev);
>   	if (ret < 0) {
>   		dev_err(dev, "TCPM: PD transmit data failed: %d\n", ret);
>   		return ret;
> 

I just figured out the similar patch sent last year was never applied:
https://lore.kernel.org/all/20250526-topic-tcpm-tx-poll-cond-v1-1-38a81560ffff@linaro.org/

Whichever patch is applied it fine for me:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil
