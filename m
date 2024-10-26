Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67939D10BF7
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 12:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F14988E6B;
	Sat, 26 Oct 2024 14:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=heitbaum.com header.i=@heitbaum.com header.b="Vd6YITV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D19088E6F; Sat, 26 Oct 2024 14:34:48 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7661788DB3
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 14:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rudi@heitbaum.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c8b557f91so25395065ad.2
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=heitbaum.com; s=google; t=1729946070; x=1730550870; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ua1dK6+NJwThX3FkPCKXcb7Pa0vZCLQXvD15iQ5aRvk=;
 b=Vd6YITV2ItcN1UmdgCJPC0fzKtOspFiFNgqeCoY+Db8AukQuVUCD8RpNl++wTqXbxy
 Rm4QBFFU/qNQV3vI6EjJOBNreLUHrYF+4GF9zTHJT5ICqufvdNBBqNdcqel6v1c9sN+h
 5nzAuoQvQcpl7jHCWdS19/h0C95Jbue6ogSZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729946070; x=1730550870;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ua1dK6+NJwThX3FkPCKXcb7Pa0vZCLQXvD15iQ5aRvk=;
 b=SqwN6DR4plIjS4v9BgkgfeaTt5OAwgw0BWggdmVIxackcvLXPf/LtVudGO6qBOlJwr
 HCx30VQRevPF2l99wNDYy9alN/ly+zu4Q88yePKeV9T7EkDrSFmTq5xA+Dlz5zn7OXT0
 hDUAXzBY0PBqFmjmcbOzxeiepPRpckwfaf7Mhrzej7fYzu0rLHSEhagLX7EIWw8kZXbU
 mpwgZLmOu8FAei8FqeK/Q6mFNr/IB+fxrJvSSajtYomi8vVtHnhJZEyD4OEh1fpnoGW2
 SLD6hEgzUKsbBxbyd4TKu+rML/2LGv9q9ZAOYoTuVR8FnPmJf+OWS6UZN5Gycvll/YCB
 5Nzw==
X-Gm-Message-State: AOJu0Yy22aotYcXg2x5M2D1ihjWNjvn1c9hdqj4lTm+38kX5xOvTfmDe
 v6Lu1aea9SSfprPuGYX0ZU+lLs4rehmoi1jCnYOHN1c2BrJF4gDg0fMjJsHYzMRhCpRk7me/rmA
 D
X-Google-Smtp-Source: AGHT+IHq101qBe8gEh42actOEmCIVnhe5IhgByV0Rq0Fpaqd+WCYGladxxp6H1Klevh0YzD5dv93pQ==
X-Received: by 2002:a17:902:e5c3:b0:20c:95d9:25e6 with SMTP id
 d9443c01a7336-210c6c1b09fmr30352895ad.34.1729946069651; 
 Sat, 26 Oct 2024 05:34:29 -0700 (PDT)
Received: from 74d70d9af7e3 ([122.199.11.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc02ecf5sm23418475ad.199.2024.10.26.05.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 05:34:28 -0700 (PDT)
Date: Sat, 26 Oct 2024 12:34:24 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: u-boot@lists.denx.de
Cc: rudi@heitbaum.com
Subject: [PATCH] libfdt: Fix build with swig 4.3.0
Message-ID: <Zxzh0ODFyZnav5JE@74d70d9af7e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sat, 26 Oct 2024 14:54:40 +0200
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

Call SWIG_AppendOutput instead of SWIG_Python_AppendOutput so that
is_void is handled within swig.

Link: https://github.com/swig/swig/commit/cd39cf132c96a0887be07c826b80804d7677a701

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 56cc5d48f4..e4659489a9 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -1037,7 +1037,7 @@ typedef uint32_t fdt32_t;
 			fdt_string(fdt1, fdt32_to_cpu($1->nameoff)));
 		buff = PyByteArray_FromStringAndSize(
 			(const char *)($1 + 1), fdt32_to_cpu($1->len));
-		resultobj = SWIG_Python_AppendOutput(resultobj, buff);
+		resultobj = SWIG_AppendOutput(resultobj, buff);
 	}
 }
 
@@ -1076,7 +1076,7 @@ typedef uint32_t fdt32_t;
 
 %typemap(argout) int *depth {
         PyObject *val = Py_BuildValue("i", *arg$argnum);
-        resultobj = SWIG_Python_AppendOutput(resultobj, val);
+        resultobj = SWIG_AppendOutput(resultobj, val);
 }
 
 %apply int *depth { int *depth };
@@ -1092,7 +1092,7 @@ typedef uint32_t fdt32_t;
            if (PyTuple_GET_SIZE(resultobj) == 0)
               resultobj = val;
            else
-              resultobj = SWIG_Python_AppendOutput(resultobj, val);
+              resultobj = SWIG_AppendOutput(resultobj, val);
         }
 }
 
-- 
2.43.0

