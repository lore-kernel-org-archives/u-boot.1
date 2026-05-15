Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B31CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF9358467A;
	Fri, 15 May 2026 15:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LbR3AJyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D4318467A; Fri, 15 May 2026 15:34:51 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2C684676
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c822652f82aso6801633a12.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778852088; cv=none;
 d=google.com; s=arc-20240605;
 b=G4EdJZnuDASBA1HwR5LZRI/jls2MMJhGJhxi3iVdRFJ/79vvuO5rkSbpciIpDt9qBB
 JIENtsWy7MBXu+QsFTVfL9dTRW8dW74pFzobCq7NTpdu9anl8EvQuKRytU4HbvHc3TXm
 MY5Z56JaDJeoW78e46uo9/SzPFDbfqszjQ6/GENqh2mfZQMHjk47wHDKdNcqIyU7I4Cm
 GyoBCxoWZxqLeh1uztnffk4lmnZcl5VJEmhZ9i/RP0E+UB6nUl04lmsdH8o82JBONOGj
 6q60njAprxylIW8/Zoai9jZZ0LJeeR/RgUyRbpdyvIpFZSQqB1X6hJQQR722a71MjP8g
 qTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vrH1+i9ANv8kcO0i7a7gNq463pJJjkaNwiQhL/d6MF8=;
 fh=qmb99AbYrxQTqbU8c3YoikZ37BstHm/br0rQHEGk45c=;
 b=PFZy+jzkfAnPfWA1a8mWEl8kbMauFBgWPYFwv/bfjUXXxlC5PabYB+DlXQDujcR9Uf
 s/OkFiXlxoHZseUuMjGULsWF36M7ZLq364SoCatksfEXN5nNayuP4yACE4qXo2b9yPSH
 rnJVU/pK51Za4y1x+naaNToq0kYuWzdWJMuGF1CU8KjZwNyI5dFjzh0jIJ6453XM9WZ6
 rDyB7PtNgqWKmR18tWFqt/InykKeNdv+bxSRVFefRPGZ0TE2qGKRikdmpJ2GZXap8B+9
 flQAP/vJkqtsP/BwKH2a79n/OUkCWKZZjon2qhJoBTTox1G1+kuxlXnB2okQVaeRBqcD
 cuDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778852088; x=1779456888; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vrH1+i9ANv8kcO0i7a7gNq463pJJjkaNwiQhL/d6MF8=;
 b=LbR3AJyBaduMNkF6ho9Fe1FeX87GWaDieFkPCtbbdOZHRF0vCBVTPDXkgeCcxXIxSp
 CiCfZMuRQr0KPTOUU5MxM3la+u4ouNEIsdDkj7zIpKlTxlv2yfj6A1uq5oh9ZUP+uSQH
 n3DAHDssQKqHkipS92EfGwO4hmsQmCcaivKoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778852088; x=1779456888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrH1+i9ANv8kcO0i7a7gNq463pJJjkaNwiQhL/d6MF8=;
 b=IUctZFrLv/z6cEwiMqnA7lu5wItcIrxAa74q16ni83sQaEaMqZ1Fip9YXyf1zaLrrU
 eHBEUr+YvnOFKgPXj7P2W3Um43mzsUx3JAgXjVJO7zgZXgltPwvHG1SnWoo3AXfCbTY4
 hvHvxu4a2wVYCoJnsdM3/QvmDeKrK0W0WLr85cv8o8mbDEdHbheojkRFtSl+Nq0eMbYZ
 T0aegtl4EOW4uWs6HVxZJ13XYSXDgzMt6mHdg/yebIwb4qZUjxsyBPHAXn1+VToqd2wl
 xtnGqGtEPqoV4z/q60AdCdP1sKpL/D/+/JdLh1FjLNR6BdpY/LrWfVGleW4eeJ75nsQ0
 8HJg==
X-Gm-Message-State: AOJu0YzFWl8g0FBMt3M4qXoBOZ014y6sCfU//DsvksuTc9MC5y8IOd7T
 Ih8wQPvFHDyHMBQbfiW46vxt0+4Yju9qEB4gG1uTDA4cp//6EYG4iIj1SodsIirgo6g8aFunCZV
 JjnzBcQT69MVmMR2WgMwl4M88HnFwAZU1kIYPNmj9
X-Gm-Gg: Acq92OHf0JkRo2uAXhhONJIUf6h8lM0M7dd3kb7/HTRwL9OeHXFVHwpzDSvFts5bjex
 veX2pQi7sKGc5biRkx0SDY9HNYKSfimXU34njFlTsww5HYqf85zSP7j9EIr11FBGm8QUNs6EdwM
 qMIhwuwWOonHYbjRUqj1AaIdIwfMAbORFoO6+Gp+T/RNMrdjXndbi3mGp+ZL5g6kqnY8o/PmHwj
 BxUUP+O7qKiLAgjWtLClxYoCYvpGlewl5KVi8rL37aRnYREPZxAVxYBr3IY7G+1ZCNqxiwGufLM
 M9/NxVKYvzmx2G/y
X-Received: by 2002:a05:6a20:3d8f:b0:3a2:f402:50fb with SMTP id
 adf61e73a8af0-3b22ec9780bmr4659695637.34.1778852087663; Fri, 15 May 2026
 06:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778665323.git.michal.simek@amd.com>
 <ced1fd0e7b531fcfae9ee7c0a107ee660d27d580.1778665323.git.michal.simek@amd.com>
In-Reply-To: <ced1fd0e7b531fcfae9ee7c0a107ee660d27d580.1778665323.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:34:10 -0600
X-Gm-Features: AVHnY4ILfWqz36KHZxg82RkFmOjffAi8GGImbVGS3RK4mNXcThJWoc055qcfiho
Message-ID: <CAFLszTjgoxeVkyr+TLNOY0mURhRQPv=RUCp+4ZP0zjSD30vfAQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] reset: sandbox: Cover reset_reset() fallback with
 second sandbox provider
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com, Simon Glass <sjg@chromium.org>
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

Hi Michal,

On 2026-05-13T09:42:05, Michal Simek <michal.simek@amd.com> wrote:
> reset: sandbox: Cover reset_reset() fallback with second sandbox provider
>
> Add a sandbox reset controller compatible string
> 'sandbox,reset-ctl-fallback-only' that reuses the existing sandbox assert,
> deassert, request, and free helpers but omits rst_reset. That forces
> reset_reset() through the core assert / udelay / deassert fallback.
>
> Extend the reset-ctl-test DT node with a fifth reset line named 'fallback'
> that points at the new provider, and add dm_test_reset_reset_fallback_path
> which verifies sandbox_reset_get_count() stays zero (rst_reset is never
> invoked) while the line ends deasserted after reset_reset().
>
> This complements the existing rst_reset coverage on sandbox,reset-ctl and
> matches the approach of using a separate controller to exercise the
> fallback path in unit tests.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> arch/sandbox/dts/test.dts     | 10 ++++++++--
>  drivers/reset/sandbox-reset.c | 27 +++++++++++++++++++++++++++
>  test/dm/reset.c               | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/test/dm/reset.c b/test/dm/reset.c
> @@ -151,6 +154,38 @@ static int dm_test_reset_reset(struct unit_test_state *uts)
> +     ut_asserteq(0, sandbox_reset_query(dev_reset_fb, FALLBACK_RESET_ID));
> +     ut_asserteq(0, sandbox_reset_get_count(dev_reset_fb, FALLBACK_RESET_ID));
> +
> +     ut_assertok(uclass_get_device_by_name(UCLASS_MISC, 'reset-ctl-test',
> +                                           &dev_test));
> +     ut_assertok(reset_get_by_name(dev_test, 'fallback', &ctl));
> +     ut_asserteq_ptr(ctl.dev, dev_reset_fb);
> +     ut_asserteq(ctl.id, FALLBACK_RESET_ID);
> +
> +     ut_assertok(reset_reset(&ctl, 1));
> +     ut_asserteq(0, sandbox_reset_get_count(dev_reset_fb, FALLBACK_RESET_ID));
> +     ut_asserteq(0, sandbox_reset_query(dev_reset_fb, FALLBACK_RESET_ID));

The line starts and ends deasserted, so this only proves rst_reset()
was not invoked, not that the fallback pulsed the line. An
implementation where reset_reset() returns 0 without doing anything
would still pass.

You could reset_assert() first, check the line reads asserted, then
call reset_reset() and verify it comes back deasserted. That mirrors
dm_test_reset_reset() from patch 2 and actually exercises the assert /
udelay / deassert sequence.

> +     ut_asserteq_ptr(ctl.dev, dev_reset_fb);
> +     ut_asserteq(ctl.id, FALLBACK_RESET_ID);

ut_asserteq() takes (expected, actual), so this should be
ut_asserteq(FALLBACK_RESET_ID, ctl.id).

Regards,
Simon
