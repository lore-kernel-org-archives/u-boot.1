Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CFACD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 20:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 362D684BB7;
	Thu,  7 May 2026 22:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yLE3x57G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDA484BD5; Thu,  7 May 2026 22:05:51 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA4284B58
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 22:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso12434095e9.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778184349; x=1778789149; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JJKECZPO9XBcje6sWMkAemgjoH/OVGGIRZdM57IDuNI=;
 b=yLE3x57G8nKN/RNSBTVHWgKTlcXvJ9hpAOOVX/d6BLN1EEZHkEE6MezKZFAqtOi2bi
 UvaT/I47D0lBuCSKlk+FSuhVMqDEx25y7K1tC35VXATNFXiJ3qnARzvXPDmOScuX7073
 V8f7vJT30JAnWdWlpRuzp1bKhkiiaw0/i1aRYmvExdhZmGV6nqGDspiymGM9vMaG2pAe
 OTl5ypyRu2wf18NVhMFtC9D9CWq1xwglwSinzXa4Mtc/lJ+2dFxjLH8HNu3yMl02K8/z
 Sfj2SBmOuHfJHIPF1xyoDNrl8KnMCcOQVrRx2bSlMnD1Uv9aWCcpyHEfHhJB8Snw+Vbi
 vzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778184349; x=1778789149;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJKECZPO9XBcje6sWMkAemgjoH/OVGGIRZdM57IDuNI=;
 b=GIiEApduybThTrDnrteiGCSh7/KHqIOce2MYuMNpS9g4m2iBIXfXu2PpkuLpH5ZAV/
 1MRUAoE+DLjfBFUUbhHx5KWTI6MsoQkxihs5+KYOvQxS7sP7GANzZ8NmmiMVK3+srNnj
 aAFWIZykwLy15JucQ5evukHpeN0s7ouWE1DwZlS+glQPT0vALo6CdelgacJ/S9brtHQ+
 1AyFgDJ3YUU9inemMne24u6KyrCuTJVQ7Q1nZEdjw8b6QPIpVpDinikZ01w6SJT/TRSs
 egW0VIKHvRbGOot7jjTtC4yMrLDE754FPPUVLd2ypkf2WkRGYyhsKAYivOsnIirXuaaC
 PaMA==
X-Gm-Message-State: AOJu0Yx+M3+QD4ZGWrbse4di2XsCzqumY2Jx/woa9dPK5IxuEsm4AUi9
 uvkKlf7Gg1sYY8yZIldXBsb++uyOr5KK8o0rCX47d+v3c9cgriaS0Fqfw3X5ahwgWcc=
X-Gm-Gg: AeBDies9X4IMT11UFJ5EVRX6tkhXSqO8/WwUrAUuZX268+KHQbmjLz5kxjnuz9qGva6
 oH6sf8eyWrONQLWej3Nsy/z5V1/+qGoKDa4O2eIGDAClH0spsXYP8MBDC0AsALhVaWNY0W80/El
 Gr+J5RONw/SR6S2iuS3RcVFiU0VDFCOblLIHIavvOaNjwlkR6QBma57TzqiJ72cSTLDTaMNuu3W
 amuTV5KfpRTeUDNmnfuuErSmwMR7j4SD5FUqxwTDDJ/OYQDHeEbxuvLYj+Xl7ICkqiQ7vyecbQB
 tZXyr8tzrwIo64SjHeZwIVoFBNanltSwqxQRseAErLiPiOebk8xqZZTgXZkdVCSZyJuMdikPjfx
 W1fWinAP/cPau6EHWFbfkIT0nVWTq27dtydfniUHRrKiwtUff0snudOGl9YYA71kmRSuXyAEYiW
 tUAYkXVtWgUJujijJTWoJSedUFalH711FeWlGhh+L1C2LZUwqYgh6jaLGNtOY1SQveLQyjsTXHu
 ptc
X-Received: by 2002:a05:600c:1393:b0:48e:635a:18d9 with SMTP id
 5b1f17b1804b1-48e635a1ae9mr25395935e9.15.1778184348889; 
 Thu, 07 May 2026 13:05:48 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538b26a3sm260800935e9.9.2026.05.07.13.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 13:05:48 -0700 (PDT)
Message-ID: <238269ef-d3bb-458a-bde9-40506df61936@linaro.org>
Date: Thu, 7 May 2026 22:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] Revert "dm: SMEM (Shared memory) uclass"
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-1-c01ec2ff3886@linaro.org>
 <CAFLszTgwbSxN5tEZ7ShgaAi1JvGfT-ntPdeJ1q8rd2GcOeaFeQ@mail.gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAFLszTgwbSxN5tEZ7ShgaAi1JvGfT-ntPdeJ1q8rd2GcOeaFeQ@mail.gmail.com>
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



On 07/05/2026 17:31, Simon Glass wrote:
> Hi Casey,
> 
> On Mon, 4 May 2026 at 12:57, Casey Connolly <casey.connolly@linaro.org> wrote:
>>
>> SMEM is a highly Qualcomm specific interface, while having a dedicated
>> UCLASS for it offers a nice abstraction, for things like memory layout
>> parsing we need to use it before the driver model is available.
> 
> Do you mean before or after relocation?

Before, we actually use it and read the memory map in
board_fdt_blob_setup() since we support the usecase where you chainload
U-Boot from ABL but with its own DTB baked in. This allows you to leave
the original Android DTB and read the memory map from it while using a
proper DTB for U-Boot without having to hardcode the memory map.

Basically it exists because some Android phones have awful bootloaders
that will crash or break stuff if you don't have very specific arbitrary
things in your devicetree.

> 
>>
>> Therefore, it doesn't make sense to fit SMEM into the driver model.
>> Instead let's adopt a model closer to Linux, and parse SMEM really early
>> during boot (as soon as we have the FDT).
>>
>> This reverts commit 7b384eccc785b596f68448b155cbda26df57fb23.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  arch/arm/Kconfig           |  1 -
>>  drivers/Kconfig            |  2 --
>>  drivers/Makefile           |  1 -
>>  drivers/smem/Kconfig       | 25 -------------
>>  drivers/smem/Makefile      |  7 ----
>>  drivers/smem/smem-uclass.c | 46 ------------------------
>>  include/dm/uclass-id.h     |  1 -
>>  include/smem.h             | 90 ----------------------------------------------
>>  8 files changed, 173 deletions(-)
> 
> [..]
> 
> Regards,
> Simon

-- 
// Casey (she/her)

