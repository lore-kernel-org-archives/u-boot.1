Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5680CCD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6891D846B4;
	Sat, 30 May 2026 00:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SM+F3Q0Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685BA846A3; Sat, 30 May 2026 00:03:20 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6191884693
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so2171541a12.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780092198; cv=none;
 d=google.com; s=arc-20240605;
 b=eNoRj4BClfXxR/O3a8M7dEKpjKUgs6rSxb1bKTJF/+7mgm+iJjQhJSND+zFOH3f6GW
 gWAa76FY87fnhA5ihnUawqmH5doeWR/takIW1lPAtfNWS8cZMsLXuec5xH3sDDqgSWst
 hmQKuCoRh6HMQbq0hfYE03iaGyVbS3czLhEMzL4tgoxJLcgyCtr3RWUTdJaoHbjH9eTD
 7xupy0blc65Sb4UlwgAf9b9W5MJIUmFUojnL8F5ov4Obnwsfb56m7Q9fJoTMpniQLCJw
 oAmso0fs1jphPS0VHAUDR+mnJG6omnxx3t6PrfWVc+qGqUY0bkP0xYUFE9iVv71b8Zxy
 Pm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=stS3Fdc6iWqer/nQxD+WL4rF5F6fFyH4NUZeGZiGI4o=;
 fh=DC2HASiJfj9MvevuwsjANApa+wuZlNNVi8lVbwpA3rM=;
 b=bBKhTA8lx/+gUltnvEjy1pHbl8y3AsuVIirwBAFl0/tG77+m1gEFxQASl87b10sV7h
 tyOnF2oDS1C4DF8iYTD750jt1ytmmO2aDH1BWHJf80NzDu5ED2LHZPcwURVDfuuICJMx
 CuO0hWoADcOPzN7mzetxvbhZTSHwpoURZ5TX0Ov1VGV/wngo69UNKQJiSlIgpnHHl+1H
 WjCm/xUqsegyw0jIUo0+9vjay3/Hz1WSQ5GDJNPIW3oPC7Q63aieteP5IDmZcYSeOjoE
 eM29NN9a2hptm0ShoENlUpPCGTreReV0eMrS+S/yDpS89BWYIxLCs5zDIgLR5cIQhHTb
 AifA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780092198; x=1780696998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=stS3Fdc6iWqer/nQxD+WL4rF5F6fFyH4NUZeGZiGI4o=;
 b=SM+F3Q0QknuRGhCZGamNEFFYnkP/ZWSmSNoNp3/kPPVZwEBsLI8/gurC21L0o70Tzz
 m+og1ITyMs6054ju7ZveHyj8y9BF6TSdfqlnSB1HbK60IzYFP+jHh7n6sUwstiGXwIle
 wa6ABvZ77hIL/WimMyvbIiV9E/p+uKajJiCvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780092198; x=1780696998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stS3Fdc6iWqer/nQxD+WL4rF5F6fFyH4NUZeGZiGI4o=;
 b=lMv70cT0VipQ5CJZC1fLHhFy+vfi6G5Pmw9e65IHxAsJfK3xp3bcfQZLG9YVqypvYT
 broyFDhCdGaMWE9eIQEw88QPePU380IV+x0wdhUxIdq/edLeLs/W5tm2gc60QRxn10T8
 YGvTobZmRItJXZIyDVuw4dtgTubDZPGk1PXBf158RRAnbmhLK6mGlzCSH27n+Z5bnO3Q
 WHQvJ+Emh6XzEbh7kkOrIjaVvW+TDu5jKCKcRrhGlFIrDyR2VYOkzpnLGtVN+1eyZj/L
 JnShV26DT5svawcLaQq7Pv8I2XJ5bDjcOgYESXU4E12FHzGHMWQSaE3lwgWMRVPTT0Bh
 oGOQ==
X-Gm-Message-State: AOJu0YwW94H9A7AqCe4dJ41/Xt5PD3M9q/Fm4qCctMGaPy5MlruIbw77
 t99jPbob5klmuoGG2yn3D1obOyriQ/XSKJ8Cygb6bxZWZz+2Q7SbGxTbzKaYly5NKOgFEUah6oL
 fA/qAgg4UP6VT8C6CwaoMLfzrmmitWL1s17QuUlCM
X-Gm-Gg: Acq92OGiYr6g7/ohX9D1r7ATtYL3LRWEi1mwfUPidsLc48Z3IAXf4+ZJ/zscI7++TRJ
 DIUm1IBFvV/SJybq4ZLCUDebbihk0aMAdzGG2l3tuyTVV3Btc2TNvlSMi9gdyW+J6SOxB22g9Ms
 9SGqFbcLHhvpf1b35L4PX0nRvgdD0EOuvWDr9WB3oR2ZHEmM43KZKIORxruw9tVbQhpkF0+TS3a
 yuNCSLGUvfDoj9JYceG5m98w+Jcxewfp4hTjJ8rCZLyqfXzFmu7nV92aBVbu9EuFlaTMSuLfAew
 BBNIMbnb7fMOGIUWgdc=
X-Received: by 2002:a17:907:d27:b0:bdd:3159:baa8 with SMTP id
 a640c23a62f3a-beab4f1ef6cmr71266766b.31.1780092197755; Fri, 29 May 2026
 15:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
 <20260529194621.1470583-4-rv@rasmusvillemoes.dk>
In-Reply-To: <20260529194621.1470583-4-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 17:02:45 -0500
X-Gm-Features: AVHnY4Jv0m5hTZ6W5esXZeTnc0PBgJWQJfbDuo_8wxavN9rHSYZdv5OU-zz5O_0
Message-ID: <CAFLszTiBQwRkXt4eZkopi5rC2tDP8d=u6zpXMDxF0WzaRv18Uw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] test: hook up test of allowing control DTB to act
 as FIT image
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-29T19:46:18, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> test: hook up test of allowing control DTB to act as FIT image
>
> Add a test demonstrating how one can embed various scripts in the
> control DTB.
>
> Verify that the source command can be used with ${fdtcontroladdr} by
> itself (invoking the default script), and with :<node-name>
> suffix. Check that the scripts themselves can invoke 'sibling'
> scripts. Also verify that without CONTROL_DTB_AS_FIT set, the control
> DTB is not accepted by the source command.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> arch/sandbox/dts/sandbox-boot.sh      |  2 ++
>  arch/sandbox/dts/sandbox-inner.sh     |  4 ++++
>  arch/sandbox/dts/sandbox-outer.sh     |  4 ++++
>  arch/sandbox/dts/sandbox_scripts.dtsi | 24 ++++++++++++++++++++++++
>  configs/sandbox_defconfig             |  2 ++
>  test/py/tests/test_source.py          | 32 ++++++++++++++++++++++++++++++++
>  6 files changed, 68 insertions(+)

> diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
> @@ -34,3 +34,35 @@ def test_source(ubman):
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('cmd_echo')
> +@pytest.mark.buildconfigspec('cmd_source')
> +@pytest.mark.buildconfigspec('fit')
> +@pytest.mark.notbuildconfigspec('control_dtb_as_fit')
> +def test_source_reject_control_dtb(ubman):
> +    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr} || echo Fail')
> +    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr}:boot || echo Fail')

Just to check: since sandbox_defconfig now enables CONTROL_DTB_AS_FIT,
this case is skipped on the main sandbox build. Did you confirm it
runs on one of the other variants (sandbox_noinst / sandbox_spl /
sandbox64)? If none satisfy the marker combination, this is dead code.
Perhaps note in the commit message where it does run?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
