Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240B1C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 122F38129C;
	Fri,  7 Aug 2026 19:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BxRuGNRP3IQh; Fri,  7 Aug 2026 19:00:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19CED81294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786129222;
	bh=3sj7jQWdbZ9I3nqt+pX9B/454brfLYuoHxv4ZdFh5Vc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kh6VEXAcSFtt5Ozq4OAxjRG4PuKOoiNYWbAj0+r3nUSAqTo3kuuEEoxT0YqSCAYaS
	 bVz2ynNWYH776VU+sV+pGk61+rjH7bb+qo2yqzMgQPlcrTLZClC1DMQdhThrKq+Ojr
	 EPUpJzORwb6XAEjFIgdGyldRV8yN27z3CCKXjwRuYMHpu4IeprlBY/9VC1P3LDmmv8
	 wEhAy1mtg0leLReChQgQpHwLIoybcYz+HfwuqdwVjDvvk8fEUKHMCQs6/3LMVOj0hk
	 hUL51S3iJh3TlTJvRlc7Bth7onNgAzUVaOhL8x+4o7UdWWHRMjmQ4F0BthszcZbKGu
	 9DMz9H2IFZ+uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19CED81294;
	Fri,  7 Aug 2026 19:00:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E67F1AF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8038240159
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iaGSbYZgspoG for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:00:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0E415400C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E415400C7
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E415400C7
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:18 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e6b554044fso3390729a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786129217; x=1786734017;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3sj7jQWdbZ9I3nqt+pX9B/454brfLYuoHxv4ZdFh5Vc=;
 b=DiFvaNzHtSy8VQd1YYYQnurDjiKLq2ttHLepjsYqGsaNJSOsT9PYALuTQ3UcZGvmSH
 fMjT5ALCiwIHkRSnqB2s2DIYO2yIYzlMuQME8qPurYneRr5KKfqc3/XY3qN6sz2MCd/p
 5CP90BbcN4KPX9JFYHoHlVzYxVzt1C+oyyuFoO6RMFDbcxFKptb1IxDxW6CZRyVwXKIN
 5YXVrtQMJYpOT/xuENNJ/AR1lP3XQDO8xffyfMZ43xIRzk4PUgW3JWdNWsrw9x5ad1NT
 fMnhU8SUjkYkEKGSZdRGX9siRHcqXMiCTcu/I6HF26258M/nBMoPac5B3W1ErZ7wjthp
 Bi2Q==
X-Gm-Message-State: AOJu0YwJcc2FdaBfZwzGAqFtI0jo5Cth9t0xlKZymMvdcEDWDfi03MFp
 y/Zk5bcn8OWqJJj+LRo/rFkzdWDVrO2xRZoxGWJU+H4gAd/tG7rRR5h40yKxeOOOMnc=
X-Gm-Gg: AR+sD10IOR3CPgBs1b8Xt+JBjAYcLZAhhxUWgKjKm3lJFnBHXYNQD2oVolrgD8zN3VJ
 PoNELqOAHyqSjsEQpm2LB+3U5Y3ReqV418tbx86V9+AwGkpdQWqzS92ZHJlQZLsH1EbdfaBkB3o
 xAbKV1dX02kBNm2H4fIRX5+WNcNSgFGFsgkgmolceI1qn8qQ1WtIZlQ1jhGjHGct86qjRDAddb5
 He0jPyqgsub2r1KcSi9N8m3cpaeb6RX2jqBZPaJW1VhelCqUHqAG5jQbKlQoORCNvrzogrj3XB9
 mCBLfsk0VXLR7XkQfYgbfVj9ipmdyYzT/roCyUgdWms91UTRqx2YHiwP2yr0YKL9pf+yRNfvY+o
 AlH/0Uk/uPP+o4iLR0wLS/geQ4JicvQdqTSHt2CmPbDTQsBU+sLWQ3B7wzTOLjFut7EdUIZMzRA
 3BQsOda0wyp31EG7X3z6oi0AGyhY6JfU/AxwFJZcKqQjGKi9mHqB/INXC/eIvBHKcL
X-Received: by 2002:a05:6820:2207:b0:68d:2f4:82be with SMTP id
 006d021491bc7-6ae96ec8b60mr11874701eaf.22.1786129217410; 
 Fri, 07 Aug 2026 12:00:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be47604sm2679283eaf.10.2026.08.07.12.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:00:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/4] serial: mtk: clock rate fixes
Date: Fri, 07 Aug 2026 13:59:38 -0500
Message-Id: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNyw7CIBREf6VhLQYutrWu/A/jgsLVYh8YqMSm6
 b8LdWNMjMuTmTkzE4/OoCeHbCYOg/HGDhHEJiOqkcMVqdGRCTAoWAklTX3Z0X5sqeqsaunFPNF
 TKAosuAZd8ZLE8d3hGsTt6fxm/6hvqMZkS43G+NG6aX0OPPX+ngROGeU6z3egUWjYH2s5daZ2u
 FW2J+knwIdJ8J8miCYGwDmTFSqBX6ZlWV7qhQqnGwEAAA==
X-Change-ID: 20260727-serial-mtk-clock-fixes-266e61d2d917
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ePN+55Vua4Cnv6sK7cpTEYH6iHqLl9uFVLeg/WV35Hk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdisd4SqPSJK/RaKo/aEa9ibREkhDZHb3febNS
 lEbgVtPWAGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYrHRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9TgH/2kyo4zZaBrLbir7mvTGVURBuuMEbpVPLY6R4AF
 tVxOLCffbhosPKsR1wVqRmvknHVM1LJnlqoFa/NGoosRPQoxPcTH/1+1DWZvo33LVPxO+p5F17e
 RE5bcWy1Rti0wID89S8WovXpI0Dqla6u6WyOms7Qx8TGsYxapjs5X1hwEBCKx0VcLsYfddc7qvM
 3OO30oZ3hBJasCmdrl6YkdHoxG7sKYIU1I4DciHLZ1+BNmhgnvZPSAgO8kILbffEgqlzZWPneb/
 RbJXDsypP+qmOJ4lM1D/sjal7BRi3RinsWGEl8xEmMwU5+qd1sxL73bgH6wZanZ13Fc86UXO0XI
 0sXs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786129217; x=1786734017;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3sj7jQWdbZ9I3nqt+pX9B/454brfLYuoHxv4ZdFh5Vc=;
 b=Dr7dczWV7+SN3KV+Xat22Ocw34oqY7VWWn3YvlXJm4NjNbLvraEq3u9mZAsfHYXxSA
 eJwXIKpsL1USjBPFmHpx3wZa5KERHr+01ckEb1CGeSfbGOBDBKjMF9mJ057GdCdwtA17
 EjJFeLUha7wq5tICuDHCs0wOCgSle3j7xzqyMBmquIR1LxlWVtQrjezGkwvQ3F+/d/wn
 oQe+U0JvGq2tJl//xEjIm8/z7umQj1QBNLFqCbZJ90g2BnJfE8Qe9865Zq3Ov890ptlk
 aDsDW1MzouHZoWML69+MSrO3sdh4B94HQNTDPr6Cgrzxv+l5Fu6jLwPy8FCti2HtKibo
 eKAg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Dr7dczWV
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

While working on SPL support, we noticed a few bugs in the MediaTek
serial driver related to clock rate handling. Here are the fixes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v3:
- Use clk_is_valid().
- Drop the check before calling clk_enable().
- Add a new patch to remove an existing redundant check before a
  different clk_enable().
- Link to v2: https://patch.msgid.link/20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com

Changes in v2:
- Moved return value change to a new patch.
- Link to v1: https://patch.msgid.link/20260727-serial-mtk-clock-fixes-v1-0-1d5542de3d28@baylibre.com

---
David Lechner (2):
      serial: mtk: return error value from clk_get_rate()
      serial: serial_mtk: drop check before clk_bus enable

Suhrid Subramaniam (2):
      serial: mtk: use ulong for clk_rate
      serial: mtk: guard clk ops on clk.dev

 drivers/serial/serial_mtk.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)
---
base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
change-id: 20260727-serial-mtk-clock-fixes-266e61d2d917

Best regards,
--  
David Lechner <dlechner@baylibre.com>

