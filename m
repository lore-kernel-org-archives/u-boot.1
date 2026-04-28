Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06280FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC0584669;
	Tue, 28 Apr 2026 20:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BwlqCdoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E4D8466B; Tue, 28 Apr 2026 20:07:36 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECDCD84660
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ba6b39871a3so19089866b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399654; cv=none;
 d=google.com; s=arc-20240605;
 b=Qzt+6slmyGKsYoltutAQIA7MIL3d8uww65+jCU14aEBEUkl6T6WFTbkG8y3SXsbzzN
 MMohVrxIfuvxJmf2RTmC+MvM6e3jB61j/a+lU+vq+d5wbIeel6PFPnXSS8+rNUsIP4UO
 pt3Zg4U8xDkRDmHtw84LQwLFb84SLhTDeGIZ3F75QI1yHE/muo28EOA8ZiNA1SoUvvFT
 noK1ZkYTZUp+Gy4lBVZZbcSnd3lo3KaB/B0BbI6UoGZHUUQBCZj9gJf8Kued63SWsR6G
 +CYaDeVij9S0iBNF4mO4c5bZT+N1hPnxf9HBjW/eQBf6H2HjfwkHA/yJzuT518Ut48cl
 hnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ATKKj2XQ8n1OlchcFuYJur5vGCnuh7ZH1jLyS20mNx8=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=jgxksMevXVfIfw1z27oZIBAxujcPcIGeB0f71hYbp3ar2NuNQ/dgR37pye3uj/AEIc
 rmQqB97luHhKgTQpSu9Is1s0H436RIYgKVHFQogByWqJMnlesOU76GunGHo79w3Ft7Hw
 xO9PJCtz4nCerSxbu5WqKJp+dKDNuA0PE7x46Yjw7V9ik7mzPQ99hb5ChwYMesEMEpa9
 mf44p3b8koDnbkaOB1xcuAvZQb7ITdIhfzaMwMdzE7zCLovO3lRG36qbVRCmP6LoX1Th
 fYyAr+2FHXm02RIn0a64GSIxWch4rNz1tV8G6f1k5uzYPP1Tg4oCrXzFtYdvnlqINd9v
 JSDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777399654; x=1778004454; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ATKKj2XQ8n1OlchcFuYJur5vGCnuh7ZH1jLyS20mNx8=;
 b=BwlqCdoa/L5nlql/QYjLpjpfq+68QV6QYlSwRwDdNcl9sjPz4nzw2HxW1wjr0rTrLi
 rGrigStMzZHDknKyNKFHyWPqyrmbissikbsbZ9Om8pr6BJipZWIj2oJMZL7CV4b8LNzV
 UBU0WU5JLp2vPGL9feak7QoA9T9+whyBmGLfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399654; x=1778004454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATKKj2XQ8n1OlchcFuYJur5vGCnuh7ZH1jLyS20mNx8=;
 b=pjfohA7E4x47TvE/bO5+8v562iOlSqdMGbXezAqITMrVBcTHeePukZJwk/U7uUq5iM
 LgQBjSEtPdGf2iRKB7o2gbqm8riGq8XXamgcxmwyZVQTBDg9MGtd9OnPBEXRt2EnWTka
 Rl2hoyjndQsSWCEkIzQCJ21kXuNyAQfS4E7a8DUEk/ByLxkg2DI15twB7Wbbyfqt8wxD
 5BfmsUeV65MfxCLJM0osr1PkiC97tWjTJaVnCxt36V/NqMR3jjOSLrgMZY34rtNPOjad
 jPr5lcV7isNapC3Lyw8iOpa7I9qqkPXjMlaIRpGqDr/lUV3siKTagUTklT5QuQAjd4K9
 iR2g==
X-Gm-Message-State: AOJu0YwG6PgZbgnyD3SGBUdXrhyg/vCM8GmCjEHhO4i0r0czl5tLs7LP
 C1eyADNgi1O/niYI8hiczn3773Ctmuvtcd4z7q1Inw9dOc7+P1ze54oqOgrr04L4oJLwteD5muc
 HaCLwh4a202qoxxL9pCaXVgaIjAnNDwWabff3vukV
X-Gm-Gg: AeBDiesRn0B7NnHGFXkgyBG3syAFlXW3USPub3NTT8OJgSkEU2E4xrLb/mwEyzCD/T7
 bpmFFjzNtozuknITcQ0hDeCul3t+TatdpbQouqci7/fQD5A5eUgpAZv7sQqkq3G+xa8ECLNwACD
 Z68tuy7+cBPat4SYm2UfHK3M+ojUCmVTsY1K+sHUHwSh/oncOjMMyFLEMtWxqFWUxVtIuf/rpwX
 pZu77nTyPJKeTHRUy4g2axWCxMoquz+ku7eKaX0s2HCvl71lvQx+/vjKFTK34rkww8AKdvgO4Ck
 LrWv5XbfazFa+hQ0
X-Received: by 2002:a17:907:9602:b0:ba9:30a4:537b with SMTP id
 a640c23a62f3a-bb952a5a45bmr2450366b.18.1777399654220; Tue, 28 Apr 2026
 11:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-10-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-10-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:07:22 -0600
X-Gm-Features: AVHnY4LFXGuAwj1pV9y9ZMfz59wJC0ToDNjgTpIOq6fsqbbg2CcZu99zHR4l1yU
Message-ID: <CAFLszTiDRK-OZV-rqXs+NpJZd+ZSoxjKuAgyXJ4nH3sUYLqk7A@mail.gmail.com>
Subject: Re: [PATCH 09/12] sandbox: ffa: share synthetic partition metadata
 via macros
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Harsimran,

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> sandbox: ffa: share synthetic partition metadata via macros
>
> Reuse sandbox FF-A partition constants in emulator tests
>
> Allow the sandbox FF-A emulator test to use execution-context and property
> constants defined in sandbox_arm_ffa.h
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> drivers/firmware/arm-ffa/ffa-emul-uclass.c | 36 +++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 10 deletions(-)

> diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> @@ -19,41 +19,57 @@
>  /* The partitions (SPs) table */
>  static struct ffa_partition_desc sandbox_partitions[SANDBOX_PARTITIONS_CNT] = {
>       {
> -             .info = { .id = SANDBOX_SP1_ID, .exec_ctxt = 0x5687, .properties = 0x89325621 },
> +             .info = {
> +                     .id = SANDBOX_SP1_ID,
> +                     .exec_ctxt = SANDBOX_SP1_EXEC_CTXT,
> +                     .properties = SANDBOX_SP1_PROPERTIES,
> +             },
>               .sp_uuid = {
>                       .a1 = SANDBOX_SERVICE1_UUID_A1,
> ...
>       {
> -             .info = { .id = SANDBOX_SP3_ID, .exec_ctxt = 0x7687, .properties = 0x23325621 },
> +             .info = {
> +                     .id = SANDBOX_SP2_ID,
> +                     .exec_ctxt = SANDBOX_SP2_EXEC_CTXT,
> +                     .properties = SANDBOX_SP2_PROPERTIES,
> +             },
>               .sp_uuid = {
>                       .a1 = SANDBOX_SERVICE2_UUID_A1,
> ...
>       {
> -             .info = { .id = SANDBOX_SP2_ID, .exec_ctxt = 0x9587, .properties = 0x45325621 },
> +             .info = {
> +                     .id = SANDBOX_SP3_ID,
> +                     .exec_ctxt = SANDBOX_SP3_EXEC_CTXT,
> +                     .properties = SANDBOX_SP3_PROPERTIES,
> +             },
>               .sp_uuid = {
>                       .a1 = SANDBOX_SERVICE1_UUID_A1,

This is not a pure refactor. Index 1 and 2 swap, so SP2 moves from
SERVICE1 to SERVICE2, and SP3 moves from SERVICE2 to SERVICE1. The
existing test in test/dm/ffa.c queries by UUID and walks the matching
SPs, so the set of IDs returned for each service changes.

If the reorder is deliberate (e.g. so the table reads SP1..SP4 in
numeric order), please call it out in the commit message and confirm
no downstream test relies on the previous SP-to-UUID mapping.
Otherwise keep the .id fields where they were and only substitute in
the macros.

> diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> @@ -19,41 +19,57 @@
> +             .info = {
> +                     .id = SANDBOX_SP1_ID,
> +                     .exec_ctxt = SANDBOX_SP1_EXEC_CTXT,
> +                     .properties = SANDBOX_SP1_PROPERTIES,
> +             },

The macros being substituted in here are added in patch 8, and nothing
else in this patch uses them - they exist solely to be consumed by
this patch. Can you squash 9 into 8 so the macro definitions and their
first user land together.

> Author: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

>
>     sandbox: ffa: share synthetic partition metadata via macros
>
>     Reuse sandbox FF-A partition constants in emulator tests
>
>     Allow the sandbox FF-A emulator test to use execution-context and property
>     constants defined in sandbox_arm_ffa.h

The body reads like two competing subject lines followed by a one-line
restatement, and none of it explains the motivation. Also, the file
changed is the emulator itself (ffa-emul-uclass.c), not a test, so 'in
emulator tests' / 'emulator test' is misleading. Please rewrite to say
what problem is being solved (e.g. the runtime tests added in 8 need
to reference the same exec_ctxt/properties values, so the magic
numbers are pulled out into shared macros) and drop the duplicate
sentence.

Regards,
Simon
