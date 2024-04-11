Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C227CD11C2
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 02:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9C8865D0;
	Thu, 11 Apr 2024 04:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKuNpp8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F20F86D38; Thu, 11 Apr 2024 04:40:12 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535098644E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 04:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78d68de297fso263304785a.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712803209; x=1713408009; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xnM2q51B4JmI0IGAEl6l+GHWwvAB3d5sPk24HEX2tpI=;
 b=fKuNpp8y3OBdBTvdXuymYS4T4RrnnVxPodWDZfvLnPGojjVqFU0w028CwbMgyY6Or0
 N2nZjqqPzhxjbo0jvyTEDTlOS00gD0puRuZp73RjUdoidt+f8G9xmd9XPMy51s4TlEq4
 xfCT0kSmoVtBKpBTuTumPC+iV3Q9L2T+iqQ67filTlcbh1iOcOEZoZa3psmg3/cdh4/r
 OqlPsKhYFERcf4mwS62gzXIFrVn2s+djATlrNRy5fTaMzyvB6COBbJzwGJqQJkIHIN21
 iRGJ7jBYm8ncFxEYCSSxDd+JhLPdhR1yaZ8FOkb1Dtq473pL6lsrdWebkaT5WdMYFbQT
 ilcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712803209; x=1713408009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xnM2q51B4JmI0IGAEl6l+GHWwvAB3d5sPk24HEX2tpI=;
 b=By491wQVDKpr1VObK0gtG35wjZz5zX+glaaeXWqcdFHzmaPPN9ky4bAv2G6xhvFG+Q
 s9EGzQgRfhM82+egAiB78WipKUbKkeupG1iEW3jZsE5/zpS0VSt7mv/rLNaamgFhV0O5
 06daMPfO4Qa0443WfHnIlhTT+QKoGRSqvMyNWjaQAznhUf9JclVosRqxWX1UZxwt6Kuj
 sLOcnIhAYWZHrdN5UD9MT4bB+NfjOKkLQp82C537dNFUFxQeG/XhkR+PaxDg6ldONUeC
 isADRN1K6TvLwaLN792s4YFC7qPnNMHkYJz3D6gYy/aeH3QDNU8hTot5SyWDR6YQ3TVp
 VCgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHCdA/DtLCrEifTpRhs2A8XZ9IqnPvvZB3Qv4hax5CeeSFc6xmGAzqmCzXLcQq3XmDYpY68q2unyq3+JIL0roC4vCznA==
X-Gm-Message-State: AOJu0YzuInHVsKpek+mHE5e24ipkDxtMbKq0fqywDzkCn5muEyTbwIqU
 4K9Y6DutAuAcq3uwJCUgumt9GAovrocN1J/mwBhLHUg5Gixb/sVP
X-Google-Smtp-Source: AGHT+IGACDBlXX4cNslP7JF7BpmKl3pOfhVV1I1Mm+hM84PJc39PdtO1hS4v/5C2zjYuF9wnk/g3Xw==
X-Received: by 2002:a05:620a:565:b0:78d:6b64:b8df with SMTP id
 p5-20020a05620a056500b0078d6b64b8dfmr4078742qkp.66.1712803209089; 
 Wed, 10 Apr 2024 19:40:09 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 m16-20020a05620a291000b0078ebb7bc23dsm399313qkp.62.2024.04.10.19.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 19:40:08 -0700 (PDT)
Message-ID: <29ad530c-38ba-dad6-b33e-a309a3fdf07d@gmail.com>
Date: Wed, 10 Apr 2024 22:40:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] sandbox: don't call os_close with invalid file
 descriptor
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240410215034.18806-1-heinrich.schuchardt@canonical.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240410215034.18806-1-heinrich.schuchardt@canonical.com>
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

On 4/10/24 17:50, Heinrich Schuchardt wrote:
> If open() fails it returns -1. Calling close() with this value
> makes no sense. Return -EIO instead.
> 
> Addresses-Coverity-ID: 185828 Improper use of negative value
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   arch/sandbox/cpu/os.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
> index cbae5109e85..154a5d77490 100644
> --- a/arch/sandbox/cpu/os.c
> +++ b/arch/sandbox/cpu/os.c
> @@ -188,7 +188,7 @@ int os_read_file(const char *fname, void **bufp, int *sizep)
>   	fd = os_open(fname, OS_O_RDONLY);
>   	if (fd < 0) {
>   		printf("Cannot open file '%s'\n", fname);
> -		goto err;
> +		return -EIO;
>   	}
>   	size = os_filesize(fd);
>   	if (size < 0) {

Fixes: 566bf3a8698 ("sandbox: Add a function to read a host file")
Reviewed-by: Sean Anderson <seanga2@gmail.com>
