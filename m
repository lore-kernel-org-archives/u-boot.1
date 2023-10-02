Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4601E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FC38644E;
	Mon,  2 Oct 2023 03:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QZIbm/gS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7018874E9; Mon,  2 Oct 2023 03:23:18 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F70874C9
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-325e9cd483eso2236733f8f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209782; x=1696814582; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=foLI2TJJSu9BISCBd5Vmb/gazYCPwt02lR/ea1ZcC1g=;
 b=QZIbm/gSAz1SvDiHulgwGFn3h/rFXS7oG2hmdw+JxQzI81nwr6XoftX51CuqW6UuYo
 M6w8SuFKS8zqX8S2YwQC7YvWj5nxeQb9rg29us8YnIb+1sY4/0a1PpqYEmX0d5z0XpeT
 vFrUE46Gw91+lHEML0D6OVRz8YHOilQEV+2+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209782; x=1696814582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=foLI2TJJSu9BISCBd5Vmb/gazYCPwt02lR/ea1ZcC1g=;
 b=pBx/f022nhO0yP5vRMIRzxk7LMiGJrM+NZz4gR5hJbdaUiIN680Qv/fJ8GfavxOHgA
 SzF/EefaIREFt5mSzPcSQR19a7jgl7WJadGqYWK1jfMzq+8kEOXuLQntvCtpY71IiceQ
 miAMCqWYG4+yLSF6Q3oPj2VDw8u9eB2ftKSRYLa0IPhB920RNBsxtRvbT/TjiY2aYVgO
 Err6if0jPFD87CWlPW/qFA+cvF6o4VyL5mfACxMwjmBMcHpbrualIf+4l6cpeSv38kTg
 8tuH+Tlx5io3iexXu6mNQCiYFtAL5IHDWI8KNXPGYvbMbYWc+eXT/kbiqPvapTyYWhwu
 92hA==
X-Gm-Message-State: AOJu0YzbpaW3im5z8JtmyLaFQVpBp7iU7Z7PqYdIlewXZao1+x4kHwGY
 Phl2u2kGaacRtYteQ9qyo188v51AD7450wyragTW/3A/VAgECrnUWE8=
X-Google-Smtp-Source: AGHT+IHfl587gaZ9XnwVC8qw7ngFx3i98NLnS0383izk9Tp2qkhmt1R413FJbDYbFAaRb4IicjXbqZa3DHLtfMOwBR4=
X-Received: by 2002:adf:f546:0:b0:31f:d7bb:481e with SMTP id
 j6-20020adff546000000b0031fd7bb481emr8993360wrp.63.1696209782331; Sun, 01 Oct
 2023 18:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-12-takahiro.akashi@linaro.org>
In-Reply-To: <20230926065750.734440-12-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:15 -0600
Message-ID: <CAPnjgZ1f7WwDAwn2Ry83BCLCRZep0dwFdi0K-s7r8i8Acv1d6A@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] firmware: scmi: add a check against availability
 of protocols
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, u-boot@lists.denx.de, 
 Etienne Carriere <etienne.carriere@foss.st.com>
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

On Tue, 26 Sept 2023 at 00:58, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Now that we have Base protocol support, we will be able to check if a given
> protocol is really supported by the SCMI server (firmware).
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
> v3
> * new; import this patch from my followup patch set
> ---
>  drivers/firmware/scmi/scmi_agent-uclass.c | 41 +++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
