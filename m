Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23121E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2167880241;
	Wed, 18 Dec 2024 16:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cD1qvN6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC3B802E3; Wed, 18 Dec 2024 16:08:11 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B118022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a9cb667783so52029375ab.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734534487; x=1735139287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8sIabQEG15A9jaAOY5uExa/Lp4x7nME6zCNCFoabUw=;
 b=cD1qvN6rDLhL49W/nr3M0Qn8EP2Dzm9E8kO8zmOW/RlXqwbGneWp7UwnUG63rWx0Zm
 wrts9gMl2ypuSI0ixl6qoRXzR0RPZ/uOocU6c4qXZEUoaJ7TE2mxc2DUPltEETKXYuh6
 jcmDh44OvKLMFRmMLAgWHIB6xY1etdSutX720=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734534487; x=1735139287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8sIabQEG15A9jaAOY5uExa/Lp4x7nME6zCNCFoabUw=;
 b=QuSkZowBND0lnpgjnMy11rFmDLqVIgLBG8taWGxhZYbdAvd5FwK1tBiWBNzCd2n50V
 VWl7QWo/ps97Nb85720vzaov7CFblnlDSSG+BoX/fBPQNxn1/1KhNauQqyo5nyJKwUnZ
 5jEmbzo6BTgVXiiLtpSd1/Xze1m2h2guNNHO99L0kq3Koy81dJQe1W592yu+FsExKeqJ
 +cJGtrBUBuySOQnAsuawhBjA75prvfeTyUaj2nGsFBv6qOh7ubDHhMw7fZ00Ea3BZL8n
 lpP5+a8jZJpCjDt2fTZhLVOfcnTlHVBZ+Xy8ddcGL5peJrsbSG2G3sqHZ2V8ZKrRMS52
 L6hw==
X-Gm-Message-State: AOJu0YwcQCXFgTwYjyNmSVQABrEl5pWaIvjVTYB6wtyqeDbkT+ejBgOR
 2tClMis6jh4q8KRGb0YFkL8TlXTjPYReOwhtIDSSFHhxSsQ39nSg+oSsepA6omxwkZbo2pH7UpE
 =
X-Gm-Gg: ASbGncuMtBx03wUFL3EXSqI4F6n5wz/WNy7dGxmgxNKVJ9Xuwqe0o+BzKsxv07sxbtn
 7CUjqx6FcpEKJlW6eQgwMvaIdDojDn2Qoe6YnK434gZB/U8AqfS2QYt1CuPwmlkXMRmPSGZ5KrQ
 p+XxO0YlgtOsVRoz0uYop7oNk6TAqUCrJ90f0Kzowg4IDMxOBq/7iKePrbPCn545BlMvPH9i323
 iFUMa9QE3nW3x6naQpF0PTePJm1Xw5YT9StgJKIeRcBYnb0HcKNvwW0cQvWFQZABC4TZZvGicHF
 ml9dKJQAHuOaO5Mlng==
X-Google-Smtp-Source: AGHT+IFlJ8salrK4kSB8Y24OwzX8IrhLyEZ5XBGAcNJItebZR0fAA8zwwid/mRa9KgeMa0rz4GT2lQ==
X-Received: by 2002:a92:cdaa:0:b0:3a7:d84c:f2b0 with SMTP id
 e9e14a558f8ab-3bdc0bc7b71mr30842235ab.8.1734534487163; 
 Wed, 18 Dec 2024 07:08:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5e32a3529sm2249628173.95.2024.12.18.07.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:08:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] gitlab: Add samus_tpl to the sjg lab
Date: Wed, 18 Dec 2024 08:08:02 -0700
Message-Id: <20241218150802.4064561-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218150802.4064561-1-sjg@chromium.org>
References: <20241218150802.4064561-1-sjg@chromium.org>
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

This board has two variants, one of which boots with tpl. Labgrid gets
upset when they both try to claim the same hardware, so we might need to
see if we can handle that cleanly, e.g. by making the job wait.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c620cfd1e34..72959427951 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -593,6 +593,12 @@ samus:
     ROLE: samus
   <<: *lab_dfn
 
+# chromebook_samus_tpl
+samus_tpl:
+  variables:
+    ROLE: samus_tpl
+  <<: *lab_dfn
+
 link:
   variables:
     ROLE: link
-- 
2.34.1

