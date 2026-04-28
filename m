Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B51FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 17:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C029F8465A;
	Tue, 28 Apr 2026 19:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dbo6P9TT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070CE84662; Tue, 28 Apr 2026 19:49:44 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D70B845E3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 19:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67845996252so9940695a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777398581; cv=none;
 d=google.com; s=arc-20240605;
 b=ltIxYXTh7kJ69oDYI4viVAcoByWivH9E/N0qGcA8aKHSfF9KtQv53UjgOE40Tx4eTs
 NRWdRLSPwzTgl75bzw09NooEXW/bPrh2tF2+Uw/Uh0ECOtWaYBer7xvVmAXmokhLhkg6
 6H7owqwIpOGc0BWN0EfFHHsdOcKuKsWlziUyR0+t46otV2zs6TNebyWTOxH9QX8/jY/D
 5SBVnBHnzjaopSs3SP9vh2xqw055PT+k2+vhOtL8I2Zv3KuD9BZbOWu4+h5S1tiRJq5t
 7zODhCQGPRx8fmUWJylaAivjvcYwmGpzdWKOriOxUCKtsMyiOLT1E8ZxC8mID4yvshpG
 VIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CCE2n4dwGq+KwCRhki+37PUV/mMQ70OqX3uBxcnkZCg=;
 fh=pFMYuUCQS2Qz6N1SFX5dob5zji0yi5jFd5G7HT/pODk=;
 b=k+nuXy+HczSKgHxTFWWrJzNFntncadhpNruNRo/CnOn5g+pz7EO1TLFnd3pGodnTbF
 zZEG7abhaXcVdCkubWgur96BbMgBzYFdA+CDUQoyvbxYyhbGXN/Y2u1wzldEP8oYTGjp
 Rzr36wn5n5w6rhGBmSC9lB49zmBpSpCKl2YE3645dBt6BPZxyiLX/GuHDAxirbZqSq7Z
 KER9doe3siunZjVP9db9/FVdyNRWT37/daGfbONHrNr1FRrA+SnRBhpjd2/U/pd3egUg
 9YQ9D2HvUeCuABWOuIl98FOIpO+84P8QSkdkS7zPQ/vTF7SuNq+IaTD2HlXDWqnlwBdW
 Ibzw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777398581; x=1778003381; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCE2n4dwGq+KwCRhki+37PUV/mMQ70OqX3uBxcnkZCg=;
 b=Dbo6P9TT2uRS1CVeHXOdsDFYJ6ekLnQsF2waKkvk2IxEN1UBb6LCEPmPhwcIdnVKHC
 F78xfSOxDalCLpyRKAiyx0R1J0HnDRUXm+FQjh1mtTexbdormhp584B9Jg6PBwXIu+4q
 U2lNwj5DUuh5sSvWamRfTQunbp3/nld6MWYpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777398581; x=1778003381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CCE2n4dwGq+KwCRhki+37PUV/mMQ70OqX3uBxcnkZCg=;
 b=C2XDALRD/C1knGgciT11DhK+GE+csECV2VEq8lvPJPr4Ph7AyEqbhsipsv8KdFc9XI
 UNdt+QqcGcRXBQUeKOrzA9DOy0v5FKn3IoFgHkIktDXV+XyQ0AtF0SpCrAXDKJ87f+ii
 NNWVx/AWsBDasqccUpPAGhTMZUCo3aaz3ar0+rAn9gRyBFV290ZDnRGEGpSbGntgWq8K
 IvOChSlNmGPWw8ef+DJMLKUJY6ad5bowgbi6UUX0vHop8TjHEPeKOUNwekoGqIBLd5rB
 apJ4Gha7L/twKFyBTpVK/P0CdBIVaEITZI6M07oiB/Ku2TAenZNxKcIpxDICgGVCFAuu
 J0jQ==
X-Gm-Message-State: AOJu0YyN+DOeqY/YdTIb9ERqKE/qs+4kA6Fwlh2TRvWSJNXAVbSIs72o
 r4VhTgqw2Ei89e14vj593RIW8ykytLeiAX2VLHpqElCX3d9+rUicA/9yThffbqZzA4oWsHgI/Gx
 Nc9lFebCcQGPvNi2+KqZYj4cJV+5CAE5Mghj9ZdRtzLOJV4XzQ0Q=
X-Gm-Gg: AeBDieuOXtoM/75/YRt+ohQ3+odQBslco5E0GXFNDOmFpcIbh6Ep22yWe7g+x6khKx+
 l2U3ABtZc1RmaiBXY2pwS+ZZavziOwhWaiWgdL5N67UXQUAXemkBbEz02cwSo6dB0MbNNTmb+z2
 e5x/5gVt4Be/QBIaZpzggIKdfOpKq+i3B/u0t0n09xmRoPEKRZwiWw9X/7vnDuNcyjBHp+Ik7Jx
 +rNvpxNnkXV8H/0SvQSqlZPHVZuAPIPiucLMgyqLlKUbnsb07/n+rJ8UigTE6ABxyh+18EnxLZX
 0nquec10npcnGX6Z
X-Received: by 2002:a17:907:a80b:b0:ba5:9407:92 with SMTP id
 a640c23a62f3a-bb93c39f39cmr24907466b.4.1777398580937; Tue, 28 Apr 2026
 10:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 11:49:29 -0600
X-Gm-Features: AVHnY4I5Y2W2PMuvAckru2QrSgkxp3uRd73hzOcB4uh-ke89OPfFOPRLYXrwmXo
Message-ID: <CAFLszTj2hm=bGA6N==mt5pC2iyWMdj2q1A1zqPfx7OnMhNYAyw@mail.gmail.com>
Subject: Re: [v3,0/6] Relocate U-Boot in the last bank
To: ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de
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

Hi Ilias,

On 2026-04-27T10:08:21, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrot=
e:

> # RELOCATE_LAST_BANK not set
> # RELOCATE_LAST_BANK enabled

The Kconfig symbol added in patch #6 is RELOC_ADDR_TOP, not
RELOCATE_LAST_BANK. Please can you update the cover letter and the
bdinfo annotations to match.

> Patch #2 - Introduce fdtdec_setup_mem_ram_top() from Marek

fdtdec_setup_mem_ram_top() is added in patch 2 with a docstring saying
it should be called from board_get_usable_ram_top(), but nothing in
the series calls it - I think you should convert at least one
board_get_usable_ram_top() to use it.

Patch #6 moves dram_init_banksize() much earlier in initcall_run_f() =E2=80=
=94
before setup_ram_config() and setup_dest_addr(), rather than after the
reservations. That is a significant ordering change for every board
with a custom dram_init_banksize(), and it is unconditional (not gated
on RELOC_ADDR_TOP). Please mention it in the cover so reviewers of
board-specific code know to look. The Tested-by tags only cover a
couple of platforms.

There is no doc/ update for RELOC_ADDR_TOP. Given the 32-bit DMA
hazard, a short note in doc/develop/ explaining when to enable it
would help platform maintainers.

Is there any way to test this logic? We could perhaps have a sandbox
test which tries the various combinations of RAM banks and calls
functions to see what happens.

Regards,
Simon
