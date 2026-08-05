Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7618C55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D66D80E12;
	Wed,  5 Aug 2026 21:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LA7eo2aoHOo3; Wed,  5 Aug 2026 21:53:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40F9480DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785966789;
	bh=fMbVQt3vlvjz8zudhKAOx18EB46q2+NpxC9eFAMcZrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MgQblo9KJv0747F1/S6xTw5SHJBK+UU624ahEYBkImdrXv88wecu/M1FjUwVvsimD
	 +TQuo0ObExluclW+j4taYGv8I61X5z5dG3iaPWMIRG0vOyFGRvl25BhmZO+bY9/aiQ
	 XeuAEKAO1tjHrgzNyqdo40BBLU0YMurR2vIU6X6xaoRL5pG8HlvVbuNr3dv8SHDZna
	 Q/5864c8YFdHa0t5niOuN2XqR0oNRRSS5ovHBCDWFwgsSOIEJF9AwtGyviwS5kxo3u
	 /ZEvQVC314LApdL7hRBZ9Y8mqsXDIuy4KPwWEZbarob5aeLe2/qOk3WugeNLrENEet
	 mLcnnfSfLhjsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40F9480DE8;
	Wed,  5 Aug 2026 21:53:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 568F62B6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CCDD607E8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-elH8IeUsEI for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:53:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4771A607E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4771A607E4
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4771A607E4
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:53:07 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso2341759a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785966785; cv=none;
 d=google.com; s=arc-20260327;
 b=EqKHlNsq7VCMzTSmp1ICK2wW3Z3JlAHntnj3TEzORXoPmohWgD1SV9wqrTVJGyvxMv
 xwsOEGzNV3CNrc1/GWPWcTdrrzyOJIxDFN80f7ZSFYf5eu4EAw1cXHaoJn446MWbnZae
 uSW66xO5dW4lWtOMAJs44+jiL2D67MiYeuVp30dbeCC0bM2FvlFW/WV7cvfCkm/6Q5Fv
 /R2ZFu4jI88G89mJCYDufo0pBC41VMESxYWJjMh5KAZpDyLAFlLpRXnuxPIeRmt8Ogs/
 NYyShDy9bvfXmz4QI98Y9V3SH7FY8lG0Bcio0y90FPMojIMohFBPTx3Gk/DvpJwaYzmD
 TH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fMbVQt3vlvjz8zudhKAOx18EB46q2+NpxC9eFAMcZrA=;
 fh=eybldZBXeZ25kcSUWgn0EFj7euTPyUYAWUYWgJkJ5MY=;
 b=ZcaXD7Id6CKhEROtFeFvMMYJNURUuyxJMs1uUb1W5sKPmSBKG3WgbVoFdezp0eVdkE
 9IgRbiTi4JmziOqoEdKExZa9amQGJC6SZyLYWEmARXpFzDjU4W8tRoFKNfUUyaxpXfVU
 u6ikMFs+AnCO4iynpytW4sbWss1jzxqPBeElxABiMHVjKenCFHyWIBr+F5Q+VOw+R4hP
 vHoZdo5v8l9i3y28EXeMZayWjgcucN4n9ok2z5TvkIgbxD9NL8c2szycvSRwF6GBlKGC
 r/Q6h+QFNcRsYc419c+W4UChAPVbULmNkqLheysy8n5Sqg1KKf3orBS22hrE9/wzmAON
 5pvA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785966785; x=1786571585;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fMbVQt3vlvjz8zudhKAOx18EB46q2+NpxC9eFAMcZrA=;
 b=nLAoK32UCIqlciFHhKm7CzjWiyAKkujX3dvXC1PAnMRWO/yPBr2PopPy6c3VRWs6Pr
 tp/K3+35SDznQvinchl5rJEXL775qNaJhqILHhIhSb/nLizStWZR5xaC4QnyskOJGkrw
 uNTSJuKlzPrB/iy+BTovZkdYnr8g8XjDlFrk+G0kCOwCWOrZmfLGBh4nWtLJTEJ5gS+T
 EauyFvegkKa1zbf5XejiNqDABalZAcMANfivYSA2q3uB5qmJcSWelkQ45KCKNFBJIQNb
 5QiJ9WKTRwnQAV9LucgknuaBHOleOWlFMcOVMrsXt5ZNI0+cvsF+pdvnIHQnEIwVRkm0
 MJAQ==
X-Gm-Message-State: AOJu0YzrOwg7CoscmlKg32FFE1I4qQ6S2GJgSOzxCf3F/B7e0M076N9Y
 e/fNX66IlyYjP5NtK/imUOBaFy6RFysOoelA9aXl2QVK/8wGrUhEqJzTxIRo7xAGK8SVTXBCWGE
 GImc6QkAe2RAJfV47kp1OXt7TlbtzlqjS0G5YW5lP
X-Gm-Gg: AR+sD11bAylJ9lMQ/IygyLgsDrbZY70Is+Z02CXQ86y69Up2pG+5z2K+Xaz5OGPKErp
 fG0q57zps8qc/msA2fkb3pvNOmkqri4L7ZHpBnTUUGWNnH1OLp7Pdf+YhBQz1pDyyTYCnNQmQNL
 I/SJkGEjQO3PrGKgn67l7zK1fsGTWfwWOnbs2+ebal0b6B2qh4nV8GSTbQORSKRo2RKkvO5WKxR
 FcNIalrS0h2WNj/4Ks9GLq9bpYG5wA3N76pwINV5yLlchelq/s6Det60j/sYJsSi23Yp4W8uTSk
 I2C/1fop0Ag6b7CEiEIeb4XKdU+ZhIT9+TAeA9eSZsM=
X-Received: by 2002:a05:6402:5188:b0:697:decc:7f9a with SMTP id
 4fb4d7f45d1cf-6a14f0e3895mr5170529a12.9.1785966785193; Wed, 05 Aug 2026
 14:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
 <20260730-b4-fit-ext-data-hardening-v1-3-4a6b91e37b51@binarly.io>
In-Reply-To: <20260730-b4-fit-ext-data-hardening-v1-3-4a6b91e37b51@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:52:52 -0600
X-Gm-Features: AUfX_myrhlmMCbvkcDmWP5XiMWprK7c735tZyflXXKmDIuMFMynzDeQB1RNMIYQ
Message-ID: <CAFLszTgm2hLbxsmc0ynaOOn-OyrUYpDBiMCuR+NneNNXPcrxPg@mail.gmail.com>
Subject: Re: [PATCH 3/4] spl: fit: Harden external-data offset and size
 arithmetic
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Francesco Valla <francesco@valla.it>, 
 Anshul Dalal <anshuld@ti.com>, Randolph Sapp <rs@ti.com>,
 Binarly Research <vr@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785966785; x=1786571585;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fMbVQt3vlvjz8zudhKAOx18EB46q2+NpxC9eFAMcZrA=;
 b=NQ5jfoSL6zu4c97TZsSYfesFZfM5bdqU2+qvzN01Qdn/FrHay4ICHc9AthFOOVX7va
 FvvzIhl0rlzov5n035hR4HC0BdTnjuNA53UL/lc2gNKAOMeMbwUNQ28/U0BEKfOeJNyX
 6cK/yBOcHtcqSLGaLvKCrH7tQctbSOjoCyPlc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=NQ5jfoSL
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anton,

On 2026-07-30T15:03:40, Anton Ivanov <anton@binarly.io> wrote:
> spl: fit: Harden external-data offset and size arithmetic
>
> The data-offset, data-position and data-size FIT properties are
> excluded from the configuration signature, so they are attacker
> controlled even when signature verification succeeds. The offset and
> size arithmetic in load_simple_fit() can wrap on hostile values:
>
>  - adding the external-data base offset to data-offset can wrap past
>    UINT32_MAX,
>  - get_aligned_image_size() adds the block-alignment overhead and
>    rounds up to the block length, which can wrap past ULONG_MAX,
>  - adding the FIT's device offset to the aligned external-data offset
>    can wrap past ULONG_MAX.
>
> Make get_aligned_image_size() return the aligned size through an out
> parameter and fail with -EOVERFLOW when the computation would wrap,
> check the two offset additions explicitly, and compare the
> block-aligned size (the amount info->read() actually transfers)
> against max_size before reading. Do the same for the FIT header read
> in spl_simple_fit_read().
> [...]
>
> common/spl/spl_fit.c  | 98 +++++++++++++++++++++++++++++----------------------
>  test/image/spl_load.c | 57 ++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 43 deletions(-)

Just to flag - first_loading_rbf_to_buffer() has the same 'rbf_offset
+= ((fdt_totalsize(buffer_p) + 3) & ~3)' pattern...out of scope but
the maintainer may wish to take a look.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -700,12 +700,8 @@ def test_vboot_ext_data_bounds(ubman):
>          fd.write(500 * b'\0')
>
>      testcases = [
> -        ('negative data-position',
> -         {'data-position': 0xffffffff}, 'Invalid external data position'),
> -        ('negative data-offset',
> +        ('invalid data-offset',
>           {'data-offset': 0xffffffff}, 'Invalid external data offset'),
> -        ('negative data-size',
> -         {'data-size': 0xffffffff}, 'Invalid external data size'),
>          ('off-bounds data-position',
>           {'data-position': 0x7fffffff}, 'FIT external data is out of bounds'),
>          ('off-bounds data-offset',

The 0xffffffff data-position and data-size cases are dropped rather
than repointed at the 'out of bounds' message they now hit. Please
keep the 0xffffffff coverage so a regression that stopped rejecting a
UINT32_MAX property would still be caught - a rename to 'invalid
data-position'/'invalid data-size' with the new expected message would
do it.

Is there any code-size impact for this series?

Regards,
Simon
