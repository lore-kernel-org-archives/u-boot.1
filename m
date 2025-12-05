Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA931D339A2
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 17:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB3984223;
	Fri,  5 Dec 2025 18:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V0837Du3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8881184230; Fri,  5 Dec 2025 18:28:46 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7409F8421E
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 18:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so20431895e9.3
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 09:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764955719; x=1765560519; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wPxK4+4xjJB3YEoVa9tRBNixN5kQ0lMCPR88fGQBWI4=;
 b=V0837Du3GLBcoz3gpsLI/dwjoKkTOqi4oWnwdngKT+BKQP2PDHoo8np2xjMhSwsapO
 bCfrnIb9/UXK9JbxA94QonCqgEEshDRtbGm7o/ZmZWdpIPk71s2djIIh0cBnoEWtJfD6
 iiXaQ+778zQ31eYb1exbbgT/HAgaqXY8lTklql1B5Vf0rHoEJcbvcanAnQRnXUqoTzuw
 VcuH9NpXr42kBmmdCHboD6/883HZ+UHZL3LE0AVd0yBGNmPlsXBczawoHScIJVQs1yCy
 xd04TKYY8Z6uUJo+UH81aEV9SIbOVO9/N4MJMtbG//0Pw0jZzHV2b9NudqDuptHIoQ7i
 tYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764955719; x=1765560519;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPxK4+4xjJB3YEoVa9tRBNixN5kQ0lMCPR88fGQBWI4=;
 b=lNjnq3lmx8//Py567r1kLDRteu3wTFFRbl0hrXpsUEKQYBHa32JQ5OsRgwkPxlRLgK
 OGYKU1ioOi0tkLxym8cUcAWKL7t3+IlFAolBXcDqTyTynJU98vXc7lwmxNh0sEqhnvA+
 Fqq93XZyCZdZK5j/sMxmVCtvdxRKXBjefGVVA/Y7AIxYYs0Hg9blNXduIaOomFZBfXHD
 Jfw7BK2tjodaql8X5ygw01fHbBqPXbrPIzIU91VWsQ+VMAi2l/vZTJhOorKCh2JlPhXA
 2VH5Qi1JFce0qPl6AUQK0pfnY77rmxw32FU8bo0DHu7stYhTA41eDTiJ19w/Xu9bATur
 idFA==
X-Gm-Message-State: AOJu0YwHmseK77NoeAkvv6jGAR3Yy1OVRVj14aYQ8yOEyS3fROaUmBdr
 P4rtPGwfEAmBZRwcDd6w54VoqcehFrrwezd8VasnLohSrP+168xY2n42MoL3FAxWUEsAqXHLJqR
 0SuRIYfY=
X-Gm-Gg: ASbGncvGmJjTWpjj5zWPdrVEMX/QZqaDV1py2LryaCDf2cVhKVBIhIF31SeNGKB6vmM
 hufInyVECTLj9iNNcnvLOlmRm7ReTreMxz+FRBGyymPXkjvFw/dRmC4LsZjONZrSGwNPN49Kj0a
 JjpVQ9VvhRoqXkxGpIFFBfctDYwxtfPIz5QJTRAyCOAjq0A8q4y6wpU0bbxKyvOydrvjZI0ZSwc
 9U1UrbFidzD/kEIKN/1sBNFA85LBYjmXVbejQoxqbwn8qfZpPaP2GjpdyDsvKmUzm/2gd99mubQ
 J/MxwQBh1cwQOiXclNAx71BV9mw9eVghwIm1xoeT0ffsBvG0cvaqsHXRmGZg6zvY8SAusExdogd
 +hPjm0XJzeAyvZrRIMEPzAoCuV8hQ/5TLJ2hlSnJcpS31IauOdVHN4H2F7WjSGN1vBvTnwIiqIa
 jrKjKnOf8tRx5BOC6RdO7Qov3JDdoJZ/1RPMD3ZzFhi5jP+r7g7g==
X-Google-Smtp-Source: AGHT+IH8HMOX3QPlgk3F5jb9Mj5GbMjrHFAY32gP5FnxD4laogvhQsf9H1MQVuJTUUf9p+5jCL131w==
X-Received: by 2002:a05:600c:3508:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-47939dfcb2amr880685e9.14.1764955718827; 
 Fri, 05 Dec 2025 09:28:38 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f7b:b001:ff09:b7cb:eda8:67f3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930c747b8sm94780945e9.9.2025.12.05.09.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 09:28:38 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 05 Dec 2025 17:28:36 +0000
Subject: [PATCH] net: lwip: tftp: Fix filename handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-lwip_fixes-v1-1-90bbca659923@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEMWM2kC/x2LQQqAIBAAvyJ7TtAtPfSViJDaaiFMFCoI/97Sc
 ZiZFwplpgK9eiHTxYXPKGAbBfMe4kaaF2FAg86icfq4OU0rP1Q0hc442zrvLYIMKdMvpB/GWj+
 riDdlXAAAAA==
X-Change-ID: 20251205-lwip_fixes-ea4051356612
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

The code to choose the filename to use does not cope with no name set at
all. Firstly the test for a name in net_boot_file_name tests the pointer
rather than the string it points to. Secondly the cleanup on exit in
this case attempts to free a global variable. Fix both issues.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 net/lwip/tftp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 94bacf630752d20357cef40775a25cca39d811dc..6c7ffba661e5903b6b3a6349edf2c8b22eb0d36b 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -279,7 +279,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!arg)
 		arg = net_boot_file_name;
 
-	if (arg) {
+	if (*arg) {
 		/* Parse [ip:[port:]]fname */
 		i = 0;
 		while ((*(words + i) = strsep(&arg, ":")))
@@ -342,6 +342,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
 		ret = CMD_RET_FAILURE;
 out:
-	free(arg);
+	if (arg != net_boot_file_name)
+		free(arg);
 	return ret;
 }

---
base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
change-id: 20251205-lwip_fixes-ea4051356612

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

