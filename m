Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146ECC79FBF
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7E85407D3;
	Wed,  9 Sep 2026 12:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9oWfhL1RP08R; Wed,  9 Sep 2026 12:46:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1C2BC4073F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788958002;
	b=kzfv8GHXOpWhXH1iN6m4gs5aLMswgjswJPSQbXMhA/J7Qzxx8tKK4/CZxjT+RLvv/ff5
	 ba3vQXm0vkYnnTnxBxpUsuqRer3L1Z7KEJLpWQS0hZADVqk8XV3GYNVB3LNqBWrwipSyh
	 34NIsyZZvfPrgx5tSXlUtnAnUq6pNXD2S9R248GhujnaII8ghw6UJS6Ocd9UxPFNNzhgn
	 gZJF6dXB8M05HDChvOvDXdc6xoJvjWuwhvzBVnH9p5FvCfzaRnL5qrZkxOIGVgqTC/rQV
	 p9uKNTEL5s2bYl0oN0bzULuDmpvstn+gNRyoFAHYA8kcd5xRSzF0jqAoKQN75giirBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788958002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
	b=barKz8z7H/JgWcVYQd3ZYLH0W8jea3DKM1Gd6qlVegOTxIEOydjr2mOk4kB0aLAiKhnA
	 tUICwVbpvqQB+6OQ/D7I4o200wi4Ar/cm4aBUtYWUqujBJqjVOMFAQFx44XFb6ukIiKPe
	 4CyDDb3ZX10eg/5fvi1xqppUP6hRk0rZMDF/doQefw3uSE/EAAyO0r0JIYiAABvAbzGgP
	 EjaZm4cajTVx5GP+weFMuRAxmyee9YXkQ9Z3dH5QHJ2txEzbBusEJHyUlUuT3kRaS0QMk
	 B0/1dWWe8KmEVDfwF0FlHt7ujon5nov/FVlEzYORr8SxWuzdg5TzDIFDzlfi2ZyicXQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788958002;
	bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TiK9Nm+FG6ss6e34XbSMGpSJSjs0bx/s3P+DA1wY+LRVNTn4sfZ4s9dsqi27J9bve
	 J8/SehZhN2v0sc3guE4A9sqWeYBrwkX6oCEXBlcaYCjPCaukM+175AfMNJpsbGa2kQ
	 hsTajgFXlQCsLUQ8KH3mplSIbxm4BSMC9gdwO6kDVS4Xm0rQR9G0eSS4cLO7Y8aOxG
	 XxPE5rnei2+IiKl5HiVgoU11MAblypyxNm5Dh/IPaIVir0/YR0joJi3PZEVYBfVO+D
	 s4hm4KUL28+2QVOAnV4empQdNFBueAvZWBi/B4CsIhfidHqbZ00UK1cahhFhkswI3x
	 hcBvXouGLeosQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C2BC4073F;
	Wed,  9 Sep 2026 12:46:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 717E2724
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6344F60639
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RSMj26sI77Bq for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8C928606CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788944009;
 b=BGqVVZmnr7GAdKmMb1SlPqrvznb9WdkevpaKv7qRR7B3GmaYWH7KzTYUywFj4ZloO8Fy
 rBlasJ3ta4jy1hIOdngxdexK7MrIkZlRZc2yYAHARE5bZgP9xigOnuWo/5I5tsSYT0YjC
 td/zcUiKyEno0y9dXSkPVnZzE8EZos5inDCbfLqsb6IvxOE8nxN1zH3U7FY3nWfUOrsOE
 RH1IJ5U7h/Qra0OrUB157/J681glYQoIb97Fx7e1plNETKZNaIpX4IjsGCqCBGQcCne0F
 X8kIMMQsJe9W2e52szE9nk0Ns0rj4ALgzWqpwDXg8nkUZUGIqRQ8L4jH/8L4RHDS2SA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788944009;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=aVccZkyMdkAQY3r4Z0ynKFH093J9A9jl+gvOiApgqw8XW47jd7wrkEVxvVCHu6hWcxSR
 m/FurnmMJHtl1ZHZFNJb0N3py5nkzDksQRpVyzn4nCz7mJZiFZrOCNr0+QVAkJCvUC6SN
 lLEe37YxntiXDbZk1OYCGelu/iDy1ua8/MlrVNp0A78CzJly50q64skn7paGMHdWdXmA8
 n8uVXU2sCVGFTghLV9TkwIciEOq308hlV4M2Ofiad8oDpIAJpbvn/wasTvsDdJwYbQ8x4
 1T88kk4ZIvxf182QntqGbwsYlIs18X3pxfB3QxzGp7qkmueoZeVkPg0NT5YBIJFH+fw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JQ9JbhA1; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=JQ9JbhA1
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C928606CE
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:29 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c25085f2422so66556266b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788944008; x=1789548808;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=JQ9JbhA1kT0qXnYXe248tMkEABuaIysbmG+OszurPJFVi0iWyQd6uMLmETB85pG329
 6z+4mlAmkB55upvhkCk7+GlpFf7LHDLQDYbDHgVSxA85XY4nGsyivbS/TH6id2yoXOQ0
 MaZ36deoyNpiBOXA1MvbXYbAz8d1Kn9OCa3ceVXvgVYOe538mJ4mpoC28RLb6TyGqd6T
 PO9adMFHhfZ8PtbypL1R7l9LmiFr5Bg4bM0M1e9cV6g2BS+JlQqTLljjZ/9hkp6nkebV
 hzTWLyOZ7b2nUjVf8puARgT8WDf/j8GiXC80kBQupqM8OqUSo01gBVJL1AUibjohWICk
 AyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788944008; x=1789548808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=mjxfm1aG9rederX9QampR/wCAS7f1fHJga1OPGB/XjJTy892VBGyChwsqx2noNHy9O
 bie6SeRIN5QJN+TQyULkliSlOX1QTWBSjw2uO/N21Tdqkd5PN06JrWL23DOOVCZdlg8R
 iS5CyBwNonM1CjrYYIEGIZ9v6tara1fBsfbzj4C+UMaVsOBW+icnii2RKwzsdfzb8jzT
 UdbkEx2PyO63w4iboglTwI6lea5hZji3OuLyZuLkj7Zb1z0M02+TgmLI/XyWVl1NgRHb
 u2MG8P1uXiHcnhacf9oV3EJ7yt51vC6Np1E/ozeQeCgHq3DvNyuNBprsx/l77fF7l72G
 UVIA==
X-Gm-Message-State: AFuF++k0/pOmJeb+q/xyRZHQXYw561mUgkrR3K11IzDxDK4x+IfUAI/x
 hJ/BH9afzUy/WVdBsZ8pEO/UAtNh/X4jStZr1fptEBsL6cUgw4pqWL5iEPx1GFJrpQMvbJcot16
 YEqaV
X-Gm-Gg: AYBFou1paz9yhqsnjXcpTaao8Hy6Pz8GXow6uBHO2VWq70+k9RVNEjaXoM9tjrNgopf
 Vk4QXmzGQgIlCVcFSHHjZTbulfXQdupiT8JSddeLQDA9OcubPDIck9j3PiEoFEmlOFUzu7kceeC
 lWjjNauaq4T3WLPiyoxvOA1APrU+cV3jey4q2Lkn2qB621FLfyx9MHt3XMk4A9zNoebN2LqpqMm
 PLX2lr8eMTKEHqUDGoIiYCqM2O++0YhMmKfm9+AYG5ZP1OTLsUt1Rk1jsnqCPFs53sJdB5pMlo7
 CvbTrmgVByQrrF/u7HUFcK+j57L69xFfPLk6qIzqFO9BVW2vnEZgEf51R2etC6dQ0U+1yB4dhlY
 bapCHly1LlpWJawKDnOcau+hazvoRw3PjUhbeg/GZg3fELBH/wWvS4lsK9v6aRzx+8phM97sZbL
 ToNATfNbZT3LbRXA6LZdybWjfXx5Jgh9oHLVV8a07GWySZfDg2j+k30x5z6AXvmOps4NF9ogIdA
 An+DpGzEbLgikB7OJ8JoetL0IcZUyxK
X-Received: by 2002:a17:906:4784:b0:c25:3ccf:bd9c with SMTP id
 a640c23a62f3a-c2625012ec1mr1041945166b.2.1788944007600; 
 Wed, 09 Sep 2026 01:53:27 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262f97f1a3sm557381266b.19.2026.09.09.01.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:53:26 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 24/25] usb: host: xhci: fix up after the resync
Date: Wed,  9 Sep 2026 10:50:14 +0200
Message-ID: <20260909085015.2480097-25-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

Adapt the xhci glue to the re-imported xhci-ext-caps.h.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/host/xhci-dwc3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 3504a7cf42ce..488d39fe72fd 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -51,7 +51,7 @@ static void dwc3_phy_reset(struct dwc3 *dwc3_reg)
 	clrbits_le32(&dwc3_reg->g_usb2phycfg, DWC3_GUSB2PHYCFG_PHYSOFTRST);
 }
 
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
+static void _dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
 {
 	/* Before Resetting PHY, put Core in Reset */
 	setbits_le32(&dwc3_reg->g_ctl, DWC3_GCTL_CORESOFTRESET);
@@ -79,7 +79,7 @@ int dwc3_core_init(struct dwc3 *dwc3_reg)
 		return -1;
 	}
 
-	dwc3_core_soft_reset(dwc3_reg);
+	_dwc3_core_soft_reset(dwc3_reg);
 
 	dwc3_hwparams1 = readl(&dwc3_reg->g_hwparams1);
 
-- 
2.53.0

