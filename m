Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3CCC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2465C88F5D;
	Thu, 25 Apr 2024 14:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M8CTr/fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F9288F48; Thu, 25 Apr 2024 14:28:48 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EEC488DE4
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hughsient@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78f00cd23bbso15869985a.3
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714048125; x=1714652925; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nrFmNE0Pl2LKLdp5FVZBIfOlpjXBRKjDy1Ug7iTCGJA=;
 b=M8CTr/fsb/qO7EYqlT9ntLlPCXKHTGU4yqBnqrngcpGSLRjk+gDs7MF5afmjl2w+OG
 S4beJlCEhq0kEFYJfnWgND1y789ETW96EUDQPfmVKFayXdwx5ionZlBEE9D1kBzsQTL/
 p08qyHyU5sXiGL4+arkz1JcRcCF27TM0HcdyyV0NJXhylRueas4N4shqQBUMlAb5v8QH
 /1PkZFeW14TTb/b17Ht3Q/S8xUEzBwWgxi19rYf1qqkhDCheEkT3ZoT3Vql0E5MAuSq/
 gcSBL4S8drOLNLnlCQuOThVM8zb+Kft/iT94OVlXN2fduqyW6LCfnbbzfPaoVGRMUmPk
 Yg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714048125; x=1714652925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrFmNE0Pl2LKLdp5FVZBIfOlpjXBRKjDy1Ug7iTCGJA=;
 b=N/mO5K8a3zCC7bgpE930zMs/IgslvXAqR8wG5/45tmz/MTnDOJssPJ3aIAKIj9UZin
 ub5eoSJTIRfLqWA+NuT2kdaLfZdl/DYFgkPbddCZP+zTm1nQBuI3Yl0dp0XPeYI0Cy84
 JRfv6x82EZDxtO9KWO/I9V7do19e3FYCpbmzl52LJ2C2ETDZ1STGqLQ76XepT2rfsq0Q
 NIeMVQjEff2nBVUxQBl0pfrYDPO5m4z2eKGNI4m4GmrxN3XDYgR7FrcCRJP5iZjYb7t7
 rFcePLdfKmOZP74mRkjMFdjIXemcmONy1mJkhn1eaOYey2O19xBciIKJdLxd6Ug3zqO6
 Occw==
X-Gm-Message-State: AOJu0YzyqfuT1GzAlNoUc/bT9Ux6sSoqULufL4PHulhFQ1PUQMdzKxU9
 C4G1Ew7cWEFVl3vY60mzg8yQVqsWkuK0WCeU+dGRDddLY9urWi2jZFQkmfX7ipgxsDjzdaVfL/E
 tGxtSlJJUk8G1aMKn5CDVvPA529Y=
X-Google-Smtp-Source: AGHT+IETiFq9ez8QXYJEjSMhSa4dedCWNrOi9mJ3Iwhg4SHfQgXLgwbuB1L/JFE8l/nkDYvDGorZxixTiFLAQ2+MebM=
X-Received: by 2002:a05:6214:258a:b0:699:dfe:6015 with SMTP id
 fq10-20020a056214258a00b006990dfe6015mr5781064qvb.5.1714048125128; Thu, 25
 Apr 2024 05:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
In-Reply-To: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
From: Richard Hughes <hughsient@gmail.com>
Date: Thu, 25 Apr 2024 13:28:33 +0100
Message-ID: <CAD2FfiGuFaC=r+TGfq9auzWJbyzVNbug8zR9RzSwM2+Uk52d+Q@mail.gmail.com>
Subject: Re: Capsule GUIDs and LVFS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki <naoki@radxa.com>,
 chris.obbard@collabora.com, 
 Paul Liu <paul.liu@linaro.org>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Apr 2024 14:32:02 +0200
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

Hi all!

> Any ODM/OEM creating a board
> based on the original device must use his own
> GUIID to avoid confusion. If not we would end up with different
> devices reusing the same GUIDs and upgrading their firmware with a
> different one.

Yes and no. Of course it's never okay for vendor A to use the same
GUID as vendor B -- but if vendor A has two models of hardware (for
instance model C and model D) they can have the same capsule GUID if
the update can use a DMI match on the product SMBIOS key to identify
the system. Of course, it's much better if they have different GUIDs
in the ESRT to completely avoid the chance of the wrong firmware being
flashed on the wrong device.

> Richard, the following GUIDs should at least issue a warning in LVFS
> since they only work for QEMU & Sandbox internally.
> Sandbox SANDBOX_UBOOT_IMAGE_GUID 09d7cf52-0720-4710-91d1-08469b7fe9c8
> Sandbox SANDBOX_UBOOT_ENV_IMAGE 5a7021f5-fef2-48b4-aaba-832e777418c0
> Sandbox SANDBOX_FIT_IMAGE_GUID 3673b45d-6a7c-46f3-9e60-adabb03f7937
> QEMU QEMU_ARM_UBOOT_IMAGE_GUID f885b085-99f8-45af-847d-d514107a4a2c
> QEMU QEMU_ARM64_UBOOT_IMAGE 058b7d83-50d5-4c47-a195-60d86ad341c4

Are these GUIDs that should be "never allow a firmware to be moved to
the stable remote if it uses this GUID" or more "a firmware also needs
a DMI restriction before being allowed near stable"? I'd err on the
former for these.

> I've cc'ed all the people I could find in board specific MAINTAINER files.
> Can you respond to Richard with the proper company name & board name
> so we can bind the following GUIDs to a vendor properly?
> Richard any guidance on how this should be done properly is
> appreciated, since I am not too aware of LVFS internals.

The LVFS doesn't need "pre-registration" of GUIDs so to speak; we have
have two deny lists of GUIDs -- one for "this is never valid" and one
for the "this needs a DMI match"

> STMicroelectronics STM32MP_FIP_IMAGE_GUID 19d5df83-11b0-457b-be2c-7559c13142a5
> This seems to use the same GUID for multiple device variants. This
> needs to be fixed

Is the DMI data different? e.g. you can see the Windows CHIDs (we use
the same DMI restriction scheme as Window 10) using
ComputerHardwareIds.exe or on Linux using `sudo fwupdtool hwids`

I've created a spreadsheet of what we do now, please feel free to add
GUIDs (anybody!) to the correct column:
https://docs.google.com/spreadsheets/d/1uPQmUrGA1KKsDPzGeg4xb2XOQEfsjDBBP9SQjqh31Wc/edit?usp=sharing

Thanks,

Richard.
