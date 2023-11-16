Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FFCC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 20:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE4C87454;
	Thu, 16 Nov 2023 21:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rOFMEiJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD50586EEE; Thu, 16 Nov 2023 21:04:40 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3096386EEE
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 21:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 507093F87A
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 20:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700165070;
 bh=LJUJ0veYST+qDDJzusFDt22WhGiXAJsO3o8ORN0K0uQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=rOFMEiJbYFJlEt87ms75gRRMUKnXvRpVzaweQ+UsjqSZUttFPrjFxSKRqi0KhvXIn
 nH3sNs3I1rEpAZ3Mj4A0FzjDRpWxpYkOlgpbsFt9cK6TEohXtUsMLzel1sPYRsP+Md
 FekRcf4phHc4A4+92Gs4rkdHLHA9OzhRTQKn6/6TnKVsD1FOlPtCbA7ULK6zy8QWh/
 AnDofUeAS7LgKtCvQa2zHNm4xK1DWtSNNf2UdCyDV4Dc6da+q1rH/ozSF/IdyPH7sK
 kyW7Q5a0Ly/8OTsNdJEny+PnJBeGLgSkjRhtm4YuofvEpqlbSbsZbgkso4t0ux2kCc
 RKoqSdBBRjKZA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-408f9e9e9b0so7112435e9.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 12:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700165070; x=1700769870;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LJUJ0veYST+qDDJzusFDt22WhGiXAJsO3o8ORN0K0uQ=;
 b=pF3omT7eIxwIEUZnYi+TDkf6kWcjhAUTIanveDE7xMtc/L6JeC4+ud0veggQM5Zc+7
 Qw3wnVpa87UIdUI53F8eTxxWPHYGCZ8fhzcJCFduWVP00RQpoFymWYDFldykoiJf3Ugj
 ejz5qMBLPqzidowy5nlbAQX8bxKJcPd/o+el9tlKho3qjkS0QHByclWJNk9LFF4VBS4O
 M1Fr1fl0RLO97dKERyWmAwtmBq0pIwCQnRATWq6PRfQl85PS7L7rkNZLpKQMAkD6p4uU
 GZmqiFLATAujXzV+vlAsK81H5CuSXFAWLcM7HGjiIIlKDHGi/b1lzJxXfY7rmJi/ev54
 c55Q==
X-Gm-Message-State: AOJu0YytA315meXc2OpMrdS/ZKA1wLQmmo84GBa/OJOKfXBXX2evW6Qt
 LQ51L6nro46iqweWn7sVyvtOQ2m86KJfaH8B6alZG/Uzmtrgrn35feKBsV5pFQ4AXFmDjE3suEU
 zBJLfMuxr2TEQgV38laPaeSFmS0HjTMwv7BnvKOQ=
X-Received: by 2002:adf:f40f:0:b0:319:67ac:4191 with SMTP id
 g15-20020adff40f000000b0031967ac4191mr11088290wro.37.1700165069923; 
 Thu, 16 Nov 2023 12:04:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtMTWP47cYcqi+QCoibb1PdyOhRJ8uwvo2ouFEDMgX/Q549D0M3T3pqX1QTmPv9OO7tllsvA==
X-Received: by 2002:adf:f40f:0:b0:319:67ac:4191 with SMTP id
 g15-20020adff40f000000b0031967ac4191mr11088271wro.37.1700165069518; 
 Thu, 16 Nov 2023 12:04:29 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 h1-20020a05600004c100b00318147fd2d3sm276004wri.41.2023.11.16.12.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 12:04:29 -0800 (PST)
Message-ID: <5eef4f1d-106d-4a74-bc9b-4929fc96294b@canonical.com>
Date: Thu, 16 Nov 2023 21:04:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] configs: defconfig for QEMU RISC-V with ACPI
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
 <20231115142355.123038-7-heinrich.schuchardt@canonical.com>
 <20231116183703.GD170968@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231116183703.GD170968@bill-the-cat>
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

On 11/16/23 19:37, Tom Rini wrote:
> On Wed, Nov 15, 2023 at 03:23:55PM +0100, Heinrich Schuchardt wrote:
> 
>> Provide a defconfig for testing ACPI on RISC-V.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   board/emulation/qemu-riscv/MAINTAINERS    |  1 +
>>   configs/qemu-riscv64_acpi_smode_defconfig | 27 +++++++++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>   create mode 100644 configs/qemu-riscv64_acpi_smode_defconfig
> 
> This feels like a case where we should start using fragments rather than
> a cp'd defconfig.
> 

Do our CI scripts support Kconfig fragments?

Best regards

Heinrich
