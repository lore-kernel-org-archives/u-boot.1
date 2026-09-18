Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1A5C982DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD7EA40ADC;
	Fri, 18 Sep 2026 12:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mvKqwXocSARZ; Fri, 18 Sep 2026 12:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 82E8440AEE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789733650;
	b=oMC13fd0PK4lf1ekyIPbJrFjjEsaDybIVu6mOpqsyARTU8eYOpdtHnhaDV3bcg4g+LPd
	 BRv13h/AA45tuTbhszEJxerqBNyKfl9RYctq2WfbYwOeKdsvcvs6T2P2yPrwBt5RusPLD
	 J6/EGvJZAX5/Zr2D21fMP8N0yawtjBeUsoTeojuH5JHx+ak9VskiOSD/GTdrtUAP4UFVd
	 QMiXGXQYQBEa7G5rGGUXXXPxkKiZJMXhDYKL1hw/35oqBWVNByFv+t/JOxgpqLGqBgABv
	 EuEsl+grSSqcuwkxqnG6vgM9YbJn1gEi7PAp/C41p7IGyoRbLXjgdP6HN6gvseOslYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789733650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZPVua+lJKU5KQkyB624qX2/0MZZofNb2DGposhmYo3A=;
	b=iS/M9UAj0H5AkmDHNlxMvl8E5W04EAwwR2cQlK2NJzE5nNw6NLbxWQ+lVNUNUBgUNo/U
	 yvGPlN0DPsJWwVlQAXXpEuzQLbqQ4cmQ9VTZ41hHeSUGANX7oarHpQNENbGBd0vwS2RHy
	 lXZSk//I2t0BYigSxMvGflE90+Ihscj3RCjPii8cJpjZTzY2kNMfmktxd7kVpUjdG8D/k
	 VegK0xAiWOFQI4mWW/VsyK/32KAEV58ug3/vHEND2WatkvRmwlMFWTlQkxh8Jy/qXRh83
	 NjiFzWVY6FMdkiUZawMuSi9XRODlXQZ1gmRgFfHbzZ+RPMTgTNEQJ0SumyiS8xR3fDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789733650;
	bh=ZPVua+lJKU5KQkyB624qX2/0MZZofNb2DGposhmYo3A=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wAkFwPqdEiDnxXZMcV0L9ACzMjjL2vpoASY+AONo1Z023PUCQB9+h4QbB8BxNWe6x
	 5QL94c9CAZBq5dj7qcqfTW6d5CeStlx3HbLZJhpzlWQhDlUNKRekdtgTym9vrnHYFW
	 Ua/lh/5Zt7WiCql3ckqSXfNt7SI71xOllpRWUJB92d8h2Me60x0TgyZ1ijGwGWKNp5
	 YSgpqgO3hjMzM4jO5MyvM2S3Kr9WNMfdWNh7/WrtTEtg8IVGs0XNlVFJKBgk/ceJ2o
	 9H0L/0DmtDCyhPiOvE0c5tAIPJQyRRQ19kieYQEGoBPEcpR/Gxr3YuSteWhS3f6wRS
	 n3z30FT0s5x6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82E8440AEE;
	Fri, 18 Sep 2026 12:14:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79E753B6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B90D40049
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWvtIM3SIPlU for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EEA2D40048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733648;
 b=br0V0kzxMhvxfjSZSW/7AQ9TH2ovIvqvDl9/Tu/L03n2DVgechCDsTWwcNSi75i01/iX
 Y+xGKMYe+Eg5RkwLOWPqDwIEXiKtXS0cYZny1VyZpAPpmIRMVN6WutXrRUwKDz20jYnFZ
 NCZi5rJD/70AJUdoMHQx9RwYZtq6hygBG7O0xgf7sN4ajNilvTJ66QJV1N8aZlWWENimc
 QsFNjaho2WuEp7XtAzdIcS6t9pAU0X/05BJa3l68rI+k2tvVIUodVb5sxB2+4EGRp2VD/
 5pkRe/UzxqUHRozzBR3sZNj+xgZdgqK6g4WY0ejAV7A64/ytUFMTJ19nTvUPe2CMIog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733648;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ZPVua+lJKU5KQkyB624qX2/0MZZofNb2DGposhmYo3A=;
 b=oNG8OKxT3XJooMJ+TwbuBPhYftnD7roiYSgdY0QMKhz6BuMJgEX5SK+CaWcTdaucf6Vp
 TfixoBHvbemHCy1RNYrBIhJaXjIcp2ArZoog/sbOaT+fctNswMba9ifAbvQOzVRWOcY+D
 BVlYsWeY2KRHlVjrT26fJ00rIxHLRkHQM9AdT0JqA6oKf4TPJ4z7prJJ3fxTlDrFBFiSq
 lSRPRXfpRsfzfCG5MB28VAcc3AL0ROFIEirfwYQxhApgrcjvkERCuVvsD1scG5XpvPNjn
 2iUCjjjC/ezbQj15MOTnEHRS2L0uO/OIUghXTmxbSFCofZvmHZ3EXrIvnNoPqvCZEgA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OGTjgIzf; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OGTjgIzf
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EEA2D40048
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:07 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so2264165e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789733646; x=1790338446;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZPVua+lJKU5KQkyB624qX2/0MZZofNb2DGposhmYo3A=;
 b=OGTjgIzfvQscxrZIQUYdfMU82S4auqgy63R5iRl5pRpIfmMzJFunn9o1x2Vc1BJrxD
 OMxd2VWBDIekFaBZ0IyJMLTULhrjh4CqArpNiYudJlAnXOonHLGuOodSdSjdQdGkPhwT
 df5sqUuxq8BfATX+1yCew7XUIn0FDTIuytELO915XfB1TSgELfvFL0BSIMhaXGyRxaw0
 mG3UOSfd09M6xS1eC7+gR5JJvjhwroSImw4n9X61xF4jN0Vxza1Vyt7h6ha9UG+ryTMK
 eOZpVn6ed3SDE0C6eiqrSbjxbdaQK4yccYVdsBaz6KymoxgiOkRGT0sgiX3XwIznq4Hz
 XZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733646; x=1790338446;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZPVua+lJKU5KQkyB624qX2/0MZZofNb2DGposhmYo3A=;
 b=PQ8qnrpL2LUAwKWB2WMR/0CGcAIFrdzRe1+UOyCWlXfBooSRj5BnIO83AdwJ/9lLAD
 OwOhkaXcxQA9gnjs4Pg8em86cOW5Bm7y1Fv0KCBx42atZE6h5DoVLJkxICkU2+DozQpr
 lPJWCq9TvLcNIvbzgAWTGm5R79uoUWMOlfRnjIbaaQD3C4cg8TvAg4bf479CaTW6Hp5m
 WhoS+d3vSkf8A23gUDYbzzHOq6ZKpCx/6K1Qh23iBhbSd+NJieWf5vlp2/19f1IEqcKd
 ZV2I6NJfEPp5lEttlmrp3OlV9ouEpVCAnrYrjk9F8foAVsdReYgwH2fXNbOg1MR/DCkU
 WA5A==
X-Gm-Message-State: AFuF++kT2gmR1keyqJcj5fza8xEh8BRY/HrGQ2pWltlFYRuYWCkH8Q2W
 FPDNnY655xnB5gkulgdVGChWmXknSONICDU+e9F45Zb3DCiNJ9PKlx574CQVjfglzIduhRhBbMx
 UMY3g
X-Gm-Gg: AYBFou04kHzO0yv76gzOBvNpOAcAC2n2rNxFZffAd3yxc2j+lo6tWgow9T1XKtEC9Pd
 RbJBRFgTTzJ5eOMrcEqZVZzVsGU3lmrZlOf3tRP5DpEQBAuVbnjoAt3+iJIXaBjixgvmd1v4i+3
 3CCAUHKrqeKdhjvaxBbskGxXb7U13xYRG86D5ly9ZTCOe7BrtgJoq35FOB2HOMhIAqBpj3OHzHq
 jsDghfFq4++bH0DHFXn0sv97G/wHYFsuDy4ASqHae52ag7eYQeQkvkxBb4s2ChaCjUabl0jF1mC
 HJwXCwDAu517hbmd4hYxy6r/b+lMW3Vo/axjK1RQ4xfLf3bmHseC9QrMP7H/uORbWvSOXVrAftm
 ja9Sq3vuX+THeRaM4+HUrRs5y2Lgbiv7hATYA2eqvsaS6e/X7NaB57ghUnkHslyw76MIM/C4bDW
 4JBcIXYdG0tspERB6imqPrEMNgtd3SQsUBz+kL9y8xqvdyfO0Xlqnua8dAL1M37GST7TNuGpOdo
 91mgxybl0WqIRyKZWAnT/lTSrvqWlH16VPRKC9RpOrYQs+wjJc=
X-Received: by 2002:a05:600c:468a:b0:49e:7c8c:bc77 with SMTP id
 5b1f17b1804b1-49fc4fae7acmr36089745e9.7.1789733645590; 
 Fri, 18 Sep 2026 05:14:05 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc59286b6sm42755035e9.4.2026.09.18.05.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:14:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/7] disk: Fix the GPT layout on media with large
 logical blocks
Date: Fri, 18 Sep 2026 16:13:49 +0400
Message-Id: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOQQ6CMBBFr0JmbQ2lCMrKexgWBaYwaqC2hWhI7
 24L7ly+5M37s4JFQ2ihSlYwuJClaQyQHRJoBzn2yKgLDFmaFWkpOOu1Y/mDqXNzQaFkl5c5BFk
 bVPTeQrd6Zzs3d2xdvI7GQNZN5rMtLTx6f9GFs5RJobjiRXMSEq/qSVqjOY7ooPZ71+BrDn+63
 5j3X0bu6BHFAAAA
X-Change-ID: 20260731-gpt-4k-f8b9e3fad474
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anton Burticica <mouse@ya.ru>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7429; i=alchark@flipper.net;
 h=from:subject:message-id; bh=N2zkrMOvPE3s61TWfDtOWloI3fIniCVOgqvdjbPPq6Y=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt1WZ5feex3sHNv3a1H2ZLT996fvJxZxmWTbp1JZaX9
 qjUHJrM3DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUl81mZDj9cv7bR7Om3JaqePZQNDDF31gtZjbL/aps3vJs6bh6ARtGhl1+U+Y
 6SpjEfGKc37nz+7qTLbftp25ZcE5rUYT49owVIvwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The GPT partition entry array is sized in bytes by the spec, so the
number of blocks it takes up depends on the block size of the device.
U-Boot got that wrong in gpt_fill_header(), which reserved a fixed 34
blocks at each end of the disk. On a device with 4096-byte native
sectors, such as UFS flash, the backup entry array ended up 28 blocks
short of the backup GPT header instead of immediately before it, and
roughly 114 KiB was wasted at each end of the disk.

Patch 1 calculates the count from the block size and makes the four
places that need it share one helper, since they disagreed with each
other in different ways. Note that it also changes the 512-byte layout
for boards that do not use the default entry count:
CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is "default 56 if ARCH_SUNXI" and
is set to 64 by a number of Rockchip defconfigs, and on those
first_usable_lba moves from 34 to 16 and 18 respectively. Existing
tables stay readable, since the entry array is always located from the
on-disk partition_entry_lba, and only newly written tables are
affected. Partitions given without an explicit start= will be placed
lower, though, and on sunxi first_usable_lba lands exactly on the 8 KiB
SPL offset, so sunxi and Rockchip folks may want to look at patch 1
specifically (none of the devices I have override the default).

Patch 2 has grown since v1. It started as a big-endian correctness fix
noticed while auditing the file, and once the new test in patch 4 could
drive a real block device on a big-endian target it turned up two more
problems in the same family, both of which make a table written on
big-endian useless.

Patch 3 from v1 was dropped in favor of outright removal of the old MAC
partition label support, as suggested by Heinrich (already in next).

Patches 3 and 4 add the C tests, which are complementary rather than
alternatives. Patch 3 drives gpt_fill_header()/gpt_fill_pte() with a
synthetic descriptor, which is the only practical way to sweep block
sizes from 512 to 32768, but it can never reach anything that touches the
medium. Patch 5 backs a blkmap device with plain memory and does a full
write/verify/parse round trip, covering set_protective_mbr(),
is_pmbr_valid(), gpt_verify_headers(), is_gpt_valid() and
part_get_info_efi(). Both live in the lib suite rather than test/dm/,
because UT_DM depends on SANDBOX and test/dm/part.c is built for sandbox
only, whereas test/lib/ is built for every board with CONFIG_UNIT_TEST.

Patch 5 enables EFI_PARTITION and BLKMAP on malta64 so both tests are
actually built and run on a big-endian target. malta64 already sets
CONFIG_UNIT_TEST and already runs the full pytest suite in CI as the
qemu_malta64 job, and ut subtests are collected from u-boot.sym, so no CI
change is needed. malta64 rather than malta because hdr_start/pte_start
in gpt_fill_pte() are size_t: on a 32-bit big-endian target an
unconverted __le64 truncates to zero and the overlap check still happens
to reject an overlap, while on MIPS64 it does not.

Patches 6 and 7 add the sandbox-side python test. Patch 6 is a
prerequisite: test_gpt_write_part_type() never binds its own disk image
and has only worked because an earlier test left host 0 bound, so it
breaks as soon as a test binding a different image is added above it.

One known gap: test_gpt_write and test_gpt_write_part_type hardcode the
128-entry 512-byte layout, so they fail if sandbox is configured with a
different CONFIG_EFI_PARTITION_ENTRIES_NUMBERS. The new tests derive
their expectations instead, and pass at 56 and 64 entries. No sandbox
defconfig upstream uses anything but 128, so I have left the old tests
alone.

Still not covered: gpt_verify_partitions() and friends now have
big-endian coverage against a device U-Boot wrote itself, but nothing
checks that U-Boot parses a spec-conformant table produced by someone
else on big-endian. That needs a real disk image attached to the QEMU
target, which means teaching u-boot-test-hooks to pass one and, for the
4Kn case, using virtio-blk rather than IDE, since drivers/block/ide.c
hardcodes ATA_BLOCKSIZE. I am happy to look at that separately if it is
wanted.

Tested by building sandbox (default, flattree, sandbox64, spl, vpl, gcc
and clang), generic-rk3576, sonoff-ihost-rv1126,
A20-OLinuXino_MICRO-eMMC, turris_mox, boston64r2, qemu-ppce500 and all
four malta variants, with no new warnings on any commit of the series,
and by running the full sandbox pytest suite plus 'ut lib' on malta64
under qemu-system-mips64.

CI passes all green: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1326

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Rebased onto next
- Patch 1: reword the commit message only. The entry array is sized from
  num_partition_entries and sizeof_partition_entry rather than a fixed
  128-byte entry, and the two counts that could disagree are now named.
  No code change.
- Patch 2: also convert the protective MBR fields and the GPT partition
  names, and fix print_efiname() to match. Both were found by running the
  new patch 4 test on big-endian, and both make a table written on
  big-endian unreadable. Dropped the v1 Reviewed-by tags from this patch,
  since it grew three hunks nobody has seen.
- Patch 3 (old): superseded by the removal of part_mac
- Patch 3: moved out of test/dm/part.c into test/lib/, so it is built and
  run on boards other than sandbox.
- Patch 4 is new: a GPT write/verify/parse round trip against a
  memory-backed blkmap device, which covers the paths a synthetic
  descriptor cannot reach.
- Patch 5 is new: enable EFI_PARTITION and BLKMAP on malta64 so both C
  tests run on a big-endian target in CI.
- Patch 6: unbind the 4096-byte device at the end of the new test, so it
  does not leak into whatever runs next.
- Link to v1: https://patch.msgid.link/20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net

To: u-boot@lists.u-boot-project.org
To: Patrice Chotard <patrice.chotard@foss.st.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Denis Mukhin <dmukhin@ford.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>

---
Alexey Charkov (7):
      disk: part_efi: Size the partition entry array from the block size
      disk: part_efi: Add missing endianness conversions
      test: lib: Check the GPT layout for large sector sizes
      test: lib: Check the GPT round trip against a real block device
      configs: malta64: Enable EFI_PARTITION and BLKMAP for big-endian tests
      test: py: gpt: Bind the disk image in test_gpt_write_part_type()
      test: py: gpt: Test the GPT layout on a device with 4096-byte blocks

 configs/malta64_defconfig |   2 +
 disk/part_efi.c           |  66 ++++++++----
 test/lib/Makefile         |   1 +
 test/lib/part_efi.c       | 257 ++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_gpt.py | 120 ++++++++++++++++++++++
 5 files changed, 425 insertions(+), 21 deletions(-)
---
base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
change-id: 20260731-gpt-4k-f8b9e3fad474

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

