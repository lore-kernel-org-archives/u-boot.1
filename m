Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A01CEA7186
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 03:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B50842B7;
	Sun, 19 Apr 2026 05:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PID31q0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 368E2842B7; Sun, 19 Apr 2026 05:52:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47705842C9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 05:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b941762394aso259443466b.1
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776570774; cv=none;
 d=google.com; s=arc-20240605;
 b=T4Ty7SyHaA8U93HSsvP374xjbJSdsW5bTxfsAsAL9gA5gtuAqo2//klMd+1fJBNMlr
 +OGfimYwq+lBdenWS4pGuP8BuNAig7pXki1+4FzeDg9Tk2QUy+htnRjuqyvimMNK1L7/
 BJMVjnb7CChXoa0cfS53MVJFEy4PnQHFuVSIgJSAr1vG6ufF+IhvxgbzfjNjU6CDQGQg
 B+QtHfYDy4JzH06GZJFU5XI3pe7FTueIZ1t3xRSURir0v3Nqv+n39I42P0W5FiFcABRi
 fPqAKlrBsVVeQnnt39AqjjOBFj2DhyGx9WQI50Nk1j5rTmtfF/8L1BFU1qatPt/i5die
 8pbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mRKimyzZxL/v+HygKoETyRIvBrfROyxzCEp9uLhrrBw=;
 fh=EEhmfBUJMOmBzICnFyzxhvsS+db8LkKxz2AAf+ZajXE=;
 b=EUIpzj+T1WB7uLAUGs0a8FJrTl1L8FHe9o1+bE7LY1k2iQymsCvTYLMWkRF3fnMEBB
 01EAhQM8dgk7wlULIu00S07m9CNRdToIfY4fhMjFzdS5yOQMGYPnOcS7D5/ul7WskEpA
 BP2eY9Ot8hmsaZG+wH5K6KCjKBGKzxvw0gvqufSg1RGzkavqIBfD3qGtHb3yDWWB5dN7
 WDAL8iWcIgLpUH0u04ee95trqhRqQmfa/vLAAyPQ5jmuQYQuOX29DAlscLJglCgqna/b
 wlDy1RWVsV7G5Hl+ZoLrgLPQ9juAWpnuFktnkHpBdC5CUdg4DuCis5CKTZLMVeZ6+Et0
 PJGQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776570774; x=1777175574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mRKimyzZxL/v+HygKoETyRIvBrfROyxzCEp9uLhrrBw=;
 b=PID31q0yUoApKwOqS0YtOxbE511cg7oUSPtuNlqaY2lPC43sxpyHtDK0eDb+rzC07a
 qg416neH18dwwNohsICH+lDrz1YBVRGiJEQ8xSexliZ/Or1Rn0ssClTNXQj1VgW/lrBE
 H8twrf0zH9h5rAKIpZVZ9GgFMc3qPMt/EOVP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776570774; x=1777175574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRKimyzZxL/v+HygKoETyRIvBrfROyxzCEp9uLhrrBw=;
 b=oG7YmSyYnWB8eDkbV+ka+T+nk600P6NI6rVViLPcftPkJwi4IXK+/x51JTbCT4alOf
 JUNVwv4JYjPWX/imB2svxx0vfM3VoZgEW9DDPTPBS7JijqV+W97lNoUut+JWvOzX0NVr
 9mvSdwkGaI5SEUJ+M67nt0NccoJlmnPNuetpsiAsntaNsS5P63ibXOVcsbYgbN6YKGj9
 EZaJWsCM+F0kkmcywTWPQctJOESHGdJl7KqHQU5DMPuzL/beTEj6qLXMBQWelLpZq7W/
 m73KF+c/5fNwvTseFLYCd8MqPlGZ4/nke/bMRn+cJHDYMSAAhCmLCS7uhxnb+CgZZ832
 +Qfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4IXKpOizKmeYvyzcunrYIXzbZGHBoki5yh1WjaIIq75KZPhWV6BebTQaYMRsmYYazy1OV18Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyF8dMQ5co1VhzRQiw4VLt7yMQ2lNMELX2JXV7byLqouD16ZWop
 vIjTGiC8JFtsZ40rTq0Ho+XZo6HlsnOSL+LEV9cZuRn+GcYt4LZdSEJ5IAUv43spv81LwOGNYy3
 YrL660aYfpXl5AOuN51AyiG1yo0b1hb950K3Yi6lq
X-Gm-Gg: AeBDieu7UJusQ4ej/W9p0WOF4NnASkk0f4EW6dse5tFgzBmF6M+koOmhkEiZch1Nx53
 d3kwKLgqv9Nmx0PhjFwXCQ/fXosijC/DovlXlIEcWrYVeMPkvLOqf2l/9h0sgbv1ol+ImRncB2I
 v3aWkK6s63zW3+3A0zxRPI2JmJTEjzvnfwrIDQSu/RWuXYD0ds/1Xa7Rtf/swP/3kiTe1kbSEmh
 ndZRHjjzbyYdb6xGGRDwJuwFjm9ptEzq9A8H1AA32/yMl4258hzvnXR6D0x+NXDtzauCJhLgdGu
 B7DPdx/6OX0kYi69tF1c
X-Received: by 2002:a17:907:934c:b0:b9d:ecc5:5981 with SMTP id
 a640c23a62f3a-ba418e86337mr398399366b.15.1776570773625; Sat, 18 Apr 2026
 20:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-6-rs@ti.com>
In-Reply-To: <20260413203555.1990337-6-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Apr 2026 15:52:36 +1200
X-Gm-Features: AQROBzCTPCK6LROPM9thJsTabRR8B0OF4uVP9fuloIJMwEz9EleQ-4JVQrzfJiw
Message-ID: <CAFLszTj6orczSi0FBvoZVZJuuxMnPYtsjEkMHgK4rG7kki_6Qw@mail.gmail.com>
Subject: Re: [PATCHv3 5/6] efi_mem_sort: use list_for_each_entry_safe instead
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
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

On 2026-04-13T20:35:52, Randolph Sapp <rs@ti.com> wrote:
> efi_mem_sort: use list_for_each_entry_safe instead
>
> Use list_for_each_entry_safe and comparisons against the current and
> next efi_mem_desc. This reduces the computation required for merging
> regions, prevents unnecessary additional iterations of the list, and
> requires less temporary values.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> lib/efi_loader/efi_memory.c | 48 ++++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
