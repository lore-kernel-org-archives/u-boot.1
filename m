Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165E0CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 804F080F1B;
	Mon, 28 Sep 2026 13:42:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fsxAJdOd2DkI; Mon, 28 Sep 2026 13:42:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C4E7780EF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602949;
	b=nRIcMURToG44g+OTgLRw61jNh+cNm0Gf59aB+Gf4YlnteTlyEWJnn4k9RSJuRNnZ4TUJ
	 bFpmzNPvNYL2uKTCXG9UfZRqcWzQ8EA1FFlWJ24A9yeALiqIdjy/Q+c6Dv6qSnL53Ose6
	 vSBND2D8qUEtZ9XbeSmY0xZlkoth69RgTne+Mf/yUpgGZT7EBkVLzNHeY4I9afPUD4iqC
	 ionLAzm9GZ+WHODjSdq7SDQFRYTbvRXtIIrL84hIG5OcJQNK8Y/O5kQF5Okm+C8m5vlj/
	 fVr+knFCcAGkkjn6REuVKJHKh6lTFtRyMRIPN7r8XiDtdwdwJRy4ryiD+Ze+aiNAl6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IrVg3chAm63mK5BlfjgHTYURgCgwVbs9nE3PiAAPvbw=;
	b=ZVD/D3tpdFOA60zkS0sgPFtDYAr1k0MRDv19Zm+OSZLM6yH71pZaylui3v91lOnrP+fY
	 o5jge5K1d92XR/cKN02akGdXPioXR0ryUIu5ht3mSgnSfE/QqMDWeS6Agb0scVslXJkuH
	 LKuhhAeRmT6og6Z/MzGwYIpRij2/mn9ugcbGQLEyqvkZJy/ZefAnUMpM+rvMC4YH98G3s
	 lXJUdCoHX8Jj9If58uSVwn82EQs8PLEdUhha48l8NFKtpbS64MWOh69/ehYzqf2Mx7BEM
	 +eVjgsGeqT0zxOXdibUbPdkpPegv/LZYWiWxALuB6KIJYbnMGWp3GJocHe4742DV5XQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602948;
	bh=IrVg3chAm63mK5BlfjgHTYURgCgwVbs9nE3PiAAPvbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I1gWZwW85W5Ve8V/iycE1+6BaYxBgyiVA6Z0iQOUPGysMGkOVs2YXfW384BaseMRi
	 mkZLecyb701mx7YbkskYCbPLQqHgbC+ZXMshCsrCZ/kwOJb9WzpLu/fe34VuGVvzp5
	 mXFyPuqWY5Ijz/noOHZAQg3E8GxVbUM8QvyO1fng/7OGomFyfZAPGOLsvodYuBkV7+
	 leLreQVLgqSKAj5OXphShPCGNXAxR5qqLcRNo9okW8m98p8m6lLvrulKZ+ej8zDi0o
	 w0yadkcTKamTqCzA8S57gnM3h6VynVn5+lGJyfHXVuD8T46fmu2QLbsMqWlwD17BUX
	 5Yd7eZSlRa/7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4E7780EF4;
	Mon, 28 Sep 2026 13:42:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 159863D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF4A160601
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gDXpvtEK_wR for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1A408605E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593514;
 b=kKuCl3l7NorTs+p1PcUCi4ZzvNoggD2EnJyApfAI+eQelECImby7egBmiZHUXWQ0Di/W
 p9vawzHGnnduBnlm1XoyO+LKyxhW2fMOx1dbR/tPhp6IMp5N81j7JC4kBCvjsmbJL74As
 GRRRH0pm3XYdPvwgXqurMbsivh+LCMOiqTbhZnljXwDRFcf5kkgeGYR1mZu9yjrly4aNH
 lCq23DiLfjYRO4CfVNa1m1Vgb1GlFCtCFPjF6Hv6U5yaMpafGKRccHuO9FTX0bbrlgKTG
 E08pD7zAm1/nM1wPAClFRYiZYwNq3i0JEmGw+WtJja57JiW7BLu+M0X2i260db+ufQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593514;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=IrVg3chAm63mK5BlfjgHTYURgCgwVbs9nE3PiAAPvbw=;
 b=j1Gxzkv2GGqEzJRcFz9liAPYc94FpLWP8uZ8FEcLVSXSqB7JDkLFW4+PodzBhBzOlHQ8
 IN3RthaniOOWG4GTnDvAVEIIXwMvBsUXB1bMG5IPggh1gQNRt8QliK2dlfb0iK1OksHxX
 uGW3VICHJP499YdQj6zYrcJkTljels5pDxC9onXSXwGrL83W1Q0F+YLixriWT9MuTMRv3
 0KazXCMx47jYCT0CEdo8GNFdUSz6essz1l7JKsf9BzSrlnnrDquY5yX8PGBE/KqHsk3sn
 LYDrVeS980+7vMF567HvQGZry2G10fods800XTsSM04TGWz/pDBY8Vg2LZiPch8x0jg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YBR5oMG0; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YBR5oMG0
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A408605E4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:13 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso7805505e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593511; x=1791198311;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IrVg3chAm63mK5BlfjgHTYURgCgwVbs9nE3PiAAPvbw=;
 b=YBR5oMG0J/ZaQIaxZm0BPQgteTH+eYT6CLmq385OEfdl+HttXENvx6Uh5MWAMXKa7W
 wNE7ddgqT3nJCb3BQVBUq9+Hvxr7tCoJHtErpYxxi9+hdQ7QnAMOBEKMeMqeYT4rRsSH
 sH4BnFSM/3zycPuv9apeFQ5vLd4DBHyAnOpgJ8GETXQa/biM4UKlZn44ebIDco3spDQh
 LFmIIrSR1lv91leUz/eFxtmklqH6QH1sO90fxuvo7xmh7BQOlZ/oVVKe/DCjrtsTfLRu
 uC1xmsftHVmppyeBPZQ0CjfTyk2mOANvPpEQ9CpAtaPlo1EP/RPHD9WZVeQEbHZrTdBJ
 y8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593511; x=1791198311;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IrVg3chAm63mK5BlfjgHTYURgCgwVbs9nE3PiAAPvbw=;
 b=vbnOsLaIL4yzAAklnbUtPfMBT847b3vts9h8rNrXvu8qrR33BveY5SPgZFX8GxCHM/
 aT6FogwpNK9fQivMAKSUuy7Cari8dnkAVcbKIRCYJZYD1AfjUWqmNtO8BVLbKHxgxVWl
 KrzqYwvI5dR1PY9ipy5CkFMJRZrrvRSU60LZOHhvFlF1ZLLop9E6g6SnGZfXOwGciQp8
 BGVLyU1Ye9hqfUP92NRFC/K3HSeq1WR8gvvnxkSDs0e4vDhkELmYS7bGnnThOZxvVzZl
 EQhjGNr5Wq5WoXbNo21oqPRY+XPYdRTqd1sUIH/sDjupvZ8rRfwLOZtBRtSSHIAOJPxN
 RRkA==
X-Gm-Message-State: AFuF++lDZ7zSOxqAeqLkXEzzf7Ru8d/QMbmlyQ4fwRC9jpCaOWtXb8r+
 h//vleTF5FE3uJgxUTIg9LGN/+eXbgyBPmFqlaCODbw73zCMQ9OBNEr8EZhDLTlucxg=
X-Gm-Gg: AYBFou1WK6VxxgGpNAWFTkAV/QHfYhIfsXETegwA2fDEsKupjgjNHmLdfOxSpJiFzG6
 tdL6atYnELKXlBTYvbfFXPTvRdXHs8t/E697C2nC3d29EKLQrweGvwWhEsUZX7vd2g0wu5oP8ry
 d8qeDSV3gw3dGv9LgRAUMuhF3Ul8MxOsXfRwd4i6gQWSjcjdLqtWYX4/j9D1wtx0depqe0oohjb
 JYKdrpcyxhDar563k6Z04UGM1IsdhLSZksuspfJY32BJQVUf8zSGbyRB7OvxudTMD7z3TL84o2n
 GsdShok6+PxszR319s2djjvp+EGrlb1ZziypS4fBTY9z0lAprsEic+ZuCANpagO3rfCwmzkDGNk
 v1DkC+6eT1JZpsnt6Wy9PPrKOF3kcfhma8SFtCngQt0W5AyfEDAlkFda+9wQK9Y0q2ZRUA7uiwd
 qWxi047peXfyi17Aw4/OcN/W15w04fM/oZI/9FTLPc4KosyoB4Syef+lxybExOKwi9Mrf624dfd
 C02qcCUOCkuuItkwH+tfOrSLnCWwdJPV7yKFP+5/mXipA9gft76u3xNCRRbLo0hMJldvJbFiXKV
 H3ULdpk+lRatd21kaKsWo7O7jL0HucLo9IHEq1Dz
X-Received: by 2002:a05:600c:3547:b0:49e:6692:27fd with SMTP id
 5b1f17b1804b1-49fe66c8a33mr209939275e9.2.1790593511430; 
 Mon, 28 Sep 2026 04:05:11 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.05.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:05:10 -0700 (PDT)
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
Subject: [PATCH next 07/13] powerpc: mpc85xx: Allow LTO
Date: Mon, 28 Sep 2026 13:04:28 +0200
Message-ID: <20260928110434.70686-8-pepe.schlehofer@gmail.com>
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

Select ARCH_SUPPORTS_LTO from MPC85xx, so that boards can set
CONFIG_LTO=y, and name mpc85xx next to ARM in doc/build/gcc.rst. This
does not turn LTO on for any board by itself.

Only mpc85xx is covered: it is the PowerPC family whose linker scripts
discard the LTO keep-syms sections, and the one that was built and
booted with LTO.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
---
 arch/powerpc/Kconfig | 1 +
 doc/build/gcc.rst    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f20d58b4de6..70ba76e530d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -17,6 +17,7 @@ config MPC83xx
 
 config MPC85xx
 	bool "MPC85xx"
+	select ARCH_SUPPORTS_LTO
 	select CREATE_ARCH_SYMLINK
 	select SYS_FSL_DDR
 	select SYS_FSL_DDR_BE
diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index 1fef718ceec..48d22a3c8d4 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -193,9 +193,9 @@ Link-time optimisation (LTO)
 U-Boot supports link-time optimisation which can reduce the size of the final
 U-Boot binaries, particularly with SPL.
 
-At present this can be enabled by ARM boards by adding `CONFIG_LTO=y` into the
-defconfig file. Other architectures are not supported. LTO is enabled by default
-for sandbox.
+At present this can be enabled by ARM boards and by PowerPC mpc85xx boards by
+adding `CONFIG_LTO=y` into the defconfig file. Other architectures are not
+supported. LTO is enabled by default for sandbox.
 
 This does incur a link-time penalty of several seconds. For faster incremental
 builds during development, you can disable it by setting `NO_LTO` to `1`.
-- 
2.54.0 (Apple Git-157)

