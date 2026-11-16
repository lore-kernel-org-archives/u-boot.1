Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D9606FE87
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CURtAe7y;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K4ECf3TE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67F7340602;
	Mon, 16 Nov 2026 11:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ss_9RjruRarD; Mon, 16 Nov 2026 11:18:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41244405BB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827900;
	b=aP0KDLrkKNgoS/Ad2XgHuO4O3hA8Vxx4RKjJvrXLvSI5nXD8mDTZ3siax9WzsQru0cMb
	 xdF3kw8ZVIR5qdeZQ406fKkoXov13xwCggyrfsEZlBl6vlmXlq3P0Rdtyq0NnWJga8Reo
	 VamWA/nqz8xTMcq/KK7S1kTdGC8O12NRNVjZeVKHxRjLVg0QiB8Dm8jgOnuPCFoKuIdt+
	 zUEBb1ljM4WZPqHJZt2wlpW/XdQRYsRD1aVQiaEYbGLHT8UUlqKlCng+H7TIE8+Kqnf6o
	 6qTTSVRpcNKUH/IlbQqmtgC3mXH6v/8TB7+p4wlFmCaWI6hDFfPl8x9ModlHVEX5UbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1Iex3BwI4DFurrsbehl2yhCiXVjgx31L8gkM4H+jxXg=;
	b=r5MxKaowd07VZy4QlN0T+2edzP81sNldCPDL9h4C0KgMn6Avdd20FEUHDvA57S0963sv
	 YxMmvST3/J9Llu3ez6Pc0p7i+zuahabKU8vsqiaJkLmBNBrF+LhXj6hwBRuT3juFvfMxa
	 BnyXPXOfquCfgDG35J9VHBrVx0cQE0jezsq6VDJdAeOJiNwrBUBMj0fk6E6oo3MA7D7Ri
	 ZoRwGeAqGb8y1toe7IexdK8CqRZTtKaDI2tlWcB72j9Jn+uzW0J90bZcYemC5YS40gGNL
	 iX35ARSCVHBsMsUf8WwwJb8r0+48Isc0GmClZz+v6meDYj7qzqkaKgENd5+v7FRnbGA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K4ECf3TE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827900;
	bh=1Iex3BwI4DFurrsbehl2yhCiXVjgx31L8gkM4H+jxXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CURtAe7yssIntzjHAg/7Hg7Nix4zi/D11gESlYUKWbWITEzu0XyG8fvY86dT3QC49
	 b0+D5XBTMgEt5Kjz1HSZ/xRCyFwEy4Bc6fnU63Mcz81q7aOQEGKh0uPsdeUW43n8QK
	 YR1zRh0n8Q2t7APHjzaLj4Ml5hbwhLDK/x1F255yDfaeAzD952WYV9Hvh4PKHM9YQW
	 t5pM5Ms86evwAuKDxplnWown84kYr02TS7Q7i8a9z0GyIOF5HnjRwNHO1fOJclWS6V
	 YgKIFJ/2VV+hiOO7sv5o7dd9fi4MGL0bqhvRgoCPx0rYwpXJWtw0YCq0JRDGDDq+oj
	 TjvcXsJo86svQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41244405BB;
	Mon, 16 Nov 2026 11:18:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB8D528C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8F6E405BB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wd-dvy5g0yM8 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:18:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B449640541
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=K4ECf3TE
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B449640541
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:18:17 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso3629772f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827895; x=1795432695;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1Iex3BwI4DFurrsbehl2yhCiXVjgx31L8gkM4H+jxXg=;
 b=K4ECf3TE8Kp++s6IaIJh/vXggTqJOfaA3UIq0HIkdI2Xbfhc2xm9ZSs7ECWicZrjTY
 KNc96XEUFX8fqTb+V7WIuco/6uzp0R5MwyErpXJ14P0+jV4oOhLlP3gt+VQekLC6aBRq
 SuFrAKJiylHn43uoIBC2+ckF3BU0txEfV4dCPYsqr5xcz7adOotx7gV+mYZvk8DaEjG1
 g8GLGsPgp39d+2telrkImJktXewCPveDWZwHUNt6T6qGBYH1vDfU60seVfA1FuiA0nlC
 irYqV7bAgtDBwyJoLE/QE8+dkP86Y39ywmMB3GL2ctUmVie2Q9+VswTIH8d91pFQBfSa
 L28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827895; x=1795432695;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Iex3BwI4DFurrsbehl2yhCiXVjgx31L8gkM4H+jxXg=;
 b=IpKf+fPsMs4+SmU837gH2vGxnpls32jY0QSO1eXUx9eORBVFiiQ52ZO/muqw8mfMlL
 EYPcccMSW3FIn+i5mP4qgFp+CFRODk6nXatJh3/u3vxGHTjGrirIw3HxUS/zBDaNYP2s
 KDJtqNNC94+uvcAumCPW8DlKidSkjtkFtmNd3y2+rwITYtl0nouPnGDOeSV1KWgB7VSI
 TMoLpLDy+oejnrwccqEIVZ/Fg2ng3cBdk9neJgHWhO+eg8oTbusQzXlEEVluZHPy6vjn
 LxZjW3QQ90UtbTIek4xn9jgfVatPKc2/XY15OK3UWKF3UbBC1G8SvUg4sgd6EpX+m0wa
 GSIg==
X-Gm-Message-State: APuU4Z9+0bNnA5I67/Vd/PlCaMT9P+In/76vtFZFqGzRCjkXCJrvVVl/
 jb7c7eOlwxWfehYkISFwjEqBvHQfSldtAq9ENT/ZhEfJWbmGntD/f+YAYDlWcVVzh5xBjbpa2Xv
 2xyQNuU4Iqg==
X-Gm-Gg: AZFdTZcY0gQ1P9qjx/JWN2g6DAoRpwwma9CBx/TJmDHrU7F9HH3dJlZqwaQKTfMeX8Z
 xrpd59vw1Fbfy/XiSkoZYKMIdgQCdQmXWlRBxMQFBHpf2Oc5lQGSxQf3rWodULElYaBhmHQzH3l
 LGoWKXCxcdnjxFDz/A/4l12E/DnbgYrxOqH2gT/ickLhlT0l9Q1p2mu5Iqllc9h1WgDZi7Rwb4W
 /ZHuWQAZtkB1u56m2JBFVsEmB8DsrgzNtal6MJXrssxVBWJd9NueL5lIGLfRWDtX4jFak3NbZR6
 ErTTKgQTx7ysy/d3aBP5nZxwAdJOUGvMxVzJm7jywvwjKwRYXWWNtJwrP9JO07wOJOLDdEp0VuM
 3Jp9q9vsdmDt93if7pp+4jYTscR4LA7b84ouNc7nIy1koyfHh7tz5a29KOARSWh3oPzvYfdnDpt
 QWgxwVZfhfylds/DJqadOFlISWvUULsjOzdCBGP2XzdXd5QZ8AVQEn5yN29r5FZNywWHLOIlibt
 Q0hdjBOyylBBv7dvT5kBmC2inKO3bV8x6isq3xs2Fzb8TIFx3U5qPf8Jfv1yBlsyuQhdZSJqa9i
 bQer2u4xo/aVpTcVv/Jw8QEFiAhPItoLwC/k0hTdBtO0lAx7KmHh7oWuqHpJWFLT3nltqongh6t
 Lhthk2UE=
X-Received: by 2002:a05:6000:430c:b0:491:83e7:32bd with SMTP id
 ffacd0b85a97d-49c72ba683cmr21840787f8f.50.1794827895115; 
 Mon, 16 Nov 2026 03:18:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb?
 ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe370f8sm19463716f8f.27.2026.11.16.03.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 03:18:13 -0800 (PST)
Message-ID: <cdb45ea7-40e0-4112-9544-c0eb1bc96523@linaro.org>
Date: Mon, 16 Nov 2026 11:18:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: rockchip: Set return code
To: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20251001-video_rockchip-v1-1-4933bdb56990@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251001-video_rockchip-v1-1-4933bdb56990@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 01/10/2025 11:37, Andrew Goodbody wrote:
> In rk_edp_start_aux_transaction the check for "AUX CH command reply
> received" returns ret as the error code but it has not been assigned a
> value so this could lead to the calling code silently ignoring the
> error. Instead return -EIO.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/video/rockchip/rk_edp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
> index 0ba68dbce3d126f8a3230435ffa0f780c1e08d61..7186abc9c6c93d05e774e61efa136bf98ff727df 100644
> --- a/drivers/video/rockchip/rk_edp.c
> +++ b/drivers/video/rockchip/rk_edp.c
> @@ -216,7 +216,7 @@ static int rk_edp_start_aux_transaction(struct rk3288_edp *regs)
>   	/* Is AUX CH command reply received? */
>   	if (rk_edp_is_aux_reply(regs)) {
>   		debug("AUX CH command reply failed!\n");
> -		return ret;
> +		return -EIO;
>   	}
>   
>   	/* Clear interrupt source for AUX CH access error */
> 
> ---
> base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
> change-id: 20251001-video_rockchip-a480d9178ae6
> 
> Best regards,

This patch has been outstanding for more than a year now. The existing 
code is clearly wrong. Is there anything that can be done to get this 
accepted?

Andrew
