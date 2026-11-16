Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E46606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=afEhAcLT;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=L/0vupdN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD7F580F34;
	Mon, 16 Nov 2026 20:15:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ov0vA532Mm66; Mon, 16 Nov 2026 20:15:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1271880DD3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794860109;
	b=nTWGu7bt+ycNznVS+DnhV8JZ34iEZ84akknqVyQWsD/lnTmDCQFHeuu4h0kqEOqhK1Qp
	 qkgu91FOgWU75WaJA0ZmABoz7QyJqqdE4gMQv2sKLYz256HVt732PTKCDMtSYjveYPoQu
	 b+Vk47MUKylC0fUolfnyRYNEujoFG2P/nPLV/huNZMbKQJCecuCiFCLe+wOYyWaXBuQv9
	 1RcLrCBoyugx9et9EX/ene4mX4KUoGtFqrlaDtlD3K1vHSWNBDcWtBGXKhtwolL1rJexj
	 YQOXWmt80tUOdmb24kDn8j0rDV03JSqFwfkMZ6ijQBTNL3u1A4KMiYJiRtuEgbch0hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E/XmXqU/K2bOPD+YsUtaP7H81NiZN7892OL8b5MT3YM=;
	b=ow+LhBpNC1rYXea3wdLWMaH/2J4fjIoB0c/hYT1OXqa7vDDXAiwBgPYHGk4QkNOX5Pof
	 eLNTmNd4SfZkXB/W2ydNxczCT9ua8h/hbcwfj1k88shRJdcluotTDByF/ObvxDHqtHznJ
	 QFuhJQy2Uefgz86kKq+nQW/jlWxqTQ3WE68L5Foku+PRzyPrDqt3KAz7F68O0S59Lc6nW
	 gP3cgz9ZijbY+atwrfQC/UwRNwj7troLKz0rM1v9z9IUt2PFCe0Xjolxje64kNNrknkfT
	 zqGTJ2goWR1RMr/jVDeAuESaGZY53OQdALosbw0U9MMG10DMCm/VJlQRvZT5qrwcl/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794860109;
	bh=E/XmXqU/K2bOPD+YsUtaP7H81NiZN7892OL8b5MT3YM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=afEhAcLTs0p9FuUeGOB7bR7Cv07i1iIzPPQiwd9jyweQUy2rQTZVUNkcGT49YudYa
	 UxBYVkE3XfGf2edpvbSFR5XQ/FlBYompBCc0HQLqzYLzb9I6arLDAaGqB0x9smz1Hd
	 R4nB0PxtBwiDp+oJnNH8bYWvNhve6G0qdFcVOJacA7TJdBzF4VyfjeZ2BOMGP2J3ya
	 urnTdJKmpqZRuGZmlZOqNXMllHwh8AHJT/h/4eRS/i/JASMYdjxaoiNkJ5NLzYBfkX
	 bJbjE0zAqCQlwp/MP7n4vF3W3NDUw6HUJfXpL6NVgaJ44ClXjDdm4qk5K8Rst/1FRA
	 nVBwk3T86Ioyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1271880DD3;
	Mon, 16 Nov 2026 20:15:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CE624DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EA19405A2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6jtfqKUXGvO for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C4C340588
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=wqu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=L/0vupdN
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C4C340588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:15:05 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b81214ab40so666256a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794860104; x=1795464904; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E/XmXqU/K2bOPD+YsUtaP7H81NiZN7892OL8b5MT3YM=;
 b=L/0vupdN7YEKsQGjlUJl2lah7XDZUsDGVVP3YakDEEW7FLm6vRr0EvqdbMFNw1utsg
 ZxOQeI475yhzL9+/g7QCiZHfMue6JzWWoDaBy1r37c/YB+J3TX/Jk0lgSMX50Y94JZ6k
 mFkb0z607QsW0vtWGqMFgtsK1GtPUCZJSXBWWKfddsB5IQKOaGP28joWAOUVOKl3kzCY
 tVB5XDBXqEF2VYyjcbySmENQurytgBQgcHnnO5owcr1VHDaxjYr5WYlbgDvSCdYYwQII
 Oadq1Lae8/urT23aq4gXPrLGpoi7L8RmDxGVbaN+0OPo9PW927KzE1eQbLgZt5iIhSoT
 B2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794860104; x=1795464904;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E/XmXqU/K2bOPD+YsUtaP7H81NiZN7892OL8b5MT3YM=;
 b=TgV3tovbNfGkR6vHubZvU5Tkd3+biGEs9WEDsB5FnEXGkuvdDj0yhXrPe9x3Z4+MSx
 ar7xkDPs1ZNaNVDcZZbSfj5YHYjS7Bp6xEPh5TAO5aJz6eeuk3uFWg3p0uCf7T4eQhPd
 7BhkOxlusgrBTRjWOmicULQjfYQVVT+2N+fGyiAsKLIse/3/T7hBp/XArZL00BVsA+Or
 xn+N5410gAi2d9hp3SwVwF1D13hwPBUo6X04EMh9OrhLAtGlnTG1BBkAhouNpbim+7+A
 kfEx4LkZkUHQ1f1PHCh5gs5J5XONXFSTP8vzPjpixRlxoHMsTzQ2xJKglEJevc8+JiYG
 J4+Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHT2ZxNaCOfuv9bp3/f6KMOmEmTCWOeXdHbVA1Bt5BcTheBCaJ4Kvyak1uDX6AhxH1+KFpOSOE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z80+cgBmjLCFfPW4DKhdSqB+W4R411LsEmQYrGb4yxRrrReLCBm
 hKyUs/jah/VbxPDLvUF8+CfgCnwhs2p/Vp29QgovnptU0vkHyjDwGJGxBbJs2cjzr6c=
X-Gm-Gg: AYBFou2x5ZHXPWb1Upmtp+E4+T+dvZfY5PVssPWuG4PygUq2NLImVnQR2m/2kl++SrO
 GLESWOnKjBHUqBeH2HaWxIRHT+SR5F0MxTLEydNjffmvGnCGNcsXqrurEHzE5AwYSRk95xuf4hn
 M96fZ0dTKH8iQhBMJGIUbh5/yV/7Pf9XAaM3AxNieVrO1wXpKddWoX3qv2UVAdHW32KLu/5Qtaw
 9I26XrGfloOFZrq2yNkPwqwamGEJLU2Y7GZj0gdXF6dUsaDIF7YyyhUb4FeqVULTulAJ5G9jtu5
 Zg3Jtjlxgtk6jk414Y4kv/Qr3qvmHrdT2s2/FeWf0EOkfhLGZfhcw+35Iy2atwxXGnFexwYEOhd
 yuvD+f2ndEj4CJhpZukT5EUYdio0kM1+97NaP0dFE20qfvL9M9l7kLgvlHa3gRAovAmsRwBY4CD
 WNXil78SCuRPmB0Eva/Eh4QlJ6OsEypyzq3Mimycg3YYtS/fPZtEYqWm7REB1PYm5c6YNOB9PMc
 NXmKPfkwBDysR9L4qN17aQaW1yq8TPpvg2WLBI218HYmikNJb8+XLENzBElAbZcJpNeKYPbXkOJ
 9G/r174hlP1sOUX5S1l4iw==
X-Received: by 2002:a17:907:6d0f:b0:c49:c3f5:8bc with SMTP id
 a640c23a62f3a-c50f34ebd25mr48012466b.10.1794860103520; 
 Mon, 16 Nov 2026 12:15:03 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac29a846sm612427a91.9.2026.11.16.12.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:15:02 -0800 (PST)
Message-ID: <deff7930-1571-43fe-8f05-0c576e115c5f@suse.com>
Date: Tue, 17 Nov 2026 06:44:56 +1030
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Five memory-safety issues in U-Boot filesystem/partition parsing
 (coordinated disclosure)
To: Dilip <dilipchowdary21@gmail.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, joaomarcos.costa@bootlin.com,
 richard.genoud@bootlin.com, alchark@flipper.net, sjg@chromium.org,
 kabel@kernel.org
References: <CAPmzV5kAUpHf5fGDHmQXnyDJxs=Kvgtks2ztva88pG2wj7m9qA@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <CAPmzV5kAUpHf5fGDHmQXnyDJxs=Kvgtks2ztva88pG2wj7m9qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/16 17:24, Dilip 写道:
> Hi U-Boot Team,
> 
> Thanks for all the work you've put into hardening U-Boot's image 
> parsing, the 2026 squashfs/disk crafted-image series was great to see, 
> and it's what prompted me to take a closer look in the same spirit.
> 
> I'd like to report five independent memory-safety issues, all in the 
> same threat model as that series: U-Boot parsing an attacker-controlled 
> filesystem image or partition table from untrusted media (USB/SD/eMMC/ 
> partition, and for some, a netboot-fetched image). I found them by 
> source review of master v2027.01-rc2 (commit ff8a9bc4), and each comes 
> with a minimal, self-contained proof-of-concept.
> 
> Reachability for all five is an everyday operation on attached media, 
> `ls`, `load`, `part list`, `cramfsls`, `btrsubvol`, or distro-boot 
> scanning,  with no signature verification anywhere in the path.
> 
> Here's the short version of each:
> 
> 1. squashfs: out-of-bounds free() in symlink path resolution (CWE-590)
>     fs/squashfs/sqfs.c : sqfs_clean_base_path()
>     A symlink whose target has more ".." components than its path depth 
> drives
>     free(base[i]) with i negative,  a wild free of heap pointers before the
>     base_tokens[] array. The `if (bc < 0)` guard only runs after the frees.
>     PoC: ASAN heap-buffer-overflow at free(base[-1]). Trigger: /s -> ../x
> 
> 2. GPT:  integer overflow in partition-entry-array allocation (CWE-190 → 
> 125)
>     disk/part_efi.c : alloc_read_gpt_entries() / part_print_efi()
>     count = num_partition_entries * sizeof_partition_entry is computed 
> in 32-bit
>     and wraps (even on 64-bit), under-allocating the PTE buffer, while
>     part_print_efi() iterates the full unbounded num_partition_entries,  
> heap OOB
>     read + partition-name info leak. PoC: ASAN, 512-byte buffer vs 
> 33.5M-entry loop.
> 
> 3. GPT: unbounded header_size drives OOB CRC read (CWE-125)
>     disk/part_efi.c : validate_gpt_header()
>     efi_crc32(gpt_h, header_size) runs on a one-block buffer, but 
> header_size is an
>     attacker-controlled le32 with no bound (Linux rejects header_size > 
> block_size),
>   a multi-GB OOB read before the CRC check. PoC: ASAN read past the 512- 
> byte block.
> 
> 4. cramfs:  heap overflow in symlink/data decompression (CWE-787)
>     fs/cramfs/uncompress.c : cramfs_uncompress_block() (+ 
> cramfs_uncompress_link)
>     avail_out is a fixed 8192, unrelated to the malloc(size+1) 
> destination sized from
>     the inode's declared size; a crafted block inflating beyond `size` 
> overflows the
>     heap buffer with attacker-controlled content. Present since 2003.
>     PoC: guard-page SIGSEGV at the allocation boundary. Trigger: 
> cramfsls over a
>     directory with a symlink.
> 
> 5. btrfs:  heap overflow in subvolume path resolution (CWE-787 / 120)
>     fs/btrfs/subvolume.c : get_path_in_subvol() / list_one_subvol()
>     strncat(path_ret, tmp, PATH_MAX) accumulates the path across the on- 
> disk ref
>     chain with no total-length bound (strncat's size arg bounds the 
> source, not the
>     dest)

That's the biggest problem here, unlike kernel which has VFS layer 
handling such overly long path, here we don't have anything that limits 
both the source and destination length.

What we need is strncat_s(), but it's not provided in the current code 
base, so you may need to create a dedicated helper.

Thanks,
Qu

> and no depth/cycle limit.  PATH_MAX buffer overflow via deep 
> or cyclic ref
>     chains. PoC: ASAN heap-buffer-overflow WRITE once the path crosses 
> PATH_MAX.
>     Trigger: btrsubvol on a crafted image.
> 
> I've attached a full advisory for each one with the exact root cause, 
> reachability, PoC output, and a suggested minimal fix. The PoC sources 
> are self-contained,  build with `gcc -fsanitize=address`. I'm also happy 
> to send the fixes as `git format-patch` against master if that's easier 
> for you.
> 
> Attachments:
>    advisory_uboot_squashfs_symlink_oob_free.md  + sqfs_poc.c, evil.sqfs
>    advisory_uboot_gpt_oob.md                     + gpt_poc.c, gpt_hdr_poc.c
>    advisory_uboot_cramfs_heap_overflow.md        + cramfs_poc.c
>    advisory_uboot_btrfs_path_overflow.md         + btrfs_poc.c
> 
> I understand U-Boot discloses on the public list by default and that the 
> project doesn't enter embargoes, so I'm sending this openly. I'll 
> request CVE IDs from MITRE myself (one per distinct root cause) rather 
> than ask the project to assign them. I'm happy to send the fixes as a 
> git format-patch series against master and to help with review, just let 
> me know what's most useful on your end.
> 
> Thanks for your time, and for maintaining U-Boot,
> Dilip Mallavarapu
> 

