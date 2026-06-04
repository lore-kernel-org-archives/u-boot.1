Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCACCD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 06:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F5383FF5;
	Thu,  4 Jun 2026 08:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KobmeaDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6087484715; Thu,  4 Jun 2026 08:59:29 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5135848DC
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 08:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45fd45e596cso137623f8f.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 23:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780556365; x=1781161165; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vA3pIlB4sr+EG/jptsuCU/pLXJLDwW1iBXZ7guxr2Lo=;
 b=KobmeaDBtzOvJk3c6Rrf4bZzrBoBhlfxsxUJZfi1d9ZDJs+UMK0TViwPr7nqR8i8tU
 h8D8eIp2nhaRWBjerYvJY4s4hRhEQ0+KG5TmiWaYb75/l8p0dHSO2kqvTn1n9HqPN+6Y
 xgYoqAHGkqQiH/DOWPJz3JzKGtZgBwtA2bTNXVxfZ1GPx99fRBcPOTxn1JHhcZu4TVB9
 IFHzIioS5WqIhM/jXwkXOgBpY4rPdTdo2cMrIvtYJK5x4qwT3cxcoO4EwPZ2X54JA43X
 eL3mgnHaeWIZ0jNshOgs0S6g+zf8LIjMrOkBMGKkP9v26skL85HBDOli61XcEfbTDpo0
 lCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780556365; x=1781161165;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vA3pIlB4sr+EG/jptsuCU/pLXJLDwW1iBXZ7guxr2Lo=;
 b=bnCxVDopNGTsUoH1QiX3yxJ2JR+JEekxNn2ubnP/VDPaJisWBGZZmqED6sBm/+YsAn
 6AvJxFgu1LQGMJA+3HgV7h9gPwkVce9tEjEVHhxFg2WPawNUN3Fr34T0CKYZ9r+Lme4e
 nppmGrO8OKGcLW9Nno1KtaRP3q1BQ9v0FY9gcP/ezDCWo6UZTAq4AGUdD7p07SDlHbE0
 Ile/BAYWS3q8ihYlz+uxuX8UnAL7PD9TJrBMPJlodpJUu0jgu0SJDWKo/8HF4y0geM/q
 QoyNhEeAglCZBxMlG+GbdxBdIcLsCmx1wegtzbfJeGegxHGW+gOWFrgHP1RpTH/MCPeN
 5o8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sjVSpPvc/KuHG0BgC0uAvw7reSH6I8b1lzoZ9D0J36KNIekYEDEpRXCYmDPkDuq3oMOw9ffA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxew3oknCNLH6SVFK8NRaqHZG7Fy+P3Tn86aZYP/YVrDpnnjMFW
 uwLfFiovOZ53QEyS6n4hFtWPgbKD+Jw1UgaPYgd5Bg9CHuwlwpkqirpNjYwuuH3AQFE=
X-Gm-Gg: Acq92OE2uJHLM5yBjivhE85J8tSzIZWMGb8JXAzXZwdHc8Ft2E39TqfGWxvLfaogu5w
 ZcfBnGo2NggBRBb3kjAxEEelX4hsc5CDJKrSXJ000jr0uXWTE4rwZOAo/KK+Hg4nEhOcTHNxOPL
 WFGtqZxCkHUZ+PBrzW9kSjhKkG5p8c9Jc0d9/lZDB/vfQQCvEBdU1s5pBjDJtjyAVXHrlTEhv/d
 bC9xB8Qv/dcRY4kQRWdVx0V2z1EA3l9llv2T/7IzTiXbNn32djdHY9fxK2I2zjjqlzPHvSqc7m1
 8SJuNjlRrk570a3geRRkCNqmv5+sBTuraEVFsuY1zekSxA+8SNWv3OIeKu1uBCgjLtmptgQpJpc
 x6o5ljn47TA70X4HSK/2EIQqOVlquJCO+x63aaOz0QK/wbNEvV00gTJyCM9h6eGBukjZVZiSQd4
 1F9mzpEgmgqqPvI0w+rgTmLMvZRAoqHwFFXEZvAsBAFQ==
X-Received: by 2002:a05:6000:299c:20b0:45e:f52b:f4b7 with SMTP id
 ffacd0b85a97d-460217f1fddmr7198025f8f.17.1780556365172; 
 Wed, 03 Jun 2026 23:59:25 -0700 (PDT)
Received: from [172.20.10.3] ([37.167.4.222]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcae2sm14596722f8f.6.2026.06.03.23.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 23:59:24 -0700 (PDT)
Message-ID: <a98fe06c-be89-4f0a-a547-15ce783c55cf@linaro.org>
Date: Thu, 4 Jun 2026 08:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/6] mach-snapdragon: fixup CPUs with PSCI enable-method
To: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
 <20260602-msm8916-smp-support-v2-4-792e53dac374@samcday.com>
 <0291ada3-0426-4893-93ae-f49cd7c1eb91@linaro.org>
 <NSO1C4Gn8wtOi9FvzD06-Mqkv1rpQAJuKgQ6BFNMPeNiJ_bJugEd-VzU-zwzn4U1dcBY6-U8jV46v1gE-80q7pbeI_rM2bDSa6FmDpNzs-Y=@samcday.com>
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
In-Reply-To: <NSO1C4Gn8wtOi9FvzD06-Mqkv1rpQAJuKgQ6BFNMPeNiJ_bJugEd-VzU-zwzn4U1dcBY6-U8jV46v1gE-80q7pbeI_rM2bDSa6FmDpNzs-Y=@samcday.com>
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

Hi,

On 6/4/26 08:53, Sam Day wrote:
> Hey Neil,
> 
> On Thursday, 4 June 2026 at 4:33 PM, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 6/2/26 09:19, Sam Day via B4 Relay wrote:
>>> From: Sam Day <me@samcday.com>
>>>
>>> If there's no PSCI implementation, then change the enable-method of all
>>> CPUs from "psci" to "spin-table". Later, when spin_table_update_dt runs,
>>> it will further patch the CPU nodes with the necessary cpu-release-addr.
>>>
>>> This new fixup is only applied when CONFIG_ARMV8_SPIN_TABLE is enabled,
>>> since that also determines whether spin_table_update_dt runs.
>>>
>>> Signed-off-by: Sam Day <me@samcday.com>
>>> ---
>>>    arch/arm/mach-snapdragon/board.c | 41 ++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 41 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>>> index 829a0109ac7..3b08069af98 100644
>>> --- a/arch/arm/mach-snapdragon/board.c
>>> +++ b/arch/arm/mach-snapdragon/board.c
>>> @@ -183,7 +183,9 @@ static void show_psci_version(void)
>>>    static void qcom_psci_fixup(void *fdt)
>>>    {
>>>    	int offset, ret;
>>> +	uint reg;
>>>    	struct arm_smccc_res res;
>>> +	const char *prop;
>>>
>>>    	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>>>
>>> @@ -198,6 +200,45 @@ static void qcom_psci_fixup(void *fdt)
>>>    	ret = fdt_del_node(fdt, offset);
>>>    	if (ret)
>>>    		log_err("Failed to delete /psci node: %d\n", ret);
>>> +
>>> +	if (!CONFIG_IS_ENABLED(ARMV8_SPIN_TABLE))
>>> +		return;
>>
>> Can this be dynamic ?
> 
> Sure can! ... Just as soon as I pin down exactly what you mean by that :D
> 
> Are you asking that this be guarded not just by ARMV8_SPIN_TABLE
> enablement, but also by root device compatible?
> 
> e.g:
> 
> 	if (!CONFIG_IS_ENABLED(ARMV8_SPIN_TABLE))
> 		return;
> 
> 	if (fdt_node_check_compatible(fdt, 0, "qcom,msm8916") &&
>          fdt_node_check_compatible(fdt, 0, "qcom,apq8016"))
> 		return;

Yes perhaps move this in a helper function to guard all the spin table functionality ?

Thanks,
Neil

> 
> Kind regards,
> Sam
> 
>>
>> Neil
>>
>>> +
>>> +	/* If spin-table support is enabled, make sure any CPU nodes with a
>>> +	 * PSCI enable-method are updated to spin-table. Further, any PSCI
>>> +	 * power-domains properties are removed.
>>> +	 */
>>> +
>>> +	offset = fdt_path_offset(fdt, "/cpus");
>>> +	if (offset < 0)
>>> +		return;
>>> +
>>> +	for (offset = fdt_first_subnode(fdt, offset);
>>> +	     offset >= 0;
>>> +	     offset = fdt_next_subnode(fdt, offset)) {
>>> +		prop = fdt_getprop(fdt, offset, "device_type", NULL);
>>> +		if (!prop || strcmp(prop, "cpu"))
>>> +			continue;
>>> +
>>> +		prop = fdt_getprop(fdt, offset, "enable-method", NULL);
>>> +		if (!prop || strcmp(prop, "psci"))
>>> +			continue;
>>> +
>>> +		reg = fdtdec_get_uint(fdt, offset, "reg", 0);
>>> +		ret = fdt_setprop_string(fdt, offset,
>>> +					 "enable-method", "spin-table");
>>> +		if (ret)
>>> +			log_err("Failed to set CPU%d enable-method to 'spin-table', this CPU will not be available to booted OS! %d\n",
>>> +				reg, ret);
>>> +
>>> +		log_info("Patched CPU%d enable-method to 'spin-table'\n", reg);
>>> +
>>> +		prop = fdt_getprop(fdt, offset, "power-domain-names", NULL);
>>> +		if (prop && !strcmp(prop, "psci")) {
>>> +			fdt_delprop(fdt, offset, "power-domains");
>>> +			fdt_delprop(fdt, offset, "power-domain-names");
>>> +		}
>>> +	}
>>>    }
>>>
>>>    /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
>>>
>>
>>

