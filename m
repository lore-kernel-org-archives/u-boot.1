Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2E606A80A
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zpZPoYcX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLDZWqf6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27F2C6069A;
	Tue,  3 Nov 2026 11:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0a-yMA9uNvVR; Tue,  3 Nov 2026 11:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 973C86060A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793704092;
	b=jfnV91fB9SjslOJiR5qiq6jhfwRe4syqxIexSnnqNviXF+Hf1ON0dWjJFy2YnEG0PcWn
	 eC7ZtzYP11I15MQqJ+qrSFCzlfwuYbyCqtouKEkZsE2r0M3AaNBzEpnYTcY2EeU8dox2Q
	 PwakR+SB23NywFezRK3NoK33O58wiKWZb3JyvGx7NeipvoxRQB2lmsQqRnRWXakhujkQb
	 W5khiqs7DPhgqwWdzi6qZ0Rt5ifQzX47Rpm6utd4nWvlEzXl6i/q17OR3UrmpLb/NvqVb
	 uRpWh3F0lV2S8w8L4brvVGcgVS75FexO1nzfjI/lIuxS+MlRGtc2L1zqNTg/g8dc1Dg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793704092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6iXQa029onCR6A5Cs1zZZ1/I5Snr6OhzpFI7GkrdoHg=;
	b=iGIClWqbWKrA4E4isx6U4C72TnWidO1O20qQOHVHVtPqBmw6YjqBXOBH5kWst+4bYBvz
	 Tb7Ma3CdA3+RZaEXVYDKPjSPniojgXfISaPrtRW2ufZLsY+XJ/ZLSqzSMraCL9f531MIo
	 bLmD09k0kBmfFwcZazEcoCD25cWIh/iqN2dvg1wgw1LMK4QugTVu3C3GjlvuEhPt8dZ3Z
	 947RRpeqWtJaRcKTGhKM2bSSWBpY5Cu4HzxR3qALN2HaC5VrNkyNGOvG3WSpXWJ9+qbdh
	 WE1T4IQLtzrxnaBSpdgg+V+5YSqeKOmM880AVdgJ0Wd1OKJyLOE6gUVzoyeNKSbbXuA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793704092;
	bh=6iXQa029onCR6A5Cs1zZZ1/I5Snr6OhzpFI7GkrdoHg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zpZPoYcXW1vfYwzF00HGRU/kI9XXYLaa2oHf2LX8II1Brtv1NEMwZ7Hp+fOfCRujm
	 b5FtGcDwfuuhjrHHdzzK2eJk0FZa+zu6BRoIeCLya/CzSUypg3WMYNakkL0TYY8wpg
	 z1Jaca8fUEN7W/BR//BMGu9qkd5PaUZH3nXSHQWZYvDke+nxZqRLbYCNYTXcyJeY7k
	 tzs0j4zI2FWQVLiD9/ERT1fXaICn+CT1NZWHzfKykkGKCnadE/ADtB2lP/6yZcRLMs
	 IKglwo21uH4FSPg7TdbuzsSKvngHHVhlS4PCbi16uqBqNPesP0m4Dt0d8372yflIHa
	 TcbVkRprfO/ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 973C86060A;
	Tue,  3 Nov 2026 11:08:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A46BE235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89ED880E03
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TZ604pY47uFd for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 11:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3243E80944
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793704090;
 b=N5SB9tOHd6T6zMTFoAZ4ozM1UUcwWcj9Pc3TQ3znaQzA2fQvf98y5e8o1eWHIhWA8Kyg
 GAxfZhzN+mNoQo1MiF9xotUueJk3IurX1Qx7VuvxxbwmIC+awuIYAg7VM/zH0ABthHv2X
 JT+xJrYBJU008CRkQ5fnZrDPG2FRxOysaN64sMD0IYaSV21C5o1NQ/ydvJbsAA70wt3b2
 lclY4SpOO89mbRCIWpekSamdREUtBPKXTrn8cctUrzT614XqJlAqEw4FlOqSTU8ch1Pyt
 xQqtu7Cb1un24jueT+WId1RkZ5x2a1eKh7rBNJWwPlqfmwlhhogWjx/JvQX/AvDAklw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793704090;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=6iXQa029onCR6A5Cs1zZZ1/I5Snr6OhzpFI7GkrdoHg=;
 b=lrl1dQZQZATt3ZwQcBh9LGmiMsRQO+egCGS44QmaQXO5JcsebPuv4O/r5F/Idf51Sn2t
 hh8mUNyYeGGGysQ8lDgv2VzQYGh6kpKn7FoX7fQ4wd44l2zVcvL7Dlb/vMtrANBOBa8A3
 qLmMrU2UNd2Zuip9wbR/Qpj9blCBLOXy4oYNVzXpVeT8/KB07YFPDbb5Y8Y8qYEDsQH3V
 BkaGbUshsfpQDNx258DSf9flYvMT02CQhoDKrhGG7k/nWFB55ZlXIz8FKc9iiQ5AqTQiH
 BocnNYQeVZoSNtw+gEx2iMqn52/QWKB7Pu6WmQkaMtqvK8BFCsrLGQ0+dXkHqdCzYjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gLDZWqf6; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gLDZWqf6
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3243E80944
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:08:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 482D340E83;
 Tue,  3 Nov 2026 11:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2790D1F000C1;
 Tue,  3 Nov 2026 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793704088;
 bh=6iXQa029onCR6A5Cs1zZZ1/I5Snr6OhzpFI7GkrdoHg=;
 h=From:Date:Subject:To:Cc;
 b=gLDZWqf6zoJ4eNr5qGF//jqbrNVeAWlJuLEWnPlUh00tkUFz5VgAcCGMIPpbi/iAR
 DSeBSImK3k3ynZPwX6dB1qdMxUC4rpcJJ7qF0BC5Ebsn07TuAjVs1no413zia9zVgy
 FbOEDH4Bm/jYxTQ94xd2nyGC06Qb6+zPoPsUWhshX4SmmCAinUG6ZnDv3BkgJQYuwN
 gWYlulfZI0ctVCWmAri5O+OuOezFEvsBRmDQLDbIXwNZoUcPXjFWquAWLUpHGjFCPw
 KiV7v5rJwD7zs2UESFmZfKaW1lvuxfzcOvp93QTiLPcTtsDih13nOD7K2dkdXLZcJA
 sX05jSk1by2/g==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 03 Nov 2026 11:07:59 +0000
Subject: [PATCH v2] clk: spacemit: k3: reduce clock tree for SPL build
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-01-k3-clock-spl-support-v2-1-09a0b28e902f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CQAxA4auQrm0yPwkLr2JcDLXFCmEmUyAmh
 Ls76vJbvHeAcVU2uHYHVN7VNC8N4dIBPdMyMuqjGYILvfcuovM4RaQ504RWZrStlFxXpCFFJ8I
 kkqDVpbLo+3e+3f+2bXgxrd8dnOcHYUtwdXsAAAA=
X-Change-ID: 20261103-01-k3-clock-spl-support-cba30ffecffa
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16160; i=dlan@kernel.org;
 h=from:subject:message-id; bh=7vhsJ3SJ5sIBVdsz2NZHvvaPfHQzAUUJHhZlo5GOhhs=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq6cCSMHEPZd+kpznxkcYMqVD91Z9ITR1ABWhPX
 y9Rr+KbTeyJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaunAkhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3pPBAAkj4Lg8Oe2I9q7gfdX1yczWDkmWd3bIEqMvAG3bWbMVjMF0WAVLRB2
 KXQc7qe72ymn70Cw6mKY5NdwP2E5DMOIExUeDU2jo1jyOve/9LVhCuuG6UZzqUOomrot6zOpG9U
 gV8S8/NncaKsy2sJmI2cyf1Pc6jg2jHxYaEI3h8KdQVrabae6QboBCUWcw3z/MGlZvHp3+Grh6p
 M/xw+6QIyBIfWpYqabAboTipo3QGhd+7vD/POqpqxdbkCSvWxDkvm+XqwXLFNqvHZKdFnkPHN/3
 8pI/v3tlN2cR/gDP3f4/yCa0OJfRSc8sq2pgJ94JPgXp5eKr2L2++5T0bWC0OAa7XuP65Z0+lZJ
 6qnsmQ2vwS3X35kTnMzmJEPQmKTEtiUS8uuxQfhSBFKRCcfWmSsJN+Bez6vX7rVFuntcjZUSVrk
 oy0b0+YSfTglAvzE5CpcmVusGkITtKWGbBluiwzKg7kbS3EQHdpBa1qX/1iyUGcz+cKzJ9Q1QB4
 4wQghfCtHe/kIVTTgdwwJnKxhMQbIyXlCfeWDbd2pgilG/60GeLVQkVEtdfwP/yeAWIJ42M2FxC
 sjJLJ2Mp1GUeQckeAEkqnbHkSMOxy9qf/J6cQTSAaFdFUrprnI5J8siYrNVjw6ScNL9JXH/sOT2
 hzMrSBNIP8k/vmTAEDxbyyDd82fFmI=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Due to SPL image running in a memory space constraint SRAM environment,
so reduce the whole clock tree a bit to make it fit for final runtime
requirement, only a subset clock tree is registered, which includes UART,
SDHCI, I2C (TWSI), and their PLL/MPMU/APMU/APBC ancestors; while the
full clock tree is retained in non-SPL build.

Where surviving SPL CCU definitions reference parent clocks outside
that subset tree, it will use "clock-dummy" as name of clock parent to
ensure the framework still successfully resolves the parent clock lookup.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v2:
- add gpio clock
- fix tswi8 clock
- enable sdh0 clock
- Link to v1: https://patch.msgid.link/20260825-01-k3-clock-reset-support-v1-6-c430253e759c@kernel.org
---
 drivers/clk/spacemit/clk-k3.c | 209 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 190 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/spacemit/clk-k3.c b/drivers/clk/spacemit/clk-k3.c
index f4f1bb7bf04..de7d2ae0864 100644
--- a/drivers/clk/spacemit/clk-k3.c
+++ b/drivers/clk/spacemit/clk-k3.c
@@ -42,6 +42,18 @@ static const struct ccu_pll_rate_tbl pll1_rate_tbl[] = {
 	CCU_PLLA_RATE(2457600000UL, 0x0b330ccc, 0x0000cd00, 0xa0558989),
 };
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+CCU_PLLA_DEFINE(CLK_PLL1, pll1, pll1, "clock-24m", pll1_rate_tbl,
+		APBS_PLL1_SWCR1, APBS_PLL1_SWCR2, APBS_PLL1_SWCR3,
+		MPMU_POSR, POSR_PLL1_LOCK, CLK_SET_RATE_GATE);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D4, pll1_d4, pll1_d4, "pll1",
+		       APBS_PLL1_SWCR2, BIT(3), 4, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D6, pll1_d6, pll1_d6, "pll1",
+		       APBS_PLL1_SWCR2, BIT(5), 6, 1);
+CCU_FACTOR_GATE_FLAGS_DEFINE(CLK_PLL1_D8, pll1_d8, pll1_d8, "pll1",
+			     APBS_PLL1_SWCR2, BIT(7), 8, 1,
+			     CLK_IS_CRITICAL);
+#else
 static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
 	CCU_PLLA_RATE(3000000000UL, 0x0b3e2000, 0x00000000, 0xa0558c8c),
 };
@@ -337,9 +349,51 @@ CCU_FACTOR_GATE_DEFINE(CLK_PLL8_D7, pll8_d7, pll8_d7, "pll8",
 		       APBS_PLL8_SWCR2, BIT(6), 7, 1);
 CCU_FACTOR_GATE_DEFINE(CLK_PLL8_D8, pll8_d8, pll8_d8, "pll8",
 		       APBS_PLL8_SWCR2, BIT(7), 8, 1);
+#endif
 /* APBS clocks end */
 
 /* MPMU clocks start */
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+CCU_GATE_DEFINE(CLK_MPMU_PLL1_307P2, pll1_d8_307p2, pll1_d8_307p2, "pll1_d8",
+		MPMU_ACGR, BIT(13), 0);
+CCU_GATE_DEFINE(CLK_MPMU_PLL1_409P6, pll1_d6_409p6, pll1_d6_409p6, "pll1_d6",
+		MPMU_ACGR, BIT(0), 0);
+CCU_FACTOR_DEFINE(CLK_MPMU_PLL1_61P44, pll1_d40_61p44, pll1_d40_61p44,
+		  "pll1_d8_307p2", 5, 1);
+CCU_FACTOR_DEFINE(CLK_MPMU_PLL1_153P6, pll1_d16_153p6,
+		  pll1_d16_153p6, "pll1_d8", 2, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_MPMU_PLL1_102P4, pll1_d24_102p4,
+		       pll1_d24_102p4, "pll1_d8", MPMU_ACGR,
+		       BIT(12), 3, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_MPMU_PLL1_51P2, pll1_d48_51p2,
+		       pll1_d48_51p2, "pll1_d8", MPMU_ACGR,
+		       BIT(7), 6, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_MPMU_PLL1_57P6, pll1_m3d128_57p6,
+		       pll1_m3d128_57p6, "pll1_d8", MPMU_ACGR,
+		       BIT(8), 16, 3);
+CCU_FACTOR_GATE_DEFINE(CLK_MPMU_PLL1_25P6, pll1_d96_25p6,
+		       pll1_d96_25p6, "pll1_d8", MPMU_ACGR,
+		       BIT(4), 12, 1);
+CCU_GATE_DEFINE(CLK_MPMU_PLL1_614, pll1_d4_614p4, pll1_d4_614p4,
+		"pll1_d4", MPMU_ACGR, BIT(15), 0);
+CCU_FACTOR_GATE_DEFINE(CLK_MPMU_PLL1_31P5, pll1_d78_31p5,
+		       pll1_d78_31p5, "pll1_d4", MPMU_ACGR,
+		       BIT(6), 39, 2);
+
+static const char * const apb_parents[] = {
+	"pll1_d96_25p6", "pll1_d48_51p2", "pll1_d96_25p6",
+	"pll1_d24_102p4",
+};
+
+CCU_MUX_DEFINE(CLK_MPMU_APB, apb_clk, apb_clk, apb_parents,
+	       ARRAY_SIZE(apb_parents), MPMU_APBCSCR, 0, 2, 0);
+CCU_DDN_DEFINE(CLK_MPMU_SLOW_UART1, slow_uart1_14p74,
+	       slow_uart1_14p74, "pll1_d16_153p6", MPMU_SUCCR,
+	       CCU_DDN_MASK(16, 13), 16, CCU_DDN_MASK(0, 13), 0, 2, 0);
+CCU_DDN_DEFINE(CLK_MPMU_SLOW_UART2, slow_uart2_48, slow_uart2_48,
+	       "pll1_d4_614p4", MPMU_SUCCR_1, CCU_DDN_MASK(16, 13), 16,
+	       CCU_DDN_MASK(0, 13), 0, 2, 0);
+#else
 CCU_GATE_DEFINE(CLK_MPMU_PLL1_307P2, pll1_d8_307p2, pll1_d8_307p2, "pll1_d8",
 		MPMU_ACGR, BIT(13), 0);
 CCU_FACTOR_DEFINE(CLK_MPMU_PLL1_76P8, pll1_d32_76p8, pll1_d32_76p8, "pll1_d8_307p2", 4, 1);
@@ -476,12 +530,49 @@ CCU_GATE_DEFINE(CLK_MPMU_I2S4_SYSCLK, i2s4_sysclk, i2s4_sysclk, "i2s4_sysclk_div
 		MPMU_I2S_SYSCLK_CTRL, BIT(18), 0);
 CCU_GATE_DEFINE(CLK_MPMU_I2S5_SYSCLK, i2s5_sysclk, i2s5_sysclk, "i2s5_sysclk_div",
 		MPMU_I2S_SYSCLK_CTRL, BIT(22), 0);
+#endif
 /* MPMU clocks end */
 
 /* APBC clocks start */
 static const char * const uart_clk_parents[] = {
 	"pll1_m3d128_57p6", "slow_uart1_14p74", "slow_uart2_48",
 };
+
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+CCU_MUX_GATE_DEFINE(CLK_APBC_UART0, uart0_clk, uart0_clk,
+		    uart_clk_parents, ARRAY_SIZE(uart_clk_parents),
+		    APBC_UART0_CLK_RST, 4, 3, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_APBC_UART0_BUS, uart0_bus_clk, uart0_bus_clk,
+		"apb_clk", APBC_UART0_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_APBC_AIB, aib_clk, aib_clk, "clock-24m",
+		APBC_AIB_CLK_RST, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_APBC_AIB_BUS, aib_bus_clk, aib_bus_clk, "apb_clk",
+		APBC_AIB_CLK_RST, BIT(0), 0);
+
+static const char * const twsi_parents[] = {
+	"pll1_d78_31p5",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_APBC_TWSI2, twsi2_clk, twsi2_clk,
+		    twsi_parents, ARRAY_SIZE(twsi_parents),
+		    APBC_TWSI2_CLK_RST, 4, 3, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_APBC_TWSI2_BUS, twsi2_bus_clk, twsi2_bus_clk,
+		"apb_clk", APBC_TWSI2_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_APBC_GPIO, gpio_clk, gpio_clk, "clock-24m",
+		APBC_GPIO_CLK_RST, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_APBC_GPIO_BUS, gpio_bus_clk, gpio_bus_clk, "apb_clk",
+		APBC_GPIO_CLK_RST, BIT(0), 0);
+
+static const char * const twsi8_parents[] = {
+	"pll1_d78_31p5", "pll1_d48_51p2", "pll1_d40_61p44",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_APBC_TWSI8, twsi8_clk, twsi8_clk,
+		    twsi8_parents, ARRAY_SIZE(twsi8_parents),
+		    APBC_TWSI8_CLK_RST, 4, 3, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_APBC_TWSI8_BUS, twsi8_bus_clk, twsi8_bus_clk, "apb_clk",
+		APBC_TWSI8_CLK_RST, BIT(0), 0);
+#else
 CCU_MUX_GATE_DEFINE(CLK_APBC_UART0, uart0_clk, uart0_clk, uart_clk_parents, ARRAY_SIZE(uart_clk_parents),
 		    APBC_UART0_CLK_RST, 4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_APBC_UART2, uart2_clk, uart2_clk, uart_clk_parents, ARRAY_SIZE(uart_clk_parents),
@@ -843,9 +934,31 @@ CCU_GATE_DEFINE(CLK_APBC_CAN3_BUS, can3_bus_clk, can3_bus_clk, "apb_clk",
 		APBC_CAN3_CLK_RST, BIT(0), 0);
 CCU_GATE_DEFINE(CLK_APBC_CAN4_BUS, can4_bus_clk, can4_bus_clk, "apb_clk",
 		APBC_CAN4_CLK_RST, BIT(0), 0);
+#endif
 /* APBC clocks end */
 
 /* APMU clocks start */
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static const char * const axi_clk_parents[] = {
+	"pll1_d8_307p2", "pll1_d6_409p6",
+};
+
+CCU_MUX_DIV_FC_DEFINE(CLK_APMU_AXICLK, axi_clk, axi_clk,
+		      axi_clk_parents, ARRAY_SIZE(axi_clk_parents),
+		      APMU_ACLK_CLK_CTRL, APMU_ACLK_CLK_CTRL, 1, 2,
+		      BIT(4), 0, 1, 0);
+CCU_GATE_DEFINE(CLK_APMU_SDH_AXI, sdh_axi_aclk, sdh_axi_aclk, "axi_clk",
+		APMU_SDH0_CLK_RES_CTRL, BIT(3), 0);
+
+static const char * const sdh01_parents[] = {
+	"pll1_d6_409p6",
+};
+
+CCU_MUX_DIV_GATE_FC_DEFINE(CLK_APMU_SDH0, sdh0_clk, sdh0_clk,
+			   sdh01_parents, ARRAY_SIZE(sdh01_parents),
+			   APMU_SDH0_CLK_RES_CTRL, 8, 3, BIT(11),
+			   5, 3, BIT(4), 0);
+#else
 static const char * const axi_clk_parents[] = {
 	"pll1_d8_307p2", "pll1_d6_409p6",
 };
@@ -1122,13 +1235,13 @@ CCU_MUX_DIV_GATE_FC_DEFINE(CLK_APMU_UFS_ACLK, ufs_aclk, ufs_aclk, ufs_aclk_paren
 			   2, 3, BIT(1), 0);
 
 static const char * const edp0_pclk_parents[] = {
-	"lcd_pxclk", "external_clk",
+	"lcd_pxclk", "clock-dummy",
 };
 CCU_MUX_GATE_DEFINE(CLK_APMU_EDP0_PXCLK, edp0_pxclk, edp0_pxclk, edp0_pclk_parents, ARRAY_SIZE(edp0_pclk_parents),
 		    APMU_LCD_EDP_CTRL, 2, 1, BIT(1), 0);
 
 static const char * const edp1_pclk_parents[] = {
-	"dsi4ln2_lcd_pxclk", "external_clk",
+	"dsi4ln2_lcd_pxclk", "clock-dummy",
 };
 CCU_MUX_GATE_DEFINE(CLK_APMU_EDP1_PXCLK, edp1_pxclk, edp1_pxclk, edp1_pclk_parents, ARRAY_SIZE(edp1_pclk_parents),
 		    APMU_LCD_EDP_CTRL, 18, 1, BIT(17), 0);
@@ -1189,7 +1302,7 @@ CCU_MUX_DEFINE(CLK_APMU_ESPI_SCLK_SRC, espi_sclk_src, espi_sclk_src, espi_sclk_s
 		APMU_ESPI_CLK_RES_CTRL, 4, 3, 0);
 
 static const char * const espi_sclk_parents[] = {
-	"external_clk", "espi_sclk_src",
+	"clock-dummy", "espi_sclk_src",
 };
 CCU_MUX_GATE_DEFINE(CLK_APMU_ESPI_SCLK, espi_sclk, espi_sclk, espi_sclk_parents, ARRAY_SIZE(espi_sclk_parents),
 		    APMU_ESPI_CLK_RES_CTRL, 7, 1, BIT(3), 0);
@@ -1217,8 +1330,10 @@ CCU_MUX_DIV_GATE_DEFINE(CLK_APMU_ISIM_VCLK2, isim_vclk_out2, isim_vclk_out2, isi
 CCU_MUX_DIV_GATE_DEFINE(CLK_APMU_ISIM_VCLK3, isim_vclk_out3, isim_vclk_out3, isim_vclk_parents, ARRAY_SIZE(isim_vclk_parents),
 			APMU_SNR_ISIM_VCLK_CTRL, 27, 4, 25, 2,
 			BIT(24), 0);
+#endif
 /* APMU clocks end */
 
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
 /* DCIU clocks start */
 CCU_GATE_DEFINE(CLK_DCIU_HDMA, hdma_clk, hdma_clk, "axi_clk",
 		DCIU_DMASYS_CLK_EN, BIT(0), 0);
@@ -1229,18 +1344,16 @@ CCU_GATE_DEFINE(CLK_DCIU_C2_TCM_PIPE, c2_tcm_pipe_clk, c2_tcm_pipe_clk, "axi_clk
 CCU_GATE_DEFINE(CLK_DCIU_C3_TCM_PIPE, c3_tcm_pipe_clk, c3_tcm_pipe_clk, "axi_clk",
 		DCIU_C3_TCM_PIPE_CLK, BIT(0), 0);
 /* DCIU clocks end */
+#endif
 
-
-
-
-
-
-
-
-
-
-
-
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k3_ccu_pll_clks[] = {
+	&pll1.common.clk,
+	&pll1_d4.common.clk,
+	&pll1_d6.common.clk,
+	&pll1_d8.common.clk,
+};
+#else
 static struct clk *k3_ccu_pll_clks[] = {
 	&pll1.common.clk,
 	&pll2.common.clk,
@@ -1328,6 +1441,7 @@ static struct clk *k3_ccu_pll_clks[] = {
 	&pll8_d7.common.clk,
 	&pll8_d8.common.clk,
 };
+#endif
 
 static const struct spacemit_ccu_data k3_ccu_pll_data = {
 	.clks		= k3_ccu_pll_clks,
@@ -1335,6 +1449,23 @@ static const struct spacemit_ccu_data k3_ccu_pll_data = {
 	.offset		= K3_PLL_ID,
 };
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k3_ccu_mpmu_clks[] = {
+	&pll1_d8_307p2.common.clk,
+	&pll1_d6_409p6.common.clk,
+	&pll1_d40_61p44.common.clk,
+	&pll1_d16_153p6.common.clk,
+	&pll1_d24_102p4.common.clk,
+	&pll1_d48_51p2.common.clk,
+	&pll1_m3d128_57p6.common.clk,
+	&pll1_d96_25p6.common.clk,
+	&pll1_d4_614p4.common.clk,
+	&pll1_d78_31p5.common.clk,
+	&apb_clk.common.clk,
+	&slow_uart1_14p74.common.clk,
+	&slow_uart2_48.common.clk,
+};
+#else
 static struct clk *k3_ccu_mpmu_clks[] = {
 	&pll1_d8_307p2.common.clk,
 	&pll1_d32_76p8.common.clk,
@@ -1388,6 +1519,7 @@ static struct clk *k3_ccu_mpmu_clks[] = {
 	&i2s4_sysclk.common.clk,
 	&i2s5_sysclk.common.clk,
 };
+#endif
 
 static const struct spacemit_ccu_data k3_ccu_mpmu_data = {
 	.clks		= k3_ccu_mpmu_clks,
@@ -1395,6 +1527,20 @@ static const struct spacemit_ccu_data k3_ccu_mpmu_data = {
 	.offset		= K3_MPMU_ID,
 };
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k3_ccu_apbc_clks[] = {
+	&uart0_clk.common.clk,
+	&uart0_bus_clk.common.clk,
+	&aib_clk.common.clk,
+	&aib_bus_clk.common.clk,
+	&gpio_clk.common.clk,
+	&gpio_bus_clk.common.clk,
+	&twsi2_clk.common.clk,
+	&twsi2_bus_clk.common.clk,
+	&twsi8_clk.common.clk,
+	&twsi8_bus_clk.common.clk,
+};
+#else
 static struct clk *k3_ccu_apbc_clks[] = {
 	&uart0_clk.common.clk,
 	&uart2_clk.common.clk,
@@ -1539,6 +1685,7 @@ static struct clk *k3_ccu_apbc_clks[] = {
 	&can3_bus_clk.common.clk,
 	&can4_bus_clk.common.clk,
 };
+#endif
 
 static const struct spacemit_ccu_data k3_ccu_apbc_data = {
 	.clks		= k3_ccu_apbc_clks,
@@ -1546,6 +1693,13 @@ static const struct spacemit_ccu_data k3_ccu_apbc_data = {
 	.offset		= K3_APBC_ID,
 };
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k3_ccu_apmu_clks[] = {
+	&axi_clk.common.clk,
+	&sdh_axi_aclk.common.clk,
+	&sdh0_clk.common.clk,
+};
+#else
 static struct clk *k3_ccu_apmu_clks[] = {
 	&axi_clk.common.clk,
 	&cci550_clk.common.clk,
@@ -1637,6 +1791,7 @@ static struct clk *k3_ccu_apmu_clks[] = {
 	&isim_vclk_out2.common.clk,
 	&isim_vclk_out3.common.clk,
 };
+#endif
 
 static const struct spacemit_ccu_data k3_ccu_apmu_data = {
 	.clks		= k3_ccu_apmu_clks,
@@ -1650,13 +1805,16 @@ static const struct spacemit_ccu_data k3_ccu_apmu_data = {
  * Enable them explicitly here, otherwise Linux gets stuck
  * halfway through boot.
  */
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
 static struct clk *const k3_apmu_boot_clks[] = {
 	&cpu_c0_core_clk.common.clk,
 	&cpu_c1_core_clk.common.clk,
 	&cpu_c2_core_clk.common.clk,
 	&cpu_c3_core_clk.common.clk,
 };
+#endif
 
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
 static struct clk *k3_ccu_dciu_clks[] = {
 	&hdma_clk.common.clk,
 	&dma350_clk.common.clk,
@@ -1669,6 +1827,7 @@ static const struct spacemit_ccu_data k3_ccu_dciu_data = {
 	.num		= ARRAY_SIZE(k3_ccu_dciu_clks),
 	.offset		= K3_DCIU_ID,
 };
+#endif
 
 static int k3_clk_force_probe(const struct driver *drv)
 {
@@ -1768,7 +1927,7 @@ static int k3_apmu_clk_probe(struct udevice *dev)
 {
 	struct regmap *base_regmap;
 	const struct spacemit_ccu_data *data;
-	int i, ret;
+	int ret;
 
 	ret = k3_clk_force_probe(DM_DRIVER_GET(k3_pll_clk));
 	if (ret)
@@ -1787,11 +1946,13 @@ static int k3_apmu_clk_probe(struct udevice *dev)
 	if (ret)
 		return -EPROBE_DEFER;
 
-	for (i = 0; i < ARRAY_SIZE(k3_apmu_boot_clks); i++) {
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
+	for (int i = 0; i < ARRAY_SIZE(k3_apmu_boot_clks); i++) {
 		ret = clk_enable(k3_apmu_boot_clks[i]);
 		if (ret)
 			return ret;
 	}
+#endif
 
 	return 0;
 }
@@ -1808,9 +1969,11 @@ static int k3_apbc_clk_probe(struct udevice *dev)
 	ret = k3_clk_force_probe(DM_DRIVER_GET(k3_mpmu_clk));
 	if (ret)
 		return ret;
-	ret = k3_clk_force_probe(DM_DRIVER_GET(k3_apmu_clk));
-	if (ret)
-		return ret;
+	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+		ret = k3_clk_force_probe(DM_DRIVER_GET(k3_apmu_clk));
+		if (ret)
+			return ret;
+	}
 
 	ret = regmap_init_mem(dev_ofnode(dev), &base_regmap);
 	if (ret)
@@ -1825,6 +1988,7 @@ static int k3_apbc_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
 static int k3_dciu_clk_probe(struct udevice *dev)
 {
 	struct regmap *base_regmap;
@@ -1853,6 +2017,7 @@ static int k3_dciu_clk_probe(struct udevice *dev)
 
 	return 0;
 }
+#endif
 
 static int k3_pll_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 {
@@ -1914,6 +2079,7 @@ static int k3_apmu_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *arg
 	return 0;
 }
 
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
 static int k3_dciu_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 {
 	if (args->args_count > 1) {
@@ -1928,6 +2094,7 @@ static int k3_dciu_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *arg
 
 	return 0;
 }
+#endif
 
 #define K3_CLK_OPS(name)				\
 static const struct clk_ops k3_##name##_clk_ops = {	\
@@ -1971,10 +2138,12 @@ static int k3_apmu_clk_bind(struct udevice *dev)
 	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_APMU);
 }
 
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
 static int k3_dciu_clk_bind(struct udevice *dev)
 {
 	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_DCIU);
 }
+#endif
 
 static const struct udevice_id k3_mpmu_clk_match[] = {
 	{ .compatible = "spacemit,k3-syscon-mpmu",
@@ -2030,6 +2199,7 @@ U_BOOT_DRIVER(k3_apmu_clk) = {
 	.flags		= DM_FLAG_PRE_RELOC,
 };
 
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
 static const struct udevice_id k3_dciu_clk_match[] = {
 	{ .compatible = "spacemit,k3-syscon-dciu",
 	  .data = (ulong)&k3_ccu_dciu_data },
@@ -2047,3 +2217,4 @@ U_BOOT_DRIVER(k3_dciu_clk) = {
 	.ops		= &k3_dciu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
 };
+#endif

---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261103-01-k3-clock-spl-support-cba30ffecffa

Best regards,
--  
Yixun Lan <dlan@kernel.org>

