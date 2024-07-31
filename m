Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A45C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 13:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26928889C8;
	Wed, 31 Jul 2024 15:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCZytB5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2C388A03; Wed, 31 Jul 2024 15:17:37 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02BA0889AE
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a1e31bc1efso341077485a.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722431854; x=1723036654; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tCfayZwVl7INTaICPQFBmSdcy++Vbwv4q9itstz6Kio=;
 b=gCZytB5sAk4PNsVoVqYdUqT2X3gjDQO9IqAPimo+pf4UpTOMuPkSyBlHB4yJqRHhI9
 CkatL5BsJFl+Vxa5X+e2jo5nMU7ZN7jphOyvURZe61Upn7vL6wVVMTE1qViNbS2gBtiI
 iRrAI4dFsdHFTvGEnguxI/6D9ypQNcl386WARnipt8bOU4KQrVYZMKYrdriWW21LGFP2
 S3umNcYD5fi+xt0UpCnPA8ergnjThejtLgSBBmI3KbuQrBvC2aPKSXdNuZldDdHksnnw
 V+H10ZmKgt9WbxS4SHkOXdWxw1kPn0s59xbaKZtLVbrSfVs6jFlJoqfQVqtsrQRLV4EP
 1Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722431854; x=1723036654;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tCfayZwVl7INTaICPQFBmSdcy++Vbwv4q9itstz6Kio=;
 b=ORkZZLdnPJGcajWVgAR96KhPj97aSbK0D811IHy8dw19Z2pbbCQKFHXK0eEaWsxXKq
 0TMJ/bnvvBoA1M7KU7ra2ELG5v/9++8Myv8xfF9URaxCECTCtSZhiXf/JGU4PripHb2I
 IWoAestn+9CDPgK6yC7UWunZLDIWNW4wlWpnINVGO3Ool3rtBYYk0czzbHJSUFdjNudQ
 BnvJ4vVW9tiH0Y9dNdNoekSVdWP+Cd+2joVaCh2aWqWu3OZ2nxILNnozhGuXpNGef1+D
 owCajJA4YzZxy405mWlrep/EubkiFcTHUxn343cAvHlnXf/4jOQFX2JERDaMHraHJbxH
 DtBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBWPQedHisO2kfw05gBA5XpM1YqEbHSVmrzeaG781l1ZCBaeCv0L19ivC/PX8U8QN28dKtqw8HM4Cqhn2jIyC5OJ4qJw==
X-Gm-Message-State: AOJu0YycBJjgJ369EsRNUi8z7hhD0RfS5976ZGBglFqU2cR2snz1nyb9
 tNiGV+tszdWd+JoLbwZcawwIQ/tkpjW/JGCbZOWw9l+YxUDUQGRR
X-Google-Smtp-Source: AGHT+IG6n8Ze2c0i/DsP63kLx6NcSK3MO6eZ78O8fT0ektyzAoCFojtAy4AFJ5ho3z19CqkOrIxDKQ==
X-Received: by 2002:a05:620a:319e:b0:79f:606:5be8 with SMTP id
 af79cd13be357-7a1e52c7370mr1686954485a.46.1722431853862; 
 Wed, 31 Jul 2024 06:17:33 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b5b7bsm741381985a.46.2024.07.31.06.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 06:17:33 -0700 (PDT)
Message-ID: <5abc3c9a-3aa3-42db-a3f7-b497bad47517@gmail.com>
Date: Wed, 31 Jul 2024 09:17:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
Content-Language: en-US
To: Franco Venturi <fventuri@comcast.net>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>
References: <20240731130913.487121-1-fventuri@comcast.net>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240731130913.487121-1-fventuri@comcast.net>
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

On 7/31/24 09:09, Franco Venturi wrote:
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
> Fix: cast 'sizeof(*header)' to int so the compare is now between
>       signed types
> Reference: https://stackoverflow.com/questions/17293749/sizeof-operator-in-if-statement
> 
> Signed-off-by: Franco Venturi <fventuri@comcast.net>
> ---
> 
> (no changes since v1)
> 
>   include/spl_load.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/spl_load.h b/include/spl_load.h
> index 1c2b296c0a..83db381202 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -22,7 +22,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>   
>   	read = info->read(info, offset, ALIGN(sizeof(*header),
>   					      spl_get_bl_len(info)), header);
> -	if (read < sizeof(*header))
> +	if (read < (int)sizeof(*header))
>   		return -EIO;
>   
>   	if (image_get_magic(header) == FDT_MAGIC) {

Reviewed-by: Sean Anderson <seanga2@gmail.com>
