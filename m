Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F0CC02192
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 00:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871C480137;
	Tue,  4 Feb 2025 01:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zb12ckHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 929F3801DE; Tue,  4 Feb 2025 01:38:43 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C74680050
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 01:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab6fb1851d4so683392866b.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 16:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738629521; x=1739234321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FDkkdlx2MXOL/dQnOcvdZ4z57Az8zV9l9XzbKAxprPc=;
 b=Zb12ckHnrB5K1A6KwZjyp6oDUoxsinikoQY+ugxOwsXDvI14vw+X59FwiST1J4swXc
 S7Tk7zldOuiSbZRzon4CT9nu0+6ILemOsUn6Tyv+2w2E7R4AwdRDvcjfgUX8bnGSOVX7
 tvq5aPO5t6UuOS7cqKX2Zn7G1qvlv+a/3T56I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738629521; x=1739234321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDkkdlx2MXOL/dQnOcvdZ4z57Az8zV9l9XzbKAxprPc=;
 b=Ar4gLQ0H7bM3ihLb5sNtKcPub/2IVaTBFZpJTjQ1d36OtOj+hQebTrXN9IyC46dmFB
 rQ82hrf+eT+ipbIFO4fRnAnvsqj8HV5QZuKDg+JB3voevGdvIMF1tfzV2djvUKB0tO8q
 cgYnIilaXQZ4rJesF2lrtFHA2FOkxmIumcsQ4zR9RHZyjb27K9Hv3z9Es36JqUWmrTO2
 TEl8PWtzrcanKv62fo/tZpvHNW5VfznaVkwPxZSZEKCjKNt2X9lRUmqwKrTpqH/d6VGK
 6UXun0mG8jX79GSTiTDx7rPlzABWASmi31rHlog16f54zfiGOxQMGTDitTWmSrPyZnd5
 WZSg==
X-Gm-Message-State: AOJu0YyKIaJtdlRJxbA4vUKjB67yJzFqvTl8ay3v7/v5yaGUZhPZTupd
 qElQSniWpZgOPPaTCOVt19Duh5efIsCoajaHuUDEPri8LKz0nLYMb6B7hAUhsQJ0vhPtUX538eY
 rprYBiX1jvl03Mk5YeBFxswY3JMHZr3fLXr2j
X-Gm-Gg: ASbGncur5HFUDTgOHY22Q+KR4mJ+Tj9Pb2y10nx9BIjD2Q+iOVJlXCs09fK8MCN7VrZ
 4Xv/VBpxemth0dV8QWrGKkVEAdkHZjDDzqNKpt0+YDo9RbIvjhgxLcIS/1P2ULz/Ctj+1Ev9mZg
 ==
X-Google-Smtp-Source: AGHT+IFNBKQzlZZPKNQmLoewokJmSGDfHQX6Bw26xE3AXca9kX2ot2yF71fo/gQyNZSl1uOeKYDqu38PHagQqkR0ZFo=
X-Received: by 2002:a17:907:2ce6:b0:ab6:de32:da61 with SMTP id
 a640c23a62f3a-ab7483d0373mr133193166b.5.1738629520830; Mon, 03 Feb 2025
 16:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-12-sjg@chromium.org>
 <20250203200847.GG1233568@bill-the-cat>
In-Reply-To: <20250203200847.GG1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Feb 2025 17:38:27 -0700
X-Gm-Features: AWEUYZlqjhPLL-s7M205UNaLoFJD4ku9CCOAwoah5nA6uB0RvFLkBRGTPsO7TlY
Message-ID: <CAFLszTjknAo4CHVpyYNtV3sGHbHFCE-YJEhzaoLB7cSNFpMRPg@mail.gmail.com>
Subject: Re: [PATCH 11/32] efi: x86: Rework VENDOR_EFI option to permit other
 archs
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Tom,

On Mon, 3 Feb 2025 at 13:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 10:42:04AM -0700, Simon Glass wrote:
>
> > At present only x86 supports the EFI app and (apart from Qualcomm) the
> > payload. In preparation for supporting ARM more generally, rename the
> > existing VENDOR_EFI option to VENDOR_EFI_X86, using that to define a
> > generic VENDOR_EFI which will be enabled for all architectures.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This looks like things that should just live under
> BOARD_SPECIFIC_OPTIONS in board/efi/Kconfig instead.

I don't really understand what you are getting at there.

That directory is for boards, but it seems that EFI is going to grow
from just being a set of boards, e.g. with board/qualcomm also having
an EFI-payload build.

Regards,
SImon
