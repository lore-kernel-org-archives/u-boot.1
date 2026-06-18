Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF5FCD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 14:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E90846E1;
	Thu, 18 Jun 2026 16:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WhAJ7exq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D005C847C3; Thu, 18 Jun 2026 16:23:18 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC1628460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 16:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so1884069a12.3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 07:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781792596; cv=none;
 d=google.com; s=arc-20240605;
 b=BzWTgY8XpccblnVpirrWiJdKBM1JLMhSiVY2urmeQvS0+DHlDTM0ffukoKbD6H0PvT
 jGq0OUKb8clP3e5KmJ/+PEVfjQ0dHeAcYZaj0dbwe/QLVrH8f700+CaFPs/1+FweyzKc
 AkNrCVGJxBkY1v677hHpVJHB53VdxdTTiNbs7H+Ic7m475WZ+bevtUzDG0BACsY1391g
 1pIjBDZhf5I5f2cH1ppFVFLbwDYEy34Go6wWbUPPP9rHbDxbLA0sw4TkPJbBebNxxwAd
 95OK32d4SD01T8n1TBeG1Q10k8/omRlSxcSYlx1TWFkNXQgKFg1DcQ5hTPe83r4vD30d
 mrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X4Rrt10LLuLIpo+mQv7uJuzA/vaWWCU4CSJWy0+CkRI=;
 fh=2KD3Aixmonan6I5Sm7vHXZsTaKiGcYwlYzuYzefAnFY=;
 b=Z+NEwgubuKgLIcxnau9GRyrIG0Q7C2LKgkZ2iuw5h7sZ7Sjx86a93BmYQyQsPq3QZ2
 RVB9fM97ZsswaXAYG0LTP3/n+Vf+8mMwviON1HYS60zst+uWCd694p/WFYU7iLQiERRv
 PwaA6Sm7IAwyvLFy1rEdHIa1x3IJ6SdGb2sl7vgcGP8QvPC7vzECdA80XWP7rPaNv7T9
 kBg+PwGs53fVQp7MSZ0JBuTFl51b4uCGLVx4DOuxr3u440l5WnnGndjMzaJHl7hqXhdA
 4IOPL+Si8aKDBCr4w8xJS0GFG0e5WKhIV9DATrB+AfZLTFrJ4h5BH4zcJaaV+ep0W94F
 r5bw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781792596; x=1782397396; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X4Rrt10LLuLIpo+mQv7uJuzA/vaWWCU4CSJWy0+CkRI=;
 b=WhAJ7exqWO5OQZUxk0CQYQ+qpd+qtzc8EHu2b2dysIR3oX6a/l9NCEb3ddQeqGY9KX
 hh5ZZegHi3t1rsmU3xdFL/p7Y4pUgVSj6OvLE1T3HebBzNGX08ZcAsVxvli4qKLs1h3K
 fNU/It1G+70T7bfVvk3IQFGm6u/vGAPrmuw2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781792596; x=1782397396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4Rrt10LLuLIpo+mQv7uJuzA/vaWWCU4CSJWy0+CkRI=;
 b=ax4qCf/VNC3SX665Iv96Scg5082MkV4FNgJQvmqRlHiX/96UJTX9Ffe49HkDd3hZBv
 /F11hR9Q7kpi9tTUwuItkHBwvvOvZLvZB5IWrzncX0re+yTTyxs97549m/t/UIXwEx7q
 qHPwDxAyDd8uUyqlR5u6dd0czxk7bQZbzatlK9hUgLXJxXMJsAUylTRUI+mEyC8mgmV0
 kYHgvEzQltM0sy0ZonphSb2OSli/swUZGoGUnkVk2WS5bcfKvuMIF+yVsvRBoVD8iYvU
 r+/q2o950K5XGnWD1OVGXtL46GBuNl4h9SFnKi6+/S94IYc1CkDdD1lFZSnN6e+DwSy7
 9b5w==
X-Gm-Message-State: AOJu0YycTB7sQbniGRCKGiFEAZ7af+sfr/35HXrT3w86oXKTQxUvQMS1
 jk6lLKVJFjzx6nIFqrHDpFcEPCOIL5UAfjFcuAEit+rbV+UNiwcMKbueJ3Zmo/FaFNyc8saGSe3
 HSbLf0Oay9Y9Xq9DX2duvaIsagoxbgOUUPVRq1IB+KNBMS6FXfBPbLiua
X-Gm-Gg: AfdE7cmEdfCVDlk3Dr6TjMJIl0ygvVMRsAT+slRwrWKN+qOGHHchi5m2Ey9bZCnEUci
 7QLpaxYiLSWPxolFpRWoAXUlGNsV3DXydhALyth9CIjCN2eIPoDad5ZfCtPuBu2CkMvczV3wn/p
 2IFn7KFFu+Lo4bBL1cPF6Yi8KF0i/CNxcqTUMKRwcCpZlnGFa/Xc/DHsek8AXj6QOnJY9aiA6Tu
 ISJqbuOamBFPQJupbCbBe1uE3mVBtLFMLXWhQql0SEroXsn5URm3p2rhoTEJTDKoiVGqHKbQg==
X-Received: by 2002:a05:6402:5388:b0:68c:d4e:3a46 with SMTP id
 4fb4d7f45d1cf-695bb1c8cedmr2182939a12.8.1781792596207; Thu, 18 Jun 2026
 07:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260605154255.833334-1-aristo.chen@canonical.com>
 <20260605154255.833334-4-aristo.chen@canonical.com>
In-Reply-To: <20260605154255.833334-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 15:23:02 +0100
X-Gm-Features: AVVi8CdIg3E2v8aOjunwpDXzO2kj6wFXRExVX5WSiv6WLZNU5C-9JNuBsFej3Nw
Message-ID: <CAFLszThmb_mB1TLiiUFGEhnXt2HscEoH7Qvhp8TQs6TpO7Ts7Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] test/py: test kernel_noload decompression buffer
 overflow
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Fri, 5 Jun 2026 at 16:43, Aristo Chen <aristo.chen@canonical.com> wrote:
>
> Add sandbox tests that exercise the per-image decompression buffer that
> bootm_load_os() allocates for a compressed kernel_noload image
> (ALIGN(image_len * 8, SZ_1M)).
>
> The overflow test builds a FIT whose decompressed size far exceeds the
> per-image buffer and asserts that 'bootm loados' rejects it with a
> decompression error rather than overflowing.
>
> The boundary test builds a FIT whose decompressed size equals the
> per-image buffer exactly and asserts that 'bootm loados' succeeds,
> guarding against an off-by-one rejection at the buffer limit.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  test/py/tests/test_fit.py | 125 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
