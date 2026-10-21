Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5E606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t/JkHhTS;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=TB3psNYi;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=O0m+qRLE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24D1D6083B;
	Wed, 21 Oct 2026 14:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4s1xkwdtphD7; Wed, 21 Oct 2026 14:48:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4CA936084C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792594099;
	b=WULXmGVYVDDwIDSRHVgxRMZiAAT7WPnVS+CQy8CpH7Bpu+MvP5VDLtpHBO6kdLfcipFf
	 t9KVWu5FyhRr+NEndI+JU90lAkxO4zxtfqNN45neZzm9pMX8/6QaH3xa3bQqbwIRQ8em3
	 udREt4OUHQExE1X0SXj66tQyhEXuv6m4P6wTnfZiExgY6h8sZLZkRAUP1BzJxA+LC3tqo
	 Uiocj7WmrsQw36ekqPwykSeeB/7vWLcbGX1QsqLJdamS7zM/sBbzvVj2KGlBSejgO4Ci6
	 UZTosD8ctYhkie9KXVpD2ZGL98rfESz0qQZoULOUcT2y2qA09EViMWGMvuhAHVA4Taw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792594099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yoho4x/v1lksPWGsa5HJxXq28fcW7nrTAwD+19sBnfk=;
	b=YROBrJFVCafp6nYP1ilga9KhdjP1lpJ1t0SZHH5MVrG0tU6ItY1mv1dIhOv6TPcnC7zr
	 MDhBB35izigKbWaSA1jM20lUnQD7YKiZNg6WEdbo/yQTpBjBHM8ZvCSEwjYxs7hxlkiBq
	 eHS874bMJowEXDGRgdS4fJxO36ix2/1NEjzJkoiDNaLhP8GfowytBbX1c8BuCQUbTMz9f
	 hWyEVzWIJmK6cr2sfErYKbij+Tl1KWgurcHNBPIZ3axSkBHYUOM5pobqjQuxGwtNGLtwJ
	 CCCuEcaenqP5KC99z4VdNnQtklGhmG7DiLgMvvMg+FvqkOmQZ4URI3O9vBUU/tWgNdQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792594099;
	bh=yoho4x/v1lksPWGsa5HJxXq28fcW7nrTAwD+19sBnfk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t/JkHhTSNevAUZEroQRPq/x4E2TSN5/cqD1ObCSyTlBewqqCZguSpVS9qrDTZ3QCN
	 u6aZnqa65GDSaas5b84iJi9LjQCVj+HVZX65iT6gstufOgSdl/+aAy9lAJsTugOFVI
	 sK0lVShFTBMm3/J7NgiaHPPTUoaIqKQW0/gSGTg9fiHlDgT3bsWfyHIEAl+DUmTWCi
	 n+ToqOnncuWGQqHFMvP8xKdFgWHjs3uAeIOU2d2b+UrSeiWgiFwmSRmyCRD7egl/0F
	 DwO9a7f5FZaSPi8JQY0Z/en3ndfU0d3W1l6GZ/0UytNKEpIjS7+ZXR4riX22LMc6HU
	 xEWFpVWFU6aRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CA936084C;
	Wed, 21 Oct 2026 14:48:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D37B2765
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C58BA4016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:47:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U8NcAYqxl_N9 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:47:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8CBCA40077
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792594033;
 b=MOD9nEiDfpRXfC6cI+A6xlVKBkz2b+dh8WrVN+Do8vl6xPnnrOieOCikDav1hCrVlMi/
 dtILPG2Ks8Z6ZVsJcW/DHDsBMQErAaomOWx9kgktDJRrCFiIt7oYSGfxg6q9fuC/PXjQk
 rRTIYodfT0rsX2beFPLGKDajfd76KGsWA/WcVW+bZ81B9m/Ylxab8VPcVBKfw48Anrtsv
 yHBof1ClDbE8aVf+myDJLwk4eAI0k9lWF2B/XrlONvzICqqdzZlvv5ug9AyqnKRCnbIhF
 rx5r1VllHpJZUkoCEdpxaA2pz6qMCv4dZxQFaxucz9KvjhZL4SMRlAP/GE0usZapXqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792594033;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=yoho4x/v1lksPWGsa5HJxXq28fcW7nrTAwD+19sBnfk=;
 b=Wm0e2b7z0LHYrQsjn+u+qDFhzxaXhrSRB60SKHnY52Up4je4KVSSQbWqP201Y+jM4xdk
 Zw8p7osSs/2yUeL1K5PTn651o+d98FtjfHJGcvzMNCCvNXLauCkc8AmF+YlDUvAUIQwE+
 S4JeWuLsdWYiL0GHmdxHqzhepfyXG1kMz/e2yowm+5UCFrtcLcOc+E/rz2x82/ha/GciR
 KqZjZsB6xb6p0Br//aKweIeSeRas+93GYD23gh1F254Utj2RfM+S9JfzFSO8FuhoR+BeB
 tESC6uBCF76HDjqiNZs1FyJ8wq5qCM61ejW5OzgtdbI5P1dKsLhlc/6FDofMgbR/dIQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=TB3psNYi; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=O0m+qRLE; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=TB3psNYi; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=O0m+qRLE
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CBCA40077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792594024; bh=yoho4x/v1lksPWGsa5HJxXq
 28fcW7nrTAwD+19sBnfk=; b=TB3psNYiOThbGXKFx+QFzzTKcz3uh031HJ+7yX2mKU/OF1cV9n
 1MIbfYW/4lkN+xG1FiS/2ZJCY1icX/A2y6IaE2AiqElpfGNof0GNU/HdTvkGDPlmE98L8YKA2BM
 vjgtTjQ/Em1z62Z6VPl1ugJ2kA5+vHf+JuML0EgxXdwaNdq7g2E8ruJP8zlmCd+JRsAjSH6tTMI
 IRk0e/wKv/g34enZ1P4VesTGP594p3F+fOIB4vWhZVYkCiWpTJ+8OXCwR8RjVIb5QPNmlE8Jp3s
 6vz78jzQvpXxY3d78dfzlK+qX4cDcBCt1mt0y9xFn3vItxvorvjw4haB1/LhsFZKuQA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792594024; bh=yoho4x/v1lksPWGsa5HJxXq
 28fcW7nrTAwD+19sBnfk=; b=O0m+qRLEyBH8UYdsDU98cNkTl5VQY/LtBLYoKIsL1DTM9Y3yrX
 m4rUcj4+ZU2pfFmAkZIeRfJf7CGG5ED+n7BQ==;
Date: Wed, 21 Oct 2026 15:47:05 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Marek Beh??n <kabel@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_00/26=5D_powerpc=3A_drop_unmainta?=
 =?US-ASCII?Q?ined_boards_and_SoCs=2C_take_over_maintenance?=
In-Reply-To: <athE5KyKe3No2qz_@nxa18884-linux-1.ap.freescale.net>
References: <20261009221017.20385-1-brads@mainlining.org>
 <athE5KyKe3No2qz_@nxa18884-linux-1.ap.freescale.net>
Message-ID: <3682B813-95DF-46F2-BFD6-982899BD1A4A@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 14:48:16 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21 October 2026 05:51:48 BST, Peng Fan <peng.fan@oss.nxp.com> wrote:
>Hi Bradley,
>
>There is a build break, would you please give a look?
>
>Building current source for 1 boards (1 thread, 32 jobs per thread)
>   powerpc:  +   qemu-ppce500
>+In file included from arch/powerpc/include/asm/ppc.h:36,
>+                 from arch/powerpc/include/asm/u-boot.h:23,
>+                 from arch/powerpc/include/asm/global_data.h:89,
>+                 from include/init.h:30,
>+                 from arch/powerpc/cpu/mpc8xxx/cpu.c:11:
>+arch/powerpc/include/asm/processor.h:1129:34: error: 'SVR_C291' undeclared here (not in a function); did you mean 'SVR_T2081'?
>+ 1129 |         { .name = #n, .soc_ver = SVR_##v, .num_cores = (nc), \
>+      |                                  ^~~~
>+arch/powerpc/cpu/mpc8xxx/cpu.c:79:9: note: in expansion of macro 'CPU_TYPE_ENTRY'
>+   79 |         CPU_TYPE_ENTRY(C291, C291, 1),
>+      |         ^~~~~~~~~~~~~~
>+arch/powerpc/include/asm/processor.h:1129:34: error: 'SVR_C292' undeclared here (not in a function); did you mean 'SVR_9232'?
>+arch/powerpc/cpu/mpc8xxx/cpu.c:80:9: note: in expansion of macro 'CPU_TYPE_ENTRY'
>+   80 |         CPU_TYPE_ENTRY(C292, C292, 1),
>+arch/powerpc/include/asm/processor.h:1129:34: error: 'SVR_C293' undeclared here (not in a function)
>+arch/powerpc/cpu/mpc8xxx/cpu.c:81:9: note: in expansion of macro 'CPU_TYPE_ENTRY'
>+   81 |         CPU_TYPE_ENTRY(C293, C293, 1),
>+make[3]: *** [scripts/Makefile.build:272: arch/powerpc/cpu/mpc8xxx/cpu.o] Error 1
>+make[2]: *** [scripts/Makefile.build:497: arch/powerpc/cpu/mpc8xxx] Error 2
>+make[1]: *** [Makefile:2228: arch/powerpc/cpu] Error 2
>+make: *** [Makefile:189: __sub-make] Error 2
>    0    0    1 /1              qemu-ppce500
>Completed: 1 total built, 1 newly), duration 0:00:19, rate 0.05

Nice catch! Thanks for reviewing! There may be other errors, or are they
all of them?

>
>Thanks
>Peng
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
