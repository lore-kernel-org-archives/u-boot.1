Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B840CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 12:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD26587516;
	Wed,  3 Jan 2024 13:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="WkPYw7Jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB17886EF3; Wed,  3 Jan 2024 11:11:20 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5279386EE2
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D1E10A11F5;
 Wed,  3 Jan 2024 11:11:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=mail; bh=XZm3ZgKDyxI/wwKUIS+D
 EZCd5R7AL6UAKSEqwAPMZHg=; b=WkPYw7JbVOyAHnqf4gh43y4LXXYS/dDUDMjb
 MSl7hjvlpFVVKkURRGRmBlsZasZXpcT3A/GwROkccscQZiNSdHboSEETwJmERuOk
 mz3/x6pXdzM57uHhhzk6ViX455gobYDk6LYqbaTnxDpTDNpRZoZgsFedPrp2/rgg
 YPRNBv9DN81Y3iYr4jUKxYa7NbI2exvkwii8lOxygUK38QHDw6+MlZHC8unxAoXl
 Vi7BIYwztpSYGx5yvAMzq8s6fjKqOUJiCzgzuY07Vd/cXG/MM+s+3SEfn4D4PaHc
 s62sjf6BHa3HiXGPyhVPzRXKa4sl69embUVz7vwiuHoLlahW6qfeIjOjvS3I4Hpr
 6rNF/GNu8VSe2DcrT1h+wQtjUNXBDEZXl5mZx03L0uUGuUO4YZ4yFKGqATT6Py2v
 68V/MpcxwxOygqpojwnQO03uKeTA5HZdTRGdy93agdh+nO3gd0DMx7ApTWqsmZrF
 n2LNa/vcxuCsFpybbUg/+Dv2Aw+3vp1vUy/mTa4FWydsRoYmgLTpdau9FwR52RbG
 KaSYmO7c3guCuO4uN78uT/gBmH9rlUKLKXLBBBpjNti7+SNq7z1gm3sjcMJRiigR
 gv5EvUoV8DcM7iPk4paZSJ1KCghyT2bq3CIj2lCGZm5NW4u575oEkVTyOnqWJm5i
 A6CEVc0=
Message-ID: <f78b464a-5d9f-4552-bd2f-700a0cbe3ddf@prolan.hu>
Date: Wed, 3 Jan 2024 11:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Passing boot logs to Linux?
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Daniel Golle
 <daniel@makrotopia.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <ZYH-K_UGat0yWMVH@makrotopia.org>
 <CAPnjgZ3sNBuaNkbTF2d=E2JD4sQOaA5QRfzDfz1KSV==nOWbTw@mail.gmail.com>
 <514fe736-5122-41f2-bb1b-ee1a42ec2cb2@gmx.de>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <514fe736-5122-41f2-bb1b-ee1a42ec2cb2@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.254.7.28]
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 sinope.intranet.prolan.hu (10.254.0.237)
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B55657064
X-Mailman-Approved-At: Wed, 03 Jan 2024 13:22:38 +0100
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

Hi,

2023. 12. 31. 0:54 keltezéssel, Heinrich Schuchardt írta:
> On 12/20/23 05:11, Simon Glass wrote:
>> +Heinrich Schuchardt
>>
>> On Tue, 19 Dec 2023 at 13:33, Daniel Golle <daniel@makrotopia.org> wrote:
>>>
>>> Hi Bence,
>>>
>>> On Tue, Dec 19, 2023 at 08:08:48PM +0000, Csókás Bence wrote:
>>>> Hi!
>>>>
>>>> Is passing the U-Boot boot log to Linux supported yet? We are working
>>>> with a third-party solution, which works, but is a bit hacky, so I was
>>>> wondering if an official solution has been merged yet.
> 
> U-Boot supports writing log messages to an rsyslog server via broadcast
> to UDP port 514 (CONFIG_LOG_SYSLOG=y).
> 
> The device name can be set via environment variable log_hostname.
> 
> If you have a log server for your devices in the same network segment,
> you can consolidate all your logs there.
> 
> A driver writing log messages to a file could be created in U-Boot.

I am aware, however, this is not what we want to do right now. We want 
to pass the logs to the booted up OS on the *same* machine.

>>>> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>>>> everything to a membuff, but I don't know if that can be exported to
>>>> Linux yet. And if not in the tree yet, would such a patch be welcome?
> 
> It is not enough to export a memory buffer. There must be support in the
> operating system to read it.

Of course. But it should be trivial to add a driver to Linux and other 
FOSS OSes to support reading these records from memory.

> Linux supports the common platform error record (CPER) format defined in
> the UEFI specification. See
> 
> * https://www.dmtf.org/sites/default/files/PMCI_CPEREvent_Proposal_v3.pdf

According to page 16, records can be of the following types:
* error, recovered
* previous error
* simulated error

There is no type that is an operational condition (even though you can 
append informational sections to an error record). So what we could do 
is mark everything as "recovered", but that is misleading, booting is 
not an "error condition".

 > * 
https://uefi.org/sites/default/files/resources/Spike%20Yuan-%20Server%20RAS%20and%20UEFI%20CPER_final.pdf

This looks like some promo material, not very useful from an 
implementation standpoint. Plus, this talks about Intel-based cloud 
computing/HPC, not exactly the embedded systems we are targeting.

> Boot errors can be reported via the ACPI BERT table. But that won't help
> you in OpenWRT which uses device-trees.

Exactly. I would avoid depending on ACPI/UEFI. Having a simple in-memory 
struct can be supported on all platforms, even without ACPI, UEFI, 
writable filesystem, even DT is not needed if you can pass the base 
pointer to the OS via other means (ie. command line).

> Best regards
> 
> Heinrich

Bence

