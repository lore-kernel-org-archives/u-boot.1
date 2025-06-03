Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241A5C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 08:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99DA681F0D;
	Tue,  3 Jun 2025 10:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SAA185zo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A10082102; Tue,  3 Jun 2025 10:51:44 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501EE81E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 10:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad891bb0957so942669266b.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748940702; x=1749545502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zbQZZ5RfISb6fCFCg3dtZQcYnSeK3NAmnG03AWmLeTE=;
 b=SAA185zoq6mW2TKQRjZk0qR1PVYW3rjpV3izJOL17McQtMS52ZOwCSOhip3izDp8SX
 HAGB9T6ufXAVlHbqV3ysc801Y48qeD6FuYv6a6+IbVsVfPEL3Ni4BI/eiDuxar8wHAtg
 8MTBKnynCPO15lAGMucdrr1i5h2xfyMPVXhbb5wL/yArL3AorGvduNz7F/1vJKkBRPo0
 UKvZgwneB7YATm846wod4f1H23LYboxY6TNoIUGPdKIG2h1KW7EkHa9iUDgRW9/WdWts
 wORheq3xnIqGWvRHk2+yWEZcd5AV2SeI/fuNp2NmYGF5lAgDkyPQaG2U4B3EoSSww/6K
 8iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748940702; x=1749545502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zbQZZ5RfISb6fCFCg3dtZQcYnSeK3NAmnG03AWmLeTE=;
 b=ZNXYSFWHm5oym6K/qEky6oFn97nKInaJWXkD4IxHWwAbulDIbRsamHbl+MmKNndffP
 19zco3W0oQhqeaAa7Ce1xYrgo8eV3DHuq6fhhAD4u9eKP3YDr09Isds858fHl77Oxh1Q
 xBIpOnTzewWCBDGHNp0P5BPZxFeDYvBcnDjEww75lF4oX41Pu+bjS6Adj+rXg02k5JdM
 /7yBCPS0k/j0RMlwHTXMk6sx/g8TfOaW46GN0ZtoqhwqtOIUst0geilJc6lO41lLS8AY
 8zwChvjFmNR4UR3onlZcDHNTBz843vEPRcDvBzuiaKBrYwFF8QFz0vJgkfvBZWbYa9BC
 w3hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk74rJINFcpCv/j1rcNmrNM3afGl6NklbHFhkG9597TZvVHtlzXXOWFQNXF2+eiM9Za6+4+Vk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzjw7pyAsKme0XrWXEFLU11trxx6fVfsuF28v8GURnYVyGOgqHI
 cnyzOJdmA9WwLL+1mVFe8TFFc7COUM8xOcgSwj6jDJ557R60plh/1LFg
X-Gm-Gg: ASbGncvo+Mei2oOZRTdSQvY0G4TK2jDPQRFv4N3gOXmSmlvtxuDS+b0PRQqMrNsm+OZ
 fG/WbfXeKh0omCfgrfqe8WzPoEVRgic232xLJobsmqgIPd0HMaWryIvZolEcb6dED6Y2mL3BkoI
 e1IN6TZrEz6UF1MXjI0Qh03U45AIqZhpr5//OrLYJUMcSpxzE5dVPcFyFyZgYWYXR1WbutXfrll
 sTmXvFJPbng6vD7optcYHbrWALQNENo49LKjbOaapLoc4UjJvqEexIP28wz3AZ8DW4NdqVIsY/p
 SN+2HUI+9DbA5q23aron4UlJGkHte/07xjA5KPSUIHWM6zH4f39Dclq+HqGsJJqYkLCq
X-Google-Smtp-Source: AGHT+IFPB94Tn+G+kwHh3BJ+NS6CelUpdjihRjzA+9zCiIC2tAsKH9jxZV13NBb/Od9wCzCttWMvGA==
X-Received: by 2002:a17:907:3dac:b0:ad8:93c0:27a5 with SMTP id
 a640c23a62f3a-adb322b36ecmr1618309766b.5.1748940701275; 
 Tue, 03 Jun 2025 01:51:41 -0700 (PDT)
Received: from Ansuel-XPS24.my-cloud.eu ([82.144.39.243])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ada5e2bf0b3sm918778866b.112.2025.06.03.01.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:51:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/2] linux/bitfield.h: import FIELD_PREP_CONST macro from
 Linux Kernel
Date: Tue,  3 Jun 2025 10:51:24 +0200
Message-ID: <20250603085132.12407-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Import FIELD_PREP_CONST macro from Linux Kernel to permit usage of
FIELD_PREP with scenario where a constant value is needed.

Refer to commit e2192de59e45 ("bitfield: add FIELD_PREP_CONST()") in
Linux kernel for extensive explaination of why this is useful.

This is also to better align with the Linux Kernel for easier porting of
driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/bitfield.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 7ad02f8cbb9..1b73ba6f9fa 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -90,6 +90,32 @@
 		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
 	})
 
+#define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
+
+/**
+ * FIELD_PREP_CONST() - prepare a constant bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * FIELD_PREP_CONST() masks and shifts up the value.  The result should
+ * be combined with other fields of the bitfield using logical OR.
+ *
+ * Unlike FIELD_PREP() this is a constant expression and can therefore
+ * be used in initializers. Error checking is less comfortable for this
+ * version, and non-constant masks cannot be used.
+ */
+#define FIELD_PREP_CONST(_mask, _val)					\
+	(								\
+		/* mask must be non-zero */				\
+		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
+		/* check if value fits */				\
+		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
+		/* check if mask is contiguous */			\
+		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
+		/* and create the value */				\
+		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
+	)
+
 /**
  * FIELD_GET() - extract a bitfield element
  * @_mask: shifted mask defining the field's length and position
-- 
2.48.1

