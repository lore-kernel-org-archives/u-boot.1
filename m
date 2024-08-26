Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF56C5472D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 17:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED4C87DEA;
	Mon, 26 Aug 2024 19:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zs2nLmuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6C688481; Mon, 26 Aug 2024 19:27:19 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DE987B84
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 19:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428f5c0833bso29773475e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724693237; x=1725298037; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFjjK2n9CMwLkhDpWgjmwtKiqLSZZbNFpa8s3GHrdDA=;
 b=zs2nLmuqTNwveGVWRoKeveM/Tv0L+uLROduT3z73EeGnIFFreai0MY9gypUH7Jyw3V
 sIuaDttzkRQDRvEOlbJk1wRU+wKjrZJM/6pWODqAoLvSFlCFo/67jjfXP/WiTj64q0UT
 McSzipuTJOqsWAVc4jJb4T4M0rf0ijzDs+l222Wrfx7u/HCQkfhbICnWcbWAdxT5rzhk
 y0lh3ihwHVfoNhjjBMD5wNFVDYAZGcodcVmV0vRDiOG4PKZezbgsxduM6bslbQMHmIJK
 S4QGSKBMNPA9Bf9Lvd9KnWeZ189caXFZp/5LpOe3gZcEZUP7SJwIlpO3SIUWQ0LY2Kwc
 XGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724693237; x=1725298037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFjjK2n9CMwLkhDpWgjmwtKiqLSZZbNFpa8s3GHrdDA=;
 b=GTDmCbB8OLRC6oAPXI9Yssan5hLSNz+pYOtHqBmy6IyOth5uQkn6e652gY4YHeB8WX
 mL5u1EJfbZxGVli6taV5GfWBk8VFgWBIg4VFYzObBgIyXNzfKDyblSx24MC7g3EJkaqc
 QEd+qjmSutg7i7dGsNzQHySFSStQ36BFLkpjUgdfNMIVodgdw6nb8FXXfFvn0eQSp8Iq
 TikT0i0Wvof7g6RNRz79EHR45NMMLBCh60iHrimCrF41iSoLT3DcVIs1EJrzQO7sK1+I
 EXnGPytHYYvcTFa0ZK6FQfIR+F7E7dvn+Xd/PC2Wov/NDscizieaV8LpBkzMLbu0SDiP
 8VHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8FSAVZ0Kx1d7yRk2SZyn/CG3DO4Q19+q+FkDqbZeog+Nvl8wRBNhHFOBTwoyQWcIrbKr5ah0=@lists.denx.de
X-Gm-Message-State: AOJu0YxCl+Rf4ozyg3vxu/JY+/jj7jws4xeH5mR0o0h//cPEUoF+QQXs
 iVOSGvAkeUdca3vIBPBo/1rnkKiJnqtWvP2JoeQ13mSweXv6vL8MwswkTvZh1MRczz9xeBRSI9l
 Ym9YkZA==
X-Google-Smtp-Source: AGHT+IHKkL5XqbF8sZyiDnh4Y35EnE1jtUGcNdHe5gPgltnZlaAna44plwnRGL5JUaXt0EmvucV8eQ==
X-Received: by 2002:a05:6000:e92:b0:36b:b174:5256 with SMTP id
 ffacd0b85a97d-3748c82c760mr213578f8f.6.1724693236662; 
 Mon, 26 Aug 2024 10:27:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3433:4a68:4ceb:ac41?
 ([2a01:e0a:3cb:7bb0:3433:4a68:4ceb:ac41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac515914bsm158151085e9.12.2024.08.26.10.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 10:27:16 -0700 (PDT)
Message-ID: <423562a2-31ce-4d97-bc46-7412245d43b8@linaro.org>
Date: Mon, 26 Aug 2024 19:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/develop/sending_patches.rst: Clarify when to use
 which branch
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240826163917.2786791-1-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240826163917.2786791-1-trini@konsulko.com>
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



On 8/26/24 18:39, Tom Rini wrote:
> The previous wording on the paragraph about what branch to use when
> submitting patches did not reflect how / when the next branch is
> currently used. Reword this to note that master should be used for bug
> and regression fixes, always, and that next should be used once it
> opens, with -rc2.
> 
> Reported-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  doc/develop/sending_patches.rst | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index 3f25b1d0466f..82efb717b179 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -74,11 +74,13 @@ General Patch Submission Rules
>  
>  * Send your patches as plain text messages: no HTML, no MIME, no links, no
>    compression, no attachments. Just plain text. The best way the generate
> -  patches is by using the ``git format-patch`` command. Please use the
> -  ``master`` branch of the mainline U-Boot git repository
> -  (``https://source.denx.de/u-boot/u-boot.git``) as reference, unless (usually
> -  late in a release cycle) there has been an announcement to use the ``next``
> -  branch of this repository instead.
> +  patches is by using the ``git format-patch`` command. For a patch that is
> +  fixing a bug or regression of some sort, please use the ``master`` branch of
> +  the mainline U-Boot git repository
> +  (``https://source.denx.de/u-boot/u-boot.git``) as reference. For new
> +  features, if the ``next`` branch has been opened (which happens with the
> +  release of ``-rc2``) that branch should be used, otherwise ``master`` is
> +  acceptable.
>  
>  * Make sure that your mailer does not mangle the patch by automatic changes
>    like wrapping of longer lines etc.

Crystal clear! Thanks.
FWIW and with Quentin's comment about the back ticks addressed or not:

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

-- 
Jerome
