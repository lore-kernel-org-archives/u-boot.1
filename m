Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A676CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 859D740501;
	Mon, 28 Sep 2026 22:00:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7h53x_c8BvkD; Mon, 28 Sep 2026 22:00:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B63A1404E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790632853;
	b=cV8of2LBZ38qM7jOFXMvNCzxatkzDC+bU8IIEC+E6h3+4IDa1w5yPpOKUB3x8IcSqNJ9
	 gjw+X3vVQ8AzEtn7hcK2jr1qo7Cdy9+0oZDWveMga9Mjw/UeUmqEnpovJbStde/bj4p9W
	 Vj3LoS2LmcVngqytQBTxOL7EZHRcduK1i4bkY7CnY0bwsmVwkrrjJEDVeY9JIe1Vsuf73
	 L4zikjPfDx+/QLH5SU+79WJ4EZZqqB0u2r3mRP1kRWokL+1svWehNb3nP8YlWeBPQ4gkW
	 mVdVyVVc6qyZL71qr4KbXC7RGT2V+sDKJlNqrn+lUhT2ToJZUI0MfIVRC5YZtuRKf4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790632853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jwRdipBmLyRo5rXAvtQEE8Md41cCIt8NUua1y4pi3W0=;
	b=AZoMIxbSKWNFJDmgKkRVPstqzourrrbbpmHVQj64XmqqrI82gnlT3okFeTtiYYPXsTdE
	 ShY89s77w8aW+C+V9nxTjliOEV11kgzCpThwlbpDXi2KRA8O+Ft3/Ss3IlA6oAdWfnV3h
	 J2k/fFBHmP6TajPR34CRBpaqZIqUGp8ljn60jBjqDSOSbYgAN8kFlHaEIs1YPhtys9SW6
	 WLlOTTqgCH9lIzEBNO/G/QNuLLDImfB0HSa/nFuHvgoUzEKyP37nlR8If9V7b69wAtais
	 vMibWUveR8BLoZAM72ifTNGmxBuOWoJIuRGBSTGe7jIcDNVyY8gH1GuKcGayfXJEPMA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=KWVrpW1s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790632853;
	bh=jwRdipBmLyRo5rXAvtQEE8Md41cCIt8NUua1y4pi3W0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uNaIgvkrgAlrFbWKRzBIhHWOBcKcdiDZx+OzHrlMReYu41D04veo4aAw/eHd5QgG8
	 50+6K2MBhIuZxEQLRyhuSG7af+kBThnL/9CXnOHykRVWjg8O8l9vwkQ+mYB0/3wAF8
	 /Sn7hWQdlJ/dASy7O4eQiiOKsAcVYEBAnVUoB0UXlLYljFqJ7yIH0YYyjEVNs8fV8K
	 4rPGNSjJJRrk5/Yc7pkWiFcjNME26fiC60csuVRixsHqUUdnep8kqmNzoe0Nc0U9Vy
	 vVa7jy1NtOMIQNpNa+sfeQVS06yQDfdADF3GgEAV+Jmk8EfPqlmyMUNk2toMUlZFTv
	 n6BpZVLj/uaiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B63A1404E8;
	Mon, 28 Sep 2026 22:00:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D4F0572
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95E2A404E8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:00:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yl4pyHbPEDUP for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:00:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D584B404E7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790632849;
 b=FnShtddsnoE33GTLCpTyCgK42KJNSDKckTn4n7OYadTalGgIyrBw5a4AQ24L1BGlMIdc
 mFaIbcLCKSLyCT/j3mTGiwjtQDlnJTcn/9X8ZmIsZzQ0kdxJHxuf/TQy2TSFYU190udA5
 cS3nkZcNA7Qa8tXr4qlntq1s2PoxTJG0pD2np+5U+TdITU2BTPIlAytxiTRHr0WteEk4q
 J28ULCM8EhFzCCG601zsgu41Qo5DcScUimxuIE/fKMzoaYmkra+rOfwm2site9Yv4oYOJ
 IsQcmjIgiMVK0Fdp9t0YfpWq21RVLP0p9zyANTgq9VGDEQYg4CyXesieLmaXPZLzlww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790632849;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=jwRdipBmLyRo5rXAvtQEE8Md41cCIt8NUua1y4pi3W0=;
 b=J3+CUqZZxPy7P9FhcoetVh0jIY04W+skcRIN4Saiy9gHP+oPNenTHbqrrE+oUnQRnkm8
 6A1GUNQ5lcsW0Xs/bsomCGlr9YvTYItkAt5cFJOcphe4OqukCn2n7mYQuOkD3lCutneUI
 1pFIeS/vvs9CDFUr5kUMO0dkAImYAiKfaFtJweBCYIMyGMBLALmVl3vyF9aqRN29I6BpN
 wTxhDIot3LPseMuYpNfMA6MJoXpYd8OFDu7beFvtnMGfltnjK8X7tbCAM/lsvyEj8txU2
 o7Bv4x9XEbfwswRm8VYfeMmyeTe5bcGYuHT4GPTfm1jtwms9pJRHbt0IA6BVLCoVDvg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=KWVrpW1s; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=KWVrpW1s
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D584B404E7
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790632818;
 bh=jwRdipBmLyRo5rXAvtQEE8Md41cCIt8NUua1y4pi3W0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KWVrpW1sUyhD7ggVYqfojYJHfiLIFzr3ucurV5l3d8MX4zBMuaqe6YhI034oJi2rM
 Om3rMB8adm03Zxu+NWW9tnGTIdFOfsx8LcPZTtK0oPsHBYk3w7lNdsnTcXBUIK/Qx5
 oIt5Tr/AaSWvd9WNkOQbvY8hoUiNG+Rg87p3phH2yDQzwC/hCETdP/TIxXX7tx5oZW
 F4BJfXE9JUp3Xodsf5ymv/j6zGQ2MF8w+rFys3gb3GmrwzQi7d04IeZA8Shy8t8E//
 mNVT08C/Pys48zW0NJwpu//5+ShOdiGS8Xo+q1heHukApnvrsWLdQIOEdpIZCRnl95
 0zEtT4E3f89oQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6F753B2208BF;
 Tue, 29 Sep 2026 00:00:14 +0200 (CEST)
Message-ID: <773e462f-7296-4b21-b090-ff1f27c10f6e@freeshell.de>
Date: Mon, 28 Sep 2026 15:00:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] efi_loader: bootmgr: preserve a passed devicetree
To: Carlo Caione <ccaione@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, David Lechner
 <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.u-boot-project.org
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-1-016658d0b6ba@baylibre.com>
 <2858ec5b-40ea-494d-8566-64eea06a1e89@gmx.de>
 <arrMZNzoS0hrDuSG@macbook.homenet.telecomitalia.it>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <arrMZNzoS0hrDuSG@macbook.homenet.telecomitalia.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/28/26 13:33, Carlo Caione wrote:
> On Mon, Sep 28, 2026 at 20:45:37 +0100, Heinrich Schuchardt wrote:
>> On 9/3/26 15:09, Carlo Caione wrote:
>>> An FDT explicitly passed to efi_bootmgr_run() is currently replaced by
>>> the FDT referenced by the selected Boot#### load option. This makes an
>>> operator-supplied devicetree ineffective whenever the boot option carries
>>> one.
>>
>> Hello Carlo,
> 
> Hi Heinrich,
>  
>> I do not understand what you mean by the term "operator".
>> Do you mean the end user owning the device?
> 
> Yeah, not a very good choice of words, sorry about that.
> 
> By "operator" I mean the user explicitly supplying a DT for that
> invocation, for example with `bootefi bootmgr <fdt_addr>`
> 
>> What makes you think a device-tree entry in Boot#### set by the user owning
>> the device should not take precedence?
>>
>> I cannot see any justification for the change in the commit message.
> 
> The use case is a one-off override: load an alternative DT, for example
> for debugging, while using the existing Boot#### entry to select the
> EFI application, without modifying its persistent DT setting. Currently,
> the explicitly passed DT is silently replaced by the Boot#### DT.
> 
> My intention was to make the explicit argument override the stored
> setting for that (manual) invocation.
> 
> With this patch and patch 4 the full order is:
> 
> 1. Explicitly passed DT (this fix)
> 2. Configured firmware-owned DT
> 3. Boot#### DT
> 4. Distro/ESP DT
> 5. Existing `fdt_addr` / control-DT fallback
> 
>> The series lacks documentation which describes how device-trees are
>> selected.
> 
> Yes indeed, I'll document this better in the next revision.
> 
> Thanks,
> 
> --
> Carlo Caione 

I understand the need for what you describe, however the method of doing
this is also not clear for me.

When I have encountered this situation the workaround was to invalidate
the 'model' compatible property in the tree to prevent a later match and
whatever process from installing a different Fdt than what I wrote on
the 'bootefi' command invocation in U-Boot.

An example of this is the Debian Linux 'mini.efi' netinst
debian-installer on riscv64 architecture. The 'mini.efi' contains dtb
information for multiple targets, and there is not much configuration
choice about this. It would be useful to suppress the Fdt passing logic
that occurs through EFI, to mask any of the model compatible (possible
using u-boot 'fdt' command), Fdt, and fdtfile name.

I would like to see actual examples of why this series is needed.

-E

