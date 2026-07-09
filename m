Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B65C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 18:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F17F084C02;
	Thu,  9 Jul 2026 20:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UbL8Bn6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 948FC84C05; Thu,  9 Jul 2026 20:57:42 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B8184C01
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698aa8d4dafso159852a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783623460; cv=none;
 d=google.com; s=arc-20260327;
 b=Oomrpqf3fm4DTJCx5dpgYZ4by0jJqVYIi6jSbUBCiQYZpio64wyxGBVYfVH2lbBp5Q
 YJ5dw8lujH969B8vA9+IXdbrYVoRy7tp3vgEEXYpiho5cu3voV4xyoqAxEAvxN0Fsqe3
 MyLOA1wNmelAt6z0sCGL2o6duZXiAVukQHfD/LE/WlhwsAtv1oRqn8TaUfxNjNH+YxB1
 gG5Dn3ZXT6jyDYErohBAu6q0LyhgCE+NEZ9bXzq9EuaxYVlNQOPT9k5oRSUyaBY1mh/M
 szekOj+sZkJaJyRN0yvySOJm2ssOmyRG+iXK031S+5mSCHYn2CBJaYnMI0I+x8IZcM5m
 0SRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TVO4tPbxMv+j0J//PM0iTUyrC9dCEbErTGbzpjx5NME=;
 fh=TliE1Jet2erAwxe87EYqLrPpLQmH/Bomcvaj7zIAsQg=;
 b=YKvHCLtjit7P60Rr6ZTIOkX5iLg5M2QWKxiPSjOGZKPIZHX2DTXK1Ujsx4eUEy6MFL
 evq3G9kMm/uLwbclUuW+e2coiF9NUoCHInOz1JRX+8xWrGFgLaJC4+la/FDZ+/kvQPso
 YDswMBIelBN5Z/nd48xNSuxkEsa9iomb0MlDw7wypyFj6S5Cv9EIXBFiv/28CKVPzPnl
 QlQi6gSXjdXOWHlajPmkUKeGOvhbVycRFVhnb9k3lkBSV/rv+0aChajYcv0o8LNnfqCP
 77oX4x6v9ocn8TNmPRaHOXtNR5lSYgYn7cC9tKJVyPsW8jgRqbZmLcx/gBueQFGH6dJU
 kZwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783623460; x=1784228260; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TVO4tPbxMv+j0J//PM0iTUyrC9dCEbErTGbzpjx5NME=;
 b=UbL8Bn6ph2wOsGPML3pG5drXxWL0poDUK3NS+NcLt5M43m4XfChR2D5pZ+N4XxnvrO
 Z1WPNNkU8beV+oyqBOZp+1/ufhOi+fhi0AMxcEHhf54mUtJTQ35+TMRub63ZbXXd9ibh
 ftNQx1CaKes1O1rIrNFtTEUSffQhmp7yJJUQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783623460; x=1784228260;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TVO4tPbxMv+j0J//PM0iTUyrC9dCEbErTGbzpjx5NME=;
 b=qgVRRHTssojhwGiPN02ccrPW3Wf3dmNXgB/r42eWBzHz6Xo+yPSFs43FA2ifWxcXw+
 EfgU90qsbESYwFxPP6QQAZnOA8s66R/mHvN3IN/2AVPf03Nus8HMX2s0Z0F3vuoBMNAO
 I6J49HE5gzSUdOJEb0ttZWwHcZjHdNt33xDnI4Uf1mGgfSYYMj209820sGigFmhPg7Ar
 V8nev30mEpUROtyNRb+ncWbbOrNqCjKMOerEvaHH1ppBfRXAmMN7BkbgUSrpLQM4PmsS
 rIo7BqCossZiu7enjiJjhHTUh8C5PkqRJovfdQomz1FJuV4PaRfzwwKbVhyY454VLmKf
 NftQ==
X-Gm-Message-State: AOJu0YzgT5PWfZSkaSW5yevayEqKJKjZJaANpqZ8LXyk+9tAGq5+Kuhu
 iP1jpTeP/Wl5PduCSyEz1XyYIn7eT7FHx2V+BDsL7SbSCyluUlGHJhmUOhNlm4LG6MdI3T/OHhv
 v3oTIc+G9q3wx4uIe0q1+w1D4LC3ty20w9f3yO52D
X-Gm-Gg: AfdE7cl11IT+l9l4RSM+Mzr9M1982KfYGmk+GhIz/U2MkRMkq7mLjgtegvJ+OFvp1B2
 97Dh8/Omoj5weLlGJ0E4JsOVxBNUCzFfLLq/eKMo3CxHGuD/kuJsfw619ih1YsjHqiYSJIIhtYY
 rbrvyrAnFSUePgTVdQsnBRB57LBO8cvHayL2f2hu+rrkMBLQkXeawjqIvxJez5pTscqJvBdyosN
 pdEjwpWyv/am1epXIXe5uBDOixrzJmB3aE7vIKgUdSg7RTVOzLTnLu/IbU7wD8YzD1/3Rk=
X-Received: by 2002:a05:6402:2102:b0:698:aa8c:c162 with SMTP id
 4fb4d7f45d1cf-69ab44abbdemr3487265a12.23.1783623459762; Thu, 09 Jul 2026
 11:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260706105111.2018334-1-vjardin@free.fr>
 <20260706105111.2018334-7-vjardin@free.fr>
In-Reply-To: <20260706105111.2018334-7-vjardin@free.fr>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:57:25 -0600
X-Gm-Features: AUfX_mx9DnaEMRTf2tsDpDgesHiS_6WpqSUgrnxbS3dsUcO1Nha4ftjSa2XjTFE
Message-ID: <CAFLszTjL3srT4fgOhnPGizxX9Wmo8awZ4vf-3CJJ84ozpY82Jw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] test: dm: pmbus: add a sandbox PMBus chip emulator
To: vjardin@free.fr
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Vincent,

On 2026-07-06T10:50:51, Vincent Jardin <vjardin@free.fr> wrote:
> test: dm: pmbus: add a sandbox PMBus chip emulator
>
> Add a UCLASS_I2C_EMUL driver that emulates a PMBus 1.x compliant chip
> behind the sandbox I2C bus, plus the test.dts wiring and sandbox
> defconfig that bind it to the generic PMBus regulator
> (compatible = 'pmbus'). This design is a stub only: it lets the
> follow-up dm unit test drive lib/pmbus.c, the generic regulator and
> the pmbus CLI command with no real hardware.
>
> The emulator models a flat per-command 16-bit register file and the
> three identification block strings (MFR_ID / MFR_MODEL /
> MFR_REVISION). READ_IIN and READ_POUT are deliberately left
> unimplemented (the chip NAKs them) so the telemetry printer's
> "(not supported)" path is exercised, mirroring a real buck that only
> calibrates a subset of the sensor classes.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
>
> MAINTAINERS                             |   1 +
>  arch/sandbox/dts/test.dts               |  10 ++
>  configs/sandbox_defconfig               |   6 ++
>  drivers/power/regulator/Kconfig         |  10 ++
>  drivers/power/regulator/Makefile        |   1 +
>  drivers/power/regulator/sandbox_pmbus.c | 160 ++++++++++++++++++++++++++++++++
>  6 files changed, 188 insertions(+)

> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> @@ -395,3 +395,9 @@ CONFIG_UTHREAD=y
>  CONFIG_UNIT_TEST=y
>  CONFIG_UT_TIME=y
>  CONFIG_UT_DM=y
> +CONFIG_PMBUS=y
> +CONFIG_CMD_PMBUS=y
> +CONFIG_DM_REGULATOR_PMBUS_HELPER=y
> +CONFIG_DM_REGULATOR_PMBUS_GENERIC=y
> +CONFIG_SANDBOX_PMBUS=y
> +CONFIG_PMBUS_THERMAL=y

Please run 'make sandbox_defconfig savedefconfig' and copy the result
back - these are appended rather than merged into Kconfig order. Tom
does this sync from time to time, but having it approximately right
will simplify that.

> diff --git a/drivers/power/regulator/sandbox_pmbus.c b/drivers/power/regulator/sandbox_pmbus.c
> @@ -0,0 +1,160 @@
> +static int sandbox_pmbus_read(struct sandbox_pmbus_priv *priv, u8 cmd,
> +                           u8 *buf, int len)
> +{
> +     const char *str = pmbus_emul_string(cmd);
> +     int i;
> +
> +     if (str) {
> +             int slen = strlen(str);
> +
> +             /* Block payload: [length][bytes...]. */
> +             buf[0] = (u8)slen;
> +             for (i = 1; i < len; i++)
> +                     buf[i] = (i - 1 < slen) ? (u8)str[i - 1] : 0;
> +             return 0;
> +     }

Two things. Please guard buf[0] with 'if (len < 1) return -EINVAL;' so
a zero-length block read cannot walk off the buffer. Also, if a caller
asks for fewer bytes than slen + 1 you still report the full length in
buf[0] but return a truncated payload; either cap slen to len - 1 or
reject the short read, otherwise the length byte lies.

> diff --git a/drivers/power/regulator/sandbox_pmbus.c b/drivers/power/regulator/sandbox_pmbus.c
> @@ -0,0 +1,160 @@
> +     sandbox_pmbus_support(priv, PMBUS_CAPABILITY, 0xb0);

CAPABILITY 0xb0 advertises PEC (bit 7) and SMBALERT#, but the emulator
does not implement PEC. Please either drop the PEC bit or add a
comment noting the emulator is deliberately lying about it.

With those fixed:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
