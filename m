Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B93CCDE00B
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 22:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21A21849C5;
	Fri, 26 Jun 2026 00:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="au9G2tU2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="m6chbVVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C548497A; Fri, 26 Jun 2026 00:16:59 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852C384987
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 00:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gmY7Y2lBSz9tNn;
 Fri, 26 Jun 2026 00:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782425817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+sT0LkEdKfj/ZEfm+ltn3tkLxftEl6EpoMx8MsJNac=;
 b=au9G2tU24sugpfOVDs7VV0uQy2BrUHzNAP/VYyuyESzZxsiPjI10iLnYZ3WjXqS08XugEU
 fbhwl0v/SQSjjWzgfoeljg0Bph/OgdFYw5dma6JaX9NgN4Vq+tIMcpkNn7ocBBZvqh5pq7
 LZK/Px9NIhuVtjP7VrI137up37JMS4Zj7m5VmQHGKr2kNza2xtmFBHm/bq4hA/3Us6ee+6
 rJzl383uBcAULdR1I+0z7iTQVjnk/vvWcrjZSgKN/XTYaxsHhg7dgocaQC4RUbL6echJRq
 0Al/nLX9tCReZkGiVtPSnZQPnEfcsU+Hjj1I4GpIxqfS8x5i0izpzuj/iqpWsg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=m6chbVVN;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <ed3e692b-79a8-4b0b-b159-48a90ab077af@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782425815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+sT0LkEdKfj/ZEfm+ltn3tkLxftEl6EpoMx8MsJNac=;
 b=m6chbVVNsZHl/1VdCPcmoupreAtNu1Opl5FfounMeHYLUFlDV+iZugccGzeQh3U1ceNXNj
 IyftKcPqg6Nip2+0BscoTxXRBOJFx6+JTNbWjKuqD/aZOeymalzu9a9aZLMP2xnmObosqv
 2oWWxvtGX06FkqJfAP/58VyR/PfxqzGjZHK2jEQywVK8UCSRY9FxptP9SxzSm8rTSWXXrD
 45sMmzYUwzYBWgKFrn2Himm5NQ2U85gAVg1o/XwCcrxid8vedD2PpRpSs0TBA5fQTXTR63
 hc5SLwbGDWveJxgrXJCpt509l28C+uqcmcy8wQKbcbgfxt4BnV6k2D7+Lim0AA==
Date: Thu, 25 Jun 2026 16:27:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] usb: usb_onboard_hub: add support for TI TUSB8041
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+usb@mailbox.org>
References: <20260601082717.239518-1-alexander.stein@ew.tq-group.com>
 <bc565581-c31f-4fde-b487-f9265ca76c00@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <bc565581-c31f-4fde-b487-f9265ca76c00@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: myk5nkcq99iewor3r1qpugz6g8za78pq
X-MBO-RS-ID: ca9f2e61762650f34bf
X-Rspamd-Queue-Id: 4gmY7Y2lBSz9tNn
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

On 6/25/26 4:10 PM, Quentin Schulz wrote:
> Hi Alexander,
> 
> +Marek in Cc as maintainer of this file
> 
> On 6/1/26 10:27 AM, Alexander Stein wrote:
>> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>>
>> Add support for the TI TUSB8041 USB3.0 and 2.0 Hub. A reset duration of
>> 3ms is specified in the datasheet.
>>
> 
> Matches what you sent to the Linux kernel... /me checks notes... 4 years 
> ago.
> 
> I see a few other compatible with the same configuration in the kernel, 
> should we add them too in U-Boot?
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
I just sent USB PR with another set of IDs, could you please rebase on 
top of that and send a V2?

Thank you
