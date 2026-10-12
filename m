Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B00ACA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1112340574;
	Mon, 12 Oct 2026 22:28:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xba2tQAt6IbU; Mon, 12 Oct 2026 22:28:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DAAFD405BF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844089;
	b=pL+eLohp4qwh2trgYh+eTTnFJ9d7CMpyJ2gCQtw8tYyCP3xhCWRcPlIAxGHbnuwaaVL8
	 htdLOc6L7Sr3sVLmw9zuC+C94jTQpoJ78FOta/+hvKNfi1HpGjLWzYjJosJmTUoHuBnKA
	 /3MTzJj2oFPh3Ylp3H93y1IgtHIEmhG3luMUJtSOxGbxJE7KkxI6dau1yZYU/oKixLG0B
	 JMqq8j0boHXK/2eW+6hPrWt+5MrSUdKyxdjKoL/XIKsUJEEJMg8WYmDph2NKlxC9wfRRk
	 vscuy+BdP1bOwKSOa1uTjnPjg94GdoWN4D3/HV9AeYpNdm9j8jX15HEumOFdRikzqeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844089;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Adi65LvqK1XVJ4k4PaRd2t1DY+Ka70YUyCTLdNgdeJ4=;
	b=Rq9tITgZJBGm213mSEX4qnzWYhCV+8g2QYfw+obNLaQaxtpINA/8xuIAz3AolAzVbA/g
	 cfIpxr7IcK9glSXzEHBzaMSD0601XRVeBfyt6TEblXnAIOhOVbRWa3aY8TSwM13WWiYK5
	 r8RebITZlNKuzS/okWWn4r+bVNKPR9/SOsE1Ma/1FJIORkKnnOwzzIzAKeURJxK3SQ+Fa
	 k7MngFDU341EBwo3SX/PHM8S4747v9KQPPgdKr5h9w5Jou+9aI+yFI44jcbZefSRMMBoI
	 SgKnFdPrGh48l93QYOo4W/taMd5dl5vxt0QVKI0TaoNOgGehpSSawv36w8AfLaNRekg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844089;
	bh=Adi65LvqK1XVJ4k4PaRd2t1DY+Ka70YUyCTLdNgdeJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NiYtgA1LHxHcTswG+aD6ICPz9nc1yoPaLv7fyV3Mge+3Maqva3rmRfdhTgbNZpG1U
	 cDMfOXnEq61P6raJU3InvenA4KHsGP2rMzUmfC56nwd6gRnSsU7xg8LXyCSC5U98ar
	 kBn9pFDgVwg6m+XIflwSOZyntBdf2drc45JD4kfaLuUPCIUNjt4NTwAjJ+Lg+j1GW5
	 Y2yxStS2+ZTYtpFR3yIOgNsJF/GChCrMXGr5YDBxUHG22JD80XHBHWWbP6VfTDf7eu
	 /T68AKZHLP7IY6UtIju7JNGGkcOenUmYpQ19ravZZQuZ0SOFoiN7BjAW8x3mEmrpC5
	 GWtma4UFGCNRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAAFD405BF;
	Mon, 12 Oct 2026 22:28:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 15442105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0615F606F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YFWv4itnuaTM for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:28:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3FC63605D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844084;
 b=hFlzM0IombPMwrYis5PJvJ8zbTNYOhZyY/fQD4N996Ia5DZ0vKMa09duj1ZtEMGaoKX4
 aHzLiEKuV/tV/jkTsk0iUJIHjXPflmB9gxXkri8FhCtYRs912rW6SMnX1srIzUFbmDEug
 keuLMq/PoViVjvQOFi0D+XQb7YE73PwYBn7Kv2uyV825XjBGAIg/2jtnp0y0ijsG3SmV7
 ML51UmE4aB41w1wCTIeMHx2tbMl5mqKSrA4U1TaVHkbsqrLLrEi68m+ST6Vw0YUclEp40
 HJEbtYWhlIQJZEXTtj4Ny04PsBwCXAs+Ru8wbTkYztFDiU77tOFMvyCt0OsX07Zv3wA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844084;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=Adi65LvqK1XVJ4k4PaRd2t1DY+Ka70YUyCTLdNgdeJ4=;
 b=thhUIDUBLIXBcUcUiMx7/KcVPwgzLtxqg1Nmaq8W4H3JpUog5iHbaRGhUmUcRj+dSjMk
 esYSc5RRq7X8PSatwhAQV60rHirgH4EmXePIV2D1fNCbH/jHQzPLnlmnxjRETvF0a4hxA
 YjUZ1i01xAwnPIma8+GGKIs0iGSPQiG95bfzcR/agG2jlU22/ZrPXLtL2RS87uLPFb+l6
 LXJE6bJmWWjqEEMJ0d7x1/7fc6rOEnpXdVTVB+TpJUQowflt9e/og77U8pl+ZMbMIDwdt
 6cMZjKhn1imq9i7Ko/7aaG9qKxiOQ4yzDU03a8kYXZYDCuAObObFpBQol/OdZsJCc/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qCaISGV7; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qCaISGV7
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FC63605D9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:03 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-48ed188ee81so1442077fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844083; x=1792448883;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Adi65LvqK1XVJ4k4PaRd2t1DY+Ka70YUyCTLdNgdeJ4=;
 b=qCaISGV7S1qORRTTRgsy+x7aBg2vMwC3qR8GPaHwj3tpjTM5jUk2PviVRAgqFt5Y9L
 CIVDOfhujQe4NLpgLw8diL/1a6a/6fLwMEZ7Ztz067wFdYcHqEQ2aPkVnwNGFqPjvhRU
 Xa9QvNtPrD0qdJSV3ToOyZZyk6osVXHOyT21XDh4EQ1q98vUa9jN/L/Bi5mmRmbFiz0/
 TTOMD9QtQh6NfvT2whwbFuplyNjdi7P2b/3LNg03ZZqm6bb1ZUp8F6Sb+zkVKpOpDrPP
 AAnjlMktQA2ZrN6YnjRXQXHZJMF3j8XH5SpwykXL8qmIeRDofTHn6vQqVfcCFbbSXXTs
 R/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844083; x=1792448883;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Adi65LvqK1XVJ4k4PaRd2t1DY+Ka70YUyCTLdNgdeJ4=;
 b=WIIq7baAX5cTOYrAw0TCscO0csCF2XQf4bQwvaEH0UDKwx6Ezx8araRJK1XitO5tGD
 dKQuett8cKTE+wV/0KNW4CKIDfvf7R7t063ZAiFaz5K9xxh3E+UmXI63XhgLibP6vjy+
 QRXiTYGPGK9bLIkxPm5/aRwPIasjQPEHF4eoX/Mml6M+6jyiWMFBtyIQOjDvir8pwwtE
 V184QtAXXwfiNh3j348uD/QPRhC5sRFqVmU6K/aLDeuIUNEstvwdkd4o2QHjiddYsrSb
 xsgJwkxMlLDzab/1SEZAGlwxaw6q3tFY8wsn2Bsth71htPIVNhqH6xzSThs88C4WytEm
 oh5Q==
X-Gm-Message-State: AFq9FYKj5WKI9trZLoFZYXsEt0yZr9kKWmnXFNMjkRWmYYJ+szMg9nwR
 cB/yDIMlJwBM/nloMD35KxpjSiOSdlGYnbCT32V1LVp/6qxjdvhCqqFt
X-Gm-Gg: AYBFou2TnEdSTrJ8seD8zi9xQbJZLkW47VzrUQb/A9oZq0zMWroGjiFEruC3ftuX0ln
 g0xSxxQvfeUj6IK2OZNKIEc8NJlyGnmKa63JPxxiNKNQWKWgKxxy01znizohhVP7Hh/nDh2TWDS
 L6YLy1rQWizkOLLa/b0CH3VPwZSLB3FWiD3zuVt15fiaNu/A4Qvjlf0Xmu3enDna57ZoiN+1+SD
 2xRqRREzCx6jYgwU7gygz7ywhr8CYH7JdQt6ewUo7WfAVdcDpOQ8C54NeMX/YantfpY4d3kHHmX
 LoqXEdzfrBm48BusO/QMhi6GACUifQGerRn4sO70nFu6OqXaHQSFZgEcwoGrAoYUQ6dFo+7Qvfe
 ccoHF6zSS8K5X0ShRb2PaRUIaGzoLqdKa0bt0otXpnlIa9O0/ZsqahxkYVfJQBDDq60IIXgD5ux
 lPj0A+dU+1Zm3gvO72fR4PV6aP4F7H2B3SX7/XVBrrw/y5xSqNpiNciXVid1jKBK19cajVFPxJv
 pyBwdmwLy2Jep1qxy+BHEj6424LcoOfJbhmTmQxBEGoog5MKsZDMUXkAIUbLTe64m9uvnqjjvP/
 xq7bcteb+sBDycoRymm593kJCNB46I2XyS9rd9beoNjSnJzXQ4ApUA75+suW/DZrYcoNfAlP2db
 /MKA0ruVH2pJlPhy/+T4cew==
X-Received: by 2002:a05:6870:cb8f:b0:469:fb51:b351 with SMTP id
 586e51a60fabf-4a2a8964307mr8765663fac.17.1791844082993; 
 Mon, 12 Oct 2026 15:28:02 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm10402859fac.11.2026.10.12.15.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:28:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 16:27:58 -0600
Subject: [PATCH v2 3/8] net: higmacv300: return -EAGAIN for empty receives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v2-3-c6a20425c15d@gmail.com>
References: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
In-Reply-To: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

higmac_recv() returns -ETIMEDOUT when polling its receive busy queue
finds no packet. net_lwip_rx() only treats -EAGAIN as a non-fatal empty
receive, so DHCP can abort on an idle poll now that it checks
net_lwip_poll().

Return -EAGAIN when the queue remains empty. Preserve the existing polling
limit, free-queue refill and received-buffer ownership handling. Leave
transmit timeout handling unchanged.

Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/higmacv300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/higmacv300.c b/drivers/net/higmacv300.c
index 6b88f6fbf59..a8ec0dd63a6 100644
--- a/drivers/net/higmacv300.c
+++ b/drivers/net/higmacv300.c
@@ -193,7 +193,7 @@ static int higmac_recv(struct udevice *dev, int flags, uchar **packetp)
 	} while (--timeout && bqw_pos == bqr_pos);
 
 	if (!timeout)
-		return -ETIMEDOUT;
+		return -EAGAIN;
 
 	if (++bqr_pos >= RX_DESC_NUM)
 		bqr_pos = 0;

-- 
2.53.0

