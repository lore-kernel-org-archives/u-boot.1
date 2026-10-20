Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BC606A33D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YYTV3NmM;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ra8d3xak
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADA32810F8;
	Tue, 20 Oct 2026 10:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sMOmZcYa3T0b; Tue, 20 Oct 2026 10:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7E4958110C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491385;
	b=EHqtE2gCg/Opv3ZFg2szrbgICbg1fNzCst6wpLOQKabtRrjg5Lgcy+OVH8R1RbDfc4Qy
	 lCs1QuL55xT9k0OKrmM5Am1gbcHAHh7Lj8GUcP/cN8i5SnCewepNOmougT+IoBfqJmnse
	 SAkjWWp/wyyqnLCB5mp0IhSc2i1ZKi+5banjU5nGzh2DfvMyO2kwtUgkdAncQFbWWjPml
	 EZvhgsR8w7O1LX3l7nFZ5XVvabku0hTeOyhR2ywonb05NI7h7hucn6guz06/0yk1zhFQF
	 nwenk/9akMabpzkJowRViHIXiFqdaMhw3/qLmrbawEF/i8TVLE7RrMqOQMOf/43zGAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=M09pOZHjYw2QGuYgrQbkFGjL7VcfS1j4y3M+MqZ5Z3A=;
	b=ga/vsYfgZq61KopHjU/C4SnwjY9HFxaYrZuT8G0vhIlofwcUfcQavmJhYK8KVG3ZXeQh
	 qENXBKNWzbJ/qa7FJcM3RqYzB6zbHXSiTPB1K2//GsWq1n1jqJl8KB49xEi51qhfP9If2
	 kgdXxBgOz2O3+t8W9jVZBfKc4L9RZCfteh3AZ/RKwT9M8y+NV/iR1Qk0Bpt66MWthy9wg
	 DTNE8JaQcbnr3pu9TGScsAaZmKXD8Gf8pIUrHAvKaEiu14s9HYdy3DnfC1+9qWZEgUwH1
	 uKNJOhC6Q4yrsfVPQ3z/dAz0VnBIlxkgPhneinzcsaPvLmPhEp20AhQ3tbdja3sL0VA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491385;
	bh=M09pOZHjYw2QGuYgrQbkFGjL7VcfS1j4y3M+MqZ5Z3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YYTV3NmM4FY4ty378qz0unNx2YpFRWJnwZPLE5b4bgz09e1QmqGIDqtJC/91/EQmj
	 wCMXVReg/TRfngMRSdLQTKHi1sEFC+FLRrWQCyclmnSfxqHnKYKlBaR9+SxgrrZqTt
	 tQCh+Tmudnuj6+88eYMUA7GG3MdKLL2uk5qSGG/yVxmPetVk3EI4AQGhsgKpFfqxFq
	 q+DBIuUtMz0INxw8I/Cy5jS5T/H3i39o9fTzcvB/H04B1w237MJUJBBh50Pp9KeKNq
	 dU9ZSc1JCdQd6iOthlZyB9HToQswQ4Yh/6HJ2bQNlP4OUair2NigsfUUJIZBrAMLsy
	 kkxHx9V5jvQLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E4958110C;
	Tue, 20 Oct 2026 10:16:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71475769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 624C640328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lp2mU5p6jK4K for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 866B64016F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491376;
 b=gRBVi5gLWl6qQQSGcP8lRCxq429v3uHeEgc2yTSoaYcwHe1d8WD7snT9nVtYEuqdJYTC
 EXl/4Evw7nHFLL+QdmU1QnlNE+rKpA0mob0f9jjF0U73cZTQRF+Y72HmllS36yb+4cUIG
 JoWh4Pipi/djxhKp/CWj8MJeWdrBWWOSaC8TgPGKNX/n+Ff53mpp76f32VJu9JNbi8v+3
 djp/O0VojUqwpTLiOxN0mZiOrFztG8raPZoESMwxGnAZvYnZYPM66+EAVvKA7JhbgX/1k
 aX9jy3rHcEdgNXnkFBnlNAVGowoUiZ+uD0q5vuHYiQpwqjAHI8+vEC8G0ix8fiY+j3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491376;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=M09pOZHjYw2QGuYgrQbkFGjL7VcfS1j4y3M+MqZ5Z3A=;
 b=obRuqybcdnVDi1CNsZduMXyUWd+vh7pn83TfKabz62Tjnv3JgPYy98dug3yw6TmhpiYr
 j3y8jo55vSyq5FwfbnM83fUvhsz2BnSixdaw2/A3ZCBDbfCK6RTrfSfO5UFOJlDMHv0Rk
 RvMhOveuO9sD4aqG3v5bXmQn6Guuie54XwLo8ViucUONUjwY8sfHWOOeKaNPKlAkHEot2
 49mS6uSO+yqfOMBqhbEi2PE/ds63CNQJvppcQQ/9F5ap9N+hosSNpAKa1pBFX7ApQQg3o
 eCuHTpkLds8HHyyjpVCWWkGuwn6ykdLMsVVw9ljU0d3enpnMgPcLL3QmFD9jR+04CDQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ra8d3xak; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ra8d3xak
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 866B64016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so19421155e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491374; x=1793096174;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M09pOZHjYw2QGuYgrQbkFGjL7VcfS1j4y3M+MqZ5Z3A=;
 b=ra8d3xakskv9k6INOF61+J6KYZHpIMJiyS0AKI6//ohKDyrCR9XGn1eorx0HTFrjfr
 ohs9+Np6lE9PEcPNYVwNUbBW8Y0YWpkJVC5ddHhnx5T1X2og0gHVOin/GObzk7XPClvx
 PYSbkAVsF0keO1b6lmeaCdUAgEUpl7j6hDCKf6Ui65QwOAzZ/HmIbBo1xJjq38xeX4/W
 Iki9Q/H0ZpQ2SNY2rvPWrdtYpDUreMK8R2em9JhUAOWLpQT5RynFnqJr9wu6TTkZNryK
 KKrsQA5MyEBJS63EMfOwhkoVidn66UGH3Ib9uiMShR+9+uetg8I64Mn9X6Qk4nCJuneM
 GuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491374; x=1793096174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M09pOZHjYw2QGuYgrQbkFGjL7VcfS1j4y3M+MqZ5Z3A=;
 b=H/CiCReJUewYe4nO3aKjYBWhYe91FKAzCv7fN2J0lX03fiC+PWHWrO/nmIt2zgOVba
 /pOBEpyhyAJoaDsgnvQvwVA5sfvykXhwRxWM738nXNJhUQnS3UioFnI9rdvbpe0cBg5a
 CA+iaoL5OScrBg0bFqYaUZiSUBCLCd7QfpWAGhufMh5TvRsluBp6Q2VSsz12/KvfAOVC
 v561Qlf2fmp81j4HRB/1JIewjkMa4CO3FUw7eSDF1KFcSM14AY2SkjJiuqkQSgFwwYbu
 RFVD/YOqL597G//Y7jYgRn++xNIHF0qvL8RqKB3fcY8ZE1YGFQ/vVYQ9VWhO3uf7NGzA
 BaPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNbknqWkVLM7nCSxjY8+teJv4agtvR3KnUf1NWIvnbpggzgUGtTQ+0g/Ql8kndYVn9Ms92P94=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLHB4hP/XZ+ISWm1Daxc8ujwgA/yFrOCW/wCJqSarT+g1qb9ka5
 yk+KDCJyPC1NXaQIcgA5hHGtmpqVFHK//Irhqhcty2ppSCVb58b0A7jI
X-Gm-Gg: AYBFou36ckSa/xI1GHcxaxkledvxZBiC7jL4IjaIKM2M5SnKG16BQsDi1P9xIO7wnDI
 0wybgIMnPL8BeHIiKhkh84LytzNpbtN6XfNXZ8o0EwofbdON5eQwaDUVEq6x7aO9nR7qJP/Ny+r
 tRP3UQ4/cvPc/zIo+SQnrOOe1hpg9Duw807o1BI2RD+pjASD9dIjrlZgLO+HpsqucO7LV6/0EJW
 lvQ61H2g7ZBAozh2djSTVCJ8JThbLmzTsfwHCvbZOwlHmXUn9/1r3OjRk8V+Bg5kNQN7JipVt2d
 LcbCjpiWlrxVQuvCUiBMvfaC2Ikc81Z2lbGXMI81hkSzLGamN6kc5VfXPh8MXr/QBQ/7cmR4+2C
 sXgx3ZsgorYk3juBt9xxUbGgvzNxjxtPsi9RRtEnT9YQUURTSSFOcOMPflewtviepHgztXJgNv8
 CVTScKij+VOp/6BoEfPx/Peq+kqi2xoI4DUgqk841Tu9f5nON08MeyunQJz/jE46/tCRM69hQxY
 PBF
X-Received: by 2002:a05:600c:6207:b0:4a1:e3e4:c438 with SMTP id
 5b1f17b1804b1-4a1e3e4c4efmr140922655e9.26.1792491373775; 
 Tue, 20 Oct 2026 03:16:13 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:13 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 4/9] usb: ehci-vf: drop the empty bind hook
Date: Tue, 20 Oct 2026 12:16:03 +0200
Message-ID: <20261020101608.2818265-5-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020101608.2818265-1-mehmet.fide@gmail.com>
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

vf_usb_bind() only returns 0. Its comment describes a hack that keeps
the second controller from taking sequence number 0, but no such code
is there, and an empty .bind cannot influence the numbering the uclass
does. Remove it.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v7:
    - the Reviewed-by moved above the Signed-off-by
    
    Changes in v6:
    - dropped the two Fixes tags, the hook was not empty at those commits
    - Reviewed-by from Marek and Simon
    
    Changes in v5:
    - none
    
    Changes in v4:
    - none, rebased on next

 drivers/usb/host/ehci-vf.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 5d27318de62..e5f9ec0fdbb 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -261,20 +261,6 @@ static const struct ehci_ops vf_ehci_ops = {
 	.init_after_reset = vf_init_after_reset
 };
 
-static int vf_usb_bind(struct udevice *dev)
-{
-	/*
-	 * Without this hack, if we return ENODEV for USB Controller 0, on
-	 * probe for the next controller, USB Controller 1 will be given a
-	 * sequence number of 0. This conflicts with our requirement of
-	 * sequence numbers while initialising the peripherals.
-	 *
-	 * FIXME: Check that this still works OK with the new sequence numbers
-	 */
-
-	return 0;
-}
-
 static int ehci_usb_probe(struct udevice *dev)
 {
 	struct usb_plat *plat = dev_get_plat(dev);
@@ -315,7 +301,6 @@ U_BOOT_DRIVER(ehci_vf) = {
 	.name = "ehci_vf",
 	.id = UCLASS_USB,
 	.of_match = vf_usb_ids,
-	.bind = vf_usb_bind,
 	.probe = ehci_usb_probe,
 	.remove = ehci_deregister,
 	.ops = &ehci_usb_ops,
-- 
2.55.0

