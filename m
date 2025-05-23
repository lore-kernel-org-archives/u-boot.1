Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3F4C3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 09:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F36468310F;
	Fri, 23 May 2025 11:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nCE4wtj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13BD831C3; Fri, 23 May 2025 11:46:10 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A17A2830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-44b1ff82597so9072775e9.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 02:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747993568; x=1748598368; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=teC5tTMK82CofkrRzx5DnfavRclTncErwK6RSN4Ol6I=;
 b=nCE4wtj5H6b0I0bj5AjUcaOxlZE7HAYgMZu7kS5qyWF+PCLW0BVIsdV/ZVjOK9iTRM
 /y9GCQkannZpw9PjEk+zwCl3oNweZPodv6TRoVtw7gM42qYczo3BHCozZjXFFxVjmDsr
 gIrQupSGu4SKHCpRmwyBlabl4qzzdbB3eUpi65nEAgYeIzb+G04aAl/vCPsImMFnafhO
 qu1ek7yiZbTXyf95Ng0xWt3zaLkZzUN0vpNpcPtBBaetg/0nAfXDatx+ObnR7siA7spy
 rWM+2Ds/DZ3314ZK1ap9ct2D7SqY6YPXHdodK0WlZ/LKbBPBvcPydR8Tv6Z80R9TS7ow
 /4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747993568; x=1748598368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=teC5tTMK82CofkrRzx5DnfavRclTncErwK6RSN4Ol6I=;
 b=wPeBRWVhxs9+0s8IJ2kPBVI63v3ZkJ42F1Pwu24HRnr4YsNZxYhQRTRgp+xzvXGFUz
 ROA/3LliQFQrnoN2cwg4b3puQtOykigrFRNkbP9WCbm0KuAHXenLeKpKJThizfCjiXgC
 Vet7S2yfYMjOcID18fP8m7UNQo0BI62Au8iVekJNfb4E2xplsoI2WQl9LL8YyBqWkLmJ
 Trwq2S8FK3siC+BiJKemXHKFXp21MTwYiqNed30NTTslRxcbF+w12CDqoMEFCJZN6g2v
 cirLB+nK2gVxZBXIUWlDDYjrM7q0uK5DvtGaN5vEvPq+0czMAFQIgNRadqkgshx0u6C4
 A8bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM79JR1fK5iUxY95y+WdCf48QgLhdTtsIr2MH0iOyhJPrbWgCHpMS7ScIgcm5JcXTU0NLc2XI=@lists.denx.de
X-Gm-Message-State: AOJu0YxsvstupY2cgCIIdPPIcralactyZkjFwEw4/qCHY/uJRAgy8Wml
 MsSRVLPT9tfM2ow6+v35HRcx04bJKiBj7Dh8Faynk+9UdHE0/mbxSkZycR99mShSDrI=
X-Gm-Gg: ASbGncsU7tNmBfIQajYjAuh39GYwFA3C26ikf7NJIBiA4xqq3yPiynWeja6VgQTtCXg
 vuPS/mwumyVDYTggYNj576IEAuURfqB61Jux8A7ao1gtyb+mYics0RGe1yNxGiy8NEu18P2eCpi
 HWIorMtsdiZsqp0b5JuQw6Q0r4nZBEgCfFuVWwLWRcmBr6cw0nnFLNRiYRc3wmUR5KCWeJzQv1o
 NAfB5M8/1j/PbEvKOllarsXSbIe226LGVifTmrEpRBAtxnHyOrLXBHjsZ0CUnwDA2fcMfkQ58BU
 T474jJdF4pAuVyKjQhBzA7KY4APFmfrO+h9JlyQ5XkPKlUqDMggUd/ZHiJ+yt+LR8mJpt9/7mdT
 eedX0p55VemhLU2FZ7Tfk+ed3p8wS87Q=
X-Google-Smtp-Source: AGHT+IEzYrAvCYe9EOw17IWuRHxORfMXy6fsCLkOthwyjFg+XWgjqXfy6x2avfhkt2WVMM7mvGy6Pw==
X-Received: by 2002:a05:600c:1e03:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-44b6d6b69b2mr17824135e9.19.1747993567889; 
 Fri, 23 May 2025 02:46:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ddf4:2a94:8e10:88ff?
 ([2a01:e0a:3cb:7bb0:ddf4:2a94:8e10:88ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1ef0aadsm133502095e9.12.2025.05.23.02.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 02:46:07 -0700 (PDT)
Message-ID: <d6e1c95d-c571-46e4-aa2b-3d2a2c93bb1c@linaro.org>
Date: Fri, 23 May 2025 11:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] lib/uuid.c: restore support of system partition
 type for ESP
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, ilias.apalodimas@linaro.org,
 patrice.chotard@foss.st.com, Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250523091140.149298-1-patrick.delaunay@foss.st.com>
 <20250523111100.v2.1.Ie741b1ca358414a1d718dca0667ac44eefc9227b@changeid>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250523111100.v2.1.Ie741b1ca358414a1d718dca0667ac44eefc9227b@changeid>
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

Hi Patrick,

On 5/23/25 11:11, Patrick Delaunay wrote:
> Add support of optional shortname for parameter 'type' of gpt
> command (limited by UUID_STR_LEN) and a separate 'description'
> for UID format "%pUs" used in 'part list' output.
> 
> When 'description' is absent in list_guid[], the optional
> shortname is used as fallback.
> 
> Many partition types for EFI have no shortcut yet, but only
> description as they are only used to display information.
> 
> This patch also restores the "system" as short name for EFI
> System Partition (ESP).
> 
> Fixes: d54e1004b8b1 ("lib/uuid.c: use unique name for PARTITION_SYSTEM_GUID")
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
> Changes in v2:
> - change 'string' to 'type' in struct for list_guid[]
> - clarify the usage of struct field 'type' and 'description' in
>   comment and in commit message
> - use 'type' for EFI_XXX description as these string have
>   no space and size is lower than 36 characters.
> - update after V1 review
> 
>  lib/uuid.c | 158 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 85 insertions(+), 73 deletions(-)

Thanks for cleaning this up. This new uuid/type/description combo makes a lot
of sense.

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

-- 
Jerome
