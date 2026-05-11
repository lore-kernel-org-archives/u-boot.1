Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FFFCD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 14:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F9948394E;
	Mon, 11 May 2026 16:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="UDeLDalB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1165F83A91; Mon, 11 May 2026 16:31:55 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8E88341A
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 16:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Fn1CGeqRWbN8/3wQ/AOqfp6T5ISmzcXaEAsR8f8lzFQ=; b=UDeLDalBMZiZCi1UbxZNyHUlnC
 klg6tDSPLIeJz3nb13v16xtkRT3u+SEInHcNg6W4bWrlF/RUWAKcHworkpYZ1ND9PIJ5lKc0mZ7yU
 nUGytfMIEDhwE48NDmLH6XwYjqnL0EwI+mhbSt0bPwPAn32aWvZ+oGgyprV9pek7P02wh4oXtjVbL
 epE8/T0te+9/Z7PrmwhkxdDPaVUipZ9uvA/tzDykcspkxGDUk0NpQ2cydHBXmQyA1xeF1G3CZ4ywT
 BlogD9XTV33MJSjecfsyYwsPJT6HCaZoNvWa3i14KgUHZDEHt9kxglwA5+1eIyqzvg+hLkqzlNaHK
 ad6kOllQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wMRfk-000Iwh-2H; Mon, 11 May 2026 16:31:52 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wMRfk-0007Gz-1D; Mon, 11 May 2026 16:31:52 +0200
Message-ID: <17292a84-702d-44c6-8a67-9acd22b1b6e7@ew.tq-group.com>
Date: Mon, 11 May 2026 16:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] cmd: date: validate date using rtc_month_days()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-2-Alexander.Feilke@ew.tq-group.com>
 <CAFLszTjfq8g1xU=FTtsdLRwXC5nojbq+YwnwEcLcYaTRvd_vBQ@mail.gmail.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <CAFLszTjfq8g1xU=FTtsdLRwXC5nojbq+YwnwEcLcYaTRvd_vBQ@mail.gmail.com>
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



On 11/05/2026 15:29, Simon Glass wrote:
> The commit message says tm_year is not initialised in the MMDDhhmm
> case, but do_date() calls dm_rtc_get() into the same struct before
> mk_date(), so tm_year holds the current RTC year on entry. That is
> what makes the leap-year check work. You could rephrase to something
> like 'tm_year is not set by mk_date() in this path, so the leap-year
> check relies on the caller having pre-populated it (do_date() does,
> via dm_rtc_get())'.
Valid point. This is my new proposal:

cmd: date: validate date using rtc_month_days()

The old check accepted month 0 as well as Feb 29th in non-leap years.
With this change, both day and month 0 are rejected, and the local day limit
logic is now handled by rtc_month_days(), which correctly accounts for month
length and leap years.

In the 'MMDDhhmm' format case, tm_year is not initialized by mk_date().
The leap-year calculation in rtc_month_days() therefore depends on the value
provided by the caller, which do_date() does, via dm_rtc_get().
This is pre-existing behaviour, but is now made more explicit.

> I wonder if mk_date() could be static?
Affirm. I will add that when posting the next version.

Regards,
Alex
