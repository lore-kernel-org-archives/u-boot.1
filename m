Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0227C5ACD1
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 21:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 561354085C;
	Fri,  7 Aug 2026 21:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKFQR-iWqp20; Fri,  7 Aug 2026 21:23:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B27640857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786137829;
	bh=HCdjfy6Fo2qyd0wmXCqjNjNF4FnCyohtLmlOyiidvn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HKBpyGJWhEXtrhvir7B388T29dVn/IZN0OIg3jIIwiJOUYXlgnvmNV7Nb0BjqaYTy
	 TTun/WeRa2pp1j7HPV33k/8QjhWGoje/lD52scGeVTLgk5RoBtZQ8IANrb/mt76LFt
	 xO31BDgYOg2lAVk4qyemx/QdqjEv7KBsCHkRs4gxeK2pfTj+v0CG+MSOop0UcINJEl
	 tbixht3A94GB0pUgCp9+ccP/DjLXlhS13cooBDhiwMUceOigrvMosCojnthmLc1Kzn
	 70lNhMQ7sc3VkrENWfHgwHtub/z39LXHLXvF697a1CmEJ+wq3uahp26Srty6mJyf5f
	 Yxue8MFJP9d9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B27640857;
	Fri,  7 Aug 2026 21:23:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D980296
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B2F640857
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:23:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 13K5ldR7E4VW for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 21:23:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7093640850
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7093640850
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7093640850
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:23:47 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so6079367a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 14:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786137825; cv=none;
 d=google.com; s=arc-20260327;
 b=I/eeuA+5uUXL1E4MWOr/Kaor3/hvFv70cHR3Avq0WrxEHGbJD5k653ilBrVrjBjHeZ
 pwnbGi25XX57DVqV+Y3sFaeIkVdnvTBzltb2a8E8oC5IuX610CjPYi2100EQVTTRdPfe
 HfiMC+l5Jt3dtinNiGGwL1EV64N+qqq3C3TaeQHwZ+oUkIAIo5gJWeSR77H1xyRJQfjb
 3ax/sDimUjQGf3f8yedZA36TNdoszKmuP3+andG5tsIzPDvLyY9y33cTJeVViUeyAKCE
 6I72rhcNPkRXy1gtttUbx4727X0vLkhOmllODwFrnkFEjwDY6Ms+fjAN5hU93fnwKaQm
 g95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HCdjfy6Fo2qyd0wmXCqjNjNF4FnCyohtLmlOyiidvn8=;
 fh=lg++Nh19w6AA5XbPpYH3uVwDvtX0Uh5YfzojdundXr8=;
 b=rCY5kXCkTdjiITAHEH/bDBto+LdhapfJBL6g9vqwrLsjwP5IQvHFAhM/ooqws6yMU2
 nljkXrHthQZCFEBZ7iuIsd9zGgrNEhfmhOGSethdEJFcwahUm8mKvvmFH0AMh09snt3P
 KpmKMQ2SliUkNRtO5Q50pcMtJjztdDWVu6nWBcVeBq64chtiJshIhPE0do79oyqDdPR/
 V7uPurtwjxxmhTvyx8z1G5TrAm+woT6YhtUSQOfgquS/3JXBYyjfz4C4RzXPhhFRgIje
 LcCQbmSDoj+2GwNLCjhaOfK3R7eV859cecoVBh5J8QG57W2Yed/lHwzs1LKm3e6g5x0d
 lMhg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786137825; x=1786742625;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HCdjfy6Fo2qyd0wmXCqjNjNF4FnCyohtLmlOyiidvn8=;
 b=gGPa8IpxlRO96Gt4zjQJaqpWCK5AbQqjSKR4OB01ZFvvST+9V747eEJ+cqSg0vnZJ7
 r4CCZpwgnNGZpDc5R5RUsCjxrEJ0v0LYa1+70wkxGhpYdk2afO/5WGrVmTSSS29Wt8JS
 QS/V1R/B5Z6UZrrSaK32MFBUrOYgBwBHx+yyOrew8nhC74lUsQ0VMIkySppqSCmSUsaQ
 dHHulIAoeY2YxFIwiJGc3Py8SnMEiEl6TYY1CJ+VCGooN2dQ0ncWdWP4AdVwavhDL7ZK
 Mw6wqkXvs1kO/qif7EgPkytE4ln6mrDqA5MHioZEcMFOFOTpRGNcGpOxg9RJAheMB8KF
 rFPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUStDJ01R+t1hVa+BEm9zBeo+rR82FopUxFD9awAvHtfUxPdSe7DkOP+x03t+67tqFL5SA1gQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxP35UBFAWKJ6oNZfPEHTxRPiaYmrUErmZ328f6MoDwaaqlNf0e
 cjhd2XvYRVr0zr+7DPmK55GNqAWEAXBGwLm7ZdwL58RPQUvNn8QauDOUTNV1gRsMoCqNynAHPbC
 2abaLT5NaXfEjwduTAjTSTBdJTGf64LDnbgxmQiVS
X-Gm-Gg: AR+sD12xCpI0mrwP0nc/ZCKN77rrqt4EsYqLNF6ekKmV9cLfoUmYSmb/LGqOPaN6uCo
 x3dt/WprKu1/dPj1lrHZyax6ahUzuNutYlpHeeqHIjNjioPYIRj2l6JhonbK/AA2NLYZKVN+2St
 S3E7Z7gMJhJSjoN1nsw2AQKSQdq3yLLLsvnYZzgQ7ktzpx5s8DZ783sdYcj7pMzAeMdIjzYLpoA
 z0d+zFp5EOkaCl34z4pP6TMhF35qyFVjP0GoRW2BEKzPh6F1I5+ovRKT+NIE6PKFs9ei0DFBZy0
 hf4HNRrBOEFAQkvJT0IZG0TjM8q9viAZKUQbc0NtAAI=
X-Received: by 2002:a05:6402:52cb:b0:6a1:44c8:edc4 with SMTP id
 4fb4d7f45d1cf-6a1e5afe8d7mr3017854a12.12.1786137825450; Fri, 07 Aug 2026
 14:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-qemu-x86-pflash-v2-0-f3896316eb66@elliotjb.com>
 <20260807-qemu-x86-pflash-v2-2-f3896316eb66@elliotjb.com>
In-Reply-To: <20260807-qemu-x86-pflash-v2-2-f3896316eb66@elliotjb.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 15:23:31 -0600
X-Gm-Features: AUfX_mxSM9PnvwkZHRS66qfHsUoqYzpz-LnYllGXKqF_nV_LiAxaftMOzAcM7to
Message-ID: <CAFLszTiW0cFyRkeLRAw9k3sP_TpPqO-Qu1PvH+fmi67qOmVK8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] x86: qemu: Wire support for applying EFI capsule
 updates to pflash
To: elliotjb@elliotjb.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786137825; x=1786742625;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HCdjfy6Fo2qyd0wmXCqjNjNF4FnCyohtLmlOyiidvn8=;
 b=nTSiIQzYLrpQtRDp2oQgeJSaag+1xWS0GMzVFvyZZ2/Lt7T8rioNkpVDPA0X6wYq/t
 Cxe0+9Dag54YjnbMdiLw0wK7L04kUdb7ddr2pmj1PMYHVfaSgXoA0O9GQ5kTz0l7/Rhm
 wN8VCv0gRQwfdd4OSO/560I0qEAVwgRlNxQic=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nTSiIQzY
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Elliot,

On 2026-08-07T18:07:09, Elliot Berman <elliotjb@elliotjb.com> wrote:
> x86: qemu: Wire support for applying EFI capsule updates to pflash
>
> Add new UUIDs for QEMU x86/x86-64 EFI capsules and register them with
> update_info. Enable the config options to bind the pflash with dfu,
> expecting to follow the typical convention of the first bank (nor0)
> containing u-boot.
>
> Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
>
> board/emulation/common/Kconfig         |  2 ++
>  board/emulation/common/qemu_dfu.c      | 16 ++++-----------
>  board/emulation/common/qemu_mtdparts.c | 36 +++++++++++++++------------------
>  board/emulation/qemu-x86/Kconfig       |  3 +++
>  board/emulation/qemu-x86/Makefile      |  3 +++
>  board/emulation/qemu-x86/qemu-x86.c    | 37 ++++++++++++++++++++++++++++++++++
>  6 files changed, 65 insertions(+), 32 deletions(-)

> diff --git a/board/emulation/common/qemu_mtdparts.c b/board/emulation/common/qemu_mtdparts.c
> @@ -50,28 +50,24 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
> -     /* Currently mtdparts is needed on Qemu ARM64 for capsule updates */
> -     if (IS_ENABLED(CONFIG_EFI_CAPSULE_FIRMWARE_MANAGEMENT) &&
> -         IS_ENABLED(CONFIG_TARGET_QEMU_ARM_64BIT)) {

Just to check the knock-on effect of dropping the target check:
qemu-arm-sbsa also builds this file (it implies SYS_MTDPARTS_RUNTIME
and sources the common Kconfig), so it now looks for nor0 too, and
MTDPARTS_NOR0 has no default there so it resolves to an empty string.
I suspect this is harmless today, since sbsa does not enable
FLASH_CFI_MTD so no nor0 MTD device is registered, but if that changes
the result would be a malformed 'mtdparts=nor0:' - perhaps
board_get_mtdparts() should skip a device whose partition string is
empty. Fine as a follow-up if you agree it is latent.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
