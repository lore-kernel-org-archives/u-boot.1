Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1291CC5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF0E0607B2;
	Mon, 24 Aug 2026 16:46:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yuWx8p9Kcz3d; Mon, 24 Aug 2026 16:46:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589960;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GTyEStTuC4Tf6FfFlKFIXzJslyYvzj7qdUUHm1GW2CzPyRJEfncUsjlzkQ8QzjUbJ
	 bXFg8lsXp+Cgglr9qcIbpsBKj2egiajsA1Rm2BbQh4OxY2tXPaOGAXJ1EEMJmqNyMz
	 bfPm7S+AiGC9/7RD8xQj0nlyFKnhOSc2NhW5/XjArZJOaIyPY4HrTFpX8NJMTGcxJS
	 Yle7xxZ2UWG8v2be7g6Ekv5GgSz6vuemxcG5NT3xGyjoi5TLwTd24Zl/BSboCmCUpn
	 BFlVxa2WZ/WZko+Fb7Jx0DC6ZK/cwVuWh7d0l0jjS0b9S4rSrcSSQi4JRagxR0cQr3
	 Dafep4il9ET3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1C4060693;
	Mon, 24 Aug 2026 16:45:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52438386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50AB140068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-QTTVvbXKJD for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=wtTw71Us
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D84840029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:55 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a09571dd5cso713207a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586234; x=1788191034;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=wtTw71UsAuv7KIga5sPxLHoIjIrPr5+DLXIFoj2bkfufG+vOGMFC9YWcMEw3lmxTU+
 vaT0/iHF1ZVTsskIS9b3WRDY0gtscl+GnVe7lK9UD9NpzCRM3nRAdDCubbW93JOfVTTx
 fOwXw31jUzLyRiD/ySI0VnnlmGZD5E2/umo6C1fWJFvDEwEaymc/mG7KMsMb8Uiija+a
 iOHrNqjM/uzVfSV8jGSbBpmZ8VfJsn2AiuwhflSkNKlldOa9YsOid9ONYW6erWWImeei
 +6+uVx1KlYDFfd+495OxCll7Vxd1VX8qnqjSExYIOKHXKoX1x1dAs0hCU5qWWhFT5YP+
 doCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586234; x=1788191034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=kx1W4dRWL2wtJmDGhe0GqXUDApPhUkDF8H5ANlUNekMd0gAXfD8b9PwMI8+R7SUZsn
 yPvsfbVW3dUscVzKlVwBVlDqbfc6qdZZrMVo+4EqK6FmzOg44WZCQwfWRrNyVsJslFCG
 DQtG0mcFEzR0KxYx/GW89ADtjBc4tboeco6HYBZpWuRGQ9Eh3L637RJU31+RfwXI8DbD
 FCU6romYT/5NL+5LCCxtiM22HZoI3gP6HuqH2s1tBpaqNkFRaWFJsJP9XU3ZcLuoWkJX
 D+kLeoL8A620IvlhiNWjv9RiYDaRbz3veLbNmfcPBfqv/yJHdziV/Q33ZbT99cHlwwsZ
 s4pg==
X-Gm-Message-State: AFuF++ms5grAFPzFajfStMQEuDr5Aaf7bj6NsLWftrgfmqjSQzMjE/OY
 iaScMRxWLtkBr7Ol0B0vicTXR83veppC8nmav8VJ4MHJQOHtBnByLAat6AMl9wInrranTzjlovk
 CHw6x
X-Gm-Gg: AR+sD10KCapjtWRijf9YpSxh/tFjG9KBJ7Xf3ET8BsZVgEDCaWw9rJEyTDWONW1bBR4
 mgCI/KJ5fDO7KOdBu5gdmL6WVX6SLJ+2v5d/lAGrB+kqfKehblZnr5m1ANVD9+StAawrLzk5+5L
 ldZeZQGlm9BvRjj2i9cYQ2AnWkEf//9ApHL5NUfsXejnrCv2lsXh3dmxAfG32MQuhMJv4nAeNQQ
 vVyiW26smNvqiO3sIhgGecaHy9BOUWXT7kh+fkrIygERKZnW1fqx8ENrzpIXcT6vJTJUWApeOfg
 7H6//66Bqm42MGzEXaLdffpD6R3iq3J2sLu/5LwoxEJLewnn1Df+r+C2Dmjb7ZNdN5TLV7fSRb3
 BLF66w6lARySr87gf2trU2hp6Zf2r+EDFAIkcs6PWhk/BDNDRM/N0/MwjLwio4M/IJHegi42Fkg
 TjS5SB8TiZ/gEw5XOOVgm842IMfvmU3M+BjnuefGfobnTfsQ+jZl7IR9fjAIQBcGwAe5YIlrpY7
 so7HpQoQ8Xhww7X4ykVfQ==
X-Received: by 2002:a17:907:c19:b0:c21:6f8c:231f with SMTP id
 a640c23a62f3a-c246a2e942emr1720416366b.1.1787586233887; 
 Mon, 24 Aug 2026 08:43:53 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968ba7b6sm1268749166b.62.2026.08.24.08.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:53 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 22/24] usb: mtu3: set endpoint capabilities
Date: Mon, 24 Aug 2026 17:41:31 +0200
Message-ID: <20260824154133.217744-23-anders.roxell@linaro.org>
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

mtu3 already uses usb_ep_set_maxpacket_limit(), so only the caps field is
missing. Without it usb_gadget_ep_match_desc() finds no endpoint after
the dwc3 resync.

Set the capabilities like the kernel driver does.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/mtu3/mtu3_gadget.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index da633faae7b2..f209bf47d073 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -591,10 +591,20 @@ static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 	/* initialize maxpacket as SS */
 	if (!epnum) {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_HS_MAXP);
+		mep->ep.caps.type_control = 1;
+		mep->ep.caps.dir_in = 1;
+		mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep0_ops;
 		mtu->g.ep0 = &mep->ep;
 	} else {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_SS_MAXP);
+		mep->ep.caps.type_iso = 1;
+		mep->ep.caps.type_bulk = 1;
+		mep->ep.caps.type_int = 1;
+		if (is_in)
+			mep->ep.caps.dir_in = 1;
+		else
+			mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep_ops;
 		list_add_tail(&mep->ep.ep_list, &mtu->g.ep_list);
 	}
-- 
2.53.0

