Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C244606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H+TqjOm+;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=epFI9fam
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0461281754;
	Wed, 28 Oct 2026 14:49:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1Oxofiq8k5D; Wed, 28 Oct 2026 14:49:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 696B3811A6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198895;
	b=YRO7qMMyhiJrBmR8p+/rHyOog7P80huB8KFDVoRkKH98NnA7aWO9nlxyu9pfWPWmZt4X
	 evdZ+lSKIe9IEGZxzZehTKPiqlCRvypQmXuYb4DaFyyxxEVIos7WJIFewvjZ89qMgjgLv
	 RACudosCCHc5HOJ3rkvN3Zv9qh7PwvDC3pQb/0BHh3Y/+LbEKFJo5ifHoQ12bAb9T+jF7
	 4BRl/3u0eEuUijmGgS+xJWU/ljLNwtEfX8xRywiV2jw9APIjhbhSrLECWAjLGPzpFjCte
	 HqQr/yRVvIlewsTcOQhqzwKWzrwL6wCMAhYkmPhyDbqUgL39LKn9jYGXqcpu7QUQOmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KbI885Dp5w7n63WXoNNxspmGMt7ClWjXCVsRGZBqO+s=;
	b=FSuE96laE8Lv833itFxWLo/oHZ7f1kl5CIFupHXLrOw/zYHJGqMCCMfNBkBocYGhVhCe
	 cLajIUnp25LDCci8MOvQ3WLExeQnPmOFyyoqKsXqUFnfubjXdnCIR4HIX97ohfYI9WPvB
	 AnZPActWKTFAC4te+mSMKDhtpTT5lALvbWDDjeYD1eGwD1luDvPpEi4UVnxRlrMNeJ6Re
	 Czb4G5tT5ks5bMWNq0X7CzsxCVF29EnxHA65sM8fNrgTYGxMSWd9tp8qGwitZLL/f1nnh
	 Nz4WrdpIlxXE/x1XuvPNf53qpGPxDBQbIpwsigERfwIiSWL/N4QRNDnKSHnCUf8THvg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=epFI9fam;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198895;
	bh=KbI885Dp5w7n63WXoNNxspmGMt7ClWjXCVsRGZBqO+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H+TqjOm+xL63rzGYh+fB6w+I5T950zTmSohSxGH5M9KH3B/5X98gcECOEmqr2OszD
	 JzumOcQrlJO+ekP6OjWTnIz6677pe/XHUFSTNSIGuG3tBzhLkRkH62fPYsSdOCXw0G
	 MTy5u5ywG/q1fDuwGL+O732PmXXaUTlaEllAkjTjfB4fw16Qutih9JQ0M9A8o7yQ4a
	 ItjktW7hKRs6QB72nkn7iczxTd5fZbqIagla/RGqj9XPY/G6jkDlecaWw9wNkvcfUA
	 Eqf77iWKtclHB8RyONO+0M5qz2G8bx5OsycCNQZJKWMWbJwq9wHbx9LPhlygTGJtw6
	 SouXZv7sfz3Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 696B3811A6;
	Wed, 28 Oct 2026 14:48:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5466B380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A5DF80CCA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gk6NQxhknm5d for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 383CB808C0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197013;
 b=ptBZ8ai14W8Ih4ixc/aQoL6m7SMH33/ZndlHAtQeBQd8HTeYlXbrFFlHvw9jDaEgzHTz
 LHwNOEVAIr7G+LsHXDpr+AueJ6KzOJNOTU+svTNOCMIQ1uzC9UqfynwISjQIeR2okFaQ7
 P4RbeDG5LDqf/CDRKVHD19It1r275ycdk2q54xuYA1qQKSnDF3kGFZ/LcshP6NqTwt/Pu
 aMdf0CllZpYcdMv89WsP4q2r4tPFP61Xxmphgaa6VXklfdDWV9VJvVPRT4SyzsRPyT5OP
 atRkT75CmHXM2ghsGrQZvraaFDZ3k/2A9ydNd0Iqkjr3ZcmCi8jFzk/o19xJENjmfVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197013;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=KbI885Dp5w7n63WXoNNxspmGMt7ClWjXCVsRGZBqO+s=;
 b=VbgWpabklMj3dg9MQNRb8e1JQNP1bbXV0DeIa7lw13Xy701y5++1fNqUs0mjjdk9b4yd
 Usw9wktro+8CkfRA71okFEcyPAf7RXtCJNbtASJ+fd8qW23asjtbNFMG2cpfThZ3vP2WF
 BlE5L0NWkzpE5w8hQUuwLVx2/bDNU0e3Ukc2nSiwfxjh5wBv1/yKoSkodvSxSjU87xuEn
 AkfH1WVlj9q4WQ4Egot2bCeOXeg7LJf2oQwzSxYJeCEq095xZs3MAzXevbgl12E70GXx1
 bLTrw+sttucoteYWaz+DBqeVWrx/8ju7EBBFkMtLbgeY+9L8uBBfsZzMGlnXpHpm8yg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=epFI9fam; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=epFI9fam
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 383CB808C0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:53 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c40db84b4b5so12915366b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197011; x=1793801811;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KbI885Dp5w7n63WXoNNxspmGMt7ClWjXCVsRGZBqO+s=;
 b=epFI9famIhPjvqM/Px9r7cfO1cAkf3tL/Kb/x7qwoVWUXHwYoAHfKwOi62Hyn6u+Mt
 cAMAgq0vFeWs3PlT8J3HkrFs470MBb5KWYMuSmBPN5z96WgTIWAQzHSFAGGEQavSZ+ls
 gZCuuR3ucK+un4VGFa6NTxDZwZMVJiTv+pmnXz49aJKGXvb4aPa3rm9Gol3P05GlCvAO
 hVGwqM2Em0EVDdHso1/ov5JHlPP+AzQpHZo11pex+GFzqh2SRCr0cE+Plq6KIo+SSp3X
 dmMnFj2Lo/T2HkxmFMfC5jaPDzF1VwDDTTUA50ZIEYiGKSgjKBc1nKCpVTdvgs08NzAE
 ihjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197011; x=1793801811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KbI885Dp5w7n63WXoNNxspmGMt7ClWjXCVsRGZBqO+s=;
 b=ZFmJdsIS4j8KKKv1PafrDCa6+LBKzxRIBT/ksal7dZiS2uVCilTF8eBoExNTtQpt9d
 C/hRqsvU2DAsh8MZy0QpQuT24kSHCt4gyJU3/wFFy/MFtHTyjbwb2ZuXXQptBWOfPrCW
 hg+oHMvTnDiDcqWpIuc1WYEhQLW1KwhsGgSlCJnxxZcp3d2QELcZwOFZ0ttdUu2/+re8
 j0VJyRd7C69sYZmZ1W9v+4Qwv2KGdORWu9yUevOExlcFnwcR2HnNWNB+wyAoXCuKhwhE
 CwHLtwbX0JlEJvBoL+hqrjsjnMHrwb7+KBOp0LCAFH0ncbdfGQ4NHBPXsZBk9Jkt08+y
 1Eww==
X-Gm-Message-State: AFq9FYIUO6pFWXJewmsbDQgtE63Ufp7q+L5raFms3GhTxGUILlQoqPeV
 zTr+1pDpQ+uhRi0MqJAk8195pEtmJGi9LmyjZCYqrj5hVJ9NRlOVcCTrDL+FIjIDjWt4yQ3o2Cy
 2EvsX
X-Gm-Gg: AYBFou2zrNVosfjF11Akx6MJgZ9FTvbP4XEOxbdH0izZl2YYtycIE1csbpAVmlWCaEX
 eiqBS1+tFdrh4zDP21bmkdDBxV8650uB5rpLTIu1c0RPhd5BUn+5H/RLnVYra//FO9eB4JTEVyb
 hb/d8+UbZZOyhJZAJenyGi0lVu7K/ek4d/Pqwj8VogtI1p/91oiqXzYdhh6OVAklPe+4xMP+DEB
 mZCGDsyeO32uMLIlY4htmtQ6Nh+gE2dWCtX3CLQ+iG4WIYR1ytEtawvbVcYmWOhiIwFjsFoek91
 XTObu3BcNGlajkkpprPPjmdtzv5uXL44JQSol1/iAqsr9OBwnlHGU49sbchEJ2orG8F3LwQNDEf
 mHuUCUMa9mRoIG1h/cH7xkT+R1CQUTyxXFvUnuV3ln7PXW/MvjbQaDGEJTgevwO7LT9n/6apVds
 1ygqMhYEv91QDNodyIlCdNRxUVzK5ItpVuJ55RcDz5dcIoxmR90si8qkacfkuPEqwRx9wuipmah
 Ac+ritchjAClPfnrnIH7eNfaA37MHQYSYb4JEwjXE/VQ1u/Wqv40iwF37SH++px1PCa0W/PGoKp
 NMPl371MRoXe/6CnQW+GMg4MZvXlLkTgBxKHvRRZzedgOoWc5UEXkKc+uYJbSSqYHqcw72ggDr/
 wfyYk1BlMmQ==
X-Received: by 2002:a17:906:66d5:b0:c49:9a88:75f6 with SMTP id
 a640c23a62f3a-c49bdedd106mr237026966b.2.1793197011139; 
 Wed, 28 Oct 2026 07:16:51 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:50 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 12/30] usb: gadget: udc: enable async callbacks on bind
Date: Wed, 28 Oct 2026 15:15:36 +0100
Message-ID: <20261028141554.3073545-13-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 drivers/usb/gadget/udc/udc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index d19f363478b2..d9f1c68f57d1 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -1015,6 +1015,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 		driver->unbind(udc->gadget);
 		goto err1;
 	}
+	usb_gadget_enable_async_callbacks(udc);
 	udc->allow_connect = true;
 	usb_gadget_connect(udc->gadget);
 
@@ -1164,6 +1165,7 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 			udc->driver->function);
 
 	udc->allow_connect = false;
+	usb_gadget_disable_async_callbacks(udc);
 	usb_gadget_disconnect(udc->gadget);
 	udc->driver->disconnect(udc->gadget);
 	udc->driver->unbind(udc->gadget);
-- 
2.53.0

