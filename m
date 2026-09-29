Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BE2CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEB15810B1;
	Tue, 29 Sep 2026 22:21:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lnMA45zAsNMs; Tue, 29 Sep 2026 22:21:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9C3BA8109C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790720478;
	b=p0gN+I61IZnELlz2x1525capx2NWXKVdBe9eztXqYnq/TBFrM16jiyGTCmwGRUG+cSRX
	 10hKlIqxbPEyrxddSA56dxz+D8wt9QRcZ7RE5YwJat3y/K/pvoCg0ShAIc+bDPWk+8BHS
	 MHA1b7ngxleXHsvMFmDkNxPYWCytlBv9KOw3x7LZ/GGmU5jPadbZQJL2icM+fe6nA7b9X
	 7Bd1+VlV1s401tlrR4WTFLUf/mz5fd9/EK54PkjVYeOvFnEvH//Zd4XukRi0Y6YRwdJqC
	 oErwtVRddxlnzJGEp1UCGYLrjM+uqUiWcjG1Y7GvfcGtLdmcUD0DcAR9V4F/PSXqI+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790720478;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=u8Onw+eTNb5LvSV0HnJyqQrqTgvUsmOZ4BOysjeUeUo=;
	b=Oj4dgH8qzghYLxDx/eXF88igWkjEbVCW7zE1glFOR3vfG6e5wHtHEhw9Hk8Hp2gPOEy+
	 ViIVtqZKZOZOLcwroMH6DaNC8MCesQ9VsHs0rLbe6OL2+q5BwF0HETJjm15GarRxcGgPW
	 ngLcXDSQEzMLLtou0WCTW3YeM9RBUOHOJO2JlJkNhYYIq3AKab8x6GG4Y6k1uDEHp7tMQ
	 tn6RO/6TUy8zrNJEb9+cLJVliD4nAIJxO6KXyjKMJy6Tievp/v6vBGAKhExP88SzmVVmC
	 oss7WhpGPWvS0C81pYBQokmP4Sk5PPMJXy4b8iKWE9MuZ4XZcGsKzLIMTJqEsOY9ZOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cjQaFPpm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790720478;
	bh=u8Onw+eTNb5LvSV0HnJyqQrqTgvUsmOZ4BOysjeUeUo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o9rMAXvsvUY3tLVOWvGyYQeobtFu7634OtSx9u214XG53wGvh1U1jk+CA8AH2qK6j
	 cJJruufsc2IuAsXjZJEEd1hB1KQ9Kn3TIbgAuWBjxnoYVm1mlN4LpegVoO3uECv9Hj
	 U5mGKlWUmO3G0qfWSrA8YKwnfjW4VUXHDAa2x0iPiV04LBgipDGiQQa4Rq9N2Arr7U
	 NWCiU/du9AFyBrNrUbVOqcO1El3ufFD53rOZq7oWNLdTZbwkcvUwEeA9Y0WlUy0ANz
	 rBfCSVvhhKsSN9lodtszGGeW34FbPjdAis0YYUbx8KypwNyQJQYvxZAtpJjSffouLX
	 R+U/Zagd23MFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C3BA8109C;
	Tue, 29 Sep 2026 22:21:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6130833B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 466A38109C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yqk0D3XVmYmk for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:21:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A50B38100A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:3a::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790720476;
 b=f7FNtccFYcm/MJ8semGMjyEokPcif4IFaatwPy8Fs7i1fHnjm6/jI02ohORPk7OVVusn
 o987dR0wHV+OminuT5X3F00pO0qNnbzXdejvPnx5lkwsDgtDwHft3S0+y5VMldw/0pH0j
 6mfJ39WvLM1iWl6eyfBmbtA+4runQTlcOfq+5Gb0uukD/nryoSSZmb4xI+8+mryl/4GXb
 yd4KWdKtrHsGgt1rQ8W7qVpspJH2hrNztlb2lIQZVDnA8YyVAwgvmc7K7W1po9cJ6zl/a
 pqJ8P1b+pj0p/hR9TDiEQfQcbXVfGQ/rn/zeEiLQdD/nsOzsn1M3x/+DbMb1Rf/Twsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790720476;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=u8Onw+eTNb5LvSV0HnJyqQrqTgvUsmOZ4BOysjeUeUo=;
 b=JTW3oOtuH67GY5hJE6VQ+blmRW8/hgYRPpYpj3H5q4ELVm7Xn1SARPriuUj1J35dYNuS
 QJVk3dCPWT6HmriBLTcovtt+5eNvOG5d+YFwtTO94vthWbnXfUdhYsKeWkBjXzMGAVSfa
 9W3+j1uPwI5WjBNyXiwwGSOK8LNn6AUN8damIslAr6anstQikGeOT790ZGBWlBSW9ax9C
 O/mkF1ca5AfRxWVxKv5alYL3Jb3hkXEQs8IRqetrDdfnnxFVkjAA3h/bGGJwraFmNsvzO
 NxFPjZrvtF011eE3jAOGQV+IF5kAycy3Odsk0o2SX5YOpX8Y9gzLMbmdqSBRyvK5spg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cjQaFPpm; 
 arc=none smtp.remote-ip="2a00:1450:4864:3a::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:3a::d;
 helo=mail-vs2-x0d.google.com; envelope-from=hfranco@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cjQaFPpm
Received: from mail-vs2-x0d.google.com (mail-vs2-x0d.google.com
 [IPv6:2a00:1450:4864:3a::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A50B38100A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:14 +0000 (UTC)
Received: by mail-vs2-x0d.google.com with SMTP id
 71dfb90a1353d-5c67e512ee5so1634750e0c.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790720474; x=1791325274;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u8Onw+eTNb5LvSV0HnJyqQrqTgvUsmOZ4BOysjeUeUo=;
 b=cjQaFPpmYqi5Dk2uTO+fVDHNTpV+4Y4ewNSGJV1UzYrzRdI3FovCqLlDLY/vX0Hsan
 15FH5kFgwuEId9HJcPG1pfQ5cpH4d6RIzdxZMrX79QQOTpT5jyuwzhjnlr1/8uApOJZw
 HUbIZBMqkPHxyFh1wJ5coOIF4U0nOUexXQYXnBq7mpaUuKdCbBPM2BawCrTtskfsnefp
 P3KKGBk7L/vgAnMqMKpoztdGJ+KwdPuZnDzTfE9hLOV1uXuJOFVWBXeOXW3r743Kaj1K
 2fSF3Yrl8CK9WXhC8bacBRs01sJryn8ES1qBDS4S/+4zB36jCmEZd/e3f5hxZ++QFdjw
 hsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790720474; x=1791325274;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u8Onw+eTNb5LvSV0HnJyqQrqTgvUsmOZ4BOysjeUeUo=;
 b=x0rw7dzEl9rOd4dxrlbWXXeEvflsCFZiOax66sAvK8+3JmvM5YuVL3/bR8INdVzZub
 ICj6e5Hxh3c2REgGQMRtfsa4NTr4NjPdvRcHEoJ3j0wWH0AfnS9y8YSTr91dYxBz9cDy
 KtsDC4RumrnMrqL6yxgvhUoOi9sPyLnrkdfHPf4g+puEWo+Ezo1XrpbGOJ5L/iNJCZk5
 cPPdXYVE/6i8cgNVjSTVAxZlXLe561AafLdL68+YXmTcTIWrtkURSVf3N5AwT0gK/GDS
 0yeDyFCedmvxYl5Ian1RIVMwwRCEtUuTml5QVJO8NlpQnCvbjT9S+nczixqTK+NuU6Iz
 YQeg==
X-Gm-Message-State: AFq9FYKjyQeflZ1CH5dLZSUpgbGAlx9HXdUTC6EP1zQR3l5s7nuKnOmE
 XSxzMSfdOLSxeOzOysePlQolQ9darZnoQ+UTG3DqadSYHI+8/bxtMxxXeqbhM4O1oPI=
X-Gm-Gg: AYBFou0ID3+ffgkkhttvlSntst2j60YQ3q57IRh+2X4nlEdNsGS6eJvazS6kdCWFTek
 dKWqKhOoiPgd0CT4eHUK6yq9C+ml6fvAB9IPO+b33a9Ls1r7uWRGeGBQW4wKgvfR1ofODuplElh
 NUxAFqcDjwuJAy07uUbmwqYoejKjbiDZcgOdgsBChnQq/PUtJ/BRA353pAfnoIwXAnD7HB8922l
 HsQllZMM/vxA0DaS1Xn0qcOTKY/fOLK+d1ebTd+5weKduMXOaCcjg6/n2pV3xyrYfT8Qd41OlBv
 I48dtVJZ9R/at2P79GtSLQfKG7NXKy2z+etLXsoYLUfkzSEXYeh+SCfPmigmAfaxwwF1F6WGyFJ
 /8EW2K89xvzTjoLv+ygt5qJaL6/6p0f9/cP1lfBTDq8iC12gaPr4c+FHY1WzKEeIlhB+zKCEGbZ
 89KuEVwintIgiPdel15xxVFQ/wnH+1Vx2EaqJYzD2CGzAeJVUz11YX82AKnwK/boXxwjpO0QlED
 stw3Eoz+/7X90FlOY8smqdkQuSVpYHmbnagQQ==
X-Received: by 2002:a05:6102:15a3:b0:7a7:12c0:f061 with SMTP id
 ada2fe7eead31-7bc3b58e053mr337437137.12.1790720473632; 
 Tue, 29 Sep 2026 15:21:13 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::ddab])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-988d2a051f8sm746472241.3.2026.09.29.15.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:21:13 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Subject: [PATCH 0/3] board: sophgo: milkv_duo: enable standard boot
Date: Tue, 29 Sep 2026 19:20:30 -0300
Message-Id: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NS47DIBQEr2KxHiQexjb2VaIs+DQzTMYhAWxFi
 nL3OB8psyypu+rKCnJEYVNzZRlrLDEdN6Cvhrkfc/wGj35jJoXsxShHPse/w8r9krhNqZbqOSm
 PDgqiRWDb75QR4uXp3O1fXBb7C1cfovci47xssfqafVpT8ywNQv4rLadSM8zMfS3cdsrAKwqup
 2ntHj5rCrhL8xzr1AQN26p+BBka3DBaoQbbBt9qAy0FtKbeEHVsf7vdAa3mEQz/AAAA
X-Change-ID: 20260929-milkv-duo-bootstd-14de5e4e03ef
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>
X-Mailer: b4 0.16.0
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

The Milk-V Duo (CV1800B, 64MB) does not enable CONFIG_BOOTSTD_DEFAULTS
and has no environment file, so U-Boot has no bootcmd and none of the
kernel_addr_r, fdt_addr_r, ramdisk_addr_r, ... variables required by
the extlinux bootmeth.

Enable CONFIG_BOOTSTD_DEFAULTS and add a milkv_duo.env with a memory
layout that fits into the 64MB of DRAM:

  0x80200000  kernel_addr_r       (16MB)
  0x81200000  kernel_comp_addr_r  (16MB, Image.gz decompression)
  0x82200000  fdt_addr_r
  0x82300000  scriptaddr
  0x82400000  pxefile_addr_r
  0x82500000  ramdisk_addr_r

Also reduce CONFIG_STACK_SIZE to 1MB. LMB reserves CONFIG_STACK_SIZE
below the relocated stack pointer, and the default 16MB left only about
1.4MB between ramdisk_addr_r and the reserved region. With 1MB, about
16MB are available for an initrd.

This series depends on Zhuxu Ran's "riscv: sophgo: Use upstream
devicetrees for CV18xx boards" (v5), which sets CONFIG_DEFAULT_DEVICE_TREE
to sophgo/<board>, so that fdtfile matches the Linux devicetree install
path (sophgo/cv1800b-milkv-duo.dtb and sophgo/sg2002-milkv-duo256m.dtb).

Link: https://lore.kernel.org/all/20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com/

Tested on Milk-V Duo, booting Linux through "bootflow scan" and an
extlinux.conf on the SD card.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
Hiago De Franco (3):
      board: sophgo: milkv_duo: add environment for standard boot
      configs: milkv_duo: enable BOOTSTD_DEFAULTS
      configs: milkv_duo: reduce CONFIG_STACK_SIZE to 1MB

 board/sophgo/milkv_duo/milkv_duo.env |  8 ++++++++
 configs/milkv_duo_defconfig          | 13 ++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)
---
base-commit: f8eb3469e1a17c79b047b3fd38ae820e8816a115
change-id: 20260929-milkv-duo-bootstd-14de5e4e03ef
prerequisite-change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61:v5
prerequisite-patch-id: b8e6815314b7881a02de0066232864d522c4a26c
prerequisite-patch-id: 0df1fa5db1b2bff402b429809796bad99a517483
prerequisite-patch-id: 49e1e8263cf0a5ba8d63c8b598b6382cde5284b2
prerequisite-patch-id: 86dd30e784f022f0a7bb6fbf125c9699467176d4
prerequisite-patch-id: 49070c05ecf58331ec519a57d1b82f8b2b835a89
prerequisite-patch-id: 6b6881e45cc6de6544aaa4509db21611158f4fa1
prerequisite-patch-id: 7198127d4602eeb14212087ce9bb694d84e71a4c
prerequisite-patch-id: 3a58bd8a061707ff27b8538d4897def3b595dc36
prerequisite-patch-id: 9055ea941b73e35d1e825787d7eca14ffceb8e8b
prerequisite-patch-id: 554c1487e8d596e0099677ca88eee0021b1ffbae

Best regards,
--  
Hiago

