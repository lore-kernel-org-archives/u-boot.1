Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA341606A338
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O1OUs2Za;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1bDdkX0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB19060746;
	Sat,  7 Nov 2026 14:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjbObKQO0b7d; Sat,  7 Nov 2026 14:33:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1206D608CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062020;
	b=kwgo+mfJ9PHKxa0lexT8/82xHHNMyCumvSB/Jy08/1nVHoCyWXfBg++45rS31Utk0Q2x
	 LtDTs94p5m6m5Doj7S2IRt51ktJgURaIEm50ihuAwLx+XFxR1knn6qBvIN9G1sljCa32V
	 yn60xukMoVOiUlYJz5wKHwB66vXW6EhCvZQtehmmZtE6ve0whlBDhz+Y6QJfCljG2O39i
	 u7lbcO5dYmuMrWUgb1hugBZ9kQwYA57w21TDc6SKxWySjDHZHOboM3osGbmdwsYVNzv2d
	 nGszWyHGxlCg1lgxBeHg6IBy8bmzdqzc5w77H0vjqr1CRV3uX1sv9nbwgwU81PITj/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062020;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2Gr04E8Q0E/p30m49LLF86fEtCGgMdf2F966D2AC6kA=;
	b=DWGEPNwxicAouGBR3ekwOA0hPyeNxHh4GIQVw0968PLOl5E9EbvBHO0uFF730XglVXmZ
	 wjdjL9y6fuSLDY4/tOvGaObEwuihqCCnlf9S7Ka0iWeXYDcILvKVaw/Ea4rJ2tc3bqkO8
	 jMBYsRUdLzBPPUJ/zKsq9mLt7f26y75Z5r8gHBLQJnFGfVpReoxB9R0gvZa/lHaUqn6rI
	 MeAurUFD0Lx3H0b59/QyoFjUBqU2IYSkPuILcWqU7XbfNsFffBZdmUpK32HJqoiGsX9IH
	 94Nj/a2Ql5lkzI8qt+w4SBvKupzANLtV7RlK08sSYOh3T1QxA+ScgE6ROyCp6mUlF8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062020;
	bh=2Gr04E8Q0E/p30m49LLF86fEtCGgMdf2F966D2AC6kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O1OUs2Za4DrgQhdgTUKtJRgfCDrenXV99WwxMvGSVZMWBNijB4KBjjNPCVv4uCNsz
	 gRUQ5XmtNlO8lgeNqbGwWSKMZqd21jSxsJXQjWXhVXs4uHJP4+oE8by90NiaRN3hW/
	 +Rg4z9g79ISjsmYZlDy5byKkVobcFfv881HRH+RqzOByKepDClYlSMZ3fee6pz9yCn
	 52M6DM3ueryD8MinxGrwOAoT98C3yRRIden3nfgZmGnT7rjKTZuYon9vhPnm4ct/We
	 R/JxIDTfOFHgnMklzd9/9i5XqUYH+A4wS/NoOAc5yjdqUvagluiyYtdvRgVLh1gzm/
	 9PXq96LB4OC0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1206D608CE;
	Sat,  7 Nov 2026 14:33:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4E7C1C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AED540761
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RzbO2X3S9TWp for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:25:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B30CA4077E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=g1bDdkX0
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B30CA4077E
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:24:59 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5c0ace36e8eso34091e87.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794061497; x=1794666297;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Gr04E8Q0E/p30m49LLF86fEtCGgMdf2F966D2AC6kA=;
 b=g1bDdkX0fkpVP39kgopQ9CFK7ysck9RmQOeMvvbkor6zgELwzZyO+PpuUeGc+JSgA5
 EoMl2lPrr0GUl/PlUJPlD1NMe7BWHTki6NjCBG1/U2JX93JuB3TSYyGyPtkI79cxn0Mn
 KCyPZzFy5XGguNTZO7zaeijGfbbkS8q8TLsDa2azvCczBjk96oTjjIrfPQ0xahSWZtXS
 qtfSSHWrQ9jEqKZS2LSLzFvVY5B0frUrm4G9QH4rlsE9fhMdv72uOHMbDlRWRXt6D5A7
 PCsGAYgwp/zPvt0eQkRsgFFRoiLg/r6ADcKzlNBJAUD09OtFMYwx43Db2kAE0EY7x2X+
 nd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061497; x=1794666297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Gr04E8Q0E/p30m49LLF86fEtCGgMdf2F966D2AC6kA=;
 b=VfMBJ/qIuhk8x4rTcVxkg/XwqgCepeq2PmQ9PFzGCRwGJp6S17IvEHjSgswMz9e6kN
 4c7wXnVIqnb+Kw3veXkCI+wMmaLMG2HBdx3kja4G5faBcI9J9oNPiZ89tCjG0q0dFYoo
 Kh2m8cY9Ut8PU/skBo9eVu2tuB15qSq9XSb9B1rUTnq6wp5u/X68auXHs8L8QtR4q1vq
 i+ub31dc/ZZHsw1npGZlVq+eW/HO/LgsMveOJmtfSHibCsDgclEG56z1a9h7Kutx0aNy
 0UvQYnXqPzQPxNCIrGdFxHI8D07Qc+BcgAyqhuLAku6h7m1s5qwYZsG7iTCSIhA2B/I5
 JCSQ==
X-Gm-Message-State: APuU4Z/iKv2GXFWhm63Rv07k3UChId9RiRtJKjFAeybvpV7SZ5KhC5Wl
 GmbeH1dTK2HG+FGGc6ywuQU4ug3wLvYlfZ0x/YV+GpqjbLqfKtwgIIW4srnMHAoXcNC0G6yM
X-Gm-Gg: AYBFou2QsBo01GHAtLvS+Jmk0g8X4Tx1he4a5nuYsUvhvjylUlhteoZIXGLoc6P+0q0
 qhdPE40bFs6WXhuJXPlj2TGqIHynR0FM9PYm+4iLhJ/PqRXFWpWfFjT0GjLfxvDS95DiGMNcu9T
 odmctCQwZXjCx3SAgUWVfPidyCENFCst5vJuneuWlQNeYTtZBSO6M2wTrokkUDo9eHaSD/dyDZe
 ryIkuHOg6hrx0tJ3ncgJsalRg8RYsT95g36z2wffSNbmipXmwZcXymLlsAQz6Tkp+Y+SQwCpEmJ
 a4yiuaD7oJi+aYkVwDxxkb0QfdAlpq5C4fpdeKrFmlANmmBSL30kYpt2fPA3/bwNuMB1xTqI9xB
 IZB4sbyxVkaVDKSCAXL95DZF/DOj/Lmnq20y2AE6KT9cQzgDL5+ohCsJcMUXTJS9AeaRN517ZLn
 TuCNABGE6rNEQjhGeKW3u2wz391w3cxOPTOgyic6hLlkqwetI0UTOS5FGpY4frB+d/Az+fBl0xX
 RcwdWmV8+LpBZENlmKgZOjZ7AcrDJ4SrYPqQdJ+wdu+6u19439TlOwxpsZ+vuNioy51vt1k8lvQ
 Z/j8ikfmUTXhZOIz/KZNj+pIVJGTtmXCIMLwF23d
X-Received: by 2002:a2e:720c:0:b0:3ac:ff56:d749 with SMTP id
 38308e7fff4ca-3acff56d8c9mr3025021fa.1.1794061497021; 
 Sat, 07 Nov 2026 06:24:57 -0800 (PST)
Received: from OpenwrtBuild.lan ([178.207.14.215])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acf60c9cf4sm7125971fa.36.2026.11.07.06.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:24:56 -0800 (PST)
From: Mikhail Zhilkin <csharper2005@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com,
 Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v1 1/3] net: mtk_eth: an8855: fix bitwise collision in
 RX_CTRL_8 register
Date: Sat,  7 Nov 2026 17:24:38 +0300
Message-ID: <20261107142441.2104669-2-csharper2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107142441.2104669-1-csharper2005@gmail.com>
References: <20261107142441.2104669-1-csharper2005@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:33:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In an8855_port_sgmii_init(), the bitwise operations for
the AN8855_RX_CTRL_8 register contain a shifting error. The code
attempts to set a value at shift 16 (0x200 << 16), but subsequently
applies a mask and value shifted by 14 (0xfff << 14). This creates a
bitwise collision where the second operation overlaps and overwrites the
bits configured by the first operation, resulting in unintended register
values.

Fix the shift offset for the lower bits from 14 to 0 to prevent
overlap and correctly apply the exact values used in the upstream
Linux driver.

Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
 drivers/net/mtk_eth/an8855.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
index a2589a2ad31..eb037ec1382 100644
--- a/drivers/net/mtk_eth/an8855.c
+++ b/drivers/net/mtk_eth/an8855.c
@@ -627,8 +627,8 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
 	an8855_reg_read(priv, AN8855_RX_CTRL_8, &val);
 	val &= ~(0xfff << 16);
 	val |= (0x200 << 16);
-	val &= ~(0x7fff << 14);
-	val |= (0xfff << 14);
+	val &= ~(0x7fff << 0);
+	val |= (0xfff << 0);
 	an8855_reg_write(priv, AN8855_RX_CTRL_8, val);
 
 	/* Frequency memter */
-- 
2.53.0

