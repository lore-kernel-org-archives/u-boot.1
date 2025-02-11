Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968B9C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFB9800CF;
	Tue, 11 Feb 2025 09:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vibE+G/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 923988033D; Tue, 11 Feb 2025 09:35:23 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F2C80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43934d6b155so16020915e9.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 00:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739262920; x=1739867720;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oCX8894HGyU+i38cUswUS6BbMeHJ5PXlhJNbWeq05Lg=;
 b=vibE+G/gjFTKNBtPq5OoFmBlrZ3Q1ylZMH3OVrY/WV3uh6BvA16KKn/aXeZ9d5Pdp5
 5wh2UMUqNJ2DelMVZouYpkhRrl59kXDsTfj9gk4Z18lqLKDLW2EvSgIb1kjwlUwowgcM
 QGggOfuo4Cv+wSE2dqXYP8pVsamjb4B2+KdzQNG/N37ht5cU6mGloEXgN5+Hqcr179Zs
 ftHHpH2CbzxqGLkI2v5Uj24jIvG3x/Xvo6w5UoJVT1OSpqldYMM0Hq4UXg6DJp4e1bnL
 dYG3v49NfwYHedLR1uRURpwBxYg40L3WkdTt5soNuvPEyeW4LkRBNNHUCgOKWL2rDFs3
 uYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739262920; x=1739867720;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCX8894HGyU+i38cUswUS6BbMeHJ5PXlhJNbWeq05Lg=;
 b=f6QdaNjcF1TYiICtc+sIQgQ9wayWAfpIYA/Yo9IKsqU87I1DGBO/LP3i5neshWdi9G
 DILaVP/HMljBWwyvTkPLt++swidb4AOa9qUSMOD8WlBPpoiTidc8nGTzxpNy+74w3wYs
 oaqvd8gpPy5zrw3yBVX7aaseVFwW9IloSjisMrLTEEKGgIG9M0zIByX+OtxdYwWnCuwk
 nZL8GwHEpvw2Zjky17XHX+DqgJEnS1EiafzZgKEemtsRD959ayz/fMJHSXE/TByq75uL
 +AxM1dZqdCsfOiQRK/ixPcFGQUZkufgM3AN7TjDvF10smWbYklEnkXaczq4S7lIjSkb7
 w9cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVopYmyubrfJ4KbB+2a2KIUo1wyfcx8s2tXXL1rpQnO4p66FpthJ9Sn3j8aONyu+RfCYxIk7RA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7wHmY9pdhnprOMVLDxBV4ECfE/aZT4JJ7lA2+ZAl2Pmkmq3nR
 +SQtS99Kil+q5U4HvDSsP33onU5PozF2U3f9cgaxAqLQvBU5tU6TTCfblzsMYKQ=
X-Gm-Gg: ASbGncsZKc04MFmYrOs+Zhz93VzEfAv+dQA0me4VMu/4e9la3hEbEKn9JuNOHmNSUBw
 1dfC4wlaVnnoyHhqnrzxotA0ubWn5djFBhVjb622CNY4MMf7sJkKJyQh+vMTG6JEHE76x9QTitW
 5aZDTcHlGs1en0MI+qNOoBh3+ufDIQEc+l+vXxNwodp0KS2lrPryjkbV4hDaib65szabFat4tTO
 /5RggzALSdN8bdBSH+aKzBSlN+4f90c7e6fpwlq6wfV3SvGzdhjIU0fI458X1zAyl8kADcfdGwx
 V8SjXm2ct8gjPEGspXETLddd
X-Google-Smtp-Source: AGHT+IHQKn7R3rMt2cFjL6sNt04VXP8h4HQ+fAe2liDHQ9AG9JXgT/lDBgiHHkFcn6CeoQ413lLwlw==
X-Received: by 2002:a05:600c:484a:b0:436:185f:dfae with SMTP id
 5b1f17b1804b1-4394ceb21fbmr18536545e9.6.1739262920063; 
 Tue, 11 Feb 2025 00:35:20 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43935c4f4aasm97446255e9.22.2025.02.11.00.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 00:35:19 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Andrew
 Goodbody <andrew.goodbody@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>, Jens
 Wiklander <jens.wiklander@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Julien Masson <jmasson@baylibre.com>, Love
 Kumar <love.kumar@amd.com>, Michal Simek <michal.simek@amd.com>, Padmarao
 Begari <padmarao.begari@amd.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Weinberger <richard@nod.at>, Sam Protsenko
 <semen.protsenko@linaro.org>, Stephen Warren <swarren@nvidia.com>, Stephen
 Warren <swarren@wwwdotorg.org>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 2/6] test/py: Drop u_boot_ prefix on test files
In-Reply-To: <20250209160725.1054845-3-sjg@chromium.org>
References: <20250209160725.1054845-1-sjg@chromium.org>
 <20250209160725.1054845-3-sjg@chromium.org>
Date: Tue, 11 Feb 2025 09:35:17 +0100
Message-ID: <871pw4anga.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

Thank you for the patch.

On dim., f=C3=A9vr. 09, 2025 at 09:07, Simon Glass <sjg@chromium.org> wrote:

> We know this is U-Boot so the prefix serves no purpose other than to
> make things longer and harder to read. Drop it and rename the files.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  doc/develop/py_testing.rst                    |  4 +-
>  doc/develop/tests_writing.rst                 |  2 +-
>  test/py/conftest.py                           | 52 +++++------
>  ...u_boot_console_base.py =3D> console_base.py} |  8 +-
>  ...onsole_exec_attach.py =3D> console_board.py} |  6 +-
>  ..._console_sandbox.py =3D> console_sandbox.py} |  8 +-
>  test/py/{u_boot_spawn.py =3D> spawn.py}         |  0
>  test/py/tests/test_android/test_ab.py         | 12 +--
>  test/py/tests/test_android/test_abootimg.py   | 10 +--
>  test/py/tests/test_android/test_avb.py        |  2 +-
>  test/py/tests/test_dfu.py                     | 18 ++--

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # test_android=
 / test_dfu

>  test/py/tests/test_efi_fit.py                 |  2 +-

[...]
