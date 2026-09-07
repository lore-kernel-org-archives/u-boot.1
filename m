Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECE7C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 09:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 907A4605C7;
	Mon,  7 Sep 2026 09:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mpqIEFfrqigh; Mon,  7 Sep 2026 09:29:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CEF20605F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788773371;
	b=DACcHbcR+f9lEj74seJTeVvRJCCpralZI1FbbfRLpTMRF8/QGV0DcyAKq00m7DceC4w3
	 TDz3OwcrBtkJdJua0/DmMNReqftpuKNmMsg9EL/uFaPJDpPVLoJCdimplU5YSSYQQaZf7
	 AF21G+BhMCW9x/FFGxdf6o9GydlLeUopMofWiAzA0Ws/OkyDEgvmtYGWcG67bbkOWbIVS
	 re+NCjKnJNjHzH6a1J3jIFjiarHQfZV6ROuSCmZBSr9PHEcsAn+kgydRHCw48QahxY3MS
	 1fi2iXjUiN2kLjEjpo0ZnQ7zXbYL5gg495PFEse5pAP/fEttSmgLzv90O8sQTAgdGCg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788773371;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uYiTFRd2EJns3LSxa3gVrK4tRynRE3a5uBgKhlAtkLM=;
	b=G467SAA097LEYCgInG+bWzQaI2SA0W51tPeNWwETMzmSwbnxSR6FkOSN+wHJAMpU+oyY
	 3rYB2lKL/KyAQEB8roKVzs4QVWCLCZwO1ixzNdApwl0iOqfojkc1htqlAh9FG9YEOk94v
	 Ty/yqQ+4F9KnqDdUMpGKXQ5aS33ZvzcFDaoZycG4c3rctDoPk+x91MFzshgqgvg9VLTOK
	 1yre37FNXXkwq5+ueJ+GIB7AWsgSPG56U227BO7imccCvCTHRCC2lTDiyXPlzLlCC2aAa
	 4eOBWXKSYAferGH0vCK3fspgfem+NuMprFd27rZy9DrrCSliip2ffviRy//en/Gbk/w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yuyvi2J+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788773370;
	bh=uYiTFRd2EJns3LSxa3gVrK4tRynRE3a5uBgKhlAtkLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wt8Zl+3beCrbT9iVTAREUOTij2Qx7bLS/mwviOfKc2rmeejTZO5nIEebfvhn8RJox
	 AmLW6T4FOImtfBjSroMelQUwKw7vNTU62wScOIKODXore1tJik0Vu4JOiy5tJ9YVKG
	 8uIYTUjwAW6TgkbbF7g788howOscMDGxCfMXyOqhNv+iaA7gAD54S+Koxqcuei4OZx
	 dl/5lek6Q+QCpK+lwt2lm5gA/G4RkKJBk8TfsRP0/mNVTGKjNwaDlVrEszG6h1onTD
	 jVXvkJBc0kRvJVlmQg6zhS1+50rj3SOwy4qvIEjgXblzv5lYo9ctTEtRaH7upv1+ta
	 2NKlxmcXHmkMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEF20605F5;
	Mon,  7 Sep 2026 09:29:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB8A8AEB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A140F605E6
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B9hOFtrFCw8e for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 09:29:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9412C605F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788773369;
 b=UQQEeOqkOgtoWk6QxSc0fclEtcrBNkzNh/in61vZBTy0aH2iwrOymbB79BBLyqt/eo8x
 wamBKu0Scbf5ERDJJNJNSO3BWTzKvwFZo1FOIzN5jGjMeCOt4wx2ZPNDcooSpoPvX9IFc
 Is1O8yguiQd2sqfaPW1V7mk3+Ekux+P9LzrFaGCEs8vi06Ueh07sLaEdq72T8aoZ1NZ2j
 tFEGCuh12s7SbBJKwYhN6HyM4UryD7wwh7ylvVMZurFwL+ntDFPguTw3ZZuDsIc9gLJLj
 TH/19uo9B8zPK7bRYBgUWEaOW1bURRICg66hvYS4DxsLIOdfV8R/zEvEokf4a21+o7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788773369;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=uYiTFRd2EJns3LSxa3gVrK4tRynRE3a5uBgKhlAtkLM=;
 b=ZPAztpP8mowweTY6rRRIksifoe2nO4DcDlN9mG3PfLocu6lXh3tnK2xO1ruNAP9j5s1j
 JRzFh/XvFGo2N1vT1e9OH+b9SdxZSnFIocXLaYYnuhkcMTVE+K1paSJTqw6vljvEThUHB
 Yvfei7jbZNGyyj1eHYJegoGcoZUTlF1i7J+o+nAGGNy/vAeoAogQx5xa73deEBQqgu0Ct
 DRp7/42Gtif+tADtvw4Ff1r0YRQnj+r7rtNIvD1oudL0ZDBufCSkwHBa3GDM2Hi2M5eXx
 e5rpK3+JLGk1MumKqUfFjV8KKg8fcZQWhkkMXQe2PB78R+SBN80MNYYNSKwdYlfIb1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Yuyvi2J+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Yuyvi2J+
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9412C605F5
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:29:27 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-85a50f6a7f7so42058167b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 02:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788773367; cv=none;
 d=google.com; s=arc-20260327;
 b=FGpIG4Pgr5k7y9gugO4DPFnezmv+7MmZOZw5u7yF+wPARtjQYAmHFvbMvRRJmg6MJl
 5H+K16DkRXR7I/srxVliD9oFCfMSTpQ74RgtN5TmJfJkuirXyGcZtbfUfZband+HGDS1
 fbtAf73AioZwDZQC33VWJKl3GW1BPPFn2PWnaJB8BHKXT71nZevHTQUZo+oc3PDmlRA5
 qLN2YOuswvIcVd4iynKPrU8cXJYfhj47QrJ33z+Q23hBANQTdPZi8zkq9GiQ9ng6+TSE
 VJM1HYRKkJoinosxMYIRTgOLn2ooLaA9oaGdOvi1DmxS9zBddJPfIfiWmJHXv1RU9OuG
 XdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uYiTFRd2EJns3LSxa3gVrK4tRynRE3a5uBgKhlAtkLM=;
 fh=/c2cMmmUb+XMHQmR2B39/8DkawFJIvGJ/oRmSM+u5RA=;
 b=i09MGpu7TzcTXGrHE+woBfrdJ9RqK+caswsX+axFkVjSgjcCFyHcJ1eO/OQKuKRzrh
 zOWjglNhVo5APKJPTbYWW79WKKisVKziFQr4omAtjn0XTRHkxwF8GTjSPGFaCC/L9Igm
 PQpvlIYdVx7BMSEBydPEJJSNmI16jAOAquvNL1TyoUjS6KaJb/Wq/iwZb98jmaa+AZbJ
 /1+dZ/2x9328SM4lf8NK1i4U3Uf+RrqiXT3XTtBF4lQOiHJOHTfc5QhZtF9XqxyDPpqd
 XwY6Z71YQTB29PliasAqnSBjqbpLEtN94k6JdIrfYjq/jqJaE1yNRJH7z/3a5WRcVmzm
 spdg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788773367; x=1789378167;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uYiTFRd2EJns3LSxa3gVrK4tRynRE3a5uBgKhlAtkLM=;
 b=Yuyvi2J+BAZplwCqkpXtVQOoikP6kObUj7DuXft/BgGHHE4sYdU0ld/fZX69afwp2t
 Y1w6wvs2FI1mTX62mYdFsQ1K1bGqFlFHvUfbB/MRp8embaVszLUFMReM96Tne46hPlHt
 a8Jp/PMVgqQELJdsg7jEB0C8d3q0p/DJsPOPXgp4jnrSTv/odXYEvUGnGDgySqeQJSHC
 9bslLnXqrOh1/1bVxfGPMfeihQl7WClVA1QAzJQJofBoq0wOA8dTrXEXbCI/Q+xtS5Ak
 JNckYV8qvPSAKaZW7fU2TR5bHTzaGxPtRd/tYrf/TtPiYpmqZ9CK8YcA1e3+2oiQc32H
 GIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788773367; x=1789378167;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uYiTFRd2EJns3LSxa3gVrK4tRynRE3a5uBgKhlAtkLM=;
 b=nLPIFqnRYDJcdHC2NxTnWCNEtkwpsl5AlrEdFybN5CzzKGJ6CfvxMP1YSVqgXeESLd
 3nXN3CtuytXHvhpE5YE5Bh5jvNTqtY0NOfod/CRXx35PEMtJRJYGpSNR1N4iGKBUzCfW
 QhnavQ1FmixVHdyM/27KqN7rkprB0cC1DZUTR1gF1YOxLw5T4bpOXp75IGbupL3jjv5M
 At4ed1T0ZQBeajNnqzLDMfjdDZivBQoM3BMMOYhQhMDePwEDv/aDg7SQZkfpD06jC+Bn
 IxHn3qrTnRc+UBlTW8Qb0PwT2iClI9zYQPelt8FxpCcWRooqboppYPJETWITv0gLJxqY
 8RmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/c+w748vtzNrVeKeCfh226YLMT4EFzV5V4v4oj+NOCvu6BBh692m4HWsF5VHjW7eHWVJaPEY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nQv4Q7fkD8mqpXIINXwKY8O/kFNMKcyGfGCUXL0J2oBWmSkuaB
 3lVlWn309q7FqGp5i+l32zG1UVf8pggRemHO4VOdxLE1DrBOVn1/hAQ+ZQmuIceDxGei6BHs5Kp
 OKtrQikeMhzTGYlALdYYCHOAGDvgsh8Zp8eSHOsS3yA==
X-Gm-Gg: AYBFou2QXSy3iUQBIGLMQYsKFqV8k8biayVu+Y9yFYfU8bHBA7+JcfXmKjtLj2+CTXT
 Zv0/CmXt7c//cpx73fmwf/xuYKnqS1NW9ZhUQW6jcMqBRtBL510dsyxhF8VLlysktpcG6z0AzfV
 RLOWlKFh8pg0Zll/cXbfLTrbk1EsszADPUPOEPzexpwBQGgnlPHkrK6cgJv3o+Z0+7f1RpdofG1
 UnmmRXglkCViqN07JBy3eYnoSIqF025I34j+83CrJjHqS9cGbvxxcwL3IJZImDgnlwEMklqjGTZ
 lPYMeZZruOGIvWxLphzsmalwuj86f7JuM8vVtGeNlJ5Gin834glDEJLy27IxEmt4io0+TU5dMXe
 wyVsJfJq/2+ddxiUAYOR42onWLT8J073VoEP5i3A5soP3Nj6zKDWCG9gzaDHZrpNdKSJamTiZPr
 h39NZ/+u3EdnIxJ0vt7gN28wrMurUIswcQnS72HjxHqbmnyuUcdS/wvoyNHztxs7c6prJ2TncpP
 iNV5dTnR/KDDIemMsNZYIUBQHksa/cvnWVrUl1i2fLdbfR6qEsxZFtBM8U6K8/5ro0q8rpJypuo
 Ih8xqPLnlovfQUbDET5HdhmRMWOjv3cENLElnau1Qc4yr3A6bWpwzaIv995XzuCzkRMsE5+Pl1K
 affECXTdIWH2hR5WdhyAY6GFC6bjLBmATc/S4ptJAAWE=
X-Received: by 2002:a05:690c:ec8:b0:878:cee5:9885 with SMTP id
 00721157ae682-878cee59aaamr10719547b3.43.1788773366701; Mon, 07 Sep 2026
 02:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
 <20260906121751.3550628-2-aswin.murugan@oss.qualcomm.com>
 <87a4putklz.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87a4putklz.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 7 Sep 2026 12:28:50 +0300
X-Gm-Features: AcwNN1X_k0-b4NuEyWyPr-WtliLGfCsPxl5bYFRYgKqcvLWH5S_bTWS6W9Hupr8
Message-ID: <CAC_iWjL+b_4PtYVNjokUF4xLJvf6PvFmM_tno+qB66g522Ap=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] efi_loader: skip fs probe for non-ESP GPT
 partitions
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 xypron.glpk@gmx.de, varadarajan.narayanan@oss.qualcomm.com, 
 quentin.schulz@cherry.de, balaji.selvanathan@oss.qualcomm.com, 
 dlechner@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
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

On Sun, 6 Sept 2026 at 19:23, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> > Date: Sun,  6 Sep 2026 17:47:48 +0530
> >
> > efi_disk_add_dev() runs efi_fs_exists() on every GPT partition as
> > soon as its block device probes, even for raw partitions that are
> > never opened as a filesystem before boot. Only the ESP needs this
> > probe for boot, so skip it for other GPT partitions.
> >
> > ~170ms saved on Qcom SoC bootup time.
>
> Sorry, but I don't think this is right.  UEFI implementations support
> loading UEFI OS boot loaders from normal DOS partitions and folks
> depend on this.  OpenBSD's install media use a DOS partition instead
> of an ESP because (some) Raspberry Pi firmware doesn't recognize ESP
> partitions.  All arm64 UEFI implementations I've seen (including
> commercial ones like those found on various servers with Ampere CPUs)
> support this.

Mark is right here. Also, distros  have grub/shim only on the ESP, but
the kernel, which can be booted directly by the EFI bootmgr in a non
ESP partition.

Thanks
/Ilias
>
> > Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> > ---
> >  lib/efi_loader/efi_disk.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index 4a3ace3a304..4fd53fb598a 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -529,8 +529,12 @@ static efi_status_t efi_disk_add_dev(
> >       /*
> >        * On partitions or whole disks without partitions install the
> >        * simple file system protocol if a file system is available.
> > +      *
> > +      * Skip the filesystem probe for non-ESP GPT partitions: only the ESP
> > +      * is ever opened as a filesystem before boot.
> >        */
> >       if ((part || desc->part_type == PART_TYPE_UNKNOWN) &&
> > +         (!part_info || (part_info->bootable & PART_EFI_SYSTEM_PARTITION)) &&
> >           efi_fs_exists(desc, part)) {
> >               ret = efi_create_simple_file_system(desc, part, diskobj->dp,
> >                                                   &diskobj->volume);
> > --
> > 2.34.1
> >
> >
