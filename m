Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B26F30297
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 02:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96AC839A8;
	Mon, 16 Mar 2026 03:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m0HfIErv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF06783DB6; Mon, 16 Mar 2026 03:34:41 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F196836D3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 03:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b955351e0a6so644267866b.3
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 19:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773628478; cv=none;
 d=google.com; s=arc-20240605;
 b=LhDBVuarjEiS/Ic/kL8Pw2Gdl47KU8ALNxbcvGjJSPvzFlsyyWqDBxiou6eSbW5iJj
 l03zuNZMyf/RTuCHqrjPCKxpv6nW1KpSeW6/x56E69V9C9psj378s2jhsIRgGQyDw2Kh
 O7cc9GYn25/3Qtac66uduRsNBnDPJqCv1hIK1vjuVog0VEKhaA1jPOW32UonWEAG9BYv
 APbR0EZHZX+nyFGtvHo8bew8ECAvNgMy4TpQdlbRNupCclORa7ePjz5K/quy29st9PEZ
 ax6AGWIJ6N24fsa4e9pV54/KytQ+EaKo1bKIjpZ9sDEgiM/k5HDFW2tistSpmXK/Gizf
 eifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=j/qt7ROdMQ9lygCocTCh9EAfXr3gnABPL3yzRpkRnYc=;
 fh=GQyKwPRr8dOXk65gAXuiKSXcuQM8h6Aog4njpiF9nLE=;
 b=kJfPpGxJKoXOCgiCA6CSx8mx5FkHIbZhcKSGgAop9rRKbl0y1o251eHaFmeSQVWvxV
 rajP7xDU/G20P5pB9Yv2lN2TLSAJiewaTbSFqkIj/JkodFsZnKRHVKhSTlUsLL0NAcuq
 TzhHprEOIFn4NKdElxYV82W/3rz67MMBMUl09M5kSisgCwUvGrGB1ShrVYqW8HqoWDtF
 4FMQrJrgwfDtK0kts7IC6UpYwVyFD+jl0rwRlyykya8SNJLD4xNiqevFOxTxP6nby9kw
 w3LOfm35/x4P6CShhATKMhXnb2CfK8W60fafXnoywMlswI08/xq7e5QvxuZB/krknzRp
 BMHg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773628478; x=1774233278; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j/qt7ROdMQ9lygCocTCh9EAfXr3gnABPL3yzRpkRnYc=;
 b=m0HfIErvMElgTa7wVhLIiSDJ6ixhciAsdMsrum6GmBZlgQ+xZ7pxmPWLgEmtl5P1UD
 LjOzYUN7zhJTuxpI5hTzfudpzK/1BeKjAF3Wud+ZAVIpyfYlskXufCn5mCzYP7kb8ceN
 QbYCTyfOsGxpMM+YsTIHqT/MIFI0pQJVaNzck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773628478; x=1774233278;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/qt7ROdMQ9lygCocTCh9EAfXr3gnABPL3yzRpkRnYc=;
 b=sGefhYgCd2oK8ekM5U3L+poKMWgJea3nBuK2hO4dDhYsbHbdw3jlcmnaxnTCPnMkwy
 8sFMWvCz/IN1ts58a95KEd4SpfZSWWhK6B4HdtD2tUA6pyAWIuIrSLbslKdpd/ZNf9uL
 MOTDugJLGLUq8fl7IXceUk91PWR7vsF+LkAHQRrkrfFwVsGRxYoZGyXcG7MJ7vhBlckP
 Z3V8/9uZR8E1h4Jtpyx7/NRiaOPZtXWzYeCc49NG/mHhj4v71slK7ucNHTyII7Qm2jV5
 KCKxXcL5zJw666xN39Vw8H01ygbKjCuLA6vu0NjSufoMK1xtoQg2EObmYOso4viOsVuN
 4s+Q==
X-Gm-Message-State: AOJu0YxBGEzOPDVaZDdQK0gL62+7MgFwS6UwhqDodnomop2hPVDm24F0
 WKP5bIC6sug2x9A6KioZE9zkQBUNOmDKEHCz7Pf82twXdlsyyKkoiLD41THcrvwbIrdKS/hlr5g
 gs1j4+T9DW8ZErne55kqt0jIolIIaULNDI701pgELv0KleOL7xOpfTw==
X-Gm-Gg: ATEYQzyVs5nZbVSQdh6qTLzq+ZxjxPrDrj+evC+PRb7/f5J2LKvh1OTI4vdIJJXKH7J
 ZDqsjoutEF8Qs4LWK8xtNIDqLnIb4MvYTPLzQ37yBUY+wo7aLKO5wzGQKxKlJ16BsKGJJUVqAMZ
 C3Rnf1jEo0XXk8M+b84yQUzIS+QPATL01T55cjgL0lJYMuxN4h3pTNba6/hf/Z6oif+IpN/sCX1
 t6XJiJAiYo27TvUw+pkwJFIzVAHaKf/a9AeXcDzTEqGQxGuPMT3UonCTXEE+fGN3T16CqCIR1Sw
 JX84wA==
X-Received: by 2002:a17:906:4fd0:b0:b97:69eb:b6b7 with SMTP id
 a640c23a62f3a-b9769ebbbdcmr727010366b.51.1773628477817; Sun, 15 Mar 2026
 19:34:37 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Mar 2026 20:34:26 -0600
X-Gm-Features: AaiRm53JoYyG8EF9ocWbH1IscQhWuNEhW-2CksQft12dQWZk_PVkTrdA1cogG3I
Message-ID: <CAFLszTheetVyGtiTKottzbdpCS-aqg5-T7GOFh+5ih2LirfKZA@mail.gmail.com>
Subject: uman - a small helper for U-Boot development
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

As a background activity I've been putting together a small tool
called uman that wraps some of the things I do repeatedly when working
on U-Boot - running tests, rebasing patch series, building boards,
etc. It started as a collection of shell aliases and grew from there.

It's nothing fancy, but it saves me a bit of typing:

  um t acpi            - run ACPI tests on sandbox (or QEMU)
  um py -b not slow    - build and run pytests
  um setup opensbi     - setup opensbi so you can run RISC-V boards
  rf                   - (alias to 'um git rebase-first') start a
rebase at the first commit

The code is at [1] if anyone is curious - Python with some aliases.
It's pretty rough around the edges and very much tailored to my
workflow, but perhaps some of it is useful to others. Note that the
'ci' command doesn't work with upstream yet.

Feedback (and PRs) welcome!

- Simon

[1] https://github.com/sjg20/uman
