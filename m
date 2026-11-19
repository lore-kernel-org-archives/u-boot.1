Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48881606A338
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VpekLfp4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26451814D6;
	Thu, 19 Nov 2026 18:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zkIEWQiq_aSw; Thu, 19 Nov 2026 18:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F055812CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795113309;
	b=A7Bb4qOyFoCzQhZDe3tF3MqNbFJ6EJBsnbXDkKxrp1sFr4oBGkXgGinOZFWXRlaFlKv1
	 +2Kp4Qnb/rCCJm9sa3ZXmB+i7dgo+HWFH9p3v6ig3EFKwLv1AB11T04cdkm4LmzmWYOVx
	 p4YG3gzbz+EUZW1Saa1zHj54/ajrdWp3cJ/CTFdHI1WdNGOvgTVaGFxNhntsoSkiBpZeC
	 WUvG7IaIuSzDRacvoqNFp/IMwHEUXm7u3801Wr3klO0BK3xUk/68I0R24LOmG++GFdVxX
	 H4U6S+uhjcJOIKxsV2n1Ta9CJ8E/ID3+b8oQbsi9avL5MteEQq9UrtF0mpy76wcohYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795113309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Subject:To:Cc:Message-Id:Date:From:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Kou4bkj6UiK1saw94ckesKjv6SDIKQcI9idfBvWJZwo=;
	b=Ux/uPmYZ5bIBUMPInDw5GbR/l5lvkqh7fssgnsI3DMDw2/G3RhvrW8PBenvLkSQUvo+Q
	 m9sJVNuOu5bNAA4toQALU3fBBrbOo8yNhVQW37a/8ArV+IzJHg4ikarD/MCFnAn7Xy47B
	 1nviCwePEIsbKbUQuC74e+WMZuqDh+djxaMCd/QuTGPu23sgYjWfwQ0F2eeEylS/pQfQw
	 PD20DPf+4vTj+lB1XQC6sg4Dt0LgP6+jLyuaRUVbv+ThwiTLRYPRU5UAnEq3O6nzljc5b
	 Vj7AE+OPRM9I/FYf18OlgNkvw9HZWungSR12oxN9ZpzgpIp0VuUNKDJYzQwZJZRg10Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795113309;
	bh=Kou4bkj6UiK1saw94ckesKjv6SDIKQcI9idfBvWJZwo=;
	h=Subject:To:Cc:Date:From:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VpekLfp4jUJotkzfwC0QKay7DEgE/+ubKZYP7Innl5fRu2ua5WV3tWmm6o0+5XQyk
	 o/SlU1cVesqVm6xDpTNLtdcYJ+NVjmmeMJlVoozEgIYF4e8JobjMZmKkTBe8floFOk
	 3alBeh13FQoz5GjpHhqHCqHwgPNPYlb1SAcjfilWCM4iZwXJeUbs9HnXS2kftl2GjK
	 4i2vrPNG3e9uNi87tOBON4u1cbBlixUNvDsVhFGy3CweAvYzIAcDWzMBzKXbAA/JQc
	 znGREEYVgYKGBEVHvA4ShpSZgTuPxnxuQrLXdrEo1he3QagEQXuJuqnYb5/v3pGKAr
	 XmCO7iQ4J58Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F055812CF;
	Thu, 19 Nov 2026 18:35:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39AB52F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C51D60D5C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 58QDMMudK38b for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8723060699
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=213.95.11.211
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=213.95.11.211;
 helo=verein.lst.de; envelope-from=duwe@lst.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8723060699
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:35:05 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2005)
 id 30B9C68BEB; Thu, 19 Nov 2026 19:35:02 +0100 (CET)
Subject: [PATCH] pci: fix NULL deref in pci_bus_read_config
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
Message-Id: <20261119183502.30B9C68BEB@verein.lst.de>
Date: Thu, 19 Nov 2026 19:35:02 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Torsten Duwe <duwe@suse.de>

If a PCI bridge device does not have dm_pci_ops at all, do not even try
to look at one of them.

---

This popped up during work on the RP1 peripherial:
"Why is a dummy dm_pci_op read_config needed at all?"
Here's why. Pretty obvious.

---
 drivers/pci/pci-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index f4ce630118f..41f2adfcefc 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -367,7 +367,7 @@ int pci_bus_read_config(const struct udevice *bus, pci_dev_t bdf, int offset,
 	struct dm_pci_ops *ops;
 
 	ops = pci_get_ops(bus);
-	if (!ops->read_config) {
+	if (!ops || !ops->read_config) {
 		*valuep = pci_conv_32_to_size(~0, offset, size);
 		return -ENOSYS;
 	}
-- 
2.51.0

