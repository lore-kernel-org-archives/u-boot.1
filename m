Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A0DFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86B3845E9;
	Mon,  4 May 2026 14:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c76cV1WA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA777845E3; Mon,  4 May 2026 14:17:45 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93D483FEC
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so7857341a12.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897063; cv=none;
 d=google.com; s=arc-20240605;
 b=fl/e5km//HqVwVlrjknRMZkHaOv/do/coiFVDc1uj0QHSMRwe9JuyKo0vZ+ZyUbuOA
 TcHIEdKnr75QdXa6o2ir9LSTmRg33VRL+CfxuXPUwNgo+zSVHUQwrx4lmpqPSsmqLuQi
 KCqiWs8+BvOGzv99zxcmUSq1Gm7ETYhztVK6vwFBwFHtHb8lMaDRfUQbQNT6NvMuJfr1
 VLAqDL4dEm2BLK6eEBdzPoHfTsUnNsmH+aWuaghWxFefRCC/GYi+bhMBac12b2cj0EkB
 zs4k5Vor9rTFAdlQMEfZ2k8y3+y+8nV0/8nrfhuh9nOpdMywMLWym2ZVqdR0S2s0dssl
 D94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=suEa1mvWkV3XjyxJkzq/aU35EdHAiVhFwO1Q2Sc18eg=;
 fh=jmbcoFG2RPEOJsmPKSiakkV0VWJqP8RiS13G+yktnmU=;
 b=LrmN8g52rS/JT9+hv2wLVx3ygBYYFPbTVybYyJrjyNcLZcVhkTefa7t2yKk4KEoBNh
 QN0o644UrSAPyZ0TmAD1x+xc8r0JUmwEfBzHMaQ0ejyhKmuIkx5UngZ1akAxjHPG43rt
 dO1bO8nsQbXNrQ2yacrQImRMV2360VohBYhWjgjXBCwmpXHAVLvD7XFqLVwKUKX2akES
 +Ec8e+bXt4X8Zi7CDX9qANrkc6hxey9j+OvKR8h8+aHt1ItLiaNihpbA2Bm/9Meswaq9
 kLITYoQg6txfePhHY6/EglucIFxe844lcP4WmJRibxjZW03owcZ2SX7+NORXkoIbIetk
 5O1Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897063; x=1778501863; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=suEa1mvWkV3XjyxJkzq/aU35EdHAiVhFwO1Q2Sc18eg=;
 b=c76cV1WAT/bYpGlE7BDUCHpha15VBU8bmt5ANOIMC8KTVjcyNotVPxonHNk18VhI1R
 EVwZPCIWBsg56OC9eW9e7UMV85wuCAQV5V86tkzIcJW+AAPrcfzlCyi1gZ1addA+iRCh
 JbuRAUSPWOSMo3SCdsLPL6Y47E6bd2WofXsS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897063; x=1778501863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suEa1mvWkV3XjyxJkzq/aU35EdHAiVhFwO1Q2Sc18eg=;
 b=NXAa3MkJrlvCJxj2i7geN9rAAgVEOPmjNXdO4PjFaPIVi9IHCodBnjV1Hu9eDbaRd9
 jtvpQNWKSRFP3pOtuZRc7/HVsy2ID/DVQAa6nUaRXnXemRHX/8wALxQi1reQK8/OA7Ou
 3+s1CcieRvKnaLfqKDYKLsjAOk82r2DElyK/VNo/yGs+zwHt7P6MgmLCPxjBpnFBK0cU
 K6m0VC8xCjV7u8O6/4f6AElX0Ef/VY9mvxcGN0jxUDqCv87bZYxTyc5Ov/pw3RSjwoJ6
 fDa0v6FN/ZGblkiEf2LRgRpHAKgYKKUEb81K5EeMxmtRNAS0dm7+9uT0ir8Zq8LUFdj7
 G21A==
X-Gm-Message-State: AOJu0YxwvG8BhOqMDXSsewAP0ts08suoG0GeY/uh/aAiRO4QkC7EiyTn
 zJiiw+STzRrNb1d09UxwUdTJbsuuujbe2S3E97jU5LR+jP1dW3qEni7KSy93kAlBoF606QA6OhD
 gMr48KTMXlF8yST1vUxcuAjQCY9sJAFaJi3IiNuGV
X-Gm-Gg: AeBDiesTwIfdW7p/kpVtoGbl8HNzRN5N20WgG3Hl6k11SHB7oB+zHP0Ai5srpAyTzhd
 robhpAPLVycR5pjunIJaaTP/oW3A6QVCNTr05EnRVx8g9papasSxKk8ETPqP9uBeH0GL7TPvdIU
 VIekxSrXjH6OPnFRb71lMc7YQUpwI7DNbxUp+5sQ+FCoAM3AWe9l3EQiHxuo2b1hWTi2uBRcizW
 jq6dhoD6bWbW/SWngyg4S2DMuMcjA7aQ8RV9vmcDHdtYdTtuJZnT/aj9uAAT5vcO1b3+yaujkui
 rudrUKOxNa8w6bnS
X-Received: by 2002:a17:907:3e1d:b0:bc2:df19:b48e with SMTP id
 a640c23a62f3a-bc2df19b65fmr134759166b.34.1777897063347; Mon, 04 May 2026
 05:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777551598.git.michal.simek@amd.com>
 <7c16f629d85dba0118f8d67831adb8f167bdb8f1.1777551598.git.michal.simek@amd.com>
In-Reply-To: <7c16f629d85dba0118f8d67831adb8f167bdb8f1.1777551598.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:17:31 -0600
X-Gm-Features: AVHnY4I8NqKuIDiNcZYNZGY3BFilAMTHWo605Z7BwKxSvLfXtVSJUrvqFrKKZC0
Message-ID: <CAFLszTgN0=H_5qRfeqzB0V-fOeXYfV-xJ4upGSB4W5tGnaZ51Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com
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

On 2026-04-30T12:20:00, Michal Simek <michal.simek@amd.com> wrote:
> reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
>
> Add DM test coverage for the new reset_reset() and reset_reset_bulk()
> API functions. The tests exercise the assert + deassert fallback path
> since the sandbox reset driver does not implement the rst_reset op.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> arch/sandbox/include/asm/reset.h   |  2 ++
>  drivers/reset/sandbox-reset-test.c | 14 ++++++++++
>  test/dm/reset.c                    | 53 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)

> diff --git a/test/dm/reset.c b/test/dm/reset.c
> @@ -120,6 +120,59 @@ static int dm_test_reset_devm(struct unit_test_state *uts)
> +     ut_assertok(sandbox_reset_test_assert(dev_test));
> +     ut_asserteq(1, sandbox_reset_query(dev_reset, TEST_RESET_ID));
> +
> +     ut_assertok(sandbox_reset_test_reset(dev_test));
> +     ut_asserteq(0, sandbox_reset_query(dev_reset, TEST_RESET_ID));

This only checks the final state, i.e. a broken reset_reset() that
skips the assert step would still pass, since the line was already
asserted manually before the call. Please can you extend the sandbox
driver to track the assert phase (a sticky 'was_asserted' flag or a
transition counter) so the test confirms both halves of the pulse
actually happen? Same for dm_test_reset_reset_bulk()

> diff --git a/drivers/reset/sandbox-reset-test.c b/drivers/reset/sandbox-reset-test.c
> @@ -96,6 +96,20 @@ int sandbox_reset_test_deassert_bulk(struct udevice *dev)
> +int sandbox_reset_test_reset(struct udevice *dev)
> +{
> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
> +
> +     return reset_reset(sbrt->ctlp);
> +}

Re your commit message, better to implement rst_reset for sandbox, so
that we keep the coverage up.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
