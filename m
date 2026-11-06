Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E9606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T9jxF27v;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=acQUbw2T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A8AB81488;
	Fri,  6 Nov 2026 18:23:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YlWC4AxRlSlI; Fri,  6 Nov 2026 18:23:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F9A38146D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989387;
	b=BSbKSKoUB8Bf2OAb8ot7f4YKu60XfMCLSIpZSa1xN5HhCAC4q4TsYCafBo5jIgFwx3jP
	 ypf1foyxezgbR1z6zzgNi1PFNOjAhQnOuVwFCcXQ6v+BpVQoQQtWV2Q71fDwlyW6V2tTT
	 xgzKXIbE9M9naaPV4vXAl4OoK+wu19jy5Jm6sVaUbPjgIvzsVEY6KkujyH5e2xEqtO5GP
	 uqsHsd+Y5fY7rO70Nka6rvkbfXBby8FeXev4zo7uufY4s/MtpqIHvrbnE0p2A8DuBuA5Y
	 Nj2ArAndDbWjIM3pj/eM7aEoH5gO5H9kU6YO13MZT1DIWLBE32btcSnK3hBmQtflK/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XQBVw8+9rBR+5K7VhwBSX+zVUQiOKx35c9QFDOLFc7E=;
	b=RZ1RUxwr3eNLPcYPuVOECcy23xKok1fueGxjxInZLrY82MEVPqLEoDVTQyMARQjTAu3Q
	 58xeXul9ITbDm7Euq3nQPWZVglYkDoQKq2fTm0jVweU18r47EGJbswwsK7r9FvRs0KxKd
	 nT6XjDDU7ELo6wQVhbjODHOc36jQQmpU+INxaLVhDLwcuaNOcEFeRp7YxqE/jM3hZNtek
	 e4LmIMeo2y7n6IrHUwEDMGROlNJMejVVBhKYc3/Qfs0jruLfD7Yqyz8fRyzQMIch8BiGN
	 D/MkZ7s7g0wyKXPtuVbe1MOVuOTVO4vW2E5ijZulpy/d5RMPsIqv9+euOjzYfGJJMmw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989387;
	bh=XQBVw8+9rBR+5K7VhwBSX+zVUQiOKx35c9QFDOLFc7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T9jxF27vvQWQO/X5+6GCbugyQf6YDQH51L0Z6SE/UJm80Lj9RQVaybQdebU5JsjLM
	 ROWfknH5fNUuh8gKdGnpPS38+YTpPZvAxBcoy/GyPla545zwsp75sGzaG77V5HdtLs
	 m2wMz4FUWCug8jKx55i8OKk427phq6m4VKtpCfV6Fs2exi5JDhPrJdvuenTCHdIJFy
	 +eqikls35HsMqGJlNdbg/Idv88tkRrKs4K4WVCsN34Koy1UFKvhg2CKYjnxuNCqegT
	 PNFl3FJrN4RK3skOo6YIjEep4g6X/sXdtWF1l2x5HDLzPq5JXxa46niKyyoTdNoao+
	 Z+3zEaU2yZZGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F9A38146D;
	Fri,  6 Nov 2026 18:23:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 02ECB31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC4CC606EB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7oz61pyrSiT for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:10:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32AE0606BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=acQUbw2T
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32AE0606BB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:14 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8a06cc097c7so621205b3a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793985014; x=1794589814;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XQBVw8+9rBR+5K7VhwBSX+zVUQiOKx35c9QFDOLFc7E=;
 b=acQUbw2T5Q+vUIr7s4p+sB3VTfz6o0HSPL9OZTuEBpaAMaEhux8I0WNW9tmrZ04n5R
 FQdw6j+Z9f/3zUy17Qm9fi6iwwjWCEeIi9EvMjyCSGBJxSxkRDWe+i0Wrmu3TKPUI7g0
 3xJWM7tbCykc47InVxP8tqlQJ0HxbOh/peHdP/JU2VXtukhlvcJQyjQAFDDYOO5sqJYj
 x5QNRKUyqqepEwrmuIFBh1xvf9XZnbMQbmHqHSDUlVinUiou53XmIyCZjEl921DQ4g25
 sH9oP2OU4GA0hB/eOC9EEdWWXI/zKvpNqk/QPjpqTfXLhGLLj83+U8M2rftvaKuU/YF1
 mh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793985014; x=1794589814;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XQBVw8+9rBR+5K7VhwBSX+zVUQiOKx35c9QFDOLFc7E=;
 b=d0Vt50ssbomElBcwEOGRm5dmUF7sQg3PxViwCDXTegujkq9V1aX9bH8IgxVYkzrNho
 Q4GEB+Tsxi8ox7PrrhO9Em7+k5U3p7BRivj9LgFeZmHX5/I111GLF1Z6cxTL8E3RtwQg
 CyWI4myOLE5Cj8mfwIaN/w4jusczkirQcH0rmq0TpYQOJDLm0hdZNVsCOL4lVHSzyAuh
 Q/9hKbo9PFGGf560cN84AunK6CgeSxt4c22jfRwlR5DXZ06dRjws5N/xIGHzZuWFy11L
 Mwod1GBY8rq+r9S3JwO2ZOTrIuJCw3BFzKQFtEx0tdtNBeQyO4hkB/ermF4yxVS4gAkT
 KHWQ==
X-Gm-Message-State: APuU4Z8QDpcSn7kWMhTGMrOfQeDz6jtYikVeHyXsHS4TarSDEwFbe7Sj
 S9Za5AsMvKwWQXQ31uI6c595yHrsUuOlOUUf5N5PlRgSL1Q3K/DElUtdhgnHsLJ4YdQ=
X-Gm-Gg: AYBFou3BXSJdPs78Zwk/rUnYZjpbDn4EBcOVbCsAktlj3QnXNO4cwSKFHVu3P4oEhBq
 uC1DucERBxyze5LhllrqLM/LEN2JNbc7jiNcsdAfOxDFi6PUfLvYkybAir/erf0b0jhWgX2wrUl
 qijTjAxgl0AT7l+4Nemjrc/Wc0PBDoLhkiHgZmI9LGILT5TqQC0fYcIBM2ee7AgCRwClNlEaig/
 uQAZvQ79fM3GXI75eI3NZWamRmFJS5uGdt60niHtJmoYK6M2DEcgNOZjOaiMCSca3OhA4zyBeyS
 rLHRQ4psJmyJqaXJ8WQsV9n4lO/+dA4wTytvbPO26CelyXUfReNrFBKN6IH15cEAqaamGnwsetk
 hziUE6CxbvNdR0J8k0G37vZ3FloiBROvH1FT94vn47ksC9D0877CRQ7NJgvXe+gMpYHXRFNkfBA
 ESWBKa4vbW4zLjYmQNEfPIAR4ODNnHAtdm0hmEbXbJwrKEJ2PISh4J7X6BeJHnAd4RNIblLW9fj
 uU6j9Jdd9hnBtPyfuVxuZa/Nq1fkPtbo7QUUHSbSMd7wwG7ezRUExUNi0PjoX5i/usi3D5xTEbM
 QFru4q4nTs8DwhrcrIQuAsyYKB4lt1125wc3u8yLv9adaN5sUM+IaLPxuF/9t7J1P2c/eWzusFM
 K
X-Received: by 2002:a05:6a20:2d23:b0:3dd:85a9:55ab with SMTP id
 adf61e73a8af0-3ebb29cea7bmr3563479637.36.1793985014327; 
 Fri, 06 Nov 2026 09:10:14 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b359dd36d3sm767461b3a.37.2026.11.06.09.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:10:13 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Date: Fri, 06 Nov 2026 10:09:06 -0700
Subject: [PATCH v4 3/4] net: zynq_gem: free buffers in .remove
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-zynq-gem-remove-leak-v4-3-1995c70f540f@t0.technology>
References: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
In-Reply-To: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, James Hilliard <james.hilliard1@gmail.com>, 
 Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793984944; l=748;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=9dn3x6SDVFKjB6DpVPwAFbgWt/nkNM4G4IBda5mrcf4=;
 b=9ujK30CBAl0/YIMiPFd3Hkdg9aLFoXQKd47X5tK0BNgKI3tkLjqHsnpJwgsECQEC4cnCgU/pG
 BEVYJDjLldYA6zuFfHBGKSH3lBY1Q1n7IXNPfDZiINdlEtS6pgcvkBs
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Fri, 06 Nov 2026 18:22:59 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

zynq_gem_remove() never frees priv->tx_bd (the buffer descriptor space)
or priv->rxbuffers, both allocated in zynq_gem_probe(), so each
remove/probe cycle leaks them. Free them.

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
 drivers/net/zynq_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index 0224b4ba245267d0514b80b6947f8010c3e5f09e..ddc83de1c1beab31d52a17f2d41f608fd92ed8e0 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -1074,6 +1074,8 @@ static int zynq_gem_remove(struct udevice *dev)
 		mdio_unregister(priv->bus);
 		mdio_free(priv->bus);
 	}
+	free(priv->tx_bd);
+	free(priv->rxbuffers);
 
 	return 0;
 }

-- 
2.47.3

