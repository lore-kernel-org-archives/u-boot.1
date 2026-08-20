Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E53AC5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C537760787;
	Thu, 20 Aug 2026 12:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w_TSymO6fUqI; Thu, 20 Aug 2026 12:13:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787227991;
	bh=82aaV9NUmEDSpEeY9zDMWfl2Getv16I0jWq4MhUlf9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w1T1ALcl1UwGHNk/5o5xuGdtPWGQN5/wIV3DP/b/CF4qz4xjLKON5Hdyor9L/JUFO
	 1xVJ3quWEL/qocxUIC9ZX8YETNbDOvyfGSdYmvIgfQnSwuR1n4qFKim7OmYtXeJ5aA
	 PhTPBsoxTyJ6Jc4wfqFhG0k8ElBcOf7tnkRIbt5zJJLdkyKgJIZhHa756hiMI5gdgy
	 QLRyV93B51pGKtiuFha61LX5baHbp+YAOrAtLsN5/q//+cpdl98V7yNy3PcZMt+kpj
	 1BxsFf8wt/F1rPSABLSOyyvmmVw+3nOdygoD/f9xEm2vnGQNwNkF4ne41I8NHbn3Lb
	 XhfEYebFb3G9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F32CD607A5;
	Thu, 20 Aug 2026 12:13:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B56739E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D69D80CD8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Kj7Bl-ScLuz for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:13:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Gz4IxlGA
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 145EC80CD3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:07 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so3766281a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787227986; cv=none;
 d=google.com; s=arc-20260327;
 b=Hv4mH0yCcpN1og3PXF81rbD3WGoXnwHYHKzvhSHN774xLUFAGD+wIOSg2tQ5s6TGxz
 cAw06RLBEbuWWNVg2H1mUqdVGXZV8HJgSS/kOa+7eAPVWAeECudicpX+opbWGp0yIvwe
 v7+EB0jh0EiAJDejabVoDZgSXaDz8qLADXWW2RmIgYejmBurfbn0IvuisGvQL2BMbDVf
 RoXD8teh6mFzjQNcRo1V+KeKRkRy/SPlygUklBt7MdlUgor/OlAkE0/ULWohTyibQuiG
 i5m7AwRaQA6p43R2+sMXQ22KdYnkT0fZyh0xxPCssCfOsUyo0dGVfe5qMcVd7eAwudIL
 tyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=82aaV9NUmEDSpEeY9zDMWfl2Getv16I0jWq4MhUlf9w=;
 fh=Bwjok4jWsPwFzEPPOJOguv26ANoKPtuv9PCfDq8ap3w=;
 b=WrVa4gzB3gUgbXCdB1dIa2Pm1mMwe4e2PyxJmJ3HstqJohzSmZzKy4Sh36Me2x90Uu
 ELNn8WFex2CvH5PgW0tK3Q8gKpKAWFYAchPK8WVm4+aW+TMlB85LB3F6DGeTV+gbzZb2
 ouuTp4Cq/8V4T6y5BPp++4+1EEfblsS5EbeTnucvKoVuew0nIASG0ZUddsX+Nyx1i0Vb
 11LeoWUu3QiiB9wt54GzAtozjofFHRkm3eP9z7/S+CY7dzdimHnQ8Hkh2nT7gJglNL+j
 zTb87whjQGhJYeU4OyUzyBrbN6YoHRRtqlhCzKv/9jcCfvm6YcUBefZTVVoAInTrKF/0
 8X4g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787227986; x=1787832786;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=82aaV9NUmEDSpEeY9zDMWfl2Getv16I0jWq4MhUlf9w=;
 b=Gz4IxlGA3n/Su6fAeS596r++dfCMlyq/oH/bj72hjQUHv+JQUlXNxtSQEHXo4Tz6AW
 bEjqpW7HmzJtoxGuAidDM7nIZz+G1ulkJfYy2Pw2tzDammvbU8TK3f4UcN2HlKkcSYja
 6VzZHk7/S1xq1OkUGmlZy5qq/dPEoi8AiA710=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787227986; x=1787832786;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=82aaV9NUmEDSpEeY9zDMWfl2Getv16I0jWq4MhUlf9w=;
 b=RNfMu2nz0ix1XxgYHGQFfF3XxNCkMAvrnPBxW66irI7y5jh2rmSGILHhCeHsWpi1nA
 1uwjefmp/gYGADjqAB8LXadyNTmoTKIenuvAB4iAimrk73zHx/cp8TK3j4JRiyvf5KJU
 ln0sDqucqNSgDtt5epQFVFjMAQvURXyo/Ne1WtmaoKUm2UFpfqn+FZyblUMkdutdLnvj
 Dpg4wx9ITccbDbBVOFSZ85JDoCW00qVK/DDwEPwGl4a4BVTDt3Fsxo29knCSxrTMvN0L
 AGwBxYch40Ev3hsSZtf06LM4mF6pJpWQd4gpplkW055umge0rpwSE55h+lcq72LQj5SF
 2hCg==
X-Gm-Message-State: AOJu0Yw47z/SxARIgiF243wmn8GY9GkIMp89ToA/TrRNOhapzRj+9L9w
 eanWAy9GAHSkRAvXHrOX9+MgzwI0lb4Y2a6n6sg82sDw+ubaReSqsv6E6T5xdhSm7clUUkFurz0
 G34eHCxvEt4/g7FiDXuTR6N/LbSRy0auLjPdaY+mZ
X-Gm-Gg: AR+sD11vGGXGsihpThTWEp8/9+AzpS7pajJ5VnpnfsBjFQGNrGOHU5KhUbbvKtbuqKq
 IBvG9tRZl8Xa3CwLHuA93+Tlcdu+uh1wlgxmKWWikB14OAbrgA/b64+cm78vkuRowIAbfNY4iaR
 1kK0+QnZvcnQleck/XtbMNytm6e1WWems/QmrvQN6Zx8Cd2AvwxtRaDjZ94tBcsbI3r4LyxqvhU
 ehTMp0BF2uAoE4xsP+rKsBkvPn/BIl/ohgkvdaKMxIRGB5v+BCualJV3WcvJqQPjt6fQ4suQVX0
 2qJCQzlC6efsAtSyiw3yYP+dHh5Z18+eCiwv+LrG5kuuJBkz
X-Received: by 2002:a17:907:d50d:b0:c1c:4858:c19c with SMTP id
 a640c23a62f3a-c242e388e87mr904166466b.23.1787227960475; Thu, 20 Aug 2026
 05:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
 <20260811-b4-reset-edl-rebootmode-v1-3-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-3-2e15adc156a3@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:12:25 -0600
X-Gm-Features: AcwNN1UyLBEw8KumfOeRuxFTmvXdvCHHFcmRm8l1m_XG8tAHuQHc0W5mWK7pfuo
Message-ID: <CAFLszTgqWk11Zi6a9_CjFRhY1Pi4FPc-rGCno5wUaNF9FUgUDg@mail.gmail.com>
Subject: Re: [PATCH 3/8] reboot-mode: add PSCI reboot-mode driver
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Balaji,

On 2026-08-11T05:18:35, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> reboot-mode: add PSCI reboot-mode driver
>
> Add a PSCI backend for the reboot-mode framework that triggers a
> SYSTEM_RESET2 vendor-specific reset described by a "mode-*" property under
> a "reboot-mode" subnode of the PSCI device tree node (for example
> "mode-edl = <0x80000000 0x00000001>" to enter Qualcomm EDL/download mode).
>
> All device tree parsing and name matching already live in the reboot-mode
> uclass; this driver only turns a decoded set of magic cells into a
> firmware call.
>
> U-Boot's psci_system_reset2() client takes only a 32-bit cookie and ORs in
> PSCI_RESET2_TYPE_VENDOR itself, so the trigger folds the low cells into a
> cookie and rejects a 3-cell mode whose cookie_hi is non-zero rather than
> silently truncating it.
>
> psci_bind() binds the driver to the "reboot-mode" subnode when
> CONFIG_REBOOT_MODE_PSCI is enabled, using device_bind_driver_to_node().
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> drivers/firmware/psci.c                | 16 ++++++++++
>  drivers/reboot-mode/Kconfig            | 11 +++++++
>  drivers/reboot-mode/Makefile           |  1 +
>  drivers/reboot-mode/reboot-mode-psci.c | 58 ++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+)

> diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
> @@ -39,4 +39,15 @@ config REBOOT_MODE_NVMEM
> +config REBOOT_MODE_PSCI
> +     bool "Use PSCI SYSTEM_RESET2 vendor resets as reboot modes"
> +     depends on DM_REBOOT_MODE && ARM_SMCCC

psci_features() and psci_system_reset2() only exist for ARM64 -
fwcall.c lives under arch/arm/cpu/armv8, and the prototypes in
asm/system.h are inside the CONFIG_ARM64 block. ARM_SMCCC is available
on CPU_V7A too, so as written this can be enabled on a 32-bit ARM
build and then fail to link. Please add 'depends on ARM64' (or gate on
the appropriate ARMv8 PSCI symbol).

> diff --git a/drivers/reboot-mode/reboot-mode-psci.c b/drivers/reboot-mode/reboot-mode-psci.c
> @@ -0,0 +1,58 @@
> +     u32 reset_type = magic[0];
> +     u64 cookie = 0;
> +     int i;
> +
> +     if (count < 1 || count > REBOOT_MODE_MAX_MAGIC)
> +             return -EINVAL;
> +
> +     /*
> +      * U-Boot's psci_system_reset2() takes only a 32-bit cookie, whereas
> +      * the binding allows a 64-bit cookie in the 3-cell form (magic[1] is
> +      * cookie_hi, magic[2] is cookie_lo). Reject a non-zero high half
> +      * rather than silently truncating it.
> +      */
> +     if (count == REBOOT_MODE_MAX_MAGIC && magic[1]) {
> +             dev_err(dev, "64-bit reset cookie is not supported\n");
> +             return -EINVAL;
> +     }
> +
> +     for (i = 1; i < count; i++)
> +             cookie = (cookie << 32) | magic[i];

Given that magic[1] is guaranteed to be zero in the 3-cell case and
the value is immediately truncated to u32 at the call site, the u64
shift/OR loop is misleading - it looks like it is assembling a real
64-bit cookie when it never can. Please make cookie a u32 and pick it
directly, e.g.

    u32 cookie = 0;

    if (count >= 2)
        cookie = magic[count - 1];

That also removes the need for the loop variable and the cast on the call.

> diff --git a/drivers/reboot-mode/reboot-mode-psci.c b/drivers/reboot-mode/reboot-mode-psci.c
> @@ -0,0 +1,58 @@
> +     /* Does not return on success. */
> +     psci_system_reset2(reset_type, (u32)cookie);
> +
> +     return -EINPROGRESS;
> +}

psci_system_reset2() is declared __noreturn in asm/system.h and ends
in a while(1), so the return statement is unreachable. I doubt you can
remove this 'return' though?

> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> @@ -188,6 +188,22 @@ static int psci_bind(struct udevice *dev)
> +     if (CONFIG_IS_ENABLED(REBOOT_MODE_PSCI)) {
> +             ofnode rm_node = ofnode_find_subnode(dev_ofnode(dev),
> +                                                  "reboot-mode");
> +
> +             if (ofnode_valid(rm_node) &&
> +                 device_bind_driver_to_node(dev, "reboot-mode-psci",
> +                                            "reboot-mode-psci", rm_node,
> +                                            NULL))
> +                     pr_warn("PSCI reboot-mode was not bound.\n");
> +     }

Shouldn't we be checking errors here?

SYSTEM_RESET2 arrived in PSCI 1.1, but this bind runs for any PSCI
node (including the 0.2/1.0 block just above, which only binds the
sysreset driver conditionally). The runtime psci_features() check will
catch missing support, but consider gating the bind on 'arm,psci-1.1'
compat to avoid a warning on older PSCI DTs when the config happens to
be enabled. Worth a comment either way.

Regards,
Simon
