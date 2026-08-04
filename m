Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29CAC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60D996075E;
	Tue,  4 Aug 2026 13:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QIFwV8RdX39g; Tue,  4 Aug 2026 13:05:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F1FC605FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785848706;
	bh=yxJIxELbOPOuDiqZ+mVM+0x1kk9yaRK+3ZCMNyzHdWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xvZslAujJp+jBUSeOBTuKL1ew8zW0i43yY4rZA29GSmz/BYYEGlkHxfXdjK5Kqe0+
	 V8GyJ1me2TbkjAPUtYLtr6mo9W3go0ol/P50aFZ/BNJZgz/zAvv219n8J7TS4ofFV5
	 kWIdXRa357zlDFmVnSuyJc3ISsO0bl+PIMs9ff4KyFea/gaFlornFkgTHYSh+Ot6fG
	 AFeMKyK2FJSl3/t/RxWA3IJ2cIdILHal2AuYwaS2HBAw8jRub8XNJ3XJh+6PXQX7sG
	 e3iLirhUlXJSgJUPuv3eLpUC0qhI1PipurwFshRbIcxX070mR9NYeQEmflkwnM3r5O
	 g3QSNUj2o3Cmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F1FC605FA;
	Tue,  4 Aug 2026 13:05:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E40D26C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0FE2E405AD
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vI9Agj7y6pu6 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:05:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 329AA4053E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 329AA4053E
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 329AA4053E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:03 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so6807333a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848702; cv=none;
 d=google.com; s=arc-20260327;
 b=IKghvmOsJN+LwOycmHQh2+0FLlhlEcSAtDNrWXUhd6DTeoLbzdrgLRRW/uiyv9Bxr8
 UDLi1pm/VFM6Izp36UzPqJkPYgQDy7VJMJhu0HFTCy+dG8zlciuzW7idqUjBgZqmSNNm
 mCuvM9vZGotPgixRHUuS0PHSG8zxBp3F9odapQzGyD9401xVOdM4qN0EAv2a7kb1VGcX
 qhT4Cg7m2VJ/McEUU0cFNK4FOYocBZbw3KKR24cUJ0bysh0055Ma83Rd2m6nLtUSFMTl
 1PlMnyLOwvtAelLqqY4f9kWnH/dkwLWxHYvo+uQYf5CH25E0JQ2oDeaExqaj+Gs48Se1
 qDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yxJIxELbOPOuDiqZ+mVM+0x1kk9yaRK+3ZCMNyzHdWg=;
 fh=6vrxFiHTpMVqMrB7zhgLECcF+aCWJa85hfZ0R47mqGo=;
 b=coR0lmhpO9GVIArRynvyyDS7v0EUfrairfgZf7ZoMfG+kAxWpkGnggokjX7OgSJsD2
 8nQih/5dqKLsal3jajIDpvi2hb/lsBg2hn6HnPf8xSg2DhX1fKxVSZNadR4XW8Ms6F4r
 k2m9BEa/ipxIXNH3UHEJ8oUZ6Ftlx3keXwDBvPD+vXz6kt2s4zquGvJ7MfOP94pHboxI
 P7ReLra6YPs7rRlDYrVzbjcoRr/Td6xiDC47C3CwHYBCMA3VqgwhQbmyV/61+HKv5juX
 6yIBxB+zP80NIzBNdAODOiAHvSDkCXUrJv26Ildo1LvkTaVzykMgQ5icDB4BeB6JjsyR
 j4tQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848702; x=1786453502;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yxJIxELbOPOuDiqZ+mVM+0x1kk9yaRK+3ZCMNyzHdWg=;
 b=ULFocGe39eO3iVcC7ghDRrUp0GQEPQRw8lbaYzIiaAa+oyV0TYIwsivwJfI/uIx7rN
 PdjiGmU4Uqb91LEIDLKHViyYfOtEdloX41RKHhpFhsFygTNsoleqZ4iWpcXgjsr4iP6+
 lJqzYKGDbSE5n+ev9F1P/Ncao6NYQ+nTge2bRoQK1hSpjyuhUyVIFK7/Iy/3KmuqqP0M
 Fz9YQkJM36J9UUnSkP5zi1JjY0HFad9+dzmHVX12ZW8iW/jQFxzo86L9+4j0fEYFXUc8
 S+DCMAS/5NzODm1TXrM19xw8ourwydqIUBh2eo7dhnZDgRdhbgK6xPg5ytiOZXScvhqs
 EvsQ==
X-Gm-Message-State: AOJu0YwUXwXzbUijdpdviwBRFjZQin33r+ZQppQBtq00U4wh8+gTuxRc
 Z66j9R2ftPN87AWpZJTTB/9puQUU83pxQUV+1X8x4o6AelwsVKMzaXwKIcLQXmG2Ej3np3uC4Vt
 OvcIy5mv+aToQg5VeHSVth1uSju1gOR+oFXdjxbtm
X-Gm-Gg: AR+sD13iTbaOj/N5+yxKMn4HKKgBaQdmud7ZHwA3BHBg3JIr/NHsdbsRy3HGT+B+9WB
 q5cl3IoK/kDt9/+ba2Y83ru2JcSRwhbzP/La8EhIOp5C47CJ2JrzHiJkzqlmWOuDu2xCl12jGBU
 ESW+wrrnDoWdQvEKTLUL3Ii5qMaxDlIv7hfS4mOLfcP2ofafs0EJD7o+c07f/FUbolSwDY9hxNN
 JF/eL3tK2yYqzd9YksDCPe7MMefTJlS2Td2+dtyT6QmMwoUZE48xnH+FOX7iRZJNSrJHiynURCw
 57ONyg660URy5P2nlyjJ7g9L5Vu0NsqTPcVitLp0YE68
X-Received: by 2002:a05:6402:44d7:b0:69c:72e2:a3d5 with SMTP id
 4fb4d7f45d1cf-6a0a7c61137mr10979360a12.6.1785848702059; Tue, 04 Aug 2026
 06:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:04:48 -0600
X-Gm-Features: AUfX_mwsJ0Haiiut4mDYXpDnKoQc0zO0fzMNjrUj9yHG-orhRX7le2wDdQUgHc0
Message-ID: <CAFLszThEcG5J7vzmAe2hFXEu7vbCzhTiT5QB9v0ib6c6C8pWWw@mail.gmail.com>
Subject: Re: [v2,
 00/10] spl: Add support for Falcon mode with ARM Trusted Firmware
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848702; x=1786453502;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yxJIxELbOPOuDiqZ+mVM+0x1kk9yaRK+3ZCMNyzHdWg=;
 b=Dp1YQ6VReUY5RFS9hglWh0Ilrda0FmnJBi5z8eQ7OndX+X92g9KCNNEepWEj4hBCph
 WWvq93LZWjuiVFrzW3WPi6go2cxHDgwJvm9aXAF7RByuGlUPEa6DcTs/ydI+VaUqTCvq
 xLwJIiZuS0HnG519cDUA1bqIrP2uoTj4RiNa8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Dp1YQ6VR
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> binman: tests: Add test coverage for a FIT with embedded Linux+initrd and /chosen
...

> This has been tested with an uncompressed ARM64 Image as the payload, as
> well as with a GZip-compressed one (using existing SPL_GZIP functionality)

Just to check - is there any test coverage for the SPL side (the
atf/UFS/Falcon-decision changes in patches 1-3), or is that all
board-level? A sandbox_spl test for the caching behaviour in patch 1
would be nice if feasible, since that is generic code.

Regards,
Simon
