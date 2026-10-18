Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF12CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF1044066E;
	Sun, 18 Oct 2026 08:35:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c4hw_37C7TMd; Sun, 18 Oct 2026 08:35:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CAF2040791
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312544;
	b=LKDngDDNIRgeu1PZs488nIND59N/Crg2YpPNf6eFrsXDw2Ae42dbITJ/5iJl6aoNBS9m
	 a3Ux4lqfipidZgCK3J22Y6gIl7uDIDDWtfmmEaHanKCTW2/JyOukUATyZMe/iOez0HBq1
	 4DSuvlshE25jv81H5uBFyJm2HIMlS7DmsDU+Jxs1jc5E1XYrGwDTg+qlWUtmCUcbyfKtg
	 flQyB/R8jg6IqJZ5A3ylOfPRLc7NitBTbamZPKFd6vUjsaS/N+F9tPQMvBUoSQ6evcsGC
	 QX9u4xskGeVpb3yE7K20e51kYmznyISqzrf/B56KY3iaB6hLhzijRMCMi8xADjtt6sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uUZ0GAHo376LhKc7lTEir//F8wUDb6DY5gZmPQlhGqo=;
	b=GCAJFSKeccE7PVoXAYkCiQmLV+W7t+fKU4Hw+4LiNR5TXuEaTUmBFyWisAnQxvf575tZ
	 3HLfCUVnjBvIOx1qh7mKqjXa1VjPbo+moKS1IgIErydojj7DGXFGnExdF7IE5UKj/lm0A
	 GfOOqCpj0WqHFvbTVR4i9e7wwQq1a09tFl9XccDrAUHWXaiq4euclkmEDsq6XNOkJB6WG
	 UgB84KzQQ4uEuGHGlJQDx+cZbXdLN34iI/eAudN7tT28A/VnF1SRr4zwzRaKCCQ/d7Bjc
	 wk4k+sK6OsQOlQxAjeIZf4aELqKoJf9/1ZfvddWfIhdZ3IEaMm3gzwb+/85vkJVEPPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312543;
	bh=uUZ0GAHo376LhKc7lTEir//F8wUDb6DY5gZmPQlhGqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=adutCTwTUiGhsHa1WUvEmU2KXRnic/Dw4fQpTnjS5k6BkRvM3pRWnelJ2GaVSwtHJ
	 xRXt92iOreDWT2aeyF1YpZz/3bwwPPdwtu5++JnEDqH951N2APdifYtDEcfGmeELB8
	 5AGUMQgPwMifAbkI0uAOyNNcox/yJGf74WBIssPmWn6/TbggqPd+zie5eIkHKW+44T
	 ZiIEnRbJVf5pkmBQTCr9aRsfJChvzU2CAGu6aJ67ig3Akz/l3DAiCxVI/WmVwaYuS6
	 fasJ+FAEdrQqe2yvWuyVoMLPtBoFhYDRUjvESMLumVKHmmF7qhwk2yv4pNAW0wvUKj
	 7+6zeImi76scg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAF2040791;
	Sun, 18 Oct 2026 08:35:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 009B775
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB25D6068A
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id As5BwYAGMahQ for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A444B606EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312534;
 b=nqT4bLykJ1bx1H/E8CwJ+hVEiuVkhOQaqPpJoWC0vA0uk+ADXNtQ85JrdmdT3GOaPRXo
 jDac50EqS2ArJU4dcIds+rZFOzQxt9rM7NnrRCSNIeFE8WMQhC9NDiDu8vWVn3KvpkiY7
 Dc5fB2cDHV7q2YMIwdUnhmv9HvqeeYm8tv41ci8u5dQXX9t7jHCdr+D0wY4stpYjJ0kCF
 xJomU8mUwaF+T3MJr8PpDj9gOtXFNF/bOGgh4phe3YnaZW73mRdo8itrCbzcKGlNKOXsM
 0vm87fgkvVLWUmkbVfiGMMN5iXCddgtAesogrEo27+oGEw9DxzaW9sOAbgK9lmMU2zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312534;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=uUZ0GAHo376LhKc7lTEir//F8wUDb6DY5gZmPQlhGqo=;
 b=h7DJ2Pcw917LgxKHYtC0SusYw9WMVEgtlO/yK7nzBwsD2mblILGZ1U8PxxUmr3Xe+jyt
 Bo0IwYdq+PdTGsi/qnpobGTmE6So73cu1bqWdOLCcilwIim6pI91xyNyNTr3karUcUi0D
 qhbW+P+/EBCZpDY/Q44ukfwDJJhXq20te0JjAg6oTEbllJaz4c0Lahqtt+6RwSI12usm4
 jxkNcEox8ZAkTWZclZOE6im1dDRdt4fu4gGd9H7IZZTbVHxH3GV4w58tJZpdnHpcUyKJ7
 XvLSUK9eqf29PA55pJ/aEf2wag1HqBQbOzKtOUpJ6XSt0o/ROoNngFxAIHAL3+LAUwA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SGq70uHw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SGq70uHw
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A444B606EC
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:33 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so14792875e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312531; x=1792917331;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uUZ0GAHo376LhKc7lTEir//F8wUDb6DY5gZmPQlhGqo=;
 b=SGq70uHwkbQY5tXARQQI/1vFAxZJ2MyvnZO/CEnVDmVt0OSNMHGRvzfus7dOXyG1j3
 eFKKpz6WATo80jKDsRwwmwnNvgAptsqLrM8aHT/yX7qaVS+B3FpEitT4zOMYCg1re6YT
 xlYxnfZdfUhFH0wWsWOkw4l6+LBhFvBFfauyH2WI9sgkTeYnHgya6qQakTPyB92HsPP4
 Ar3wlvZEAUK55FKZc6GheCnSfUzBqtgv0NZo93Xu+w3rcYfKeFyamzk3NApqeWyZ8GXF
 RVvA5LwnlY0nalIHJJmTc3vHhseUmhr2ksd7pOkPo1D6EjoaetryQMuxS+puYOQgDIi2
 Epeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312531; x=1792917331;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uUZ0GAHo376LhKc7lTEir//F8wUDb6DY5gZmPQlhGqo=;
 b=hbrfKIuqJ4kobahXnJTAWLzmYWoqPXxT10078+YuxAUoWrj05Q7Ri65ZY64YzA2bOj
 tKtithfcuKUS4R49AQV+/nkP9AFPLr3HKjyRBfbsuG3P0kwIwkCuGHESr0/MhljIMgwf
 dXa1USumOvSRCmPI6sQZm6XFtQGR7dBa4aVr8xL9vREeYRtZNEhATVbtUhp6q1b5Pn6T
 oGJyEEF7M6V/FcbJGlts04F9XG+T2BtHLvRP2gjgSfDXzVoGZRMSbWnHGk0GiK8b+QHX
 w0iTqiOrbglsFvSc5K3qywYzddzWnZmt2j8OHcJGa4hFs9uwZTOXwkMVwT7h4Zgn3Rqb
 lCmw==
X-Gm-Message-State: AFq9FYIxt9B+bG3n+etu4awqwtVKMwfAXBe4mZlq9F1lk+FKu+Z4tgIC
 18V3so1HDrPXy4aLamNrjgCi2MjuFp0qUw2ArSTlFIGlsCqWdBNRRVj8xUcD5/OB
X-Gm-Gg: AYBFou0Db1nH7pM+7+11ZuBX7vM87yI3YgGQgwK1AM396p4SABI0apxwKtd/nR/UXXD
 intoVXlYK/wJgKgA6EiqXIdssvAg67kcNfDRD5dSYHUuPPQxV4W/wQNfS825dB/FJp0UsjmmV5K
 fCng1a163C3tNbl0huQQ0AnrXr9hinML6VRlUmeR1gnIM6Mnvks7/veuFxDb4ca9n9t6nvb5+go
 a0RZEfKmPEEpGj+ZVIEQkxmim7f0lrIBhJQSZMwgGccg/2dgCuD2MLiu+9Sv6ZJhbDL4z492Pyc
 pybYJOM38KHxaSlv2e258qAf06JGnKbYLqvWSHSiFKsTc+suMD1eSX5AWWVkjibTuWRIXmnVz27
 M1YkZ5HK20Hd6k4aP5dtQcuTVMJnXzWJbzy4+yksEQT3N2iua5zelV5ALgHVQBEdczs4eZdMmcd
 zGaO8KsPyOWMyKWnBRTf1b/bBzxKhZyxzVyk7/ILayJ3otc8C9Yw6C83QrsD8Y88m+T9EI8wX4w
 YscfZ9fQXDkmMxNHhNLK0kvltMXf/PV7I6lf/Bgqc/6AUlUg4B9r4R5TbCuGj+waW5zLjXolCpd
 b3C6dj0Z32x5pOh3HktR1ktm8juQh53cqZvVqFUV3aYTZTeoWo1fsbXeC0he8QB3N4yxuDL3/uV
 E9wvT0wNQOb03SKshrLqUMFY=
X-Received: by 2002:a05:600c:4503:b0:4a0:a34:6e7d with SMTP id
 5b1f17b1804b1-4a1d7614e56mr102019335e9.18.1792312530895; 
 Sun, 18 Oct 2026 01:35:30 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:30 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/14] powerpc: Drop -ffunction-sections and
 -fdata-sections with LTO
Date: Sun, 18 Oct 2026 10:35:09 +0200
Message-ID: <20261018083516.49229-8-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When LTO is enabled, omit -ffunction-sections and -fdata-sections, as
ARM does. This affects U-Boot proper only, as scripts/Makefile.xpl
adds both flags for xPL builds anyway.

The change takes effect only once LTO_ENABLE is set before
arch/$(ARCH)/config.mk is included. Keep --gc-sections: it drops the
.eh_frame sections, which the linker scripts do not place.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
---
Changes in v2:
- new patch

Depends on "Makefile: Set LTO_ENABLE before including config.mk" and
follows "arm: Keep --gc-sections with LTO":
https://lore.kernel.org/u-boot/cover.1791877299.git.pepe.schlehofer@gmail.com/

With Debian's GCC 14.2, U-Boot proper of the 71 mpc85xx LTO builds
changes by -5302 to +5588 bytes of text and data, and 69 of them
shrink. SPL/TPL sizes and builds without LTO are unchanged.
---
 arch/powerpc/config.mk | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
index 32e86d84a12..557d9360e3b 100644
--- a/arch/powerpc/config.mk
+++ b/arch/powerpc/config.mk
@@ -3,10 +3,14 @@
 # (C) Copyright 2000-2010
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+# Keep --gc-sections with LTO: it drops the .eh_frame sections, which the
+# linker scripts do not place.
 LDFLAGS_FINAL += --gc-sections
 LDFLAGS_FINAL += --bss-plt
-PLATFORM_RELFLAGS += -fpic -mrelocatable -ffunction-sections \
--fdata-sections -mcall-linux
+PLATFORM_RELFLAGS += -fpic -mrelocatable -mcall-linux
+ifneq ($(LTO_ENABLE),y)
+PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
+endif
 
 PF_CPPFLAGS_POWERPC	:= $(call cc-option,-fno-ira-hoist-pressure,) $(call cc-option,-Xassembler --fatal-warnings,)
 PLATFORM_CPPFLAGS += -D__powerpc__ -ffixed-r2 -m32 $(PF_CPPFLAGS_POWERPC)
-- 
2.54.0 (Apple Git-157)

