Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B45606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fyN1C/DD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r/M/mkk1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5479980DA2;
	Wed,  4 Nov 2026 07:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bz6tMRg4D4sO; Wed,  4 Nov 2026 07:18:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 86F3180D9F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793776685;
	b=rcIkuLFKB3OIoIEoIix7OHI628g69MV271G4MKRjvMICrRLsvHjCNxsY313wisiTEUHw
	 eP5+nN0UikYdLVhNGgExwaKbbEnQvZYCF6VNcZgxzTBBpdYy7MuJ9WERM3SdYfzZn3t9G
	 IY9rDDEbBLcmnZD8RdfMxvJFqpn7MCMoiQQ0/cXGnvoEIfRCA37CkBG0dk3Nsz5zylwJa
	 QIAx4QqNS7b9j4ButngXo+ORDj9VFSgg75XJXReG/j5Ca1OkbTE7UhrnkSI4/GfPVaCr5
	 Jr/zMeGpBB3mJtgiVql5H5J1g2MRbp7m0ocnmFYD0ugHVbb6OnIv5ij4ZxjmAFaU8Ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kmWtqbWAmE3Ep/bEXLU4MGDs/ANTR6xBQMoRmLyDvxI=;
	b=KeDHkbFuY3pN0na2N5Vic5zLaM30R5+X++XjM30hpOBzt7f5vXLwQ8zkH1O81OfgQIKB
	 0Z3+5cuBaD4/pIYJvRRHa10qmhFm+64xo23eQOyZ06GwH4OB01hfXvW8LgxeZKdUtMWsP
	 i9o4hbsfktS/6unVUjDMKCf/GzC5d4+eqxMkO+4WQtJ0FI1Yvr/P6SynVmlZV9c8gvyLp
	 FskNBL/keR7a7GMpJ6g80lFCAdfzM6MBhNjErQikFAuCxLvB5BLEOWQYhQvQVlnqQJG4s
	 EtDGHKiZzuLCYio/KyzWBAchNv5EIwsdc7OaIEVwSNKQEVdg5ayZ1a/Pnp0GtERPSig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793776685;
	bh=kmWtqbWAmE3Ep/bEXLU4MGDs/ANTR6xBQMoRmLyDvxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fyN1C/DDue/gtE1iXRyje7Iz1YgFW8sW0D2e9Y4OH4crmCuSqRLnate/RYUe6G/lF
	 VR7xz55Sm7Q8j0k+En4MKrv71J57iZnI+etTn6wcaFHlsSZ4cD4nUVlvAlB3GZY4+b
	 YpCWPm6Lpwlve+GFeEbRkhPsr7j46I+Dzg+3FtyO+yI1nT5lbQjPUsRXFkPn3UopwB
	 oOVsvtB5ay7ZkiT7XtEwG9kCCXWVNUzCA0FF6SNKa60+Bt34hwvtApR1Vr6Ar29Mrn
	 rGe17kNa8/xG9EpyoQIEL6Z3LSGYNkyjE4iS/BmJgOrHMDFiIfP4NNOC7QGRSGJexW
	 wr+gkdU6K/5YQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86F3180D9F;
	Wed,  4 Nov 2026 07:18:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C321A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D965405C6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxlYDLRLCa4w for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 07:18:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67D42405C9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793776683;
 b=CMM3IgDWDFVIVoMZUoXGKfP6SnvdoizvZnGJe3r/0DUo+Y5gx+ZEWb0ULFLOKnyqHIqB
 vPKWkb4HLHBzFpO8vOxI0k9DzDVRLpKnDeOuNMljKIzktZfFRL8qwGT8d59UhXLsxjuwj
 19W4MdrUvS5ZrOD3wvyEFzcCaNA1cPiHepDO7D1qfk7Cp5bjSAkhC8eLP+LFyGMk0czTF
 D1erJsUQprZFvi4b5DtYydncB4yPfgUxqEPsO7KAiBsPD4RdzNIta298dRGZqnoqw1jnq
 HmjQ1fzQdaekU2Jmb77gPkn/znyQ8u3bvMdsLaTCgyh/9IGSLwaSZCIBSopfLSqXHKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793776683;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=kmWtqbWAmE3Ep/bEXLU4MGDs/ANTR6xBQMoRmLyDvxI=;
 b=kDsPimimAc9jta+xG8NTIkXYXc9qSG/PJsvEaxrypw8lJV/CsoZNv8CMjvT2IBLwRjqJ
 bGeivT3DpFr/CosNP0KfcsuT3rrEU4ofOxhfWTwZGGbTTyz00lEUi+g3hB/BQQffZXXiq
 RREXFwvaijxhVRuOyb3WatnsIhXI6HdIrfUpTpbJxwPExf8561XyZ/y3Y2rVbjbNGg9jz
 HZMYhtuL2DiwtFIkjqTFvQbCgmziyEu4q5Wd0/mcFsxhY5rB9vw74WkE/SBCFdXjA8muE
 mt8PZ96i6Im/hBdeK7pztYwsYpXV0HDVuMIphmkTOFd+GHd7bd+yTf91qNRUXlCatLQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="r/M/mkk1"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=r/M/mkk1
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67D42405C9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:01 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so2554965e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 23:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793776679; x=1794381479;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kmWtqbWAmE3Ep/bEXLU4MGDs/ANTR6xBQMoRmLyDvxI=;
 b=r/M/mkk1XGxtqLfoA8JX2btlMJoP8XH1aEju55HElkeWBTBmFRImHvszjfcsQsZjhs
 VD0pUauvA01IUNT4yLd63ty1p4Ik0NnF3DqvM3fLzLTdUlfx8yzQeYa9lmK0vLElmHlp
 3+aPYY9NZFHnHz/Z+/BLPYieY6/os2ECCyi08cDKFwVc4ZxtJ8Kh4yHtL9gQuIwFVPyc
 p+u9gt4BTJZQjqHi3PPb+eyeADMuvp+dHg40smG4PzPa23J4yydMIPSj1M8i6VhzRjT2
 gOFaR8d08tMkqTgMQF9ZGl2DwEmvHasBYt/bX5smn1jOrVjAc5b4Y85U0caGDlKHTygG
 sA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776679; x=1794381479;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kmWtqbWAmE3Ep/bEXLU4MGDs/ANTR6xBQMoRmLyDvxI=;
 b=xrD79j7SiRUbHvIa/S9RHYReCBbnd7LWSszipQCExbbFpEvpoW4Z2p/A/xFlNMYn84
 ek6wi2Tg5Z3AZY5uREGy8RJTavox10PLpGc1pO6O2VhctTmH2MC8hn40yA/4xgoO1Io3
 T7MNkpn2XYWk8m42QngWqlZWxIGIbChuQenQioKDuYUJel4QHXKabmx+ai9+Dy0mR0ca
 mVO69n4FveqkqRrL/80lp+8QBwgbP4vp2txEwa1QyscSHhWetUAOEws58oQjMOWIOEqj
 OmWdrayHPnEAzY0m5TUNGe0umg/igzSGXbFdB2kjqc2CY/CDn+yYxPropyiX+45gMSVO
 aDSg==
X-Gm-Message-State: APuU4Z+wp8nwAxa0kODTNwzuc2YS2dDizmb0AaBf/EqiWn/nm3jtbri9
 zYAQF6yUVV/aWfJyqjaMdmU28r794COTmRiSpIP6Xgcx2PjnlArhzEOgkOG10F+rkxY=
X-Gm-Gg: AYBFou3e86zOVDOojIRrTXGIs2+5NnZ47j+5dfDeS4ulffCU9fRHe2qsmTActz9Wb4l
 a3vjrJLiKnNidaPRPRVj+SFSDHSJ/iv5erwAxouR6lpxGB5mCOh4t3TTOpUaG4fgbL4ZZjIUZMs
 tletavrV7pQs8yALqYGql1ug+aBoq9hh9tqTRRP4IAIwQHIA5zi6Wr3vWfwcyicYjv8/WPyi3fT
 k+nN9TqiZB3HSJ7shzRBGqXgCbK48NqFFq+Yeb/MzjhsZy/EzN/c6EoSE1Mkwzc9HGViPe8Hh++
 kyvxrh+I1A66sE5fyhng6Lfe8cwBGcpGl7wyDFp57Z5MXk1SU8bgUeieMAnWq5FfiD4PIgbwar3
 5oTEvXrXuLzv5ReI0cDpbxUC685oE9p/xAk3IBUJ0bJX3nMBD2+ZzM1ngQg+f+9Ed4Si/xiVETn
 uarc/phq0CA20T/f9AproQOeOnw/y1OvZ0at52e+d77XgPCXKyhiaLHzCjPuMZts9hsf95Yul5p
 wSQFEDZ7hlL2ldg6CEFI1p5FAsjar6hUkPtdTzubbkxHwAJFMfnnadNRRmDKCjL/3CGUD8NYfSW
 K8NvnVplNycTteifTDB+2R+Lg2c3VOZxj+HvWJxx5VbO9DAhypkp
X-Received: by 2002:a05:600c:5397:b0:4a4:7a8d:c736 with SMTP id
 5b1f17b1804b1-4ac16acfceamr337508125e9.9.1793776678965; 
 Tue, 03 Nov 2026 23:17:58 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed92a753sm2463797f8f.45.2026.11.03.23.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 23:17:58 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 1/6] usb: gadget: composite: bound ep0 requests to the request
 buffer
Date: Wed, 04 Nov 2026 07:17:57 +0000
Message-ID: <3f4477b0-1aa7-47f8-97e6-3391dce81d94@gmail.com>
In-Reply-To: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

composite_setup() hands every control request's wLength on, unchecked,
as the data stage length, while the ep0 request it queues, cdev->req,
has a buffer of USB_BUFSIZ (4096) bytes. Two handlers take that length
as it comes: the OS descriptor vendor request clears and returns
wLength bytes of that buffer, and the SDP function's report 2
SET_REPORT queues wLength bytes into it. A host sending a longer
wLength has the data stage run past the end of the buffer.

Linux closed this for all of its composite functions in one place,
commit 36dfdf11af49 ("USB: gadget: detect too-big endpoint 0
requests"), and barebox carries the same check: stall an OUT request
longer than the buffer, and shorten an IN request to it. Do the same
here, so no function behind the composite layer can be handed a data
stage the buffer does not hold.

No request a gadget function handles needs more: the largest legitimate
data stages are DFU's DNLOAD/UPLOAD at DFU_USB_BUFSIZ (4096) and the
SDP report 2 of 1025 bytes.

Fixes: a764c941289c ("usb: gadget: OS Feature Descriptors support")
Fixes: 5661f08a7144 ("usb: gadget: add SDP driver")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/usb/gadget/composite.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 04b85419931..d6147d22936 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1019,6 +1019,22 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	u8				endp;
 	struct usb_configuration	*c;
 
+	/*
+	 * The data stage of every request handled here, or by a function
+	 * through cdev->req, goes through the USB_BUFSIZ ep0 buffer.
+	 */
+	if (w_length > USB_BUFSIZ) {
+		if (ctrl->bRequestType & USB_DIR_IN) {
+			/* Cast away the const, we are going to overwrite on purpose. */
+			__le16 *temp = (__le16 *)&ctrl->wLength;
+
+			*temp = cpu_to_le16(USB_BUFSIZ);
+			w_length = USB_BUFSIZ;
+		} else {
+			goto done;
+		}
+	}
+
 	/*
 	 * partial re-init of the response message; the function or the
 	 * gadget might need to intercept e.g. a control-OUT completion
