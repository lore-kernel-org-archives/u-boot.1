Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35166CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D03848C0;
	Tue, 19 May 2026 18:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PutP7Ktr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21E5848D1; Tue, 19 May 2026 18:22:35 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F471848D1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7dc85b74so3775443a34.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779207752; x=1779812552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzi7NZ+cMkjoUKeeivN4HRSRNQJmLKx5dOvONg2pmIk=;
 b=PutP7KtrxQu4pgmZJ/YBwLbIvVVhzrOcfsJrSs6bI4k4NkPO3fHkVVSNYTkTDZpRlU
 crhmM+d3xm48LY7BEciXRN6LtBk/sqUHy31kFbjgEjiHh7rz84UBEPoTsIP4VQzAEGmZ
 W1Uegyjnaop9qiseBVGDbuHJfVvnprrt5e+R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207752; x=1779812552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jzi7NZ+cMkjoUKeeivN4HRSRNQJmLKx5dOvONg2pmIk=;
 b=dCprNThgy5UGZRosBYwg4CRcbpyeH4xfxpvQP0CooS6dmIyrE/aLmaA3MU4mR2YO1X
 IeLXgX3xyzSjbVIYFmPoJoBEUA+zl8luzYLo1fcKU66SxLKBcvfwHENPhtYv9yPatKOJ
 HMjYaw+DVCiIHihkAAA3g7GlSRG3TcgrgFEw1SjFW63Em8BL0PWwZ27d+NbTATIanIEk
 2fzooIkSVmOovVBwSMZ/BBhyC5OvMwm5mLfpr/lETou5uzj9hdJKjW/aOo4S96yA1bHJ
 38tV5lRRi9np9h5b1uZHaM2hXAhi3t/leepXwqvqHz0eBmDbAUQ/MqTgPyhafkXt+w+G
 KPtQ==
X-Gm-Message-State: AOJu0Yxy3iWZLjUs65bgIP0eR2zDSjMWVuAwUN2vAEpawixK8kH/fuUT
 mGZ49l0/ZDU1kZa9Onvr2tbsgNuyLyo86Jnx4fQOvR5D1yEZKjlJKbEbUBV1SL547Mjyd+FKG7f
 KdEeAJ+q0KmRC
X-Gm-Gg: Acq92OFYB1paunBcCx9YnKpaOwcg2JnZTQrT2y39atgjFKeG5+zfeP71aFnigAgCbFv
 fuPLQaBedX0ctwkzsMgKxGjynb6JoO9rOPO5bhVK6x2mLShWqqh4iFEcWcsCg8BzKQCB9LvaGX9
 DIFaE6RK6YtpqhAF/vIHaVFPPR25dNFg1yBziiEpjqsQ+s0uStqi13WHGDCTR5wrAqgusvMCjNg
 voq4giY7YWeu92VNVQu86khwqmPg39pnerEqkJIk5bu5gXkuPuj+TrzIMp4mJlqEFdlQwuhKwbw
 /PB0DWXfdWhBCldyR/eKD+Tj0VP6zhvRBHPVPVAvZaS4679wmUihUbYNOwOZGX2PNNa0S0VEiup
 3u7rtfjDS3QbJT3irTrcS8ZCOXST+6U5BkmNyjg2y4jHMml+d04ri9SbLkR0xWns55RAMVJXfgW
 GOHDYP6g9byb5Q04SrcRMNSWuyLJO61pu8uMeLN8h7f3p7712hoX3VKEESayk6yif1NdaL3eAUm
 cho1WBtLqOVDgofPRQgKXFuJDpw+6N1lP7LLfoGchEt2S4ROJms30I0yZDrFQZtlSsLQ3ttNF4=
X-Received: by 2002:a05:6820:1889:b0:694:99b9:5361 with SMTP id
 006d021491bc7-69c94375832mr11050205eaf.38.1779207751953; 
 Tue, 19 May 2026 09:22:31 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d0462e85esm7500388eaf.6.2026.05.19.09.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>
Subject: [PATCH v2 2/3] bloblist: Demote not finding a bloblist to a debug
Date: Tue, 19 May 2026 10:20:55 -0600
Message-ID: <20260519162225.770071-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519162225.770071-1-trini@konsulko.com>
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260519162225.770071-1-trini@konsulko.com>
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

The message about not finding a bloblist will quite often be seen at
least once, and is non-fatal. Demote this to a log_debug message from a
log_warning message.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/bloblist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index d084be899588..09afdd1f96b4 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -613,8 +613,8 @@ int bloblist_init(void)
 			ret = bloblist_check(addr, size);
 
 		if (ret)
-			log_warning("Bloblist at %lx not found (err=%d)\n",
-				    addr, ret);
+			log_debug("Bloblist at %lx not found (err=%d)\n",
+				  addr, ret);
 		else
 			/* Get the real size */
 			size = gd->bloblist->total_size;
-- 
2.43.0

