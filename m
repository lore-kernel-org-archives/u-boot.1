Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AF3D33998
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 17:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DDD683FE1;
	Fri,  5 Dec 2025 18:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wf8kO+ZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB0D8423E; Fri,  5 Dec 2025 18:35:22 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17BBB839E2
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 18:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42e2ce8681eso1710276f8f.0
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764956118; x=1765560918; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MfFZrFWM46H2WZFZn1lH3py4HGPhkIhVWr07BMXO5h0=;
 b=wf8kO+ZCU60yKeRRzIessuH79hrHZS2wV62f0Qlv+7+CfcMujib2PNBi66jvUTj7Y0
 iWow6oiQTcN75kcBedIFr+avU3KEUgqjQ4m/S1PLIJf7tlpMhImm4KtXsuEgNvanv6Gh
 3is1tAfL8VHplxkNKQUQL4mQTSBZdxzuGm5S4stJv0ntPfBTxD/BrzcvI7heH/A7cunA
 6MSNxzZQaGk3amxKAq3UsTLnC0aHhIvDsBKo7aq+YgSTblgygkZt0NuSjHFk7wOUJjeB
 vYQNOTEed8kk8xt24CgNMIKmbRUV9SUjIYkaZgRSufh0yHytx0WcFyqV2+VxFHQROqnd
 UfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764956118; x=1765560918;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MfFZrFWM46H2WZFZn1lH3py4HGPhkIhVWr07BMXO5h0=;
 b=WCQC0Pxq+3mt1EJQ9L266xsfvDvP3rTje3Z1CRVOwGpkGOZmLchcNNV/xSLYdAKQ91
 VpUkrGB2SPhcXq1MmwIo76xymJpSCG64lBAFfslQgeIM7LNFw5Ak1zRZyNjc2ibw2udV
 sR7rXOPAEmm05LAvkOcxqJ3TAnP3j7JBevIAOkopvueAXJlTl7tNHGVMENFFR6rx7QmF
 7gRAFtLChxblBZuteW0sL3/Jn6T6sH6rH9tlsG9mN4XLfMv5Zx1toX8X73DgJtkpq+2b
 aWmhzcx/OzJ2JH+pF8PNX6NGO7Ewt6f+qIAOQx+UIwDeTKTo+7aTh/m9Trr5Txc/zJf3
 XwjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6c+sQNjQIHeJoLjg9kBlPbA3ol7stRnU+tEQtaQeQKcVeoKaS0ipSGMOAlivlaTNsJw/cL6s=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8gpU90JZVgd6DKFyHCbOeUkWdy7/WwIACKX6C6fX82MqbqTG+
 WUxDQEC+WS1pcOpkFq2wK0rMCnZb+oVa6mUYgCpPqYnMsXWsH9B7z0CpmMFe8kYckCc=
X-Gm-Gg: ASbGncs06CA1xOiwwKM3lQ6Cf0X6OQJAsd8ZRpeMDTBDXkTTmG5GuXPyndJWivTbCja
 egicVIbwwoHzuQ847gNRbGbsVyj5d4Mfs+JazqT8PpequpqDZzyAUApIIaI4fvwFVo21SZ700mP
 1RFcDcRGCFgzFo+C9djk6guPQU502LLv0ow7qoeSJQ0+MJHo5mWJ6k7SBNml6AyW17MBzmF61Mq
 yfvvWxBPgWpRsOoNNXHvvSpVWbTVDTIm1JUntg0QAMi9FWKVE+NYVdHmFAuLhRoTFi9YVzOkkGa
 BcUCnn0Jbbu4wr6xpKNmMeLvV4bS5PsdFrk0a2gRCNUbjEeZfEAwpt4im2AveLy1aElfuVc2l1V
 Qptu/CTsHv0sjPx3cOXqF/U/aYra+hlbjMhY0Xb5SOworm+ynM80+YNTIvt8iu7hQDAGDqKU532
 rjf3DhbxmT8tmaM1D84sotV0BVOjNaveeio2ll1eLdUrEQ3gDK6ykoKjpMgAWrE7pDTQu/T3teQ
 gMn
X-Google-Smtp-Source: AGHT+IFpnc0NIL9WyndnKZb/4csA2n01eb5vcZu6ef6GBvA5Ti+TgGWgAW7RT/LRHvrU69sbaV/XWw==
X-Received: by 2002:a05:6000:40e0:b0:42b:3d9d:c605 with SMTP id
 ffacd0b85a97d-42f731c8442mr11729595f8f.49.1764956118488; 
 Fri, 05 Dec 2025 09:35:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:e36c:4236:70ac:25c6?
 ([2a01:e0a:3cb:7bb0:e36c:4236:70ac:25c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331a4fsm10132626f8f.33.2025.12.05.09.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 09:35:18 -0800 (PST)
Message-ID: <220ff684-a889-4503-9d39-d694e0ce051a@linaro.org>
Date: Fri, 5 Dec 2025 18:35:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net:lwip: Add debug line to net-lwip
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Martyn Welch <martyn.welch@collabora.com>
References: <20251205-lwip_dbg-v1-1-f3406179c0b7@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251205-lwip_dbg-v1-1-f3406179c0b7@linaro.org>
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

Hi Andrew,

On 12/5/25 10:46, Andrew Goodbody wrote:
> When debugging the LWIP NFS implementation this debug line helped to
> show the cause of an error. This could be useful to someone in the
> future.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  net/lwip/net-lwip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 8741f65fe12e23cc30068506453a762533f8a67f..f70857204b2808139ac3ccacd89d5719b7db12d2 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -297,6 +297,7 @@ static struct pbuf *alloc_pbuf_and_copy(uchar *data, int len)
>  	/* We allocate a pbuf chain of pbufs from the pool. */
>  	p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
>  	if (!p) {
> +		debug("Failed to allocate pbuf !!!!!\n");

The exclamations are a bit too much ;-) I might remove them when
picking up this patch. That being said:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

>  		LINK_STATS_INC(link.memerr);
>  		LINK_STATS_INC(link.drop);
>  		return NULL;
> 
> ---
> base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
> change-id: 20251205-lwip_dbg-243f89da0aa8
> 
> Best regards,

Thanks,
-- 
Jerome
