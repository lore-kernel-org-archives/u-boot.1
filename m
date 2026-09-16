Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47EDC88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E40F6085B;
	Wed, 16 Sep 2026 13:09:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D3FhJ0tQDteb; Wed, 16 Sep 2026 13:09:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E1A5C6080F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564163;
	b=XuOwVGO5O6XPR18iQcqi+GVKJEGtvdbEP/qAPIQJnGuXZ0wqE56aZU/jx1qhm8FyVqe0
	 UHcS5UcFlK4CU/Xob/CoLVH1WJ8Z39n/nGXyMMAwbUiTFxuaRhGGhWQ7fHLmT4g21w3X4
	 JpVw7o69ABXuWGskH82kEz1z9jqbwkEr0VA2D/M6IDHsnwJHfzxHTBlKMkyZByVNLK1ZB
	 2V5okCEK2wAe6kT5LeWp7xpedvq1yRPnmg2fJIPTcawthnfb6EmPgzSq5GmoeB0IFsLpU
	 75RakoZF1BNb/Xcx1nNp9D9p5BKvlvREgADlCbskXnfCEqP2g9oa9qUEWMYuTv+n+Tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564163;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
	b=D/gVzYUfSmHCNQXNjsy2o5l/UONE2UDvkgaIG5mxOJWkXsg/Ug+16JkAytCgmIPhbAkg
	 zQCvoCXHiraYSqNVohBPXnlSvN+1GVndwBMBkC2C3GyTESVfJuiVLc50PrftZTs5Yd54b
	 +eyB1rbgQ+WwX/OmC6iZ2peKBD32WBxyjSoz5RXDIepiuKR4Vj9CHGydv1nTJcisYDgVe
	 DOo0Xb2aziWOM6/7dZ9P+fmAPj/drly4FcqT53RHKFi5dAAaPnOgSZCvM16zI7QVx4FDU
	 1I/Sc1NEsg1lOD/YsrvW+sn6pP946++hvM05SOcvSC25EZSXilB6Kz/+wQoP9XDW21w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m89RU8JV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564163;
	bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cGJt0CT1nrGj8rl1KihHq/d9p8Nu61x0hTvFxCC+sanCCPpik8kFu3US758m4WLxo
	 qi+BR1KOvdmEyZIidDQDBq86twjoF8rcshRKvN6LIxXAbss7R6Uc6RULEkHFIG96ke
	 DUw6Oq5iYR3Ja+cUrwhH6MwRRKMoc6JzrsSF5S/P1OjoJwsYK6wi+oSPCz3OJTXE6X
	 AN7VOJv2dHoKMZf5eEKda5v/s9uRIx1hF33+enu/WCnqm24hTBndUMvrYq5Y8PYUfj
	 blm4a1VvqoFt41aVMAUmkYPRBKr6G4R7zJwbT5ww+7IkTnHWYHuyuoQWoxu+V09ub4
	 6VfQJHQeczFLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1A5C6080F;
	Wed, 16 Sep 2026 13:09:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE0DB29B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFDFA607E9
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kb0ru-Z7mfqq for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:41:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F0EE56082D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562492;
 b=fEjEoEaBJB5VoxKKsfEr6ZJaaklYpiBb2goJaC1b4fSALZ2omWO+K9HVNEHbARAcvI5N
 6bLMQFyH1ZnFDG8lM0ybRX7qkR0zhFWfvBMpZtu8og8EnJPxSDrNT/fIlWIyOVY6bvHG9
 sAzq9kZGfhm4f3lkdW+20it1oOZcUuJzg635KXEbEQaC28edHb8H75aNqbCspLF+U9biB
 Vq1Xb7o0IV/gB6WejVEO/Tb1ApvgJDe+B0j0k2dC+hUjNBULWeSwr6X/3VcBPCTACjMTc
 fYspzZVL3Rq9HjZ0lXW7EKlW+NX1bSKLNhH6+VEpjYt2D4h6SNnA41lZaoQQ7UPw1Qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562492;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=ARnvsYE4bzz9GtNskBp84yVGfhX0zJjF8TQfl4GU0hXwtAksV5VUYWj/m4s7cMSJjk54
 I9t1UQeav+gzVKsxlZbpXH6qJQ5kvnzpIFGxgzixu1ArB6xBuWCuE7uJIl6PuPbnSUPXC
 Z9xqosk1WxIyODuW92LM6B2sGuHBm0lExaLfCZc3sKm3Rkg6AS2EmFaI31rTycb3gbLvu
 +umHhbG5HVmfLnjjvZpWsAPwjqXvFFkqycSy3PIdmHKpSQ0ozqvWOxTWr5Wi//7LWI9vd
 GMJLFWekr3McrflHuzPwPHVVL+sNVCxtJZ75ICWS6sRyN4bKgcMsjHIRvRUwyd6llrQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=m89RU8JV; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=m89RU8JV
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0EE56082D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:31 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a5d8ff627eso119733a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562490; x=1790167290;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=m89RU8JV+mQimMgU7w62PFG6nRG8uQzTTWh9PYv54h/V2hYYWIsuyTv6fVXNHPJJXK
 q912CGQ+AzZcaET1R4oYwQpo+2XTHJ9xuM9jSno85J/ii5pnJVwAgM29g9JSBmVnZyqx
 C2bCnfF4Fuib6QHhEM/60pHe1blqRO5zdAAMhdkfCNP71CYZd5F/Se5bUcjB7Qocn6Tx
 c4wuvDgfBblWiKtBEc52qVxaoBb61czTSY1XFMlhD+rYB2RUv6pR8AmRP5zdIDMafd4Y
 A3QrbeuGIYQLWdn7WwO3tWxjZao2lQs/8tB0ZL1RJer1do+UUi0NSM08gg5t20uwEd3e
 VJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562490; x=1790167290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=uSYdxhzbVj9asrk/FrHnsSEO+BIlOWZwD/lff0vCHLOVXKthSjM6WFYtVG14ARhqsp
 LPGQqKbiQ6Cx6HoS4bblZSQ5G+RNtj2am1rd+Fo0xx4tezMZZvnwyIIxL+M7imerEMHX
 ryrPDcBDz3w4b28mJC+CQWoUAf+HRVPQDAB0zaSgy7gUUNcTuAJRgT7/iSoE1OndCC4Y
 cRdKgO0deQz9S5nOJ4KR047nVeP+B8JEQaz8DdUpKbQKoa7aVMrYG3mvz7R+bURysQK8
 Ga4BR/zGT9XkKsL6c8pdNDUuYn3b1O/B2o2fZX6/CQQ4opiu+VDF1Rkx5/7CuqYpZBNC
 XsBQ==
X-Gm-Message-State: AFuF++lcEnHRCCLvd1En7RQvMIiHDCmDEKbuFbvD9vASjfD1Z+4lhT8M
 zY4xiE1w8UbnmkkxTPIfwG0B//bo0D/EghzNxYm3WLWJfo5swz/SZwUOgA8U5Ya8NF8aaX519+D
 FjPhl
X-Gm-Gg: AYBFou2VqoUnRfOF18nNuPSMDE5VCEvKxVviL/3BMpVStWSsYpS2EctAuPUrGsuNcDE
 a1oHXB28RO93XQF3TG/dYg48Rpch6gpu586p8cFMoOaDGqEmhuKbvKYFo1/NHdCObXO1QAtEvnN
 2iyhqYQCsCRucgkt6284Um3dM6kT4bbWx+u3/2NCH6jsbnz27/N2/RdUiuXiJJnP5gPQh67hLtA
 MnIDY/lhmr9AP71MMK/sQjOr184ZFcqEgMkpxZrHmcuMUwmuTZnlcKkO5WB8IK8wGzAXGvc3xgu
 UBaUMoWeKR16NF+KTtj/kF8n6YK1l1kglZvSf+Stw6mwQTipwSJHFjNwREhP5osObst4HouEsEm
 jGFz2LowQAd3x6JByQHGLUimJFFjBLw8vuhrev8xfO+IxQQrTgm1Ta5ta0cZHZxTFS/QBmjkbFl
 lYxV9qTwQojCSApmFxopTQCHvI6j/Nu5Th8YOO1hD8dmYKVD36PXlOzcxMEma8j/l7TweOeLcuc
 HmTbatvoIGqR+pi4nDE5ZIryVfRv3VEyvMaPqSs+reQmDUO1LchtmlVbg==
X-Received: by 2002:a05:6402:3215:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6aa2245a5e9mr2262776a12.2.1789562489828; 
 Wed, 16 Sep 2026 05:41:29 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2a1289sm1487519a12.27.2026.09.16.05.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:41:29 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 25/26] usb: host: xhci: fix up after the resync
Date: Wed, 16 Sep 2026 14:38:25 +0200
Message-ID: <20260916123826.517181-26-anders.roxell@linaro.org>
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

Adapt the xhci glue to the re-imported xhci-ext-caps.h.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/host/xhci-dwc3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 3504a7cf42ce..488d39fe72fd 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -51,7 +51,7 @@ static void dwc3_phy_reset(struct dwc3 *dwc3_reg)
 	clrbits_le32(&dwc3_reg->g_usb2phycfg, DWC3_GUSB2PHYCFG_PHYSOFTRST);
 }
 
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
+static void _dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
 {
 	/* Before Resetting PHY, put Core in Reset */
 	setbits_le32(&dwc3_reg->g_ctl, DWC3_GCTL_CORESOFTRESET);
@@ -79,7 +79,7 @@ int dwc3_core_init(struct dwc3 *dwc3_reg)
 		return -1;
 	}
 
-	dwc3_core_soft_reset(dwc3_reg);
+	_dwc3_core_soft_reset(dwc3_reg);
 
 	dwc3_hwparams1 = readl(&dwc3_reg->g_hwparams1);
 
-- 
2.53.0

