Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231C2C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 07:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0C47808A6;
	Tue,  8 Sep 2026 07:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cCnfqeHh2Xl7; Tue,  8 Sep 2026 07:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AA72B80883
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788851731;
	b=RpS0MjgKsd2W8loBTBWlFrPEe4lJYeSBEiTaX170InbTqbVgQGEqJRUUieET0KQCnpau
	 Lkc+nvFOdaljQrJq3M2BIHOrFsAxC17+arYAINKqyROdIxVF010+5mBnyWWrOcPsETu2F
	 ueS/LBP/2KxTfyakv3a8cPZkHoGz7SqBVQsJFGtiFGiZyHvZ0yHpns7qlg7rMTd5ZzZ5s
	 196lZ+G8lgliYCFxqWg3WEQgYmPmMvXfl0VcnQSchKpKuUK4Dy+a7WuZ/7g258I78xrls
	 emQac9ncCTcohqUlASRGErMauYpcxV44jSt1sfTyy5JHZ+MhFDe5pYKG6QJG9Gl9uEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788851731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GiuX9HzVL85aQvgch9M4Rs/ME0EQjcR8ZM0zii3zaLs=;
	b=GzL+6G/8oD+xVrHDSyYmMbdRLtsKW99rQ+U+EFG+QizeywkCZMV74QoNNMxkugp7XRK5
	 Td3vJw79DxwSlU6Hu998lAlkvnvipFaoU3OisO6ZHva3HmlR83x7uN9/STuQ6XtdYcXK5
	 aLcxxO4KqyqvgovDzAD5D78Qvi+YLEyQR9kkgb1JXS37BAzKMrvQXZql9Kp6O7RIUW2YJ
	 YbbAFb5LbCeN1LR+OeDuoJW/fzWG86sfgZ7G5sIwwUeqPhyxWC8vq6Na/CU5E6feOG5Lp
	 eBFJNR8+FRWuLeNESTpC6+8qmm6p5wAI5/DKt/RmMkZ9fasl6Sc//cuoQ3uBKMcFAbg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788851731;
	bh=GiuX9HzVL85aQvgch9M4Rs/ME0EQjcR8ZM0zii3zaLs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=buvnzsyhDwt/TPMxfWOOJZP+JemNIQbJfuarIV/UBVlIBFVCJjPudTGN22vk4dKaR
	 Yoa2kw3MtcI+ArxSgoql0S5aGbUxfrcF/Liiq+/yzeaA9CbAsaf+vgTXcLtmBjtnNE
	 uqWhSQoLf60HdMxEb/3u/kmg3Np1VDCse927f9NxrQfY8j/RTN4gL5Q9Mpd/3ukvLV
	 F/8ioG55pbHoE6vayXDy7AHE9Jn47EsruRurq+R59rXwM9L80wrnoVBrihjgwB1gLb
	 1SIt03O6HC2KmTgIX6p0AFI3YCpFb1nBdluHr1k0iy+cRU4wYSH4c/xiLgwAYaIo0j
	 mxzSBsUfzEHxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA72B80883;
	Tue,  8 Sep 2026 07:15:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4930572C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E397404F5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UCvn7s9oF2Yj for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 07:15:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2362F404C0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788851729;
 b=Bxqnhgzq7roNn+YJEwwBcfWDBLg9D7/Mn+0+dn2R2A50UMjKjy3MsjDm2ijc9casYWoY
 uTkn0iC7piBy84RklwV/lhnxtTNkzWEUvcfhTlcEcdrg1lU2kxPfSPnzlecTJEeV2zFpE
 SubLWDARGQ/uCGvY3mHPlQ09N67LdJGY8fiUioseU3k+EYpbTjeSNGqjGpZJfTFP9I6EA
 WnQyIozUOTJGS60jsQaoqYyrioZ4+sAMDn1q4LVIpCeJiWZm/rCXAdgcgHaheiwA1RVfq
 uLRdjhGVXRirPB8nNUltfd4M26s+agSEPp1t64fdN/kw9Fz/RCbQZ/lRzECCBmFiFug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788851729;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
 bh=GiuX9HzVL85aQvgch9M4Rs/ME0EQjcR8ZM0zii3zaLs=;
 b=r7qGc2n7jX9I9wR93mZUrYECnix+GPKgxReaOXkZDNbIHYMFy36i1w6rJLNI/raHMsx7
 ccP/0BkAXunHRE09KJpqMhLc1nZ8V3R0Ue5sweZe2u1UTuutItO1t5VbxTqHQL7qBJh18
 viDTCgFofaHPlCmaVV6C1DOA6SqRZxuxxraLVC/zPgq4pkXQaBkzwJxp6/+RYnvtS4Hkk
 m+0R+1bvuL9S3XASBVb8iRrCDUc7e+bJ2igX5eYV1DuP9UXIvtDFKIYj4Z4V99cVBigrX
 h01qmH+l2ayf0Tb0ucwixgahvu11XgxiejrJjtAyBg4bDCSm3bjpFDn5E0ISbtY9VYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HwlVmzPd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HwlVmzPd
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2362F404C0
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:15:28 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso40811875e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788851726; x=1789456526;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GiuX9HzVL85aQvgch9M4Rs/ME0EQjcR8ZM0zii3zaLs=;
 b=HwlVmzPd0FO6h+hNRes61jNw6esIjRf2rRPSLEzzjWg5Z5G9yVPbScjr5G4coVP0Jx
 g3xMe/jqOhw0/c8hq0f8SvXMwa/Ic/74zG8ZbnvQ0V0FiAGR/y0nNhj3RHwb1PqwJok0
 ib+N6V09kGhuHeBcocsvsVr1Q3OFjUJv4aGf41W4TlQXpxT+pqQmMk2mDDz6w1cNHUt8
 ZDRYxDAhOT+Qcga8o1+IuTn8BEqLWrwicO31/uVP2BOOG6ZJaHqNDL27iwo02LM3GTx/
 cRotyoc1KeupWEaMsQ4O4rnjaGNt9DkvaF8l3nLWZSs9ju/atCdCLl6RzwdG2mHhFy3s
 ds3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851726; x=1789456526;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GiuX9HzVL85aQvgch9M4Rs/ME0EQjcR8ZM0zii3zaLs=;
 b=inwmG7YM7NCaE9PA7Qgb9cS2YsEuWeQGiZKZtl0GZVv2i4w35r7NiYbTyCZEqaLHaw
 ccD4DlNqKYvnyk2tZnrq/fIB9MufDR6BoT39XdZ0jVLpF1YEl462VpB/6xUX09qop2RL
 VLCsWvvH7pkegq0Xp6kKUU0cgDkubAHE6hgo2Y8c64FllHu1ChGg74r2sAoYRug+9lAU
 xqVY3Brm/J1zfoB3u5LIVLVlgtst0reuK1moEXB3IeGTyCYMbLEhnREXylJPq7OIAfFj
 TfFXTyXFTyi5YgfU/hunqp0emoK9mNhYN0iJEUZjz+qCTkDiWjOmW8jWULI+F74zYPwv
 yOoA==
X-Forwarded-Encrypted: i=1;
 AKwUvByyDW/OQSSq+FlvGuupMI+zA7QsaDqaasvvFYgt5a6J5269WYF8GAYXmvlL5QOkzJmuzw/PSw0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lmeZHUUYAXyT55vgxcfZnRDCP5Zh4+u/Chpp4HjpE85yTMhkJY
 U7mWLKeUQvTUaMv7spCLDHXdly/G/S3WUzEM+bZW+KOvCEA4BYay/XMzuNHZwtoYRBQ=
X-Gm-Gg: AYBFou2Z5fvDitebarItX3aumYUPhZZFTZqT9DaQuiAaZSQnGPDSTMovwYjcVhNNZT0
 kIqKDt2QuuOQa0PRJo0d5VvDO1n/vCWiVLvpAFfyTlNFP8TjigCEW1ZGFzPGyiMWRHp3X05xBWr
 bzQ61Od6EiiexmWRNmmeRSCBGSEnnOO7aAyi+9eZ5IKM1SLmMROoS2iFUlq3AKnxrSqmCBduyjY
 QVM7gVyIZF5Z4vqrXjYe8IlzQ6zggcTJlWUT4gi3CJ+fs5JNQvkFZZXRE3JwSxrvoRdUoOfQIKL
 MCSH+l0oMb2T5tc9sGv3AWwK047DFTXILFnMOsebMBOLvVaL6v7YFiq8PpoYTv2rgfcrN1mw+eN
 Z98C8X966LMHPfkn3XdDMySl7jj81BBb+YkLnpUQSFlQyVYcZoAciAYewN1YsYbeBH4ESlXhdis
 m5iXHWZ3w9zDJ5lyIk2S3ZFQnOfkfW89UJgzCOo+afSc5r1zQ/57cwD3tn59HsuP/mTgKWhuvBk
 zA+3zSrnjwMyxOPAM9NuCqW5wrEGXmcz40+V3hJ6pXUhugXEzrV5OqeNAXoScJn7yM5hX+mxQKT
 M3cw5yXMC/wqWTEKZ64UwjF3y2GUJ0JcVE0ZPRsRxE7t6Tac7uYK/q6lACZ1rV64dROhe5fUxIu
 By0YgKkPamdvMgLSXp8BRAjQdBKFFiGCJOHcpx42HaJHlA35MhRGngIAgiOqS2FmZ5c/j0iA+2U
 44pv4acRrXCgzG17TAGm1WDbSAoEyrU7i/mPT1jd9yDLNhDptGBwk8Cv+KU4yfrMwUcButNHc7H
 xgwwfJkZGLcmj8hc9Ivz69/db8subWDkY24l8OK7FmV5SsFdIatmV6dJu+CJ+ymcy9oRsX3vGnk
 WdM=
X-Received: by 2002:a05:600c:310e:b0:49c:fa21:1c84 with SMTP id
 5b1f17b1804b1-49cfa211ce7mr239492885e9.25.1788851726386; 
 Tue, 08 Sep 2026 00:15:26 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm949278905e9.0.2026.09.08.00.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:15:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 10:15:24 +0300
Message-Id: <DL9R0HDE15M7.1NFT7IXOOHCZ4@linaro.org>
Cc: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>, "Sai Sree Kartheek
 Adivi" <s-adivi@ti.com>, "Alexander Heinisch"
 <alexander.heinisch@siemens.com>, "Tanmay Kathpalia"
 <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH v2 3/5] tee: optee: Do not warn about
 TEE_ERROR_STORAGE_NOT_AVAILABLE
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, "U-Boot Mailing List"
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.17.0
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <13fc430cf440cdbc490bce630031ca49e81e1e13.1787514446.git.jan.kiszka@siemens.com>
In-Reply-To: <13fc430cf440cdbc490bce630031ca49e81e1e13.1787514446.git.jan.kiszka@siemens.com>
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

Hi Jan

On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This is a transitional error that is resolved once an RPMB becomes
> available. Keep it as debug output only.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/tee/optee/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index ed8f2b6ec74..d3b5811afb8 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -106,7 +106,10 @@ static int __enum_services(struct udevice *dev, stru=
ct tee_shm *shm, size_t *shm
>
>  	ret =3D tee_invoke_func(dev, &arg, 1, &param);
>  	if (ret || (arg.ret && arg.ret !=3D TEE_ERROR_SHORT_BUFFER)) {
> -		dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.r=
et);
> +		if (arg.ret !=3D TEE_ERROR_STORAGE_NOT_AVAILABLE)
> +			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.=
ret);
> +		else
> +			dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable stor=
age\n", pta_cmd);

I don't mind changing this and I like the different error messages. Isn't t=
he dgb message useful for
users though? Or it is something that's not expected to happen in productio=
n systems so we can hide
it?

Cheers
/Ilias
>  		return -EINVAL;
>  	}
>

