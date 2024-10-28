Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3367AD339A1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6F68913B;
	Mon, 28 Oct 2024 18:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UiROVgp9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E45FE8915F; Mon, 28 Oct 2024 18:05:08 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E821489128
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so7130976a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730135106; x=1730739906; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y4cX2TYwIviPLfKxt5HpITpeE4hsTE03v1uKVGaVkpc=;
 b=UiROVgp9UnOlDoXzi2BOCO6S5DQNiOxe4oXeFzQOH9ithXTn9jKBbX4zF/ISWtcfrf
 XET2WHQl74KituWN2/rJd6paaEHBi/ODjFOOMwksBVSjKhogg+aE1gEo3Joc0igtOHmU
 I+ILJDpbzEV6n37/4L1DmA2r6+91+gdgNkGE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730135106; x=1730739906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y4cX2TYwIviPLfKxt5HpITpeE4hsTE03v1uKVGaVkpc=;
 b=FIMrUqObtsavPyxarpJWZb0tHj9QUnClw6H+kHTBNaKi0mHJU57Vd7QF83JapOFQrn
 ix2POjA9N8P+VnB+EmCWBo2O+i4WL5m17vtRQzaFd+2Eek6iEEaOblVogBO+WmmV+T4e
 gRQkwNlSigUdIcAYFAPznguw5FhFlWGPCFM6RLlpyrnrpwORcmBuV9XbShMEE3ROi1KX
 1HMNjr0ylPPyGsu2ojzDADgItYQZ06ZMm7WspcLxvQUS9HpFFDoVOqqYqSaHrAt5p3My
 u4EPbOspnfKfvfbLkyJH/+X7jfn2etSh11T+4PtnATlXb27DRKo3piYI/vZe6+DD/OI2
 PB2w==
X-Gm-Message-State: AOJu0Yx7hHD8FyfCXvLgViTBzulDZICdNH3AYHNxqQTI4ZXknUCm993O
 3QaZePxLZQQQP6XdipwoBaWfrIp4e6zvcrbr8gDj8YoleMs8nQKSHRuZDi41oBzhh4NFdPRV22B
 IM7OXe5CpQlhgtH3JpcbMhE8pckeYZtW958n7
X-Google-Smtp-Source: AGHT+IEjdd9qfMkwSgq7PRCcTeO6v1g7aeyUDG5OEG3qZins+LZRAPKbBJDPRzKDXnajUCUdb3x+6fQWKhh/DFVxC6g=
X-Received: by 2002:a17:906:6a0e:b0:a9a:7f37:2b62 with SMTP id
 a640c23a62f3a-a9de6167b7emr992918266b.49.1730135104813; Mon, 28 Oct 2024
 10:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-8-raymond.mao@linaro.org>
In-Reply-To: <20241022200543.116343-8-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:04:53 +0100
Message-ID: <CAFLszTgRxuiQOZOr_fvAZjmZewKHPi3k5Hdd+CgeExpVDycnVA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] cmd: update smbios cmd
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Update the cmd according to the changes of the smbios library:
> 1. Refactor smbios cmd print functions to match the content defined
>    by the specification.
> 2. Add new print functions for Type 0, 3, 4 and 7.
> 3. Update the expected pytest result to align with the smbios
>    library changes.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch. Move all changes related to cmd/smbios into this patch.
> - Combine with #9(v1) patch.
>
>  cmd/smbios.c                 | 342 ++++++++++++++++++++++++++++++++---
>  include/smbios.h             |   5 +
>  test/py/tests/test_smbios.py |   2 +-
>  3 files changed, 319 insertions(+), 30 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

OK, so it should be possible to expand the test for sandbox to check each
field? Something like test/dm/acpi.c ?

Regards,
Simon
