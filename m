Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6E9CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0312C8669F;
	Mon, 16 Oct 2023 23:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VdK01hvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B9E86B97; Mon, 16 Oct 2023 23:54:25 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C5C9868C0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so8687372a12.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697493262; x=1698098062; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sFyszUAKH1Bi59GLrKaH1xZ412ynyNyWfhIyPM619dM=;
 b=VdK01hvuJ+9EGpawmKPvivrUe1HiUNVSqBkUS1m3ttwNLpbkC0yctUwAQ/nZlscMEu
 kJKQrqWKUgeDZIm5sMcvyesxXBH1M8CWsB6ZjpbWhTTR4wx52wsxpIePQUQf55o/jik/
 jzrgYuu+k8RrECvL5VJqRUE+vu5ps7Ut/5OMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697493262; x=1698098062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFyszUAKH1Bi59GLrKaH1xZ412ynyNyWfhIyPM619dM=;
 b=b28j6oi8WUVzBh9oRN9xzI+GXtUJbmaXTteCGTh90KMdkYYIWto1bRBmlTKIzUtZP7
 SXkH5+hEEwzU2NRR3o8Z6aNCQXXRo8qHJBffdk9OmtCQKQG4XOwzZay697Aan3gRjuR/
 hSqAbaTWi1lKq437uMbR2fOlfqA5m1XWrsza7AIhxLIFt7DhaQyYJMtUWSBECWW8K0cw
 fNnsuBKvJAS67Jy6RL0VOBNv+i3xD27MgIA426Z6b9uNUp1gpy1Kh6JDa82ZKC9/isHG
 FTORO/zynn+Mljmn1w4P0kDjUM5A3D0VFCEYfjYRf+/R2evoyfIVUGwM8DHIVM4bMRqF
 UkBQ==
X-Gm-Message-State: AOJu0Yz4X9f9dCJ8KXfWn7+Kq+ABNcRQOj+Ipw3pe9whw0FUv/WLZwJf
 XwXP9VAF6q1Cprl2NipgKl8e90DI//0AHzBrmKh0tw==
X-Google-Smtp-Source: AGHT+IGZoGGJeNshHE+uBukBw1GOLWeEgu2vwWq8BjnV21H2X6/a8NzxZphGstDjGzZP8Yp311u7fu7RX+UlFVrwkP0=
X-Received: by 2002:a05:6402:34d3:b0:53e:467c:33f1 with SMTP id
 w19-20020a05640234d300b0053e467c33f1mr440773edc.8.1697493262341; Mon, 16 Oct
 2023 14:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20231016195728.GA3574754-robh@kernel.org>
In-Reply-To: <20231016195728.GA3574754-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Oct 2023 15:54:10 -0600
Message-ID: <CAPnjgZ3xo6Rz8dGe+UtNxv9O96sbaphx0DYkKcRNd1m2nozQ3A@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] schemas: memory: Add ECC properties
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, lkml <linux-kernel@vger.kernel.org>, 
 Dhaval Sharma <dhaval@rivosinc.com>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Yunhui Cui <cuiyunhui@bytedance.com>, Guo Dong <guo.dong@intel.com>, 
 Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>,
 Gua Guo <gua.guo@intel.com>, 
 Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Ard Biesheuvel <ardb@kernel.org>
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

Hi Rob,

On Mon, 16 Oct 2023 at 13:57, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 26, 2023 at 01:42:38PM -0600, Simon Glass wrote:
> > Some memories provide ECC detection and/or correction. For software which
> > wants to check memory, it is helpful to see which regions provide this
> > feature.
> >
> > Add this as a property of the /memory nodes, since it presumably follows
> > the hardware-level memory system.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v7:
> > - Drop unnecessary |
> > - Add a blank line between properties
> >
> > Changes in v6:
> > - Use a number of bits instead of a string property
> > - Fix inidcates typo
> >
> > Changes in v5:
> > - Redo to make this property specific to ECC
> > - Provide properties both for detection and correction
> >
> > Changes in v3:
> > - Add new patch to update the /memory nodes
> >
> >  dtschema/schemas/memory.yaml | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
>
> Applied this patch.

Thank you for your help and guidance on this.

Regards,
Simon
