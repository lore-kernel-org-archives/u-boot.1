Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF01CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE16F607BC;
	Tue, 29 Sep 2026 12:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OzhUB_E3CHAg; Tue, 29 Sep 2026 12:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 841B9607B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685395;
	b=TkCWqQdGADtsnu1CQ6wVRZSkd0vKNavavziKF9HpDATL86FTy1nCAdw8wO9bQeq1pFkj
	 6+R1+TG8jMlC6dp6eXzjBSFPAkKY86GnChhtWxYoyElzmkqHHPmYbwRjuNjcr5JbzzBEZ
	 AWqcdu009qBgJL0czoYcIPR9i+6apIILv4e2XX6NBUcGSd5TEKFsqh8RXKaP6mqFGiv61
	 5XjAG/PwoIybzHeEmb9T/NrLX+Nns2H73iELaBE5bth41Xj9rGxqR2criwtRa9ClnsrvB
	 StVcqd1+y2tnvGFO2mY/vYNO35l9YxZmh9e1AGSCOkc/WIUbgZo8UMEy+ejnrz4YlQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4OWkAfpoYCalKuY9+6MQoduJ8do1SVh3L376+EGfTaY=;
	b=VVc1OraITOgMZBMNJDShVAD6XzTS0BG4imsWJXXuGWoH2wfQ457+9AVk58k02ZNuyk9h
	 FbOZPcc4S+YbVE/Cy0v/pAXgvBMoEg/GnvTc9qF+hRVsAmdl/xsb4a7JEJ4+q8L7u3rJa
	 HgN75gyWCZTrRzg40dQ20beROsgx1Dk8ZaJt9DZfKJ2TYnJ0AhGaDR92ugxbTbNgHEqzp
	 auI9EMq8niTGRBVNta7cdEKibH4i8tkr66fZrvTpIiX8cxCPKV6fkO3oNDcszweT37s5y
	 +yVJT96gwtvGZ3tyC23TPAOemEEGdhOErGQ142cMRlI/N8v4MOm5OYezvwCROOySk3w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685395;
	bh=4OWkAfpoYCalKuY9+6MQoduJ8do1SVh3L376+EGfTaY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I3G12yROqh1chjdpz3K1UOvCu4BsrYdWDU62k78RqLwmooQmWI2JUelLbEymMd3Yv
	 2V/LEjkNrl7mZjzZNrxnxB9W4vo43LqPRZ3VBCWSIHYsu5OKsmqZGts+BowbzYt21k
	 hgsriPqmmUxk+WmvVv3TOMDExMCw6eIkxp/6Nm1io+GxHi7QqR0p6KZg19bGq9PXv1
	 CVGPGEh50rBKYHRf7uF2w1uu3XMKRADzZnF3upMxO3wRb/HrlMPmd9c4H5MmRg73kv
	 4TjmfXkFK6wfObcuec1dnsRQU29HlVUk0ABCuw1xp8UBlsZaPBKfqu4X3eLxypeY2Q
	 yb0hi3RXVDnKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 841B9607B0;
	Tue, 29 Sep 2026 12:36:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87486335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78F5140703
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 220jr_QrNTVR for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A3527406E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685391;
 b=L4QKhZkjFMOetPOqK0apPlLDY2WbEgnGBEe2rJ0+IKTHn8SI5VMvfT3d7nkNkMDr7IPo
 OYmTrgz6AOmQdqsJ8huRLkjCFsXkOrydq7F/5YNVh9UxpUKg0FPdB4qf8aHWaGrBZYB58
 zNUQX849nKJ/73la1EuV25MW4qucAwhBDrQ0iv9DmspFqAH2PsIVkk6j718D3wCOvEXqj
 KqyUMMcMwvbMWhDhAzrxOboV70lbSzPxP3LTMEabLzDpY66UAaqAf3dlDqI86Pe+wpy2J
 BreP/ce726sXGETGtnnSG+NfiUcOLp9oKXhcwc9lB2lxZw/Rey9v0UAds+TMdPxRnKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685391;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=4OWkAfpoYCalKuY9+6MQoduJ8do1SVh3L376+EGfTaY=;
 b=EdGwOmFUsrepufMvrsQvexm6t3zc9INK4t7l+5qaPEm7ht6kpASgncG4JpJHGgze5kYJ
 YEbu+TiILe5YbV136GsIRmOzmU94aVjVgsXBLnTQUFGKtenhk6gTPsFx7Bv0nrxTb3GO1
 MSS8Od/PR2VLEHoDZV+zqHv5zPlsbKQH7e7vPyXiJgrR1ahj2N5sMA1JYw2ujeY6AYC0+
 6VYBc61Bo0lvG/00Hmqdx9jMuOkbCaE3n1s1cOXjABTAggHbH9mi5so0LjSW9TAWGY+aq
 FELmBoWcv/84FSlQJ0Uy1DvbfGZeUaNaCYFAhc+rljOCxi3jRTAmvW+mhmZJx2MjkFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="L/3Iw5/n"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=L/3Iw5/n
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3527406E4
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:29 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso2735605e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685388; x=1791290188;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4OWkAfpoYCalKuY9+6MQoduJ8do1SVh3L376+EGfTaY=;
 b=L/3Iw5/nXeKqoDHxZBs4aLk2ZXtgpGPMCdxKis/QS/AuC1uHHmVRajogfp3EXKKs18
 oi1UtvA1gLnYXR2NG2bcAZbsqhwhH0SEsMBPRzJjfXvyqOakX+SqCmD0Xro5qazjwSlP
 1aSXBY8RKFE8Y8bQEZMYNFFlUiXDKyLbgjblDXW7XoKz4T1ljJVRS4sOD0+19p9MRKn+
 vFc+T3t/JyUhGgFiqSKLLGkqOBej/0JiC1c3bYb1HOsSKbkVqOXuxAXDLUVmYtHbjqZW
 d2Ei2xe2xfgdhCXXeIcopmIOuumwdhkMJ/0JqYdAff/exEmirngf1lvCrvdZQZLOlnbZ
 E59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685388; x=1791290188;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4OWkAfpoYCalKuY9+6MQoduJ8do1SVh3L376+EGfTaY=;
 b=MpVy00LXrJWn1iri4rkAWJnGaMZ+Rk1GktrdvJ3WPeKZrxgPF//a1Xty8/AQ1eFk/x
 dj2kYvMewI3O7R7BCWfqU7m/J7DOwWFwcsjwvBQXBw2ODQ9hrlilpksnsa+jEjQgSXWv
 FS+sQro14TeiMK4YS7qk0UGbOUvZfQNmTZXSkQykzLZc22LUNYZjfO49FrEBDEvFLndA
 BEoafrFQvr/FZC84y5F/KZc2Q6I5+LYOhGavoPzSPaI4YujvSsl6sNBk6Yej4KIl7lDs
 pyUJlbNAkXaBiJcG+Vg2FWpwegXCil9h0IX6epLQxmC+A1r7vruO0NrzOrDQY0Oxk/0L
 cUHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDBMb0v2x1LKBlBs/MqTsNo4YElvGXn/ystJaQ/Wa4wBln1nu3gMBCtygQJUNyZ2a7mS/aQvQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m91UXTVBrFAHw7eWfslBDU+sCRSC5FMMeeVZqg+cVJcrtIjuHA
 pcgptl75DlP9ClsPc8PbityNyzmB2g3rtVTduZVqlTfKcXTulD2fsvZlWxXl4JeDqrw=
X-Gm-Gg: AYBFou3812vmGb0E64S0xncXt1zvsfjPOlwdquay3s+MCNfTDeXKaIq9ICIF/wt/Udu
 pkGfFDQI3W2UiqDuoP4BSOBsfLy6VdltxYQzkDjbaVOemJxiIOLXGuvpfvlhcuKcXf1XjW2YEZK
 d/ogn6nT2+/qeSuEAtgm2jlkdBskPcgtOeb9WyWH2xoGSSM2B6wmuEOmF9k4x2FaUf+rqgFmQx0
 R1PYkZ+5tc4ks6IXkm/ylbCtsyPR0uFGz3tWbgoqvfZ4mKxAt1uDIfhMIDgluNGPMpSYF56Ghtw
 hgLtakQLHbdU/jiTO7PIOi9xE2gaA6Jc0MbD+TCd1r/Wdki6ubRaM3rVMuC6dlSxJBEhpudxNnR
 cbz6vN7dFqtThUGl3XRdFfe+6jCGTF3C5hVIjv7KdjlC2xPueswsF/mvyFb0cwPwQAKL3koypTi
 akRY9y5fu498m0BViNE6jTH3vgpGWBQ7efH8E3Q9kIXovQEfHHGUQgqzgFE/B4jrBsfF9aK+lpC
 LJd378V2/RruSZsVwBfZyRggDf5zXF9tT68imxVQdABeXzx61/Yu/42QxS6gkAPkaLgLc7EyUfx
 bnuDr20csVIfeG5y8AmC1X2hdP8f1ftxEpTnlHxBrmVI4IDJZQItzhU=
X-Received: by 2002:a05:600c:3548:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a00d76700emr39272735e9.5.1790685387657; 
 Tue, 29 Sep 2026 05:36:27 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:27 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 00/11] clk: mediatek: code cleanup
Date: Tue, 29 Sep 2026 14:38:38 +0200
Message-Id: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0JmbQ00DYIr72FYtNNBRn7TApGQ3
 t2CB3D5kve9bwdPjsnDPdnB0cqexyGCvCSAjR5eJNhGBpnKPC2zm8CuFT1Z1jO1EUgPy+QFGWs
 kalQqNxC3k6OaP2f3Wf3YL+ZNOB+xw2jYz6PbzuM1O7x/H2smUqEsYl2QLYsaH0ZvHRtHVxx7q
 EIIX5OXsbjPAAAA
X-Change-ID: 20260917-clk-mediatek-cleanups-ebdb2cac446b
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.15.2
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

This series adds more code cleanup in the MediaTek clocks drivers.

- add missing static identifier to MT8188 clock tree before refactoring
  them using GATE_CLK_TREE (see below)

- MT8189 already defines GATE_CLK_TREE to factor the boilerplate
  needed to define a mtk_clk_tree. Move the macro to clk-mtk.h so it
  can be shared by other drivers, turning 150 lines of open-coded
  clock trees into 26.

- As a leftover from the previous cleanup, some drivers still register
  separate drivers for clk_topckgen and the other clock gates. Merge
  these into a single driver where applicable.

The series deliberately only touches the MT8xxx drivers: they are the
ones the Genio boards are based on, so they are the ones we can
actually test. The MT76xx/MT79xx drivers show the same patterns
(open-coded clock trees, separate topckgen and clock gate drivers),
but as we have no way to test them here, they are left for a
follow-up.

Build tested with the command:

❯ ./tools/buildman/buildman -o /tmp/b -b b4/clk-mediatek-cleanups -CveW --boards mt8183_pumpkin,mt8370_genio_510_evk,mt8390_genio_700_evk,mt8371_genio_520_evk,mt8391_genio_720_evk,mt8395_genio_1200_evk,mt8365_evk,mt8366_genio_360_evk,mt8512_bm1_emmc,mt8516_pumpkin,mt8518_ap1_emmc
Building 13 commits for 11 boards (11 threads, 2 jobs per thread)
  143    0    0 /143
Completed: 143 total built

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- reoder MTK_GATE_CLK_TREE arguments
- mt8189: move MTK_GATE_CLK_TREE in the first patch instead of the
  second one
- Link to v1: https://patch.msgid.link/20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com

To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: "irving.ch.lin" <irving-ch.lin@mediatek.com>

---
Julien Stephan (11):
      clk: mediatek: mt8188: make the clock trees static
      clk: mediatek: add a helper to declare gate-only clock trees
      clk: mediatek: use MTK_GATE_CLK_TREE() for the gate-only clock trees
      clk: mediatek: mt8183: merge the clock drivers into a single driver
      clk: mediatek: mt8188: merge the clock drivers into a single driver
      clk: mediatek: mt8189: merge the clock drivers into a single driver
      clk: mediatek: mt8195: merge the clock drivers into a single driver
      clk: mediatek: mt8365: merge the clock drivers into a single driver
      clk: mediatek: mt8512: merge the clock drivers into a single driver
      clk: mediatek: mt8516: merge the clock drivers into a single driver
      clk: mediatek: mt8518: merge the clock drivers into a single driver

 drivers/clk/mediatek/clk-mt8183.c | 29 +++-----------
 drivers/clk/mediatek/clk-mt8188.c | 81 ++++++--------------------------------
 drivers/clk/mediatek/clk-mt8189.c | 82 +++++++++++++++++++--------------------
 drivers/clk/mediatek/clk-mt8195.c | 29 +++-----------
 drivers/clk/mediatek/clk-mt8365.c | 29 +++-----------
 drivers/clk/mediatek/clk-mt8366.c | 64 +++++-------------------------
 drivers/clk/mediatek/clk-mt8512.c | 38 ++++--------------
 drivers/clk/mediatek/clk-mt8516.c | 31 +++------------
 drivers/clk/mediatek/clk-mt8518.c | 31 +++------------
 drivers/clk/mediatek/clk-mtk.h    | 22 +++++++++++
 10 files changed, 117 insertions(+), 319 deletions(-)
---
base-commit: 58badc5b2d377ded320c24f8d000ea3423405ace
change-id: 20260917-clk-mediatek-cleanups-ebdb2cac446b

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

