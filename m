Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB4FF3ED4D
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBED8419C;
	Sat, 11 Apr 2026 15:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D6H3WnQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EAB984181; Sat, 11 Apr 2026 15:09:33 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CC184118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-66fb5f2183fso5266235a12.3
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775912971; cv=none;
 d=google.com; s=arc-20240605;
 b=Jgq91z1+ULMx+SziDe/j36YFwBdckGpG6dtfX+2WpH2YeoZHP6nEePGfoDS/gH3lgy
 CbvBCw4ZBpCkaxLufYPv+oqQXVPP4/cLQpr4F+w0e3oJa9x8THNeXdSFndsQd/86osnw
 ysev4hdPeSanifQOKaBVAvBOWNRM5Ud04zKuCT06aZrEqEWr89pZGd3oua6OT7I2Ko/C
 r3XQNp9CJgkzB9LEP9uh4axjXJ5iO3/ICubnSOAfktWxSthUVPhqBeNpJVb6JAOhtcfw
 WLifhiitwK8Ymz42F5gaR+388aLKmcsdGTWivSiyLXh+Aq8eSFZomABujrTabyzab9N/
 Y0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0tE2BfrHD0kjepkNoJ+tIWlrV+sf7C1wnCseTYFv6VY=;
 fh=9YhgbuI+2af/v+sJNbjaPLRI3sIoBSTkNk8g7pMUaxI=;
 b=SIHtenQ23Gi9rhgaF+htjZshJj6P5Nu1VZtlLjWjW7zThw9zytm4+as+lyeiswoZV+
 Nz67j9lK8plVXG2cUVnFwjTHL4vfsWcEpvCRFse76DijgiV+piegc9yXp2WWLbnQt/Iv
 Nj/Rt2om92k4rs6ouoPLd12fFVBogV+TAWmAtpmr2qa/gKPlVK+C/0nsF893SMgtDZfz
 cD3nYb2GY0Xd0oq6i88vQO1Srzy8PCdNtbt4pqT0ja7Cv5L3QcmW1Q9NiT9yPZLEUKd0
 hOPBh00l1TH6jyzPLeY4mRI17OXaNKVrLccNlb4aCZCmkygudxFsQ678MQEeftEXnxZH
 uq3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775912971; x=1776517771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0tE2BfrHD0kjepkNoJ+tIWlrV+sf7C1wnCseTYFv6VY=;
 b=D6H3WnQAZMsTvUDGVvdS8azrlqJ3XTLjDtdoStfsV1iVYs8zWDYQ1LjKAQgImth3gi
 YoTHgR+HOYWYpa7Pr97NL2J1Ud3RRw2S7WUW8b82huLRFDRC0GRI6Bo5yfskfZJdyIyM
 ETfUsMQ7pMSM3X2tkO8QUI330zgAQh8Mjj1G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775912971; x=1776517771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tE2BfrHD0kjepkNoJ+tIWlrV+sf7C1wnCseTYFv6VY=;
 b=WXc2cZFCpt5/wqyMJKL9AXdsPnWREOWurm/FW2y8olO7ZymFz+PU6fzeWp/nLqLkXg
 MxR+UN3GlnMTFBoB3kCiWkA3tssLVnDRtkIgyHM376z7p+by46ozuPkGti2UUk0j/H/o
 tz4lfqbg/NLprxq6qvvLS1QAWQCh7xKS7g8zGbOA10tH5DdJ+Shc/gVOC658zx9sBOSS
 E9/NCtJAuaAzJb5NXG3T4rJbnVm4inrZVKvY6+SADZwS2NHcRij8gd9NI6aaYd5BQ1lK
 NyoV8w0QDsUoWdT4eGXlBwut7am10J78Hpgo94/dVnnnEzAh6HK6Q05pJJkBbNdpj/Z2
 D7Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjqotG35Za1sMj510e7dcW6gGGODtDJGvhO8BYs2huRXTiskKI1DYYcdd8/+jfNospC1yqYuU=@lists.denx.de
X-Gm-Message-State: AOJu0YyGC6ninGSYU0EKhAvyPICX1j8XazWCP48vT9cg6iAwY3S637QP
 12ql0K/A1mUYH/ODwrdVNSv8rJISISVYkyb73Gn6EBhAFQsApm9a7ElueF3NaAuVAcMloUUMxxn
 3lDxTfPv6ItoDRCvWXNyXQddfcD3EFxvKICc8v0RN
X-Gm-Gg: AeBDiev2V1ki9q4A5fk5C6gjDH1nALhmphl4NgEebnoHggm2hzH0VzzI7Gs9afVp+5+
 lj9NaNHmvBVZGeuczIIx37cDx02Pf5lV1yJdpdR3doV7n867Mux27W7HQ3lAuk1/Xh0iuo5XcDe
 jxCMyJZCVUVhpPhsUC1vMCvknFRUrriLuB4S7u0bZZoVcVcRKUkICIAin6f1iORAbrSQ+BuFCh6
 gA5ncDkjlCoTu2h+oOJqpQxKLoB8JzVe0r8PPY5u7I+KGJV1AMczyO1Lxob6koM1YPIgy7ib9U0
 Ame0lA==
X-Received: by 2002:a17:907:a807:b0:b9d:6cec:23b9 with SMTP id
 a640c23a62f3a-b9d729c06ecmr393568366b.41.1775912970950; Sat, 11 Apr 2026
 06:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-7-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260410091154.1001021-7-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:09:18 -0600
X-Gm-Features: AQROBzDYMCnZaBpNCE-3XDu0yzt3axJBlocjVsAsWRwiGCWiaoNfJz3zmtCZS3g
Message-ID: <CAFLszTgRffhOYcVdBTN2ME24wO8mMAvB8eKD_c8JykeSWR2hMw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] spl: Include SMEM driver in SPL
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:25:15 +0200
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

On 2026-04-10T09:11:45, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> spl: Include SMEM driver in SPL
>
> Add SPL_SMEM config to enable/disable SMEM driver in SPL.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> common/spl/Kconfig | 8 ++++++++
>  drivers/Makefile   | 1 +
>  2 files changed, 9 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
