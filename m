Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E1DC982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45F2F80EF1;
	Wed, 16 Sep 2026 13:09:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwgXNQ3M7spq; Wed, 16 Sep 2026 13:09:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8932580EBB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564157;
	b=JAWEmN3jcwlEMNwcz1Qz1rVkTClkx0LyHbugpYJ174H/nZoIaOy8b40/uVQgCRN6SySh
	 PDCsEQ7Bcl+9Z8aSHRE4YFicQ4y+h0OX59D/MJqy3rk9ab8KEFxOjOmil+MzUKpGnJlOg
	 rTbdD/6vMZi+mPrLhxqDNoNa7uudLYFFU+hVxj6x9TAiD2QN1gvDvVlIy5YvQgQ5WepHq
	 U2e85JquMFgVyF4oxABiUlx9MEGVC6AkyYOzqzrfgwmW1puJzRWe8IbLbxjdHTiO+bqUS
	 O/sV+3bPWhVgFOArzrdRU4DrynXuoIRBb8UjbQE8lRbmXHDwx2dv33ZbklKhHjjOzCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	b=YrOOi4NvY1YEjdU+r6bSSTz5y+CqO9oLO3LGxk4XmDRUHfSpUoCxnSzq9h5WXlIv7m1w
	 YOl5T2S7wBZOQgmbH1+hjp9iWHa0O+Tki4nD3bpFTwoDOVzKn//ISxDoNSw4dVom84oWW
	 md7gkbaGIzp/4bEjKtbayYzrJo3XtCQCHHvop6Q/ilxwhbRv8kp20QJGrwaiq2N1uzYTC
	 GHCClDUVswxGIwG1wmwKv24QlE7JL7BdHST2vlwaZUiPKYSkiOne5HqK5omn7d36Sb+8u
	 odA3aRxBbNGqPfK/Ds3wcP7PgyJ3Bi8nxOyypG+DVOgR73xtRV8A/555VoiK6GMzHQA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564157;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e5NI+yT4DkZXkjL4giROqnIhVGeLVEwU9PXQg+1sOSAvusoYLdxA5jJZzp2wPrEFA
	 sPbCppq+UWVYxxB+bUhxc1F3elHVeyb9n8BM7R8TcYm8N2wBLTdrsFnbBPJfXzFro9
	 m2hsuSzq8XhnWNCthTPaCMzPy5N+lVuMnA0J0UPPnuWSUgDpM++iCkSWffVO/sYnrq
	 h2bwvsszqhyv7aLfrLJ3JsqfQ2fya6iOWm0+oYXVja2WML7z9n/87RBsyOLq4FPLbC
	 HB/aiuAOmUj7nIVT4KWa2MwndgLWEOisnpmkQrMEYBPsDG42wJZKGUwZoosewQ4Uzj
	 1kQXI7ym9pUkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8932580EBB;
	Wed, 16 Sep 2026 13:09:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 58CD1388
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E8EE406FB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGugMGHRDiHM for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:41:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 39AD5406F7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562490;
 b=NPKLJibcwo+7BYFlbjcAkz+qNKKdXrdiiqUX11zQR4gj89cbsRlVkBUczWGa2ea5nGkS
 pA7R8geTpUBLc5IIEtZNPTPh5hdejEGWukNCRwz76/zEYAIbrK9b8x+g4HsXcJ0eqJFF3
 PAF/pvGZx7qu8dqtMv02+eypV9dSpkNaX05k0M0P+QmkGG/NO603awJ41KIPy2NZveTuq
 VXKA8mlAaDFqVvDprpmMFYUoPy7zXx9HCytml6wdsBv1nfqz2wXqP3Gg1UJmk5+xre4fA
 bfvaIGY7zJQ4JKlJpC47PMEko/CVxIvRxDIyL3JB15wu3lUEQouUwfubiD/wIUnR8Kw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562490;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=EQxZQmvvNmhrESjAV/YKLQR+nZ4aEhdDcYUWAfdm3ev2LSqJkIMrHtc7eKRKgrG8ckbi
 IIKtO27dC25kU1QU49xKSXIlXQzAmlNJqwk5oVt+40UzbSqD6eiRb9xSP8qze6DVYEnZQ
 EHM50SnhxB3S2oqNn0so4BF0xy4NoVJsrTR+S39+AZuyXK6NCvRj+FO+Ha+Zpa+z+osZy
 JALpehfUOMnpoDLBYaKlk82wajTAK6njv3dxIJ8gy4OZ9ibWN8v7bV51oZwnXrd2ghNd+
 56+tq6FiGH+2KCeY3rg4DhtPdJ2R2phVCYV+1B5a+o9hxzakffXR/ha3KFVNN1EM48Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=p3P0gu1T; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=p3P0gu1T
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39AD5406F7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:29 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a5d8fe88f7so132051a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562488; x=1790167288;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=p3P0gu1TdeHtVh9xT7k0+b9aMt+UaoId7cH0yLpwaHXu57DPm3DOKxznJkVA4M1yku
 pM18cegXD1/QDvp96kJ72fOlWjm5ruuT+ERICOKJ03cDJEVhUi0Z0EkOMHCEwpJ48agn
 h018Dvo68Mwht8KeDg3jxR+NyFvXYv/wE436rbonLg4xDvK7llafASKsSbqCTBlLL0NB
 eKfVHtIIQU/R3iMI42r99U4TSh6XjT6XLcboCDrx4ix9P94yUGu9AWDnuw4twaHtw+WI
 cWSxchadFmKZv8oWghjK49vyJFqN4ALGB/HUGvQAzRkSptZVQervArfCcJm5HWklrQsF
 IYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562488; x=1790167288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=dqhBn8WU/BXODcg7ORPx4suxknl9GCYNF7WcOA4XOOijcxXWXMWAewDjx8svGNmT3p
 Ca+sNEk+zabOy223uod4LZQJWx7MKVvQAnw0B6W9DuOxateq9O/qtomY7Y4YhJbq98yW
 px8n/BBXOf2cOV3jq7ulpf1ia7oCft3nXgI+OS0oDr60jiPA5xgKFNDjzRk/0cW0ppi/
 8UgVP/X1lj/crqm5/jYhJqFwddHdgJ2JzaT5RJPnwAbFOJBLLeZQwDlq9Nlhy3iEX6I2
 VN3eCmcFBqP+XD9z1n2edoQcKiM5t3mJG0kgOYaiTuLZOShsdk2hUUnrNuo1EOEDC6YT
 nDOA==
X-Gm-Message-State: AFuF++m3fcwScoVpxboppICQScvhaNpbSNjWmr3qOgMPz/L/sW40ZsWY
 DKdevuFXditYLGjBTNpUHoXeTVRwh5EnLR1xqnHsImhQe4Nq3mhnZtfVPyvPzig5yyaApn3Lc36
 CDW5d
X-Gm-Gg: AYBFou01JxGl4FUia+Dc8+6vWEHhLSIHy6Y6yVZHed2XzWDpiYPUcHO7Fzz+Azg5es/
 kXBMyA1rM7urtAT1bpdQGzejAsvy3qoyVaN9Wdik34vRrltmGjjJpuPgoiP76omaf+7/2lEM+Jp
 /GygyzC8FBYaKDXdrAfxvqeFw13y3eEAlbTgFi9yGG8YRJdotouJX09n+1oOXDcqiDqhp+wzvWp
 X1QQ454tjz0nf+HX1fZTHHQg4DrY0ln1H2jZGZZ0CQsF1i8oNyY/Maj0Jb4oATTDaHXIY9v3Qjx
 XIIG4D86+Xs1/Pi72E/5m0Ip3Uhe920IKTLVcL1xfWY8dBYk5uBikpuFvqyTzXgYNomtm7oSxFi
 AC5x0jkmrU0Ksk9+4UA8kjrv/QYsE2fp7zcs4KPhf3FmANDobOxMCw2fsc/t9KchpoXfQe0+r7T
 kdM92iZkad2yODTp9zbbthmX3jdADYNKWn7AlVLcitCt4Ggxb1vr66zeu834em0PiyvAd0SE1bx
 Z5sk5QZ3uvfYjBAlixQBjWWLLPQe7BUPR0vEfU2waw4AvCg9kn++svU
X-Received: by 2002:a05:6402:5022:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-6aa223e0576mr1957249a12.2.1789562487798; 
 Wed, 16 Sep 2026 05:41:27 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2a1289sm1487519a12.27.2026.09.16.05.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:41:27 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 23/26] usb: mtu3: fix up after the resync
Date: Wed, 16 Sep 2026 14:38:23 +0200
Message-ID: <20260916123826.517181-24-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

Adapt the mtu3 gadget code to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 4b0bc5f02d10..07775d23d508 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -300,20 +300,20 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 	u32 value = 0;
 
 	switch (le16_to_cpu(setup->wIndex) >> 8) {
-	case TEST_J:
-		dev_dbg(mtu->dev, "TEST_J\n");
+	case USB_TEST_J:
+		dev_dbg(mtu->dev, "USB_TEST_J\n");
 		mtu->test_mode_nr = TEST_J_MODE;
 		break;
-	case TEST_K:
-		dev_dbg(mtu->dev, "TEST_K\n");
+	case USB_TEST_K:
+		dev_dbg(mtu->dev, "USB_TEST_K\n");
 		mtu->test_mode_nr = TEST_K_MODE;
 		break;
-	case TEST_SE0_NAK:
-		dev_dbg(mtu->dev, "TEST_SE0_NAK\n");
+	case USB_TEST_SE0_NAK:
+		dev_dbg(mtu->dev, "USB_TEST_SE0_NAK\n");
 		mtu->test_mode_nr = TEST_SE0_NAK_MODE;
 		break;
-	case TEST_PACKET:
-		dev_dbg(mtu->dev, "TEST_PACKET\n");
+	case USB_TEST_PACKET:
+		dev_dbg(mtu->dev, "USB_TEST_PACKET\n");
 		mtu->test_mode_nr = TEST_PACKET_MODE;
 		break;
 	default:
-- 
2.53.0

