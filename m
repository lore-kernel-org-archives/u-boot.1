Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6571C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 16:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F1D80C69;
	Wed, 12 Feb 2025 17:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QraKXSep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318DD80C72; Wed, 12 Feb 2025 17:12:43 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DA68001F
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 17:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab7d58aa674so400044066b.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739376761; x=1739981561; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFRDDbNJU2rWQzOx4yo5lJ8LNciVnvP5eqs6RSfya0o=;
 b=QraKXSeptTmuOUk+1pJ/L2ZaRxBWrKdc/vPoCsMNg1Cl6QcbQLHgqLndzfEMYxKHeR
 rsvhCD7PbI+FIM8mXoFfbXK8HhPsKg3spS7KTECNugyKn6jLw6lCxdrRGsoQvNDK6Go5
 s1fWgJRN6Q1akIdemeD6Af5rKSRZhJGCuuNIW7Y4CjRAqHNP+/0s7lP9bEQO6nqIF+E9
 JmEbj00di/tnGOdu0TmFgLIkg7Hl5u1pv5JGowDVmkepGadB+sZ2CS1gl147PVWRTXWl
 szTZ8hbRFzr60Y5YOOkCe1wpqPLGm1u60Wy+KFkuTugVFUQ0F9FXfXciwP+oZWPDXee/
 88Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739376761; x=1739981561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFRDDbNJU2rWQzOx4yo5lJ8LNciVnvP5eqs6RSfya0o=;
 b=VEdp1FZ3LBp0Os2gcTmZd8nRRsxfq+1wKrZax+ECqSxqK36YTGzd3Cjf1PXsHV8I5G
 pqHsJet8Tarr2WdQDdw/xs/tg05WM8loksBuwxI8oDNWhwZ5gf711oSMy1dD7hK4qSct
 LdO6A9MB4GXGiuO/uNeL/Pgit+jo3o40aqhq9WI+Awiv8NCgMtBgeVbQiPN+e7+SFBkF
 If4AcxOAnHtvklporD6lPdvPMloRdkz4xpRBxaBJtqAUHJfnRHwdmRYSYPaGtieEIx02
 QssZe9fN38JsCRF1m3zq5hbDFOOb0PZ3vAJQN7M++eJ41ykXQQKyGENK5GpXPwu28R5m
 4kjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkCHk5zRQVSpg/HtJuEk4jDDV2ayxBYzhJoIsIVcKSYGA8y+SegBhp7dP/fwvOcpUc2djWtpQ=@lists.denx.de
X-Gm-Message-State: AOJu0YznYC+SLe0vLMhTPkwGDvbnhtXUJuAz6zrMTywH3HVjtpDjeJtg
 N20Dcc/HzvWH+g0yXVtGfmcFzVg/DZopx7CKQZg2VWqSb1ykPQrwBeyKnilIBDQ=
X-Gm-Gg: ASbGncsVinDmf/z0eu0YTdHTIIQ8cfvIEHb55wnk8xok2za92gGKRNXKOpiL94n5tEv
 3X6CtvkU1hrE0VyySSvdokYKRIZyEOvEZWe8O7kNBRDRJiTUdsptnRO9C8CsCDbEsK5ox1t4jI6
 rR/8tmHJcfLLkMD4rVTk5q3CDb8L8NW+gr8prUllw79ElZGpeSLrokiylH1Bv2+GguM4sYTiSKa
 ILdIkMRjVRsXlcRuHxacBKWSXuiK8RBESovvytxhvuF0QAQnRZG5fhVASJWjVxL5b8I8DzNsGGu
 gF1tB7/D8kM0UeG8u1wDu+s=
X-Google-Smtp-Source: AGHT+IH6G4rb70a0sLv8wDyo2OrDz2xh5wUhpc5nEyfjgWCbPUlMjS2Llg1Xb1vAfQFJN9MpolGPLg==
X-Received: by 2002:a17:907:2d91:b0:ab7:bfb1:99c3 with SMTP id
 a640c23a62f3a-ab7f34e713fmr386356566b.53.1739376760637; 
 Wed, 12 Feb 2025 08:12:40 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7bf5b8e6asm657536966b.16.2025.02.12.08.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:12:40 -0800 (PST)
Message-ID: <8fbb61f7-a44f-47b6-b24c-dbd8ce8f9c47@linaro.org>
Date: Wed, 12 Feb 2025 18:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Alexander Dahl <ada@thorsis.com>
Cc: dario.binacchi@amarulasolutions.com, Bin.Li@microchip.com,
 Nicolas.Ferre@microchip.com, u-boot@lists.denx.de, Mihai.Sain@microchip.com,
 Balamanikandan.Gunasundar@microchip.com
References: <20240415074547.779264-1-ada@thorsis.com>
 <20240415075755.780653-1-ada@thorsis.com>
 <20240528-among-detective-e8ad4c9b5457@thorsis.com>
 <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
 <3a3cc57c-e696-408f-a050-39502081b6f3@microchip.com>
 <20250212-untidy-rockstar-373666ce4271@thorsis.com>
 <4702c602-0c81-4153-a7a5-eccf18b58b37@linaro.org>
 <CAOf5uwnUn7QzABGqgKiBew8yAi-jZJJ9Ft8Ac3X7c8A3xrC4bw@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <CAOf5uwnUn7QzABGqgKiBew8yAi-jZJJ9Ft8Ac3X7c8A3xrC4bw@mail.gmail.com>
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



On 2/12/25 10:45, Michael Nazzareno Trimarchi wrote:
> Hi Eugen
> 
> Please apply
> 
> Michael
> 

Ok,

Applied to u-boot-at91/next

Eugen
