Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27BECD3424
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 09:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B681803C6;
	Fri,  1 May 2026 11:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cdvdbMno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548F280F0E; Fri,  1 May 2026 11:18:22 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F1F80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 11:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D4BB83FBFE
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777627099;
 bh=kkJpF1Cndm8bDSdnykw5VUVEqzX3YNQU2SUdDQEoX8o=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=cdvdbMnoFYfe0ZPlxQuseADbc/Qgr/YpI5daJBdHFGp/wssmnliGB+rdq/wUuRG9t
 Sxz3HsHWfdr3S70FfkwF7PPoZz3hxDMjSqMjsEhYPiLgyJ7CwaWF1KM1eFIVgYvZ2M
 MCPA05Mf0iCb5SWPL6H9YiGMTkOuMUGKfdLgrf2+npPwhiu8KezXNm08hz2jRmJpLZ
 Xx94BwPC6gq5/z7QCMiXa/Y0uwQrUUom5roSSUvktTRB/eUsebhmEOYn4CK0QgFJht
 jiyv4Y28RIZsqCn62P/WkxmnIp+dhy9Oq1XWD8P7SxyDq52ExUOx1fjem2cDtXAnD/
 bpsJaekKD1aADQfwCi520mK5+oJQtDxhX/OKvEz+Dos7pXlA3QF5bigsHuo7SHHBln
 bpb9c4CbZOGSQTfb1HmUSsvcUYPqNJUYgDGiyOsyK1B184ZSWID+KmvMUxPBps30fD
 Yci4u7WCM64qBww9EohdCwHEa952IoKq5kQxCboO9RGM/RV2Bv95yaF+DjS0LePrWx
 9zLqYK8q70y60qpl8MqPFhSA4+iLySm5NUuIb1qLqtXB3+F9VcFKHvExJm2r0Dlbe5
 VnoJa4ltBQVY7crbqWZ7qMc+ZjOiKHsaq42n2WRphNKIn/kGwmrrJnw5BjX47dJY0S
 biU6Frd/8ee2hGjxN/1aOpnU=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43ff0eb2b2aso1344587f8f.2
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 02:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777627099; x=1778231899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kkJpF1Cndm8bDSdnykw5VUVEqzX3YNQU2SUdDQEoX8o=;
 b=oSvQ5BgWqsgXUP4Z/++fpNi8StkgH1f9WMmefnJGTg0sUMg3jjfCCBwWDIPSPlJeJg
 IprnQ7kuQHzfc3zBuyY5lnRxW8BjJZ+ftNQDu+YHS0c6bJlK1eSNpCmBUMOZvhhMUlJV
 JtV4/99VFN2hdlOVEYvYZ3pVrPciDINBDbPF/+BbtZQEAKqxIhHAbDofwL4zSvQAHo8B
 RMmta1WFx9e72oL2BC/+MK0bzhA7CqCOp7zEl7pDc0S8rRqzGYpIIIz2bXWZWowYHnku
 vO9a7CHUR97wJHVtHvw5urQQCJgvHrDnkZ8shYPWBUyxnQvzRG2aa+k0UQWGF0us6l3K
 KshQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ87AkzhOiBj1FSWwH55urEzy+foXE7Mq4sGDrEyvHhDMbsptxg28fshS/QwI9mheAYoS2u+St4=@lists.denx.de
X-Gm-Message-State: AOJu0YxZAKuaAAZSZRt+nDk0RVdvpCoPIZcc9VJOuma5yFCcLAHkr4Rx
 JQB6ZhTeDOJXjGIE9GhEALaavR/xkpgvRcTkUhXFYjolAld4Z0sawWB5NFpYc5oHyS3BexF/E1I
 XSvAK2bcIx3dbbPOk8yWLN3Bt53AYX73LirRk8E9+ATFDuvmEuzjR/AXPmu73DPRlqXojfcI=
X-Gm-Gg: AeBDieuQo6MI8gEg9hmwHOVYfmiSzuRREZGvpOdsTh90khapg/tIiBHciJBXWhB1c9U
 XLqkwaw7SQxEzFIWAV8lOoPNigTkro1uS9JtYYWBuGm4RbeXDvTLrOYy8Chpo2AX0KwnsECM5nW
 BU/TkHgOlG04TZa8mQ5zzZpVz8ORFqrWIAVzaGI5xeL3fJkT6BeJzsixrTFfz/Lq2GhJsP87dKd
 0eUppGUfA/Ohb5VVSzPsK2Hsa8Lak4JryRcA7cEL3pY5NuWotXsbenB82ov9C0fuUTke8tjjYXl
 kn5M/0rqVio1LG0msSJAxgcQCpi4ACpR7UGFN0WJJW4wcpHFVV2hnh5NsUiP+Zd0Rv8f1I+hm7T
 7DkpUNRy4ghvfF6oNAWvF/+Za9s2TB642fRmzN+B/QoQKE1nlQ+tShBWpy7mPELU+MjiIIoI/An
 ZCXb8hSNOIQLYQZA/Jgq9dTzEf7fh5lOlAwzse6WAGqnqcLKHbqlh8G8H514LRC9N6XNE=
X-Received: by 2002:a05:6000:2002:b0:43c:f66e:f24 with SMTP id
 ffacd0b85a97d-4493fa018fcmr10120546f8f.35.1777627099462; 
 Fri, 01 May 2026 02:18:19 -0700 (PDT)
X-Received: by 2002:a05:6000:2002:b0:43c:f66e:f24 with SMTP id
 ffacd0b85a97d-4493fa018fcmr10120503f8f.35.1777627099010; 
 Fri, 01 May 2026 02:18:19 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8f51bac8sm3895761f8f.16.2026.05.01.02.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:18:18 -0700 (PDT)
Message-ID: <ba82cf35-1ee2-4407-8d25-9569577c7a47@canonical.com>
Date: Fri, 1 May 2026 11:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: usage: cmd: reset: specify when the -edl option is
 available
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260428-doc-sysreset-qcom-v1-1-964df4ee79f9@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260428-doc-sysreset-qcom-v1-1-964df4ee79f9@cherry.de>
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

On 4/28/26 12:26, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The option is only available when CONFIG_SYSRESET_QCOM_PSCI is enabled,
> so let's make that explicit in the boot cmd documentation.
> 
> Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command documentation")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/usage/cmd/reset.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> index 366b17eea16..54767fea241 100644
> --- a/doc/usage/cmd/reset.rst
> +++ b/doc/usage/cmd/reset.rst
> @@ -23,7 +23,8 @@ DDR and peripherals, on some boards also resets external PMIC.
>       Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
>   
>   -edl

All available arguments need to be specified in the synopsis section.

The parameters -w and -edl are exclusive as both only work if they are 
the first argument. So maybe:

	reset [-w|-edl]


> -    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
> +    Boot to Emergency DownLoad mode on supported Qualcomm platforms and only
> +    when CONFIG_SYSRESET_QCOM_PSCI=y.

This information is incomplete. Without CONFIG_SYSRESET_CMD_RESET_ARGS=y 
the -edl argument will not be parsed. A configuration section to this 
document might be helpful.

Should we mention that a "PSCI SYSTEM_RESET2 not supported\n" message is 
shown if the platform is not supported?

Where will a user learn how he can use the emergency download mode? Can 
we add a link here? Unfortunately the EDL information seems to be 
dispersed over multiple documents in the U-Boot documentation:

doc/board/qualcomm/dragonwing.rst
doc/board/qualcomm/iq8.rst
doc/board/qualcomm/rdp.rst

Do we need a document doc/board/quallcomm/edl.rst?

Best regards

Heinrich

>   
>   Return value
>   ------------
