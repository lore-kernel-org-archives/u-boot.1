Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA160C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 09:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31448467B;
	Sun, 12 Jul 2026 11:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RdzB8EeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE536848A1; Sun, 12 Jul 2026 11:08:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E798844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 11:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ca=FG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783847303;
 bh=ghtlgNzlFhTXXf1RaB5JQh+EJOx/R9fr7VnWCqB+5LE=;
 b=RdzB8EeFHKhL9WFka1VJxUzrMnJz6nWmHA9v0fN65XF+CT8ETByroW2lKR1nitWpFoFlJ7gPe
 0Smr40GDxfaFQGoaL2QIwDiwkvXGhmjvhKfc3I/g8znDuhlCnGQzvxkUCdeP157HxXchzOS4qcY
 Q/SXH3KoCNnuUKV8fs8E5WeDZaHss5MI4KTTbyrhcOh7cSpqMlOr9eXWL6KQ8ASx8/HXNmFmaze
 Z1QBa+Rc6JUGq8c/p0ZF6kSutDX601Vd1tD76tG6NEkyo6BdvdNJ6ZOul7+2qlIWgtHejbMm4Zu
 w8P0zg0zbJqNP1HLO9bL5H3GqaGz/voslbTd/lyXcVwA==
X-Forward-Email-ID: 6a535985e9fa2a52933a7128
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e46068aa-1276-4501-af7e-db841de7e291@kwiboo.se>
Date: Sun, 12 Jul 2026 11:08:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] usb: eth: Add CDC ECM support
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-6-jonas@kwiboo.se>
 <2801bed2-d476-4b4b-b531-b182ecc5210b@mailbox.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2801bed2-d476-4b4b-b531-b182ecc5210b@mailbox.org>
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

Hi Marek,

On 7/11/2026 9:57 PM, Marek Vasut wrote:
> On 7/11/26 6:08 PM, Jonas Karlman wrote:
>> Add support for CDC ECM (Communications Device Class, Ethernet Control
>> Model) devices.
>>
>> References:
>> - [USBECM12] USB Subclass Specification for Ethernet Control Model 1.2.
>> - [USBCDC12] USB Class Definitions for Communications Devices 1.2.
>> - [USB20] USB Specification 2.0.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Is this pulled from Linux or is this written from scratch ?

As stated in the cover letter this driver was written from scratch.

  The driver implementations was created based of the CDC ECM 1.2 and
  CDC NCM 1.1 specifications and was tested on a few different USB
  Ethernet adapters using ASIX or Realtek IC.
At some point I looked and compared to Linux to ensure ordering of e.g.
control messages and size limitations where closely matched.

In more detail the NCM driver was first created and tested on AX88179.
Later when tested on RTL815x there were some issues, so I also added the
ECM variant and tested that on both AX88179 and RTL815x.

The ECM variant is likely enough for U-Boot purposes, however NCM still 
has some good features such as custom MAC-addresses. So, I included both
in this series, with NCM being preferred over ECM due to driver list
sorting.

Regards,
Jonas
