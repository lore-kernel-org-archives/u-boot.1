Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7E2606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gphXJe4G;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XKbv503T
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5D2540904;
	Fri, 23 Oct 2026 04:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWvyXlZi3tp6; Fri, 23 Oct 2026 04:59:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1876A409C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731558;
	b=XUIgalUwLc+P8RljE+lXY7E/O0gLQF2v8RRvWzowEhYVeJfWdpiFpQMkUKp4G/JkrGkw
	 TEUcKwP6jlehd02TKBz8a06ib1lt6bK1P/JJozycl8JLODTrNuJ3LBeaudjRZ/fPufzMk
	 EIMhE7Evh6yOnila9TdzrNqcVjfBa+ta3Ylt3mx5+1l5i18T0VHcYk7d9g89E4By1XTRc
	 HeX2MmpdkWIhnd/itI2XnbbmyWSnHbbhcXTpBm47ikZ42kuC2Pq1CS8a+mFurTZAvlDFQ
	 ls9BcNSZZJjryjcZMwrMElPP1uUU07Qp1Dy8NNzCAQLWY70mukzoAZi9isd4CEdqM/w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y4KQABpnD56K3zTOmYC4sxgox5T/XKOQcyxEKGGX0A0=;
	b=n/qWVyuUA0PR5UcWnl9f/KK0HBHo40yi6QkTqc7i9cvbezQnLftteax4bfTFKL7sZxLZ
	 4VRT2rqs3GbO/u2SO1D2odWMi459WPjpyuQpGRRdvTq0BUHdyc+TJexOBqNnqNUhotMqq
	 +f/cp/XYIeIE5d2mAy2smYTw2Ks9/sxSRthogjaPIcUHK/FSOslSyOEiA9CVLG7EBLjYO
	 THuBtxxe3pXgt2ROLScqgZINNoKifdg3hzCVyP3PLRvyNTagdPbTmWAR2ZeJOFwD7icGV
	 J/KQ6UyLQ+8PSZPIf5DF6YS/q+n8bBJEy/BCssZrRz1o8rOAVtYaVsvs18eSmA3lTtw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XKbv503T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731558;
	bh=y4KQABpnD56K3zTOmYC4sxgox5T/XKOQcyxEKGGX0A0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gphXJe4GebISunmE1JaEILOroYE0BiwJstK7q8xkTSFVhlxCIu4CajAoGxmZhluTs
	 A8sSxtS28QZ3E7FPO8G/YXN/DzOJ4fStWdUCeRU0Bac369z2DOeElAjb1lq5OpZc5F
	 q+3n3FaDQQ6iAwjLbyBUbHFMzDNesWpxVmQFOm1z5DSlyJ80DknpkwWtd8KJ4ozqir
	 f0B0GGEMEdx4cKcGIWVExznHK9r/3JGabFsw+r32TFatJHk5LZl44d5d1MNzT4u17w
	 4TDXVen49stZW3IsgKejIWz/2HAmqpJi2qAqstF55FaszoHZZO+rqaToVANwKQohyJ
	 fyrmF6NPG1WWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1876A409C0;
	Fri, 23 Oct 2026 04:59:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E2263A4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53FB6409A9
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:43:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0JV8BtwTwS-8 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 00:43:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72A17409A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c30"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792716186;
 b=IJl1UzbdQI9AkE2vwYWRlfSR1rMhzTyBBFdS9ipgpgdFva8kDX1n0SNEKJzPSx5NOPkC
 x509BKg8VJbww3qfiTxUZo+69rt85pCcdsU6wbj3mD2Xqf1AAazDPD7jIjQprBKCoXv6W
 8tuJfbi6REzZ+PjHxMi5EjmlJQrl5JA1bdh5jj6oy6grc7hH1RUDcy0htUHrFfoVZUM8p
 I7obc/3DKIq1PYL4zCklIIuvujEOud85/8WhGtn9GrYoDJGbJaXqnsHymzhZTDvUwcwl5
 W9XV85AsSfIqqLYm3qobhN6JntgT9dd5QEk463necjgARTawooO0kbva1/O2zEe+dXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792716186;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=y4KQABpnD56K3zTOmYC4sxgox5T/XKOQcyxEKGGX0A0=;
 b=a9DuVlznKbJ0mLXLBcqbmqvBIznO+s+iwfaDY1nrmzDse3vvdQdv/5BwcPYUvATxjjAP
 2z8bSQ3+4OnflX8CRGw1jcj05FqOJrZSK8vCGmtJaGzQjSFtmLPUq9wcjYsZhbjMskVAX
 ba86JO6Rd+vs1w4YdvV18zyD9WOVLM4TJFuq90wInTiGMe0Zbd6mFBwpAEgnpRL3q6Rb8
 sBYFOKW+HVSOMyg8qxq2xeeiMnb2KcIAK4AdxEF5v/hATSRX/1hB3vAw+RezQPA2mgq8T
 jikr5xPFg7Wkj1q9mJHvWAJ45DeiiE4NOZvWNpXNmbgQwGUjIqiVqRgzkM93gdqzwYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XKbv503T; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XKbv503T
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72A17409A1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:43:06 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6de1fd5f572so190057eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792716185; cv=none;
 d=google.com; s=arc-20260327;
 b=OK/7yZE+H/EWIxTUVXZ2OZXwC2pXGbzoillVGnnCsb8vfvwjAEqhP7qGUbKaK4Wnvy
 T1Kyu8FAjq5iQK0YGh5V0yJa+Yl9VWDVwiOMVUxpEDJE+II7GsjuDaKwnjSLN/1qQq2i
 FJfWg2MY78WMmP+nz73JLJipPSxwQ+LdWpamJMv7n+qS51yw/jyATAHJesXZUFl8JUr0
 rwrMEurPitLNQ1n0i7riw3I0y4flTPr48pbASIv6Rs7QCJGqDD0IsRAmNTK5Ggb6fqeh
 d2KI9TK5vJOhQVpXaQmtVSPFNoRVnFk6138+T4IU3zhlDhkqDqHufwOyWGAK5yObVMSo
 wqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=y4KQABpnD56K3zTOmYC4sxgox5T/XKOQcyxEKGGX0A0=;
 fh=Pz4nqdP6lAtajID60dK1PACYgUigVHwAEh9+O2ZjPNk=;
 b=Cp7vD0rjBYTarwC3hMZRYlFmZ8Gq2KbYdJkyeEhfvnkpqDMSOjtYtaaiEldGr7yGof
 rPhCbDZOLIMcduZFOkBMcD4YgIKl3QIQKoCffAyAdc74NMlBO4w+AqHv9a6sY3JBt0aj
 2WfMaB7pXDF7AMOJFVc71kQvm0DsWorGQKFnFLXwPNGhUQvK8aU/vIOopqD6DEuBtsQu
 Ff4h8FfCQHNyJgEXyAWdAms0c29G8SNoHLwLp3Gg5CvdxwdpIfFn/DzkjplfxNmwpE5X
 j2rhz3nAMRSNjZJXR4g87Defhvk58KV6N4Zo6nu7QTViEMwlUd2VvmXxEkdJKvFEUOaD
 v5EA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792716185; x=1793320985;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y4KQABpnD56K3zTOmYC4sxgox5T/XKOQcyxEKGGX0A0=;
 b=XKbv503Tp4EFmh5hQuWl1XGt6W0gTOzTtxthgZrts8xiV4BOFsaQ8RWJQAxmqidNWi
 5oOnDVpF0lRD+VObIWxYSl3aeKYueTtxhF+Yj8mfzw+q4bI8gvGT+eG9TVrDlc6sXZsH
 33gWyj7bSKf6oC93bW8LYq7zE7NQD6THO8HuoHfm5oKZghOANL33lAtGRVxBxwhOzd5Q
 5hznqF6qS0vDiQ8/6EphgRcmglWVcdsDo0olBxyvMef176SoaUT+ESrGlEr1O0YBisze
 JS/dfsP9myL/otY2N9f09z3o9uoehyQlMBDMv5RVxD6NejS+bO4WNHWXQ+dDJIyfOtDH
 ugcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792716185; x=1793320985;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y4KQABpnD56K3zTOmYC4sxgox5T/XKOQcyxEKGGX0A0=;
 b=jt/tVVCGCJSShrGHaVBhrOS0nO8gv0vNtP5g1ame+6PQXEuZaP44A+wINe1pvv955U
 mVUZa22yCEjzbrXaa2pMh5ETrSSmLshz4KLxAXhnrdaFSv6RT0Iwu5g+DR6A2HQqY34p
 7NM41JrJBlAyIsPx/U6mySmueZNCEnPE0PgK/F4sWdm0aaQB6JyBB9na8E81epnhnZp+
 w62NdGTaqMjcZwbj9n70V8aejEpFfr1Jd5SMT6Bsir2tymR9nSxEKMJqY368fKu6FzZt
 qP9H23WhI73yurQNyA9dWkvifbUTyCkXPveFvxwa3EanYmE91zOgBFugH+88gYI4cBw9
 /2uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuR5Z7fQGuAbpp3qiYbSmepo2x/IEfeSB7+KKw83XRFN5hdrx9CdGW4emJWyy/mCf/arTXB0Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJEKi29VXVfZEWOo9XKjqf8d+X4ys3lsLdtV4eWU7eO4lRveUFV
 fLKACSRCh1IAfca8xXkHeCIzVVyqvTwwjry4PKXlPfXDqAnDm9ocG/dGYPM9MUghHiCvjjhee9X
 da+40WbgpZpA+8Cb6xV+oI+XnG+sUlSg=
X-Gm-Gg: AYBFou3kAC7bELuyuI8ybYmv9+PhPADTga/gw0g5g74Jq2rAB2uMT/GCbE8nX9lJ/ES
 eitni13P/IvN/gHoAWVfw+5CFkBH1cL6hNzcqNg72YN9V0JeHRMuWvJALyq78PQom4MTUALocCR
 FZHRSHKy+HNXL9txpiyuMz6mlGu1lhNCXUG4mNoY0XJSvdkG4wuJWJNfz6NsBwZESV+y3sOdhx0
 vUM/bNivU2E2y+Q/OOCCW4iDdEHiIzi04kmK9OTukh+wVXozZOkOFGOJ/p/RmGZ7RkuggsgfEYi
 nFlt8nDaqz3ctxJmkcKrEcQ/kCVEGoCCq54AOD20wGPX7l06OeZAVuuxG9XdxGG4fjhm2woBzWI
 D5LWXD8Dvim7r16iUBKz78Yw4tRvUpYxU22I2RErpI8pf
X-Received: by 2002:a05:6808:c1c2:b0:4f7:a3f2:d8b4 with SMTP id
 5614622812f47-55be86b3b89mr496629b6e.65.1792716185119; Thu, 22 Oct 2026
 17:43:05 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 17:43:04 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 17:43:04 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsh9KDHJJFK5Pf3A0JUaNb0bK-hDZxzGpx89xMJ5FiKBLg@mail.gmail.com>
References: <CAJnxHsh9KDHJJFK5Pf3A0JUaNb0bK-hDZxzGpx89xMJ5FiKBLg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 17:43:04 -0700
X-Gm-Features: AclHuK_cF8Y9-Jb7XMLUImMdmG7MdfTGXxe7ioa2DzwmGvebsVujeJTQ_OYE2zs
Message-ID: <CAJnxHsjiDJw6X-KNsUT34e9WoQQGySgAueiyDDXj6Q=xetV1vQ@mail.gmail.com>
Subject: [PATCH 2/4] usb: eth: asix88179: Bound the rx packet headers and
 packets
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Content-Type: multipart/mixed; boundary="00000000000065e258065e774379"
X-Mailman-Approved-At: Fri, 23 Oct 2026 04:59:12 +0000
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

--00000000000065e258065e774379
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000065e258065e774379
Content-Type: text/plain; charset="utf-8"; name="2.patch"
Content-Disposition: attachment; filename="2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4551ae30339beb7c_0.1

YXg4ODE3OV9ldGhfcmVjdigpIHRha2VzIHRoZSBwYWNrZXQgY291bnQgYW5kIHRoZSBvZmZzZXQg
b2YgdGhlIHBhY2tldApoZWFkZXJzIGZyb20gdGhlIHJ4IGhlYWRlciBhdCB0aGUgZW5kIG9mIHRo
ZSB0cmFuc2ZlciwgYW5kIGNoZWNrcyBvbmx5CnRoYXQgdGhlIG9mZnNldCBsaWVzIGluc2lkZSB0
aGUgdHJhbnNmZXIuIFRoZSBjb3VudCBpcyBub3QgYm91bmRlZCwgc28KdGhlIGRyaXZlciB3YWxr
cyBwYWNrZXQgaGVhZGVycyBwYXN0IHRoZSByeCBoZWFkZXIgYW5kIHRoZSByZWNlaXZlZApkYXRh
LCBhbmQgbm8gcGFja2V0IGxlbmd0aCBpcyBib3VuZGVkIGVpdGhlciwgc28gYSBwYWNrZXQsIGFu
ZCB0aGUKc3RhcnQgb2YgdGhlIG5leHQgb25lLCBjYW4gcnVuIHBhc3QgdGhlIHJlY2VpdmVkIGRh
dGEuCgpDaGVjayB3aGF0IExpbnV4IGF4ODgxNzlfcnhfZml4dXAoKSBjaGVja3Mgc2luY2UgY29t
bWl0IDU3YmMzZDNhZThjMQooIm5ldDogdXNiOiBheDg4MTc5XzE3OGE6IEZpeCBvdXQtb2YtYm91
bmRzIGFjY2Vzc2VzIGluIFJYIGZpeHVwIik6IHRoZQpwYWNrZXQgaGVhZGVycyBtdXN0IGZpdCBi
ZXR3ZWVuIHRoZWlyIG9mZnNldCBhbmQgdGhlIHJ4IGhlYWRlciwgYW5kIGVhY2gKcGFja2V0IHdp
dGggaXRzIHBhZGRpbmcgaW4gZnJvbnQgb2YgdGhlIHBhY2tldCBoZWFkZXJzLiBLZWVwIHRoZSBl
bmQgb2YKdGhlIHBhY2tldCBkYXRhIGluIGFzaXhfcHJpdmF0ZSBmb3IgdGhhdCwgYW5kIGRyb3Ag
dGhlIHJlc3Qgb2YgdGhlCnRyYW5zZmVyIHdoZW4gYSBwYWNrZXQgZG9lcyBub3QgZml0LgoKU2ln
bmVkLW9mZi1ieTogQW5hIEJvYmlsbG8gPGFuYWJvYmlsbG8zQGdtYWlsLmNvbT4KLS0tCiBkcml2
ZXJzL3VzYi9ldGgvYXNpeDg4MTc5LmMgfCAxMyArKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2V0aC9hc2l4ODgxNzkuYyBiL2RyaXZlcnMvdXNiL2V0aC9hc2l4ODgxNzkuYwppbmRleCA2
OWQzMDczYjY2OS4uNGM2YzliMjc5NmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2V0aC9hc2l4
ODgxNzkuYworKysgYi9kcml2ZXJzL3VzYi9ldGgvYXNpeDg4MTc5LmMKQEAgLTIwNCw2ICsyMDQs
NyBAQCBzdHJ1Y3QgYXNpeF9wcml2YXRlIHsKIAlzdHJ1Y3QgdWV0aF9kYXRhIHVldGg7CiAJdW5z
aWduZWQgcGt0X2NudDsKIAl1aW50OF90ICpwa3RfZGF0YTsKKwl1aW50OF90ICpwa3RfZW5kOwog
CXVpbnQzMl90ICpwa3RfaGRyOwogCWludCBmbGFnczsKIAlpbnQgcnhfdXJiX3NpemU7CkBAIC01
NDMsNiArNTQ0LDcgQEAgdm9pZCBheDg4MTc5X2V0aF9zdG9wKHN0cnVjdCB1ZGV2aWNlICpkZXYp
CiAJdXNiX2V0aGVyX2FkdmFuY2VfcnhidWYodWV0aCwgLTEpOwogCXByaXYtPnBrdF9jbnQgPSAw
OwogCXByaXYtPnBrdF9kYXRhID0gTlVMTDsKKwlwcml2LT5wa3RfZW5kID0gTlVMTDsKIAlwcml2
LT5wa3RfaGRyID0gTlVMTDsKIH0KIApAQCAtNTk1LDE0ICs1OTcsMTYgQEAgaW50IGF4ODgxNzlf
ZXRoX3JlY3Yoc3RydWN0IHVkZXZpY2UgKmRldiwgaW50IGZsYWdzLCB1Y2hhciAqKnBhY2tldHAp
CiAJCQlyZXR1cm4gMDsKIAkJfQogCisJCS8qIFRoZSBwYWNrZXQgaGVhZGVycyBtdXN0IGxpZSBp
biBmcm9udCBvZiByeF9oZHIgKi8KIAkJaGRyX29mZiA9ICh1MTYpKHJ4X2hkciA+PiAxNik7Ci0J
CWlmIChoZHJfb2ZmID4gbGVuIC0gNCkgeworCQlpZiAoaGRyX29mZiArIDQgKiBwa3RfY250ID4g
bGVuIC0gNCkgewogCQkJdXNiX2V0aGVyX2FkdmFuY2VfcnhidWYodWV0aCwgLTEpOwogCQkJcmV0
dXJuIC1FSU87CiAJCX0KIAogCQlwcml2LT5wa3RfY250ID0gcGt0X2NudDsKIAkJcHJpdi0+cGt0
X2RhdGEgPSBwdHI7CisJCXByaXYtPnBrdF9lbmQgPSBwdHIgKyBoZHJfb2ZmOwogCQlwcml2LT5w
a3RfaGRyID0gKHUzMiAqKShwdHIgKyBoZHJfb2ZmKTsKIAkJZGVidWcoIiVzOiAlZCBwYWNrZXRz
IHJlY2VpdmVkLCBwa3QgaGVhZGVyIGF0ICVkXG4iLAogCQkgICAgICBfX2Z1bmNfXywgKGludClw
cml2LT5wa3RfY250LCAoaW50KWhkcl9vZmYpOwpAQCAtNjExLDYgKzYxNSwxMyBAQCBpbnQgYXg4
ODE3OV9ldGhfcmVjdihzdHJ1Y3QgdWRldmljZSAqZGV2LCBpbnQgZmxhZ3MsIHVjaGFyICoqcGFj
a2V0cCkKIAlsZTMyX3RvX2NwdXMocHJpdi0+cGt0X2hkcik7CiAJcGt0X2xlbiA9ICgqcHJpdi0+
cGt0X2hkciA+PiAxNikgJiAweDFmZmY7CiAKKwkvKiBUaGUgcGFja2V0IGFuZCBpdHMgcGFkZGlu
ZyBtdXN0IGxpZSBpbiBmcm9udCBvZiB0aGUgcGFja2V0IGhlYWRlcnMgKi8KKwlpZiAoKChwa3Rf
bGVuICsgNykgJiAweEZGRjgpID4gcHJpdi0+cGt0X2VuZCAtIHByaXYtPnBrdF9kYXRhKSB7CisJ
CXByaXYtPnBrdF9jbnQgPSAwOworCQl1c2JfZXRoZXJfYWR2YW5jZV9yeGJ1Zih1ZXRoLCAtMSk7
CisJCXJldHVybiAtRUlPOworCX0KKwogCSpwYWNrZXRwID0gcHJpdi0+cGt0X2RhdGEgKyAyOwog
CiAJcHJpdi0+cGt0X2RhdGEgKz0gKHBrdF9sZW4gKyA3KSAmIDB4RkZGODsK
--00000000000065e258065e774379--
