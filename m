Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA25DC5B56A
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 12:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 377FB607D2;
	Tue, 11 Aug 2026 12:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8eiJo8Q7upsj; Tue, 11 Aug 2026 12:39:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F0186065A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786451973;
	bh=OXXJHLhgLWyzk2N08IZ0jseo5jeZEDnPlEDAvI5HPEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q4F3jJ4ZC9c1XjOfX18FDnz7XfugoyDPvK/UaKjgLmKpY/PqkziHTe0D4/+uvDHyX
	 6Ikfq0+4cGnsOF0eYwa3CzMgsXQYpaiZV8Z73Qvn/amRqHUYuSw7mb4B8MCaYy8PSq
	 IXHPxf6ZQ77szYn3Es3OMRf1v6QI4qSww2+L1oV38U5Pd/LXfJspsW/J8XcubDu89R
	 D3bOqzmL2K1Ki+Ud/02h12fouT2XzFHWNyXZ7RQJv9V5hb5uj1lg4HCGJv1iGyKiLn
	 3iKt8HsFTh+LrAG5CJyGDgUf4cP8RC0Mua9+bxQmoyZGoKUCDqIGb8ExMIEIZqzc2m
	 Ya2+s7NlXKP2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F0186065A;
	Tue, 11 Aug 2026 12:39:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61C5D28A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31F6F40774
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccfXk5LLEKIk for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 12:39:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 783CA40760
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 783CA40760
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 783CA40760
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:39:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 78EFC41FEE;
 Tue, 11 Aug 2026 12:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D131F000E9;
 Tue, 11 Aug 2026 12:39:29 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, Arthur Chan <arthur.chan@adalogics.com>
Cc: u-boot@lists.u-boot-project.org, David Korczynski <david@adalogics.com>,
 Adam Korczynski <adam@adalogics.com>, "security-cvd@anthropic.com"
 <security-cvd@anthropic.com>, trini@konsulko.com, mkorpershoek@kernel.org
Subject: Re: [security] Report of possible heap overflow in U-Boot's Android
 bootmeth before any AVB verification (ANT-2026-ZWED60S8)
In-Reply-To: <CAFLszTjWPVBmqtSyOTBG-5qQ+xCmJ+w=vwoX2jUepEvFnZMtAg@mail.gmail.com>
References: <39fb1908-e2d3-4d3c-af94-958bef35dddc@adalogics.com>
 <CAFLszTjWPVBmqtSyOTBG-5qQ+xCmJ+w=vwoX2jUepEvFnZMtAg@mail.gmail.com>
Date: Tue, 11 Aug 2026 14:39:27 +0200
Message-ID: <871pc43k74.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786451970;
 bh=OXXJHLhgLWyzk2N08IZ0jseo5jeZEDnPlEDAvI5HPEI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=jmC8kTOxQEnlB0+Ef8pGtasjmm0e8qA6gDX+AzHA+CGfCOQdwH82Ml8s7Pfvcc2BI
 pPuA8RtFjXvBldrH8JNsyAS7gQ+vNR5ScZQSujgKHUD5jD3jAQPKCKvkc3b8f9r20g
 lPNy7snJvQ8yoneMEVrCnweOZszXKuNwMZDQzg8aibWH6v8WPFQSApHCtE1pyNwaQt
 86PHzAF5Y045fUdPACVOuSYgDJrHd9O8QIKNhFonCLCtYSi44ZQqo0b3H4E2Jb/x4/
 2PjsvyEZa2OijUBWyH3+9dswX3j/FqyWKfqo8Z4vby6SvHCFoYl7TlNMhAQN+rrQIY
 IIM62f/WJeADA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jmC8kTOx
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Arthur,

Thank you for the report.

On Thu, Aug 06, 2026 at 08:52, Simon Glass <sjg@chromium.org> wrote:

> Hi Arthur,
>
> On Thu, 6 Aug 2026 at 06:23, Arthur Chan <arthur.chan@adalogics.com> wrote:
>>
>> Hello U-Boot maintainers,
>>
>> I'd like to report a High-severity security issue in  U-Boot (https://github.com/u-boot/u-boot / https://git.u-boot-project.org/u-boot/u-boot) related to possible heap overflow in U-Boot's Android bootmeth before any AVB verification.
>
> Thanks for the report.
>
>>
>> I have attached 3 files with this email as described below.
>> 1) report.md: A full description of the vulnerability and how to reproduce it, together with suggested fix of the issue.
>> 2) Dockerfile: A Dockerfile for demonstrating the issue.
>> 3) driver.c: Work with the Dockerfile to demonstrate the issue.
>>
>> Attribution
>> -----------
>> Please attribute Claude and Ada Logics. This issue was found by Anthropic from using agents to study security of open source projects, and I am from Ada Logics helping validate the found issues and creating the report manually and notify the maintainers.
>
> If this is a standard text, I suggest '...issues found, manually
> create a report and notify...'.
>
> Are you able to send a patch? Then your attribution will be in the
> source tree :-)

I agree with Simon here.

I also think someone else found a similar fix and proposed a patch
already which is here:

https://lore.kernel.org/all/20260729-b4-android-bootmeth-oob-v1-1-31c3450ae0be@byteray.co.uk/

If you wish to contribute to U-Boot, please apply above patch and let us
know if that patch fixes the issue you've reported.

You can contribute by replying to above email using Tested-by:, for
example.

>
> Also I suggest avoiding HTML in email to the mailing list.

Yes, see:
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#general-patch-submission-rules

Thanks,
Mattijs

>
>>
>> Disclosure
>> ----------
>> This report follows a 90-day coordinated disclosure deadline. I'm happy to coordinate on the exact timing and to provide any further detail you need.
>>
>> Kind regards,
>> Arthur Chan
>>
>>
>>
>> ADA Logics Ltd is registered in England. No: 11624074.
>> Registered office: 266 Banbury Road, Post Box 292,
>> OX2 7DL, Oxford, Oxfordshire , United Kingdom
>
> Regards,
> Simon
