Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC763C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 07:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B4EE605F5;
	Tue,  8 Sep 2026 07:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JVMmnYpHju9n; Tue,  8 Sep 2026 07:12:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8BB7360609
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788851547;
	b=WnMwvnkRXFfptb1qT36Vnh3f5uFu8wP+Qwf/laGDrz+RQiE0VaAqvjtRmxa8l3b0p6KH
	 ImMEY0PB/05rawY//ckG+pq4MGSgObZj50+DfEpJoCegrfSB+0mwogyo1PKSE7UC4uLch
	 BUwQzjgKfx+dFdZsJg56euBEsANm3zaHzs31qVibTVa/2Q64efFZAMs4ZHScmuiTATYWa
	 2wDjhLxRgTPghm+VkafFxEvhhEcZNhiVpBFTaOnQqB4tp9zhClC7/UoeQEUkAne1JOlwm
	 MS4Ss29Lwv6NUMqPbKiGB7o3nlblztaVV4cowXirlKZlCyz3fvNZpdozcwdotT7iTOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788851547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PIoZ9ygwM8OP+WVMuLH4flnh9Zwn4WLqXDpnIxEN+4M=;
	b=qZAIlOP5py/aWu6ZKuU/3TpvUMd6+p6lLZgqcuca5QWuBDTebn/+S5/TA2lJhsLc3szn
	 OVBTDuubbZVhkKFSOP7uWJ5dk42M/tIa92LBlfQV3ytwCGX5dTryXRFuhi/jQbW36zJXy
	 L7QpCEAv9N7EIt183/hb8Om1M7THtiWn0Te1AQ/boz5MvkDTtg5NbO3jOsVeK3ZxXGMtP
	 hj+bAuf0uAbW8aY+oVirf6RXsxerOmivyS3CfZrGerWteoBCfyZGxNo21Kd2EW4x/q6fC
	 0h4t8KYI552ik4MZ5ebsiFIhsAm7Hfo2+Vy9ya5nI9Nc6yIFlV9EePxVQnHHH9TnTQQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788851547;
	bh=PIoZ9ygwM8OP+WVMuLH4flnh9Zwn4WLqXDpnIxEN+4M=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yit3jxNWVVw5Bled/f67gwIFG/hDUVAApq/pfCYorwhYWROEa99OijhQIW6O9ksWn
	 6OCcK6l3Yg2Neq4RpKNToML/QFpKr7Fvf5aVYZzHMdCNFUOb0F+d7PUkxbUgQpr/HD
	 asWvCUlvxMc99MNtjs7FzxWZ+/SwFyWD7lS/8+ePFKEbzc0FJiDHSuEgVNxmrSZ55i
	 aUmonxeLO9Dy6n8DB5fSx7NdtjSHl02RmwKxTyiB8uG3corVxq3JVmb6WX4pGsbJFH
	 20F5jKbV/XqnT9w4nDpzb+G3NJ/O54wt8pYmaxpiKblJ6AWCEoEow0/AIidCH6sGIy
	 H6gtzFq8rzoCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BB7360609;
	Tue,  8 Sep 2026 07:12:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 655D3230
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56A0A80893
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a5VjOx1Qspka for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 07:12:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1AE7C80892
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788851545;
 b=KshUmPCp7TeNPv3lSMzbCSGxhxbFa6bL9IqorTKnZP96jozbkdZQxGv/KoV9T4Ij54ZM
 m47OFEaMnNf67uAvUrZlubXcfxrIkgC5gYHEO2H3gHj3NVJUiuahqKTA/bRrpGQDin36N
 zqnlRiayFsqGbcDDKC/FCuAjNgTGjkwDIBYiMEHhtM6iv94eeORZ9d8v18csPcYVmJvd/
 34GJ3xbtUHQKoDSDNm0ketyGCnuvKS8XJgKxu3APYUZhc+3qzkJan04Onq882h/JoqrIZ
 J1vM4yG0680dxXEKQbsPoJiL/o5MI5OXKPihOu2eU0QdZMxYkJK1w5m3CvKZ7YZbY5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788851545;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
 bh=PIoZ9ygwM8OP+WVMuLH4flnh9Zwn4WLqXDpnIxEN+4M=;
 b=bFyu8ZR/993aFfHb0JzKpOgEjJWRCVp5eUE4jSNasNAQum6drPAmdrGZqqDWSoRAzeID
 Hui2lvebJb1X90ekcHoPmQlrj8AWAhQSeFliFfxoLX7JeBk/ppBOKQ18HWiRh+CtJn9zj
 kdzFGPQqn1rckhemhxnLV1/ZwFO2xDkT9WEdmnr+Gxff8MdXSaWoY+a8YNagQ/Dzztc7o
 2W2nOFsniti8aD/azSGbZS2yVwkFwhh+86XC8/PGm8qMFfgstjz3KD9OKx9CnJDuXKMOR
 Z9UQXDnajUgveDKSOQ12O3ER36OrJqU8SFienxdrRta3LwhTCMFkPM/cGV3kgX8R/Wg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=t2kmeOcO; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=t2kmeOcO
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1AE7C80892
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:12:24 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so34697715e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788851542; x=1789456342;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PIoZ9ygwM8OP+WVMuLH4flnh9Zwn4WLqXDpnIxEN+4M=;
 b=t2kmeOcO1G1RNLJVfxOPygaQ5L93deO04mDoEw5388pSfUiyDS/5b4UCV1lW9HD5uo
 DMurGV+cosKmzH1yFJx6sh4m5ipnk1gwMy+PH9vA+ytxxbPIOwGr/yhw9ZyopoVZCSL3
 qbQAdAcWVWFHUt1Fyu4tM4L0muNJzDivDmVOTDiZtLolTf3Un5Kay+y8zBWywg51fo8H
 YPLUKrZIdq7cpMP1bLg1M7cUeuUhDPurxWzbIvrpkSjp+N/f7mYUn35N7tzsu17ocEna
 3TawpbuzGBx1JNJhZxq8I9pkd2Dq2GE+cgAT6Y/rHSWNLgNymhgg4DBT+8sQkclmO9pt
 6ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851542; x=1789456342;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PIoZ9ygwM8OP+WVMuLH4flnh9Zwn4WLqXDpnIxEN+4M=;
 b=lGLtqDNj/MBAMYx581F09pNY/KNopNHrveP/9toyfj0Rt+vQQcxqk7CmH+sWjLhSyZ
 MXsTKPKKAIYeunENByMRsgWaNx+bWB3G+HPiL5Md1OhFIwzpOqoIZ7o1SWFF3SVtcJPC
 CBHqJixLxQTTIJmMrsI0BUVOygx7ZcUATSk39pKHIDmmA3PpqxqvC/+LCUTz4ZuBjkBC
 HEkni5CNvp80eEKiVecO0bgjgbMxsAWmkcVXsfFhfejYNqfAciqMsbqUqGLQJ+Gd/0gN
 u7mfbZLKRwiHjVzlXRsKiocASTXKR+cMMIO9yKM9bBheQovbBuirfRaY8Lsjf7+0xx3F
 ovLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyMbfkGRVpoEUIKmHhRsWPyc9Yexx+/CaGo+JOZmw4qVsQriaTfo2JOOFWnQcAFkt4phH3ky8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++myGFw4YgZxPSMgmTaS5Mkjrjl7DgJcVYKvMw1qWtnQwc8l8eyL
 RDGjHpCP9Mb3dPrsvR63/SdGugD7K3pASjtoLa59YMjPXY8DQxGC4OS+lplzp22gztU=
X-Gm-Gg: AYBFou0X1P0vVeTSnDWhifREh/MLxo6PvWfuTaq4DSG/GoOXJTfTt5rnchh8IvqFjo/
 DGEKf0oEhlpiwk3TfMIxKt0qXubuofPMBRHmqs/Jnvp4zIKcLk+U+Q4KdVzW93TdOuGRimv/yyS
 A7CHEEb/a41CckNPSsTqNfiUTIRLKnYvatBcI2kVDMK3QzfghRW6ocLGO9HuFHs+IJlG1EHcUyk
 D00bFp6C/H+Y9TRDLScD5fXxpDHOdE8QUw8JbnUiKhTf67Twd2/4+dC538ahVpPi+xBeRIdjee/
 ssLzdkZL197N/2Bw/zHQl2YKeLIX/N/Q08muc8Y743hLq6SwvglegEK2jyZLcGjeWFeOqkQB6Cu
 dRf9R3gVTSBNZxQS7DZvz1lwrKHNRSB9FvzM0fAoOUn4VsBqwHwt8HKrSsLMZGGneotpTAfMxo+
 nUmvkuH73w8D6my11GA1ROqPdoksRmOLuxh51Rpa30xQhtWoYZgvYa9PK425/HNiP9vPmb3KlIH
 GbkDpJBSuYJAmL3HGi36NdjrlMuTuNWgA/rC//tT2jvRNAepPYCEcmy7t241Z7YP9BNKpjTFm4f
 SOfMQbT6DiywNOzYTMjs3bH9F2OH60WoyrXtxCDkOtGSPcmkBMLxotzX9mAhJCCGvvH4SLVg1x9
 hm43vJIT75c1bitYRd7zpq0UES3ujeJLIK+2Ug0tZFrST9Bf64bbOoodtLaaHDhFK3MwZo0eru7
 PYK5FXvDLMCOvmrrIk1ICw0roRWzrCeQPiNFDoCg+dOBzYqEBgjUk+FHZypK4ku+78IyGmRu0OI
 f6s+Wd2hZs6VQaU528xbqr4c4Dhfcx+Nt50bW/TYr0R0IzmedsuGac+zVjdkWe4+/cE
X-Received: by 2002:a05:600d:8649:10b0:49c:fa20:cc0a with SMTP id
 5b1f17b1804b1-49cfa20cd58mr179281365e9.33.1788851542312; 
 Tue, 08 Sep 2026 00:12:22 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5952560sm416691455e9.3.2026.09.08.00.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:12:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 10:12:20 +0300
Message-Id: <DL9QY4SX994G.I90T7GPS8GRG@linaro.org>
Cc: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>, "Sai Sree Kartheek
 Adivi" <s-adivi@ti.com>, "Alexander Heinisch"
 <alexander.heinisch@siemens.com>, "Tanmay Kathpalia"
 <tanmay.kathpalia@altera.com>, "Peng Fan" <peng.fan@nxp.com>, "Jaehoon
 Chung" <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 5/5] mmc: Make "MMC Device not found" a debug output
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, "U-Boot Mailing List"
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.17.0
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <57a99d87a25d42f68f26697b81fafefcae29abad.1787514446.git.jan.kiszka@siemens.com>
In-Reply-To: <57a99d87a25d42f68f26697b81fafefcae29abad.1787514446.git.jan.kiszka@siemens.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>

[...]

> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 698530088fe..ec16899f92e 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -319,7 +319,7 @@ struct mmc *find_mmc_device(int dev_num)
>
>  	if (ret) {
>  #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -		printf("MMC Device %d not found\n", dev_num);
> +		dev_dbg(dev, "MMC Device %d not found\n", dev_num);

'dev' might be unitiazed here on failures

>  #endif
>  		return NULL;
>  	}
> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
> index 8f8ba34be71..573521842f6 100644
> --- a/drivers/mmc/mmc_legacy.c
> +++ b/drivers/mmc/mmc_legacy.c
> @@ -45,7 +45,7 @@ struct mmc *find_mmc_device(int dev_num)
>  	}
>
>  #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -	printf("MMC Device %d not found\n", dev_num);
> +	dev_dbg(dev, "MMC Device %d not found\n", dev_num);
>  #endif
>
>  	return NULL;

Cheers
/Ilias
