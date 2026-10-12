Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20AECA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A4AA60710;
	Mon, 12 Oct 2026 21:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CNKl895rwPP; Mon, 12 Oct 2026 21:32:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7CEBF605E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791840761;
	b=JruM8LqmTNIGp5vxDWztjWgDfoBJyXaWdl/KeN2P4zT8EmzCUgCaZ07nm36epSbmK+Ho
	 Br5wYrLO11DztlEU+UgfFptgmiWaiFOd2R/J6jNH4ZxnjyQ58YH181+/s01Bd8kG7RkLQ
	 m38kqFhhMSzAbL5ZW5X0RMmxOr0o9dnQFwJX0j+9f+O3Dexu5LE0guq+hTvB6UrQDsJjo
	 infmj8oSpkcHPcJtQhAzCdlYkUEoCWdP64rk1+4yn3Fu7pt8Sw5na5ubIUz6cDNLZASyj
	 JvdqWjnq3TlP0mdj9h5XeUx57QQru4fgdkLCOFD1715m2SejZSUxnGrt2ECV/mB0Lzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791840761;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1gB+5gckfZ3ACegZIFPL7s9I+0g4pNjGIKHM8hoIwfA=;
	b=NbZTHxwGvTUb9TGvB1LEBUaVkU4mfL+oaIgROlikcedFaIwmpfh+pDVVWv//fhu1Df/b
	 f2du3LkU44kMyVlId9oYZjpLhRCszDLNthQTygzNueo3NlY5fPnrChiNM6X/LD1Y93EoV
	 kROSZ+O+RSVeqEQM1A87bTk6mAhFfQkCQMs8Sy6hp0x6H4re8XNZpFidH9YqzIAoRziaE
	 IjCVQ+3vTKuhTRbmPmbjJhcIeQ4WhWUMCh7eT4eX1rH4LdPVVNdknOXLnOTRiGNkHC3To
	 NprkWejoepgypgUITbOkySghz1VeFIyw7hA5x7QqxSAwRLDMRQD2z2A85iZxvK2EMlw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791840761;
	bh=1gB+5gckfZ3ACegZIFPL7s9I+0g4pNjGIKHM8hoIwfA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qIcuoEOTlQxahoMsfWliadGJiRV7AJNvxLz05+InVquqjUNoFXnTW/PX5KvZxnNst
	 jZe6J8zOcR4mICFbnV+60vMSTxjIm9olFnnLr8K53sTezmECqAp0VxqEJWy7YeZhSW
	 5ijoJcClbM8oZrINtcMlxMkn1HW7zZaBzDfu3zpniw0P9GIQISqYbE7N9wzTE4MK19
	 mU2Yfz5Xv91uaA5bujQQ1DkZakdoPvkNVyr9/a8KQ7rOpuN66IS+EwS0MBiraX3g8N
	 lYhqJ6ZOJyhFn81iRMQUTSMz0x/EQEOzEhEYUlxy4NHfy0hMIsx8E9RG4wS1art/XY
	 kld3iwdnPx0Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CEBF605E4;
	Mon, 12 Oct 2026 21:32:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C21E32A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8ACA404F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HlYvvDyx62-u for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:32:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 614B340435
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791840759;
 b=Yr7l/jEIhOWGpWLrMVuzX4ksTNgnl61Kcx5xt+TuiFlhuAFuMe6RlgnzLEXTdChTLkYR
 AAsqgipaQkwwtnkIP6h55WRMdalvWPtdzPgpTmX+9spTMfDHOs0LdlWiQcLFAigXFnUja
 X7Tebm/89cwJ1NiXJTeJIaSm9xx/ikX2yWLp4IqiPAPjmrWdI30ERcuBfnKyvugKg+VAX
 o30ByxpgXv8lRbACJMRCo9UZCiF+8Zd/IeUMYXGESFReSnROX0FzFcn/TrXwyQjppO/cf
 HH4aH/8XBIpmTmllJ7JantA4MfVpQVHovsqo2+tNc0Mrft1CY2H9ocPDc+Mk7i7BvOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791840759;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=1gB+5gckfZ3ACegZIFPL7s9I+0g4pNjGIKHM8hoIwfA=;
 b=e/qnnhgGT4QA1G/2CWA5DGXQq4+/zmu521ig/HQS/ObsfGV55WCEzntwE7OFc/moWXuU
 qGbjDDtp8oRlf3NoTJVjx0COrTETR3HGhA2punCcq8KK5LKkpwytzTCall5S771R86d5b
 U8NxeB9Kr3WODoK2YpGHU0N1qFtaXBXFsUfEeigevVjnLNbMEL0lpm2p7ykJBLtJR6f3U
 ZScqOdsABziwanry/FRU8/UF570fD9CjuijTwbkOvosAg8aajLEb/Ek11so8Swk5ZiASx
 n3HttzQa7ll4T5nVFgXYC0Ir72yBdM8yjf48FIyn5zswvPjC2UKuq45TjpttMF6srHQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YQ3cw26y; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YQ3cw26y
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 614B340435
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:32:38 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-82374c2d7aeso1833100a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791840758; x=1792445558;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1gB+5gckfZ3ACegZIFPL7s9I+0g4pNjGIKHM8hoIwfA=;
 b=YQ3cw26yhXiv8/Su3KaoBfgOWZwVyC6AtvhKb9y61PNIOOL/CBcmaB4RTL8J8mOrhN
 KG/FylUv+LPuSUbMYaXVod/DHnDvXD/x8F86F7dX5rTD5/f+fGJkxQZR0FobdvzgxWwc
 zmm1mNPL0CWfs9FhEp1HTrT14EJkSTLY+RKPiaHd0uILzv16GPpkfXLjaJBSmsFw0KYQ
 7hUFI/MHZ8EaixThHEhh8rz45gOghdMEmvgfwX25Hx2xHwsiLCW9gsmZ5m32IoiR6uTR
 6BFkzDJuD0KaJ8oqASqmHrjOUawEAt8DJdwOWDskJ0ViKW25CWi++LCqxt7fBAEzD5Pt
 M8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791840758; x=1792445558;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1gB+5gckfZ3ACegZIFPL7s9I+0g4pNjGIKHM8hoIwfA=;
 b=Fw0Sa4NKXOW/B+HeAbrU0DYu+KxOxwadPXsKhesafNKD8tv0o6eNwHqGaP5HoM7/Zg
 fl8kxvMMq1L9QszX31Nn3z2k7FXGHIOz9X5U6O5ruUs1sV1s3YlX39F9hY9uAPsNGvZM
 8AGKEaV2tZiy6uIBrM6z3XcB2glGBqbQhAPldh80zVo6OBmCW4KHNdT8cAaYVeon6mY6
 7zMGUkXp6jwkTf6lq9vAO3jW8p4sqPggwwhAxkV25DEWMCiWtUYvU+8kVwkGYHaLgUiw
 UmP7LIt5AIDakfuroobJDvPWxBBVJ8XCsU7H3lcRaztPLvnfRoc98tXvDn9YZp8yb+TF
 WdHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLC1qcz1Io8YylXn1XB0CNrFS+PZYltyhtwZ9vyqFVpApN93c6iu/TQlAw43tGwHOFUnVZqEA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLuB9BQFWPbBluKgWM0ZezYG/UqOiFj+f15sRZwD9ZAJac4Y4wY
 wp1Yd4CC97uK/qhIOT6IuGLCnmMvrWcIDpQ+odUM/UBOchhj2OMMW0fCN1yJTuTwStRhqiBDb2U
 qfkIa
X-Gm-Gg: AYBFou2MD1lYVA5+a1jthzdMzpJk6ioZS9CwMfUaEOVxWCLiNnKSqv8cNowW8qVKCV2
 EGJDld2VaC40Sra9RCz0nEYoToqcIjThGFh/8BGtGn694ZXsV/4N4j7SWGJIAyYBSmhlkEK2U61
 W2NGfMknS550cJNnbeHur5j0APasXO4STEVLI91pFs7UHlhSinyPOMJh7lmA79jRcim34aHk4mj
 bjHS8cvplMmqqJGdOAjwpu9MY/zIGc+3LyooByQXiD4WdI0Hcni0w+cKi4QwN0RE7Bp5z13FOaV
 QskHlCodsnu+NGACqavR52l7H3sjWPZXpPD9QVy5L6oTBuPw13tvYXDsyDT2tVA9JhCivOZ4XlH
 zz/Jp21VdZiu4mGR5eCdxOVngvDT/FAChQ5p1BYyQMt9WmjrfVtmBN0qVSPb3ojvrtuynoWPzeP
 m9UV1MD22KMQAZwkCtv7wiOhXuC6o/zwME8uYyeLNSGSyVsvljuKEXz8/1QTqghn4ep3DSOnzeQ
 1E=
X-Received: by 2002:a05:6830:65c5:10b0:81a:f631:4db2 with SMTP id
 46e09a7af769-8302aa99ad3mr5411962a34.31.1791840757980; 
 Mon, 12 Oct 2026 14:32:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:926f:d0ec:bfa4:a539])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8303494f79bsm11809409a34.1.2026.10.12.14.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:32:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Oct 2026 16:32:28 -0500
Subject: [PATCH v2] clk: mediatek: drop unused fdivs_offs from apmixed
 trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-clk-mediatek-apmixed-fdivs-offs-v2-1-683cbab13829@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OSw6CMBRFt0I69pm2ChpH7sMw6OdVngglLTYSw
 t5tdQMOT3Jyz11ZxEAY2aVaWcBEkfyYQe4qZjo13hHIZmaSy0ZwIcE8exjQkpqxBzUN9EYLzlK
 K4J2LoIw6H2sltOOK5ZUpoMtOKdzaH8eXfqCZy2wxOoqzD8v3QhLF+7+WBAhwh6YxpraW29NVq
 +VJOuDe+IG127Z9AJ4JbxfjAAAA
X-Change-ID: 20261012-clk-mediatek-apmixed-fdivs-offs-aca845a1bf0a
To: Lukasz Majewski <lukma@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3447; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Uasf6LEabNSBi5fl66RFYvaiurszWgZ8xmOdw79+5tg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqzVHtJx+gJmlHwIMadwzjOxXAa81AxoHzkoA7J
 bo0eK9wrQ+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCas1R7RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHvQH/0OJFaM1tSgT7M5njecu2YvYqtpEUWCJBqeNtWi
 gZrokO/rUfZyzKBnDlvA2wy/caZcTwqgNe8ej1VjXG8SQj85ISak42XDvYtELssNPc/UZjmEM33
 28Vwb4nxed9D552Qti46PIYGEiyXFEWmo2PA9+r0qnssgLQ0wxNxryD1P9jo0+r520tWHmgLY8G
 +WlPpZclFK1NmhNCuTA20avzXpQTXKklGnetNumGCMSK/6bKlBQx/nuNJO0fVwPYoi5NiRYG0NV
 /X94H16QFjcFsq3b9pbD0d3BcqURUpnEbnWW10AVT1EfA89Y5oV3k//Inyn5zQluU8pfLQWxg38
 qPhk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove .fdivs_offs from the fixed PLL clock trees for MT7981, MT7986,
MT7987 and MT7988. These trees have no .fdivs table, and
mtk_clk_id_is_fdiv() checks tree->fdivs before looking at the offset, so
the value is never used.

The offset used to mark where the fixed clocks ended, so it was needed
for these trees until commit d09876c4f6ac ("clk: mediatek: add
mtk_clk_id_is_* helper functions") replaced the ID range checks.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Added same change for MT7986.
- Link to v1: https://patch.msgid.link/20261012-clk-mediatek-apmixed-fdivs-offs-v1-1-f366cc5dd0d7@baylibre.com
---
 drivers/clk/mediatek/clk-mt7981.c | 1 -
 drivers/clk/mediatek/clk-mt7986.c | 1 -
 drivers/clk/mediatek/clk-mt7987.c | 1 -
 drivers/clk/mediatek/clk-mt7988.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 6d5c967ea78..89be561432a 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -619,7 +619,6 @@ static const struct mtk_gate infracfg_gates[] = {
 static const struct mtk_clk_tree mt7981_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 	.type = MTK_CLK_TREE_APMIXED,
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 1e54d8ed2cf..7a806bbdfb0 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -526,7 +526,6 @@ static const struct mtk_gate infracfg_gates[] = {
 static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 	.flags = CLK_PARENT_APMIXED,
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 831fa7177a7..3cf008f420a 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -56,7 +56,6 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 797274c59ca..3adea0cd9e1 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -804,7 +804,6 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261012-clk-mediatek-apmixed-fdivs-offs-aca845a1bf0a

Best regards,
--  
David Lechner <dlechner@baylibre.com>

