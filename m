Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7B7C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AEE68215B;
	Mon,  5 May 2025 17:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Re0+lfvD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6DA482153; Mon,  5 May 2025 17:43:54 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A490980F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f4d0da2d2cso9090196a12.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459831; x=1747064631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXzJqyCFo2tsYo7c5WRwHAPTeV0jnSCcuWDAzUBwo1I=;
 b=Re0+lfvDN987Cv34jPQoZGSGzJ/NBxM7/CsNG/2hxMCHxyrpGFkdcKPYsg+xAxEeml
 NdDpJQTK4/KtmJl6vFxNCiWE7Ergre0k+GvVV3CPf1Rtt46A7X7rewMP79U5+z4uZQD3
 Fhvpa8Bam0OHcJeot7Y4fNjc0OlDF/bjrIzqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459831; x=1747064631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXzJqyCFo2tsYo7c5WRwHAPTeV0jnSCcuWDAzUBwo1I=;
 b=a4XMK/nN4A4Ufg+SxPy+T2P1ERG7IrA5gf0ACRvbG9s1F69EfMDc8RXZo/Ll84nie1
 TzGogDPlH+KdlhYAkcgrRDZ7566s2nMQ+D74Q9dDmsfMVs1BxhzJAoh4DOugCS2GYgrv
 I4kNU41s2LJQF7ioUnF7sn2TPiP50cYonLstXpnY5xZEvzUn8L39r6ZTD+Vw0JEqbeSF
 Eo/wYEQXZ3ZunGSlP4rP61ZfS/ec9EMrL3/x0OBgufY9iDG9VJ8ikB6hgZw5APsnVumX
 D7PDRLZQMCiWdmv2VJf2ly5n6XGZjnuLPyMGUVo0GZY4M0BqpdMj1/zuE7xYcN3M8kdb
 z32Q==
X-Gm-Message-State: AOJu0YzfcFmvPpcVYOr+0NgYR4xZvWgaBiAZBwPyUIBwkJb0NEgBS4Ic
 4Q8s6Go8hPDWnUMCtOuJ3N3Enu4abQEwHisO8phiA86rhbJrHXuKPBXL1ALB1KBU37e5L1SfpVg
 3afsnjhw=
X-Gm-Gg: ASbGncsqowlG9cD9/gmYqQaxwTAZodAcEm10pZpduTW1JHfGFVIf8gBsCz5tCvE2VwG
 63pGu/l8rg2PDfBlNwJngcXlcoDOHciMz33P8OEvPZsmTYqdQPk3YbChqAMLSI5h7uB1nCL11yI
 uwF09YM4ulrppj67Xi37mKfNqCojGY6vhPYGFQqId+ALizst2gOnE7FVcSL499tcO8XNAysfs4G
 iyYcY+Ejq68XiSDmzxAKANmW8Xla5QqwMPUxDmuSQocxlKlVPRDpia8RU1OmQV6lw6+QPwFk9jt
 h0KDzom1XXA1CwfNsh9X7KLyc4zyr0NyNgub
X-Google-Smtp-Source: AGHT+IGe3GBnmTI++PF4d3mDu838Wu0TnZRXyXVfnqVo0ACedRAPO0Ou4a3vQRmVql4wJwWsZYSTxA==
X-Received: by 2002:a05:6402:4314:b0:5f6:25d6:71e1 with SMTP id
 4fb4d7f45d1cf-5fab04bd22emr6055051a12.0.1746459831226; 
 Mon, 05 May 2025 08:43:51 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:43:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/19] expo: Comment scene_obj fields which are for internal
 use
Date: Mon,  5 May 2025 17:42:39 +0200
Message-ID: <20250505154308.2911248-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

A few fields should not be changed by the controller code. Add a comment
so this is obvious.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/expo.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/expo.h b/include/expo.h
index 4dee479e9a0..6b191815ded 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -302,8 +302,9 @@ enum {
  * @id: ID number of the object
  * @type: Type of this object
  * @bbox: Bounding box for this object
- * @ofs: Offset from x0, y0 where the object is drawn
- * @dims: Dimensions of the text/image (may be smaller than bbox)
+ * @ofs: Offset from x0, y0 where the object is drawn (internal use only)
+ * @dims: Dimensions of the text/image; may be smaller than bbox
+ * (internal use only)
  * @horiz: Horizonal alignment
  * @vert: Vertical alignment
  * @flags: Flags for this object
-- 
2.43.0

