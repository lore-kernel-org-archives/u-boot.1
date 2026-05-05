Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCA9FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69E984913;
	Tue,  5 May 2026 14:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pumnWnSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B33D84913; Tue,  5 May 2026 14:58:13 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EC084910
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so6630098a12.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777985891; x=1778590691; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VdXU1KwlB89l/ZNZ2g8Eun13L+8UpNuG16uIy9kOkQo=;
 b=pumnWnScHfR+zBZqGc1gNOEFjKyGEkkX+g3esjnql29KjZJQD073BsE9QZswu3i0RC
 VBPphRPzckXWX+BKrQupvde6SyZiWWSyPKzIeeRe0pM30oNqjdVlbsCunGh+ID0Onya1
 vU0YiLWhLeQ71LK9RtbgJY1ZjNS29ZXuZW1mYCrujTnSzcrwyY9oVaHbGqQJVEWYMg6D
 ZzkJVIRZt8kWHMC/KD6/pByCPqosI/FFEQqZoc+w9nznn3Rb7XMoJXmqYPqNb2d1no3j
 5gU05dzv8whabvcWnUsNr5Mo+q+ETYzLvunRAsLwY58eNnOI4+lhR6hPp1vyMBbNCyQe
 Kujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985891; x=1778590691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VdXU1KwlB89l/ZNZ2g8Eun13L+8UpNuG16uIy9kOkQo=;
 b=eYRU1skNGaOT/cTjEiLZ8abU3U53rBFTsbOvZU1qOxI6a4NCDAe9npqOPcyfcbQvm6
 o1RKUVnudgFvyDjeYYDvUvgHUL6+nQzgH0lYnuOOhJzA1c8KBYmir8K4glil1taZKQcs
 +7W83/c2cLhDBgroVTCEIAGsCTIs/F1i9gghputbgLEsZobHpnz+GmoiFmv7z3STgXSE
 neR9W063RAS+UvGvdoOFuYZhWwcM+EAUT9YrH2k1spSrL9bqTeEx8QmfWmB97UQrFhhC
 r7RJ0ZMTST6Okxl+fjpLZAgF5LhSnADkoifW4LA8NfPMtqzKb0YL0j3Ia5h/AfeYKY7+
 XpOg==
X-Gm-Message-State: AOJu0Yyt2D7Q+Z4KxfM9HL+8VLsvUGlDMcBeHQ48+U528xHgm80FGzhv
 J01re0XbwgEniaa2enmREDckW0OY59gsH8xEPr4lpObVfexzWE0EfF9IOeUqEfK69fY=
X-Gm-Gg: AeBDiesfUERJ/+okDIveIlU5p2YUTD9sJqh/7TySp7Wgefxls/MXGeGkRT7XvUS3fUi
 KWcQwpwMeDbVfjrXs40zKV2/FuHGKwC0NKyZ3YeMXFxqF+S/NPrKzoJrtIFokun5//UkflwE+RA
 J+EjFGEKPbCpiNSXPW/5yzMetzSzx3MJF5MKfBM0OGgwIrkhklc9Z6tYRELM4KCgqt8Rbn3qs90
 stTgw19MCpjSlfsiz4/L2GJHmnlUE7BMVMeyXGOKDp6nE1PPcv7YzirIyWp622mT3InuVgbZ3jY
 e+/ZSkbYLr9O+Uiuo+abvcNZ4ttOs9xvNP+tTNMt68azc8PWffrAKhTt3mhpuzsrlNvSp4+UHLS
 csQdKX5gWglfOKBg5Kjr+Iazq5rNQ+yMVrcmg44XcWr4v0b1nw2x6ZIuE0SC9EyeU3ao53uai6E
 u0F9WpsBMDPfboIVygA3hmxZYGczzbe7BkmTwBuQZGwVKGY0dgzBkiT+nNtVW3owk8aaCcL0uPS
 6Zy
X-Received: by 2002:a05:6402:2111:b0:67c:4e1b:9133 with SMTP id
 4fb4d7f45d1cf-67c4e1bdccamr4772311a12.13.1777985888789; 
 Tue, 05 May 2026 05:58:08 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67cd91bb84dsm400040a12.20.2026.05.05.05.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 05:58:07 -0700 (PDT)
Message-ID: <3d1e6e26-330a-4861-aafd-a8f0e0a5ea30@linaro.org>
Date: Tue, 5 May 2026 14:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drivers: ufs: qcom: Initialize and enable clocks
 before hardware access
Content-Language: en-US
To: Neha Malcom Francis <n-francis@ti.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
 <20260427-ufs_clk-v2-6-36e10a7c0ef6@oss.qualcomm.com>
 <177789285970.3146166.17231505865681142244.b4-review@b4>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <177789285970.3146166.17231505865681142244.b4-review@b4>
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



On 04/05/2026 13:07, Neha Malcom Francis wrote:
> On Mon, 27 Apr 2026 14:56:10 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
>> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
>> index dc40ee62daf..ae33f62fbee 100644
>> --- a/drivers/ufs/ufs-qcom.c
>> +++ b/drivers/ufs/ufs-qcom.c
>> @@ -557,10 +547,45 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
>> [ ... skip 20 lines ... ]
>> +
>> +	rate = clk_set_rate(&clk, max_freq);
>> +	if (rate < 0) {
>> +		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
>> +			max_freq, rate);
>> +	}
> 
> Was it intentional to proceed with init despite core clock set_rate failure?

I think for now it's kept because some platform clock drivers don't
properly support this clock since it's often already configured
properly. If it is required then the error still provides a useful
pointer and the driver will fail later on.

> 

-- 
// Casey (she/her)

