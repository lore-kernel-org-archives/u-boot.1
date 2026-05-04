Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A02DFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E37483FEC;
	Mon,  4 May 2026 14:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nzVpJRNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 929DF84653; Mon,  4 May 2026 14:27:30 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A68E28394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-676e62faf2bso440907a12.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897648; cv=none;
 d=google.com; s=arc-20240605;
 b=j+VZN17G9SyRxRzfj3nQIDuQBzuSrYcir+hCMXztpACTaHvXt2PG0d1DLfDPcJqDek
 LL5pPhLQ3Ttm9amRsDyPyon4MMBXQyhy1tvFng5ssogRTOIgy/FkaROiBz1K187/7eKc
 vC23DF0qckoUITPY7wcTTBE4ZZytjvW/PGv/BlJlJVqkdFLRwiCEpHpL+ClYcE+I89Wz
 BPIRpgRrO7TBNB+dssc7C98F93KYx/VVkXxM2TvFryJYTY+fp3k6Yii0841YAKabKc9x
 mxToWYoynnixp1ImJCUhKV8aA6DML4dKSXek/q9/t6hb5h4AO1ppld2BrhIf3rJ8g9uv
 ssAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IWdI5H3aBz4CkP8/uV4GsJEGaWWyqTX7wd0Fxos7zNE=;
 fh=PKLU0xSNpsrGOfl0gQ17G1VaKViMSq+Ysfr2F1w3zVg=;
 b=cha00IOQPKIeCHpnpdPmGZjbbRG/03GcXB30pI+Of9VL1gNHXTZtFNP6OgWoqivyo1
 B7o2JbMkSGdmzcV+6whEmDpe6HJvWeMOiZCklpsnD0XDK4yOFMbeFeHDprBVdZBu6mbg
 G9vkE8y3kQZB+7pJTCHkeiFZ9LtTSQign2hAytmucPB6gGKroCBcLK05dvJ90UxpsalN
 3ZOxJvvHMCwsX6yWSQNiCiVMulCII2M/xqxgHJkdUN3Kor3EVvrIWC/nZfkVmSHcreMl
 YPpywFd1JvHnjdquPOzxcwRcC7ihWFwR000BJyeTBp30KBSiX6FCn1WPl6YOUkkVxRG8
 SMzQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897648; x=1778502448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IWdI5H3aBz4CkP8/uV4GsJEGaWWyqTX7wd0Fxos7zNE=;
 b=nzVpJRNR+6jVIFNpFrSQI8SW2xrKhtC3lTaWfDEWM84hSS0TmRVmzuSoCKnn+bUOhM
 zZ8azGUTVg6EJb8Vl28gmTJWihlD5r78fQKG9jgGRG3VZRSpvBmbRCIcGn79U9XFIfqF
 l1vO+Jk3J4wvsEK0b63F/dV/iz60HzWjG5R84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897648; x=1778502448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWdI5H3aBz4CkP8/uV4GsJEGaWWyqTX7wd0Fxos7zNE=;
 b=JTXM+StbOQBNtkTKle5p0Gr2dNCiy7D/lG/PJ2qs4D7hAq34NOEfajzcTQks5Y+EYI
 fjD3Q9Apd/SMFIpKlXxc1KEiQ5r87lhR9yF+hrB3BlDfKcu3sX7YubPCajM8uulKxndG
 GGwYtsFpcXH36MI4grFxwpL1oKbpUE9rwpURARjJ+ljgqV50wQg3mmSUaN3b0bUdCsKu
 iOXfJQgZTT7do+AL0p70vD6ymGJEeZqNgXAeockTReSDAdBqNV3JPfj6rL9dnDQIZDJ1
 OlsWxow81uKC/XR6SSJ//mdm/LVIijP1nVi72dP517jxIUJ+SFvno+zlgbHdJBD+IqUQ
 sPXg==
X-Gm-Message-State: AOJu0YyxE1JcJ4NoPOCAszCoj5+hq7Qm33BhShAdJwlO0r0eqQK/5nP2
 lp1KUX9ThxSsmUKAg0EyKokx8RN3B6nzh61YgD00zGWH2fmehPLv1hBUgedk8T4aUPlOjkT0CdI
 4uLNG1ULlnXhT6fAXl+rRrFSgV0KrXoc4nw43IEDw
X-Gm-Gg: AeBDiev+qRkM6cz6jCIh3/rQxxE1mYXK7+8iZSsPtFdlPveKbfI8SKLGYPaBDbmW+g7
 asQEJHJmoGyKCa911x+6bh8oNSQyWAoo1SKTm3yGCkvCzzBfhCLTLxfiSJxaEhandp0HejrDXU9
 ul+8RrE+jhPiSveMrEaxiVK4TjT0esHJml6bQSpZ0rjefsCUpeF4K4pE6XF6KDninjtgupyqiv8
 UMeoWajxoOOqCS+uayqZWM4eB8vMK1EilPWOOu9u8OuyBArP4tojsarKhPTWj+RkqUkwpGv0rlC
 +2VggELY2b9YcaXx
X-Received: by 2002:a17:906:f5a9:b0:bc3:3864:b528 with SMTP id
 a640c23a62f3a-bc33864d5a3mr88381166b.40.1777897647770; Mon, 04 May 2026
 05:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
In-Reply-To: <20260430122629.606153-1-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:27:15 -0600
X-Gm-Features: AVHnY4IJP8DZzv1Fnz2U6kEiLuYPMGteBrC2rDGPvHmOt8Pu8sfICJ-yfZ1fUW8
Message-ID: <CAFLszThcmzcAewzvjN_4kY4FR6rGknHmWUF4GNha__4h2uCqAA@mail.gmail.com>
Subject: Re: [v2,0/4] Improve FIT signature handling
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de
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

Hi Ludwig,

On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:

> (optionally) enforce signatures so we can't accidentally boot
> unsigned fit images.

Thanks for tackling this - fail-open signature verification has bitten
people before, so making it opt-out is a good direction! A few
series-level points:

test/py/tests/test_vboot.py exercises FIT signing end-to-end; please
extend it to cover FIT_SIGNATURE_REQUIRED in both the success and
fail-closed paths (no keys in the control DT, unsigned config).
fit_all_configurations_verify() added in patch 4 should also get a
test, ideally driven through iminfo so the command path is covered
too. I wonder if we should enable the option for just one of sandbox /
sandbox_flattree?

Please update doc/usage/fit/signature.rst to describe
FIT_SIGNATURE_REQUIRED, what it changes, and the migration story for
boards relying on the fail-open behaviour. The QEMU change in patch 1
needs a note in doc/board/emulation/qemu-arm.rst too - the
CONFIG_OF_OMIT_DTB=n / CONFIG_OF_LIBFDT_OVERLAY=y pairing it needs is
not obvious.

Regards,
Simon
