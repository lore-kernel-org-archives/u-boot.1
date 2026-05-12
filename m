Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3709CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D15C80398;
	Tue, 12 May 2026 08:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UWaCbSiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5024C81E18; Tue, 12 May 2026 08:57:53 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE73D801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6563f83ae9fso5403395d50.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 23:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778569067; cv=none;
 d=google.com; s=arc-20240605;
 b=MzBaMBwRwpMgMTylOiPDCiwLo0jOHLRq75HN9fm8wcwpN7mmz85t2A1tBz37wgt5EU
 4L/JubBQLrtSei3q8byo7nNEgIlX7vqFdI1d24v8EfFXojtr4eqsrpyF5oRao3BsECtV
 vGplQQXBMmzAuleYt/npJx8Vt9DXumWjbi/48Gusxjh0mWjNUWTpkCCaJb4iP1JbrIsR
 yLMjoKa6JwWbuI6Ruf4ggoLrQEAsKqnctNzLnqOTM1LMHCbjZriJaYiKv8CqZWCB7IiD
 OG3g8NF+UEt4kQkZz9l4g/fdz41/gRsr0bH8laJsW+rk8HVqSiuYvkDe87cSxGAnaK3L
 92yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TKDMvgoa3el1tGD+SI3vJEe2cuHjdEJALNOB1hMal5c=;
 fh=lMuOIcWCqjiFf4ZnH3BUeU2JUKtPI5agbsHiYCMwWi4=;
 b=K1FwKyi4INUUA9EA22rvYl2BmLkU8TwHOyXJpco9P7+FXtvYr81ev47z0lPDkFQgUy
 t22rIL14RLqasglCHcQRPEdGoLsUgy+/I/HclI6uIlBcZAcbTcUEics9eKdWye63L3Qo
 zJCMlGdbvyfIvmHtFEwoFuW9nSuvlacmlOttVPUEEXag0gpDnDXZe4aRqw0p5hceu/L3
 TVHDL/aoiiifcRJaiXpQHb0aeHJtPoB8VuC/VcY4t3iLkIDFhFsKUweJ2swRkU5WPwxu
 VC/BM7kPPqa3enrcaODL4CdQX6DjztEIYxGY9JT4n9EjG2Lga6FyG/9+JlDykY3gGIkD
 uBMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778569067; x=1779173867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TKDMvgoa3el1tGD+SI3vJEe2cuHjdEJALNOB1hMal5c=;
 b=UWaCbSiQdNok2kc1mtgt92ES6q9NeEnlrxT+ccTw2uiz73xtCQshKK9ALHVyGpeJVS
 4gqB3VPizBgy0i8hxVe+3CK6JyiDT85owVlW11hJ22MwoVnM/r7SiH79daJ1tImkdcwf
 db0vf9LKRAsbGramObEXIyyy6OA/H0DPnPXwE0OhO5KGaQ8HrA0hHAOg8ZXFwxWBj+a3
 +b6AaZvQcjSWrKFC004asOY2zZD8r/tOMiu0Fats7A0QL16J2T2FBZ0KX0RROmCipri6
 y+o543LlU2J8ZUb2FqCgTXHSsH3py0Q1SswJD+EqaRcLSch2sFD1H0WffwPRMU/7MxwJ
 XCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778569067; x=1779173867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKDMvgoa3el1tGD+SI3vJEe2cuHjdEJALNOB1hMal5c=;
 b=Kk+SEcMp9ji5Vum3GM3D/Bt5J2eW9F6ufpWI8gzltcCcK3rsX8vAON6ib4Qt3lkXeE
 nRgrjVqwIARGCow9B9vavWhD+5FaqcYitl1RTyQ10RBnjcr6b+J8euoHz4u7QllSoAYz
 tSktMG98pM2SQBoV9Sjkw3PFTn2axfPNKtPtKuiS0wqkt0T+IsTMgCaJRzaw0aFaQlPg
 oVbL4ucS0fpOpj1Oujag37wEIKVwDMVkUWF/QZ0WmVRcLFK4JpwCY3RfORUeKqN8kCKZ
 4FgCIXBBVs6aeclU3+gA8Atw4BpxZVnOByaFGdWcy3JgesbUNZXeB/SArRMmn7zFnQ/5
 NoNQ==
X-Gm-Message-State: AOJu0YzL/En9OoyPlCdNgP0NYbLlln15JIMFdkNJoBj7eHw0dOi76hfK
 /H4hwOuWqUBLgfXKmztogKGuvIgKyK/sCaQa3RVMchRJBDBqXZrz1hi5ARdFmvtBnFuh0YjHOau
 jGJAfT1kVM6u5KebE7Bq/lQj4OL/X3XRuaP8mdBOing==
X-Gm-Gg: Acq92OHN6wIgW3X/De9J0AMqFeaGvrkH7+2aVvPClRAniMFO/aTJxvjzJF8AlM+OD4V
 C8uZTcqacb2u6pcTvNvNNBBxRapwpNO25hFpI4AC8qE2Qt6zVL/rGM1Sqht3BAepUnlneO8/qjA
 oVlBz5f2QBteh0l8Zr1n7ZNM+cCh0gJDm3FP10gOtlqc6sFOBXCS/eDKljWrxfDejelXa2is3zO
 hTLQQD6zTz03EU7Po7u5mrkQ72UsWW63+3SHE+xUnwCB/jeNbwbaH5I4c5jqGVoiBvEAnPlbDYS
 TonhywG+VXcr/k9gUku2LwaEByaNz/cR+OZNsxFYtN1FZ3Wr4aTRvjKVCUp7rsCceGWJaDhQNMz
 9XyUPYyYh3OQ9wAYk6bcpa3SE7vi62Syar84PVsnhWElZyGrduRp+yUjLTvV4cYmFsnPFLC7Dkh
 ggGo36o5HNgdkT/rIkjP0RIFrhO1Nc2b0dgESxuX48i74rI4+zQ2ay60CCD6vRVWurMQQ2/PZbM
 EJzTV538MxvSx3ieETFnuyZFlVnSFxohQqUSqh6ZMLpTE+KJ+79fMgFwrFKRHOiCpryu8uhlIvk
 fCw122mTGG70uQk48VlFnhiHxQUXQZ8flrn54vgVOMmKoWGSQfZpO0Uy+O1mQGsXkDnZqaR9799
 ThIEyGA==
X-Received: by 2002:a05:690e:134f:b0:64c:9f31:e33 with SMTP id
 956f58d0204a3-65de13173aamr1464593d50.65.1778569067584; Mon, 11 May 2026
 23:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260511225918.28543-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260511225918.28543-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 May 2026 09:57:11 +0300
X-Gm-Features: AVHnY4KPF-AL9tBGs8J9SQg7u5Y3xp8vLRZ3CMbCs3jwLrEhUAHLfsCsRnCov24
Message-ID: <CAC_iWjK7VPjK0oa=Q=MFVJPjGroFCmEvq8oxPY-YOnJp7QY96w@mail.gmail.com>
Subject: Re: [PATCH] arm: Fix typo in linker script
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Tue, 12 May 2026 at 01:59, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Fix typo, addreses -> addresses. No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/arm/cpu/u-boot.lds | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 8e2266a90fe..98b0306f3b2 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -96,7 +96,7 @@ SECTIONS
>         {
>                 KEEP(*(.__secure_stack_start))
>
> -               /* Skip addreses for stack */
> +               /* Skip addresses for stack */
>                 . = . + CONFIG_ARMV7_PSCI_NR_CPUS * ARM_PSCI_STACK_SIZE;
>
>                 /* Align end of stack section to page boundary */
> --
> 2.53.0
>
