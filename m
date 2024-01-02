Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E385C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 14:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 160FF878B0;
	Tue,  2 Jan 2024 15:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IU4BZYq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD0F08787E; Tue,  2 Jan 2024 15:06:43 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81A4B876BF
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 15:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-67f7da00237so50430746d6.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 06:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704204400; x=1704809200; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fS7NqMH2eIGA/5mOhNdfVSOsNkAraMPGAv/00O2wjMU=;
 b=IU4BZYq2VcSkGjUb+4Wm8SANNEasRKeyxLCqJzMiUpOdS4lE4G3RV1i6dRFZNcS1pj
 MMLH3TnSIcIV1mnFilr1Q2J73aBEmykVvxi/OBTOt9EXhqox6gtcgmLrPwrNteDH1zcK
 DKxGVCaa8LjpFc8ewEKo3MboIx2XixxwhNRtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704204400; x=1704809200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fS7NqMH2eIGA/5mOhNdfVSOsNkAraMPGAv/00O2wjMU=;
 b=Xcje2CCF6aGLRD28ayn8D1fR2+FcIqO43ZnnXuEKTeSPZoJAGapG3p+BBVOcdxtrTl
 jHIHdamQXRBg1431YeysKxRxQHeY86UecRsNWYRzpdCcjJ9Y4gH26Wt3nAA3mMuu/j+T
 jZURvEs1ExfsDNetaC6N0OkgSfL+0bnIjn+2dy7d8ZjVm9dSQiBvS6mi2q2t9k84Xwxx
 NLo9WoRzrSJfj59vgZHWvHkCzjSSoKsoemw7BojCX76U9lzHyWF1DhWz4Gumty70mn19
 eC0UMfgxh61gFkqtlOFMXTPl0eCrbtvLGcwQd8BRRCabtMDRQNGc+AjR0jwt+ddYymur
 tuFw==
X-Gm-Message-State: AOJu0YxB9evMbXemyDxLZjJM0xVBniDNjJTZSzrS/FphnjQqHpAaK2fM
 Z6PLQFqlak8zUnh3nt6EiEoa7f/DLycQZJb1jqG2vfyHg6oV
X-Google-Smtp-Source: AGHT+IF9ufCoh5H8OdUR9WMriGg9SwVG9iNVway8/67dgdaGrlkA0FHPSnEaOsZ0575k8HXk5pxfk9p0Ub2pBfdy7Mc=
X-Received: by 2002:a05:6214:e82:b0:67a:a36:d7 with SMTP id
 hf2-20020a0562140e8200b0067a0a3600d7mr19539906qvb.2.1704204400232; Tue, 02
 Jan 2024 06:06:40 -0800 (PST)
MIME-Version: 1.0
References: <f7ff13475bbd3f0471bee709dc6a805d3da5915d.1704176360.git.love.kumar@amd.com>
In-Reply-To: <f7ff13475bbd3f0471bee709dc6a805d3da5915d.1704176360.git.love.kumar@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jan 2024 07:06:29 -0700
Message-ID: <CAFLszTgFS5CPZAioNLRFQCispoHKLS8V8Mc0B1YYqRcJ15WmYg@mail.gmail.com>
Subject: Re: [PATCH v3] test/py: i2c: Add tests for i2c command
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
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

Hi Love,

On Mon, Jan 1, 2024 at 11:47=E2=80=AFPM Love Kumar <love.kumar@amd.com> wro=
te:
>
> Add below test cases for i2c commands:
> i2c_bus - To show i2c bus info,
> i2c_dev - To set or show the current bus,
> i2c_probe - To probe the i2c device,
> i2c_eeprom - To test i2c eeprom device,
> i2c_probe_all_buses - To list down all the buses and probes it
>
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
> - Take the configured eeprom value from env to read back and compare
> Changes in v3:
> - Add test env dependency to run it for provided i2c bus list
> ---
>  test/py/tests/test_i2c.py | 116 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 test/py/tests/test_i2c.py

It is OK to write these in Python, but you might also consider some C
tests for the commands. See test/dm/i2c.c for some examples which use
an eeprom.

Regards,
Simon
