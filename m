Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96161C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 12:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A4287A2A;
	Fri, 19 Jan 2024 13:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aacmgy/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EB0387BBC; Fri, 19 Jan 2024 02:34:32 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F20F87B98
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 02:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3bd884146e9so261584b6e.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 17:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705628068; x=1706232868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x7k7NSJtb5Zjxq+Zd57Y1OLsMxWPsi1zX5npdGUN/P0=;
 b=Aacmgy/8XDJdAqYC1fTcymIBSZueLP9voBlWWMrwkNAutOEHGQmiH1+N24FgCEMMI3
 i8XwpJEirtLsDphgRXYgGZ8e8zfi2K49x1l5wNCzVjU+IIZRZViW4GMCQ1+uX50sFUAH
 MFqIY43rPpWAIOSQU772G6xuoPHxhSO7A9EBlF81GhraxrdV5fhnbvTZzJBmlhcZGQbQ
 NmLhtgcj6m/qFVvXJhxaoVrdkhokXOgf4KWFpwDLtAUIOTeK4tYWJ/k+12Ca+xOvgSV5
 bUZUymhFwoWoSNUkExkbTw5IquXpJFufXZ7+fyMZYMmL2ehyGcc+FCpNnRfN8Ug3AdSv
 LkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705628068; x=1706232868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x7k7NSJtb5Zjxq+Zd57Y1OLsMxWPsi1zX5npdGUN/P0=;
 b=tLISk9rgzVNP9prHMmy5qdEq5bdHkWLPcayu0MfDyiRqfcQi75rQgIMGeGRCGFSA9g
 K9CLnJG2jFFF4tLNv8F/RS7qraMZtDCuBLtCqPJhYok07K6RU62ts5ZKgWyy8ZbUAwKv
 bpswNaSmXh61vAAzv4/redY9qIz603DXwx/bvdqdhoKoCg1TatM77YbtBgH9ccibY1s+
 Ws8pIcL5ZYNfyQadhppEfPuk2EDsIz7jWgQj82Ue6wNqdYjKXEKB/QMRiu1qUWQC99np
 xMQ0v3buowWvwAoTQ9HHs0cGXKp9M5XjVZd/sT15HYVFNIRX/y3pgVPXzXMpj/oy/KGD
 VK4Q==
X-Gm-Message-State: AOJu0YxB999PFq8SGRP757TPPAcmeIHRXMFx94s8qQAgfRI/4wsOrsTX
 103QwuO3Xve/LiIzKxRedn2JA3bqGJGC/tOLye4v9TYujtYTnhlC6WrGRhqQDQY=
X-Google-Smtp-Source: AGHT+IEdlD/Nkcv2g3/i/ehvqlrKdgz00QyoZzxjjpaOlMnsE8DAOMyB4oMoH9GQCuD1rrtWe9rU9A==
X-Received: by 2002:a05:6808:6d2:b0:3bd:38b9:64c3 with SMTP id
 m18-20020a05680806d200b003bd38b964c3mr1554837oih.61.1705628068504; 
 Thu, 18 Jan 2024 17:34:28 -0800 (PST)
Received: from aristo-b7flip.. (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 du19-20020a056a002b5300b006d9ecb8e956sm4040763pfb.173.2024.01.18.17.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 17:34:27 -0800 (PST)
From: Wei Ming Chen <jj251510319013@gmail.com>
To: u-boot@lists.denx.de
Cc: Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] doc: uefi: remove duplicate word "has"
Date: Fri, 19 Jan 2024 09:34:14 +0800
Message-Id: <20240119013414.1407234-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Jan 2024 13:21:33 +0100
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

There should be only one "has" instead of "has has"

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 doc/develop/uefi/uefi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 6bc9d92285..c739242b6a 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -830,7 +830,7 @@ driver on a device the ConnectController service is called. In this context
 controller refers to the device for which the driver is installed.
 
 The relevant drivers are identified using the EFI_DRIVER_BINDING_PROTOCOL. This
-protocol has has three functions:
+protocol has three functions:
 
 * supported - determines if the driver is compatible with the device
 * start - installs the driver by opening the relevant protocol with
-- 
2.34.1

