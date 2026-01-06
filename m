Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBC4CD0429
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 00:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643CC83A7A;
	Tue,  6 Jan 2026 01:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="VJwR09zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE5783D9F; Tue,  6 Jan 2026 01:58:45 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DDAF839F1
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 01:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34ccdcbe520so301176a91.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1767661121; x=1768265921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H4+Yto72WQAncu5cJL1JBbnaWQJKTJ/NnYjTeZQoPNI=;
 b=VJwR09zOzyz/hp+S4jQ74R2JOnHEWyNN0JfY6rGHhROxQUAYZ0xfUvCC9flRelJgYU
 85UyMTPLH/lZgI5QbXsC9e40U0SrzgjgMvd1REboLs22FzA07A6JWXoCBcCKF/2fa3w1
 4QlBjrnMOsTyMGgHcRXNX4IbUwJPSSN1eeQvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767661121; x=1768265921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4+Yto72WQAncu5cJL1JBbnaWQJKTJ/NnYjTeZQoPNI=;
 b=EMjVbq4xHuHpVlLUYYeEu5SoqeyHKLAEV9SPvSRyWUhhKjQkzBL3ZSXhIFW/Fs/g7Q
 5ZPBnN2lRVxRCgpJWjuYPdikjTIwnm51+Cxck1gvt3ghvura6LGDcvx9xX1Piq/6I2xl
 w5cWb9mPAgF26XwW5ZWPFSwu7VpV7IhfZXdRCdc+Bu3z5n/7Zkaq1eefzDtDJCJqqvhA
 LhTFxNOYEwiNJlfI3mjTdVtjgFbUWdDFCpD7d9hzGl5hDXOzdVRDLMLZ4lmM3ZboxP9J
 xFCDDWWQatFEYZn7IicJL4X3Bw1A/J0lU4hl+QHLIWzMIALA7CxhWgVCAw5KgmtWwau+
 4sqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIXTnsgTiALXcdN2w2qTqiq6WjS5hqn/FO7/gSAkKZYxPcm6Jh2HK2mXCJtajsC3L80tkIbhY=@lists.denx.de
X-Gm-Message-State: AOJu0YwykPC1kg9dTTsDZ468pBCrEfLsfUTi8S+SRmJUpHrIh5Cw+oRl
 nkfP+05OrydLEU0BryZwIju8KJK3Z708WAbnJzJuRSy4aP19VLn3kQI9Y5yCl26/7m58oj+HlhB
 XKwKwGp9nxvGfqMN7CEPfuaJOPNCI9y1npuiBVobNuQ==
X-Gm-Gg: AY/fxX6pYKIBknRImpJkEVhZEnO2fthGSfHDUOKeKKMRRWONobHSLJXq1o8mKQlXi+Q
 NnauL7IkeYIZ8o79ID9EcGHpRZ7cGkesSdqzEfKHcFbCqjzNBThnMQ8l0Mt2c5LIbMsDICp5fiD
 j7Wj+9dEaqwgy+StZKzZ/NrKAp6jaKFEyn8AC2n2Io0sbTUv7H655b6WnUhsQ3SHkKvf3FN/em4
 iJfKoe2gnRu1qJD8IMYlxSdvr3b4fxrt6bY6Tp0ZP+wuFBsQaZ0LUFIynDQ2ITHL5cEV0xt
X-Google-Smtp-Source: AGHT+IG9UfL+j2sPoC7TwdZvBJ89norKTDBXQg+C/zkuzHg2jnqO6/QD4KtNZaYdCTTL7/vu16Zic+9qZbKBgIHWf28=
X-Received: by 2002:a17:90b:4c50:b0:340:b501:7b83 with SMTP id
 98e67ed59e1d1-34f5f89ac09mr695702a91.10.1767661120818; Mon, 05 Jan 2026
 16:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-4-visitorckw@gmail.com>
 <CAFLszTiMZLXoXEk=JL3siZURVD2YdnmQ7HXy=Viw8uUFbrL6qg@mail.gmail.com>
 <20260105234725.GA3416603@bill-the-cat>
In-Reply-To: <20260105234725.GA3416603@bill-the-cat>
From: Daniel Palmer <daniel@0x0f.com>
Date: Tue, 6 Jan 2026 09:58:30 +0900
X-Gm-Features: AQt7F2pjcxJMUAq6zFvuEmqGitaY_nMwY66wYnH8JR9zL1sIa9T_0efUT9tp_b0
Message-ID: <CAFr9PX=S7X0Y5Rg2ySN8H_g7ot1R-Ksu+SZL=Ot4Yx=N2YDW6w@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] rtc: goldfish: Support platform data for non-DT
 probing
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 alison.wang@nxp.com, 
 angelo@kernel-space.org, me@ziyao.cc, heinrich.schuchardt@canonical.com, 
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

Hi Tom, Simon,

On Tue, 6 Jan 2026 at 08:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 05, 2026 at 04:30:26PM -0700, Simon Glass wrote:
> > Hi Kuan-Wei,

> >
> > You can package your own devicetree in the U-Boot source, to handle
> > what you need.
>
> That's not helpful feedback here, the correct path is to use the machine
> as QEMU provides it and not start yet another pointless argument with
> QEMU. And this probably applies to some of your other feedback as well,
> thanks.
>
> --
> Tom

My version of this converts the bootinfo from QEMU to a devicetree
inside of u-boot and then u-boot uses that going forward.
I have suggested to the m68k kernel side that we allow bootinfo to
pass a devicetree pointer and/or use embedded devicetrees in the
kernel selected by the machine type in the bootinfo.

My plan is once this very basic part is merged I will rebase my stuff
onto this and then start spamming Kuan-Wei with patches to add in
devicetree etc. ;)

Cheers,

Daniel
