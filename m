Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47938C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 22:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638418762E;
	Tue,  7 Nov 2023 23:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bGCIxbN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FB848766C; Tue,  7 Nov 2023 23:51:35 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B068762B
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 23:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5441ba3e53cso8055771a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 14:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699397493; x=1700002293; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=toMJaHEbQc5JmeoNT8A2tLQHabDvSyngw8wsM95MO44=;
 b=bGCIxbN7oLwMRWweZxnBGnevpf57rFcK2kIn1pwpaIIV2vriB1sjpTPYZgtbDYygCC
 w7RemJ9SAyUzoa9Z/Cs9VH9UjHgkQh/mKY7E/ZhdcvH+6fK0K0XR+95aXIdNXMh72BQp
 Eznzeqgc5iCYbpyHt+YQ8q07zdD/JkUGAk+f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699397493; x=1700002293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=toMJaHEbQc5JmeoNT8A2tLQHabDvSyngw8wsM95MO44=;
 b=D74vKAnPm/RNQc3VkysBhQ+BHRq2+VxDv4j2BbrNhuSSexOphw91AtFp+1NU/Z/KbD
 U7prHAhqjTE1UVnNFOjBBeUbgdgh/Tin+wZayrtIRkBWFRYs/0evTltCMdqGYg8Dloma
 nLVppIlZHCB5BKDL93LLN8mDanJt5pyikD2lzoTAqzCB8LtsF2jSoWZ/6VeI309RyEJq
 tWERwmLxPqg3kk2jylCpHh73g+LK7B60/Wr+Nj6VWRZjtJiJdb5oJfuxPCy6kHW3VY23
 HboHKrP2DLDttosGRI9CXNWA6RcvRgc49OCTrSFDmZeERm8OY7PpzzTYcuHbjel7dxwq
 qhug==
X-Gm-Message-State: AOJu0YyI7AAyRHfLTP8oMlExwuGYdrlZR99Qpc8FUQAeTwP9Q3vXUa2h
 zDfwg2nFdbymoAeLDnxG5jURJjEtC40qzR4RcdTY7w==
X-Google-Smtp-Source: AGHT+IFHbbQYzjW0NQE1Xg3D+MX02KPV7gDdhzVyLOTgiPoFpXZeOa8r7gKBrjWulvJK2+tqRzojojAsVntSjl5ebbk=
X-Received: by 2002:a50:ab10:0:b0:540:346c:7b2f with SMTP id
 s16-20020a50ab10000000b00540346c7b2fmr33393edc.40.1699397492546; Tue, 07 Nov
 2023 14:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
In-Reply-To: <20231107223837.GU6601@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 15:51:21 -0700
Message-ID: <CAPnjgZ0PqwCnm_Dn-ydR+VkN9qGU8FN-wy17802bQpGQrxTbPQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Anup Patel <apatel@ventanamicro.com>, 
 Xiang W <merlew4n6@gmail.com>, Chanho Park <chanho61.park@samsung.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi,

On Tue, 7 Nov 2023 at 15:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 07, 2023 at 10:27:50PM +0000, Conor Dooley wrote:
> > On Tue, Nov 07, 2023 at 05:10:23PM -0500, Tom Rini wrote:
> >
> >
> > > further clarify or not
> > > the RISC-V ISA thing that's elsewhere in this thread (and part of the
> > > kernel, not a U-Boot thing).
> >
> > TBH, this a bit fragmented across threads, and as someone that hasn't
> > been following it it's a bit difficult to tell exactly what is being
> > asked for. Would someone be able to ask it as a direct question?
>
> Sorry for being unclear, and thanks for asking. What I think the U-Boot
> community would like to know is, what is the device-tree based way to
> know if a RISC-V platform has the Zbb extensions and so the RNG opcodes,
> similar (in concept at least?) to the ARMv8.5 RNG feature.

Some more details (sorry) from your friendly devicetree and driver
model maintainer:

- U-Boot models hardware (and other things) as devices in driver model [1]
- U-Boot requires devices to be in the devicetree, with very limited
exceptions [2]
- Where multiple devices exist in a uclass, it is desirable to be able
to number them [3]
- Similarly it is useful to be able select a particular device, e.g.
with a phandle [4]
- U-Boot uses devicetree for configuration as it has no userspace

Regards,
Simon

[1] https://u-boot.readthedocs.io/en/latest/develop/driver-model/index.html
[2] https://u-boot.readthedocs.io/en/latest/develop/driver-model/design.html#platform-data
[3] https://u-boot.readthedocs.io/en/latest/develop/driver-model/design.html#device-sequence-numbers
[4] https://u-boot.readthedocs.io/en/latest/api/dm.html?highlight=phandle#c.of_find_node_by_phandle
