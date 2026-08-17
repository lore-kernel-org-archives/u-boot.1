Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F42C5DF70
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7834F40839;
	Mon, 17 Aug 2026 18:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87HoEF1Yqfcc; Mon, 17 Aug 2026 18:17:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7F154086C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990673;
	bh=RFo0gfc51SFOfFL7GnMdVFsfPa0CU7VhwBUDHAb31Xg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XxxSvUXrS9+zq+8i6xfHYPbVpiCi3X8gbjE41vKgp1TqCa9lAIt/eTy0r7JUxOkQK
	 4vPqC24PQZkapDC71vVMAmIYFY2YtUuN3/PQlB5PFvMbQbhmbp5L9mGkEcabA6C7KI
	 Yyr65Jpws/AkuDMXuaFnjWf+1EVCILVRz3LC+V2VYJse6xVq1oDB+cUXi3QqH18X6p
	 qheaTMMfINq/izUNFki8vr/MxXsiMY/HFnFqJEfvip9TjUuzG0NfB8DQv8WTrKBeeZ
	 mm24evMc0dxdHCaAB66+1GuCmZULBpppvt/P7VjQvfiDuR+xLPug6aHnOcyrYYLTU3
	 HorxJka0gK2gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7F154086C;
	Mon, 17 Aug 2026 18:17:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76E31337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68933404F5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:25:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DuJmErrbg-qF for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:25:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.221.45;
 helo=mail-wr1-f45.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 261F6404F4
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=linux.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 261F6404F4
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 261F6404F4
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:25:50 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-480001972b8so1488067f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786987549; x=1787592349;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RFo0gfc51SFOfFL7GnMdVFsfPa0CU7VhwBUDHAb31Xg=;
 b=MtDppRhTCD5FrJdRKpmg93PCBiumHOIdytVQP7v9fA1kyK4BYy3lGGuW9DN+09FIi6
 ogMxHXCgSJkFT4Fuk+D/e//FM7WfdaP03/oXkvnDif4b22G61hVpYWAXeiaDzvZf55r0
 wTVW/kwogQDDmdCwycZSsHc//NQVGkwLUirXzONVLMgcCKApVGFKErg65rQYKTNx6OBA
 fiOZhAFrz+TTBvUBo7D9bl076FhWzs9c671WBmZBzF5DinMsUiDfhTt9XqXdEAr0mAbW
 6PPg+ck4aVlQVnbAxJ3YweLvtg33KUk461SOg79m0E9A0MUaYgWghhnQT6s+UNMXNnz8
 yk9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxmQh1S0JNMdzlrJrRB6LEUl4pQK5/inr3gbEMfNScvYu8sLfu0dFer5lAjW1VmpEpkDueEyo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzX9BUfl7K0wiMh95dCbMiMehTWcsuT2qp8RDqvUu+/J/b3r7xk
 HyROQhP8gfyoEzrbhNoCTxSAcDoORPHCNvwbWuuj0jOiKFK+lyOzFT0h
X-Gm-Gg: AR+sD11AiSuT+21b2BFXhcS0dz2PwTPlfaF5SRR1byOiZ9CgMNBFGBB76BK7Q+Y2bHK
 syXXkcUzH2sJsvRMQTBPgZDO3hf5G7OpYXjRsOPeJKI/B6FYndGgl5GhiJTR1UszfHORSdAOln8
 hR2UjE58FDvKKL3Ofz3+NiE5GO72bSLywg7+F5WfNQACEYlzYd+LPsP5P/sZ5ZwxHx37f9nKqV6
 f4zwoupxsBoYt2t0FCNASK+eQhL0fGFKteoLZ4evDTAz4JLILU8P+aMJTbvpTyISZnK0oANv78V
 HK+TV/2ZcELXSo17ipcnLm2dzFQMa9viFJyRAgqGZSEeczusr2OI1ONCKlGq8+83HFaRrzyhRmD
 1YP7RkykpyVCR6DoDYfNtK7mAlG4+e2KHO9rHo+YbUBK6cU/TmYACeKtjnzZnsmVEwVgMO50y45
 UIp14mSn8JX3AXqWOlKLS4HDkCtvX9Hc6QguAuzIY5WGEqilbGEFb/qjOCSioXX3rcPoZ6j+jka
 aTGDCHlHUY1z67O0YI5FLc7/OxW+hs8
X-Received: by 2002:a05:6000:46d4:b0:481:f33d:6445 with SMTP id
 ffacd0b85a97d-482a907b955mr2168213f8f.7.1786987548797; 
 Mon, 17 Aug 2026 10:25:48 -0700 (PDT)
Received: from [192.168.1.135] ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7c55bsm5240047f8f.20.2026.08.17.10.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 10:25:48 -0700 (PDT)
Message-ID: <d2de2aa9-328b-4779-a6a2-bf2f54cca441@linux.com>
Date: Mon, 17 Aug 2026 18:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] serial: meson: add Amlogic S4 UART support
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20260806101809.72526-1-tanure@linux.com>
 <20260806101809.72526-2-tanure@linux.com>
 <tjk4ry.249pxi1g19ygb@postmarketos.org>
 <e8d19994-1236-4984-be2a-058cc317d10b@linux.com>
 <d7a85b8f6f65f7caabb45ebaff5380335030bb2f@postmarketos.org>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <d7a85b8f6f65f7caabb45ebaff5380335030bb2f@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

On 16/08/2026 18:41, Ferass El Hafidi wrote:
> (didn't mean for this to be off-list sorry about that)
> 
> On Sun, 16 Aug 2026 10:42, Lucas Tanure <tanure@linux.com mailto:tanure@l=
> inux.com > wrote:
>> On 10/08/2026 15:01, Ferass El Hafidi wrote:
>>> On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io"=C2=A0
>>> <tanure=3Dlinux.com@groups.io mailto:linux.com@groups.io > wrote:
>>>> The S4-generation UART (S4, T7, ...) derives its baud rate from the
>>>> 24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
>>>> baud rate register, while older SoCs divide the crystal by 3. Add the
>>>> "amlogic,meson-s4-uart" compatible with driver data selecting the
>>>> div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
>>>> the configuration the vendor BL2 programs on T7 hardware.
>>>>
>>>> Older SoCs keep the existing div-by-3 behaviour: Linux also uses
>>>> div-by-2 on G12A, but both modes work there and switching would risk
>>>> regressing boards that have shipped with div-by-3 for years.
>>>>
>>>> Also drain the transmitter before changing the baud rate so in-flight
>>>> characters are not garbled, as the Linux driver does.
>>>>
>>>> Assisted-by: Claude:claude-fable-5
>>> =C2=A0
>>> As I understand it, LLM-assisted patches are not welcome in U-Boot rig=
> ht
>>> now: https://lore.kernel.org/u-boot/20260515220758.GM1858239@bill-the-=
> cat/
>>> =C2=A0
>>> AFAIK there isn't an official AI policy yet, but it seems the concensu=
> s
>>> on that matter is currently "please don't". Sorry.
>>
>> Ok, I will drop this line.
>>
> 
> Please do not drop this line. I appreciate the transparency towards your
> use of AI. I would wait for someone more knowlegable about AI use
> discussions to reply.

Ok, I will reply with v2 with all comments fixes and keeping the Ai 
line. And I wait for the Ai talk.

> Best regards,
> Ferass

Thanks
Lucas
