Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8028FF41808
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E816D83A8C;
	Mon,  9 Mar 2026 16:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zs/CPKHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A664783A8C; Mon,  9 Mar 2026 16:48:34 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C752283952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so1877741266b.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773071310; cv=none;
 d=google.com; s=arc-20240605;
 b=fcbuuRzauLn9oJ4c4tHvi/OVeMIq3ofM62mlSI/IxMHFZabWXO53cIf5k8tdjBjO07
 /lq0JhmFriP2m7dTjjufR7sUoVHpZ4qp+Ae23i6nYnRO7jmstF+WcZ/IaQ6zh8t/xE9K
 8ZqNcgCXUmmfelvJljs7oLiVQo5DR1sbLikQ2AHITkpiaNw6DIU7QeCNjRcdSnb+Vwih
 2HjjXFrtWtPs7afFog2F9ZGLbWt239I9LbRuTreaBKMtJ7YuLt3LD+Y+oKKCEmQVMJ7f
 pKBonyy/z6eMx4+Xmuv7x0WzGNHEkbPN/TmFipb0NkmK8EQd+7crjAFPeJKm5PDM6J+d
 Wiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b2OUUFSmGbu3dqUEVKEELAfduu/bYQ/Vn8zKpHySMFU=;
 fh=up0zHCCNwW0ZFtBGuVKBG5zPGJEUx8NZHjRKjuMZiDc=;
 b=arsUW9pVeFeezIOuTOwS+8A38eCGhfwjHl8kBgkAftFHdumpgGDDNa3cfG7sonA0bw
 MpF8dEKCT65XflGMYrzb+TdlzwU4YCVVl1KbMvmTupKF9qPFbwtO5g+up0gtfXn04sl1
 yR9m3VLLTSSCa17VpCRCFx7EN5ZzyVd0CO+YDlojtpphtknppR2BKiGhar0haLVmQiR7
 zOYiHigagfUYXu5tjGHwMIUT4tf/g4e5fqpagcEOLAqfzVGIv5RT6UazlaJ/hO+YGBBF
 OpsRiuhMn6lPKzbJBDC6flPGGSipBFVJYfju1gpdDaQoOnyilBHQdHossUfc0o82Ndyd
 gsWA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773071310; x=1773676110; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b2OUUFSmGbu3dqUEVKEELAfduu/bYQ/Vn8zKpHySMFU=;
 b=Zs/CPKHIkfcGOmT2dkpzuGgbLg8PaAczl9/cviXJrVSVGkQ6LKbIiB9l/Kp+g1vBWs
 HS3gJhhUoHNb/FbF+6xvcT5frn6SEiWtlUADnY27IAzKaYDOu+0fuQ565Guo0DGMgDk6
 FDJ0aEBPVjyrD+g4kpXy5E1MrwIYSRXtmHr4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071310; x=1773676110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2OUUFSmGbu3dqUEVKEELAfduu/bYQ/Vn8zKpHySMFU=;
 b=KvM7yKuktcUrfJilw+ie61polYFIr5EMhKShDnmJJ6mg1UPTnChpgy/Jh/Yykf65n+
 wYuYtJ5Ij5Y8YlOWQZcS07/iO02NVKbYncXdYO0hHVCXj/cR9+OaNpcK2n7aMpz2F2eR
 2G148wdGK5SHbkMCzk+sAEpqgd8GwhAgca8W7pjue8q/07hxfg4oYUUZY2zQgDWfZdT0
 H1mzUtzsd2jBIkMoGIfN4efN5WhqsviigiMWc4rWEtWhO1TNhau1u+WmSBtGCvEJyQ5J
 wo4PL9Hft8VeF8LdzrGH5Ybis2P/G/9/X5uHVkAZS99STOAMHwjf0W32SnDRfPuDIUp0
 M4/g==
X-Gm-Message-State: AOJu0YxCiivzwmXtcKWmNxh4QDQ7qbldEaXjjYTZjITf5G1L785qn1vf
 g1ToptZMl+pdjmy1FMCiF4nfoJZzu9jlLbWD0u401l+BR7keuxNE1kEYF6ggvJ43x2f5X8gJzAU
 jgpWZZGhpVUOfFRUr+muNrPbdhzeqMHmvMuW8hT/+
X-Gm-Gg: ATEYQzwql3YR6AGNYOO75ktAsk3MF4q8+aIuuPqAkFRs7bQU8SFttcq/mcIUDoYrbI/
 PMjDFslwKrlWyZwTcbnqXB394HLrIPkXuzmi4cV5nPBfGwtyuiNjef/GJ/C3cddYnzx+GgxXF18
 8CqSTrw9OeTE3L3YaKkVIJdB368opmF1E/KnTXP74G7fsHr4iVLYNhp18yYjC0YCVDRjr/gyLP2
 Eq2iBmLercrvQtHmEt1WNjQ32X68HTdGEuNQ2CG/aOWuck+WdMiwbqXvUxSKJEURZ3hBRmsS5e8
 gJ9XWA==
X-Received: by 2002:a17:907:94d3:b0:b94:1a0b:d79c with SMTP id
 a640c23a62f3a-b942db91f32mr686506066b.21.1773071310178; Mon, 09 Mar 2026
 08:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260306012019.800588-1-sjg@chromium.org>
 <20260306151215.GM1388590@bill-the-cat>
In-Reply-To: <20260306151215.GM1388590@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Mar 2026 09:48:17 -0600
X-Gm-Features: AaiRm52ZcynuYFW0b-TZIKwGUZSVo29-c8vKz5gF7XEUya0l9rKK4aceVFMbpro
Message-ID: <CAFLszTjmP_41AZ_zUr2_b-B8zgz_M1d1JUJ+q9vwsQT1yCo4CA@mail.gmail.com>
Subject: Re: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed
 node list
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ludwig <ludwig.nussel@siemens.com>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Simon Glass <simon.glass@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On Fri, 6 Mar 2026 at 08:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 05, 2026 at 06:20:09PM -0700, Simon Glass wrote:
>
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > The hashed-nodes property in a FIT signature node lists which FDT paths
> > are included in the signature hash. It is intended as a hint so should
> > not be used for verification.
> >
> > Add a function to build the node list from scratch by iterating the
> > configuration's image references. Skip properties known not to be image
> > references. For each image, collect the path plus all hash and cipher
> > subnodes.
> >
> > Use the new function in fit_config_check_sig() instead of reading
> > 'hashed-nodes'.
> >
> > Update the test_vboot kernel@ test case: fit_check_sign now catches the
> > attack at signature-verification time (the @-suffixed node is hashed
> > instead of the real one, causing a mismatch) rather than at
> > fit_check_format() time.
> >
> > Update the docs to cover this. The FIT spec can be updated separately.
> >
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
>
> Thanks again for looking in to this!
>
> Closes: https://lore.kernel.org/u-boot/20260302220937.3682128-1-trini@konsulko.com/
> Reported-by: Apple Security Engineering and Architecture (SEAR)
> Tested-by: Tom Rini <trini@konsulko.com>

OK good!

- Simon
