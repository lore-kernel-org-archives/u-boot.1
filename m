Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE06C5DF94
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC2ED40DD1;
	Fri, 21 Aug 2026 13:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GyuMWgksDukJ; Fri, 21 Aug 2026 13:15:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318133;
	bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gVYPTHfwT15suhdrGl1wCRZ/d4+Bp7x1jjl4023lPY/GCdLIMXuTN43hJCB4GEywW
	 sabs6RdoVjgRmdMGenCBA7iMBlHQ+t/Dh665TxjU42CQERObxVjC6QHPWIJzr8ummq
	 Cf1mBFhJXuNnuyoygmUPbMPlra9luAnBjmUP6qeYMQEw3mUkeu0Z+/64b+I5zPFvzQ
	 122M6B9xQiHiYww5UWsZTuMqgLWLUcZ8Q6D/umEYfNs/EeqDm6iuROOo3R1uaQg8uq
	 aXWGvD3IjoOkhni5LsD5O+xbxv9J7BC3A2gKQ7O974ldldKEEgyNNtqtXgzLVV20hm
	 yC45nwkk9fUAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF21E40DBD;
	Fri, 21 Aug 2026 13:15:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DDA89279
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF7F26068A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Opc1utAd1ei for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=sk51zTn9
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AA7F60662
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:33 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c082647cd0dso6444066b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302352; x=1787907152;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=sk51zTn9yy+HX4k/pRj8GvP7MMUFm0fZdCLh203V9Jp1AvsYfk1xR5p/btZhHp/UAO
 uS5OpeqNAF/xZnRp+5dbUoyf4gDgENL/J06z3sHX+93vnID0bneHJ+Pj8R5HhMjjMhow
 vm4t2lYAuC6F/N8wabrmki5O60XdZKysyuQmvKnRefMJShudnEZYg2whereka1Q0kLcs
 rNBE55jBBZATJUYNJR8x/n1zCJMDSuWdnxL+z8/tbzX6qsx2n+nEOnxW60Ssaxojklj/
 saAev3eDu5rco1N1smDj7JVTYvvHXSJIvlkTpWIv3Ex+RuQo7X9JzL0ydsBYxlRsFJyX
 7whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302352; x=1787907152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=nXC1DHDm8/IjDd44+dvV6rcmL4w1B866MdT4OaLdYNOobenI3cCOUVdyTckQqhqMyX
 FBZGLlXfMaDeCfWryco7IHUm6BatiLzuCIrin7jshXsEMYNT0WxjY3yEK7gMIgQgZTlf
 p7w8xGMugjnuhNJROSTMpzyk2ij3JFNr59gBpRBYf2g5kxAtjDl4PhPpqUqnyJfetsQ/
 2fBAlUWyO0fQjyT2LnxyMKHVHqcMcEQ2DAwzN4n50A17l+R8lS+8ZaCqYWpDbxIyiDi5
 Nmp5MUUF5p1+r18pZVHdQLM+j9rB20sCejJ1wxoCB14hfB5q53z3z2IdCRrQYoVdcSVm
 9W4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGzWSiFpv7abUBz3gvrThTm+CCsjraH8+wIKM9iVSan4n2/Hfz78TWZXrGHLzWUxWpvxoQb+M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kJtklAnImAApfYGfvoQ/nAHELWRZ9TnYghqDdaGd+opPOaikdD
 ne3l8GJGpy/1s6H//QjBURozBeb5QLSRkP22h0xqsyDx58NKl5WqH0iWasU9XoiogJc=
X-Gm-Gg: AR+sD110ojy/hrxeb4M3FtvVCJm/306V8CqUXZowBRsmeaVYorGCcfHxnaZLUgDotoC
 dXA4+N2BgF5w1wrXMoKFD0TsL3gDVVwug581je2lQRsQuRpqKFSPTrWJ3JYpF/QbZmplSPUsU4O
 4FrwEjgrYsvF4vkRow8H/oUMkxRqIIRSGJPbr44ArfZQrAitOnmGGDzg9lq1kcfsl0D3GKXMaGR
 RPhp9MR3Ajvl5kf5FiFTs+bYnoFxp03D6oowxVXiGa6K+D9MX0OxisRm/Zl1K6/Q8jgcpLP+Wih
 j9SD2TQ07+k9MagEPor6kOdtK9lF3pIcnvPbtPf3AvRTzloxqTPCU8qqDT2D/LvAbRZK7V7c7VC
 jll59AMtwcJqlVz44WaNnJDSm5ASfBPxjRbfv5cPwmiPNRHC1MrwFWqPHBRa909vBpks17kgK2n
 YcHTowB4FX3npW6NQsixD9KHFU+IE3lWXTfqWO0jynkuIYA5hxHS1s4essQRNDRayJ2WVW6AtCt
 t2LL5Eab0ONQ0E448616cEt+sPQ2tna55A=
X-Received: by 2002:a17:907:d0e:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c246a65fe29mr242951266b.4.1787302351555; 
 Fri, 21 Aug 2026 01:52:31 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c245931812esm418748766b.60.2026.08.21.01.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:30 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 71/87] usb: gadget: udc: enable async callbacks on bind
Date: Fri, 21 Aug 2026 10:47:47 +0200
Message-ID: <20260821084829.2070426-72-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

