Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC11C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA5374065D;
	Mon, 24 Aug 2026 13:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rOaVJsd41ZEQ; Mon, 24 Aug 2026 13:13:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577203;
	bh=Rrr0PgLJMKPfx+Iqb+q3bs0vvogEYzlZkZNtWgifKn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F3xZscvPtCU+LpvPEI9bpr3j+UbR6nC2YqsvZOe/atAAk9aFh8IG7Om8vvTjAezJf
	 R0ucPAtDcTOZaJKHTguzuU8dhWyFmsSBuheLwSAMI3Mp+EWLKkNkfRWDfe73kZqdYg
	 n85JM64c4V7vrRJh12AYkuTFjTRcgsv3LXjxSe+WN7OBNPky8Yg3X4SMzw8V2NH2Kh
	 gNdT/1tCJ/QWisQoHCF61WFIKTPjFUTsOiCF+5wK82opK7vX1jC6PfWHFtB/F+9qiM
	 Meo3KBJiyGCL9XnStX6Agh9FI9HTbj70OPY9llK8lCYW0tqlVOGb4PS149FdNbqCzQ
	 /Nn0MVcrNsUFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A83A94065B;
	Mon, 24 Aug 2026 13:13:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65B04386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C044405A9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KjQQpI9RGtqb for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=s67AT6te
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4961B4054A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:19 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-482c58a8683so1314831f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577198; x=1788181998;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rrr0PgLJMKPfx+Iqb+q3bs0vvogEYzlZkZNtWgifKn4=;
 b=s67AT6te6qIlWxJaFsoc/TyTd7w0CulQ+X2YePjTJ0EWpJTibLMIIqAmh6K22Y8AMW
 YcN/EV5e/P8fq+DUkSXTeXTKidRhH5RlRgU0XhUyBSKOwnfOHlXzz8bK06nZq8A5dsTk
 7TcfvCatKIo497P3bmNJNJPQlfHqrD0RgXpxCwBLD1NSzTAXfjk57cS1syZKkg3CyIVL
 iFgjlmxr99PujSnSIWF2toMYnw+R0+UyIaTEfsRNplwed1PSVRhmTutHWIicZLGuIePF
 pqd+Q9bDSrPIcp0CTCB8EOvB5XHWbr4NMZv12L+gdgM8HZzWGAceUQ+xP4q3Azc4Ity1
 Ar4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577198; x=1788181998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rrr0PgLJMKPfx+Iqb+q3bs0vvogEYzlZkZNtWgifKn4=;
 b=iEU6WCwpsJH8HRc6LskQBFAC1zSDn/V71ASXfQiDr0RGP9E/fp5yjV/oGopCN2F9ZT
 RB0vuv3hXz5oDYJ9qD/E606ZM5yyaQn0YPS2pUUBAUYxVXevFuFYtsGMUF0pY2EXdomR
 yr0oTemWTi2y2bwfyExz7ZWETivRDM1WVbRR7B9j2AAeTDf7tZG6kh7IcNjVNPY+wIG/
 tzrgnJ69z5Fhimh76LgK0Go55rpkjaVmD1WgW7vTOfzsY3jy1AdJJ/dOBicb+JkcWobi
 AzdJvp6CdnoGxZo61spFIFL4P4WGwXmZkhwUsmdPkp6S9A/NQ2FYtxI2VkLAC1FSWs6w
 i5QA==
X-Gm-Message-State: AFuF++lfAsofnSMuV2Z8XCxm7AXcgY7Lz+6cMBW3jLjoIXYTFh/dqmTA
 L0XKvkcSj+x22uCWWAIeORi07QAk3mnl30afk22SqZMRmzTnsNXZNnFMSjSOmSoL8uc/PZWicU4
 P58vwQRw=
X-Gm-Gg: AR+sD117aHWbBQYNSdLXrIg0O/g++IXYV9AwncZ8c/nanFWsifWdWswH0UocW1Yi7Ef
 yAlDN5FBCLoi5amZuMSADGANuka+FjUrp+Z2K3fqCRB8zsxqT1NHM1pcaAbOuneKVUG9cVczIRE
 4wtnTcnOMVGyCaVI8xhAYTsjpy+EJyesm5BgYqVemhRvw9b8XXpjICUDsMIqAU6d/mY2/8YeapF
 DyAztxl4YNSiSCEOiRDdAExD6gSskWbjyAXGqvzLurk6xNen5uIBj84Z1RjU0N9DNK6z2Y8KhYp
 r3hbDNTn62F5pv5j8wEioQUov1RME9ZBf762GomDMVA083/ScdRZIP7m0tR58zUbMuKaCEOLQhR
 t1Sd9nH0W7hMW9EGFRqSQtwGAOqGssd8R6Ym+Gt7mU85rZUAcTw/jO5ujte9rNutx4xAA65mFdH
 5pM7WWfl59a4ekX0R5huWTAlTH9KQmwEoXShkTpYz8x1+VoSu9YNOKd05R53MC6iVXmVrT3J0pS
 RLwnQG4A90XHEg8b6CHCZBC67fBumnRVP1/UI3W8Q==
X-Received: by 2002:a05:6000:2589:b0:482:bf17:e685 with SMTP id
 ffacd0b85a97d-482c0b88f19mr38333275f8f.11.1787577197737; 
 Mon, 24 Aug 2026 06:13:17 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:17 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:12:58 +0400
Subject: [PATCH 01/17] pylibfdt: Cast property length to Py_ssize_t
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-1-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=alchark@flipper.net;
 h=from:subject:message-id; bh=qVQmfG7SvItuiSkRnjKqDi+5TnxKXag2I/y1OvvDSzU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGeuKBPyOaZ8lde7bq7drAtJ7Vw7VCPvxP1QLnIQ0
 2C8OFG0YyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKlmy2FkWP6exfDa+h2RXw2fzI4NTBXWOvXP9Gj6ZfcTv4w8/uyS+sTIsN7q99o
 ToTPW3mU8UGB2ddGhhK3vNdoWzDtufeOZeIzfHR4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Commit 7d01bb1c5a1d ("libfdt: Fix build with python 3.10") took only half
of the upstream fix, dtc commit 383e148b70a4 ("pylibfdt: fix with Python
3.10"): it defines PY_SSIZE_T_CLEAN but leaves the length argument passed
to Py_BuildValue() as a plain int. With PY_SSIZE_T_CLEAN in effect the "y#"
and "s#" converters read a Py_ssize_t, so passing an int is undefined
behaviour that happens to work only where the two share a representation.

Take the remaining hunk so the typemap matches upstream and the subsequent
upstream imports apply verbatim.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 326a15c7941e..eb075c0b92bf 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -1049,9 +1049,9 @@ typedef uint32_t fdt32_t;
 		$result = Py_None;
 	else
         %#if PY_VERSION_HEX >= 0x03000000
-            $result = Py_BuildValue("y#", $1, *arg4);
+            $result = Py_BuildValue("y#", $1, (Py_ssize_t)*arg4);
         %#else
-            $result = Py_BuildValue("s#", $1, *arg4);
+            $result = Py_BuildValue("s#", $1, (Py_ssize_t)*arg4);
         %#endif
 }
 

-- 
2.54.0

