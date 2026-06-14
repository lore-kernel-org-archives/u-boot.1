Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2767ACD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A00FD84704;
	Sun, 14 Jun 2026 14:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CoHNZpTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D00CB8485F; Sun, 14 Jun 2026 14:47:03 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A6F83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68c1630159bso2480536a12.2
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781441221; cv=none;
 d=google.com; s=arc-20240605;
 b=bpCcnTylNbvKBVBdR3lNGHMT8AtAu00IRe404wFaru9MGVN/ZqcZxC730h0Vi9ElE6
 ZPJFCIJmuOb7QEZ0X0nRbSioyaIodErmjkx44pprRQWz0nL+mmPHYwezaBdPoSp2tXUo
 7A0IHrOw+v/EMVr5SHN0zCac7onFMm0HXe8ipH0/96TjW2kiOcj7zdcvw87Bhg5G77n8
 zwvtrAQ84JgcpbXVdA+ju36PenhNe1VoLQE2GasQ2HtfpULKyovHKNtbBgFcBSkDfiwH
 oFuRZhr0ClIwoeamurNVjRcUlWW88Jxwgd34Puwx338h/0Ziu9ODzdWcX1yzSCyrNBNg
 JqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qUSu/WZzIqgQu8Fuz20ecq2k160aEq2xkrqTNaIAmsI=;
 fh=43gRR5aHyq9GfSpVKKiP+/Vu4RiiNI14wXkBdL9UsaA=;
 b=DGbJV4nKZBoBV+auvBREG4WAJ5Z1kUpD+5etYvsYJml4oIIF6TgcVIabjq4NpDb/PS
 H3eBBIhmDu7Xj8f5yA635ed4sNoEglhFRVAfKv9NemGGsaQ6bsbeZZy1OldcoTIWzo8d
 pDhM3TLFd7cR2oOUD5QUFDkyQhM97lIiE5q62hAa7/H+L4wWiWuqquQXtBMtPbe8bcFD
 X0cNUB9OQnQDPodLm5D8O81+ATZTKWAbffOCfRG/kGryYlkPGxsVucKWXMaNPxYkK/bk
 caQXaAW+ps0E1qChPZNCcENmqE/R7FvfPxkr6ktHn0zsfLv7rufikBhXHsYEfTpIpeAQ
 eIVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781441221; x=1782046021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qUSu/WZzIqgQu8Fuz20ecq2k160aEq2xkrqTNaIAmsI=;
 b=CoHNZpTS9xAntzf31r5OSRKIugqr4/+brf2+8PzWvrZ8FZZLeWH9t65QbHl6XySbXl
 3JfmLXnmC7RrlBk9n1b412jQE0snzWCmC4C9xquTIAMSyeSrFu7zvPvRVy2OyFmX9VTs
 dgbHDDedKc/2TXEcBBDTps2p5ZV1fctyGSPK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781441221; x=1782046021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUSu/WZzIqgQu8Fuz20ecq2k160aEq2xkrqTNaIAmsI=;
 b=RV07v8WnED9PVISOosmkl8yugZJI6jpaHcIh+vgVJqfaLGUvdS8lMoUsDpSg7+HRQv
 jsCjL5ccOzcsWglWfksQFfgBSWnvX0iIWiVfMsNAbSmr6tAI25mRJC9at2hIl0wEhsNM
 D7K6vaT57DxNg9NY8KNoc9hL9KXqWjHle1WsUGTuCVth9CktBowjna02INJROc+LNdTM
 EJ3JJ575oFFb08MUOtB2o6ilNCWAr5kDJKVZuWXn/WlSCSSVwhVjzWOy7lbOPdy89b3o
 kxtacVz37Rv+vACLH/NGOefuxEmLPCJbLiZ9hXh1uqdctzcTNJS3Sw/2hiyseaX1KQSR
 4I6Q==
X-Gm-Message-State: AOJu0YzbR+riSB3J2JIS7NiAlmpyU4F3ZDeHtSNvwRQ7JNx8206nRCCu
 J0pNJo0Z7faVL2YoqEj+5TWtxWwDXJfoqb8GrMnkCYPhvGDKrPJN9oUlRbmm9E0F5lgWELFtgHi
 TTMXI6Dd74YXVb9ohTRInUWGUs50Kb6pcCZbt53KMUHfj04IgjCY=
X-Gm-Gg: Acq92OEdTp1D8nrW8qeR9eeeHNM9Q0pxWS+GCp3eR3+jxhKIxTXC7mFgw5drEd8ZN7e
 AhQEDmv1rL10BVXFLi4qY7bB7DE06yS3epnsO8uESvDkG6Ge2Pxb6fSVNkU2DT3HCOGinQ7fdPl
 3JkulOm9Qj+DBoQTSmPzWwbppdryJqqnAJ0vDP0MZNxpjpnGfsYzmMqOvFi1z91PE7LQNBjb3Zj
 A4CLrjB4zU0wgOsmeKyL6Tqph5X8sEgnaUWgl8VwP0UyX6JVZc4Irm0WF8HoGWZGmJmOzkasWB2
 G+zczQ==
X-Received: by 2002:a05:6402:1e8f:b0:68b:5418:bee5 with SMTP id
 4fb4d7f45d1cf-69378a5a35amr4673869a12.25.1781441220914; Sun, 14 Jun 2026
 05:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260611161831.122299-1-ludwig.nussel@siemens.com>
In-Reply-To: <20260611161831.122299-1-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:46:48 -0600
X-Gm-Features: AVVi8Cc1I0Zw4cVtWwCLpxSU1Dgr8b5BAlQTCCpCJzjBK-5SCr2Euu9plyr3QTI
Message-ID: <CAFLszThk7M5SBi6MmaGvBUAvduDn6vdG_RywUXRy3mgy2GSE5g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Improve U-Boot's TPM handling in the non-EFI case
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On Thu, 11 Jun 2026 at 10:18, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> U-Boot might be the first component to start the event log, eg when
> used in qemu. So allocate and attach the TPM event log to the TPM
> device if not initialized yet. The address is copied into the device
> tree for the kernel so the event log is accessible from Linux
> userspace too.
>
> Changes in v3:
> - fix test failure
> - sync description with cover letter
>
> Changes in v2:
> - fix return value handling
> - imply DEVRES in config TPM
> - use fdt_getprop for reading property
> - don't wrap #include in #if
> - fix memory leak in error case of tcg2_log_prepare_buffer
> - handle NULL elog parameter in tcg2_measurement_term
> - use CONFIG_TPM2_EVENT_LOG_SIZE
> - pass log_size instead of position in dt
>
> Ludwig Nussel (3):
>   test: include mapmem.h explicitly
>   tpm: print all PCRs from pcr_read
>   tpm: allocate tpm event log if missing
>
>  boot/bootm.c               |  18 ++---
>  boot/image-fdt.c           |  69 ++++++++++++++++++++
>  cmd/tpm-v2.c               |  69 ++++++++++++++------
>  include/tpm-common.h       |   2 +
>  include/tpm_tcg2.h         |   9 +--
>  lib/Kconfig                |   1 +
>  lib/tpm_tcg2.c             | 130 +++++++++++++++++++++++++++++--------
>  test/boot/measurement.c    |   1 +
>  test/py/tests/test_tpm2.py |   9 +--
>  9 files changed, 242 insertions(+), 66 deletions(-)
>
> --
> 2.43.0
>
> base-commit: 3cdce049f90d77c3f9221f1eb73922384c8972c3
> branch: us-tpm3

Somehow this email did not seem to reach patchwork, so it missed the
cover-letter title.

Regards,
Simon
