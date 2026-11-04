Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22997606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uYzz7EHc;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UUmmIiIe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 909F46069F;
	Wed,  4 Nov 2026 02:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6CUNbWDck8Ai; Wed,  4 Nov 2026 02:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A9816066C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793757845;
	b=LGakp5r9vaIjPfJTsrtglr0nMfY6yRAd8j4XXqb7i9uHi0OGfUwi11ogwjhlLvtpcaX+
	 rtu9MSj8dCHzgM8zrpb7f0lC1h6/wneH3MtZruKYcsuZ8YR4c4WJYjX4LrD/k3BwB5308
	 BRPuKr2XiQvbXzOTUxv2w2+2wht7zSVpCGR3SgwsekEFl9k6T4X/D1t8qYWHZZf6Ra7vL
	 MXC6SixYrx3YSvphR/nygZlaLXFL5YtCM42XZN+g5udJwT1tDRUTL3FO8Y5CN7mBoa+/E
	 LNdzp4vRA3XGNLwveDzQy7yAVPuOiImuS8IG6wS3o+TQs9yZrRevnrZM0y0+3zVFgWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793757845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oQKfHxsoZ43jPXB8U56gZWLrwTl7ynffsjZhdvLk1nU=;
	b=F435aFbWIFN9nGIA4hrGFSyMfVQ/8/etvFLwUcSsLM+b5o2U24eQ3FhkHl5R7nWI3hPH
	 MnxeTSBTL6rad/EiaZUb1J+gctliyRCEiOljK/PNzsBz5IQfSMmUYW9Wkz2iwyTbdCu1j
	 8bjgyZhAxlrQ91dWWQwtSpCqsWujfonoAa8zqzDECTHDkMdwMtWLlZImP3FmRNsQM0JaA
	 cLu9sOLbbmat9ra05OTEdvKYL8Zb39kAYoBGFxqMFme/0iWZXganmokP/3eIixwig9xyP
	 jN5otXnQ7DhH8oua9bdhuwDEU8CsxDReTjm9050QM/3Zfb3lK9zXGi7IoJPrz8rixBg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793757845;
	bh=oQKfHxsoZ43jPXB8U56gZWLrwTl7ynffsjZhdvLk1nU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uYzz7EHcHXz0LhJpJ8tcZwwui7wJ4IsbCKDQ7pdXT0vbOg3rEGOpT2wKMtfyVdJi8
	 dNkM0cWl2SVMkm3Rj4GfVZeOyaSIfao7mU2Q4EnpUhAvAYdzjyVXqno2X/F9V1JGVO
	 ehK2Twlsxl9pAoXweXs+xvWLuZkApTOTKyq2NomrNSeaeAFT/l3iOe3TvOumFg0n4V
	 X3c5Hs6yn2GHJ9qjuT8OKwVuYOhGz4jOC2S4rP5RDG1dfU6V0uEv0Tmvqp2RBy8L6U
	 9vGqhLEXJ+LDAiaE/aYcqhlVJ1BuEXrmCQblf0Abop8TuT/PC5R1pNK6GecDY0UOSR
	 4xnaTp2y39OCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A9816066C;
	Wed,  4 Nov 2026 02:04:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A5F237B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 02:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B8F040176
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 02:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUGicrvKcfOJ for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 02:04:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D66E340048
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793757843;
 b=Ih4iuqBIn2p3gmqRiXsQOOSyfhcnKYA49NWdnpUUZRTb+32mNonG/xinEj0YNb5KBtFZ
 pmZQ78Dqqkx4lXGcALxpQMAQXixEPND3+qkdNCfZlOboDrrl8vrsmVHn5+Ngg3Pi6KVhJ
 aZvabtWsacy71vVuil7gKUdmcgDAxy+LLqqZ69WE2xx+Jr4pVwFlifbX+GcDCAXmvy1HF
 8Ct0MEwlZYT19XoYzx3p2Epz7X8GCSSz1u9W5b8FMgKMap6S3P/WgkTeRq4H+PpT6R6i8
 9ho8WBuHUMqEXwAKl4hPPIFAoaUrB8YKW5YsfEBrmM2dZYa65O9ri2Ex4tTXDtQr24Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793757843;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
 Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=oQKfHxsoZ43jPXB8U56gZWLrwTl7ynffsjZhdvLk1nU=;
 b=UE+q63+11Sp1raMl4ZWWn02fo0T6ACIHM8rKRagY52v8vpP9pNYDkQsmFTVAiCywANje
 MMr+mEAnP3h0LRxDTwb+pU7NHK+Z1Tp8SFun3p+xyfUQZBeLmgxaADCY6TthYyB99Tpns
 3GpV5Y55uU9purWXh2BVtGs/ez88RmBjaxQ5hqLnGi/ltGqmWLxHib2ZFLpEB2XSHmKCO
 Re6FrNDSWtF1RKrzB2lKQ+JyuSucbPYsPgr9KEq7tNhkil9/4ynTtgxUaTza7Be4FIxRS
 pgf1vAbUO1EZE9ic7zbjZoheb8PvaeYLtkSdcQ0vrA9fIFkb9uvM2OgMSzoElg4BvIw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=UUmmIiIe; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=seanga2@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=UUmmIiIe
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D66E340048
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 02:04:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE4E84823; Wed,  4 Nov 2026 03:04:00 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C1A983E76
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 03:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-91c04f35e96so72066d6.3
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 18:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793757832; x=1794362632; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oQKfHxsoZ43jPXB8U56gZWLrwTl7ynffsjZhdvLk1nU=;
 b=UUmmIiIe78qXZrRJRIJChL/l8karQNo1Lo4Xi8OtvrqdWvhd1m+af4vvvKVtox2q3v
 yxfNuJ+RXm4T2ehvuSri8Ev3QGE0bbZcSYDfdk8uqNoVxp38+gxoXQfW8UFIlShapyWY
 6W6Jc9p+CobflJ83SWw2ot4rk7qR/yn7EfQL+MaBoJzplxyX6DGRghkdiMCRI0GKEpOg
 D5B4X9sW6gp56sKbPIA+qSZ62M6HYvMdkNe0/dBZKZTNu2Xr0FIDZ+bKL8/cMXl5XkfZ
 kYqPJqghGr6LVSKLRLtSLo2DL9X9Cq4FF7Oei7uQr2lHA3reboVv5Qfxx8nlS3GxJkGH
 2YwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793757832; x=1794362632;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oQKfHxsoZ43jPXB8U56gZWLrwTl7ynffsjZhdvLk1nU=;
 b=nh8WBNm8kYnTaKEV/7vAVaxGG5L/T+hynIShdcDTMgBVnHi9anOIkmtuWzt/ReQuAq
 Qpu5wuOvBZPMSHJi/5NnsoJZC7Ui9IUOiXn1VGI6kXmjUaIv/IBzAjElPK4R0s9N47B5
 clJgKXWfrP7Ts9aw9FeGYLbQIoYP1gIoZqOff/ti1m+r4rqANsYeTi94BxK2Gy5U083T
 YjNVP23P/anph1aupU2eot/RUVC1cFp87PUGf70sq8ch+aseeWSmPdQ722J1Cp0Exkow
 G03C8jwUxHUKIdr1Ofj2iAotDzhMH7/f1hmFZhYL9rfYOt4QQ5rw2srw5k4u0KygaGq9
 cTwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUD1JO1HWvWcmbuTVMWObNqfGNUY8o2y1Z9BiPFW1Sr38bX0f0lQl2E7rsxeCRmDG3LDFOIiE=@lists.denx.de
X-Gm-Message-State: APuU4Z/4eeqxv220yuv5h2ngxycRxx6KJe3yo6i3U6NmHXQO5N4gNCsX
 fZF32Ek0ANQHnUuzU/C7XsEKqlyrrZY2NFRn7PQ5HMuG8VYgIuVfYd46
X-Gm-Gg: AYBFou0x1+nNua+Y6NFeB1ZA5Kkt6EMEsWviGgsH/GwZLC0qaAjnY+UMTWGIK9CWfhD
 whYK5oG3oKoI+e2diHpRovf3zzM+D4RJSIpy9N6WcV8z7P5L2VVVB77rScOPHRBgYLIog+0M26d
 +3mYURLLYi9uzQgGwGZdAA5PsvLxUpr0bM039isomI4pWhGzilHPGZ1N7mXOEklbu62vhwX8iSK
 C90dp3Ebx0ahHwMF/6uy08FlAebJ/UsjKpoO3FuJBwSNNEdd/FkpqmnMF+1wx/xEpa1VwseTzxh
 gzy/v/ZZ5G4GXeEJd88R4YQoUmOmnsnlT6qbqK1DPVtpdT4GbSHzx9byONqn5GJoP4RvBOSEshz
 RYCH1eypVeOALKmRc04fc0AjeMZ/yJkf+p5vBh2Qk5aaPjK6OMc+bTmJVPgG8wO68TTH7cKzFWz
 LNd2qyLlWXAaKCsxnfpgSMqwv6PDmNF0PB5Xs1frnc/zWwF/hjD9QZkaHDK4YJdq+fCPu+Y0oKW
 alu7CqaEN2Iza5pCuXlS67+vyNGEwu6AXTM4QAyX6Nl8ie0+5Qi6md+N2maUAkCVCfdGXdoP0ms
 swpdLFHXazIpC4iEBCmZFVcHLADxl4G2n6aVOueu5DXI4e0gO2s4bVPbINc+btC5Q8upp8P5
X-Received: by 2002:a05:6214:c6f:b0:91c:6ccb:4442 with SMTP id
 6a1803df08f44-91ca4a4b1f1mr337650216d6.2.1793757831689; 
 Tue, 03 Nov 2026 18:03:51 -0800 (PST)
Received: from ?IPV6:2600:4040:498b:e200:2d8:61ff:fe7c:5d59?
 ([2600:4040:498b:e200:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91e7e0139ccsm6107716d6.28.2026.11.03.18.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 18:03:51 -0800 (PST)
Message-ID: <3a7e331e-ed41-5ca5-192a-f7d1a88c4339@gmail.com>
Date: Tue, 3 Nov 2026 21:03:50 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] usb: dwc3: fix abort on invalid ref clock rate from
 clk_get_rate()
Content-Language: en-US
To: Frank Wang <frank.wang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, macromorgan@hotmail.com,
 heiko@sntech.de, u-boot@lists.denx.de, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, chenjh@rock-chips.com, wmc@rock-chips.com
References: <20261103082732.18483-1-frank.wang@rock-chips.com>
 <CALeDE9PLaF7rB2RXn9G6ipWW+J5dentCtyNLgdwTUywgiTnooQ@mail.gmail.com>
 <95e91156-4ea3-4d1e-a0ed-ddd4de47be73@rock-chips.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <95e91156-4ea3-4d1e-a0ed-ddd4de47be73@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 20:53, Frank Wang wrote:
> Hi Peter,
> 
> On 2026/11/3 17:42, Peter Robinson wrote:
>> Hi Frank,
>>
>> There's a big rebase to sync with upstream Linux driver [1][2], I
>> think it's due to land shortly, does the issue still occur with that?
>>
>> It would be good to get the rockchips SoCs with the dwc3 controller
>> tested with that rebase.
>>
>> Peter
>>
>> [1] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637669.html
>> [2] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637734.html
> 
> I checked the usb_dwc3_sync_v10 branch referenced in your email, and found no code changes related to this issue.
> 
> In the Linux kernel driver, getting the dwc->ref_clk rate is mandatory, so this issue does not surface. In U-Boot,
> however, getting the clock rate is optional. Some platform vendor clock drivers do not implement clock rate retrieval
> for all clock IDs. Therefore, adding a check for the -ENOENT return value can improve code robustness.

It would probably be better to return 0, but alas that ship has sailed.

> Additionally, mainline U-Boot codes do not yet include support for Rockchip 32-bit SoCs with dwc3 controllers.
> 
> 
> Best regards,
> Frank
> 
>> On Tue, 3 Nov 2026 at 08:28, Frank Wang <frank.wang@rock-chips.com> wrote:
>>> On 32-bit platforms, "usb start" aborted with
>>> "### ERROR ### Please RESET the board ###". If the clock driver
>>> does not implement the "ref" clock, clk_get_rate() returns
>>> -ENOENT, which dwc3_ref_clk_period() treated as a valid rate.
>>> period became 0 and the fladj calculation divided by zero; the
>>> software 64-bit division on 32-bit ARM calls the
>>> division-by-zero handler __div0() and hangs (64-bit platforms
>>> survive silently since UDIV returns 0).
>>>
>>> Skip REFCLKPER/GFLADJ programming when clk_get_rate() returns an
>>> error code, as is already done for rate == 0.
>>>
>>> Fixes: 6bae0eb5b8bd ("usb: dwc3: Calculate REFCLKPER based on reference clock")
>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>> ---
>>>   drivers/usb/dwc3/core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index be198041f08..9a84ec6a60e 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -151,7 +151,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>>
>>>          if (dwc->ref_clk) {
>>>                  rate = clk_get_rate(dwc->ref_clk);
>>> -               if (!rate)
>>> +               if (!rate || IS_ERR_VALUE(rate))
>>>                          return;
>>>                  period = NSEC_PER_SEC / rate;
>>>          } else {
>>> --
>>> 2.17.1
>>>
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
