Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE5606A320
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mLRJnbPG;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=sJnspsUj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15C1760A38;
	Tue, 10 Nov 2026 14:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ixKWOtmRVCXk; Tue, 10 Nov 2026 14:50:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59354608FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794322201;
	b=pxLiXjXyu+cejdSgpUtlLts8UfCU9Pih3w9R5EpUVOpveJLa3z1jORFNvD/1y6T3jTsn
	 GaBUGGYw5iioMUB9S1a9fUreNQd3XTLv7k9uT4py1tob88PcZ00uMnpX/47l7IR1+JeFe
	 yx1M0JhgBEp1OJdWZVh5hs1anc0h5DUToKGdOjDALXznTQMzfJ3e2jC7O/3w1B1FOcVQ1
	 47JD5qdpUhQJ/y2SKAKKg4eTVa+K8m2YUSF1FHkbjg+EQ1t3jLe3Mz/LEPVXf4GfMn42I
	 LldUNYNBEbHTJmV48HYPK3zQPHYwlG/dbZQor+QZZ5VcMUZenCawHOcxI5LtKIxGNXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794322201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ceBdcgKmS26KZ2DHyR9+5+F9pSzVBaAK/MAp1Unpce0=;
	b=koZsco2yZSbZUL184XPa6+jv0p/RuorCWRySMYYKUvnenl+3WsN/nIshtCG/Ocsv5cjh
	 Ofw2cmOM3ZqGgf0llQ9TxlrIhajPJ9R893Nf4eglbgFrZsPN6XKK8/csU853epdYM7Y6+
	 6lL7JZrK640eEaKEDRPuwENCkOMGK61PicGIa9w0Fy00q5GO9hOsxxk8bkY2C4Qjg0XAa
	 jke9fTF2KwSX5Wy6t/4akpPjAKieGc7qyfxIM0/MgvnkgRoy2NYpuM+lgawyiBRhcVm06
	 WjELbrTBruAJIDkwHSa6aaurA7z29XDefDcFu/jdU7jnDKELLpLyXsvOd/CLUVuYmVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794322201;
	bh=ceBdcgKmS26KZ2DHyR9+5+F9pSzVBaAK/MAp1Unpce0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mLRJnbPGAbyVFk1cZQFq2EXtTQZcNaTIE4q96vipRXWvTl/8H1yZFvxEZJo7hgRzI
	 aw74OX8ZfR/B0w/16cdxD3W/F0loluukQwZxwZkz7OsY1VGdyFcof0UVLDy7t2byyq
	 Yn9Xp1CdE1wHapJGQLxqM6ziOUVLMkk6QxWSw3EC+XNhbppq26ZstuV1ZXxkR9bYGo
	 uZzN6cq8rGS6bkahYf8vIZbVzebvdrbfvFVJH6iitJVnh4/YL/67d3BxyMxZOtGK58
	 rUPeTj8i/v6vwVhzSMMA8xNo0C0IkKP8F6lRnR9h3lK9KQX73+olrQQaDcwyXaojEF
	 uBl1UaiurhX5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59354608FF;
	Tue, 10 Nov 2026 14:50:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 717631FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62FB44036E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:50:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9eP6ZBeITqt for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:50:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A4B4E4031C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sJnspsUj
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4B4E4031C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:49:59 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-833e671ee9fso2042553a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794322198; x=1794926998;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ceBdcgKmS26KZ2DHyR9+5+F9pSzVBaAK/MAp1Unpce0=;
 b=sJnspsUjosSzwgMFIlikuEAdBuHYamUhD6gc5UX7m17UfsGT6R9fFSItki76wuezQJ
 0TuT/8bB+fwE7kF1a0yFfwkRBppqQnXp7O31jVDI2wzoi0aqZOgE2hqK8sN3kgDMFXT6
 JLVvkgbkIouJ6sGSzVTqe3Y8l6pY6ljDWp+7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322198; x=1794926998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ceBdcgKmS26KZ2DHyR9+5+F9pSzVBaAK/MAp1Unpce0=;
 b=a3dPGI2E7hcvJs7LpVs3qMhV40dDMgOlPP/2qx11b5kvgqwX+VtZz/DVkgmM/MQeAI
 WlEq7VkmQQlpBtknE9TbeCXkYI0f6Cm6SFfqvjJ5l8pqKLaPi9RUz/lx6m6PHjtwBFah
 1hsNBOWOOZiXSDtIFzwvsi7qox2m+jpWXfyDzfEzp2fQwdGaK/mVA4OzixDeS9g94u23
 u7FniEnl+ClQ7fP5D5ZdNyT9j1fgnyTOl/Y5/K1RlDkXB6v50m3jZonvToPt5QU7eU6y
 DJDd+ESiSAPtsjevXI9Z9wFlsLsHjl7l6/jY7IpXgzZPUYULxtqmqpicpGKp7+TdyIXo
 9clw==
X-Gm-Message-State: APuU4Z+lEhZWSoYI1clkTaXQ0NVC+JLvftzKnsqPYIURHZd0DXEPkdtp
 pzVwSeOFIOE4kLgvWYvkaqN+RZqBfVPndaFG8hK/fd2NNcXVGF3nfHZHxybUQaMUSDyOkrznn74
 5bYRAPokU/7/C
X-Gm-Gg: AYBFou35LXfg6OE2mRgp6vydwfx5+pitl9Dy8RF50fk2vXy9eP1yT7D3Fqdf/QBFQfI
 Tey3mBw+qLuV71SQcsb2TJ8Ya2Uxj9IdTayBllqRhmeHJIyDPoCfuCypRtPEx8qB7Caj/B7UIXq
 JK/yQl336gkEAiZ8VonX3OZnXa5s1nnctxMdu5olQ24BZF4Rfnvf5scffupNet0s62U4ALuZRFS
 UbA9kb2iQjgNwBbSscpkwKgczqEwBWJgYXbJmKQeLVYBUoNcVi4Mz8rGulS+qrsFQ3YJexBfMzf
 XRmN13/lizn8FqV5ZAC4cRy6t4AblOlp5h2aBLQgeCZYdsdkfloXXZQdUXeNRz5zdC9Hnv9EIjq
 Fyz5X8htglSoM5WwwInwRotHZGbF1hpYtmWVV3II92YAWJJFHItzq9QqRsc+AAjfb8n2771C+IW
 Zs4F3X4xrp2hf5yHQdua7YKKVLuk/SmTY92htgBhowv2SS91Oooekso2iWJsu8AvSlkxx2niI/p
 YWlEcOQzgKVbNxIMZqalpceIe00OIDTUQoc7aSuMfzL7T0XMPwlqeskPTp34F7hamjmgcPbBO0w
 +D9BVWntCDV6K/jsiiyLMTFGPfxfVHgMraJqk3xOhk759ngayNSIT9qkSz9S665HxyUNJC6VvWA
 drr0yF43nLF3g9w7HcQNthHL5OoTCF3PZJvPIwnqC7y0pUOMz+XkzJxYDRCXWEisP6LQ4gaPT5U
 d0FfeapoG70AdbY04n2RFctPQ82Jr3sbuJ5swtzhk+Q+XaOQGkHcRbxOg=
X-Received: by 2002:a05:6830:4391:b0:81f:8a6d:7b52 with SMTP id
 46e09a7af769-860dc7fdb8emr2130562a34.24.1794322198020; 
 Tue, 10 Nov 2026 06:49:58 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcb62443sm2069667a34.6.2026.11.10.06.49.57
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:49:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] test/py, buildman: Update filelock package version
Date: Tue, 10 Nov 2026 08:49:56 -0600
Message-ID: <20261110144956.4094684-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The GitHub dependabot tool has reported a "moderate" priority bug,
CVE-2026-112909, with this package. Update to the latest version as the
minimal version for fixing this issue security issue has a regression
with our testsuite, which upstream has since fixed.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt        | 2 +-
 tools/buildman/requirements.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index c3bf31d057a3..832c1044e5cf 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,4 +1,4 @@
-filelock==3.20.3
+filelock==4.2.10
 pycryptodomex==3.21.0
 pytest==8.4.2
 pytest-xdist==2.5.0
diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 32c14fbac576..7590e6c25fd7 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,2 +1,2 @@
-filelock==3.20.3
+filelock==4.2.10
 importlib_resources==6.5.2
-- 
2.43.0

