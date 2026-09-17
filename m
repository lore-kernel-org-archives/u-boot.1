Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4273AC982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 10:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1EF14078C;
	Thu, 17 Sep 2026 10:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lN-weZUHLow9; Thu, 17 Sep 2026 10:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3647E4078E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789639633;
	b=AnKS8gt+u6F27XFPSzvHwSnDm9HsWG/ztcdh0QaCGtRlR5UnAyrNxBoWTqxYsN7ReVzF
	 EK4tR4oMJUjOdkrpo8SAPMtsRZ4uKmKyPbjpCGL2r82KwCfVb/dmUI4ao45lRhNfN1XzM
	 gE2f1q0svjQaplrUkn/eZCZVVnlA72E9MiiuMkSrV8/m1ogoTFvxPjrnwqcUO4QT9HJog
	 zndnwriv7U0WTiDWrwQTY+hCOLYgC8SgjyAw+FlM5PkWyqgpPHbBYwE8ba0gJXmifDLUP
	 nvts6ynjiwSnBhKPrcowbNiohoDKUwmegqeoLPaRVXmvtprySP46rfvSd4EEeYTEphQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789639633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i4LsMvtpNzwo1T1j9u3uPGWMCAK+ww/uQMbXm1m3eyk=;
	b=esFAASEAaU8cEfyTjLRgVlKsc2q/VMBdOiAj7TA7wMcyFuRUepFsFCPj4OwHtuQTOEXs
	 bAka9AZrkg67cNlDRyLmNyLMMaNqD6tPYOO9QjBgZuABc383lhinGjUjPX9F6Bnj2tkYX
	 +2f2wgpaOo7eSY/9sIr7NmdBB7Off22CS22vLDaP3SOUHSwEhqnXQApLulYM3WJNlADLk
	 byAqSCqaW6daRcKVN+izwF8I5Z/k/2BmM6XTfTYFp8ml5WTp1MK09t/e+xKDoHCPMih6U
	 SNVN423OUMbTuBv37kBZdqDIxuh2Aia6LB1jvQYIeyvDEmOh0JdKIrEImQw2Qb1e4lA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789639633;
	bh=i4LsMvtpNzwo1T1j9u3uPGWMCAK+ww/uQMbXm1m3eyk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XBHkNSBbTJLzkIxGD7NLwh4+tr7mG+Xqd5JR6H+ALtgPXl2ZhQ9oXWtSGN9Z48ETO
	 Nr4QWY7J+Bk31ZbC3QJagcKq236fAO7JGrPoH3d4n4R58v6fgeSo6omAtMGk853x82
	 uIpb6FS6BlfvxSmJ3sg12pYnS1TJpg8iDs+yyClTq3oDI24lN1XbcpIxysw5vWo823
	 ezJeaQGaabbFZk1BS5c62pMPNzq29Q1huVIongnY6KxbJkSNMtjm0pmw6/6R2M8LoW
	 6KvmsZIqZGitDIZD3GzI6rWZlIwLVTXA/6sBSX9jAEDWlBcrhW7Od3D8MH9Sh/Ql5Y
	 UyvcssZ8/t8Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3647E4078E;
	Thu, 17 Sep 2026 10:07:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F5312EB
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E0A280298
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSFJEdeXtbTQ for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 10:07:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 158E180EC3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789639630;
 b=I0qVYEuUOJK4qYokFXYltM/dggfL08xXzgC6QqzI5wqx3LpFUGmo5oA/G6NWf/T4+3EJ
 RhRtt6eLpQVGjxbQnXCMvNfToIuY7Imi6oz+/Qnn+PBIf9+CRw8isj6yyPYXAQfBXrtOL
 TP9ef3ldFQfOXuw/S//ZodtR1lt9TdZZD9MkzOG/tZLm+zB4zcdmhcMtB4IiYmW6JhHtc
 +P37j/kSo8XhHmV99acjuIQxqUFn2o/gM2jXSYomsFDIJRYa2Vck4hdGSzD9h8GF0u4w1
 t9Mrjd/z+NjNqNk+YPov4z5emIaVoXi1Gl+Yam2mDuKSfKDCN++kbZ4unVfYwXz4RJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789639630;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
 bh=i4LsMvtpNzwo1T1j9u3uPGWMCAK+ww/uQMbXm1m3eyk=;
 b=gfl78XRLx62v6bZ99t90gfoXxO1JaewQRBMDpfIqChdCsgDAPFXYq6FyfPj5t/UCr67c
 sLyDFM+i2Q+27vSf4dzkRAepF9a0azJzW9TqdArbvkuHUDXb/YeRRhngfIzJzPP3CEciI
 r1EnTIF06Z/zB3aX3HbgF42cRTivYch1ikGdwojXeMgPyTQV3SDrr74ucxIQAC1gfsl8w
 fAyrSOa/URto3AUWWgTOB2L5YBprK+Dn+Fo1qllnWPIaPkCi5JhR2TiJfivNzVIxTur5E
 FURNo/lFXRr8SYjERpHwyx/LU3IasWsiqxzgfHA74si79+H+Rl3uzAY00Plt7pgzAuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mEU9WTNo; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mEU9WTNo
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 158E180EC3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:07:09 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6351832so368254f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789639627; x=1790244427;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i4LsMvtpNzwo1T1j9u3uPGWMCAK+ww/uQMbXm1m3eyk=;
 b=mEU9WTNoTKXFkRmdYCPXGNZK4ysbN9hL0YMVpyjkaGyUxVjRC85tY8gPwi34q7nJSS
 ztexRegLteRoKpUHtJdRGnA78L+sdxrRQqy5veIVFMuPkNAtUm7IGFIUAfXU/NN86cwo
 7OyFdnTmjSS2UvRvrEnNZQWdQBqNiQcRj1yMjzZj20k1BJt+EZ6MPRvEbcl+NxZrEh5P
 tvVmXe+XhaGH1FBTPecyxFrW+aichq3MFh2MEdUkws8ME+ttno79SQga0HLQftIVIv0p
 goYvRGew2Hu8UdwyDOx1DHMZVN+oqqiN4SyMewkgeZazkChZmaf67Wwqi0oLgdn9jjoH
 m2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789639627; x=1790244427;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i4LsMvtpNzwo1T1j9u3uPGWMCAK+ww/uQMbXm1m3eyk=;
 b=xvVWTfAmW/8+JupfLXA0U2orZwN6gKrduV+Z2MzD72+4O80qo7Huo4+w4iJ0oSjnlu
 tXjDupaFlMkqB6x9g46pbIQKgHNCobFuganfgmyw+iHbVkDl6GgIZqZv77sdUfqqHKFf
 kGr/7vjgNrKjK6p/bCZFvtqzio+wKmx5ydVEHp4VQuI6psG2og21+QT1xQuwOOEGk6ZH
 LdxaARYohlRk4teEJJlECGKxvmCUDY4Qnlci08DRO3yW2beTy9oukJ2sTqkH4UJ61RbV
 gDs6Tn+UHfI0xCgO9kv3BJh1NygXtPCSDAG25tfBYAsVqv98NZoP4BJNHyQg7zOKeRs9
 a0WA==
X-Forwarded-Encrypted: i=1;
 AKwUvByl6jUgMNenYuxPL7awpCpI8rXyRgVtF/1KmtpRnTs80FSc9SrhyiODsLbuL8TYYroDhcodR5I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mMYkl563p+oTMQD5642TxZ3Z/UVA83AFqyrGt34coPQ+F56wnt
 7Q2Lj7wIajzRChpv15M+xsVJkgnIwmaTVDLcgeX2C3Xx1nNWrLdjzJIcpMj/N7paS9Q=
X-Gm-Gg: AYBFou2qPI7Tw/CoXO0XJJmOUOTlx/tqVckOuHX928lPyNfZPJ2j529SPbwvyBPJVWA
 ZizyWUBc+otUzyY3TEoj8cAYIF/3n92eXvuLidp77SQF4a/GTFXJ6pdtLTMw/U3gDM2Du1m3Qae
 0N1Ebb6Ddbz9CzbGppCOGvBlQrSCkv6W+5U3GOdnwYoSv+ImqlzU0fUMaXS07VjmseYh8vqXUbG
 AZtelpHfx/uRX8Kx0HVZaJa3YRTEFMT/il9BSM0fUC16iXsBH0y2i1cDCEznigKZcFx25X9CovH
 at11ZWtYJHDddfWUNq5Gq4x6fh9/tb/+n7aVU/PAi3mG+K3iNBjCtSDLxNKEA6FMQq3vM9KNwui
 8oTuGFaFtz95SHw9YSILTT5IzdXWYXr9HVGh0vEnsL8VGieJz3abISNJ/hzrkt7cowOkyU0OfUh
 wMvnWIJcCAQkhbQBEBhn5Vl3KBXceG3EbjCHAi+u0kGny+lMvZiW4SwrE/eSJj8KAqbNeEHJbEw
 xk2bfsOGPBNeFgyaWYk+Fbrm9rjKPTHYJU7kJ0pciqlZy4B2LtRVbOn2nHH2HTh8WO/KUPDOPPP
 PiR+ZXF9Dvhvi1kIioO3akliH0wUKx7S8N51XJWa+yKnddys/GRffx87Olwo/9b/ic5F1uYiku8
 ff+BLA530aOI7u/rvCkbDpqmtaRlpWcGCUekGZrhY4kcWO6wUE1paOz1bHObDvHheHcUhumCTxI
 cfUQPTHDkKbSPR8PrGLue/eJGC9wEsxtKTifNjPj8i3vdeqMT0gIFt/I65jKFBzPTS4r41hz08C
 +r77Cct8HLNJvbYJ4R9XV1ugJdxqbo+4YIXbKxvR+MZhyqfQo5OD6BYf1gnTR7dK73ccofT7ey1
 uzs=
X-Received: by 2002:a05:6000:26ca:b0:487:92e:c605 with SMTP id
 ffacd0b85a97d-4870cef7140mr7881359f8f.9.1789639627178; 
 Thu, 17 Sep 2026 03:07:07 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27a41sm13579450f8f.18.2026.09.17.03.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 03:07:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 13:07:05 +0300
Message-Id: <DLHIATZLJMK5.17ZWBC2UHDAI7@linaro.org>
Cc: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>, "Sai Sree Kartheek
 Adivi" <s-adivi@ti.com>, "Alexander Heinisch"
 <alexander.heinisch@siemens.com>, "Tanmay Kathpalia"
 <tanmay.kathpalia@altera.com>, "Peng Fan" <peng.fan@nxp.com>, "Jaehoon
 Chung" <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 6/6] mmc: Make "MMC Device not found" a debug output
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, "U-Boot Mailing List"
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.17.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <cabbf5bb428068d97cbc76c4739dac2392413eca.1789023381.git.jan.kiszka@siemens.com>
In-Reply-To: <cabbf5bb428068d97cbc76c4739dac2392413eca.1789023381.git.jan.kiszka@siemens.com>
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

On Thu Sep 10, 2026 at 9:56 AM EEST, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Callers of find_mmc_device are generally processing and informing about
> errors already, e.g.
>
> =3D> mmc dev 2
> MMC Device 2 not found
> no mmc device at slot 2
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> CC: Peng Fan <peng.fan@nxp.com>
> CC: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/mmc-uclass.c | 2 +-
>  drivers/mmc/mmc_legacy.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 698530088fe..cd930807802 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -319,7 +319,7 @@ struct mmc *find_mmc_device(int dev_num)
>
>  	if (ret) {
>  #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -		printf("MMC Device %d not found\n", dev_num);
> +		debug("MMC Device %d not found\n", dev_num);
>  #endif
>  		return NULL;
>  	}
> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
> index 8f8ba34be71..2a4a8a83fb3 100644
> --- a/drivers/mmc/mmc_legacy.c
> +++ b/drivers/mmc/mmc_legacy.c
> @@ -45,7 +45,7 @@ struct mmc *find_mmc_device(int dev_num)
>  	}
>
>  #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -	printf("MMC Device %d not found\n", dev_num);
> +	debug("MMC Device %d not found\n", dev_num);
>  #endif
>
>  	return NULL;

