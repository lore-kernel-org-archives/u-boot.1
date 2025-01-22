Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092B6C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E050180AE6;
	Wed, 22 Jan 2025 17:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QLuh8M3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 407E280AE4; Wed, 22 Jan 2025 17:14:19 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE5E80977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1489862166b.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562456; x=1738167256; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aqBv/C/IOHtmxYCJs7qtX0vqAuA0RF5/Ez9Mb896L9w=;
 b=QLuh8M3OGQlHfTyWHCC+SyJBQkD9DiD70YxXnxBEsZU7vsGhaprMo+Tfmt4m07EhdE
 zb/9MasZJoiragTSFYk9vF+bOkm8chklXWK1DHLHY9610YYbMc0uJyWqqeqs/+iii8/p
 +tPhYqzRofHNPZUKaaDpKo8FGoutj7N3T30PL7BpwSY+EFGSOzWyBmHnYh4rbqyrL9A6
 oDOs/b10rlkj4rPOZd5VS6LEEGlKiw56Ryjb0MQa44wCaWWlKkDuSOywxDqPshLAsP4T
 61VmpM9Mz/w4+ly4+MhyS0DZ5VSPIhhNeZgEIFjcUIu75PaFTG7oCzb/Emve1lem2Snl
 uEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562456; x=1738167256;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aqBv/C/IOHtmxYCJs7qtX0vqAuA0RF5/Ez9Mb896L9w=;
 b=FLXvI6WANmRW0ZbgxP10uygi5cYvmLUhlffY6QzNBLcDGjE7xFp0nL1z9/TIXRmoI9
 BKX5LBhmKR0OoSPShnH6Dfzg+dbUb2KRfkWAcbIvNhVzP3OkS6hvwqPcp+Sym88hsa4A
 pStjvJybcdIS/loHkDZf/Q2b4Gm5oC22Ckc7kSIkp/g8ErINmhLp6tN2o7acEwFF2n1t
 w3o2BVY2nxmDzBxwIrORFU9d6FuxJidel2iraJkLfU8hhv/4wtM/TQ+LyrHgL75qzvHh
 uIyAsaDZFpKtVkj2++u4BcxqvAOtgOYGvg2Z0bYeo/lvZBkXsxkArW5qwULx80xxMbI+
 cUWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmqsn1OAfFJvPbpgfRw9ETb2gH0XhGjWP3/Yxt0D4qdPwTXZWmuooZQe2tngT4H+jJ+pcU4kI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0YrAj4773gJksQ8eNNKBiSYt2fdMGGDJrpcNo8vxMxB8UFz6T
 7cPOaLe/SIbfFUX1ukdY9dq9oSXL7rIl0D/u5HuRCMaMUy+RZMZ2uCq1HwSIILk=
X-Gm-Gg: ASbGncu4ODeCEsaqo/+ipXgKfZzSdI2p7reekOPuuBItXzYzhQBDGRzmOXSbH3GOnwA
 75RNkxfOuGTF250b7VBDETDuTE+jkj7JfHHQ8mD5rsgOSVyLZsK7flHj742a2RljflyP60owlwH
 Uiock6vdifibmpLYq0A0026bILDTY/4PI9zG3hSBPP771IvvQIDIUyzomVg8xxh8gPbLtHa0vGN
 qbeRI3YzlMBYQSQBsaKFLjqrQKSSmHu06/dlIrzbW2xZWh1DkKFLuD7hRWEGug+rSsx7Aw/b9RL
 JzE94yOAQmyZ3xR2qRRP/3NFKUfyX+cQmrjmzH3GL970QVMMH/vy
X-Google-Smtp-Source: AGHT+IG/BAr7ola/houDc/nzciF7AtmTqgAA/0yg7Oj720oUZDxZmSE5yN4R+Dd6OMbZ+rFNHN5k5Q==
X-Received: by 2002:a17:907:9450:b0:aa6:9198:75a2 with SMTP id
 a640c23a62f3a-ab38b3787ecmr1882711466b.44.1737562456284; 
 Wed, 22 Jan 2025 08:14:16 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f23007sm940633866b.96.2025.01.22.08.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 08:14:15 -0800 (PST)
Message-ID: <a5710d64-55e4-4b9c-afd7-be0c2267ed77@linaro.org>
Date: Wed, 22 Jan 2025 17:14:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mach-snapdragon: Fix and improve /memory parsing
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Matthias Brugger <mbrugger@suse.com>,
 Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250122-qcom-parse-memory-updates-v2-0-98dfcac821d7@samcday.com>
 <173756237991.1864727.827993854575196059.b4-ty@linaro.org>
In-Reply-To: <173756237991.1864727.827993854575196059.b4-ty@linaro.org>
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



On 22/01/2025 17:12, Caleb Connolly wrote:
> 
> On Wed, 22 Jan 2025 10:26:52 +0000, Sam Day wrote:
>> The first commit in this series is a fix for qcom_parse_memory, which is
>> currently broken on master (since fc37a73e6679). It's an alternative to
>> the patch Caleb proposed a couple of days ago
>> (20250117102734.3725009-2-caleb.connolly@linaro.org). This approach
>> results in a smaller diff, and also makes it possible to do the thing
>> introduced in the second commit.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] mach-snapdragon: pass fdt to qcom_parse_memory
>       https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/782641f872a4
> [2/2] mach-snapdragon: support parsing memory info from external FDT
>       (no commit info)

yeah that second commit isn't applied, need to figure out the (subset)
magic...
> 
> Best regards,

-- 
// Caleb (they/them)

