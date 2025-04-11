Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B7CC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5342E841B1;
	Fri, 11 Apr 2025 17:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ljndL2/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9BA482B66; Fri, 11 Apr 2025 17:31:02 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B8DF84003
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1731553f8f.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744385458; x=1744990258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGMNM6XA8An9WA+DYUWQ0tcHnJe8kJMPt5NMSRCY+hE=;
 b=ljndL2/T4eYvNUtNaMJBjCMV1sBQyF0WKZCTWRNS3EoBKZ71mXLxtVodUMZkE6oRLs
 hy1eRiOWogcoTZPtiwQvtVzldZOb2fSFnJLGykFfWC6k5oZqJty5T8Yq/vT0Yzid8GJZ
 AjJ5bvpCGcjVtaPWqGUGyFCv/mTN17JUZUTjZDFyE1voziKuR5jjM+8DhC4J6zEk+lI7
 IlmW7UkA2Ahs/kO9ZfQaZ722T942RSSwtyUnz/ONQixdNIndUzKuwj+mDD4kmm4wGLwo
 ba0wkkjfEWVPhEl+artip/JRgXJsClUsLQ/ZIic5JbFmvI6ztd75rrdBccNZLzelfYXn
 XYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744385458; x=1744990258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGMNM6XA8An9WA+DYUWQ0tcHnJe8kJMPt5NMSRCY+hE=;
 b=sTtVrtePePLSsH4i82aaPrk7Vb2tS6vwm5w14HINlmT3k078L6N2f8LEhMFBc2nFZN
 VKAT2rDrkgx+Yl6KPxVnxA0Y4p3Q6P8NLl7o5oHsLYaAiADLk9qkHMc4sfEAhrCPymzF
 Yskvy6NY0sAWQFsjNPEmyDouXJCOILaTWzUre1ubTjUs7nYIpND7E8rsMBrc16nTE2hu
 OltFff6N9sSoWoiX2C3W3OP49LIGPFvC5UqSLtMKnUlo9WYnv5F6E1f1eO/I3D6Bvksm
 Rj2K08QMYgcwRO9lTRK7X+AvO9ANLbvRJcvDQpSgt0izRRl2vO8eY6S+16wBs1NKTXst
 v2TA==
X-Gm-Message-State: AOJu0YxlBR7hzk94aFtHkOynvGxJDDuu6K48l5cdBS0UbMl/xvocvM5p
 Zz9e/okZIKlY0zLWDAwnB7ig3d6VkIYEvE9KQcLEcQm38SQLxtVmgZR88MWGr8mpwnID9G6mj1W
 82J8=
X-Gm-Gg: ASbGncuvfLQj7NugNK8GDqpXMg5W+Ew+K7y2B1TAUp3Y6NHj0f3f8VsizxBIekfA4AI
 aXtUFwUy/6kshuH1Zyz9ZvbwnJkomsDcNcVfhIxdsG+I9DAcWSnMnSQUrs7xAHuBUsy0zMJ2fmr
 9IMxe3lVSaWeo3fXaeL0QcuNft5uUlvTYU98Zr1hLSG/5mQ7I7EAJ2GjUzjyVI9nw/c/dIqescC
 rudIhDF8buEQztt/D5v7NydyVobS+fV5e8aSBjx0HaKjE9nh6U6Z98rzOjO4X2mO+9OeAMUBLno
 zTwHAJgGts1dPebunNYe6/Cdp2DUZ14Bt06TYI5dmfGUxYQnzQ==
X-Google-Smtp-Source: AGHT+IFKFl2PmFctMGEcDFecbMhB8QwCjLfVUxlQDHUpy7jBr2NTHshSQ84Aujqd1TleTDeXQ/hMnQ==
X-Received: by 2002:a05:6000:144f:b0:39c:cc7:3c62 with SMTP id
 ffacd0b85a97d-39eaaecaddamr3067054f8f.51.1744385458381; 
 Fri, 11 Apr 2025 08:30:58 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:94cf:dbda:d223:8de8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecf30sm90337355e9.1.2025.04.11.08.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:30:58 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 4/7] bootstage: add support for reporting in InfluxDB
 v2 line format
Date: Fri, 11 Apr 2025 17:29:30 +0200
Message-ID: <20250411153040.1772000-5-jerome.forissier@linaro.org>
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

Add a new Kconfig symbol: BOOTSTAGE_REPORT_INFLUXDB to report the
bootstage timing information in InfluxDB v2 line protocol format in
addition to the human-readable text format. InfluxDB provides an easy
way to record boot statistics during CI in order to detect performance
regressions.

[1] https://docs.influxdata.com/influxdb/v2/reference/syntax/line-protocol/

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 boot/Kconfig       |  10 ++++
 common/bootstage.c | 133 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 5e90e20141a..6249f3bb0c9 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1174,6 +1174,16 @@ config BOOTSTAGE_REPORT_JSON
 	  Enable output of the boot time report in JSON format in addition to
 	  the human-readable text format.
 
+config BOOTSTAGE_REPORT_INFLUXDB
+	bool "Display boot timing report in InfluxDB v2 line protocol"
+	depends on BOOTSTAGE_REPORT
+	help
+	  Enable output of the boot time report in InfluxDB v2 line protocol
+	  format in addition to the human-readable text format.
+	  The report may be uploaded to the InfluxDB Cloud via an HTTPS POST.
+	  See https://docs.influxdata.com/influxdb/v2/reference/syntax/line-protocol/
+	  and https://docs.influxdata.com/influxdb/v2/write-data/developer-tools/api/.
+
 config BOOTSTAGE_RECORD_COUNT
 	int "Number of boot stage records to store"
 	depends on BOOTSTAGE
diff --git a/common/bootstage.c b/common/bootstage.c
index 1ab55ecbe8f..9009882ef73 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -497,6 +497,137 @@ static void bootstage_report_json(void)
 	puts("=== End JSON bootstage report ===\n");
 }
 
+/**
+ * puts_influxdb_escape() - Print a string, escaping the characters that have a
+ * special meaning in the InfluxDB v2 line protocol
+ *
+ * @str: the string to print
+ */
+static void puts_influxdb_escape(const char *str)
+{
+	const char *p = str;
+
+	while (p && *p) {
+		if (*p == ' ' || *p == ',' || *p == '=')
+			putc('\\');
+		putc(*p);
+		p++;
+	}
+}
+
+/**
+ * print_time_record_influxdb() - print a time entry in InfluxDB v2 line
+ * protocolformat for a bootstage record or a couple of bootstage records.
+ *
+ * The function prints [,]key_name=value
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
+ * @is_first: true if this is the first reported data (won't print a
+ * continuation comma first ',')
+ * Returns @rec if it is a timestamp, @prev otherwise
+ */
+static struct bootstage_record *
+print_time_record_influxdb(struct bootstage_record *rec,
+			   struct bootstage_record *prev, bool is_first)
+{
+	char buf1[24];
+	char buf2[24];
+
+	if (!is_first)
+		puts(",");
+	if (rec->start_us) {
+		/* An "Accumulated time" entry in the text report */
+		printf("%s=%lu",
+		       get_unique_record_name(buf1, sizeof(buf1), rec),
+		       rec->time_us);
+		return prev;
+	}
+
+	/* Elapsed time between two consecutive stages */
+	printf("%s~%s=%lu",
+	       get_unique_record_name(buf1, sizeof(buf1), prev),
+	       get_unique_record_name(buf2, sizeof(buf2), rec),
+	       rec->time_us - prev->time_us);
+
+	return rec;
+}
+
+/**
+ * print_env_influxdb() - print an environment variable in InfluxDB v2 line
+ * protocol format
+ *
+ * @env: the variable to print
+ * @cont: true if a continuation comma ', ' should be printed afterwards
+ */
+static void print_env_influxdb(const char *env, bool cont)
+{
+	char *val = env_get(env);
+
+	puts("env_");
+	puts(env);
+	puts("=\"");
+	if (val)
+		puts_influxdb_escape(val);
+	puts("\"");
+	if (cont)
+		puts(",");
+}
+
+/**
+ * bootstage_report_influxdb() - print the InfluxDB bootstage report
+ */
+static void bootstage_report_influxdb(void)
+{
+	struct bootstage_data *data = gd->bootstage;
+	struct bootstage_record *prev = data->record;
+	struct bootstage_record *rec = data->record;
+	struct bootstage_record *boot_end = NULL;
+	bool is_first = true;
+	int i;
+
+	puts("=== Begin InfluxDB v2 bootstage report ===\n");
+	puts("u-boot_bootstage_report,");
+	puts("u_boot_version=\"");
+	puts_influxdb_escape(PLAIN_VERSION);
+	puts("\",");
+	puts("u_boot_date=\"");
+	puts_influxdb_escape(U_BOOT_DATE);
+	puts("\",");
+	puts("u_boot_time=\"");
+	puts_influxdb_escape(U_BOOT_TIME);
+	puts("\",");
+	puts("u_boot_tz=\"");
+	puts_influxdb_escape(U_BOOT_TZ);
+	puts("\",");
+	print_env_influxdb("arch", 1);
+	print_env_influxdb("board", 1);
+	print_env_influxdb("board_name", 1);
+	print_env_influxdb("cpu", 1);
+	print_env_influxdb("vendor", 0);
+	puts(" ");
+	for (i = 1, rec++; i < data->rec_count; i++, rec++) {
+		if (rec->id) {
+			if (!rec->start_us)
+				boot_end = rec;
+			prev = print_time_record_influxdb(rec, prev, is_first);
+			is_first = false;
+		}
+	}
+	if (boot_end)
+		printf(",total=%ld", boot_end->time_us);
+	puts("\n");
+	puts("=== End InfluxDB v2 bootstage report ===\n");
+}
+
 /**
  * bootstage_report() - print the bootstage report(s)
  */
@@ -505,6 +636,8 @@ void bootstage_report(void)
 	bootstage_report_text();
 	if (CONFIG_IS_ENABLED(BOOTSTAGE_REPORT_JSON))
 		bootstage_report_json();
+	if (CONFIG_IS_ENABLED(BOOTSTAGE_REPORT_INFLUXDB))
+		bootstage_report_influxdb();
 }
 
 /**
-- 
2.43.0

