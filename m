Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41366606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fbCsLOcu;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ozRS+yb4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14318406C7;
	Sat, 24 Oct 2026 22:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5oTNMvlE4aO; Sat, 24 Oct 2026 22:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33078406E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881350;
	b=kvo+icKO7UbDmWY7vRs33VBObqa/Sg+ycWRooHRD5J4nivlnZqTRjhYuNWAB+sDnyxFf
	 vB0FZcuizkvJZoC+j+Shl67fAdXMwHqCBhTJ9iL0kHxB+xqUB6PenZeISlBHPllF1zpKQ
	 LpwaA5C2n+Hz5XZuIn9c8qswvBStAdIrxzfHoR0RXZCnNEU6HYT06Jlw5VcBERBdF+HaE
	 Pse+G7vrHzbbGIhGK+7evCVKYdea5k6BBk9XKoQpjMyDZOoZ4bR9ozdKNfUn8rQwsA2SL
	 y3fW5Xbv6zsp2/+fDyjs6CMu2D8N3G9OPqE1GH2Urjmr6yMt2RN1H6GYRfe6TO/P7eA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881350;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rnZhrzCOi+T5VWnovLkWw3cIVnV2ipZ7JwfNQ1odztM=;
	b=sI2i7V7yvRZjQT6MR7DVtg+5g5zmehKv2SR+vTYRXzl6TS+HowsSyfvQsJrvStWmsnzo
	 yGKk7Jv2HNV2RlJR1dcVX8orrFCDueX9rOArqqXdnROYeiKlaSTDazXfqSGyiBiAS0z4i
	 jMEO2w3M2I5K/Cs3ktNtKPFkjtQSfH55sdX16eb3Sr1/INGHHARl+2p93EGC0mMEfD7mq
	 OwOJSnPLMgLm1Ubj0OJCXr9FbC9Rc9GTD104tGdkW58g1bdHRWj68tYZtdKwiKh6IYlQP
	 ANumETdmL6xXh1PPi1RCkqPmhoXLK588VxLZLoododHvArSUd+SejWQvtP9j81+qDDQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881350;
	bh=rnZhrzCOi+T5VWnovLkWw3cIVnV2ipZ7JwfNQ1odztM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fbCsLOcuNIQbwU7pJWCOsizBAwqysc+r6Rt5P7aED1TKixNpCQWHwO/GB41cccVLD
	 SdC5yMoofBSLmltj53T6BNWysqJrALVTYRJc0Gnk5/EsVEfL5u+ri+g1XpOUYArxIj
	 NolFJvULEr+dwRSdkYZD2DjTstqROMqp2euVdzTokteIlFYBapM5bJhk/bgJAv/4ia
	 3B4VcKEEoyj8poqqAfVC0AL9Y7GsyzxloiyX5TXOCASTBOT2WhpAAAWIQsonte5ofz
	 RfWsLDOkhMX+vETauWnakow9oR6PQcsZHJTLVcXqmPWNKvpyBCUPI2o6StvQ9ugtlV
	 qhe2vvcEIdNoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33078406E0;
	Sat, 24 Oct 2026 22:35:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 916973D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83A6B40079
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2B3fBdN3qBFr for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0F7A24006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881344;
 b=MYhxrZb4SVQImwF2IamuE1Hwn1zngP2yg6FwakIvTXHOE3kSk5Cc1bSzLycNkhZyfwW9
 S5YP6kfciOmRnXg4lkrlCEbBExgkXMwwO8m0AF+JgCnuhPO+J/JpeHEONsfIDf+I4tebH
 hv8c283GMpUgOUwIZXq9qErDD9CunbatdHJzI3wSSJwKt+Deq29w3xKNUPiwrdPpjKldF
 uiUvDMpPmcJMDw0+ARALedj07uUzF+vNBRjCJTIXOSsp9BI8OwYiPdc/wAMVfUgfx6wud
 Zu/x41Tl+d+q8k4XmQcZZHjYCc8xQK1u015T+eY3h2OVJbXXjnTFSWwe/KS7HoPsAyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881344;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=rnZhrzCOi+T5VWnovLkWw3cIVnV2ipZ7JwfNQ1odztM=;
 b=tIRQYoxyASgRcH1H65vWsakEkQxoZoAQ5770H57mCnrtbFzwkd+VFxyYXq/4dKYdRjjU
 hUvEnZkObj6IuP84CWMMTquTZ/4AMi/ZaEMakk6d44cD6qRRLocJqW3tH1fviBHYmfMa6
 d3klsug6vsS1tdgbGsP4dD8oKqkZrGnPKpYHbLe2+26farra+UMkllUBI6EkkxCLAVNZU
 +k5y+VKsSdv5yQmuKwEc0FE0QpzxywQPsLB04+MmsKttQsnfdOmUozN2kKw/GAFDGJTcG
 6aWgLlZ8BIg4BkDSyd14ahYGNSoiUbSMzL2W63/ZmIhZ7RBDR/i3YPp39FlVKt4od8Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ozRS+yb4; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ozRS+yb4
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F7A24006B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:43 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-48e2d5a69c4so1089365fac.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881343; x=1793486143;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rnZhrzCOi+T5VWnovLkWw3cIVnV2ipZ7JwfNQ1odztM=;
 b=ozRS+yb4r+/1p197uAu5tV60uVbEvpAfcd7B6jWsf2NGJElgekaPJV5vuKHrX+3qVH
 IuNRRTD/2fxXlMV7b9mwLZ2zEnrEnxQROSPq0WatQDsJMEAQBK87msyBXqA43V6WH2Vn
 0CfFbCBsGJnEE5iSGmYJPxkTiuM5/NkZKtKSkI8JoeVW24HfWYQs7hXoPSGMHotQBfvF
 1r6b/rvnFJRweS8Oj5739P5boVMnaeWZ+sehGVx5p5QexzquOXSowzbPH16rOmr5oAT+
 KYbrdEROBdADKCApnaYo260C25Ezi+JuPqoNvSM+yNPk78h5w7yh6rn1jp2WZ5+PPHRU
 3AYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881343; x=1793486143;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rnZhrzCOi+T5VWnovLkWw3cIVnV2ipZ7JwfNQ1odztM=;
 b=j6Ji9utriXsdUl/7Hvp6a7i9KTLGl+XJv+zo6m9FbFQYz1O/Q1QJIJfsrcx+oJvyfI
 zVUTEmZKU/nbY7iG6YXIRtz0QoNDwEPGicjCwD8Fmku6Bhfg44aSKLd+UrI5umtlBWMp
 5lb+CoilXv4VIif+kJhzr7XwnJp1hEInbWr36ifWrnfAg3p+qrBZH2tM2hATcPE6DaDl
 6FfgZacuofvEMtNk35dr1tj343DGgq8cYqtVM/L/6jCeZyZmirYXBFf68uZsWlVamqGU
 3O4kp/k+CcIscCmOV0dZSbAB6agazA2e2wJZbT47kQdXIbZRX2UUYf3XIFIIwFkP9wvl
 /RLw==
X-Gm-Message-State: AFq9FYIIjFnJdMKw8hoXtf16My+D4Bfgs0+dbYUPxina4QOxmGyb2bQg
 u4shvg2kWM8LedkBZIg+2DrQtroUuke3azcv63CLWOkk+AYPWE5qLEws
X-Gm-Gg: AYBFou05GCA8Cov4K5AR2ADKE/0ldVKWU0/9j8h+S42AFmQSM9sd2+04E8yFexiVHEH
 UddX6USjg2/AJZ006epsoQtHzpdsbj5CQPL7zLxjoBYN/RhYjjjZuIKRm8YAzXeuP1wYkVBhHQI
 IdRarR6R8SRvgMiJBs4IU4ttMS1WQ+UFVTCHm47OGqgWRlvHeezQ6h2ZVy3+eDuRebOGEBpziMu
 Vb9L6WkWe9X4RoLRgP7uNc6Yy28RBtj8zNpl3SMCFczeFc5naei/q+9mVecoigX8zt8vqbI3fR7
 ilmb1DkSsl94Pun87PtVcNdKTGHfTcaxvNo4z5+2h5S3N4LCwGOHPn9jMpY/1AEojdfZ+JSVzRd
 gWcW/f/5unphXJbvTQnlZ96Dqni3QnLDe7EElHJwTKwHCIoshJy5ytRdxmUa5sgn/0c+U+Ez5SW
 /cFJ/+dZJdbPDjacDtGMp//u+SXkAtO3bEkfQ8NuFHNH3nvz4IEc1i9MDsuwRnp8nCfjwvgt09F
 9m5/115r0wcUuPRFhe+3g4IdrAD+rE82avlqPtqGxkL8bhtochiYsg1HJ7wDfQMd1AqtXcN/oBh
 aqpSM9K7a7O8iT1HzBVY7xjizyvtooKMgfcvL322eLzgpvWzbDmoC5jUVepGxv0EZ1CInvk+xTC
 KIHVZ34IvTMCJCX3FdPJwBBG2euSGaEKrsWNTtZYsbiQvEX6J3OqMZ/WNEZ9frn+Wjz0RDzPXSf
 vXBIs=
X-Received: by 2002:a05:6870:c22f:b0:49e:f:1e42 with SMTP id
 586e51a60fabf-4a83f640ca1mr1603048fac.60.1792881342563; 
 Sat, 24 Oct 2026 15:35:42 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:35:03 -0600
Subject: [PATCH v2 16/16] net: lwip: retry TFTP after matching ICMP
 port-unreachable errors
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-16-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Treat a matching ICMP port-unreachable error as a retryable TFTP
failure. Validate the checksum and quoted IPv4/UDP tuple, including
the negotiated transfer port, before retiring the transfer.

Handle IPv4 options and chained pbufs. Ignore unrelated, malformed
and stale errors, and keep recovery independent of optional ICMP
diagnostic messages.

Cover request, transfer and receive-server errors, rejected tuples
and fragmented pbuf storage in sandbox.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                                       |   1 +
 lib/lwip/lwip/src/apps/tftp/tftp.c                |  27 +++
 lib/lwip/lwip/src/core/ipv4/icmp.c                |  16 +-
 lib/lwip/lwip/src/include/lwip/apps/tftp_common.h |   3 +
 lib/lwip/u-boot/arch/cc.h                         |   2 +-
 net/lwip/Makefile                                 |   2 +-
 net/lwip/icmp_unreach.c                           |  44 ++++-
 net/lwip/tftp.c                                   |   1 +
 test/dm/lwip_tftp.c                               |  58 +++++++
 test/dm/tftp.c                                    | 194 ++++++++++++++++++++++
 10 files changed, 340 insertions(+), 8 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c72b00325d9..93ad6e7a4bb 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2312,6 +2312,7 @@ config CMD_SNTP
 config CMD_TFTPBOOT
 	bool "tftp"
 	select PROT_UDP_LWIP if NET_LWIP
+	select PROT_ICMP_LWIP if NET_LWIP
 	default y
 	help
 	  tftpboot - load file via network using TFTP protocol
diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index e742273bee1..878ae18043b 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -175,6 +175,33 @@ transfer_timed_out(void)
   close_handle();
 }
 
+/**
+ * Fail the active transfer on a matching ICMP port-unreachable error.
+ * The caller must validate the ICMP packet and the quoted local IP address.
+ *
+ * @param addr Quoted destination IP address
+ * @param local_port Quoted UDP source port, in host byte order
+ * @param remote_port Quoted UDP destination port, in host byte order
+ */
+void
+tftp_handle_port_unreachable(const ip_addr_t *addr, u16_t local_port,
+                             u16_t remote_port)
+{
+  static const char msg[] = "Port unreachable";
+  u16_t port = tftp_state.port ? tftp_state.port : tftp_req.port;
+
+  if ((tftp_state.handle == NULL) || (tftp_state.upcb == NULL) ||
+      !port || (remote_port != port) ||
+      (local_port != tftp_state.upcb->local_port) ||
+      !ip_addr_eq(addr, &tftp_state.addr)) {
+    return;
+  }
+
+  tftp_state.ctx->error(tftp_state.handle, TFTP_ERROR_PORT_UNREACHABLE,
+                        msg, sizeof(msg) - 1);
+  close_handle();
+}
+
 static struct pbuf*
 init_packet(u16_t opcode, u16_t extra, size_t size)
 {
diff --git a/lib/lwip/lwip/src/core/ipv4/icmp.c b/lib/lwip/lwip/src/core/ipv4/icmp.c
index 6d588349c4a..ea3e06403c7 100644
--- a/lib/lwip/lwip/src/core/ipv4/icmp.c
+++ b/lib/lwip/lwip/src/core/ipv4/icmp.c
@@ -258,13 +258,23 @@ icmp_input(struct pbuf *p, struct netif *inp)
       if (type == ICMP_DUR) {
         MIB2_STATS_INC(mib2.icmpindestunreachs);
 #ifdef ICMP_DEST_UNREACH_CB
+        /* Unlike echo requests, errors have not been checked above. */
+#if CHECKSUM_CHECK_ICMP
+        IF__NETIF_CHECKSUM_ENABLED(inp, NETIF_CHECKSUM_CHECK_ICMP) {
+          if (inet_chksum_pbuf(p) != 0) {
+            ICMP_STATS_INC(icmp.chkerr);
+            goto icmperr;
+          }
+        }
+#endif
         /*
          * The callback receives the IP packet (not the ICMP message) so that
          * it can extract the source address for example
          */
-        pbuf_add_header(p, IP_HLEN);
-        ICMP_DEST_UNREACH_CB(code, p);
-        pbuf_remove_header(p, IP_HLEN);
+        if (pbuf_add_header(p, hlen) == 0) {
+          ICMP_DEST_UNREACH_CB(code, p);
+          pbuf_remove_header(p, hlen);
+        }
 #endif
       } else if (type == ICMP_TE) {
         MIB2_STATS_INC(mib2.icmpintimeexcds);
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h
index 4445f551166..08ceb2f6b96 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h
@@ -52,6 +52,7 @@ extern "C" {
 
 /* Negative callback errors are not TFTP wire error codes. */
 enum tftp_error {
+  TFTP_ERROR_PORT_UNREACHABLE = -3,
   TFTP_ERROR_LOCAL            = -2,
   TFTP_ERROR_TIMEOUT          = -1,
   TFTP_ERROR_FILE_NOT_FOUND    = 1,
@@ -114,6 +115,8 @@ struct tftp_context {
 
 err_t tftp_init_common(u8_t mode, const struct tftp_context* ctx);
 err_t tftp_set_timeout(u32_t timeout_msecs, u32_t max_retries);
+void tftp_handle_port_unreachable(const ip_addr_t *addr, u16_t local_port,
+                                  u16_t remote_port);
 void tftp_cleanup(void);
 
 #ifdef __cplusplus
diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
index 849c79c5a8d..8af27f7eff5 100644
--- a/lib/lwip/u-boot/arch/cc.h
+++ b/lib/lwip/u-boot/arch/cc.h
@@ -57,7 +57,7 @@ static inline const char *sntp_format_time(time_t t)
 
 #define sntp_format_time sntp_format_time
 
-#ifdef CONFIG_LWIP_ICMP_SHOW_UNREACH
+#ifdef CONFIG_PROT_ICMP_LWIP
 struct pbuf;
 void net_lwip_icmp_dest_unreach(int code, struct pbuf *p);
 
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index b017c32629c..d010a62fa65 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -5,7 +5,7 @@ ifneq ($(filter y,$(CONFIG_CMD_BOOTP) $(CONFIG_CMD_DHCP)),)
 obj-y += dhcp.o
 endif
 obj-$(CONFIG_DNS) += dns.o
-obj-$(CONFIG_LWIP_ICMP_SHOW_UNREACH) += icmp_unreach.o
+obj-$(CONFIG_PROT_ICMP_LWIP) += icmp_unreach.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
diff --git a/net/lwip/icmp_unreach.c b/net/lwip/icmp_unreach.c
index 9e8a05f5717..05749664c46 100644
--- a/net/lwip/icmp_unreach.c
+++ b/net/lwip/icmp_unreach.c
@@ -1,10 +1,44 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright (C) 2025 Linaro Ltd. */
 
+#include <linux/kconfig.h>
+#include <lwip/apps/tftp_common.h>
 #include <lwip/icmp.h>
+#include <lwip/ip.h>
 #include <lwip/ip4_addr.h>
 #include <lwip/pbuf.h>
 #include <lwip/prot/ip4.h>
+#include <lwip/prot/udp.h>
+
+static void tftp_port_unreachable(struct pbuf *p, u16 offset)
+{
+	struct ip_hdr quoted;
+	struct udp_hdr udp;
+	ip4_addr_t local;
+	ip_addr_t peer;
+	u16 hlen;
+
+	/* RFC 792 quotes the original IP header and at least eight data bytes.
+	 * They may cross pbuf boundaries, and IP options change the UDP offset.
+	 */
+	if (pbuf_copy_partial(p, &quoted, sizeof(quoted), offset) != sizeof(quoted))
+		return;
+	hlen = IPH_HL_BYTES(&quoted);
+	if (IPH_V(&quoted) != 4 || hlen < IP_HLEN ||
+	    IPH_PROTO(&quoted) != IP_PROTO_UDP ||
+	    (lwip_ntohs(IPH_OFFSET(&quoted)) & IP_OFFMASK) ||
+	    lwip_ntohs(IPH_LEN(&quoted)) < hlen + UDP_HLEN)
+		return;
+	if (pbuf_copy_partial(p, &udp, sizeof(udp), offset + hlen) != sizeof(udp) ||
+	    lwip_ntohs(udp.len) < UDP_HLEN)
+		return;
+	ip4_addr_copy(local, quoted.src);
+	if (!ip4_addr_cmp(&local, netif_ip4_addr(ip_current_netif())) ||
+	    !ip4_addr_cmp(&local, ip4_current_dest_addr()))
+		return;
+	ip_addr_copy_from_ip4(peer, quoted.dest);
+	tftp_handle_port_unreachable(&peer, lwip_ntohs(udp.src), lwip_ntohs(udp.dest));
+}
 
 static const char *code_to_str(int code)
 {
@@ -32,7 +66,11 @@ void net_lwip_icmp_dest_unreach(int code, struct pbuf *p)
 	struct ip_hdr *iphdr = (struct ip_hdr *)p->payload;
 	ip4_addr_t src;
 
-	ip4_addr_copy(src, iphdr->src);
-	printf("ICMP destination unreachable (%s) from %s\n",
-	       code_to_str(code), ip4addr_ntoa(&src));
+	if (IS_ENABLED(CONFIG_LWIP_ICMP_SHOW_UNREACH)) {
+		ip4_addr_copy(src, iphdr->src);
+		printf("ICMP destination unreachable (%s) from %s\n",
+		       code_to_str(code), ip4addr_ntoa(&src));
+	}
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT) && code == ICMP_DUR_PORT)
+		tftp_port_unreachable(p, IPH_HL_BYTES(iphdr) + sizeof(struct icmp_hdr));
 }
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 21c5e885a92..2e1ce0969a4 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -257,6 +257,7 @@ static void tftp_error(void *handle, int err, const char *msg, int size)
 	 * Local validation and memory-write failures must not be retried.
 	 */
 	ctx->retry = err == TFTP_ERROR_TIMEOUT ||
+		err == TFTP_ERROR_PORT_UNREACHABLE ||
 		(err >= 0 && err != TFTP_ERROR_FILE_NOT_FOUND &&
 		 err != TFTP_ERROR_ACCESS_VIOLATION);
 	memset(message, 0, sizeof(message));
diff --git a/test/dm/lwip_tftp.c b/test/dm/lwip_tftp.c
index 66f43e9c553..847afe4a8f9 100644
--- a/test/dm/lwip_tftp.c
+++ b/test/dm/lwip_tftp.c
@@ -13,6 +13,7 @@
 #include <dm/test.h>
 #include <lwip/apps/tftp_client.h>
 #include <lwip/apps/tftp_server.h>
+#include <lwip/icmp.h>
 #include <lwip/timeouts.h>
 #include <lwip/udp.h>
 #include <test/ut.h>
@@ -179,6 +180,61 @@ static int tftp_test_start(struct tftp_protocol_test *test, bool put)
 	return tftp_test_start_window(test, put, 1);
 }
 
+static int tftp_test_icmp_chain(struct unit_test_state *uts,
+				struct tftp_protocol_test *test,
+				struct netif *netif)
+{
+	u8 packet[IP_HDR_SIZE + 8 + IP_UDP_HDR_SIZE] = {};
+	struct ip_udp_hdr *ip = (void *)packet;
+	struct icmp_hdr *icmp = (void *)(packet + IP_HDR_SIZE);
+	struct ip_udp_hdr *quoted = (void *)(icmp + 1);
+	struct pbuf *p, *tail;
+	unsigned int split;
+
+	/* Split in both the quoted IP and UDP headers, at odd offsets too. */
+	for (split = IP_HDR_SIZE + 8; split < sizeof(packet); split++) {
+		ut_assertok(tftp_test_start(test, false));
+		memset(packet, 0, sizeof(packet));
+		ip->ip_hl_v = 0x45;
+		ip->ip_len = htons(sizeof(packet));
+		ip->ip_ttl = 64;
+		ip->ip_p = IPPROTO_ICMP;
+		ip->ip_src.s_addr = ip4_addr_get_u32(ip_2_ip4(&test->server));
+		ip->ip_dst.s_addr = ip4_addr_get_u32(netif_ip4_addr(netif));
+		ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+		icmp->type = ICMP_DUR;
+		icmp->code = ICMP_DUR_PORT;
+		quoted->ip_hl_v = 0x45;
+		quoted->ip_len = htons(IP_UDP_HDR_SIZE);
+		quoted->ip_ttl = 64;
+		quoted->ip_p = IPPROTO_UDP;
+		quoted->ip_src = ip->ip_dst;
+		quoted->ip_dst = ip->ip_src;
+		quoted->udp_src = htons(test->port);
+		quoted->udp_dst = htons(69);
+		quoted->udp_len = htons(UDP_HDR_SIZE);
+		quoted->ip_sum = compute_ip_checksum(quoted, IP_HDR_SIZE);
+		icmp->chksum = compute_ip_checksum(icmp, sizeof(packet) - IP_HDR_SIZE);
+		p = pbuf_alloc(PBUF_RAW, split, PBUF_RAM);
+		ut_assertnonnull(p);
+		tail = pbuf_alloc(PBUF_RAW, sizeof(packet) - split, PBUF_RAM);
+		if (!tail) {
+			pbuf_free(p);
+			return -ENOMEM;
+		}
+		pbuf_take(p, packet, split);
+		pbuf_take(tail, packet + split, sizeof(packet) - split);
+		pbuf_cat(p, tail);
+		ut_asserteq(ERR_OK, ip4_input(p, netif));
+		ut_asserteq(TFTP_ERROR_PORT_UNREACHABLE, test->error);
+		ut_asserteq(1, test->closed);
+		/* A repeated error after close must not call the old handle. */
+		tftp_handle_port_unreachable(&test->server, test->port, 69);
+		ut_asserteq(1, test->closed);
+	}
+	return 0;
+}
+
 static int tftp_test_oack(struct unit_test_state *uts,
 			  struct tftp_protocol_test *test)
 {
@@ -937,6 +993,8 @@ static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 		ret = tftp_test_server_retries(uts, &test);
 	if (!ret)
 		ret = tftp_test_windows(uts, &test);
+	if (!ret)
+		ret = tftp_test_icmp_chain(uts, &test, net.netif);
 #if IS_ENABLED(CONFIG_CMD_TFTPSRV)
 	if (!ret)
 		ret = tftp_test_server_command(uts, &test);
diff --git a/test/dm/tftp.c b/test/dm/tftp.c
index e5589b19f27..8e9d3fd3619 100644
--- a/test/dm/tftp.c
+++ b/test/dm/tftp.c
@@ -16,6 +16,8 @@
 #include <dm/test.h>
 #include <test/ut.h>
 #if IS_ENABLED(CONFIG_NET_LWIP)
+#include <lwip/icmp.h>
+#include <lwip/prot/udp.h>
 #include <lwip/timeouts.h>
 #include <lwip/udp.h>
 #endif
@@ -31,6 +33,24 @@ enum tftp_test_probe {
 	TFTP_PROBE_OACK,
 };
 
+enum tftp_test_icmp {
+	TFTP_ICMP_NONE,
+	TFTP_ICMP_REQUEST,
+	TFTP_ICMP_TRANSFER,
+	TFTP_ICMP_OPTIONS,
+	TFTP_ICMP_CHECKSUM,
+	TFTP_ICMP_SHORT,
+	TFTP_ICMP_LOCAL_IP,
+	TFTP_ICMP_PEER_IP,
+	TFTP_ICMP_LOCAL_PORT,
+	TFTP_ICMP_PEER_PORT,
+	TFTP_ICMP_FRAGMENT,
+	TFTP_ICMP_IHL,
+	TFTP_ICMP_OTHER_CODE,
+	TFTP_ICMP_OLD_PORT,
+	TFTP_ICMP_COUNT,
+};
+
 struct tftp_test_context {
 	bool fail;
 	bool empty;
@@ -67,9 +87,93 @@ struct tftp_test_context {
 	unsigned int failed_attempts;
 	unsigned int server_case;
 	int server_error;
+	enum tftp_test_icmp icmp;
+	bool icmp_sent;
 	unsigned int timeout_ticks;
 };
 
+#if IS_ENABLED(CONFIG_NET_LWIP)
+/*
+ * Queue an ICMP error quoting this outgoing datagram, not an artificial
+ * TFTP callback. Return one when it replaces the normal server response.
+ */
+static int tftp_test_icmp_reply(struct udevice *dev, struct ethernet_hdr *eth,
+				struct ip_udp_hdr *ip)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct tftp_test_context *ctx = priv->priv;
+	unsigned int hlen = IP_HDR_SIZE + (ctx->icmp == TFTP_ICMP_OPTIONS ? 4 : 0);
+	unsigned int icmp_len = 8 + hlen + UDP_HDR_SIZE;
+	struct ethernet_hdr *reply_eth;
+	struct ip_udp_hdr *reply_ip, *quoted;
+	struct icmp_hdr *icmp;
+	struct udp_hdr *udp;
+
+	if (ctx->icmp_sent)
+		return 0;
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+	ctx->icmp_sent = true;
+	reply_eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memcpy(reply_eth->et_dest, eth->et_src, ARP_HLEN);
+	memcpy(reply_eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	reply_eth->et_protlen = htons(PROT_IP);
+	reply_ip = (void *)(reply_eth + 1);
+	memset(reply_ip, 0, hlen + icmp_len);
+	reply_ip->ip_hl_v = 0x40 | (hlen / 4);
+	reply_ip->ip_ttl = 64;
+	reply_ip->ip_p = IPPROTO_ICMP;
+	reply_ip->ip_src = ip->ip_dst;
+	reply_ip->ip_dst = ip->ip_src;
+	icmp = (void *)((u8 *)reply_ip + hlen);
+	icmp->type = ICMP_DUR;
+	icmp->code = ctx->icmp == TFTP_ICMP_OTHER_CODE ? ICMP_DUR_HOST : ICMP_DUR_PORT;
+	quoted = (void *)(icmp + 1);
+	memcpy(quoted, ip, IP_HDR_SIZE);
+	quoted->ip_hl_v = 0x40 | (hlen / 4);
+	quoted->ip_len = htons(ntohs(ip->ip_len) + hlen - IP_HDR_SIZE);
+	udp = (void *)((u8 *)quoted + hlen);
+	memcpy(udp, &ip->udp_src, UDP_HDR_SIZE);
+	switch (ctx->icmp) {
+	case TFTP_ICMP_SHORT:
+		icmp_len--;
+		break;
+	case TFTP_ICMP_LOCAL_IP:
+		quoted->ip_src.s_addr ^= htonl(1);
+		break;
+	case TFTP_ICMP_PEER_IP:
+		quoted->ip_dst.s_addr ^= htonl(1);
+		break;
+	case TFTP_ICMP_LOCAL_PORT:
+		udp->src ^= htons(1);
+		break;
+	case TFTP_ICMP_PEER_PORT:
+		udp->dest ^= htons(1);
+		break;
+	case TFTP_ICMP_FRAGMENT:
+		quoted->ip_off = htons(1);
+		break;
+	case TFTP_ICMP_IHL:
+		quoted->ip_hl_v = 0x44;
+		break;
+	case TFTP_ICMP_OLD_PORT:
+		udp->dest = htons(69);
+		break;
+	default:
+		break;
+	}
+	quoted->ip_sum = 0;
+	quoted->ip_sum = compute_ip_checksum(quoted, hlen);
+	icmp->chksum = compute_ip_checksum(icmp, icmp_len);
+	if (ctx->icmp == TFTP_ICMP_CHECKSUM)
+		icmp->chksum ^= htons(1);
+	reply_ip->ip_len = htons(hlen + icmp_len);
+	reply_ip->ip_sum = compute_ip_checksum(reply_ip, hlen);
+	priv->recv_packet_length[priv->recv_packets++] = ETHER_HDR_SIZE + hlen + icmp_len;
+	return ctx->icmp <= TFTP_ICMP_OPTIONS;
+}
+#endif
+
 static ulong tftp_test_option(const char *packet, size_t len, const char *option)
 {
 	const char *end = packet + len;
@@ -153,6 +257,14 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 	opcode = get_unaligned_be16(ip + 1);
 	if (opcode == 4 && ctx->probe == TFTP_PROBE_NONE) {
 		ctx->server_acks++;
+#if IS_ENABLED(CONFIG_NET_LWIP)
+		if (ctx->icmp == TFTP_ICMP_TRANSFER) {
+			int ret = tftp_test_icmp_reply(dev, eth, ip);
+
+			if (ret < 0)
+				return ret;
+		}
+#endif
 		return 0;
 	}
 	if (opcode == 4 && ctx->probe >= TFTP_PROBE_DATA) {
@@ -197,6 +309,15 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 				"timeout\0" "1" : "timeout\0" "5";
 			data_len = 10;
 		}
+#if IS_ENABLED(CONFIG_NET_LWIP)
+		if (ctx->icmp && ctx->icmp != TFTP_ICMP_TRANSFER &&
+		    ctx->icmp != TFTP_ICMP_OLD_PORT) {
+			int ret = tftp_test_icmp_reply(dev, eth, ip);
+
+			if (ret)
+				return ret < 0 ? ret : 0;
+		}
+#endif
 		if (ctx->requests <= ctx->drop_requests)
 			return 0;
 		if (ctx->error_requests)
@@ -214,6 +335,14 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 		reply_opcode = 4;
 		block = get_unaligned_be16((u8 *)(ip + 1) + 2);
 		data_len = 0;
+#if IS_ENABLED(CONFIG_NET_LWIP)
+		if (ctx->icmp == TFTP_ICMP_TRANSFER || ctx->icmp == TFTP_ICMP_OLD_PORT) {
+			int ret = tftp_test_icmp_reply(dev, eth, ip);
+
+			if (ret)
+				return ret < 0 ? ret : 0;
+		}
+#endif
 		if (ctx->partial && ctx->requests == 1)
 			return 0;
 	} else {
@@ -474,6 +603,60 @@ static int tftp_test_retry_command(struct tftp_test_context *ctx, bool put)
 	return ret;
 }
 
+static int tftp_test_icmp_errors(struct unit_test_state *uts,
+				 struct tftp_test_context *ctx)
+{
+	struct net_lwip_ctx shared = {};
+	int i, put, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("netretry", "once"));
+	for (put = 0; put <= IS_ENABLED(CONFIG_CMD_TFTPPUT); put++) {
+		for (i = TFTP_ICMP_REQUEST; i < TFTP_ICMP_COUNT; i++) {
+			if (!put && i == TFTP_ICMP_OLD_PORT)
+				continue;
+			memset(ctx, 0, sizeof(*ctx));
+			ctx->icmp = i;
+			ctx->partial = !put && i == TFTP_ICMP_TRANSFER;
+			/* A broken ICMP path must time out, not hang this test. */
+			sys_timeout(100, tftp_test_tick, ctx);
+			ret = run_command(put ? "tftpput 2000000 20 file" :
+					  "tftpboot 2000000 file", 0);
+			sys_untimeout(tftp_test_tick, ctx);
+			ut_assertok(ret);
+			ut_assert(ctx->icmp_sent);
+			ut_asserteq(i <= TFTP_ICMP_OPTIONS ? 2 : 1, ctx->requests);
+			ut_asserteq(0, ctx->timeout_ticks);
+			ut_asserteq(put ? 32 : sizeof(tftp_test_data), net_boot_file_size);
+		}
+	}
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->icmp = TFTP_ICMP_REQUEST;
+	ut_assertok(env_set("netretry", "no"));
+	sys_timeout(100, tftp_test_tick, ctx);
+	ret = run_command("tftpboot 2000000 file", 0);
+	sys_untimeout(tftp_test_tick, ctx);
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_asserteq(1, ctx->requests);
+	ut_asserteq(0, ctx->timeout_ticks);
+	ut_asserteq(0, net_boot_file_size);
+
+	/* An ICMP error cannot restart a runtime held by another client. */
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->icmp = TFTP_ICMP_REQUEST;
+	ut_assertok(env_set("netretry", "once"));
+	ut_assertok(net_lwip_start(&shared, NET_LWIP_ADDR_ENV_STRICT));
+	ret = run_command("tftpboot 2000000 file", 0);
+	i = net_lwip_poll();
+	net_lwip_stop(&shared);
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_assert(i >= 0);
+	ut_asserteq(1, ctx->requests);
+	ut_assertok(env_set("netretry", "no"));
+	return 0;
+}
+
 static int tftp_test_restarts(struct unit_test_state *uts,
 			      struct tftp_test_context *ctx)
 {
@@ -717,6 +900,16 @@ static int tftp_test_server_policy(struct unit_test_state *uts,
 	ut_assert(i >= 0);
 	ut_asserteq(1, ctx->server_attempt);
 
+	/* A matching error for ACK(0) restarts before the transfer times out. */
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->server_case = 1;
+	ctx->failed_attempts = 1;
+	ctx->icmp = TFTP_ICMP_TRANSFER;
+	ut_assertok(tftp_test_server_run(ctx));
+	ut_assertok(ctx->server_error);
+	ut_assert(ctx->icmp_sent);
+	ut_asserteq(2, ctx->server_attempt);
+	ut_asserteq(3, ctx->server_ticks);
 	ut_assertok(env_set("tftptimeout", NULL));
 	ut_assertok(env_set("tftptimeoutcountmax", NULL));
 	ut_assertok(env_set("netretry", "no"));
@@ -875,6 +1068,7 @@ static int tftp_test_download(struct unit_test_state *uts,
 	ut_assertok(tftp_test_protected_autostart(uts, ctx));
 
 #if IS_ENABLED(CONFIG_NET_LWIP)
+	ut_assertok(tftp_test_icmp_errors(uts, ctx));
 	if (IS_ENABLED(CONFIG_NET_TFTP_VARS))
 		ut_assertok(tftp_test_restarts(uts, ctx));
 	ut_assertok(tftp_test_options(uts, ctx));

-- 
2.53.0

