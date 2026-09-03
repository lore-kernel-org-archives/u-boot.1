Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7362C624D7
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 10:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55468810A6;
	Thu,  3 Sep 2026 10:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EWmtfIKbRfhx; Thu,  3 Sep 2026 10:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5E5258107D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788433123;
	b=b1nV0GTDeUVGnKQnDk07OfeqwdJzTednLZwjjSE/63qFROtoTIx7QDlkyyzjE0jhArRG
	 PhS+bxN/pco2rTmi4D84UzW3V/lKdy4n2evtyQyILfPtkfL1cCEITMLDfldDnYd+hsnzX
	 RITUutzrRmwm03pTArt9FKEOwgLF8ZF9SnKywNRvX8m6jD9tBA55Jban5aSBZhSw2CYhS
	 CH3ZfM7jAHPlM2ZwqQ5IOny1P23OI3vnIGteLpY2sa71Wl4SovmW2i8dRECQ2TmoRoJ1F
	 oCFx1kmZyzR7I2uwUWNOxVF06TlKCkqMpHFaSmJgjK0zC3fS70iXPUHNXqwDjDnvLKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788433123;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NFxKnyZW12zEzkbdf+q45JY58E31kz74uF1nsWonndI=;
	b=OPGnZhqr2O4PxXtc4oNtBoi7xml12Yit54mmwYvMmKnlsV03PNYfNGzdX0yxC8bx3XN6
	 Z1GbeIYcOzq+yMU5B9CjM3Nyw+uZVZEJbdYkyAHsKLjzspua1PKLyPxDzuWJLT/qfog2O
	 4Nl50038B+QSz6riofX2GfIBs1eR3q97oX5+EbyF8DUqy8XjNINDL6cq5Q7AwfNGw++5p
	 0IWNM1gghhhPSWQLME0jU/Szq7adAQL+Yt1k3PCIcDoBdZnPp5aE0LFd4NIyVozwKyiaM
	 958Ddnabh6q4D5CE4gaAzZR6xOlRn4fj0T4ZZNanhE37KvCSg+J0uJbwZREU0qzzEag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788433123;
	bh=NFxKnyZW12zEzkbdf+q45JY58E31kz74uF1nsWonndI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DpmpjC9Es5issFSqzn6steVoGnyFBP8F92Ri16u8YPEsVDhfqyrHfDTmJJuk4EVaX
	 TcFcvGeRTXJfiTYPsv8M/0M8GwLuIyDo2EYhE+VAPHpBBI59FpeVmG33osSwm+se34
	 f+/Xw4KN5n/0kHUhjpq+MiB8goli4FH7Q3rC5wUatXExmNX3CidfZyWLo9q7Ml/CKa
	 +RPUqU4KHtVz68FHjljSsFgeL8ikuNiD0IelN0tGP8JRoEuixl9jsBLpp0QqjQmMrw
	 wOiycbzRZdt8yINDG/r2CWHEIgdD4YeT2pxt/KLvHYr7Bm7DAjWuag/WpHFe1YLIMv
	 3CfYKcqeokcgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E5258107D;
	Thu,  3 Sep 2026 10:58:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01A66230
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 10:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F249840A92
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 10:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3TqzKTPDn9Tc for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 10:58:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9B57940A8F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788433121;
 b=NVGFBvF+0tJ+QAo6PwBtI1MGh77r8aokD5naqlAKweRsx7Axj+bewSlwkmYsLOf+lqFO
 nA5TG0OtSXJWasGDsrGYrCSC2ijfwI41jnH5UszsEirkYCj1zbYg+Kdf3spyEswTySMPp
 lULYvfleNtzhJPGE43Tf8CckGof+2QXzwG5ZcCbyYEp8wJ3Grmuk9f0shE849SD6gm2nN
 559qTGdW5pl+nujv8SEAnJEc9sIrMEo7uUBkHvM4CtBvZo5aVQxZMutydnBHH1bqG1s8J
 5nvOpfkoUqnbSxYIyBFsNQX1UZAiHazpiB7rpBBl/tbq3Fk0OSwBWoSselbskX8lAMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788433121;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=NFxKnyZW12zEzkbdf+q45JY58E31kz74uF1nsWonndI=;
 b=NuL2zNY6ogOvt0foE+BCItTXx36m2tAgN2I9dB7E6MZCAx7Q1VG+AIbU3YR+rHx/gy7N
 ADPV/s1paPf8ncjcPYlr9fsM34x7h8EkHLXYSMKPkJO6f8/7rksdwZIYQk+q452Ld2xgj
 cTJK0xQxJ0ARCbZdhytTtbFO7JCQfm237vBOstHeyUuqpKJJ6xbYV9pf/bbdoUSUwqHvI
 wNurkGzGGXiOK34pUUFHHCMuPDZ7tb4Hrq+CgPfoHS3L41WjH+UYwklWqaucXewXy8fBA
 2EPdbGJQW2AXUZnsvH3DGPSHWM+P7GpIxt3bwSkkW2utEve+ZYWMzeh6jGKInc6ERRQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DmUndF03; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DmUndF03
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B57940A8F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 10:58:39 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-495590dde14so24582225e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788433118; x=1789037918;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NFxKnyZW12zEzkbdf+q45JY58E31kz74uF1nsWonndI=;
 b=DmUndF03mQhz/VR+Fo42ZsmmeBkxL9zmHP/kApErVogAhl1VvRU9RMnfhxC8txnn9e
 P4tvO/lMzFmnkU2lu+lIdpOFWyY6pfH1llGPMI0ntcy1wD0Qf1Px96gs60kHMPPkdZmt
 3PexCjwmKkjJWoDZOGlxQJ3x5NTNNxD/w5eI4mbpoy4ucfTxsfNmyfE5V0XhKMthdzxi
 zvkQzn/9fh3sxxWvWZEKxVKgiaTXczNTCoREww9aO6kkPqyeED0BQEy/0po09oQyodg9
 OgPdq/cL0BHQEcKEKjGgPbaIQNhhiAPi4M6C0/Vn6ic9gx5UYA98z5mfqv2W8e9HjR1C
 WRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788433118; x=1789037918;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NFxKnyZW12zEzkbdf+q45JY58E31kz74uF1nsWonndI=;
 b=kT636UdfCN7qW++/yTpojI1Dn/7nK4QwW5fEyDaiartN653RYFAKAKNGInTJbO5osz
 xztcSanaF4MijBBTMAxnDUquywEhwgeVe4rHJ3fMDujuNEAQDx74HU3+XaoajR4Pm96/
 v3QFU7t6Gh9VvrTgdllWI4Hv4jrvp95TyMYhlRbOhZMEJz2xU24MVKN2eTzT3QmIk+w0
 2Z4YfqhCl2CEEJuuraOX5FMde+i4IM9c1qqtwAKRPbDluBgmZZYVX5SeGINrtZ4oKhuH
 yyWoNCvEnFSs+UcyeBSsEYdWE+JvYPqsOQkyQixS9u3qssTrJzzCQxEAdGYmjR2if0sX
 M6qA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQyI24E9pbpNbK2WVO2BqTt6IbU/Y5GbMJxczk3B8EkMliwHwzDOAYNU8aT2U+hN6s8YWCjEc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mxKGKYQHzQXOv/n94ZpZQhhTUdCxvWdDRZT1LQcZUevvXAj7jc
 1cIQobF6ELzvNiAEAjE9scDVjQ3w3mOe6PftVx80TM0RZJwyjqzpCPYixwyUq4Wu9BunmHxWRkL
 ldscC
X-Gm-Gg: AYBFou2qBbyVQvPGoM1IJQv1/8Lf5D42tFL4Ycr7wHnTC6jz9OJCx9IZ4uX+n5O+7KG
 QnoWzs+0IpAtsXbozru9/DZV+n7Wfh8iqPDwZBVUMtyOvcc7tWrs6e+hCfW5L5vhgaPaRfTJ2hy
 LRNxETlxV5SaYi+quLcLylHkBQqElxukBpaqXg9QyLJGqAcr54cPbcK7xv1oV/XT4QUkSGWkpXD
 rLdWdbT6yed/TOmQZwVM/SYo4AIQS3TG5HRffyCOgPMKEowHXDa7i9DrUitieUu4afKKuTcSwEi
 3TfdVQVxKPH5hxucctFjLej0fgqhKeBn6MnALLvBbbU+g74msWsaiNfv9GS0ZyNVQ/WLvp77prD
 sIO7hZZFbeJPlqBGneESMbDh1XgjWhHEoW/GHPg1+o+ddQkN1qw2JE4hfQOuQJdZskQmNrAbnVU
 Jgyt+GeZE0cjCtYgpW72bdc5N+jDYGtokPItOVO0CehNPAT3M2jR2ic0v//y3clOP/m9WFqH1Sp
 4eqRfXXJVoDdgqTQvHvwqj9Qw==
X-Received: by 2002:a05:600c:4e0a:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49cee20e7admr110004875e9.1.1788433117541; 
 Thu, 03 Sep 2026 03:58:37 -0700 (PDT)
Received: from [192.168.1.37] (p549d4d01.dip0.t-ipconnect.de. [84.157.77.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm60433685e9.15.2026.09.03.03.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:58:35 -0700 (PDT)
Message-ID: <0ae552d4-2708-4e8b-8607-bf5e67c1ad8c@linaro.org>
Date: Thu, 3 Sep 2026 12:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: skip serial# env set if already present
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>
References: <20260903-snapdragon-serialno-write-once-v1-1-887c200f7b14@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
Content-Language: en-US
In-Reply-To: <20260903-snapdragon-serialno-write-once-v1-1-887c200f7b14@oss.qualcomm.com>
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



On 03/09/2026 07:20, Balaji Selvanathan wrote:
> serial# is flagged write-once (ENV_FLAGS_VARACCESS_PREVENT_OVERWR), so
> setting it again after it has been loaded from a saved environment
> gives following unnecessary error logs, which can be avoided.
> 
>   ## Error: Can't overwrite "serial#"
>   ## Error inserting "serial#" variable, errno=1
> 
> Return early from qcom_set_serialno() if serial# is already set.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> This patch depends on https://git.u-boot-project.org/u-boot/u-boot/-/commit/7c957182640da775ae6dd7a9456b6a6a8532c4ed mmerged in u-boot/next.
> ---
>  arch/arm/mach-snapdragon/board.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 80bf510d31f..e8653460707 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -208,6 +208,9 @@ void qcom_set_serialno(void)
>  	const char *cmdline;
>  	char serial[32];
>  
> +	if (env_get("serial#"))
> +		return;
> +
>  	if (!qcom_socinfo_init())
>  		return;
>  
> 
> ---
> base-commit: b55d2b12d3a88d003a9911adc8d96e4921f67ad1
> change-id: 20260902-snapdragon-serialno-write-once-7c7c3cc3863d
> 
> Best regards,

-- 
// Casey (she/her)

