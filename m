Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36A9D41C36
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 13:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC4C83C94;
	Thu, 11 Dec 2025 14:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="axcF0vHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8B783A3D; Thu, 11 Dec 2025 14:36:23 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C5C683655
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 14:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6498a6f8ab4so148272a12.3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 05:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1765460177; x=1766064977; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qh/+VoBcCoUSMQMmgnX3EpKVO/YISKlfHH0qI24OlCM=;
 b=axcF0vHuGMVwU/Nos8gyY4isa+Xdhl3AUO2lFPo9qIVwh+4kmHyLcfBXl5f7RRWrbJ
 sqITMYTQ6Oj0C8aZiVwb/MpQ0xYV7vrR64i1Vq+XPUkXBJN9jOJW7eRMhFyJyI26nmKY
 pEEfkOkTAn+STnhd2VJkvsh89AJOe9l5oVpAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765460177; x=1766064977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qh/+VoBcCoUSMQMmgnX3EpKVO/YISKlfHH0qI24OlCM=;
 b=gNZAyr9ZOnQYX+3+bDkbtsQD72YR6ikcGIk2g/ttfEEIx+hQK/Xoyp/CAJEmkRIDva
 4UldECwKL/2zpHy/6oa756iQkk3IulrlDQyFgNt5LOxzT+hYHrdOxuyHW4SxFvaLHqXl
 H6zaHXp+TpFXSEQpoy3CbpwW8MC8NuzIXvgLKy39iiEMzFekF9AzuRIKWxqzqhSIP79D
 58hzpJv2Lte9Wsrsu+Uwl6G4hU2zQUSUazQuUF9Iltv2K9p2RGbPJWbUcBDhOzP+U4PN
 y6j9PcP4DdQ/pwKWwyflNMeLUoSgB5wTtt4Um7oDBPY+ApWzJm8c3gP2FFnVSVyteuTV
 uXdQ==
X-Gm-Message-State: AOJu0YyK0BC+tF4rZ3e0vF5MVq18SgwQZGtVWZX5fTi9sJlaAWgNgGXL
 kwh1qz4gBlVcgbHRDBAhGJSs9ky2tiE/Kbw55/lzKzKws5TouA8eKXNXJ9n71MBlinQRJw+desc
 6DlLtl/pIpZUL4a8HBenFwlNovaD/pZDCWTq1ROtQ
X-Gm-Gg: AY/fxX6MJ8SsKkLX21A6mdVNEW5URMM87qnIsUTcAWE+QdZkJQ6HcBsLRdINMTLY5aC
 2fB/EDqSaGZSRgzivfp6IEH/m3yMc0JU/9A/LGJPDOR3aAMmGurW00Vf6V/cHVIjxyvynnmbeXs
 aruV1hHSFqSwcWVVA+vvWi5x4NqH23zf+rvKMsXntq4O061Gsc+QWj2xpGyk3SEEDqPJUGaXcar
 z763eIylODEeYkXrpjL8D+A1HfJ1TgHHJYSr0W94VwyrhicIoIoCKN2Fza2AXGcf2TLUA==
X-Google-Smtp-Source: AGHT+IFPiRWQkSZLvnA9Wqz+RWTPxesf+605UcQgulnfjbTnOP8JyLJkomYg6NndQMBNQoZkPM5532kuX3UbBQffk4c=
X-Received: by 2002:a05:6402:2812:b0:63b:ef0e:dfa7 with SMTP id
 4fb4d7f45d1cf-6496d5e914fmr6048511a12.6.1765460177251; Thu, 11 Dec 2025
 05:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20251202182403.GF303283@bill-the-cat>
 <20251202212119.GM303283@bill-the-cat>
In-Reply-To: <20251202212119.GM303283@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 11 Dec 2025 06:36:04 -0700
X-Gm-Features: AQt7F2ojbu1xWXAfh_qIVQBLwea2OKNuwH9xXKLXBkhz7OjeZ5_L8-DaAHxDwx4
Message-ID: <CAFLszTiQZRY5qqT7kjUwCZdiHgdvZBJN4OPg25S5R_fE65h9bA@mail.gmail.com>
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, 
 u-boot-board-maintainers@lists.denx.de
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

Hi Tom,

On Tue, 2 Dec 2025 at 14:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 02, 2025 at 12:24:03PM -0600, Tom Rini wrote:
>
> > Hey all,
> >
> > I am wondering if at this point in time, anyone still builds our host
> > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> > Windows, natively.
> >
> > I ask for two reasons. The first of which is that a reason we still have
> > to support Azure (despite its slowness) for CI is it's where we have
> > macOS and Windows hosts. But at this point in time there's so many ways
> > to have Linux userspace running on Windows or macOS that I don't know
> > that there's any value to these builds.
> >
> > The second reason is more macOS specific and is that with:
> >
> > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> > Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Date:   Thu Nov 13 12:54:51 2025 +0100
> >
> >     boot: Assure FDT is always at 8-byte aligned address
> >
> >     The fitImage may contain FDT at 4-byte aligned address, because alignment
> >     of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
> >     8-byte aligned address. Make sure that the DTs embedded in fitImages are
> >     always used from 8-byte aligned addresses. In case the DT is decompressed,
> >     make sure the target buffer is 8-byte aligned. In case the DT is only
> >     loaded, make sure the target buffer is 8-byte aligned too.
> >
> >     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >
> > Which does things we must do, we now don't build on macOS. Why? As best
> > I can tell (and for a general purpose OS, is a good call), memalign(..)
> > doesn't exist and you need to use posix_memalign, a not drop-in
> > replacement. We could spend some time reworking the code here for that,
> > but for now I've instead gone with this workaround so that CI can
> > continue:
> > https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsulko.com/
> >
> > But longer term, unless people say they need and use these tools, I'm
> > inclined to remove them from CI and remove this workaround, for the
> > v2026.04 release.
>
> We have solved this specific problem without a large work-around.
> However, the more general question remains. Does anyone use these tools
> on Windows / macOS?

There are a lot of Mac users, at least.

For Windows, mkimage is used by the EDK2 people (Universal Payload).
It might be some years before they switch to Linux. Even if Microsoft
decides to switch out their kernel, I suspect the 'power shell' will
still remain.

Regards,
Simon
