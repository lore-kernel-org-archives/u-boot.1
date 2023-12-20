Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F959C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 05:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC49E86D82;
	Wed, 20 Dec 2023 06:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="IXSAuHG+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5430C86E5E; Wed, 20 Dec 2023 06:04:13 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E6886D38
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 06:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1703048650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUZmKwE2GHujOHvTB8MoDO+wfSfHlz31vWUNXkpYJQU=;
 b=IXSAuHG+V5XBvKxyqyU9sZtDmcjGJtcwXmH6bWwHjieFh9TVRjffNzZ69No8JHkjv4P2bS
 IVgkjUg0ZiXfOGNJG4mLEvTtPCvNkMg9Q8MLVfTqxXbprHuvE/VHiZ7NVD1RFZtGbkNzTU
 wUMbERCB5Y7xrJaAH6wqSLXD+RJO+QAxyaxx3GnvF9czx+ZLP2jve6lXqBmLSDnqFN1T3I
 xBZO2E9ub6AZWAPi55J6p4zJLGRpha/+JNpy3I9K3z3AOdQOJcN+YHWnz6NtpZ31dqEdH3
 9jA4ihALGWeTVj7wj9FhI9VxWq/0bIN/gNVGIg5mEMRRvtvCfIV3g7PnbI88mA==
Date: Wed, 20 Dec 2023 06:04:10 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, =?UTF-8?Q?Cs=C3=B3k=C3=A1s_Bence?=
 <Csokas.Bence@prolan.hu>, u-boot@lists.denx.de
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
Message-ID: <16e633f9d4b1c426aaca510157479d65@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2023-12-20 05:45, Sean Anderson wrote:
> On 12/19/23 23:11, Simon Glass wrote:
>> On Tue, 19 Dec 2023 at 13:15, Csókás Bence <Csokas.Bence@prolan.hu> 
>> wrote:
>>> Is passing the U-Boot boot log to Linux supported yet? We are working
>>> with a third-party solution, which works, but is a bit hacky, so I 
>>> was
>>> wondering if an official solution has been merged yet.
>>> 
>>> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>>> everything to a membuff, but I don't know if that can be exported to
>>> Linux yet. And if not in the tree yet, would such a patch be welcome?
>> 
>> Not yet, but yes I would like to see this.
> 
> I think most of the infrastructure is already here. We could use either
> console recording (as mentioned above), which is more complete, or a 
> new
> LOG_DRIVER (which would have the advantage of omitting things like 
> countdowns).
> 
> In terms of sending things to Linux, I think the natural choice would 
> be pstore,
> which we already have a parser for.

Yes, using pstore would make sense.

As a note, I'm willing to work on this, if Csókás actually doesn't pick 
it up.  I'll be so happy to see this feature reaching all kinds of 
boards and devices.
