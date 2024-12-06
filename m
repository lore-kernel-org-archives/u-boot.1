Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FD7E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 10:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C65895EC;
	Fri,  6 Dec 2024 11:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ImoSy8Je";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E2DB895F2; Fri,  6 Dec 2024 11:57:01 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D728959D
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 11:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ff976ab0edso19794811fa.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 02:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733482618; x=1734087418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pMvTPhjmXRzGTI9tmyvCZUg2ccsy+mpJ4BCTUvwFVeY=;
 b=ImoSy8Jez4W5T/GKyrpiUeN0oFyVzdB8WR9kfLbs/Q6Q219wAkLuag+KnrxGgFx31w
 +WcfDYX/NVwyRAUQ64Ok1/kDjojUMp8DmBiVHF/k3cY8BeqjoBuVRGWw7wnU2xUcyXtf
 5JJs1N0mefo4v8OPXvrOYmihFL22PROEzuoRAd3tO4YnrReg+ZZ2562f7ZqgHPKFhmWN
 pHAbtBr63X2NWXKWuM7rDw+yDUpJDYdesF9pQ8cgtNI/gv5tHrLP3F5Zg4lrwaE84Qq+
 nTySYOpSSD4WDnTf5eA/5LrGy3FqTHYGlvAYvNsacrBLkYmKg48EJxZJKmoIwDn3avxl
 yO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733482618; x=1734087418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pMvTPhjmXRzGTI9tmyvCZUg2ccsy+mpJ4BCTUvwFVeY=;
 b=fV+HA6iQU/vUSdFIQ9uJTxiigr9Rk2g+uTemdSQPi6DRSoq5/sRx+3arlz8+COeMbJ
 jykb9Mjhk01lKJXCRUU8dNULKl2IKWo9gToITIObHo+ObCEeQYmxgHW+jIB9UdCUQH8I
 PeP7uQYrRve4XzYbk9fHXFYhLm4FPBJ4qkaVqDbefYcQOhXtoj5UYtCZ0gdZSa/bz1S3
 yQNSWJkhV0bqJ+io/gkPvv8CQ9D5mc+KY8278AnX7IzADmSk463c0t9kim819Khp/om/
 GXRz73JMIz3Poi0VtG6fTH1f3agGbPhRzkRQ9AA41Uiy2wpjsOJQk6IMOPTNt/WkSS8q
 xooQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlKD3NyA3+7Eqt71NI42VLCJLHISO0YNUs5bpgj18W5sX4Ywr+jgTIU76Cx+aNVZmP7vrrVMw=@lists.denx.de
X-Gm-Message-State: AOJu0YwJtLEtzOZgfDBYmRN0M/DAAXWty1pndQQU3ACRdmW4wPqOtUfq
 XckLPAhW208tMa4V30pykJqZMjN9sW3w2QUTBBF7Se+9sch6NgifZPqmrSuMLXU=
X-Gm-Gg: ASbGncuckNM3KYMQVtp/UqrAPghQblU6o2vRnue7IhCUG8GJxSGfIgCYbKM9GF4UKZm
 MBZ2ipBA55r7nciBjspHDR6cqHwKia78OQo1uILlCUqkkCQYV1eJjaehyEkNhvs2Dx+OBnNwCeE
 W4gvR89IHRo5Kv8sJDiZvCKIeT/KdJDHUDmgi1r10+kQeB5PxHJ/LUfMB+xGaPH7rYrkbYFHGTy
 QsTJi9wbiqhO/N/PS9VvHLEOe/U3Q1xPO8jWPdl21UfSDpcRx6unrWoScdb2f4zwQUnd3ZFTxwD
 iiww8rSj8nexg6Utu8CqjaEbTt4=
X-Google-Smtp-Source: AGHT+IF7Sd0xzLzB5dlU5aQQGHbyfITEaiawHn7/Iml5sIO1Q5x55aLZTEiH6MYhTVPdG8I9zVQWvg==
X-Received: by 2002:a05:651c:19a5:b0:300:eb1:a4f3 with SMTP id
 38308e7fff4ca-3002f8df262mr12298121fa.14.1733482618215; 
 Fri, 06 Dec 2024 02:56:58 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d14c64b48dsm1978810a12.51.2024.12.06.02.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 02:56:57 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH] mbedtls: remove MBEDTLS_HAVE_TIME
Date: Fri,  6 Dec 2024 12:56:45 +0200
Message-ID: <20241206105647.2548249-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

When MbedTLS TLS features were added MBEDTLS_HAVE_TIME was defined as part
of enabling https:// support. However that pointed to the wrong function
which could crash if it received a NULL pointer.

Looking closer that function is not really needed, as it only seems to
increase the RNG entropy by using 4b of the current time and date. 
The reason that was enabled is that lwIP was unconditionally requiring it,
although it's configurable and can be turned off.

Since lwIP doesn't use that field anywhere else, make it conditional and
disable it from our config.

Fixes: commit a564f5094f62 ("mbedtls: Enable TLS 1.2 support")
Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 2 ++
 lib/mbedtls/mbedtls_def_config.h                     | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
index 6643b05ee94d..46421588fef8 100644
--- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
+++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
@@ -692,7 +692,9 @@ altcp_tls_set_session(struct altcp_pcb *conn, struct altcp_tls_session *session)
   if (session && conn && conn->state) {
     altcp_mbedtls_state_t *state = (altcp_mbedtls_state_t *)conn->state;
     int ret = -1;
+#ifdef MBEDTLS_HAVE_TIME
     if (session->data.MBEDTLS_PRIVATE(start))
+#endif
       ret = mbedtls_ssl_set_session(&state->ssl_context, &session->data);
     return ret < 0 ? ERR_VAL : ERR_OK;
   }
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index d27f017d0847..1d2314e90e4d 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -92,9 +92,6 @@
 
 /* Generic options */
 #define MBEDTLS_ENTROPY_HARDWARE_ALT
-#define MBEDTLS_HAVE_TIME
-#define MBEDTLS_PLATFORM_MS_TIME_ALT
-#define MBEDTLS_PLATFORM_TIME_MACRO rtc_mktime
 #define MBEDTLS_PLATFORM_C
 #define MBEDTLS_SSL_CLI_C
 #define MBEDTLS_SSL_TLS_C
-- 
2.45.2

