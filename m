Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC68CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2634483FEC;
	Mon, 11 May 2026 22:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HMlHfFbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B41483FEC; Mon, 11 May 2026 22:14:27 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 429018460C
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so289771966b.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778530465; cv=none;
 d=google.com; s=arc-20240605;
 b=Bu10Y4cYx+cnqPn0o6vHzjdTf19Tzw7m667zYy8WYAXnxiIa4QG6aRrvb2L6AEd0pR
 4zypzLO45MlXtroMsGm2Il0Wwrn5yiAM1sW4X9gYfEOwivkzYMM6GZD7vr3dOb2frSVi
 gJxwXhVJni0qM88KdSnctG3FIBqd7eDa0pqU/62Kg9nK6QC2cnFo8YQnEqzEVbpOdG5J
 jpXq0TdytYjw/rmr2dZBFdBeuHPOnWCe5FapKmhEZ9dTn6vgFdk7a4CYaSdEn+u+xv2r
 YBDV3c8MtguC0iAK+1MOO6TcLzVFuJHhISSAYfg+cLpVsV362xNnn+z0ZSsCaVHrBHmY
 MOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wN7/ochuA3RrV+dIoSCxUIV880Zw6YJf9LsKHBSMA0g=;
 fh=0veFT79CiSOcOldaDcjKZ4h8J0gM9Ol8nAJRYwPMAcI=;
 b=KEhv46B9xGFLdGLCHiyTsKeg9dKp7tLdf04eTDIJWxasLKdE+Vib9l7Z0tfnzGiMtw
 V+ElldpqFmXl1ZwjXpJE4tZW6bp8qhTOoIdiyH8yi0FfPMzg2sb/9H6uuLLqwmVpwhxK
 +yFnmMxZf/oM9JkyJIZ/TQJLs7hv44B1Til96gr3q70dIYj2UrM6ip9RU6ZCqFPztGLR
 UrKDd8TS4dRDjuTAVDtk2YlvZciKSNpiE1ZrEldKntxrX3qXk312nTdgW6zchJcI5gaQ
 LQnWUn/66UcdRoNhJqdZE1h6JGDJiw5Dl4I0WR5A7pQn8x7WOiHxstSAQPOQzFEJN1cd
 S7ug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778530465; x=1779135265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wN7/ochuA3RrV+dIoSCxUIV880Zw6YJf9LsKHBSMA0g=;
 b=HMlHfFbM5jTZWpTuUAaSqajiPPtyWi2kkRaoAoSndeUkhv9pwIZ7VGUJSKo5qfNCrS
 imScLoXoj1o/ztvygZJ/SO/5vyYz8QmhfvmHjEWT1U9W8c4qABDGXSm67rM0j5fjmlQj
 zP1AK6RYtqWpd/tYMTeh6f0gyHyAm4dA/iXC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530465; x=1779135265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wN7/ochuA3RrV+dIoSCxUIV880Zw6YJf9LsKHBSMA0g=;
 b=FgHKK91FFwYQtkwk/YhH1TPg67mowCRrv/HLxC+AP1b5V335Y8j0dtT5YfltSNaGDU
 2BModGK1rG9VlbIUCpIQ0oJX8acc0ZKMaJQrMAQz5vIqisQ7DjgiAkkEwYF4iPNJjiwP
 ImsoeucHdFg4Npoj5wuI75h0qnZYyCfFpO97WfBpfJbbn/ImMKQQzjkiMA1mSBu7+4St
 JGnelsLGDyLvtb0VcI2T8tCuSr98MGcgRIyn8NXdwPidwyTfcpNTIjt2YzQyCosniFTs
 q74hKnhxw0Gx6AiG25a2PG6Flh2HCxJPEyznEZahPsdE4CBtq8uA+2y4CnDg3+dykLWY
 6i2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8YQ8ycHT1Bj33wTjXyn9YKNy6/7JG4/9vEYcXRN3B1HNVVKBsKna2xDt+5PdkbcrH3ESbvuw=@lists.denx.de
X-Gm-Message-State: AOJu0Yysittha2B305hd506EYVOglpBWvfA6hpgEWWNOVPH9ytyHPzEN
 TwZcEoQVd15dAfPzpmI3FcqyeL22pcM+HrL/YH0NLN5Hz18NiJp4a7GJ1zRQ9dlXnir6rNajHic
 7ddKXgG0AyKGOfE8+/4mQirS2eQSB6MG7moSqGWqS
X-Gm-Gg: Acq92OHuOobIbJplDWQ+BQrWIWoachtouOJgf9uSeBIh0BWWD4FB+emCjQz3/mY54ap
 7RQDgEkw+YAGJYEVf4kCudCBeEydus8LMJDmsZXQAX+uO1iSV8LT3zMcysXNdUSaFn5DqmOV7+P
 G1EIw2ATuJwocTZvzCra/ZIIyep6X6RIc7iehzfpPL963l3aHBuLr6EO/FpWdXVfFpwj4GzXsgV
 skJSxJQgZZN73WmnIUjpX5ULdjK0Cx/RtU51dk0MqEdxxaY8So4Ozx/QV02x7jeu4Bsaj2WoA97
 OLuvIA==
X-Received: by 2002:a17:907:849:b0:ba6:4e0f:e396 with SMTP id
 a640c23a62f3a-bc56b41ef3fmr1399294766b.12.1778530464670; Mon, 11 May 2026
 13:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260420164725.359539-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjAqjEtnLb1Ns7fLp7jt90XSfOwJ9iyG55aYA9EWv4fWQ@mail.gmail.com>
In-Reply-To: <CAFLszTjAqjEtnLb1Ns7fLp7jt90XSfOwJ9iyG55aYA9EWv4fWQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 14:14:12 -0600
X-Gm-Features: AVHnY4IB4p8e_T02hOXxfibiAcKoWkgilO79lh2M1L0meLuFAzMGkXxjoWNeLPQ
Message-ID: <CAFLszTiDjeM31cDTnjgva-hwe08jve4amEyd4WOd+ZxM9Tjt3g@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: fix initial RSDT and XSDT size
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Roese <sr@denx.de>, 
 Saket Sinha <saket.sinha89@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 21 Apr 2026 at 16:48, Simon Glass <sjg@chromium.org> wrote:
>
> On 2026-04-20T16:47:25, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> > acpi: fix initial RSDT and XSDT size
> >
> > When creating the RSDT and the XSDT table they contain no entries.
> > The table size therefore must equal the header size.
> >
> > Without this change a NULL deference has been observed in
> > acpi_find_table() when running ut dm on sandbox64_defconfig
> > executed via sudo ./u-boot -D.
> >
> > Fixes: 94ba15a3f13f ("x86: Move base tables to a writer function")
> > Fixes: 7e586f69070d ("acpi: Put table-setup code in its own function")
> > Fixes: ab5efd576c4e ("x86: acpi: Adjust order in acpi_table.c")
> > Fixes: 867bcb63e79f ("x86: Generate a valid ACPI table")
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >
> > lib/acpi/base.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

This uncovered a test failure, so I fixed that up when applying.

Regards,
Simon
