Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E326FCA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36314607E7;
	Thu,  1 Oct 2026 21:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wsPbjy7cALIe; Thu,  1 Oct 2026 21:24:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7D430607D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790889883;
	b=JKXoVOm7A5GkPEUDT2QqbUXjBOuGTvfkxZ/NXoiRYj2e0/fEM77Q+nQEA+lbnlFg/Rix
	 pJlkyqpLmSiz4wV8EfAWfbwhE4csOJlSefylmxFw6aQeGBdO2uvJZxZYbAqz9sZhvkAs4
	 WdSbXaakwojxH678bDri6DtGJRAypbbP0OeI1LbkEkeBKLj7zzkdx78Mt3rn4kt6Nn9zx
	 B17anH1KPUArAn5tM+bjBvhFcnXRtX+fTV8Bg2fYKNKbqqg+g6fUr4SmKOlSAsr9RZNrL
	 cQIDsXuSGdrtj9ikOomotpWjGWsD2pu/AZPiRPDtMNTyugs6xKSfpvXPeW9CMpgaMAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790889883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7zZP+RZMGL2N7JgQpzlsqi9SKvqCiMmwlsNlSXjN3W4=;
	b=UvAOxLKsVDCeknL3r+CInfVNSMSw+gbhWu4VRj6gwRfsP/w9lRcYQThw7EIGahBm0S3g
	 25pUV8PRltQFtaMmUHSkFUTrLpLL7ziUnTBIOaJYO0umnO9gJT28DxLxl+L/d39Y6bwS1
	 vZPKEEp/sOPKmoBU/tJTnoAcdfs9YL/3nL2zlkZboH4hXhpPpHdUGrvSWfGpdn3AgkfWD
	 PSIAOZfXOL1e6k2LupK+DqYQgbQ/zQqR6Mv6FBWIMns2RzFm6eOoHrRpov5O3605xVhi7
	 OSduZwu4LZPZnctYMbz73eaubIUe/mVlq0o7YvJ7AFLHQW+zZhZuG+CJ6h017HoSm9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790889883;
	bh=7zZP+RZMGL2N7JgQpzlsqi9SKvqCiMmwlsNlSXjN3W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n5NHIkSmb7vepsyhtzjSyjqkaQQyCD5W6ln0Ta9ITf/Wh0qef4Knr2evIspd1o/9a
	 O04YPuEF24iXexhfykxf4HFbnMTvhoJRtz5SEYbM9BRHrH7vvmzJmsqJdr3LibXkDf
	 42cGy8tAnBxp9qcRiCib3f/BJq1XO4DZVocNeEjDWZQeKEn+s39pXJ/oNLlZzxqWkz
	 MyOnV7V8hMXu+x0sad7HHope+7QcoYM7bUH6mrWAupk9VPXye1CMz3JA3zQEbBrR2X
	 IfQFXcCyIrj5I9ps94zTM3hUbhBy3zYa76m0tx8OWth0winz7owexJyOjjVh2Jil04
	 fThU6/omYMx1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D430607D7;
	Thu,  1 Oct 2026 21:24:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A24AF33B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87FC740BD5
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 76Dwcts9drn3 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E699840BAC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887506;
 b=pvVxS/Zv5/Y8AHqdvL+hDq4IIFWVK2apuQl2po1NuJB5Vrn6nWMardRkLeyGYZdz7j+u
 p+sa2nQJkUikKZnqqPIm5i76vS24mg+4BVmTNNr5JDNkbPu43okk1BkJauvY9FmtsuCZC
 JkGBKIGmTM0DFk2TvCTIRX04hGKN07/HkKmjNex1GnAjTyFLu1Hbgo8RNDqsCX+oCGm7e
 YkKAmXvEcfTjaJ/2M1yviNxF0DkUkoc0XhlQVAadtGkhyA/ZKYaTKdq75aFKVpVv2ip5i
 0s+XDVz+d5Wa5o344SqLk2y6R8z1ttYy/mAABZYkT8WxtIG3xxJlwzL0+ZooskJZIYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887506;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7zZP+RZMGL2N7JgQpzlsqi9SKvqCiMmwlsNlSXjN3W4=;
 b=rg0Yk7Tv0iTddj3dbplK6HB3+wLKg5uPxEbPNZZhd6BaMYNC8G64hb2aQs7G8v4bWoxs
 qWLZQnr/nEcsU1LEay38BWR/jQUEQoeRPwJstMbIpQBinvoV4b4rfj3Y+j1UTQ95emLus
 oqJMUoIFByrSOjxLSfza/mGZs89kTctTWoEtTmqJU0ZtVvYrb0E4CWyTC85wpwKbinr1h
 HXUWyPVJSasZdtVitEBXv/NeOVlepvynv+br91a81n9gN8gTxqRcaiEMopYIkTHXD4FFr
 tOwD4oF8fJtxxNJWvx9TO0JTSuxSLO8y6j35rf13uKbDkoi/p91SAXUg1jl4q8mb2uw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mEG7zWo3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::2b; helo=mail-pj2-x2b.google.com;
 envelope-from=lqing2013@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mEG7zWo3
Received: from mail-pj2-x2b.google.com (mail-pj2-x2b.google.com
 [IPv6:2607:f8b0:4864:39::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E699840BAC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:04 +0000 (UTC)
Received: by mail-pj2-x2b.google.com with SMTP id
 d9443c01a7336-2e2d42b972bso21000165ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887504; x=1791492304;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7zZP+RZMGL2N7JgQpzlsqi9SKvqCiMmwlsNlSXjN3W4=;
 b=mEG7zWo3W5F9HUlMH7e2nUbGs0QdeMzZHWLsyGzv1fOcdSLQlEER2gXiC5EawbwGrB
 zcuxEux7bGD9x6vbb4lV5pgPnIg4BILnxGlPdATCaS9zDqS01BK7ag9fJzUEs8crgddM
 VJpqtUNdyzwJyPLr0Q+r/dGeJBs+sVZv29Sff4aCJBOjZdVRaZJ69ZURQ9wmdNNHLHft
 IKq8myjWqmVoPx92/QKpLJ36i5/W9VLV3GUlSiUIf4HhAnsFuyEKImEVlyqW9gQYU7Vc
 MEvCI5sRrVYI4ueogJ89IEmb5WWDyLQko4IxoDWDD/+UqRenO2KDwD1JRz63Cv7g0IVY
 7q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887504; x=1791492304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7zZP+RZMGL2N7JgQpzlsqi9SKvqCiMmwlsNlSXjN3W4=;
 b=Q0n/n3Z1X8LIZUBzXcUe6WlvCJjLP4o5Sp3GCdwpzR/9oHe6ZRjawPOGCHQQoLPBV+
 pfjRgn90IrECttr0tHI18i0lAfAnbi9wKInjDI/Mz6V7Y8wiMEWbPgDYumDfRdOYdlm4
 2mHfap2tZ6pvhiUpWod0/Az2Ri0BT38mp5ty9bjFpNIbNWvIbmf8J9LUw6APB0gtaPyM
 Ppq5u4592JgSxCiSWihfY5r4uW50+4rtLpghMxtxaMPbF6Rdg4E5TFuIHM6r5Cj8LwYh
 jZGnknuzXB6W1YpNZNS2eRb7JP4uR10IutFIxSW7R5pScMR80VGw1GI+5mQOcIN1rwi3
 8d5g==
X-Gm-Message-State: AFq9FYJsWNpM30bJOo/wXFs4yDwgNPKkDDxSpi/2cdZi6hvgV+3gNoJC
 kbttnEZnKfvAJ/HLe04gWCHqmfxlk9mUnYYfdiCYq2rLHZ/H6Pif6t/C4o1N3vMhCaFUgpcJ
X-Gm-Gg: AYBFou2L9rH4mBfjX7f8ab/DgqQVv1IPWooaBOZsrJG72h9j2MHOY+Kd2cx2kDEBOVs
 gzNhx/g/WkKZvPZcmFnDNrKnffz+sD7X03E/jFMp0DOfc+6IWG16EgdZe5qPt13km+ud+ZX1pPZ
 ij2FkDFhHcOU+4IvMP9GMCV9PFVm0tGnD3eUf4PMRdE2TovGp05/smihKQF0SPaKs//u3ymYUc9
 7dIM4H5JzWHxhU2ePKAcDXD79U6aqQGFp8WHTSZBZMuJ5Py0D0990zFIhNPGi3eJ3kDxcJeTKOd
 qXKrNiUlVBWzXHyzeAK76/0i2bDZaYS9HrWJJbiP1xaJui4nXCkGIX8pb8dlNQtbulnz1ablvvS
 +xNWHmgn2f/VBouBD8BjV8tYP6c1NLXiepsxOSjN2VT3NgFZbSyV50KFZTWviMYenjfMYw+CLxH
 C/R75LC1fdqt2qAw1hvx7wcNa7waLg3IsxTb2Lt+jWXB5uCXLHj/MHxvyEKk4/k6yHDRr91BsM3
 PgLtC3tyRZdPAoQkoe2574RTfFU8yg3Hl6faw==
X-Received: by 2002:a17:90b:2e08:b0:3a0:c72e:46d2 with SMTP id
 98e67ed59e1d1-3a6ce3bc53dmr662320a91.6.1790887503909; 
 Thu, 01 Oct 2026 13:45:03 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:8a30:2e86:1710:20ae:2ce4:794c:d830])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm883877a91.17.2026.10.01.13.45.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:45:03 -0700 (PDT)
From: Qing Li <lqing2013@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Qing Li <lqing2013@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/9] usb: gadget: f_acm: do not gate TX on DTR
Date: Fri,  2 Oct 2026 04:44:44 +0800
Message-ID: <e54e1ea64d7e9b57e9c4c9b134ac4a166f2ba287.1790887323.git.lqing2013@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1790887323.git.lqing2013@gmail.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 21:24:42 +0000
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

The macOS AppleUSBCDC driver never sends the CDC
SET_CONTROL_LINE_STATE request for this gadget, which made the U-Boot
console input-only: __acm_tx() bailed out before queueing any data.

Drop the DTR check so the console also works on hosts that never
assert DTR.

Signed-off-by: Qing Li <lqing2013@gmail.com>
---
 drivers/usb/gadget/f_acm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index b6c11d97a62..cf16ca83c12 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -493,9 +493,12 @@ static void __acm_tx(struct f_acm *f_acm)
 	do {
 		dm_usb_gadget_handle_interrupts(f_acm->udc);
 
-		if (!(f_acm->handshake_bits & ACM_CTRL_DTR))
-			break;
-
+		/*
+		 * Local crux bring-up patch: do not gate TX on the host
+		 * having sent CDC SET_CONTROL_LINE_STATE (DTR).  The macOS
+		 * AppleUSBCDC driver never delivers that request for this
+		 * gadget, which made the console input-only.
+		 */
 		if (!f_acm->tx_on)
 			continue;
 
-- 
2.50.1 (Apple Git-155)

