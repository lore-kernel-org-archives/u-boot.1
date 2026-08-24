Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D552EC5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90F468123E;
	Mon, 24 Aug 2026 16:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CxLZJCCkqb-4; Mon, 24 Aug 2026 16:47:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589953;
	bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=njHmNSkMeOCurCH1PRLHqPswiQxNp862OO4Y7KwitsdU6S5NJv8BFKjrrrd/FWZ/w
	 MbcIsmtg21coS5L18uNtcovMu35ZpbDrLD0lxrEEkHv/5orAeRyy/49sAiyT983YYx
	 21y5jwY7RXK0kI/rpxVOfXWkXQRqmSPXxnDOIj/YhpDdFlGfnzO0GMRY9BjUDyE7r3
	 foBN5XaJR0x12ZGnoRGQx5eveE5jMyEzETwsbHmDJGpxR18fwg0CB/Sw4AjIbwJrZY
	 wLSLsF0jIcHGDpUiU+dVPlLWE/9TtWzMY92I/dRIgnNOLRGKW3n5bnlXKaSjGBzM+n
	 z0rBFwSNBnTIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3496680E23;
	Mon, 24 Aug 2026 16:45:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22B5129B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14C8140540
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TFONQj2wSyVM for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Z00+m7K/
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F9674053E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:14 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a1f56768baso558011a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586192; x=1788190992;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=Z00+m7K/2hJmFWSgw96LpHA3+1GFSEsbivAOrwzZcvojcBPh5GoB1MFbrf5BZ/QEPv
 IZe2d3sab5wRjkPi+qopUx8pxKBWNYfPmanSw4Yo/KBymj9PqtxKMATOdjpmSUD2JEJP
 RzL+YBT6tfMkwAqiVclCQ5pFA7ERlRoby+o0eLYeBz+Dp9PMtnmxWBT03a4RIBwBia1h
 4ApjwDJoWgnqfjAg8ZDjx/DyW4yDbi15LQaFHM9lKKIegIyZ0I6Z53ISpHj8RS+8o+nd
 xqJPKX0cuZAsXnTRcIgFoaFDKpCG2YYpuH772XiOCNL1K1WWioPRQm5tjFYP2eQV8lLW
 29eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586192; x=1788190992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=owEVEFMJAd7q55XXzAEzyCvalb97RFW+nygb4e3NYERheTlZu3C6uPfeC6j4kDZ3W8
 V57KiG3jhG/cVP0+4fFLHaIXc9JcyLReR7bdAxolY/MfWq8YFgCadQJjigFHAIwx48dn
 d0aCfg15LE7fD0wfFgKyLzL3eohZLjL47zaA+ovzdu0V6k2OMbk+4zvYGSEQvd8YHNg+
 NGEiXcY0WVvWtHOam7OG80p/LZrcq9WRr/TAtSRKdL2/880Cc8ROvFtj+FvcUlNLxjRC
 42YnFFS40I105XGHTeEWgd9Krf7kcHnjrZgPmYHquDob7uQHWr88h5X41ltmjjaODKs7
 fjjg==
X-Gm-Message-State: AFuF++muN88ku4kBfg0+6ONcZXIfqa4IUcuMPgZAdxuzzQvzhGY81Zto
 2+VKXQ1Cz3Sl3mwsKwh0j0Pg2/WbqheZP+ox0/+sqTdvSXg45amt+V4QfKoWQMgMzHxHJHA9MWj
 ISMuv
X-Gm-Gg: AR+sD13Yctte4tGr7MJuj+DkYkha6acyaQFBg4HjNEAT+MZAZJ4CHIApafRbaO0c0yk
 Qt+lrVI/IujCUXS2BkHZTGrSUItVhNqrhgC5ucHbRQxg4rLOHrcOtKdcTExWeF1J4WhIAGP7Qxs
 Ewg5Y9NY2RPlPafJi6M1kDc1j/DB2ivYxfI9ijRcLi/JAmYGORZBscz8TdhVeDwjdMYIyH57Bod
 BRx8cjKFIcnZr6UuELS6U2gNJqPaoBm0ma0pW/zdM1YdZbcqDIykWGAZwFrW4QjP6S1/rmr6ZZB
 FD3uRbYRQiVcRcWQ83/MmQpkCAjXz4XJTu1mluu/Hrw0i4U+HLDWBbtKOap+w9ioDvbak32IQBb
 MAhCJnFY8fx03Y2XN5Gl/P/stBlMHUp7tl5mtL6qJwvN8KolJJnYwAQneBVClLUuiOvBosHnLkP
 d+8bHPQ4AnupiXyogq9r2Mbhx4l97QYkPkcSTmtlhipN0LAu5UA6dzAgn4B49nMMkohB7ITxxBN
 iKGzn0aS7pHTQ+tssajsA==
X-Received: by 2002:a05:6402:4597:b0:6a0:f1d5:deb8 with SMTP id
 4fb4d7f45d1cf-6a42eea451bmr16840823a12.0.1787586192546; 
 Mon, 24 Aug 2026 08:43:12 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm13368763a12.17.2026.08.24.08.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:11 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v7 17/24] usb: gadget: at91_udc: register with udc-core
Date: Mon, 24 Aug 2026 17:41:26 +0200
Message-ID: <20260824154133.217744-18-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

udc-core provides usb_gadget_register_driver() now, and it only knows
controllers that called usb_add_gadget_udc(). at91_udc never does, so no
gadget works there.

at91_udc_ops already has udc_start and udc_stop, so only the registration
is missing.

taurus and smartweb call at91_udc_probe() from board code and there is no
udevice to use as the parent, so pass NULL. udc-core only stores the
pointer.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/at91_udc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 5b0c55d59c8d..ee2af2d699ff 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1494,6 +1494,16 @@ int at91_udc_probe(struct at91_udc_data *pdata)
 	/* Clear all pending interrupts - UDP may be used by bootloader. */
 	at91_udp_write(udc, AT91_UDP_ICR, 0xffffffff);
 
+	/*
+	 * The boards call this from board code, there is no udevice to hang
+	 * the gadget on, so pass NULL as the parent.
+	 */
+	retval = usb_add_gadget_udc(NULL, &udc->gadget);
+	if (retval) {
+		pr_err("failed to register udc: %d\n", retval);
+		return retval;
+	}
+
 	INFO("%s version %s\n", driver_name, DRIVER_VERSION);
 	return 0;
 }
-- 
2.53.0

