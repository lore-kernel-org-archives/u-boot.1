Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FBDC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8B984B1E;
	Mon, 13 Jul 2026 14:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SGcpIszS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56A1684AE7; Mon, 13 Jul 2026 14:58:54 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D0F84B27
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso6870720a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783947531; cv=none;
 d=google.com; s=arc-20260327;
 b=BoQ9Ct35O7V3uSfvTJNdKj2ZfCg8S2UtNP1ug/jFfcHn7KoP3EAGzP2xfg/dU9B3db
 B+0JfrBEJ+PaocYOEEds6S9Pf7zJirV8Zfp9BTI5xWXDsLZU7uN8Qm3fxeosx+InRAll
 NTsyJDoSBXyzVRjL6fskPFv+tavV+bzp7vtq6MZbI1RmWcpRLtOqtGUPuteoEeDndh+Z
 /InCLMTEWQ2bH/4trvCD+SjnlWXmdSeHyGNk8L/DWE3R/2RcvXXpLWADHPggdV1FganI
 A4TqX/+h4opoS5Vz/yum5GGDBHYuiZFjMe8W4hOafUQ26K+9Z5L8LeRuwppf8Z1/kQmI
 52hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Mmxf5IYRmkffouxrxOdtgadRTXDrV0+CB22GvTCzNis=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=N8wJpciyXFmmKR9NdsEtVf9oA3eP0GOscZaH8LNgbb1KbCYVpsvk8CnPHDiVJxHb0H
 Xi1aM2oTGOVWsPrlJwTjEuzCIiRk5eKjeTjhhb3sYyoxYcPsRAitWC1wfKRypX3zFPW4
 3IPhZx5s30++JrY4BoIqNnP1KV09J/7iqVIcgAHRsufPk1S0dLDZAlfc5yETb2/bYz4Q
 LPyoPiA8JJ367YgdCjdcS2WsuuLPMsQF3H7mBATcbC9kpKDijojfk1IAJp1snFsKjmRn
 tkZVDYCsxqjtCjVY+h66CxpEjuOX8ukVMFD1RV0araj3VmYRfLr2AGbq3bFczzZfODcU
 pREA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783947531; x=1784552331; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mmxf5IYRmkffouxrxOdtgadRTXDrV0+CB22GvTCzNis=;
 b=SGcpIszSDxtl+aXoE1XsuuLQoWp/tM+oKz62rQMnpwd3OP2C2bbE1MlRy1w7OgdPXm
 tlN015biYx9B5rmgnXoBBAiEFOW+9usaB0h8MsSPaWGZEFDFCSDC0ed2cg592MLRfCVX
 YdclK7d3UbuqM23YBOcVadX1tI+qYdPOyiu5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947531; x=1784552331;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Mmxf5IYRmkffouxrxOdtgadRTXDrV0+CB22GvTCzNis=;
 b=Wrx35wTPlAGzzrKg98ccoJJebmDGV6OVazo+krLzr/1eRicrqDw8Xkr5pXVvIKbPG6
 fG6H8F/A2S0AHcpxU7pLyqn5XmfpAHw6pQqXd0qEVlfPQyCmXbyytgvuwqTaA8TtIPBq
 VVPnvQiTeHWcu03Oc9gizUYofEJnXO4CEFPRCTyJAD34v8kg4NddpAyVYMvXqV6+jLts
 0Oy1LF438NWQ5tZwwL73Yp4wmGEvNyFrqRKL6ECk5kP2JitQCGwAOZtdb2Ph0X6XMqfj
 Q9X043sb6Ny/13rZ6OKWxINQC+grQvMUVpFavcfdOdJ2drEF3tr8L3DdxzTFgOTFiZki
 sqkQ==
X-Gm-Message-State: AOJu0YwqL7GTnnyo0NZAmTEOZpqeERe+Ul9KyGVyIH3stp7v6Lwxpz5r
 fJGp9xAteiOELtELyjGDW83bLUspr+9wedGD/Zk2wmknv6Llu/Y4jAvp23YTHwlk9RClhlnNbbF
 FMKY2E93QrI47sPS9j2XN650j94ebyq4aP5UjfJZe
X-Gm-Gg: AfdE7cnfPk213dLTI2mKsY83KXqBSNX0l1yW6EByR2NMJhMAF/PIi60OQ+23a1d+0t1
 z0J1/RZuCd04AnFiDj34w9F12o2zpJl4f5ZoqBAdEMYU+AN60ddfq8rGdUHKgg/2rcaT/OGWHe1
 /I+i1ZttXVLGpxvI5aL55oyvBpFveoJEnsi6PdEByHgQOK5Ku9I0xRaXeU37wqQcabfqsguaWec
 qcS/1PNdfdpcsaucPBIg00a7IPKV6wPlw3WwYV9EDk+OKWvZ64qnCfLeqJN9K6pQs3C28w=
X-Received: by 2002:a05:6402:2683:b0:69a:9355:d1c7 with SMTP id
 4fb4d7f45d1cf-69c5f24e53amr3686890a12.41.1783947531436; Mon, 13 Jul 2026
 05:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260710163706.2827580-1-trini@konsulko.com>
In-Reply-To: <20260710163706.2827580-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 06:58:39 -0600
X-Gm-Features: AUfX_mz84dseNSzfj_OFHVGey9k6FCEiyLNAQeA8cqRwwheO5MEQmxhuEibPNW8
Message-ID: <CAFLszTgRuBmPTU1EYFM7DAZzJdsWpU31mkUG8Z=vVZ62on0dVA@mail.gmail.com>
Subject: Re: [PATCH] Gitlab CI: Switch to git.u-boot-project.org
To: Tom Rini <trini@konsulko.com>
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

On Fri, 10 Jul 2026 at 10:37, Tom Rini <trini@konsulko.com> wrote:
>
> Now that we have everything available on git.u-boot-project.org, switch
> URLs to that location.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> As part of the migration from source.denx.de to git.u-boot-project.org
> we need to switch CI over. I plan to apply this, and continue to pushing
> to source.denx.de, on Monday. The switch over date will be handled
> separately.
> ---
>  .gitlab-ci-sage-lab.yml | 2 +-
>  .gitlab-ci.yml          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
> index e2f368486047..90f97696f86c 100644
> --- a/.gitlab-ci-sage-lab.yml
> +++ b/.gitlab-ci-sage-lab.yml
> @@ -16,7 +16,7 @@
>    before_script:
>      # Clone uboot-test-hooks
>      - git config --global --add safe.directory "${CI_PROJECT_DIR}"
> -    - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
> +    - git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
>      - ln -s sage /tmp/uboot-test-hooks/bin/`hostname`
>      - ln -s sage /tmp/uboot-test-hooks/py/`hostname`
>      - export LG_ENV="/tmp/uboot-test-hooks/bin/sage/labgrid-sage-env.yaml";
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 245e422d72fa..79f2af2cccf5 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -36,7 +36,7 @@ stages:
>    before_script:
>      # Clone uboot-test-hooks
>      - git config --global --add safe.directory "${CI_PROJECT_DIR}"
> -    - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
> +    - git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
>      # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
>      # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
>      - ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
> --
> 2.43.0
>
