Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11917C52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52A51887E6;
	Fri,  9 Aug 2024 01:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TkZYdGkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5893A887E6; Fri,  9 Aug 2024 01:59:44 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5824188B63
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7a9a369055so147650166b.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161582; x=1723766382; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bEI1hdBBKDi+4MatAn/dUEamBwISGLtYgDhR8T/D6ME=;
 b=TkZYdGkRvmVcCuxiKspfAm6k1V79iFK0AY6UQS2M/z1KKPnqR4YZFDDeke5Zc4YTwn
 Gvs6+8FL1cFpGIELdCo7bFMqcM7LrqAK6y5NFxGNeuehhKNKLP0zVPQgdK92BPEgYcKJ
 S/iSLiyAj1ehVcwMhhdwNj9OFnx53DBl81Hw8+16n6ngb+D1h6kmXVq1bRFpzpYniEWX
 vp589O/RqT7pVE+aDJ7uG9ShawszAsWbTGhhZw7+zhbR2o57Ct2houMkjW4u02VOBemM
 X6IBO5MUKK95NxGzFs/KPvKR1APYww6r6C74lPD8khI6/NUnAlRSzm7rGFAzSnTqnC2G
 X8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161582; x=1723766382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEI1hdBBKDi+4MatAn/dUEamBwISGLtYgDhR8T/D6ME=;
 b=s6sx1xAvIM+L4sU5DYGGTSHAPtX307ESX1+TtzC0Hfseowsstj3NytNKWFEBvrTg3R
 AtNPrmYEgZ2lBuBRR/EncIiI1iG7pXsSFzRg5XeAAkBenIr/d16qDO0lMjUMfbenR2kL
 mUWQyrtSKTkJJC2SEVzbdRdRDgOxS1DCFfGNXdyqcpKpC6Pi33KODE9TrI5niHrLDbWq
 d9AOh/BMlm6zhmF8MaNC3vBPQj39lFyFweHTYn5qB7Vmk2Tu4uWZK7hkDRuquz9KgLa2
 fSqdLIXI1AJsH7EdqK8/8Bx/Z2pPkQhs1WHQtbNPkczCytjsHvXJIWADvakkYPGGKLoB
 W06Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUqKWn04CP7iUFPt2jSW4j9PiUp0zruwyTVrRnSkEICU1Z+p4Ny/FCgpLFmUWTh4gkyDU3A6Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzuTqX8b+wJfOsubX083v7Jwm5R+7ewTjTF568H5zSH+INrVQcH
 cPDJxvK+0mWfNNQrwKGhyU7UzKFju49Tkm5RCHoLw/cUU09Zjt9c1FtSl0VMZdM=
X-Google-Smtp-Source: AGHT+IEsW9Ez0VHN+TYmOKJlfd55IV8RIWLD0i+rJKfUb4IsVwO03JABHZAPI2qH4VJj4BVt36OVSg==
X-Received: by 2002:a17:906:bc21:b0:a7a:9d1e:3b25 with SMTP id
 a640c23a62f3a-a8090d914c0mr243104066b.30.1723161581685; 
 Thu, 08 Aug 2024 16:59:41 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:27 +0200
Subject: [PATCH 04/11] mach-snapdragon: set serial number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-4-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2518;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=yVYnfDMvE8yc0UL37TJQeHQnigVoARCzVu/AFvgzM+I=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvnsQ06RuZ6+DvV5fOdN7N/V7tMOFxxiJbLO
 5RgoyeMLJqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb5wAKCRAFgzErGV9k
 thbVEACd5pMVQBXIxJYTJRSBmjWN1UwoT6efGh/roD0sqeyTcBqlSRdd6FMhk9aSp9EnhnQ/X/l
 sksZvaP33XgnLWf9toZCvbi6NlxhbdBXNS5vM/7BXSEECziTmPtpd/ajka3DAA8LQkHXeDTsHxa
 30EozmWKMnUfurTpZ4XIhAtySnTFL9hb9E5fF0n4V2lG7mn3U6eWm7LGXh/isY/7hFkDAGEyYQJ
 3NLNwSbKtWvhYYN8OsuC/7y/1ikQnvrelWGZ75YI3aq9EzZ0P8jrbDZBvkWQXc19w420Pl8sIDG
 I8GapWn0F3CoG15qIjm/RioNp2w/w/0eX1FYpR2eCTNI8hiN4vIjrH4AKm/1ssuJAf0PZJYquev
 xKQo0J3tt1PXC4Aw6ltjVRl4tezZuYmoL1mI52NOjq1oGsYKT/p09+l7IIE5ggm59CC9um/JmGO
 kojbPI8pol8+KocAThN4xoU8F9ZQmQJWdIrOdUIqpvdzw04JcGUfXxtPqYp2kNLsaZVUX6EmUAh
 dutvsZAjAJ4NXXXJpZJRm3+VU7Fipri2B7pUFEQmVczEAcoi/8kQCXPhKSnUQ3O9YnrxfDlPAm6
 nl2U9JLnphtRwUTboi5uqqC7J6uwVgR7TPIDBmHfHB8RLcFyRjTEhjCo9WwTpRkCYpfBModP8nZ
 j0aQrZVy/HwLHRQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

In the typical case where we chainload from ABL, the serial number is
available in the DT bootargs. Read it out and set the serial#
environment variable so that it can be used by fastboot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 0e8234a62b28..36335627f4ff 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -243,8 +243,68 @@ int board_init(void)
 	qcom_board_init();
 	return 0;
 }
 
+/**
+ * out_len includes the trailing null space
+ */
+static int get_cmdline_option(const char *cmdline, const char *key, char *out, int out_len)
+{
+	const char *p, *p_end;
+	int len;
+
+	p = strstr(cmdline, key);
+	if (!p)
+		return -ENOENT;
+
+	p += strlen(key);
+	p_end = strstr(p, " ");
+	if (!p_end)
+		return -ENOENT;
+
+	len = p_end - p;
+	if (len > out_len)
+		len = out_len;
+
+	strncpy(out, p, len);
+	out[len] = '\0';
+
+	return 0;
+}
+
+/* The bootargs are populated by the previous stage bootloader */
+static const char *get_cmdline(void)
+{
+	ofnode node;
+	static const char *cmdline = NULL;
+
+	if (cmdline)
+		return cmdline;
+
+	node = ofnode_path("/chosen");
+	if (!ofnode_valid(node))
+		return NULL;
+
+	cmdline = ofnode_read_string(node, "bootargs");
+
+	return cmdline;
+}
+
+void qcom_set_serialno(void)
+{
+	const char *cmdline = get_cmdline();
+	char serial[32];
+
+	if (!cmdline) {
+		log_debug("Failed to get bootargs\n");
+		return;
+	}
+
+	get_cmdline_option(cmdline, "androidboot.serialno=", serial, sizeof(serial));
+	if (serial[0] != '\0')
+		env_set("serial#", serial);
+}
+
 /* Sets up the "board", and "soc" environment variables as well as constructing the devicetree
  * path, with a few quirks to handle non-standard dtb filenames. This is not meant to be a
  * comprehensive solution to automatically picking the DTB, but aims to be correct for the
  * majority case. For most devices it should be possible to make this algorithm work by
@@ -341,8 +401,10 @@ static void configure_env(void)
 	/* Now build the full path name */
 	snprintf(dt_path, sizeof(dt_path), "qcom/%s-%s.dtb",
 		 env_get("soc"), env_get("board"));
 	env_set("fdtfile", dt_path);
+
+	qcom_set_serialno();
 }
 
 void __weak qcom_late_init(void)
 {

-- 
2.46.0

