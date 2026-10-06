Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C14CA6004
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD64B607CB;
	Tue,  6 Oct 2026 15:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QnKiHy6uNx3i; Tue,  6 Oct 2026 15:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1AA68607E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791299504;
	b=YR+QFcWmJIa5kRYscYvRCLtZBvAqODfRGhG+ZoQjDbi8lIJuepdr1oZkVFGlU7hwgJYX
	 CdH0G5NUR0UvGE0kldNxZ92XZfTR07+8WTnM0n1I4lybM4eRMMUPrOUBDGWUzTn99EwBl
	 fDgXJJyz+HGbTUjx3mZMlIwZ2DF7umJm9MVd5x1wTjKWnbyMIBpOKHY3jzFTeYiV/QHqo
	 FodoiXLxPu2uWCY1H+dFbSASSHa8Blxx0dNmi5Xfx7ANgdab2cmA76ogWJ/Z2DP2hzHUE
	 ImFdV72S6KQ6mFub5tQStNwUN2ZTRiS31kK8EZ07sGOfAs9uNokg/UIFH4J2lxOt+9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791299504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
	b=QQ7Qpf50r+jqBgVo9uiWUdejbEYe47lpOos30vRuiL65WtkpE3jlsnFobWpAexLnTVmR
	 aPQJ086a1YWeBaB4Oaq5+/WYb2JRa8Nkp+M5AxiGEbI5iLn+PnWONn/yY3K1qg2hIY2sD
	 bCbDbbtrESGwAbbFiQlpO2Xi0HxgmRmX87+zPPAJO5E05I+YCKFecMMCSqpT02Pb6evJ+
	 CfxSHcTnFK3zLRWVYE4RrbxHqIaMfioCaPUZfb1HPCarkx0291DLaKEo9xQo5bKD9E16J
	 hXYnTAyTYxqRlaLzQaeumrk//OuZvk0MpS2tloQ8D2/Fs5aXQ9afViGUWaWc7c59o6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kU7niipr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791299504;
	bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LAH1+6jBrt3h8cGKJ+3Z2aq4YzU/Z4yjRTIq86OJe0ZJ29sietoIE66wfBQDKy788
	 A8pKEwfXPBoqejgDRILUF1eMtIsHQLWgRkXZ4wNKF0SIT4hmf1DGtCKBTCAdJdQ+mV
	 /2DiNCpm18/neg8c/kthI4foxcQUY8GYxT9wVGgnngo24oMza0gNHvMGscQhiR5VlC
	 Uom7A/39xgUcoPHFgQoJNI68agT+rycDxhuEUhylWM5m8P9D0aJMrsRiYW3OFH//aY
	 0wbs/1QgQpgdehkKKypu6dA0u2jOfnliXIasIwRZOFEdfm0ziJB5lrveAXj02u4MPD
	 zo2H1kX/gwwmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AA68607E5;
	Tue,  6 Oct 2026 15:11:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FE3F317
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CE8F607DC
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDseuuDbXx4t for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:02:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E6DFD607CA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791298923;
 b=rpm7XXPkwBhgWbG/Tvjnf1ok/Bst64Md6maDSwNANw0QQADJY/xPEtjIq8dgn1a+rMBy
 fZeYPFwBV5uycu+3oyd1g9LS7rLg+kp3q3Kiw0uyDvmk1Ue7sqFo4/ISjaz+JucgfydyH
 ye9Zz91rIHt5s71YUdFT/7ebI2PfiLMNkng3+PWGZ6b9mEOQ4JtatI3UGoOWNG75wnIPT
 NNanAj+6tpqxFA9I43tIziLHqd+2e8VQP/cJi/DwlsYw0iAgNx57vjIMz+nkgOaGlY3TV
 JQRb1Ot5B9b3GY24rxbT+HKunTSNJOJckyxpIZomFGvCDD2DtzwmP3iHB4KNo73jC0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791298923;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
 b=BZeKoLrbtF6ypVDSXmrYqG4kkqvCckAIYe2cNoFB0+M/0d8c6F+IEtsa7h5dKz+HmNTH
 Wgwohx4ZRA+gyXVCfq4ONsN23U0K5ekKvfnVP/i7OAgJM8zaiey3fv5TSBWMDduRHqJfF
 gXyiIj2JRD4Pf4o2UUixR4ZV6V74vvYOPiW++UPQD2CwdPoOzMb9J4TBP+hGfyxFn7Nkk
 1n/AQ0OBsqmc/KfBECTLEhqb+chFh+onj+2UHamQg13qoPTqyc+/UsRh8VtYjxrT1pqJl
 ANOiHKtDe3XEdCqxJUDwzm5QjaNR/CJ7AUF0kXEs3zdv28svTnL2RdIeU2hV13PBWDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kU7niipr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kU7niipr
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6DFD607CA
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:02 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so28858555e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791298921; x=1791903721;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
 b=kU7niiprUsc3CAPBd3evfzTF8fW/p6SNWCL1UPS/ZY+RQL4wpOKuxh+QlpNDzGp9kc
 LlY7dvLzsREaCIOTma79Ig9Nq8OLgjOjzHlM0Ai6H5qdShjEBvvoXLEtvqeQNWHO0JOv
 o+wFynSmJMkD9TN3Vfi2SswBV5ieCA4Ovg8n/R0pupGAEaza3hOatE54pMNd9VxPPEy1
 PisQiUONYMiZ/oOyP6owoQglkPnFj1rvwy1m2aRia2oqsDzYI/02JJGH6jV/ABdZErQh
 99AxnB2lPb0+HjhV8nzxrkesp99a0fl0egGkO74eH3UDspUmIloY2Uy8Jp0iZuxWlzdC
 6RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791298921; x=1791903721;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
 b=eR10AOeMvHcKejjO+KG65NOdC/6RLoh94v7SZMazh6YnOLmBkHeiPPODzfqE290dej
 gYioH93d3UGwXL3ZuGlKvJAqeVCBNjXj0YV6FxkKy9Dw2MuezJV7VxLVE/R5RuLCl0i1
 00wsOO4Y4T7nF55Ra0dRrZrsc9YymEFQ15Kx7YAE+uArlXs0BJqOlxd4oTRvP2ckDejW
 H4dN558S5OQbzP8sYx3FOxMt6SKeD7/0HTq35pSx1y2KS632hYi0/pTpsMoRy0aNg2Hs
 b0zWNIxqEAaXez3M7IEYn3CZdezp4nB4eG9lK+tJmvc2/d/yJzDqdIDGrWbnx+chdUlF
 4CtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxM//7mXC26eYRcuXb7UgxmNo8IhjRRduMyxOicpOO13sJGG5i2YG3HyeZOgplExRA8uY8XL6M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lGNi4dMqXn5y007S7tqBUek4Xt7H/+O8tM3mOLdSqGhAtEmT6y
 Piw3IHL0ZnAQiucs7p/2gzu29YVS0VZiKZqy9kBBvcJ78Z0LtE1r7c3RS3fTpeKc1Kk=
X-Gm-Gg: AYBFou1nqe1Oco8LWNBNVdnLJo3sZTBJPT79NpJy6S+yRxwTYBOzPWER1H6Uf5Nyp4S
 uPKqlAy8MXpu4qzTawYFcZyIMX4S2X6mdvqiFmrY7Rg+7LNOqR8odA5YYzF3bwYstpY688P7rhG
 wfeM6jJuAC4PxylvfAHFMdxLYPsh5X+NDDyct4/5u4YPYNWqVFmREepC2QufVTIAI/JNDkhGitO
 a0NRh76O0dbfQ9aZ86fehfhoNpb2CtumroIc8WFu8b+2yJOUoCs1L1WFmirBrtQy4PqHh5P8H1y
 QA3dN/jPk1tWUQXBnkqNYBHMN7bXtapcSxSRngTZ1MLjE0zEEgz/mROwuOwTz6FbrWhXtxNpIn1
 qd7H/Mzh48L3v0MrzqGim4oG3lFcw0G2Zb9h0QXIClAfLvAOULLZ/RnOkvSZ7xQ+KPYlQ7pAEEo
 4yT7BH/OuChbH9qBntBdrMp2BP7sogUCKLTOWSGN/bN0xu20V4mQCqNM0p9C4tnaFr0x6GwkIrW
 q8PzgXznsYuOLnAdIQb6RSwTsDR0By2cbrzCwQDBsubZF66B219XyKNvWyu7ACe3Eq93mdoyU9q
 7+RBk2KPtKGdcnszEcp82JQ=
X-Received: by 2002:a05:600c:a11c:b0:4a0:eae0:769a with SMTP id
 5b1f17b1804b1-4a17b558d3fmr24516315e9.28.1791298920325; 
 Tue, 06 Oct 2026 08:02:00 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm357622075e9.4.2026.10.06.08.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:01:59 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 06 Oct 2026 17:01:48 +0200
Subject: [PATCH v4 4/5] doc: board: mediatek: document Genio download
 agents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ccaione-upstream-mt8390-da-v4-4-63d7d124780f@baylibre.com>
References: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
In-Reply-To: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.16.0
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

Download agents have different firmware and eMMC provisioning
requirements from normal storage boot. Document them so users can build
compatible images and understand which persistent eMMC settings each
agent changes.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 doc/board/mediatek/mt8188-genio-evk.rst | 135 ++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index e36e8faeb48..6c7cf02ec22 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -279,3 +279,138 @@ Genio Tools uses the default bootstrap from the image directory. Keep
 ``bootloaders_b`` unchanged until the new images have been tested. Add
 ``--dry-run`` to check the selected files and partitions without accessing the
 board.
+
+BootROM download agents
+-----------------------
+
+A download agent (DA) runs from RAM and exposes eMMC through USB fastboot for
+provisioning or recovery. The BootROM downloads ``da.bin`` into SRAM; the
+external DDR loader initializes DRAM and enters SPL using the same execution
+contract as normal boot. The DA itself is not installed in an eMMC partition.
+
+Prefer fastboot in U-Boot proper when the complete DA fits the platform's
+BootROM download limit. It provides U-Boot's shell and boot facilities in
+addition to flashing. The complete image must fit in the SRAM download area
+before the DDR loader can initialize DRAM. Fastboot in SPL offers a smaller
+executable payload for configurations where including BL31 and U-Boot proper
+would exceed that limit. Both variants run fastboot from DRAM.
+
+Two mutually exclusive modes are available:
+
+* ``CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT`` runs fastboot directly in
+  SPL. This keeps the provisioning agent small and independent of BL31,
+  OP-TEE and U-Boot proper. It needs the matching external DDR loader.
+* ``CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT`` uses SPL to load BL31 and
+  U-Boot from a FIT in RAM. U-Boot then runs ``fastboot usb 0``. This mode needs
+  a matching BL31 built without an OP-TEE dependency, and a DDR loader which
+  implements the additional FIT copy described below. It provides
+  U-Boot's shell and boot facilities for provisioning flows which need
+  more than the SPL agent's flash and erase commands.
+
+The two paths start USB fastboot at different stages::
+
+   Fastboot in SPL                   Fastboot in U-Boot proper
+   ---------------                  -------------------------
+   BootROM USB download             BootROM USB download
+   (host -> SRAM)                   (host -> SRAM)
+     |                                |
+     v                                v
+   DDR loader                       DDR loader
+     | Initialize DRAM                | Initialize DRAM
+     | Copy SPL to DRAM               | Copy SPL + FIT to DRAM
+     v                                v
+   SPL                              SPL
+     | USB fastboot <-> host           | Load BL31 + U-Boot from RAM
+     v                                v
+   eMMC provisioning                BL31
+                                      |
+                                      v
+                                    U-Boot proper
+                                      | USB fastboot <-> host
+                                      v
+                                    eMMC provisioning
+
+Build download agents separately from normal boot images; do not enable
+``CONFIG_MTK_GENIO_BOOT_IMAGES`` in a DA configuration.
+
+For Genio 700, build the SPL fastboot mode with::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ make O=build-da-spl mt8390_genio_700_evk_da_spl_defconfig
+   $ make O=build-da-spl BINMAN_INDIRS=/path/to/firmware
+
+For fastboot in U-Boot proper::
+
+   $ make O=build-da-uboot mt8390_genio_700_evk_da_uboot_defconfig
+   $ make O=build-da-uboot BL31=/path/to/da-bl31.bin \
+         BINMAN_INDIRS=/path/to/firmware
+
+Use the corresponding ``mt8370_genio_510_evk_da_spl_defconfig`` or
+``mt8370_genio_510_evk_da_uboot_defconfig`` for Genio 510. Each build produces
+``da.bin`` and ``da.map`` in its output directory. Use board- and mode-matched
+firmware inputs; do not set ``TEE`` for these builds.
+
+Image and loader contract
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The default ``da.bin`` layouts are shown below. Offsets are relative to the
+start of the image, and region sizes include padding::
+
+   Fastboot in SPL                     Fastboot in U-Boot proper
+
+   0x00000 +----------------------+   0x00000 +----------------------+
+           | DDR loader           |           | DDR loader           |
+           | 300 KiB              |           | 300 KiB              |
+   0x4b000 +----------------------+   0x4b000 +----------------------+
+           | SPL + USB fastboot   |           | SPL                  |
+           | 700 KiB              |           | 148 KiB              |
+           |                      |   0x70000 +----------------------+
+           |                      |           | FIT: BL31 + U-Boot   |
+           |                      |           | 572 KiB              |
+   0xfa000 +----------------------+   0xff000 +----------------------+
+
+Both DA modes use the shared ``mtk-genio-*-binman-u-boot.dtsi`` templates and
+``CONFIG_MTK_GENIO_IMAGE_CONTRACT`` settings. The image starts with the DDR
+loader padded to ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by SPL padded
+to ``CONFIG_SPL_MAX_SIZE``. The loader copies that SPL region to
+``CONFIG_SPL_TEXT_BASE`` before entering it. SPL fastboot reserves a 16 MiB
+heap, including space for the sparse writer's 8 MiB buffer.
+
+The full-U-Boot DA appends a FIT at ``CONFIG_MTK_GENIO_DA_FIT_OFFSET``, in a
+fixed region of ``CONFIG_MTK_GENIO_DA_FIT_MAX_SIZE`` bytes. The external
+loader must copy this complete region to ``CONFIG_SPL_LOAD_FIT_ADDRESS``
+before entering SPL. Its ``DA_FIT_OFFSET`` and ``DA_FIT_SIZE`` must match the
+U-Boot settings. The FIT container is directly parseable; only its BL31 and
+U-Boot payloads are gzip-compressed. SPL decompresses them to
+``CONFIG_MTK_GENIO_BL31_LOAD_ADDR`` and ``CONFIG_TEXT_BASE`` respectively,
+then enters BL31, which starts U-Boot.
+
+The default padded images are 1000 KiB for the SPL DA and 1020 KiB for the
+U-Boot DA. The latter fits the Genio 700 BootROM download area. Selecting SPL
+alone does not remove the fixed padding; a tighter download budget also
+requires smaller reserved regions, with matching changes to the DDR loader.
+
+These fixed regions are part of the external loader ABI. Changing the image
+sizes or addresses requires corresponding loader changes. Binman rejects
+payloads which exceed their reserved regions. The generated DA is a raw
+payload for the platform download tooling; it has no eMMC BootROM wrapper.
+Its FIT hashes do not authenticate it. Platforms requiring authenticated
+DAs must use their external signing and BootROM download tooling.
+
+Using the download agent
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Select the generated agent with ``genio-flash --bootstrap /path/to/da.bin``.
+``genio-flash`` reboots the board after flashing.
+
+For manual fastboot sessions, use ``fastboot reboot`` to start the installed
+boot chain. ``fastboot continue`` boots firmware from eMMC with the SPL DA,
+or returns to the command prompt with the U-Boot DA, without resetting.
+
+Use raw images for ``mmc0boot0`` and ``mmc0boot1``. Android sparse images are
+supported for GPT partitions and the eMMC user-area alias.
+
+Both agents prepare the eMMC boot partition and bus settings, so a newly
+flashed board can boot without additional host commands. They also
+permanently enable the hardware reset pin if its policy is still
+unconfigured.

-- 
2.56.0

