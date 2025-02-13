Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A760C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 19:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A44D580F7D;
	Thu, 13 Feb 2025 20:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lRcFFW2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E5380EBD; Thu, 13 Feb 2025 20:57:01 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7538C80F6C
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 20:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c89c=VF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739476616;
 bh=V7cOGWUa4Q2TYizdFDsRJBcF8iV5u1pCacmTIFWOFAQ=;
 b=lRcFFW2wcR3mZPyJ3RRF8WoQaLSvIADxRHeNk7AdZaawlZ4SR+NPqzSivMmZ+W6CsZ4UtPGQe
 irD4dCVQnZjepbFEC9nvrzXHsb9zYfzoWUEmd4EAdVfIBi1xhZYeLUhqsif4Oc/uN1vX9p5PHXG
 NEJyTQ3VhB3YNsrv/HQskqZRsfcB49PijjPGuFtHNv/6VoxkChtncsP3ibCH5J8VFgo1GKsrE3B
 s3yNH90Y0Plv1WzdoENkm3LIV0m0JPNh5SH9jomTEikAJhO04xNQeRbw6Hj7hMBD4kLd448cPl2
 B6ix0dRtpJUKozHd2wB/m1QTxlxgdlTrPjTB48BNYzKg==
X-Forward-Email-ID: 67ae4e859555f68eb880580f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <469dab5a-c51e-4c35-a7e8-38f77a354835@kwiboo.se>
Date: Thu, 13 Feb 2025 20:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xPL Proposal
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250213141517.GT1233568@bill-the-cat>
 <CAFLszTib-ydH-TCE-Oi0SDGu1ASWbCbfWApTqxFFHoU3Di_nvw@mail.gmail.com>
 <20250213155912.GU1233568@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250213155912.GU1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 2025-02-13 16:59, Tom Rini wrote:
> On Thu, Feb 13, 2025 at 07:33:20AM -0700, Simon Glass wrote:
>> Hi Tom,
>>

[snip]

>> Yes, that's true, but mostly in kconfig. I would be willing to resync
>> kconfig with Linux, if that helps.
> 
> Yes, re-syncing scripts/kconfig to v6.13 (as a stand alone series) would
> be helpful, thanks.

I did a dirty sync to Kconfig v6.8 about a year ago, when I though I
needed a newer Kconfig to support "default 0x0 if SYMBOL=value". Then
found a workaround for current Kconfig, adding spaces e.g. "default 0x0
if SYMBOL = value" so I dropped the entire upgrade attempt.

Pushed my dirty sync to [1] if it may help with anything :-)

The newer version seemed to work just fine after fixing syntax issues
in a few U-Boot Kconfig-files.

[1] https://github.com/Kwiboo/u-boot-rockchip/commits/v2024.04-kconfig/

Regards,
Jonas

