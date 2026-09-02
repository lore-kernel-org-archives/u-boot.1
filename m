Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68479C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 249F860726;
	Wed,  2 Sep 2026 14:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXznL1IKNl-G; Wed,  2 Sep 2026 14:35:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788359735;
	bh=1DFzsMR394ryqSszL9SMAnrRH7x7uLTcZCkW0pOSo8M=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=EHDZTkhFIE4Oa+3cIVrm9OqVFrLfnVDKs/hSqL/sCHYA7XYpMLyHIK23iEM7WDLfS
	 jRGSJPFyxTKLs2Q8eg4O0rQSOXTjvmWIp8Q77R1NpRr3EjZA84+rGQeTcv8+sk5UFn
	 zoXAvl37sXWPrs9WemzDlri5KazBSOK/cQ7RnTVlxsywNVTaze7DJs8SKbeO7HooKF
	 dsiPD8ZJ5nPHQrLv9loLoCMV/GV3c9l3TQUgtScnF+H0fO9j00E9UNhNCSflG1oz7o
	 qrBR9U538d8qVMSpFOKxS53wAVdu7SgjYlPIZ3/3A7O8kQLIetmZ/Y1DZr4OaSDG0j
	 TIvLdNOJGSQcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DCDC606F5;
	Wed,  2 Sep 2026 14:35:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E836B127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA23E401B0
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E8Ojwxt2f4xO for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:35:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cObFHymV
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D10A240191
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:35:32 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a20319d030so1658986a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788359730; x=1788964530;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1DFzsMR394ryqSszL9SMAnrRH7x7uLTcZCkW0pOSo8M=;
 b=cObFHymVjjyc7a0W9fxg2czH5+5bKbfhMZ6LSxCswM80ihlW5sL/q/U0vADgKdMcTL
 Q4xPRbRRxYztRbrxqkUzPXpEylGHNwx7nMFLP0HJB8HoeHoyb713qeF14/YFiuWja6Xu
 d/f6s9Dbob63Lr5dF8uxW5s+osxtZz7IUzH2viYBlTIYpjegPtUE/i7KrIAvTTfhpsh5
 +ETJAaPs0cH6z7mH5IWCupYNCLbTkuB9SPa5h1lUYpLD41cnHCuvuy5hkpfHNVUOUYss
 iTtadpZumezDTFEJSiwafpMOKNqk78LlH9C6wrznX8NV6OatjpK3KpET1ux6vTNXfuNR
 sn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788359730; x=1788964530;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1DFzsMR394ryqSszL9SMAnrRH7x7uLTcZCkW0pOSo8M=;
 b=JvyWtpUXSUTBOEUztuQazOP2d7tWEMaWJeCg7fOM0pelWbrpkNx9S9G8Znq761Sxdq
 zTvnlrVjlNKhtwQ2e0caHj9KjcNbBqcD7nKVLI4RrOFRVWip8j0K/duSoHVwroiDA7wv
 pRn41Q48VnMf58l/sF2sQhau57tuY5d680ciIHCkEhZFGjSwpVlzmytj+vTFEofSyXki
 Y+zIRTXi3pxQne7erbVqlGFo9ch10MFsSPohCuUJ1Jnn4feH+skJGaR5+EZ7RaA8X0YM
 kLsp1Kr5fWqKHO3CV7g78xpVHUJKGFGCJa5c6dqgm/2QBYztBTsnqgRw/YWHkJ0QZd8X
 vBjg==
X-Gm-Message-State: AFuF++l35u4JBSnoEHTWte0hXUHBEVOmFtgItYoz1/+qqgEU0ImG8wBT
 +3VSw2AqQH7PNLLpZgPs/6VWiIuimms1fsTZcnUWuBIumuUYrPHkRZjRYA6oQDjMprI=
X-Gm-Gg: AYBFou1HLse3xFiUMffO+QfBkR8+Xa07ekauWeovYrfNB5bfZBEd1uc75A30qxEHDVz
 meCV5qPzUFwgRoi0NI2pWLmsjLXCJ5kNmPHN8NVi4eqaDdq8DujrHKOo8Knd/GoUSOUJqg9MAYN
 1Zr+z9ZnhdwTW/lLnNNVKJ4AhlqqmciG+Qp6M7loHlZmYl73d1sb4gUl6PiRpYa61XaxzLcUUmI
 dyAvcKvjRWUlJleLvaNgTfyuw6tOosK4OeTWMuUM43j0TkhPFAudf6rvyfTB/nXhxaw8JuU/Bs1
 D2ki/9Yk8gnfBYXJT3/upRfmVd3xcIif5HurgLkYE51QNORrnayn5CjHN/xgDFUZgRaxUqYD+4L
 fnHHC5xkg/qCpDXWI38L5YFkWerI8FDhU7FcxHWOEA3nGh+RKJ7/mauWjhHBY/1Hr87XOqdJQ12
 WbCjVcfcks4NceHMvCM7xLTzfBJghSTGLYxfL32OKmDLJZbYr6VRUll3KrJt1TP8M/Kdiwvalhg
 dk5HQRqs2Ctb6aSX+sRNCas4dYnOG7hKk72MOmFLykaij3B
X-Received: by 2002:a05:6402:2349:b0:6a3:fdb0:c374 with SMTP id
 4fb4d7f45d1cf-6a682abafe9mr3571453a12.13.1788359730128; 
 Wed, 02 Sep 2026 07:35:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e9e:e6f8:a41a:72c?
 ([2a01:e0a:106d:1080:e9e:e6f8:a41a:72c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a67f9329b4sm1186377a12.19.2026.09.02.07.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 07:35:23 -0700 (PDT)
Message-ID: <c960ead2-4dad-4ed3-bca8-04760fe47884@linaro.org>
Date: Wed, 2 Sep 2026 16:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] gpio: qcom_spmi_gpio: add pmk8350/pm8350c
To: Casey Connolly <casey.connolly@linaro.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
References: <20260902142937.2422919-1-casey.connolly@linaro.org>
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
In-Reply-To: <20260902142937.2422919-1-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/2/26 16:29, Casey Connolly wrote:
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/gpio/qcom_spmi_gpio.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index b218a3d3d585..bf2c11ebf8cd 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -766,8 +766,10 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
>   	{ .compatible = "qcom,pm8550b-gpio" },
>   	{ .compatible = "qcom,pm8550ve-gpio" },
>   	{ .compatible = "qcom,pm8550vs-gpio" },
>   	{ .compatible = "qcom,pm8998-gpio" },
> +	{ .compatible = "qcom,pm8350c-gpio" },
> +	{ .compatible = "qcom,pmk8350-gpio" },
>   	{ .compatible = "qcom,pmk8550-gpio" },
>   	{ .compatible = "qcom,pmr735d-gpio" },
>   	{ }
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
