Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A681C79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 14:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E314080D39;
	Sun,  6 Sep 2026 14:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zJ5hfusZaTBe; Sun,  6 Sep 2026 14:20:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DF39280D2B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788704437;
	b=hGKUuf+wZpY8Rl/14Eamel5SL0ixPx0Y+0VtVdMOxsFxCf/WVkG4sN+2MTw1SK52A8oZ
	 AsHhhRIojiCGfQpyBI8rDdahjVDtXxlSQYi8Yumu4/qu1eohxooiKg4xgRJAmFXl2BJTf
	 RLWH7QmK1ceES+YpPiBmcg+l2dSYNlmhufdUGQvDkWEc0OdyqX9he08NcX9nTS8hT4jl7
	 jXQPmMZnSSZvENqWYZNiltarHQqk0FVKkeEO+gEyGNRV9sBUFG8svTy68n8r66dWAhzxR
	 phr0PVov804/2GRRRV+Dc4ZtrAjB9TRTEYqAg+mRlRjc3eGssxQTLqEZSmp2GVH2+5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788704437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=n0XdUZfmi8E4Y7fvVKVnCIjytdWEdNog6K2me0O8+Fo=;
	b=MYwdX0i6jU5KanAB0BPOQepFaCySU+MBKHOrvwoH9/jhAjKGWzhjjhcfCoyL9GJXSkKT
	 52k1iR4RcEJcxcrS1H5BWQl+P5vzWrtI0ePolPE74wvqG+l/ur61b3GUyLOfAVAhHXvDh
	 ErKv0dpDDxc0p1/FRZ9IEJLkPfuXM8rtxQE0/EgpYyBEUDTFHeToNYkwoMkjLno6ugzu9
	 8rudQnow/d9XVx0P/G3J6WpWgKNfAZTZNkhJfugEppc8ZqysVRfpgWOCloLgnJe/5cBXz
	 62ME5Z7SsVB/roGiuH1WAd9m7ri2OX47phOJBTdQFJFkvqcGdVpJ2XDJSF+9IKM8tpw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=permerror header.from=rootcommit.com;
	dkim=temperror header.d=rootcommit.com header.i=@rootcommit.com header.a=rsa-sha256 header.s=dkim header.b=Pyz7lXwZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788704437;
	bh=n0XdUZfmi8E4Y7fvVKVnCIjytdWEdNog6K2me0O8+Fo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gw8Ep7HVoCNdpxjDKPSQBmJzLhy6LfEnbyhNaqc19I2KjbursEh07QwaFw5QppTnD
	 z6TabiRybxgODbtRR2U+iFLqPn2di8LD0v+A2uU7lds1e+cI7n85OODE8VFY6kasI1
	 o0weD1JpByBJzNo4R9iHEHZZorfe17RcBYn26L+UGFPYxQa9sdb7oyLiNxJkC7yWYu
	 tJTobvskhCz/jPZlakenOOAww+Uxhp8DuSsJK7Q8+UbfBiVBNSiDTwJvgRB1x4+lEr
	 /860it8ZO40I0wofrNBEc2gxxhEMNZJS9oKBUJb/3VA4Rh/cxgpjlomLHgXnN5C4KV
	 Z6t4z1l/rXntA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF39280D2B;
	Sun,  6 Sep 2026 14:20:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62D229CF
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 14:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5459780D2B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 14:20:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRkW0ihTbiR4 for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 14:20:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A306380CFE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788704434;
 b=iMCWWH9rvU4PQDKTW/NGPB06PAQMFCOqGb4xcOg7LiuFuMISgoT13JdN5LsLYL8paQw/
 bbXHUvemYI5BO2Sr4BN9n9+rVj2cRLKEAaItFTG5m+/r2dvKJiA8NniwjzDv+cRK6Yf/Z
 KROOqoDI/TlDU1qkBdsze72ZshqJezIPM8g4AllCmuOp6my4r8RemsXQ+0XGqgZBA2l4Z
 xNerSAqGrbm+XMEpL1hK9Zw/JjiorKDAZiH+ChiFfaxVmNfBucxz6bXptoVgkalSHGB+b
 DcmAO7fcAtKB4/4Tt6CgntrWsW9zfCoowAR+KEwh41x3c+GDaHmE2TsD7UQrXbF3vvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788704434;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Autocrypt:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=n0XdUZfmi8E4Y7fvVKVnCIjytdWEdNog6K2me0O8+Fo=;
 b=hKJWmWHu3awcJzToRf/ulY7PM3oCkhA+j7+E1XMXSCE7e10tI5ZMZbbfZJUPDw4LBkid
 BpAf5ruyIAmu4JzQZnuRWU5AOqsYraMCl6YEFrZtDGsse/L7dDHZw5u4D48V/G/64c2hi
 QLhrEraO715/GHc0kOYQUCmc7KtBTy/jGX59x2ahrQ+cZNKgrb0/D0qNYbaloZ5DD2I10
 X6UGX5J3g7Q0Kshsx/2WgUI1aIlLKTZ+rXyhJ+WxO+FZVfw+kiK+hlderpZ8sQFWNjvld
 ZMAqnJAVDAilZ1qDPG0uDQ5O//gp243Bi94lXP0N5abowbaEiqo/d/NnUMZa2nX5RDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=permerror header.from=rootcommit.com; 
 dkim=temperror header.d=rootcommit.com header.i=@rootcommit.com
 header.a=rsa-sha256 header.s=dkim header.b=Pyz7lXwZ; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=michael.opdenacker@rootcommit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=permerror header.from=rootcommit.com
Authentication-Results: smtp1.osuosl.org;
 dkim=temperror header.d=rootcommit.com header.i=@rootcommit.com
 header.a=rsa-sha256 header.s=dkim header.b=Pyz7lXwZ
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A306380CFE
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 14:20:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 25D1F4E414AC;
 Sun,  6 Sep 2026 14:20:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E531A60288;
 Sun,  6 Sep 2026 14:20:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 740AC11C79850; 
 Sun,  6 Sep 2026 16:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
 s=dkim; t=1788704425;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
 bh=n0XdUZfmi8E4Y7fvVKVnCIjytdWEdNog6K2me0O8+Fo=;
 b=Pyz7lXwZgOMWdUmeejfxXkn3viSsNwYI8ZotCQhGOqZx7/G7JjmqWW0zNWEtPuBXOdrQwt
 hJ8TNqppEAVh1dJo+gkWl3vDQ1pxzzh3zjSVYIcKzlrCC3oSyLESMguKrecLYtbKmvD3Ar
 XD8fKi+bSE+JxTirD4CzSFgAP3lDxAlS1mKgnYKmuaos+dH3ie1Ao2jWJbv2T71wIniR8a
 mbvFd61xWYscXP+s9pb36xf/s2aN71j5sL6HyohOj3NL6GaaHYAzyRShQY6jOWoYyrMFwj
 0V0LsulcPjmPvK26p9AfbzMPx+Dnk19k5c3+GNkoz28Gu+hiAq2wVCChZgNJJA==
Message-ID: <9c92963c-4a46-4052-ad3c-d9a4852b818e@rootcommit.com>
Date: Sun, 6 Sep 2026 16:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Subject: Re: [QUESTION] SpacemiT K1: Incorrect RAM detection with unpopulated
 CS1
To: Alper Ak <alperyasinak1@gmail.com>
Cc: michael.opdenacker@rootcommit.com, me@per1cycle.org,
 ycliang@andestech.com, u-boot@lists.u-boot-project.org,
 Marcel Ziswiler <marcel@ziswiler.com>, Trevor Gamblin <tgamblin@baylibre.com>
References: <CAGpma=6KqYJ_TB+qNZJjc0anTb5WmRW6ikjG-SjbVfBsOk5pZA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGpma=6KqYJ_TB+qNZJjc0anTb5WmRW6ikjG-SjbVfBsOk5pZA@mail.gmail.com>
Autocrypt: addr=michael.opdenacker@rootcommit.com; keydata=
 xjMEagLVOhYJKwYBBAHaRw8BAQdApKjypQYDpk7gc2tKU7srAaN/v2wqp3zsRtrICl5tMarN
 Nk1pY2hhZWwgT3BkZW5hY2tlciA8bWljaGFlbC5vcGRlbmFja2VyQHJvb3Rjb21taXQuY29t
 PsKQBBMWCgA4FiEEHltE0IOQ91GyZqTazXRqZ2jNCaAFAmoC1ToCGwMFCwkIBwIGFQoJCAsC
 BBYCAwECHgECF4AACgkQzXRqZ2jNCaAK/QD/fCa/2kPEcJYpt3XjoXUFC40rV5p92/Mn/CcV
 cDDLTNcA/19zgdNIKAqVOaJAcLwhBjCCIZJfAQ80CuPOdGRR5NMGzjgEagLVOhIKKwYBBAGX
 VQEFAQEHQCujvLLf/3B2yAjCRJWU9BUta58RTcZ9ZYYxzsOBj5FmAwEIB8J4BBgWCgAgFiEE
 HltE0IOQ91GyZqTazXRqZ2jNCaAFAmoC1ToCGwwACgkQzXRqZ2jNCaAWEgD/SY55n6h+sq1u
 /Kdbsd4z+uOz2+0Z9V0HtrYLdfgdBTIA/0nuXShti770G4hZDQD52XLANSdPbO7hbwmpNKHm y3UE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Greetings,

I'm reviving this thread as the issue Alper reported in December is 
still there...

On 12/22/25 1:32 PM, Alper Ak wrote:
> Hi,
>
> I'm working on Orange Pi RV2 board which uses the SpacemiT K1 SoC. I'm
> currently using the bananapi-f3_defconfig as a base since there is no
> mainline support for Orange Pi RV2 yet.
>
> The Problem is U-Boot reports 4GB RAM on my 2GB board. I think the CS1
> register shows enabled with valid density even when no physical RAM is
> populated. This causes U-Boot to report double the actual RAM. Also,
> If I don't set "mem=2G" in the kernel command line, it causes a kernel
> panic.
>
> I'm sharing U-Boot, bdinfo and DDR register dump output:
>
> U-Boot 2026.01-rc4 (Dec 10 2025 - 15:28:43 +0000)
>
> DRAM:  4 GiB
> Core:  21 devices, 9 uclasses, devicetree: separate
> Loading Environment from nowhere... OK
> In:    serial@d4017000
> Out:   serial@d4017000
> Err:   serial@d4017000
> Net:   No ethernet found.
> Hit any key to stop autoboot: 0
>
> => bdinfo
> boot_params = 0x0000000000000000
> DRAM bank   = 0x0000000000000000
> -> start    = 0x0000000000000000
> -> size     = 0x0000000080000000
> DRAM bank   = 0x0000000000000001
> -> start    = 0x0000000100000000
> -> size     = 0x0000000080000000
> flashstart  = 0x0000000000000000
> flashsize   = 0x0000000000000000
> flashoffset = 0x0000000000000000
> baudrate    = 115200 bps
> relocaddr   = 0x000000007ff81000
> reloc off   = 0x000000007fd81000
> Build       = 64-bit
> current eth = unknown
> eth-1addr   = (not set)
> IP addr     = <NULL>
> fdt_blob    = 0x000000007ef5ed20
> lmb_dump_all:
>   memory.count = 0x2
>   memory[0] [0x0-0x7fffffff], 0x80000000 bytes, flags: none
>   memory[1] [0x100000000-0x17fffffff], 0x80000000 bytes, flags: none
>   reserved.count = 0x4
>   reserved[0] [0x0-0x7ffff], 0x80000 bytes, flags: no-map
>   reserved[1] [0x7df5b000-0x7df5dfff], 0x3000 bytes, flags: no-notify,
> no-overwrite
>   reserved[2] [0x7df5ed10-0x7fffffff], 0x20a12f0 bytes, flags: no-overwrite
>   reserved[3] [0x100000000-0x17fffffff], 0x80000000 bytes, flags: no-overwrite
> devicetree  = separate
> serial addr = 0x00000000d4017000
>   width      = 0x0000000000000004
>   shift      = 0x0000000000000002
>   offset     = 0x0000000000000000
>   clock      = 0x0000000000e2b328
> boot hart   = 0x0000000000000000
> firmware fdt= 0x0000000000279b18
>
> => md.l 0xC0000200 1
> c0000200: 000f0001                             ....
> => md.l 0xC0000208 1
> c0000208: 800f0001                             ....
>
>
> I think this seems to be board independent and appears to originate
> from the code at "arch/riscv/cpu/k1/dram.c".

I have the same problem on my OrangePi R2S board with 2 Go of RAM. 
U-Boot believes my board has 4 GB of RAM. It seems most K1 boards should 
be impacted!

This seems to happen because the code in arch/riscv/cpu/k1/dram.c 
unconditionally adds the value read from CS1, even if CS1 is unpopulated:

phys_size_t ddr_get_density(void)
{
     phys_size_t cs0_size = ddr_map_size(readl((void *)DDR_BASE + 0x200));
     phys_size_t cs1_size = ddr_map_size(readl((void *)DDR_BASE + 0x208));
     phys_size_t ddr_size = cs0_size + cs1_size;

     return ddr_size;
}

Looking at the corresponding vendor U-Boot code [1], this is conditional 
indeed:

     cs0_size = map_format_size(readl((void*)0xc0000000 + 0x200));
     if (ddr_cs_num > 1) {
         cs1_size = map_format_size(readl((void*)0xc0000000 + 0x208));
     }
     ddr_size = cs0_size + cs1_size;

However, if you add such code and set ddr_cs_num to 1, this works well 
with my 2 GB Orange Pi R2S board, but breaks my Orange Pi RV2 with 8 GB 
(U-Boot seeing 4 GB instead of 8 GB).

How should we address this issue in a clean way?
Note that I've done my tests loading mainline U-Boot from FSBL.bin built 
from the vendor U-Boot code.

Thanks in advance for your insights.
Michael.

[1] https://github.com/orangepi-xunlong/u-boot-orangepi.git, branch 
v2022.10-ky

-- 
Michael Opdenacker, Root Commit
Embedded Linux Training and Consulting. Yocto Ambassador.
https://rootcommit.com

