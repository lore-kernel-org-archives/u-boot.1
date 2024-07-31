Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A28C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 12:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5564F88950;
	Wed, 31 Jul 2024 14:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bvPaFfOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C48388955; Wed, 31 Jul 2024 14:52:26 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B738811C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 14:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b7acf213a3so29766806d6.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722430342; x=1723035142; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2XZBS/lo0+vzqYT2esCR+IaSauWDJzxZy1EebHmcB1w=;
 b=bvPaFfObHAl9As7FidIhhzVE+igabccfF5uDaTd9vG3ALtCPMKeVdaaCk3QVlGubMJ
 zDZOewWLgmGSFuLk3HqmGG6B3xyWkw3ox3kBM/RB7meckhkovLc334ar35MkSvCExuzu
 v2J0Rby56STE8lnKotCeE7n8GYl4ZwOBWjI0+vPiFgaqGNN1wPR5WIk5INlDn71/sfN8
 QMePoxSW4US9Sfzxzm0y9auoHKm3iRBDi+uim9OgqdG2fliW/8R6HSvUAxekgvppTFn9
 JMmK3yVWBw39GQsePzttsitlWaBopWRqA6rWNlc665wgrImp3K81ZONM3JiBwf05nItB
 6bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430342; x=1723035142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2XZBS/lo0+vzqYT2esCR+IaSauWDJzxZy1EebHmcB1w=;
 b=SZSSWoaESItFkZTADLNRTxNhPomfB06MFylZKfwnd78S65mtmB3IA7AEdcDLqDjPrR
 URB5TILRQKD7O1xC/wPeoMpE6rVsIGrRn0mrkKCWvFxkPqGTEDAG20YTWDY8mWPalaYK
 uiDvTtBtnuqVyLyUssNbAdRlujK+HUCpZLE0PdoFa7XYfaEIkLhgDAgiowPKwfdjsiuC
 L6HW6MKP8oMHsP5FSpSN1al9uVzNLBh3FouHbdT7UlqYtAmXIV1b/NhD0H11g92MfsbP
 RscRz8v1dCBzWsE2JZUNhGYwdHn9kXSfh5EoYTYqhP3cSw1KqOmC122JjneH1jhZqtBi
 SzAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0sidTtdv6SXLDk9Zo9MapZwxmzdJZTJjLpH20ON0Nx0Whj39p3i1FAjJLmMM09TK5E/bN4B8=@lists.denx.de
X-Gm-Message-State: AOJu0YySCG0WSrLmx6vNQxLuzjVatbDpYcricseZ2ysdEeMUKT3yGcOp
 MLIZpAXcq3fcdN3vhxrKKFsG/DOSdt7szlF/AS/TWSJ9WGzGWkWs
X-Google-Smtp-Source: AGHT+IFXXlPl+zzC1UAvLARrVF8S/1Nhi4G1Sl66jdCuZQ37CdNxWjQH3/1/4guGe259Mkhf/ZVjpw==
X-Received: by 2002:ad4:5d46:0:b0:6b5:44c:24ea with SMTP id
 6a1803df08f44-6bb55a0245amr209398236d6.16.1722430342589; 
 Wed, 31 Jul 2024 05:52:22 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb78f3fc49sm16362796d6.87.2024.07.31.05.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:52:22 -0700 (PDT)
Message-ID: <60c5a1ae-763f-d6e4-2200-53916c99e29c@gmail.com>
Date: Wed, 31 Jul 2024 08:52:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
Content-Language: en-US
To: Franco Venturi <fventuri@comcast.net>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>
References: <20240730133043.12577-1-fventuri@comcast.net>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240730133043.12577-1-fventuri@comcast.net>
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

Hi Franco,

On 7/30/24 09:30, Franco Venturi wrote:
> Fix signed vs unsigned compare in read check in _spl_load()
> 
> Issue: when info->read() returns a negative value because of an error,
>         the comparison of 'read' (signed) with 'sizeof(*header)'
>         (unsigned silently converts the negative value into a very
>         large unsigned value and the check on the error condition
>         always return false, i.e. the error is not detected
> Symptoms: if spl_load_image_fat() is unable to find the file 'uImage',
>            the SPL phase of the boot process just hangs after displaying
>            the following line:
>            Trying to boot from MMC1
> Fix: first check if 'read' is negative then check its value against
>       'sizeof(*header)'
> Reference: https://stackoverflow.com/questions/17293749/sizeof-operator-in-if-statement
> 
> Signed-off-by: Franco Venturi <fventuri@comcast.net>
> ---
> 
>   include/spl_load.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/spl_load.h b/include/spl_load.h
> index 1c2b296c0a..1e05599d29 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -22,7 +22,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>   
>   	read = info->read(info, offset, ALIGN(sizeof(*header),
>   					      spl_get_bl_len(info)), header);
> -	if (read < sizeof(*header))
> +	if (read < 0 || read < sizeof(*header))
>   		return -EIO;
>   
>   	if (image_get_magic(header) == FDT_MAGIC) {

Since read and int and sizeof(*header) < INT_MAX, I think the best solution is
to cast the latter to an int.

--Sean
