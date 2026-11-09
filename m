Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9239606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gf7dsFJl;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKmkqn5S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B111D80DE7;
	Mon,  9 Nov 2026 08:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1jYIf0B0yUo; Mon,  9 Nov 2026 08:07:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03FCD80F24
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794211626;
	b=jKioxM+ph2Ht6aPLGwB7miy2DnymkdRZQKg3BWPksSJEOUSZQDL/pxIGw3sL9eBKjCA7
	 iIS+skbCzqra27lQGxuslX75uep0nsgCkzazYduxe02mlR98o3awi6D8+Hq9JJxFM/LOc
	 yPQMQQhsVwxfaDHKughALlSb4TNN346LByiZ1JpWkrCNfTt/upnBQwWxqlYoaHmNiXeaX
	 q0ixQDNC9fMjHtZzQSBezvlfNzH4Hzmjqb9k6LOeoSYRawITXtSBz6pXFIcOmY2Jh1WH7
	 qADJbmLKId4gbGjFK3wph7i4NmNHK8COMvTauztHBe9yCASJooYD2CkUUCKxgaGqLPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794211626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3dH9St7kCErlswahcsGx2/sPrESbpiidPxLpdVjkphU=;
	b=BKJpQ65PQCzqupCtLWDyOA14jaqrTNDcu7wvaWlebDgxGesV+Fif+GgNmzjibwVwgvz/
	 FfhAOpxOT+mAzhktJzv72f0JEfkI6Gu8jDIX/1VBmuLgFJJPrgnTxTfaeOYNT3HWpb63u
	 aKttF5VRjcCDdiD26s/tlij6gL72bXRNlN2J0ZcB9AaqgQax+31zjuF0qZFJQ+/lzQJV1
	 HwH33r0iQNM5cnq7Y+UBhl/RMtvkg7QY8RfsCK1xA6V43D8RW+YQfuVjgxzXYLO8GNklm
	 0peL1BH5DrRNaEt7fKWKyyWq7+U3NiuDjMasx1qWW0iV0+ZnsbcXUQLSVnqQ/YB7izg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794211626;
	bh=3dH9St7kCErlswahcsGx2/sPrESbpiidPxLpdVjkphU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Gf7dsFJl13N22xZQTzXYBtpHMMu7ltWvBwfcJY+z7lpEtwjEa6DtY1Z8nIrIfPdzW
	 tvpVynTl+sg3tLZCt+8pewiUHf8kI4P/bp/RiZBbQA9AxtO6UG0SbnDN4O6D1RT64c
	 yg6E25RkIbqwrcFp7hm7Zgu7PurcsVghPI9UG8UOVsVAN3tEYWksRIU9dcSE31TYBN
	 hzqTH4p9G7sSV+i8V9LI1i/9XLTZXoRXGnAkF3cMHnPx+78WqiD2ZlQ+aAcU8btz9C
	 zfaUcwrwjlirKrknsA4JMVuo8avx62ltuGPxxlirFet5mljUe9Wvd9idIKo0jMArWr
	 ouKrNzEKEzQrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03FCD80F24;
	Mon,  9 Nov 2026 08:07:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E899F235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA1366072A
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g1ZWKte7LIoB for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 08:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F198560703
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=nKmkqn5S
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F198560703
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:07:02 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4c5d8c7f326so199231b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 00:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794211621; x=1794816421;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3dH9St7kCErlswahcsGx2/sPrESbpiidPxLpdVjkphU=;
 b=nKmkqn5SbrCG9Xybg/M2sP4t/sxR5OCnBjZLy8cJU8zThqN5nD/V9XxHE/iUANGWTJ
 SPo3ieWnVppVMPLgPOQE7Yb1mxcY0kxuMzCygWNL8uBuSe+UJJkU3KjEQGwZAMds26E4
 P9epBSZ6N759vwWolFLD4hffK6Ei5kXtZj7L8O7i9dFNMkrwJ+V+4XuJget5do0/jFcp
 korAx0sGcfWDAEjB7s+xfyvlCfvQGciIYpjxThfoX8eqnvAungBJkW1j4SENMDNGDGod
 elBtmFtn8bIJ0pmoDugj1wO5iCkNbVo2RMei6lRgrvKy7fSMYjGBh4GUtquypbt5xAJQ
 Dysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794211621; x=1794816421;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3dH9St7kCErlswahcsGx2/sPrESbpiidPxLpdVjkphU=;
 b=OTJl6c6OduSN5ONEWIc+IrPyYg/beLC01uAIppnbDiOgQECToTxrOr+AgijzjJTCwG
 b5otPZxTii7ZY6Z5fJ8IG2sB9N8aqIMDktennkWja1Iubo8BRJXx4FnO3UfUv79qcV/4
 4h89OgCHSZdHrhVj2DBP8LZYCEZXHz48UCo/XF0dUYzKxYsC0pPmB4RIcQR/enPRFuZ8
 s4/zR6x5JX48csVDojfuvjyf2+PKSNfxdc5Nz9R7hC0Qyzft9JohvG6X7szfphliOZtz
 DhazePo3zOGs+6CvZrpGUkhw5oFBdyddpnyvdjSzsbC72rXhclj5ouMjKlfDaBq+FgvN
 /H7w==
X-Gm-Message-State: APuU4Z/960g/u3Kea3GHZ6GIG8aJDaCA/n+3fc7yhiia6MSfbceC3XdN
 cHR3qqtrws95nDMJlmNsJMCL2/Xcf1WYRdrPHNGsSCqGzv1EQ3ZoqHYL
X-Gm-Gg: AYBFou3kEVqSGBsPA2zAb1MH3AvWaWdQc4hyUTKMHizaCS3dRPUDfi9LWNaq9C6hPHq
 2YuX1fDYMJAm5Y5iY2kc2pUMdGEx2+eI+qc4R67fXKT4QVGPx5NM2SyWwoodobbIevfjNcfSgL5
 PSKkLhOC+sG7m513p3TEJSC3aTHS/VlvJaXLdYxFKSPz2WcRc4S2nysXJko+dx7IN0e47IskPCh
 S5pTkuub315UGskwJzuzJ6gLrtvtGAQlvYgykfckDKZ5iTTiYNRQG8fSV3F7YxO1jkYUdKytj82
 pYXsWupnYSUgBi8DWtbsMWTYe/Lqt/LtdvjHeNm9j7DapXu6HkGn5q39WNZFbqKilHn66whfbq/
 UPE9mvOHdzJPfJO+GoPaIsJCyB9QJHbXnJuLMYDVHth80Ax3R+82wi8iLA11Jb18RKil3FTbi8l
 pCtk8noZHsrK1LZWf5etNT9dxYYQeyWZsIoY74AJRgNnTMOM29b9MUAMGqWkbBeU8LLnOMuW+fM
 K0M1neJct1eBTX+xEkAGvnnTeyxMeQFNzNdWF60aa0mt3RJHvNQ6No1JqQrwQyTC96ZAV1+SNLl
 //zrSMdQvfvdYsKaUm75q/uW7vOX/ysrD06VhGbxTkEJUZkPkRKwYvRtwrN3cjx4UJQ6PfpT0KY
 XNFYXa97wMYyZzow0XH2L1xOFLUU2cByTOym6zJwaVBmDE/rtGeUn0eUSZ/QhnhqIrLRCBRZmaL
 53lovShxo7fSrxNKemeAbdHBZ8knJFS3d6fJCxDgpp5+vPwPYvSmw=
X-Received: by 2002:a05:6808:2443:b0:4f7:d324:bc5e with SMTP id
 5614622812f47-56814738d1emr1808330b6e.58.1794211621660; 
 Mon, 09 Nov 2026 00:07:01 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56813e56700sm3778411b6e.17.2026.11.09.00.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:07:00 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 01:06:59 -0700
Subject: [PATCH] net: sun8i_emac: exclude the FCS from received packet lengths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-submit-sun8i-emac-fcs-v1-v1-1-fb0de3d8147c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBAAvyJ77kISSEn6ldKDblddwbRkVQri3
 922p2EOMzsoV2GFW7ND5U1UXsXEXxqgsS0DozzNIbhwdTkk1LWbZTGUJMhzS9iT4uYxds6nSDl
 7imD5u3Ivn9/6/vi7tRPT8v3BcZzgfWyVfAAAAA==
X-Change-ID: 20260928-submit-sun8i-emac-fcs-v1-5b0185c991c5
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

The RX descriptor length includes the four-byte Ethernet FCS. The driver
does not enable FCS stripping, so subtract it from the length returned
to the network stack after checking the complete frame length.

Otherwise the wol command treats the FCS as an optional four-byte
password when an Ethernet magic packet has no password. A four-byte
password is instead exported as six bytes containing part of the FCS.
IPv4 protocols generally hide this error by using their own lengths.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/sun8i_emac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 41c52f56d7a..0199e2b5c30 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -518,7 +518,8 @@ static int sun8i_emac_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 
 	*packetp = (uchar *)(ulong)desc_p->buf_addr;
 
-	return length;
+	/* The descriptor length includes the FCS, not part of the payload. */
+	return length - ETH_FCS_LEN;
 }
 
 static int sun8i_emac_eth_send(struct udevice *dev, void *packet, int length)

---
base-commit: 1ed1749575f28b406c241218eb6a200574574a25
change-id: 20260928-submit-sun8i-emac-fcs-v1-5b0185c991c5

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

