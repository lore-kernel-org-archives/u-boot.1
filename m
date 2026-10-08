Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67843CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 07:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B362607CB;
	Thu,  8 Oct 2026 07:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KgiFVrk1jhmS; Thu,  8 Oct 2026 07:49:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 359DA6078A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791445782;
	b=XSPw6qAWhhUjj6mwX6DQqb1XAZVuV9vYNCBUbwCcww1timPlIq553JyeCSqv3MvP8jMi
	 kbZGgPZKUoCrYhTY6Uy09SkkdKDM9A99mj1XwgMtcOQZmiScVVCnXQ8jApUork/aHobFf
	 XqodPdsVb4t9JQfhxxqBNcC/EdTn5KU26CQs3Uac3Tq+38EaZrUScyMPLc8dyIOrfAj6k
	 w4b07mcub/CrlzG5UwnoC0Hf0uS4CQ506aAa3CHpGwFCfIQ8h9vpivBMR6UFBTGRFGvo3
	 pXlY1mxDDouFJvLTnLcqu6FltwOGrDfHEJ/Wd7O5iFlwH+cBKHeTx2GLK+k0HyQ1wYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791445782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hcQHvNMdmoyjh+l/7nmB7eTBjfGBLtpQzdARxYYtQ6k=;
	b=sxnrtT7VkRy8NxV/ebACQfDglW2aptk5ncSWsF4FuekL/AYdfQquLS4tVhsMczUnSRNv
	 yJbmaZzbTPIyIpPmkHaE6Lt0TlnT+q2fbQa7kssrRn5tY2BGFVLP+fI4UU9rQHJGZLyNE
	 8nBDpwZFTco+azVXQBy0+/q21fEzim2MFrYb45YIctdYsD/4MgfB2CeUXAwQlk3OtzWbp
	 gJv9A68bN7UmZH4PtQgX8lL1LjUox/gf8X7kzhhKpWW0PCYwPC0GZ6Fi/+3hIrM0jEra5
	 oXLvJtzVUv1UefCbLa1APN+VKEEaXp6dBtZGFO9uLxSBpsbg0N+LkPJ9oeeG2pgHqWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791445782;
	bh=hcQHvNMdmoyjh+l/7nmB7eTBjfGBLtpQzdARxYYtQ6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fswN7ygt3TNrYy8XkHF9MSVBZ5e4Cx8juJNZ8+Ow/WpHe8CQIwSYRQN2Cq765ach6
	 I4muRYbKKoXdVXwa1P8dtTNxUXQqSBuSivWiGghgwRXaLezvp8rGdVDZPFWgj0nCy4
	 8dy76jTRs9UpaitaRuFGQ++/XNfY4l+YGANJRY7PFYJn1kjJTCVcDnEXxm3WOquFTm
	 27nN0cPPZfhi31DhGuh1yZcYXAZM+GaN71LvngF8ccKCAD9H3QAy670M1z06KSllv1
	 5tpA19IFG3noa3PjSxT1G6Vc5TdXgeDCMg36eZpr8/AQhwoUiXzQWIBUdTc4TZFa9M
	 8ClG22qfkPACw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 359DA6078A;
	Thu,  8 Oct 2026 07:49:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B88702B2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9FE640849
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5H5Lw1h-bhvu for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 07:49:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4C15440411
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791445779;
 b=pVyy53SOrVwG2csan2mZveYNXjnkwGIPq97Z+wt4Lb4hcUeo8WeDYc/xg/AU1sc27ktT
 jqIrXs1Efy7QbqoLbnXl5Ba3ifTYlC92qHz4xhzft9hDgXzU3GOjm+ltCMghh8CG9Weag
 NAKsgECc3JK425WhzX8D8BsGIrJCmng0uwQ4rkH50SbVjw5r5ghBlTTqh809XgS0XL4OL
 bv8oaMsEf5PndtY07Evj4BkpjzBb1kNpv0IChYVXDgfqf+X2cJ+dZC7iAWzOdueDq4eI9
 QD8NwG+U82R9JDIOgmntaIHBqtgwCjpMwm7lQnH8ctKhd8f5+PuGZY+eL6T+kycw/hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791445779;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=hcQHvNMdmoyjh+l/7nmB7eTBjfGBLtpQzdARxYYtQ6k=;
 b=lp9TpaMOuVq4jr0bwMp/887IM9Z12gG9LDDaQXdSEkvASD4sFRzFzcU8bhRS325D6C+J
 XJNP0aiddYCjq5fn8JmfHaM4VVvBs8p2o90EBLMPyCWej0/oR5W+maYYUFtALn0mDMhHh
 M1fN2R3pjsAX1cLGysl8QO00jVD+L5uOqf6fRXZfg0ysFqhajNb645xrdVkXLMBi1g2bZ
 0+Izgn1NiKNuP+GAdAOMuVbUM4sFFukZ2hKjTkZatGCVuksarb1zjolODYCsJwlHpDQ1H
 0TN3/yfsQrcETQ5Nv7IRp0US9d+Dig+TIvifKFQn6KWIEjhkZ2OpD761DO7Y2DiXQRA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=DJAO3eNf; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=DJAO3eNf
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C15440411
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:49:38 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C6DC13F60C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791445776;
 bh=hcQHvNMdmoyjh+l/7nmB7eTBjfGBLtpQzdARxYYtQ6k=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=DJAO3eNfoOnRx/UrU6dX99imMGPIk0UX0SRqTmlL73h9LkISOY5VmQntypK8ygzPL
 TihYW8dboRfuXkSav6virUAIMPxteT535i8hb0jThbADiCXd9I6fwyS/9NWI57WuKH
 9oZV+XKPulQMz9YWHnBxW8OFKrnl1ugxMnpLYfucQejPj5ZSgoSz6DuRUImwjgXHB9
 OQrSJNStCIOTPxZEoAk9kJta7pxR4IdLPMYR5r+xBaPq/9KBvFrP29EmO7pwrz776z
 Mx/kGPEvphk7xv8C+40xZsdhfkZfelhGoMqDgjYeq6qz/AWsF08zIgag7Qa8gNqW4g
 jemopfSAOI7/P6qGqGSwRoMIAhACo7BuRGKHS9resZe2qLJLDL/XxDCf8IHWLYKqmW
 KxSetRN5C9u0UAYynE9PCYO//T9d7A7DJztZWMeAOgXNwNw2wPnwOuVSXMBhm1StUz
 uAZ0/J97uxlvXWgJk/651jnqwYwTnQVSDSjCARgeCX5ZEozJEw66Q/IeJyW0baVcRb
 OmSQds43CBRcHiu1sGC1PX10Iu6tnYzFyUGWlflXjrMRMICLazPyWBfcK0CJI/rmC4
 3903ZUZX5uMjjULkUS6qX71JzFeWTaVA8JSLxJEoY0PzUl3WuIJuU/tc91G8yCgAwg
 BggFMfFrqtKRRJIECq/Fc7yY=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a17fe1f66aso17247575e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 00:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791445776; x=1792050576;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hcQHvNMdmoyjh+l/7nmB7eTBjfGBLtpQzdARxYYtQ6k=;
 b=C6wU4a5UjrpSW2k6+qtHYf35Z+qdfTkxTblTTmebhNubEDsbojqmSDy+SO1ebLkfI1
 It3taIHy1DY2ncTcdFMmzDhmLdQ7Z5hlzx1Wpxswd7zHfgjVo7/uUs+CQF/Dfhu4z8PI
 ddxo9UT4imVle9i8GeztoCklGXkl88qgNpSQwJA0+Fdk+14IxhqcUjKO4Zi9/23TsMBz
 XZlYcmeeoWtZA59GywQvjQHMlt2891maen8iMBC10kUTFaRrlyF5X40NKYyqcKf0+BO1
 ltR9+57IqyuwsprgCfwy5YeOuf3W2lFbqNDJXh6fCcvgcucrb9X2yvWSa63GV73OijRG
 6T/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6kQS2CAk/2duQQ6SyJLiA75+PHhV0zYRNYdRwj4qTtud8SBc+6R1QRMnQcBFpgd2nRqd+YV4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lir7tovNbdFmkdbf2TsaRIcbXEsHOa5nDSHcfn9437f/g2mPLP
 01W4Yj3SErCYAdZg0zWpv2qiYeY18mLPzzNcS/Yt7shdlCRVJCwIg+GWHU5jzjF9xmE7xp8padx
 KdSosoqDyzui2QilG5LuzPboF9AC2AGP5pYvXzq5OT0aHe5lwaHqWm57w8CEO4KH99aPVrQ0Ceb
 H9i6UBF6TNvg==
X-Gm-Gg: AYBFou0Bx8p0xIMxmSbqadqCIIetvUoBv7q4U7QGT1ho4569DF+vBKUh+CTmMcXMKGN
 Xqgl2+7qoLTTL3WO/haOGFSo8Ptt+ROTNEIKc20nKLT1k/nm2mHcLvLBNZpXV+CUiyXzTxEjqdv
 RboeF38JEfNsJ+SsIeTKlbOK3k5I9v8KDQ3JHBJqq9FgGb6SuWmdDUXf3GdCQwAUfx7q4vCSUm5
 xHyJN8u8iv+UaoHaZCLNQ8wlZqBuQrYWrCbH0t0R27rtBu9V2QEg77LzKGAOuJiV/o7b3DbfP2I
 N4r8F72z9RxOq1GaNDjTlWDex7bETNPx8QPEpJSotJRyeH1cg22SJPP7moClpHX1wyn8RgPL3+I
 Cq8Do8yRyEvQmcT50Z/l1nJYvWK3PMrnkqsUuUgZ5R5cqzFMAJ1Y7Tc9Q7WBboa2TdPbDAlnxra
 WSUemqYUz2WNiRF5AKxqjvvw==
X-Received: by 2002:a05:600c:8116:b0:4a0:108:3b48 with SMTP id
 5b1f17b1804b1-4a18030428cmr80205595e9.7.1791445776332; 
 Thu, 08 Oct 2026 00:49:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8116:b0:4a0:108:3b48 with SMTP id
 5b1f17b1804b1-4a18030428cmr80205205e9.7.1791445775931; 
 Thu, 08 Oct 2026 00:49:35 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:9d16:5fb9:2b0:6bae?
 ([2a02:908:1242:30e0:9d16:5fb9:2b0:6bae])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843b5f28sm56528865e9.12.2026.10.08.00.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 00:49:35 -0700 (PDT)
Message-ID: <5bb7fb09-2f7a-4012-a2cc-fc4598402d75@canonical.com>
Date: Thu, 8 Oct 2026 09:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sysreset: provide sysreset driver for qemu-x86(_64)
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
References: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
 <CAEUhbmXm6UW+SGEyadyeH09m70X2xVsLSPe_6iTTUmptjKKt0g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAEUhbmXm6UW+SGEyadyeH09m70X2xVsLSPe_6iTTUmptjKKt0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/8/26 07:43, Bin Meng wrote:
> Hi Heinrich,
> 
> On Thu, Oct 8, 2026 at 3:09 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Currently we only support reset but not poweroff on x86 QEMU.
> 
> Could we just add the poweroff functionality to the existing sysreset driver?

Hello Bin,

On x86 the implementation of shutdonwl seems to be chipset specific. In 
EDK II in OvmfPackage alone there are 3 drivers implementing 
ResetShutdown().

On real hardware this is abstracted away via ACPI.

To have a generic driver we would have to implement parsing the ACPI tables.

> 
> The new driver is missing EFI efi_reset_system() implementation,
> causing EFI reboot failure.

Maybe we should just keep the poweroff part and keep the preexisting 
sysreset driver on QEMU? Which would match the 
PcAtChipsetPkg/Library/ResetSystemLib/ResetSystemLib.c driver in EDK II.

Best regards

Heinrich

> 
>>
>> * Provide a new sysreset driver for qemu-x86 and qemu-x86_64.
>> * Add nodes for it to the qemu-x86_i440fx and qemu-x86_q35 device-trees.
>> * Use the driver by default.
>>
>> Heinrich Schuchardt (3):
>>    sysreset: provide sysreset driver for qemu-x86(_64)
>>    x86: add qemu power controller to device-trees
>>    x86: use x86 QEMU sysreset driver by default
>>
>>   arch/Kconfig                         |   2 +-
>>   arch/x86/dts/qemu-x86_i440fx.dts     |   3 +
>>   arch/x86/dts/qemu-x86_q35.dts        |   4 +
>>   board/emulation/qemu-x86/Kconfig     |   3 +
>>   drivers/sysreset/Kconfig             |   8 ++
>>   drivers/sysreset/Makefile            |   1 +
>>   drivers/sysreset/sysreset_qemu_x86.c | 155 +++++++++++++++++++++++++++
>>   7 files changed, 175 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/sysreset/sysreset_qemu_x86.c
>>
> 
> Regards,
> Bin

