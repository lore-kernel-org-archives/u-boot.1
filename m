Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701E0CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D7B846CE;
	Mon,  4 May 2026 22:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S35wxUWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74883846A0; Mon,  4 May 2026 22:30:38 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 855DC846E7
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-676e62faf2bso1301682a12.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926636; cv=none;
 d=google.com; s=arc-20240605;
 b=BsgfV0F3V6U2KFxgdxvYuGrnQkT+JpAYSY1wGkgB7uEmU4JJ533BRrTbx4G3vI7lnN
 v8oEfH+N4/wqqaszcbmzn9vR/L1uV0iJY23/bDdx0/wRZqZ+kygaeBg/u2Y9Re2/KlhX
 3acqgJTuMU2UuEwyTymaXwrUUSM1HHgeRDRwAvVtwMRmZWhw6E+xpX0T0v9xtQc9FnAT
 lreyyuQ6OVTqo3JRlKYtdVXKoSEzf8mOp6Yn26d89blL3vR5N7TnucE9268t6s+LWgCR
 wDM3Q4LL7CySLUXha2bj4M9s5BTZjhSqqEGmRQAR3UpqHeZpzkPz/FX08SQb9YNOMzwn
 rYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mHnkqdPGmDs75xVzX7Lm0+Jw86PgxxFcFs0sPu0EB7A=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=lmDuUBjMy/Uk8QHGfqsrbq5wxIObeYHULzQpsY7XtX8b6OO6SHmFEdhDnBZP0BXnfl
 25sWLzMNbu9JjqzS2xdet0orb7pqZFxc7y8xILdBUmp4HETQpy2O00t3EiOTIPEcrnII
 Kv7hIv5lbmot5jAMa48OST8ugbwaLTmFscG6hx+2aIQSep/UBrM5fUJR4O/saMC9P0CF
 PURC69Pfg31ca4PTOl8ybbxU1Fcd2+IhhZvu4J5ZcSdNSp/d4s6rbanlAZv/OQ+CvExB
 Vh7Dlxggm5DtucWBvlGrej730gtTBJejpR3Yp/blls9hgBdWDzlYCsmmvHRcv61TV/f+
 RClw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926636; x=1778531436; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mHnkqdPGmDs75xVzX7Lm0+Jw86PgxxFcFs0sPu0EB7A=;
 b=S35wxUWWBiCWvsXLw7Yssd2TYoGt4GkuR787xig7L+Z/hdd8pOTT+xYwVX8JXNxK0K
 rg5PvZhXoYaveNbV7OqUEIoPpl0g3Ltp4bcBF7TXQfBumDitnpENo1EPa2yqg4y4M6XN
 UCZo+pc6S2SkmJtCN9x+qj6ev3ZkKhsziAaMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926636; x=1778531436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHnkqdPGmDs75xVzX7Lm0+Jw86PgxxFcFs0sPu0EB7A=;
 b=WzAOp7Jr+XFbOw8Cv3VHa/QnhLJJOM8MoEgmIwFPU/PFfZuzY8CRHg0ZF3Z2ctuoA2
 eaokufua3gtNpIoiPYcYwRpCa1tzf5oe6H/fVU149slIlaOU5/mebeDIirS4ZDSMDBWn
 LjCLo6rNBJUkQudQHXVNvS0o7ogtdATSqnpp22zuTRed22c3C10T0IeykAPqCT4R2hYI
 aGTIM3IsjdryXm54YGzmLUOK7BFie/eZ3HHCouA0BUlz4CCsbW2e8QakaEh9RGXT/h3J
 bWWNVJUpw2CGgFE+LyCLjQB5Fv0oyyWYtdC/azXB2A0lOwt24KZ6Yq1829Z1zkJpYYr5
 S9yA==
X-Gm-Message-State: AOJu0YyEwTZNMDihTuLcgD9LOOttJBFck3ZbuAnOBWoUFfxKXIwMiIvc
 wvdQrjxeEQNqx3OoPj89R5LwnuqkENXFVjRbFO6qMbRVuPOrKAnsf372sGbW8ohTbRzIAoBUjTy
 jqikQnTU3S43JK0u73FuQcBOH3CsTsxYPklajBNQk
X-Gm-Gg: AeBDieuMo5sYfuSZV91oHjBH3DGGy0HhtlyRzYfufbPTequ+i0gVlhCCU15Z2KrUVfs
 HtrNzltoGutkam4CE7XhmCAn00LlD+227VyGBQoe7Bv8be0frQdtpzMUt6e07+vePO3eAO4j8xr
 d2htlJiI4B5Tl/SzUO7ct7HKWn35NFgcTwqSkPpUhsuCcKPk4KU8lRfPz7clWOTf/oVgvM8B57H
 JD5L97B2CBzf8Yn2zonrLrrJoI96pAbvFHiXhzO57m1h3XhemhuStm9Z/xwkIhbmvRcfhKkw416
 W5XYQ/HJGyhEjvT3
X-Received: by 2002:a17:907:7245:b0:ba7:3d21:c137 with SMTP id
 a640c23a62f3a-bc40fd16f31mr7410666b.17.1777926635892; Mon, 04 May 2026
 13:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-2-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-2-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:21 -0600
X-Gm-Features: AVHnY4IdfZib9d1Y1n-s6CwiI9WLEe33c0fnQSsdKt1KfpIqB4pgl8ZVWAOHo7c
Message-ID: <CAFLszThzyxYdJGUeh+drdDO77COVDo_PA9ssYHq5jtjLKrT3XA@mail.gmail.com>
Subject: Re: [PATCH RFC next 02/18] CI: pass clang HOSTCC and CC to pytest
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> CI: pass clang HOSTCC and CC to pytest
>
> test_env_initial_env_file test calls make on the build directory passed
> with --build-dir parameter which points at UBOOT_TRAVIS_BUILD_DIR which
> is populated with buildman before pytest is run. For "sandbox with clang
> test.py" and "sandbox64 with clang test.py" jobs, buildman uses clang-20
> toolchain, but pytest isn't configured to use that as well, resulting in
> gcc being used with a configuration made with clang-20 toolchain.
>
> Specify the HOSTCC and CC clang make arguments so pytest uses the proper
> toolchain, this will be required in a few commits when we'll upgrade to
> a newer version of scripts/Makefile.extrawarn which gets rid of checking
> whether a clang flag exists (because it's supported by the min clang
> version the kernel advertises as being supported) which will be an issue
> since GCC for sure doesn't support all clang flags.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> .gitlab-ci.yml | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> @@ -288,6 +288,7 @@ sandbox with clang test.py:
>      - ${HOST}
>    variables:
>      TEST_PY_BD: 'sandbox'
> +    TEST_PY_EXTRA: "--make-args HOSTCC=clang-20 --make-args CC=clang-20"
>      OVERRIDE: "-O clang-20"
>      # addr2line in Ubuntu 'Noble' and later are broken.
>      TEST_PY_TEST_SPEC: "not event_dump"
> @@ -313,6 +314,7 @@ sandbox64 with clang test.py:
>      - ${HOST}
>    variables:
>      TEST_PY_BD: 'sandbox64'
> +    TEST_PY_EXTRA: "--make-args HOSTCC=clang-20 --make-args CC=clang-20"
>      OVERRIDE: "-O clang-20"

Reviewed-by: Simon Glass <sjg@chromium.org>
