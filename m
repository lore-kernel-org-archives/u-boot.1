Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E709606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M/Ux42K6;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Qzdg/4W1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5C9C60847;
	Thu,  5 Nov 2026 10:52:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DCk0OhrcFr01; Thu,  5 Nov 2026 10:52:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2F136080C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793875961;
	b=AviliwXTLvTc5dPNjganQqlpEhzpGyHRR9+AnaNXeKciVvN9ekE0WG2g/hqLqa+6PEYv
	 DWp53ySFkjZVIPRbpO22TGa9nJZC3BtYFA+e4RYmA8sVf+IkewinTo/GeRonmXxCUlj39
	 zI5K4pjYxq5c1hZk7PqyByVzO19HhEQ0Av5i/2Sf0PTjWtYpGFYliXTnDQO4XqDiB8h3G
	 m1Y2Ud0aDs3sW2JISj7Jq2nidOtklr/QcGVlDcQpAWP67gWOMrbXq5m4lnk9t13EqJTpp
	 qDEymIrKcGccyG1f16xczyYAFSjdME0CC27UMPtCzA3/uvr7nJh597wnx2ccCd/TW3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793875961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:References:Content-Language:
	 Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=ED70FI2y1wqiXdT7ZoUlv3DGKb4U2e2J1RekSKG8Alw=;
	b=k/DzrBAnWc8EukmSXcvq3SJSVdaEzUQoP7f4Tfo0aHUfBsSNVYYRg5MWKxjq+sYOGvnF
	 GcLLKO+lg594Y3WHUapYFbEWwsr+2MDUhu+bgjyGD4mvl8vxWqmTBTawgCNqmz6dMVh1M
	 mStmLzRM/xnwg6S0DU0Aykjeycv26fLpui8Doa0Z4mAjevHK7CiN3L8tRPC0YkuFyule0
	 7lrxMyK8MBzvX3AZVqYYCdV+li1I8o/2z/1crqbz6ZMJyB6Nkk2aR77+5uZrdiwKDmfda
	 ulZt1WY75E8Jlg038U1Heajfrw/bxxeGyfoaLaI2C9azxkfSXdo0tcIJ3zGMkcHIfUQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793875961;
	bh=ED70FI2y1wqiXdT7ZoUlv3DGKb4U2e2J1RekSKG8Alw=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=M/Ux42K6Wny/u1CY1ABs3Qv0Ug72aKiyIix2miqm2TeSwYu1xNQvqZtsHKJhedVbM
	 C2AnDf4Q0CWNQN/czu7CHvDvs4gIwiDRyxCBOg08op5Yq9iPrfKZeSn7uCJ2stVSDE
	 E4Gs9Rh/P5iAPI5+Jn8NEtKi45f1K0BH441xYc4Y6sIfKPw6fjkFiYZILlqPC0NjMM
	 JUXfDQQn36KsPSIwFkl2ST+7lSdRoVegfs7FV6juKW/ef/H/oqiG4NVOh0Nx8h680F
	 p6v9z3ox53g3j7jC5fGU1u7ujSNHNLGKHw/zb1TAVG0vh3Lm1RcaoEXtLUrFQKp0Ds
	 0Lqlks5ZhR9Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2F136080C;
	Thu,  5 Nov 2026 10:52:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 954DC1779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A490407EC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wuienrfa61Fw for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F517407E9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Qzdg/4W1
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F517407E9
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:52:37 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so15388505e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793875956; x=1794480756;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ED70FI2y1wqiXdT7ZoUlv3DGKb4U2e2J1RekSKG8Alw=;
 b=Qzdg/4W1qraAT8l8KhZ+aOCJDqjc5fC8j+F8etFXtEwG1AiHtK/KRRKqOrByBaVlue
 5RAHjuxwbuwhQTR5je2gBQ9F9VEyFnwgFxuFBNZ/hmqWAXt0jadcXD9+heJU9R5iFhxJ
 CATR0GGXcPvFQPgWpKOhJam5+7aSU3ZW/uE2uvlE6uQdaVMsoL/ns9u0TDkJTNaBrmhz
 Bc6aNM6FqdLCSFivPNeTzLPlUk6PE8OQXog1NrrXERaD7/ZuDxwUqUsFgrfbcd7o7TvN
 REmI1Ng1muk8TIqV3wIjoEOgT2HzEkUMWliXO8xrHroifDfkiEaynDxMeWh5pg0eUxYb
 Rz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793875956; x=1794480756;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ED70FI2y1wqiXdT7ZoUlv3DGKb4U2e2J1RekSKG8Alw=;
 b=NWGy8FhCumht8SjajathUnEYWoO/cpRdLxGhEIatt0+zzdmy4p2Qaxje/A5MrGPBbs
 32LQljtwapSi0ykfztYi9hTUydqM8VtpDS1A4PIqUMP5YmOldh1nUE8/LB29fhSNXOk0
 m6+oiIL5Usy9IR/8Wx3cSCzeunqy0HBEeTvW8129U9qVSKR/nVoJSBfSOqvUEM6/bNUE
 1ShUh4oNXnmVt81LMvUJbalUlTCkWj6eMdEIrHjAS+6VDCbJon/GzrhfKc89L+LpklF8
 6hHDcgD0rIRh2f59+AK3DKRwaKaJHCsPY8XPo/qcD3CnhskHjVUSX8CAeW2/rKflS9cU
 fNHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwut/PGsLWCkZYaGEb4R+RSyy3T1gR0wJ2EQv32vJq2kGIVYOuIPBcHCoP/3pvVbYKC/Y/X/Gk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+462Ovc68kRBbff9gHmzOdCJ8ceOv9GqJwVlcuk18YtIH8J/kT
 trTyxm979UYnxBFRz1tQovNGL1Fn0/sAKMjpDrKJm+ziao7+5RIKLc09SDE7qQJB+6Sc2FPJPC2
 Ybydv
X-Gm-Gg: AYBFou266J3/pERb7V7ymLTXlrSgK7bNZB1wv/jcu1R+STJMfz50AgO/1K7rwZgUFSy
 ZZUVRwkJpZmDPQzyLMUM4NihFTUieUuIdD0BsHzazwid6TdoJH0Kxawq416XpST6KftvC7kCwS9
 r43JVGUxaSnnejnHah4fGm5vt3CmKlmZ+6wxSInxFhQNWqA4SvtWzvwUIao+g31+MgJ3tyhbOwu
 gybbv5qj/HYj6SQFNp10p5rGBrjQxN2M0aYzxX54NP+bq4OpvXOYGSul7p+nKcZwtYoO6o573Kg
 JnMF340FY8QlFKOXyhadi2qXvOP0TVov6E+HVd2i8p8Cq4nct0aI2ygNVEQOImePUcBi5zkCVc/
 z0xgV+5FAPDXqiNDpvrWXd63TH/ISPgRiR7D+hArZST+/Fq9XazUWo/Q3to3pkwK18CwQUJ6MV8
 j3QTCKoTj4r1+UzpYdXO6c1ID9j8ViBjtNJV44yIltoxASxVkFCHygorqjg1X8a2opehTsdU7Q7
 dR7TpZOGSW43Eo5gLHnVX+N6wj93Cov4emC6vkSASuMa4c/ZFybUTdWd4KHfRuPtNz7hFxj1LUq
 OvtNV4Lt+zRiOhUDmjeXYBx+GDcmcb6gCSE/+JHwcjFaad2KvERPQHntHlK8MtPb/JNUpnW8F++
 bk1k95l5c
X-Received: by 2002:a05:600c:83c5:b0:4a2:148b:c88c with SMTP id
 5b1f17b1804b1-4ac17191017mr389888695e9.8.1793875955532; 
 Thu, 05 Nov 2026 02:52:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b572bba0f3sm54298445e9.9.2026.11.05.02.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:52:35 -0800 (PST)
Message-ID: <34e103da-2c45-49c2-9bdd-c645a8ed733c@linaro.org>
Date: Thu, 5 Nov 2026 11:52:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 5/9] phy: qcom-qmp-pcie: add SM8250/Kodiak Gen3x2 PHY
 support
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, senthilkumar.l@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
 <20261104163408.1250410-6-sumit.dhami@oss.qualcomm.com>
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
In-Reply-To: <20261104163408.1250410-6-sumit.dhami@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/4/26 17:33, Sumit Singh Dhami wrote:
> From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> 
> There is no QMP PCIe PHY config for SM8250-family SoCs such as
> Kodiak (QCM6490), so PCIe1 (RC1) cannot be brought up. Also,
> qmp_pcie_clk_init() only tolerate a missing "ref" clock, but some
> SM8250-family DTS files (e.g. Kodiak) name the rchng-equivalent
> clock "refgen" instead, failing clock init outright.
> 
> Add the SM8250-family Gen3x2 PHY register-init tables and a new
> qcom,sm8250-qmp-gen3x2-pcie-phy compatible and tolerate a missing
> "rchng" clock the same way "ref" is tolerated.
> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>   drivers/phy/qcom/phy-qcom-qmp-pcie.c | 187 ++++++++++++++++++++++++++-
>   1 file changed, 184 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcie.c b/drivers/phy/qcom/phy-qcom-qmp-pcie.c
> index 2f6ff259b35..bf6173b80e0 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-pcie.c
> @@ -24,7 +24,11 @@
>   
>   #include "phy-qcom-qmp.h"
>   #include "phy-qcom-qmp-pcs-misc-v3.h"
> +#include "phy-qcom-qmp-pcs-pcie-v4.h"
> +#include "phy-qcom-qmp-pcs-v4.h"
>   #include "phy-qcom-qmp-pcs-v5.h"
> +#include "phy-qcom-qmp-qserdes-com-v4.h"
> +#include "phy-qcom-qmp-qserdes-txrx-v4.h"
>   #include "phy-qcom-qmp-pcs-v6.h"
>   #include "phy-qcom-qmp-pcs-v6_20.h"
>   #include "phy-qcom-qmp-pcs-pcie-v6.h"
> @@ -89,6 +93,13 @@ enum qphy_reg_layout {
>   	QPHY_LAYOUT_SIZE
>   };
>   
> +static const unsigned int pciephy_v4_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_SW_RESET]			= QPHY_V4_PCS_SW_RESET,
> +	[QPHY_START_CTRL]		= QPHY_V4_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]		= QPHY_V4_PCS_PCS_STATUS1,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_POWER_DOWN_CONTROL,
> +};
> +
>   static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_SW_RESET]			= QPHY_V5_PCS_SW_RESET,
>   	[QPHY_START_CTRL]		= QPHY_V5_PCS_START_CONTROL,
> @@ -103,6 +114,120 @@ static const unsigned int pciephy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
>   };
>   
> +/*
> + * SM8250 / Kodiak (QCM6490) Gen3x2 PCIe PHY init tables.
> + * Ported from kernel drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> + * (sm8250_qmp_pcie_serdes_tbl / sm8250_qmp_gen3x2_pcie_* tables).
> + * Compatible string: "qcom,sm8250-qmp-gen3x2-pcie-phy"
> + */
> +static const struct qmp_pcie_init_tbl sm8250_qmp_pcie_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_SELECT, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_EN, 0x42),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE0, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE2_MODE1, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE1, 0xb4),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE0, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE1, 0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE1, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xa2),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1, 0x4c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_ENABLE1, 0x90),
> +};
> +
> +static const struct qmp_pcie_init_tbl sm8250_qmp_gen3x2_pcie_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x35),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x20),
> +};
> +
> +static const struct qmp_pcie_init_tbl sm8250_qmp_gen3x2_pcie_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1b),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x70),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_ENABLES, 0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0xd4),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xdb),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xe4),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xec),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0xbf),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +};
> +
> +static const struct qmp_pcie_init_tbl sm8250_qmp_gen3x2_pcie_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0x77),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RATE_SLEW_CNTRL1, 0x0b),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x05),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG2, 0x0f),
> +};
> +
> +static const struct qmp_pcie_init_tbl sm8250_qmp_gen3x2_pcie_pcs_misc_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P6_P7_PRE, 0x33),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_PRE, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_POST, 0x58),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2, 0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
> +};
> +
>   static const struct qmp_pcie_init_tbl sm8550_qmp_gen3x2_pcie_serdes_tbl[] = {
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x62),
> @@ -639,6 +764,21 @@ static const char * const sdm845_pciephy_reset_l[] = {
>   	"phy",
>   };
>   
> +/*
> + * SM8250 / Kodiak (QCM6490) Gen3x2 PCIe PHY register offsets.
> + * serdes=0x0000, tx=0x0200, rx=0x0400, tx2=0x0600, rx2=0x0800,
> + * pcs=0x0a00, pcs_misc=0x0e00 — fits within the 0x1000 reg window.
> + */
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x2 = {
> +	.serdes		= 0,
> +	.pcs		= 0x0a00,
> +	.pcs_misc	= 0x0e00,
> +	.tx		= 0x0200,
> +	.rx		= 0x0400,
> +	.tx2		= 0x0600,
> +	.rx2		= 0x0800,
> +};
> +
>   static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
>   	.serdes		= 0,
>   	.pcs		= 0x0200,
> @@ -660,6 +800,37 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_20 = {
>   	.ln_shrd	= 0x0e00,
>   };
>   
> +/*
> + * SM8250 / Kodiak (QCM6490) Gen3x2 PCIe PHY config (pcie1, x2 lanes).
> + * Compatible string: "qcom,sm8250-qmp-gen3x2-pcie-phy"
> + */
> +static const struct qmp_pcie_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
> +	.lanes = 2,
> +
> +	.offsets		= &qmp_pcie_offsets_v4x2,
> +
> +	.tbls = {
> +		.serdes		= sm8250_qmp_pcie_serdes_tbl,
> +		.serdes_num	= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
> +		.tx		= sm8250_qmp_gen3x2_pcie_tx_tbl,
> +		.tx_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
> +		.rx		= sm8250_qmp_gen3x2_pcie_rx_tbl,
> +		.rx_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_rx_tbl),
> +		.pcs		= sm8250_qmp_gen3x2_pcie_pcs_tbl,
> +		.pcs_num	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_tbl),
> +		.pcs_misc	= sm8250_qmp_gen3x2_pcie_pcs_misc_tbl,
> +		.pcs_misc_num	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_misc_tbl),
> +	},
> +	.reset_list		= sdm845_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= pciephy_v4_regs_layout,
> +
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status		= PHYSTATUS,
> +};
> +
>   static const struct qmp_pcie_cfg sm8550_qmp_gen3x2_pciephy_cfg = {
>   	.lanes = 2,
>   
> @@ -873,8 +1044,10 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	}
>   
>   	ret = qmp_pcie_do_reset(qmp);
> -	if (ret)
> +	if (ret) {
> +		dev_err(phy->dev, "qmp_pcie_do_reset failed: %d\n", ret);
>   		return ret;
> +	}
>   
>   	for (i = 0; i < qmp->clk_count; i++) {
>   		ret = clk_enable(&qmp->clks[i]);
> @@ -902,6 +1075,7 @@ static int qmp_pcie_power_on(struct phy *phy)
>   
>   	status = pcs + cfg->regs[QPHY_PCS_STATUS];
>   	mask = cfg->phy_status;
> +
>   	ret = readl_poll_timeout(status, val, !(val & mask), PHY_INIT_COMPLETE_TIMEOUT);
>   	if (ret) {
>   		dev_err(phy->dev, "phy initialization timed-out\n");
> @@ -998,8 +1172,12 @@ static int qmp_pcie_clk_init(struct udevice *dev, struct qmp_pcie_priv *qmp)
>   
>   	for (i = 0; i < num; i++) {
>   		ret = clk_get_by_name(dev, qmp_pciephy_clk_l[i], &qmp->clks[i]);
> -		/* Ignore failure to get ref clock */
> -		if (ret && strcmp(qmp_pciephy_clk_l[i], "ref") != 0) {
> +		/*
> +		 * "ref" is always optional. Kodiak/SM8250 DTS also uses
> +		 * "refgen" instead of "rchng", so ignore that too.
> +		 */
> +		if (ret && strcmp(qmp_pciephy_clk_l[i], "ref") != 0 &&
> +		    strcmp(qmp_pciephy_clk_l[i], "rchng") != 0) {

Perhaps add a table with all the possible ref clk names to ignore ?

>   			dev_err(dev, "failed to get clock %d\n", i);
>   			goto clk_get_err;
>   		}
> @@ -1097,6 +1275,9 @@ static struct phy_ops qmp_pcie_ops = {
>   
>   static const struct udevice_id qmp_pcie_ids[] = {
>   	{
> +		.compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy",
> +		.data = (ulong)&sm8250_qmp_gen3x2_pciephy_cfg,
> +	}, {
>   		.compatible = "qcom,sm8550-qmp-gen3x2-pcie-phy",
>   		.data = (ulong)&sm8550_qmp_gen3x2_pciephy_cfg,
>   	}, {

Anyway, it's still fine:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
