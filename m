Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C083C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 15:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7240288FB5;
	Thu, 25 Apr 2024 17:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DOVJiwCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10BC488FD7; Thu, 25 Apr 2024 17:16:18 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431F288E5F
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 17:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e48d0a632so1573331a12.2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714058174; x=1714662974; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cB8eb8qsermhTEOTejDHbWXNvO6PPk/VFIKOHXqqMoI=;
 b=DOVJiwCnDCz4KR8ToBGuk4/tAlDM//ofQjKSoMS84OPbIfkBvhf0Kg7m3JuDGREqoK
 kp6JchmUqYq+WfbRNp2RPMfZZLFVwnhtVsEmHlH0sPwn8iODPBT9KHonKNaGgi9jl29t
 s6cmPXT8ITm4Uk36eQEvvJYMjt29yMX6Nua66ngtGnE7xp64hwI36Wm3L3A2592PmEAX
 MV7PqpQqGA+nay7oRHYj5+TwPmVIxyzy4PRYxxCVX62WgMCrXg8m/gs1tq5uM94WhKid
 yjhCHI04r9yZBnOp40kKSah9FwYyEtwPISZxbsMp7DEqyeLJEM3B+YF6lMUXJoN8QEpI
 ievQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714058175; x=1714662975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cB8eb8qsermhTEOTejDHbWXNvO6PPk/VFIKOHXqqMoI=;
 b=Qypkb8xXpsqaBLVl3MLBYs/mba8uu1HcUQNKKmbssX2J4ylHCB2r7qtoistR3UST2z
 kj+nb1fuORQc9gmFWmWAJIPESbmlLH9bl1cM4NhJGEyjfH/HWkBm8rPotEQ7Fze4SPpA
 pPFUo7hSHToE44QccpYdy7XXHq1mSsQ0A1qvTPc+jZ+HhqjW/8wYWQyZ1KJxwATYpQvY
 YeX4KWeoqxm9QlZD23JA7GVKN98ZnLYt6bXbkOhZRjXNxBVYr4ReW5mU0TUlRhTJvtVT
 VcGoYjCm+GCo3kq20MOG7qCTrYB8BDiJdViZMKIBo3jrpDRSg00khyCujzL7pA25IDvo
 Opzw==
X-Gm-Message-State: AOJu0YxTKflCiH2jM8unOeQGHv6vLccZowHYrEscQ/f9lFxMrXIcp0T4
 7Nun6hR6L4CZKjqyji7iObAWunyiZKqQchGqRYDxSV4KW6yFxcroXeJF6wBJzu0=
X-Google-Smtp-Source: AGHT+IFOvHQzBRPQKQl79GYWUtYBnpYMjqpCX6sQl05Myy6BRDsYOHh73b3fJTzqZ7SrAxTglFjJTw==
X-Received: by 2002:a50:c059:0:b0:570:35e:9a09 with SMTP id
 u25-20020a50c059000000b00570035e9a09mr261501edd.7.1714058174449; 
 Thu, 25 Apr 2024 08:16:14 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::dcdd? ([2a02:8109:aa0d:be00::dcdd])
 by smtp.gmail.com with ESMTPSA id
 b10-20020aa7dc0a000000b0056fe755f1e6sm8973972edu.91.2024.04.25.08.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 08:16:14 -0700 (PDT)
Message-ID: <cd5ca19b-befe-47cf-9a84-f610ae7f04c9@linaro.org>
Date: Thu, 25 Apr 2024 17:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Capsule GUIDs and LVFS
To: Richard Hughes <hughsient@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 FUKAUMI Naoki <naoki@radxa.com>, chris.obbard@collabora.com,
 Paul Liu <paul.liu@linaro.org>, Heiko Thiery <heiko.thiery@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Michal Simek <michal.simek@amd.com>
References: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
 <CAD2FfiGuFaC=r+TGfq9auzWJbyzVNbug8zR9RzSwM2+Uk52d+Q@mail.gmail.com>
 <CAC_iWj+BonsVbA5Bw3Kck2k4b8SXru0U_Y2kAmx5=_t6SozotA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAC_iWj+BonsVbA5Bw3Kck2k4b8SXru0U_Y2kAmx5=_t6SozotA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi all,

On 25/04/2024 15:46, Ilias Apalodimas wrote:
> Hi Richard,
> 
> On Thu, 25 Apr 2024 at 15:28, Richard Hughes <hughsient@gmail.com> wrote:
>>
>> Hi all!
>>
>>> Any ODM/OEM creating a board
>>> based on the original device must use his own
>>> GUIID to avoid confusion. If not we would end up with different
>>> devices reusing the same GUIDs and upgrading their firmware with a
>>> different one.
>>
>> Yes and no. Of course it's never okay for vendor A to use the same
>> GUID as vendor B -- but if vendor A has two models of hardware (for
>> instance model C and model D) they can have the same capsule GUID if
>> the update can use a DMI match on the product SMBIOS key to identify
>> the system.
> 
> In theory, yes but we don't have any of these check in u-boot and I'd
> rather avoid them and do it properly

I discussed an idea with Ilias to generate GUIDs dynamically based on 
the board compatible/model, which seem to essentially just an 
abstraction on this.. But I'm wondering now if it wouldn't be better to 
do DMI matching.

Like, if we have a GUID of some specificity (OEM, ODM, mach, whatever), 
and the DMI data (usually root compatible and model, but easily 
extensible and overriden by board code) then we can do the exact same 
matching, but with the added bonus of being easily able to tell what's 
up if something doesn't match. Generating a GUID from this data makes it 
way more difficult to figure out why the board doesn't match.

But the issue there I guess is that the EFI spec only allows for 
identifying by GUID and not any other data...
> 
>> Of course, it's much better if they have different GUIDs
>> in the ESRT to completely avoid the chance of the wrong firmware being
>> flashed on the wrong device.

So expanding on the above a bit, the idea Ilias and I brainstormed was 
to use v5 GUIDs (which are deterministic based on a "salt" GUID and some 
arbitrary data which is hashed together). We would use the board model 
and compatible, as well as the firmware image name to generate these.

Then for every board we want to support in LVFS we just boot it, dump 
the geenerated GUIDs, and use them. This makes changing the 
model/compatible strings a little bit annoying but it's workable.

I feel like this is a "clever" solution to the issue of all these 
hardcoded GUIDs (and needing to add new ones for every board, even if 
the board otherwise requires no code changes in U-Boot). But it also 
feels kinda ugly in how it's just a worse version of the DMI matching 
fwupd can already do.

> 
> Exactly.
> 
>>
>>> Richard, the following GUIDs should at least issue a warning in LVFS
>>> since they only work for QEMU & Sandbox internally.
>>> Sandbox SANDBOX_UBOOT_IMAGE_GUID 09d7cf52-0720-4710-91d1-08469b7fe9c8
>>> Sandbox SANDBOX_UBOOT_ENV_IMAGE 5a7021f5-fef2-48b4-aaba-832e777418c0
>>> Sandbox SANDBOX_FIT_IMAGE_GUID 3673b45d-6a7c-46f3-9e60-adabb03f7937
>>> QEMU QEMU_ARM_UBOOT_IMAGE_GUID f885b085-99f8-45af-847d-d514107a4a2c
>>> QEMU QEMU_ARM64_UBOOT_IMAGE 058b7d83-50d5-4c47-a195-60d86ad341c4
>>
>> Are these GUIDs that should be "never allow a firmware to be moved to
>> the stable remote if it uses this GUID" or more "a firmware also needs
>> a DMI restriction before being allowed near stable"? I'd err on the
>> former for these.
> 
> TBH those are GUIDs that are used by virtual devices. It wouldn't hurt
> if someone reused those GUIDs but we can display a warning about it?
> 
>>
>>> I've cc'ed all the people I could find in board specific MAINTAINER files.
>>> Can you respond to Richard with the proper company name & board name
>>> so we can bind the following GUIDs to a vendor properly?
>>> Richard any guidance on how this should be done properly is
>>> appreciated, since I am not too aware of LVFS internals.
>>
>> The LVFS doesn't need "pre-registration" of GUIDs so to speak; we have
>> have two deny lists of GUIDs -- one for "this is never valid" and one
>> for the "this needs a DMI match"
> 
> Ok thanks for the info. Is there also a check of "I have duplicate
> GUIDs that aren't in the DMI list'?
> 
>>
>>> STMicroelectronics STM32MP_FIP_IMAGE_GUID 19d5df83-11b0-457b-be2c-7559c13142a5
>>> This seems to use the same GUID for multiple device variants. This
>>> needs to be fixed
>>
>> Is the DMI data different? e.g. you can see the Windows CHIDs (we use
>> the same DMI restriction scheme as Window 10) using
>> ComputerHardwareIds.exe or on Linux using `sudo fwupdtool hwids`
> 
> I hope ST answers that, they are cc'ed
> 
>>
>> I've created a spreadsheet of what we do now, please feel free to add
>> GUIDs (anybody!) to the correct column:
>> https://docs.google.com/spreadsheets/d/1uPQmUrGA1KKsDPzGeg4xb2XOQEfsjDBBP9SQjqh31Wc/edit?usp=sharing
> 
> Thanks!
> /Ilias
>>
>> Thanks,
>>
>> Richard.

-- 
// Caleb (they/them)
