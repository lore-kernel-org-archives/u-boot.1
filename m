Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A5CC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E0778419D;
	Fri, 11 Apr 2025 17:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xUsjJT0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B7582B66; Fri, 11 Apr 2025 17:31:01 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7413284183
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so17988785e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744385457; x=1744990257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZyn0Y/5DVU3ehrHBzDsZieA14VFSu1fxGrz7553hew=;
 b=xUsjJT0h+ZbKKcQWL/EfhnjcnTFB4fKKDS3KmeG0OdlrQS/+Ufp3IWIXGcXzafiQXb
 EvBSJh+IyxABdOg5xjox1DsCK3H7lbAPverTSeMP6s/izyfYCCN1ugO+311woeCqOLC7
 dZpHhya1DaRMwZgJnaxoSYgj4iqSjCe9BbqFDHAEhdkx2DiaKN4EeuzX3iB66YgjewNv
 awaDtjqIBuDLVXQXARgTlavhEg+jLJFHmgRlwp6cIu9QrItNbj+zt/oGhJc8RkHM3WKN
 tVUXUTzTxn8G3NFNRiLXYzgY0dvLN9aZuOYCoqiWABC93iu4Ak7d9X/VWDW+4zTsFG3y
 13Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744385457; x=1744990257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZyn0Y/5DVU3ehrHBzDsZieA14VFSu1fxGrz7553hew=;
 b=CAcAbn7erDA1uuoYRf1k4XrJqPBYHVEen3eBOm0Ybd/C/lfe+mFnVD7vUIYuyyr7B8
 BhYAY4UP/ne9vegwXN9Iyonh05/96m+iqpgvKo0Yf2gZ8JsO5ErzL46Rpu0FUo+i6CbX
 EEVDNIsxl0gH++1ntNkFmJcJr5iGdQ5XHo/zezSjy+hP8uY1mJB+ndWwHZJCdzjI1dDi
 lx7PDJ5FqsNSVB5hjfxlpkzURWrGHXOpRKasgAZvOGzAvz/OG3eHRSQCuxNepFnv/5BE
 d/G9qkMcUQN6sBlVvng3pa2Xz/ENIUfqkK9lYJB+I/7IKxB4H0H2AbawxHx+ksfU31YX
 ZeLA==
X-Gm-Message-State: AOJu0YwsCEf9u9CINZGG8jFtSiXVrBaaUQjXwd3FB9vVrkbhKHTgBfcN
 Ch+DKV8TKWE5q2Y9PS6Z2aKh0LfgCX39uObs49I+lrA2blAkGOUFw61zUfxMmrErIWq8BcM52hg
 jIbg=
X-Gm-Gg: ASbGncvv/CvYMgQkf4EwtbMzPh+tVHplReVy5TM96TdPBQXjsD5kfgD1LjPkiU8RI5k
 dUwni4vgzOVHfQmInyBWo+fGmlwGwMFNMVMHfSAfs/iZnS+ndlA9LuPQezqW9h0r2OGZ00fSkIK
 kXp7fmgPFOIuR5P0gcSMDzgE6yejARGEo1qrE46eEGNhthRPnEMMRARB2OOCllkhtvgTeVCkcZn
 jwkT4tsCqB7W1S+mUlbraqfnLxk5P4EdkBL0xhOSfIpKcKu6cF7iJIkh/9YQLa+77DnsunuIgOg
 2NvKTGVgTDj7Y9xuqQWxf2wVanXDsS5cDoCgs7Z/VyMcvZGxSe1eVzkpaXky
X-Google-Smtp-Source: AGHT+IFTmPaeAhkzNJx6z/wHNTaeOEgWQBwLOY6VrLRBp1HNkuyKIyBatb0i9nHSvotWI00hed3YSA==
X-Received: by 2002:a05:600c:5494:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43f3a93d850mr30568155e9.11.1744385456504; 
 Fri, 11 Apr 2025 08:30:56 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:94cf:dbda:d223:8de8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecf30sm90337355e9.1.2025.04.11.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:30:56 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Weinberger <richard@nod.at>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 2/7] bootstage: add support for reporting in JSON format
Date: Fri, 11 Apr 2025 17:29:28 +0200
Message-ID: <20250411153040.1772000-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411153040.1772000-1-jerome.forissier@linaro.org>
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
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

Add a new Kconfig symbol: BOOTSTAGE_REPORT_JSON to report the bootstage
timing information in JSON format in addition to the human-readable
text format. JSON is easier to parse by machines and represent
graphically. The main goal is to be able to record boot statistics during
CI in order to detect performance regressions.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 boot/Kconfig       |   7 ++
 common/bootstage.c | 156 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f101200ba7a..5e90e20141a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1167,6 +1167,13 @@ config BOOTSTAGE_REPORT
 		 29,916,167 26,005,792  bootm_start
 		 30,361,327    445,160  start_kernel
 
+config BOOTSTAGE_REPORT_JSON
+	bool "Display boot timing report in JSON format"
+	depends on BOOTSTAGE_REPORT
+	help
+	  Enable output of the boot time report in JSON format in addition to
+	  the human-readable text format.
+
 config BOOTSTAGE_RECORD_COUNT
 	int "Number of boot stage records to store"
 	depends on BOOTSTAGE
diff --git a/common/bootstage.c b/common/bootstage.c
index 4532100acea..1ab55ecbe8f 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -11,6 +11,7 @@
 #define LOG_CATEGORY	LOGC_BOOT
 
 #include <bootstage.h>
+#include <env.h>
 #include <hang.h>
 #include <log.h>
 #include <malloc.h>
@@ -19,6 +20,8 @@
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <linux/libfdt.h>
+#include <timestamp.h>
+#include <version.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -324,7 +327,7 @@ int bootstage_fdt_add_report(void)
 }
 #endif
 
-void bootstage_report(void)
+static void bootstage_report_text(void)
 {
 	struct bootstage_data *data = gd->bootstage;
 	struct bootstage_record *rec = data->record;
@@ -353,6 +356,157 @@ void bootstage_report(void)
 	}
 }
 
+/**
+ * Same as get_record_name() but with a %<n> suffix if needed to make the name a
+ * a unique key. More specifically, where get_record_name() would return "foo"
+ * twice for two distinct records, this function would return "foo" and "foo%1".
+ *
+ * @param buf	Buffer to put name if needed
+ * @param len	Length of buffer
+ * @param rec	Boot stage record to get the name from
+ * Return: pointer to name, either from the record or pointing to buf.
+ */
+static const char *get_unique_record_name(char *buf, int len,
+					  const struct bootstage_record *rec)
+{
+	struct bootstage_data *data = gd->bootstage;
+	const char *name;
+	char tmpbuf1[20];
+	char tmpbuf2[20];
+	int idx = 0;
+	int i;
+
+	name = get_record_name(tmpbuf1, sizeof(tmpbuf1), rec);
+
+	/* Count records with an identical name before @rec in the array */
+	for (i = 0; i < data->rec_count; i++) {
+		struct bootstage_record *irec = data->record + i;
+		const char *iname = get_record_name(tmpbuf2, sizeof(tmpbuf2),
+						    irec);
+
+		if (irec == rec)
+			break;
+		if (!strcmp(name, iname))
+			idx++;
+	}
+
+	if (idx)
+		snprintf(buf, len, "%s%%%d", name, idx);
+	else
+		strlcpy(buf, name, len);
+
+	return buf;
+}
+
+/**
+ * print_time_record_json() - print a time entry in JSON format for a bootstage
+ * record or a couple of bootstage records.
+ *
+ * The function prints "key_name": value
+ *
+ * - If @rec->start_us is non-zero, it means @rec holds accumulated time. In
+ *   this case, key_name is the unique record name and value is @rec->time_us.
+ * - Otherwise, @rec represents a boot stage with an associated timestamp. The
+ *   key name is obtained by concatenating the previous record name and the
+ *   current record name, separated by a tilda. The value is the elapsed time
+ *   between the two stages, that is: @rec->time_us - @prev->time_us.
+ *
+ * @rec: the record to print
+ * @prev: the previous timestamp record (used as a reference when @rec is a
+ * timestamp)
+ * Returns @rec if it is a timestamp, @prev otherwise
+ */
+static struct bootstage_record *
+print_time_record_json(struct bootstage_record *rec,
+		       struct bootstage_record *prev)
+{
+	char buf1[24];
+	char buf2[24];
+
+	if (rec->start_us) {
+		/* An "Accumulated time" entry in the text report */
+		printf("\"%s\": %lu",
+		       get_unique_record_name(buf1, sizeof(buf1), rec),
+		       rec->time_us);
+		return prev;
+	}
+
+	/* Elapsed time between two consecutive stages */
+	printf("\"%s~%s\": %lu",
+	       get_unique_record_name(buf1, sizeof(buf1), prev),
+	       get_unique_record_name(buf2, sizeof(buf2), rec),
+	       rec->time_us - prev->time_us);
+
+	return rec;
+}
+
+/**
+ * print_env_json() - print an environment variable in JSON format
+ *
+ * @env: the variable to print
+ * @cont: true if a continuation comma ', ' should be printed afterwards
+ */
+static void print_env_json(const char *env, bool cont)
+{
+	char *val = env_get(env);
+
+	printf("\"%s\": \"%s\"", env, val ? val : "");
+	if (cont)
+		puts(", ");
+}
+
+/**
+ * bootstage_report_json() - print the JSON bootstage report
+ */
+static void bootstage_report_json(void)
+{
+	struct bootstage_data *data = gd->bootstage;
+	struct bootstage_record *prev = data->record;
+	struct bootstage_record *rec = data->record;
+	struct bootstage_record *boot_end = NULL;
+	bool first = true;
+	int i;
+
+	puts("=== Begin JSON bootstage report ===\n");
+	puts("{ \"u_boot_version\": \"" PLAIN_VERSION "\", ");
+	puts("\"u_boot_date\": \"" U_BOOT_DATE "\", ");
+	puts("\"u_boot_time\": \"" U_BOOT_TIME "\", ");
+	puts("\"u_boot_tz\": \"" U_BOOT_TZ "\", ");
+	puts("\"env\": { ");
+	print_env_json("arch", 1);
+	print_env_json("board", 1);
+	print_env_json("board_name", 1);
+	print_env_json("cpu", 1);
+	print_env_json("vendor", 0);
+	puts(" }, \"bootstage_data\": { ");
+
+	for (i = 1, rec++; i < data->rec_count; i++, rec++) {
+		if (rec->id) {
+			if (!rec->start_us)
+				boot_end = rec;
+			if (!first)
+				puts(", ");
+			prev = print_time_record_json(rec, prev);
+			first = false;
+		}
+	}
+	if (boot_end)
+		printf(", \"total\": %ld", boot_end->time_us);
+
+	puts(" } }\n");
+	puts("=== End JSON bootstage report ===\n");
+}
+
+/**
+ * bootstage_report() - print the bootstage report(s)
+ */
+void bootstage_report(void)
+{
+	bootstage_report_text();
+	if (CONFIG_IS_ENABLED(BOOTSTAGE_REPORT_JSON))
+		bootstage_report_json();
+}
+
 /**
  * Append data to a memory buffer
  *
-- 
2.43.0

