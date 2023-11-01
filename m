Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A201C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 00:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A984875D6;
	Wed,  1 Nov 2023 01:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hy/j3zxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BFB875ED; Wed,  1 Nov 2023 01:45:10 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 700CC875D1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 01:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so10691862a12.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 17:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698799504; x=1699404304; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7MUlt0g9LnhKmetrNGbM3qYXZhKxVEEW7lRcE8puw0=;
 b=hy/j3zxrV5pmsEL5hLAZrlRdfJKii0Tg+qdK9Tg6E5hk81faZ5jwG/K6YVTHMviZkW
 L0/yzyDoudKITLPKDK2wS6JcoQGKJfb4g4JSvjg9HeFKZwEuQI2fp6+ZpGNMvXEgelEP
 Q01S7g2NARqm56g+ueAeYFLwjWE/wo04fpLPS3TQg7VfAun77eFWepv9PmpM9koKk4Y0
 fQXkBNJD9/eOj7V3/inC0votLJv6pI9j4642FAqTHF99I8Z6TiazkV4Y/fBClzgRGkT1
 deZ2erJrw24eIPrRrFkks7pNFHXcPVzIb7vYkAeGL8et1TJ0iM4w9JhEAzNexZIR54KS
 BtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698799504; x=1699404304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7MUlt0g9LnhKmetrNGbM3qYXZhKxVEEW7lRcE8puw0=;
 b=SeyaPrUBVinLvyJlKX8aL44AzOemVfQibW3ReHGSIMyT5R3+laYD17k8WmQ21ReS18
 EUyDH1knnThgRCv6stIQU3N0uTx0F2dEjDBiCciIU9qGGRrXJ9Le7Yz4M38sHCjc/9T1
 P4oOgYaOSg8CN1qhgkrFIxlAWSIiiV2oU2CujPCBd5SzPtq/SjcMCiUHNVbNKtnIwPsH
 rYMkr1m3L3av5Yn5gIXluYMNkcmUySeuDdsyCIiqoPKny3fA30UIWjESUQ8bLpZn8lPf
 YXA/jNViOH59TTtcaeqRSNoDBhwBF5l8/LlKakVMnGWnDg6rzTlRzbC3ZSi97i8FO/db
 WyrA==
X-Gm-Message-State: AOJu0YwK3DjTL3Xv306H2yNuLwifid6ciIZT40elYuGXURVPIA+4fydD
 TL9CIfj4PPBCPALiZUIUZBZYZ1PjeKVo9oBwkvE=
X-Google-Smtp-Source: AGHT+IFuAhIsj9lSDB22ScHDg9CNPHSpm2XjiNN1BJk4c0u0H+vuKSSsfTw5NDph9r1U/+Dr362cJxSUGw9zWIx7QUY=
X-Received: by 2002:a50:d7d6:0:b0:543:5cfa:ba41 with SMTP id
 m22-20020a50d7d6000000b005435cfaba41mr3205254edj.25.1698799503946; Tue, 31
 Oct 2023 17:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ2WT0NkisCdMo-1Jhe9ycXFZtFcGw665N_-Q1Vowepm0w@mail.gmail.com>
 <CAJaLiFxqsAnLqvjM2x84Gc2mdxPG5RmLcA57CogAbMfTX4Og0w@mail.gmail.com>
In-Reply-To: <CAJaLiFxqsAnLqvjM2x84Gc2mdxPG5RmLcA57CogAbMfTX4Og0w@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 31 Oct 2023 17:44:52 -0700
Message-ID: <CAJaLiFyxbvy1uAw41hzPyTfSLbWAaGNn=31mfWVmAwb_FBR3vQ@mail.gmail.com>
Subject: Re: Re bootstd: Skip over bad device during bootflows scanning
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Tue, Oct 31, 2023 at 12:00=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrot=
e:
>
> Hi Simon,
>
> On Tue, Oct 31, 2023 at 11:50=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Tony,
> >
> > Sorry I cannot reply to the patch[1].
> >
> > Can you please send the console trace for this situation? I don't want
> > to ignore errors completely, so wonder if there is a special error
> > code which could be produced when a device is missing?
>
> The error is -ENOSYS (-38). But sure, I'll post the console log.

I've sent the console log in the patch thread.

All the best,
Tony
