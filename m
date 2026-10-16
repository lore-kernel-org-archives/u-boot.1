Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44CECCA491
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 10:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 180DD409FE;
	Fri, 16 Oct 2026 10:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9AMFPrAPHLB; Fri, 16 Oct 2026 10:32:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B1E8409F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792146728;
	b=U1ZO3XOjxSSWgBw/PFsKv85rikjNMYD0IemG8xnQptgAPR4XBJTPiWG8YgyfReOkyK7C
	 F8wD7X05llcNno9D+brc5yOZ+QFmqJZVlvkTvzfXsN0owwdKiV6a5LDhl2lW68HDiZdeX
	 yM7VwGgfuLz/bdoQ+xj9RLFcarCm1pwxhGfbN7sZPm2GFzk4Xf/dS9mVVSKuTJNCLKj3c
	 aG3M6GJ9wtag9h49AnSqPjwKzy/8Io6XivQ6oXyVA3GCewmQt28nWaQ4K94xcaCbMygie
	 z+6WqusRQ+wdB5x7g8MzptEiXXhmtZPHQa5OfytLHHmdA/O4pPpT2jlt74Ht31dkMYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792146728;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5TdfU/nMf/SbXvjuj2EsaF0xunahc7I3dX38wtGp018=;
	b=NQe6sjAq9bINir3bULkC6Ggc1hle0/gXt82B0zxOFWneLAuu2ZSmw/LVNSM+rkBy2W6K
	 SY6zlrojQIiDa9wZO6el10gYzmO+7zTG+rsmiANU/11zbY1V/GwrYW0xtskTEidhAX1dH
	 0rIVdLCglzYtozY43qBYTCTItAdiVRcCjZD10vQW8brkNomwiqXFZkPdxRSp18Tf71lT0
	 4JNh7RtjhHmXNG+OdGwD01d4072JOWHWibhgf3FfKJYgM1H6ePnSP6PJ9diCUbZSe+JdA
	 tkbK1g3xLemSBcEppvWR17DNVs2G0D6mVEoVCrC2LdnmnRN++ny3DSQJs3ElYML3vYA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792146728;
	bh=5TdfU/nMf/SbXvjuj2EsaF0xunahc7I3dX38wtGp018=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P+W0g6rv2lVaPAR3RExITlg6d6XHts0mvQcX9RTM8qUnd+YmWiyFxBoAWh3i3+rYZ
	 LgXBPr4NX14sTNZy2HdIt0HUhhnr1McsfYdq/LI8gLZ8XOjsGhiAqOiMn42ZzH2jnH
	 gygJ5lWKL20w39rPteoN/faj29LDLZXT15xNiHfr6/YByAanDu6Wf5dwDwXVE72310
	 LhljcK6QdrRS0T5sKyBfIGk1M6fStrBvOtupE7igIFNwmpcpyvltlbuTpiUvInj6ZJ
	 +HhIttA/0SJV/Gz+ZwgreOcdFfOxhUmvbvwVg8vd+hAKqb0iWTYqi5hpo59zmzRX9I
	 wIvmf11Ex6XSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B1E8409F6;
	Fri, 16 Oct 2026 10:32:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BAF2109
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6204D81460
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:32:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5apgoodalbM for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 10:32:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB429812B1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::bc09"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792146725;
 b=ECJJGpIIGAwOf7j9QqFGbJFa/BFe+sRogZEJIBatRTW9b1ahDKEClspiBdiWfGDwThpL
 kJIzpoDKwm/zYYRX3DP5OvngMNGxticYDaflvBu41VL+Hl0UCOVJyY1zzZO6BDIjCo/Oi
 6pkSicq2b/qOzhschGGyg9TUbd6z601Hx9xmmwBWL9Phg35t+uk5ZPBJUd342MAEQO8VN
 C5ZnY0kusNeV2tWHYW1Js7gAfwbtyIpKrwHhD4skc5dVY69+yK6UFPbAld9zPZ820iF4W
 GpO+DZocO+RVTuOGxQ+k82ApxTOuoo2iQhaTUIH2H780dMyQj/gN0iMGNTBCddItJew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792146725;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=5TdfU/nMf/SbXvjuj2EsaF0xunahc7I3dX38wtGp018=;
 b=JvD2D9ASSPUeWahsm8eFNyag1otatcFbWdtDxLzq7kyN3tRzMtT7GiJdprE26OXW4eld
 RfIqX+3twyiSRFirixa3mdnkEzQrbajQh+uNk1IT/PHyxwXDPUij47NT0fsdO5CjDElzl
 uam0fxgRAP/zrc7apx7zpGEZYQfVYHzCyCZJN0rGHj95yFAS1u3cc9Z+ubxPUlIb2eQ9V
 J5TYehhtG7BdyuvqiHtbFz579UYs+y7kBTTfB8Gp9ySpibzyZhG/s5J0crFng/NT2rQIv
 sNto4WYIQ1jLqJFMPgzjTXVhPuzTPKCAAAfSVMyOUgzwRzaVeEG9UCu4DpkpOiYuxZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=fspVCuzP; 
 arc=none smtp.remote-ip="2001:1600:19:8e30::bc09"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::bc09; helo=smtp-bc09.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=fspVCuzP
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::bc09])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB429812B1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:32:03 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5h803P8gz12Mh;
 Fri, 16 Oct 2026 12:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1792146720;
 bh=5TdfU/nMf/SbXvjuj2EsaF0xunahc7I3dX38wtGp018=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fspVCuzPUE7ZiHFlZD3cNnaylVoCj9TuqEHfCZ8yaf3ezwCrCPKvenk1vtWga4XSw
 rFqL0QxYAI9E80Dn0agNZkyHiZgrjFLDBckMHSPF0B7LE1g3bHXLBMbI0Hpd9CCjJZ
 OAySNVqdi2aslGlLtztccjRxzvabMHjGDxNABecRXDbu4T2GJWG39AAZ4vSWI7IOUo
 eItnojC1K7QIK6UgmSePbaKfd7JTdzO3vSNDQML0rF8XUjX58u1NV7UtcmCDaAY7eV
 yLmR6gaADV/NkT27qTA6g/raZB2m579yctZxcosYKiFOFVGqcq19MHsecHFIlNnn/R
 rPm89ATh9Ua2w==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j5h7z262wzTXV; Fri, 16 Oct 2026 12:31:59 +0200 (CEST)
Message-ID: <dc849a75-9166-41af-9ba5-abe8a63be884@0leil.net>
Date: Fri, 16 Oct 2026 12:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: mkimage: Update init code size limit for
 RK3328
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261004195853.59863-1-jonas@kwiboo.se>
 <20261004195853.59863-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261004195853.59863-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Jonas,

On 10/4/26 9:58 PM, Jonas Karlman wrote:
> The RK3328 has 36 KiB SRAM at [0xff090000, 0xff099000). With 4 KiB of
> the initial SRAM typically reserved for BootROM during early boot.
> 
> BootROM will load init code of up to 32 KiB (0x8000 bytes) to address
> 0xff091000 in SRAM, before jumping to it.
> 
> BootROM typically jumps to init code with following registers:
> 
>    x0: 00000000 ff091004
>    x1: 00000000 32334b52
>    x2: 00000000 ff520000
>    x3: 00000000 ff500000
> 
>    sp: 00000000 ff090f50
> 
> mkimage is enforcing a 30 KiB init code size limit for RK3328.
> However, the BootRAM can load up to 32 KiB of init code.
> 
> Change the init code size limit to 32 KiB using the <size> - <reserved>
> pattern to closer match the actual limit of BootROM on RK3328.
> 

Downstream still uses 0x8000 - 0x800 so unless someone from Rockchip 
confirms this is safe, I would rather not modify what we have today.

Cheers,
Quentin
