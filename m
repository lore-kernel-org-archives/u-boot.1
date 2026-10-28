Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808F606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RjmZ6K/I;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iw0ndxDd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CF906061D;
	Wed, 28 Oct 2026 12:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g9cmdEr6K-nB; Wed, 28 Oct 2026 12:13:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D9B5605DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189589;
	b=UvNCXxttpSU0Bv1ttGzaDETNpLGDDBJh1Ao9iHEqNh3NacqvVMKhtMtK85Ne9r/MIYAq
	 711Y8gYzIKuUr+jhhOd3q4GsYcDZPX6pChvDBi626seJkGHH1a7d/y7k/n/Dbnj1oA5B2
	 7MEbF0ZDjDL1zeHJ9kWIxlJmT+lMhbPMwRK30loMDfJef5mH3r4ieZ2eIcwcrF0dfS+vQ
	 O8Bt6KV5w4bvlwG8r9l3pi+qobdN3g7m+i4OSwEQyMk7IG9Kk/ZyHyJoPYrFBneyxgBC7
	 70WqRCKlW3lQBf/GrNH3YFUqcvEj/bZMgcjZtcgPhQKaCRi5VLpTzu2iULjRszuhkqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=o36tNzGt4eKXVg31JBkx+VHDRxt2SAsmk/xQta8gv/g=;
	b=X5iVa297gAPvgtSUuqHc+faIb4PdC1LRIZ6RM1QDY91o5z2iVUuhbH5eU+9vu5zGO1fM
	 9eVBaoflmo2wmfBURukCV1SUOcP+1r1S00IdYCXV2uJk+tkIfvqyVwc9x6MlX9cMEJBNs
	 NchG28d2bta5I3MoADw179ZZ7bymvz7uW2LWcrp2Ds2PlKF5AxZpUbk24jAd5T6WX6bcV
	 JAdHYby3aDudO/kyk3UflOvraSbitrCMOVERw/vklacJg3jabEWwYsReAw2SocG8Qf5x5
	 bEhaty8gmSHeyAdA3SkEs33ENDn5Tz1N0yRnV10RSiBzW6Cc4LQHVt1KQUjg9RY0CTA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iw0ndxDd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189589;
	bh=o36tNzGt4eKXVg31JBkx+VHDRxt2SAsmk/xQta8gv/g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RjmZ6K/IO3RY4D1zaMxUdae7+O3S4P4LWLnqltjtK9ZptPUYtS0VJLWTqnVnseTIB
	 v6yj6sZgFrXX66jiIq4Zfu3tzoUPv5AY+fxN6OcXRqDJub3d/qDmpBl8tgKRrYH7pB
	 asPmxX3jqVNX0xXz5ubJ4dehTbEinQ+s6JuMf9Z4gCeOB2Bga27NNV3PEtfI3181ms
	 427DGk1Xny0rEK+jnVISPxZXbFnT49tZuycN6z7xDGOm4gFa2TjKa5Gcqd8mFXWd/I
	 QQBCfgKAP1fucGSJaYElvAkbs3q3NRFcNnEQMMyi78zDP2uFeta3NbjB70mHZsNr4C
	 apk5TDcUbiSeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D9B5605DF;
	Wed, 28 Oct 2026 12:13:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6825A972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59E47605D4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7HDNbY_XLjjb for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7028D605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189586;
 b=rlCTW+NhH/c29qlCIGsryza7V1wWcrJVpVh3bEPck1qwN1JkCygqJmAAOG1lIp2xdCtk
 T3qUgAsHb4myhn35QdhwF7HbnPOX9UP6Z0WzatgdCv3tkBAIrQ+Q5xVYqKw0o4N7fGW6i
 7TVhXTyzaUjzm7C7LUQP7cCmvs3F+B3tCpEeHjq25xNWkYXm1JdxYn/hRkSq/DrvY0wzz
 gtnENmsSIeviwYN/KOfhZ03KV5b2+H2FSuc9V3UAIfEvIZ+Wq3rZI4FXifIjJzYxKFjMO
 mYQGsR5lhk9LTzTVWbhnqJ8DkfDYUVbvmrWr57AhZPuHkmZH+dNOW9+U7+OzXrKhYSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189586;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=o36tNzGt4eKXVg31JBkx+VHDRxt2SAsmk/xQta8gv/g=;
 b=co1VK6fNiEX96TSlAOoOlG4PBfN+v0MeYpv0mZnKi9UWP2CtWFRlSbxJ7iZymbbVQsh4
 ubAbEtcCX+Lc3e5mCm8PP3S4/D9rU2JRCaxgxZx4aQW67f+P/+6SIQIG3li3MeF+26Y5i
 ye4TGUi5Q5mKQqepIEXN9OqaffGqj2GZigFXa6PhMG3uPR6UzuCO5+5qpxmtRSFBGF6Pd
 oZWhxcW1bB9I7BBwwPwL/AqwFxFTBshjCmBy9H39apHWpVi/hImk088mZ/EhJXMHyGjd5
 cCjSaZrDzFzTNHESl/WySk6O0MjJAljsVy0UQw7qFKE0DTW8f78W/Iicxyy80hIVqVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Iw0ndxDd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Iw0ndxDd
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7028D605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:05 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso698819f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189583; x=1793794383;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o36tNzGt4eKXVg31JBkx+VHDRxt2SAsmk/xQta8gv/g=;
 b=Iw0ndxDdbGOuSCcFhMIqh2dcO1Ec8DRI3GCKHFPQHP6WAZiGJrOqhSAH78/M/YZmdy
 SJe9rsF8jjBSadQC8LvraU1KIScP4s7UQFDBsKqPExA5ueHFnAs4Q2Ab9BceB5OGyf0h
 dTNB6UdLgVPDzCFVQaex6K/Uk9TjrOf/afGb70O2NEeBBu0E1/Bg8iAK1DIJ8Hn7wY6W
 xRGCjw6Wxgt7487OsbCGbRb39PEUjhGgGSgIKU+Xl5Id7YYxpfFLv9EXaIjmUmPOA6ju
 AIM+m7ucXKG5UxfBwWGsZ9OQjalm05LY17SCZtiH5vm+3IDuVqAtcMYFtr8vi2mreLf0
 FkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189583; x=1793794383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o36tNzGt4eKXVg31JBkx+VHDRxt2SAsmk/xQta8gv/g=;
 b=jRL3wcFASWxO31T+bkUcCenRq/iRA5Pt/Sci2RRnFgxLFTq1Ir38w9ZEGDKis8I+cy
 lnT94POB8tYyvWlttfWDjaIw/tjxKFCAbvfmz/876yHQTYt5NOXwAFKfJ2+a4emQuHHm
 ObSXeBZKu76xiRdVoHu1oeUXsECIe461C+ZeT7/mmkhkO0+a2ITVrMAcFvIsl99PKXQj
 QCvVn0/wB/23loNuF1qnXhf8p3zT6sUko4bduuAz7xOtMJYOOKGtGNdbJVdnGuQWnD2X
 JFVDgnHHbZTDrjiUO2fHOETGsT/2JxK1diMG/AxniW+wPDMytD0zNweGBBCWry9ly0x9
 4RnQ==
X-Gm-Message-State: AFq9FYIEDhybgAJrzGIAcEiBkqC2y4Yfhk7bcvHAuZkq0kwNMOhE1Iwm
 7z7jesXnBa+UVSMdcxspIQaBaXGzt+h8pkFbLrHjBrHys1bx4uRavNO6fL57OVNC
X-Gm-Gg: AYBFou1ShWeof2SVmOnVLyAPzDZgy5ixmmqdz8RBISYJ5MwOFM3UBe2JptyG509kNRx
 SHJu2Goe9t8afBn8RRUNWs9B2aVlet5I4Cim9DD6wY8A5JEAt++1hCUiMd5Ol1WMYne0/5iR8od
 uE/lpduZjtK78+buI72CUQQZI6/K2kJkmSUZPDUwiwdVbZvmr8zEIGbE2RiU/Dvm+XNPB6HE/P8
 7m9ZMZPhnbPnHXIZPGNBPKQ0xNiovicBg2qgh8OkOEhqyxZrRAlDkb/InkBLulSzMLDNdqmB9LK
 RdWkK6cL/TY+3p7NpFeH1QU6bePuQ75KMuTcCA3050lWiYK4zJG4UE+rOh/CqUWu30H/DG5sgza
 Uhaug5VADj4suBrdEy5YqSBMb+vrOkC6yubH0sYoheRtHC9iexPtMGPNtJ3V+vytknlp8fwGRSL
 +3q29IdkZMVqjZ2YHla4SSdM9XsUzMmXV5v3JgIJm9c3mYRkQIj9M3PAheDeXvzobQUBxS2R5M6
 x15YlT0fZmjNGwa5BRa2mr9yS74KvrQD6izin4X1ZS3eSpxy5/P6NLJZE6YGdy4vDDC14qhSDNb
 h9bJc68GQGfkAav+whmSYzM8VJB9Z6LDKor4BUoIg8rHulfgIqAzWUIyYTzZy6pQkoxKFCJ1zKT
 8jqjyywnKaDHLSIpenEHTKLyMFjyCE+QX6T5TFiCC7WnYJ/VkwSPZXSKlSZKJalVbbKpF3wCXDt
 hZK67LMkAxrvteC3sHAolOQmV2yVwbIsu+XFKkLlvI0TjQAUAuKDLt
X-Received: by 2002:adf:fc4c:0:b0:48e:5570:75ab with SMTP id
 ffacd0b85a97d-48e5d30ecf6mr4170542f8f.49.1793189583031; 
 Wed, 28 Oct 2026 05:13:03 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm28113560f8f.53.2026.10.28.05.13.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:02 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/3] macOS improvements
Date: Wed, 28 Oct 2026 13:12:55 +0100
Message-ID: <20261028121258.572-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With HOST_TOOLS_ALL=y, the U-Boot host tools do not build on macOS.
crc8.o does not compile and kwboot does not link. The kwboot link error
also stops board builds such as turris_omnia.

Patch 1 links kwboot with the system libncurses, patch 2 removes an
unused function warning in kwboot, and patch 3 keeps the sandbox
asm/sections.h out of the host build of crc8.c.

Tested on macOS 27.0.1 with Apple clang 21: tools-only with
HOST_TOOLS_ALL=y and the host tools of turris_omnia_defconfig now
build, and kwboot boots a Turris Omnia over UART. On Linux (Debian
trixie, GCC 14.2) the same tools-only build and a full turris_omnia
build still pass, and kwboot still links against libtinfo.

Josef Schlehofer (3):
  tools: kwboot: Link with libncurses on macOS
  tools: kwboot: Define _is_within_tolerance() only with BOTHER
  lib: crc8: Do not include asm/sections.h in host builds

 lib/crc8.c     | 4 +++-
 tools/Makefile | 5 +++++
 tools/kwboot.c | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.54.0 (Apple Git-157)

