Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1665C47422
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 00:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601E18793C;
	Mon, 22 Jan 2024 01:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ACDfYYQa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MIZugfsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 058FD878EC; Mon, 22 Jan 2024 01:37:24 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D908773F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TJBBT4sf9z9sT7;
 Mon, 22 Jan 2024 01:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vS9mVJgzyDWIknc13Ea4SrdOL/eGgbh4I1uuyeBuprQ=;
 b=ACDfYYQanEjKIyt8XmVP3RIwtoARbb35X7Vg+CiE+VsOzVAd8HRicqa45xKNFrJv0rAeah
 vFdmX3LYsq6tUbY+ZCrI5bj1T2B6haoVejud8Rp1z/XcYT114msWnVstzfvTFjW2AzR6MM
 DBMTxL80M+Xpwg1beZpFdW2POYe0paeo8XpMZqdAbevca2EUdv12n1M0ct6VIyoKToKnuQ
 USm/zJ/S25HA3/o0bUqVSgEpXUlGkepoBmGi7Xji7i5gB2EszxUtytx6qBwcb97zdegFx4
 Pt5KEKULvq2hAe2SEP+yhvWH9lKJlCZYA/lkENURaLiNUIoG56Hj8PVWopNK5Q==
Message-ID: <2e5ca70f-c934-4551-9661-c41330c018b1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vS9mVJgzyDWIknc13Ea4SrdOL/eGgbh4I1uuyeBuprQ=;
 b=MIZugfszyWx01veLSUveeNW3IlfMwxG67PWHTZQEkwWX8NfIsPqr6htoiAGS7hpORpR10x
 ZFfDKa+Qp4GU4HXNVxweczwZ+xDdbkmlO9NvYEd+VBUH5iECnH38DWx8UIX9ZOR+ztGplU
 Aoy9E05wGkWPfYKaEHf1pdBI3S2I3Or1qi/BcopDnQHLkhdtm9dE7P27XGgsrju76Z/wLf
 tI1XcLaayEb77lpfZ0excZJ2ET36aADD+0SKaO977Di+TsAfE1cn9fxKnisZbYYmU0NvgF
 0r0JmJ5w6oOs8IoTIIO79aIpFAvVfqUMJi4XSoIO0IpPkpk+9+cubBhQ+87wFA==
Date: Mon, 22 Jan 2024 01:37:18 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 02/11] dt-bindings: clock: Add R8A779H0 V4M CPG Core Clock
 Definitions
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Duy Nguyen <duy.nguyen.rh@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
 <20240121174340.279465-2-marek.vasut+renesas@mailbox.org>
 <e06c54a3-6497-4501-936a-ebc9f2b7cbed@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e06c54a3-6497-4501-936a-ebc9f2b7cbed@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1cqzozf7gxkwmnr181frr4xp5qezeayp
X-MBO-RS-ID: 5ccede0c66a1eb9c929
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

On 1/21/24 22:14, Paul Barker wrote:
> On 21/01/2024 17:41, Marek Vasut wrote:
>> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
>>
>> Add all Clock Pulse Generator Core Clock Outputs for the Renesas R-Car
>> V4M (R8A779H0) SoC.
>>
>> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
>> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
>> ---
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>   include/dt-bindings/clock/r8a779h0-cpg-mssr.h | 100 ++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/r8a779h0-cpg-mssr.h
> 
> We should reference the corresponding Linux kernel patch via
> lore.kernel.org if this isn't in the mainline kernel yet.

There is no corresponding Linux patch.
