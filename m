Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B94C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0F8885A8;
	Fri, 26 Jul 2024 14:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="C5L4NVYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5387D884DB; Fri, 26 Jul 2024 13:59:06 +0200 (CEST)
Received: from smtp52.i.mail.ru (smtp52.i.mail.ru [95.163.41.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED3580C58
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 13:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=5nIGKt2D5YFVF/LBfbI0Fk/GV2FZnkbkPAHag6MV84I=; t=1721995139; x=1722085139; 
 b=C5L4NVYi3uvtdEe00pKNqNnrtn2wEucS5vmGRsTlMRPYe3BgtX2f4iLUJjAtllR31XAbFATzeil
 wpRFtoujgNZ3YGykNPr/R0SeZwQnAakfUyPZJZ91+RlUIBFV0bOLIt5782V23Sk1TPsWZBHz1+vLd
 BrKhAv98CK48NioqG1/xUP8yYHex2wnS3eENJTbu4yDmv1N2VsDbMi0CJH3dGVrjBjPoNQybhCcmI
 5o5T5fjpDHneGRigzh+vRJnhubpsfefJEn3LQ0cd+fVvgKJmoI5WSw/BeOglF6C/A/ZSoKAh09tD5
 jqSAIZrNQjC9gOyeFQumidy6SZGljot986AA==;
Received: by exim-smtp-868bf69f6c-2dtrj with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1sXJb6-000000001PW-19Mp; Fri, 26 Jul 2024 14:58:56 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: sjg@chromium.org, sr@denx.de, rasmus.villemoes@prevas.dk,
 pbrobinson@gmail.com, Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 1/1] serial: ns16550: Add clock ctrl to driver
Date: Fri, 26 Jul 2024 14:58:40 +0300
Message-ID: <20240726115840.149817-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-868bf69f6c-2dtrj;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C61A13D99F4944E7212A013F29C7F5C920182A05F5380850405199A9271315B1DC3DE06ABAFEAF67053CF92DA9380889885FE6BF42C7EEC79F880CFDCFA9C15CC8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A3295C83650092F9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373D58C44ED3182E498638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C7953B14B2ED4101B23C1F8E65F7FCD7F3153D4015DFFDF020879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C05A64D9A1E9CA65708941B15DA834481FA18204E546F3947C7BD21ED50D08CA4DF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637FBF931FEADDDACF0389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735D028CC0B556B22BCC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5C7006A1E474B2E215002B1117B3ED6965E3E22D4D16EFD808D59E407A97E9958823CB91A9FED034534781492E4B8EEAD09F854029C6BD0DAC79554A2A72441328621D336A7BC284946AD531847A6065AED8438A78DFE0A9EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4CFE6EDD9E11656DB7C78601F5810BC8F10C03FB59F205C9D79F0D6F903E7F5FDCB9935FD7D732077D42B5C1564802C6634FD0B63F315E9C72719CB5B4AF9AC0DD0D330B7754D37036DDF96CB8D31E6A913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojW5AakKLSukPjk8+vXcGrFQ==
X-Mailru-Sender: 689FA8AB762F7393C6D0B12EA33CAA9BC0A8A41115AA10C3DB1E1E56263FEDA3D583CD998223BC1F90DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Fri, 26 Jul 2024 14:43:57 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add code to get all clock inputs as in serial DT node. A clock
property is an optional feature, so do not fail if a clock property
is not present.

If a clock property is discovered, then use it to get clock. It
marks clock as used and prevents disabling shared clocks.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/serial/ns16550.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 6fcb5b523a..d2065a77bf 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -513,6 +513,7 @@ int ns16550_serial_probe(struct udevice *dev)
 	struct ns16550_plat *plat = dev_get_plat(dev);
 	struct ns16550 *const com_port = dev_get_priv(dev);
 	struct reset_ctl_bulk reset_bulk;
+	struct clk_bulk clk_bulk;
 	fdt_addr_t addr;
 	fdt_addr_t size;
 	int ret;
@@ -528,6 +529,10 @@ int ns16550_serial_probe(struct udevice *dev)
 			return ret;
 	}
 
+	ret = clk_get_bulk(dev, &clk_bulk);
+	if (!ret)
+		clk_enable_bulk(&clk_bulk);
+
 	ret = reset_get_bulk(dev, &reset_bulk);
 	if (!ret)
 		reset_deassert_bulk(&reset_bulk);
-- 
2.45.2

