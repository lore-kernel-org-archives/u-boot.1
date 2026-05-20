Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADA4CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F7F5847F6;
	Wed, 20 May 2026 15:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PCKU+KpK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF8884862; Wed, 20 May 2026 15:39:14 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4241846BD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so45625675e9.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779284352; x=1779889152; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HDMbr588ncELUtdnYmNvSYoqUA1k0UMaEhkkPzywtoY=;
 b=PCKU+KpK672R80qIcujD/3K9MfgsdVAAzDecpI2ugBtkcyRDFLvCI/cvs+UrAYXdii
 yNTQAJu0XiJjmNqTpO4xQY9Fy8JXliI/76A6wsU9sxQdsAI16C/ILX7+FL+N8VU1Q/pM
 jz+U8K/8cL/eI2ngImVJLRruEBU8xyDrwsmNqCR+I+S2pnOtcf6bbaWoNIydp/UdclbT
 cK6inpefYtbAFmKf0Wow4/WE4BUbo/THS+dTRmeA9lFIGVZmxRtOXmY8DDL2mhwz4O2l
 3nCBhL+5wAMs7dDP9pz6qMHvlPNn2NZv4IT/Zccg9BkIANzjUpjxilGMyw8Ho2O0nfXj
 8d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284352; x=1779889152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HDMbr588ncELUtdnYmNvSYoqUA1k0UMaEhkkPzywtoY=;
 b=QUzTrikoPj2DzTO/aGYEfCQz4pBwMDyWXKPuEDeSoCNEUtQkwhgiYaLSxG9W1nxtKA
 iXzIYNYkMOVhe5sqa0NdC5ocfvBSHmhWyjJfHnT5ZAYKLgOf5YfxkWjfU1fMqCiJmXHn
 gT0hBRoQFfSWVWiSjYVi6B5yd2kkByoSIltDDC8CbXyBxlF/FTsBWbA2keEBr+VXaBOr
 hn0eUryvqDDxtj9148d7D1WFN9ocm+LfMWpNYOh8Eb0nPrvy9PZ+aHdRX1yXeHVNgSnc
 4BZBEn/ROD0Ig9yv4T/kMDngxA33FElum0mCH5aGs9u3yXAgNbcEmRiFFMvLSCCG1Z68
 a7fw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HgPqaPEaCL720+Ikb3uHvs5z+e0f5p/oaC2JC+JSIDiL1N/mYTtlABvmLG5exC5uDRUbeioo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+lXmnTqxgUiWgZmYZaSZRvaYFsviJVbqRJAUUYXrN0BW371Et
 8t28Ka41TkBinzAveVkXkhIGXr6VKocHG0u7Dmj+G17AsR18pPJ110RLKTSQRxtz6SE=
X-Gm-Gg: Acq92OEJ8Ac8bpaq0Ww4bV8UJ4QufcFpgsKXV2EuxUtkSj7JtU8saRNtHRtih0Csyml
 oscHeTna6DeFcBavmeX8z3KiXb1oP1Dyda643Txl+kKoytFBk15ZHor4t+pfS3WNN+1xnoiSbym
 KOGuiOZCDUTCKNo2l87qZ9NkdfEjZNl9+g77kJjpJ+DvogTsZMjGU8vMrVX+rOnMWxUK1qzUyDd
 VeyiMsxuDCKQ51v9G/6Q6f5MzYJiMtZaCYozEksKcwTmE1dP501bxbxgB5TdN4W6xfrWi4TMcT3
 be6wM6aYCrD2KdaRIuvhgG/dkSJL4B2cWDIibIxqSxOl4ABuaU0lYZPhz0kiW2WXFBj/bF/l6h3
 SVLNFadrKVP7FbawvvdwPGLxLx1C2iBgz/EVgx2TFKi8Uez3yS2ztEKOINd4s4rERjBuj1HU4/w
 uqLpnnf+1OXcAREwa2sta6z3viM+czdbyuuKQSFtBMOfi8dRvl+STnFZrCZdc62F40Qg==
X-Received: by 2002:a05:600c:4692:b0:48a:592c:e632 with SMTP id
 5b1f17b1804b1-48fe6325f18mr379346485e9.16.1779284351904; 
 Wed, 20 May 2026 06:39:11 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fead15bf3sm131750795e9.6.2026.05.20.06.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 06:39:11 -0700 (PDT)
Message-ID: <f715b89e-348a-4fe9-98e7-1708c0259b4f@linaro.org>
Date: Wed, 20 May 2026 15:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: pcie_dw_qcom: Staticize and constify driver ops
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, u-boot-qcom@groups.io
References: <20260508122144.512818-1-marek.vasut+renesas@mailbox.org>
 <177928247654.3007879.897450050126184217.b4-ty@b4>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <177928247654.3007879.897450050126184217.b4-ty@b4>
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



On 20/05/2026 15:07, Neil Armstrong wrote:
> Hi,
> 
> On Fri, 08 May 2026 14:21:37 +0200, Marek Vasut wrote:
>> Set the ops structure as static const. The structure is not accessible
>> from outside of this driver and is not going to be modified at runtime.
> 
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-pci-fixes)
> 
> [1/1] pci: pcie_dw_qcom: Staticize and constify driver ops
>       https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/1f4f0f37d7567d4bad86dc42e8b04206d3c8daf9

Hi Neil, sorry I already picked this through the Qualcomm tree, should
have checked with you first.

> 

-- 
// Casey (she/her)

