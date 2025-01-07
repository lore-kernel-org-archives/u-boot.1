Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A30E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 10:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87EFF8036B;
	Tue,  7 Jan 2025 11:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NENj5KDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D80B8036D; Tue,  7 Jan 2025 11:58:31 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33EA801E8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 11:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e39779a268bso19253242276.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 02:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736247505; x=1736852305; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqzItpAgu+Qj75CPqEpnn2GhqUQQgiEFN7EaaP2iXVo=;
 b=NENj5KDSJANrMWcnU0LH/0TmF3ZBeyYUxveoN54usQ8A7hBk3VAh93LJ1N7DhAmtd1
 9CagE/ECkovxvEpx0sFiCVTd+vQ0p1snrEk4bpIo6B+PMOch6R0gqsgZqyruurYZzc02
 J7OPRrgp5Nyhi8IzjAuLo4jdpT1XeLhzhaCYOpTb1a7WR/CQEW7xk1qHI2UXg2gwWgFU
 C9wuc4EEXaiIPb7Cwuf64MsNylsdfoIVxuZmoPL7Awu4UhxylvyiGeIn64ILWa8ebj/U
 YvHbcICAcrFFW26ivLw6xp0LXPGpwcZKFDkmC49oKiWxOA0IuEPv7RpSwtqqQVU+75op
 cFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736247505; x=1736852305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GqzItpAgu+Qj75CPqEpnn2GhqUQQgiEFN7EaaP2iXVo=;
 b=sJQuU0/V6SbyD6BqIAkbqATqvAaszhgB/5d8mv6cry/uUouksLDeCknLrDLLmrA5FV
 2kZ55iwikM14MEMzh65xZVBfk7BtsMZbIsm/2VDqUEaDBr1n1AYOh64A9ecfXEbSeGAg
 W8lt1kRohWdwTZYTM02Cy56TqklbdnKwSWhVMfqdCJloM2fUWIZWmnGFqO3LJ2pe48iv
 Z7efjrQoihLY7na3k5ufzCRP4CXkSvDzbTm5m9TnehLKHnMbbguM/0I2pt9RnDyEGMNv
 mHvnq+YoMR0HIUDwbrDfDvKz3XHmhBfLZMPzkE20q3+6TJG7zQ7R3aYiIyeWw6jV/rUR
 xcUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Aih+fG/qchmRPRv4vNnjgbyzYMIloFU6GwccF7Szu4psd92+ADgMdF1oPRENcqFI3M78yNg=@lists.denx.de
X-Gm-Message-State: AOJu0YxE/b45CdwXs+/kTQEE70iRmlGUtdxsVb6WgA8VkAYPEQ0/KnMQ
 0p1qU3Wfp4YMish1z+fo33LTD2TKFo+NGGPhuU6a/gyrhfDCpDsMsFMf7JK2+NXrUecgN6R7U/p
 U8jmASZl8OoIVL1k1dMIZsxHvOVtD6ITuvqZHUA==
X-Gm-Gg: ASbGncvepW8Z76PrJnWwttkz6PbUNYnrhj6zOxg2mRXpkLlSAoOE99PZOCZ8T/hi1H9
 lRXZG6ZCt27y1zZyCAvF8EQc0/fXjfsso67OBsw==
X-Google-Smtp-Source: AGHT+IGLVLKI9XbkjvU3mLpp4U8whWboXMhI3HbX2ECz328LlMDBlzERyFcw8zhoMG/83dASBnKXD3uWq6xDwEpcuKE=
X-Received: by 2002:a05:6902:12c6:b0:e3c:a021:4898 with SMTP id
 3f1490d57ef6-e54d22542d8mr1963009276.13.1736247505601; Tue, 07 Jan 2025
 02:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20241224220049.26629-1-heinrich.schuchardt@canonical.com>
 <87y0zx8sic.fsf@bootlin.com>
In-Reply-To: <87y0zx8sic.fsf@bootlin.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Jan 2025 12:57:49 +0200
X-Gm-Features: AbW1kvYJYX0Pa38GNxBp6R0-3PTy323NyDx5uPZAEsUmxdN3swpIARJahv7WTwE
Message-ID: <CAC_iWjJNdXsBKYZiTFM8RY2EvcSfYVVfxNCU1Q+cBE0UN089vA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: update descriptions in tpm-v2.h header
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Miquel,

On Mon, 30 Dec 2024 at 10:49, Miquel Raynal <miquel.raynal@bootlin.com> wro=
te:
>
> On 24/12/2024 at 23:00:49 +01, Heinrich Schuchardt <heinrich.schuchardt@c=
anonical.com> wrote:
>
> > * Provide a link to 'TPM 2.0 Library Specification'
> > * Remove outdated comment for TPM2_NUM_PCR_BANKS.
> >   The value 16 can be found in the current standard
> >   TCG TSS 2.0 Overview and Common Structures Specification 1.0, rev 10
>
> What about including this in the comment rather than dropping the
> comment entirely?

Sure I'll amend it on the PR

>
> > * Describe some of the structures in Sphinx style.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Fine otherwise,
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks
/Ilias
>
> Thanks,
> Miqu=C3=A8l
