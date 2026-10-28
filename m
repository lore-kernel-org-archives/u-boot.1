Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0B/A7A7r;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F3jT9Avh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 849FE80FFD;
	Wed, 28 Oct 2026 12:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10F-cswxxXUR; Wed, 28 Oct 2026 12:13:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95B7F8101C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189603;
	b=K1V3LzPI4ltSuTiYDGtF6TKvRrGR/zWPHljW+YMm3bNJRDTY+/zjUdRt2EJY5ig0kwtG
	 YR6E7JNOb+VVm6VNGo4n6ngoopF5hTwLoEs2UMV10ADZ5Y9PsHYEIuDWiWJ3TTeFYr4Pa
	 GULDILiHReG3bCyt2wzOVhnZeEOSy8ntqcbr4hC6SiHHaIUHQd0IvlS7XykOa5rsl0hkg
	 U7BS4cQwVZTYpLmEJ9AaaYx9dJ1C33dRxyP5qX93jd26axN+Nn1vdPtZYFHmZtn2bV+u/
	 p82HxJ9Zy8aKt+Px/4b4Siam9XjIZgT0fxczSDDvB+mdffenjdY38BpyAr3ts2Xhc0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GZw+MVe8dmT2gGQWXa3HJN7dtI5NkcpKrQiR7a4zltY=;
	b=R8g+F6zvtqIrKyHprRCJovGU7yR1nJ+rLt3amNQWDCI2LE9XkpeWq0DFE+RlAICvE026
	 Rjcu/hWvX7LquTVMQ+Kh83PA81EGiRytiKT6mRMw5DcDQmGli6NjV3iohVGv4C74/5WTJ
	 FEKpFHZOYzpFdgjpKtDucuT1b1p6ozjQ0oa1Fu50A3Wn6417RBwRsjAeFTp9a68pyn6Ku
	 5jGOFO0GCMYsA0uhowMd2OwNVkAQiVoXPIfbb1r9gPFjBIPm+dKh8WQaIxYQ1vy/vTcJ4
	 AnaFRWmjiBSnVTHINx4cI7DckdsfR7EYvMFwny3yeH58w4m6y6QP2jCeUpBB17o3lHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189603;
	bh=GZw+MVe8dmT2gGQWXa3HJN7dtI5NkcpKrQiR7a4zltY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0B/A7A7rkth/29YlurITlCcyg3w+uyxiYSzK+04y1oUu7bqQrQAHwtKq1IBF0f/zt
	 00zF5Y1YYTCGQAcCPRjTPXGx57An7LOliGUbb0rXGRLo+HXOA8W0GZ0sKhGJ2VBahQ
	 Hgv+0xR0jYzuGiumfYS5m/NXluzShf42QCj8Dc9HeiOWH2Z3lHnY5eQVIG/IQJ26Hq
	 IoUMomn4ReEcIg/dvcKMNeqsbKdBvqCSYaHvp7wWGqoofovguWX43I2hXVLjMHqf5y
	 V2bfCaoryT5d7byeIdzMeU49myM887K8CMPp4eT4cZvJLK7Yg5heeZUMI7dk+wDwSt
	 ymmVmGpSUaJHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95B7F8101C;
	Wed, 28 Oct 2026 12:13:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DAC1C2AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD34C606D4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3BmxPk6K709a for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BBD8760600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189599;
 b=RPvfT4YtMHfjC2Na561ji/ELB5/3LJ8pRDVpvdWfmyn8bS4bFUdRy8NkmXlvIM6mprL8
 GmpCMTWGbCxUuhBuc7Cw9Fns1lw7TgsJvPHgyf4Cz6RBzD7j+tAVq1qZVobc8Ia90mBei
 47uiu0tpIddfWZRU3EkmL7mUjnhmUj57B3Tnp24YEBNoED7D4mUNIwALxTS9xvy7wRoSc
 vFsSDwvWRBbqm9+6gE+NaaGwBC3qHpnjA1SpcBtslqbO+xOv9X5r17VNj80NZYMS7FSeN
 KUg0Xjg7VWiYXN3c07cSr7mnMxQTQDyOvJLSRT9y+JmOQWDJNyJC6UG2js112XaYIvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189599;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=GZw+MVe8dmT2gGQWXa3HJN7dtI5NkcpKrQiR7a4zltY=;
 b=lscIO16HkON9YlXFwq/MGxIP00amWKMhVmAh8yJnNm4gnuq+N5arMr+gzXwatMjmVPUn
 kb7wqIW3V7YJDhWKLweWz8ByK2vU2pwpk/5tfl4ebK3lBn8VRJ5IWLQcky8NBD8OIw6Bu
 FaQMbqe66Zg1po3Rcm/50/OXQZBtbmN9x0feqMWmVPWdQZcsYLUwYa3WhTJGcTUf+oo9a
 zAuq01W96S1AjPYxOcUIRlpse1+zAAxOHpO4l7fyOMAz+klP3HdnxC4ewbB4k8A9yDgzK
 dUzHVisCZzBGqDiLeSYi+xjS3bKEhwjl6vE2rbeIryVPIhrQVJBZhRkgK5BhQhDaAAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=F3jT9Avh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=F3jT9Avh
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBD8760600
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:18 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so6854185e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189596; x=1793794396;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GZw+MVe8dmT2gGQWXa3HJN7dtI5NkcpKrQiR7a4zltY=;
 b=F3jT9Avh3vznQBzB6kAXMz7IkIHTF1HBkL1kW7bqmnQJ0k2QeC7Rb3nQUOqocwXChe
 RWVW8/f9HaQUZGmxq9LZnM8yTTFz+LkECCuIMDN0mCK2nKn1SbPZXwc5RAh/jGBpWsGf
 6IbWMxTSjn88nslll4UDOmRakBOEFp7MncQyl2YssVx1UqqlhSWrDELTO2cRbQzJ8yD3
 W+xMl+93r0fsFlUJCEZmp4XK00Usa2tE6r+rA0lMQm1+t0FlCQ4RF+YWO4LQueg++6Ut
 mH90pEmwBRLC+i+Esk3bph6WU6iP3leWh7E6dLqaAxYz+O+Eem8+pJsD9URBL0G7dQOn
 +2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189596; x=1793794396;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GZw+MVe8dmT2gGQWXa3HJN7dtI5NkcpKrQiR7a4zltY=;
 b=XQ80s7/EQl6eu4cOv6wMGhFOgGq+avBtqMpJ+H7MF/XI7ZsuQfZTxgNndYo8M16zTO
 OzvN/CCzfNdrdS9kfp7NrpU/UlV6/oUcAb3btyJ8PqZ0IMwt4kiWlb237mRHc8dZNg2g
 1ELsBZoSaiDYrj4mC224mwZMl7vAXvnzTqdCuOjJItmDW/S33f9WgLU3vDfhTCXLLtCU
 EPj0QNC2So6W32eAl+5Bd3vCB79hMyLDFiOkqFEJlLksQQ34EKPQhBVnoaQb+Wr2aHgq
 qkKqqgvqKNcFqN4FTt9dMGrzD66bLKdykuVLvh3HqwFYAAAu+4H28cEaxO2/42pZyAmu
 aktA==
X-Gm-Message-State: AFq9FYKLIG0DrP3d3NdO4Vk/b+NEh/Q3awtf8ij1qRpBng1ZpkjLzYUj
 Camxs7YXM3YoHeHHJVTLG2DqI72tWZkJlCf0AJMrAuI+5O3hPfklgEaF8JO9P4QE
X-Gm-Gg: AYBFou2oD+WrJyn6LH9sY3ScHdFW1AOVg0HF3reGmgtU7gjWsGsntE8zd5MnMaRObd+
 VjL8mCVmX8lWyAuSS12TgdoaOXmrgvb9lMAyUqzP2wkb51ervql2cyWF+1KIgpKtxCt4Xrp9ruO
 LADKk3JsIHUKkWOsLxKW/2MIgaopnhCaR2FDFFdR2d2SjyOAAzk8wFtxNxr835O+yFHfCbd8ApY
 505qJSpNUwWeuplqVwkPwu9pvLXTAPF5a4pn9gYyYzjJKKFtooZds9BSOBmF2JuGh3DZMs1nOKm
 ucY+zuE6eiXVupQhQarwH7yEYqt3cvLVxWlsb4Wjqgaf42gacl1cZZAeUruycIUWx4X9aqxWqbR
 2gJI3lSCvrWnx3FM0i5hDEBLuqMacOpc89Uh2ZVmEfpr0lKFR0GfSqMXuBMrdgTyDotH6W2Rg4s
 rAwnTusaNymR00O0TbzWQhBDSRmMkRISUl/vBxzE7jdqZiUB+3QI+2OyJYtQ0hWuuwmZ4tUJlKr
 5Pd6DyF1k7KjC1UlvxgdT1IGiXUCHWSju3fmEEwC61mP5tK81XfpgydoJpr5/GOPbrrQKfrorLf
 KalcMLmNiMFFPdknRN6+GDL2fiUM7VitTuaqv2yezIcis3WzWmilbbKmX7awpCx5oZvQguzSnGp
 Ce4jqB0CbK87XuGsH4cA3ahdzoIlziwPWrnioZJmF9orJEDk6/Ji0M3yhKvDE0rqESmxiAeK87R
 MzVqmopYbCS+X4FstdrS/dy7nAdu22ctT+iAKoKRKEUeqlUL77w+lsZQ==
X-Received: by 2002:a05:600c:a11:b0:4a1:e11f:b2e1 with SMTP id
 5b1f17b1804b1-4a966773233mr44979915e9.15.1793189596242; 
 Wed, 28 Oct 2026 05:13:16 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97a093e86sm41139085e9.1.2026.10.28.05.13.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:15 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Sam Day <me@samcday.com>
Subject: [PATCH v2 0/5] arm: Make the LTO conditions in arch/arm/config.mk
 take effect
Date: Wed, 28 Oct 2026 13:13:08 +0100
Message-ID: <20261028121313.814-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As requested in the mpc85xx LTO review [1], this sets LTO_ENABLE before
arch/arm/config.mk is read, so that 32-bit ARM LTO builds of U-Boot
proper leave out -ffunction-sections -fdata-sections.

v1 broke the K3 R5 link [2]. Patch 1 fixes the dangling reference in
arch/arm/lib/cache-cp15.c that the missing -ffunction-sections exposed.
Patch 2 keeps both flags on ARM64, where U-Boot proper would otherwise
grow on 104 of 105 boards, by up to 30240 bytes on i.MX8M. Patch 3 keeps
them with SKIP_RELOCATE_CODE, whose data relocation does not expect
section anchors. Patch 4 keeps --gc-sections, without which 32-bit
U-Boot proper would be 2080 to 10832 bytes larger.

Build-tested on all 208 ARM LTO boards in the U-Boot CI container.
Patches 1 to 4 change no image. Patch 5 shrinks u-boot-nodtb.bin of the
102 32-bit boards by 896 to 4464 bytes. No other image changes, and
NO_LTO=1 builds stay the same.

Boot-tested on a Turris Omnia, one of these 32-bit boards, loaded into
RAM with kwboot. SPL and U-Boot print the same boot log as on main
apart from the version, and the mmc, sf, i2c, usb and wdt commands give
the same output.

Changes in v2:
- Add patch 1 for the K3 R5 link failure, patch 2 for ARM64 and patch 3
  for SKIP_RELOCATE_CODE.
- Test all 208 LTO boards instead of the 30 with CONFIG_LTO=y, and move
  the size figures from the patch notes to this cover letter.

[1] https://lore.kernel.org/u-boot/20261012190720.GF3722450@bill-the-cat/
[2] https://lore.kernel.org/u-boot/20261020212819.GK720525@bill-the-cat/
v1: https://lore.kernel.org/u-boot/cover.1791877299.git.pepe.schlehofer@gmail.com/

Josef Schlehofer (5):
  arm: cache-cp15: Do not reference the MMU helper without an MMU
  arm: Keep -ffunction-sections -fdata-sections with LTO on ARM64
  arm: Keep the section flags with LTO and SKIP_RELOCATE_CODE
  arm: Keep --gc-sections with LTO
  Makefile: Set LTO_ENABLE before including config.mk

 Makefile                  | 14 +++++++-------
 arch/arm/config.mk        |  4 +---
 arch/arm/lib/cache-cp15.c |  2 ++
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.54.0 (Apple Git-157)

