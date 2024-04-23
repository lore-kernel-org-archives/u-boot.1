Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A91C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD3188342;
	Tue, 23 Apr 2024 13:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="icB217Xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10646884F3; Tue, 23 Apr 2024 13:06:02 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 074CF88341
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-571c22d9de4so7347168a12.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713870359; x=1714475159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1R0KBmZfe+rzGCPJBIYqVIQ4TyNfBxDY2jiddWl7/SY=;
 b=icB217XebJ+mr2FvKKjv3PsqTwDXqnZptCdK9FkHQaSZAM1aVDiHXaAMoJwARUrztz
 EDyg97RdFoNBSULeZdGtwbp+1/TtUiTRBhs2iWOC0u8qSfZNkVMG85+RJ9V//EwBKaSD
 Q1ppwPhWtUR0KP6ijLx2UaRybC6sQmZ06B1m1CuPcIAmXP5aeI/LYTR4GT1RpQwJ8eWg
 vJoPYmXFx1GX401a5ZLV4y0uFKzX0cpL4DacSH9AlPFmU3/+LNOjpg08M+mN/wVn8Ubi
 VkRMLRaoWrQpYviQRnO6YEUkTDHOdTS2Wi5ccpca282FlE17Sy+AnjhrYNY3SyFcqbMT
 fbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713870359; x=1714475159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1R0KBmZfe+rzGCPJBIYqVIQ4TyNfBxDY2jiddWl7/SY=;
 b=WkSZ20DLDuK/2KjTmtDdmuO4n6VoGmjvN1mG+kg6T2pwqSOBBMocXduxAEWHj0Z8hD
 c0bwSnkVezUut0irIveB9RoCZ9Z552LOjbi0nKv9oL9Okf5G1OvgQ5jVx+6C0TsnEt4m
 HYLDCPEgX6hU7Yxm8q6eIEtgVG0jR+ku4fgPBEtCIjCWnm8sNtlNlYXKY4Mg/CneaDfq
 T35iP4Xmf4yEQUmjrV4t85AhkO4/a+XFm1HBOVsdHN3JZRKsbiav4ykSPuKZjJ5oTSbM
 d1NIGRNQY32ytcWKsE/lORFrt/X+jjSB+mN2xdsd+YHjksYuvd/J4XGaiXzomU1qxmdI
 631w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHh5UuTHTZb3RZEsEUo+5Lo4Oyix1iflbrQPj0s/Y3qXa5qy4JVQ3/o21FBX/5S3nsFxPR02rMW9ZoMskbXY/fvvkoFw==
X-Gm-Message-State: AOJu0YyBXxrtsZwL3gC68/ESKmYWQ00LaQUc91dUXfS7jxfFAbzNA+qM
 JBAP0u8dcFv99AN93O0ZITAUAer8vDPgdu8IZbZh5qDKc+z2gw9iMGrqmZeR9HR/WfjJPes70ws
 v
X-Google-Smtp-Source: AGHT+IGoGzVN73VAswh/k7B6L6wIUf+gTK32h+hNfuPD5PC/3PLHaMY/7kTfWH2/TJvCpFkB5le8FQ==
X-Received: by 2002:a50:c018:0:b0:571:be3a:e904 with SMTP id
 r24-20020a50c018000000b00571be3ae904mr8253066edb.8.1713870359376; 
 Tue, 23 Apr 2024 04:05:59 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-121.dynamic.amis.hr. [188.129.47.121])
 by smtp.googlemail.com with ESMTPSA id
 b17-20020a056402139100b00572047bf766sm2607601edv.51.2024.04.23.04.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 04:05:58 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com,
	sjg@chromium.org,
	u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] .gitignore: add LTO generated file
Date: Tue, 23 Apr 2024 13:05:40 +0200
Message-ID: <20240423110557.80296-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
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

Currently, keep-syms-lto.c is being generated if LTO is enabled but unlike
keep-syms-lto.o it is not being ignored, so lets add keep-syms-lto.* to
.gitignore.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index be137040a2..324078769b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -67,6 +67,7 @@ fit-dtb.blob*
 /Test*
 /capsule.*.efi-capsule
 /capsule*.map
+/keep-syms-lto.*
 
 #
 # Generated include files
-- 
2.44.0

