Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65167606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fBwJJJg6;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=FZfJC2de
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9461F81253;
	Thu, 22 Oct 2026 01:38:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wnNsyFSZZ-pL; Thu, 22 Oct 2026 01:38:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AEA1D8124D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792633095;
	b=c9Lpc8olrIiXCxZKXzpP2o+zfhDMljb0QtKe98Te24vHDSbuCFse4nMtYLTqyQv4pZjA
	 HpD4WNfuFjld1H8BFQJSd3htPxq+Jm9ssv3DtVv4NUWfh3KYPgOtdMUYUDsa0U3MoS+xf
	 cGLbTR4uPj7POTIqx1Va2nijR4vt6ezgJI3738IKYDh6BMRwHDeLQraNAJws01ppiINFg
	 UY7KZcTMV7vYhO1PsXY2meIL3wbsviuF3rrazk/73Hp+H55z6w0HCZ9qkCndOLcLlBZl7
	 uYXmed4E2VwHYcqYZsoJowrnSj3BPIOKCjZMJLV1lfuCNnJWNhBLsrmE6DCgcnR/yvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792633095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MrZZIyt+TM/CkFvbC1ddSQLfRn3R/0lALW1iVfgm9Do=;
	b=WnQwU6MLCe+ZA4yt9/M1EIsqr8aCP5ZLwQjpPNCAloEPebQb8dvKzVbD3Y97sw//AWSv
	 PHyBr20gQuetqk9HAITSQqyKTq2iT8FkS5JM0o1Ma3nYFu8SP9f76W9zLfmmaHBr/jfpF
	 Y2cb+dGwNc1mppAduodcKXlHq3JU6pRDCqjAjra2FbfkwZyAZNJ01VQR52CQB35WfJPnf
	 IMEP73Z+FKoH+JAmqOa4CXQNwX+5pVuwjZJXm6T+BrEcGOOU5SeR+nGEsd1XVpEYngUVu
	 ANgUWVOYjNE3deQ1oz0IxNX+xy/01Pk3Lxmnd+t46VQYSXJZjp/mZ02zY5rHwlskLYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=FZfJC2de;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792633095;
	bh=MrZZIyt+TM/CkFvbC1ddSQLfRn3R/0lALW1iVfgm9Do=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fBwJJJg6OpVM9PM0E+dhgqruoggM5XOq1lfwQe4ouUXdo85zfSFEdo4CoECWZ1Qar
	 oQRoCEISenpEtVNY8/EVsCcxJyhCqvn6t22SREw6CWdVH2pbCACo5lyOTAiNCMcxyi
	 6ZwRJK/+KwSI3ZNgkC8uhV9GqSy10jimiknfmlWNL6vBt+bVR8Sm9UZNwPXj80ipSc
	 yUS++Bud8g48y5TxCKyavECc1+HI1GLlxgJzl3tIKxJu1FRUv4sZRVRrusB046I7DY
	 oGqy9QhmT47dv7oNttKJ7Ss3/ky2WAuUveaZVFnFvz7ZJjoRL3N4CURYm9bO6Y7z0V
	 r8FYB13HoozHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEA1D8124D;
	Thu, 22 Oct 2026 01:38:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D8830371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA1E581201
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2liGscm8tgBt for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 01:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36F33811FD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792633093;
 b=VQHswGDky8TuJagWKavNsjTG+fMqiTAMMMOYE9HRdibOBHr11t20HkpKAvFjWyjQB3A+
 yBaUwphgFDgCDEB23RQQCcAdaT2H6T7ZUTNBxSnRSnjYVLUxJtZ8DB3bJbd8sEZt5pvhh
 6XQ20lBeS1hnVmYvGPbWAisaITqmsV+SgG/vgJf8vfCFZqfy/e2dgymwuKldWM3ew4vJg
 bM4kEWMhlsX+YLPC6GKNnm85cvv83z86wgHWxcgvYkZJZ1kFhtY/LRy9MB3BdZOqWI2tb
 qrlHeYmDlmdnljQYG7Hu0yc2xx1uKFWVn5b2zzVAHQGdccCfWKLRMUdOghpSEt4T+gA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792633093;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=MrZZIyt+TM/CkFvbC1ddSQLfRn3R/0lALW1iVfgm9Do=;
 b=Kkym3l6b+BoQULJVRsOWuZJFaG2fz1s0R3O4ikm0tv83293QeClYMyRmYpujBP+BzTYb
 w9zG5NeKf6aKkYM2h5e8jfLsvcOiAQVgUqAR7nhHR4oWHHkgUHqrxagRkKNMP4GDYyFW3
 LXD+YO4k8t2Gh7HYyq/qQnYvAMw8hknfTwCamH4lQqXYErtRl50aPnmocBThAbywY/IK+
 uy4lyxa1JM54p2xeovRgkNMQ0H/LndQdQ9LfmoZdqiAWVkH7XxHJ7Pxkow0sKHKNq7eGm
 3qN3U3XkjoNycq/bDvAsMjVVIUa3HwK6Cvg9tlQxnOq6IfiPE4Is/+i33H8ZhnXqSSg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=FZfJC2de; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=FZfJC2de
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36F33811FD
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:37:51 +0000 (UTC)
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6711f05fb14so1427300d50.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792633070; x=1793237870;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MrZZIyt+TM/CkFvbC1ddSQLfRn3R/0lALW1iVfgm9Do=;
 b=FZfJC2depfUxW6qIT0z9zp+9UZrit8AKjwpfTI/NevmuTKTMVRVnWo4jud0IPCzxk2
 mZg/b7kwpipp+U4geUxL4Yiz1PXKqmGresl7BewujRIkq8xR0qghue1lwcenppTjdu6n
 2Iixv/DxnJXLr0OXVwQs/YSToMMZxMp7yLin7tRzOMkPulphXwhIOyTW5RwG/I3gtQch
 0SHxlEL4yD5HNpYpCZFGjIWKEUJleFuSjZ26Y8fbReo2edf5T39cuMGAx2S8LLriPVBb
 H0KkXdhqfHhI7U4TpTP8CE8O5GYZbXYEHKfhIJBSCYLhCEvAGvvPUZBrhfZygQwQwgNv
 i+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792633070; x=1793237870;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MrZZIyt+TM/CkFvbC1ddSQLfRn3R/0lALW1iVfgm9Do=;
 b=x17HggpTlpVEDRXxqVesZtEZW3Gr11/d2t8ZwLZJkg4zPIlbX/9JwW03Pcz8LVJLY7
 y/K4g1TsJBANekJDgQPhEDweioB0jyyxk/+5G0mtQ0y3ZCRwMckUSjes2ghgH6YVrD96
 qNDsYV/n09rNzkoAobF4ng6auQ296vWR3Z6HRf2LUC5AhlxGqL7UTKHThGgdQJpzUaFT
 3DxW4bmJB8+9VZ4WcJ3Sh1fcOdeOXq+RkGT7jMALAaAqQTqFj7HqJ7YixaXFyEqRQI79
 D4eVFG94vu0FelsP3ZeqBrYN2PPuUMZmHyGjJPogLt/I9IpRoLibxpqtmazx+Rw06HQ1
 ApCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzb82WJXS8KmwSxwIGqp0A5LZJ0i9+DogyiAXc2DVaEiN+i5SBmEYAQCTAz+2ZUuP1LHJSt2J8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLgwDPw5s81jVzLXT8NuQVnOgFGOURgwCGSY/P7K7JDhugjRUR6
 aqnnY9YvXdjF4Gm8xZ/qBjdAOx3aq7JShADHFPYuIz+2V+VaV1De27IZATCj5yVyA+0=
X-Gm-Gg: AYBFou3IGjm1HZIx3Rggkb9Mfg/ElCX+290iiCxMW0Mneo6ebjvHg2jyVM7Etz77xrn
 cMnUBHjkxcGWIuRbPgEyp1A0/W3qRxsdnSG4BNoTRA/BgIhzz52FIRqH1kXul3Eln5h+SkRGKdO
 crHoDcoEC5obAyWmtV2kSFHV9loCMZp70PyQk8YnDmw42Z534KYQanOWHsyYoFo3Rfb1kubTKdt
 ibZSNX0Dg264WW2q43x0Tp4OYM6X/M3wWJvLw/HRZG4VNDEKli6aEBufdAxrrtToOcBq/dZIJp2
 hKabxNJNSFcdDk9omDnzACvhinWxh/78C2OHPGp7Spz/l6RU5N34xHUu5dskYIq7/2OjdqaQH/c
 BDSRbY3+Xyz3f+xsYHwSYNVZvS+yncf7YghGMnnTdwRTp9TRlv6gbbd/KLNCjxRwdAssZnV1pl1
 8HHZMmvI8NbO+uUXj18cTDOMgwVS9Ew2ZqnFk+IURuwGLq3oD64oWslp1RyjUxk9PYNObhrhX7/
 nf8EBPO0JM1bAJd6vc4Uh479hbiBLFg/CdpwgE7eqnDAktQlWn7dO+FukPMmLjecxTabeON6b75
 yr7CwaMPNO7nyivX/AcW3kAZSBFijqEOgyQ=
X-Received: by 2002:a05:690e:1c0c:b0:671:5b28:13aa with SMTP id
 956f58d0204a3-67a0e4ffdadmr2011719d50.70.1792633070383; 
 Wed, 21 Oct 2026 18:37:50 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:81a7:5305:ca4c:d0be])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a0e53a353sm1933502d50.18.2026.10.21.18.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 18:37:49 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH v2 0/2] SPI/NOR Flash Fixes
Date: Wed, 21 Oct 2026 20:37:13 -0500
Message-Id: <20261021-spi_fixes-v2-0-78af1e8c8c3e@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMlo2WoC/22NwQ6CMBBEf4Xs2ZJCsSAn/8MQA7jImtiSbiUa0
 n+3xavHl3kzswGjI2Rosw0crsRkTYTykME49+aOgm6RoZSllo1Ughe6TvRGFsdG41Sd6qGRPUR
 /cbgHUb90P+bX8MDRp4FkzMTeus9+thbJ+7e7FkIKpSalsdZVIauzZc49mlR2aHw+2id0IYQvj
 UIeJr4AAAA=
X-Change-ID: 20260803-spi_fixes-586ef497b80a
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds a new Micron NOR Flash Device ID and a fix to the Designware SPI
driver to not try dual/quad/octal modes.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Changes in v2:
- Change datasheet link to use Link: <url>
- Update DESIGNWARE_SPI kconfig entry to pick SPI_MEM
- Link to v1: https://patch.msgid.link/20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com

---
Anirudh Srinivasan (2):
      mtd: spi-nor-ids: Add variant of mt25qu256a chip
      spi: dw: Add supports_op function to reject unsupported transfer modes

 drivers/mtd/spi/spi-nor-ids.c |  2 ++
 drivers/spi/Kconfig           |  1 +
 drivers/spi/designware_spi.c  | 14 ++++++++++++++
 3 files changed, 17 insertions(+)
---
base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
change-id: 20260803-spi_fixes-586ef497b80a

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

