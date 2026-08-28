Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0FAC61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 10:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C524E80DC6;
	Fri, 28 Aug 2026 10:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id seu5CZIC25-1; Fri, 28 Aug 2026 10:52:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787914345;
	bh=mLskofQnK7XABzG4QQnEHFJgJ0jyqwWEUUWwzjPfYEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DPFAcHMMEA4Luo6GW3okgfp8E7XeUke1E9cqwUBzRMuOnuK3/ZxORhzKUJbRoWMHg
	 y8HtipGOihDJHHxynRy/9FIlA5gJW5/LpzhdCa+s1vfBa5XeY3oX2XNJrRlJN/Naia
	 +L/xsdUFMieauXoeXwRSGIhEBfk0Bq13lb4EXRSVWT6oAZLBBCM3HygHEpMFv5vIOa
	 5csb+cAu9yIlEKiJD8hki4vdZwMNNkhqpDjzByePqHA5hf0st5x3VTAALe8eOcR3fF
	 HCzWkZE72twdO6aiScYucIUjoLVX5bpu2f2ka0WxnTq9P/JguVSc81mEUDC2USGenR
	 CshBidmSw7oZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DD5E80C79;
	Fri, 28 Aug 2026 10:52:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 866D8CBC
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7867180C79
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ayRv1YdLnySb for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 10:52:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JnSiTbeo
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98DA180C44
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:18 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so636869f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787914336; x=1788519136;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mLskofQnK7XABzG4QQnEHFJgJ0jyqwWEUUWwzjPfYEY=;
 b=JnSiTbeo5bTVSct1yRnTo0lkCUWZpI6x0MxYr+NIfcfCWwz5gU/GuJZuxLTVtS4Xcd
 4kj56tHyO5hwcQmNk5+y1Fr6ZigsWDXy8pUdvhiqzzaiKuAfo9UivvFhtHR7/PT9lVoP
 bcHkS8gUQiqEK0S9mcGzrVDrB/5a3ihnMdWl17OvhgvKdWCMsVbWyA1yBMQaxQpS3n/Y
 +zlI9gC5gi/xWvp0LRenHrYNkHUcd0MsX1wQiby3zGpg928AxXeMGms2struoDnn9grt
 /DcREMokiz5XRR3MICpOg7nEKkasnFlK/EwJrLlS8i62wF/OgtA7iK/TCnInV9KaE2IW
 VHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787914336; x=1788519136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLskofQnK7XABzG4QQnEHFJgJ0jyqwWEUUWwzjPfYEY=;
 b=m8z+VTaJ753YdoczsV870xqqn4zOEXjyxflakuvCUZhVsZiVrMv03fYIlvMD320VXE
 S0PLR6Fui9Iq91KaSiVndvCMSN92LLkKHcfAiQ8C0CVipho06BBLDYwtrKZonuVv7GEo
 ZYLkvlcU4OeTbSS5IWTLAZXxYcMf9rf7vIcbY0uBu7wh8iWtwqBKJqL4Sz6fj/nUKLeg
 zq66swEW5lYoPIsQKNpjpYCJDZYM36Xb4eyIIzXaTBoiUF+RWhg1Nn9dP2TJt1WB5B2Z
 v/9hnfoCwr6B1F0jlPNhrtJlEmos/MOcIfegLaMWjA+mPq+lSh1mJ9lkqv9uluyzNyvT
 WWqw==
X-Forwarded-Encrypted: i=1;
 AHgh+RolN/U/qtQvelyM67CMKIddfaVEiaLMyNXlOjFNBT02itMEF3jZNHuoPBErIdUTjg21TIGQEec=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l8B1lDdRTZnV22PoSOPPIOHCoF6PoObXusvAp83dOyMDhobSJ0
 49pNlsE1RtC1191MQ78E2bb/2ObKE9hU3VR+Ia5p7XqGqNMK2VNBQzKz
X-Gm-Gg: AR+sD12/nXuPFBLAX4w7LlCTEtpFhF5jCnjj48ifbBKZZFQXbBC95qbbPjNLnBBE6TW
 loiJXdEsuu58adTjyBuB/6A0OgyWDAFG+85XWUgBSSw5cE5yAoNNVDOS56oVvwjOA4amt5Up/IB
 oANrKtysYTdYgamHX99t1CyrpZkrNuv5+oWWxmmKvG+VApa98Ra3UBlvH3VXkorUz3sZA49FcGz
 52RIQIn6I+n2LvLzw38y4KBZEdcycnnkvi6AKNk5GcvCvZjWzhEXBH/BhOZ1hOPBaw1O++gY6+8
 80YsqEljpZhyTBnBHdO2JcJyLOMf8u2Ah4RiebxKc4hPAC9xOdMnK6fmVtMXWdWhfVPxwmdNhhJ
 JRGL2D2P6CURbaRnGNp63wNCLaGs5kHGcgROF7z6pJ3FO3nlsvobEaSg4ChJ7s7X/kISwrInbHV
 +7+9RONXPTU2ne888J/cEeLzjJ8W6r6bEZKf3xiyvqr9TmLN+u/P6NN2FSzNZbO5YqwQ==
X-Received: by 2002:a5d:6f10:0:b0:482:c72e:6af4 with SMTP id
 ffacd0b85a97d-482f782b5e7mr9650102f8f.0.1787914336076; 
 Fri, 28 Aug 2026 03:52:16 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm3212202f8f.1.2026.08.28.03.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:52:15 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 3/4] doc: driver-model: state that of_to_plat() must not probe
 or claim
Date: Fri, 28 Aug 2026 12:52:09 +0200
Message-ID: <20260828105210.32664-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828105210.32664-1-mehmet.fide@gmail.com>
References: <20260828105210.32664-1-mehmet.fide@gmail.com>
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The design document says decoding the devicetree belongs in
of_to_plat(), but not what the method must not do. Spell out the rule
that has always been implied by the phase separation: no probing of
other devices and no claiming of resources, and point at the
parse-now-request-later GPIO helpers as the pattern to follow.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 doc/develop/driver-model/design.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
index 633545944d1..7f60c75f4d5 100644
--- a/doc/develop/driver-model/design.rst
+++ b/doc/develop/driver-model/design.rst
@@ -759,6 +759,15 @@ The steps are:
 
    6. The device is marked 'plat valid'.
 
+The of_to_plat() method must only read the devicetree. It must not probe
+other devices or claim resources such as GPIOs or clocks: ofdata is read
+before the device's pinctrl state is applied, so a pin claimed here can have
+its configuration undone a moment later, and probing another device from this
+method defeats the lazy-probing model. When a resource is named in the
+devicetree, read its description into the platform data here - for a GPIO,
+gpio_parse_by_name() - and claim it in probe(), for a GPIO with
+gpio_request_parsed().
+
 Note that ofdata reading is always done (for a child and all its parents)
 before probing starts. Thus devices go through two distinct states when
 probing: reading platform data and actually touching the hardware to bring
-- 
2.54.0

