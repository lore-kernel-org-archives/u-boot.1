Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2374DC54FCD
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2832607BE;
	Wed, 29 Jul 2026 21:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_qbYqsHqfAG; Wed, 29 Jul 2026 21:52:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4C886075B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361927;
	bh=RI1EUVHWPeeRJfSKDt9HdTbv3BlFUqJEwL2q4X44q28=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XignqNyXpAb8z7kmQkTVhfdQlRGoVPGvq5HXydkqV7RZSU5/t4+id62hKPFZNPLxj
	 ABdKrgotI9I9pmeDOZf3QsuzTmFq9GFsOhUD5H4gykx4msOgMXpRK7GApGMvH+fr3N
	 1V6iZ7G3+3uwRErHWQxJeXbd0PBiDfqMszZ0FDGvwN5zH0pRTo9T73b/w8RfIgg6sn
	 llsJebhPBpuBdBFxDZIkSFx5qedwI9yv6pPO19mXzXeO4D0Po71W2+iysxhSRI9t/G
	 BlibGVvDNWp5DoKIOrj7g4+dfDMPwsf9fG7d3TY2S/se4O99TS6Wgf0XgfIpAojZGN
	 OZRV+NFmde3Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4C886075B;
	Wed, 29 Jul 2026 21:52:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F567194
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 21:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 240C440721
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 21:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dIMwKMYb0rj7 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 21:52:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2DDD1405D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DDD1405D1
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DDD1405D1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 21:52:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F568494B; Wed, 29 Jul 2026 23:51:59 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C606803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 23:51:57 +0200 (CEST)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7ec49608332so785640a34.3
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 14:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785361916; x=1785966716;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RI1EUVHWPeeRJfSKDt9HdTbv3BlFUqJEwL2q4X44q28=;
 b=WSkvCdET/o0hwwOcGdg77lqlpesyLc5ygYD0dGpn36eT+U7lBul0WIoYyUG7AahIeX
 yskS0mnmmJNWfNoxyNgGBqceg2xRrvlBWxggnE22SdI5MUqjZQP6SelIdiyN6eEJDqGj
 FcAEVNDv0WFEIpW3LMxcVC4qYPD5NUzpezkI5wQddTr8rK4Tl3XobbO69n98hBTirEAT
 f47ekcRxtxnD+VkY4cQySNAH0wabsCxMHD3a+/wfVFajYNVshaBBLzcAi65pkSP4HGpH
 eTT1ZwHPls6qjhOuHQSNeJEdr4s9qj9SRbyGGHAH5CsCroMoW0Vbzzt7OYbr54r2OhFp
 EN3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrwy4v9gKuZKenTqBnN/T60gc3qhNQVFSpkMjhPDNdjO+a3LDSpiHq8HMVfiZjFkj0da/xL36o=@lists.denx.de
X-Gm-Message-State: AOJu0YyEqVN7DLKJGCthDlj/+s+owRhjU1j+dnRCAgoa67mzQ942hHjW
 gX3CvdbhjOwCB9FTw4nDtkikMdoWT0sqCAyeUXKf1xJyXZK1yUwGbPhqw3fQMGkkKQc=
X-Gm-Gg: AR+sD10zKx/BARYKhkoIMl9FNtui/DFUNNd+ePIrFlmbqooeQqFa8yowV8ZaGIIc56K
 f20qa1+xutMHjdGd7IJzbhh4by5Dz1y+pNXCTvvvMrFtnbPEbseO3L5yP6YC4yskVXiNmsDekMz
 CyJ7Nbky2kt27hmLPPq76vNFVQ2ORcLltmfOOZi7sMMsMUg1pjX6m7mPsWQZ7rA7C4j8mns/OUh
 vOhoqueoFQSNRLL93UvIrDZLoKexGFKNe2TP6c0jbikASfU1zUhcrTPWzEwFcVlBLAFfoGv1G8w
 FA2giR087+9rbiRGRkGx1NPcnUJ9EUiVmNdTxwzKO+EE/EfI0iixcmyuXtKhU69adw9g8et1lLv
 t2hcH0nfQR+I9j3JRqbDPBOtfGiy0uvExoCpjgpMQ7v6WValCfompvum/YY4vYdfSbtIS0qLh9K
 Haeb3uAdJNJCIEm5HjQLxVTJezfArn3xO+37veISliHEtebPf/4bjs/aydVQ9xTIqzd9yfhnjiE
 ueaywP2CUqhqzCWBFCT2d0v6T081VjqG3gYCsU=
X-Received: by 2002:a05:6830:81d0:b0:7e7:76f:3ec0 with SMTP id
 46e09a7af769-7f02824f73amr302738a34.15.1785361915909; 
 Wed, 29 Jul 2026 14:51:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ea38:c35b:7ec6:8152?
 ([2600:8803:e7e4:500:ea38:c35b:7ec6:8152])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94d7desm3348641a34.22.2026.07.29.14.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 14:51:55 -0700 (PDT)
Message-ID: <613f8b92-d71e-4720-8471-9fce6be2374a@baylibre.com>
Date: Wed, 29 Jul 2026 16:51:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ufs: decode string descriptors as UTF-16 big-endian
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com,
 yoshihiro.shimoda.uh@renesas.com, padmarao.begari@amd.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 macpaul.lin@mediatek.com, venkyada@qti.qualcomm.com, j-mcarthur@ti.com,
 u-boot@lists.denx.de
References: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
 <20260723143852.2287208-2-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260723143852.2287208-2-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785361916; x=1785966716; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RI1EUVHWPeeRJfSKDt9HdTbv3BlFUqJEwL2q4X44q28=;
 b=RcnVyv6tlqhaBoE6us6i7CyQfm/JeaAM1auC5zv2biQ0YpRaiFJGnethnDVQPlhgGd
 DNZkJq5jF+Hmdz4eCxkI3eyW9z3bY1369lsDx0NTP/1CCKJw/KtUetDNuu5dZgNV7AOr
 ZjTFIep70GSuqNWP0pR2060qlLQXmjIegUw/nVX/0BFATW1UmrN9zwc/EI+UsRTniGz+
 J8BkaSbmZ4Q83mFbn647UGmGbw98A1PGVIOUndGKDlZqfvqZlTzLuH+91fsIy2XpSj0N
 Rr+b74cCP/TCPI9/Fd8DMKe9dweCsDh887tm26q8roQckyu+sykm0CGAs44jZqc6I8yU
 T6qw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RcnVyv6t
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="RcnVyv6t"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/23/26 9:38 AM, Jorge Ramirez-Ortiz wrote:
> UFS string descriptors are UTF-16 big-endian (JESD220), but
> ufshcd_read_string_desc() fed the raw bytes to utf16_to_utf8(), which reads
> host-endian code units, leaving dev_desc->model blank. Byte-swap to host
> order before decoding, matching the kernel.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>  drivers/ufs/ufs-uclass.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 6a51f337e47..8f120fbbee8 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1533,6 +1533,19 @@ static inline void ufshcd_remove_non_printable(uint8_t *val)
>  		*val = ' ';
>  }
>  
> +static inline void ufshcd_str_desc_to_cpu(u8 *desc, u32 size)
> +{
> +	u16 *p = (u16 *)&desc[QUERY_DESC_HDR_SIZE];
> +	u32 len = desc[QUERY_DESC_LENGTH_OFFSET];
> +	u32 i;
> +
> +	if (len > size)
> +		len = size;
> +
> +	for (i = QUERY_DESC_HDR_SIZE; i + 1 < len; i += 2, p++)
> +		*p = be16_to_cpu(*p);

I'm not a huge fan of modifying data in place like this. What do people
think about adding an endian parameter to utf16_to_utf8() instead?

> +}
> +
>  /**
>   * ufshcd_uic_pwr_ctrl - executes UIC commands (which affects the link power
>   * state) and waits for it to take effect.
> @@ -1765,6 +1778,8 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
>  			goto out;
>  		}
>  
> +		ufshcd_str_desc_to_cpu(buf, size);
> +
>  		/*
>  		 * the descriptor contains string in UTF16 format
>  		 * we need to convert to utf-8 so it can be displayed

