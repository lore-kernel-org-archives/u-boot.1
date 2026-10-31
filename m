Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06EB606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tSZ44FKi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s0BWZ4QG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FC2A81134;
	Sat, 31 Oct 2026 06:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XESMDCWyHR87; Sat, 31 Oct 2026 06:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D417681150
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793427431;
	b=dAZlEMV44l2uz6IfjD6WCnoE8sQbcVe9LYyy7Y4Ly6sImihwcjkKkw2L/rbygZET5KvL
	 7Iywv1gitM+pl9SuXnuLFzLBkUlQX/P5/xgA4JW+MgOQuplaoyqUXGjpASRawETB0Sw/T
	 hA6NGsrCvadyjeYr4H3Bs4XcxnGqtHEBhtiYq9HjcNP5JWeTAVrraE8HAC8J6eFkcUojZ
	 g61fgMh0Wwyc29rNBQ6SJe3EkfhSmoM9b38aYHOEMgraxte5QUW3k8OYZOuGN4WNJwoVq
	 gpfWDy4NESjqo1yagY74Vnr36/PtBu2NOlNn8TrPZR0s56d2PuGuDLao78A9TbXXm7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793427431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8NlG/HN/xvaK3+2pez+ORoeszXBpctO+QDubAcLIfzY=;
	b=Q46FdNFoPnwKNTeyiMlmTmptNknmGLOCqjaQ3Zbk26ETN4eotPljGBeAUu8u6Ido2Vo3
	 Oj72bffXy8C9klhkXe25/rwTBYbLLWFaGAeQ4UO17+uDAMqcldirXos35FQrb8CSILI3h
	 CJNeKNhGRK8kToym7/UGybQaJo7+zH8wVySaGQ2h9RypzxiIgVsuTwqV4YUdEGSM9QIs2
	 I+Qv9Gx/NEAoLW9cZtQrH0CQWUgzUTv0RELzUqx9Ja/d5YJFUA30terVecYXFwj/R8nzk
	 NzQvtWXt2qyLe+gX4t4s9KM4sepq23q4peKivFEe0i7ygESwcmR1aSK1c3gs0znquxQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793427431;
	bh=8NlG/HN/xvaK3+2pez+ORoeszXBpctO+QDubAcLIfzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tSZ44FKiRdmo7GfLHwHy1KRJMekTeU4RniM/WNryKjU97yqeGj9RuSf7O81XY/e6Z
	 iW1qmRieBbSg8KnwD5ZXWhueSoxGHSA2zIKUuyelTZwv8R7uKIoaIDL1ZRKmFeRJPk
	 cZKY0hy7IdIj14LbkMFvDF1xPogqS+miSLV/1a1BnZwNv0ZKO1N0IHchqFQqNofzbQ
	 yLRRg6rUZC5UCjbsmpnMNeGug0Rja4BGbyD0QvG/2mL0M0+a4LM7xv2R/gXcqBetal
	 ZySty1qo3VooYx22t1Btixl7jKl1nTjIZ+BkHBn08EHLsjmzJ/P3YWSfh3xC5FZxGo
	 6rsUH7ssS8HUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D417681150;
	Sat, 31 Oct 2026 06:17:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 576AE529
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47FA960AE6
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qV34X9XZf1NN for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 06:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73EBB607A0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793427429;
 b=MTee5TX8OAzgt34FjpYsNt5kWMExa8IV4eEemJNkzlYp+8UcCFlXoXMhurZcgZV00atz
 rGsncZTuzCluzaB8Vxztm3MR0ab8kxoxxmSjk1noUbTzNZwwkjuFgcXyw7N3cD+p45kRc
 ut307HnwXkW7TbN+s8g3pV+bA03YNZ3L7en6xvoXmbSfCzfKYtKMaAqd8CyBNXTXygqIy
 rzPeJH+i8qD7VsaX3F/gkFwx7UpaFLdAjmRHZ/DpHPR8odZZ9IgWUSLx7ySygVvcB1QbE
 CF4h+v3Agxm9M4vx5NBMw0H1IjswQNZDIByRTxq1iBaPTqHpGDRAQ6t73FPb3CLxR0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793427429;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=8NlG/HN/xvaK3+2pez+ORoeszXBpctO+QDubAcLIfzY=;
 b=BycpqxclICEB8o1NQTp96XRZldzOke5+OuDwrgBy/DJsxuFO8+MwYnCtv66NrMA2XNK4
 ZcJAhDyVllOkJCnZHhx8vapmuRm9YbCdBrglzXmDrrWDxbYmpveaIbJXZQ751sADMqAVE
 +krixT6OqmwrHfAJSAin6xLS16zJmxGTqgstb5rgGP49wG3HyjYgsT2m1hHm4HpXoSFFY
 hWymhC6R/6ZT3TyKOS0mBC2O/aLOH7k5gqgatIBDeb8zsS2EfWQZGA9e6pqNtRl2mUM+3
 mHhmtk7B9fO+Niysw0prYW8ALbmB4yuqjoWMKwR1OlOZtPRRLgi82L8O5H77OqbBuqA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=s0BWZ4QG; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=s0BWZ4QG
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73EBB607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:08 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so13803895e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793427427; x=1794032227;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8NlG/HN/xvaK3+2pez+ORoeszXBpctO+QDubAcLIfzY=;
 b=s0BWZ4QGkWg8BvCRMoO6Re00HRFgZd5m3f6EU2cSPdXOgUEC2VC7C8JC6SksciRnnz
 a2bq7DqY7cv7fhfgtd1jFHtqnS3ZgpPrDtRuUOHf3xw3hJA9QCCeyKxnHMzhRWUPgAEu
 By62IJNeB0zeq1OcKTgoFggi1f6BYX1Bh0LeRek/VVTGNgN8FG6goOr2KRgtUMuOjMG2
 vrzQc/6f7mmgkS/O79XgJoylmMUJ6vJG5w6mgb4wQ9f+Vm90neKJ/ifFh2U62Yuk0Cc9
 IP8LCzZ2vdvElvD2oA7BlNIqHuO4Gza+MNc8PftTd+QDwe+4T3+1pBuvLOQHptr+k0r3
 9UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793427427; x=1794032227;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8NlG/HN/xvaK3+2pez+ORoeszXBpctO+QDubAcLIfzY=;
 b=J4yeO8RrtJqGPDXEtngaUSz5jX0zn1IL7zIcbJWETeS0tMUqRgbhqFYxNiIe2VeBxy
 mAI0t6++OQwjwil1963eHaDu+pU/gd9eW9ZMumK0FdYXEcM+zOWvwOl78D8R2P/qggOd
 zU905KrpmUPD29Nl1yin4PZlFbp1fZKh6jHnqUbOBzDslVfQdwXB//XMoetnKZLQ4end
 z60sFCg9/mtxTq12YOpC+v305pn0lptORCQKooTgC1Re4qK4pa89mBse4mdBbT6a+w1S
 nsiPaeEIDISHj1cMBKPUE5pmLxEmChcT4gdIMQM/9yA63ewbsaqdnTcoHdiW0lJcP3Yp
 EbYA==
X-Gm-Message-State: AFq9FYIVdTzln44MMjenT0AyFob5vlfuSu0nzQ1XEnWTubJhLCNlocJt
 CR+66Ld6WBXmwLYON9mjQYBoAlahqyv3g8ZykvoP6BBCOJDcayBGLDp2
X-Gm-Gg: AYBFou0UsUEwMUFSp+kv+SF60eufcjuobuqb6Mh0uYPon+qJNlYtEwDOyLfeR3hVx6S
 bWVCxxad0JRxPy8qqOMS2pOVH0qZpfJYPE2r93P+c+1ex24VHz5aGmVJ0l8+lbFbzKqEQ4T6qZb
 Vo+oWYashmqWKvieHdhlaOmV1oacfcskf2VaxetdUr3vBnMOutXtZQLmAtJzI2AkuQpbIIyidbw
 PXvNf6kAAg0rdXYar4EPgQ9+wWGFr7J/H6peHfw13DZuM1BeRyFEn2q4r5NgB1zT7fCw6jkab3b
 PN9YCZqLo9s5VzVGTHIXAqck+uYPWtzF/u31HCvbZ5NTESE3w95WMXeiU653nZNcN/SfdjsCvwa
 R21YADd7T5Y1b+Go77VYNa7McO487/ve5R+F7ipz9OeS80IlAAMdLE+/2l/315YXHM4zxY86QMR
 /b1mDb/PAn1NVQW05ns1XLH2HWvx/G3HBd2rVARClr7kiceZDMMw01fJcgR+hcMKtDNRdhnQkhl
 7YNBh2tn+RaJAl+t+JGpKfAi5y/T3oYUo9OXA8DVV2bY9n0Lp35x93SjikAXIEdsCf10kHg+U+h
 ozgfCEV0KPranAAfVUkusmYKC/VUl/Y=
X-Received: by 2002:a05:600c:1385:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4ac182dc0a1mr104471455e9.16.1793427426642; 
 Fri, 30 Oct 2026 23:17:06 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b72715sm6705062f8f.18.2026.10.30.23.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 23:17:06 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/6] cmd: usb: don't look past the last port in usb tree
Date: Sat, 31 Oct 2026 06:17:05 +0000
Message-ID: <864239fe-50a3-409c-b536-56d5407183e1@gmail.com>
In-Reply-To: <57123e9b-629d-49d3-b500-095503129ed2@gmail.com>
References: <57123e9b-629d-49d3-b500-095503129ed2@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Without driver model, usb_show_tree_graph() looks for a later sibling
of a device in its parent's children[], from the port after the
device's own. The loop tests its index before incrementing it, so its
last pass reads children[maxchild], one past the ports of the hub, and
past the end of children[] for a hub with USB_MAXCHILDREN ports.

Increment the index before testing it.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 cmd/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/usb.c b/cmd/usb.c
index 13a2996c1f0..278ecac7390 100644
--- a/cmd/usb.c
+++ b/cmd/usb.c
@@ -372,7 +372,7 @@ static void usb_show_tree_graph(struct usb_device *dev, char *pre)
 				/* found our pointer, see if we have a
 				 * little sister
 				 */
-				while (i++ < dev->parent->maxchild) {
+				while (++i < dev->parent->maxchild) {
 					if (dev->parent->children[i] != NULL) {
 						/* found a sister */
 						last_child = 0;
