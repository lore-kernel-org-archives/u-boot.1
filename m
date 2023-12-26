Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F17C47072
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41626878D5;
	Tue, 26 Dec 2023 10:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YUGz1LmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340A9878E2; Tue, 26 Dec 2023 10:47:29 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F211E878CB
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-58dd3528497so2529017eaf.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584045; x=1704188845; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCcOk3avGBoxUXMcLDtiiSpaj81G/YGPh648fwpZ87Y=;
 b=YUGz1LmE0GX2c+UM+WJ0jILDJZPT49uOXqxrvrizhcHAAdfkTg6j594O2ZjnXhCHNM
 NpVco4sIjG3ld6c8AKOdtxEYB/s4NggoQ8e5VqxH9CPPzcILvMgdSB1wbpQ8XrIie/ie
 WyKlLcoIcQn2IPduzTQHUfHvOUfX94xhC2Z7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584045; x=1704188845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BCcOk3avGBoxUXMcLDtiiSpaj81G/YGPh648fwpZ87Y=;
 b=Slvjo7F4QnwLzlrTCqhyIzH3ywuFB3KEPbsv0t5n5zfYYy3irwLzRUwtFxks1STRPt
 81/egmpqnQ1xYX6u6i8ZT79+hwC7qKZcuo23tonAPzRYXVBb0PGFYc8BrBOE/uxhRQ19
 SDgyYonH8EyGFrVIGpq09Jx9U3Qur3pm5BLBRS6Sa3nLPvojsJVw32TDaPgC8JHE035H
 Y4/tsySqzrzHxLtZWdS4aCFM6jEWhu+XZQuQJ5wbxMIWphRN/nqMIbZj3Syso39o5z9X
 x6+BKldnsOG+AUNyI6Iwrrws1UguGv4zFQ8ZLLLk9jojJhtsXi0r01qPB+mpVVtuogsF
 j7CQ==
X-Gm-Message-State: AOJu0YzxkzkxRc7RDdVVdUEzZ5F0Bteb89dQ9xXIkGtgLvkYlwNhuBgD
 ewWh7Iow5tGHrxrWA/28+4MmbY/pr66mVdAnIKCBhtuLyRgT
X-Google-Smtp-Source: AGHT+IGEGtAGDpw834xiENy2zwwciEIqHsLgUDOhZ1XF2wvf5VvUcUp/hwFsW9RAY8EfAomtBTfLFk36bxg10UM/Nok=
X-Received: by 2002:a05:6358:7e8d:b0:172:a4c6:124e with SMTP id
 o13-20020a0563587e8d00b00172a4c6124emr4163888rwn.14.1703584045591; Tue, 26
 Dec 2023 01:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-4-sumit.garg@linaro.org>
In-Reply-To: <20231222061208.3009970-4-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:51 +0000
Message-ID: <CAFLszTiPbM-fofbNaTO3vtTWNTOee_pO7-_obKxmP=oChD-8oA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
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

Hi Sumit,

On Fri, Dec 22, 2023 at 6:12=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Allow u-boot to build DTB from a different directory tree such that
> *-u-boot.dtsi files can be included from a common location. Currently
> that location is arch/$(ARCH)/dts/, so statically define that common
> location.
>
> This is needed for platform owners to start building DTB files from
> devicetree-rebasing directory but still being able to include
> *-u-boot.dtsi files.
>

This is a v2 patch but I don't see a change log?

> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  scripts/Makefile.lib | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
