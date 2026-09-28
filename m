Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D415CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92C5780F28;
	Mon, 28 Sep 2026 13:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id meO38e86z-ZM; Mon, 28 Sep 2026 13:42:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7C85280F65
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602954;
	b=iuAhtaVg6kxW7zhwmJa5TFooLhQ3yiMftXxogDvhaS2lkhWIMVlIG3RPpHxaHp2fFdTq
	 CYlzje/oxE50PRJUgPeEK38JSNCFg95omQvcZO02ohj/eelyQ9X0f8Uuwu3NQTS4mkydZ
	 KNBVZx8gWeDGZCep+Fgw5jyfWlr+uqjJmkn1YVjTWuy9DCFwuIqZG1DmVKdOmZnbigApN
	 VQbuYG2g+Hyw8LSyRkmKp3KqW+POoVJ6T5iGvH25lSZJsXD41wM+jSH6dNkFISedqfDPi
	 Yn8KclUPNiGn6Dq9y+jZlj3oaoetlnZY7sofqcFdYDBBJBKfdz4JXwunzkLvjX9JcEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=43qyDGOZ8tySAn7X5aZNeZGUk3aEaar0Rsitss6uIhQ=;
	b=DYajx/0NFmuwJeCRC42f2rLSqgk93J5xkO5T/BwoMJB7qJDJ32qD0DiibVRbLrRVgarZ
	 O5c5cBVL5yP1PGquqXI1LF5q8XEiJ47i/6qBOocYKLaYX7ExVykkrHuWEVqlj1fLXrFFJ
	 fw3+S+F81iqJOEBFGLx70gX2rnaunOoOADb0x3RbEkCnT8bsXhYR0/9Iga+6cyAZrxqRM
	 GgRvX/meKMTsG1iYlIx+VXssPu+xXq9Cq0AP2vF1KgpHwgPvxqfB8O2hjPFQiTOHlFU8Q
	 gEmPVLPEGUgampv2CB7RisCAWRePfkPJ6z2xUIw5ZfK2fvegniHuwsd/EiC8veTWdQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SOiI2N8B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602954;
	bh=43qyDGOZ8tySAn7X5aZNeZGUk3aEaar0Rsitss6uIhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XXQt5U2f8r0dcZiW5lXgZXxVqbtNU6sXJHXkUMD+XaS5iPta2aeMYxgLSu3VDMlmg
	 pT/qIksB0fXg/iA47UouMTttAfwxzSrMFteZEdyObggqhg0IGO0Ph6ATlov3FyjSfZ
	 j5XDwi9YSazrNKmFxcwkbtCttrE+nzUkMfLsEnnEleTN0WNtW3m1tWOlmskGv8FzXP
	 qcneMHuShKyYJ66ZI158/C4I97UFHvAzVF4y2zLUk4IEnD6bmChVSZoEM9uiealkCk
	 8ITXNUC9T4M07KHJKeqV4bbu9dVzBWopah26pbYgHw9K+CVLZlcCCbUaa8k19RG9p9
	 Gj2VfDNn/jjIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C85280F65;
	Mon, 28 Sep 2026 13:42:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D6FA3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AA6B80CD4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DmN6JR_AYXGj for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6FC9D80CBA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593522;
 b=fMK/lrYiAj6pEFtuEFys5rNXmaikOlB1d88kZ7VMtwwxJk4csAspnezMR5deKtn2jTqb
 E34hNuKEgtKbP1DwypemUtay72iKw64f1qVdzcbXko8O9RCrJL/BxyozzaRJ/oK6+2CjU
 YtkpLyt5oXya2IhpL7kgwHbB/mWBf4pvdIg3qzB0R1FNXPXe428OOMs0r7jndgWJnCX96
 AZncwhzmDmLDqvyVKjNQ/Z6F9dffCn5A9Mxw2QU4AJ1+/OSuzWDVwTvdO6g/xjVOmYVKE
 EtanbKhdsszBI/cuczdT1NZ7hHvk41cSCl3l5qxOQMKTwtGfs6Ba8sQpiFuMggSzc9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593522;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=43qyDGOZ8tySAn7X5aZNeZGUk3aEaar0Rsitss6uIhQ=;
 b=T0F/0uzXSP7sf5i/hgmPsSWiUPbrU9LCXcHogOxNTvflOo/MB3lxao5VtKiRN1jb7w5I
 UZyBrdAnOlwW17eaK/XsgyC3Eujnjh98ilal5J+OwphCuWDGJbBZutTJYn18T8vrj7LcO
 mjEaN1T6QkAi7y1L0mcOZzlo7UpVWRBbP/2EgOhtUdIEqWjC4L7co/o4Kd9VbDRu3h8uL
 CHhPMquEyTET2lP7QjaUNVSvANnKSP5wEQPp1HW0b60i7FiHCUpXj1w2sL7goisyR4ILC
 1ppXLXG55Rl50/xuyOvAF388ZsAnPqXa7n04BIRFeuNluJmsDIEoiTyY4R0I62WLt8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SOiI2N8B; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SOiI2N8B
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FC9D80CBA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:22 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so21884255e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593520; x=1791198320;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=43qyDGOZ8tySAn7X5aZNeZGUk3aEaar0Rsitss6uIhQ=;
 b=SOiI2N8BGNGNSuHKSZLPb2qKhIZb/QTfOBqyaGhnkTyEhipV24razEE0RcHTJHTZXZ
 CUsBZTp0nGqxoFdRRnOlfkjmCjBzDQWzrIKtWZCCXj3RKw9HU3kUbJfvvT0cOPqBfHeD
 ZZjlJ0eVCjEHYjvWTpcBg9nHkCfbhCw2X4CB4H9/mcUxBNidJj7gRYnzyS5JRZwoFmwB
 5NRLme4V25lMIIW6U/E5ltmHO+QUm1q6OoN1/Cs0RMiwl6GC4BLamsTPESpxlXU8YUX9
 xI/7d66uJpGrOvEnsmftjtBfuUa/PeUQtAzL/5LNu6R0AlXHnXwU4BRVf9U7NqKwm5qV
 O0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593520; x=1791198320;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=43qyDGOZ8tySAn7X5aZNeZGUk3aEaar0Rsitss6uIhQ=;
 b=Pne5NYSrlUdco+Tx2wP3HbKAdgwYZJ1zY+bv6zdsWUAO0bY2xqR0lk8GfS53cPd7SJ
 2PHCpWEXehxRkak1/a3lVrxqs+k40KUIO2uo0w8dTG3UUAYtGjJSbOdxbPDy565/Q1rb
 BKQ/PT8pGNw5bCzluEwyHEVSGLoWQe3kwqw81lcqvhCNls9hkqC6f0pZDALtYc/Mvn65
 nZL84eHRGvJyBuRZEGL5HkqISeYoZGTtZdgfjEdUCZuwwTHgoA55HMNwyJA8L6c+l93a
 X3F+eQa3Tk+0sFc87LGqXCtjwQqDE3kxmsSIvJlttS5dGG7p4JOPtdZGBC73D5sieDbs
 lzsg==
X-Gm-Message-State: AFuF++mFz26bE2d2ayD7RChO9NgUpyqTXzWxqnbv33/N87iiOyf7vmfv
 hz08RW3fg51VImD2O+sRXujSN5s11jzy+EemgqTFFsHuM9Ah79+7nwXd6WEsmhExSMI=
X-Gm-Gg: AYBFou2Y2DojHokWMJkhK+h9SJr7GQtXsz6DoLcJ3YxK2wbRKJpZROOUmrMiYwT3nXy
 2qWWMyxKnbpRfOetragj3Q6iAFTKRoxgMF+B8GSlX4ZVTHjWdYmx0H7VdWl+CA3ItVjGBHCPH2T
 r/6csRZyniMsQIwZkKECrsL5E3PRefFXNISj0Sf/nVoqwoGc5h8jhn90tJmStv8pV81perzPl1N
 HoSTDX+5TvMzKj/7Ee0fBNpQaswBtNBTgawlnt/zvt1c6yya8kHR5rb73CZbWc4v1Wnnm9btFIb
 jcLvtg0PdNhSHAgfgx2qYuSZFaHhlivU4fpwJPb4T6E1DRqaC36+0+lc2uj7HFGM6DV+r1lk+Su
 ARYkEnEXghyUI8S2GB+rRosIYIZa0Q8lPAojD5hqNzmw8CEutwWhYxH0K3hUuI7YmEdutya00K+
 n5+F00u9GNvKxZ/y7JUzKpSnxKoZsXouxJyUhVK99aK1CA2qbOWZjjjJTybxV0kdI+uNX5ENALv
 e4LWBoNlddz+r5ib9rzCaboGYFZE1JjNz1wFPTJN7cjuZ6+FwnwAqmQQjDYc3A9mowGjgupeYJ2
 kr+eNaGjLTFDEvYdzcorR+XcV0rgfHqQKa48m0yG
X-Received: by 2002:a05:600c:a16:b0:49f:eddb:bcb1 with SMTP id
 5b1f17b1804b1-49feddbbe6dmr183426945e9.25.1790593519440; 
 Mon, 28 Sep 2026 04:05:19 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.05.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:05:18 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 09/13] configs: turris_1x: Enable LTO
Date: Mon, 28 Sep 2026 13:04:30 +0200
Message-ID: <20260928110434.70686-10-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

Enable LTO in both Turris 1.x builds. The NOR build needs the space for
the ubi command next to the BCH code, and the SD card build needs it for
the BCH code: its u-boot.bin is otherwise within 1 KiB of the 1 MiB its
SPL loads from the card.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
 configs/turris_1x_nor_defconfig    | 1 +
 configs/turris_1x_sdcard_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index 070428ae25e..d8ce4aed4a7 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -19,6 +19,7 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_OPTIMIZE_INLINING=y
+CONFIG_LTO=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=786432
diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
index dbeb34dacfb..982a6cb0703 100644
--- a/configs/turris_1x_sdcard_defconfig
+++ b/configs/turris_1x_sdcard_defconfig
@@ -29,6 +29,7 @@ CONFIG_OF_BOARD_FIXUP=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PCIE3=y
+CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=1048576
 CONFIG_MP=y
-- 
2.54.0 (Apple Git-157)

