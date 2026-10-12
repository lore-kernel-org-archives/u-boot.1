Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7305ACA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2601140539;
	Mon, 12 Oct 2026 21:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0hrIDmj2Omg; Mon, 12 Oct 2026 21:50:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42A3540515
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791841813;
	b=jfE+Y0aL+i4iYSqHwrTySfmL3iZV8RMCicxanQnKFTJa3vD98P6gn+wIICItlUi7yb+O
	 HcwXZCvFsY6RifhXESYqNCoBD6vRezvXpiYyvKLAoQN36aFWeqoQZiK/hk/lQFRcS7pXZ
	 3kvLBeo+4SoQXLjtflP7kJZDVqG5/czrrQeaBBz/P5YmY9R9p7/Ptis598lfoUX56+ZZf
	 EIVOeAmG7Po0V665lMS6rkBewzXV1K7hhS7jKfCeD08aaMagk6eyhuDHQ12u4R+t868wd
	 nVkPvCQLmZcK2RUnY7ZPRm/NDVKx4t1m6n8WZJ04MD5sISHw30lwAT1LqjuVst7Y5QQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791841813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DgXSAGTQSwSESsMeO0L4IDqHKiN5rKYynAkCBkqPKAg=;
	b=CcxCXA9s2FufweydLrG1xbjd0bxaSXXsb2E+4xUS2gOIOOfU7m4gz5c8DlqDPbJUV085
	 kdOvRGh3qqE7LYgCo9ijX/cMVyQVdnQRDIz+xcBYm8DturYNXAY9uEvXr2Ed/nlMn1Dk5
	 dZE/41hCaqxac0GUT8ZzOhCiHPXxMsME06UZvX75V0BUPDcGTbod0jNHNfrTdT8xZozb2
	 jXgrRhZRDHfKc//fUV+/AuQNbp85N0UTRxOWj7x6xzU0aauhFfCS9svrFm4uq1fJZ8MYZ
	 JXv1NarHpHsJAO4Ut3W9BV2l2c4jxAckW4tJnfOIew4w+vjr8hIUp9//iHC+X5cvUtA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jzJU0np9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791841813;
	bh=DgXSAGTQSwSESsMeO0L4IDqHKiN5rKYynAkCBkqPKAg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SX9/EoyHOEKIRd5c27bIFENa/qJrkOUNYbGnrx/DQuVsMIs6orhBtZPsNlgHtk1Ev
	 KsTdeRsuS/FlB+CWWzuyEM1cmOz4+qUUpDvdhVTfB0tggsx9Q4IpqwS0d0zll+T9Wo
	 xpVJXocqehD6F1bC57C0WG3mCLMkqP8BFlzWYYpLl9x/oZCj03VeIEjO1zEfjo0btB
	 v/ssVbXdja2vqTaDYLWcr8ItAoGGwf5jKZRd+qLnJ0zf48zTLBpiCja64MZjGJAlqt
	 NzKR5sdZfo3QwN9RpzvsFHTAazn/n7YnitrBdBcCQh2qCfnmveO7R6YPVrq80bIU+e
	 AxQpOHKnzQkkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42A3540515;
	Mon, 12 Oct 2026 21:50:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96BA4105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CD00404EB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gb1kzP_UknuL for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:46:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74A38404E9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791841574;
 b=l2rAukMZbF0XypokZhxd+SuONvsGiqPa0RxRAQfEaikCnk7pQIU7ssfwcZS389dd33dX
 hQkfWP/7CwjDE9K4wyoORw6K2Ft0K5cPv3w1lqaLJA5LSn9kAA2ecRUh6nnpVNiRoIKKI
 j1zUOVySZhdyLP7RhFACzEmjTvqX2vVFqoBsXTKsZ0yssgO8d1L1SQXgYCijpHUwKVsza
 cYLkiwe41pdGOM0HjcDMgJOFGTakspZHfYOA+gMOFUL+PQ/xeBjZ9CUEDSb/NxM9rZt/c
 JjEajePM6ie+K8LWsNyYLq7pfVIPid4Cc7JDsmJ5HAUuFgaHjCX+d6lx4uWWRaMJhww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791841574;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=DgXSAGTQSwSESsMeO0L4IDqHKiN5rKYynAkCBkqPKAg=;
 b=Vty2jicBUV+s0nPAqxCEsAv3wF74QLJjPNRbwVNHM3GAMkGAxZVysJNJ/9IE5A6x/mw6
 Tl0SgIz9yIa710xSaINeI9HPZbv6Zs0UNv3EFrgdzT+atGQbJF5ugF/S8LM/gmnCOhM3s
 iXBsVIZ/eaMsxhwhq/iw+2OlEVU2liKAS/MFwSZuoiIYJDHtUENElNtja0cibMJLo/BNs
 eS8wnjd8sKgkMiZUYdHWL/D+X5fUQccQj/zxnipd6Z7nwg3/kDHMIMYEEE3D4EoC3TNo8
 DUKP/Zg3E/VnDWL48jv+1W+CZ/khKjJOtCjfruL3A/qczbpvGVgjG17XUWofLCPZOiw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jzJU0np9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2e; helo=mail-vs1-xe2e.google.com;
 envelope-from=sebasjosue84@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jzJU0np9
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74A38404E9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:46:13 +0000 (UTC)
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-78fb1fb9508so3866162137.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791841573; x=1792446373;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DgXSAGTQSwSESsMeO0L4IDqHKiN5rKYynAkCBkqPKAg=;
 b=jzJU0np9i09f+nTO9xIo0RsE8xhieMRDHKBnLBBJ+9C3TUo7iu7LBaikVznKN0XyqM
 jXKTfdIg+JKouapC45DFMbLDImmk0HfNe3BbDT/S2S0U3t2LliXOhG7i4V2H4Q9t7ovq
 pzEm5dc2qe3BDN8o3x9AZn/5JU9LhCTvsDZz/7s81ImEgPTtXtNbkKozA45sfphTepL0
 04oxXz8cWGW8ifLiX8UlZqz18SqYjEd2pMOEbsCD0TrjwDjXFkicH406/B2y3faKPzCr
 yIThAWuo1nXWuFPIjOEEAD4B7KcIgr3hm0upUwZS/gCviO4K6K4oC3dGsxaY10wSD3G9
 7MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791841573; x=1792446373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DgXSAGTQSwSESsMeO0L4IDqHKiN5rKYynAkCBkqPKAg=;
 b=nRXKNQfXy2L0h+VIPF4Pr+PIrfb/5hHeqymjqeRFacfcYo73ieK6l41SmHj4nC/A+X
 1RrQ8tOuV5EEpij24Ol0HtHxCAGIWJcwE57sX5f8/G/4lhb7Simheq/+HalSMgoR8ObT
 BI5d+FLojcwpkJcrSkcNmdOckRLqSRCORs+HC66y+mKdk1ePoHdaSzFXPY5ZWnM8AqSq
 DUM/SsbOM2v3hRmIsCtJfYv1TH7dIAusP5quQ04j21/ErqBwoHOi0yjYcYPQJ76Fsk5n
 8v1wjjhbzqUG22oGuxh85sIe1pZPXfPUzpK808hdijO+rPkNhnDXAykdidyAvUvUEkLV
 1XrA==
X-Gm-Message-State: AFq9FYIIWcYQNawmuYr/u6urwVAWqpThx4v058sxfm6ZvmwsmEuBZa8R
 MMjJ1QpTXw4upn+4Yu1aBfdOLvTFUgINSK/DeMxxI1A+WtEUcPJQBcA45AxCScyqgbEOhQ==
X-Gm-Gg: AYBFou0w6vXvg3nwcwfAYzFrKf8svg5GR4n20jbqiKwkPCt1wjCStn8UrCVf7h75fCS
 TZWg1yF51CHR5EysWNtRifHvRZ9mZ4/kS0TmKaTwd8mRBW3Y21EGbGDIaeVZwZj9uBm4LimKfQD
 DNqq8MskI2drmgwKotGumA88QVdlBn9OS6DgVnas4O75Clw+LC93KGDuDSrYp6RQ+j+NRIO32GY
 iFNS+Aex+vOGHjrQz46cykyeSmELBo0exTCo+P0hVtvIMC5YcE8bid0imFN26eF3kKxeXZlXTIj
 KFAdLnIt2TMPL0sAEekr935KrAIWa3hFr2BLuvStjSFUmQQf6MG5UYCnM+PAVm+tGMNSlSPHO1V
 7uYW6Di/q8iLgqb3yp03UZu0d6h8O4n3ycPBkl6UhSZeQbM7cFRguZasan+xLlDVLtYfaFugF3H
 YQre+rKv9SN1D1wcclTlyu6Qm+FgIOl7sJRgIZpObaV7Ern3V56fXtZ1IOBk89XU7ldboPhHgnE
 ZT26pGKDM4Nd2n3/mteb6oefBRc30sA9zM8PCSib9KQKe5lksB/YrBe3eIz/0k=
X-Received: by 2002:a05:6102:6449:b0:7c3:874d:60bb with SMTP id
 ada2fe7eead31-7cb426c067cmr2294628137.5.1791841572600; 
 Mon, 12 Oct 2026 14:46:12 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cb35471536sm7301225137.11.2026.10.12.14.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:46:11 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, michal.simek@amd.com,
 Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2 0/2] spl: Fix the uninitialised /fit-images entry point
Date: Mon, 12 Oct 2026 15:46:02 -0600
Message-ID: <20261012214604.1477684-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 21:50:12 +0000
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

Both the ATF and the OpenSBI hand-off paths look up the next stage's entry
point in a /fit-images node, trying fit_image_get_entry() and falling back
to fit_image_get_load(). Neither site tests the result of the fallback.

fit_image_get_address() returns -1 before it reaches the assignment to
*load in two cases: the property is absent, and the value does not fit in
a target ulong. The caller's ulong is left untouched in both, so a node
with neither property leaves the entry point uninitialised. It reaches
bl31_entry() as the BL33 entry point on ARM, and opensbi_info.next_addr,
the S-mode entry point, on RISC-V.

Both sites came from the same conversion in commit caa7fc2c5775 ("spl: Use
standard FIT entries"). fdt_getprop_u32() returned the value and yielded
FDT_ERROR on failure, so the variable was always assigned; the
fit_image_get_*() accessors moved the failure signal into a return value
that was then ignored.

The two paths differ in what a failed lookup means, so they are fixed
differently. In spl_invoke_atf() the caller has already initialised a
sane default (0 for BL32, CONFIG_TEXT_BASE for BL33), so the out
parameter is the whole fix and there is no status worth returning. In
spl_invoke_opensbi() there is no default, so the boot fails.

Changes in v2:
 - 1/2: drop the int return type. Tom pointed out that neither call site
   checked it, and there is nothing for them to do: the accessors leave
   the out parameter untouched on failure, so the default the caller
   already set up stands. The function is void and the commit message
   now spells out that mechanism. Subject reworded to match.
 - 2/2: unchanged.

v1: https://lore.kernel.org/u-boot/20261012015542.1156811-1-sebasjosue84@gmail.com/

Build-tested with no new warnings:
  sifive_unmatched_defconfig   (riscv64, spl/u-boot-spl)
  cm3588-nas-rk3588_defconfig  (aarch64, spl/u-boot-spl, covers spl_atf.c)

Sebastian Alba Vives (2):
  spl: atf: Keep the caller's default when the entry lookup fails
  spl: opensbi: Check the return of the entry/load lookup

 common/spl/spl_atf.c     | 21 ++++++++++++---------
 common/spl/spl_opensbi.c |  5 +++++
 2 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.43.0
