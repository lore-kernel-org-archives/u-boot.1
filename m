Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96837FEEF55
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 21:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81A98405F;
	Tue,  7 Apr 2026 23:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QmRmrhbP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D0C9840B0; Tue,  7 Apr 2026 23:55:15 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42338404A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 23:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-684a584b3b9so874912eaf.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775598911; x=1776203711;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gg/QxO3vAJn1kiboadUvhSFRnlPQBS/F7AnbmEcAX6Y=;
 b=QmRmrhbPZ9FXMbb7QmmYiR1laqebCcIrJCatQuEB0/XGj08Gb178W1rzPlUcilQZDM
 jgXCtDkH3t/CYHpQXNVguN2tPjm8kAtpyj3ozZb4vTft4eBqKMwTvLJpeyqFVS/Q8HkS
 B3ayU2gQjviAoXy2p2eoygynjpYE4opkCVkZGDEtY+bf+HJTglSXedvpMh+Rz6fCY/mq
 uJLUtqhYEdiffP7c2P85DRrCXhanBJ9mSP2BYfM7gTMZlqXykPPBjeT9LjzJLamdKKR0
 KerwZmfy7obowBibTrPIXZ8/grOtgjomoCWEh+E+CKS7gdMH1IX8MBfuFJOMNCNaGnR0
 yJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775598911; x=1776203711;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gg/QxO3vAJn1kiboadUvhSFRnlPQBS/F7AnbmEcAX6Y=;
 b=sNq5kJW3a5SKm02UIlDXYnUMWrqWNfHqGW4f+befCpWHW98KfUQSxgAGeOWt2xDpu+
 ocQFY3f3oCRa5utezsIx7ONHEfVE7y0EdJxrTrDAz+sYP1z0iblNB9wY+ldpPxSpUXsi
 BTzNMUmz4n0m+wykV4BBC4f9+COMjLsPnCS1DPjPXbD7u0PakrlthuJNm3WjJxUa2wGg
 IJwgZhGjtI/wwMnalPklYmpcWG3g8zeg6NQvlNSZH22Qlo8f08CmGmmVG0/n36DL/+gl
 SVOyWka2dv0ocs3ocPAttLcVMqm+QYH9gep0Xgv+jMcu2iW+XknaQEOgiAyXSL37f2JN
 vW3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdK+v/e0f6SjM6j3nCBzUTNWXhfPtMlsmsDDHiQ7l8PtdnbwcBWFG4kKcfT2MY8era10i6t0U=@lists.denx.de
X-Gm-Message-State: AOJu0YwhAIuF9txB5ROdvawGWGQv8DhNzSfCb7B1G4xJyyKdjjTb6uwn
 MVMdtgwq2zGsrz2GP84FE1Q21KLpYWVVvXN/XQ/whSbCywYnOPaXUCj0pKK9sjuonRI=
X-Gm-Gg: AeBDiesiIVLh9xdYds7UEeW/CpiQK8C1C+1/NfLCPQSsqCoMH1jNLEP9qgRQud03y6G
 /vuyHV9UhOrDHoH9qmaiayzez02auhsbt/+nqQCZgDjZHlVCbNm1F0BK+HlR0T8fke4C5Ok3SNZ
 w25AAmK2MSYM8t6WvWd64h9Z1zeh7NHbLrLmvaVcXZ6IFzsymCzaa136eSIBRdVHh/WSNgVF3DZ
 rvFdjPGuEhre/ZJlz1721Tjhtz8U3hYEGtpzSWZN8wKTwL3q2mRmPSUe5ZyXtpFVRVhjwtlcvnf
 uzUpxlxMYbX8XR5TVWP6CkcluQeIy3nnp8i6WkxGZyD9z57tiP1tzVFd32YEh9GbV0+ZXf1tVwJ
 TmhIzW/t3F2EX/8z6Ayumx2gAZ01IE1DH0JpeqJgTAYfdoqTB0R75wvUDrioXQZyHqWpBQrnjph
 MPIYptapU4gJZKMXasmeMFOBC67qhJnrAgtx10lKegey4YU/iYBv6IclTgOduXl4EznlWcO7CfO
 g==
X-Received: by 2002:a05:6820:205:b0:680:2238:66d5 with SMTP id
 006d021491bc7-6821e25e760mr9458295eaf.30.1775598911584; 
 Tue, 07 Apr 2026 14:55:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f738:1ffd:6365:30a7?
 ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-680a63c7fd1sm10806826eaf.8.2026.04.07.14.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 14:55:11 -0700 (PDT)
Message-ID: <726192d1-72f7-4774-8133-ad55c0ab57b1@baylibre.com>
Date: Tue, 7 Apr 2026 16:55:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: CONTRIBUTE: fix top heading level
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
References: <20260407-contribute-fix-heading-level-v1-1-9b075f01e7b5@baylibre.com>
 <e3f19f0c-b170-42b5-9d1a-9975fdc44425@baylibre.com>
Content-Language: en-US
In-Reply-To: <e3f19f0c-b170-42b5-9d1a-9975fdc44425@baylibre.com>
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

On 4/7/26 4:52 PM, David Lechner wrote:
> On 4/7/26 4:45 PM, David Lechner wrote:
>> Change the top heading level in CONTRIBUTE.rst to a higher level. In
>> reStructuredText, each page should have a single top-level heading.
>> Otherwise, each section of the page is treated as a separate page in
>> any table of contents.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  doc/CONTRIBUTE.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
>> index 8ccb3a193da..3f8d422e967 100644
>> --- a/doc/CONTRIBUTE.rst
>> +++ b/doc/CONTRIBUTE.rst
>> @@ -2,7 +2,7 @@
>>  .. sectionauthor:: Peter Robinson <pbrobinson@gmail.com>
>>  
>>  Overview
> 
> As an afterthought, I wonder if we should also change "Overview" to an
> appropriate page title.

Actually, I suppose "Overview" seems intentional when looking at the
top level table of contents in the navigation bar on the web site.
So I think this patch does what I intended after all.

