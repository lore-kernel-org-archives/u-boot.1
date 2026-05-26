Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8238CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 08:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01874846CA;
	Tue, 26 May 2026 10:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="i4d/IQjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A1C84851; Tue, 26 May 2026 09:03:52 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A088469D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B45E3F581
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779779029;
 bh=XGICoqjkmDnc1HPgI4zVX69zzmJwPLoTiY8IqXjwsWI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=i4d/IQjdaaYUdM5VEkz4nY0/mV35tgPKQZ2Iw0Z6zHB/qTGQex6nhh9AVTlTggpLP
 rOtez+dvXW3M93J8u6WPpJDAexqLkAcrVQpsoasjaOe/mrxsZ36Tz5JT68PYiWKBoD
 LKx29S7tyr8WNrJo6cZN1moWxg47fJItQCYWEfj93aoPZjz3Qbui6MPkyVbQUNK5rz
 yWRO7h5u/Evbg8teJm4N+UFHp54NWMInCRSi86O+sAk54by8Q0swSH49C7pnnnmpst
 AgG6I7/3Qm8hkYFKQiGAiFEZY0BkzPwpUFZ+VboYs71VGaewyUQtAnKhM8QGEcdhcv
 xVcDT9G+osidUKXmHcgi3ofb4hdPKYeqbEWt4g16zfxTQWRzVBRY2+eXRalFT5a5Y9
 Wx0wWC0uNHp+UycsUOyyzE3DS7zNIB2IMRrISMIh9fnzj2/RJb8pEfGZThPsD3ArSZ
 4vVx+hlVEXJDEg0uX/u3BGdh1P8zw6k00zkcaM9ISz71TBu9YROa4hj7cEXDLa5SNW
 NeAWlfKf8Kn54Yi8Hwpe0n8z66Fi6NdPavbyUKj7IUEReCoUMJ6DSW1TPO+sbgfUKU
 ip++1kekOlaSoS410nEUhT2f5gchqhekNHxUgDD0kt+2qlOJ2F+LZ6vQPGJpjwoyrE
 AX8dJsR8BqHuS9mmA1yGcpXg=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b99eb06178so232648655ad.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779779028; x=1780383828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XGICoqjkmDnc1HPgI4zVX69zzmJwPLoTiY8IqXjwsWI=;
 b=hU0U4eEgtI1SIukkDYxzIhx5I81wmin6X+XzekbscM6OifIjcruzOkH7Oef9Oiel0i
 GggIq3QM2OOiEYqseBVbXjUgQwagBMDPGPiP5UKLpMo7xAN15CHSlZth4lTNkZq8bSfk
 7N6ZskcYqHSPz1g0yer/LOyiCLq53I0z5WkGyNjCFMjksYRpuUel1fTnC0KzzW3I7YA2
 M98c5A/p+/OrqoO7x72HNEYkfOeUDyZswGctEdbBJnSkdAdva2AV95QbeOoYgaNhuclB
 jRt6S6mqioQhJC85xGwy+qNaanFbych2+bbqL2rPbZCiI2OlYCOC2fXYQJDb7xZ3SQwo
 46JA==
X-Gm-Message-State: AOJu0YwZKo3Phkr7E9EkFrTBA5UWffjMjhmjvbQNjt1DcRdCT6uUJm75
 PpXT7rgyDOPPu0Yh0UzPAC1ONL5rV/oYTbdLudYeevEXo6G9oBacOo0qJLL6Izabj3dOf9rhfV+
 W9dywhwiZqAhECvYMSy4z1qnSFjKjC427T6sz10riFaR6PfnR3SuRHaAICA/6zwOmHFL8IDlxvW
 vr2ZsRVRjk
X-Gm-Gg: Acq92OG2zJpsNyMdLkzIZ4uHbUkLtdelmMf31DNDHm0mnJyYuX4P2+5eqi6QwF2zG1C
 M6HHWD4P+eMpmIRRySq05q1S6hpMrfMYuVDpDjPA4XKaYhBbJBEtBwgXPIZgyDmL5N050dD6Qy1
 TuL4brqaTRUfKau/1lwNlpBYFugb62nRHIBSFQ6tVbvk6jfal0UGIECKXLs7MbzkFMYdyrOXEg+
 eo03FTkn1Oq7+z2/Xub1RDplUhy3Bm6D0iGRXgGoYc2EsaqTXKn30p8WQ7+24hFsYXPE/bVg6JL
 xMEv+SeZDkCM9AAJCJ7tT3dkfgu+tovOMS8etnCqwpNccZJJkFwUMu8Oz7Qyo441KlYH6ync6iv
 s9D0qTWxx7RXIqjirosiF3+kUeCl860i0p35bjuxxaO6jq6Z3HNCH8M7PgwWicCWK/3Bq5sg/5y
 JRkK4Kbfvq+A9GpuQ=
X-Received: by 2002:a17:903:3c63:b0:2ba:85:5827 with SMTP id
 d9443c01a7336-2beb05ff545mr225934735ad.26.1779779028054; 
 Tue, 26 May 2026 00:03:48 -0700 (PDT)
X-Received: by 2002:a17:903:3c63:b0:2ba:85:5827 with SMTP id
 d9443c01a7336-2beb05ff545mr225934495ad.26.1779779027653; 
 Tue, 26 May 2026 00:03:47 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm117133795ad.21.2026.05.26.00.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 00:03:46 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/2] tools: mkimage: fix get_basename crash on paths with
 dotted directories
Date: Tue, 26 May 2026 07:03:31 +0000
Message-ID: <20260526070336.23199-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521023503.29315-1-aristo.chen@canonical.com>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 10:34:48 +0200
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

The get_basename() helper in tools/fit_image.c searches the entire input
path independently for the last '/' and the last '.'. When the last '.'
falls at an offset earlier than the last '/', for example "./mydt",
"a.b/c" or "sub.d/leaf", 'end' points before 'start' and the computed
length is negative. The size check uses signed comparison so the negative
value flows unchanged into memcpy() (cast to size_t there) and mkimage
segfaults during -f auto FIT generation. The helper is reached on every
auto-FIT build via the -b, --fit-tee and --fit-tfa-bl31 file arguments.

The first patch restricts the dot search to the substring that follows
the last slash, which is the minimal fix and preserves the existing
behaviour for typical inputs such as "arch/arm/dts/foo.dtb".

The second patch adds a parametrized sandbox test under
test/py/tests/test_fit_mkimage_validate.py that drives mkimage -f auto
with each of the crashing inputs ("./mydt", "./sub.d/leaf", "./a.b/c")
plus one control input ("./mydt.dtb"). The test reads the resulting
/images/fdt-1 description back from the produced FIT via fdtget to verify
get_basename()'s output matches the expected stripped basename.

Reproducer that previously segfaulted and now produces a valid image:

  echo dummy > kernel.bin
  echo dummy > ./mydt
  ./tools/mkimage -f auto -A arm -O linux -T kernel -C none \
                  -a 0x80000000 -e 0x80000000 -n test \
                  -d kernel.bin -b ./mydt out.itb

Verified by rebuilding tools/mkimage on master and running the command
above with each of the four parametrized inputs. The three crash triggers
all segfault before the fix and now produce the expected fdt-1
descriptions ("mydt", "leaf", "c"); the control input "./mydt.dtb"
continues to produce "mydt" as before.

Changes in v2:

Patch 1/2 is unchanged code-wise and picks up Quentin Schulz's
Reviewed-by from the v1 thread. Marek Vasut asked on that thread whether
basename(3) could replace the helper; the in-thread response noted that
get_basename() also strips the extension and therefore only half of it
overlaps with basename(3), and that the GNU vs POSIX basename() selection
in tools/ is implicit (it relies on _GNU_SOURCE being defined globally
and on <libgen.h> not being included), so v2 keeps the hand-rolled
approach.

Patch 2/2 now reads the fdt sub-image description back from the produced
FIT via fdtget instead of regex-matching mkimage's console output, and
invokes ./tools/mkimage rather than building an absolute path now that
the test runs with cwd=build_dir.

v1: https://patchwork.ozlabs.org/project/uboot/patch/20260521023503.29315-1-aristo.chen@canonical.com/

Aristo Chen (2):
  tools: mkimage: fix get_basename crash on paths with dotted
    directories
  test/py: cover get_basename crash on paths with dotted directories

 test/py/tests/test_fit_mkimage_validate.py | 57 ++++++++++++++++++++++
 tools/fit_image.c                          | 10 +++-
 2 files changed, 65 insertions(+), 2 deletions(-)

-- 
2.43.0

