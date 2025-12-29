Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3160E92733
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 16:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC59683E92;
	Mon, 29 Dec 2025 17:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtBjXNWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD5883E21; Mon, 29 Dec 2025 17:18:28 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFEF883E92
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 17:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so11291309a12.3
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 08:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767025106; x=1767629906; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C0RHC7xnnvbxfWpqC/Lsz3MymqNxAHUt8gXwdDvkLfM=;
 b=TtBjXNWiOWH7F5i+ozsXPf+ciIPQSu4Ej9eooSzp+wzeeKnWYmcN79LRlftP3NxMcR
 1aYfSyJeQpTduggyW7eTzPEMKURJxdFQkHs3hlembkFiW5wGU9LJDJYcwbUb45EOws1S
 AomfeOHOOJYqVDt/PbJGV9DY8wQK9Z1RWrNWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767025106; x=1767629906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0RHC7xnnvbxfWpqC/Lsz3MymqNxAHUt8gXwdDvkLfM=;
 b=uPbvD2jKsoj595mFb+sBOZENA0w7Tve1htOofMLFQWs/EGm893bSsYk//rgunYN3nB
 9zQj0k2X8Xa+GrO6zmFiji3UTYI46gIDSRUR7qPI5npArZ3N2Qh33SWMeGwCvSOU7G1j
 Cl5toN6CEz3uRBcrZBMebbP58xzSzprJUMNUclCew1Y5tguZ5LcOp573kotbXaiLUCZL
 SwOCsEu64HsUM58UvCh9WyWlML/m6FDVsynqFBoiZEdXk5O3iOV9vQRl0xmsfKqJsVCC
 lSDaz27tJ2Tt49KqS+ttCK/T0h6164MrxFz4nI9c6hZlbBUYZU6oKUfLDuJXx/qxPKsZ
 Fh5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVghnkaUSdZPzAfZvk5dzqaouiA2KDrHs5yJy1seXR7NANeXY/ziI2GX25+YV0x+60wwjn7270=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7nm72dUcl1gEA5Sm7HuBZxkeLF7PMB+P3AjkCjzA5aUYcYCbU
 NfXRptfax4mr5xtlnp/r7xxFCVPWeiMRFo+dFv8pmtJq5O00rx+ooyzb2CSc4ddVTrOquLbeG8N
 HQdUkUXdyVzbXls+hROpUbok9mhfp6I44N4/IvSZe
X-Gm-Gg: AY/fxX66IXdfXVmxBctpOGaW35TNZdlWAznmo41eLUcpoFTFsbO/5gvCxFvPM++yY88
 ZCl04QPjvKJy85ptCbFotlo8aVWFDELETY9TNHkOlqBnE7VrB7n3OvKzTCy4Q3TkRjyrwBWr9/d
 T6anZRkNdoQnc28I+g3aRabzC4IgUvQtO0/wTb9fGIPatQOHaRfMumTMT/2mxmx3E7ekvn1EJJJ
 oNVDNvQlQab49RW6UWXsQT6KcAByDOQgLY93mqs/ucD+B610CV11faShvGgNbc+/ZeCDQ==
X-Google-Smtp-Source: AGHT+IHaSNNbiBfUjJtjEAtQJjZ+yKrJRo8NyDpKVdmTN4j1rpfU7MEL4oIDXURLCbUBS3ihy2alsyTyBuayMfI6wcM=
X-Received: by 2002:a17:907:3da8:b0:b76:b76e:112a with SMTP id
 a640c23a62f3a-b8036ece49dmr3200331266b.11.1767025106360; Mon, 29 Dec 2025
 08:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20251229161045.177883-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251229161045.177883-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Dec 2025 09:18:14 -0700
X-Gm-Features: AQt7F2p2SWTAb7dEXJ1C3ytLPdCEZys8HjlbCBBREkm_I-536WC6AqF75-fcKFY
Message-ID: <CAFLszTiPqK=znJEk6_M2XYEk2ZvSfiBUOtQEsYryYcD+d9u0VA@mail.gmail.com>
Subject: Re: [PATCH 1/1] .gitignore: add vpl/
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Yegor Yefremov <yegorslists@googlemail.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Javier Tia <javier.tia@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Mon, 29 Dec 2025 at 09:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Directory vpl/ only contains generated files. Git should ignore it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>
