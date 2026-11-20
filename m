Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4822606A32A
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v/QYQnfR;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+K054HZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BB0F81755;
	Fri, 20 Nov 2026 13:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F_ZdnkvoH_66; Fri, 20 Nov 2026 13:21:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 268D081698
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180892;
	b=GFC3TFZrX2t8tDdN/XTEYHxF3La5kVDHERjcSQM+XEHbv9gRHgE1FfhKXJ9a/MENqFDz
	 P5VnjfGYxLdNen2xerjOOILDz4/Jx3SzCk9bNqkwqjzok0tO0JLsS51/9ITeGxy4edNNG
	 mLzLtrw2a2N6Sf0v2eKNecWvtQMVHvG4QeWEMa18GdcxiBC7dND0Me1BOuwEGF4hB9LDX
	 QuIPej4Nc5JQC+Up/o3aYb5i2cx6cBYxH7rGZhbBCOIgDdEQDlFZ6osEpi3KLf9i8AKtK
	 MyDssOe/lZaMh97/kRSx6HoiJV5vBWdtgHFC5GUFxH8Sh3BlHm1H51gdBN6MGz4QLyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Vvdm2ae2VpuU/TihF/ilratCx9CqpnRIMp7GcQBndvg=;
	b=I33XHmTsyZ4TjXsnFhYRtq/cF1svvh/B4Tl7FL+4zJdldnuCPKIlGk56Q19oRNE8iEOj
	 AlpHSb4/HupLQdaRks165l6UF4feev6W4NQK3uDG+O35/8RqqlyA/BtfnrYrcG6bImwPZ
	 nKwuradJ2gRy3wwpNqCn5HJ+DoOw7zqvT9/EczytnC3j6BcQpPE6dUSzq4W2Q0IOWsXVu
	 6E1DOS7ND5bNdhNtvNeUFVN54Fv+/gCTbzT0H2Mhzc6wUeUHjwDHUwu5xICfMEjZ0B2zH
	 HE/0ywihIYwVUGHONlf5ewBwlsdKRXp3HjmRAvUF4ZdbGch+1NouN4dEiJSzWH2AZJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180892;
	bh=Vvdm2ae2VpuU/TihF/ilratCx9CqpnRIMp7GcQBndvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v/QYQnfRCF6i0hrpcm671az3ZyuzFZDwrBvtp1IIoSNDMkK5KJ1vB/TqiRwFxS0QP
	 5OWIBYH/LxXLApcD7hhjRXNz7DvdcC+io6ckytEawvogxC4wGkrr7obOJGD0xS1fwC
	 QlDmp4QTIifGk6qQ1CTHIKMAX/hroDYIT8c/GSgjL6LYMG5X9ePf8MOaAbDN7EEhOS
	 uJgrCY/j1GiAiqWf/ObUwcfvUyZ4r7He1dXF4A6jAjzr+hkImnSdFYlwny6wYjgcID
	 XnGqpN3ED5I2Zrdkun/Imj9RKrD0jPz39RlRz1X7wfSXcMtUOhhhqKzTizANVVzVTt
	 ApsS515NRt0cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 268D081698;
	Fri, 20 Nov 2026 13:21:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E2ED81C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4F5140A25
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chf8vYwDVihm for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 11:10:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DCE254016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=S+K054HZ
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCE254016D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:47 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so5538685e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 03:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795173046; x=1795777846;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vvdm2ae2VpuU/TihF/ilratCx9CqpnRIMp7GcQBndvg=;
 b=S+K054HZ/68U+OSvEEAHvUkGZWqDlErVYsn2mxCqe0EdoE68Hgpw3QWwg2AwNyc3Er
 qU+ubmKsRgxZQsQyRgeA26XCJxi7o/m2mOX0v0wXUtlYlm2OfKp7S5jRfdcK6YlNcupq
 5j4TmNbifKdrzUUNqOMIS0GIqZniJ8V/t6BhEJoruGVArLipZo4IVPoYh9jbQdTnB4AF
 x7NmmO0/SWhqP1RnI84zbnMGmbShjk3gv/rrVqkMAQYvpBNIskoC0S3NC5IJOylO/Uil
 4EFUjcHFV2C9Gs2KXLZkxiJV8UqWfbISyJUac+RkPyqhEclfW4F9uX2Kw+IvZUCkZIb+
 ctzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173046; x=1795777846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vvdm2ae2VpuU/TihF/ilratCx9CqpnRIMp7GcQBndvg=;
 b=TrdhCCTsbzWmn6W4M26zFB+NHS8B99kVbpVkNC59pTvG5ceciEKu1pN5Db7jccZcVJ
 QbH3MRIQTcMkEFZTeTmO8aP13yZ4ww5RkwesxmNeDdFmgbK4apteKFKMUcWUXjUGTc79
 f9ZOHRbs5prZhJuls3+LOxZd/8LO8V/m8zL12eWuv7tzQTde+T5LDHoc9+dWr9RtAIrO
 GgAVg2ZBMEyDGDj12GrpaSdFBILHE0bPHcPybKecnoLRLDzEhQmvYSUr6b1MiR5rtB4G
 IOmJZDuEfNUyJdt7uWWynH58iQWfS9QmJhzRp0T4RCwhf65ED1a9gS8aKAhxlgWrOQmZ
 O6bQ==
X-Gm-Message-State: APuU4Z9nOd/84jIDCTLPDlj8UQZoYhzS/1EPgVc6zn8Ogv51uZNloJwU
 W499GVWpUmTaiCMW1LSjKg31wv22pBmoKiAx/DaeT5q1Ip7jRwq0+uMv
X-Gm-Gg: AYBFou1CyxnUjstPtIAMQBFbtO0iogz8vAdwOnQdeelmRUhMpBPGZbqcwZY/SYbx0Po
 kICeHA4dyMI1/V21YcO325zRTR9lkGOYbBXmQLzbb/u0J/9N5oUunXqi9lkMxWaAGbSNB1ZVokq
 Zp+pys7tawKGLPAhKfNqiQ6gIyIcL4joa5I7Bx9uaLnmJGLgC+V35JLAUciXRENIOuLbzk9lE9W
 cXLzfReO4QHpY6on/at2nSdxJI5/lTrgGzAFxSS7+LaEgQ2Qq55puoArsIeMorJer97CcnoheVy
 ThoUpaWFvFeEmieP0Yqxrs8IY3SKlZG+gaw2fqVhSUHxpl3Azh4GNExbkyPDurs+zk8ehva6AA2
 /i1+rQ8oxUAAlZD0Rm2NlSjR9J3H+z3neTnXX+AGvAq3C1fHW9W3gRcPk66ENimUKNsujIPD2Fs
 3P4V1IsZH1bXgcjijYygEs+eLBmS7HokF2jT062GRyYKX6Ogv2Wk7R1eXNrCpQQkilqlWcUaXKe
 8V555heqZQX6kH42QeZCmjJPmYGBSJdK7p/76FWj6XSvMlmm0GvMhLZouohG4m/wmGf0z5VsWPF
 heHuZZoNhRyBLt1WyFs/a0o=
X-Received: by 2002:a05:600d:600b:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4bb88815f1fmr59167075e9.21.1795173045569; 
 Fri, 20 Nov 2026 03:10:45 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm79108005e9.3.2026.11.20.03.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:10:45 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, francesco.dolcini@toradex.com,
 lukma@nabladev.com, dlechner@baylibre.com, msp@baylibre.com,
 stefan.eichenberger@toradex.com, Max.Merchel@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, primoz.fiser@norik.com, jbx6244@gmail.com,
 aford173@gmail.com, cniedermaier@dh-electronics.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/7] clk: imx: imx6ul: fix the enet clock gate register
Date: Fri, 20 Nov 2026 12:10:07 +0100
Message-ID: <20261120111037.110741-2-eichest@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120111037.110741-1-eichest@gmail.com>
References: <20261120111037.110741-1-eichest@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

IMX6UL_CLK_ENET was registered on CCGR1 bit 10, which is CG5, the uart3
gate: enabling the FEC clock would have gated uart3 and left ENET alone.
The ENET gate is CCM_CCGR0[CG6] on i.MX6ULL and CCM_CCGR3[CG2] on
i.MX6UL, as the reference manuals and Linux have it.

Fixes: 0f53197c3d6c ("clk: imx: add i.MX6UL clk driver")
Tested-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/clk/imx/clk-imx6ul.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 32fb949ffbc..a73fb40b8ac 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
+#include <asm/mach-imx/sys_proto.h>
 #include <dt-bindings/clock/imx6ul-clock.h>
 
 #include "clk.h"
@@ -259,8 +260,12 @@ static int imx6ul_clk_probe(struct udevice *dev)
 	clk_dm(IMX6UL_CLK_PWM1,
 	       imx_clk_gate2(dev, "pwm1", "perclk", base + 0x78, 16));
 
-	clk_dm(IMX6UL_CLK_ENET,
-	       imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
+	if (is_mx6ull())
+		clk_dm(IMX6UL_CLK_ENET,
+		       imx_clk_gate2(dev, "enet", "ipg", base + 0x68, 12));
+	else
+		clk_dm(IMX6UL_CLK_ENET,
+		       imx_clk_gate2(dev, "enet", "ipg", base + 0x74, 4));
 	clk_dm(IMX6UL_CLK_ENET_REF,
 	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
 
-- 
2.56.1

