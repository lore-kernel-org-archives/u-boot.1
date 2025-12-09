Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15408D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 15:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B8983C61;
	Tue,  9 Dec 2025 16:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SvDLO38z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA7B683CCF; Tue,  9 Dec 2025 16:03:34 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB7F83C72
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b727f452fffso931056866b.1
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 07:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765292607; x=1765897407; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hdtWJQ/TpbRIpjcf1yhtPHiPWMF9f3+tHicH9UHDLBs=;
 b=SvDLO38zBcPwDszXbbw/6ceimXVka9gFKFRzInvgalx2t9H8cb604x46CuvmzH92Hh
 OjZVCu6/frBD9EcJrlOjm9I3d8mlvgxFiNin6ihbnSBddXRBiYzQ0PWrTJGXorji/Agf
 HwSxHf0xaHVkG3Kz0IzglLDD8IcOYxDCy25GDLylYhnP29dgFrGojKUF1mmeTEP4MKUP
 Rfx0CZBnnUd2eUvRRenqv3SOzNEXrvl8duLf9FLDFPPhRGUDVtqSIAR5Una4ZSrVFBxs
 6W2YtmTPRRTw2H/7a5VCNJH4kUl+ceFHtI4w7Ie24fBtDmFpeQhg4Cz7kMNAFgFzv4Ow
 Yrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765292607; x=1765897407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdtWJQ/TpbRIpjcf1yhtPHiPWMF9f3+tHicH9UHDLBs=;
 b=IltCEdU0rVk3ZKkWBbeITeCOFlf8Fs6yhDA2EVQmlNwvV8JMzkdA8uVLuKl4SJAT2J
 8MnVbqA+VInukA6MEp9qzOEOBgHivITeNxApvGAL5mZ2zzt3bNvmJ6eHOQzBaP8OtY5/
 GiL1Xq3zDdSMTgm3jGxArbNsc7CGHkkw4AtRkY/eqVyljFdhov/eYI3BubTjNyYvVpZR
 ljCq1+usJ9yHrhvNkoHqdao015ymasZU81zST+bnkm2gIgUUZ+ag6kT2XI7aqOAkHuzj
 0xmoYjuD3mjdze5eC8OmSvudgE77n9cqJgJssVZcOrmcXvUYpZtxQTmzqEVu40xX9qc0
 N12g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl9VXkoXbxjtchrqGvYgpwsg9yar0AErxQe2eBXS3suPsD5+ONWF+qiQKkEHxX+xXP1Fcd20s=@lists.denx.de
X-Gm-Message-State: AOJu0YzuuhjUWmXH5tP/ZWBsPmlUPN1mQhC3ewsKMbqS6wyQXf+12rkH
 dUBT3T5wm8BXI4Uc0oZzlGaBaYMUYIpjGEd6wcS4UdyuVsATmE3tK9qKT/FXlaflNIgd4obaGt/
 tApzLofQ=
X-Gm-Gg: ASbGncsZogP2jlHZCGPqH+8cyE72Rcg8UeKeKXFkTH8M8tkSfXzQ9u7gJtsW70xre8w
 JGeDpqvOoV7sP+drX3g/kE5lZ2Ml84T0Jm/jJ34or4U16Drfocv4xest/p0ClPa9IuWnhHRZooM
 Zm6q3JaIESqTI0UbFmcQYmubTmRDFNXLO46F/taPrT0+recxDUJqaEfYSuZea+QW1PIdcrqT39e
 /OAyu/DtZYQV7mFfxDGuVFVLkGqYM/Yf3CnJmnOSAblA+3TvkwDYTzMWvk5fP+whVBYjrFczS+y
 2VvzUNjJU1WtLzA2GTV/nlODm49hWA3AhT+TOc32Gm4N4TU5H52xYxSiAEh8ng41dCx4Rv5pU57
 GewW+BJ77FnQhhKOWbwuJKSMEnkQ8Hiwe3vcw0WaKtUzg6XjC4XaRFm+MhK+UNxNLR5+EjLoO0F
 y1a/+p17qv5nVG2+ALJWPO3w==
X-Google-Smtp-Source: AGHT+IHyG5sWoSQp2xkFk5lHbt/fKzuHJL1gg+Bcx2PVGZpPvyslItbRNa5Rl00bmA69f5xDAmyYXA==
X-Received: by 2002:a17:907:7e82:b0:b70:4f7d:24f8 with SMTP id
 a640c23a62f3a-b7a6eab5f2fmr219133266b.22.1765292606890; 
 Tue, 09 Dec 2025 07:03:26 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4976732sm1417015566b.43.2025.12.09.07.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 07:03:26 -0800 (PST)
Message-ID: <00bdce63-53f7-4c53-bc6d-b137d177e64b@linaro.org>
Date: Tue, 9 Dec 2025 16:03:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: Port NFS to LWIP
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
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

Hi Andrew,

On 12/8/25 13:52, Andrew Goodbody wrote:
> This series ports the existing NFS code so that it can be used with both
> the legacy network code and also with LWIP.
> Firstly some legacy network code, mostly variables, is moved into common
> files so that it is accessible to LWIP.
> Secondly the NFS code is refactored so that the parts that are not
> specific to the network code can be shared with both network
> implementations.
> Finally the LWIP specific parts needed to interface the NFS shared code
> to that network stack are added and enabled.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Andrew Goodbody (5):
>       net: move net_state to net-common
>       net: Move some variables to net-common files
>       net: nfs: Add licence header
>       net: nfs: Move most NFS code to common files
>       net: lwip: nfs: Port the NFS code to work with LWIP

Could you please add a patch to enable NFS in qemu_arm64_lwip_defconfig?

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index e8f976efaf7..a974970c3d3 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -5,6 +5,7 @@ CONFIG_ARCH_QEMU=y

 CONFIG_NET_LWIP=y
 CONFIG_CMD_DNS=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y

Thanks,
-- 
Jerome
