Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30027CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 12:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6CAE83EF9;
	Wed,  3 Jun 2026 14:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WMtk8F19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B5983FF5; Wed,  3 Jun 2026 14:58:38 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F19C8341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 14:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so128099625e9.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780491514; x=1781096314; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2sIY8hfRvYlmlUEdOYGjSZ9ybRr4rUVGFtVhVyr6wes=;
 b=WMtk8F19dM+UwPL1m+YzFqbiwVYwkYkI5nrP+dQzTMPNbsCEBJmrVnsnHDy1fBzm0o
 Ed2voqiO2yhbobQ/f78kdx0GIamKc5MP9GVGgjuaLWxlFhkb6cD+EeYXlcgdJjFVHm12
 DDlpGzK9TY0/leX9OFCJVgWkrS1kS4aHoAOuqkGH6rOTq5O3fr2bpKkdGYcFXfPNhU//
 3BWGCeHanh/9qx08BPkxxFvMWbIY7tIULw1pN6yGQRbOjEYKQIOUrfM+XlblTDNOaSDu
 zNQ9WZFNX7c88wGe1xlr9xW9eIAa+ULfASBhwXJ4DV9RIZEHNmPqBuHUAQc8Gn/FVpli
 Q4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780491514; x=1781096314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2sIY8hfRvYlmlUEdOYGjSZ9ybRr4rUVGFtVhVyr6wes=;
 b=IEWPh+HChu9fBUhBQ11d20UOcMsI4JhNPvG13Wk55NE/Sb+q6MiJ331CgLkZQg4jbO
 DvnCRvsXMGSD+XNrLTT0a93jknn4I2uwZUQc9Y1dIQZ55Xt8N6rBD9Az54XKKjG7MCIp
 3rSc6089G04pwX7C9YCHu1a0FClJT6968cCmXVruhpyJCX/lABoKcplT1aJvr2L3w0nh
 KqK309tusJqVj55G29sd5N+S7C9b9H+xIa7AK9F2nxfEBCNup7zrC8+UW6zFBVJryewW
 Po/SceaPPTHehNIItkPyYdFaTqa0wQKT0iOwOdPedBAbowhbAN/6bHVeqmA17ZCK/OsD
 ipUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+P+QbgLHSpTBrA+iijpBeE7xhUk5bUvN83w+l/nTw6z7UBAN91tFWGeiwVvyWKiBBx4mHlyPs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1K0SleJTT1LxUVBvTkNJSsqhPHyy5FWpN/HtMR9LTCFnprQ6k
 7KZ9zQsdDaSuIwtVsSsZauWgtgtW7HYBsTCpwkAnrFIOMm4YCPzawS3DmU7DUXw0uH4=
X-Gm-Gg: Acq92OF2CrNs97akOSUi7yMHeUSYywcQrstBD1r+0nrN/jSgVGd3viydj2qLlrJoN0L
 6SSrauGZCSlZfucqDezcfmYe1jtfCCOJF+5OnFVc5cAWrg7cKYX/ySAFtgNdmyTC2n8iHANj9Pp
 MG6iNJ95XpkpU1gTQwMqAOezb7lk8/sYCgDfFFEch9GaenG/nuTsyD50qxCO7zHL9V542Nr3Sri
 DE/8/xzr9cvNQee53URDpeJQldQbfMdj8X71f9dTHByXzq5c0y7Gkl9fgWfkLbt5u5vUj7qxg6N
 muaSB2PDydSOWC0G5eVqSO1l4+FC1JBOT6rk8H+XVW7RCbTDntFgHejfWFbv3tpslwawjmbYOkH
 /CWSbZzhaCCFybHCE/4Q3UJMuRQ1+tU4Cv+6ahs7ECSCW5XzXdQFtTI40vYdDFDlIBW88ErMIDp
 Tf8y16JeK9aohZ1YPI5UQ4bP+iUuem6CwQjj+1wAa6RqsQnC+ZP0SrrJxZyOcVH6w/WI6xn+uni
 B1G8p2VWH7o
X-Received: by 2002:a05:600c:314e:b0:490:45bb:8dd9 with SMTP id
 5b1f17b1804b1-490b5d2f857mr60006105e9.8.1780491514219; 
 Wed, 03 Jun 2026 05:58:34 -0700 (PDT)
Received: from [172.18.178.88] (ip-185-104-138-128.ptr.icomera.net.
 [185.104.138.128]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b63d810dsm67472655e9.9.2026.06.03.05.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 05:58:33 -0700 (PDT)
Message-ID: <bf90dff6-0570-4ffe-a076-ddc4c2140e0a@linaro.org>
Date: Wed, 3 Jun 2026 14:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: ipq5424-rdp466: add chosen node for serial
 console
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 trini@konsulko.com, quic_varada@quicinc.com, u-boot@lists.denx.de
References: <20260603113853.3396271-1-gurumoorthy.santhakumar@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260603113853.3396271-1-gurumoorthy.santhakumar@oss.qualcomm.com>
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

Hi Gurumoorthy,

On 6/3/26 13:38, Gurumoorthy Santhakumar wrote:
> Add a /chosen node with stdout-path pointing to serial0 (uart1) to
> enable the DT-driven console discovery path in
> serial_find_console_or_panic().
> 
> Without this node, the live DT path in serial_find_console_or_panic()
> is skipped and the fallback path is used. Adding the /chosen node makes
> the console selection explicit and deterministic, ensuring the correct
> serial device is always selected as the console.

Please submit this fix upstream! I can pick it here until the next sync 
but I'd like it to at least be on the kernel list.
> 
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
> ---
> Changes in v2:
> - Replaced the DM_FLAG_PRE_RELOC approach (v1) with adding a /chosen
>    node in the board-specific U-Boot DTSI overlay, as suggested by
>    Casey Connolly. This is the standard DT mechanism for specifying
>    the console device and avoids modifying driver flags.

wanna turn down the verbosity of your LLM?

Kind regards,

> 
> Link: https://lore.kernel.org/u-boot/20260524050328.414639-1-gurumoorthy.snthakumar@oss.qualcomm.com/
> ---
> ---
>   arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> index 9e4af4d9f72..36640f31d61 100644
> --- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> +++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> @@ -12,6 +12,9 @@
>   		reg = <0x0 0x80000000 0x0 0x20000000>;
>   	};
>   
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>   
>   	&sdhc {

