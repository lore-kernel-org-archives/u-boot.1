Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE676C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B705812A0;
	Fri, 18 Sep 2026 12:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Gia7STIZQvU; Fri, 18 Sep 2026 12:14:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D4A918129C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789733663;
	b=nwn4bm997+nkr/HYM583GTlXHicmhV/zHa+eFD7BPirOC/9pwx7pl/wJlWf/iIuS6Cj2
	 7uBOirhvVL6RJqHL1UHmV7rSoPLgEOm7yULLMssCWh8L0XS8W2FeyOszmtNJJmcJqTB0H
	 3U0bkO8wgNhrYP2UaazJg1mLbyr/S/Av5/Ed/kaMO77LOzySys7YwBfmRlgXW78b3Dltx
	 LL6WgicRhTCFJWVk9XwnDIzF97llHG0S433oZpoNpZco9jbp5PUzF7cs5a49t2L7euY0l
	 RU9n7JUSS6M6FD2qGKfkTijRIonqtw8pPrMrN9I18w4UpJ3qxmcCVQ6e3OelayN6qbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789733663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=djRnHyKCiFVGofNwxkOzZK+AHH/RVuUb6+sStERVzmQ=;
	b=Mhf2nyZhJOnXyv1tmqgzyT1wRMXAJH9sh5AK5fsuFMOrJYHYURgcJkPMMaj/K/+N5Zbw
	 EMHQGndWasRPvRJQfd/9NVr/r0j/a3mcEa9daY1UUTviVysJ90/mkmM8UuwD2ZNMYEGC8
	 X/og0hc83V4PkGUBS0apnoRi20zK5i5dvWOo6ib1Wure8+xin6zDGqO8cm0vLQL4Khhfj
	 JqqZu3teX8C5zksWxIkxxdn/gXf74jPEH4DM0JMl+b+DYp3ZVqZxyLzw9A0VuW172onGG
	 C0z+iek9EO3/5EwJTaY+y/c3U/v1yBsN9o9ZlLPBlWt9VxRg/G8OsebqgOUxrcci6xQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="H/QrgiKG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789733663;
	bh=djRnHyKCiFVGofNwxkOzZK+AHH/RVuUb6+sStERVzmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vZD85F9NKVbP0G9FNUP0yPGcXhd5w1tgZmXefmsT4xMdTFJqK8LZ3fKgEdAUpXtaN
	 p4QJHADXbQaQZVw/mT1/2KSwLbyGkfyyEgnCrqHaVcPP8LAdb3GKx98puuC3XKeSym
	 QltfK3MKBrP3gmJc0ND8ve8+kD0vJDP8y1A9KojEpqsOyQzQ49RH6iurrNtasm/gin
	 ZCoQNGzRJsMwuSaauaCVCR/Tsba2UnhgL8FBNyFGGMK6BsYL60ow27x96kaKlzlxIl
	 v7ujLHcABkUnXGl2bCFxj5KTC8B3FhEyZ+paLRUKfLHy3VZ8lu+treEa86jd0p348x
	 w7V2qVrRlWacA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4A918129C;
	Fri, 18 Sep 2026 12:14:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAC9D13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD3308129C
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vghPGkN4g3FV for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:14:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AE6CE8128C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733660;
 b=bSVMLmBgcmJiotbbkjy/ZKJkfIcK5pjaQ+NT4OW1kwTS2VWICB1m4uYPo8EEfmljnpPK
 qp+2LHqO261Tqk4aJ1dpA2ruORroQ8DPex3OjMItPMkfUxMNvtQf+zeoH3XwlzyRWzSqs
 htLiCXqsYS8xigfm+fUdSTjykY5aCA50F/qHjvur3X/p/MU7Liao6QWQTlFI6CPbIEh2h
 pWtALE1F6H/Ln3HJsUZSAd2jHJyDyjySEi8ZJtjL4gljaKep6vRuNsIcXZg165vC1DmxD
 kllTUwT6aGuP88MNZ1vyXeXkZfLnoMTdc+CRCYhhAoi2PHHh0MFptaFXrplhjorWNSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733660;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=djRnHyKCiFVGofNwxkOzZK+AHH/RVuUb6+sStERVzmQ=;
 b=kuI8g9xyMHxr72Xz5y13qJR8ZppCQ4ANu//jFFsbkKoFIuBwLJ5SEUiSbbGsmbcWkyrG
 P4sO5+sdMbVb9NN9ry6pR54HWoBH2dzINNQBGZ8ZqkiWHVYM/sNMAoyMC6uPWFmP0pEmR
 m+UB1Hf5WdbrO6mlktbWSu1F93bJSCMSeuiE1MYpUZIhLu5nhiZRtDNQp/rzkAKSagx2N
 mPwCGmxNXjGGoKtvsWU7vHJYzdlW3lGsIBruIZFXPRfhZjLWpvJguuRigQ0Uzf4faSqvW
 nOlFU6/t+QVAeJ0MiZ6yrUTbrQSYuQnxyaQXQF1xrPWXbc2EbG9qV1ipSgvWqlQfivQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="H/QrgiKG"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=H/QrgiKG
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE6CE8128C
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:19 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so4407665e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789733658; x=1790338458;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=djRnHyKCiFVGofNwxkOzZK+AHH/RVuUb6+sStERVzmQ=;
 b=H/QrgiKGIruPrOzq6M5dmT8g9+ewKeyirMxePBqLPfo0pgsADa0mPAHRTfgix3L0lj
 0K2U7nZlqK6D66cBGjVxB/2jY0M1aq9YXBRrkVqXOtsMGf71PYUEVIr7ZeOSzfz0rjld
 8OCQbyICHdoQw71HdQg823kF5QIRN9pt1zcNUYX7xX4PVZy0XHSZkdlLbhk6rGDiNtAY
 CL23tPpfYDYVIf2GLu5gXKJIJe/v7Hw6zzrFFaSVqm5eG/uJQ8GDqu/SwMwZ7HnO+5y0
 2K6wuKljuSEpjcaqIy34LCEenoB0mZbHjL31bHAxK0bJlnHCA9+hN11Zzy4Z7czcQ/Mp
 MNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733658; x=1790338458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=djRnHyKCiFVGofNwxkOzZK+AHH/RVuUb6+sStERVzmQ=;
 b=qDOJxQKjPavzPC2S7cU2U7kJkY8delXpMu0DGBR7EFbd7wnAb4eGRgvBd0BdeJ3lDg
 WoN23Xychl3wQNd+7oe7u9HBLCx7HB5azNnkCOvfCiJqfxphkuE8OZr1iVv942Xeocw6
 z4a8LofPnLWW1yx4UxYj87oZwET/PBkIhzmkwLw576AU+ZkU9cRK40w/Hi1ekLB6nL6k
 +jm2wkfqnJ3JmqnRg81ikZ+WYLOCZ/2uAaPYy8uI2lTIAmwuNVPmB+PRIq8YnyPw+Tv4
 gfXrek/HTdZXR3mA93y3XhfXjzKR798eWOv6OcUh1LodH3Bso3yr4N5bMUAnwjSrbb32
 yReA==
X-Gm-Message-State: AFuF++n8Ux+MzHx8W5BpjUJqtwxr/M2kdxWATthuKBTjffrSftpYhV7n
 TDEClwQDJmGAVmEoUOpuCk2rmu8ZIkr1rdLLCgPKsnTZDnhYKxBrsNisln9/Ju/QDa0NTNMTc9s
 PlVLE
X-Gm-Gg: AYBFou1Vt/hoJ6yxjiWvJH2A0/Jr9IOe9BrFxaCsXGUdZKtHR/djmGNfhIKVGwTBovY
 hi3xr+/6rOszhOgl+wuNjhWx7VIEodAM0E7SWLT7sBkl6hukqxUQGoFl1CEr8wFX3aYj8JNx/8d
 1Lu/7a+e77z+pLSEUV7F3/NMUgjZV8DEGajk56eBjxu9wzc74M2wWPak+ywde7qahpZlPsLeqwS
 XbFirkIvqxBtESK5gxEt5htyuKYyQS6C9tLHmD5m0xmUV8NqZQWkvj7nOkuZ2vsT1D2xng7TX+8
 4ZTDsH6jVBjUO/a0DKyhENxqDcllD7wjblOkYz2kLxGsRbdyMzJlR35Fj3MZwNztTUOu/t5xUyu
 2UZha2QnSGJY/9BXp0tZW8p0IcCmIGafVEVe+0wTuocM26tlAM2Uv4/BouTieCGTaJ3wKVWyFNw
 broY76Vf+WKn5PgOXFkH7+/NZ3HpTgf1o4dowU5vSWNfWtt9U1cDJkjx9qHeSCcJSOO352lkDX/
 uAS3rMDFsVU6uPsYJbr2+wPCIGd1TcTEflQqdx5nBdhWIZX8qc=
X-Received: by 2002:a05:600c:c490:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49fc573e8b8mr54510045e9.16.1789733657731; 
 Fri, 18 Sep 2026 05:14:17 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc59286b6sm42755035e9.4.2026.09.18.05.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:14:17 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 16:13:54 +0400
Subject: [PATCH v2 5/7] configs: malta64: Enable EFI_PARTITION and BLKMAP
 for big-endian tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-gpt-4k-v2-5-daefa4792e9f@flipper.net>
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=alchark@flipper.net;
 h=from:subject:message-id; bh=14hgLfH8VtgJxEF5PzmkuY6QMATO58xEVxBNBegKkXw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt1eY7s2vuNeO/a6JWVAidLRI3EX67udzrt3WvzrTSn
 W7NbSwHOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjq10qMDPOflPy53igqX/FgSeypX2pTeKSO3VZbuje6StdsJ9vkt2yMDMt3l8w
 NuSfvoV+35XQZs1PJh3KJXr6jW7Rfp2Ru3XQrggUA
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

disk/part_efi.c has no big-endian coverage in CI, which is how its
little-endian assumptions went unnoticed. The GPT tests in
test/py/tests/test_gpt.py are restricted to sandbox because they rely on
'host bind', and test/dm/part.c is sandbox-only because UT_DM depends on
SANDBOX.

The two tests in test/lib/part_efi.c need neither. One works on a
synthetic descriptor and the other on a memory-backed blkmap device, and
test/lib/ is built for every board that enables CONFIG_UNIT_TEST. malta64
already sets that and already runs the full pytest suite in CI as the
qemu_malta64 job, so enabling EFI_PARTITION and BLKMAP is enough to have
both tests built and executed on a big-endian target. The subtests are
collected from u-boot.sym automatically, so CI needs no change.

Pick malta64 rather than malta because the width matters. hdr_start and
pte_start in gpt_fill_pte() are size_t, so on a 32-bit big-endian target
an unconverted __le64 truncates to zero and the partition overlap check
still happens to reject an overlap. On MIPS64 the same value stays large,
the check accepts a partition that overlaps the entry array, and the test
notices.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/malta64_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/malta64_defconfig b/configs/malta64_defconfig
index e927be3b38ec..9a5bbe15da92 100644
--- a/configs/malta64_defconfig
+++ b/configs/malta64_defconfig
@@ -26,7 +26,9 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
 # CONFIG_ISO_PARTITION is not set
+CONFIG_EFI_PARTITION=y
 CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_BLKMAP=y
 CONFIG_SYS_IDE_MAXBUS=1
 CONFIG_SYS_ATA_DATA_OFFSET=0
 CONFIG_SYS_ATA_REG_OFFSET=0

-- 
2.55.0

