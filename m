Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BE9C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 09:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 909AD86F50;
	Fri,  1 Dec 2023 10:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x0hy/ZQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DFD587678; Fri,  1 Dec 2023 10:31:50 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58DC886B2E
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 10:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50bc57d81f4so2744459e87.2
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 01:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423107; x=1702027907; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+h1NK48lfoodOnRNz9mfCaBRJ4i/CwNAVPkuvbAaETc=;
 b=x0hy/ZQTgKTPQDPkfdYOtejugta8kHWwIG3XXhoraPsNTzEJuKEMt7X9IC6HmWHOpB
 hT95Tp9NDPmCmz+KD678tc++AditiFBsWBOChVPpbcZXqJ4d51iWhP3cg3YZErikpa3+
 cYg+Cw0hqJ+8bfjaHJ5H0YmyZVvMoVdGjpP44eH0xrnt/q4h8r2Wir7l0TcIB3UvJE2E
 I63Pl/il5G+yaY32LYBlGW7fgjLsP9lCNZ8UkWj68PcJrepGDiqx/vUzjuErKkV7qWxA
 7YRu288Q7Ud+GxHdkXVkU2DWZVEOiHeAFHKzoiuDhRoumWs4QjyYPHxdduW+0NxfhfsF
 iUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423107; x=1702027907;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+h1NK48lfoodOnRNz9mfCaBRJ4i/CwNAVPkuvbAaETc=;
 b=wIX+xTh8BcBlC1wKku6LHP0ek4F/ghmHva/CnIRiDoBhm6vTl7yb8n5XwbW1QQrRs6
 wKnUE5xB21DQ4kOQKLgPFbte5G7gqHWYLAMMRD+eCyPeAnb+nQ/SsKzanqgy45BVKe4g
 bc02DSxuhi05KV/LvjRrYd1UbyRUKbEa3QunOzOibAPp6mfZjzU0gzW7rS1AV+11zmYx
 p0H40Pl99UbJiveI8Om7b3PM7FVF6fALzDK4U/L0yYP2Ms7MmXjBKs22nN0FTiGbqqSC
 VwG1/Yrv1s1l7EwdjSrfuwmfbqUWREcA8VB0G4LtG5kzikyxshfys9JUtjxyWEv3GBuv
 MkiA==
X-Gm-Message-State: AOJu0YyafWLPS/rdu1KIRqv4116WTCNPHYt8IOrAb6kXdZt78/JaNbck
 OgLw00w7S3JmJS897MX0j4tqwg==
X-Google-Smtp-Source: AGHT+IET9vzvaXmFx5DRfafJMUed/Os6GEQr96L6c6Yxp+i7kq5bY7CYKVpG93LDLdKknYt9/t8jWQ==
X-Received: by 2002:a05:6512:b96:b0:50b:d74e:d483 with SMTP id
 b22-20020a0565120b9600b0050bd74ed483mr438758lfv.74.1701423107389; 
 Fri, 01 Dec 2023 01:31:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:46dc:1c67:6d66:e21?
 ([2a01:e0a:982:cbb0:46dc:1c67:6d66:e21])
 by smtp.gmail.com with ESMTPSA id
 t14-20020adfe44e000000b00332cb846f21sm3695695wrm.27.2023.12.01.01.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:31:46 -0800 (PST)
Message-ID: <b8aded0c-46a1-4839-9729-748d31f59b61@linaro.org>
Date: Fri, 1 Dec 2023 10:31:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 9/9] pmic: qcom: dont use dev_read_addr to get USID
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
 <20231130-b4-qcom-dt-compat-v5-9-41500e237ad0@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-9-41500e237ad0@linaro.org>
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

On 30/11/2023 21:22, Caleb Connolly wrote:
> Linux DTs stuff a value indicating if the USID is a USID or a GSID in the
> reg property, the Linux SPMI driver then reads the two address cells
> separately. U-boot's dev_read_addr() doesn't know how to handle this, so
> use ofnode_read_u32_index() to get just the USID.
> 
> The Qcom pmic driver doesn't have support for GSID handling, so just
> ignore the second value for now.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt | 94 ------------------------
>   drivers/power/pmic/pmic_qcom.c                   | 13 +++-
>   2 files changed, 10 insertions(+), 97 deletions(-)
> 
> diff --git a/doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt b/doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt
> deleted file mode 100644
> index eb78e3ae7703..000000000000
> --- a/doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -          Qualcomm SPMI PMICs multi-function device bindings
> -
> -The Qualcomm SPMI series presently includes PM8941, PM8841 and PMA8084
> -PMICs.  These PMICs use a QPNP scheme through SPMI interface.
> -QPNP is effectively a partitioning scheme for dividing the SPMI extended
> -register space up into logical pieces, and set of fixed register
> -locations/definitions within these regions, with some of these regions
> -specifically used for interrupt handling.
> -
> -The QPNP PMICs are used with the Qualcomm Snapdragon series SoCs, and are
> -interfaced to the chip via the SPMI (System Power Management Interface) bus.
> -Support for multiple independent functions are implemented by splitting the
> -16-bit SPMI slave address space into 256 smaller fixed-size regions, 256 bytes
> -each. A function can consume one or more of these fixed-size register regions.
> -
> -Required properties:
> -- compatible:      Should contain one of:
> -                   "qcom,pm660",
> -                   "qcom,pm660l",
> -                   "qcom,pm7325",
> -                   "qcom,pm8004",
> -                   "qcom,pm8005",
> -                   "qcom,pm8019",
> -                   "qcom,pm8028",
> -                   "qcom,pm8110",
> -                   "qcom,pm8150",
> -                   "qcom,pm8150b",
> -                   "qcom,pm8150c",
> -                   "qcom,pm8150l",
> -                   "qcom,pm8226",
> -                   "qcom,pm8350c",
> -                   "qcom,pm8841",
> -                   "qcom,pm8901",
> -                   "qcom,pm8909",
> -                   "qcom,pm8916",
> -                   "qcom,pm8941",
> -                   "qcom,pm8950",
> -                   "qcom,pm8953",
> -                   "qcom,pm8994",
> -                   "qcom,pm8998",
> -                   "qcom,pma8084",
> -                   "qcom,pmd9635",
> -                   "qcom,pmi8950",
> -                   "qcom,pmi8962",
> -                   "qcom,pmi8994",
> -                   "qcom,pmi8998",
> -                   "qcom,pmk8002",
> -                   "qcom,pmk8350",
> -                   "qcom,pmr735a",
> -                   "qcom,smb2351",
> -                   or generalized "qcom,spmi-pmic".
> -- reg:             Specifies the SPMI USID slave address for this device.
> -                   For more information see:
> -                   Documentation/devicetree/bindings/spmi/spmi.yaml
> -
> -Required properties for peripheral child nodes:
> -- compatible:      Should contain "qcom,xxx", where "xxx" is a peripheral name.
> -
> -Optional properties for peripheral child nodes:
> -- interrupts:      Interrupts are specified as a 4-tuple. For more information
> -                   see:
> -                   Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> -- interrupt-names: Corresponding interrupt name to the interrupts property
> -
> -Each child node of SPMI slave id represents a function of the PMIC. In the
> -example below the rtc device node represents a peripheral of pm8941
> -SID = 0. The regulator device node represents a peripheral of pm8941 SID = 1.
> -
> -Example:
> -
> -	spmi {
> -		compatible = "qcom,spmi-pmic-arb";
> -
> -		pm8941@0 {
> -			compatible = "qcom,pm8941", "qcom,spmi-pmic";
> -			reg = <0x0 SPMI_USID>;
> -
> -			rtc {
> -				compatible = "qcom,rtc";
> -				interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> -				interrupt-names = "alarm";
> -			};
> -		};
> -
> -		pm8941@1 {
> -			compatible = "qcom,pm8941", "qcom,spmi-pmic";
> -			reg = <0x1 SPMI_USID>;
> -
> -			regulator {
> -				compatible = "qcom,regulator";
> -				regulator-name = "8941_boost";
> -			};
> -		};
> -	};
> diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
> index ad8daf43f06f..f2ac6494811d 100644
> --- a/drivers/power/pmic/pmic_qcom.c
> +++ b/drivers/power/pmic/pmic_qcom.c
> @@ -66,12 +66,19 @@ static const struct udevice_id pmic_qcom_ids[] = {
>   static int pmic_qcom_probe(struct udevice *dev)
>   {
>   	struct pmic_qcom_priv *priv = dev_get_priv(dev);
> +	int ret;
>   
> -	priv->usid = dev_read_addr(dev);
> -
> -	if (priv->usid == FDT_ADDR_T_NONE)
> +	/*
> +	 * dev_read_addr() can't be used here because the reg property actually
> +	 * contains two discrete values, not a single 64-bit address.
> +	 * The address is the first value.
> +	 */
> +	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &priv->usid);
> +	if (ret < 0)
>   		return -EINVAL;
>   
> +	debug("usid: %d\n", priv->usid);
> +
>   	return 0;
>   }
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
