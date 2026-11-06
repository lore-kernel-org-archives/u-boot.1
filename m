Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB956082BCF
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FHI4CVfL;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YZBwDMke
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30A5740931;
	Fri,  6 Nov 2026 09:38:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tEQ2N9kKTl7e; Fri,  6 Nov 2026 09:38:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60AEB40920
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957915;
	b=bPvmTvrjO3ZRUs+OhhTeX13gqauAKj4ZJNIMoZlMXXWVoSUK0Zo5dW/8HuINuqr5le8K
	 D7oJrHKzvvWOOIK01scyNE/N6F/+/yKyxIBUgtY+clwbzQOEjDxqFsJUR8Ahtgtn7tdk0
	 PYSsX78wjfIRTCwC+NNDQyAxoUvYGYHt8nauL7DdbsnAscodKMi5rZlmUMntX3N+op6zQ
	 kXcQBaYmbFBNDo2vJHPKIkL6oAb5ZHxD0mWBzdXDB0VURf2DAGIZr83ccxdZLEw27NY45
	 9mRHkYLhFgGFwtNvMdbqYrbUt+wlJK7RBT/kFpk4C20DSkRzVqQLFZt/4Gk0XSWhKJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957915;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IkgVdEMvO8PcmBOMpoZ71I8RXwEqoRR/KzWaqDB8kXU=;
	b=F8hQTRPQ/g/A4Svgwn9uKpdanSTSUyUtuP9kV63mQjJt9ARrFB7puzAmh15la3ccEj5p
	 NuG+V8vndLCC/BH90HkoqJlfSoz4ofyUyJ75IfKKbZ05mNhyYqih90D65NgapSjIWS8oU
	 L2n3ETcMvp1zrBUeJMmP79iQJGFZg9V3ViUtlFLb2Cjg+o2Ux7NBj07i7FRT74FV3Pmcz
	 DsszYIAKpiPzMLiiAlhBkANvDREbC9mjZwkC722rdxPhOBPmtqx+NIdPtVUjBshGA5u21
	 aBsnbBSj6Th3mdXpmnL8p9Uq/UkYAyD77IUqORyR3IVV6dvQQZz84d5W57RcYaBw/TA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YZBwDMke;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957915;
	bh=IkgVdEMvO8PcmBOMpoZ71I8RXwEqoRR/KzWaqDB8kXU=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FHI4CVfL+UREjrdHflKB/TOg3AIsJDg7sWBqbnIbjjPt2iRTFGl1n+o0/16YFBhwW
	 WjrCi3o2/BAn6Lf8geHzUdZkWA1nMbwF+ko24A5AvfKXDI0AUwnseVdDVs5Nabb8cY
	 NK7oCCf6QTgGASJcunfuL0dqnUqL/RyK6ECu/bKPZoflq0j5CGJ5g91ZMKjHdcw6Hd
	 mj7YRf9JEjK2g+3qjNjxEn+/4RCMaTKM2N9K1jJj6IS7te1xnMtyDoGWMAfsO6//QZ
	 grVS3lnCgJBVAYObl1g9b1evZgadNSYdE2ddfPksuo3WJXQXblEYfJADDhi3mU2duy
	 hnP4crh7Hx+lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60AEB40920;
	Fri,  6 Nov 2026 09:38:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 00A6F1E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1FA440920
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:38:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qy5w8Y-ybVIF for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:38:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A925A4091F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::8;
 helo=mail-wm2-x08.google.com; envelope-from=andrew.goodbody@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YZBwDMke
Received: from mail-wm2-x08.google.com (mail-wm2-x08.google.com
 [IPv6:2a00:1450:4864:31::8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A925A4091F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:38:31 +0000 (UTC)
Received: by mail-wm2-x08.google.com with SMTP id
 5b1f17b1804b1-49e7b06acb8so1930835e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793957909; x=1794562709;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IkgVdEMvO8PcmBOMpoZ71I8RXwEqoRR/KzWaqDB8kXU=;
 b=YZBwDMke4LC/TD0lYkAHOs3mt84ToONZblAhpGtoKcQWK63hTk0Bi8Lr1Kt4p6W23w
 eM2HAQhpGBGLafYMgI2ZMTRpJ1FxoUPzbkjC/QBhwmEYjaODHniOiPGGSuX0NZIuNZUf
 cOiwFHwa6FkiIColQdD2NpUD/eg5nDr7rhuWMmI+fWoL3CXzkwkMusVj5KQ5sLhG/7w9
 kBuw7aYzJ0OLHl9ZSX+vhCh/zNNNjpZrXy2UBQUYIyiYuMkBbbqNgrxINUdgetaqQXCW
 xTiORWN6Gn9nq8Ox+zU0e94TAhVPAXj+h+zHjH4YQokt+roCEabGIKbiGuYfP4voAvC8
 WSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793957909; x=1794562709;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IkgVdEMvO8PcmBOMpoZ71I8RXwEqoRR/KzWaqDB8kXU=;
 b=YzvSTDfl/WK4ihu5AieXorgogeLwa7BZ2HR5bkTBw50YViqTCwFbxfy+BQ2QP3WwC8
 o5v7D89j3Vfkzee6XG2bNCUJO0Z9Ml3QSgYw8cLd1oceHg3mS7FW2kJJO/TYp54WXx7a
 UHA/vbfzJwPVGvunBcEiXoZ8zssr9EVbJMgou3kPb9PGAvkDPiNbWixKDWFlCH5es2w3
 0tQuVZHABvCLJnyc0op/tb0/56gbXcoZzDlLfIeRJ40FvKVNvAn1t/dwcazgGQj21afv
 tpA1qXn9XesLnCxhtpFF4fGLG1VGlvkXcRn3vqCcjwldLp6R4Do7RK9LkyUxhwS05RLG
 RAlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZmytPubC3mex5lvBwNCQQTpQXfdGcNrF9TpXIZ61SxZt4qzzQbyIRWOvan7Y0TGB0EvltB0Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9jXcK1u9D9QDc2DJXi6svG20A4a/2JKk6HfLGfoi1z4w1uFkLY
 o5JCNK5W2fNocYUfyl+1UIFtyVk9U0n+wq4Vf6UL3ilKpBNZlR+QFXFfgdPp+6XaEpBLJoJKgff
 zFzM5pGvqDT+N
X-Gm-Gg: AYBFou0R8oq8tJf8ueXXQ/OlqCc4UIBCFkOFeD4JyGTd9WJt73YcNi7/CDHcXnGGmw+
 QkUMH6d9yCg4PWcnjWhoQUojyNZgjVxvskEFUJ4EW4m67R08haB/V7+cgfSwpu7oxBxy9h3Cb+m
 +iHJIj7YLiU90J9q8QKT3Tq+F30OgKYRcl+B9iy7ooHc1MrlkySnSSHP/7xvhofr5Aijk1zd3me
 5Hjkwl4wNmtH25ggX9uaerJu5ciPXRSOWmHZihsR7m99qNbyEEzizlIfEYzkISQSPGe3V93UsiR
 eOwmnb+NGUsHMTPQ7uohweuYTaWir4lNDju4CZpPeHtzdgmVfvMqKQf4ug1vFW3KYT7NLZdT4XR
 yuXmPf8INOJb5CrYAfXmcmxOiUqhMfewHaU5yNbdq1SWUs2YzGaLHc48zMdSF30D2ROt/4Pj5na
 puA55kl9zNQpG9/u/OSddr9m0vh5gB1BXvzZvlbtpy3gv20QaWHv86d7QfwdlieRncaApCMZevM
 k6kG5+lCxBTS8eOqDsmmGA3Tk6Jv1RmiYbYgthEkuU6bRg7qBeuSuHz74r6/UWZmIC7AUAm+0qo
 xeW+IErf2jbfVMkqPXN7hzAnoMrNmiUMi5f+nHVwyrf6RFTsJZpxX8b/JgU0ZAxGHpRwvf8X5Pb
 F2GsPRzAXdOCOaH0X/1sOMvyZ6WA=
X-Received: by 2002:a05:600c:3b29:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4b6db4a5d89mr31955315e9.4.1793957909079; 
 Fri, 06 Nov 2026 01:38:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:8bde:c374:f0b7:a2ba?
 ([2a0a:ef40:e16:1f01:8bde:c374:f0b7:a2ba])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e2029278sm41117785e9.10.2026.11.06.01.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 01:38:28 -0800 (PST)
Message-ID: <2548e7ce-f6fe-47c8-8f16-ec9ac7ee3ce3@linaro.org>
Date: Fri, 6 Nov 2026 09:38:27 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Azure CI: Update to using macOS-26
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261028222745.2775066-1-trini@konsulko.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261028222745.2775066-1-trini@konsulko.com>
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

On 28/10/2026 22:27, Tom Rini wrote:
> Azure has deprecated the macOS-14 images since July 6th, 2026. Move to
> using the latest current macOS image which is 26.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   .azure-pipelines.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 556828f42fe0..fcf7aafade6e 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -1,6 +1,6 @@
>   variables:
>     ubuntu_vm: ubuntu-24.04
> -  macos_vm: macOS-14
> +  macos_vm: macOS-26
>     ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
>     # Ensure we do a shallow clone
>     Agent.Source.Git.ShallowFetchDepth: 1

This is becoming more urgent to fix.
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13733&view=results

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Andrew Goodbody <andrew.goodbody@linaro.org>
