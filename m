Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD2CC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 10:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD3F8144A;
	Fri, 28 Mar 2025 11:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bomS3P+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9033281E6C; Fri, 28 Mar 2025 11:44:49 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8728B805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so13645485e9.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 03:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743158687; x=1743763487; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i/K3szfFKlFqlfokoWETNcqSkfzJa3BsAEuiUJcASys=;
 b=bomS3P+jusy0tPlT3hYsJr6+JBOPbHlI7KrTP4ooklvPi0HEWZWy+Ogiw/jm1qr3tP
 cO4GhfMWQKG6PmJZfKkjtN26E9OFTC2ceIWJ9Jftb3NUATlMtyVZS7j7mRs28QDCuFM+
 pj2RFfYvt3PIWq6wbjD6CqOoVBzZAKJMYPGpAgkowaBdCzqqbKYnk44auXU9aTUPRVdo
 Dvhre07oG1jtKe2BLxW0KxNVv4slsZXNPoQUEILcBCUw7/kfsaE47XdfWF8hRNnjTXBq
 SF36GuVgXp6S6BtoWmRPxi2J9rw1pNZBLSaS2fJF5ezf/UlCIc4lJoy3tRWr7Arhloe+
 A34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743158687; x=1743763487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i/K3szfFKlFqlfokoWETNcqSkfzJa3BsAEuiUJcASys=;
 b=O9SGWYSxE17Z+tC2TTPmuXSE/U1sOboyFDwWLAQfCGCEKdonZprw+/vq/kdcLN+TDp
 Z0tMyXDPWPHz47VLQSR842btDHRDrbBNfRLWXUI9b3DM7ETZf84meBVAxWmdNDTvKSAu
 Nm+Vg1YqpGtQwkLA+Da48s2pwtw55jA+J419kloL9/fDE64PxtSF0C0GYnInGgC6PhJb
 tw1Noz8KQJ+d3OKlOi/fPtPnLaSKI9E6ASfqRWLJSeaq/w7OarvNslPQ8+nhFm1jQZ3v
 2y8sc43Ue1dz191A4r99RpSAwBE4Zq2uVsV0YkmxUn/n9PKfSYcmxZdStHH0aFVUZeL+
 6WJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAcdNnE+/LGjKxWDgUu0K2USUy7RZY5jkpTikw7ZTBPZGVeq3rPxNxSxBPK9H82rzqu+f6A7E=@lists.denx.de
X-Gm-Message-State: AOJu0YwFCqDSHgySIGLtx4yoUMK9RFePJ+CFSrLrwFuJpRGbMXD6SQIu
 t6LUHlGj7t30+Hy+W+1uIHCssjPT1MwLoLKsEgSU8mkwxJxWrazuvArClIT8W7M=
X-Gm-Gg: ASbGnctQgvre9ZOtdsJ20s9MHrM9uloH1lTBoTBTzGa4y/Amv62U9yHBgV8z7qq4J08
 qElAYHyvDbCJgySLMbTuXs6uwr0og+sS9R9gWxkWzWxrT5UAXY4m7yYHylxPEmeIArm8/W57tmP
 5EGlVQMWMh9eN8bw2OhX1i5CeltgU1tyrDX4+I4SfqvBe+xc5TKhV5Du22NzSoQLjoB1EZav2Z5
 IENwJOBntFDGCmnWB5UnPyEJmorITznyvgJJEuilZ2BepvhPzlX6Ak4NMBaty9TkuOZTVVN/+L2
 rv/ec02asgz52nwJUfkczbz+ghgywUtAOaDyRsdQhnuoZgkmY1mEJQMsqfV0bHfQydX+NtyI9b0
 =
X-Google-Smtp-Source: AGHT+IFtNWMXdrdNYB7gihx20LLQ8Bz798THzyeTcpqGTEyJo97kJyZzhPfA0waj9+ld66RQ1YF35A==
X-Received: by 2002:a05:600c:2319:b0:43d:300f:fa51 with SMTP id
 5b1f17b1804b1-43d8582e032mr48145285e9.9.1743158686831; 
 Fri, 28 Mar 2025 03:44:46 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e834a5sm68576095e9.13.2025.03.28.03.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 03:44:46 -0700 (PDT)
Message-ID: <714a1d3d-7578-4fed-bc8a-c93eff3809c6@linaro.org>
Date: Fri, 28 Mar 2025 11:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Ravi Minnikanti <rminnikanti@marvell.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250327231318.2713201-1-raymond.mao@linaro.org>
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

Hi Raymond,

On 3/28/25 00:13, Raymond Mao wrote:
> When a bloblist is valid and contains fdt, it explicitly means
> a previous boot stage is passing transfer list compliant with
> Firmware Handoff specification, thus the fdt from bloblist should
> not be overridden with the ones from board or env variables.
> 
> Fixes: 70fe23859437 ("fdt: Allow the devicetree to come from a bloblist")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   lib/fdtdec.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index f09c9926a7a..c38738b48c7 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1708,7 +1708,7 @@ int fdtdec_setup(void)
>   				gd->fdt_src = FDTSRC_BLOBLIST;
>   				log_debug("Devicetree is in bloblist at %p\n",
>   					  gd->fdt_blob);
> -				ret = 0;
> +				goto setup_fdt;
>   			} else {
>   				log_debug("No FDT found in bloblist\n");
>   				ret = -ENOENT;
> @@ -1752,6 +1752,7 @@ int fdtdec_setup(void)
>   		}
>   	}
>   
> +setup_fdt:
>   	if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
>   		setup_multi_dtb_fit();
>   

-- 
Caleb (they/them)

