Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985EDE81BD2
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 09:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5B682BF2;
	Wed, 11 Feb 2026 10:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mwQ/VbEb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1050D82BF2; Wed, 11 Feb 2026 10:32:15 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F01802C1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-79430ef54c3so48141917b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 01:32:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770802331; cv=none;
 d=google.com; s=arc-20240605;
 b=Id/EQlhGvvQ7Zao6i/U8TQd8NGgcbnIvZOml33AinmUFk1CHP83mZ09yL2smLzGg23
 EYtg6KBJrZ2UnTf0gCsNDzTES/ujrrkGhLREHeXsp3lpbk6/aP4qdcDCnn9RjPnweokC
 za0X2dAPonorVTQbLv2XXDB3kS74wm3vc0+0l6RxK/eaxDuNNc8NifvrmqdOBj/LuAyY
 A+1bNc7O4PCvaD6UO48Pm/wERVGIZjmOIJppmcmZsxoVjHv3Qhbx+FBn9xQtbz+NIJbK
 Y1N81dkP0MXu35jmRLK9NcVM7s8jQB3FlqMWypyPFPCbuWBpEnhanjFQW+k0AlA7gfL6
 xiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V8QcuNswCuJm2PpQcO33sZS5putPYLynqzNiG7AOLes=;
 fh=r5jNfMaYjEFWkgkW2oKy7Pjh4Xgn3i/3ihf0W19kJN8=;
 b=C1NL35aWxtQRW/w9kKDyfnWiO9NMgb/oBQBeJAVbKLzTe70z60mQi1DIbRD+tPjUqI
 3mAkTdKaZWcVhmaAjj02hlL9ITtEloiUjVwV5pWoSItszfDwXmuz//Y+Tt6H09dnbBvy
 T/16hQcTPn3YpakCbvGrT47q0FtUWaEy7GN2++tHRtD7Qr6nPGoluFa8Kkip/adxZvlN
 S+GcsuYR4F+NQHqjLe6a7I8hjrRnQjw3EKWlkKVeHaG9btGq6SKY/2eZ0fwbRU/ujJUW
 gTyQ9UnRR2c+OD6XRz7DPEf/I54W70jbUIr7mV5dGGupNi9qxfECs/iTYT4/QxJgfWgP
 zuFQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770802331; x=1771407131; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V8QcuNswCuJm2PpQcO33sZS5putPYLynqzNiG7AOLes=;
 b=mwQ/VbEbT8eLiBT+Ph2oyCRrS41X+v76WfXs+aoTVOJbmeSJH8VGBQVy3mtbUuuDB7
 9E46pdNsL+5k25aaDxgSPXdd4rSoa9L5qqoxJD19HotmScyP2Nfdj7MU/fCqLS/+8nn6
 c1ZZ/i/0y3uFVoBWNDSOxDDPomr5cuRq2+MMXEoiFKUZ4dg/jVShNySsEN4SUwvXZG5h
 vvDZLSQqGrjGqQ/nSp4qvlWPVwZPCDchsWWK/i2E64Jd0k1vEu+IXN56nraZdxEh7kzh
 Ka3rz7roXC/ixDw+4JfBVFKiMOc1bR/i0py4JFlZc4UVm+zCicp7qrD6vFCtRo++IHKR
 lUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770802331; x=1771407131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8QcuNswCuJm2PpQcO33sZS5putPYLynqzNiG7AOLes=;
 b=bs+10qvach6O+Gypf5kfSKtGc9XLAQsZK7zoFOYLpMq+jXIkQQB8HwRTaUWukjxZXC
 XbHfv7lGY+BnminmDLk4mpxqMYA6BPi9WtyIqPQkHQTSTKnRW06KWMKFjIymRYI6XJEY
 N1UDC78qkGvBYGkNMRQ11WkHjsSwSyBJKxZfaBJYvXCcsGYVzF1EfF+MMZFzgD7ji9yK
 FYM1Rb9+Rsi9I0H2JCLjv/1On1EPgafI4j3EL0qGUFlxrhyUYVYeiiv0lp+OO5lVuiNu
 +Bg8xkG5Lst+T2y/gWwKEteF/IeZz1r1Gs9kVnUJVX3qGgHHA8+bmfBgXyZpAVDkR719
 MfQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHWvOu3TYkcAZbFfNseTOont+6WdhaagqZwbYLpAM1vKm0ZtC2cTrNOYC9I4JvGTEubx6bBJQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzOR2/pjc8Ku1U75KO17bYmoZqoT2p1XgCVBA7rfiInvMmDhbwb
 Rj0ORnmY5D+U/taCOaaBcZmFEIvJplOVQejQPpDXaC+QLxY1F+1OGiZUDCtB0qFMB2zYQMnXt/3
 oJuZOVZUZh5YDMs/Uaf9oN3/GMQnMc6lcXkcJmbd7tA==
X-Gm-Gg: AZuq6aLTk33bOGT4gDX7L8v1+IgGdvZ82IF38gb2MUhmANnM4phcrkLOXBgL8z/CbZw
 u9EdGiwSPmQzDuakCSNud/j1MRfaT7lVvbZ+SThFjNIlEWo6/sXjl33Jijkz/pAvdvOvqPWSAu0
 dVtVaZ8vc2yib7WZqqeyO2tEUfZvKmZ5bpbKvRZ7lMMxLT6HnolT4lIUx6snD95l5Inr9MBJmgn
 U4hCioj/UEDHuzB38lmxZkIIGlYKeJyr/oefLDrOWDDJiBajREExsHUODPhgPaVbeFOn4Y1fiXc
 hQG3fnMKsYCDshPyMYVzyajVlsdfOPcWLDG1Kga+TaLpvBgkf1W52EhIStyV8200I9sTBUfpGJw
 n8oijwGwPjzW3vhAbfT7rWjAJHDQ0cbVjC3xm1/BJT/i+07GOgHBaG3zcwDQ4DihS/MP2aGNUhz
 Shc8KdgZXQtBkfU1RTZwiN4BeSCyJapOFLEXWdV4NxQOWFW7j+rKKvK8g4tEVfts2XuPvd2dvSX
 XMvC5T45GtPC+R64r6yYcwsnXV0F/Rt7/vKxiXl6qAUm5Z0uGLtGhuwwjZ0USwWgn4KVUG02r4b
 KjbAQ4cid31L0BPdeGrm2DZ6fZYTzKrOKAu96hHquOmE6d4JmY4u08o=
X-Received: by 2002:a05:690c:d88:b0:794:f357:965a with SMTP id
 00721157ae682-7966aae7da5mr16261047b3.50.1770802331354; Wed, 11 Feb 2026
 01:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
 <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
 <20260204161345.GY2603314@bill-the-cat>
In-Reply-To: <20260204161345.GY2603314@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 11:31:35 +0200
X-Gm-Features: AZwV_QjQVE0U1vtscB1bQHb5LZ1oJXbdhJGQ8dvB6fW4kVBUTr-AtWRmONrdS1w
Message-ID: <CAC_iWj+qEmxNeGVBcLcrzNM=BkVj0QW2VYW6ZNGTKD6BeRTNHA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
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

Apologies for the late reply.

I did test the patches but I see something weird on smbios type 17.

Handle 0x0008, DMI type 17, 104 bytes
Memory Device
        Array Handle: 0x0000
        Error Information Handle: Not Provided
        Total Width: Unknown
        Data Width: Unknown
        Size: No Module Installed
        Form Factor: <OUT OF SPEC>
        Set: None
        Locator: <BAD INDEX>
        Bank Locator: <BAD INDEX>
        Type: Unknown
        Type Detail: Other Unknown Fast-paged Static Column
Pseudo-static RAMBus Synchronous
        Speed: 512 MT/s
        Manufacturer: <BAD INDEX>
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified
        Rank: Unknown
        Configured Memory Speed: Unknown
        Minimum Voltage: Unknown
        Maximum Voltage: Unknown
        Configured Voltage: Unknown
        Memory Technology: <OUT OF SPEC>
        Memory Operating Mode Capability: None
        Firmware Version: Not Specified
        Module Manufacturer ID: Bank 3, Hex 0x04
        Module Product ID: Unknown
        Memory Subsystem Controller Manufacturer ID: Unknown
        Memory Subsystem Controller Product ID: Unknown
        Non-Volatile Size: 16383 PB
        Volatile Size: Unknown
        Cache Size: Unknown
        Logical Size: Unknown

Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
I tested this in QEMU

Regards
/Ilias

On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wrote:
>
> > Hi,
> >
> > Anyone have a chance to review this patch set? It is the last piece of
> > work to support all required SMBIOS types in U-Boot.
>
> I've been waiting for Ilias or Heinrich to have time to look at this.
>
> --
> Tom
