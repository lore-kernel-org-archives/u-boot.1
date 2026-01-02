Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEF5FA374B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 14:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B46839D5;
	Fri,  2 Jan 2026 15:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W3nrXjWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747F283A41; Fri,  2 Jan 2026 15:22:24 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888A88389A
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64b560e425eso15910659a12.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 06:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767363742; x=1767968542; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HneG6cc/c7Pj/nRVNYlefF8v0whF0edudsw6DqZxlkA=;
 b=W3nrXjWuV5lvEpSISU66TOkybUl9gAytV1y7EwstI1kAx1XT5YWS6gZF7whqjufrx9
 +Gou7FEeSDlmS/jLTodVTX1N/eyVMN807DT9PtmBY0Rn9RRDP/Q1pIHdfhCsH6kA2oKr
 LsaW1j23/Fcy6m37uy/XJj8qyAiBnqSU6r9ThUX6CXXREqaJt7NCGXM5RlUMBIwZuiYh
 TVOSLpTL485rM4srHrqMglOBYk1HnDwl+4GPJ8Pl1Q+JmVXXxHejedDdcguK26vf/MMp
 W5j8bgqVq/IlETCUSN+kFFzLnf/R/A01rGuHt+IApbBc+m6nJI1ITFT9lnoMimyC13jp
 6QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767363742; x=1767968542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HneG6cc/c7Pj/nRVNYlefF8v0whF0edudsw6DqZxlkA=;
 b=lpwYvi6zJE1ENx8T5QS/IsRCdl6XtMy+2Zx94QN1YRMeJu/Ld/TPiPf0gaMjL/c0gM
 9dq5O9uFMb9faEae1RG119UrXzdpSsXqVt0BDLal3l2fkV5FnuOv0P9S9lGoE+xSa5Pn
 CNOfd/RU5ZBgTaLrEcvYvl3nMDS08fvdcoNbKTHiA/OQqQfDL7t6Re6USBNJwV/Ppd7U
 sXSDErjDL1T1JmBWvU6+/K1CBMP8o4OsEVrXJq5Q4L1CKTjfVUSOrJDzffKoAP7cPe65
 jQ/gmGw9Iot7P4RXK4EXZZgOGID/xPFBgyLAsp73GOwjbYeS7okaSvhzVh+p8rxm9KJE
 2sRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfufoMJRqxJMiYeArLI/GQ6CDNVbNTSY6QWeCRHHceQR+Dc+qdNg37tfTvdSN794tZ+MWgKG8=@lists.denx.de
X-Gm-Message-State: AOJu0YxVASbrZBIe2Zf51SO8lK2fYMOuTrZEPBz1yGwgiEfOxv4RLmIf
 YWsdDVjfJIFgMM+Xc3Ky2559nXc1ntq/JZ0KwCYuMFXpCsuK/zaZ10HiEYWAqtUt/slSSsRjWl/
 0ls+Er6JlIgKLjO8dkPelLXlY9O8+IWY=
X-Gm-Gg: AY/fxX78XmQkXxxDXvz0S1LMRnMwEwXXBt4yaoR65lDNzmeZ63PKGmHf+YRSg4lHs7p
 ZxA5Ep4pe8xf6eO1680YVbAer7AUTIwoRs+jpmWMznb9eXo0HWQu7g1RxVNuV741YtnkGFUqOZI
 1XTrt5GO+0hX2l9L3jfIeCpiaVAVl8bugUa79e3wLKBQS0a68SPOiZmf/jH3bNWN878YkO5mVcp
 ILMYeC0eIa1TQyOl7FuzemFKZx2PcUO4SWclRih0e1oYJdKN/0Ch2GWTJa49e+ulOYeGJL3bviB
 zkCicxVNq1uKfJoK3m/CUl1GyEFQ2N8CVioC0cai38vdOIQzMekUkv7aC9mpvQZJfU1ykWdzgqS
 KrophlvYFPDx1wk0AdyRkrU0smcLu+8oWyaQMWEvR39B6ww==
X-Google-Smtp-Source: AGHT+IFleAD30OemreBHZ+n7YK1xkx6OhAkF9WEkaqguVANu6B8jbGb4U07njcvJK8WFn1v8+50rLQkHj1Vw2fuwU30=
X-Received: by 2002:a17:907:9811:b0:b70:c190:62e1 with SMTP id
 a640c23a62f3a-b80371d6c41mr4339967666b.35.1767363741700; Fri, 02 Jan 2026
 06:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20260102125622.144573-1-heinrich.schuchardt@canonical.com>
 <da40c4d0-8c8a-4341-b779-96f571b7db87@mailbox.org>
In-Reply-To: <da40c4d0-8c8a-4341-b779-96f571b7db87@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 2 Jan 2026 14:22:08 +0000
X-Gm-Features: AQt7F2rSca7ABFIaEdHytMWfiwTXEHNTB7xyjTN1INcHk3CwfZ3p_s7eNxiiZlo
Message-ID: <CALeDE9Oue=0L3PRVs7O8suPVDFBXL_i6o0hc50jLQ49HtaX2nQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb_kbd: remove match string
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
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

On Fri, 2 Jan 2026 at 13:47, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 1/2/26 1:56 PM, Heinrich Schuchardt wrote:
> > USB keyboards are identified via a USB interface descriptor or via USB
> > vendor and product IDs but never via the device-tree.
> >
> > Remove the device-tree match string.
> The commit message is wrong, you can actually describe USB devices in
> DT, see e.g. Linux:
>
> arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi:              compatible =
> "usb424,2514";
>
> Documentation/devicetree/bindings/usb/microchip,usb2514.yaml:          -
> usb424,2514

I think there's nuance there because I think those USB hubs at times
can have a GPIO to control power or something like that and hence the
compat.

> However, it seems this particular compatible string is ad-hoc and
> unused. I wonder if this might break some users like RPi which supply
> external DT and may depend on this support ?

I've never seen the USB keyboards described in any of the RPi DTs
