Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B2606A7D7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hkMoofNl;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=szl8FtsH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08F2581316;
	Tue, 10 Nov 2026 13:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kNUR0vgSPkZ; Tue, 10 Nov 2026 13:06:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9D438128F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315961;
	b=D+qpMO6Xbc9QHrHVQMfc3SmFVGMk2SlQ4e8BC6y/R84RWGZytzwF/EhGTP15DSkfjFyv
	 m0edaB1CoQM+cOi1ZnWQiZhmIzSXW2U2uB08JBQFCO+Z9Dh37p6GZuP1dO3cXEhZ9zH1t
	 PdIdIJgDQTuKY5q3tWuOpMdEteQZh9M3ZomSfF3COaENlEQr67CBww2h80jEKkVudUoG3
	 qF8NNtM9iq59Ys17UHUheBbUtaL0tb+85JOxhdjpvvqJBaCATeovcgHeX1W9/K9RYp82H
	 of805vhwv+3MbiQ1/oOS5i87mTo8Au2tZIg2r3NHH3bUVWn/qFG9v7MWV2MXM9/fyaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R8nLD7SouM5bFIOauEPP0T6dVUB0KBSmndhl1rngS9E=;
	b=CGegw+al8VbSQOEFTF/hk3wj15nHqdq9jL37fXqxfmnWq5FX3ss3j/qNqj/5iCT1czKS
	 QlwJNKduoBeRzFtrKKJZZb5vfhUIGTqcxSPfcKE3xLP0dREDBTdOZhYhx6FOsOui8gfKj
	 BLdzXtNuj9U/VC0Vic2eqIKMK3PUOQND6XWEd4H4bf6O4mJjUsX6P1XpAL7SqPX6B+NKi
	 RRdOml0Wa6gECVhrE9S9CxMDgmsrKdOOkT0CT5MbSNBiaylsU4hs8Ydm0ub8iq6xNh9vU
	 ZLqKxEM340XwohXeClGK2vZessyCkiMn3x0kSz7JOOY5IDH/mHmSmYR0GDbLsy4qgMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315961;
	bh=R8nLD7SouM5bFIOauEPP0T6dVUB0KBSmndhl1rngS9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hkMoofNln9jTUuT0JL2c+ikm246X586B6W40PQyeALYpDIqFVtFTMBQun8o/unrxT
	 ajAcqcs8Gk1ZXYMEjdzRM9uZpEQ1StsYeVAyrECfogPBQArk04dgoGi2NChkd0xm/e
	 ee9Z65Lp/MupW1QRWjZS/ryk39uICEgFm7rP6LBuRc+Z36Gry/RowOO0xGqm6L5VxD
	 L7LB6qkFMi4aZQrmcq+fGZKuTiIJV2ULT3Z3WBMrImLviorS7lHusDP70scIuSaVyu
	 HW+mH0jk6JzlM2PHw+eQHjSoGKvTAAjlLATS+fgIIOuy2n6Tc/yGnVf8zlTcuJNj4Y
	 9m5Rv95GoaLEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9D438128F;
	Tue, 10 Nov 2026 13:06:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 44FD9D7
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36A1040684
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKix1wryVKYn for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:57:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B8C340639
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=szl8FtsH
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B8C340639
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:56 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EA27C3F9D7
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794297474;
 bh=R8nLD7SouM5bFIOauEPP0T6dVUB0KBSmndhl1rngS9E=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=szl8FtsHRt8owCoDPAkxulBu8ZFOS29PhQakf7/BzIIg/w6pUsMgwxJAXPR1U7r1k
 kxxdft/2C1JDqBtLFRwDg1XY3P4bNKpbHdKZdzCeRh2ZI/Pqx9Seuv+baLDdFJpZej
 MLrpDdXOIULNtNWbFcRBAP+mfa/8y0LjHsxxGfz0cod2t1uCZcUfu/yPzVympnf7KC
 Wy4LP8cIruqP9YkoaCayiojAGvJ8Dczqm7R+fu2NsqXoGSRghVkdg6ii4i05CMTQj4
 w+oc0PsLOSdVY4i/SmtniSDmPk5wYJupWg2TdJtAQtKuiVEAQai7xkeB/4OXtj78et
 r5AlYOSy0piGMSmD+Kmx7gO1weu3FSXSMdIu81BMd17ffwDKyfjMnw2ITVMsp3oYqu
 wQDbP1T8VSfywKFloR17i7qANBy888kVtXDP+gGa0wPWS9+Aer6eBvNJJDp/MaMmJL
 i6QnstXdSfSajX7cri5PWolV7s5b+xwidO/BZMuRMWLsZz7+1F6QcL0I4HOeuy7Psg
 GUEisqQPEP6AqI64L2/HtDDAepJAemviya5WdFAzJBwdc6ha30KCRilNwhveP8i161
 LYs1A9nqvgY0ap6IBD7JdN5m6Inv+n2poaTpzG5XGH9B+ZJBnfCiAltpLWrsYtHz7k
 Rnbp9vrDu/KgYdrbs8VeJ8Cc=
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-37390b2989bso3807901eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 23:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794297473; x=1794902273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R8nLD7SouM5bFIOauEPP0T6dVUB0KBSmndhl1rngS9E=;
 b=TucjqhXUv1mGxMN4/bwRMt+mHWF7ZWsX3wHdiAhDupk5jo+1L+SbJRct82yIc+wNGY
 JS1/mbGPh3hqLumRFCmGmoXcXA/Je3NBs5EufFmcvH91pTkX3ihmQ/KQx7kbJoAQVSco
 z+Cs0l6kaaVjvxlpC7KKCMWlXan2g5B1bRwnFoSKFH1XeCE67Tfp+JE9kEHJdOdrQgH0
 ugzwR2DZzLHB78Vt8/TQ13//etwwOSNhJH10BH3DylqDM2Ttc9qYY5d4olhAD2/Yfuh6
 P8mif23dy4bFAYUFXmYvYROEcQwvu/6VxYk4Sxyz+/QcQr6jhJ87qYQpRlPG1cj3ZOsW
 azEw==
X-Gm-Message-State: APuU4Z86UnWGCLlftpfqcih/smnNJkPdykfKT79JWeQOSu7gy+ui9x/o
 Wy0Snbwrv+IYfrsK4cl8Ox8EU8hHs9hSWLsH2eVR23pWlod6W0rPjYYmRYcjQc/8Hb6465tKIW/
 MQhfTxN8wTz0fPKUtND8E1ADEFbPMIQRPWCRiIRthywsVyABJT3uUdlzpN6ruOL4X5WU/L8ZsmB
 ulD7CtV7GACqIW6hwET2bd
X-Gm-Gg: AYBFou21snbuChEKHEuE2+B1Szh+VJiI0/JvSVmyVxxqxcOI0g7UoTwRFxptDWt1HWd
 vznAbYLIZXdGdCccMXAlgsnDTHi8Ef3ADX3osYkIUthk3ugw6cr0TnShf6bRDy3DsMbq5wi9Ysb
 LrRUlRySWlmZ3IVO4Aen7Z74Vziq08DuLXVuKfZAwgX2dXPZjtUMZKsX0uQ1kdnQTzaEqVkSC3Z
 +98P26WVhEXWkCdc18gkKj9pxg+FUAVD1Mq+gtYy3n7w/AQ3JGRwBDc120Ydf1yJ/NXLKyHTM4k
 ER4dAJwnIdCnQwNQHYHs0G8pnFsVJWHQL0olpLw3fAz6WYvnRKp3nJBMAZzYrDnh/QDICFRTv7O
 zPUZ9BCCo+czDOxAJMw99gkZ1PMrzDN79ZaWUl8XvRycCNTThMSyDGnGTakkvZ7rhsHS/bmSg7D
 iW+v0Gc5UiVt45wBh6b+YpM/b6
X-Received: by 2002:a05:7301:b0f:b0:36e:1fbe:3571 with SMTP id
 5a478bee46e88-3751c53b760mr2456021eec.3.1794297473151; 
 Mon, 09 Nov 2026 23:57:53 -0800 (PST)
X-Received: by 2002:a05:7301:b0f:b0:36e:1fbe:3571 with SMTP id
 5a478bee46e88-3751c53b760mr2455988eec.3.1794297472530; 
 Mon, 09 Nov 2026 23:57:52 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe3261csm4212914eec.4.2026.11.09.23.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 23:57:51 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
Subject: [PATCH v1 1/6] cmd: pstore: check that the buffer for the records is
 allocated
Date: Tue, 10 Nov 2026 07:56:37 +0000
Message-ID: <20261110075707.1409824-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110075707.1409824-1-aristo.chen@canonical.com>
References: <20261110075707.1409824-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pstore display and pstore save copy each record into a buffer as large
as the largest record size set, without checking that it could be
allocated. With a size larger than the malloc pool, the first valid
record is copied to address 0.

Report the error instead.

Fixes: 9744d1a54784 ("cmd: Add command to display or save Linux PStore dumps")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/pstore.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index 30b5f62fe6a..e864dc80df7 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -278,6 +278,11 @@ static int pstore_display(struct cmd_tbl *cmdtp, int flag,  int argc,
 		pstore_init_buffer_size();
 
 	buffer = malloc_cache_aligned(buffer_size);
+	if (!buffer) {
+		printf("Cannot allocate %u bytes for the records\n",
+		       buffer_size);
+		return CMD_RET_FAILURE;
+	}
 
 	if (type == PSTORE_TYPE_DMESG || type == PSTORE_TYPE_ALL) {
 		ptr = pstore_addr;
@@ -389,6 +394,11 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 		pstore_init_buffer_size();
 
 	buffer = malloc_cache_aligned(buffer_size);
+	if (!buffer) {
+		printf("Cannot allocate %u bytes for the records\n",
+		       buffer_size);
+		return CMD_RET_FAILURE;
+	}
 	sprintf(addr, "0x%p", buffer);
 
 	save_argv[0] = argv[0];
-- 
2.43.0

