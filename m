Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAD6C61DC6
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 197C2406DA;
	Tue, 25 Aug 2026 22:51:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0CxvKeb_YhWo; Tue, 25 Aug 2026 22:51:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698236;
	bh=59JK/vPFenIlb94WtdH9o+RF0baQqO3Rr2EwqsrtkaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hy5DS7E4a/7PULnLDynd9gCVYMN/pirR99IDdehFXHs9GsLPuSO7zkiQGAg/wvWK6
	 vVi4XdgiOts8Ci/N+h2pf35GctsAUR57e+JYChivpZJntn4anefOx05cJ6Ba42ajBT
	 ol5VB8cqGYUkC3kn59mOexMCxU5YM5mKlKIUC4bJMQQyBYvYBmwblHcsReo0b/qa58
	 mOFodSZbJS0/jTE/nwVY43v82bwvvB4nbRI9OCTvu+KLi6gl5Mh0JO4i1HalbLC+SL
	 NPHjT5wNhtm4zbJLS1WzDYDvUh9Gh1Mpokiwq5ErTkc3iDedLRpyY08pvPE9Ep50YF
	 hDs9/OkkNowhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B0824076F;
	Tue, 25 Aug 2026 22:50:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EDD5B334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E01A180BF3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FTV_YbUe_Khw for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=kvHTGoTU
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp1.osuosl.org (Postfix) with ESMTPS id 87EA280BF0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697862; bh=59JK/vPFenIlb94WtdH9o+RF0baQqO3Rr2EwqsrtkaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=kvHTGoTUnOsFMbnpaPyikYpkzHzOdjEsx9qrtGYxiBM/gq/kZwwSN+8NGBI27t9P1cqQg1MMdDiIyfOMyIOH27RvFwhvTe9IkCdsQuaqrugCuMWnN7AY3Io1+Q5ikXtnVYK0MhlwhhOwm5AdmbiS52n1uBkd3eKLHxsgYYqP7RmajXUlG53C/vx0BlMIt2HLUadTLPNUSbvT4QovHHWWTQvJdq8YQjTEvaGzV7KNTkAc3rdKpEe+ymPH8O4pAq9E2VQcYvkisB4Vcd81JGwk6KFKvfoPMWmtCRQD0GRvTi3KqqK8Yqv9L07RWrEg/YJl5xPaWPuEh7NP9hId7veABQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697862; bh=aBp+TVEpR6FUbdCAk6zg6rNtr+Mk6qrhQn/btJO5tBr=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=V7vUZPp4eqw2encP76GqyPS11JszNucG/A7C6dd4uRBxIxRi6+rxva+vUEOxsTcBKI9Y1GfXjbcOlq7Fzn2+MV3fz0dN3RNhWvwYEsxRqjElMyGf63Yh4INr5TS9TegINQeInANFdyhs4ebzwaOr6+6EXtycX5FHuiWvVY0zt9QbKo31zSn9Mr/jzER8H3sNmCphwV2m+0526iOxMWS1nh+bbkMCI19tBmMb9rfbDlmmkKewZlrr6yLkf3oIx5EmcR9HFjI7/vFwWA5p40WnPgWUKATi6aDC6sWC5IfMH/z4AEn86NG/uNorUEBuhoSDhV9NmrkZQqh0DFYpB3Ey0Q==
X-YMail-OSG: 5Va7Sh4VM1mq0KLwAjAIa.9TGgYwNcWlxs5NsB4QHB9_Wc1_LQuhAjtSdEIhZ7S
 dFns2rgZ4u8fpK.MiihWrSNoKFv5e0AaWQeIBcUFcBH4yHgsxgTbNjMgDBQ9jawxFDRzm5x40mAg
 8tEgOCQYenTlxf2jaaafv.o0Zj6K1t7D3B2UGIybMNiUomFjddrcCZivsMEtdKqyBkUxduLUvY0M
 yLbieAUZvPjh4C3NxKLKcsV4VeV4o7IKM8JM4HTeFAJUwBQi2eoBHBfuQoZCt.NjVg5qnsPyVq5w
 ecmmrjXeysfgpHFq5NEe9x5n.iq2IUR700y80EdzpG3Ajt0uF70TlpD2qEtEhwytf4q3tlW7Azyw
 6ccRCC.HAVhCIYGleERwSu2goyBaiwpEfVnRpn9X7nEIRm5JaR2qi5yLQtv4vFmi9gyax7kv.lV5
 2VTOAdoliBmdpArVtsoTJxsYaabR1Y8InezOdH.M4Z16Jbj3scjAjzBcSgT06jzXUGET4_MpPHhv
 _cX4bm7M7EkGL1faOEKFtQG6c0_ChbXeRTvS1YuXtkH9Zg0KSkm.M1OBMU7JokImuhS77XUsrcYq
 in6G3wNTNm7dHeormCliRc6RfH7yOrX8IVLJtcHl0CMJ0Dq0OsYLDQ8LjQP.DnUv73d3VNzpFttQ
 ZTVIhbb5cWxycsn00SseJd_sXZclaRh8GP74VJ6YD3jMTJwLKrYoL_FB2CXXrp01aKjFt_BFd3iG
 asUeW6cYmtfN7bcSaf79WlR2gTYf3pb2n5Qz.NZ2ghW97rWi2HC00N8AMPAUIsIpX.72mVdbGP7I
 3hJkP1VgNSAUUU8G_XSIssE2xXz0CTX9Pvh5dIJceNDvK7DvL4XCp9sVVzQ5IoCoyLtlKJIhKiWS
 u5X.McwWXda_8stjamQfOnFhzItjqlyGmhB8weeODrMPvle.lmjmPLzxUBSqH41_a.BfRvM9jQRM
 c6c7vN5yTH3qAo3.WuGj78BYYvP8d7U7ftP0W9Cw0idfzeWWbhN4eGGGOsdixHbbfcWIxPk3V4Kg
 HHVsGDPq6W9Yr2OdcO0cqhWLkK5mRE1jWa7qIoMiod1gD3MDC1oHOF8bPesim1g10DaneR9LPMnZ
 KSS5hWbgwGP9M7STFeUIoLGg24Hqi2lJvWgMpdQSMi8czo44gIu4tjzRKTwrGrt4lSPXqKG3cgVp
 nhqwAeKXNRfjffoZh2XphYUHiVu_t76_8UIUAgAMAMhb9ds4WxafkmJ2Ja2cU7pQwKQ_RoD9b.pX
 Pei8Ig68SpjrX6XpbpOckrXUGgxk1MYx8I.qBI.RxnW4VWnj1MVCK4AHeKj6y2g0KTyEiC4qJLUG
 1vGDzTOfmHZkCA7t.QvNnqZh_Z5YmqBULXfb5x7efE7XzgsGObzOigs7sjv4lsfy13_pskVarLF.
 ngI943pTVVkQanE2vxOMoK3ekTIiYCbKUko7bfFgfEMqpGg6663G2wKuZJXbui6d6qJQDeuHrMK4
 Q5R.psqqg_37Vtpo4al8zdjKeQGIDk4NQO5RdyastLcAPajnZuFcQB2LVmkO_fXGRrtHKaHOrh5b
 IwNhLubPUnqGt3YE65x8bBitJGEz8tsn5Dh4k7EA3b4b3iEdFRRVffd2fvHJMw6ICe.tVPPZvbHS
 R8Oc4NNXQWSw2jfZOIvfr1_0EEb5mU1Ey_RW3PtzxboucyEo4CrELXDFBgFKcHmosWF_NYel759f
 oKWB8A_ZMm3TiTZgbFQS44FFh7GmRNHPtB1ttxHyqDR27BaI29Y89cWR1q639DQftyAnGFr9Laqu
 06lmV7TxGjoTk0ngMzvEEIVridU1VjXfw.AAROOVP6j6j911e6OT216RwmvVp4kzHA85HvcYitfj
 M1QB71f2bIvRkqYWIVCViaBpBVVRzTpcdej5epBCLcbJUDHshL7XzCmybCB0QfmC8U8DRC6xcQ0h
 1ZMXJNmAdGWUcxjHPpb9GB2K3EHyvLhKl9BwPaVYlHAGIXt2LIdTmbr5RNXcsDEtth.Idii797cO
 Ld6tW4deHRhM13JMUgAFBh48BWhbWaksEx.znlE_OE9WpUfYOFgrY3sQJTizh.i33dSaZ5icfUMp
 6cSc-
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 259c5be7-a97e-4824-8170-584f1e342fb5
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 25 Aug 2026 22:44:22 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:44:19 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 12/12] doc: board: econet: add EN75xx documentation
Date: Wed, 26 Aug 2026 04:12:07 +0530
Message-ID: <20260825224330.713151-13-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
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

Add the EcoNet vendor index and the EN7528 porting notes.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 doc/board/econet/en7528.rst | 39 +++++++++++++++++++++++++++++++++++++
 doc/board/econet/index.rst  | 10 ++++++++++
 doc/board/index.rst         |  1 +
 3 files changed, 50 insertions(+)
 create mode 100644 doc/board/econet/en7528.rst
 create mode 100644 doc/board/econet/index.rst

diff --git a/doc/board/econet/en7528.rst b/doc/board/econet/en7528.rst
new file mode 100644
index 00000000..fc4eaf2e
--- /dev/null
+++ b/doc/board/econet/en7528.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+EN7528 reference board
+======================
+
+This target provides the U-Boot port for the MIPS-based EcoNet/Airoha
+EN7528 SoC (MIPS 1004Kc, little-endian), used in many GPON/XPON ONT home
+gateways. It replaces the proprietary multi-stage TCBoot flow with the
+U-Boot TPL, SPL and U-Boot proper stages.
+
+Boot flow
+---------
+
+The boot ROM starts the TPL from the uncached flash window at
+``0xbfc00000``. The TPL enables the Front-End SRAM, initializes the serial
+port and reads the DDR calibration image and SPL through the early SFC
+reader. After DDR initialization, SPL loads ``u-boot.img`` into DRAM.
+
+Build
+-----
+
+.. code-block:: bash
+
+    make en7528_reference_defconfig
+    make CROSS_COMPILE=mipsel-linux-
+
+Defconfigs
+----------
+
+- ``en7528_reference_defconfig`` - reference board (DASAN H660GM-A)
+- ``en7528_ram_defconfig`` - RAM / chainloaded build
+- ``en7528_jcow414_r3hook_defconfig`` - JioFiber JCOW414 R3-hook variant
+
+DDR calibration blob
+--------------------
+
+The TPL loads a vendor DDR calibration stage from flash; it is not part of
+the U-Boot source. See ``arch/mips/mach-en75xx/README.ddr-blob`` for how to
+extract it from the vendor bootloader and where to flash it.
diff --git a/doc/board/econet/index.rst b/doc/board/econet/index.rst
new file mode 100644
index 00000000..d691db07
--- /dev/null
+++ b/doc/board/econet/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+EcoNet/Airoha
+=============
+
+.. toctree::
+   :maxdepth: 2
+
+   en7512
+   en7528
diff --git a/doc/board/index.rst b/doc/board/index.rst
index fcb4224b..60d75003 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -29,6 +29,7 @@ Board-specific doc
    coreboot/index
    emcraft/index
    emulation/index
+   econet/index
    gateworks/index
    google/index
    highbank/index
-- 
2.53.0

