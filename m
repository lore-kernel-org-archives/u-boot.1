Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C26DC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 06:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0F884A48;
	Thu,  9 Jul 2026 08:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kH3bf9tU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F74684A51; Thu,  9 Jul 2026 08:41:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0088407E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 08:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783579283;
 bh=D2IR2uclguHtKMrAs6LiCYThKJ/X8449QmHwX5M+6H4=;
 b=kH3bf9tUhvlDsvrMHcIQ9X9erskKEHbadCd3Wv+LdMzkkzyRmP5D/gaADnNt+h2aRJxeXFxqv
 a1ekqS0rrqAHaQp/K0tqJRbBGp+RMfXcRhKqhx5o4QYA7kzb5pT/OjR6cOxnmbqFAs4VEzs6t0B
 AmQDwjz0iaquJk8qwQUoHVnXiTKLrcNGwIYllH1H10v2qi251k62lpccLCBXxQdU6y6geTWJZys
 8vzhu00YYiL+DY2QULTZwFNkf0rprS01ckVhhvnmQUS3pgbOngdI3BK4jIeEuVmHYjRISsZDIc1
 psR5Z2YE4wlkBgOehZBS2z0+XDQdqG2g3FMQWWH0yWew==
X-Forward-Email-ID: 6a4f428e40f9cb1df2448d1a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1f7d7469-692a-428b-b85d-f1a1df5b4a14@kwiboo.se>
Date: Thu, 9 Jul 2026 08:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] Kconfig: Add missing depends on xPL to xPL_ symbols
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-7-jonas@kwiboo.se>
 <20260709015241.GQ749385@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260709015241.GQ749385@bill-the-cat>
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

Hi Tom,

On 7/9/2026 3:52 AM, Tom Rini wrote:
> On Wed, Jul 08, 2026 at 10:05:32PM +0000, Jonas Karlman wrote:
> 
>> xPL_<name> symbols should typically depend on the associated xPL symbol.
>>
>> Add missing depends on xPL to xPL_<name> symbols to avoid the xPL_<name>
>> symbols being available when the associated xPL symbol is disabled.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  common/Kconfig | 2 ++
>>  lib/Kconfig    | 7 ++++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> Did this go through CI? I ask because with SPL/TPL, we have the problem
> of PowerPC being special from the rest of the world with these symbols
> and I want to be sure everything still is building, before I do a
> before/after size check on the series (and probably keep the binaries,
> so I can checksum before/after and make sure they're the same).
> 

The CI has been run [1] on a branch that contains these changes and the
pending Rockchip TPL cleanup/consistency series, not standalone.

Compared to the patches that was sent there is a small diff with && xPL
being dropped in the final series sent to ML:

 config xPL_SERIAL_PRESENT
        bool "Provide a serial driver in xPL"
-       depends on xPL_DM_SERIAL && xPL
+       depends on xPL_DM_SERIAL
        default y
        help
          In very space-constrained devices even the full UART driver is too

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/pipelines/30636

Regards,
Jonas
