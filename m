Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FEFCD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AED584942;
	Tue, 16 Jun 2026 16:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K8J3kX0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2609A84942; Tue, 16 Jun 2026 16:29:56 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07BFE84895
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e6b554044fso3771465a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781620193; x=1782224993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkyDLAX+pVSp2MfAF+4JUn0HGBQiceCgXf+q2VGMWd0=;
 b=K8J3kX0YmHdFcIMBGODj2xuyHniLaK0U5IdX7DGfQ9XyJbN/jFpWpxNLAz0LgEkrtE
 BSlsAYTTqdfmCE0PhfAT5RmA6nagJy6O/g84+gZtwcFoHs+qSffi//zhSdbydN3OfPoA
 6+r5Vv3FzbcyVD04GvIfYZc0V3T+l4BM2RSnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620193; x=1782224993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IkyDLAX+pVSp2MfAF+4JUn0HGBQiceCgXf+q2VGMWd0=;
 b=TLUMF4Sv1qolA7mYrcBK0JQqcACrcZU3Qrs31TOnfS0QYROvJMXf0hstWMolD3mZXh
 8W65K3SZsn8+6fmHhj7nCXd9TcxqjSZQV1w/rIiVpIGOUP5VmDNFcVjPjA5UmeCqh7Kh
 DLYwi125q+qlkF+3qAmoVOp82TVNX5BqnpJIfad0PnEV9Yg94+rqgj8OXJd42P8kW16t
 7dUty8jaqtQjL8u87EfqjuqJX3inQbRqnniJYOluFQ4bxUIIGH635mpY8BxP8MvRKiEd
 KDvrG+JOTv798IcwlfLgUrhC1mQ//iBvtwjg0MHPBI2x26hMlBcTyZFimWArzDZFgYr8
 kd+w==
X-Gm-Message-State: AOJu0YxEGzrgjRnzRou9L9Wq6raw3KTLZ9Omf/J1ajWCp6UhJSkJEbNj
 ixH07aNFsfUA3UZSfsL4uuDAxZjJjgmi+UIh6zLrqCx1O9CtBnJCC7k0yYvQ93r7wHpYp9Z6/3c
 PMis=
X-Gm-Gg: Acq92OFVcEVub3uy8HgMDBSd6zR7sLNe7Wc3LjgDOtVbGzjktHkQh4gf5OnOF9ZlfWu
 fcOb8dkp45klaxHwr4Evuftn4F/F+cjt2YE5hzTYONQ0ttIUjSbQlBIFc9S2HGJ2tOmVAGBtMMp
 IcYF6s/22WwG7fEzE0A0vzRzRWF0UXe1aAqQsvEA71yhcFCD41sSv6/kxOy7ki2xg3RiweNr/rQ
 HVgRpJjOSLGUbGda5NAWV1fgLmuvygbnPW6VIqZAKkVeIIhgl8ruJweIWagfJ/h5A8v1ABxHS+0
 LZcfXAzlThA+IbgUM7FEQS48mIEh0mE1GvirKfcAvfKHQbBf6X547IIixOBqZDVk7LXYTYdAsqi
 deNm2XKYVyq8voeVVPdRYjcoZSz6CwXCoaKyCS/9ZMvt9pInygv5bn8UpK4UGIDFOqWy18lQco+
 J6E+3symIBS48/z6rWXA==
X-Received: by 2002:a05:6830:83a9:b0:7e3:7dcf:9d3f with SMTP id
 46e09a7af769-7e78478ee9cmr14058456a34.16.1781620192740; 
 Tue, 16 Jun 2026 07:29:52 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6fb5edsm7263749a34.26.2026.06.16.07.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:29:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/9] u_boot_pylib: Require setuptools for building pylibfdt
Date: Tue, 16 Jun 2026 08:28:44 -0600
Message-ID: <20260616142859.54136-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616142859.54136-1-sjg@chromium.org>
References: <20260616142859.54136-1-sjg@chromium.org>
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

Building the pylibfdt bindings (scripts/dtc/pylibfdt/setup.py) needs
setuptools. In the tree this comes only from patman's requirements.txt,
which a later patch removes.

Add setuptools to u_boot_pylib's requirements instead, where it is
available to every tool that builds pylibfdt.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/requirements.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/u_boot_pylib/requirements.txt b/tools/u_boot_pylib/requirements.txt
index 1087e6f2857..0f6a230d522 100644
--- a/tools/u_boot_pylib/requirements.txt
+++ b/tools/u_boot_pylib/requirements.txt
@@ -1 +1,3 @@
 concurrencytest==0.1.2
+# Needed to build the pylibfdt bindings (scripts/dtc/pylibfdt/setup.py)
+setuptools==78.1.1
-- 
2.43.0

