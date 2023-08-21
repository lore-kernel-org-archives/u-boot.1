Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979ABEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01907871C0;
	Mon, 21 Aug 2023 21:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EL3zWNSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D81871AE; Mon, 21 Aug 2023 21:13:32 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C1487135
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-cfcebc33d04so3614630276.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645208; x=1693250008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/MAzm1zZQJU8JgP5cDMhDLNwTEQLDHUJXfetPIOyh2w=;
 b=EL3zWNSbESMdxg0toJ38BUrtdco+K+yzLSYhGWxcufvrONyuGnYg+vRV2ZYeWXkRmm
 ZUplj+BTOokeIOuPvHHI3ZcKFzBs7bUWZBEmfrfPS3Lx4HRQdpCC0bepFu/mdeQHup78
 hMiM2tFmbqBqrMlGMJqtAUK5IOdg7v/i7tF6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645208; x=1693250008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/MAzm1zZQJU8JgP5cDMhDLNwTEQLDHUJXfetPIOyh2w=;
 b=YdJjNJITXL14AED5bNxOqbCoNzkRfm8G/n2kMFRmlzpfczl8pI5bb7Y0w6u/sAm/Ov
 slnkJ9aXe+EYkF88d1CIKG7dYGgGmOJN2zZk9SpUPM+lbsej3yHk4frgnzLVwm9p1G4t
 VZaMpVZOxMtb7SFf+2JirAv2saaWve3Kqlji370ryCg17DtSnAgP2Cxatrb8VdxCFY7I
 Giyavircd+33lfZVA/JGp8sNiqPjTogdF0mCnW8GySxXEDZPCFM+iIGMecGBCfxdL3za
 HTNoolOlrqFpf+HHFxWsygoKZHSZyQOhkc0FTpYNu5/DQ1Pml+hcvYMYGRE2G6fRZTet
 qr5g==
X-Gm-Message-State: AOJu0Yx7FW4gg21xpEuStQAe1HQfTZPFjcxp16ACjWbTQtlFwB6JAPdo
 C8PD79+swgIEaowu7vlogzsgjEYT64ifgaSs/UarQq8E0sPsU8bGNfQ=
X-Google-Smtp-Source: AGHT+IGzrsqdbIID+pULMiVQRM2kZ0SUuqES9Afwu6j0iXtvXMlLlI+m/F6oaRbmmwvpeABacuCwmmQPCk++fVm8xJw=
X-Received: by 2002:a25:cf0e:0:b0:d74:6188:19e7 with SMTP id
 f14-20020a25cf0e000000b00d74618819e7mr7672229ybg.35.1692645208029; Mon, 21
 Aug 2023 12:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230820190412.21266-1-jmcosta944@gmail.com>
In-Reply-To: <20230820190412.21266-1-jmcosta944@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:12:02 -0600
Message-ID: <CAPnjgZ1c12NPKPgrYMY69181_nKtzas6hy4Q15u8knL8b_a=Hw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Port gen_compile_commands.py from Linux to U-Boot
To: Joao Marcos Costa <jmcosta944@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, antoningodard@pm.me
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

Hi Joao,

On Sun, 20 Aug 2023 at 13:04, Joao Marcos Costa <jmcosta944@gmail.com> wrote:
>
> Hello U-Boot community,
>
> I'm submitting a patch series that ports the gen_compile_commands.py
> script from the Linux kernel's sources to U-Boot. This script, originally
> located in scripts/clang-tools/gen_compile_commands.py, enables the
> generation of compile_commands.json files for improved code navigation
> and analysis. The series consists of four patches: the initial script
> import and the necessary modifications for U-Boot compatibility.
>
> Your feedback on these contributions would be greatly appreciated.
>
> Best regards,
>
> Joao Marcos Costa (4):
>   scripts: Port Linux's gen_compile_commands.py to U-Boot
>   scripts/gen_compile_commands.py: adapt _LINE_PATTERN
>   scripts/gen_compile_commands.py: fix docstring
>   scripts/gen_compile_commands.py: add acknowledgments
>
>  scripts/gen_compile_commands.py | 229 ++++++++++++++++++++++++++++++++
>  1 file changed, 229 insertions(+)
>  create mode 100755 scripts/gen_compile_commands.py

Can you also please bring over the documentation for this feature?

Regards,
Simon
