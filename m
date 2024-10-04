Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDB3CFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 07:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 362D488FBD;
	Fri,  4 Oct 2024 09:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z1K64rSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF81288FCB; Fri,  4 Oct 2024 09:12:46 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 664AB88F6B
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 09:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-287ac3fe2a8so861642fac.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 00:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728025963; x=1728630763; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2OSWye2EBYlaRp7SwmQSH2YEcLhVs0syzVGImrc1LgU=;
 b=Z1K64rSOexfHt4afsVJTU3OCHC3z1ZJYXYtJ1ecWwcDkPf29A7Ckcr9JQbxcC+l61a
 ReCFtZYcJSirDla+xLPpHkmm+S2XLfLO8a5dk75YZt42plXJ+QWAEJnr/XyAOSlpnnIT
 J7TSK3Z/lVAlUoPo1dDM5ZuTxBlq6VK2NevgOo3Ivlrhv837e6tmNLVeKXMLOOtmDtU8
 4R/Kw0VRyPUq5zSj7HaT0lfuE+34YSgSUnrlFqs71mvz0NBrFkMiXeKyNxNwYp6b4Rf2
 S+r6zUUy4NU3wS4YiuWaftFfW6yS+h1Fef0ApnJE+dfQ8AjQ5My/FBZAYYJCfCAe+Jf8
 Ou1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728025963; x=1728630763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2OSWye2EBYlaRp7SwmQSH2YEcLhVs0syzVGImrc1LgU=;
 b=tex42Qt7TGt+wd3Wn2SIJS7BxlT+mAmkvt2gzkDkm8S+ULJWsq7CyPn9JeOLkpQN/k
 eOi+QrmhUXji6kij7rsQNI4pxDIgJI3+jotELE6p3+39HojXYLe+FGgkTroIntWa2q8M
 QA1/p7jWYtjEnV0ybi/ggkkOIu4YjDtFdgNigTQeeeA9D7nY3XiYct3XkvxDbY/4fcTH
 MfLTTsMYimkU0tGFJ9k70DObYFH99PJHbb5gEECgqlnkakINNOJBfof+c7z1IvXfE8rN
 eY88e9aODyDpHx2wpBnWc4VN23CwwBgGHeIapS8cWBZ3gJRXtcnjaWlrpNwvbKZLwovs
 XE7w==
X-Gm-Message-State: AOJu0YzkmZDHQi8HakIh1UCQFjPQq5TD6qg+asTnm2aKPJLR6mhIot2d
 2TaxPTplt4DWgfoZsIg7oXEShvmFZ4uBusqgaYIWLx+x6PHr7TX6bk9jPf8ZyyVVPCMT3RKDCi3
 KKSCqcCJk0fpnPggwBBhAl8dX3lAD9AEUhAvRWgF6ktWiL6QkWhw=
X-Google-Smtp-Source: AGHT+IFrJvqL9cYOzuI83XDZEo8AZRgb2MFB0QRFC5DpXTlkiCY1f8nTVDLwllJTZI9T2iN4reqe2yfz/ZPdgBa6F6c=
X-Received: by 2002:a05:6870:65ac:b0:278:162f:41f with SMTP id
 586e51a60fabf-287c1e344e5mr1760948fac.17.1728025963088; Fri, 04 Oct 2024
 00:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <1699de5384a71c0d0ad535cdc48cc2b95087719d.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <1699de5384a71c0d0ad535cdc48cc2b95087719d.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 10:12:07 +0300
Message-ID: <CAC_iWj+egprdEiMOm+Aa2Cj1yA--6o3nuvjXytLuDYA5QKMWmQ@mail.gmail.com>
Subject: Re: [PATCH v11 03/29] linker_lists: set LINKER_LIST_ALIGN to 8 for
 CPU_MIPS64
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, Alexander Gendin <agendin@matrox.com>
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

On Thu, 3 Oct 2024 at 18:23, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Note: Patch posted separately [0].
>
> [0] https://patchwork.ozlabs.org/project/uboot/patch/20241003142030.1610222-1-jerome.forissier@linaro.org/
>
> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
> exception may occur. Fixes an issue found on malta64 with QEMU:
>
>  Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>  31                      if (!strcmp(name, entry->name))
>  [...]
>  ld      a1,0(s0)
>
>  (gdb) p/x &entry->name
>  0xffffffffbe04b0d4
>  (gdb) p/x $s0
>  0xffffffffbe04b0d4
>
>  $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>  4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8f1f4667012..8f4df849801 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
>  config LINKER_LIST_ALIGN
>         int
>         default 32 if SANDBOX
> -       default 8 if ARM64 || X86
> +       default 8 if ARM64 || X86 || CPU_MIPS64
>         default 4
>         help
>           Force the each linker list to be aligned to this boundary. This
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
