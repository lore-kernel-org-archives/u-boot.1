Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4192D3DEA2
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F2E88BEF;
	Fri, 18 Oct 2024 19:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GkHA87JJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4401688C3E; Fri, 18 Oct 2024 19:26:08 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1DE88BBE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 82AD43F5AB
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729272364;
 bh=PbwTBKrxEujOS2hN2AOIuUIbJdj3Dv1mehQtFnex/58=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=GkHA87JJqLNgVoiIt12UvxPgfIU6VlirWLJ78O0oISCjMbhqW/iIfiH3FXEfJIQHx
 +5JJi0jP84vWSJn0UWEA+dnUjx8OtKWb48DijmqgfOyTHj/q6a9b9rdvTKsELJBGsd
 Rf+9aQRr6yAk8M5rg5DIdbH7YlwzgZwRxLnp2FeZrw0jrRTT5GBdUpdwZArrzp4kg8
 1RWbENJSSLKi197ohgjSWXM2v+Lj0pBmib4aYIEn9z73vwrZwOu+pOiIFwFhl/N1u2
 PMLo0cBDyx58jHSWayn9Zl7IWubqYZfoyLJEePq8eZi2gO0R+qB0x6q6+BNreiZ0gi
 qB70VukwY27Og==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42ac185e26cso17998205e9.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729272363; x=1729877163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PbwTBKrxEujOS2hN2AOIuUIbJdj3Dv1mehQtFnex/58=;
 b=TEg0yk1Qpez1osmvI95WKTjr8dFThqitBzMDnhV9TdTQ05JXXak4gTDPLG+29DjY8Z
 EzKSpTzZz4MadC4FsoBCq+7DuO8BdldrPUHUBQJSW8BMJDGqgad7ie8x8JCQHQ5Hf7dq
 dE+Z5FPfo9o3jhpRNR2MheSieSA8hBcmkcAXdfAK824b3vJ2+vnctfN+cw7LnhMlW1IB
 zqOqOyJnCdZGX0xFR4KkgZNiX5HXhBFzhpHxNH9KdjSDf2kOWWKuUGAMOPNta1y57Vc2
 glY6JxcIsBDZzMOoxKLHnM3VDcdHtVMRWRd0BavK2lgZjBGzXdUcrfDUxtAyWKL8+O0e
 YrjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb60LkjB0Tdrw5AVI0ry6opKZ2xeGsBBMdelKT2zC+f16kgHWuOtyaOaT4KbfZV6dr4p1wgjo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3qxh3yXP05E3w2WRsTOOaS4yJGo8h7WBGUYupCxY+3HR/fZPX
 DqdnQ+UcayHwhzAMz82L/tvvHSUHeVMFOqvWPKWcYR47gb1xzvbau+BYd2Y/WY6VHt01fpgghLF
 wFf8pyqGTafIPjg8T8sZdljCF129qeEZEsc2H9PZrVDk3Onz5cN2TEQwRsMIf45mO334=
X-Received: by 2002:a05:600c:35ce:b0:42c:b1ee:4b04 with SMTP id
 5b1f17b1804b1-431616974efmr25972425e9.28.1729272363542; 
 Fri, 18 Oct 2024 10:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXAMmRtPy1yX4mcP1EvxRs6DqXMXlzGK17D2XJvRqi2rgTybrQX7Ew4SwZj5jpn1SRvUyozg==
X-Received: by 2002:a05:600c:35ce:b0:42c:b1ee:4b04 with SMTP id
 5b1f17b1804b1-431616974efmr25972185e9.28.1729272363096; 
 Fri, 18 Oct 2024 10:26:03 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316068dfe8sm32244985e9.20.2024.10.18.10.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 10:26:02 -0700 (PDT)
Message-ID: <ee96c1c0-c1d5-4f18-a1eb-f6460e859683@canonical.com>
Date: Fri, 18 Oct 2024 19:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sandbox: add bootmethod EFI boot-manager
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Mark Kettenis
 <kettenis@openbsd.org>, u-boot@lists.denx.de
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-3-heinrich.schuchardt@canonical.com>
 <CAFLszTjjF1r4f6NjrYSFz36DK_X6v6rYMwDCUqiSLOPysGRC7g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTjjF1r4f6NjrYSFz36DK_X6v6rYMwDCUqiSLOPysGRC7g@mail.gmail.com>
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

On 10/18/24 19:21, Simon Glass wrote:
> Hi Heinrich,
> 
> On Thu, 17 Oct 2024 at 19:18, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The EFI boot-manager is the default method to boot EFI binaries.
>> We should be able to use it on the Sandbox.
>>
>> * Enable EFI boot-manager bootmethod on the sandbox.
>> * Adjust unit tests to reflect the additional boot method.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>> v2:
>>          no changes
>> ---
>>   arch/sandbox/dts/test.dts |  4 ++++
>>   test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
>>   2 files changed, 21 insertions(+), 11 deletions(-)
> 
> This is better, but I still see this.
> 
> => bootflow scan
>       efi_var_to_file() Cannot persist EFI variables without system partition
> 
> Please find a way to get rid of it. I can give some suggestions if you like.
> 

Would you, please, mind providing a rationale why you want this correct 
message not to be written.

I expect the sandbox to behave as any other board and provide warnings 
when they are adequate.

Best regards

Heinrich

