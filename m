Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83B8C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC2588214F;
	Wed, 19 Mar 2025 16:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DbR2smVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC9C81E47; Wed, 19 Mar 2025 16:04:17 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2FE68209F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5dce099f4so9419470a12.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396655; x=1743001455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlQ4b9vwdguDhQUaKHgIipzyu5npBcK71z/l+aH2UTo=;
 b=DbR2smVMagw2NstpI86d3w7LndvQhIf/iWB97TnCECBusnNJkVxWh7xjLWF8gyqsb2
 YAId2RJRgUsCeTsXVR41cWSB3cFXkMlRix24/VwEj/m+hUn7eqP1yJ1DkYVf1BZGE736
 PAK32Fzt7qeR0ieYJ2NmLRaBqxvvRl5KVf664=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396655; x=1743001455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlQ4b9vwdguDhQUaKHgIipzyu5npBcK71z/l+aH2UTo=;
 b=ugszaCkUbTgyQtga9VidnR8f1to9fn+9ICQbticxNWdbU3MSNINWGmdGoWjtw215OB
 f9HJqOOzkc9KSHcgZN4HGUP4ybMMbia2nYYNGLlRWGt/wDbnp22LO1xPuMjoy3l2m9kI
 50iubT7nRznaas2uxWl64OnPNja7OU0o2/lcKh8sUlN+8UwbswT6Akh69JuKTbTAOudI
 l8ScYJ5xI2U3ykoWK6KUwst69iwps3PBcKVsUdkPRUDAa5AZDIYAGVQGtFELgkkJ9V/d
 PKNjni5bjnsSy1smDfxiUUxyrcdrh3T8Fuepc02tBZKs7v0C7zOvy5ACjHKzAVIT6fzi
 APIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXarlVDiCYwooCvXKcxbwupuRXHRGYk5ZAQi6jajk+fXWNX7tN0hZ3+8cT6u6uCxlMmrTV6uEQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzMrCxH7SEYCsdgg78BMF0VON+UnUwrNG02bk7B812nctA2+SCX
 vZKuROoU7sYzveGeT9llwRC01a05279KiGWKJ1Mp8Bmat1waEdkzk76c3aKoE8FkYBNrlpihpbf
 5zKayTe6Hf4sA94okJBiEJqe58o5Q4dBqUJAC
X-Gm-Gg: ASbGncvI/z+efVS0+Yd+fQilQN/UFsJziTxNj+p3nGa3hwYVe1pLvMcLBMZnUUHV9cO
 btCiEfUcKHYCCCuzCanQ1b23UYi7tNlYqIjGP4i02+ePzztiwM+BKI187j5ShYIW9NsNCJVVC43
 yf4yPvWKI2BwlQ8hebvZf4q/LoqXPcGRDlhv17FQ==
X-Google-Smtp-Source: AGHT+IGkNfL2uT8OWF+sHvUDDzWxtiz/vIViIFY3wVtvf/5GHuALdlprKFYFl0lJzt6sShfzlOdGvLxPmik4jJHknFQ=
X-Received: by 2002:a17:907:7241:b0:ac0:527c:9cd5 with SMTP id
 a640c23a62f3a-ac3b7f84fc2mr305994166b.42.1742396655097; Wed, 19 Mar 2025
 08:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-7-sjg@chromium.org>
 <ABCF9413-6C51-4EBA-9907-95C5097A8D86@gmx.de>
 <20250319142038.GE2640854@bill-the-cat>
In-Reply-To: <20250319142038.GE2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Mar 2025 15:04:00 +0000
X-Gm-Features: AQ5f1JpNheUXddOrsk4i1K0kbU-zO5hJvkiPwCGflhm3BlkSaIvki8EsOPx6KFc
Message-ID: <CAFLszTg17Q+ovvc2MeHLadsSdK+LJuHsXhf=fFybkbf=zLy36A@mail.gmail.com>
Subject: Re: [PATCH 6/6] lib: Provide a signed version of simple_itoa()
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 19 Mar 2025 at 15:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 01:12:30PM +0100, Heinrich Schuchardt wrote:
> > Am 19. M=C3=A4rz 2025 12:59:08 MEZ schrieb Simon Glass <sjg@chromium.or=
g>:
> > >In some cases we want to show a signed value to the user without needi=
ng
> > >to use the full printf() implementation. Add a new version of the
> > >simple_itoa() function to handle this.
> >
> > Where will this be used?
> > Why can't printf be used?
> > Why would this fit into this series which is about test improvements an=
d not about functional changes?
>
> It would be more fair to say that only one patch in this series is about
> testing and 5 are adding otherwise unused changes to functions that
> presumably are used in some later as yet to be posted series.

Sure, would you like me to change the cover letter?

Regards,
Simon
