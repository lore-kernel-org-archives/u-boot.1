Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024B606AAE7
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rePNSn1X;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=FjROgKxj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA86E80E28;
	Mon, 19 Oct 2026 15:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8UPDUwIz0ft3; Mon, 19 Oct 2026 15:56:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AAD9E80E0F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792425415;
	b=VeOKqipj7WnBeNWChgCN/HCbA/jgJEtlSlSSCA6l91V2gb1f0CvZs54V+QR/WyokGKZY
	 ArRHRQISoQq+/ZIIVLlxH4ljbYh5J37SDAFcycbF7gTWyi1TLlXOpZ0KSjs8JkOpw8o3h
	 HCedIHq/1D5Exg6t0AOmDHW2gS/cS5TCvsF/J3FsoJA+8Og6yg1ZffWnOpl08CEXePj+T
	 F6EKZ7BY4MCGXc8txPAfF2TM/AZiMK7ix0LZjGd5gMqJ42CIHwg0onMp5mT5gKf/NZLRE
	 5N9cnUG/83+KxLa7pDXjJlDRHh1Umfv3s7jTY8qjcdacSUDvV0YXDQvBTM0TlbkRvhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792425415;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nK9wjWHY+niwQp5zH8bLxTh8YTnWL1CbG/PKMgAWy8w=;
	b=IiJdTrKMYO4E3Rc+fg69IXgO07xn0oci+dYUUaV6H5WMjsSrL9SuZjqyUZhU5K/MkEG7
	 IAjzVOCj58bd1m3lRQ3deCT8J04je6uAOU9UZhnQ8s0uC3/A9PaGlCUhdebN9kSBOtDnr
	 uERroICusG+EQ0XDYMSOTlc++aWQCrtgQgQW/KnOP6vCELlJeEdwGqrXVGy2PyK+CyqDJ
	 /2IgjJ1Y/wCj8IPLj0fI8g2PQN9ewXwtXsQRzjA4QAwenYdBdynbzIUCcOZAMbBMZ4aEg
	 cxlBP+wXFnaMfoZQPTv0Rgo1zzYOfo9ZTQGFKEE51D+yFEGoaFesacrfl/4MMs4gIlA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792425415;
	bh=nK9wjWHY+niwQp5zH8bLxTh8YTnWL1CbG/PKMgAWy8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rePNSn1XQl1vgZcl0YQbT02tm96gxHLvb5QswB0Ob6F5sBQeF1mT1DAFWwd6e4Cxa
	 Veksq2YzOoP6uhvUXy+RSa3EvrPb1sKC62pbo68sYc3pmyfa2B+nLxzxRGZds93FpY
	 Tz//Rs0cM9nj7+MmdpkipRNzcsRIf1ZSPlJ0P6lrURMsGL2s0JKtui9KpEPpF48j+2
	 4OY2YgPd2tiWaWBzEkxOJWU+/qM3ft16x2fF0HseZK5ZrJjwr1MdFawlHd8oXUDDUi
	 PhW9rVzmwtLB4wZHzMvX1c7MwqsKE/kUiVALh7oUQnkHoRihF+9bl1edJtoeNhA5tE
	 0lln0yi05GlIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAD9E80E0F;
	Mon, 19 Oct 2026 15:56:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 63EF81DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55E0F40637
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:56:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a86N0lDg3SWA for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:56:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4BAF440636
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792425413;
 b=k3N1GH79ZRjIE2PlYZ9Mrfo4RnJ5xbNSgRjVOsPFDIyiKplyQRWcp0fUTau/hsIGZiWv
 gSDrHQP2a/pfivPF51JedRGofxT8gxGlFpOHbB62xn9DVd7iQPx4OagVMqeZPNub6mP21
 E39z7Z6a3qLAwOY3KAj4/XgdCR2BHfDY44d/w157bHSBfxM2scr/4C2qLe5lng24eejVR
 W3Wk+1lFc+e1diHGAQCiJ/EtjiiT88MIRComG0Ydn/Beso5d6fYOSnKyzo46hKOEZexc2
 SOIIdYlrJSPEtajMLvWYx+FUxMiCXa9j74VkSHl+pQI+56ZUfS7ySeSVUM/nYSU1V3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792425413;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=nK9wjWHY+niwQp5zH8bLxTh8YTnWL1CbG/PKMgAWy8w=;
 b=oANlV8afsWDkX55blA+DMLJqBW5IPGHgHOxTLo5CISZNP4X0QTlEndzz66D1Lz3phF9O
 b6lChaoyzuACJRjiNvZnLfBXdhGvEOzd+Gk7q5hL1lD2g4QxPMt+CX+uDopJ6O68RBxBp
 chC4/E9VbImMzzQ5Qq6YJvtwkJ3kXwyLdUj3/E2oh8EPUFxoZxUTskiW2igR6v9wJECm7
 gR3hATWmr8h25GcNtZ2bAjoKhqcOr1vnYDeTQjXT4Fnp7K5HDBvi1FWtYQKlLKbdskdbn
 SYWoVjca6Zdu4G6btLmkPqgxCMyYqIVZUjG2q0X7STWIxeicVsTdFgmtF2MJ1BNPMdw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=FjROgKxj; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=FjROgKxj
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BAF440636
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792425371;
 bh=nK9wjWHY+niwQp5zH8bLxTh8YTnWL1CbG/PKMgAWy8w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FjROgKxjFTvKq3fXOXVUIGJoF36xkpAk5tSPZQofZwUwKJdYCir4RXsS4IHCtUX0o
 eY3zxDVrw9lPMBPZyiga211aGXXxiYGAIoZI63LH4JlDHZpJ+6EGR4krI4j00x1Og1
 mQai98D0XzSNipqd/mDLa8Ragb2oiKNiTbJgfMOYBUZmUA22VAQJRjaP426DPz7bwe
 gPZ7LSb1eZgAdzz0etZAofQq+dRxP4Brc3DohgoMwU2b5C3Q8SRhKFDp218jDlYKwQ
 BScRFXTJqiySW7S32675MRAjtO28SS/+1DVFkWBcuXigyILv+OIzS8+SvfiW4Eq4eF
 l31ZR7vWFUX2A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7C041B220343;
 Mon, 19 Oct 2026 17:56:08 +0200 (CEST)
Message-ID: <0622671a-d353-45c7-aca1-13a64e9fad64@freeshell.de>
Date: Mon, 19 Oct 2026 08:56:00 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board: sophgo: Add support for Milk-V Duo S
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>,
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>,
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
 <20261016-upstream-v1-milk-duo-s-v1-4-e4bf386eea2d@gmail.com>
 <d61a5f4a-f7eb-496f-86b9-70aedcfe2e66@freeshell.de>
 <atYbKddK-LBPPBhZ@jpg-duosnb>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <atYbKddK-LBPPBhZ@jpg-duosnb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/26 06:31, João Paulo Gonçalves wrote:
> Hi E Shattow,
> 
> Thanks for the review!
> 
> I agree with Yao and Hiago. The sys prompt, build steps and
> documentation match the existing milkv_duo and milkv_duo_256m support,

I am not reviewing milkv_duo or milkv_duo_256m here, I attempt to review
your series and it is ignored. NAK, then.

> so I'd like to keep the Duo S the same (at least for this series). If
> any of these changes are needed now, I will send a v2.
> 
> I also agree that better documentation for the OpenSBI version
> requirement, the FSBL and fip.bin (with links to the vendor sources) is
> needed, but that applies to all the Sophgo boards. I can send it as a
> separate series later if the maintainers agree.
> 
>> -E Shattow
> 
> Best regards,
> João Paulo Gonçalves

Drop all my tags, I do not agree. Thanks -E
