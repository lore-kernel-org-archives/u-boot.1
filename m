Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665C8F30298
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 02:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D77B84011;
	Mon, 16 Mar 2026 03:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BVdf5/9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530768401A; Mon, 16 Mar 2026 03:44:06 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A6BF84008
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 03:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b97c44417ffso22778466b.2
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 19:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773629044; cv=none;
 d=google.com; s=arc-20240605;
 b=C4PfNmxXOxgd6fwa5H+MEAYHiB8WOyuaV+cHyMdfqJYU7rWg37x9jBQTzB61gutZYT
 Dl+FCN6VUrZ7pxEJ8ukFHPHdjfG35gGd/s2ZsF5M07NCcwsiXftO26JDixdQ9Nt42X94
 awDJpvEheMX0eYtP8i/8xSMPhdSf7BzJe9t7YjtGEdp4BDxFZ+jTaJmdOcGsFZpcgY02
 O5oM5B5wIGJU3Dhvt6pbwXzELLFi3V7PZx6SuMcIdWnCXJrhtk+rx95epepGsd5aiXr3
 Wx6PsCx/kpygplmGzZb92caC/0vailac46R8HIihtGpBpMry0VPiUAiNvezqN1WGk8pK
 W/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VBtJq/iqJ8nwqRVYYsVGfM9aXOgTrilhA60C+e3VQzE=;
 fh=77GWSjT2mlmLf3PtBjW8TPqEIXbpJQfI8TB2+BGo2u8=;
 b=BNzBE6BS9K+duhbmFUbROLIJvSbmRjbGnlKxlTH/PYhEFcjeZMwNdF1AfAVdjTktlO
 b0SqaqUeJZ1BYXDpFntyU/zHtlLHFt7hPYQtCxarFIgXrn9h88AK2Awp/3QLMFl1sTWX
 BhjQqliCPW1XofUt5QiafAs7/9y1Ntj6nn9gnoYNESHz7WPiBfxfE71ihpx4NyV03NxE
 j7wUwIYYP4eRdh2eONyo4aLjyOrP5prwZ/FnmpdTGMnGr4NeeHVwjGp0O2mHc7phEVHM
 rsZrnJ5jgbknj36dMAomIlZMQ1Mv9S2oTLRX/itA7Reyrh5cySk14NyCKPJKWJJgddfF
 a5cw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773629044; x=1774233844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VBtJq/iqJ8nwqRVYYsVGfM9aXOgTrilhA60C+e3VQzE=;
 b=BVdf5/9jLvzglBl6UZdOTQJB5HMThMlZAVE6uPncuvsef1gOgcV3Wyh8BpVRncD41e
 mLImZba1ENzE/UOINPE0KrNS2mJl5AGs0ZJJku3x9PbtLUdbAHqv2L2Wjg0bFXuVplV3
 tNRoQxtXgUTE6j6k81F7zELs/gV6UjrDivfPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773629044; x=1774233844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBtJq/iqJ8nwqRVYYsVGfM9aXOgTrilhA60C+e3VQzE=;
 b=hDpOebFKtlW/ahfgcvtr57GOzOH1CGvoDhvE6QyHpntwlKTNwt2BLF+NoJcKRe/iHn
 K+UCq10eG+pYtsqV8XCVArgqilEirouwOnSLdTiFVBioxgDogpHjCqT9PwBuIXf0pXFe
 M2sYYiKsVLWMZTFXX1+2k0MBP9ZejRk90URjGsYdKOLPcVxsJbHyN7kqQX9j3nMO9qvd
 cbYksr3H3sFE0aCd6gdCirFVO+yrgvTI1aanajT5aeAmUzyhoV50hxV2YsvPGqjFYK/t
 jBdAxWwv4eHYOGU4r8nyyN0jbMn7VL/QVQwRZZqb9Qm+LGrCibRM9Ghv6q1kUTx4Oepp
 00JQ==
X-Gm-Message-State: AOJu0YwrvauqOrslIrTWEwbEEtdz0vNhD/Fhf0WGCgKYEeLHTC71GqPg
 Sc0Rsy5EChEG7GqW07KIcmfbXKFnWYw3x70NnRS1o6jzjJkiqpymBqVozPWgGoRUZ/yiBZETFMs
 bqUdrDgvcCvOoqsV54U77ODUsvA4viOiypO3na4/hq4K19KHKblQ=
X-Gm-Gg: ATEYQzzayP2PVYL9jn1rP1k7KxmVZEnCmXOVyCtsxLffuE/QfL8Vz92fir7DZh6N1EE
 Gu/KLxRPO3xVqZW2HIcWO6wZQU6ylYYAkq3ekAoXy1bClMYCRdrC/lTvQZZLrXkSB0PEG1q05Ac
 F/TvLGxVrSeCveASZ5I0kQJtcLnPERQfCJ+S5cdf1QhV2NrCmnKbMHYO9tlSapYpnNtN31A3/f5
 OVfPMR0sBxMqmlqGk/PCnsdc3tb/udNWasoECbOxgP7H4WTeoF1IniVEq0RS0juKhrLznK/gcao
 FSGggA==
X-Received: by 2002:a17:907:d38c:b0:b93:7d70:20a0 with SMTP id
 a640c23a62f3a-b976500f9e0mr560118566b.4.1773629043791; Sun, 15 Mar 2026
 19:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260311120910.3934114-1-ravi@prevas.dk>
 <20260311120910.3934114-3-ravi@prevas.dk>
In-Reply-To: <20260311120910.3934114-3-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Mar 2026 20:43:49 -0600
X-Gm-Features: AaiRm511MkQ-me6OvkqElpR_-x1d3W9ZcXPL1JrbtESUBD4D-uBnibfNB2QtFYU
Message-ID: <CAFLszTjObK850TKYL7PmwFqrQRtdTtSAftVZpLUGSDwo8mApZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] test: add tests for left-bracket alias for 'test'
 command
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Wed, 11 Mar 2026 at 06:09, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> Duplicate a few of the existing test cases, using the [ spelling, and
> also ensure that the presence of a matching ] as a separate and last
> argument is enforced.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  test/hush/if.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/test/hush/if.c b/test/hush/if.c
> index ea615b246a9..148e9a53e90 100644
> --- a/test/hush/if.c
> +++ b/test/hush/if.c
> @@ -315,3 +315,34 @@ static int hush_test_if_z_operator(struct unit_test_state *uts)
>         return 0;
>  }
>  HUSH_TEST(hush_test_if_z_operator, 0);
> +
> +static int hush_test_lbracket_alias(struct unit_test_state *uts)
> +{
> +       char if_formatted[128];
> +       const char *missing_rbracket_error = "[: missing terminating ]";
> +
> +       sprintf(if_formatted, if_format, "[ aaa = aaa ]");
> +       ut_assertok(run_command(if_formatted, 0));

How about using run_commandf() so you can do this in one line? Looks
good apart from that.

> +
> +       sprintf(if_formatted, if_format, "[ aaa = bbb ]");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +
> +       sprintf(if_formatted, if_format, "[ aaa = aaa");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +       ut_assert_nextline(missing_rbracket_error);
> +
> +       sprintf(if_formatted, if_format, "[ aaa = bbb");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +       ut_assert_nextline(missing_rbracket_error);
> +
> +       sprintf(if_formatted, if_format, "[ aaa = aaa]");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +       ut_assert_nextline(missing_rbracket_error);
> +
> +       sprintf(if_formatted, if_format, "[ aaa = bbb]");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +       ut_assert_nextline(missing_rbracket_error);
> +
> +       return 0;
> +}
> +HUSH_TEST(hush_test_lbracket_alias, UTF_CONSOLE);
> --
> 2.53.0
>

Regards,
Simon
