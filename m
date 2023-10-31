Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177D2C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 19:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E18878C8;
	Tue, 31 Oct 2023 20:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RDxEijG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 436D287A5E; Tue, 31 Oct 2023 20:00:50 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A478763C
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 20:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so10460315a12.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698778847; x=1699383647; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWsgbwaIsBh5ql3TSPcq6ilqznvUkJN1hZPgQtU6uLc=;
 b=RDxEijG9Wqg1PTxnpV1idK+JhviY1w4RRVzWn+fCEnidXQJvzZQAxHwXObjvjlQERP
 bU1n6dJwmOWqUJApW0FlCy84GUhHBE+CwQTMUyzAz3nN/V8PNtpTbelzhTr4kc0chcwM
 S7C/vYfZ/R7sKWZFElQ0014srvwUBEe++BSoyZsFR+/8j7sD/ssb0zuxcFF6WlfZ2uf+
 NJW3bSyl0nvIX9T5HggZh0zVqey+xyOVB7YDG8t0r1wr0T80w2knQVxNAMOl5zZU6q8A
 9gC2BgIRp5RAi6bGcgCpGO1Q7xClPrCwmATDFgJsti4dgyGS90U2Iq6nIxDdyY2zSuIX
 6urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698778847; x=1699383647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWsgbwaIsBh5ql3TSPcq6ilqznvUkJN1hZPgQtU6uLc=;
 b=XeKaMMNNYyD/o7Vz/bswwFuLM0o3haWC03TYKvfCrniIVSTIDZucauRuC5ckAdRtUc
 TPqoyYk+M8raeekM6SfvW4TlBkuNCMzDv6pc6b8+8JHChXWuJ4ep+5jZqYddnXa7jusB
 eXcHVVIcCoplLwASgQ2ox5a8wsFXrx8ue3v9rpD/KdFdE8iRQBTK+ScnYGT6MosTO9sz
 sGwNsqNaPA3sMzZqnyOmsw0GnaHE/sotwY40FuDsjU5dE+Su5qtNaX0UO7r18FS3iA1U
 2NMduJlxDPGOJmB4VxL1yin8Kr4ZFWWXrCFy3w/YYx+xlsfGv3SYEZnUiMfqqFwPuC0Y
 JnZg==
X-Gm-Message-State: AOJu0YzOtlsSaKjPFOxyGRA9UT5NYV4ppuumgwRcl/IJ5mHMEjyipmtu
 CqjJdgwo8jvZoats47lkPONTN2pp/J+VKveb7UY=
X-Google-Smtp-Source: AGHT+IGe3dyBUfJXlVH/mRfpfGPjBdvWROD5jvFkVcQAFpWHcIE/q41RkLNRMK+P2mAYctF66PJ0PAfbPoX0YnMw+B0=
X-Received: by 2002:a50:d702:0:b0:542:d895:762a with SMTP id
 t2-20020a50d702000000b00542d895762amr6772675edi.39.1698778847450; Tue, 31 Oct
 2023 12:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ2WT0NkisCdMo-1Jhe9ycXFZtFcGw665N_-Q1Vowepm0w@mail.gmail.com>
In-Reply-To: <CAPnjgZ2WT0NkisCdMo-1Jhe9ycXFZtFcGw665N_-Q1Vowepm0w@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 31 Oct 2023 12:00:35 -0700
Message-ID: <CAJaLiFxqsAnLqvjM2x84Gc2mdxPG5RmLcA57CogAbMfTX4Og0w@mail.gmail.com>
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

On Tue, Oct 31, 2023 at 11:50=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Tony,
>
> Sorry I cannot reply to the patch[1].
>
> Can you please send the console trace for this situation? I don't want
> to ignore errors completely, so wonder if there is a special error
> code which could be produced when a device is missing?

The error is -ENOSYS (-38). But sure, I'll post the console log.

Thanks,
Tony

>
> Regards,
> Simon
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20231030194650.11594=
-1-mibodhi@gmail.com/
