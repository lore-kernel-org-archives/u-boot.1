Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23578CC6B2D
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 04:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41AAD60ADA;
	Fri, 16 Oct 2026 04:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WPeaW3Gebv9x; Fri, 16 Oct 2026 04:02:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DE0A60AC5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792123351;
	b=DALQA+FVvtCDxBkFO9XD0GeuN+dVC1An9ZWVCMA6Lb0/e1Ckggo3DXuuv4e3484eQvTx
	 BhilHm8EzVDuB7SoQJb5gfqGCtuS/9uAp2XIWmI4Lv5u4ANaW182p5Ji92Rr8B4iD1vKd
	 Y7xh9NDUEub1Jn+w/BvgvjxJnuzbkYi/MuHJqFtGQv8+S/JCnxxSEE8vk+IHPTjcKVjEm
	 G+bV0gcGoXxby9bPSTw6X8iUqZn+Fgmy+DPTyf0VglMocv4q4yrGBbImGmuyOphNrXiZ7
	 J3gt1Aa7E8euFtPYYIIVz309g//D/nLdOpiljasKiEI0h2B3bGzbBs+lo0foJnk7Ofg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792123351;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0KHlC/3JhZW0LrLPKcMT4F4WlxBvPJeOQs1xmB0+tn8=;
	b=OsXLgAvTc3nEdUUJwKx7x6EP3eTApecG3JWvkthGAAoXseZ9lpJRhcO03hEvQdmm9915
	 lXhBOOkfo7gS22aL3c6S06bJ3J6tPZo12OdJ96WvnbIGChmawDQh+DUsJjoX6AG6KRCWl
	 m9FFeoN3B8C+XPASw7TBCi8Gg1YDJ3psSsHKj9niBwVWXxKgbvbfW2K2KxHxASpyI0TRo
	 D0uhQ6kpjtrdvBYIvFYwLPVmW8LiPG/f3ax24y2C2cd185jTUcUVD6CWcJqGVEgGyhgTj
	 yowlkeWcFk2IGN3eTlhruWQ8IjQunjD3l/22Tho4r/bKRQ4tHTHmwxLZy6aFg/+hr9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792123351;
	bh=0KHlC/3JhZW0LrLPKcMT4F4WlxBvPJeOQs1xmB0+tn8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jucdFlzwIuLN+LfVnIvUyYJLW3O+5NkfMy2Vv5nftN/D7/TGL02fIvwXkq8au6G8q
	 IpUz+bPIC0HiuvvIlRdMGgrtY+AzY/+wm0tT35PrlfoAUV5FBnpOSBzLZRAuXAIq8S
	 P7Fj2vPZaxAN4ztLSQ17Z3QF8gMFoMhvvWSr/YV8B9UAG4zAlm2RkEvYRQEtspOTZ4
	 JAKrj2g35NKRdl/8Jw34TgP6sHCWD4of1d337XfxqkRA13QUD4uhtZv/yKd0ymN2sf
	 5msGE+7VOVHdAg6V+JaxBzE1ilPVwQxcO8KDQMQaA5fsOzZqEzqOYIUmazu2wPELYx
	 TLo0QOVkd7L/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DE0A60AC5;
	Fri, 16 Oct 2026 04:02:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BED44109
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0DE881233
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kWUNAB8YscTY for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 04:02:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE1CE8121F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792123349;
 b=gQfzl2JRoZCKHXXaGof4PqNq8SAO9v/AmQxHSCti5CrdMZx1N+rr8Gqudrm+Jrgjlvuy
 f3mjDJoJ8nIvD9PUk93cfcYbWVucRPbfVDO8DvNjAaG2/AUqks1fjnzSXOYBerByI/XVv
 w4wt5z6M/DX6F4EOYeT3oAMykvPuVJiKyMv0rZK7qd1MW6mt0LME2ukxcuX14dPHwaKzK
 aL44eBsZVtuciI0nTzersR3Tn2OgoI7CTFDEGPI3P14iahRhy8FfoIr9tYVZOBYEoq/aP
 9LCbBpsuFqyUnd7f+tMWLPz+HrxoYP+dUyk7V6ONHP9Ozli4H/ugdJy3jcPxsawahiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792123349;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=0KHlC/3JhZW0LrLPKcMT4F4WlxBvPJeOQs1xmB0+tn8=;
 b=psKkizmi0BV+jwpabGQV0fDyuY64lmBN1zWYG4OwN+g/hYAJ32vNoSjKS6ZiCJ03+w/R
 7GDjyT6eneAWf8ssp+wpDsdExJVSEisHPtuPnk/UsVtXieoqSCQAitNCpL53Wl4zx0pt9
 VY8lEvBD9fjULp1o+X+VzeLQqz5NNcmNRcg6tWmzIa2C8PNv077LlRZCXamcs8wvr4Ldm
 ZKpWH+De8QZbB29IDjwG5bynCXCR6t/mVAcTIaTv1wFopAtSw9qJit0ZyLLQzMmMsVKLR
 Fo0wAl3lTHRJLy5xJSpz2yzPOtFpTvtMWtWa9JhnjnuxocyT67GAwovb/WNp9PyhNLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QItHcQgM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=QItHcQgM
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE1CE8121F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:27 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-88d48da248eso4393916b3a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 21:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792123347; x=1792728147;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0KHlC/3JhZW0LrLPKcMT4F4WlxBvPJeOQs1xmB0+tn8=;
 b=QItHcQgMI9XlvikLawnqLNHYMd/a3YP6ZPrxifO72kmX1oeyq8CcRZ47ZLr4mF+NcK
 ZeDMZ6UGt390ykgbvZAymP5lK9AkSjts8gRvUmDUXMMp3dNnEUiq8qZTBK098jYS6gtT
 5BKNjji8hp0WWa4JEY0DtKukndTCcQZjQLBCpfK3OveeD6jGuUQmGMUoogwzd8u3xnUN
 lGdV6YBZ49Nvjx0URLMSIQB2IfuQMq6qcg8kChERCJK7c5XxkT9rJq5FEykzJC+VBZp5
 0B24mZXZ2fydTufc/x35nFbLHBDXKM60jOdtfDRxXkOXt0PdcSoGMcIMe1pN90mKFiiV
 /Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792123347; x=1792728147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0KHlC/3JhZW0LrLPKcMT4F4WlxBvPJeOQs1xmB0+tn8=;
 b=HgqCG29moyvzwOdVvvXF3b0ygSxsdzy2dN7Oti+Q6LwoEy3d25lv7lrrqskGhDxETV
 jKpfDcmL9GtTgngvGcq3b5B0GyBSaqz6qcOonOOp6S5CdAkw54rU113EpiahYWIp33Ra
 YyczWP80tFO7XEUQCrS8ubunE+KtuFruMJz1Beit4JJCcFonQDWkzvnDXDo1nJjwWcDm
 uw7J9w8yzYQSx1d+4iDVJRZCus4EGaOLA2EmviynpXWRuj9JyF7jZX5qCnAdHmBCZbs2
 sqZiOU5i3nSnS3d66nTH51x/92noJ+rX9jeYlYNS10c5jFWfVcupkyRe8ybNqfGj7P7D
 revA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxQ9+MSW8Re6MdrE7QiYdE0ul0h5uooYx/nk4qKEfwn5B78FLDQUyEmOpTQh21Sw7KT58DLnU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKhMloT9I/FEJ0+SpZeC+Ngjwx9+hl0tfLq3wQhVDE69ABQAuEa
 sK/pkdSe/hZnlK9BW8E1zWlU3mmES5x910C3KXecCJl9eo9F3ca4peD4
X-Gm-Gg: AYBFou3dqQ0nAV33wUisS/3mXsd3EBue/C9zZhM/KCcrSRhKmirpOEC0dM/P5X9wjsu
 4se5b5rhtEfDi65nInXSojNaewQ46dcKLoL1rmWD3HOd/NxXa0rm0fptpMbTfAHQ1EaFwacx10/
 Io4o6PpwMJ5dF6b16PukvWrFAQWpW/bvyMKckUkrmN++/4g3ACbIC7ULqrnPGL44R2SW5Gp1oPB
 9+F5pZqeqvSH6ctNNXftEt5lQkDFg6BQ51BjFG/3LSl5YlMBZGri5knubrXNjbj1J8AxJxqNMxW
 W3T1yvFuT2vWpo+yJ+paeXrT0gZJlrke37HIHq42jU9j8QjX7iQrScWykZzWMlK4weuRZ7LjtLQ
 tUqRuelmp3v9zkNTxGtDhwfWMwRoT5AGBeov9SxOiN9wuI17papvfhYrJF0qk/1oZwY5lbdVSOr
 DlOLHq5CfmlY6KHsnhzp4HjkBo2BVxSSDKurmjm/4IjtBfiGfYFOVkfj1DqIlLx5aqoMw1DXtJF
 2WJQGWJfN8h/evyTTa60Cv7r3xeJx9+C65M64SGpE+dyJ5o+TSkIibZZmt4VrcI06q0Da1xhDBK
 IiLCloDbO+ZUaedp/3neN0eH8zyg56ZZIEUwogw8jB4Ae6I3vnC5G7oZ
X-Received: by 2002:a05:6a20:9f86:b0:3e0:e652:e451 with SMTP id
 adf61e73a8af0-3e16bef1098mr18454332637.62.1792123346677; 
 Thu, 15 Oct 2026 21:02:26 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd654a249f3sm437294a12.27.2026.10.15.21.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 21:02:26 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: marscheng@google.com, eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/4] arm: google: Add initial support for Google Tensor G5
Date: Fri, 16 Oct 2026 04:02:12 +0000
Message-ID: <20261016040216.3636305-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series adds initial architecture and board support for the Google
Tensor G5 SoC, referred to in code as LGA, and the Pixel 10 series
boards based on it.

U-Boot is built to run as the BL33 payload. This initial port sets up
the MMU mapping and DRAM bounds, disables the APC watchdog left running
by earlier boot stages, and enables the serial console.

The device trees for LGA are queued in the Samsung and Google SoC tree
for Linux v7.4 [1] and have not yet been synced into dts/upstream, so
cherry-picking those commits locally is required to build this series
until the next dts/upstream subtree update.

Tested on real silicon:

U-Boot 2026.10-00821-g86c1a8698ac2 (Oct 14 2026 - 21:47:47 +0000)

Model: Frankel
DRAM:  2 GiB
ERROR: reserving fdt memory region failed (addr=be000000 size=1000000 flags=2): -17
Core:  7 devices, 7 uclasses, devicetree: separate
MMC:   
Loading Environment from nowhere...
Loading Environment from nowhere... OK
In:    serial@db62000
Out:   serial@db62000
Err:   serial@db62000
=> 

[1] https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=for-v7.4/google-lga

---
This series only brings the board up to an interactive serial shell. I
plan to follow up with at least UFS driver support in future series to
make U-Boot practically useful on these devices.

Kuan-Wei Chiu (4):
  arm: Add Google Tensor SoC architecture support
  board: google: Add Google Tensor G5 board support
  arm: dts: lga: Enable console UART in U-Boot
  configs: google: Add lga default configuration

 MAINTAINERS                  | 10 ++++++
 arch/arm/Kconfig             | 21 ++++++++++++
 arch/arm/dts/lga-u-boot.dtsi |  9 +++++
 arch/arm/mach-google/Kconfig | 18 ++++++++++
 board/google/lga/Kconfig     | 14 ++++++++
 board/google/lga/MAINTAINERS |  6 ++++
 board/google/lga/Makefile    |  3 ++
 board/google/lga/lga.c       | 65 ++++++++++++++++++++++++++++++++++++
 configs/google_lga_defconfig | 10 ++++++
 include/configs/lga.h        |  9 +++++
 10 files changed, 165 insertions(+)
 create mode 100644 arch/arm/dts/lga-u-boot.dtsi
 create mode 100644 arch/arm/mach-google/Kconfig
 create mode 100644 board/google/lga/Kconfig
 create mode 100644 board/google/lga/MAINTAINERS
 create mode 100644 board/google/lga/Makefile
 create mode 100644 board/google/lga/lga.c
 create mode 100644 configs/google_lga_defconfig
 create mode 100644 include/configs/lga.h

-- 
2.56.0.212.g129ede20d9-goog

