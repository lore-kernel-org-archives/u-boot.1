Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EED7CD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2A0848EB;
	Thu, 18 Jun 2026 17:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cQE1zK+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57535849BF; Thu, 18 Jun 2026 17:54:38 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7009484874
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f95so1835847a12.3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781798076; cv=none;
 d=google.com; s=arc-20240605;
 b=T2Csno0McW2/xK9JVKVtDuNbfa6B0uDQrWEAPuMBuOrLz0CpvETxoH1CYA+f3I5y0L
 T57Ith+AAY2mQ6vK7FqSikHKChAzjGvALRu+28up1oq8WTCyyIoShYyANWp2J3D8Vb0Y
 FQlJ8xa0hDLR/2wtBB8eLjGU6QSIN6zrg12T7cRVxsEXJ3R9s2G9GHtQmaBcXNYrRjTq
 gPedfb/Wf0RxuuBgGVyw/NqscBE/cZIt1pZ/gfw1L60I1DqBGOzjwIIb9nzdiDECJug0
 dY8vy1Czm8Zts+o8b2+2ak58Ptxyq6sVa+njjOrFMxnAjKNmYzN6pP+O9nGby3/SSLHB
 TUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DwmYascwjtxu50E95dOJ2YT33Pza3UDb/vYwBd6vkAg=;
 fh=rLQMN6a/UX9jMmUsQuTe1A8wK9bTo6tPxTHfkaExRTU=;
 b=DX/NPCZXF5hOI64kvVK7UhPncm6tx9F6r7Gnlakw/HhXb7OsNhPc2dOsVKD+GKLZqh
 fXsc1lfMppx7DJ+sG7GXRnIqZ6w2efq5X/z2lqCM3+GIyJHV6l4CCgWH/Hqkwgz3Cgib
 VHl6nzzRT/0wgA387duv2D0Y7FLEcEfuaqoevGRpDsrdXcdhbqM0vU8TbT4v5f+YZIGd
 NgbW969sv8nxoZQy0CZSRBVAuKjtZ9lchwXo4gXraaqpNR60AwA0vGaOH5snPP4c575t
 AbVVBAY9V+JcY5CsNakckJRvZrGg36xVTpyQjH3XFhLdRUNE8dM82OtvUUatz6I+TQAs
 GEug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781798076; x=1782402876; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DwmYascwjtxu50E95dOJ2YT33Pza3UDb/vYwBd6vkAg=;
 b=cQE1zK+Ny/nXt0MdO+VYn2F78OAih42R0OnzxXiLe2cgZ4zH8625d5r5z0s2JQrwmQ
 +FpYUJPK1YAT/ZZOo8eqFNuidAiWWhV2XlfJ44fwaCWVs77tPOYqx7zXhXdCTr5EpkXu
 /58H+Pz2c7ysAoJ44hq9nbPW9hk95Faz/ez0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781798076; x=1782402876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwmYascwjtxu50E95dOJ2YT33Pza3UDb/vYwBd6vkAg=;
 b=rZNiLrOL1vXQJ/voO2zANrt7Haw0Sl8W+jUCK67rKf/AHjwk45BXdOYhjkfFGU/WAC
 3hB+RLDXPwI510bRQrTddexOBPFrg8bGfF5Rz3siJ07CNh5NvTsXzm0HjzTrJrUI87vy
 Il7O3vfXLQtIPinAyf+jERwBZ6QEcCnZaFuSvFddw/U7iAX1RE+p2Sg9wQShfpT8hKDJ
 XCIvYAkk0O5+M+73t8shhaVfE+yErqEHwPdd20naIl3YqvRVALNsJxoE8O/xNuEwB9bL
 Oa69aRKWzWBmplfTX0vBKelAUqThTSK16vMX2SOEHv/c7WG+lHF3veMbsvkGSotJkJed
 0foA==
X-Gm-Message-State: AOJu0YyiVbPtIP5wUDN4yCAq8G7D9kBs2qZKGIksLpK6B6aXuAfrZJ/T
 EFGTsReP0YnnUIciCkUwyiKf6lxulP/g3AuJOR4kgygLr4mFbzA7asqHDHhJerCWv0VJopgFQSm
 o2+8imEgJwP490qDTRH5f9s9Lm8Sa55PDGA7Ttn2yHPBYUHuQkhNRQw==
X-Gm-Gg: AfdE7cn4PqGVGwm8Wk3MUXsj78DvrP56Be9xUkiNXhzsloFjb+fmeAXUYoSc6qmWisP
 /npby+7YoJ7Y9wB37MXN9HepzFfCxzED2ApsKpoCLEnmZQeWn5Z7JKD5GcI/HgzZII+3kiyyXmu
 7NeOOkx3C9Jw9vtfgLOFgv+yXJW7zspueF6E2cz1rp/zYFgjFuD7d2n1/DVUtQV3EMY9OG4vjcB
 1kB++ewTaVJVbX6Sr1mx4FSm+slFnSmZrFEJVen0UcsLqSFqg/Tb/Q1J3pCUmu+v6IQUgozonqQ
 YjdjF9Mx
X-Received: by 2002:a05:6402:158b:b0:68f:cca5:51e8 with SMTP id
 4fb4d7f45d1cf-6954771020emr5187451a12.27.1781798075958; Thu, 18 Jun 2026
 08:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260605033907.1909319-1-dmukhin@ford.com>
In-Reply-To: <20260605033907.1909319-1-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:54:23 +0100
X-Gm-Features: AVVi8CeI1bU34P1UaiM1Sw9KTdBrhG-AdUjYk1OXCjZYPft7z6Q-Lewg4RO1Fxw
Message-ID: <CAFLszThSEcn4MUu67w0ZdHJoiyM9hqpe7_r7WiFWKq6bA89cyA@mail.gmail.com>
Subject: Re: [v1,0/8] bootcount: introduce GPT-backed bootcount device
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de
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

Hi Denis,

On 2026-06-05T03:38:59, None <dmukhin@ford.com> wrote:

> This series adds new GPT-backed bootcount device with
> ChromiumOS-inspired counters/flags logic [1].

There is no update to doc/api/bootcount.rst describing the new
backend, how to wire it into the DT, or the autoboot interaction
introduced by patch 8. Please add a short section so users can
discover it.

The use of include/cros_flags.h consumed by generic disk and bootcount
code feels awkward - the bootcount driver itself does not include
cros_flags.h, only the gpt command does, and read/write_disk_flags()
operate on plain u16. It might be cleaner to put the generic 16-bit
accessors in part.h (or a new gpt_flags.h) and keep the cros_*
wrappers in cros_flags.h for the cgpt-compatible command surface only.
What do you think?

> Patch 6 introduces the new bootcount device with compatible
>         'u-boot,bootcount-gpt'

I can't find a device-tree binding document for the new compatible.
The other bootcount drivers have entries under
doc/device-tree-bindings/ (e.g. bootcount-syscon.txt,
misc/bootcounter.txt) - please add one describing
'u-boot,bootcount-gpt' and its device-type, devnum and partition-name
properties.

Regards,
Simon
