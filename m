Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FDED5CCA5
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 12:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49D088F83;
	Wed, 30 Oct 2024 13:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WrKoKU5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2EBD891AC; Wed, 30 Oct 2024 13:24:01 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8787088F1E
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53a0c160b94so7376013e87.2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730291039; x=1730895839; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpvV7CmcHSvif0p6VecRjryHKypdibhq7xvXyxvFkQk=;
 b=WrKoKU5XvLtQWNrTReinC8QEQp4QCshRvJFOV0UUl9rpzYk0oInE/fN5MCYagaVaUE
 /JXnawtgy0OEIhAVGNyvxTtHGExrdvZBRL6UrMb4XtlrkRMV5uBuxUJk/Pz9Hb2VTAZj
 LWzOF3LfjCo0A6VjIOfHMP8LUNc4ylv/t5F8zJ0haZ7ft1YzQE2dO9aHUyOBu2xfY2X5
 alP8RG24agi/Mi1mzovtVI60Rl7q01BQCZ4xSIRXx9bmckNQN9KRIQOenzIpqsl+Gegk
 fVjCYt0Ra4I7w5h9GQAdGbakNYDw0z2jFn7pW4E0O8cdcSfs93NVaD/ByAYL2lgA3vdH
 +kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730291039; x=1730895839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpvV7CmcHSvif0p6VecRjryHKypdibhq7xvXyxvFkQk=;
 b=P74fmpuWcYOuw7f83oaNQ6M0ZrRGG0ZwccqBXh7B7l5X9ss+/kYahKCx/fr617Q4T2
 IBr6C/in/2jZ5wV+IQeand5sp2oLXfMNho3wtVrDytOZ5YYYgpkX6JK23Onp9r6i6wYA
 ATZCld84eeQWHP7un2WlkdXTUo87nT0M1AGDyeWGUxji/Eu2BOWc55QAvhnJoEM6NvTV
 ul0An0gcp/5Wru2Agf/zEGWo9sznrAxy742kPsoT2S4m2iHS7HxzbTXiRRG+iO7yOlA2
 457GRKhw4rOnf+hPQ1lIs0WQ0xSVS2iNc6EYpISQKK4W55EntgX3q8PPDgRtbA6I71hR
 Q6kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq2MAg5Xpvq+fTzwjcDOxHKOXRqXRuq/pTP5V3TEymIlYt0wQcCrrGYLGmi+xZpJdN9MduSsk=@lists.denx.de
X-Gm-Message-State: AOJu0YxWB3VMq6j95SH/1hIXKnZguiRgMMF6aquZ60SRL6TH8AsUP/Jb
 l8J1cK2dTL/8rYIc8GLiUzAyS03XTMBHrhMjwjbX3TqnZiuIR78J5JsBMTRL2K3hhrSoaneuwvj
 TMUHi5+fwZPxHXiVDevjBaKcwC/I=
X-Google-Smtp-Source: AGHT+IFuXCfvbBQksamPdJNRm7FGQPMTL6W/c2i8M759pDCMtlyBfYmyRF6qh/vCCOyIxfhEkWZX7xyiwuUrgTGnVUI=
X-Received: by 2002:a05:6512:31c6:b0:53b:1fe4:3fb9 with SMTP id
 2adb3069b0e04-53b34a2d88emr6625145e87.49.1730291038383; Wed, 30 Oct 2024
 05:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241021073749.63-1-brian.ruley@gehealthcare.com>
 <20241030080753.129-1-brian.ruley@gehealthcare.com>
 <20241030080753.129-2-brian.ruley@gehealthcare.com>
In-Reply-To: <20241030080753.129-2-brian.ruley@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Oct 2024 09:23:46 -0300
Message-ID: <CAOMZO5CC683+5_xohQw_F0kuiE9mmL2PqjqHk66A1oUXje=oSQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] binman: expand test coverage to nxp_imx8mcst
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, ian.ray@gehealthcare.com,
 u-boot@lists.denx.de
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

Hi Brian,

On Wed, Oct 30, 2024 at 5:08=E2=80=AFAM Brian Ruley
<brian.ruley@gehealthcare.com> wrote:
>
> Add coverage for IMX8M code siging. Create PKI tree and other assets
> required by `cst' using `hab4_pki_tree.sh' script and `srktool' in
> `cst_3.4.1' [1].
>
> [1] https://www.nxp.com/webapp/Download?colCode=3DIMX_CST_TOOL_NEW
>
> Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> ---
> Changes for v4:
> - Rebased on master:
>     340_nxp_imx8mcst.dts -> 343_nxp_imx8mcst.dts
>     341_nxp_imx8mcst_fast_auth.dts -> 344_nxp_imx8mcst_fast_auth.dts

Here is the result when I tried applying and testing this:

$ git am ~/Downloads/v4-1-2-binman-nxp_imx8mcst-read-certificates-from-inpu=
t-path.patch
Applying: binman: nxp_imx8mcst: read certificates from input path
Applying: binman: expand test coverage to nxp_imx8mcst
.git/rebase-apply/patch:206: trailing whitespace.
            X509v3 Basic Constraints:
.git/rebase-apply/patch:208: trailing whitespace.
            Netscape Comment:
.git/rebase-apply/patch:210: trailing whitespace.
            X509v3 Subject Key Identifier:
.git/rebase-apply/patch:212: trailing whitespace.
            X509v3 Authority Key Identifier:
.git/rebase-apply/patch:333: trailing whitespace.
            X509v3 Basic Constraints:
warning: squelched 7 whitespace errors
warning: 12 lines add whitespace errors.


$ ./tools/binman/binman test testNxpImx8mCstFastAuth
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Ru=
nning binman tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
E
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: testNxpImx8mCstFastAuth (binman.ftest.TestFunctional)
Test that binman can sign an iMX8M image using fast authentication
----------------------------------------------------------------------
ValueError: Error -11 running 'cst -i
/tmp/binman.tf697xr9/nxp.csf-config-txt.nxp-imx8mcst -o
/tmp/binman.tf697xr9/nxp.csf-output-blob.nxp-imx8mcst':

----------------------------------------------------------------------
Ran 1 test in 1.318s

FAILED (errors=3D1)

Any ideas?
