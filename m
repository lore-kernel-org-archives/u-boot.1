Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024D2D0E6C7
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 11:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 259D083FDF;
	Tue, 25 Nov 2025 12:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OikD2yG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0BB83FEE; Tue, 25 Nov 2025 12:24:25 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581C483FDF
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 12:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c730af8d69so3231428a34.1
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 03:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764069862; x=1764674662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+fPq+JQUD9ujvWv5tnJ6GZ3RPLdF84B1/6hYJ+szX8s=;
 b=OikD2yG0Q9E71bN22UfZGviljQ4E8/y3gmkSKlw7kImDxx7XJga36/rII2SUwhjuRw
 OxGyeqHEANcg8GAedCuaHo0toaJzUCZA1CpSsTmY7xx1IbkBrymCfdRVEmwJIh0UVfRR
 MiKF7U+5HcNP4O26FRWhw3EJnNyDw2mPd0i7ZSLmqYJutkbk1mjQW4wXOx/G0ArDWcP2
 d96gVcm8PwEG9djcJrQgHD+16tHRS1fYKt833jXC0/mktMK6fPD63fkrtapoDnWITIV0
 Y+MQz1AZdsf+O6LJoDeykV8GAdFC3A9bS6muy7FyTy+cyFyGlMpzQQMLkEpsOpcNsqfV
 cTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764069862; x=1764674662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fPq+JQUD9ujvWv5tnJ6GZ3RPLdF84B1/6hYJ+szX8s=;
 b=Y6OM8PxQ3dtzTe6t5ITi5eg971B+90RlZ0rS9U8AygC3bjFvBc7TnGXmG5CHY0GcvJ
 +INl/h15zeriQgZ5OP+E5noZJgZfxBbXIYKqseONTe1bd8uhSpcymKTBg0qSWutdSDRD
 yqLnmB+rV4FZzKPZ4kviqOAehUcCcfPpnG2vOqMOPDvsph+D0dr64CaLxo7FoDDsLy8L
 u3vpv3cXjL1Br8opidotQlU/9+PkVPncd/CQ8qOWi5izgepe2da/F2ElNhg235FwSzYZ
 octQ+aiqP5YJEc8Ke49vHkSCiEVeLeEpQYvlZis78M3FQfsQmljguYPGMllj9FiUOG4j
 WgpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN1nIwEUaL4PcwHb2wz5CHy+uIADkIhQa5q7XFw+Hz+o7oln7O1e1FwEm8bUD5jKETr3JxA08=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2VfjtIlitT6E/qsPmXqclrejDEhozG/ITDRKbw4dERbG2zL9t
 vgIw1hbbP28BP2GKAn5CX88+mOgW2TAzmj7Qw7dauR1uF+6CVQNbJXN7PBJMF0INn1Mkn5ynZNR
 jcxj75qJ3k9cbbjPfNYk7KJN/IQMoy1I=
X-Gm-Gg: ASbGncuM+MnirH41iKiHHaqOF5YlC1YfA3Q/APU966lwhfO5KQ9xiWmrAvhjgMgdL91
 SnKy3EIQQLZSl9OrxrZrefvLn6x/mV1DzA3I7XqRth/QTCzianW2qgOnj+/aqSCk36QCWdrFzbI
 9oNakDAUhT63287J3EZBkSRFeugLe5wDgQVKo9KYD/oqz3j+G9Zz5voPUc5/dQ6TsW5B6EJXZoZ
 orDug5s5DOnf+FuffyE0jBCcPfivsS2KNZqiT1p4XbvWKZzbOMgBVKDpcDzIlraUodL/Q==
X-Google-Smtp-Source: AGHT+IF0Zf1R4HQki4T7Bmi9NrgLcXLX0uH0FPzEwM+ll/M7OnhsyPThXOBs1XKCU3KC30puzmyDOF0AnCbpO3yunXg=
X-Received: by 2002:a05:6830:917:b0:7c7:586c:846a with SMTP id
 46e09a7af769-7c7c3c4ed8fmr1355232a34.0.1764069862059; Tue, 25 Nov 2025
 03:24:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
 <CAN7C2SCEnkiLtRyiRx9ykLWOWJFNkUOh-UNZ+Qaq=bD5wk_a=g@mail.gmail.com>
 <c813c1a0-d224-4e82-8494-1a7d2676b29e@siemens.com>
 <CAN7C2SBtyc_i3inaCMBCUr_x40_d1LqEARtb2iJms=rHt2TtsA@mail.gmail.com>
 <74bf28a9-dbcb-4bf0-8f99-9239018a94a3@siemens.com>
 <CAN7C2SDz08cDgKQXMwJfDf_pVfqhhz2BJhVKHk2WqHP+hhE5Ow@mail.gmail.com>
 <bf13f555-b1e9-4208-9497-baa3870bc0ed@siemens.com>
 <CAN7C2SCQd9M=ghBFt2t2Kg1w=VLA0DOMY9HnbwTH2Yram1iYfw@mail.gmail.com>
 <eacdabf6-9cab-4782-8712-b74dc51fd2c5@siemens.com>
 <CAN7C2SAFJzJpmm7pTS3GjZQhR9FzeB=sgVquHEJ3BHcxqz4tcQ@mail.gmail.com>
 <a0c44ca9-8b15-4ce7-9d1d-519361577cd8@siemens.com>
In-Reply-To: <a0c44ca9-8b15-4ce7-9d1d-519361577cd8@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 19:24:10 +0800
X-Gm-Features: AWmQ_blJlHxlIp8_ff75jbWuSuKH4pJYxtUYuy6YwuI2G6E314VZqe1MRSC6e9M
Message-ID: <CAN7C2SBUNg2wY8U+_npFgiRgnvOqfhOw4gZj2-DZH+q8HmqSiw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
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

> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/next/wic/de0-nano-soc.wks?ref_type=heads
>
> Jan
>

If I used that I will mentioned from beginning. That is wks which is
a way to pack a complete image. Possible yocoto build flow.

I did not happen to use any these kind of build very pure
dd if=u-boot-with-spl.sfp of=/dev/sdb1 bs=64k conv=fsync
I did not encountered any issue.
Otherwise I won't even push patches and raised other issue.

Let T.F. debug a bit, but cannot see this patch is a must.

Brian
