Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA028E82CBD
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 18:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6DBD86D94;
	Wed, 27 Sep 2023 20:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fJvEcVMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B24A8869CA; Wed, 27 Sep 2023 20:14:24 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7948886DED
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 20:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=troykiskyboundary@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-27752a1e180so5704390a91.1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695838460; x=1696443260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X10oCZbAPwpDjaBDCgIe+RfH5/wXWxkveg165IgPHUY=;
 b=fJvEcVMfpJroam55e7CIpcJGtRPhI/3aq7a1+OGKCdfq8KViFLFKGBzCH3VgamRSwv
 CDDaSGKXS5HgbwZsrKyvQj7xA79ZBsv7Yslv5iRcTj28WEpQeq065t/UZy++UxjpMC/G
 CbhWfd3AtZeVSw3U+PGn80yCynxTf83VVdpkvp6mnp+70KYc3DbVl8MD3wTHt1HTESzH
 Q+o+WvZN0WV1q4O7ySvW28c8y1fuWa4H85CLLt0doDJwkXpzKEngTZ0pboYUr+HoHbB0
 kqGDjy4rXAufaPnLTyp+C56tQEEcvofBm3ApMYOfHC6jIGhJBxFKAD2P7o8eloo/X14i
 XEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695838460; x=1696443260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X10oCZbAPwpDjaBDCgIe+RfH5/wXWxkveg165IgPHUY=;
 b=hSh3tAW1rTcmJLd4oAOIMjYnIlxoYXm7Yb40JYZU4nYpy7rGOm6dXerGIGOZ72GCpk
 kGAkaQ1PIGzfeHGozXjd02reVr9XMl7buLrhc1xOZo287FToBTM9iDf/K4kS2oCarxDD
 wT627KlfbnVR7Gwv5SyUQ5PJlygBmNNeAkLUCEw+trtzL1nodToMsUC4LvUpi4W/b/Z/
 sV2d4E1yxK1CPH1h0ZO6CYD2TcVw19zS7l54ZkOET2xkmqDE4H+L8XRdBLGHPRGIxtx7
 gszmxn1ydbAZujSsiolbq/ivLgl4hU8Fs2SEjAEuWYA0vlYT4Ge9bvzQvxkQ7onpKNf7
 2Xbg==
X-Gm-Message-State: AOJu0YwmyK3E3N5+PfAe49u4hx5GBjHhY/XXGQLl5cjGugfFNiA6g6HD
 w/UOiAhNmF+miyzlv3nus85E9uH4W6PkM5k2Lpo=
X-Google-Smtp-Source: AGHT+IG99VOclI64OcCa28v+F4oGU+n/a6Fp9MtKksawA8m8Ua6bwqf8K4iGNxNahB1BbMXQeOK953uj2e7iEq6bblA=
X-Received: by 2002:a17:90a:c918:b0:268:2d92:55d3 with SMTP id
 v24-20020a17090ac91800b002682d9255d3mr2271538pjt.39.1695838460557; Wed, 27
 Sep 2023 11:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230619230655.2406929-1-troykiskyboundary@gmail.com>
 <20230619230655.2406929-2-troykiskyboundary@gmail.com>
In-Reply-To: <20230619230655.2406929-2-troykiskyboundary@gmail.com>
From: Troy Kisky <troykiskyboundary@gmail.com>
Date: Wed, 27 Sep 2023 11:14:09 -0700
Message-ID: <CAO46J5W1-7JdoGddMqUHLfv9SyLzzpR+MXA8O8cevwfheV4AjA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] CI: add test/usage_of_is_enabled_check.sh
To: sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de
Cc: gary.bisson@lairdconnect.com, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joel Stanley <joel@jms.id.au>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Peter Hoyes <Peter.Hoyes@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 19, 2023 at 4:07=E2=80=AFPM Troy Kisky <troykiskyboundary@gmail=
.com>
wrote:

> Add script usage_of_is_enabled_check to print any configs that
> use CONFIG_IS_ENABLED instead of IS_ENABLED and vice versa.
>
> Add usage_of_is_enabled_commit.sh to generate commits to fix the above
> issues.
>
> You can remove entries from test/usage_of_is_enabled_todo.txt
> or the entire file and then run
> test/usage_of_is_enabled_commit.sh
> to convert to suggested usage of CONFIG_IS_ENABLED/IS_ENABLED
>
> or run test/usage_of_is_enabled_check.sh to
> see which configs are still todo.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Troy Kisky <troykiskyboundary@gmail.com>
> ---
>
> (no changes since v1)
>
>  .azure-pipelines.yml                |  11 ++
>  .gitlab-ci.yml                      |   5 +
>  test/usage_of_is_enabled_check.sh   |  19 +++
>  test/usage_of_is_enabled_commit.sh  |  12 ++
>  test/usage_of_is_enabled_correct.sh |  50 +++++++
>  test/usage_of_is_enabled_exempt.txt |   9 ++
>  test/usage_of_is_enabled_list.sh    |  86 +++++++++++
>  test/usage_of_is_enabled_splcfg.txt |  21 +++
>  test/usage_of_is_enabled_todo.txt   | 213 ++++++++++++++++++++++++++++
>  9 files changed, 426 insertions(+)
>  create mode 100755 test/usage_of_is_enabled_check.sh
>  create mode 100755 test/usage_of_is_enabled_commit.sh
>  create mode 100755 test/usage_of_is_enabled_correct.sh
>  create mode 100644 test/usage_of_is_enabled_exempt.txt
>  create mode 100755 test/usage_of_is_enabled_list.sh
>  create mode 100644 test/usage_of_is_enabled_splcfg.txt
>  create mode 100644 test/usage_of_is_enabled_todo.txt
>
>
If this patch is still desirable, it can be updated by

rm test/usage_of_is_enabled_todo.txt
test/usage_of_is_enabled_check.sh >test/usage_of_is_enabled_todo.txt

BR
Troy
