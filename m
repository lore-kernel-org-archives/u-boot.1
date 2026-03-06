Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26503F51416
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F93B83F9A;
	Fri,  6 Mar 2026 23:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jswsAcww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0310883F00; Fri,  6 Mar 2026 23:07:08 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD4983F00
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4c3484268so6891268a34.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772834824; x=1773439624;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FjszIgY98zszD1trFBy2+1Q9r1/cIIF1EJ8rLk2XjBY=;
 b=jswsAcwwuQU+a7/IcffXdEPCUEp+/vIDCtscSxJ4eI0bf+oNS1z+7eI6CrLrOiy7Ct
 WHl6n01c0g4KP9bgP+0BKUQgnAkHUkUfhvvxV0KB6LvSY6cC1lRO4Yy0Qqebb4+hcHdv
 nYeGm3BYLWJO8jbNneU46/aY84RNiD4VcQipMIyR7eFeHh5jWfO2qN6vNpM1WHAtoIkG
 6gz1s9yUItwaFWWZNK56Ar3N9SsFYy8Cs2s1aGibt3FtCf7hdK+dpcaMekw9uFYU7ocH
 +Ve2rrQ5xopHr/KHk/XfJgIF7kae+9n6sfBQErkM4Tg9sBh9aIOK1UohlcD5Crdmom1u
 xEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772834824; x=1773439624;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjszIgY98zszD1trFBy2+1Q9r1/cIIF1EJ8rLk2XjBY=;
 b=DL38pfj8zAZFsKKb/1xBdqGY7R6XGfsZqy2AkGiK52KsMetTo8Qe3HmA5+UVFPsaAc
 rhHNJ+NC0V7yFM5AJnQB5dfoi87cNt7XvQmPqihKC+bW0iTde+YKNxrbiDAqOMrukYs4
 KqW10mMmPG52Muk6N17O1DhSOQvVKqjIGxW0yWwrqWAfFQyrhEKjMdkVxw75E0+IL8zk
 jWBJJ7/I+IbsX6AmswNcvVj14xp5NzHokaQaIGU+2IM5Wh5nQIIID9OLf2tr/41uzHs1
 i9HJzZbe2vyM44yG6+xmIrIkq9ImCiGwWwECPSBVQKMjJQBH3HghDcsz83EJPBSKf1H4
 htcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDxZa86k314BiEdEFCHhhuhcVnB18scxE2ZaJo+KvNwTO/vNQjVtMTpw06w5LsP1Zfqy7fZWA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6xjdTmtzEPyQt5U8AYBUANopTJ0fsJoYj5We6zTW3w6VsmnrW
 SIihIa9TGhhwY8hG9RweKQBVd91JTOHosTUsLkI6caaSTbv4ifu38wQS6pFH/4xp1o4=
X-Gm-Gg: ATEYQzx1KdA4XSwldjBn574uLribFhwMHv0t/7Co3NuGagrTtc9u6JBr3ChnqEB7ws8
 54J//Gz3nbEsqSbHpNhtrs6xHVI8SIGNiQAxQjEFsVmfgw27++lreOIrAvEEv3ZK2MBE0gol2Mk
 n2CvRR8jSEl+2pp+iTndkpfRMNSF2yXkOhUlh7noHZdF36UhvpWI+i9/yLYu/Sppad23y9uU5e3
 S5y4bJ1gIlfcDNEBD0CV761FF53AGC3aFLE6NS8dG5pN37quXSa4xmTyXZV3y4pBQ+NMTj3HWjQ
 okMKMmWTrvgNr+vM7Tw3eOULak40a5DbjtpbFj858AYWzRJnFDnZrr/bJFPUM2EY2W4Vb0NAgFW
 ZNPenkLdhjYj3EJgu3Uk4X8DUrVMnaQCuGCxIer86vnA/xRAOW0Avl8ABJBMyJgfLSGOuWgY9SG
 RFkic6B82Sn/NhWXcf/N03icaT6FiF
X-Received: by 2002:a05:6830:7086:20b0:7d7:3862:5d3b with SMTP id
 46e09a7af769-7d73862601bmr59216a34.4.1772834823520; 
 Fri, 06 Mar 2026 14:07:03 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c5b830sm1707548a34.1.2026.03.06.14.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:07:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/9] clk: mediatek: clean up flags
Date: Fri, 06 Mar 2026 16:05:47 -0600
Message-Id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XPzW6DMAzA8VdBOS9bCB2lqJr2HlMP+TDUgpAuz
 iJQxbsvTU877vj3wT/7zggCArG+urMACQn9kkO+VMxc1TICR5ubSSFbIWXDzTxxFycewPkEJfV
 2U0R8jWrmw6xGbiRI00mltD6wvOkWYMC1KF+XZwf4/slYfA6ZAyJVsL46F6sRTXFc7OrulB1vJ
 uLpwAUH6N6Hzlo5CPup1TajDvBqvPt4YFpRPss7h7GvfMARl7cF1sge8hUp+rCVd1Nd6H99lur
 sq6M1p6M2sm3FH59d9n3/Bf64cGhTAQAA
X-Change-ID: 20260223-clk-mtk-remove-clk-bypass-xtal-flag-c2e2c82aabb4
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=luJhAiTAM/rkDHc+PXPfwaqDF8EWuNNftyCoo9+MYFI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpq0/ESGn3UZDUwe11eQDa8f29n1QaUyoBA0D4G
 QrVEt5sZVyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaatPxBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AD84H/2wjQytmdWW03C2Z8sDiNsxWK2Pi6aG3kul8Di0
 R5O67uqHg+wI8SK32PTt5CF+lWigvlu31j3ERwzJq8iM8fUxTZz+HTNKWYZh4n200hb/PGr5GsD
 E7+c1wUi/FBWdAIC9yqUWTL1q9YwPsCek0GbbQRGSQzrOU2r3BRD+gycof9nETE+JRsc0lUlCqb
 Fifv7ff3Fmzd5sNnPn05+mfzpjPBtyWGxbyeiuuWQkthstGMmXV6IDbdRhCXRXvnrZgsvrGYv1w
 RVnqXKF1mgX7k2NzPpZPQK0JKg24fIT45JKYYOSdvYSBlkS+weOjgpny15VU9SEBwJamWnsEoe4
 5/q4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The main point of this series it to get rid of the CLK_BYPASS_XTAL flag.
It was a bit of a hack to allow mux clock parent arrays to contain both
CLK_XTAL and CLK_TOP_* clocks. It's usage doesn't work in all cases and
is easy to get wrong.

In the meantime, we have added CLK_PARENT_MIXED and struct mtk_parent to
handle mux clock parents properly. There just a few drivers that were
not making use of this yet, so those are converted. Then we can remove
the problematic flag.

There are also a couple of other patches to give better names to some
of the existing flags while we are cleaning things up.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Fix definition of MUX_GATE_MIXED_FLAGS to avoid compile error.
- New patch to explicitly set CLK_PARENT_XTAL on fixed factor clocks.
- New patch to consolidate duplicate *_PARENT() macros.
- Link to v1: https://lore.kernel.org/r/20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com

---
David Lechner (9):
      clk: mediatek: rename HAVE_RST_BAR
      clk: mediatek: rename CLK_DOMAIN_SCPSYS
      clk: mediatek: add MUX_GATE_MIXED macros
      clk: mediatek: move common PARENT macros to header
      clk: mediatek: mt7622: change to struct mtk_parent
      clk: mediatek: mt7623: change to struct mtk_parent
      clk: mediatek: mt7629: change to struct mtk_parent
      clk: mediatek: set CLK_PARENT_XTAL on fixed factor clocks
      clk: mediatek: remove use of CLK_BYPASS_XTAL flag

 drivers/clk/mediatek/clk-mt7622.c | 334 ++++++++--------
 drivers/clk/mediatek/clk-mt7623.c | 779 +++++++++++++++++++-------------------
 drivers/clk/mediatek/clk-mt7629.c | 442 ++++++++++-----------
 drivers/clk/mediatek/clk-mt7981.c |   5 +-
 drivers/clk/mediatek/clk-mt7986.c |   7 +-
 drivers/clk/mediatek/clk-mt7987.c |   5 +-
 drivers/clk/mediatek/clk-mt7988.c |   5 +-
 drivers/clk/mediatek/clk-mt8183.c |  12 +-
 drivers/clk/mediatek/clk-mt8188.c |   6 +-
 drivers/clk/mediatek/clk-mt8189.c |   4 -
 drivers/clk/mediatek/clk-mt8195.c |   6 +-
 drivers/clk/mediatek/clk-mt8365.c |   4 +-
 drivers/clk/mediatek/clk-mt8512.c |   6 +-
 drivers/clk/mediatek/clk-mt8516.c |   6 +-
 drivers/clk/mediatek/clk-mt8518.c |   6 +-
 drivers/clk/mediatek/clk-mtk.c    |  14 +-
 drivers/clk/mediatek/clk-mtk.h    |  33 +-
 17 files changed, 830 insertions(+), 844 deletions(-)
---
base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
change-id: 20260223-clk-mtk-remove-clk-bypass-xtal-flag-c2e2c82aabb4
prerequisite-message-id: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
prerequisite-patch-id: 81f2dd4fd7c1632736c08180d6b9f6aef5fe1e7f
prerequisite-patch-id: 60f0509a5f36c2828316fa3e27dfd8f4d218eb27
prerequisite-patch-id: 237c548edf19f9cf734b1ac3b9252a4f06d8cf29
prerequisite-patch-id: 22de64f70e8d1ba5e17f8b31f461118b35e54f30
prerequisite-patch-id: 3d5661f9e55292a30f57617848a7b10e67844402
prerequisite-patch-id: ccbc73b2bc1dc41beb295604088d63773cea15ef
prerequisite-patch-id: aa76b6b028374f20551955eafe56a1e0c1daa75d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

