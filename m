Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FE9FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F03484674;
	Mon,  4 May 2026 14:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kvrwF4Zj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC4F84674; Mon,  4 May 2026 14:27:45 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D8B83EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67b7c71c165so4442506a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897663; cv=none;
 d=google.com; s=arc-20240605;
 b=kico3Ml1dEIyqVBb8mo2pg8UzFcRWp+/ZT41LsvuOoepKM9eKG663HsvCB6m1LPn8d
 IN/X4pisHZniEXJbvGQPPQ8lkrpPgpJTKLOThJYKfOJE2f1B9EK/pt4/Vptl8UV2tGk7
 RmpmjqDSpEBSrJh9vTNlMhEOQMKZFgOph1VZdkY2u5QLYsQLL5ujKp2WDLMk8L/psl3j
 LwF1TE34ARt1Mg/JZ/amj4BOUpjwBwZN+9OpNj0xQR3XQbS8VWBUryDYOj3Zwe9RoTMm
 ASXG+u1pvvPpyUBjy5la9UxQupqdjGfqBG2pLrhliCyE1KpVdVRAD+cZZp3JINjaoKQh
 w9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R8EOwhJnLdcq/ONAbdvvlIPzMGyDbBfcowTTYo+UdVM=;
 fh=PKLU0xSNpsrGOfl0gQ17G1VaKViMSq+Ysfr2F1w3zVg=;
 b=YWBxZSkN4EvnYBMgKfH8zgjGO6tL8Ipa8Po0ZMQFV6zFNN1wRcUYKJN48HrIyTApUn
 qdAz0jChC+Ddqwrrd8Lnz81ao+GgkTm/IfWERy4CIlEPmMDY4JFE+MNOfRaAktkmYQvU
 VtGcplRS0bQwXMIt3i06ccQkOEuypOiFwODBPCRV/FRBZYc0HtXfBqaN3IzrBYQSzmym
 1PMW4qq9K8zXA7m7UqYJivl9WbQEahbL1Rs2wtrMoMhyHwWLBSC+Twq6g9s7+Uy43zMP
 gVGFu72+Q95fcktgEDME1YYHwU6Eb9k3/syO9iGKIvEQpWbpjuzIJfTg11WCVRHO5rlu
 FArQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897663; x=1778502463; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R8EOwhJnLdcq/ONAbdvvlIPzMGyDbBfcowTTYo+UdVM=;
 b=kvrwF4ZjeTNdAxwsbVGEPRiiEVoE7ybs1j0ZvjXwcb5kEgYGSgBDCmfO+oF+f3VD5s
 chW9ygtOUBFKxj8/F0f+S9A5gPMeosvpHN6ggaQoPfEK2OYb4Kkm5zGHXY3cPrJ/vFZ7
 Qx2fr62pZ9voZMCgo0vLV5UZHDO5SkW+59uIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897663; x=1778502463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8EOwhJnLdcq/ONAbdvvlIPzMGyDbBfcowTTYo+UdVM=;
 b=e5Z1zB063bhC2HhlIDY5n3PBKMTG9NAdim6ZxiSo6ZdBxRO6MOhiE6LWVFKgHg0si/
 QuHfs9WzXGr7Mkrawgt8kxawAsjADhw3r8a10xvTUOVh6zHV2y4uFeFOUAZqQs/JBMdr
 YA8hYyJsqx8FASITzapiIQcSxBx98RuhZba0XZCUiEZqLE2Rokm/eSBpV7yVkgmyBgVF
 M8tEbfHxfnG8ng+aHWALEb7qedyKSNNgCpNvjPM9h8OEHVGwKQBNJY8Rx6f7miybW2xZ
 2xAwtHXzTL/Ukb1oWrnX6dwmhe4+E8rOutftRx2JqBLQcBLg9eMdu/K8ArjdjyDfbrPH
 koOw==
X-Gm-Message-State: AOJu0YzHdJf7/UgEnaAut7+crQvP9sIfyuf9nRR+A0z9/usAe8I68VDJ
 ckXx2/uCHNptLWyF3EklzN+2Q+bHAx9kE+SnW9feE/iH5nnXv+vWoQ3BPSb05lzcDJCgpCIcJmN
 EdUo9duXXS3t0ukfFz3mTGJ6tRtC+fCaxx7s6HACVY/ffPQHyWWQ=
X-Gm-Gg: AeBDieuyqrJAVF2nppZJEfp9lzOvUPmDys6Rgr4c8mp3Rxvbq0Z3l3EEOplsRvoVhSB
 CT0M5Nt/53CXw/5gplfzjd8tQl5zFUQ9P7x9awZ8um4Xb9FaPMRQcIM2dZH5/q9blYtsk/bBcUp
 Dg/45uHL9tCAPxYbpf0E8wn+KjZ4hriddcUAYLocCpEl0F4Lys5+KT1UAC7QQi/XgseeJmVgpcy
 Hfhpo77X2r+gIbV1KNZySv9P1amqM8yApN2h30mI72r4bP9YDCN8EPAViLhAwfdabqdKm0SfsKC
 o7tGiZpreLUklqd3
X-Received: by 2002:a17:906:9f8f:b0:bb9:120f:965 with SMTP id
 a640c23a62f3a-bbffab2fb42mr510293266b.7.1777897662872; Mon, 04 May 2026
 05:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114250.791663-1-ludwig.nussel@siemens.com>
In-Reply-To: <20260429114250.791663-1-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:27:28 -0600
X-Gm-Features: AVHnY4LT55kEY9U-oG8WCyLmjZI08YdE7xceMOjItU-ZlOJRE-hggCSi2bTcznE
Message-ID: <CAFLszTjwGbKPKaVTmVfhNNOsrco7W8VqcmLWvXjk3d6d+Pk8=g@mail.gmail.com>
Subject: Re: [0/3] Improve U-Boot's TPM handling in the non-EFI case
To: ludwig.nussel@siemens.com
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

Hi Ludwig,

On 2026-04-29T11:41:40, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:

> U-Boot might be the first component to start the event log, eg when
> used in qemu. So allocate and attach the TPM event log to the TPM
> device if not initialized yet.

Thanks for looking at this. The cover letter should really mention
patches 1 and 2 - the pcr_read changes are definitely user-visible.

> I am not sure the allocation is the right way to do it for stuff
> that gets passed to the kernel though. Advice welcome.

Handing devm-allocated memory to the kernel is risky - devres can free
it on device removal, and the kernel expects the buffer to live
forever once linux,sml-base points at it. For memory the kernel will
own you want a reserved-memory region (or at least an lmb_reserve())
so it isn't reused later in the boot. What do you think?

Can we have a test and a note in doc/usage/ describing the new
behaviour and the linux,sml-base/linux,sml-size handoff?

Regards,
Simon
