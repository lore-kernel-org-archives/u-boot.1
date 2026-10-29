Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0502606A324
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oJ+m3GWX;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=ahsOXfZm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FE6A60668;
	Thu, 29 Oct 2026 16:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQn_3Zq0F7l0; Thu, 29 Oct 2026 16:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C819D60710
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291703;
	b=WWSpMMDWYQXQyd+r46wp/Ccp8GH1ruZxl8jvFKVD4ognvffHJpCl0yotAHa7KnoKAWwd
	 48I6dtzuFAKc4y2SB+ksvBFSZgjyhYVgL/weZPL+Vaq22UGo5GA0SSq8M4pcr2hsFxjT9
	 KyXJ+bXjjcCMrdqXiP/Lbik4EiH9BjwLDLTzu74PgurSypx7WZ/mKbWuQ6du2OONfEIng
	 9G31VKCWDYi5QgG0IwYUhBMaq967S2nqrENG7nfI2uh24BNeSYKYCNrTpHBBxTiDjUg5n
	 Kdcvchdl1OrXa9jwlQAKtcn8WWNH6nJgvHC01eJj+kIfwHsqmYIu8rGMn8mvQXTFyxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9JZ2W3+tVCJihEiJ/hHbj83J3Nuv+GC9WaHVdQRQBVk=;
	b=mQ9d/Z2tcjxaeLOtt9fhENET0F5ZxLDSm/aesnRXw7oNSA0hYj6VcMQDZvqEvzus08ES
	 1N47j5VBlbaJ74blfN933vA18Ib11ZpxEagHjXFzvl0xsvwoXCmWrVKNASb+OvykToYvA
	 V1+3FRVT52fQ+R0aF+TMPz352XZWX8HezyCxBYi4olIqYHlSNgPVZAB0Mp4sQmKtIhFyc
	 o16qdRpDTX0eDy4WUpige1LITBJ8fANvFX90iv/RHfqhmcUHDFzRjHGvEJShgWXb6iRnl
	 hs/E+E04FTFaTRMhCSlBIBO80bn6ncm1j/c7nWL9qyTSqSpjdbeRj0oQZgv2vPN+L4A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291702;
	bh=9JZ2W3+tVCJihEiJ/hHbj83J3Nuv+GC9WaHVdQRQBVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oJ+m3GWXyPXcAja5zyyv69E3W1SZRGTTZ28sCgn4Hj62vTwzrTbWNNHaPUV+Z6aaF
	 rrSqjGqdrwQZbd0CQZdvi46xTWwFcNrqxJVTs083nzYf8jR5gE/jP07eBypQCyLEGI
	 J1XYZ9JJASDd4BTs2VzVibq+3zUrFEzQ38C+GSnJ7lby3XWG7FnwnHUb2miUBaMUle
	 qx48JKvO/RDOlUl2+C2M22RSR7gkbMj83rznJj+tV2j58dMHO3DyenL8hGmRZnfctq
	 sQUR1zG8eOlP1C0AE8EExn6HkhSHtkb0jw9ndP9DxF74ORW6ztdT2U5fychqGZoG/Z
	 TxW7CdZrq4kDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C819D60710;
	Thu, 29 Oct 2026 16:35:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C1E87DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B40C28100B
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zDvUNyFsMgFl for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:34:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B80781000
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291699;
 b=rZOR1UD7jpcZnKOF+ssOeLz79xAlKZOj5giZDfQ/VJZNPmsFVQL5Io/3DvzsNYfQzu6D
 /5I81FQCYP8zM1l9wZ8XmYjNaxK4wLzE30E+B0yG8vZGVRFQ8sCDn/x2/7re6NIM4G2ZI
 W3oB9cQq36MdPOBuU3pfNQvexwzgHiUC4V77R5JQfLF3/0XUBVANO6BrExp7xUhD1s2WJ
 8Htr+urEdhxbWpiKLdhTovZY8ooIok8X3tNf1egh72pdRoEaCiEekNoiblkZ7CnmIchj1
 9xGW87KnLPtKrgQpw3FLI2jOEvrsPOeGZbW/jltl2YHeXaAAi1P7U3L74T2ay4c+HSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291699;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=9JZ2W3+tVCJihEiJ/hHbj83J3Nuv+GC9WaHVdQRQBVk=;
 b=THVG0EFoNtW7XKZUkPvLKbwpmlE8NX7HvdzyEZwhb2K+VUl+gDvnLXqFe/wwxIAnMucA
 DZl0jY2Z+tG9q8mopkprDZDct2KDfPSZyeaTLGoxKCQo43xOlwzPF2d6SpBy3/ZAcoifI
 GYUguyUA+9Cq0R4TM4wjgVSRJbmEQdLarjr4txJ5YHesAPi6kvD1eqAKBkhKq9Ah0FX5b
 TB+o3shvAOeTIY7DjNEws7ncYj9+X3r0bnwI8MP0NsUcKtOmT9l0v9j4ESz/ecYRV7PjS
 XDNpNC6uGmejH+O396gF761IEO0FiR6aUF5LVunu7r4BIW9b+YBFGaFgq7JHuykY7kw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ahsOXfZm; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ahsOXfZm
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B80781000
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793291666;
 bh=9JZ2W3+tVCJihEiJ/hHbj83J3Nuv+GC9WaHVdQRQBVk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ahsOXfZmw7htP3ZwsagB15vfe/w90RhhEwLPJWB021kCUcGLQAKywo9WMVAmd7ci5
 HOKGrw6ogYHhjyiTJGL7Xt49X5Fc3YCsLQRBeIFg4zCFkMm5RhQYLAaLvFRc13fuiP
 ZTdHMI+bGLVmZKN4CSNEkYpcbnu50MIg/75eoQoTF4zlA5cIASfTKPp7ehBw3uXqzh
 YtdzCLCE6WcJ2SRp5wraxAo9+Gpafr+NwBgsMpaLc3aZSvZJgKw1o02wiTG3Y0m0Oi
 uQD3A0qC8+Rf5Vo81nrfiLK+qz9bZOlDy7kQP156WaxixKaJYTJ8Yo8hHoQ3uVoU3z
 SdlIWzO1eLBjg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3D51BB22087E;
 Thu, 29 Oct 2026 17:34:24 +0100 (CET)
Message-ID: <3ffc60b9-afe1-4ce4-957e-570964558d1d@freeshell.de>
Date: Thu, 29 Oct 2026 09:34:10 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] riscv: dts: spacemit: k3: override reserved status
 of mimsic and maplic
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>
References: <20261028184526.1887640-1-e@freeshell.de>
 <20261028184526.1887640-2-e@freeshell.de>
 <alg7jxkvt36hyizau2ory5w3u4vxpxxrdakxbijc5vayxfuu5w@gn4rhdoofozp>
 <d4fb0fd4-1452-448a-9889-30495e8f5b77@freeshell.de>
 <DMH42XA23X2U.VK02RL7ED7O2@linux.spacemit.com>
 <CAEev2e_TMX_eg4jGPf9hQSKNU6BpU-Ke4RHEDMqZNVRBWyn0vA@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAEev2e_TMX_eg4jGPf9hQSKNU6BpU-Ke4RHEDMqZNVRBWyn0vA@mail.gmail.com>
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anirudh, Troy, et. al.

On 10/29/26 07:22, Anirudh Srinivasan wrote:
> Hi Troy,
> 
> On Thu, Oct 29, 2026 at 1:37 AM Troy Mitchell
> <troy.mitchell@linux.spacemit.com> wrote:
>>
>> On Thu Oct 29, 2026 at 6:35 AM +08, E Shattow wrote:
>>> Hi Anirudh, CC: Troy Mitchell, Guodong Xu
>>>
>>> On 10/28/26 15:01, Anirudh Srinivasan wrote:
>>>> On Wed, Oct 28, 2026 at 11:45:05AM -0700, E Shattow wrote:
>>>>> Linux boot stalls when probing peripherals unless OpenSBI has the
>>>>> enabled mimsic and maplic nodes. Override these nodes so Linux can boot.
>>>>>
>>>>> Reported-by: Yixun Lan <dlan@kernel.org>
>>>>> Signed-off-by: E Shattow <e@freeshell.de>
>>>>> ---
>>>>>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>>>> index 352e85e7de87..278b36acc79f 100644
>>>>> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>>>> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>>>> @@ -3,4 +3,8 @@
>>>>>   * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>>>>   */
>>>>>
>>>>> +/* Override reserved status of mimsic and maplic for OpenSBI */
>>>>> +&mimsic { status = "okay"; };
>>>>> +&maplic { status = "okay"; };
>>>>
>>>> This should be fixed in the DT in linux. I guess you could carry this
>>>> patch till it is fixed in linux.
>> I think status = "reserved" in k3.dtsi is correct and should stay.
>> The DT spec defines "reserved" as a device that is operational
>> but should not be used, typically because it is controlled by
>> another software component such as platform firmware.
>>
>> That is exactly the case for the M-level IMSIC and APLIC.
> 
> The DT should be a description of the hw, not just the bits that linux
> cares about. This is why I'm asking for this to be in the linux DT.
> The changes that E is proposing here will have effect in the DT that
> u-boot passes to linux anyway.
> 

The mainline OpenSBI series supporting K3 has now landed. As promised
I've sent a patch upstream to Linux so that we may continue discussion
about the required mimsic and maplic status there:

https://lore.kernel.org/lkml/20261029162343.1896134-1-e@freeshell.de/

>>>>
>>>>> +
>>>>>  #include "spacemit-k3-binman.dtsi"
>>>>> --
>>>>> 2.53.0
>>>>>
>>>
>>> The upstream commit that adds these nodes as reserved status is:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56f37e391a626
>>>
>>> Quote, "...Also add M-mode APLIC (maplic) and IMSIC (mimsic) nodes to
>>> represent the hardware topology and ready for potential firmware usage."
>>>
>>> When the mainline OpenSBI series lands adding SpacemiT K3 support:
>>>
>>> https://lore.kernel.org/opensbi/20261028-spacemit-k3-v6-0-01d984f60941@linux.spacemit.com/
>>>
>>> ...then I think we could send this upstream?
>> Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>>
>>>
>>> Thanks for the review, -E
>>
>>
>> --
>> Troy Mitchell
>>

Thanks everyone for advice about this, I think it will be okay in any
decision about whether to change this in devicetree-rebasing upstream,
to carry these changes here as-needed in U-Boot for passing to OpenSBI.
Let's get consensus with discussion on LKML and then if there is
something more narrow in scope needed that can be done from U-Boot for
changing these nodes to pass to OpenSBI, I am open to that possibility too

-E
