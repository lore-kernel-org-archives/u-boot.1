Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA11CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5F27409B4;
	Sun, 18 Oct 2026 08:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ejQrsMKrTyta; Sun, 18 Oct 2026 08:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 938F140990
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312532;
	b=IMLqAdtzRyTovFqKOqbssfMJej1nSZgvfyvbcU/tHzzOR9gaQOx8cE6Sl3QBu/8B1v4P
	 oedntoWE0jQmWxhdh3j0KihuIukOmHvAp//Jkkruc0jGPWc6N7QY0u/LBElW6dCm5sAzM
	 q3alIxkWVR9+6w2R1/xjhcB1gKd/KNS5OE3PrmKz3u6YZe2NTrQWUJQvG2nen/D5ucWOm
	 nH7YT3vaW++D4CsLt8i9IfyblW1EeJgu/ZqRQQ50SiECFjqNz3aZFbYVTfK7uct38HZll
	 n+2tLlFO4LuOVkk6AqYqim3lyCzQzpRLLr6xkLtMr9sWgU1gyGOU4MgA+5kuav7zEeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gWini1JPP7163BXxBUGDot2hbTHPN+ol6tViR8CkhTA=;
	b=DwSaxOtgn5GQov5EXTRm60lrrfS8R4vcJsLu581wpfY5jt1W0CPvX5il+gOhH4SYCYzw
	 QesmMs+ASLM4VaDB8/YTI3VFfg1G5YTbdJJk4RH0aEV27xNc0CF9VqdHyP0y3IQklDTQE
	 8FA0WvY1Lg0m+WM2fDOi38HDpxDDT6q4+3xEdVxrKSosMcxZAFAhPmPPJJQcf4FyskFFx
	 tDEvleebTivq2AMq/xMqoM0JWezqIweckZdVQtwZe4ZKJd6s/f7uXBIxdUhGkbfTbuCky
	 EjnB0HuvKY+6kU7GrIQXyOXgUdUkU5SgshC2k6jSL3CAcor+k47DLtDI1djeJdl3KWA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312532;
	bh=gWini1JPP7163BXxBUGDot2hbTHPN+ol6tViR8CkhTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pTNBbFmCfAWEUsGh6+c4pUNmxMh5Guv8BUuKWkRaauLehxszkwczeBtREWoADoCFD
	 2IBAv1Y73l6+j1ibhvN4dXn/z2BS/sCOHA75m3693Z7V9JJOArirgpndlilXnPFL6u
	 jlEEJQ12iDx7fA3YPSX8ebIA2FWhN5aCwTkDp5++CX0uRR7VR+W6lfExpeBdWqUEKW
	 3cyAtVfMLtDCGfKMaVaB03TpCfBizZcFK7YnT0Lm7w1mX8ebYMkWqo0aYvHd9qVElG
	 YHlgPpty6V5D875Bc+QCo38VWN1iheBZMmDf+LsLAOZREMuU7bv/Cakvs3dtHAW9N/
	 QH10lB9t9mDlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 938F140990;
	Sun, 18 Oct 2026 08:35:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 86F9F2A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C9DA812F6
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aRhP_BoB3p-u for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2258812EC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312527;
 b=S1clQtVXIgMjnOOgLjSI3kRiZ0WuPNhI/fFyd6lleVT26GiD53ILb8xsQQbw1MpT3atc
 wSYRt0U2aKqMkZE/+cxn3MspajAvbZajJs4xsjlM+pUFTn6nNx4CVju1YOsXynKmrvJ2y
 Cbk1mBbrEMA2ylyN1dKwcO8RTw1CLve0EYZI00j3voymFOOIEQGw2c4ZVjEFLjczlJqNy
 f1AFRw1DOYUPIzXudgsEgC0w+R5NWzpEV17dL4ZVEmTBvLJPLqFjNeH0EF+hmf4tZDlO6
 GL2owHJ1Caw62TWEO1SSAyuUGF43yWWjBjhrcgktjKSp0EaDpYr5ooX98WUuFhosNgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312527;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=gWini1JPP7163BXxBUGDot2hbTHPN+ol6tViR8CkhTA=;
 b=FFoFfbCHEx5wq2oVZH89TbY6VAiSOI+CSsrqxR7ube+J/bWA3g5ARN3g3SEfcDieWSSl
 CuSAZ1W9WNltmDBOStZPRGBZmCCcrXvP5B2sMszI2284/xwgYXQN/uwQvrynRnbcKoTKr
 +yIH4hqtg/YllYoUjOODF4gZt0MuqYBKtenHxi0LEm9uruyvO3QEXMYoui2T9WrZwGKHL
 rF8bmhfxAJTqsj+bWk8I/VOhZSjZ9cXng/Sqo1NIaWA7p/bcTnLjTuhS/CzpcoX6jdCHd
 WaHvgq3xBmr53dFIhyhzAZ2kj7f8Tr+WE4Ij+0neXhn9Kozw73CDc6dIIV84KLThv+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=n4r9Lc8f; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=n4r9Lc8f
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2258812EC
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:26 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so12649345e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312524; x=1792917324;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gWini1JPP7163BXxBUGDot2hbTHPN+ol6tViR8CkhTA=;
 b=n4r9Lc8f2vPSQxFg4t99NhjGJVfyV/n0HQhdodE96AAzuzRHbSIJzqPHLY8iLfAhow
 XG6mwIM6MeL/45Jg3+wHkIzMdozPVQ3uiZZpiu6pBihouRNspG2mf9VtBzN2mi/I69BQ
 5gqpu+8qMhBLN2EsgetjkpQHly4/Cr6etJjlqIlVVTAAa6NslW9lEQf3HaalzYXqbPUY
 2tSW491F+yC/CMSg3zhi+MzWKQi/Rf0w0kGy1eHyK9XCnd9SuW7afK/a9NukgW8fortq
 BkoP0KccQVE1Sg/He2vfiHCUFIiy+6Z1q963rahpOGoXvQr4wBPjTvf63tOWguIW8dFb
 T/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312524; x=1792917324;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gWini1JPP7163BXxBUGDot2hbTHPN+ol6tViR8CkhTA=;
 b=Q26spL8K7F11bANYgLbEQHajyxEM4azf1uxr6PdehUtVFiqoqrQnOJrGqDuoeR+tFb
 8V1Kdvf1c8A+7R78zu5VAdntg5fHvs3qjBWG3LsydPRQjNEmWhBWTt6xDo9tIUR2Fuo3
 FzO/zci2ciJCU3O26mLujLfHMCQQNoKXEiyrdRxpF7otlK5sYyh/+sxliEmx+lnQRnTT
 AQOaUNt4YLOVb4F26rxK8FCkdrMc6vLEAI5TYL0B/QNNbwJfXWaQoRnLZf79h1JnVcl3
 H1kUgvYhpeBspE3lwKi6sMTBjPhyErL04OEnPMOz5BN9/Q8pwuSldj6bMqzhM2hm2dy6
 2wDA==
X-Gm-Message-State: AFq9FYIrjqSpJ3RZJuP+np7rcOZSRu9AmuJSjQf/erXCfvzteYAoWNUc
 VYCzrsWuuY7QLS92bA7VVJOqhG6c3PNTazS+1jAb8gdM6S4hombqzUIfghOfhiUe
X-Gm-Gg: AYBFou3x8IZPFkxKhrKcdkfbtwMfMHBc3UPmc+9WmhZgkG4Sx2YXwSpTgrHy/JGlvc+
 tysjPR5sLcunnzExvlKp0i6u5g95yXu98l5AxetcaX28OXR10ZkgxAA/r8zCY66b0zWSZlQoxxk
 tsF6IJSII5Z9o15MWFkqtbTODX7aMzlOOhubteGXCdqvcp/wfajuS6z7PEsLCKCiznfGVv54XLp
 kkrbpSDSNl4Fy1ViUHHsp4uYs8F2y1kdyFQ1Re93Tmt9EKZaY7k/mNV/A6aFykZGPHm9D4qzL3y
 3ovzOah4Auw3MLmjx440hfsLTY9XOtxu+eAZOze5H2fCTUnD51cTe01wxzWlis4iM+0ztpdtR27
 3+hkyTcC+LBr7PG9GdROmv5jpYhlbbgjmMUJM1Q5SwslJisRUWM7c9fd+IFQ3uE5KkmxTVKdfm/
 UaQkk7DM5U34nme36TLyjdzS7tXSBn6wi41l4zGbq7asADo1AkUUaXUn5msh0tDOTQ/eXDyEdFw
 jyWWtxSUdcUqEJsPb2wEMCTQ894xcaDo6YqNwuBINpsLrThTPHMCE6U1oLsieHC4NSOKsHYBG2V
 cazyrgHif59FiYv/B/Jz59wFf9t8b+wQVCKZyI+d3tdbR52ofmUq+pzTdXnoow8dENJCTjPoTW3
 elha4Mn+qO/8kuP1QwCPjmks=
X-Received: by 2002:a05:600c:c8c:b0:4a0:bc9:28c6 with SMTP id
 5b1f17b1804b1-4a1d7643dadmr84467615e9.34.1792312524007; 
 Sun, 18 Oct 2026 01:35:24 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:23 -0700 (PDT)
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
Subject: [PATCH v2 02/14] powerpc: Make the global data pointer LTO safe
Date: Sun, 18 Oct 2026 10:35:04 +0200
Message-ID: <20261018083516.49229-3-pepe.schlehofer@gmail.com>
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

The register variable form of gd cannot be used with LTO (GCC bug
68384). The LTO link fails with "multiple definition of `r2'". In LTO
builds define gd through inline assembly accessors that read and write
r2, following ARM and RISC-V. Other builds keep the register variable,
and set_gd() assigns it.

Every assignment to gd has to go through set_gd() for that to work, so
convert all PowerPC ones, including those in common code, and give
PowerPC its own arch_setup_gd() in the new arch/powerpc/lib/gd.c
instead of the weak one, which assigns gd. Rename the gd parameter of
the SPL board_init_r() functions, which the gd macro would otherwise
replace.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Cc: Marek Behún <kabel@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
(no changes since v1)

The mpc83xx and common/spl/spl.c hunks change no build: mpc83xx cannot
enable LTO and no PowerPC board builds common/spl/spl.c. They are
converted so that no PowerPC code assigns gd directly.

Unlike on ARM and RISC-V, set_gd() assigns the register variable in
builds without LTO. GCC requires inline assembly that accesses a
global register variable to declare that access through constraints.

In the T-series SPLs, the board_init_r() bodies now use the global gd
instead of the parameter. relocate_code() passes the CONFIG_SPL_GD_ADDR
that board_init_f() has already set as gd and leaves r2 alone, so the
pointer is the same.

checkpatch asks for IS_ENABLED() on the #if lines in common/board_r.c,
common/init/board_init.c and common/spl/spl.c. They choose how gd is
set per architecture: set_gd() exists only on ARM, RISC-V and PowerPC,
so IS_ENABLED() cannot replace them. The new arch/powerpc/lib/gd.c is
covered by the POWERPC entry in MAINTAINERS.
---
 arch/powerpc/cpu/mpc83xx/cpu_init.c       |  3 +--
 arch/powerpc/cpu/mpc83xx/spl_minimal.c    |  3 +--
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c |  3 +--
 arch/powerpc/include/asm/global_data.h    | 30 +++++++++++++++++++++++
 arch/powerpc/lib/Makefile                 |  1 +
 arch/powerpc/lib/gd.c                     | 14 +++++++++++
 board/nxp/p1010rdb/spl_minimal.c          |  2 +-
 board/nxp/p1_p2_rdb_pc/spl_minimal.c      |  2 +-
 board/nxp/t102xrdb/spl.c                  |  4 +--
 board/nxp/t104xrdb/spl.c                  |  4 +--
 board/nxp/t208xqds/spl.c                  |  4 +--
 board/nxp/t208xrdb/spl.c                  |  4 +--
 board/nxp/t4rdb/spl.c                     |  4 +--
 common/board_r.c                          |  2 +-
 common/init/board_init.c                  |  9 ++++---
 common/spl/spl.c                          |  4 ++-
 16 files changed, 69 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/lib/gd.c

diff --git a/arch/powerpc/cpu/mpc83xx/cpu_init.c b/arch/powerpc/cpu/mpc83xx/cpu_init.c
index 340f9a0da56..5618b79a78b 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu_init.c
@@ -139,8 +139,7 @@ void cpu_init_f (volatile immap_t * im)
 #endif
 		0;
 
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)SYS_INIT_SP_ADDR;
+	set_gd((gd_t *)SYS_INIT_SP_ADDR);
 
 	/* global data region was cleared in start.S */
 
diff --git a/arch/powerpc/cpu/mpc83xx/spl_minimal.c b/arch/powerpc/cpu/mpc83xx/spl_minimal.c
index 7036e3fae0c..1d48428573d 100644
--- a/arch/powerpc/cpu/mpc83xx/spl_minimal.c
+++ b/arch/powerpc/cpu/mpc83xx/spl_minimal.c
@@ -25,8 +25,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 void cpu_init_f (volatile immap_t * im)
 {
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)SYS_INIT_SP_ADDR;
+	set_gd((gd_t *)SYS_INIT_SP_ADDR);
 
 	/* global data region was cleared in start.S */
 
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
index 75bfc07fe97..fb3d662c9d3 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
@@ -95,8 +95,7 @@ void cpu_init_early_f(void *fdt)
 	int i;
 #endif
 
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)SYS_INIT_SP_ADDR;
+	set_gd((gd_t *)SYS_INIT_SP_ADDR);
 
 	/* gd area was zeroed during startup */
 
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 26cbc7854d9..d8aefd2ca0a 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -93,8 +93,38 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
+#ifdef LTO_ENABLE
+
+#define DECLARE_GLOBAL_DATA_PTR
+#define gd	get_gd()
+
+static inline gd_t *get_gd(void)
+{
+	gd_t *gd_ptr;
+
+	__asm__ volatile("mr %0, 2\n" : "=r" (gd_ptr));
+
+	return gd_ptr;
+}
+
+static inline void set_gd(gd_t *gd_ptr)
+{
+	__asm__ volatile("mr 2, %0\n" : : "r" (gd_ptr));
+}
+
+#else
+
 #define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("r2")
 
+/*
+ * GCC does not see an asm statement write r2 and assumes that the
+ * register variable is unchanged, so it may move gd accesses across the
+ * write. Assign the variable itself.
+ */
+#define set_gd(gd_ptr)	(gd = (gd_ptr))
+
+#endif
+
 #include <asm/u-boot.h>
 
 #endif /* __ASM_GBL_DATA_H */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index c0caa703caa..a3048975ae7 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -18,6 +18,7 @@ endif
 endif
 
 obj-y	+= bdinfo.o
+obj-y	+= gd.o
 
 ifdef MINIMAL
 obj-y += cache.o time.o
diff --git a/arch/powerpc/lib/gd.c b/arch/powerpc/lib/gd.c
new file mode 100644
index 00000000000..d36f784fbf7
--- /dev/null
+++ b/arch/powerpc/lib/gd.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Josef Schlehofer <pepe.schlehofer@gmail.com>
+ */
+
+#include <init.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void arch_setup_gd(gd_t *new_gd)
+{
+	set_gd(new_gd);
+}
diff --git a/board/nxp/p1010rdb/spl_minimal.c b/board/nxp/p1010rdb/spl_minimal.c
index 8cd79c6fb5f..33930fef8d9 100644
--- a/board/nxp/p1010rdb/spl_minimal.c
+++ b/board/nxp/p1010rdb/spl_minimal.c
@@ -45,7 +45,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	puts("\nSecond program loader running in sram...");
 	nand_boot();
diff --git a/board/nxp/p1_p2_rdb_pc/spl_minimal.c b/board/nxp/p1_p2_rdb_pc/spl_minimal.c
index 511bcf5506b..960b2c41457 100644
--- a/board/nxp/p1_p2_rdb_pc/spl_minimal.c
+++ b/board/nxp/p1_p2_rdb_pc/spl_minimal.c
@@ -43,7 +43,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	puts("\nSecond program loader running in sram...");
 	nand_boot();
diff --git a/board/nxp/t102xrdb/spl.c b/board/nxp/t102xrdb/spl.c
index de6cdda194e..f527f62a5dd 100644
--- a/board/nxp/t102xrdb/spl.c
+++ b/board/nxp/t102xrdb/spl.c
@@ -58,7 +58,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	console_init_f();
 
@@ -87,7 +87,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t104xrdb/spl.c b/board/nxp/t104xrdb/spl.c
index e02a1f95d4c..0310baa381c 100644
--- a/board/nxp/t104xrdb/spl.c
+++ b/board/nxp/t104xrdb/spl.c
@@ -55,7 +55,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 #ifdef CONFIG_DEEP_SLEEP
 	/* disable the console if boot from deep sleep */
@@ -78,7 +78,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t208xqds/spl.c b/board/nxp/t208xqds/spl.c
index 44ad4e68d9f..f8c641a9c64 100644
--- a/board/nxp/t208xqds/spl.c
+++ b/board/nxp/t208xqds/spl.c
@@ -73,7 +73,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	console_init_f();
 
@@ -96,7 +96,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t208xrdb/spl.c b/board/nxp/t208xrdb/spl.c
index df3b9c6fe40..4b1ab3618c3 100644
--- a/board/nxp/t208xrdb/spl.c
+++ b/board/nxp/t208xrdb/spl.c
@@ -33,7 +33,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	console_init_f();
 
@@ -56,7 +56,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t4rdb/spl.c b/board/nxp/t4rdb/spl.c
index 9d2472dec25..441015bf5a4 100644
--- a/board/nxp/t4rdb/spl.c
+++ b/board/nxp/t4rdb/spl.c
@@ -39,7 +39,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	/* compiler optimization barrier needed for GCC >= 3.4 */
 	__asm__ __volatile__("" : : : "memory");
@@ -59,7 +59,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/common/board_r.c b/common/board_r.c
index a397e20959d..7a9de6ba5f3 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -796,7 +796,7 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 	if (CONFIG_IS_ENABLED(X86_64) && !IS_ENABLED(CONFIG_EFI_APP))
 		arch_setup_gd(new_gd);
 
-#if defined(CONFIG_RISCV)
+#if defined(CONFIG_RISCV) || defined(CONFIG_PPC)
 	set_gd(new_gd);
 #elif !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	gd = new_gd;
diff --git a/common/init/board_init.c b/common/init/board_init.c
index 2a6f39f51ad..2faea5432c0 100644
--- a/common/init/board_init.c
+++ b/common/init/board_init.c
@@ -14,15 +14,16 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /*
- * Unfortunately x86, ARM and RISC-V can't compile this code as gd is defined
- * as macro and cannot be assigned.
+ * x86, RISC-V and PowerPC provide their own arch_setup_gd(), and ARM does
+ * not call it.
  */
-#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
+#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV) && \
+	!defined(CONFIG_PPC)
 __weak void arch_setup_gd(struct global_data *gd_ptr)
 {
 	gd = gd_ptr;
 }
-#endif /* !CONFIG_X86 && !CONFIG_ARM */
+#endif /* !CONFIG_X86 && !CONFIG_ARM && !CONFIG_RISCV && !CONFIG_PPC */
 
 /**
  * This function is called from board_init_f_init_reserve to set up
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6c9a1a1cbcc..81aec2b1108 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -956,7 +956,9 @@ ulong spl_relocate_stack_gd(void)
 #if CONFIG_IS_ENABLED(LOG)
 	log_fixup_for_gd_move(new_gd);
 #endif
-#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
+#if defined(CONFIG_PPC)
+	set_gd(new_gd);
+#elif !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
 	gd = new_gd;
 #endif
 	return ptr;
-- 
2.54.0 (Apple Git-157)

