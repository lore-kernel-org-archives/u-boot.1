Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD398C47422
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 00:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D16B87796;
	Mon, 22 Jan 2024 01:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XAnvyLlO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xoicw5Af";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6B1877EC; Mon, 22 Jan 2024 01:37:57 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A738773F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TJBC71XXgz9sq8;
 Mon, 22 Jan 2024 01:37:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8+ufNSoyv4+Iq/BsqVRCqzVtnfbSOOANpKhOLauKUo=;
 b=XAnvyLlOSn2pe6FLEeTlRKr8bx8JcxM8GDrM6ahhL6qEcjp/bLAJtH3vBemJClEhKsCtrn
 XmS/+XcXZn8BsX8jzdhY0FTfvYicopaJnvv4ycUrcalVRq2DNYml58pHUea3DnVRiHgOx+
 vojB1rf+5UC3t2Eb/Q5QNi20kLEAZQwdweEwD8hlIbOcYdC52JzoCmbdWRJETU2nEfsI6T
 Wt8z2K3ixT4N3myDt9yKCNGTL5wdCqptn8hjbGST1f4l4rBfKTq7UQLW8Prs2b6Vc/OWm5
 FjE4ekWIkoHqrP28DYvVWw9AsX8xcMxBa4kX9JD3mGOmUHpr5U0SZIA/TehzGA==
Message-ID: <3fde8b47-53d9-4be5-ba36-eb05d9f933bb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8+ufNSoyv4+Iq/BsqVRCqzVtnfbSOOANpKhOLauKUo=;
 b=xoicw5AfaGrcHbYb4LdfcV2/kfxvu0MeHAaMA3MW2Fm+G0A29+WYipSngYnsrV6CuF8AkN
 D2h4P8Rim4+SMmeYakqKEbSyb5c4AwrD5Fuh6d1x6bLkiIHR5XM6u3k9lcmFnjhzwQE+bs
 AcfGFqvDXehCOG/aju1h1GDcnqyFf6lpc6tIM7AUpImDPMU4WMd0sI7vJd3nQu9/dsRa2K
 7kCTXTZT0/jT/QATCoF/PmGOj7Ns7MyHbhiOV6+xnSkO2sgllGZEXc0IUjiGWIiE6IPrGI
 FZZeQ+r11AKBe6LS/Z04r8E+GMMf8DY9CH7IyFlApbV4XiCyT1B/FCfvON1IWg==
Date: Mon, 22 Jan 2024 01:37:52 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/11] dt-bindings: power: Add R8A779H0 V4M SYSC power
 domain definitions
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Duy Nguyen <duy.nguyen.rh@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
 <774ed277-4240-4ee4-8a15-c9833d472b7a@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <774ed277-4240-4ee4-8a15-c9833d472b7a@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 84a00f3cf9bcad69c88
X-MBO-RS-META: 3p45w9wn7bqppnggoinfbbmekk9yy4rw
X-Rspamd-Queue-Id: 4TJBC71XXgz9sq8
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

On 1/21/24 22:21, Paul Barker wrote:
> On 21/01/2024 17:41, Marek Vasut wrote:
>> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
>>
>> Add power domain indices for R-Car V4M (R8A779H0).
>>
>> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
>> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
>> ---
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>   include/dt-bindings/power/r8a779h0-sysc.h | 49 +++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 include/dt-bindings/power/r8a779h0-sysc.h
> 
> We should reference the corresponding Linux kernel patch via
> lore.kernel.org if this isn't in the mainline kernel yet.
> 
> Also, as a general series comment: I'd prefer to see a cover letter to
> say which interfaces and key features are supported on the V4M by this
> series. Is this enough to boot Linux from at least one interface (SDHI,
> Ethernet, etc)?

Yes, SDHI and Ethernet should both work.
