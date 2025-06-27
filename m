Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF16FC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 11:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D21E182EA5;
	Fri, 27 Jun 2025 13:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xyvt9WYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D56F882EC6; Fri, 27 Jun 2025 13:15:59 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EAE782E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 13:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0df6f5758so241573266b.0
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751022948; x=1751627748; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NFwfCHAAULjMlhplgncsu0YYE/r+LYqctUvQv4f74FQ=;
 b=Xyvt9WYsHx+RyRICGmWpfxmZg4G6EQlXJo1Mb4c8aQ1qBDvv1tWigbYqQjLsCXapv7
 8oIdbK01QdUm1TzhOB8poldnBv4zxR+ofIxys9IY2tBgq55G5Py/CW0qDEhhUHwr3hmL
 mYIgTbdzEttturimiRtkHsUjX4A1SVjMtthLEvTfJ2yCIlrAH51KU6m3NSwb2o13dkhh
 IgK/aCWsptgGSZ25TGdxjYyhoZNXZ1Ul4u6gW4WKl0ApW1GWj+UtJDIPE/HKGct/YC/8
 TQjP5+ol0BMcwOg5QJn9sPqUL8O6gqTAe15pr8BCNP2+8/rfqRS8N+EjVKxCAUv/j90b
 NtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751022948; x=1751627748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NFwfCHAAULjMlhplgncsu0YYE/r+LYqctUvQv4f74FQ=;
 b=H60uv+0FuVhk1iPXpLps+xFA1lNCAMgSohTpcT8g2B8ucv+DO+QVfvXc2POuIb3eQi
 DOWaJIoUw7HfScpwFjTzsIl5mWAA2AH/YLD1yY8OAWubxwUNFxTD8vLkrOphYkezbS4C
 LasgDSnwp+hpU/0E0befkv+2QxYr1s75Zvl5nRqJj0H3aYvh68ADc4CvTQ0cDAi1FngK
 qvRWfwJ6rg9YRy2e29rEuaMIBPXUrceu14ll0Tmt5b+kQzLtSCojgKlJJP7baEz69D8J
 wxhPDshSYLHQJHsBjFpz2aETOoFhjXmLNYAIgbJZXX7rJi8VJJ8t1yInIWeDxfgCHxEu
 2/rA==
X-Gm-Message-State: AOJu0YwFDCYm4xQSIN1ZsBy5gLgucmLu6pjkS3/ukn+LAqQ3iwrjniXy
 LKq28IqzWJ++CW1iYXqZpOkPuKNzh+Fp2KLsxPKNSzF/GlSwxbvrSc+um3dInheCEd0=
X-Gm-Gg: ASbGncuaPJMyOJWwzeXi8+rqU3NPwYdKFAB+gh5T7RBf5D4TG4YG/Jr2ZjObKS0qno3
 LIvCm9S/vwCGUennxEstjuazaGpQ/S0kWXBDDGKd73pX5YMmN1liI3WzWSTlCPGDjWn3nYJzcvE
 O5EIZ+2rdAFmNWz2IaX5gUMW035ApoEOtYvmTLzCwIyzeybTv5ho2Xi4hRziPnF2M9eEcm6tlN+
 2pZfqCQsh3S9IFTALLOc+fm1g8Eu5f2bOtjzoxNVEc4WsLKk4USWob1TF2TMmXBU7FW/9OQKadL
 i8bHn5nAMST7j3Vgs45+z0IqoTC9n0F9PinTEUS+4wTOblFix0D3S6dBYqenZioCmuZkSZzeIpX
 JUx1fbuOn61j3LxlFFAzmSeVJpLiFIA==
X-Google-Smtp-Source: AGHT+IFwSZ5dprr4n2m1WS8sVROCbW/mKGu6fRYHCcrUTw4vXKoWTZGU0x+DtSssbrv/ub+oHVALEw==
X-Received: by 2002:a17:907:c807:b0:add:f0a2:d5d8 with SMTP id
 a640c23a62f3a-ae34fd1847bmr240856666b.11.1751022947599; 
 Fri, 27 Jun 2025 04:15:47 -0700 (PDT)
Received: from [192.168.1.159] (p549d4d87.dip0.t-ipconnect.de. [84.157.77.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae35365a016sm108374766b.57.2025.06.27.04.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 04:15:46 -0700 (PDT)
Message-ID: <4ce46d8a-a680-40f5-bf13-b3b5d184de6c@linaro.org>
Date: Fri, 27 Jun 2025 13:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: ufetch: Initialise size before first use
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
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



On 6/26/25 16:12, Andrew Goodbody wrote:
> The local variable size is not assigned to before it is used
> for the first time. Correct this.
> 
> This issue was found by Smatch.
> 
> Fixes: 86d462c05d57 (cmd: add a fetch utility)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   cmd/ufetch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index 46bd16824e6..bc5db08eee1 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -93,7 +93,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>   	const char *model, *compatible;
>   	char *ipaddr;
>   	int n_cmds, n_cpus = 0, compatlen;
> -	size_t size;
> +	size_t size = 0;
>   	ofnode np;
>   	bool skip_ascii = false;
>   
> 
> ---
> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
> change-id: 20250626-ufetch_fix-54b741710142
> 
> Best regards,

-- 
Casey (she/they)

