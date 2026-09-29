Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AB0CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0F6A607BB;
	Tue, 29 Sep 2026 20:32:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCeE3DrkVKVj; Tue, 29 Sep 2026 20:32:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3EBEC6061C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713965;
	b=hftwVfmG0UstBW4e5ZU40RWFsWKb+0/ehPo7Vnh6zs5kMYRvwnBMbvTDrmIvvqInIeKY
	 6eeHgX7zXmdHBMjpWuyg66uwpiyvZU/rNktKHBOioolc+6DUIMCoP546mL2lxMG6FlCsJ
	 Oo7G/LUw3kbmoQMj/ISHRgAbPkNQIFw7RjZjPO/t9WuMtBb1OQtKSmEE0hPdGY28/ed5+
	 GeSodfy4FADsVfBG5tnDPhVyqtS6cbWgh93GXk+GlFsDVW6YYW8kEcUg5VAi2aPIDT3V8
	 TIj7xWRbq4VKV1/PTJSSBMjiTRDJ2scbx6oPcV9W0t6OyJ5/OZ9B27CQyzPuPyMqxSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dyw54RnipPHBaiWOOZ0tapqmY0fy3iOdUBn+ZPc960I=;
	b=ZU6GiJUYj9BthQLore4uqY0HrYYRADCugSSM2/sipi546hns5Q+X/hSNXyiqzQooWInF
	 6RGF5TlBVcOYC41zsDNUAmXk/T44IiFueWJxaLYayC0NEK6olB+wCJoh/nJY05+B/lg8O
	 2z8glBfbDi5N3LrdxZv8i9+mAGMVFrpnGRkfXw6lHYzTh4nKgaivAnDCl9FFjEvJBQFr1
	 HgLV0qwiAOhN1BgiQnrQOBRDhIJXN2VUTCxTeBFcdXU5M0R/PS57mYvYsBYUjQwMV5DvW
	 KYxXNrquv+76pwFPtaxOzlus00hV62Uicph8UH85CpIcNb53+APWbdG2rQUfWSHKAiw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713965;
	bh=dyw54RnipPHBaiWOOZ0tapqmY0fy3iOdUBn+ZPc960I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/fjzn00m4oSZyr6I9uS63bxZRiFTJubGPX0+Q5VRvLwCreXkcrvntn8JS6s85R11
	 nExeBUo9U50kzriVgalp0Zq2ts/h1HVTntIN/AS8Y0ux87Do6PoqF7NemSi4vXPAW8
	 H7hWGmzfpR8lRJHR0VSdeRByLPTVG1VvVYxAjmpnzq4d+A71GgBYX0LIeO88i/2mrT
	 /Y7DBC9I8Y6suOyDeUVwdywq6Y2N4Bzk+cS4YtVh6Sv5ReXPb+9pQ3ZGzAmY0HjFhJ
	 NdPZiMG49S6rpkDtHUje7IuE/lhBBwkpbwBJcVjgOG6qfieZ94ylLZjANSPBNcaBOI
	 kGzGMb0awIpxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EBEC6061C;
	Tue, 29 Sep 2026 20:32:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 00AF72E5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAAA2400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x2WJwtxDCHj7 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 17:59:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A4A0C400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790704783;
 b=gNXFRVys3pBJh1/8k3C1qP3AE+bdPAgKMwhXgM+416CyOy/LDAaN1BkknyNYhL7oieao
 s+kfRFuyjRJ0jABIR58rDKoxaIoW1BT4Rq2OC4zC16dnhOuq1uN2FPxuxkcjSd9rYBsCn
 BEUkYi3crN0f5qLPKGg1lju4xq47nO6kmOeXUUsX/2SNyQ1OiQlrQ1uwIoI4OJFl9if8c
 NExB/Nej2bVRBIVN603utsVD4P3ZaIoapCvRyWo0gqbEtRXoOnxDgQlFMp6beOti2WTdI
 wzTnjf2+Rp5UmrOaGQj4bXkoEOURx1PSStP0nY00WRDS8/4ZjErb/3qnzf+MRnA+CKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790704783;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=dyw54RnipPHBaiWOOZ0tapqmY0fy3iOdUBn+ZPc960I=;
 b=QhRlCH164l3S4+BWcwbGtrkZzweDLdmaAOFHlp2v1McosxHnyr6IuPaQDr5sm7D/ZTYx
 Vx19QU2Qc3YolbMEXG2bL5nsbzVrWi3WIda5g6RIh0EdAT7pv5fyBd6CP3HfEwkLKMbzK
 tLqHS5FYeWt8L8Z4cdScpXwNySpvqGkNM9jQrnc8rynBOXttgn4bgTDq2iyHZft85VasS
 63+nIgXrx7YLemhFjkdk5RtmiBZPWMc2yYXGk8VPo2mBpC4hgcvoVh0Zjs5artySwuNRc
 pDOECy45mnTRhPARuNJCGz8Axhk8SkPHEJtlJLyE6RNO8n3GprN6v3zf82j/1UG8VrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b="E9/0Ay1A"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::2b; helo=mail-qk2-x2b.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=E9/0Ay1A
Received: from mail-qk2-x2b.google.com (mail-qk2-x2b.google.com
 [IPv6:2607:f8b0:4864:34::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4A0C400CC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:59:42 +0000 (UTC)
Received: by mail-qk2-x2b.google.com with SMTP id
 af79cd13be357-93c65bc4616so286090685a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790704781; x=1791309581;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dyw54RnipPHBaiWOOZ0tapqmY0fy3iOdUBn+ZPc960I=;
 b=E9/0Ay1A+uvnDj4SNk8yqHJEWWOfFQqDZ03EmcIONTq3Z4IHYS/YWLvMZEIAJwFUbG
 t6wMjNMLMPYynTnu6gkeHFpGkkzOhdfpiUWVlaYM+syr172lz9tlFKD4RXuj4HV38J01
 EViT77L0BeLh8OmGH9b+LF/KgYxCRWs4g6DzssCjBhHo5WLhjQ+kYA0c76pJdjOHUAal
 jHWRlF3R1tA7drhbZfsSrnSilTiICtnKkjH1g86BiSP4KDT+mengYtR/N8Tn2M6BgV6/
 3euAxkS1wm4nj2fu+uvYw/Fr0p2KblwaI7EAoV+gNZFP4wGztpdcZQi9pNgcdJ8oeTyJ
 y46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704781; x=1791309581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dyw54RnipPHBaiWOOZ0tapqmY0fy3iOdUBn+ZPc960I=;
 b=FRQ9NkSvSqoL09lKcXrW6qm+ltA4cOhupAgJdaDskeQTEruETq/xCSgkv+g8ziQ3Wc
 aianp5U5XBnrGzycD9e6pXB64nY2QMtZc4+Ma6tqVMQrBlDnKKrF1P53G+bO0JJHDO43
 YD+NmH/XxNc1IRIyEpL002KXgKrzSvIwwOOz9eu57wwbMGAswLSSok6Djit7Y4Cccged
 zHSaIxkI1/dvsEv01XUbUq7oLLSWBnbi/+QqQ/wxqadfhAokuG5ts470Ure8hZg5tz3K
 TjVhIzhpNZqOfx8i4q5l1zwFB1LXp9SKDoCdFaRfDIuJPwUK8X41aYPDk+hj5nSY6gMw
 BaOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz79dlYdR5mn84Mx8xw+A1eyYIgAJlInYg0BXGC2TXVP9zyESUkpIjAjV73GHnN5PLgSF7k77g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nHXKe6kKjisKaXzYe1JL9Jp/8j/HFXZn06rQDjK3s/KlAx9dEJ
 TXlwM9Fjmid/FbIchGKdxDXCmVgOUVUxByj9fU/AWN7hM3jG9HhaUT7yqjkxk48VbLbOSjsRQ7I
 QHN0RDmfuyW3o0QQCOHtVWs+vRV0/IUtEXjBOcyFL4kVYpSTd2Hlshszzv5bh6W8=
X-Gm-Gg: AYBFou1s3+oFGJwhEESzv8dT99mddpLlVmVfkJnN0GC4aWFpGqWnULezUGO0laOEaiY
 V2NMnD85gL6/Dt+laVZy4QzFiI92aKinPCfM8+bJiSMgtepBFIAmzWUyuWdzgxBHyx+yJ5jM9Yt
 VsTkXgZeXuWWuCwHRrcGSbLxgkvT5nPkxBVGn/gw4SF3/FiyEN6++GLJtUE/HJ/RTA/x3CIgM6t
 k9Dy1S/9yuKvFjssmMX4OCfss5VgxQXqeBg1wa+i2lphvMkMMUVxpF6btC9wUCDKOjB3J3s5LjP
 iXpuQxZHGpu2gt4mg0hczdmqa/AsFGe+SkenCZyjTs35VNYZ45UtYrlfS3upnaOv6NNA7HyEIgQ
 mXL5gXBUazYczNWGWJq3OtnPU6PR5tWqpyqjjCkam+Xng0zIdwArPBihUVRqFzBhvzOmRlK2Fbx
 IV6ZopyUVn/46YX6DgvdSLr1RS+tT/4gciXH3cpnaXhk/+dAOpfZ6XkN3nQrh/NeKr
X-Received: by 2002:a05:620a:4410:b0:93b:d79b:9a54 with SMTP id
 af79cd13be357-93c9fbd992dmr49260985a.53.1790704780844; 
 Tue, 29 Sep 2026 10:59:40 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f2dd65bsm29923685a.2.2026.09.29.10.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:59:40 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH 1/2] net: mdio-mux: Don't crash if our parent never shows up
Date: Tue, 29 Sep 2026 13:59:31 -0400
Message-ID: <20260929175936.3374213-2-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929175936.3374213-1-sanderson@brivo.com>
References: <20260929175936.3374213-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

The parent MDIO bus may never show up (such as if there is an error
while probing it). Make sure to return an error instead of crashing.

Fixes: 8880edba06d5 ("net: add MDIO_MUX DM class")
Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 net/mdio-mux-uclass.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mdio-mux-uclass.c b/net/mdio-mux-uclass.c
index ee188b504d1..14143ca0ab6 100644
--- a/net/mdio-mux-uclass.c
+++ b/net/mdio-mux-uclass.c
@@ -86,6 +86,9 @@ static int mmux_read(struct udevice *ch, int addr, int devad,
 	struct udevice *parent_mdio = mmux_get_parent_mdio(mux);
 	int err;
 
+	if (!parent_mdio)
+		return -ENODEV;
+
 	err = mmux_change_sel(ch, true);
 	if (err)
 		return err;
@@ -104,6 +107,9 @@ static int mmux_write(struct udevice *ch, int addr, int devad,
 	struct udevice *parent_mdio = mmux_get_parent_mdio(mux);
 	int err;
 
+	if (!parent_mdio)
+		return -ENODEV;
+
 	err = mmux_change_sel(ch, true);
 	if (err)
 		return err;
@@ -121,6 +127,9 @@ static int mmux_reset(struct udevice *ch)
 	struct udevice *parent_mdio = mmux_get_parent_mdio(mux);
 	int err;
 
+	if (!parent_mdio)
+		return -ENODEV;
+
 	/* reset is optional, if it's not implemented just exit */
 	if (!mdio_get_ops(parent_mdio)->reset)
 		return 0;
-- 
2.53.0

