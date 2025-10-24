Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8126ECCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E90EB83837;
	Fri, 24 Oct 2025 19:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eEzYhl4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E9C83677; Fri, 24 Oct 2025 19:22:15 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588F0836A3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7bb79ad6857so1376312a34.0
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761326532; x=1761931332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLpu5XHOj755ZOXTitvZQDqSlr1MhC6ssUfBfhlS1/4=;
 b=eEzYhl4HPysEaw374/xoy/ORZ6opcKI+ir/Km5QBURLD2D+UUY8qcd0/DWY7Je1AOa
 stalzindjn6xIKKbC3kMN8Exn5i4nSGKzyE218o7JDaqYQSTuHlimiClbNpJwSDKOh2A
 qO4B+KW4+kZ6VUG7350kDKMNqG+dGpAKTZvxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761326532; x=1761931332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLpu5XHOj755ZOXTitvZQDqSlr1MhC6ssUfBfhlS1/4=;
 b=gI9k0DdT2466ClNV5qZG7QC7OER/ucK9Lyf5KuYsBrMlDkS8juCykOyg5gaBQjTD9Q
 oRx7gRKB9HX7/NZarOKRkZDMxD+6rAK7gxhqpB4VsJR6Lc+5glkhepQup1Bw/vgGQZoF
 5jBJMQc+ED0u2b22Du8nusqXBH26q7G1ZsASrb3Aq67VvR9lBRN9ET5bduTiXmzT2b9J
 ONZfFZAEbnm4IY6IN6jpDXcLomD8I3JhL4xnRGNKGB9rS3/HsdU7Hi6mf9ejs4CG2Xz5
 z/1zsONT7z+S3ReYaCC94/xA9ZhMlOl/vKVfaI2njLMTnXJpvIA+PRLzZyfAfNVOKB/V
 fXGA==
X-Gm-Message-State: AOJu0Yw4R4a8LxTnWNWHe3RHrrUnLJYdJGgu6C1TQ6b6e9aq5L2B8qxV
 nwFj4ZIcDmvGKnuRpGGrbd1kdKBcmG7kiI1ljZBI+ExbGbnuazj0AswAw6c856V9HVjYtiD6sMi
 ziYLO6sCFKg==
X-Gm-Gg: ASbGnct9ndR2VMkVYZCPhCbDglnGWztAZzOs52u750A/4hsgUNv+DdunBZiLF4Z0gE1
 XgC+7Z+hvt7o5GmsqXEojaoH6UmU/oceKxDGo33P5Py6sIpqKhRu7huEzS3/IxC8F8RoPkiCM3n
 uyEXuYycsxVec30DVysGcNJr7lNEjafM4DugkB/AXYDcAgfD/yTWL9UUoacIqU8jagRifTtsT33
 FpXLnbCKP9FNS60NhLgFCYT2LVHY/2siWlANFCetCyYet9vWmjDWAa+g3vYSAGbqca0BVsNrGYE
 7IHz09+xspxKbF3v0YH8rcoWU8h5HbRGirdrPrdvRkD65XrCsI5YQZQ9Erk6x7Nv0jMd4KNExc5
 m004VUo9/bWlfdObkHMMoXMh/PG6PuR2e8gW7UseAITq6rNU8iFEtv0SCt8woMhPmTKc0D0Sip5
 yFFkONFbM+PegDojekR2vU2KrXHtAhsAejZXRtzr8UyQ==
X-Google-Smtp-Source: AGHT+IGJRUpqnOdI0r39Pj/8xmJ25gBbKTbwgWbsRPpKYWYbTGR/NFwptRmKvk3H9QzXw/g6Vvyjpw==
X-Received: by 2002:a05:6830:7196:b0:79e:9b7f:5666 with SMTP id
 46e09a7af769-7c52408d258mr1556472a34.14.1761326532077; 
 Fri, 24 Oct 2025 10:22:12 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c51b03d784sm1675208a34.16.2025.10.24.10.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:22:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/2] doc/usage: Add a reference to General rules for commands
Date: Fri, 24 Oct 2025 11:22:09 -0600
Message-ID: <20251024172209.2418554-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251024172209.2418554-1-trini@konsulko.com>
References: <20251024172209.2418554-1-trini@konsulko.com>
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

For clarity, add a reference link to the start of the section on command
documentation that all commands follow some general rules.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
After re-reading, I'm not sure Quentin if you were also thinking of
this, so please feel free to Suggested-by as well.

Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/usage/index.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 5dbc0fc49107..6f477b842ca0 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -21,6 +21,9 @@ Use U-Boot
 Shell commands
 --------------
 
+For all commands in U-Boot there are some :ref:`usage/cmdline:General rules`
+that apply.
+
 .. toctree::
    :maxdepth: 1
    :glob:
-- 
2.43.0

