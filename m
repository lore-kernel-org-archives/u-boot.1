Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B660107637D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADAE2840F1;
	Wed,  1 Apr 2026 16:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lL6vaEiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 677A284010; Wed,  1 Apr 2026 16:15:33 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD5B83CF5
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso92209565e9.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052931; x=1775657731; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eMo1yfbKFmerV3xsWbvjjs6LxK5NznRTCCY7I6Qc6M8=;
 b=lL6vaEiLBnBg75lGZvBTFMNOkLpiNkJHJh033GZfZfDj23z4eytXNjqdJe84os1dk3
 6md3w5FZWPBlFRNp6PCe30qtQm/mD9Ni6W0tR2bmT70TKKjIm/NgB1ISLgdakLhWt+2J
 40zPHk95GR5oYOOxNiYA0NPlszRLJsi/VUzZW0R1iEWeR48D18FI2G6+iKFwqcOED4pc
 FGdoRQ1fDdapC6dH9v9di6rKLEdXT5DUFyNZxqNXIYjcu97FoGcfFoONZMuY5fXCnWD6
 15evh50+sTHZkqnmBlgnbHpfJefgI3y2Fr3E281puA9LboLZEPdB+O0qPqxe1Iapf+no
 JwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052931; x=1775657731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eMo1yfbKFmerV3xsWbvjjs6LxK5NznRTCCY7I6Qc6M8=;
 b=HpBJA2ZElp8nFZr/hMpYUveVtc3cjW4LXplCqT/fSyibpV7oZU29UA7JgP5vC5N0ZC
 IpbS8vvBxLRCXvgKWjeZk5Vp9ocqI+bcq6lLQB1U38tnsejjUQ98TizAayz9N5tKFcOZ
 8UeKY4C2cL9NsNreCK3TdtlGGS7SGNfKoFVhuAQbO3YVu7CTCjMaioCC6fQlYv4Vm7Qe
 rKsyVgozf0YnqopNfYCfeFDWS4hmS6/OBJnKArkeavbOqI29n/mTbCH/219eRHuBOmPl
 T3LrZ/L03MA2VW0jrb5lKC31g3QeVDbrOi15dtX/9FczBynQehdlwxUj+WznmpNx7oQj
 OpTQ==
X-Gm-Message-State: AOJu0YzHBxkMYo57q8cwsw4qNcEnwnGLJIq/J8JhsliJ3wVPKQZ9FC5V
 PMB5I6TpLHFRxY8z6o5+GuOVfkl3YfMzlAyAiy9C6kCkG1yGgRHcMJ59QBjUQp6Qt4M=
X-Gm-Gg: ATEYQzyXVPC+NLuN31/8J5ruJS2ps164aaNnTp9cWdmHiC4t9RLjPtZjgKcWLHqSkQn
 vJqVCARBahOFefUc4TYozsG7tKtIrmO9hU2tq5s4xKmv7Jmy2rizTO9A2Qcy7cxos7IJ8s1q4PC
 31cwSNmNXdkRCz8JXwfYIoJ/AXoLKfkVol4k+rf+n6UsCvJnd2cgNIUyUNXzYsXlZTUbW4kBf3i
 Pa1g9CE+2UtvNzlvYqctkOay2PlfpW0QlyNjkJWVIyCJYdzUdTOwbrhdn8ekeHKcZYOXzO9WHTw
 N6cmxXxnqsmVbYwJvXu7YT8AIYDonB2X9TjdnBidpVd8FtMxdct1z7+egNihG6g5JGBVvHIpXON
 zgLKA50b7LuPsj2Pf4g1Fr4Rp0Dq8KSDbZ1/m9xovTiPo5/zdlE9Vf3pMH/l91bBlwS5Q6ABMh/
 avFNVz75TAXYFp7g6ZbPdmcSrbCzHdz2w3uzTooHQ5NJ6B2EJP+rOaz5h0DamPK8Z14Vju
X-Received: by 2002:a05:600c:3baa:b0:485:3b34:2f62 with SMTP id
 5b1f17b1804b1-4888359ce97mr64817035e9.14.1775052930661; 
 Wed, 01 Apr 2026 07:15:30 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:29 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:21 +0200
Subject: [PATCH v2 05/11] compat: add PTR_ERR_OR_ZERO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-5-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=s4BvCvcz+cf1uqyJqqQOoJjrtHGguWSJkB09XcWQKu4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGlUXKp8d+NgxYz+/0tojPv4XHzEmmusUdN6uuPth2
 ownZ7W6O0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBE5HYw/FPgCfi9evG+4CUa
 927tfNr2tJ1jV+2DCPaMO+dryr7/W2jA8JvtkfkNzk7bPL/cDUlMC/e9e57dLF+90ulAXE6p+SO
 2J88A
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Imported from Linux, this is nice to have along with the other ERR_PTR
helper macros.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/err.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index 7a0b212c813c..2463c4611b29 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -52,7 +52,32 @@ static inline void * __must_check ERR_CAST(__force const void *ptr)
 	/* cast away the const */
 	return (void *) ptr;
 }
 
+/**
+ * PTR_ERR_OR_ZERO - Extract the error code from a pointer if it has one.
+ * @ptr: A potential error pointer.
+ *
+ * Convenience function that can be used inside a function that returns
+ * an error code to propagate errors received as error pointers.
+ * For example, ``return PTR_ERR_OR_ZERO(ptr);`` replaces:
+ *
+ * .. code-block:: c
+ *
+ *	if (IS_ERR(ptr))
+ *		return PTR_ERR(ptr);
+ *	else
+ *		return 0;
+ *
+ * Return: The error code within @ptr if it is an error pointer; 0 otherwise.
+ */
+static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
+
 #endif
 
 #endif /* _LINUX_ERR_H */

-- 
2.51.0

