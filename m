Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1229606A334
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ia1+4sMC;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mkT1z9Zd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D176407AD;
	Wed, 25 Nov 2026 13:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bw0Sp2Sb0NQ8; Wed, 25 Nov 2026 13:44:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 95DE4405B0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795614250;
	b=VnEd1z6fZx6FHYTnC2Oqf3f887Xc10zt1N3wi4TFcaInCOGY+5RI3Q2BEOfxw3LTTmD4
	 6oGDrhY31qSPDd7wXvwN2kLaVYKh3uYnznczP/S45e91skxhGjEHdVzZWmK/EgE59i79l
	 0iKiwfLXKnkGrNOEtZomj8wblAYZNTh+m5E6aI9X1GEcbs9LO/GkS0cCjFarMKCyXDLA+
	 3GsNGOZhsPpmF4RXFKK+fUoYHpw/OCd77PI9wYqBCAqFp1gGbM8B4lGZKFWueuwwxAPcp
	 XU1A8m9+mEgswi7neBmZBeu+L5tCVoTKscodOSIPB7MhTDIacyJrtCmXLooD+hYFKog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795614250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=OGuwM83Jm7GQwIks6V1UETLLkesfDRrEla6kmFhmy+0=;
	b=E5rgTpY8zM2g8xSyhjPVruwVq60dbqqg4sUzPR7/JM5MFjDBS2QPYuDLMzVB9SRy2O/s
	 ld41euRBh0+kJU3BEpvuWxYueIeulBGTYRU2HE6/1iyBw0wdTIxsILXKEYOdjlehbCySr
	 v2kkMH2tElTPq2EIRfa8b98f/r7bcdrm44MQmP0HuMDSI1f8c8UNi/eeseqqdr8rVzQlW
	 skk+1/7Uc2jUoWKGEDyfq+yq7hoDfXhmBDhv8GBJpALKH7TpBOZGyeDlgCXV67YhatfSL
	 MUyamXl5zFWC6rKbQLl2UF4oZpjmOmyxMMJzVHD/WT//scrmfBxMGUCDW7n6nx/YRzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795614250;
	bh=OGuwM83Jm7GQwIks6V1UETLLkesfDRrEla6kmFhmy+0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Ia1+4sMCE8iLE4zF8YB6G5MF61TsryrB2i4d4IbqtkqulFTWDHi/hMwiEDK4KEphT
	 chrvM1VxAWphn458QKqAhWqDA2KGe9yv2onqNVXMfn+7weeEwaMqFsoIX6UYZ4Txwo
	 4Sb1HSzs3rF6AsG80LQHlqIkQKNeRaHjSIWFOYzRH4yV+lMBHE3yRgMxViQzOpAJ0e
	 Yz8Z27iPZnoJ6/TNDRLgrHFQTplkYnpDADEb9bIjChn6Cblo0oe/xfwqYrM/0HhfZl
	 aH9ti/IzVlo6QCaU2MFMtK9wH2NslE0IxXIZ1+96WFtlodXkYu/L+QcYf+jsUQcZYn
	 Te0bmdptmb++A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95DE4405B0;
	Wed, 25 Nov 2026 13:44:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D704822B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCCA680AED
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9Egc8euiEyy for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 13:44:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4960A80AEA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mkT1z9Zd
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4960A80AEA
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:44:07 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so4073431f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 05:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795614246; x=1796219046;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OGuwM83Jm7GQwIks6V1UETLLkesfDRrEla6kmFhmy+0=;
 b=mkT1z9Zdp0+4YJp3i5cmk6nRCXSlFcC6s/LdQa5KEACdjqCI7sOcSaNdPk90A+7y7/
 ptU+rlyuCUYoVEdi06jPFYv7didfT307i3lwqrjJTgEazSCmsTkmsYKXxYqr6PyCWrdf
 UFjQHjbm1+uVoAfdbhJ/DH0uwkmGNmD7cVZ0EVqsznnTQTPXVBXb7i0DVh9866OUHGZJ
 Q2sq5ZYf3mWz7CMbuIfw8mrByN3F/YNVl7856eZ6ck13/Ah+dm3gBXHYxCgXh/4HE0wc
 d6iv7EuIjAjUe6Y0UsumP8bkMyRM5G9JnH+RC+ego8FJRpdloBA6VtsRWA5eo7tcLSgR
 6CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795614246; x=1796219046;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OGuwM83Jm7GQwIks6V1UETLLkesfDRrEla6kmFhmy+0=;
 b=CElJAEYGXeAg5LSLorsfrZWRZZytNJd+sySdww+fXwM3NGucWysZnEfl6WKlw2AK9u
 KO8j3CHMYdQJLiKLO4WAnptggEMJw91rz9CcGpdgsfdWvYVMYBAJjBSK0B7dm8jNZela
 oStflXwAwMusbuRcU+FYiDgm9LjyRJxveYKVOD58+XqLWoXGH4k0NvLwBfVWgbrF3nit
 RtVpKqwnWmGnwfQGM1rO8MVGoSVf8Q1N7ArbAJ4UkYKOKtHqViHJDIuenl9BbW3PwuHh
 3uDHbfgQIAyYSMJW5F0B11DmL9yOy5fQ5OVWibZSGqOgTjzjNhpgOBaeTQNfcYdbIr8h
 5FtA==
X-Forwarded-Encrypted: i=1;
 AL+hErEYuXc5fDDnYWQEAgwunbY+83VmfJipBGZwPHD6mJtgqIugRMLXWvmzc9Fb1DO/WPUP9miY+wo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/wfglejI2BhKDFkd1Z/TBjopARODnRXLDaNH2l/yQvy87IeUZ1
 841lbfynPMt2Lgg+JyQ1AWdEbhB80kUDHpaAi0EBuMPeE+E4r/her/6HJkeHe/+bs4I=
X-Gm-Gg: AZFdTZfHYPMFCcQQVlebogwxQP3gA1WbpI9zkNioWJdmg+RVqQ7xc3rtNcisfqwezdE
 sZOvYz6p6IM8IGZkGBm6pvn4yVXVBdT+WnrbbiBls43/07P1VGsng3HbBcIIDpb6zuA5gxQ1Lbe
 ISns1Ivfpf+EiCMfs3vrU/kR8btE4/3j93xbbYqdDHwfmFdj4Fz/JT4lKAVyzstb5DI9KZkA+om
 rR6nLEl7xpD2LG5775cdUnz4qWV70fsu537vhUqo+KFtLDmXc56QvhTAGuhiqwK5Ya89ztcL0if
 YP1o/sx1ofwF6SYrDLmj9BcAU8XUA1qA3d81npJGD3Cmt/fINVgMkup/TXzLFE0G0V7zguzwmZ2
 xFx6Yq3Ct4jX2v/8UpN65TEhBWCbQ8HMuFyY7QSLmeandRHdr8Y+4O7QlHHj0E7TaHKWb5z9Di5
 36vDoCp2GAyS3OQ0P420VaPF+AwC7sJGrJXOXaFSEGzcq1QzzZmDeYjNQei1rqFAfQ4xjtJwmtY
 9F+24VO6JazClllBOirosm9YCNTe4UCNl4rOhIROMbbrxYPctd/00kkii+262sZWBY3mSafXciJ
 AvMAiFXDb9X1iBbC5cHiMXJq8njLC0ppl1sjLmnpuZV5GsoroinaIYgIqvqYu2UZdgTHkSA+Ig2
 UEiRXoYWvlA==
X-Received: by 2002:a05:6000:27c9:10b0:4a9:9a59:c7a6 with SMTP id
 ffacd0b85a97d-4abb2ece9d6mr26543901f8f.16.1795614245314; 
 Wed, 25 Nov 2026 05:44:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:beb2:e1f9:ff58:397e?
 ([2a01:e0a:106d:1080:beb2:e1f9:ff58:397e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2e6dsm33837557f8f.6.2026.11.25.05.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 05:44:04 -0800 (PST)
Message-ID: <4cd7aba3-cada-4a6c-b2a6-a11fe4a65352@linaro.org>
Date: Wed, 25 Nov 2026 14:44:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/9] interconnect: qcom: Add SM8350 interconnect driver
To: u-boot-qcom@groups.io, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Erikas Bitovtas <xerikasxx@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Demeter Barna <me@fromdisposition.org>, David Heidelberg <david@ixit.cz>
References: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
 <20261114-sm8350-support-v1-3-414271f59474@fromdisposition.org>
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
In-Reply-To: <20261114-sm8350-support-v1-3-414271f59474@fromdisposition.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 13:52, Demeter Barna via B4 Relay via u-boot-qcom wrote:
> From: Demeter Barna <me@fromdisposition.org>
> 
> Add the interconnect (NoC) driver for SM8350 with the nodes of the two
> UFS paths, the only ones U-Boot requests, as the QCS8300 driver has
> them.
> 
> Taken from Linux's drivers/interconnect/qcom/sm8350.c (tag v7.4-rc1).
> 
> Signed-off-by: Demeter Barna <me@fromdisposition.org>
> ---
>   drivers/interconnect/qcom/Kconfig  |   7 +
>   drivers/interconnect/qcom/Makefile |   1 +
>   drivers/interconnect/qcom/sm8350.c | 271 +++++++++++++++++++++++++++++++++++++
>   drivers/interconnect/qcom/sm8350.h |  25 ++++
>   4 files changed, 304 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 4123a1d224..6a030a7891 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -17,6 +17,13 @@ config INTERCONNECT_QCOM_QCS8300
>   	help
>   	  Enable support for the interconnect driver for the QCS8300 SoC.
>   
> +config INTERCONNECT_QCOM_SM8350
> +	bool "Enable interconnect support for SM8350 SoC"
> +	depends on INTERCONNECT_QCOM_RPMH
> +	help
> +	  Enable support for the interconnect driver for the SM8350 SoC.
> +	  It has the nodes of the UFS paths.
> +
>   config INTERCONNECT_QCOM_SM8650
>   	bool "Enable interconnect support for SM8650 SoC"
>   	depends on INTERCONNECT_QCOM_RPMH
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index ac6b8cee19..c4b38d13a0 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -6,4 +6,5 @@
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_RPMH) += icc-rpmh.o bcm-voter.o
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_QCS8300) += qcs8300.o
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SC7280) += sc7280.o
> +obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SM8350) += sm8350.o
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SM8650) += sm8650.o
> diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
> new file mode 100644
> index 0000000000..71423c9b22
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm8350.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021, Linaro Limited
> + */
> +
> +#include <dm.h>
> +#include <interconnect-uclass.h>
> +#include <dt-bindings/interconnect/qcom,sm8350.h>
> +
> +#include "icc-rpmh.h"
> +#include "sm8350.h"
> +
> +static struct qcom_icc_node xm_ufs_mem = {
> +	.name = "xm_ufs_mem",
> +	.id = SM8350_MASTER_UFS_MEM,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SM8350_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qnm_gemnoc_cnoc = {
> +	.name = "qnm_gemnoc_cnoc",
> +	.id = SM8350_MASTER_GEM_NOC_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SM8350_SLAVE_UFS_MEM_CFG },
> +};
> +
> +static struct qcom_icc_node chm_apps = {
> +	.name = "chm_apps",
> +	.id = SM8350_MASTER_APPSS_PROC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SM8350_SLAVE_GEM_NOC_CNOC },
> +};
> +
> +static struct qcom_icc_node qnm_snoc_sf = {
> +	.name = "qnm_snoc_sf",
> +	.id = SM8350_MASTER_SNOC_SF_MEM_NOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SM8350_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node llcc_mc = {
> +	.name = "llcc_mc",
> +	.id = SM8350_MASTER_LLCC,
> +	.channels = 4,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SM8350_SLAVE_EBI1 },
> +};
> +
> +static struct qcom_icc_node qnm_aggre1_noc = {
> +	.name = "qnm_aggre1_noc",
> +	.id = SM8350_MASTER_A1NOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SM8350_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node qns_a1noc_snoc = {
> +	.name = "qns_a1noc_snoc",
> +	.id = SM8350_SLAVE_A1NOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SM8350_MASTER_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qhs_ufs_mem_cfg = {
> +	.name = "qhs_ufs_mem_cfg",
> +	.id = SM8350_SLAVE_UFS_MEM_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_gem_noc_cnoc = {
> +	.name = "qns_gem_noc_cnoc",
> +	.id = SM8350_SLAVE_GEM_NOC_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SM8350_MASTER_GEM_NOC_CNOC },
> +};
> +
> +static struct qcom_icc_node qns_llcc = {
> +	.name = "qns_llcc",
> +	.id = SM8350_SLAVE_LLCC,
> +	.channels = 4,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SM8350_MASTER_LLCC },
> +};
> +
> +static struct qcom_icc_node ebi = {
> +	.name = "ebi",
> +	.id = SM8350_SLAVE_EBI1,
> +	.channels = 4,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_gemnoc_sf = {
> +	.name = "qns_gemnoc_sf",
> +	.id = SM8350_SLAVE_SNOC_GEM_NOC_SF,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SM8350_MASTER_SNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_bcm bcm_acv = {
> +	.name = "ACV",
> +	.enable_mask = BIT(3),
> +	.num_nodes = 1,
> +	.nodes = { &ebi },
> +};
> +
> +static struct qcom_icc_bcm bcm_cn0 = {
> +	.name = "CN0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &qnm_gemnoc_cnoc },
> +};
> +
> +static struct qcom_icc_bcm bcm_cn1 = {
> +	.name = "CN1",
> +	.num_nodes = 1,
> +	.nodes = { &qhs_ufs_mem_cfg },
> +};
> +
> +static struct qcom_icc_bcm bcm_mc0 = {
> +	.name = "MC0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &ebi },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh0 = {
> +	.name = "SH0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &qns_llcc },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh4 = {
> +	.name = "SH4",
> +	.num_nodes = 1,
> +	.nodes = { &chm_apps },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn0 = {
> +	.name = "SN0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &qns_gemnoc_sf },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn7 = {
> +	.name = "SN7",
> +	.num_nodes = 1,
> +	.nodes = { &qnm_aggre1_noc },
> +};
> +
> +static struct qcom_icc_node * const aggre1_noc_nodes[] = {
> +	[MASTER_UFS_MEM] = &xm_ufs_mem,
> +	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
> +};
> +
> +static const struct qcom_icc_desc sm8350_aggre1_noc = {
> +	.nodes = aggre1_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
> +};
> +
> +static struct qcom_icc_bcm * const config_noc_bcms[] = {
> +	&bcm_cn0,
> +	&bcm_cn1,
> +};
> +
> +static struct qcom_icc_node * const config_noc_nodes[] = {
> +	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
> +	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
> +};
> +
> +static const struct qcom_icc_desc sm8350_config_noc = {
> +	.nodes = config_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(config_noc_nodes),
> +	.bcms = config_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(config_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const gem_noc_bcms[] = {
> +	&bcm_sh0,
> +	&bcm_sh4,
> +};
> +
> +static struct qcom_icc_node * const gem_noc_nodes[] = {
> +	[MASTER_APPSS_PROC] = &chm_apps,
> +	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
> +	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
> +	[SLAVE_LLCC] = &qns_llcc,
> +};
> +
> +static const struct qcom_icc_desc sm8350_gem_noc = {
> +	.nodes = gem_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
> +	.bcms = gem_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const mc_virt_bcms[] = {
> +	&bcm_acv,
> +	&bcm_mc0,
> +};
> +
> +static struct qcom_icc_node * const mc_virt_nodes[] = {
> +	[MASTER_LLCC] = &llcc_mc,
> +	[SLAVE_EBI1] = &ebi,
> +};
> +
> +static const struct qcom_icc_desc sm8350_mc_virt = {
> +	.nodes = mc_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
> +	.bcms = mc_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const system_noc_bcms[] = {
> +	&bcm_sn0,
> +	&bcm_sn7,
> +};
> +
> +static struct qcom_icc_node * const system_noc_nodes[] = {
> +	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
> +	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
> +};
> +
> +static const struct qcom_icc_desc sm8350_system_noc = {
> +	.nodes = system_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(system_noc_nodes),
> +	.bcms = system_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(system_noc_bcms),
> +};
> +
> +static const struct udevice_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,sm8350-aggre1-noc", .data = (ulong)&sm8350_aggre1_noc },
> +	{ .compatible = "qcom,sm8350-config-noc", .data = (ulong)&sm8350_config_noc },
> +	{ .compatible = "qcom,sm8350-gem-noc", .data = (ulong)&sm8350_gem_noc },
> +	{ .compatible = "qcom,sm8350-mc-virt", .data = (ulong)&sm8350_mc_virt },
> +	{ .compatible = "qcom,sm8350-system-noc", .data = (ulong)&sm8350_system_noc },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qnoc_sm8350) = {
> +	.name = "qnoc-sm8350",
> +	.id = UCLASS_INTERCONNECT,
> +	.of_match = qnoc_of_match,
> +	.probe = qcom_icc_rpmh_probe,
> +	.bind = qcom_icc_rpmh_bind,
> +	.unbind = qcom_icc_rpmh_unbind,
> +	.ops = &qcom_icc_rpmh_ops,
> +	.plat_auto = sizeof(struct qcom_icc_provider),
> +};
> diff --git a/drivers/interconnect/qcom/sm8350.h b/drivers/interconnect/qcom/sm8350.h
> new file mode 100644
> index 0000000000..580b139185
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm8350.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * SM8350 interconnect IDs
> + *
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021, Linaro Limited
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8350_H
> +#define __DRIVERS_INTERCONNECT_QCOM_SM8350_H
> +
> +#define SM8350_MASTER_UFS_MEM		0
> +#define SM8350_MASTER_GEM_NOC_CNOC	1
> +#define SM8350_MASTER_APPSS_PROC	2
> +#define SM8350_MASTER_SNOC_SF_MEM_NOC	3
> +#define SM8350_MASTER_LLCC		4
> +#define SM8350_MASTER_A1NOC_SNOC	5
> +#define SM8350_SLAVE_A1NOC_SNOC		6
> +#define SM8350_SLAVE_UFS_MEM_CFG	7
> +#define SM8350_SLAVE_GEM_NOC_CNOC	8
> +#define SM8350_SLAVE_LLCC		9
> +#define SM8350_SLAVE_EBI1		10
> +#define SM8350_SLAVE_SNOC_GEM_NOC_SF	11
> +
> +#endif
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
