Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C766C982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1819580EAE;
	Wed, 16 Sep 2026 13:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lv2blQMun8GH; Wed, 16 Sep 2026 13:08:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1AA5C80E59
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564130;
	b=A71N5SD996Ej9lx0HlhcRcF0KIzHpZv+HPxB5YHQzZs9HKE1JU1BSUuO+MoC6Z8jWpEf
	 p+Cz5yreocGbhNC6svGs4FGcdXY8nnRT6Rw448esS+7yZSZQiIPWxB5wemenzrYY7DrVx
	 EO4EVZyizFN0O0aC2XsKLKOqt4qmiJ8zG9WLuJoJGlQLSMjJ7kYDqtXvYU+89/259gfNz
	 33MFujdHOo3+3eYZSqbAkJgEbOEh4AqTVdXpqyoZLETffWxgL2WC/eW801iGl+9FGv44p
	 z3U3KTs2eFRPe7nuxzGeEb0qkSY33Lp+gxkhGJYuy06R2PHrJrF1ddQe4C4KfoKGc+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
	b=geN7r1CGEX6/VtbG+3/mwhCLNCKOWplTD4L8fA3zRHyszRDNwlqiKqBTkUmVg+5rTRMj
	 igXOJHMNGMACEUzPAVeA/u6w1NmzMS58SHJuL4zPBie9ZRvOtQClpBi8d7HUUDjk++R4x
	 KuUxGDPf1I0X5mGJ+R+PTlEh2ylJjTqWp5hPtKSebca9ShqqMGAONqtvKPbIFudX+iE30
	 f6QfWgLvGbzzR+EJQRXisJf2sHYzWCmNMDCEaayT73VlNApW4Vw3ZkZ0rv4aABWmaGlWA
	 tRFrwySB6WZ0ucZK/ZAUck9ddIy954ZldKAVIAC8ZtP9gOeMeR7MpGvnO/MtRe+J1xQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564130;
	bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8sZIGEtyWFQ2ndUNFKEBCFazQ1AoZZ+RvD9MqmtOqJoiEiMSLs21o9EWsD7KBl9g
	 jTECqAVKUD3dZ4Om8+qPUQLrIbT4CMX5aI2G46nF0ELbCQ2LqQ8g+JW9XdgukNeTBa
	 97uDDv6bslLvAZhcIePsl/TEI/P32BgBKogkpiJdJwsbDG9ugyq2G2JP6kwiiSRidI
	 t3py/4x+3NFPoHAuakcK/Il96gcon+e4kcEEQ2eKx/d6W+2KzH3Bv4mu9qFXkv8Lrd
	 XWydkxaGxhgsmCgUSirYJrzBQQ0/HIDjoXgewAGr1SnVvhajdGwRy+YIm0YyvBzjDl
	 /V5dBgOQV/Zpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AA5C80E59;
	Wed, 16 Sep 2026 13:08:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F79FDD7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31C5B607EB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kKgFmHARIKF for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:39:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 40377607D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562371;
 b=l8Qujm3PXW4bv/tVF2RscXMS6QydwY24BprL7B9z+b81kO21w6EfX4WrI6rjt2KgQTD/
 dSef9ZI/Ok3vBUBB1cE/V7gisB9I/joFG7P/HqCXhrun9+6+Jbr/6Bk+9BVihx1CbYNIJ
 TRf8IJB9Lf4lr1f+l8rg8OlnoxY/mNFN8gQkCh/3mxKXRvNk/MMVCmgHN0EJPYxx9DFPl
 4qFoZAff5NNcVoNml0hwqL+pml73IMcbQHturE13CIJ0SwDEqavotSXHqwyeeURpheqxY
 9gAQ0lpc4VPOA3lRgPsGN1Y9LCJrzDnaIAGGxFAMXgPSQ6x0IIDHT+OXi8uVaZl6b0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562371;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=QODg0JZr13x7kmPuHIZtFzjQEGjoDko2bYIwLQzM02q0AVSsuAKyG9rXib0fXR+x95Q2
 synDJOQp2OawBqXqVz/h4EC7P2/69eamj9QOkMBiUuwRQVuHrYklByP0c7H+lusb6EMtV
 nP831GVnPQ6IoQwKNkClmQFTWRiHl+wb2E+TaxjxGIkkQeAhgwbiKSb1SWN3PomwyIrA8
 p4auSI09cuHmH5OiD0K7MyCWaLTtalEpflGGa8/ggoeSevIipoT+8tw14AADC6mAvLK2w
 ufYdYZLqYJb/6AzltXugJnj2LIJNnPFKHVME2lIAWpc65o8OkeruOafac+DFY86NARQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=w3YCwMX5; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=w3YCwMX5
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40377607D2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:30 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254c50ff6fso13557366b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562369; x=1790167169;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=w3YCwMX5yDqt/GhQA2JioroxHKuPpi1oED/6Fi3GJMg0mUuzjGK5jLc9E6/3lBvr6Y
 IvihGbvWtqDaKQynvrEf7MHOtZOsX3bxcVXhoaycrEAdyfTVRKLlzGF8YxVcjFhVfmTl
 lyKN/j5025cjBbsJb3gRrOvPn03MkQLQ7Ixr8z816LVb0ObM4EOQEgU6TLpiTzD3G5/N
 Jz4M3JlWq2fzkmN8IZakKtejvuJEA2J//CX8ZIr2LeKr8p422Yeq4l3n0Kqg3btjeWbB
 ljoovwH5s2zP2KdLBxmg+JM7NWpm6B34fH1EJYI8kUxRfEtakCWFK54qkvxyaNwlF1UB
 kTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562369; x=1790167169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=JLk9ZmeFbQJ1SSWK9RqGCCgvwXKCn/kEMFlW6QXnh4GgBvpz9zp+NFP0KuxVx75tDw
 qQIuo9cQZ+iRd2TsvoHGWnWG2VDlG7ZTaMcanWMlfvTHkrAxIGamrXqS40jMbvZt5Yhp
 yvtuSpgTHYS0U/hQGvem4S3yKXsMPvXE61xBVhdWOIEq7vtVDNE6/GKOOB6ViPm52S29
 G/ablacKhYsLbqx69pnMm8hQ3W1xhotRGwGFBBCOlB6G0lCDjSmsOTk/xPwpnm+O3Xk3
 afJG178kpjmL+hHXdMlWR3At8II/6LlWElQuBkW4sStfPa8EHJrDvQy0dHd5KXrKjYB9
 dv0w==
X-Gm-Message-State: AFuF++lGiFzsGLFK8zmxW2ueOvxl/tSLOe46PAd659eISJJM+xNJ/Uw/
 1z+bw66MyKAcgFEWA2jTDKsi4//PnkaU/lopWFdchFKtRiKDoVRFlxSQ8ynRcBg6aLpfee4cszF
 1NCqU
X-Gm-Gg: AYBFou04ab+fToUP+ot0X2jALN0mOMqgmIn/spUK6xLdiktVFDpFLXe32YqAcoNFe2p
 dA8fuAqZK7/3/sEvEOrzZtl2MqHEaSJULutdVjHFnorinNL+fdOIPFfaJXY8ngjMQcEaBD7+Bx9
 XmUXAOb/gxSivl4KL78x0t9f1DfdcP/QY9POA0gvh5s+0gHfnvrUH9b5FJ6E8943EpBCzkeBZyj
 4jBbPP4hn5oCLOINzIyzGz0pMwsgeiA/bLLX4slE8xeCixvQKNZwKeKMitwJdGrsYgIPIO+cZ+7
 ycnGFG+l26eAvwcyjSVN+RVRZgjiqTpQJgKlaFKE6Do+dDqqvNKx0Ysv31s7OOpqAjMYpPb677K
 TAzP6j6KKITDBu+ka81CumVPLtu+xSO2jYPoTOQvu+CKbKKL+UXYnSGgs2WwJWLbt1O7S9QtWRt
 6AsiaUUMMDdJRYz1GUzh/hoOuOfXvt3z6iUfvsZqOcsvWQG9Pevrsg+MLXbLZDVzlstI8V/duH7
 GAw8BzHR+J+6Tq7z0lMmTsyHlx7fSs53TvVGiKyIIHjR+Tb5DUuT/qm
X-Received: by 2002:a17:907:3f99:b0:c29:cfce:1933 with SMTP id
 a640c23a62f3a-c29e530d7c9mr207336066b.2.1789562369114; 
 Wed, 16 Sep 2026 05:39:29 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de086aa3sm136889166b.6.2026.09.16.05.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:39:27 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 09/26] usb: gadget: udc: enable async callbacks on bind
Date: Wed, 16 Sep 2026 14:38:09 +0200
Message-ID: <20260916123826.517181-10-anders.roxell@linaro.org>
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

The dwc3 driver was synced from Linux v6.16. The new ep0 code only calls
the gadget driver setup() when dwc->async_callbacks is set. In Linux the
udc core sets this flag after udc_start. U-Boot never did.

Without the flag every delegated control request, like GET_DESCRIPTOR,
returns -EINVAL and ep0 stalls. The device never enumerates, so fastboot,
DFU and UMS do not work on any dwc3 board.

Enable async callbacks after udc_start, and disable them on unbind, the
same way Linux does it.

Reported-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/udc/udc-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index a01a7e6dc21f..79f249cbb114 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -949,6 +949,8 @@ static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
 		gadget->ops->udc_set_speed(gadget, s);
 }
 
+static inline void usb_gadget_enable_async_callbacks(struct usb_udc *udc);
+
 static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
 {
 	int ret;
@@ -968,6 +970,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 		driver->unbind(udc->gadget);
 		goto err1;
 	}
+	usb_gadget_enable_async_callbacks(udc);
 	udc->allow_connect = true;
 	usb_gadget_connect(udc->gadget);
 
@@ -1164,6 +1167,7 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 			udc->driver->function);
 
 	udc->allow_connect = false;
+	usb_gadget_disable_async_callbacks(udc);
 	usb_gadget_disconnect(udc->gadget);
 	udc->driver->disconnect(udc->gadget);
 	udc->driver->unbind(udc->gadget);
-- 
2.53.0

