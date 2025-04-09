Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97416C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 860C68396C;
	Wed,  9 Apr 2025 19:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Agc5mwQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163958395B; Wed,  9 Apr 2025 19:26:49 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8C38394E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso34543835e9.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219606; x=1744824406; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jtl2uNNrqR5kwMry3QMdALpPI/EAMh/ze0nHfaCPNS4=;
 b=Agc5mwQLs7/FT6znk+aerwgaqXijG4sAsboAEHp88I1xBFP6BbOPWzplVQDZrd866z
 uRwxf0MELu6wd2n73BRirxdy4O6ODWpzqetY/n3shWyD8x3mYIieXv/ZgwrBPRT4qKQk
 ZGESOl4eR78GmAcit7S8mQWXASmoKLBXc5FBXtqbx4qWuamQcwYIFgIf0vXKRQiCgc7a
 1qdMa+NNFh5HGqDyJKYKtaZOsf5g9MOZeqisC0us1nLjX2mMYIxz0SEU4Bv/L63MbvGS
 UhsWp+xqzwuTMdytk7A2ZxNpX4tEU+j1diQ6IQKHm8feVTC9kgGoxrDkSqh9Tu73JCw3
 70SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219606; x=1744824406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtl2uNNrqR5kwMry3QMdALpPI/EAMh/ze0nHfaCPNS4=;
 b=L5qEm+YomaaJsiruNVvPQh4SZgMhzu5vBqLp67FcE9S73RIlOvZw5Lbkylul+3B2UJ
 DXlsl3PXl+iWYMxlcjfGfE+uVdHAd3dG5JCCpNZ+CZajy+T++51SzNG9Drolur2uCLwl
 /CelxfHHXQSBkvi5Xnh7t9g89yHw0hNgUnozZsIOP23M4+UT/jHqCuj4E8h+hxr6bJeW
 KR5k6TyvAYI12DB3AQSlZsOXyU4AE02OnDDKS47f+aGQ7nvjgHh1YoCvySHhZxPExc4h
 6FSepnNiMqIvwYBKFQL2SwYorT5GsRr03lAHyPwWt3PqGCfgdbuPFyKdWSRWDFXu2UGB
 LAxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl3YO6GMh5P4Wsn27zbd2P+tBksIIrCQ/aLAnirFktSDLSuHgl5N/qxC8UYda5oeK9Kg5wSLk=@lists.denx.de
X-Gm-Message-State: AOJu0YyYp65uVWDVutB8H3kJPrv9Fd6DYM4c621prfrr/YvRKTtmijso
 wb4hH9PwNRk0gkOV+SmwGzJ/j1aJGqwp0DOvtGMPFX0qmYuOwdCmTqR65xBOUMk=
X-Gm-Gg: ASbGnctSUkxIBLETyiMDdyKsOdMM9QlVmi0HK6AWyxrZ7cLesSnTvV3l0VK6B7vVyU4
 A6H45krLIrRdH8jVk28DF83WpJb6yyz2qKNWxh8wkpuhDLZiLjueSKr/SfNrvDg8ROuhtVHihhK
 hud+IGR+Gv+wouhZcjRYqWTKqVHHcKwHgpASUkvgO/regrpEPicobupq2AGaR91EvaVB0bhpbsG
 pyQv62Wmm68MqbXLyoE4kZFJbyrx6LacKcsm2pYMhEoEtkECgWShPp+27VqkssFRqHfIN0zQSJt
 79tThf+zVz9LkbJlGOf9HyoBFPXWUOrMkZa0McMOxzYx6ZuMwhTDp7qo5ZMV8aoqj//N
X-Google-Smtp-Source: AGHT+IEmJ+t51YuaZEzdKDlZxG1gN0313m1RN+hvuvuvqrnMVRKu45hZiMZcr4kbr1RtDVNzsJh/XA==
X-Received: by 2002:a05:6000:1449:b0:391:1222:b444 with SMTP id
 ffacd0b85a97d-39d88533b19mr3438335f8f.20.1744219606330; 
 Wed, 09 Apr 2025 10:26:46 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d8938a4dasm2173869f8f.48.2025.04.09.10.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 10:26:45 -0700 (PDT)
Message-ID: <099f1eb6-1977-4f04-a283-b6b24d4471e0@linaro.org>
Date: Wed, 9 Apr 2025 19:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] usb: host: ehci-msm: Clean up and fix crashes
To: Stephan Gerhold <stephan.gerhold@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>,
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 4/7/25 11:54, Stephan Gerhold wrote:
> The ehci-msm driver has several subtle issues and stale code. Most of them
> are minor and do not cause issues during normal usage. The last patch is
> the most critical, it fixes a reported crash when stopping/re-configuring
> USB, which has been around for a few months now.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Acked-by: Caleb Connolly <caleb.connolly@linaro.org>

I'd appreciate a T-b from Sam or some other MSM8916 device, but this all 
looks good to me!

Kind regards,> ---
> Stephan Gerhold (6):
>        usb: host: ehci-msm: Fix pointer check
>        usb: host: echi-msm: Drop ulpi definitions
>        usb: host: ehci-msm: Disable clocks after all register accesses
>        usb: host: ehci-msm: Use clk bulk helpers
>        usb: host: ehci-msm: Drop redundant EHCI register writes
>        usb: host: ehci-msm: Register ULPI PHY through NOP wrapper
> 
>   drivers/usb/host/ehci-msm.c | 146 ++++++++++++++++++++------------------------
>   1 file changed, 67 insertions(+), 79 deletions(-)
> ---
> base-commit: 0efe8ea57fc7a1a6fc5f64fb3cf6bc4a1a4fc219
> change-id: 20250121-ehci-msm-fixes-b1ed17a1eaea
> 
> Best regards,
-- 
Caleb (they/them)

