Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FC606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=crlGFcDI;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=MZahqTJK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 977B540763;
	Wed, 28 Oct 2026 15:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tefn-A8Uu0xI; Wed, 28 Oct 2026 15:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BCB8640742
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793200621;
	b=n3B/GiX5KLAf2MZAGGr+6Qrx2Ri6O4MRikg1J5KbITysYFBOaf5Fao/VLcoaMO/rztse
	 r8Zx/7fdXqGUvD1RsocLkKFsVjRuD+0zEMWLdGrx3CmIMa922MHd1WevUASEbr1AEqwhE
	 +OedTTBpvWsuf1S35+HYJcr4veQO0sBakCB8ClPPPqvwdh01u9ULdtdXja3UR27Svk0eA
	 XJ//7JIIwKiFIB9kWs2ab/DeKjisCgabPhlH/zLb+u9065lhsAJ4c3VT/l5jDW2DpicbQ
	 slzDwS7nKE4njsxEzWKy/ByUJ67XCj6Ku3d7ild4uTvjL5imrZasrQxVwxRWlM6IIsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793200621;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LJ08sj/tYDedpRzrGg0hnC5rZXRCiwu5aY6k9TI8Nv8=;
	b=FPVMElizHMVmOXS2XRZ5GO2ENiNLalCyWgz4mIa5T1qNN+AGz/xSEkRo/oiGwKKXFxjM
	 +2NgWFBZg6tX+fRB6tNhjABJbjVDW1oHsjXW44QnIHWrT0CMq4egnoq1qPG/AWryJOvKP
	 aQnSHBMoVeDs9BFitBUyAtFWRuHWR/1Fb4Ub93GmZthWtyoGxA6rbFgf2c2S6lQWwK7EB
	 aN4nIIa+V9HBAUFf35IE39lN6K5Ovxe8QBqkwI5/QSC/OauIp6okU7EdGYGwEGFdPSycM
	 b4pKweWx7soysNVI9N+4yl4OzgHTJvTpMsGAPyTS2DSmPzWmLzw+WNJI3ylB1Zyrccg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793200621;
	bh=LJ08sj/tYDedpRzrGg0hnC5rZXRCiwu5aY6k9TI8Nv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=crlGFcDIix81wZFZ75sdD+QkYhkYvMZtsc72AM5wS7udq0l68xWFNjhsU3YC5QDP0
	 63tzdQzFkl7mrLibhHLjjIsvoNyG9boT6yXZcZFmTztHNFjAIWGaxoKNKxO/FUoyX6
	 tlcBCmoIOJjU8MBn7Zi/lNXjrF7q81Q/Du/RT6bWQ51+6/kaAaAeM/7ABih3sWVkLD
	 Cc4etCEo/NX3MZgzbTnkSJK3fZtHdmFlEMZa7nR3QPrssP1gvBgUWfoSI1HBLRz8q6
	 Wz6RMbh2fDqEM08MKbg6l0bx0TwDNQEgXb/BsoCwah74a5/kpKgMPR6/tNxS29sEfa
	 pOEOJFORBxbMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCB8640742;
	Wed, 28 Oct 2026 15:17:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 250034D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16DE960633
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AMihFJNhGWqs for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 15:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13D8F605CA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:b8b8::8fab"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793200619;
 b=j1jWjZEjWEiDH8eplrLphIlWPUORmmxK30dYV4+A0Cc0+LYg54YgFSOpFfzUkihOuPFQ
 eVdwMmJ2kre+HRAfyQ02hDUAfO/774kRg4fv3Fr8x9blhXe2ihLV0iarherLzxcQAsRDa
 ilSh4d5UUZfrZUe8/ZiqwxP8nfC1Rg2PUpl5jFqnyBU96ZmFjyI/CmoHZ5MQ90uIYaZz0
 /kJR4Tle+Y+QgLC0VNDuyrZ20zQFll6L5oqvD8ZWe2RG51TBnFg8hKUA+qg3SbnAyIaML
 HvC8ANw2HwaM/Wx3V2ZUyUTc0bf4VU6kclkUweMf77LpkrJcaG/CALu8tI1elA20Q4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793200619;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=LJ08sj/tYDedpRzrGg0hnC5rZXRCiwu5aY6k9TI8Nv8=;
 b=NPgdtmtKLuTzEk3OImb1yjMaDtKpsLj4F1QKbseqqcEWxRgKKlrNKIBTS+5UClPmccpc
 W66ziu3LVy0fcpuUb1f09DF0/J8lNsQMxSsTn1m/HIOuZA2vwOKsrJAaaeF0sXRDntC21
 yVuP87xtgV94gc+URCvYfW7bFi5AOpuOZ0AJLXVUO0uTY5ajhZTmL7ABzuJZHogtRdtwb
 G9zW680Pq/RFOnQOzTBfQPeqNUG0fofZBGhlKCjEVFNpzIPxR9OyaWXoVuhP8N2klZ2NM
 6PcdTpnMuXl5Beq/nyUTEuHoAm5hTextohEqzaX6gUdemogMx3u7DT7/L2qN0k0+fqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=MZahqTJK; 
 arc=none smtp.remote-ip="2001:1600:19:b8b8::8fab"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::8fab; helo=smtp-8fab.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=MZahqTJK
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::8fab])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13D8F605CA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:16:56 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jF9vB0qw5z1L2W;
 Wed, 28 Oct 2026 16:16:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793200613;
 bh=LJ08sj/tYDedpRzrGg0hnC5rZXRCiwu5aY6k9TI8Nv8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MZahqTJKfVJfnhEJTsw7tqOgvgUYAo+FFq7+54jCriUTo4JDy35XbLovCLfhIjgas
 /UT1G/rjjQ/IfErr6w9qdrEjkzymz+6t3w+ux24cMP0JQavj1keLNRORWEI0bfs57y
 cmq7ocAXHl8r5Cc/hIu8QUG5eRCgzJr5ibv4uhV1tsBto57iaviSJxqZ5mB3nSLNNH
 beONQEMAcEG2PUm7hsIKXWaeiwH1obqliFHSLVip4K2rqejGQpnkfDZR6lIA1+k7Jm
 tyglmvC6X/RJVzf/yS1j79wR2eg1oLfii2FIqSTPT17W+1U+tuiNqeN4l9gblAaZiC
 nUK2bYOEVdgAg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jF9v91PbLzCh9; Wed, 28 Oct 2026 16:16:53 +0100 (CET)
Message-ID: <9d7e9ed8-7e09-4ef0-b4ec-3b85fce00cdc@0leil.net>
Date: Wed, 28 Oct 2026 16:16:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ram: rockchip: px30: allow multiple DDR types
 selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
 <20260829-ddr-multi-v1-2-c0c7837aed20@gmail.com>
 <0bba4247-2950-41c2-996f-d9c29043619c@0leil.net>
 <CAC928Hbi8UudtraNW1JDW5M2rRDcB28LssZyNcxKWP3pVATBAA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAC928Hbi8UudtraNW1JDW5M2rRDcB28LssZyNcxKWP3pVATBAA@mail.gmail.com>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 10/22/26 7:57 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno gio 8 ott 2026 alle ore 22:49 Quentin Schulz ha scritto:
>>
>> Hi Massimo,
>>
>> On 8/29/26 7:03 PM, Massimo Pegorer wrote:
>>> Allow the inclusion of more than one DDR parameters set in the PX30
>>> SDRAM driver. The driver applies included sets in a predefined order
>>> (DDR4, LPDDR2, LPDDR3, DDR3), stopping at the first one that makes
>>
>> What made you decide on this order?
> 
> I've just followed the original order the data header files are included and
> thus added to sdram_configs[] array. I have no hints to do any fine reasoning
> about this. Maybe Rockchip could help.
> 

Rockchip's DRAM init blob is usually unique for the SoC, regardless of 
the populated DRAM type. I'm thinking they do something similar we want 
to do in here, but I suspect this is "secret sauce". Ideally, someone 
could reverse the blob and figure out in which order they test the DRAM 
types. I know some people reversed RK356x's (and I vaguely remember 
RK3576 and RK3588 being looked at as well?), so maybe they could help, 
but who knows.

>>
>>> SDRAM initialization function to complete with success.
>>>
>>> The default fallback behaviour is preserved: if no DDR configuration
>>> option is selected, DDR3 parameters set is included.
>>
>> We shouldn't do that, we instead should have the DDR3 symbol default to
>> y for PX30 (and other SoCs if applicable), to preserve the current
>> state. I don't like hidden defaults like that because you may end up
>> with RAM_ROCKCHIP_DDR3 not selected and build a DRAM driver that only
>> supports DDR3, which is kinda odd to be honest.
>>
>>>
>>> Due to limited PX30 TPL maximum size, including support for more than
>>> one DDR type requires disabling some configuration options such as
>>> CONFIG_RAM_ROCKCHIP_DEBUG.
>>>
>>
>> Good to know, thanks. But i'm assuming this likely means we can only
>> have up to two DRAM configurations enabled at the same time?
> 
> There are some optimizations that can be made to include all four DDR
> configurations. I will provide them as a further patch if these are merged.
> Moreover, with the work done by Jonas, we would have more space in PX30 TPL:
> I need to test these on top of his patches.
> 
>>
>> I think the information printed by sdram_print_dram_type() is still
>> interesting. Maybe we should have some log level for the DRAM init so we
>> can select the verbosity of the debug output. In any case, just a
>> thought and not a blocker for this series at all.
>>
>>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>> ---
>>>    drivers/ram/rockchip/Kconfig      | 67 +++++++++++++++++++++++++++++++--------
>>
>> No to those changes. Keep it simple please, no redefinition of the
>> symbol based on the SoC. For the RAM_ROCKCHIP_DEBUG needing to be
>> disabled, the information is quite nice for end users so i could see it
>> being added to all RAM_ROCKCHIP_ symbols as a hint (or have it somewhere
>> in doc/board/rockchip for example).
> 
> OK, but I'm providing multi DDR support just for PX30, not for RV1126.
> Therefore, the logic behind DDR config options common to both of them (such as
> DDR4) will be different in the two scenarios. Would you prefer a single config
> option with two paragraphs in the help text, one describing the PX30 scenario
> and another for the RV1126 one?
> 

Just say what this symbol means "support for X DRAM type" and that would 
be enough, the "depends on" part of the symbol should be enough for 
people to figure out whether it applies to their SoC or not.

Cheers,
Quentin
