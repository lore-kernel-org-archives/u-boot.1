Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414CFF8D775
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 19:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8015283EEF;
	Thu, 16 Apr 2026 21:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZXm+dHuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C252841F2; Thu, 16 Apr 2026 21:36:34 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6025280086
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-672bd7d00bdso172658a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 12:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776368192; cv=none;
 d=google.com; s=arc-20240605;
 b=Q4FTjN1vQsRZJ4c5odlT7dvUwu6Rq4lCZofnW8cbnW++uv6dDY0NCUnxNMminO1A0f
 LXbHsyay40DaNhukQeqsFKJYWhVhY1I30a3WG+IN+0EtStYMmaO+agPBDQToq54XgMZP
 uk8pDCs1r1+HaTeKto/qELeJdIUeFoPK78Ulc/blTIUfhwDITYD2QneIzXf0eAG2EKpO
 eT1EmiQvoIMtdib7amUHzmUGxSt+AIdD0GVvQb/Oetv6z+et+P1CNLA0nPar4CLPQtax
 RW/SqQSEMVG6AzdGqGk1NFNsXh/xZLtetxqyLSGjduwhE2E+iS9n/3/lPrClSG8a2lKa
 j7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z3NhqLS/9XedvHvU4LSaUDbGntd933Usjc4Mky+SIRQ=;
 fh=1GDjmpAREd9sK9zDNvgAAkWKiaYXwy/vI7ZDvQ2JZvk=;
 b=NAlDf5vo/Zm4XTKrGvNfAmOMTx1VH4znaOmpxVUmPEjAy8cHjCYS7JpIp95vyy2s3J
 wu7w8cFL1yqwHjB+z9l+2HpqfBbL+k5KpjtOlrwwYH6takW/cxQUZwsCFrdrsete3sDi
 uIjNpF91QHnhb3Oqrc9TUPkohDd/XrcJ+9fbUj8RS2I72sIZzvrOWmSz3MkDFlAAZAZL
 a+avS3Rofo9bVDakJMNwVrH1E1GILFjXTrTCDzwg3UmqLRBlwj59zl04NQbj1DUPod4R
 5ZcQ2z26IeUQhj4iim4BKezQTKaq5uM4oSQ/TDXJ2LMfjiG0SNGVqgM72DfJq/Lcr5FX
 wB0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776368192; x=1776972992; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3NhqLS/9XedvHvU4LSaUDbGntd933Usjc4Mky+SIRQ=;
 b=ZXm+dHuwlI+abKujN22+bKpopcx1e0yAv9dMC0KIsV28UdD2oBQZTLvns3Iw5yMFQE
 1NqrU084Fq/BUrlNjGyLT8OOhREgEWxhnEAEDO3ChB300v8t700hnFbNqiR7Fghfez2B
 w8TotrCPz0UxdjNAmCuAfoLRgO5jWxG2hWZHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776368192; x=1776972992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3NhqLS/9XedvHvU4LSaUDbGntd933Usjc4Mky+SIRQ=;
 b=VgF/bFWe4QXCB+QT3ofhVVpDoCNYpMnc4TgySQILmDhzng3dtnOgRpTrMqHUvHTq7p
 ldtKdY3v2onX2pY/9BkRPCgkgJSSiPRR1mz2tDlALMG/1QMmdhyP9weXs+ubT2ySXXHq
 5U/a6wpPv9rRRMDGn3oZM1g3UPEXLn3JfPtYDJkayl+s6OK9RCOsk4kWYgchbyUfQWjW
 GObtCJ02hIyolj0w/uFt8Fd+eAV4pguCU1HVgdpZMo41kr71YLWNFBKY7tBs9+xCHBHz
 RZq5oRWpuWQDn4Clj3UTKtQUgerV5u7aQvvDJJqrwo0Yx2m8fOXWz6OggGZUXEK61XNY
 6Uzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kiTWdg+Lvk8TdRgSZB+wMIenSarMhgAjSZHo3zFhNBi6hvRLHW8GwCvuryk+lJ+NP7H9wDjY=@lists.denx.de
X-Gm-Message-State: AOJu0YzJp4uif+HNCq7VWq5+tDOnmEueXHtUc5zRTbDI/3/1XVd6xZxu
 CuVcW7FMZTq0S98z2m56NqnRwgcRsjJLKBEzszXoYwDgQWkzrVE+eLRqsVd++uYn1MAKgxd/TTd
 pju6om04Y5xCpNDdU1ZyWDwwqTteQ2vVvZJOePAKE
X-Gm-Gg: AeBDiet75x51ZdFhnck53X5hSefIA61fD76epmOCK70av0G4VHIRI8EXLBGfUmzxacC
 BPkPrZHwg0hz88RcMLPnULClomWXCpycBCsVXdd/NJTY/gtqeu+JqZ30riBIvGefBaPFYb+M0we
 eNQjP/CKQPPTEFaFzPQ8c8jpLA1Oy+0gPdlMtRvr7sd2qSAQjngEbwbaqn9a7uAj78byIQRb3Vb
 Z+e4v7TINSHyq1aaPOGiZHa8K/sqopTsFjvfLHa8eGJ6Y70dKzsTJ1i+sCyUBueZjepiC5NtOiD
 B5czcAvZfeg+9rwXgCX5
X-Received: by 2002:a17:907:ca1e:b0:b9c:7ba2:4168 with SMTP id
 a640c23a62f3a-ba3dbfa3b3cmr33226566b.22.1776368191667; Thu, 16 Apr 2026
 12:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776302805.git.daniel@makrotopia.org>
 <9ceb70fcad4dec6efae1b03297f38665926b6c9f.1776302806.git.daniel@makrotopia.org>
In-Reply-To: <9ceb70fcad4dec6efae1b03297f38665926b6c9f.1776302806.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 07:36:17 +1200
X-Gm-Features: AQROBzBLcMlOH__2jB2VZTYEujRwuc5PY9q9rEdG_RVXaimb2WqKNV9q7NcBDuI
Message-ID: <CAFLszThhPE9SPOHhjcukPUDsg4Yf+GtPhVWeHdsnKCQE1ysOSg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] test: py: add mkimage dm-verity round-trip test
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
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

Hi Daniel,

On 2026-04-16T01:46:15, Daniel Golle <daniel@makrotopia.org> wrote:
> test: py: add mkimage dm-verity round-trip test
>
> Add test/py/tests/test_fit_verity.py with two tests.
>
> Both tests are skipped if veritysetup is not installed on the host.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> test/py/tests/test_fit_verity.py | 153 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)

> diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
> @@ -0,0 +1,153 @@
> +import struct

The struct import seems to be unused.

> diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
> @@ -0,0 +1,153 @@
> +def have_veritysetup():
> +    return shutil.which('veritysetup') is not None
> +
> +
> +@pytest.mark.requiredtool('dtc')
> +@pytest.mark.requiredtool('fdtget')
> +@pytest.mark.skipif(not have_veritysetup(),
> +                    reason='veritysetup not installed')
> +def test_mkimage_verity(ubman):

The test infrastructure supports
@pytest.mark.requiredtool('veritysetup') which handles the skip
message consistently. That also means you can drop the
have_veritysetup() helper.

Regards,
Simon
