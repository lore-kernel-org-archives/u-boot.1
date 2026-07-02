Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F954C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 19:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E5F848BF;
	Thu,  2 Jul 2026 21:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hFJ8p+Fx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A1E848F3; Thu,  2 Jul 2026 21:22:37 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84A684857
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 21:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6989c0ec3c5so3927856a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 12:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783020154; cv=none;
 d=google.com; s=arc-20260327;
 b=HKxR1k9+Byc5OeQ47FpKo1wASkJPwgkBeUpVh3b98kCbR7c/oaUWpBSW5s5rivmZO2
 zgJYQW4UPU5shn6qXzL0w+PFtCk6By8J607RiPsVldrRWRYVO53bqO7xqXEmDyhHG895
 vtn9nelGDovpepEAVlGtTGpOUevtViozxsndRUVgpy1ZVqbUBC1ZM8050eK0iVm3bUjG
 Dzxlqib7/EmNL2NQRenmOK9eUF+PF8kMMpBpMbm657xk3pkQMhcRcrJeBRPwrNbPtLDk
 hUY64WVQ8YdONJGRIFRD/iJUAqz/02v8HXDKTDxnXxYBSx2illXaqXTC7na2k7+seFPm
 6l5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Gfyq95RY59kCfZq/FSzBsc7iVUiZEa3AG28zmV6amcQ=;
 fh=Eevq1XmMZbnSOBE3e9BDfyHvcewPP/nMCv3AnLu6PoM=;
 b=okA6CQsNsaZdikdHFGH84WnkFwdW0YymX684IV+ABFDXdX/zp7N8nUVnd1ehUm61kV
 ucqp0tjbaH2JoKOekLB0wd4YfVW4CMFHGwqgvEc3jbMHTa6pmiviM0ReC8EAUAR/dOan
 4gqJb6pCCharEp1d3oJUQuucRC3HYQ7YirLWmffVCF6VWDzHOUETOkphhH/b2DNzP8xg
 Mgl8UG3X0DCzquejttXVvtivOW1vHvV/vVAgAT8MPNadA4pxhd6/QX65NuH3qrHipJIQ
 R0D0/f5jzoXyDHi4jjDfOTxYUb9B01ij73Uz6iIXlOJoAAyy/3oH7PVab7unow0VAav/
 +1Dw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783020154; x=1783624954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gfyq95RY59kCfZq/FSzBsc7iVUiZEa3AG28zmV6amcQ=;
 b=hFJ8p+FxB2Hlq4iz6V9v2JDw2zdu8xd26rcokXDnf/TohYvGtGdFY7qGxgScmnT0UL
 6ZUA09G5UzyGM7SblsX3Sx/qhbv9f6On6BwwCsnFrMefjz7P2CWS/rhyLlD3iX7WgYbk
 JqEeC4xcTH2oFdFwhGTQo8KiDj3oegfN/CORg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783020154; x=1783624954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gfyq95RY59kCfZq/FSzBsc7iVUiZEa3AG28zmV6amcQ=;
 b=ooG1gbTkzlHaSak9gqwdbzJ+GVFjVmRD0Sh9ZBOwZScCKN72nlgKEvuTrckOK+Oq8h
 IOVhKtwKzp+NIB8IdBIWwaLrEXdAriyflrn/3/U3tZw+I26vSs4XTQ9ZBDtAts1Uovjj
 Yn+/a4+XC3KeE9JjIC/QXQqEMeNNtV0Hr7lkrus7vo334HaJJM+r08NhQJmMyzmWuEWy
 6CbFanFoyGLOF08uYrElGCOI3f6j3BjkAtbaYfWMaCXQ1hXdf8Jw3ZFnGdC0oGtR9dlv
 nI4E6q7ll1Zt4lzodFqmQPUpM3HHraO4e/pPdSL1MA0W4z+y2kR/Tl1pP0/McfHygwb6
 /b6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rof0vo8Mz1iQ9zIQbijFWYW09X6K70yYZPfI79sKtw/MMyA7pN7tI2npzK5zF3oVcmDmhWcVHM=@lists.denx.de
X-Gm-Message-State: AOJu0YyreYMas5m8pjUHT7TrbfbI4+JMESK1UascOusVquctcORXkalm
 uXisGwCIaXp5GiS3BsrtC9phHdJitaWfBP7aIPafiJ6oUlsnIcTkvAXEYGx5KMFE2xn0CK8Ts4B
 bQo/WdSuGe/NqfiU2yX7wCcj1G7Vmij6uefV4ouyw
X-Gm-Gg: AfdE7cnJNLJ9GQI/kidV422ZIpVE8zuf8R1nQXCQX6m2tMT15n1KM8773uCIeEhviPd
 /fppuuD5xwCI1Mx6AOuZb7MVtf7UHnxi1XxXuEypefNRe4q5UUNVJh9cbxL06nmvlBt+hooGW5E
 x1hwLyBdkjXU6VvbJDzd8reZb3dLhyZ9Cwd6RFEwRkUWZzBwQ7NMJ3S2800XyFhejoP1VFbmSrn
 xHeJ1xRa/0I0Wp79q1EL7IM3yzmoTgCmdjdhLWpOneXdNGjl9fBdvU60KKR1unsVQ7Zp+afMQ==
X-Received: by 2002:a05:6402:13cc:b0:698:b8a0:d413 with SMTP id
 4fb4d7f45d1cf-698b8a0d565mr1360879a12.12.1783020154215; Thu, 02 Jul 2026
 12:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
In-Reply-To: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 20:22:22 +0100
X-Gm-Features: AVVi8CcNPEIi195gEa0aEnc86ct6kJnqgseOsnPyadZkt71dm32mqmjrnQ2rJhk
Message-ID: <CAFLszTjZZMpu=2qEUgPSfnYBuj3uSvvcSf3NTvy_6keuYh42hQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] drivers: sysreset: revert support for args
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On Thu, 2 Jul 2026 at 19:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> The args support for the sysreset uclass contains a logic bug. The first
> sysreset device implementing the request_arg callback will consume the
> args, not support the specified arg and thus return -EPROTONOSUPPORT
> which will stop the iteration over all sysreset devices.
>
> This is an issue if one has multiple sysreset devices and each with
> support for different (valid) args. If a sysreset device implements a
> -dummy argument and another -foo and one calls reset -dummy on the
> U-Boot CLI, it'll depend on which sysreset device will be attempted
> first. If it is the one implementing -foo, it'll return it doesn't
> support the argument with -EPROTONOSUPPORT in which case the device
> implementing -dummy will never be attempted and instead we'll do a cold
> reset which is very likely not what's expected.
>
> I suggest to either add an additional return code for the case where the
> sysreset device knows it isn't supposed to handle this argument because
> it isn't among the ones it supports, and thus we try other sysreset
> devices until we find one that says it tried and either is in progress
> or couldn't realize the request, or no sysreset device supports this
> argument and we end up doing a cold reset (but should we even try to do
> a cold reset if the type of reset requested by the user isn't
> supported?). Or just don't try piggy-backing on the reset command and
> have a new command instead?
>
> Maybe I misunderstood something or misread the code, so please correct
> me if I'm wrong.
>
> We've tried bringing up this issue multiple times over the last
> month[1][2][3] but it seems like we're left on read. This is the last
> resort to get attention on this patches, hopefully we don't have to get
> through a revert a few days before the release though there is only two
> working days left before the release. Sending a revert as requested by
> Tom[4].
>
> I've not even build tested this, only had a cursory look at what to
> revert so maybe I'm missing some patches or breaking stuff up. It's late
> here and I wanted to give a chance to people in Americas to have a look
> at this today, or people in Asia tomorrow morning before I come to the
> office. I don't have time to wait for the CI to complete, but it's
> running here: https://source.denx.de/u-boot/contributors/qschulz/u-boot/-/pipelines/30604
> Yes the commit hash is different, I rewrote this cover letter to include
> the link to the CI pipeline.
>
> [1] https://lore.kernel.org/all/667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de/
> [2] https://lore.kernel.org/all/4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de/
> [3] https://lore.kernel.org/all/20260623165021.GJ382693@bill-the-cat/
> [4] https://lore.kernel.org/all/20260702174613.GC749385@bill-the-cat/
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (6):
>       Revert "qcom_defconfig: enable psci based sysreset"
>       Revert "cmd: boot: fix edl being shown when not supported"
>       Revert "doc: usage: cmd: reset: specify when the -edl option is available"
>       Revert "cmd: boot: Add '-edl' option to reset command documentation"
>       Revert "sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs"
>       Revert "drivers: sysreset: Add sysreset op that can take arguments"
>
>  cmd/boot.c                            |  6 -----
>  configs/qcom_defconfig                |  2 --
>  doc/usage/cmd/reset.rst               | 10 +-------
>  drivers/firmware/psci.c               |  4 ----
>  drivers/sysreset/Kconfig              | 15 ------------
>  drivers/sysreset/Makefile             |  1 -
>  drivers/sysreset/sysreset-uclass.c    | 37 ----------------------------
>  drivers/sysreset/sysreset_qcom-psci.c | 45 -----------------------------------
>  include/sysreset.h                    | 18 --------------
>  9 files changed, 1 insertion(+), 137 deletions(-)
> ---
> base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
> change-id: 20260702-revert-sysreset-4579ae458f2e

Given the timing, I suppose a revert. Apart from what is mentioned
here, passing argc/argv directly from a command to a driver seems
wrong to me, so I think the new series should use a new reset type
instead.

Regards,
SImon

>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
