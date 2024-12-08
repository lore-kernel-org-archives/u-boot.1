Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD3AE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A22CD8954F;
	Sun,  8 Dec 2024 20:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IMraxU+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B9B8954B; Sun,  8 Dec 2024 20:08:03 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF808893D6
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d900c27af7so11267636d6.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684877; x=1734289677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bDxMXaH4Y8EfWN3T0ePQlVwNiD+2Wt4L6wbiZh7Go4I=;
 b=IMraxU+YqbteVGSkVbCOW6knSJTF6+CSm4OnLg+/1+K0CX8rBb0UME9c5e4BZQL7ow
 P8I1e6jCxa0TL4E9pBnf2iLKJJkWR0LTnf1Rg6M6D+PccvGHobCbE0rZb/CEtz6Hw35+
 mbkldxJNKe1zpMCCvDYGdVJCoL2PQ+dEGZbGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684877; x=1734289677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDxMXaH4Y8EfWN3T0ePQlVwNiD+2Wt4L6wbiZh7Go4I=;
 b=Dz0pGrfJa3oeD1VeW3cS3a3qdZ5qxdYMHdEOBs0MkfLOyGJOuRfXaAdtxICOgjNcND
 XEPqL5Bs+2Cd1M3s8Wu7w0SMepxWvQDBlLiGivCwG9ujZqJ4Ga8k0MY1W39WcS0w5q9C
 LyiIaKM8JZdORNeY+UTxmxF/RpeuOjCY0XqGiB8qXA5y2eCdLZ0z7qo6XNwTcgl+AgWg
 A6bIaJGc9h1igS8fMtbi8vpDoXQG1Rf43TjY0FITIHebVutITRkvdcbizihqeO9B2x29
 PBFYk5e+dVYTPDECVxLs4LUiPuzXm2jAaekmcBXUZsfLn/loYuw/R9c2YilNbvqpdUKi
 TXSg==
X-Gm-Message-State: AOJu0YwXpDM8sw6OeeE2OPnLo6sxw/szzwIFjUX3iyOaB1eSpXQUH22Q
 RBC0BWQzp5EbWWJm5DfWsppio/h+74CJWGfm0U+LJwsUbWuWDF+IsTciI1otKPS2vLbmCpfCu4d
 H4Yg=
X-Gm-Gg: ASbGncuWy8QcSax5d4YLalLCfS6ZYbhmToXJ6IlJpFnUaM3TcEgBcp3HvP107rYFWme
 Gj1D2A7Su7hQ+IuRFu9V6crVI/4reBkh+xmUR8ljwkZiOsg8cxAcA6+NPg3cwsU0K61C41K3gAs
 vnuiDtKnCJi2wThiSxBYuYW4m5f65lW2DHw03i69ITWrVDcJa0dPN5Ft0xmulccAXtrCpsKSWP7
 a4K+UAkqskVPUz7qMXxiAQchp5Hg9yvvxhY6SMdfdqnN4YivuanKmQ/uws4F4oQpH0/f9AeOQ==
X-Google-Smtp-Source: AGHT+IGTG8gtIXrWEZ8nC/W3iLlKDrCuvTzClmGQ9075N5iwwcvOJYmyFDzP2axBg9TltbYhl0wwKQ==
X-Received: by 2002:a05:6214:2681:b0:6d8:9610:a9ff with SMTP id
 6a1803df08f44-6d8e70ef529mr131783696d6.1.1733684876945; 
 Sun, 08 Dec 2024 11:07:56 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.07.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:07:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 5/9] Gitlab: Avoid downloading all artifacts in later stages
Date: Sun,  8 Dec 2024 11:07:28 -0600
Message-ID: <20241208190741.4192601-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
References: <20241208190741.4192601-1-trini@konsulko.com>
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

In the test.py stage of the build we mark the pytest results as
artifacts to save, so that they can be used for reports. This however
leads to all of the artifacts being downloaded (and then not used) in
later stages. Optimize this out by using an empty list of dependencies
here (which is the keyword for which artifacts are needed).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ae9120655b0c..696d3cb1bd74 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -111,6 +111,7 @@ stages:
 
 build all platforms in a single job:
   stage: world build
+  dependencies: []
   rules:
     - when: always
   parallel:
@@ -521,6 +522,7 @@ coreboot test.py:
     - if: $SJG_LAB != "1"
       when: manual
       allow_failure: true
+  dependencies: []
   tags: [ 'lab' ]
   script:
     - if [[ -z "${SJG_LAB}" ]]; then
-- 
2.43.0

