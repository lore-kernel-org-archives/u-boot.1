Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256A606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gsodGuTN;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=df5ujWdh;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=6xnPZLvR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DED0340806;
	Wed, 21 Oct 2026 10:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id In-o5Ex8zXw1; Wed, 21 Oct 2026 10:26:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1237040800
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792578405;
	b=cT8K614Qrx84PFpDAbvKxxUWoVwfVQ6IT38CYVEtbB18WPbh6Sc46Ph0aH1fEJoKuthi
	 G+XImQrY74SObQ/D3p81HMUVdl8fboVU3EuGmhYcqelQFL42TKK781Yi3sBapMPB04iLR
	 FE1QZmeaUtIphomJlYQFuKaSq6SlwKkZYAfW7YxRPj9lY863ZqUAogCp4Di0s81EC7iKT
	 aycQVIP/d/zzWw3VU8LifxiZ1m5pNLJWk/MNSJHsiDqkAaQAgqfMX6wpz2Z1erFQ+F7+U
	 MGpEg4EGbcY2t9O/4h+dHxGdHm8Tc7HHhM0WB2/7GHZ5rLH4ZR53bujdUgb7Bg1BSsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792578405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uTwot97+ovtXca1sIdyI+KmbakpAv38sqvSAkcXZ0jY=;
	b=gu3jNGAcDpSXaaJSo7s1ACb8MVblQAsGPlXprxN2nEH6l9RjDQU94244Ldr5DE6ulosz
	 7nppkkq19Qlx1m3MgK8a0n2vPC/Zt8PuHdYJZ3YncfknPJfwuApZdmJZ7s/UIwlR+8EG1
	 6mF66y1nzlw+2lmh/dgRIMr9n1I4ogltSqzzGjqLNUeDXMgcaj47B0TU0GZ0xWszywvIo
	 4qBN9MqtyBhOzhmYJAnG/PTJmrq4bRhXD3gK3O4FZ2Bg2JOMB3+eWJIjEQ+BTQhUFae4s
	 za3z0PRpVrKY/0cwNMA9BRmZ01QLb5dYt13ezTKPGn4qcMG6WkFN22d82JKVvr7fERQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=df5ujWdh;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=6xnPZLvR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792578405;
	bh=uTwot97+ovtXca1sIdyI+KmbakpAv38sqvSAkcXZ0jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gsodGuTNjShHWGph+1wKsf7CfFnrVQQOL0n/HwTR9AaWQGhoGaDabTUiYgcAOp6R0
	 fEej0ICpvqnv6rfglMpswTg3zkNhFTv4okXzcX0kNmVrcjPhB6nxmqRdBS1VPz0zlY
	 jPGOPSTuy+Eywjr1w1efp6DPGWXV+ApxbSLB/y0jXPrMYhhMMcx9IxR9lrQQDCBuJx
	 jRweBrJoIo5U32D5SvCklZduUkgPkSy/0ChBbzYmPFuUNQJPzUDnsOLH84z3ckvK8y
	 DTExURVWgI8Jse9R7E7t78LbpdhdtZHXF+//VtdFfHOfjsv589si9W0l7prz8q/j7D
	 HCf/DWfeuuzdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1237040800;
	Wed, 21 Oct 2026 10:26:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 05AD11E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E056D406F9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aW1Etca-9NnO for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97319406E6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792578397;
 b=RvLMhDm3WwAuIozjs7gYH/SBipzxonBqmU362Z9jW/trX+9TiwMxAL5EtB6Ol2/f5NuL
 iWP15HTtcUJnYhLe7WEMDdE31tQZwdwnaexCMg6ZWPbnwuPnp2FB40k6vUKPn+JIR5pbG
 Z2js8uCQEboRGyiaXoFi0WFZ5z5pa6u+hOFgPjOmqbuqFn1haByIBB504qNolllPcNXOV
 A41o/0dFxMzLOSl1/v1GMxdymzjAH0EdlGq1AftekQgM4mkBOZT+7SXNV/fhC93PrD4uC
 wDlUwbYTK+pFDDEAp4l6svkVV9QMVKfxsYx+Hb+lrQdXHtlzMI9jVCapAvyDaLQyYTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578397;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=uTwot97+ovtXca1sIdyI+KmbakpAv38sqvSAkcXZ0jY=;
 b=KfsgIsOL3n0YbUCrinsk89Z/k2PJSj02vuHa1lL22PWuJpkOY96ataQkhieYwwPMCYth
 O0o9gGeXhY6IRvdqIFlfEpVE8ydNUU31TLxDGx4zrIt3zQ+FErfEsma7HtbYDCQzEHWgX
 gZ2Aw48VuqFien5sXFr5u1svY7YaQr53Rbvuj1eOKb5MwUlWV+FMZK0izcc7qZFiSMXS1
 K7tE6LWSkoTPPSCnwqfoJZzaY36YVk8aMXdMg5YP5zRRyzsb4eBHe/5mVQ89Ak7UU1lC+
 Cq2cKkK7ci0PzSTTqS3yFa/2UwbixfTXmCSAL/83V9KglbYBHNX4u3HmsoR8uzDf8MQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=df5ujWdh; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=6xnPZLvR; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=df5ujWdh; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=6xnPZLvR
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97319406E6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792578392;
 x=1793183192; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=uTwot97+ovtXca1sIdyI+KmbakpAv38sqvSAkcXZ0jY=;
 b=df5ujWdhz3eEJixu9UDgyp9PGJUysY5NkRa6G+opahalmY2E+k4e99lBfjsIIagw00A9lE8TfdqRo
 ZNXZQ2BDAWB/yoWNxAqUNv3Fh6AAEcIfTAvaNOW1MciAUNk0Tc1aPtKss6EWzfWFWbUAYpgK9xtPYo
 pifpXwFGUr6XBRFPwjEvypj0hWPkFQ4vlbUeEUNdTTHYrKtq6ejVtsDPwyjFDepayJ/qkTpOE8fOFf
 SF/WTpDOuAVrUtnfQlf9V4CpedUxPpUMaNlzZhQtDHYqJ7waWv1FvLAlq5lTQRqtnOEZQN9bfCqVx8
 dXqTBbRThZ9tNg88kuhvPQYIJ9oBPJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792578392;
 x=1793183192; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=uTwot97+ovtXca1sIdyI+KmbakpAv38sqvSAkcXZ0jY=;
 b=6xnPZLvRVgZS+vBqDfBhcg3MlLhg9F5zW24vDtC35RTWz+UiofF1jCNOcudqnZu0aHImti7PcPsbH
 qNwrHupCw==
X-HalOne-ID: e1fa4570-cd39-11f1-8915-33fc7c51c1c8
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-7f8e-6877-ce5b-5167.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:7f8e:6877:ce5b:5167])
 by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id e1fa4570-cd39-11f1-8915-33fc7c51c1c8;
 Wed, 21 Oct 2026 10:26:31 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>, E Shattow <e@freeshell.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/5] lib: rsa: Accept .pem private key files as a fallback
Date: Wed, 21 Oct 2026 12:26:25 +0200
Message-ID: <20261021102626.264091-5-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow mkimage -k to use a .pem file when the RSA .key file is absent.
Keep .key precedence so existing key selection is preserved.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 lib/rsa/rsa-sign.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 3040b345fdd..ca9c6386fc2 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -176,10 +176,11 @@ static int rsa_get_pub_key(const char *keydir, const char *name,
 }
 
 /**
- * rsa_pem_get_priv_key() - read a private key from a .key file
+ * rsa_pem_get_priv_key() - read a PEM-encoded private key
  *
  * @keydir:	Directory containing the key
- * @name	Name of key file (will have a .key extension)
+ * @name	Name of key file (.key, falling back to .pem if absent)
+ * @keyfile:	Explicit key filename, used if keydir or name is absent
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
@@ -202,6 +203,10 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 		return -EINVAL;
 
 	f = fopen(path, "r");
+	if (!f && errno == ENOENT && keydir && name) {
+		snprintf(path, sizeof(path), "%s/%s.pem", keydir, name);
+		f = fopen(path, "r");
+	}
 	if (!f) {
 		ret = -errno;
 		fprintf(stderr, "Couldn't open RSA private key: '%s': %s\n",
-- 
2.53.0

