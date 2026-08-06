Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548F9C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27FFC607E4;
	Thu,  6 Aug 2026 13:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8IOcFwvOMm8a; Thu,  6 Aug 2026 13:22:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CCEA860763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786022523;
	bh=Sh80hsTRUhY0soLGA8mz2CvUh4WQhtRT2xD6ivGndf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iuwUF6inxKcrpPDJUSkDuEmcRVI8iWRonzXdQcCXG3+zTukElEPjDAvfCj79UEgaO
	 lPTZ67T+WeISvOESrmSsdc36mreJRF44B2NzTYod8O0Q07OVe1NagFwTbHNq6e9781
	 ri1na6K0aLDbHf5FK1iBhEqM3QVx0m3qlp0SgGS9joQ1HtopEDki3eE1cKKt0GnwT7
	 6o+15s35zf+HupI+g0bF+fzfcEAaH34VQnLfZ6xcDQ2lGtZQL5guooL56H3jqgDmVW
	 9nq739t2+3QfasozEMkb43GER3gzJfyAK+/MXLxUJBFfsQLcjyo27G8WPr1yV55boy
	 jsut7J3+PpHjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCEA860763;
	Thu,  6 Aug 2026 13:22:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EA72218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8215A405C4
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yr9s_V_xgtx6 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:22:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A21A1405AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A21A1405AD
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A21A1405AD
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:22:01 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so3019768a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786022520; cv=none;
 d=google.com; s=arc-20260327;
 b=HUqYF82AvmewWWD9biYHmtcrEHeRE03w6jdTlsVndiO0wKA7RuVwqL0M7HkIQ30saz
 uC4bSMbvIVRqx2EDMs00uJePcqRk0i5GXHbMdh9ODBn3JfNd0bgtqp+ycN02dK1oAqTh
 1+qDzc++OB57895bkmmCrqDZuIuGp7ihbcXyH8k9bnXehBADyrvE9xZc21/ei5w7pZ0m
 z6Os8QmkqgBkWM6VSfCvZcSzWOGUECLXAOZu1rnMr9Knqn9GDF8HEMQhgRscW9Igvjoj
 cbhNJSBmrSUEfPRvA+1fMImWbeMtGZoroGmGAwxCwdq5rTwxm2Q8rWIdRsHz9IQ4fVfG
 VJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sh80hsTRUhY0soLGA8mz2CvUh4WQhtRT2xD6ivGndf4=;
 fh=7xxvTH2sQtJt5Ay+3iwadnldSn0Fw9o87gYzUPDaOIA=;
 b=SIa57SrqHKPx9RZ9Sg/QMY/dK6Xeu7eNyjllFqiKsLqHnhtiXleNrLRgBsmQekFIe+
 81lnrHGereoAOu0zNQ1kihBJ6Hbz/znG646PK9YfP4pRXOKlUR4iTNwrrJ6k7d8CYZzQ
 PJg00irYkv0xwszFmwnzRbRvw1fEi5UUozTqgKeAUFX0pLB9t44Rk7HVEyBAjmJJ7fUi
 PLcp3TAOOVKkFANm93TlR2N50i885Uby6sFeR2BwY6NNkMeMNF+CZnqwqbSljlyv/33n
 GzWN94wIL8qvk4tXSDjrw7VxfAdTXV/QnRvDOEEMM5YjaqlSEfdv690C0wT0+/vrY6es
 Lq2g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022520; x=1786627320;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sh80hsTRUhY0soLGA8mz2CvUh4WQhtRT2xD6ivGndf4=;
 b=c9Urw1wgoV9weIHXSAWs/glCDDn0GLSWp8hyz0KUNi+LZ4A/WLO3RUmGneMJsfKdlc
 UyMCcalXNrL6Q8ImicaKmvsWNe72UE/pnJHLncIYf7oJYUFs1TGaTu1vMJEGRIs5czFY
 M/21snBx2mUADgLIEINkrilgMQ0HuCLGQQNx5N/wzACrsOpgHl7mVAIxKzph0JxDOb2c
 rnIxJg3dIKOBSkQ4Hzh8ulVVPtUAMS78YASJWDzbMvCP4+O6Wk8SFF7dAUo39pEKfGxc
 5xdy4v98KoiR4dH8xmzRWOouvhgnnVFm2UvjAZOquyhjFmQkroyKiW4QyTKOmgg4T66t
 mjlw==
X-Gm-Message-State: AOJu0YzZa3r74rbjtDOe1iYszz0m9IF2NaYkAdYLfSlUMniVWn89O6cR
 0nxTGoqUljYCDJvAgjZTI6kKR9/zqfPrNP96AAVJgVOMvS6Ib4OYkUDAlZr8s4A+A8obJ3I5afV
 egZ4CAH7qppZLrFZMp7HEay715sun/oTaux8eeblCPUpMZe4J3mc=
X-Gm-Gg: AR+sD12Y6rrj75oyzXRnfUQglX+gPCuD3cLJPZ/UM94mrSCU0TZIrUZoJHldbSBXE6U
 xC0FgQP9th1mH6yTcRewbb0+vuBj4W8qq8izZmfCf4kMd4u29QKaF5LNMz2if7pXQmoycUSlJTX
 Fg9mTqJh2yS7g23beos4R7Wuqnaw/Wz75vuaPLdaLWncz+tmnKc157AD9spg85F42xuH9L6X125
 8A9iROexmVFgW3ssslOuh1UounRGUinBRRV3BhTy1LS/cAgu7Q+Tp2rd1aYK9Y3dT66Fe7NxH0+
 boe9nmZMjUxmY8tLImJkR1YyzlPI0TPH8ae4EzUHyr8SsEoPyfTvyQ==
X-Received: by 2002:a05:6402:4593:b0:6a1:854:e75e with SMTP id
 4fb4d7f45d1cf-6a14f14c5d1mr7810645a12.15.1786022519691; Thu, 06 Aug 2026
 06:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260730155119.3328020-1-mehmet.fide@gmail.com>
 <20260730155119.3328020-2-mehmet.fide@gmail.com>
In-Reply-To: <20260730155119.3328020-2-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 07:21:46 -0600
X-Gm-Features: AUfX_mxT5nrLr_k5PC5I2TEVdM-ixQLGsBQH397ogDSesHXQXuaDVxLPffoRXQo
Message-ID: <CAFLszTjcmcSgBN=bL1QN62Q9NAoYeEjHrRTbKCV-XquNrE=qzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: allow bootd without bootm
To: mehmet.fide@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786022520; x=1786627320;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sh80hsTRUhY0soLGA8mz2CvUh4WQhtRT2xD6ivGndf4=;
 b=PjY/C5NhngsjU9tzQNzsN4eHxdWGajBdmFhPRnIc5FO+jcBXEX6rBxGrR2PEWVlCw1
 BseY68AtJ/5afhB18/Qq8ogpJKgLKQjbpBLRx0a8P/zCIIIMTY/SkYnGfZ7pPasd83JD
 UR4mpwZ3uRrJBbS8Imuu3LRKpIeC2pt2+2ez4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PjY/C5Nh
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-30T15:51:17, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> cmd: allow bootd without bootm
>
> do_bootd() runs the "bootcmd" environment variable through run_command()
> and does nothing else. It uses no bootm functionality, and neither does
> the "bootd" recursion guard in cmd_process(). doc/usage/cmd/bootd.rst
> documents it that way, with an example that sets bootcmd to
> "echo Hello World".
>
> Commit 1fd04cf46baf ("cmd: Correct dependencies for CMD_BOOTD") made
> CMD_BOOTD depend on CMD_BOOTM because the build fails otherwise:
> common/command.c is compiled unconditionally and references do_bootd(),
> whose definition sits in cmd/bootm.c, which is only compiled when
> CMD_BOOTM=y. The dependency therefore describes where the code lives
> rather than what it needs, and the boards that disable CMD_BOOTM
> (colibri_vf, iot_devkit, mx6memcal and r8a78000_ironhide_cm33) cannot
> offer "boot" or "bootd" at all, although the implementation would work
> there.
>
> Move do_bootd() and its two command registrations into cmd/bootd.c,
> compiled from CMD_BOOTD, and drop the artificial dependency. To leave
> every board in tree unchanged, CMD_BOOTD now defaults to y only when
> CMD_BOOTM is enabled, which is precisely the set of boards that have it
> today. Boards without bootm can enable it deliberately.
>
> Tested on sandbox: bootd, the "boot" alias, the return value taken from
> a failing bootcmd and the recursion guard all behave as before. Also
> tested on a Colibri VF50 (vf610) board built with CMD_BOOTM=n and
> CMD_BOOTD=y, a combination that could not be selected before: "boot" and
> "bootd" run bootcmd and bring up the OS, and a bootcmd of "false"
> returns 1. A colibri_vf_defconfig build with CMD_BOOTD left off is byte
> identical to the previous one apart from the version string; enabling
> CMD_BOOTD costs 272 bytes.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> cmd/Kconfig  |  3 +--
>  cmd/Makefile |  1 +
>  cmd/bootd.c  | 30 ++++++++++++++++++++++++++++++
>  cmd/bootm.c  | 24 ------------------------
>  4 files changed, 32 insertions(+), 26 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
