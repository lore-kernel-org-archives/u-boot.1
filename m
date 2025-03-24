Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A7FC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C55810E8;
	Mon, 24 Mar 2025 16:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="LC2WgO9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7153981FBC; Mon, 24 Mar 2025 11:42:14 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DDCB81F6B
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30bfb6ab47cso41508341fa.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1742812931; x=1743417731;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LGsK4Gf4lelwKhmhjg9hN8Zn0hWbC3MQDc9kY8nN6KU=;
 b=LC2WgO9ZMVueS9F/a7CPdI2zWmeVPQGKR7F3HE3/2yrzYzb/v4v7YhGnKN+ekVeN9m
 pDSK9DezMUQW1gGXUzdVoYfARgBTdTvvbTlBAafvCDCOeW5dxVPZzfrs8U1lRfu25Hft
 g/8InfeLjzqW4HBH+SIrmXj70Gkl0Freilju3YajXTGMvV+4I6c3QvQQULZ/RIUT1E2I
 Pj00W1kDcZuaTaDHqZ4xiKEq3w17Ee9xDn3S5/EYYM38oiftrepm82xGnLVQnUjZPxke
 k8toP+F5Sc1+L1J4E6jN1RPJIrod0f0nUVdSwgA0EotVUSYl8Z27J7z9U96EBvs1VEoM
 ZOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742812931; x=1743417731;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LGsK4Gf4lelwKhmhjg9hN8Zn0hWbC3MQDc9kY8nN6KU=;
 b=hLDtxbtNLA70qtUEZJTqgn59fwHsSLMnvUWwewEsT1Zi8HujrcObUruoQqkCQcZwSd
 iJuiLWbPUuIXEVr/zhqIxXEg7RIu5UrDa9tQFWxUPtidKjaTQmhm49F0qfg1RHGlCRWs
 36F+dCkTron0mhBOUXN29efkqfzHW0L32m6iQ/dUq6EIHcxcCVzytBuQ6c70l5pyqYKp
 yXM9sMQyozw7Ov+o6+hgLibB+ULgtGdS7U+Tr3ri02kYg/hfr97RkTyMUqKrp3XvDML9
 3rYkEhoorJ8STngbF0cUeXkX2GQX59KMakGKwhoWfdZo0l8q7X4n6T31R8noYJHZKG3e
 X2Jw==
X-Gm-Message-State: AOJu0YwiOawGyDNz8UbAGzEKsVBqJlzynbFVfr3p6Fo0D351N6yboCzE
 b/J1t0ET9M2DVDhJPMTSrD0z4S+PYUT5+7craLiGB19OizYgvg4g7f8o4jDQwl9hBqIFs1RAAmU
 8xAvD8coUwSBjhbK6kfgZrLftFfEin1xtMWWrjA==
X-Gm-Gg: ASbGncshSM7CHzT7qPij6c8ZtMuNsN6YkYkxgf/uQd/zlnY7Hv0IPBtQ0hajscBW+Qe
 VVnvKSB56CoOG6kdIETpxyIRERea87I8AkikVczAcsUqQqgAS/1XYiV6Sd2CurZ0q1FqFCh8Q7S
 +sDIZezoSnLsKiO4PJ61MqYD3ajQ==
X-Google-Smtp-Source: AGHT+IHlxXXl+I5Q6wZZy2oKzkBBXZKMEcgON6hhG0A7PqhKOCcn6/nUczxHIP9Jh2FtwyhHhDbxwk0sH8z1sVSNKVU=
X-Received: by 2002:a2e:bea5:0:b0:30b:ca48:1089 with SMTP id
 38308e7fff4ca-30d7e2069aemr47476761fa.2.1742812931107; Mon, 24 Mar 2025
 03:42:11 -0700 (PDT)
MIME-Version: 1.0
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 24 Mar 2025 11:42:05 +0100
X-Gm-Features: AQ5f1Jpd_nDJX4OYa_XIRseN3chC1HxGd0L-M_MK_cBmgd5vN3G7aeQHvV9JIeA
Message-ID: <CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com>
Subject: usb:composite: data abort on second ums launch
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:23 +0100
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

I encountered a data abort on the 2nd "ums 0 mmc 0" command on
u-boot-at91 2024.07 with sam9x60-curiosity board.

U-Boot> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
CTRL+C - Operation aborted
U-Boot> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
data abort
pc : [<27f93428>]          lr : [<27ef7e80>]
reloc pc : [<23f16428>]    lr : [<23e7ae80>]
sp : 27ef4cf0  ip : a5200000     fp : 23f6915c
r10: deadbeef  r9 : 27ef7e80     r8 : 27f7d2a0
r7 : a5200000  r6 : 00000000     r5 : 00000000  r4 : 27f01668
r3 : 00000000  r2 : 00000000     r1 : 27fe1d88  r0 : 27f01668
Flags: nzCV  IRQs off  FIQs off  Mode SVC_32 (T)
Code: 45ac d017 68c5 4667 (60fd) 60af

From backtrace the abort happened in fREe_impl(), with some debugging
I've localized the abort in fact happened in fsg buffer allocation in
fsg_common_init() [1]

It looks like the buffer is not freed on driver unregister since
fsg_common_release() is only called if fsg_common_init() met an error.


[1] https://elixir.bootlin.com/u-boot/v2025.01/source/drivers/usb/gadget/f_mass_storage.c#L2511
