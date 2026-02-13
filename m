Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9531FEDF17E
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91CC83AA9;
	Fri, 13 Feb 2026 18:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XYpAfklp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295EA83AAB; Fri, 13 Feb 2026 18:42:46 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A109F83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=292c=AS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1771004562;
 bh=ybdAmjP4X7vMmlnkJIXHKi3md+BYYgPhKUlJ0m3uZ5k=;
 b=XYpAfklp5P6AEx8w0FWC4B3SWQssMtjryRZSsvkUrrlLwtWuP6/Jep7b3xx3VGXH8gv75b8v8
 YyMHEmAwxurh3+DBz6hAu876QQRK5brpH1XFUfLx5sx0Hv4b5qlLVezW59+3LWkzEgUhLtDla5q
 GYNIt50PLiEqhFMS6IB9lGrT4SupxoG8ECOPa8wJLH815WIj8md3GPWad0jC4zBiRXZCx7oRSj7
 1PnU3FTNFmfXZoqWdgxEPFQVnJgkeyTToSYfPvA5zJJwlXnPKXd7VVYxJdZvrjDbqNiTtQAj1jw
 lNwIxJid9HkOnrLhP8MzJEmFKU1CAikY3+oPJqt3ygSw==
X-Forward-Email-ID: 698f628b11dfcf99c4b0e6fd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0670f2d7-89ad-47f0-90fc-de8ebe8dd81a@kwiboo.se>
Date: Fri, 13 Feb 2026 18:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Remove USB-C controller from
 u-boot.dtsi
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de
References: <20260126215601.837587-1-jonas@kwiboo.se>
 <0406debc-6a4b-4b8c-9f47-167376144743@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0406debc-6a4b-4b8c-9f47-167376144743@cherry.de>
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

Hi Quentin,

On 2/13/2026 6:17 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/26/26 10:55 PM, Jonas Karlman wrote:
> 
> [...]
> 
>> -&usb_host0_xhci {
>> -	dr_mode = "peripheral";
>> -	maximum-speed = "high-speed";
> 
> This is not set anymore after this patch is applied (dr_mode = otg and 
> no maximum-speed). Please keep this part as is and if actually fine to 
> remove, have a separate commit motivating the removal.

I disagree, these props may differ but the function they result in for
U-Boot is the same, i.e. ums and rockusb commands can be used before and
after this patch.

The board u-boot.dtsi included something minimal required to have ums
and rockusb working, this can fully be replaced with upstream DT and
U-Boot functionality stay the same. Something I think current commit
message is already covering.

Regards,
Jonas

> Cheers,
> Quentin

