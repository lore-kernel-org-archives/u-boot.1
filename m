Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A25CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CDBA40987;
	Sat, 17 Oct 2026 13:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DHlrj099b5BO; Sat, 17 Oct 2026 13:01:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3CE040981
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242085;
	b=XUhwgWEPvjKCkbZXuWQEjxIhBIS2LRLjPZLxvdbmVSBssuN6oU76CYKQvDPsxot2ylvG
	 UHt/gxbZKrsx0NcW9ZpEw3KfRZ7EJY2HfaHmMk1nRHtJr1Ycgp8K2ZTB+cNTYp/Cq9dnH
	 mbJhYPjmkScBUJ3u1x9o1q8vTd4QLl816lIHQXGzolPjc6zEoPHWNlETki+ggRqStexUR
	 Ak8/zjh1UmKohgXwodrFTOMc32Djt3G6OYxHlmyuzyJvt/NoTWWE9w1JScG99la3kmIBh
	 t9Mw29aU2rhGVgndfNw1aew3mgRm88/Eo2JNZ5RSnHUA50JtaGCxvNRK6+RoGXu8jmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242085;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w/rHZnyC6M5sK+SJlvgfILH70I0UHZ75Zz0w7mj8aew=;
	b=jYBy2W+ZtLUDns/IPtEA1po6bYBqkM6Q5AAt3QWxXLRw7W7Nk+ECG18mMMoGtVeQpCvO
	 hUoCVvh9YPq4pgMCvTPIcj/BRn+8Htck/cwxbIx/6a8tq66J3mXq6D8wg7ynMRSkHoziL
	 1TQDU/LyW/w2MGav4daYbcRfmqgXqxcmrIebTJ76VQhZ/R7o15CymqFaJ8UvnI+7ol24R
	 iI9kURQKAywiekRQwMVY5/lDn6dEdX3ZzD45H2P4asAhm+Jjfd3bsAmUuNTi/5LKSRbxb
	 djnm9FludIA3TjXcfJx9XRwEwn8ZZtkvYpxEom26z5Zi/n6+SwONTGqAKiB8YDMPTeA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242084;
	bh=w/rHZnyC6M5sK+SJlvgfILH70I0UHZ75Zz0w7mj8aew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BBoB87JJ5oMeNONHxUz7ymeKvBALE6Hgj/WTDz4PQABmdSaOkeUfiXAjqCSAl7jIm
	 sHp4ITU+T8Csie3UOvoFiI0ChKyXQVHjnkOgbfB7E9DJh5h5Fv8zgdCVkpIHFtJ/Hj
	 MKO/3RSRV7FkR/JqyX6Lmb4VFJYPgDvb+E766D0wsEB3FU2+xR8lFOE9t8cP5mfOZr
	 16GtMLVu1fFpJXLpytDEo6uQ1nAM8n0kyCtM3frH5tHfXND0TNiMoCOLUoa22k1utA
	 xObewU8YOWCIsNtwDUoc+DcDrakeAwQMkb6SfoxNs6SdePZDUVyguut53XukecIcuc
	 FzXEUB5BjP94w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3CE040981;
	Sat, 17 Oct 2026 13:01:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C19D9465
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B36F3812DB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQvb5IGhIidI for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 12:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DE889812D4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792240599;
 b=oR7+Ag6B7v03lqTvgQqjsco78R1xjcxVz82XnUMO8NYLYJP9bj31pbGxyqVLmBdvoE/3
 1z8VCYSLOu1fmXZVajHx4n2sWN4xaJREN4ksZflCHM+OaKKCQDhL0LPdoLnqBFYJ83h2c
 FuUVw+CP163TrMhOugEU/HND73JDoceVUjZ9LxarxKrHJogrswm6ZMwJ3a9rSzF5h0Q44
 T74U1LbFiJLFlb1A0BKPy2f7VgiN6vviKysUegE5+WeHFiNn/XrqdeGcX2vrXvRAvRr2H
 C6jsQTTghnEc7arozBUE13GUc4Y3OEUiHo7l6/rxody7Apvfx55l1FAK8e+L22U7v5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792240599;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=w/rHZnyC6M5sK+SJlvgfILH70I0UHZ75Zz0w7mj8aew=;
 b=SZfy0m4HF1FX954K5du57rmPenJpjr5lzUYALakwUNHGE0orERAGaKm6FKoh5Gcpn+or
 7mJs+VQQX7DtKsG6iQ5uQScO1pJwvWv7P9RMewLES8tGVlU2r8PuXY76t+QED/F6iuLJ1
 1yR3KlcGqT42kXFYh/igqFygy7tFe/3PxN78OQw5/BYeYE+xPJgED941aTuw2Q+X9ttWV
 fqlcixw2/E8gcmBILP5QJM+8+lhqzOqx5HtmfGD4LDikjIe+1vd6pcZWK2ymym6/y8Sef
 cOQb8wwfChjYMVH4jI8xj5b0e/QBl/Li0gNdS9aFu8Tq0S1dyw8+z59LNGtBFf75sLA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=qAAlhEGP; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=qAAlhEGP
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE889812D4
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:38 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4B1593F16E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792240597;
 bh=w/rHZnyC6M5sK+SJlvgfILH70I0UHZ75Zz0w7mj8aew=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qAAlhEGPp9F/vWY/PKG+H/wQAnJ5C3gyEJ/GT1rynST8qHIivKACWvEDLmRLGa62k
 YafXicDD719CTVnRIytrkAA4YG88DaNi6Dw46TUfHfyAgtIOuU9sHXRS8H584oz05W
 jPhF8nC8m6n2U6XzSGWRWRE/H/2aMkoX/cWg57qwzp0HWpY4LtF9LYqse3whY6aZrt
 lINLNxCbncU3z+RU+Fzf9rg0azkGd4JM2hJt54DKCMTSQz7eZEmZlPzUZTWq+3y1Lv
 Z5c1lnL6ADaHWXq8nb3gRZIm5yrAhiJxHje9g7npYTjkdEzkc7LP/uqs3EPSiAlDme
 wV0VSWKosC78sSx9AHBFBLwmGcX7RnAnjO1KvvyE5qJfV6wju7lQ6NebDoYIAm0yo7
 8dIWJeMhaolTIJunkp2PD2ihwBH95+WXUvbwqhH3IXOJ06oQHbZKJ4Z412UGbGXOab
 qx4xpQbydLpghWSzBG/KqEBkKbd6f7ahoC5+G1H8NRpOaDqpOXBUJH3xDLY9yhJeV3
 j9mhL4w1sCKSqq4kuJ1M+duHfoY764yMP5fO+uCS29uyFYQpZQHyr6gAYlFtq/rEeo
 85kpjdw6Dr7fmZudZXnKq9+AFgScWjJDDl4Ar7K0QvJ2wj/UQWqCqZLy6hWDKeOJl7
 C02oRKJt6XeE2jWSkKbbG7n8=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so619681a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240596; x=1792845396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w/rHZnyC6M5sK+SJlvgfILH70I0UHZ75Zz0w7mj8aew=;
 b=hSNYn3SuIhEnHMD6PT596zOpfH5Duq05sjc8Zv3NOg7mI7i800O2PXUf59+TLmZ/oc
 kUl5d9z7sMs1dGr3me7goTvfZXoV+Q8JUIdGwUxtf4jFwdjqmm9W98NHLTnHmwNGrcDo
 KE0ZP9AWsHrTCla1K1l6Zc7J58XYeEkg7RyFPohow9s8/xRoh2oQWlVUc4Oli/eRZ/Hu
 QtWpz8SFE/gSkVC5ujLBleCmFDHeDhycikjoTMolqglnNnQaeC3cbfA2xqbs1ebAuZe2
 KBkbtziUxm6E6bN3qlC2HaaJRiLYr0nildUKW9PjATdniy1bzwaveOGDS9yC51zeaq2Y
 7EgQ==
X-Gm-Message-State: AFq9FYJo8kl47JDLhxFg3QDlTmdTSppw5XEC7CLNmwamSpkq4ByOTQxG
 X1kQXzZDpes4Krf9OHtnhtf3oRTOuK7/vYbvBr86XUQEesvrHA2X8dHCcbRvggWyNY/e5Rg4eLW
 x2mCaS507zcvEenq8YYKgdMoaao7/QTCAZET9/qzZ5kW6Xqn5M7D1SZCXvFYOxGLxfojeIBvLPz
 3JSW8XT3rwt6qIs4WYZg==
X-Gm-Gg: AYBFou0seR6GLuuVgoUs0U2m0Srr1HR5m74oZ4UEm+kRTFhhwIWtfrVZxEA/nx+ihLz
 7w8mJKAYUvaeuezg5SpqT5xr/ZaxzhVyL40aFz0HA8kyFj+0wAPtDpHy2HYnc+sLJewLqD7cAXJ
 ZmzN8AbUipXbm+ed4NfUXhq/POm9D/4nsNwi1XlWsUAM1TiaSHJUY8fx1ZOx/C8jQN7WD89dUQL
 5KjMgxrNN6aSfHDS3j9rlHnIwfefmxBxQc/HhTSGt1CSjszc+Zk6v2HM+CUA5b8Va/CPlcEsDjf
 Bw6FuTPpmsZdZospKcbvZC3BfNW3nq1fW4K5oIlRap1UWcOlQZiIfaFx6K6eshIuvXPWybraJcg
 IUG9VGsOo2YwEAYPEbCrJYWDoxD/A+8MYfhexnCd6QNVM+dk=
X-Received: by 2002:a17:90b:4ac4:b0:3aa:f2c4:12df with SMTP id
 98e67ed59e1d1-3acee9783c0mr2280266a91.9.1792240595672; 
 Sat, 17 Oct 2026 05:36:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac4:b0:3aa:f2c4:12df with SMTP id
 98e67ed59e1d1-3acee9783c0mr2280248a91.9.1792240595257; 
 Sat, 17 Oct 2026 05:36:35 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f4cadsm7909410a91.12.2026.10.17.05.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 05:36:34 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
Subject: [PATCH v1 5/6] cmd: pstore: look for the end of the dump header
 within the record
Date: Sat, 17 Oct 2026 12:34:20 +0000
Message-ID: <20261017123554.211799-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017123554.211799-1-aristo.chen@canonical.com>
References: <20261017123554.211799-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

pstore_read_kmsg_hdr() finds the newline that ends the
"====<secs>.<nsecs>-<C|D>" line of a dump record with strchr(), which
does not stop at the end of the record: the buffer is not NUL-terminated
after it and still holds earlier records. When the record itself has no
newline, strchr() finds one further on and the header length becomes
larger than the record, so size - header_len wraps around. pstore
display then prints stale data, and pstore save asks to write almost
4 GiB, which on sandbox writes the rest of the RAM to the file.

Pass the record size to pstore_read_kmsg_hdr() and look for the newline
with memchr() within the record.

Fixes: 9744d1a54784 ("cmd: Add command to display or save Linux PStore dumps")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/pstore.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index 77dc925e398..30b5f62fe6a 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -42,6 +42,7 @@ static unsigned int buffer_size;
   * pstore_read_kmsg_hdr() - Check kernel header and get compression flag if
   *                          available.
   * @buffer: Kernel messages buffer.
+  * @size: Length of the kernel messages in @buffer.
   * @compressed: Returns TRUE if kernel buffer is compressed, else FALSE.
   *
   * Check if buffer starts with a kernel header of the form:
@@ -51,7 +52,7 @@ static unsigned int buffer_size;
   *
   * Return: Length of kernel header.
   */
-static int pstore_read_kmsg_hdr(char *buffer, bool *compressed)
+static int pstore_read_kmsg_hdr(char *buffer, u32 size, bool *compressed)
 {
 	char *ptr = buffer;
 	*compressed = false;
@@ -59,9 +60,7 @@ static int pstore_read_kmsg_hdr(char *buffer, bool *compressed)
 	if (strncmp(RAMOOPS_KERNMSG_HDR, ptr, strlen(RAMOOPS_KERNMSG_HDR)) != 0)
 		return 0;
 
-	ptr += strlen(RAMOOPS_KERNMSG_HDR);
-
-	ptr = strchr(ptr, '\n');
+	ptr = memchr(buffer, '\n', size);
 	if (!ptr)
 		return 0;
 
@@ -299,7 +298,8 @@ static int pstore_display(struct cmd_tbl *cmdtp, int flag,  int argc,
 			if (size == 0)
 				continue;
 
-			header_len = pstore_read_kmsg_hdr(buffer, &compressed);
+			header_len = pstore_read_kmsg_hdr(buffer, size,
+							  &compressed);
 			if (header_len == 0) {
 				log_debug("no valid kernel header\n");
 				continue;
@@ -411,7 +411,7 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 		if (size == 0)
 			continue;
 
-		header_len = pstore_read_kmsg_hdr(buffer, &compressed);
+		header_len = pstore_read_kmsg_hdr(buffer, size, &compressed);
 		if (header_len == 0) {
 			log_debug("no valid kernel header\n");
 			continue;
-- 
2.43.0

