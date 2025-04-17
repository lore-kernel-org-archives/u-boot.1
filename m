Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E41C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277BC82CBC;
	Thu, 17 Apr 2025 15:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x2WlhfGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31BE8303B; Thu, 17 Apr 2025 15:27:32 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E28182D21
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso537324f8f.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744896450; x=1745501250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D11ec35keRrC0Yq7WtMF0PySDIUXFOaHDLO+c2svLyM=;
 b=x2WlhfGeXbLdqWpinIms+o2fOHf+zp/l6mnLwo1uRGuzXlv57lYF0Ziehr01PMnWkW
 LbkUnXozZHPnlCFVSgq/lcQ7xMFkySspqvVe7VGXRqx3UN2HBY2bUU05b+mheTWbCrcn
 0e9aEgM09Uz4IuF51n83H01JwoTJ3CevXl5ZDkPV4J/qLv/Ub7QzZVXqZXcwHJZCDt9A
 g1kj3nQ1XHrSBob7W3NWg1An0Srlsd+16KWmPFcRKVM0DEv1zUKqYVv02jVJ3dFU5+pw
 u9zStZis2YJY/T/znGIOk0Lcf3xtCEM4xudKtXt9S6FwG/Xrca+TYSfsgJlC43xcl/kt
 fHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744896450; x=1745501250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D11ec35keRrC0Yq7WtMF0PySDIUXFOaHDLO+c2svLyM=;
 b=Pt/JyNB73zdyBw3pCbSiNd05oZuwBmTX3XwjRpNDZitDQWzUD+ZFlsmzn6O2dUT6JC
 JSWWyM4tvFtvu3XsLi3aIm0gYrnWHlGrm8l3kfiPevJIiREJSw+fIU8Vjn1QzxVf1tTV
 AnekPPC5F6fRBewnM3g5WpnVkC5QwXvEf8x5Elpz0lZZuNyjln/Px8+j5SSV3e/3+4ws
 8jXFZzFaPSwocJpq5UhfgtXLL8PVUfSfaUxVKTrPU1IdONSCjNfdCjjwUYBJ8i27r8mM
 nY9Ezr/fDk0LJyqnBXSjV46aKn25gfo5N1Shrl93lO7bvBeysk+rQz4sz5swh+xTg68p
 BWvQ==
X-Gm-Message-State: AOJu0YzgAHEUV+nPpmvlCSyE9JqYkKtrSu5CF5XOSkzMnKqc2yCZ+TJp
 vTTZS6VIxT7HsHl46pnRiAJZhZqit/RPY5vK2kh/K9djlPrdtflQk2OL2J8vv7CanXSPwx+J0Do
 EPF8=
X-Gm-Gg: ASbGncsjROv1lJUWCOYlu2VEk8SAyNSJY2yu/94V/xz7SStZCPqa9CFrPNywgUro0ye
 Wtnxio6cBlWDDYSKHxSOFKrAujdrM8wDkfyzODRGbtsc6lSRGY8tYuFO0rPvw60YgYwEzlJm/6t
 m9V0bW5cLcgyyNVR5HdHg4A4m8pGQNeMycwvKlMS8weQDQHvKfSpur5om3TBi0FPbBjzzewygHf
 hl4mIGma8aEax7T0p/RPxUomb9RFHdjC3k/BJkiRNXN9JAb4ft88TffkfJz/drwa4/goNogTuER
 TmD0h7/d+bD1ouI+v24zx8IgPKtUTTCoWuSyb9dPS1di0fXm2w==
X-Google-Smtp-Source: AGHT+IHcmA05TyhFdDaG/S6Ih5JEb741ZJpGYTVaMWi8/CQcUWracuRzgHi65GuqMCaRLJovwRH4Ew==
X-Received: by 2002:a5d:64ae:0:b0:39c:11c0:eb98 with SMTP id
 ffacd0b85a97d-39ee5b9f651mr5443973f8f.39.1744896449800; 
 Thu, 17 Apr 2025 06:27:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a07e:3f08:7eef:b036])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977513sm19951605f8f.42.2025.04.17.06.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:27:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 1/4] net-lwip: change static function wget_loop() to be
 wget_do_request()
Date: Thu, 17 Apr 2025 15:26:57 +0200
Message-ID: <20250417132718.2023555-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417132718.2023555-1-jerome.forissier@linaro.org>
References: <20250417132718.2023555-1-jerome.forissier@linaro.org>
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

wget_do_request() currently does so little before calling the static
function wget_loop() that we may as well rename wget_loop() to
wget_do_request() and put everything in one function.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

(no changes since v4)

Changes in v4:
- New patch

 net/lwip/wget.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ec098148835..2b512a1bc84 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -372,13 +372,14 @@ static int set_cacert(char * const saddr, char * const ssz)
 #endif
 #endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
 
-static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
+int wget_do_request(ulong dst_addr, char *uri)
 {
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
 	altcp_allocator_t tls_allocator;
 #endif
 	httpc_connection_t conn;
 	httpc_state_t *state;
+	struct udevice *udev;
 	struct netif *netif;
 	struct wget_ctx ctx;
 	char *path;
@@ -394,6 +395,13 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
 		return CMD_RET_USAGE;
 
+	net_lwip_set_current();
+
+	if (!wget_info)
+		wget_info = &default_wget_info;
+
+	udev = eth_get_dev();
+
 	netif = net_lwip_new_netif(udev);
 	if (!netif)
 		return -1;
@@ -469,16 +477,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	return -1;
 }
 
-int wget_do_request(ulong dst_addr, char *uri)
-{
-	net_lwip_set_current();
-
-	if (!wget_info)
-		wget_info = &default_wget_info;
-
-	return wget_loop(eth_get_dev(), dst_addr, uri);
-}
-
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 {
 	char *end;
-- 
2.43.0

