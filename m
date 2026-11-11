Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72F606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m+zekMHr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=njCTXP1F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6238560DA7;
	Wed, 11 Nov 2026 20:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FbFHyptmkHdH; Wed, 11 Nov 2026 20:11:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 595BC60DCB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427883;
	b=QAFt6jEUgh9zmVxrda7yl4bXpKqxCXm9BPG2g92Drd8mx1rA7nENQK8ECbvsn5g6QcmW
	 sQ4IHMID89Ry9nwydN5i+8mgL0fcF9dlONkpU7+reoJBeCJTTbbORX5tOBvkp1EsyDbcp
	 6q2KMTjmeKaZYd/AIOydtdx4DLd0h2O6+Cji38ebYW9UExfqZpHLagli2UkeSyDWZHg/1
	 R4/JTgYLsSaOSTHLctHCEt5aZpd1oKYqTqCEnsUwfxWe9QwwUg7e5kj/Wf0jhtWvX5T1k
	 YPZIgipCPwGsLOldGZl3WPlUBIYrzvvblOmAjLVk2gULvFEn3inw5eHUwPJrZUnQrvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I3g9REsCFKlEP7tV1IVvie7BPHEg0feBzKJyVvujYcE=;
	b=ihtyrUatZt/vuFbeBaOp2mq4wGVfx+D6CzXtvbePSJbl6cX188B5npn3HTGnudmQb0Id
	 ktmLWyPMrdIhU/EzEGVFaSLhbRt8dePAJew/0A+b5OUVyGzsInQDeliDdpR27RZfQQjsu
	 nu20QEzyEPDlaOEwK0pXuD1j3989XmnZtgXC39HWIFK77t63Mq9wr8gjmqCKWrVNcEj1R
	 3oVQnEqzyWFadcv1l2lfwkn+0tm7xG7h53t2fIEcFDXE15PMmN9qMnqmTdCx5/rd4iaPx
	 rxx95ln/b2HXryYwnbDoUsWZ0leW8SJbV7zpfKdTqimpq/94tAQOYm5D9a0pl34k4rQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=njCTXP1F;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427883;
	bh=I3g9REsCFKlEP7tV1IVvie7BPHEg0feBzKJyVvujYcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m+zekMHrixhB3STZc6+tswm4SNxWiUMAsMs7TFqRPp2BNWd9qPTI+m+Rw4NrymWLg
	 s/q90bAnIMlDbRliK4uxygDkndP3n16wpWt15Iw484U50ZY1t/gMZRYhdJq/n7O31y
	 /7sVqMW0Gm9MilaGbVsJ1sX6zRaerPZN17kg+pzECRV4r46n6VP2CLKyZi4rHwlk1v
	 GngwdQX5w28codqWKDYc0pL4JiB3iWdAj7fLIgocf2TsI9L+UC6hFglyQoY+R6GCAn
	 ea1SwocZZ/16HrpZMSJ12aPWsaT86HVEBMQItVpgdbmhpgu7+hiqk4g1B54/KIQFm2
	 fkYosn8gvqTSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 595BC60DCB;
	Wed, 11 Nov 2026 20:11:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49D942FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FABC60D8B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gmWy6Af3PDIG for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 62BA260D9A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=njCTXP1F
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62BA260D9A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:18 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4a77dcc4ca0so2547666fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427878; x=1795032678;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I3g9REsCFKlEP7tV1IVvie7BPHEg0feBzKJyVvujYcE=;
 b=njCTXP1FCZgEbXt6kyd3kAG0vMbH4QI/XQsVsDN3SGUW5kcMrDJDDl1Yt2gPKnXaKB
 QxDL3nsSJ8p4sC3d9HTzPxMEKIgc0hk8xecaPBsFLw3gMri3rH6y21vRZP4C8C9qroC0
 lxoH4qA8kYduvqyA9ZVE5IrHnFt0REQZebu9+QiI1M50az19Kz6qPKywwiXUsgW8K1dc
 T4L/MrrYtbu6W5CIFfZPM+iHV9/LxxiuuzoyyB9SSwWVucIgvJKs508Yte99GFsZqdxP
 Ds3p8dylExg1ChcXUbvy0LOz9f8XfS8+4UjtcNcWxTP0TZvvWSwrj1LppKTh6wCgswjW
 iNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427878; x=1795032678;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I3g9REsCFKlEP7tV1IVvie7BPHEg0feBzKJyVvujYcE=;
 b=RWKz7rJ3PN4pZdrAP8KbePuKnwULQKgbPg7y1fzgH6pYvBGih0DJT2Y21mhQnXTjSe
 YIj8rHKYICQPpcIBoPT4/Gp/r5VOXXSiqqszG/sL6EFboMHSnjwikR2v8UCFjJwR3/Je
 wZOJyzKUaNMweeZYnQ2B5Ju6OSqAcFk1DwQoDZUOtUWuHY1/nArcwpDJ0+raHlAoj6NR
 jJEqUUy3+6J1RfZZJgyLE0fxlKrlc87da1sapNipzRHvb5CTbOnJqGUQPFh703ApCgge
 zbhLuN+UwEwk0XXX2wIATjSw6w3AK8yC3qq80mCeDEvG8WLBsUUg8Cehhz5jz2HgUi0h
 6s6g==
X-Forwarded-Encrypted: i=1;
 AL+hErGmpOwgQBusVXhGIElaNRJq/YJxk+FKs/l7iCADwrLN3RzGy7vRU9wsWObFjkbzQoSBFj5yQyM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+kCTI4M/gP7pQoPjW+LDO1RSyFiqTGUUzp0ciJl6W7YgzZ9+8Q
 x/GKbsnwW1nGNYM4EZEZ1H0ZowZGYEPB4Ed9k2NjZoYTHwdIkr2WVnF5
X-Gm-Gg: AYBFou3Z89vKUo0U0YHsd/7yYQj0v02Ak4YIySHM/heFc8ieF+ECzQ6HUx1Az7sl7MH
 mI7u7RBC/JzcirqqTZYBUJ8r2aHz24ziqumUx4RgJM5Mrn4hHxhwLrYjgd7wD9cqpvMkPoJ+2wY
 j97Z/m2Dj5/8uPu543PszAN6Uk9HuR+bxsxsjgHDEEKZg0v2uYEClumixgkpQaiNzSDFaZo8wHq
 IqsV52etTqM3VmsHKzfX/EGu7wbnuu98Vu5XKUUejmmz9iHpu1UzvEiyuVlWZtF4pWkx4ert+op
 iXgcfiP2zfQ0Lz/9Qmjum7yJCE0UvM08keWthhVVJlKSpUBS3zwJ80ARWX6kZobKcRPhAovBK1e
 tmttPfIUmSaxHYgHJfrLUyENOiPvsYb3BNRI+fsMM4yDx8H6yhxXAmjHMfk7jZKOpQIHRtRjqf6
 O0UzhmaiNyP2lFlyk47056vXh9Oqq3Zy2RhZMiKoB0Pf9PYTtAEPPi/YuufYZV0dF8RnKRVzEqE
 t7LccXphz+K1LPgEg7hgGh06k9ALy/m65KemxTLSJR0xSh3LvoKJJ86Nl2ekhLx5HCWvUNwW0j4
 iX2NLGCJSuD1VZycb1K8EI+sT1jc2/r7FIO1jVh5BMkbhFBPEJDKuSRrmPt4rYlCSljiQT/vKii
 lR0qEkMQrDDBczikNuwOD+ekih34gF+vRzbAwQrogQxdJJs71z8gRCKO6TeXICkcIuDZIe6XRae
 o5Wl/TWnoopn5U0QEGuo3EFLZ9ab0VtF4jxHHlHC2Twgz3GHJCuLc=
X-Received: by 2002:a05:6808:508a:b0:53c:8f0e:ee21 with SMTP id
 5614622812f47-56b968c25e2mr2904452b6e.10.1794427877662; 
 Wed, 11 Nov 2026 12:11:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:17 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:08 -0700
Subject: [PATCH 01/19] net: lwip: handle TFTP headers spanning receive buffers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-1-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
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

After IP reassembly, removing the UDP header can leave an empty first
pbuf with the TFTP header in the following buffer. The TFTP receive path
checks only the first pbuf length and silently discards a valid
response, so the transfer times out even though the complete datagram
arrived.

Coalesce receive buffers when the first one cannot contain the TFTP
header. Drop the packet if allocation fails, and retain the existing
short-packet checks. Normal packets and fragmented transfers whose TFTP
header is already contiguous do not need an additional allocation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/apps/tftp/tftp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index f437c3cb3b5..ddfe2b21236 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -512,12 +512,22 @@ is_expected_response(struct pbuf *p, u16_t opcode)
 static void
 tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr, u16_t port)
 {
-  u16_t *sbuf = (u16_t *) p->payload;
+  u16_t *sbuf;
   int opcode;
 
   LWIP_UNUSED_ARG(arg);
   LWIP_UNUSED_ARG(upcb);
 
+  /* IP reassembly can leave the TFTP header in a later pbuf. */
+  if ((p->len < TFTP_HEADER_LENGTH) && (p->len < p->tot_len)) {
+    p = pbuf_coalesce(p, PBUF_RAW);
+    if (p->next != NULL) {
+      pbuf_free(p);
+      return;
+    }
+  }
+  sbuf = (u16_t *) p->payload;
+
   if (p->len < sizeof(*sbuf)) {
     pbuf_free(p);
     return;

-- 
2.53.0

