Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E22CCA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 14:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 338278079E;
	Mon,  5 Oct 2026 14:01:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YWizfIMW45ZS; Mon,  5 Oct 2026 14:01:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7914780BE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791208866;
	b=nQpgTU7Yp0j0+GwKdiwk2/Gi1QTDKqEF7ll9wbGyDz/oHKgXRosQ99Sg9cPmVdmQSZ4p
	 ppzSEgF7yoVy6TWgI4wzpRPbzwOru20LiWK4UlWsLy8LetW9GBliKAxzL9H24B/0UQLac
	 TBu+OIjXknzu4C1fB66jq3wJdGNA02N1LcAeN+1NC5+wGjujY18mj87xbubIM884hKxFE
	 q2qGdLM7Nb7YDOgyDgRp1Gxbv1rQVFQRo6/P0P8L0BZIh9Iw7mIvSDa2qZK8ZZeKix0pq
	 Hb71MGwcYDUjU2mPQ0p+Nl+sgFfoY3xX6r9txiPmqZGIL0ZZ/SzGnWVj/5guNb4DrUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791208866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KBEIEFcMcXzsgW2+ZMyV4vVgAP+RBI8vO6R+mODtMqA=;
	b=jWxajJ/ZmZgy7TRolvU96T9CXKFG/bp/Dt17YF+VMI1yDr3AHQR+r7m1gWmgzvRWd8XH
	 +XuVx6P5V47vnoDEMdnFfEno90kyzKtsjGe6AryR8sIuxc4AgxJGgImNqdXkpOpYJJEqt
	 HibaJ89sVVwvqVCwQdFvQ2J2ACrdvP6IT8rUlOU4sBtwDCUEq2KPXzbOjWwCL2VGqP7AB
	 t6TeGKyE5Ye8AUuJWsnznlvHDJIImwPXjKS0XuZBFucYOmQsaLquWKQCuFMDoc6JPr352
	 KQW9WNAE292qDG9ZznzxUOd3Vwm29NXaRA9Yq1XDju5Ky1A0IVy3v1MlVOCLmIc+n7g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=brivo.com;
	dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256 header.s=google header.b=pcf5Lsy4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791208866;
	bh=KBEIEFcMcXzsgW2+ZMyV4vVgAP+RBI8vO6R+mODtMqA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=auD1BGZog+nY+DeQFE2YuSJi38HTTgq3WHYTWTe6mcLG89CUIux7jCybg/XuQpHhJ
	 sahvrpTC/Rv1OLK2EzDKsD4qQsw+/NFKpdedPMCeM1v2f7m8tFK+gBOG33tLhvFRBz
	 vUXZkD8CtlOxQ1NNpktJjwc95YIVgtau+TFxt+RbaKFBRCDTu7ie0UVll0sS1RT8uc
	 dWzyoz0w6Dk3cFzOPAxVtqt7zyOgwllz1Nhtfrc0IowaHt9OAN9EpIkenojRPxTRyQ
	 JKOaTMcEbkX6F4rM6rdizDrJ/eaufQmIeuu7p+DXHgP5Kd0Ygwuij61Astvf05kJav
	 V9xwgrBl+P5hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7914780BE8;
	Mon,  5 Oct 2026 14:01:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF8552E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D108580A96
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pf7YoXopD3RX for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 13:54:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5D1E180A76
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791208451;
 b=eXNAsjVxnRaXQ511/h6kgGcsnqylTjHYWH7AIeWY+J3PvQA32dvYzckfUiFFAUiHYtHC
 VS8egFgZ5l+TshgYAY0pMxundm5EZ6YYqJYtmTuI2GpeYTMupB1DC+drxPlxfavKd5WSD
 Ry228kPlnsx0v77OngpVuRr67iQerNzU3zUO+AprRJ+hKg/4OvTJOPdd7E2rnFgHfRxcw
 B7dG+S4kFMLfsB6VqCvwblAiFodZ3bKswoZR5f4POoiafFEohjRDFQZzwTQkL4inPpAqn
 i6bSOBECPdGppP32Ksb+XMuW0GX6tqM5zmPK2eshsPU7gr+EeGRo6mxIQJJMXzBIoNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791208451;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=KBEIEFcMcXzsgW2+ZMyV4vVgAP+RBI8vO6R+mODtMqA=;
 b=dMXcvqI1BXzTovLo0vnvo1mH5CascZbdDqjk9I2f4qiGPg5dewhKUSfwjdbGH9zPFhOf
 6lSYzctxq885zpsbIWCIu0sc/TFhQowK5NfSFHDSBmzoj4YqW2k2zr5NVtEhmsmimpAqo
 iNbPkM3Mk0eGcS72Vl1p2lrsWJ/WJScpce36p8Esk1e75kVDwOXhe3+yTHs+ROGENAmcc
 6y0u527P+L7KHAf5cCjLe2YE4psp1+CAgSKtbGVySUppOEJJE+la0i/eCdFf/PPMsTVwe
 zXpGgyoY4mZEhzAWhDi+C+DlEMOXWLoK6gruVVPKlfevGR5Ubr1xwwWlRLHgrVdir+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=pcf5Lsy4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2b; helo=mail-yx2-x2b.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=pcf5Lsy4
Received: from mail-yx2-x2b.google.com (mail-yx2-x2b.google.com
 [IPv6:2607:f8b0:4864:41::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D1E180A76
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:54:09 +0000 (UTC)
Received: by mail-yx2-x2b.google.com with SMTP id
 00721157ae682-8ac8c533385so10706207b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1791208449; x=1791813249;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KBEIEFcMcXzsgW2+ZMyV4vVgAP+RBI8vO6R+mODtMqA=;
 b=pcf5Lsy4007c0vSZxDAJIaVZialXJq2jygS3s8iurXB8xKBFkFW0hbqB57YlfNE3UZ
 06/suPM2xytYLhRdxDITv/QBi4yBjyJsVh3XGRfkNATE8wfbSHHsaZJ0v5HgZP0O5hXk
 9bJY6Bpzwdh8Aibgd4guQIPWqUHCv8vM25MfS8ofgsK1ETINBp59ylXCxzXf0WzHYxoY
 QXOX4tB0eLTCifzn2xL8QUr5/k8QWgSFhz2rV21J32x9f+VBnSBaw9rN8vWlYMTKQBFJ
 7f/BeZP1E64looPK+7y90kC9PqZNtMW9hwc3+Ix4Oj70++TMRq6QksNBOl3Ucl+VG+27
 MgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791208449; x=1791813249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KBEIEFcMcXzsgW2+ZMyV4vVgAP+RBI8vO6R+mODtMqA=;
 b=eASjHb17EFvpR0WMxNqKH0cPfTdW/gm6DdWKr9yiwOpKib2uANvbuJhTeMfuouF5Sd
 6IjFn110qjDD/Vbvx0sYqG3Ngq0YUV8ui5pBpwOmdqk1eJOLfWgnY92dJ/g1r2MNBuCV
 w/PWC0p7op6M5tpNNeBb3tEoW0VYX50wth1HBQ8DGDUFgLuS2tbkD6ZTfUs89uMNGp/o
 PARXXHDVn8lRluljB4YTVV/uAUGjq2sQ6nGPBJzMntrp/4Img365XyJsl9WLvi+I9WnA
 DMggEzQIybKSN/LdP/X/mwG/bWE6OJKT8clgSgB2K75EZ2xkkOgaCE5cR8/9Xjig8LrE
 +NIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxU9XnOI1mYd3eEQj7XDpzvqZEFn6c6K0pUP5agFbXcOZm6ABSjdth8Z5j2ZZfE2cnnQeJjT7w=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mdWhkd77lyoBFIG3zlVijVDJsfXdUDHYQCupdRTrpOWgVO8X4x
 WNA3phALj7riHdhRRcr0LzOxbHqI2OfNuOx14WWFJlevgyQfUhnk6njcfzOxn9eeU7WeZHHAn08
 UeV26zkIZa5GIGl2Ja8lfp6Ou7G4BJeA9n16l/D7xvg7N0Wu6Qock6v0/r+D+m9rky6rWq6kcXC
 VAsrI=
X-Gm-Gg: AYBFou35g7+8YDFiNxyhFFa9mKNnkVFbf13XO9xDKCSbL/0BHwBgZQ2wV5q7xCF8jyx
 uTHfg457NpAsQSW+GuJplNoTEkET8Ycaila//wGF/xX0EKXzV+nZhdNz0qWBilw2YSiakYVO5dB
 82yIZHKdQXeWTfa7KnfVOYMXJ8eBFbug4F0Jg3J3N4+5IMoOjFooNr+4KVbSK0gAa6U/w9b5ele
 nzZfeszePora3q+YOh+jAu6pptGgMWgH+tIYVWleL1Pfel1eSiPuTHbVukPb1udV/LiBIcJ2bx9
 QyyCASKEncPW4g4J1GVuDxHrMYzoO7SApJY/3AQE+UZz53h6KT/b5W3s76493tMel76OGP2Co0C
 n8rQ/6DszBPN3hGD4i7RyWsi9WudqcN+Mh2zz4nvn6NhD5qvV/Pu+PFPcc0VOfhk79aKWPYcnpt
 zJcX6bi4o77dWMFC7sPdqbfoyj5xO/uU74IyFSlGGvyhAhZXuvX/mqXHjSFE9wBsY=
X-Received: by 2002:a05:690c:e3ee:b0:897:7280:3dd3 with SMTP id
 00721157ae682-8ae392af13emr43691677b3.21.1791208448597; 
 Mon, 05 Oct 2026 06:54:08 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8ae30120b8csm38852867b3.4.2026.10.05.06.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:54:08 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 Sean Anderson <sanderson@brivo.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v2 0/2] net: designware: Fix MDIO bus getting bound multiple
 times
Date: Mon,  5 Oct 2026 09:54:01 -0400
Message-ID: <20261005135406.509901-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series fixes a bug caused by the MDIO bus getting created in
probe() instead of bind().

Changes in v2:
- Use if instead of #if for DM_MDIO
- Fix warnings about mdio_err and dw_mdio_init not being used
- Fix missing else clause when bitbang MDIO is enabled

Sean Anderson (2):
  net: designware: Use if instead of #if for DM_MDIO
  net: designware: Fix MDIO bus getting bound multiple times

 drivers/net/designware.c    | 71 +++++++++++++++++++------------------
 drivers/net/designware.h    |  1 +
 drivers/net/dwmac_meson8b.c |  3 ++
 drivers/net/dwmac_s700.c    |  3 ++
 drivers/net/dwmac_socfpga.c |  3 ++
 drivers/net/dwmac_thead.c   |  3 ++
 drivers/net/gmac_rockchip.c |  3 ++
 7 files changed, 52 insertions(+), 35 deletions(-)

---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: dw_mdio_bind

-- 
2.53.0

