Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED43DC88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C14C40722;
	Sat, 12 Sep 2026 12:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U6MBIKp5-J9e; Sat, 12 Sep 2026 12:37:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1FDAE40718
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216631;
	b=c7oRqez1JCdQW+98qxvj8zRFd9fGbMUpNTH/+XwqN1U03BDZC8NgFulbua5axqn1IvTE
	 eNg0qh+7+Qg4F/YRfDsEmbkQ/LUlNlxUjrMQG/Uospc2JqySQXZv3ajYU4oECHDSv9n8E
	 WwHeQehYpSopaSKInaHeqoPu3Rq+1jUSUkWvLaYqxCuX5+pdOP1HxC7N7Td5XaDwN4Pk+
	 3Rll6RHIIZkYUwxiMGiSk2X0ti1ozWgITs6i7A1PCi0Cm43XLswaegfwKlqc8gg4QT90J
	 cmEBiWvoxEQwLyGRN6B1g0/tylxvOGxKkl7Q7kqyhra/hq5PmyprP9DRgm5s9/hKZ3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3JKzLnapSEUlGTnGQDFiRnSum0e56IeVk/uWK3ch9x8=;
	b=sZF044BIFvNgNwiKHRjQSgG0prfpS2+Xhkq1h35BKmyvEQuExoenCvpe6D1JJ+bfk8e3
	 XuC5Frew+eEbtY/vw1TqbGdtoJC2VnKBpH3oQlNLFpulnNScmBURZ3ssdJvRHln1+N4Th
	 DZZrlOW7KfTB/YwsiWRoRQgDwNb7Vg9k/ZZwJzkgtE3SAUmpRsUYYU9yce32SvRV7+UIo
	 0uhgA8rcPuSvcUBnhx/l1jmedDdImv6EjxBZo0/mw5iPskVsbFUuPq3HBjhiRjTgz+pHx
	 pCwU1iIe3KI/DReF+8yfoOAkaQvfMmoiYu1CI6hZJgcANlxmd/6+TRGhbFz1jr/UKFA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=uOdcPAnT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216631;
	bh=3JKzLnapSEUlGTnGQDFiRnSum0e56IeVk/uWK3ch9x8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LT6WJpfvb+LhztMm7w5aDEAgzijr6i3nUGLviDr7Yo93Oupv09yZVPrlyMiBWiAx6
	 K7tdyUQfrIQzpD5gVXQwe0sNRBvO6JN452tQa5wTmTWbpTqgy4ap61UfIFsqP72w8P
	 HPnO9EtktLRO0CGNbZMLaMjPIq03r8ZIX7/jLefu+uxYqeNsb6XH4Ea7HwOz0SkBQ0
	 NphEhDY258ZAN/myyDO8effFk+M7a4NZGxLVnbNSnLfAs0V2PmW8uMaAjx0VKNCyDr
	 jyq4AuiP4IOFB6Zj8QkrQqbdMiZKZR6k6yGZ5GzoFyGL01y3tm1J69ifTBgABozKtn
	 Offo0DeVv9zfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FDAE40718;
	Sat, 12 Sep 2026 12:37:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5036D701
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4151C40718
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEPP2PLGNLyD for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:37:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 80D04405D0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216628;
 b=gTRG/I2TQPBt3PjFsi03gXZxxEs5dOdoOuuXfz3ZVz3sUeQCKHZO5+MRUba9YpARRyKt
 cFi9KQ+2jX1n/ItbD2seKDNhf6NWMammmLMhl6eGb923ZtCgYFOvTFPy9wfuP5Iaco+8G
 fQwQsKldxtN1AE3hFP+7iyAlhNoai1gCEVSeMVRFKFzSmVxOZW95hP+5j+krRWS6kR4zp
 Ze7gzmiuuZsOTXpvZrg0dvarAmKSDsXXlwukcrojoh1iAxZ4qJ1nRiZZZ/ShTh6RJIdwL
 5jWmBTCIhbok3r53N9q8pPT3GSRXsEJ0RI04KQ7kfkuKVWnkiR/bxx+GWdcWir8QrEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216628;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=3JKzLnapSEUlGTnGQDFiRnSum0e56IeVk/uWK3ch9x8=;
 b=b3Rdvieibo0s+IMrRLRevyF6bpXY4pzMy8GGoDvZhI0Wh0AmntYdZmKznyjuMaoQ9yMq
 w2x5OqzQ/nKK+v6r9vhy22CJ5pXne5W1gei1gNZQpj6KvcUXq8i6pNq1ObgMoEjV/OZLZ
 M5FlGFkFRfWCuSkdZn78VbSg+tx82Ykg/qWsb2Zej+QSxdN7ON5phVejoW182bnzaI0dc
 hnJqJ9fcCexqKn7DgGJJdLSolcYa0Nawzz7LTNYGnlSYQzK5n4qWkQO+zZtl4y39cs38i
 okj2pYKKemu0c4g74T+UMhT2WJVlhcf28PyCH3ATmLKUsx46I3dLd4M6fK2So3+rAzw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=uOdcPAnT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=uOdcPAnT
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80D04405D0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:06 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso459892a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789216626; x=1789821426;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3JKzLnapSEUlGTnGQDFiRnSum0e56IeVk/uWK3ch9x8=;
 b=uOdcPAnTC+DfbWnlB+SMB7nm9DsSQ4QHRhvfdoz1aNeF9RSdFAfK+zc0yTBmWKEIeb
 QSWYSpv05okekm/PFXDbk2w1IqpHnsnOfnBHCwp1URhtNYmjIEju2G6b6SHxOaBE8hha
 SPJDRBst14K51rhx5nB/pvhVSajOw2dCtVBGW9py0kmdwoJiPasnMVak7OBBAgcErCFz
 s3op/4gLxbRwaV3Ld89uhcq6bgpHuoYAufNbqSh/HcLTb8gw3liX34xE8NyxJRZ13On0
 d5HSMrXfbtjINn+ua4h9YpCycuZS9wJR1+3q1uHDq1kOjjK4f2DYt/dbkinDdKYcrgXr
 qM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216626; x=1789821426;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3JKzLnapSEUlGTnGQDFiRnSum0e56IeVk/uWK3ch9x8=;
 b=Q0VeIWI868pB3afNwdz5oR27iB25yymE6uYFLvdqMCK7iIwS5kUaI9canC0BLb89Vh
 sdG8mDg6O079aVsEQv4WxoyCY5B9Sb5uXKUWnyPWUbHOKB4uLXsCIiDkKooom0vPAnlo
 T4Crz93pxbg9DwhXvYd2ls1tLmlcrWV3cFL7AEM8IbWhVThmfgJqpsgOK2FfSLqlnPaU
 ySsuvukofWz7/waUFUdtwMt6zPJQrq9v6e4x52eiktaAJVU0GwOXLJU9qKc28px/1P5W
 9nSdi810xfrRHXLqCUufVO1Vq0Ootaf4pC8tiPL0PWfwx98t6G7Qomg3RDdqvM4AuqV0
 vULg==
X-Forwarded-Encrypted: i=1;
 AKwUvByY3d1Ra7mrxRjyXOJvLhOPQ+9n9FtB+4S2AI5UNPF5jW6k4x/oFIewPEpZHbMZCzIaNkA75jY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k5e8MAj2kbmyFJgoFyXfstGxdaB1W5F4MAlU0XKvFxBQLdWboc
 TojwtEbVMqHcp+qUC3iTlT+BEUz8FBq1uT9Ss1x3h2M7Y9LBhgsF5pgbp5/eFc70cZc=
X-Gm-Gg: AYBFou035yIZs5FYuSzwcgDeLbxWC4yZH4osEiv1ANtVA4qFFGA3cQOKzK+IjW6qPtC
 SSwW8NuLZDH1WUt1wdwuA7jbe1q5fRFa4GPdLfqBfMZ/fQ6xMc3L3VcpKP/j5a0egoljBfHZZuc
 yNULgiUzOH/t9fYhELApbLBw9sEIDao7CB3J43bNnf14app2MxBrtC4Q0+L20BpMW0LMacku/yw
 0cDqon47r36FOJuta2hmjvPp4ee7atUYmqG/EUt240FAANusBtkq+V3AtrgYmWJBpcgKZL1cCdp
 Ns+lVya58OnIGgFMjUCUEWuB3UwvvFxzLHVHTWzn1EpRNYR8exG0N4SGwPhxdwqFKNebH9sqZs0
 iPREd1F4OE1lPNV3AY8dhekbZUl3A4REoh8mQkSs6mFq8x8JNHBXyvSKvliRDHZwpq+tHnItD2v
 HVt7LVfxFOc5pjBkFgVl7GXnO9av4MB2vfg6Gg8Mo8HON975BX5hOY6FNp2DL1QBNELQzr9AkIW
 cSXpL9IzLXMT3xQuo6sspgEBwpvoh2Uj1rjLQnkzVp4JZxAn3CI2pwNDkUzgcoz1QKMhv0186T8
 dhjsfLXphm6X4/7ewGgJ8F0gKwEc/mSyp9+r
X-Received: by 2002:a17:90a:ec8c:b0:395:4290:46e0 with SMTP id
 98e67ed59e1d1-39d9bbe4910mr16947726a91.5.1789216626353; 
 Sat, 12 Sep 2026 05:37:06 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm13288737c88.13.2026.09.12.05.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:37:05 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v13 0/7] spacemit mmc driver
Date: Sat, 12 Sep 2026 20:36:53 +0800
Message-Id: <20260912-m4-v13-0-71043b29630f@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGVHpWoC/23RS07EMAwG4KuMsqYoTuM0ZsU9EIs8HKZI81AzV
 KDR3J2kRZoCWTryZ0e/ryLzNHIWT7urmHge83g6lgL6h50Ie3d8426M5UEoqYw0irqD7siyBIO
 UOHlRGs8Tp/FzmfLyutb5w79zuFRZO/Zjvpymr2XNDLXv18AZOtk5gGSjJsNGPU9jDvnipsdwO
 og6c1b/lSoq+EAQjLd9tA3V39UgcVF9UejIhyEpTAEbSm/VsChdVPRRAlhMBNBQuFFKLQrrDzU
 4QmAEHBrKbNW6yxSlElo0JmobXEPRXVlY06CiSnamnKYn5amhQG6Y0mv0subB0sXggWPbbU5GP
 zFCvZnqkV2IpBPLllNbZ1ZXr2aJPTqb7EDxj7vdbt/ccHT8lgIAAA==
X-Change-ID: 20260629-m4-98e01659fefb
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>, 
 Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.15.2
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

This series adds MMC support for the SpacemiT K1: an SDHCI platform
driver, the SD card device-tree overlay, defconfig options, and SPL
boot-device selection from the SoC strap/config registers. The SDHCI
driver is usable in both SPL and U-Boot proper.

A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
write images to eMMC.

---
Changes in v13:
- mmc: Sync the definition values from upstream mmc driver.
- doc: Only flash the minimised partitions for SD boot.
- Link to v12: https://patch.msgid.link/20260906-m4-v12-0-89eb5a8f879d@riscstar.com

Changes in v12:
- dts: Drop all upstreamed DTS patches since they're merged now.
- Link to v11: https://patch.msgid.link/20260905-m4-v11-0-235eacd94fe0@riscstar.com

Changes in v11:
- spl: Fix the read_boot_mode() that returns both boot mode and boot device.
- Link to v10: https://patch.msgid.link/20260824-m4-v10-0-5e0adcb1edb9@riscstar.com

Changes in v10:
- pinctrl: Move all pinctrl patches into a new patch set.
- Link to v9: https://patch.msgid.link/20260819-m4-v9-0-6e66016392b9@riscstar.com

Changes in v9:
- spl: Enhance detection on booting from SD.
- dts: Synched upstream DTS files for K1.
- doc: Create SD card image from scratch.
- mmc: Avoid to use CMD18 on SD card in SPL.
- pinctrl: Drop "fix drive strength configuration".
- Link to v8: https://patch.msgid.link/20260802-m4-v8-4-e916643205f3@riscstar.com

Changes in v8:
- doc: Remove SD card.
- Link to v7: https://patch.msgid.link/20260729-m4-v7-8-2cb04b4fe389@riscstar.com

Changes in v7:
- env: Drop env support on the mmc series.
- dts: Sync upstream DTS files for spacemit.
- pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuration.
- spl: Fix DTB matching.
- Link to v6: https://patch.msgid.link/20260727-m4-v6-0-2f58566d48ca@riscstar.com

Changes in v6:
- pinctrl: Fix drive strength configuration.
- pinctrl: Fix pull-up/pull-down configuration.
- pinctrl: Use dev_read_phandle_with_args() to fetch "spacemit,syscon" instead.
- spacemit: rebase on latest upstream branch.
- Link to v5: https://patch.msgid.link/20260722-m4-v5-0-c41a951e5157@riscstar.com

Changes in v5:
- mmc: Split CMD23 support out.
- mmc: Use read_poll_timeout().
- mmc: Set pinctrl state based on selected timing mode.
- mmc: Remove the condition based on quirks.
- pinctrl: Fix power source argument.
- dts: Add missing power source on mmc pins.
- Link to v4: https://patch.msgid.link/20260707-m4-v4-0-dbd01185f911@riscstar.com

Changes in v4:
- mmc: Add CMD23 for write.
- mmc: Fix CMD23 only for CMD18.
- mmc: Update bulk release operations on reset and clocks for spacemit
  platform driver.
- MAINTAINER: update the maintainer of Spacemit K1.
- Link to v3: https://patch.msgid.link/20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com

Changes in v3:
- pinctrl: Fix "fast" by "uhs".
- pinctrl: Add syscon dependency.
- mmc: Fix quick by capability.
- doc: Add SD boot support.
- Link to v2: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc

Changes in v2:
- cmd: drop patches on eminfo & tlv_eeprom.
- configs: Enable ADMA and SYSCON support.
- dts: Use vmmc-supply as vqmmc-supply on the SD card node.
- mmc: k1: Enable ADMA mode support, use CMD23 for multi-block
  read/write, correct pinctrl state from "fast" to "uhs".
- mmc: sdhci: Add new quirk patch to enable CMD23 for multi-block
  transfers.
- pinctrl: k1: Add new IO power domain configuration support for
  dual-voltage GPIO banks.
- spacemit: k1: Use FIELD_GET() to parse boot strap mode.
- Link to v1: https://lore.kernel.org/u-boot/20260521-k1-spl-mmc-sdcard-v1-0-1bd14b8c4f9f@riscstar.com/

To: u-boot-spacemit@groups.io
To: u-boot@lists.u-boot-project.org
To: Yao Zi <me@ziyao.cc>
Cc: Huan Zhou <pericycle.cc@gmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Siu Ming Tong <smtong@axiado.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Tim Ouyang <tim609@andestech.com>
Cc: Leo Liang <leo.liang@sifive.com>

---
Eric Chung (7):
      spacemit: k1: select boot device via config registers
      mmc: k1: add sdhci platform driver
      dts: k1: enable mmc devices in SPL
      configs: k1: enable SD and eMMC support
      MAINTAINER: update Spacemit K1 entry
      doc: spacemit: flash on K1 SoC based boards
      spacemit: k1: fix product name detection and DTB matching in SPL

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  12 +-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 136 +-----
 board/spacemit/k1/MAINTAINERS             |   5 +-
 board/spacemit/k1/spl.c                   | 148 ++++++-
 configs/spacemit_k1_defconfig             |  22 +
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-mmc.rst             | 268 ++++++++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/spacemit_sdhci.c              | 684 ++++++++++++++++++++++++++++++
 10 files changed, 1136 insertions(+), 148 deletions(-)
---
base-commit: ff22b8227d2531e3698ef1e2623805d0bfb20bbb
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

