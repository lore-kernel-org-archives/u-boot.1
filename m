Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81D7E66886
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 04:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08DF83885;
	Sun, 21 Dec 2025 05:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="B2w8mzNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD658388D; Sun, 21 Dec 2025 05:15:35 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339BC83700
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 05:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a102494058so19911485ad.0
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 20:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1766290529; x=1766895329; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V78E+qn9ZV1TY14GjhvXUYNfryInehUcr6UjvlhD3Dg=;
 b=B2w8mzNIZUtHe0SH9U5p1LxektZLLTSvIaT74zWOQPnsd2mgf9oLUc+cDxIkjl9NQ8
 fkcIBzmQx9xl7wfYZ5U1pJAHXQHUchtPU46/4fUsgLjSC8lKGxrJmCshOBQ3g4jVrkZd
 Q7llrgSoFGppFHEvnwlHFpKSTPmzuEH5Gfx78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766290529; x=1766895329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V78E+qn9ZV1TY14GjhvXUYNfryInehUcr6UjvlhD3Dg=;
 b=XMxjU5cu+vl+N9EQheg7QYbKNvkmH4MvqQxtOwnPhqiMQwsJtIioxB7Hb1/wmTuyXv
 +OjfmMBzkBQ4R8XfmnQ/CXZ5MhNWQvw8Hq2Lpp0vIAH86UjCwEEKHkQJwoeSadrU8A94
 2LZPoG5IOUcee/qmfgApSUXdILKhr1B9H0eIqLQHZ/ZdgiYMjr7sJ/VVlpxCg9lCqwAv
 B9A04fx/WBLyBszGQOAG4ZzGeDDpmw5I7M2YpnIU65ft7lfX7D7S7JbVHdQvecVWtMtD
 gCBkqVmS8arimuIDmJUSM5TagLDQ4TOWKwjQCYwU4fvcpNwi1k98c2KJdWIImE96Ujdd
 N7tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIIDeb4zcViyAo3VY7N1octPpGxUS4bM8Dp+4eBwj2yQwNwyCWpWBY0Gi3FcF41bEkvVDiprM=@lists.denx.de
X-Gm-Message-State: AOJu0YyCELmqpqG29EdH+gBcDiQhkcyiJafnxdRSH/EP4nNceuM+tgiw
 elPiqelg5zXJax6y1flE/5odTpc4LJcAwqbQUCReXkgt27ImZMXGwisTcS57kM88vjKVu3uHa4d
 aHg8sNbGPZMFVQL/ytsplZxpnjZ2qsNGURhiTQV+Qn+u539wyALboYEw=
X-Gm-Gg: AY/fxX52WCA3rzMgUnvY0NVxJkxrwEx6blCv8V90QlIB/Jvkp4goysinx6inImIw8mw
 AMcWLPqJQDZtQTvdtHfKgbtq/NtPXrVtrttVHKEFfYnrftAdT1AEW2CtWibode2mnotqPWCWM1r
 v0FxNMFhP0c9lfOr6GTi1VKTga1lX7KVZvtDx3y6Qk6ZdTA/HwMbPbXVXg5xib01/i1FtlZT3dC
 wUL39IuOxh/dJMsafkXbEYI3cTrDx/wZ+ylrOd1zWgpe/MNYPz1wyZuOorksHWDlvDPgVYjVV8c
 zFL7zTU=
X-Google-Smtp-Source: AGHT+IGLvBD2N766HveiwhDMGLbGuwE6IRJQSp98GQizkyru9NqBFFpP8PF6folxiK92QcZ0CDxY2xZr3dPw/TdOvHM=
X-Received: by 2002:a17:90b:4c41:b0:34c:2e8a:ea42 with SMTP id
 98e67ed59e1d1-34e90d6a375mr7883698a91.7.1766290529380; Sat, 20 Dec 2025
 20:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218190059.GM303283@bill-the-cat>
In-Reply-To: <20251218190059.GM303283@bill-the-cat>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 21 Dec 2025 13:15:18 +0900
X-Gm-Features: AQt7F2o8tDNqfGARwmRCwJEXV8VaMwAQJSDfzv8FOcyJbkTOBm7EWRC8iDuNCuI
Message-ID: <CAFr9PXkk3eOYDZbjTvZPgT8Cv+Wd-+hiEA+hPZVOVD0BJZ378A@mail.gmail.com>
Subject: Re: [PATCH 0/3] m68k: Add support for QEMU virt machine
To: Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 angelo@kernel-space.org, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

Hi Tom, Kuan-Wei,

On Fri, 19 Dec 2025 at 04:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 18, 2025 at 06:52:49PM +0000, Kuan-Wei Chiu wrote:
> > Add support for the QEMU 'virt' machine on the m68k architecture. The
> > QEMU virt machine models a generic system based on the Motorola 68040
> > CPU and utilizes Goldfish virtual peripherals.

> Well this is neat.

I have had a messy version[0] of this that runs on 68000, 68030 and
68040 real hardware and virt for years..
I thought no one would want it so never sent it.

I have devicetree for 000 and code to create bootinfo so that linux
can boot on 020+ machines.
Gist of probably the oldest cpu that can run the latest u-boot[1]

Can we work on this together to reduce duplication?

0 - https://github.com/fifteenhex/u-boot/tree/mc68000
1 - https://gist.github.com/fifteenhex/eed03b250b6a0113ab08b69be0375aa1
