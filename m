Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D34C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 13:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539E782CEA;
	Wed, 13 Aug 2025 15:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DMzu6yQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0DBF835EA; Wed, 13 Aug 2025 15:50:26 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ECB0829F5
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 15:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b7892609a5so4168835f8f.1
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755093024; x=1755697824; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VRPyzVuOENxIC3V888uMQHszneShKVSIjEPdwLSa5zM=;
 b=DMzu6yQ7bXvj9TTvevlwAc+EGn+gCmVmKYeQOP/Hfu8kQq/EOETWKaf64BNnnFDuB9
 TrtJKXQZhM1254lGH3yK5tn2qABqlQBupEdmCqXHjcjloJSJRTMxTepatIsYSN6mC2AK
 4V1NgUvALrJJblrBdt9YvqWpbaZEw3YGk/SNTM79CADtEYW7msoLiRHBEnpaIs74elsh
 UfFhXAFTd0QDGe0iDsVftV81EXIlxbDh46ZSSCpbRGo6YTmmuERZAHJ4RWwWnIuEf7cx
 vx82DG617cWnVNI26WdajGtuFMrxynf2/2gYctIHhM7kk3fvDaKmT8nMmS4CNo1u9kLK
 N7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755093024; x=1755697824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VRPyzVuOENxIC3V888uMQHszneShKVSIjEPdwLSa5zM=;
 b=CSm43tALAT9KVIkExk5ImadF0J0UKSuzFwWaAK8r+k0q19KJQxpyHoN2MfbrykMHOP
 /AEJ06nMzJUi/JGrfVwgKdm0RgHGHhwweKDjlc5co1EZBuHNnIKnkQPaOmR/bv0WvI/N
 OAA5WIqDBE5SkHK1/SrpoUX5VXZmQs2ir0UOCvi7y70Y2zaTZigZnMGJPi+NZ4d8MzBH
 Kn0M4FIpPk5+7/mR2T9kTAYxIRPheu0PAQzZS9Bcc1GL5F5jKSdMlHipUDahuFBaGsjv
 NNpdqi0MY0CcS9FPGFI5aCwlBJDgrslwyMRhsJCjCQofLWJ2vnqWo/vUaSk7uU0LLkr+
 oRuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCK7DNw1+0awKbVA6KmcJ41AwQLO3+C+gQkIrFoRCfDIVxVaf95LTXHQvYd5LQByqa0Rz0eV4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf9ihyycGS+R8qoFxaVbMknSBIs+qX6+C+oATGD5LGoPFa42jS
 b4Bc3fIkzECqNWSh9w+6qjWWV0PIDQE6iY7hiF/L+zilTPQXddq3HO89TL3Qa/uxWW4=
X-Gm-Gg: ASbGncvRB9/MO7X0D1IK3ZJJNcqTjRO17vAWVn9LGrkBq1eBqSUXmMjD4ePex8DP/hz
 54GvFWgILXBa3c/Yc4weP9gsko7URP4W0ICidT2RdmEPuup3haSqJ3d8rP1truJojZQt+R0KhmD
 zhuSYGoXXECKpI/bXmJDe/D92qDZCqYLKhY+sOcIvYPwAQBNzWopl5l1YnyjFq2qLuatDYfqxsQ
 ZQdX7ffbn9e+9B309NwDIaR/XAOvriSOMSAEnKC8GcYcYvAZWC8IKcJRzJh9QgPM2vpxDhXZNQE
 U4409F8Sb9LpbP3+aXsehhilLovdnJCkEGd3MWV9zT0r3K/UiO85QHR/gB8WtG77aqRHLB5vm8P
 k6vu5hYLY6jyYq+MSu6wnLTlHwPJmlRuDe/1SsQImJ4uDRnnLeJh5Ol4sS9BPdTE2
X-Google-Smtp-Source: AGHT+IGW/ldkB0mCxe/Kmj9DwTXTvbeigAUZe7ALud5IRgBUuR6dxFDhhDq5O/iFypQ18U/SIA8AnA==
X-Received: by 2002:a05:6000:4014:b0:3b7:96e8:7598 with SMTP id
 ffacd0b85a97d-3b917ea0265mr2274535f8f.27.1755093023736; 
 Wed, 13 Aug 2025 06:50:23 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd6f.dip0.t-ipconnect.de. [79.195.221.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a59019dsm3070445e9.21.2025.08.13.06.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 06:50:22 -0700 (PDT)
Message-ID: <4816e2ef-b690-4f56-acf3-9c8b7a491b5f@linaro.org>
Date: Wed, 13 Aug 2025 15:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qcom_defconfig: Add VID/PID to represent fastboot
 device
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: neil.armstrong@linaro.org, trini@konsulko.com,
 dmitry.baryshkov@oss.qualcomm.com, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250724111911.67872-1-sumit.garg@kernel.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250724111911.67872-1-sumit.garg@kernel.org>
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

Hi Sumit,

On 24/07/2025 13:19, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Currently fastboot mode is enumerated as VID/PID: 0000:0000 which is
> not appropriate. On Qcom platforms, fastboot mode is rather enumerated
> as VID/PID: 18d1:d00d in ABL or from fastboot.efi app. So lets use the
> same VID/PID pair in U-Boot to represent fastboot mode.

Since we have different defconfigs going on for Qualcomm, I think it
makes more sense to set defaults in drivers/usb/gadget/Kconfig like
rockchip does, then we don't need to update all the defconfigs and we
can just override them if desired. Would you mind respinning this? Sorry
this is coming so late...

Kind regards,>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
> 
> Changes in v2:
> - Rebased to tip of master since v1 didn't apply cleanly there.
> 
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index b9ba7a677d9..4e24a43b888 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -140,6 +140,8 @@ CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
>  CONFIG_USB_FUNCTION_MASS_STORAGE=y
>  CONFIG_UFS=y
>  CONFIG_QCOM_UFS=y

-- 
// Casey (she/her)

