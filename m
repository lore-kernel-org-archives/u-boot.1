Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4186C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4084484AF1;
	Mon, 13 Jul 2026 14:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VW32f8H/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEDD784AFA; Mon, 13 Jul 2026 14:41:55 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76D384AE7
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so3895623a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783946513; cv=none;
 d=google.com; s=arc-20260327;
 b=hzBbcqAsjOt9gqnrvzduJU66eYTCzsLQYdJU8mqLkTm/ICFHmpNHJ8iGOLgheOOMl7
 NmkFJd8qn2gegTXiVNfY3ZizmPxBkonHIrXyreVrzRbXt+uFxm3fBHyrYDqUFOL4KPri
 sz10weAsfj8YsirLTMKgUB1oZDXHH+66pyVCCA7PGryZrE4nhU3C+2+VZMGrxSJe7/rN
 FEt11f9ZhdN7RyGSwuwBwyUAWJShuhOaLeYov51PUPoIvBFtNwkzhtxpXYWs4O2olA+L
 mUa+TwTOQyZPetgm+F3Lhh2i1i6wEvknKaJb9ZchJfC7GaLBddbhxB9grQcmYvVzL2QG
 N2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6yGxh6g8FHREMqOXeOcQuaeaUu0hZPnppYR3/49HlQk=;
 fh=CcuDZmTrATCCWiOVlvhRNk3dyUsaw1UrvxWB/NarpSo=;
 b=AtGva6RhwyvPSCX83JjLiO3uIYMoLDxfw3wVVeDsqCVziJOc6sbuAb0T7vFxrVXIdZ
 6BOkkxzFXIG8epyeiF5iUrJwwpsAhL1QMiH9in/TXYuYU9HWeoizVHqF5+BolHnduJEL
 OIvTv+/3Kds5lDIxhdUm0bfevCiB5pMPkcyQ8nsb8kp40Tmi3ElZkKXz2jT73hX61yoF
 g1VbR+UvSiDDHzqNNLWoiwCNNKM+Q0Mwbm4Sbu0YKzecdJYXPQRzwySCUVyCowkBgFln
 SbMfh/LviuRElwwiJm5z7DDh6YOMsSztf8MwdHFhLK5f72AZi9BUfeQ5x0L1KZd4rUp4
 3tVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783946513; x=1784551313; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6yGxh6g8FHREMqOXeOcQuaeaUu0hZPnppYR3/49HlQk=;
 b=VW32f8H/tVtcOrjQMO3CDqzu3pwT+Fpnvnelse3jpSiKBy5V1cGok1ZRh9IQi3/wOR
 m9dRSZ+VpMqxD/D2kSLVRQBBf3tX6VUe9aej8sFMmeSikYgJnzaywDmS9xNKqH6whZS3
 uxp+U6PipVf1AXuaQFUhc4QimxbHgalXW/8E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783946513; x=1784551313;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6yGxh6g8FHREMqOXeOcQuaeaUu0hZPnppYR3/49HlQk=;
 b=LQCStN9tbJenqz0EVu7g6Ly74jZBKV5Fv8AvRmWHx3pes3W4H5vWqUuey2B4rEzLow
 DD2rHNWHDojV2Ng72XqdPop+guoemWF4X3k9dvO9WXwmqSYdqOTDxODjcaFOniYHhbev
 z5UvBH9Pm0wsAb49EkdKl5Vu3ShzWGwtcffbm9ZL6Yf+7MQYHKMUPw0BrMEWrh78oHLv
 MJHTFB8nLTdlDTl/hB76I5WwicwEAjD7v1T/sgGaTwgPUYhEayM8fbYImEpeknBEKacj
 rPEmfDb1o041nT3Gp3CZJSWVq3eR3uu+9refobGc0RKKb6xnXjnNvp68t+sb8bz9PCZL
 AbUQ==
X-Gm-Message-State: AOJu0YyOtVnnQD7CxtW709PPSPX7mZPznb3nxEsUyUPuz/d1hZAiBPzB
 9MBDbVIo5Eop8I3nink6+6EWt7KQcJqGp8gxqQhXodHTkgNL6xDNMIls0cO+MTBX79flwNzFHmm
 fMPM4vHmodZQHLIYXOg3wMgcZYjKBJzypXC3iFl1x
X-Gm-Gg: AfdE7ckxK9AY1eT/m2cdo2lESxBICdmKeDfUY3s9c0TKrYnoGaFvJxzt+GwNTCHnJs6
 pBDw5IdzDXR85/elFn1n73M511LeHg3Z+YJDbg75KCmhDh+G6zxTXntSInolUN+4XvLmTgXGPBU
 cLzSadV+4e31MU96VOzciRMBwm3W453sw/7Xs2jxTHTyVwWxJ+VErG6i2JRkomLmsUHkFGKj0wK
 d3R8TKeBVGPbNw90l63xKibymnHONNxpF/VFnTlBZ6D00N7KbfIvqob/Xrz+ujPy+Dp+pU=
X-Received: by 2002:a05:6402:2106:b0:698:3b7c:7e50 with SMTP id
 4fb4d7f45d1cf-69c5f266cd3mr4216534a12.38.1783946513314; Mon, 13 Jul 2026
 05:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <20260710123618.2036728-5-ravi@prevas.dk>
In-Reply-To: <20260710123618.2036728-5-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 06:41:40 -0600
X-Gm-Features: AUfX_mzivqjEw4eQRi60WgKFX51e5ZJsbGJbhD-6YmEZZlxl-04EZtvdcwYa6zo
Message-ID: <CAFLszTh=4fWg6L74vnaJz7O9kOxE68XP3BCJEWVnBvc1aopHJg@mail.gmail.com>
Subject: Re: [PATCH 4/6] k3-binman.dtsi: add keyfile_template node
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi Rasmus,

On 2026-07-10T12:36:12, Rasmus Villemoes <ravi@prevas.dk> wrote:
> k3-binman.dtsi: add keyfile_template node
>
> Currently, it is somewhat tedious for downstream/custom boards to
> override the keyfile used for signing all the various artifacts
> involved in booting on K3 devices to point at their own key (or
> pkcs#11 uri for that matter). One has to have overrides in one's .dtsi
> for each and every ti-secure / ti-secure-rom node, and a lot of those
> do not even have dts labels, so one has to use their full
> /binman/... path.
>
> Add a small dedicated template that only contains the keyfile
> property. In a subsequent patch, we will change nodes that contain an
> explicit 'keyfile = 'custMpk.pem'' to instead have this template
> inserted. This way, the downstream board's .dtsi file only needs to
> contain something like
>
>   &keyfile_template {
>     keyfile = '/path/to/own/key.pem';
>   };
>
> [...]
>
> arch/arm/dts/k3-binman.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> @@ -25,6 +25,10 @@
> +
> +     keyfile_template: template-keyfile {
> +             keyfile = 'custMpk.pem';
> +     };

This looks good: since merge_props() only copies properties missing
from the target node, an explicit keyfile in a ti-secure node still
takes precedence, as your cover letter says.

Since the whole point is discoverability, please can you also mention
this in doc/board/ti/k3.rst, which already discusses signing with
custMpk? A short note showing the

    &keyfile_template {
        keyfile = "/path/to/own/key.pem";
    };

override would help people find it without reading the dtsi.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
