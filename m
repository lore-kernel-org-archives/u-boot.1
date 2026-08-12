Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B197C5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 14:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1271760A8C;
	Wed, 12 Aug 2026 14:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IOK7L_ujVcMo; Wed, 12 Aug 2026 14:48:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0202460A41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786546133;
	bh=+W/H5mQEYTm6e42Q1oo1/8CIFK3brBDa11q/Id1Z65Y=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eocC3iEG8uuMiHkWyH3xB57UCs7JZophcAexUDgvMpaji+hC/220rGhuv8Axi1aAD
	 sRka7IVsxZe0P5vdYNO5K+AKeDDTaTVWBmzKEwxZ4nx7HYTP9jTaGchQCW+1Z1le7Y
	 u3gsSu3HA4YJcFIKnYBsbhJy6LO8cIt/3beSmAJcwu8OmMzg9vhgns6q7IkxCWrKbQ
	 VYdlgvu12f4YIslQJQrORMcywx9d286N9ZU1r3PNgEAL5WtjVI24cPR9v3Qd9swKy6
	 bmXjDPp6eM2wZ1WpqmRKb71DC9HHjV+/icavTFyF36oQdAni4e/+aWTEb1meMxpgzg
	 PN++elRVAyfmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0202460A41;
	Wed, 12 Aug 2026 14:48:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C39B3361
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9B30408AD
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oHNojeK20P1g for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 14:48:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:e38::42a8; helo=smtp-42a8.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C9D8140881
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9D8140881
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::42a8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9D8140881
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:48:50 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKrwJ4LDpzqR9;
 Wed, 12 Aug 2026 16:48:48 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKrwH6VtPzbx; Wed, 12 Aug 2026 16:48:47 +0200 (CEST)
Message-ID: <42853c89-8595-4cc7-b0fb-ea146897937c@0leil.net>
Date: Wed, 12 Aug 2026 16:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] rockchip: doc: add more building instructions
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
 <5f60ffd4-273b-4f2f-87d1-5a9f1fe74543@gmail.com>
 <686b7f57-2500-4776-9302-f2849f7c6eb4@0leil.net>
Content-Language: en-US
In-Reply-To: <686b7f57-2500-4776-9302-f2849f7c6eb4@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786546128;
 bh=+W/H5mQEYTm6e42Q1oo1/8CIFK3brBDa11q/Id1Z65Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aSARNIhq6g4XPNmZo1kkvYQzzrHwsi6O+mCCy8e7Izmv/fw4DP4iiLqv5J8cmp/YO
 vNF1MDIoopsP+MyF9DwYyYkU3v7ipqYZ4p6tlWO08p9175G8hVxG6J6Dqs2Nhfb7tm
 LPaLNsLPbzlwiakv+URJQpl9YTYhqWFuFVICGuW1UF2vCr3OIElO0atGrtN5Z5QWpX
 kLnApr78MdVocSI4jnvORJEKv7PruVcJmjJhuYuk25eg39O9cqekE4AVAh2ei6GpJe
 +052xtE+dnH2WPCAXMdQ4+Fd1ipsRe/iTXtqoKTMFZeH+/79n+NL9keuUrb77+NBWt
 zfJRrjkN/t3nQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=aSARNIhq
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/12/26 3:44 PM, Quentin Schulz via U-Boot wrote:
> Hi Johan,
> 
> On 8/6/26 1:11 PM, Johan Jonker wrote:
>> Add more building instructions for existing SoCs.
>>
> 
> I would rather see the opposite happening.
> 
> We already list supported devices per SoC and with their defconfig in 
> parentheses (well, I hope so, that is the intent!).
> 
> So I think it'd be more efficient to instead say that one can build the 
> supported board by looking into that list and build using the defconfig 
> listed between the parentheses.
> 
> Considering there isn't much in common between ARM and ARM64 boards in 
> the build instructions, maybe we should split rockchip.rst into two 
> files, one for ARM SoCs and one for ARM64 SoCs? Then ARM64-specific 
> instructions go into rockchip-arm64.rst and ARM-specific instructions go 
> into rockchip-arm.rst. What do you think?
> 

Just to be clear, this isn't required for this series. You can also 
simply drop this patch in v6, or, if you feel like it, do what I 
suggested above (can be discussed of course, hence the "What do you 
think" ending my previous mail) in new patches in v6.

Cheers,
Quentin
