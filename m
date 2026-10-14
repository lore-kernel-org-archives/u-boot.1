Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FF3CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9889380E15;
	Wed, 14 Oct 2026 14:18:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_T4hBWkvM5V; Wed, 14 Oct 2026 14:18:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91C2280E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987521;
	b=FXY2fNuVEQIIN2TQtDcHdvB0K/u129irqOJAP8PnXXAzpdrNI//K6JzKJbL7G9w3GVQH
	 40dzQYq1R7e4TRg3E0bzOfY8tfu1NWjhG0yX1MtpwVuiaPwZdohJl9xHurG6Dx1sLILGI
	 bhxHb1G1wgSa7hGK9Xx4NoKLyiAzWeh3UvLoJ270LU/0l60K308jvGy7lphFCDQM9z3zy
	 MyFChfcgtMuOgYAJP3vcHKH2HY6peJWouIJDsF14wqIMl1M60RwpJYphymn3MKRqSwpN7
	 Ck9sD+h4dmkMOPAKKeCezZL9sijkciFfq0SPBqHJZFdoyWVeC0jFeuGlZzLO0zjm0OQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kMfhak3DvwQmpXyc0yfiBFZ9sEoHsaGA92+NLH+zyqY=;
	b=aMWoYOynYHJxTTGlkD2C65yN9L1z+7aOOxT7/ttRGdhDwmDoL+ZQOUeGtCt0DzfzoVO+
	 7+8Zq6vscKLcDrmaNCUAMiEvxvROhTxvD/9FCsk5+qBG+/xMm+V7FGaPg2zU68BlheLHG
	 ZxUehrXhluKX97qhX5CAYrl/fQsTfGlekgab1Ten48anrI/aDqg6fhy3w3QcNzVcV46/i
	 MlN7wggrjShwy7+xsuu4UiUznweanj4RsmCcHK7TPd8XKDy9eUHv4aJoSfrmSBkbFHA+u
	 yV8sOB1KyudGeRqGkmuuCqGB9fUEFFs7oQDSkJa00adEVZgDMeYZuTKjovqVRtg0+Qw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987521;
	bh=kMfhak3DvwQmpXyc0yfiBFZ9sEoHsaGA92+NLH+zyqY=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NhV9jxoizWIE6rGEbias3RAw5UaedhiseUbzT0UAEHQkeAveluQikDVhFKa7HTE0Z
	 gWzV9RU4DZY0JsrNl7oXCH7xvQLWWzyasVu/kew/5Pgn81/thPVGrSr879cXXSKZyT
	 llxHpgJbUIsBkTYpzmpUyze4BsD93wnwBT4jcvQskQkbhePMAsDpCYxtBlSt3RNctx
	 ENBzCRRcAP3vZFKOjUNFynJlBTM/og57jEmP/Z0Ox6X0o4XwRK5WHLR54tCgFwpzbN
	 rdMgY2qp/H1jVkWplR/XTKJrudZmQ0iSYBsoX3sQux6muspTiotuNnTkG2gDLyMqtP
	 kjbw/k2dN7Mkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91C2280E0D;
	Wed, 14 Oct 2026 14:18:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB9851518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D908440647
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:18:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5pqmMMH2m97V for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:18:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B3CFF40602
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e36"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987519;
 b=ANWleTjZNJ/FuIDIfSZNRN2ScfSslt0s/dhm8PJSWrfISeSdboqR1gNm2ZhRa58gUnSt
 YNqEI9fDbci4BVhAWkDvoNqobl6xfpWho7bpzjW5D/aZbDPAxKBmDsZhUm05r1u/SL3Zj
 2YauZ6u9FFQCLkTctCXqVC1ljSqA9ot4Z2G4upol5dAwQe/WaAh/OnJFJbgdDtqpY8YNp
 MEH6w32sf7vN5lLHXR8iO8z8Ls7NFLwPy7ddUis1KEVG1x4CiFIdPwW9kC4Nk/9jNWk/m
 96DbTm5kijGvBGuKWrrZk0VzZII1FatFFSpo8IR9hBkEIMG9ibauyRWXEF9WPH7nZ3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987519;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Content-Type;
 bh=kMfhak3DvwQmpXyc0yfiBFZ9sEoHsaGA92+NLH+zyqY=;
 b=bHjgVcpfy0o3qsPASoTVPotebaHQTKv5yOy2rd11AKTBQHOhxLY7J6kp28eskH9NLj0G
 BOmNoQEe0XQ7k5fUsknJejY8cN7pm930gFKvc3M9/79WJ84QY2b1i40yTk4jjkG5WNVty
 pcf8VW6Cs6jBV+q7av/gSgy0h+1Rjq8VofwQXw8zlMfGITjE9HyWGOcbo7rGColIncD1n
 kR603XQeBlvKs62V4xNWD8iaQHtSVSxmS12lyHhHxsuHefZL9ivg83HdU+28kTrg461sm
 px/WD5EOTjQOmqxgXt5WVxFTncpRH7XpXeZiaWgy9H2BWJrDITVlANyPCxnEuL55A8w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=abpKmPJd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::e36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=abpKmPJd
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3CFF40602
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:18:38 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-74ab99038afso2671784137.3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791987517; cv=none;
 d=google.com; s=arc-20260327;
 b=gFwgnk0DjdbkJgmy1kqZbVYxpjENasjBzqrm1QWdWoOhrHW39OwLNbJkViHcEdmjRI
 ZNRPKfbYQW4Y4AMUilK8xuI9lV4Rej8YVU/JCbqpfxfxYSkHjOuBrXTX84DUjb9jL3uZ
 8DVcXhKJ4GDMeT2QjEvyfwxdzDnUvukBS5Q0bDuwsn9mHZfqFKCtDZV6NF6EjnkXT5wg
 wpbcWvBVBVqhPVxpjxekfLJy9hHpYkT6PpG95aXQmF7rFVnJcGwijKlaSHiOMjCSbJIS
 ce9JLU1s2hRDeMPsOfhzTKDgaJ4i+33i6AZg6YA8ji07oqM4OkAoV9VKjAW3iSx1YjAY
 zrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=kMfhak3DvwQmpXyc0yfiBFZ9sEoHsaGA92+NLH+zyqY=;
 fh=433HYST8ezodNjtEk8GXWwZNqKsRjGX0kN9iGovr1kA=;
 b=UeHBx1Zhg+0Zm0JICifKxx9k2rWTaBxMhoaeDp9WqiFT+0dYkojCKyC+kwSFLzYE63
 0M6SWL4XcZPBLCX1cBe9hbp/EmTezzFr/LHYgqWemM6Yl8nYkdDVfeI5/+9AFIMa63ds
 LJQYpke0SrNA0dKkwRVAEzYHSYrHiCx1m5nR7SsjzAOyxM/fpCJNl+fGsd4sJvssRX2C
 wnYq8xEGCUbX6znxmZSt04MRE4IYfPqo8q6nKqQ8KCaBc2y/npkwwXbIILXdBH/6I3Km
 PzCFMVMpO8j9KyUMQslRhHDiTKt6mRCWPeNMCbcioPHuMFzDOgMsn5JUvpKy5ADika9X
 5ZSA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791987517; x=1792592317;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kMfhak3DvwQmpXyc0yfiBFZ9sEoHsaGA92+NLH+zyqY=;
 b=abpKmPJds8UMrKayCaKd1B5dTRNjkdfgHAqwBFL+2cmwFU9KfzsJ5ME8JlwgTUotnO
 MiZ/LAENaU4+qmYpnZcKFM8qJ2Ul8HUPVVwk0Ebysta5ScUYZi4EtNZcOtuHkrqTGQa8
 NITIRmJdXLXwbDIrzA/gbwAXxHnW1OEQFMIKJAMPZHYN1D9nFikyBqxtFaOTGPh5w8v6
 e/MJsnDMh0j8s77hA97OXWk7hlXLaYndvxgCHkKSdp61aa4EpVuYc4kVGnz53g04qOVz
 SqVLSWCeZmZKQV9C/l4AlVk6QizYqgRJ99/Fz0ync7in0RhxPge3gfREMjhMaN5MQEuk
 H4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791987517; x=1792592317;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kMfhak3DvwQmpXyc0yfiBFZ9sEoHsaGA92+NLH+zyqY=;
 b=KMV7U7oop5W72+6SdHNN3KvECFsbcGsmY4rM+a7lZSUdbNHrVm2RuTXDSzgoGYbIu1
 08rwI6uNYbJibrusVQ9rl73PL6coYwmnunwUXnN/FjbBWOwAT3Jge+vBYn9DOczSDoni
 ASyjmMc4mlo8hwjNpxnp0ox3vsPVgYVVQvLP0gCMYna8hnkg3bfVsbOdhbq5M6Rn5JNE
 8qBUd2pUN/SF/NpxNLUB0UXBgMEF3NppFl9CYxWtYYIdynKrag3CZLOfHzTHrhhOaG5g
 bD49ZCS8ntC2mNLnE1XbjoIfEzGkBO04h2sBW9vfJap9k+Pf402/F9sEZ2kEpB6N0UI8
 Z3Hw==
X-Gm-Message-State: AFq9FYLGD1FRCbYpTC/wPWxwmGum6/CFOCH6X0fDtwNGlgr9MOMQ0mGv
 txTkUT35FFn8P4udPPIy67K5uLTfG+OjZbUGOFn3VuW4Aoe8SH1LEAvX5ZiJ+zq10bH7Y+VN6Em
 aV7B9uxx+0nLgMOSHn7yAkp9mZyjIKoaVQ6RL
X-Gm-Gg: AYBFou3ckNYYLkSvcqXb+g14ZGI/zlTPO7FF/42Bl0ePYafMtV8ABswIjR07RsiN+pU
 BaXwVAOlCFQ+nV2Ou7fnFgoSTnefgc3r+M2e3oT65X1WkMBBG246y7/gQ4QBLO9FMldX8IcRT3O
 MLTlHU0m08R3eP9cMeXEfj2gSGd9OVekkdleG6M/m9jezUQIePOE7HGGBYaQEN+k38BiLAYWcPS
 +OuvdgQqCDP1iiBbFbtpOmu3OdA0pzgBYcwtoJspFuoBANEM0Fej4BuKCNviWPuGgtac1TxFAhS
 LoG1hon+PBuCIo20jW5GcGE0zA/GVUTuhMchEa3aM1HITTBG14cEGfNe
X-Received: by 2002:a05:6102:424b:b0:7c3:978f:c5eb with SMTP id
 ada2fe7eead31-7cb3a002727mr5007847137.9.1791987516853; Wed, 14 Oct 2026
 07:18:36 -0700 (PDT)
MIME-Version: 1.0
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 14 Oct 2026 10:18:25 -0400
X-Gm-Features: AclHuK_HouglWNZVZOYuHtIacTaJ1jJ7x0PQtvC8zA4OVlWcxTgBgdM6HmMjJk4
Message-ID: <CAMDkj5weBw8mXqz6RNubuPo_tkVwWKObZxpK1LXa4n_44ZzxvA@mail.gmail.com>
Subject: [Git Pull] Please pull mbedtls-2027-01-rc1-101426
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

Please pull mbedtls-2027-01-rc1-101426 from u-boot-mbedtls. Thanks!

The following changes since commit fed92546960a92177d67c0b8d7b22385f50fed29:

  Gitlab CI: sage: Update for labgrid 26.0 behavior (2026-10-12 11:13:40 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/raymo200915/u-boot-mbedtls.git
tags/mbedtls-2027-01-rc1-101426

for you to fetch changes up to 55a7009d31654b74df5936569a712e262bd26e4c:

  test: py: vboot: add test for global signature with ecdsa
(2026-10-13 10:58:37 -0400)

----------------------------------------------------------------
mbedtls updates for v2027.01-rc1

Adds the support of ecdsa using mbedtls:
- fix the support of secp521r1
- enable support of ecdsa in mbedtls
- add software ecdsa signature check using mbedtls
- add support of ecdsa for internal fit signature
- add test for ecdsa for internal fit signature in vboot
- add support of ecdsa for pre-load signature
- add test for ecdsa for pre-load signature in vboot
- enable software ecdsa signature check in sandbox

CI: https://git.u-boot-project.org/u-boot/custodians/raymo200915/u-boot-mbedtls/-/pipelines/1584

----------------------------------------------------------------
Philippe Reynes (15):
      ecdsa: fix support of secp521r1
      mbedtls: enable support of ecc
      ecdsa: initial support of ecdsa using mbedtls
      test: lib: ecdsa: add initial test
      drivers: crypto: add software ecdsa support
      test: dm: ecdsa.c: clean this test as software ecdsa is now implemented
      test: py: vboot: prepare integration test for ecdsa
      test: vboot: add test for ecdsa
      tools: fit_image_setup_sig: set required_keynode to -1
      tools: mkimage: pre-load: add support of ecdsa
      tools: binman: pre-load: add support of ecdsa
      boot: pre-load: add support of ecdsa
      tools: preload_check_sign: add support of ecdsa
      test: py: vboot: prepare test for global signature with ecdsa
      test: py: vboot: add test for global signature with ecdsa

 boot/image-pre-load.c                              |  53 ++-
 configs/sandbox_defconfig                          |   2 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/ecdsa/Makefile                      |   6 +
 drivers/crypto/ecdsa/ecdsa-sw.c                    |  31 ++
 include/crypto/ecdsa-uclass.h                      |  15 +-
 include/crypto/internal/ecdsa.h                    |  39 ++
 lib/ecdsa/Kconfig                                  |   1 +
 lib/ecdsa/ecdsa-libcrypto.c                        | 104 ++++-
 lib/ecdsa/ecdsa-verify.c                           |  73 +++-
 lib/fdt-libcrypto.c                                |   2 +-
 lib/mbedtls/Kconfig                                |  24 ++
 lib/mbedtls/Makefile                               |  20 +-
 lib/mbedtls/ecdsa.c                                | 152 +++++++
 lib/mbedtls/mbedtls_def_config.h                   |  41 +-
 test/dm/ecdsa.c                                    | 107 ++++-
 test/lib/Makefile                                  |   1 +
 test/lib/ecdsa.c                                   | 456 +++++++++++++++++++++
 test/py/tests/test_fit_ecdsa.py                    |   2 +-
 test/py/tests/test_vboot.py                        | 148 ++++---
 test/py/tests/vboot/sandbox-binman-ecdsa256.dts    |  24 ++
 test/py/tests/vboot/sandbox-binman-ecdsa384.dts    |  24 ++
 test/py/tests/vboot/sandbox-binman-ecdsa521.dts    |  24 ++
 ...nman-pss.dts => sandbox-binman-rsa2048-pss.dts} |   0
 ...ndbox-binman.dts => sandbox-binman-rsa2048.dts} |   0
 .../tests/vboot/sandbox-u-boot-global-ecdsa256.dts |  27 ++
 .../tests/vboot/sandbox-u-boot-global-ecdsa384.dts |  27 ++
 .../tests/vboot/sandbox-u-boot-global-ecdsa521.dts |  27 ++
 ...s.dts => sandbox-u-boot-global-rsa2048-pss.dts} |   0
 ...lobal.dts => sandbox-u-boot-global-rsa2048.dts} |   0
 ...1-pss.its => sign-configs-sha1-rsa2048-pss.its} |   0
 ...figs-sha1.its => sign-configs-sha1-rsa2048.its} |   0
 .../tests/vboot/sign-configs-sha256-ecdsa256.its   |  44 ++
 .../tests/vboot/sign-configs-sha256-ecdsa384.its   |  44 ++
 .../tests/vboot/sign-configs-sha256-ecdsa521.its   |  44 ++
 ...ts => sign-configs-sha256-rsa2048-pss-prod.its} |   0
 ...pss.its => sign-configs-sha256-rsa2048-pss.its} |   0
 ...-sha256.its => sign-configs-sha256-rsa2048.its} |   0
 ...-sha384.its => sign-configs-sha384-rsa3072.its} |   0
 ...a1-pss.its => sign-images-sha1-rsa2048-pss.its} |   0
 ...mages-sha1.its => sign-images-sha1-rsa2048.its} |   0
 .../py/tests/vboot/sign-images-sha256-ecdsa256.its |  42 ++
 .../py/tests/vboot/sign-images-sha256-ecdsa384.its |  42 ++
 .../py/tests/vboot/sign-images-sha256-ecdsa521.its |  42 ++
 ...-pss.its => sign-images-sha256-rsa2048-pss.its} |   0
 ...s-sha256.its => sign-images-sha256-rsa2048.its} |   0
 ...s-sha384.its => sign-images-sha384-rsa3072.its} |   0
 tools/binman/etype/pre_load.py                     |  78 +++-
 tools/binman/ftest.py                              |  50 +++
 tools/binman/test/ecdsa521.pem                     |   7 +
 tools/binman/test/security/pre_load_ecdsa.dts      |  22 +
 .../test/security/pre_load_ecdsa_invalid_algo.dts  |  22 +
 .../test/security/pre_load_ecdsa_invalid_key.dts   |  22 +
 .../test/security/pre_load_ecdsa_invalid_sha.dts   |  22 +
 tools/image-host.c                                 |  93 ++++-
 tools/image-sig-host.c                             |   7 +
 tools/preload_check_sign.c                         |  30 ++
 57 files changed, 1892 insertions(+), 150 deletions(-)
