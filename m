Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32943C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 958E287710;
	Wed, 20 Dec 2023 13:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q50PiJrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C6678772A; Wed, 20 Dec 2023 13:38:25 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD560875FC
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4668765c472so693102137.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703075901; x=1703680701; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d4W4dRnaBM3bam+j1uKaaszxZ/SRpPy2rmw/wXgnbA8=;
 b=q50PiJrONYxsSjIT6iPfYTYJ57TChF5/IaF2H3LfptTrKjFSIW21aSUStybVNGBjd7
 1Xb77SNpp0GgbkMq5TdnRhuUPF2UnZmWV+wc0yJNmHnREYzaiqfPCH0gOqXJ6H83mm/W
 M1syH9GPR+li2jafZX2ycL9ll+QJ5PsffkoapkLVIhIIIxV3xckaiGW3FYOXELzu61Fb
 /NpGUm1gKoiCaIo+rRX8Xyh6I6x+mv+wMNh0MndtqRyUtTba/Fm7pypHmE7hOeENJq15
 5Ts67NMlhBzQOp6gsWHDU7pPWNMNFHwlMUsFKN+4IiYMxH9TQ2eRY8/t3GLAi0esZ3iU
 npQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703075901; x=1703680701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4W4dRnaBM3bam+j1uKaaszxZ/SRpPy2rmw/wXgnbA8=;
 b=bwDIYhcgrUtHa1jxce0mjEGzzmoj/GuWCAz6K4ZvKpp7AuT6vTJG2LiofepWT9u8rA
 BqzyTxxDboEw4+LaM1clz1l5qwUmpJEdX1ZVcTYAKRoX0dy3KSMsRWc99y4rBhIoulxU
 X73fLfZi67Dyn17GmHCbU+zq8Y9Gm2xYQ6+UUCBtY5GPfjuXO1j2ri/B50m1Y3D1kBh4
 /CkX/wNGTcJ7kbQZkKZcxV4wF7YiaT14mga+bxHgQ8uQsP9/d6Xxa+YyAvT9ltd8ovcc
 fhyu7jbR1+hQxTama+DVHSZbhwtUOMAh5ik1VRABS1xVOfLlLQ2IqfyeCIhTPUuCSkZW
 QwAQ==
X-Gm-Message-State: AOJu0Yxh8bDGVRiRuaVzgIvrzZ3js8Whix1v276okd5fU5eYY1RcwyZq
 OcR5TPd1WuDsiDWGOGCPiYWk8miVgFCTnBGfQG6Gvw==
X-Google-Smtp-Source: AGHT+IHkZ9Jn1MCpM7OYAnIaJtCWgB4wzhWhhY3duN+JAPZarPQSbQxpaK0bneJzb2YOlpfOV1sM+zy44ZAsKVmd0xo=
X-Received: by 2002:a05:6102:3a0d:b0:464:4f99:67cd with SMTP id
 b13-20020a0561023a0d00b004644f9967cdmr15297776vsu.25.1703075901497; Wed, 20
 Dec 2023 04:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <9d01918f-a27b-4f52-87d3-674c52547d57@amd.com>
In-Reply-To: <9d01918f-a27b-4f52-87d3-674c52547d57@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 18:08:10 +0530
Message-ID: <CAFA6WYPBnh99je9HyNLx=p6ezCVfs9=atzwL9t1JzVBANSnq1Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Michal Simek <michal.simek@amd.com>, robh+dt@kernel.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
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

On Wed, 20 Dec 2023 at 16:14, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Sumit,
>
> On 12/14/23 14:50, Sumit Garg wrote:
> > Prerquisite
> > -----------
> >
> > This patch series requires devicetree-rebasing git repo to be added as a
> > subtree to the main U-boot repo via:
> >
> > $ git subtree add --prefix devicetree-rebasing \
> >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> >        v6.6-dts --squash
> >
> > Background
> > ----------
> >
> > This effort started while I was reviewing patch series corresponding to
> > Qcom platforms [1] which was about to import modified devicetree source
> > files from Linux kernel. I suppose keeping devicetree files sync with
> > Linux kernel without any DT bindings schema validation has been a pain
> > for U-boot SoC/platform maintainers. There has been past discussions
> > about a single DT repo but that hasn't come up and Linux kernel remained
> > the place where DT source files as well as bindings are placed and
> > maintained.
> >
> > However, Linux kernel DT maintainers proposed [2] for U-boot to rather
> > use devicetree-rebasing repo [3] which is a forked copy from Linux
> > kernel for DT source files as well as bindings. It is tagged at every
> > Linux kernel major release or intermideate release candidates. So here I
> > have tried to reuse that to bring DT bingings compliance as well as a
> > standard way to maintain a regular sync of DT source files with Linux
> > kernel.
> >
> > In order to maintain devicetree files sync, U-boot will maintains a Git
> > subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
> > It will be regularly updated with every new kernel major release via
> > subtree pull as follows::
> >
> > $ git subtree pull --prefix devicetree-rebasing \
> >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> >        <release-tag> --squash
> >
> > The RFC/prototype for this series has been discussed with Linux DT
> > maintainers as well as U-boot maintainers here [4]. Now we would like to
> > reach out to wider U-boot community to seek feedback.
> >
> > [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> > [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> > [4] https://github.com/u-boot/u-boot/pull/451
> >
> > Changes
> > -------
> >
> > Traditionally, U-boot placed copies of devicetree source files from Linux
> > kernel into `arch/<arch>/dts/<name>.dts`, which can be selected via:
> >
> > CONFIG_DEFAULT_DEVICE_TREE "<name>"
> >
> > SoC/board maintainers are encouraged to migrate to using mirrored copies
> > from `devicetree-rebasing/` into `dts/arch/<arch>/<vendor>` via:
> >
> > CONFIG_OF_UPSTREAM=y
> > CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"
> >
> > An example have been shown for Amlogic meson-gxbb SoC and corresponding
> > derived boards via patch #7 and #8.
> >
> > Devicetree bindings schema checks
> > ---------------------------------
> >
> > With devicetee-rebasing Git subtree, the devicetree bindings are also
> > regularly synced with Linux kernel as `devicetree-rebasing/Bindings/`
> > sub-directory. This allows U-boot to run devicetree bindings schema checks
> > which will bring compliance to U-boot core/drivers regarding usage of
> > devicetree.
> >
> > Dependencies
> > ------------
> >
> > The DT schema project must be installed in order to validate the DT schema
> > binding documents and validate DTS files using the DT schema. The DT schema
> > project can be installed with pip:
> >
> > $ pip3 install dtschema
> >
> > Note that 'dtschema' installation requires 'swig' and Python development
> > files installed first. On Debian/Ubuntu systems:
> >
> > $ apt install swig python3-dev
> >
> > Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> > installed. Ensure they are in your PATH (~/.local/bin by default).
> >
> > Recommended is also to install yamllint (used by dtschema when present).
> >
> > Running checks
> > --------------
> >
> > In order to perform validation of DTB files, use the ``dtbs_check`` target:
> >
> > $ make dtbs_check
> >
> > It is also possible to run checks with a subset of matching schema files by
> > setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files
> > or patterns (partial match of a fixed string). Each file or pattern should
> > be separated by ':'.
> >
> > $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> > $ make dtbs_check DT_SCHEMA_FILES=/gpio/
> > $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
>
> Do you also plan to extend this to cover dt overlay + dt base generation and
> check it against DT schema.

I suppose here you are referring to DT schema checks for *.dtso ->
*.dtbo generation. I don't see corresponding checks enabled in Linux
kernel [1]. Probably Rob can share plans over there.

U-Boot tries to follow Linux kernel kbuild framework. However, if
needed we can add checks for *.dtbo generation too as a follow up
patch.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/scripts/Makefile.lib#n421

-Sumit

>
> Thanks,
> Michal
>
