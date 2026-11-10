Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41200606A32E
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=INscZ3Om;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=BkCmb/22
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E045D409F0;
	Tue, 10 Nov 2026 15:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ljx8ZkRSXcsa; Tue, 10 Nov 2026 15:57:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DBCE9409E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794326251;
	b=YtCrriEKJlso5ZffktgpnXxTM8r6+q2269j5LdNKHZXSRMxfxCzAj7YF/dWiTsgoYR9E
	 pzSwPkifH2xX2NPGUwF0yeV+rzW9uqcy63++UW35hesEefW7zSAahH7k3+MP22J3/K1tm
	 GK+cTmwTwETbKactvmWEg4L5SaUHt/iw0tKmn0mB1Pwit20QZq2EU6FMLuhB19vqgmEEL
	 s2GJG/mSNOx2qNMcdBGDLpp6ZFgLLia+XFnEyHTufQn1KMBBM4tLiU04ldF0lO0G9UIkN
	 /iQn4Zyq+3ApsUekVvIvrja2jZw27dmVoPbanVL0HPGbieVnQyD7F0TlKkmRCcyvs1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794326251;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z0Hi0CX1aVNWlN9ZTuoVkJ4WKgKscqQfSNIg77REkhA=;
	b=KZgwtw4iK+SxVxSD7YDh9qMmpGWEn1gQmu3iMvcHhWKR2s+UYELmRe0tCNSuZLa1OUpP
	 psINnGql1QweVpdEwGSmQiPdkQJl5tz+5zaXRfky3unrWOz+GNTBlZE+C+Cz3cGHRorVO
	 ZbBdGXNgPuoNRfaxcWm/kVvfgu3GMoqkrFiDcw9W3YEzu4ZtGDNdFEPG+vj/GTkm1vJGE
	 Xc04QamVKKrHzpvIvZQ558KCTpSCoAbG9GJp/na7v1G3jIR1/sRXwFkKaPGpHeq3+FMy9
	 OYaAlc6XTwEDxmQWWWoCksP5DAQhIXnH1GEolMb00p27PWnDFxBYB532w10tXCuh1yw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b="BkCmb/22";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794326251;
	bh=Z0Hi0CX1aVNWlN9ZTuoVkJ4WKgKscqQfSNIg77REkhA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=INscZ3OmobSx09IgpNSpMSSX2ivEXmyF66VRLZRZMjjaJrUMbmLTvkRn/TrOQCZa7
	 7hAIHQp4DmeUbNE3dw4U1nfN30dlRAN8/EnM5J6bXsdiQ0ysfk+IwSkizpQ/dKkKFr
	 gzOhdHur6OkPkZYjGDkxCa9c4QAhORGFDCAq0Eu2PURRefV40KTAfbFj9rdL3RD4j3
	 pqlC2V/93YGj0xpBSGGioZLCQGKuxCVjXjWk0jfaV20ekbQqj0z44pojPJxuUMkli6
	 4lr+bPCc0l9bHOwbOXwfghEJfGxmOLqBpJOqwV3nTgR3dAcLCHlUbPglbjCttsP+Gk
	 cArG2uEKHL68Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBCE9409E8;
	Tue, 10 Nov 2026 15:57:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 82DB21A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 689B9409E8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:57:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j_xn6BI-ohb7 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:57:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58AB3409E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:fff0::190f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::190f; helo=smtp-190f.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=BkCmb/22
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::190f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58AB3409E4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:57:26 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPB9v1vr6zJt1;
 Tue, 10 Nov 2026 16:57:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794326243;
 bh=Z0Hi0CX1aVNWlN9ZTuoVkJ4WKgKscqQfSNIg77REkhA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BkCmb/22J1uRYIWAFtnsizXJ+EuNX69XjoAkioeaHcol83fmKOB0c3L0mm5qtcgBO
 oIlnRKg9bBhByv1I8yaol8/s0/1Tsvr6shxB4twoOLW0gm8d2vnq57lHQSATSMicRB
 tJHSryYJND7qSIwlyoYj1tWGzG4xA23pBPPVvkCa8OWtS5abunPbtUi5sIoVUg/EqL
 OT/nC4viIDkKgnwYXDoH6g0/GHTNn1Tg7Zsdqicuv9VJCUDjLVURzvPg1VtwUvjXZL
 go1wXY/LqWGRSC5sa3/RQzL46Eyua2Xbuz4HzkxssVw3VrCKVXcgyYgR3/aakrEY26
 NFS2Ny1Hvg1yA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jPB9s6vPSzPdr; Tue, 10 Nov 2026 16:57:21 +0100 (CET)
Message-ID: <51e49cd6-7157-4435-9dc3-4fae0948b2c6@0leil.net>
Date: Tue, 10 Nov 2026 16:57:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add Kobol Helios64
To: Igor Velkov <iav@iav.lv>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261021-b4-helios64-v1-1-74afe8aa6d72@iav.lv>
 <b102efbe-548b-42b5-bdba-c744449db9e6@0leil.net>
 <20261028-h64-uboot-v1-review-reply@iav.lv>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261028-h64-uboot-v1-review-reply@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 10/28/26 7:45 PM, Igor Velkov wrote:
> Hi Quentin,
> 
> On 10/28/26 1:25 PM, Quentin Schulz wrote:
>> Can we have you as a reviewer at least, so that any patch modifying
>> either of the first two helios64-specific patches are sent to you and
>> you can review/test them? Is this something you'd be ok with?
> 
> Yes, as R:. I can't review schematics or drivers, but I'll boot-test
> helios64 changes on my board.
> 

Good :)

>> Please work with the Linux kernel to get the vdd_log and vdd_center
>> parts reviewed and merged there.
> 
> Sent on 21.10:
> https://lore.kernel.org/r/20261021-helios64-vdd-log-center-v1-1-4cafd110e0e5@iav.lv
> I'll send v2 once it lands in devicetree-rebasing.
> 

Thanks. I see it's in linux-next already, so probably will be in for 
v7.5-rc1 sometime in January.

>> This is already the default (except it's a lowercase f by default, hence
>> why it appears in the defconfig), please simply write it lowercase so
>> it's using the default value.
> 
> Done, the line is gone.
> 
>> You said SPI flash boot wasn't tested, maybe don't generate an image
>> that we don't know is valid?
> 
> Tested now: SPL loads U-Boot from SPI, then Linux over TFTP, 6 of 6 boots.
> 
>> Is the offset used by the Helios64 original support known?
> 
> Kobol's U-Boot used 0x80000, which also boots here. I'd keep 0xE0000 like
> the other RK3399 boards: an update rewrites TPL/SPL as well, so the old
> offset doesn't matter.
> 

Technically speaking, you could have a partial/interrupted update and 
have a mix of old TPL/SPL with new proper and vice-versa.

RK3399 Puma has different offsets than the default ones for example, for 
backward compatibility, so if we can have cheap backward compatibility 
why not do it?

The thing is, you don't know what the user of Kobol's U-Boot put after 
U-Boot in their flash. Maybe if you write the new U-Boot at offset 
0xE0000 instead of 0x80000 you overwrite important data (e.g. at the 
start of the rootfs partition).

>> Are you using the Rockchip bl31 blob as TF-A or upstream?
> 
> Upstream v2.13.0, dropped.
> 
>> Please remove clock-names from this here
> 
> Dropped.
> 
>> Are there really that many USB Ethernet adapters on the board?
> 
> No, the list came from evb-rk3399. U-Boot has no RTL8156 support
> (r8152 knows 0x8050/0x8152/0x8153 only), so I dropped all of them.
> Only the GMAC port was tested.
> 

Please make this clear in the commit log for v2.

Thanks!
Quentin
