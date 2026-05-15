Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19441CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C33F847C5;
	Fri, 15 May 2026 20:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YdTUGXfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7632784849; Fri, 15 May 2026 20:27:43 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30FF846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67be41d5eeeso265225a12.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869660; cv=none;
 d=google.com; s=arc-20240605;
 b=TKx5eLK1CD9wsfnOkwF6J5yVHTfUAcKSvHtno4EcULrAC87XgNvR9yc3Nzv4k8LPjJ
 gDvbEBGc2BDXF65XUsUyEEoIFmB8O+cWn4HA1QnIBQjoRXMBA4/FqHapkd/WrIZuqTEp
 IwUgY4oJwrx/uW8r2R5tTfs5uBbXi8caEemgUCe1P4iaIoTW5NLQeKNadXupizdHEIA0
 Qcg4z6+xkBnruE15b6UYDa7j719o+B0mIh3QISTsuvMCm0jQ3NYa5LOiJ15yerfLjZex
 7Pi3zk9xyqemwD7W49vsClzL29vhyC93xrOGjqWa+5JTe4R2qlFpR9fB93PAb30dzWdM
 cBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z7Tdh4wqQ/qq43xzVA5BNCacfPMqPi8z+NiVSc+1m0M=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=Ow4j2L6wez2yGMLy0Kxdl/hdlFe/YEqiNprWIYxau3CDrznXAQ9OzzEHMawXjfubVh
 r1GLBbGxGef8fb9EIJR8Z/jvhMhAl5ZxtY0Z51Pim4ZeoFa/buCAwdC0SqmI8rTzbiom
 VZJcpYjwUWqQbgisLQsVVGB6LXhGuJSvo8M3faFoXcFpqY90hsi6retZ3SXpjh5hK+1I
 aJvv2Nyh+1bRwaz+XLVQB+hj7fQ1SNkptOoDXR4qYq0IFYxJDHe/tnxH9bhZrmVaATlD
 4fzVe9JRQeOmOOpO44CsA8K+JxGBNIqbyaqPSz0haplZofQ7DujBEJKmDClwBfO0O9en
 4Cbg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869660; x=1779474460; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7Tdh4wqQ/qq43xzVA5BNCacfPMqPi8z+NiVSc+1m0M=;
 b=YdTUGXfq1Crp7jj8fZGbPvJt3h7c82er2Q8+mm7MUGI6BcxWXU7HFSXkx4Kd6AyWZ8
 9h+MNRDO2bxyTiQmW0Tl1u9CYa60fChXq+0nEbgLH8iMjg5QJgzszaHXC8G3YuiBF3Mi
 leguPVVLcm0ngkfm3dNDxr3DWq/ASE6MVHACw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869660; x=1779474460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z7Tdh4wqQ/qq43xzVA5BNCacfPMqPi8z+NiVSc+1m0M=;
 b=OAlh2N48F3ACxFjYRGDqS0qdDMJfP4EUEAOoCODQt9npg1XprUKpexlo/N+HFuA+dQ
 iFf7rr/AHVovJxlnvW3h+sS+r5XEHliEkqAJeCtdYF2AfM90ufSZCrNkc35ACVZddpGE
 O8SEQeksDsgpRs1fsqPqQpWtMDXki1AgZAckWoxKxMoVDwcpnw7Xz0wPpd65jgYVuO/P
 18HYYpugr4xxF9Uw8BWKgdW+FdH5teI1tF2q1Hwp0zvuiZq3Om8kIIoqNGrVCY6ig2CE
 ccXX32fqzWosqa8r5fRSOxBPA/WDUOwIdUXa0B9A/mF/qmweXzG1OnlRuWnJkpckd2/M
 roqQ==
X-Gm-Message-State: AOJu0YyIrIIQPmAyiNxbYrzGqs+8IKruQiUndnSx0Ox1+RrpTz6DB4fU
 yx2HM5nFzLC95VVocG5M60b5S/890KqKglz7B4rYb0N9FwMbWp3Q5EpK71mc6/a7jbbSwLxNtEY
 zDdfnYdkKUmPJFBDvjxHHQGkQHEZiERIbikSy7v9yiD9V/Q999RYABg==
X-Gm-Gg: Acq92OFRUUoGiyxWpd++7sI/ruEVsKkEElUSUOkNO1Jwexw+CNpcWm4Kc7Y3uWehUCP
 A+o9wGe47Rsck1jrk2ahR/6TDT+GapXu75Gp6xC7oPeQ4fhLAtVgQI56y3uxALaE6lOJZ5NITrt
 MsNrxYl448p+SCoW5UT1KnifwjPm23eu4T2YsYO3uQxqhfqNMXumKUSRYZHFljew1MLbGOK0mF/
 T24jo2OyMixhQPrdQpenvrwdKTJluMI3kBaAKeXtA0P8EFFv832ghQQcbWM18iENJbf2/233aZ1
 564F5Q==
X-Received: by 2002:a17:907:3e9d:b0:bce:6d1e:501 with SMTP id
 a640c23a62f3a-bd51777b3e7mr299578466b.6.1778869660335; Fri, 15 May 2026
 11:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-10-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-10-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:27:27 -0600
X-Gm-Features: AVHnY4IKitXGJ1PN6_Y_K54o7n7UEwXumgebpXXLU50-zeqs0IozLastuzQKvfs
Message-ID: <CAFLszTh0GpA2WXAVL90QmM1Ta-uHPcaH6WOx+revrp3WQ03o6A@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] test: dm: add sandbox FF-A runtime transport
 tests
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Harsimran,

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> test: dm: add sandbox FF-A runtime transport tests
>
> Exercise FF-A runtime helpers via sandbox DM tests
>
> Test the successful runtime direct-message round trip and the invalid
> destination-partition case, using the shared FF-A prepare step so the
> sandbox emulator has initialized partition state before exercising the
> runtime-only messaging helpers.
> Add a dedicated no-context test that calls
> ffa_sync_send_receive_runtime() before enabling the runtime context and
> checks that it returns -EPERM. Reset the resident FF-A runtime context
> around the transport tests so the runtime flag and private data do not
> leak across test cases.
> Split the ffa_to_std_errno() checks into a separate DM test so
> error-mapping regressions are reported independently from transport
> failures. Cover both the valid mappings and the boundary inputs that
> must return -EINVAL.
>
> Replace the hard-coded synthetic partition execution-context and
> property values in ffa-emul-uclass.c with the shared
> [...]
>
> arch/sandbox/include/asm/sandbox_arm_ffa.h |  16 +++-
>  drivers/firmware/arm-ffa/ffa-emul-uclass.c |  36 +++++---
>  test/dm/Makefile                           |   3 +-
>  test/dm/ffa_runtime.c                      | 129 +++++++++++++++++++++++=
++++++
>  4 files changed, 172 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> @@ -0,0 +1,129 @@
> +static int dm_test_ffa_to_std_errno(struct unit_test_state *uts)
> +{
> +     (void)uts;
> +
> +     ut_asserteq(-EINVAL, ffa_to_std_errno(0));

(void)uts is incorrect - uts is used by the ut_asserteq() macro
expansions. Please drop it.

> diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> @@ -0,0 +1,129 @@
> +     ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
> +             .id =3D NS_PHYS_ENDPOINT_ID,
> +     });
> +     ffa_enable_runtime_context();

Twice you do reset + prepare + copy + enable + assert + reset. Please
pull this into a small helper (e.g. ffa_runtime_setup()) with matching
teardown, so the two tests can't drift and a failed assertion mid-test
doesn't leak the runtime flag into later tests.

> diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> @@ -0,0 +1,129 @@
> +     /* Invalid partition IDs must be rejected and mapped to -EINVAL */
> +     ut_asserteq(-EINVAL, ffa_sync_send_receive_runtime(0, &msg, true));

Just to clarify, this works because NS_PHYS_ENDPOINT_ID happens to be
0, so the emulator's self-ID check trips first rather than the SP
validity check. Please pick a clearly-invalid partition ID (e.g.
0xffff) so the test exercises the intended rejection path.

> diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmwar=
e/arm-ffa/ffa-emul-uclass.c
> @@ -19,41 +19,57 @@
>  /* The partitions (SPs) table */
>  static struct ffa_partition_desc sandbox_partitions[SANDBOX_PARTITIONS_C=
NT] =3D {
>       {
> -             .info =3D { .id =3D SANDBOX_SP1_ID, .exec_ctxt =3D 0x5687, =
.properties =3D 0x89325621 },
> +             .info =3D {
> +                     .id =3D SANDBOX_SP1_ID,
> +                     .exec_ctxt =3D SANDBOX_SP1_EXEC_CTXT,
> +                     .properties =3D SANDBOX_SP1_PROPERTIES,
> +             },

This refactor (lifting exec_ctxt/properties into SANDBOX_SP*_EXEC_CTXT
/ SANDBOX_SP*_PROPERTIES) is unrelated to the runtime tests - none of
the new tests reference these macros. Please split it into a
preparatory patch.

> diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmwar=
e/arm-ffa/ffa-emul-uclass.c
> @@ -19,41 +19,57 @@
> -             }
> -     }
> +             },
> +     },
>
>  };

Stray blank line between the last entry and the closing }; =E2=80=94 while =
you
are reflowing this table, please drop it.

Regards,
Simon
