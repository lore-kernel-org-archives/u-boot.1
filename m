Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0715606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qtr1QfTy;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pQEuHDYa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA83D812F9;
	Fri, 23 Oct 2026 00:13:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTI5kG3K2Txb; Fri, 23 Oct 2026 00:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D872081298
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792714394;
	b=tNjW6/XxDSRImDMEh+7zsp0HkW4cEwJGL4QX/XbyRm0um2wdJCSAv2OgZpeZ0xoPYfsN
	 GWAMNajjFNuiuldfMTpH8Xr+gScTXWVQYpigANQfLhAHMmh2WXGsgsWdiUbaYx8DWlnMB
	 qA+XPyVqcsSxmwRYYrPCfYbsmcIquQNg/Jgiuar8ypn1qxCJCKchY86jCM1yQKhwU2BXQ
	 6Aex7JQdgzSM3At37JoJzIAX2BqXRkB6KkNkWilAwfSV3VqIAV09VJEO089/ZeuX/HwIj
	 NDNHlS2AhyNH085RgWkWl1Z5/R2AUk0S0iM+DdI5b0359o6FvAnezyR/LlnJmxXGdzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792714394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YVp8bYDOlqLxrbDvEMsGr6rTl9U+0CWtTCOs4PYCrFE=;
	b=sAhUE6OYOu+ryXZwevSo4QwtniCXg6J4X1RPYG/BbfboTtWBESvC2k98wjDuva5HSZ0Q
	 Kl7fWSQOCLwh3Yg103IQ7oEwsEyoPBDD4sqr1VEltzo7fmV7mBuwmbplafN4Feh2yIsMT
	 74CIiEnCUjrtusC/AavzSEm/L/2ZzcQoXUaTXQfTqReQb6mAcpxKh7cTG0umKGm3/ou3l
	 k/Dmr56kzp9J+liVEAqDLihj0EIkY1gROrh4EpUeuZk5WsIIWdpPbZnauUcdKmkyfZYRK
	 rez0zf2OvSeV/9twfBGoRBOZ2jXz4ulHZWoJvD0VyuLAmYRq7Ko7FrEUtD1uLZGxZ8g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792714394;
	bh=YVp8bYDOlqLxrbDvEMsGr6rTl9U+0CWtTCOs4PYCrFE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qtr1QfTyFC+MPo/2nczh0bhEIFco3c6iReN+ff+EvHP6GQ84VnH/vKjAd26IMhP+n
	 DBX9DqGXOL1tK+2K+OoYzYlOnAceVlf0NXFgBew+gxabmMikvmUdVPDiimBVeiLYzb
	 2V+82EDzpmztMqfELI/PLF/2K4j3JnhT80MXIMSBt2zSG0MjwpT0R7CXs106/0us2+
	 Nxx0cLGWHJp6tI1POiohiUlqFvH65SoPmgNGGeUsILNRdbBC6H7pnlGmqdE99YVdvD
	 hu+4tKFqWsUtIIgrVAtNI1Ep9dFK2z9Ir3jWrBqmk0gQwCO1XjRmHhMhDQyjejK7IY
	 GqzOu/Uvw0mJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D872081298;
	Fri, 23 Oct 2026 00:13:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1BDE1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7E546063E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ji9Qm9RqFhL for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:53:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5EBE60628
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792713223;
 b=WEkvQsVqhITCqQaIPj1Jcy2sk+fxa12AyiEjzmupzJTNujyzMgoKh0KsxufMd9iBv1d4
 +t4/otVUMk8mzyGNlPnaQWORwhqq038t6YN8HkM8KfYBRTFTm4gXKiMNJHVwC7HzwF/ZL
 sfZUVwIU9Wz9zjuyB02yRV4RLlFGC63BR4NND0K5hQI6TZqfoiX8mPNk5NHwteTkQ6tSa
 sIM9C4YBMm0bKqMRJeOZHmUTaObqjYjXjldEd1ResC5i1h/dW7Z1w1bnPuQTpBupDN+N+
 kAnv+3B5QMoxw/qiqIOoSNO517rza5d7uehR4i14oHtcA3zZkdyOGThnJQCwZ4NT5AQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792713223;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=YVp8bYDOlqLxrbDvEMsGr6rTl9U+0CWtTCOs4PYCrFE=;
 b=LNzEe3CjP/Hi5djZM1D32i/Ola6v25O3LRBiPgHJB1Qj2Dun8lS5kGa9olBDR5cjqUyX
 6x3KuQ/WZvhlt3KBqkg0va/FCpzNUt5qOp6j/2IJbyej4Qe5kj8JfSMbI1dcj+sBJYSOh
 SVz/9ICYp8wt/P5cnZrGbLDf2WEyIVFt8ClcTxveyyTKBIO4AUtofjL0OEpqRYqHIfUdM
 ISAfrvjq52oX0tdaFSTZQc2wwOFzObA4g8AGRnHT8oQeqf6yYWTrgUS73qDu9ktH+D5Tn
 sQLo/X2lRLLHPZDy52j50OjWT0TWdd/5iitexEAwFNBAklAFEX8lr+A2JO3jFJ/emgA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pQEuHDYa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pQEuHDYa
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5EBE60628
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:42 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4d198f1a591so212674b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792713221; cv=none;
 d=google.com; s=arc-20260327;
 b=TeEE6NFgKe2XlYvVuPsCJKDVmszqvy56evT9Mlgxmy1aTe039GK2Pm5EYYwi5ZPLcH
 UC351xpTzEbync5y4xCPm2W0RCESHyWMSzLCx0RYWWs4n5UfVTIvYlQl1HwtQuAz6KU8
 HSydG+uEahrahs7uorTZ6Px6YZEYtWDIwQmMvZpTIfhmtUBCV2enkk5wi/xOg+XhH8rw
 N6Jlw4rDmk5l/hOSzhoRoQb4BSS3E6ngV7pLyb9RWtQfXHkBWpbS9lr8JeCbBEdXkP7N
 2GVkBSq/bNIH1+2VbeBH+rMMG1EUkiMCR2d1v2EP7lJ3m0U9O3RMNxTRi5YJ3l4PBXEU
 mXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=YVp8bYDOlqLxrbDvEMsGr6rTl9U+0CWtTCOs4PYCrFE=;
 fh=u4xG2KwCOaAX3LACWiWdBW7foS+n2V4JX1MkoNaREaI=;
 b=n1zMHNvYEmRXqABsLhCBm1iFzs9x0HoU/IaItIx3Mq2woKws2OMO+ehIKS4HIZmS1c
 8Rm/7pqXRgHYBJDGZmahP8PcIGoZPkCwHyT+ABOBiVuBNur407m84tbFk2H1fjvN1ZyB
 THCaaCdnJKbiXghvpAD8zmC5tHwEyzo45UTq5Zz8DUGvG0as+R3fYGMbyhHd1tge1N/I
 BP8bs5qLK/qJ+veu8SDsasAKbj4cXKyEb8dHgNnzJqTQWt8symNPW8/WOtN9WijVOuvz
 B/Mzw+KAp+3IpyjsyhrdBbdIrflicDfDuefq6X0aLzdoI7O6bUGIgDcTsAEZl4LEf1gi
 UC0g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792713221; x=1793318021;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YVp8bYDOlqLxrbDvEMsGr6rTl9U+0CWtTCOs4PYCrFE=;
 b=pQEuHDYamOQXAvN8qIud1B7fusfk6UiDg0Cw14kb/kzCUzWMKEEH7FV7B+Yjttxqrk
 MuNAz2EH2WoCYUYu77/2P9qZOVlX38s7djdFWzrcJowJaaSCqzztBoo/pj1xzLKS4tzj
 7xOZ+x1eip77mC5r/T3rj3sbkgiX1kkPpn46oGlKcEppPpU6G8smjWIno8ZSBISB7w3X
 QYI2LzOSpRj3fm5wvm5CfUUj7jp5T9kqqp4XSMLHSJ9N0o/DOiJoSHtns3DT8ZSB5LPz
 wzGiIl88yoMlE/qWM5b4LWcKqQXjKbOevXYZlWgHSN4AZZj06oEQKTdpzJNSgeP7SQez
 STLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713221; x=1793318021;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YVp8bYDOlqLxrbDvEMsGr6rTl9U+0CWtTCOs4PYCrFE=;
 b=AWDVzCekWXq2e0GPzq247lyvRXp0uU3Mt6L7Z1b5htZqIv9bNuVsc7rB/fHAIK7YDJ
 +BtnRjpaaGUMBsnnXtfUzUzJJqQBL8+HLg75lj5RIw7D+uPHbpLQEHGgaVYncUuBbYcd
 Ew74PW/HyeXUH5/Y7MeQ/d0FlTiUrQXeF3OcQW0wmLSS7cs2BMHuofTlmzMSTBifjP7B
 yDHxn2TitkEfPxFgntZ2KX/+/tDZIgQ9x9h0w7BNLYraoVSGxMwrn1OCdYMhU1L/HGET
 vpxFOX4VBtQMTRnIWEwDq+uZcQrk07LDWHNSovuzxffLuGJtKG357t5brGbr6wpKwYlc
 Y9mg==
X-Gm-Message-State: AFq9FYLOz4V/L2fw1Gz/VFXLVhEYi/Bvybl/cQa+EE3QovlIbV9Fqorc
 0okB60SDogUSJWpt0stCfSBucB6242R7n3CjJqZa25acQlsn/uk6IShoHneckhtzhbD7veHqdip
 A895KM2JSFEm8/QyV49d4u+/ZObiD5sI8SklJ
X-Gm-Gg: AYBFou2ZmOYAYSkA8G3ARzsxXmr2MoKptUUxC5tXLoqsQpD3Q6YlgUvDw8/6PyhekdS
 uMHAzyyXQTwREpJGGhbdEgn+rbNB5ocwau4mUDTpKzb+0yvK7hAqbkM+Gz4KjyvOC4KgABToJtM
 aAhLDY2OSrabtqCHKgFupBwA+OUJqJrPM5HHQhyKWyj8XUfVaEDw12q5h4VekyEbNRmtmasoWGy
 ciIcotwQT5ZtIZvTJGTenEPS9Kdd0dKeIXU6nxluKuya2HLsZ6kdVChQpMtoxzWHcnq3DjSbegq
 f0tOsgfflDYj5gQ9McwLI/+0HthLx4N1DYQ52jhvze2Nk1SM7rvyndzLe5MWtgvKPjyBvHvKN3W
 Km1bMTfDYZ/7NPrKXISNbfLQ=
X-Received: by 2002:a05:6808:c1a6:b0:53a:88c6:96bd with SMTP id
 5614622812f47-55be84c205dmr437582b6e.56.1792713221467; Thu, 22 Oct 2026
 16:53:41 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:39 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:39 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
References: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 16:53:39 -0700
X-Gm-Features: AclHuK-IVZWTkiGxnR_tLq_PuIE78DNAAOVeEdubjz9m-9FasE7_xHudSES27sc
Message-ID: <CAJnxHsijZ6sNd8tWYqYjRq8LfNX29EPD86E4Mj5NYu8eaC0MXg@mail.gmail.com>
Subject: [PATCH 3/6] efi_loader: capsule: check the FMP capsule against its
 size
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: multipart/mixed; boundary="000000000000c00f6c065e769222"
X-Mailman-Approved-At: Fri, 23 Oct 2026 00:13:01 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c00f6c065e769222
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--000000000000c00f6c065e769222
Content-Type: text/plain; charset="utf-8"; name="0003.patch"
Content-Disposition: attachment; filename="0003.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: cac44d592bddd20c_0.1

ZWZpX2NhcHN1bGVfdXBkYXRlX2Zpcm13YXJlKCkgcmVhZHMgdGhlIEZNUCBjYXBzdWxlIGhlYWRl
ciwgaXRzIGl0ZW0Kb2Zmc2V0IGxpc3QgYW5kIGVhY2ggaW1hZ2UgaGVhZGVyIHdpdGhvdXQgY2hl
Y2tpbmcgdGhlbSBhZ2FpbnN0IHRoZQpzaXplIG9mIHRoZSBjYXBzdWxlOgoKLSB0aGUgY2Fwc3Vs
ZSBtYXkgZW5kIGJlZm9yZSB0aGUgZW5kIG9mIHRoZSBGTVAgY2Fwc3VsZSBoZWFkZXI7Ci0gdGhl
IGl0ZW0gb2Zmc2V0IGxpc3QgaXMgaW5kZXhlZCB1cCB0byBlbWJlZGRlZF9kcml2ZXJfY291bnQg
KwogIHBheWxvYWRfaXRlbV9jb3VudCAtIDEsIHdoaWNoIG1heSBydW4gcGFzdCB0aGUgZW5kIG9m
IHRoZSBjYXBzdWxlOwotIHRoZSBjaGVjayBvZiBhbiBpdGVtIG9mZnNldCBhZGRzIHRoZSBpbWFn
ZSBoZWFkZXIgc2l6ZSB0byBhIDY0LWJpdAogIG9mZnNldCBhbmQgY2FuIHdyYXAgYXJvdW5kLCBs
ZXR0aW5nIGFuIG9mZnNldCBjbG9zZSB0byBVNjRfTUFYCiAgdGhyb3VnaDsKLSB1cGRhdGVfaW1h
Z2Vfc2l6ZSBpcyBwYXNzZWQgb24gdG8gdGhlIEZNUCBkcml2ZXIgd2l0aG91dCBjaGVja2luZwog
IHRoYXQgdGhlIGltYWdlIGZpdHMgaW4gdGhlIGNhcHN1bGUuCgpPbiB0aGUgY2Fwc3VsZSBvbiBk
aXNrIHBhdGggYWxsIG9mIHRoaXMgaGFwcGVucyBiZWZvcmUgdGhlIEZNUCBkcml2ZXIKYXV0aGVu
dGljYXRlcyB0aGUgaW1hZ2U6IGEgY2Fwc3VsZSBmaWxlIGluIFxFRklcVXBkYXRlQ2Fwc3VsZSBv
biB0aGUKRVNQIG1ha2VzIFUtQm9vdCByZWFkIG91dHNpZGUgdGhlIGNhcHN1bGUgYnVmZmVyIHRo
ZSBuZXh0IHRpbWUgY2Fwc3VsZQpvbiBkaXNrIHJ1bnMuCgpDaGVjayBlYWNoIG9mIHRoZW0gYWdh
aW5zdCB0aGUgY2Fwc3VsZSBzaXplLCBhbmQgY2hlY2sgdGhhdCB0aGUgdmVuZG9yCmNvZGUgZml0
cyBhZnRlciB0aGUgaW1hZ2UgdG9vLCBhbG9uZyB0aGUgbGluZXMgb2YgRURLMidzClZhbGlkYXRl
Rm1wQ2Fwc3VsZSgpLgoKRml4ZXM6IDhkOTkwMjZmMDY5NyAoImVmaV9sb2FkZXI6IGNhcHN1bGU6
IHN1cHBvcnQgZmlybXdhcmUgdXBkYXRlIikKU2lnbmVkLW9mZi1ieTogQW5hIEJvYmlsbG8gPGFu
YWJvYmlsbG8zQGdtYWlsLmNvbT4KLS0tCiBsaWIvZWZpX2xvYWRlci9lZmlfY2Fwc3VsZS5jIHwg
NDUgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MzMgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGliL2VmaV9s
b2FkZXIvZWZpX2NhcHN1bGUuYyBiL2xpYi9lZmlfbG9hZGVyL2VmaV9jYXBzdWxlLmMKaW5kZXgg
ZTg4MzUzMTVlODYuLmE4ZDU3NjMwYTZmIDEwMDY0NAotLS0gYS9saWIvZWZpX2xvYWRlci9lZmlf
Y2Fwc3VsZS5jCisrKyBiL2xpYi9lZmlfbG9hZGVyL2VmaV9jYXBzdWxlLmMKQEAgLTUzOCwxMSAr
NTM4LDEzIEBAIHN0YXRpYyBlZmlfc3RhdHVzX3QgZWZpX2NhcHN1bGVfdXBkYXRlX2Zpcm13YXJl
KAogewogCXN0cnVjdCBlZmlfZmlybXdhcmVfbWFuYWdlbWVudF9jYXBzdWxlX2hlYWRlciAqY2Fw
c3VsZTsKIAlzdHJ1Y3QgZWZpX2Zpcm13YXJlX21hbmFnZW1lbnRfY2Fwc3VsZV9pbWFnZV9oZWFk
ZXIgKmltYWdlOwotCXNpemVfdCBjYXBzdWxlX3NpemUsIGltYWdlX2JpbmFyeV9zaXplOworCXNp
emVfdCBjYXBzdWxlX3NpemUsIGltYWdlX2JpbmFyeV9zaXplLCByZW1haW5pbmc7CiAJdm9pZCAq
aW1hZ2VfYmluYXJ5LCAqdmVuZG9yX2NvZGU7CiAJZWZpX2hhbmRsZV90ICpoYW5kbGVzOwogCWVm
aV91aW50bl90IG5vX2hhbmRsZXM7CiAJaW50IGl0ZW07CisJdWludCBpdGVtX2NvdW50OworCXU2
NCBpdGVtX29mZnNldDsKIAlzdHJ1Y3QgZWZpX2Zpcm13YXJlX21hbmFnZW1lbnRfcHJvdG9jb2wg
KmZtcDsKIAl1MTYgKmFib3J0X3JlYXNvbjsKIAllZmlfZ3VpZF90ICppbWFnZV90eXBlX2lkOwpA
QCAtNTg4LDE4ICs1OTAsMjcgQEAgc3RhdGljIGVmaV9zdGF0dXNfdCBlZmlfY2Fwc3VsZV91cGRh
dGVfZmlybXdhcmUoCiAJCXJldHVybiBFRklfVU5TVVBQT1JURUQ7CiAJfQogCi0JLyogc2FuaXR5
IGNoZWNrICovCi0JaWYgKGNhcHN1bGVfZGF0YS0+aGVhZGVyX3NpemUgPCBzaXplb2YoKmNhcHN1
bGUpIHx8Ci0JICAgIGNhcHN1bGVfZGF0YS0+aGVhZGVyX3NpemUgPj0gY2Fwc3VsZV9kYXRhLT5j
YXBzdWxlX2ltYWdlX3NpemUpCi0JCXJldHVybiBFRklfSU5WQUxJRF9QQVJBTUVURVI7Ci0KIAlj
YXBzdWxlID0gKHZvaWQgKiljYXBzdWxlX2RhdGEgKyBjYXBzdWxlX2RhdGEtPmhlYWRlcl9zaXpl
OwogCWNhcHN1bGVfc2l6ZSA9IGNhcHN1bGVfZGF0YS0+Y2Fwc3VsZV9pbWFnZV9zaXplCiAJCQkt
IGNhcHN1bGVfZGF0YS0+aGVhZGVyX3NpemU7CiAKKwkvKiBzYW5pdHkgY2hlY2sgKi8KKwlpZiAo
Y2Fwc3VsZV9zaXplIDwgc2l6ZW9mKCpjYXBzdWxlKSkgeworCQlsb2dfZXJyKCJDYXBzdWxlIGRv
ZXMgbm90IGhhdmUgZW5vdWdoIGRhdGFcbiIpOworCQlyZXR1cm4gRUZJX0lOVkFMSURfUEFSQU1F
VEVSOworCX0KKwogCWlmIChjYXBzdWxlLT52ZXJzaW9uICE9IDB4MDAwMDAwMDEpCiAJCXJldHVy
biBFRklfVU5TVVBQT1JURUQ7CiAKKwlpdGVtX2NvdW50ID0gY2Fwc3VsZS0+ZW1iZWRkZWRfZHJp
dmVyX2NvdW50ICsKKwkJICAgICBjYXBzdWxlLT5wYXlsb2FkX2l0ZW1fY291bnQ7CisJaWYgKGl0
ZW1fY291bnQgPiAoY2Fwc3VsZV9zaXplIC0gc2l6ZW9mKCpjYXBzdWxlKSkgLworCQkJIHNpemVv
ZigqY2Fwc3VsZS0+aXRlbV9vZmZzZXRfbGlzdCkpIHsKKwkJbG9nX2VycigiQ2Fwc3VsZSBkb2Vz
IG5vdCBoYXZlIGVub3VnaCBkYXRhXG4iKTsKKwkJcmV0dXJuIEVGSV9JTlZBTElEX1BBUkFNRVRF
UjsKKwl9CisKIAloYW5kbGVzID0gTlVMTDsKIAlyZXQgPSBFRklfQ0FMTChlZmlfbG9jYXRlX2hh
bmRsZV9idWZmZXIoCiAJCQlCWV9QUk9UT0NPTCwKQEAgLTYwOSwyNCArNjIwLDM0IEBAIHN0YXRp
YyBlZmlfc3RhdHVzX3QgZWZpX2NhcHN1bGVfdXBkYXRlX2Zpcm13YXJlKAogCQlyZXR1cm4gRUZJ
X1VOU1VQUE9SVEVEOwogCiAJLyogUGF5bG9hZCAqLwotCWZvciAoaXRlbSA9IGNhcHN1bGUtPmVt
YmVkZGVkX2RyaXZlcl9jb3VudDsKLQkgICAgIGl0ZW0gPCBjYXBzdWxlLT5lbWJlZGRlZF9kcml2
ZXJfY291bnQKLQkJICAgICsgY2Fwc3VsZS0+cGF5bG9hZF9pdGVtX2NvdW50OyBpdGVtKyspIHsK
Kwlmb3IgKGl0ZW0gPSBjYXBzdWxlLT5lbWJlZGRlZF9kcml2ZXJfY291bnQ7IGl0ZW0gPCBpdGVt
X2NvdW50OworCSAgICAgaXRlbSsrKSB7CiAJCS8qIHNhbml0eSBjaGVjayAqLwotCQlpZiAoKGNh
cHN1bGUtPml0ZW1fb2Zmc2V0X2xpc3RbaXRlbV0gKyBzaXplb2YoKmltYWdlKQotCQkJCSA+PSBj
YXBzdWxlX3NpemUpKSB7CisJCWl0ZW1fb2Zmc2V0ID0gY2Fwc3VsZS0+aXRlbV9vZmZzZXRfbGlz
dFtpdGVtXTsKKwkJaWYgKGl0ZW1fb2Zmc2V0ID49IGNhcHN1bGVfc2l6ZSB8fAorCQkgICAgY2Fw
c3VsZV9zaXplIC0gaXRlbV9vZmZzZXQgPD0gc2l6ZW9mKCppbWFnZSkpIHsKIAkJCWxvZ19lcnIo
IkNhcHN1bGUgZG9lcyBub3QgaGF2ZSBlbm91Z2ggZGF0YVxuIik7CiAJCQlyZXQgPSBFRklfSU5W
QUxJRF9QQVJBTUVURVI7CiAJCQlnb3RvIG91dDsKIAkJfQogCi0JCWltYWdlID0gKHZvaWQgKilj
YXBzdWxlICsgY2Fwc3VsZS0+aXRlbV9vZmZzZXRfbGlzdFtpdGVtXTsKKwkJaW1hZ2UgPSAodm9p
ZCAqKWNhcHN1bGUgKyBpdGVtX29mZnNldDsKIAogCQlpZiAoaW1hZ2UtPnZlcnNpb24gIT0gMHgw
MDAwMDAwMykgewogCQkJcmV0ID0gRUZJX1VOU1VQUE9SVEVEOwogCQkJZ290byBvdXQ7CiAJCX0K
IAorCQkvKiB0aGUgaW1hZ2UgYW5kIHRoZSB2ZW5kb3IgY29kZSBtdXN0IGZpdCBpbiB0aGUgY2Fw
c3VsZSAqLworCQlyZW1haW5pbmcgPSBjYXBzdWxlX3NpemUgLSBpdGVtX29mZnNldCAtIHNpemVv
ZigqaW1hZ2UpOworCQlpZiAoaW1hZ2UtPnVwZGF0ZV9pbWFnZV9zaXplID4gcmVtYWluaW5nIHx8
CisJCSAgICBpbWFnZS0+dXBkYXRlX3ZlbmRvcl9jb2RlX3NpemUgPgorCQkJCXJlbWFpbmluZyAt
IGltYWdlLT51cGRhdGVfaW1hZ2Vfc2l6ZSkgeworCQkJbG9nX2VycigiQ2Fwc3VsZSBkb2VzIG5v
dCBoYXZlIGVub3VnaCBkYXRhXG4iKTsKKwkJCXJldCA9IEVGSV9JTlZBTElEX1BBUkFNRVRFUjsK
KwkJCWdvdG8gb3V0OworCQl9CisKIAkJLyogZmluZCBhIGRldmljZSBmb3IgdXBkYXRlIGZpcm13
YXJlICovCiAJCWZtcCA9IGVmaV9mbXBfZmluZCgmaW1hZ2UtPnVwZGF0ZV9pbWFnZV90eXBlX2lk
LAogCQkJCSAgIGltYWdlLT51cGRhdGVfaW1hZ2VfaW5kZXgsCg==
--000000000000c00f6c065e769222--
