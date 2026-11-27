Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD85606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rqHCE6Uq;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=JMNly0a/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A816A6061C;
	Fri, 27 Nov 2026 16:29:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JRlXxg5USs-t; Fri, 27 Nov 2026 16:29:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF36060A54
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796984;
	b=TS0ATFuFECjXH7dXY5mVIwqSxVIm6V6+8iM5I76grnk0hD5otVwCCEujOhU2GzVzUpu/
	 6yzcXoCTL04HmgWWx4lw94o8MEiPUkzQTUXCpO2WdGJI5HUH2tlyby1cPEeIVkHtdfDJj
	 ZjnqcVriWQoXGe5CgGaXZYHrjWT3u90iJknqJYh8+MkHFpBJ2JuU28lm+Ey/vr13qjGk0
	 2J3JiABuKo85I7qNTJa4w0Ts3rn9UVUH6/lcO4Y3VjPUCe5C4u5h3kBR/jtVOUioLZNlk
	 /TFwQ1oHHFzvj6MbRU1BG45G3Niz/Hpw1vbdZ0VkKgT264hqHNHrBG5g+0vLZm6HqIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HOW9xSG+UqTFw0Z8eOkmeWEsqA/evsO5Om4lfZ1v12o=;
	b=fPi5fg3AoAX8imD/rLyf1Md4pzLGh/1UN57l+YB+g7OJLoTxIQ+YHCKkLPAGMxn3RoaH
	 GFtIHeQbboq+b/RZM5O9jr+OWuKYY692T6wavRQSuXiNh4o/GUJOAAIXrAV+LbcSlEyxs
	 qV4tCHDCSII4I3iZZceBDA+ju1ArMNxWI9j47KJVd+X+UJCAlnYF1BJcUk+VSd25gUOvX
	 tyXdam0qDvncltY66Tf8L8TSjLgTx2Xqn5T33pP9Buy/ExAeoh99AjSaPWMBApB2Bga1B
	 3DEdWYCWWRLRr1GltMnWiqw8Cw2zPoYe1fX0OHM1YdawoQ7rxZn70oEmmHAECuNgNTQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="JMNly0a/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796984;
	bh=HOW9xSG+UqTFw0Z8eOkmeWEsqA/evsO5Om4lfZ1v12o=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rqHCE6Uq7ydhlc0JeuYfKp2GVd9ZNXXr/TkxFrnOBFm7sOWD+rRnwddFg7FvjQf6n
	 1BkgSJzHILx4iWz/R/3mNYF7evsfqwbz6uXBMuo6j5OT7qR3uajgbroMS/0GKMHIrA
	 uOz/1td6sWFFSCDjBelxBHRV3Ygga/e2Oc54qYPG4OU4ktU21kgPNvzGL7BE1Heok8
	 RzFJSVq0bFim6zIyXXz4bY5vP12K/Y3Z9eG63KfxSfijHWFgocldBmUaPToG58OJ9d
	 JogH1YJFgEBDMUPdthgZpdZUqoVuOeS/IE5izmubNjxBHvjb+WseDRZTJ1Er4zHAUw
	 iyyL46m7lruzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF36060A54;
	Fri, 27 Nov 2026 16:29:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 56C1E1C9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CF6860B0E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YPcxjEP5VRwW for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:29:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A26F6061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=JMNly0a/
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A26F6061C
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:37 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-71ac9e15640so5149130eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795796976; x=1796401776;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HOW9xSG+UqTFw0Z8eOkmeWEsqA/evsO5Om4lfZ1v12o=;
 b=JMNly0a/ShdonohPNIB8l6YerqcxIXa68IhePA8Ym43JOfyoeDuDKoyLYm/SxbGLhF
 jwDdjHsCM1df2ctCRogVCzRGxOt1qdBY6PVmDo6VoS3QCe/ZB7m3ndunZLQ3ufXEE7HB
 p8nxi30M/3MBxB6+18tnBOEXBadzL1e2zy8+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795796976; x=1796401776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HOW9xSG+UqTFw0Z8eOkmeWEsqA/evsO5Om4lfZ1v12o=;
 b=QGY+v596yjScmBIVlt/blMmMp7ixqO1yGvaJ8Amcz9bJA0s7oFi9MvYGvGlnbJGy5R
 /2Nzf3+JoEFUIIFChQpkEArkn1AlU5fqZC8Q31NoeWk6mxUzIMkSFvkqDn8JPZFVqUy2
 TcYkn44d8BHPJph+AE+99cJ0kNZA68TcFzcxQTVYBZotMGy4/FNnl2EMHPFGkoSat5Mk
 D7SO4mwq0LojHu9v8KY0141uyMQ1Jt0acxwvrajxLin30K+TlsyjKI4RM/I1xqKyXVUb
 xc8wZ9SpeuQBKvfmYOMV6hdR64SDh05Qfi5jmKz3AZKLRP3itrtUooDxVpan5nWlg7b1
 2J8g==
X-Gm-Message-State: APuU4Z9P6Sx0zG3jqpxcZnkKqyLo5UlezV6vbo5CjnG/ViLL7KLM4w4R
 Yy6hkEjdDyihhBUl9LUvOneecVQiss8TO4TLqFE5t0MifIzzcsIsb8NUX4I2BnAQZIOAWvIYcAy
 4rgHulKACswHk
X-Gm-Gg: AZFdTZeLO0Vi9/ASiCjshENmWR/lGN/as7vd4PpX6v6h6bzASTt8DMheLb1+JgYlg28
 lsCo3MLoocWdv5CsgzeF5TGvAzVhBUP5dabb6WCOzXjGAjrjNflQ0IPU+EnrUp80iAsxUHt9zzC
 RK5Vf+OGFOKRZ0Z+7J5AicuF0bkuauDArKGukVi0f7znoeQan+ry5cALkiGtvleffHyre6ConTp
 i/7Uu4GXQvw/FtijDld1I8GsHdNg9TycdoeCcJzlhtlAlTDjaQw/eX47wgjbJ592qhNFVva+GOL
 mcw04NsbQ5F5ko+D9gkOQ6tvbq8xkzSQZ1Zdl00q5rh4YNrBi90/v+5uvWUmCxqzk9h6AI1eRj8
 R38hSD988QNzEWJmrGvE6zop4ZdAazP9c8Gke+gkx+nSxN8tZG6cx4hFurBAlRQqqdg1bTmn7Sw
 20z1qIN9htgjI+otNsBEG37WBytXDe6u49gKxHa1UhDpc4Yp7XmWoTyXgn7BUnHEaeMqbb+AABR
 5bI8gIvCxIQWQkv8WKEIkGJ9e1pSeJfcjk3M7JDV4ExaXTBo2xxKqZi3d1msn24DcwTpHY2RyPn
 ZnpZkrhxzxI+UzGEDNfr2YZI7NSMqOZCsiIS3g1QcD5BUBzwiAWayXPe65cmQ6JhGuvZzp/BEC8
 dTbccijyYKuHEdqwSSIl0jiAEFhOiG84uEqNfiT/LnTIsweolKraFODxCcnx1w1KKhnKSin0JrC
 18AXJZrt35j/oipw2fbJs6SAqhZ2NVEEM6TFrs5w8JjXYhzC2oUNpckio=
X-Received: by 2002:a05:6820:3510:20b0:71a:efbe:ef21 with SMTP id
 006d021491bc7-71b3920c4e2mr13694692eaf.5.1795796976066; 
 Fri, 27 Nov 2026 08:29:36 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b865900ccsm4746056eaf.6.2026.11.27.08.29.35
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 08:29:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 4/4] Dockerfile,
 CI: Update to the latest Ubuntu 'Noble' build
Date: Fri, 27 Nov 2026 10:26:29 -0600
Message-ID: <20261127162927.3545062-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127162927.3545062-1-trini@konsulko.com>
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261127162927.3545062-1-trini@konsulko.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This bumps us to the ubuntu:noble-20261110.1 tag and also brings in
recent changes to our own Dockerfile.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fcf7aafade6e..46509eeb7df6 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -1,7 +1,7 @@
 variables:
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-26
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20261110.1-24Nov2026
   # Ensure we do a shallow clone
   Agent.Source.Git.ShallowFetchDepth: 1
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b78f7a9775ad..31c3d53806b9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -18,7 +18,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20261110.1-24Nov2026
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 9c1fd21884b9..619eaa491336 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:noble-20251013
+FROM ubuntu:noble-20261110.1
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
-- 
2.43.0

