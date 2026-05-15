Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDE9CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2BCB847C5;
	Fri, 15 May 2026 16:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JljnH8aP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6649847C5; Fri, 15 May 2026 16:15:30 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70C884676
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6815add87f0so4729711a12.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854528; cv=none;
 d=google.com; s=arc-20240605;
 b=hWRYNYhVmaqPh3A19dQBC+uUV68UA5dYMj7pi5a5l1cLtBnik2jZwZW9Ripba6rt3u
 7SLxYq2iDthmMlA71zpSrXsJvAjvyf1LtP/vKk8PRh8jktuNUIH5AbubOkr83YqHERgT
 9ulbbRBANgwnkghO+rZLf5Z+m1Kpxl14UYm9fn9zTJvuZPQG8RbOGcqyBPYsoIEo6nCb
 2tvDnK/YnQJ3YN5iFJNQE+ypVmbZsL2Rh4aSbkU6aJeZ6GDaZ0ySWJS81v4esyhJqaKK
 EzMW6Gp4Rwerx1/joI9zzFXa+PZkm461DnU9FxJlUGpGLghW0zvhHjOk0C/1GkV2AI/A
 eAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=72QX8xy9X2oAOTZ21Z7S1hGx8OPxVfGULjf/234qk1w=;
 fh=dNC01P1e2vr2lQSUV2I2e7Jq0hpJhFn8N2voCk4FPAs=;
 b=YBgoyqHIljyVRRENoMx6u4Daz4PioN7q5P+CX7dP2vN1v1pluvu9drM7jrhBqNmBtF
 sap3ql1k/CeKCMdOtJN+aGn8BO+TdiAFfq+SoJBwmRv9Gc0832SucNqGBZxfNHlTnCXS
 F5nOjnr5k9U21HSuR/iwkDCvKx0gnoMA7157bvAB+CTjh6Y+yg0UTvirqNz2XvXyq9Rg
 b+OJXoOEI6rZ9+AEq9zqNJ6pN3Mxm+9Oh4rITAF7+yFf00wsgw5W1gDUgzKRzKQ/ulVX
 BZVqe3+7NOP/BCywbInkKjSCxq8+egTI9UKx0DHIYFJKTA19B64VVPL8BWhbT0FKbTmI
 66PQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778854528; x=1779459328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=72QX8xy9X2oAOTZ21Z7S1hGx8OPxVfGULjf/234qk1w=;
 b=JljnH8aP7kMI3I4TYMdSmuFhMTkyVG8tIrLiAA8gMZoPCiD1lTybYjInbmq9SFYNfx
 ICG9Fz2dRgJEEa1Hq5exw736z5DB5Ty/BeP8EI0+auG/XWWQ5GTiS+rx9Jg691EYFtux
 mwyn4aHbsymK4naC+xdFbDIc14RDMbyKOYRhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854528; x=1779459328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72QX8xy9X2oAOTZ21Z7S1hGx8OPxVfGULjf/234qk1w=;
 b=GZATLPPYa3os0tCqjSe2cvdsIt+RmSM0bIxvkG/gki/yBd/ZcnEv+HzfR2fmwi+28/
 ODstA17ozQypAZZBaco+x14i2se9xxaomc1XFPbx8mInEUZ3FTKlE4jXZssyXMLthsNL
 qX1vhvCugArs+7ldkIfBvRR5JUI8h1mdj/NRxU9miLZ97I6iFLM7bWjdIOTqpP4BoMF7
 mu4F0/puyF819SRY9dFO/L5TPuV8xaEXhUmPlNetUul033ulxCX7KiKrJivmd9sxtRYY
 4MfSUN99Jp7IWCUZIuZXNrDk3f/gkdPGiVRPSC+fnOmtRVgbojIkF7omsCNXTGuUhr1K
 fZcQ==
X-Gm-Message-State: AOJu0Yy9U8A+rtiFNrXE/Q06WPMJ80AGtFraiuceq8dGc6jObFiiT+0y
 4/lC6uNMVgYdh0N9gJQSQJ8hHjOxfhU8iz/45m6LS65xyEqHi4nRaN4gbftWS2hYp2LZdh/2PQv
 o1rxq1L4wFrHmrQm2YcQJT3gSPqZaP0QXlZv6LIs4
X-Gm-Gg: Acq92OGAH7YxXnvB3X7Wz2ax/qz3Id5DW1QhWW+V98A13tezxmiEWoUx7Abzhm89NTd
 GJcmDoSMOUzYd4nzGFrBO8CUApGZp9pEjDr2RU6Sk+31RoWSCqgzmCKeO1EOO4TLVaQCurx9zH+
 Skkp90vjERL1R9Uv4SK8GVhMle2mzFZ1vVuIwobJBpFom+HG70ZB3Z53DmMEgfZgGjFXfVYoyr5
 xtM4WwvkTjNlwMdjxyfSMeKInIhl9THHMC292kEWGkwa20bFAFuQ5gJVpdBOZbzkUaYm0yZUPNB
 u5GnedLU/qy9CuRXuuyq9Ik45B0=
X-Received: by 2002:a17:907:c00e:b0:bd5:af3:8a2a with SMTP id
 a640c23a62f3a-bd5177dbe1emr261494066b.18.1778854528164; Fri, 15 May 2026
 07:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-12-aidan@wolfssl.com>
In-Reply-To: <20260513002625.76915-12-aidan@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:15:16 -0600
X-Gm-Features: AVHnY4K_rqGoZrnDdsU-nptNT0E7XEyG6MrfmwLA1aGVPuazFuETtib7SmkFPdA
Message-ID: <CAFLszTiXR+=xWU3t_4-Eg_cvyUesh54S=h5ve_AoomGVgefvvw@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] test: add wolfTPM C unit tests and Python
 integration tests
To: Aidan Garske <aidan@wolfssl.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>
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

Hi Aidan,

On Tue, 12 May 2026 at 18:27, Aidan Garske <aidan@wolfssl.com> wrote:
>
> From: Aidan <aidan@wolfssl.com>
>
> Add comprehensive test suites for wolfTPM commands, modeled after
> the existing TPM2 test infrastructure.
>
> test/cmd/wolftpm.c (C unit tests):
>   18 tests using U-Boot's unit test framework (CMD_TEST macro):
>   - autostart, init, info, state, device: basic lifecycle
>   - self_test (full and continue): TPM self-test verification
>   - startup_clear, startup_state: TPM2_Startup modes
>   - get_capability: read TPM properties
>   - caps: wolfTPM-enhanced capabilities display
>   - clear: TPM state reset via LOCKOUT hierarchy
>   - pcr_read, pcr_extend, pcr_print: PCR operations
>   - pcr_allocate: PCR bank reconfiguration
>   - dam_reset, dam_parameters: dictionary attack mitigation
>   - change_auth: hierarchy password change (requires wolfCrypt)
>   - cleanup: reset TPM state after tests
>   Run with: ut cmd cmd_test_wolftpm_*
>
> test/cmd/Makefile:
>   Adds wolftpm.o when CONFIG_TPM_WOLF is enabled.
>
> test/py/tests/test_wolftpm.py (Python integration tests):
>   21 tests using pytest with the U-Boot test framework:
>   - Requires QEMU + swtpm (not sandbox) because wolfTPM bypasses
>     U-Boot's driver model and communicates directly with TPM
>     hardware via its own SPI/MMIO HAL
>   - Tests mirror the C tests but run end-to-end through the U-Boot
>     console, checking return codes via 'echo $?'
>   - Includes force_init() helper for TPM reinitialization after
>     test failures
>   - Skippable via env__wolftpm_device_test_skip config
>   - Verified: 19 passed, 2 skipped (change_auth requires wolfCrypt,
>     get_capability may skip on some platforms)
>
> Signed-off-by: Aidan Garske <aidan@wolfssl.com>
> ---
>  test/cmd/Makefile             |   1 +
>  test/cmd/wolftpm.c            | 364 +++++++++++++++++++++++++++++++++
>  test/py/tests/test_wolftpm.py | 375 ++++++++++++++++++++++++++++++++++
>  3 files changed, 740 insertions(+)
>  create mode 100644 test/cmd/wolftpm.c
>  create mode 100644 test/py/tests/test_wolftpm.py

Thank you for writing tests here. For the cmd tests it is a good idea
to check the console output - see the UTF_CONSOLE flag and things like
ut_assert_nextline()

Regards,
Simon
