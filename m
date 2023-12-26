Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F0BC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2D387902;
	Tue, 26 Dec 2023 10:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F/0Cclqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230D2878F1; Tue, 26 Dec 2023 10:47:37 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4495878FC
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59496704246so562070eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584053; x=1704188853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0j3ubP4bfw0mp6qcOu04E8XJR7SShXjXAkbGbP2gOM=;
 b=F/0CclqndbtI6aoMt8UoaYERbCSLJwOlUDasp98jQMuJJAageYUhR9ihgG2Y9hSGvv
 GFMp1Z1iNUyWiHFDgf4tz2rUWaLJii+8WeeJD/CV1cq6Z7HG5ydC4sw68oGoIaDUDr6i
 1feUQCxneXLf0m3sEcrSuvA1ARwNVCAIr+XX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584053; x=1704188853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0j3ubP4bfw0mp6qcOu04E8XJR7SShXjXAkbGbP2gOM=;
 b=iPhpPIbZplV0tf2Bjl693aF+r3tGE/LI/dted9rPVzOAkSBKXIFtLJMQra87o5CVJJ
 iWUMakDFSIyoDHgv2pj+XBvryjQw0zPegc980JebvcuiEIAn95mrabMLPZwQFhwLkBZ0
 QgLh5JPM2Pd7ASXvAOTUTLwi1nmvjlx+qLxdMKbwsTf6QMm/fB3eGL/kFZPZsb85jmPS
 gSWa5QjxFEM6zSTLeXF2blxD1wCRMj3hUr2yD5XjmqUKX0fHkc/3qVz0S+iCJGFiDRge
 UQc+9uFI/249HLIkos77NTr+sCx7/TPgs7eV3PWgCZFkIXcflfTj5+VDQGJMKZtWK0ZV
 JxTw==
X-Gm-Message-State: AOJu0YzgqG09y7P7kDcVwONQfOy/zdjlXc9azvV02SgAjUVbJjKcmJ2Y
 ojBMebUzaiqrXpR6hH3PFDOvgVEpqziIxO5/n9kT/Z2uuuvU
X-Google-Smtp-Source: AGHT+IH2diVRPaz8i23am3+XgoFCCGgYcOmYJsqc8Z7eokbRe1gXfInN34i7GiQNw/8xOcFzxoLk+5PBjxnGi4td8ds=
X-Received: by 2002:a05:6358:260e:b0:173:50b:26e5 with SMTP id
 l14-20020a056358260e00b00173050b26e5mr3855406rwc.22.1703584053533; Tue, 26
 Dec 2023 01:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
 <20231219122439.31983-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231219122439.31983-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:01 +0000
Message-ID: <CAFLszTg-qc4VEs5h-r5WDz0qWD4dQGu8kUSjcncEmN5qFAsmQg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] arm: add ACPI fields to global data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Tue, Dec 19, 2023 at 12:24=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add fields for the location of ACPI tables to the global data.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         let tables in global data depend on CONFIG_(SPL_)ACPI
> v2:
>         new patch
> ---
>  arch/arm/include/asm/global_data.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
