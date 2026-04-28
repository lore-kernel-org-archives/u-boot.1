Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D507FFF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D5FF84676;
	Tue, 28 Apr 2026 20:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GdOT7cvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA398466B; Tue, 28 Apr 2026 20:06:15 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 972B984660
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bad54961385so919318166b.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399572; cv=none;
 d=google.com; s=arc-20240605;
 b=PAv8jHee7aV6UpYmK1peyV6di9ma+pRVQd5y7+JAMD/t9rVkEiqr5tsx5diHmsgMMf
 WkA8Y4LtjdKZhRi11KgxwEuSBeTCO1MyBxEJncoPo59hwW4U/iI/OlZ3K22DXiCsteou
 qYvL7e1oZH4+n7Vkv7h8QLx188Nzz81jfYobNh+Df3wB/XAsqMfsFEd6KoiY2m2lJGvl
 39hBY4af19QmxjUI58QOpLdZpCaaLUB/RL1h4ixhCvYvViFJh6wzmY1rQEsI67bE7Bw0
 4nXjKTL2Ma9AK9zAMKbcfW9V1mg6BfQ1dnOz08Z46zQ+qpAKhmrVvtSg5gl2sUOCSG7l
 9Yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XFnDy9utoVaO/PgEt5jX8X2D6aFSAtJ1FBSF1ubhen8=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=P5N1OHhEWQ9bi1LsG5QrM6zlhaPTOQAYBz44snHzg3nSmef/JqN39htGCNnM6DYUqu
 ob4m1/JguAmbQCnazsn6DUaHU/w+l2YWH+RUm3QBhBL8Mkw4jHxw1c2GjXWIEHCIZjHJ
 XwAP9e/S/RhXUX5+hcMJq5EwUInN3FaHxu6qu04hzlAeRnLV7OwaJB8a+EDlsL7htYic
 suCjUjAhkJR1bPau9pnjQrbcLDogse00nJt9Bmp53I9TfU5LHjnh+leSkITcuhU0H/OD
 NYulYXGw0PivqGaIrqfngZSa/SNp36vPRcObuaeSJuIgEff9ASPXheL0F2Z0iiRAE92T
 KAsg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777399572; x=1778004372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XFnDy9utoVaO/PgEt5jX8X2D6aFSAtJ1FBSF1ubhen8=;
 b=GdOT7cvyQe0yY2ccZgkbrUnenMw+G3rBICgj5yZCECjKPKvfU+wLz6GDfxk7ZAzPSp
 Siw0ulDCNo/ePYkg85HF4ACHNqgfFciDDZgzcAPbfksay+iyNLcJLRz0El6qEA1IBqxF
 lXB8owU6B9DQRsbLjr4Uc5Ljn8DRZltKE9QaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399572; x=1778004372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFnDy9utoVaO/PgEt5jX8X2D6aFSAtJ1FBSF1ubhen8=;
 b=jnlsQde5xWkuRetsDo7TzIzAXPWu7cV4u6LGXpCxOstRAzVccKy0ithSAzX2mB1AYa
 kMvh/SNIEx126Bxr03jTgtC4hNJrlgGRflZBiFdsUilFUpaZUwhVwuCpEQL6ly+I9N3+
 yy9cnf7sX7L5qMNZlxomEGrCbDLMvZ8jkRETiE845HZkb/foAs3jPRdklxNDuw6iKfMI
 sCm0qgc4wUydztZdGF30hzp6JUPWNq8q0hfrHsnke1qddl7OezHM5amspSfurscsk5c8
 aVUn727bDjxswBatovcvddcNH29UBc/9FMcOnkGqCz3P8wAlXT9et9FCPnt6uXcdAG5R
 nosA==
X-Gm-Message-State: AOJu0Yzd9Sx59i2wcDbKp9QN3yLvBUP9LoAXgOQ3sFzq+0nEWgGcUmpG
 ZjedDIr3tdYSFa6+cxlKroKIrFZJrzGwb0xexUqdej/2z4Mc2GCtEPotLRjmbnki5qUR5RpiOzQ
 AOLkP4PhcaPJWiqX5Ut5Z1M8/0261qZYE94q3EDhh
X-Gm-Gg: AeBDiesckt3jacigh0r+ZRS6FEa/4Svv0Ptn6JOxRk2/G1Xkk056d9o4wpZR5b+DzpJ
 8sQtITQMxMHHByeXqDQnCjtKiBXXMxxRTNj0P6jB9nlBZjvqyR0cJDAniCnSNWJpnxX/LCpDMLV
 x6NEd2qWL225eKdxE7r1XBWC9ikXtcIXHeo6DAP5CEiJSgU8XCmG8GtdRbfYab+PH+Utv87EKI2
 5JxJBqtwaESnB6xc2GVJZJyDhGTQblGtNVE7j/0qawqDHhJ0EAJHCCW9F3AJOByesIOunywx78W
 m2PdmOckphrSbifN
X-Received: by 2002:a17:907:26c9:b0:b97:ce8f:b9db with SMTP id
 a640c23a62f3a-bb8018de02bmr241924466b.10.1777399571951; Tue, 28 Apr 2026
 11:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-9-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-9-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:05:59 -0600
X-Gm-Features: AVHnY4LKtGs3UneEQuIMFS1eVOqLzSFm4dW4z5Kc-l2M4Juj5fOfICFaA4sOkG4
Message-ID: <CAFLszTge4-kNpmh0q26KhRRrN_DK2134qbLi8KqRgwdB+mAaSw@mail.gmail.com>
Subject: Re: [PATCH 08/12] test: dm: add sandbox FF-A runtime transport tests
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Harsimran,

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> test: dm: add sandbox FF-A runtime transport tests
>
> Exercise FF-A runtime helpers via sandbox DM tests
>
> Add driver-model unit tests that exercise the FF-A runtime helpers on
> sandbox. The new tests reuse the sandbox emulator to validate both the
> positive direct-request flow and failure handling, priming the emulator
> state so the runtime path can be executed.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> arch/sandbox/include/asm/sandbox_arm_ffa.h | 16 +++++-
>  test/dm/Makefile                           |  3 +-
>  test/dm/ffa_runtime.c                      | 82 ++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+), 2 deletions(-)

> diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> @@ -0,0 +1,82 @@
> +static int dm_test_ffa_runtime_nack(struct unit_test_state *uts)
> +{
> +     struct ffa_send_direct_data msg = {0};
> +     u16 sp_id;
> +
> +     ut_assertok(ffa_runtime_get_sp_id(uts, &sp_id));
> +
> +     ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
> +             .id = NS_PHYS_ENDPOINT_ID,
> +     });
> +     ffa_enable_runtime_context();
> +
> +     /* Ensure runtime context is available before attempting runtime-only paths */
> +     ut_assert(ffa_get_status_runtime_context());
> +
> +     /* Invalid partition IDs must be rejected and mapped to -EINVAL */
> +     ut_asserteq(-EINVAL, ffa_sync_send_receive_runtime(0, &msg, true));

sp_id is fetched here but never used - the test sends to id 0
directly. Please drop the call to ffa_runtime_get_sp_id() in this
test, or use the discovered id for a positive comparison.

> diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> @@ -0,0 +1,82 @@
> +static int dm_test_ffa_runtime_ack(struct unit_test_state *uts)
> +{
> +     struct ffa_send_direct_data msg = {0};
> +     u16 sp_id;
> +     u8 cnt;
> +
> +     ut_assertok(ffa_runtime_get_sp_id(uts, &sp_id));
> +
> +     ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
> +             .id = NS_PHYS_ENDPOINT_ID,
> +     });
> +     ffa_enable_runtime_context();

ffa_enable_runtime_context() flips a global static flag in
arm-ffa-runtime.c that is never reset. Once either test has run,
ffa_get_status_runtime_context() returns true for the rest of the
process, which leaks state into other tests and means a
missing-context path can never be reached. Please add a case that
calls ffa_sync_send_receive_runtime() before enabling the context and
verifies it returns -EPERM (that branch is currently untested) and
provide a way to reset the runtime priv between tests.

> diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> @@ -0,0 +1,82 @@
> +     /* Validate FF-A error to errno translation helpers */
> +     ut_asserteq(-EINVAL, ffa_to_std_errno(-INVALID_PARAMETERS));
> +     ut_asserteq(-EOPNOTSUPP, ffa_to_std_errno(-NOT_SUPPORTED));

Just to clarify, ffa_to_std_errno() is a pure helper unrelated to the
messaging round-trip - please split this into its own dm_test, so a
regression in the table doesn't look like a transport failure, and add
coverage for at least the boundary cases (e.g. 0, MAX_NUMBER_FFA_ERR,
an out-of-range value) which all should map to -EINVAL.

Regards,
Simon
