Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0747C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 16:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 405B4607CB;
	Wed,  9 Sep 2026 16:11:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hoaea1Yxc3Sv; Wed,  9 Sep 2026 16:11:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2F705607BE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788970275;
	b=IUEpQ7Kh3z5U7hZTzHQP/aFlAPg/3+iBgHb4wWm1BdEy7DxYvutjsxtOyi4doMT6OjhA
	 O5BnJRxtojuPPxJjQEBT00CmoS9n/dmt04uh/RLzJpqevP+9Sm1W0QlvjmvmgbHiqxwss
	 rqoRYAhIi+rmVwpSbS6TJGL4EzoYia8Qpy2wgUQB+dtUCE+ATgir8S/CqWax4ab5fHTq4
	 zf05FERtDBoRFP9JwNA7PqM356o6+gxbnNMkhMGsH/YiWJTt/Q0B7a417sUpwEGc1gA9c
	 sJ5och7ccLzC13Rclhm9jTIVUls3Wuw0drUye5s/NPhMaSoZEEF4ApNJFIgmOTZisTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788970275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IwXj4agt5SDDDVGilxmW3kd4lleV36Y2612fA0r6sD8=;
	b=P1zPArVezw4yitHlOwa6kyfR8dcUQM0yee0oxKtjCaHpWDJ84guqhg9Bewx9Ge5/z1AQ
	 kfAKyVmI/MKKtbuJTnlGY3VMCfDHqs1vxS6vpTXm+Etr/xqs9WZHJgcuB/Fu3VucmkSss
	 5nTjytSudxAZM7iIuH2zC2Mgjz+WMjgZFSKFG7KiXmdSBAN2nEDvNQDZ0lsPE+CflfuCa
	 +AWIrubMq4rLv+k5UsiFXbqoS4Uc5AWYNjjMyKFgpt9UeYmDkdL3t/DcHB1I29SCasEWx
	 lGmS+rVJnnABlZZ9zvnPG0YXYvjPq1vra6sWTQlHhUVgTu0pOl6rlqDpqlxvjRawYjQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788970275;
	bh=IwXj4agt5SDDDVGilxmW3kd4lleV36Y2612fA0r6sD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0t9VU8Bn84BOAD3HDrAF2PD+ZUdUz/6Mk3evxQ+melQnifCFzFRQ8iJO0MOlJ8t4F
	 jvEvCr5L7Ko/+4EKsFUbVXPvm409yuMFjT8Hm1KwQHy/a0Shs8myoXMgv7qOZSLPDN
	 qD4jGhHwX5s+B+YHosdAo6iaSfIlT9pXUsKBexCIjBRmudJTpx0ajgFmTvkIvEQgIc
	 VqiNY4nUr9pjgIURAl/eK3bVQr2oBp4vyaey/lZ4hd2z2oSJUkGLrkNp/++lQTtlMs
	 w3LMQvpKsd9URo/CZV8PwmufruEqJH+hAQ/HLv4Z4Xj0GX3oGD8UbjcTG0c29EznSj
	 79XAIalvW9T5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F705607BE;
	Wed,  9 Sep 2026 16:11:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69707268
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AC5C80E0A
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0V2I4fV0-wJ for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 16:11:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CEA3480E01
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788970269;
 b=Dc7k6AqPLrzynu6ZMnsDjhTyXET5qqoWPMe9y9X3vXEfIWxZ/Z0SEXNwi44zDZ0HZAUp
 UYnz/+GU1ddER+m18fgXafEHHqxaNyrhYno1kcq9jSV6Wrx9H7pVcVlZUYuvMYRTEXO7l
 Hz+QxGD9ZhIFSGHO7yaMzN8yVlbEGaI8xYcGgHCgCU3hqane6UChJZDbpZQ+Nv81nbOqE
 JlAyu+/zuD7qo1VOn0olEmzLQXhJs+aTfFN+tlgJCMwGWPg3/aLJpUO6IItnjvQg6H6Mj
 fAcHO/ssZtLchYAkBh+uI5ZaNkDLruFru+/hicVPMPR+6SGJDW9A6UVUXrxovY0WPFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788970269;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=IwXj4agt5SDDDVGilxmW3kd4lleV36Y2612fA0r6sD8=;
 b=VeCogamhqZpK1maF472GoF6yMW1vZkuKu/vUfIkJ4WER0Tl8LYqX20SYWLrpCDUf/t1n
 euCfasfApCxfH9psjP9EidNPJeW8cyO+kV1dC7RgbYeYSUk5Dw097Zvhmoq9XYw1SkY6G
 zqsvUICVpBSX6XmvW4ydNGy0yDY0Tk4kK3LVLo4oIBpcc2G05D0HLOxGr04/BMZqvjkzp
 wysat3RfLvUaJGnYlUfhs4WskCs4DR7m4eozzQvPeV6ERVUpKoVy6/TNS3JYLo1pT4D99
 rluYkcfnRGR/R0gxQ/CpkvwBOO6tQmHxqJqRZOOOcp3eNbT8sqcnwlxgXJcnqlSOKsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Hvzj18GO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Hvzj18GO
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEA3480E01
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:11:07 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6bc7a8b4802so2342163eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788970266; x=1789575066;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IwXj4agt5SDDDVGilxmW3kd4lleV36Y2612fA0r6sD8=;
 b=Hvzj18GOBCKug3fifU/NPDaMznmPPrd5QYdvn7zL6O4+902xL67bfljrvu7T4k17wl
 A/EHS8Yaf7lEAvOUidC3eYVD5WfJ0rd8lQpuvFXQQF6J/9ffGyxsbVDPJj3GTm+hlzHG
 Sx8ECixiRkpzJexVbuSZQ8vP9DIgB0wHTlpFPRIv/syt03VSgW4BO4rXs8GljcQwJPs3
 TbW894uS7yTyQ/iq1+4ax1/Xhga+8YY08cG7iFY+Cd6bOirMS5fmGB5V3o3feM/fHYzy
 MqqJWbp47HLT3E70KxZW3zRPZdLjLvv6r8pk0hd9yBIY3pR5e6dLSEr/TsLtP/VvoT1m
 Ryvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788970266; x=1789575066;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IwXj4agt5SDDDVGilxmW3kd4lleV36Y2612fA0r6sD8=;
 b=bGnbwVaUj2SLQZUjQSK4BETG/oxn/qPgUc8RtVknvSWvODUGodNLlx6yc4uVtaXzJI
 sUCzAgS+Js4dZISfHkv/uh2xxwHz94tf7qXsHSGvSO1SXN13Ail0urYo1RzKA1Sxc3aR
 0yD5OrfOXdOm6kCDjzu/pC86PAYxwGFlAwoTW3bsL6N3rZC5qHlXzo3X51ZT00L8Qd70
 AjUcuTle1cbsd3r2J46UMGVY2fY3hO+5kGZf8+jmd3nDQo8YNhZg4mvgyvO8RPadSSv+
 XIhRFoVkG/eV45Okv/exvmLZStGdaLn9UDreAkTRPEPbUUQtul/2bilza0Xkj0/rGC0C
 hTLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/hNm8z5dvyukVZ4J6dGhRb+24+z0BRwztMH7xC7/uLY7u7YEpRqenEdrc8geRNLKSWOrE48c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l/5Eg+qttmErfl8FVmeapVta8h6vM+2K/jW1qzjyqi7zzUPb5b
 TL5tVrV7K2Zrhhr77L689INDqFsbORx+jUrQCc+9tPgyqzwTrkzDSPRxUv9aZ1DgEVY=
X-Gm-Gg: AYBFou0RMJMpQjuZNR1u/dAmU2JX1vs3aT0Y9KDxvdGBhqt4mVz2tCO2dYQxypfZEzF
 BQyd3bWeZ4t7hG4pvINPK7PcTampUUp+kPUxWgJGd7ZO+gbyNBaLEjkCf/7qpY5gJNsU7VLpRiA
 O7sgsrqj4Ma53QHg3sm7X7/2KHz7eQg0YXVoigYjb6UUg65Z/io/Xy12hzHt2F/ZfCRxx3NyAmU
 729GX8aa+H/79WPrFQQpVmzLDx9sYuijyyNoJzOqJAABNJsGDshtS6O62znH6Pwyr8JVl5r6nEh
 ZMdLYg0JY1l0+IF979Y926PUQtmcUecnRBCswccirDOjP/YAqjsANelnOVKWIq0HTXw4R2EB6RG
 BFEZUaWbh+tBi099BpsYCs9ZcTnO0P3kPHBmHffVjgB0BqLXX9EK9ISLyG31npC0hLMXzbMFX2v
 jM2FZq/iYMW6wrsusQr7Wb47kVjBGNXDjPCPN5iJtgLWzq8fuDKI1g+0HNEYrEv7B4Xe6rzQRTB
 g8tA0a+puB83JtVE7eyVSVRiRZBerGGIZ790a3A5yhvggXOQQ==
X-Received: by 2002:a05:6820:809:b0:6b7:83c5:fde9 with SMTP id
 006d021491bc7-6b783c6033amr18453460eaf.42.1788970265977; 
 Wed, 09 Sep 2026 09:11:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3?
 ([2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6d93df1easm15994939eaf.1.2026.09.09.09.11.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 09:11:04 -0700 (PDT)
Message-ID: <9e05bc7b-be99-40f7-8c64-259e92f92148@baylibre.com>
Date: Wed, 9 Sep 2026 11:11:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] ufs: decode string descriptors as UTF-16 big-endian
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, peng.fan@nxp.com, 
 jh80.chung@samsung.com, neil.armstrong@linaro.org, bhupesh.linux@gmail.com,
 n-francis@ti.com, xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 tuyen.dang.xa@renesas.com, yoshihiro.shimoda.uh@renesas.com,
 padmarao.begari@amd.com, macpaul.lin@mediatek.com, jstephan@baylibre.com,
 hayashi.kunihiko@socionext.com, j-mcarthur@ti.com, venkyada@qti.qualcomm.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
References: <20260807140119.324858-1-jorge.ramirez@oss.qualcomm.com>
 <20260807140119.324858-2-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260807140119.324858-2-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 8/7/26 9:01 AM, Jorge Ramirez-Ortiz wrote:
> UFS string descriptors are UTF-16 big-endian (JESD220), but
> ufshcd_read_string_desc() fed the raw bytes to utf16_to_utf8(), which reads
> host-endian code units, leaving dev_desc->model blank.
> 
> Add an endian parameter to utf16_to_utf8() so the caller can specify the byte
> order of the source, and pass UTF16_BIG_ENDIAN from the UFS driver, matching
> the kernel's utf16s_to_utf8s(..., UTF16_BIG_ENDIAN). Existing callers keep
> their current behaviour via UTF16_HOST_ENDIAN.

I'm not sure host-endian ever makes sense. UTF-16 is either going to be
coming over a network or from a file, so needs to be big or little according
to the protocol or defined file format.

> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>  drivers/ufs/ufs-uclass.c  |  7 ++++---
>  include/charset.h         | 17 ++++++++++++++++-
>  lib/charset.c             | 15 ++++++++++++++-
>  lib/efi_loader/efi_file.c |  4 ++--
>  4 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 6a51f337e47..5cde2ab70be 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1766,11 +1766,12 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
>  		}
>  
>  		/*
> -		 * the descriptor contains string in UTF16 format
> -		 * we need to convert to utf-8 so it can be displayed
> +		 * the descriptor contains a big-endian UTF-16 string, convert
> +		 * it to utf-8 so it can be displayed
>  		 */
>  		utf16_to_utf8(buff_ascii,
> -			      (uint16_t *)&buf[QUERY_DESC_HDR_SIZE], ascii_len);
> +			      (uint16_t *)&buf[QUERY_DESC_HDR_SIZE], ascii_len,
> +			      UTF16_BIG_ENDIAN);
>  
>  		/* replace non-printable or non-ASCII characters with spaces */
>  		for (i = 0; i < ascii_len; i++)
> diff --git a/include/charset.h b/include/charset.h
> index 348bad5883a..442cc44d077 100644
> --- a/include/charset.h
> +++ b/include/charset.h
> @@ -13,6 +13,19 @@
>  
>  #define MAX_UTF8_PER_UTF16 3
>  
> +/**
> + * enum utf16_endian - byte order of a UTF-16 string
> + *
> + * @UTF16_HOST_ENDIAN:	code units are in host byte order
> + * @UTF16_LITTLE_ENDIAN:	code units are little-endian
> + * @UTF16_BIG_ENDIAN:	code units are big-endian
> + */
> +enum utf16_endian {
> +	UTF16_HOST_ENDIAN,
> +	UTF16_LITTLE_ENDIAN,
> +	UTF16_BIG_ENDIAN,
> +};
> +
>  /*
>   * codepage_437 - Unicode to codepage 437 translation table
>   */
> @@ -299,9 +312,11 @@ size_t u16_strlcat(u16 *dest, const u16 *src, size_t count);
>   * @dest:	the destination buffer to write the utf8 characters
>   * @src:	the source utf16 string
>   * @size:	the number of utf16 characters to convert
> + * @endian:	byte order of the code units in 'src'
>   * Return:	the pointer to the first unwritten byte in 'dest'
>   */
> -uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size);
> +uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size,
> +		       enum utf16_endian endian);
>  
>  /**
>   * utf_to_cp() - translate Unicode code point to 8bit codepage
> diff --git a/lib/charset.c b/lib/charset.c
> index 182c92a50c4..e5861ba96f8 100644
> --- a/lib/charset.c
> +++ b/lib/charset.c
> @@ -11,6 +11,7 @@
>  #include <efi_loader.h>
>  #include <errno.h>
>  #include <malloc.h>
> +#include <asm/byteorder.h>
>  
>  /**
>   * codepage_437 - Unicode to codepage 437 translation table
> @@ -458,13 +459,25 @@ size_t u16_strlcat(u16 *dest, const u16 *src, size_t count)
>  }
>  
>  /* Convert UTF-16 to UTF-8.  */
> -uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size)
> +uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size,
> +		       enum utf16_endian endian)
>  {
>  	uint32_t code_high = 0;
>  
>  	while (size--) {
>  		uint32_t code = *src++;
>  
> +		switch (endian) {
> +		case UTF16_LITTLE_ENDIAN:
> +			code = le16_to_cpu(code);
> +			break;
> +		case UTF16_BIG_ENDIAN:
> +			code = be16_to_cpu(code);
> +			break;
> +		case UTF16_HOST_ENDIAN:
> +			break;
> +		}
> +
>  		if (code_high) {
>  			if (code >= 0xDC00 && code <= 0xDFFF) {
>  				/* Surrogate pair.  */
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 19b43c4a625..b0faae2d716 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -184,7 +184,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
>  	int flen = 0;
>  
>  	if (file_name) {
> -		utf16_to_utf8((u8 *)f0, file_name, 1);
> +		utf16_to_utf8((u8 *)f0, file_name, 1, UTF16_HOST_ENDIAN);

I'm assuming this should be UTF16_LITTLE_ENDIAN (because FAT file system).
The bytes read from the file are not going to swap themselves on a
big-endian system.

>  		flen = u16_strlen(file_name);
>  	}
>  
> @@ -216,7 +216,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
>  			*p++ = '/';
>  		}
>  
> -		utf16_to_utf8((u8 *)p, file_name, flen);
> +		utf16_to_utf8((u8 *)p, file_name, flen, UTF16_HOST_ENDIAN);

ditto

>  
>  		if (sanitize_path(fh->path))
>  			goto error;

