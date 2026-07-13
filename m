Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC04C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 00:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC4684A3A;
	Mon, 13 Jul 2026 02:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iyRdmyMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 245FE84A49; Mon, 13 Jul 2026 02:19:16 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3854284852
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso4745934a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783901954; cv=none;
 d=google.com; s=arc-20260327;
 b=ns+mk5vpry+3+3+fve9QDWzRvUU9ZHolM+RXgnUu0VyUPeSmLmfVwNd8l7IqjkBDGh
 vHu+GRNhpGiileq+5NHVY7fv4KI1O9R65uEDAMGZNV74WBciVG5mKFvzCcqrgBtYXufj
 iTB5Csu1rAgvr+ucrA/LHjr305P1xuwBL4dzhIkpDyKLeWg0CU4xNM+L1KuaSxujHVn3
 Lyb9hlbQS/0M+BIlMGcceMtMTSasPbE+NXAYd8KYWRVKwGGvXVL4s5HvKKtifDCU188a
 7LihCTHnbh7JU+ZoR2CRB109qLUn0Feon4x+e9p299B3F1e8zdOtknTX4EqXN/xlhMv0
 dxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=29lBHXIBIiiv/7ZY1s8ZxrM/txK4rKZIm334U1OwthM=;
 fh=EEQIRgfuMtwQmXdjfdH5RZ1j5rBzQhaEFZ9mu3M+W/M=;
 b=KV7xJbLdtFkv13JQT5/3DAqiOMw++tw4r0LlPl8ldi4TEEAzP02Th6TB7GhYPDT5x3
 4QCTLbfOFYRqICbORojHho9sCXv2NKY1W+jALwCiyxV3trdR1alagmJCfUf0NjitNvPD
 8s+agmbx/DFTrC7y4NXSV0IMmTnWXd0O9RfiKE8fFMU9Qw9aneEoSNCnQrWo7JNndYtK
 7QVWk1GHarQGHUCHYtihrppJSgvEDUO4VAAISuY4cVSQdNwMZNLbuLTl/ZqZVEw6uann
 fd9uzzq9r+23MgwTaMoq1dmZEY6JmtozAl2MJRfg7MILJdyAOEdfDxZPVQfQpsoqUtA0
 HCZw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783901954; x=1784506754; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=29lBHXIBIiiv/7ZY1s8ZxrM/txK4rKZIm334U1OwthM=;
 b=iyRdmyMted4vL+o4O/Q5eTRZHR0gvxinJbimPtY/FEBcRuordxRGBUKFfAWgpNAdSi
 WCxLl99eSGS93J8sFQERzXtSo7jAMqACqgUDAvYl2uhSBIIO3u3uPm7x8T/D2lRhwDY6
 4nMmhed9pnFBsEqmMpbXeCu4hcKeHGnv4vFxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901954; x=1784506754;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=29lBHXIBIiiv/7ZY1s8ZxrM/txK4rKZIm334U1OwthM=;
 b=dct+NQibdEutEpVHXRsKg2AQioxk7SxzdDIuqDsQMnlRHQ4vC0W0b2iKyBI5HgvmHj
 Iz0xHctDdWSAUL8cGxN0rmMkDS/SEsoY/mRBv1sFUlNw8c/wCpEWfBhsRg6wCN4Rftzk
 jHnEGm88TBgLoIfHNtnNH0XfBHC9vZS1tYMCq07gAraW3retOUxDWvjQJJvS/REg3WML
 XVw7TpubZTMogOGS2rAEm1P0AO2wkRmNKukYz28vdndQxwBY0Ka9XAk6VY3XLiXillQk
 F87w7OrHCcNCgwjRz1D/gIyW8MXKYT9EVhd3KrYgwCNP+hwkq5eptmFlnS4T/AF8tBYW
 +DEQ==
X-Gm-Message-State: AOJu0YzS0rxDoOKP1bvChNfyuPfu2mSQ63Vl7159W+K4aPbAmu3PBAE/
 SY1mvncyE+OqHz5tkhxR0ayA73JmqsmlkgSJ01cPrdcTeSMu50ENQIklVoOSKkrCRBPGi68BAmZ
 QLw2dcPL4jD4gQ9A1QWp1Wp81A/LMcM0zIUPIOGUH
X-Gm-Gg: AfdE7ckZAjWFY74/+mof1ABa4g+yW7Mj0g6P3tZYd8EuYrzc/3LMu1LYkGX1yvP/rCK
 lRv+HKiqIJtwu90iA0lD5a24oN9EDjv8/nqbKFM9z9sRGRCnI8L4NK2D4ZLkFeNe67Lp8tlv2+p
 U/Kq6kNDhHE6bX7GgZYYdOHoSvY9d9B8gaSbOinX6v4zfUDoRCn2k0BceoMcOSJdwCRdcHiNB/s
 cgzxmrR/xnOqlKZH0JvwFKjbPwH1mt6V8T7fIqPsgbAKzTNfOh4JG9sAtpUqaMYstea7b4=
X-Received: by 2002:aa7:c74a:0:b0:69c:20b8:f1e with SMTP id
 4fb4d7f45d1cf-69c24ea1ae7mr3434762a12.18.1783901953723; Sun, 12 Jul 2026
 17:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
 <20260708-other-contrib-v1-2-8b3bd4d265ef@cherry.de>
In-Reply-To: <20260708-other-contrib-v1-2-8b3bd4d265ef@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 18:18:59 -0600
X-Gm-Features: AUfX_mzlcYRxiyk3Ld_HTlkGCLk0-UJq67NrjDPe_nCOuDmaFwE-4cUw7yiloSo
Message-ID: <CAFLszTjzpdPd_35y7-3pJpbvAThJL04OgVLCHY5ftrmtmbMyhA@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: CONTRIBUTE: tell people reviewing *is*
 contributing
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tony Dinh <mibodhi@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

On 2026-07-08T17:21:12, Quentin Schulz <foss+uboot@0leil.net> wrote:
> doc: CONTRIBUTE: tell people reviewing *is* contributing
>
> We are "a bit" struggling with reviewing things and it's most of the
> time maintainers or long time contributors reviewing patches on the
> mailing list.
>
> Hint that reviewing is also contributing to the project and that even if
> you don't feel you're an expert, your review is still welcome and can
> help us catch bugs before they are merged.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> doc/CONTRIBUTE.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)

> diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> @@ -38,6 +38,15 @@ script. Please don't send patches as attachments, and ensure corporate mail
> +Code is not the only thing you can contribute to the project. As most
> +open-source projects, the U-Boot project suffers from a lack of reviewers.

'As most open-source projects' doesn't parse - there's no verb for the
comparison to hang on. Maybe 'Like most open-source projects' or 'As
with most open-source projects'? What do you think?

Regards,
Simon
