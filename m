Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3F606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t1YnqfKt;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BxHc91Dk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E0A740A35;
	Fri, 23 Oct 2026 04:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vt2RLtgpK6Jh; Fri, 23 Oct 2026 04:59:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9B1040A21
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731571;
	b=cTeN8O+Q+xAKnz7RwQ5WnP+jVluevkv0ZFd3t6fdEu8ISJik/2MPd5C2jRbBjz4qQYY/
	 i8peW91O1tWZkjYwhtkTyrwO4KvwN+Ox9hSkowoRnuPHJRjm5OTlITjrEcOGWXdIiM9qk
	 p2flMUg2Y4u9dcuGFfkvaHk9/3vgPXC/S1gVdrK3wWZXpKwugem47Bc7lcdot6K7WEiRw
	 uYmXNDAnlr31idY9/IP0nOWj72ab/nUg8fuagRCcJuZYmhZleE/CgOqt29TU69rxI5TDM
	 9hjpY+dZm8wQqeC+trojki21eYiSxdgyg/Y3kBm5/oQ85aTYpWao6klErGtVwGo9fNA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C14McxUUeEUCB5g8hi18zhUoGpiUM647T2L0hnGWj4s=;
	b=byU+unXVtR0/VzR/7mqE99qhec6To9Frzx4JOJYTXaS08XtdBwX2eIKNZBgxw2TVVA4o
	 oVUaNVjPz6XANXO5e2QQ3v3/ib/TskrEcINCOHnp2hAxgY1+gTCul8i80XpNhaCcte59q
	 GLUjvuIYmpCtoUhZtoIj7ljc24NcdDlldO4/xde+7qSqUPDGAuwWscpVS9pyBSjDYaIW9
	 QBftTdcMqU90FoiNBDC8yiwto9NCl0nS9N1VqgCFrhMcU5jZ9LAFxas/HlHJhJ7CTzxRQ
	 qPJgO0F4zkSdK17+fSpklrLQXrOcgmwQIixZuuYqZQkvgkZzGcYCzbophLhRgFK/bNQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731571;
	bh=C14McxUUeEUCB5g8hi18zhUoGpiUM647T2L0hnGWj4s=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1YnqfKtCK48UyBltVh8NH5Ep5HBIEpPV3u0lGmAwMtc6hEaTWtbJSPs36Pjb0jgb
	 HD1FMvvi61HXb4hsnrs+z3O8W4UUZoX6tcUp16ZTR9kC6B/wBR/cGjf8L6N1MNB/nc
	 8wLZrsePiCVAPZwFEBpK7PMSanMP69NKJRrW80F3LryINj1BpB+pYf4sRaQwLsQ+Oh
	 7FmPij8DwPRjt0c8VphMDxDzbgFnYLpGU06bJ8fJ2wgYHlrEqMY4mzz+FUHmeE+OCA
	 E620a1AkPfjU96lhWJaG6EcIyOOgJchCyKUTc9CK25s0YPXgvafqCtl/1JmQFLCL0E
	 vbVT0/X0Z1Arg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9B1040A21;
	Fri, 23 Oct 2026 04:59:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7737C49D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C9B460674
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nJmPlag09YfX for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 04:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 821C460664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792728389;
 b=eQ11QBIxbyicjZVM0BWVsXLnStbGrpmcKvBx/yya7x5UHimYs9ic15K2vHCNJsGOYrST
 ropvREjOMsXgRP5jhdqRdZwxharSPFvsc6i36VPHOXNWIb86a2xcmP0tD+8YXnsExuoad
 s5zuyMKf+c1kT2c2SEneiIhNx5m/GjOzYfPqIRZ4ujgjEAYQvEgmu26bDhr/OxG8b/c0q
 EmfA0aOesdjIcewodbhMPVDP9l891G8CMeqLFaeueoKoe74BMLcaorNYd/AdUfqVoK5fX
 Q7a1lX7CI1oCbr3Eqya1jox71ncB/IFxpJKavNLslfkoNAJPGPF9OHJKt80eHZXYGrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792728389;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=C14McxUUeEUCB5g8hi18zhUoGpiUM647T2L0hnGWj4s=;
 b=W0pZWL5O5RIOD6WcCJs7/jK9A8A5JDKQrgKBv0cg3LNZM0SnSYYXwmcmoVRQhLM2WkDO
 Xl1YaogfRVkt7UC2GS+Uc9lP39kIivFzftWZNvq1qeazULOFUNo/EH7oyCjveWHZM5g2L
 ztVWPGFVjAIfeRA1UyoRr++mTyWHYbOYyiSZ0FylbxmRu0gM4vGOfU6OXteWEdhQNocUY
 zgVnjhdxrGRDBUcQwXFzR9TWzNz9GrlvwJz8Gx6NNwZbQcLFFGHMUFiOFWSZzOjTtwEGr
 NHAQ1bRSp9JA8VZoyhTomeFI4WA6p59WTfKHOwP0jr6/2dIlSXp3RebdgDJj7X0Uz7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BxHc91Dk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::b; helo=mail-oi2-x0b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BxHc91Dk
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 821C460664
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:05:44 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-539edfadfa9so232199b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792728341; cv=none;
 d=google.com; s=arc-20260327;
 b=s38hDarMKurwWJfv5UTyRXSMyW1BzeM13AxFJRw9hvaW8XcPrFSWlSA5fKnrzO7vL7
 Jx4JjRnLFjEGQfFEM+Dd05bu0xzEGxholoR51jb9HQGL4DKWzL4zBRhFqVyO9SS5abN6
 k9c31RKPt8CLqJffnjIX5dmY/JBT+h5nIl4MW377l58xF1Mz+NeOzzbKk/+AT8jdVUQn
 QihJXoVcNeM5oU3kVy1Q1abpv00OuiYG56K7U2lBHFG6h9QgRuLs7G6i2OYH3lvYpdXW
 64iDJHVXa5ic6zarAkXYYF0vSX/eeITHyA/9++mKmXjsWGsjO3hVRRN+ssvdP8GEk8jV
 58eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=C14McxUUeEUCB5g8hi18zhUoGpiUM647T2L0hnGWj4s=;
 fh=fO/i0n3hYJ74cs21KGuyGF2OazYql2f81AfdSYYrRi4=;
 b=p8Ml2Wj9uwZT2FTdO95oL+GNWR2M2/Flt0fKfsyDCz9fklt8YUGhKLKkpBKSNkrhFv
 848WVW4A0v3rUnblSQ4K3SgnhRhCfQJDWBCElQVKN9wXl5i7XaJpfMpWC/w+mDcs3wV0
 c69QAwOZ3zEztL1PeGndAVnvv/0NqMS0NWUSm5qnIAQRiqh7pKjJLV3nfnwqzlDzMJx/
 eocxtbERz1qAFO2isLc3T2h8iLdhpphQ/vg/CuAdg2U252JaJDWjscYC+Y2MRf3a7FKT
 kZ5kkBs8AV9HzevsQLW5b5rLWg2WQqKATeYvDWdOtzLX0DZpVFTFnReNVu0cjHp4GCfz
 dHcQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792728341; x=1793333141;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C14McxUUeEUCB5g8hi18zhUoGpiUM647T2L0hnGWj4s=;
 b=BxHc91Dk9Uz7CNt38bP1y+XR8KhmYRBFpI1nRLkLELCTpMl2Rzxgr/YaKizPxUmwZh
 ndbIVJNVEm9L7tVnFEeEyBBLxUpez897Gbn3jxKfupOfnSstdo1fLXpQ//ZRHTtB2iq2
 hBqdChb2Cswx9Tu3gokiurQ8QXZj54A9sDfl6lpwyI616VxeUgZjQoR6C9NYsUL8QLcS
 fGcN+n8KO+4r/pyohqX7cK70aTCvmHy1cZKWivk/ECn0Uvj7yO+fkzfSRc24apQw2kZb
 orryNa8l/FBvwYG/aWNf58StmAAqQ/8TwQ6AiwiOxKg36BF3PMkpTEWq0KG4YyOlHBoF
 0vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792728341; x=1793333141;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C14McxUUeEUCB5g8hi18zhUoGpiUM647T2L0hnGWj4s=;
 b=dHGIr11dgHN8OwV+xBQ7F8qkbH4bqug7iXiLQ1ONQ9cAocli2a7mo42+KwHPCqlk4y
 rZLuBk3nbflOb6Ih4o+d/BAEpyCuqlMKhvEIrRDHiVstYWledoEARpt9H9LZJv1aUmRP
 wLjwVilAuUYTu22eIy/CtYNlAycQB08Dw0yfWAqf6ts40Py4Hb8tAgAJ9r1fNxMHrFTq
 f5SyjikXCOIAQpmJja8zJS4Rv9HvXwODCG5zfiYieVY9hszo+ocW0Z6HPbJaJrh4CcRU
 0ib2IsNKf4obqaV5HelxQRRHQIN1ywn8xqPlqu//5HkKnUzoUZ5e+/OYQzhKTcl8OQFg
 G+ww==
X-Gm-Message-State: AFq9FYJpYQuiOIIQEosOoYSqC53pfrMQoFEM++CilvcsLzT3goEZt5n8
 kt+SrsE+ryd0qCZCsFHlgLphCSA5pxQwWCDROPOCqkCMhiaou/WdJma5Cpl4NSn2/XsfIvPWTv+
 9M/21CJ3VIQ75ZFvjkvsGbKQu7CqCQpY=
X-Gm-Gg: AYBFou3Zlu/wSxE+0bpldT/si1ZPBhayiQX5xbpLKx+S8pxcAnZGndCW+3Dh0EX5AbR
 Uljs/ErHCCXHtFJQNi4UHq6oJeq0gfK9ScoFfNCwCFj4VsSP7Ylzq6XuVRabE1ThDRGoZzI9F1g
 AMcmQq0LKg8PvoaqzDhof4Spd2V+9QSXPbhsxRgRO06Porvy/36ERDIV5CcWXbfX1j/1qZNIgiQ
 L/RBOPkt5vC6u/9sFDgG8f1bNLHx8cCKq4OhSnfK7/hFid3CLv2k3BDz9OWg50473E45DZdCeNE
 P88CAZbNRW7G5p3/one7TxeBXxtziyVrwWrod6xDewFAAWEedv1ryFUCWT3/6GmNjuNsT8m7sjA
 uxi3caJjpzRsrkHuQT64C+/Q=
X-Received: by 2002:a05:6808:17a3:b0:4f6:1336:cdf9 with SMTP id
 5614622812f47-55be82b6ebdmr625713b6e.35.1792728341219; Thu, 22 Oct 2026
 21:05:41 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:39 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:39 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
References: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 21:05:39 -0700
X-Gm-Features: AclHuK9eJbRBFrisxhCaSetUUeuRCmp89b2lHWxd53pX0AVekxaDktPfKiZ5cX4
Message-ID: <CAJnxHsjcBdaXkkzoHZAOZ0Erak8_oS_uue4ZpZ3hwpHjn_dOwQ@mail.gmail.com>
Subject: [PATCH 5/6] fs: ext4: fix the block group of an inode in the write
 path
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: multipart/mixed; boundary="000000000000f532e3065e7a17bf"
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,T_SPF_TEMPERROR
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f532e3065e7a17bf
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--000000000000f532e3065e7a17bf
Content-Type: text/plain; charset="utf-8"; name="0005.patch"
Content-Disposition: attachment; filename="0005.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5c53254b1d44bf90_0.1

SW5vZGUgbnVtYmVycyBzdGFydCBhdCAxLCBzbyB0aGUgYmxvY2sgZ3JvdXAgb2YgaW5vZGUgbiBp
cwoobiAtIDEpIC8gc19pbm9kZXNfcGVyX2dyb3VwLCBhcyBleHQ0ZnNfcmVhZF9pbm9kZSgpIGNv
bXB1dGVzIGl0LiBUaGUKd3JpdGUgcGF0aCBjb21wdXRlcyBuIC8gc19pbm9kZXNfcGVyX2dyb3Vw
IGluc3RlYWQsIGluCmV4dDRmc19kZWxldGVfZmlsZSgpLCBmb3IgdGhlIG5ldyBhbmQgdGhlIHBh
cmVudCBpbm9kZSBpbgpleHQ0ZnNfd3JpdGUoKSwgYW5kIGluIGV4dDRmc19nZXRfbmV3X2lub2Rl
X25vKCkuIEZvciB0aGUgbGFzdCBpbm9kZQpvZiBhIGdyb3VwIHRoaXMgZ2l2ZXMgdGhlIG5leHQg
Z3JvdXA6IGV4dDRmc19kZWxldGVfZmlsZSgpIHRoZW4gY2xlYXJzCmEgYml0IGluIHRoZSBieXRl
IGJlZm9yZSB0aGF0IGdyb3VwJ3MgaW5vZGUgYml0bWFwIGFuZCB6ZXJvZXMgYW4gaW5vZGUKaW4g
dGhlIHdyb25nIGlub2RlIHRhYmxlLCBhbmQgZm9yIHRoZSBsYXN0IGdyb3VwIG9mIHRoZSBmaWxl
c3lzdGVtCnRoZSBpbmRleCBpcyBwYXN0IHRoZSBlbmQgb2YgZnMtPmlub2RlX2JtYXBzW10gYW5k
IHRoZSBncm91cApkZXNjcmlwdG9yIHRhYmxlLgoKVGhlIGlub2RlIG51bWJlcnMgZ2l2ZW4gdG8g
ZXh0NGZzX2RlbGV0ZV9maWxlKCkgYW5kIHRha2VuIGFzIHRoZQpwYXJlbnQgaW5vZGUgY29tZSBm
cm9tIGRpcmVjdG9yeSBlbnRyaWVzIG9uIGRpc2ssIHNvIGFsc28gY2hlY2sgdGhhdAp0aGV5IGZh
bGwgaW5zaWRlIHRoZSBmaWxlc3lzdGVtIGJlZm9yZSB1c2luZyB0aGVtLgoKU2lnbmVkLW9mZi1i
eTogQW5hIEJvYmlsbG8gPGFuYWJvYmlsbG8zQGdtYWlsLmNvbT4KLS0tCiBmcy9leHQ0L2V4dDRf
Y29tbW9uLmMgfCAgNiArKysrLS0KIGZzL2V4dDQvZXh0NF93cml0ZS5jICB8IDE2ICsrKysrKysr
KysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9mcy9leHQ0L2V4dDRfY29tbW9uLmMgYi9mcy9leHQ0L2V4dDRfY29t
bW9uLmMKaW5kZXggY2ZmMTEyZmI5OWIuLmJlYjY0Nzk0YTcyIDEwMDY0NAotLS0gYS9mcy9leHQ0
L2V4dDRfY29tbW9uLmMKKysrIGIvZnMvZXh0NC9leHQ0X2NvbW1vbi5jCkBAIC0xMTU2LDggKzEx
NTYsMTAgQEAgaW50IGV4dDRmc19nZXRfbmV3X2lub2RlX25vKHZvaWQpCiAJfSBlbHNlIHsKIHJl
c3RhcnQ6CiAJCWZzLT5jdXJyX2lub2RlX25vKys7Ci0JCS8qIGdldCB0aGUgYmxvY2tiaXRtYXAg
aW5kZXggcmVzcGVjdGl2ZSB0byBibG9ja25vICovCi0JCWlibWFwX2lkeCA9IGZzLT5jdXJyX2lu
b2RlX25vIC8gaW5vZGVzX3Blcl9ncnA7CisJCS8qIGdldCB0aGUgaW5vZGUgYml0bWFwIGluZGV4
IHJlc3BlY3RpdmUgdG8gaW5vZGUgbm8gKi8KKwkJaWJtYXBfaWR4ID0gKGZzLT5jdXJyX2lub2Rl
X25vIC0gMSkgLyBpbm9kZXNfcGVyX2dycDsKKwkJaWYgKGlibWFwX2lkeCA+PSBmcy0+bm9fYmxr
Z3JwKQorCQkJZ290byBmYWlsOwogCQlzdHJ1Y3QgZXh0Ml9ibG9ja19ncm91cCAqYmdkID0KIAkJ
CWV4dDRmc19nZXRfZ3JvdXBfZGVzY3JpcHRvcihmcywgaWJtYXBfaWR4KTsKIAkJdWludDE2X3Qg
YmdfZmxhZ3MgPSBleHQ0ZnNfYmdfZ2V0X2ZsYWdzKGJnZCk7CmRpZmYgLS1naXQgYS9mcy9leHQ0
L2V4dDRfd3JpdGUuYyBiL2ZzL2V4dDQvZXh0NF93cml0ZS5jCmluZGV4IGRjMzdhZTE0NDhkLi42
YmFlNTU5ODQ5YSAxMDA2NDQKLS0tIGEvZnMvZXh0NC9leHQ0X3dyaXRlLmMKKysrIGIvZnMvZXh0
NC9leHQ0X3dyaXRlLmMKQEAgLTQ4NSw2ICs0ODUsMTAgQEAgc3RhdGljIGludCBleHQ0ZnNfZGVs
ZXRlX2ZpbGUoaW50IGlub2Rlbm8pCiAJY2hhciAqam91cm5hbF9idWZmZXIgPSB6YWxsb2MoZnMt
PmJsa3N6KTsKIAlpZiAoIWpvdXJuYWxfYnVmZmVyKQogCQlyZXR1cm4gLUVOT01FTTsKKwlpZiAo
aW5vZGVubyA8IDEgfHwgKGlub2Rlbm8gLSAxKSAvIGlub2RlX3Blcl9ncnAgPj0gZnMtPm5vX2Js
a2dycCkgeworCQlwcmludGYoIkludmFsaWQgaW5vZGUgbnVtYmVyICVkXG4iLCBpbm9kZW5vKTsK
KwkJZ290byBmYWlsOworCX0KIAlzdGF0dXMgPSBleHQ0ZnNfcmVhZF9pbm9kZShleHQ0ZnNfcm9v
dCwgaW5vZGVubywgJmlub2RlKTsKIAlpZiAoc3RhdHVzID09IDApCiAJCWdvdG8gZmFpbDsKQEAg
LTU1MSw3ICs1NTUsNyBAQCBzdGF0aWMgaW50IGV4dDRmc19kZWxldGVfZmlsZShpbnQgaW5vZGVu
bykKIAkvKiByZWxlYXNlIGlub2RlICovCiAJLyogZnJvbSB0aGUgaW5vZGUgbm8gdG8gYmxvY2tu
byAqLwogCWlub2Rlc19wZXJfYmxvY2sgPSBmcy0+Ymxrc3ogLyBmcy0+aW5vZGVzejsKLQlpYm1h
cF9pZHggPSBpbm9kZW5vIC8gaW5vZGVfcGVyX2dycDsKKwlpYm1hcF9pZHggPSAoaW5vZGVubyAt
IDEpIC8gaW5vZGVfcGVyX2dycDsKIAogCS8qIGdldCB0aGUgYmxvY2sgbm8gKi8KIAlpbm9kZW5v
LS07CkBAIC05MzksNyArOTQzLDkgQEAgaW50IGV4dDRmc193cml0ZShjb25zdCBjaGFyICpmbmFt
ZSwgY29uc3QgY2hhciAqYnVmZmVyLAogCiAJaW5vZGVzX3Blcl9ibG9jayA9IGZzLT5ibGtzeiAv
IGZzLT5pbm9kZXN6OwogCXBhcmVudF9pbm9kZW5vID0gZXh0NGZzX2dldF9wYXJlbnRfaW5vZGVf
bnVtKGZuYW1lLCBmaWxlbmFtZSwgRl9GSUxFKTsKLQlpZiAocGFyZW50X2lub2Rlbm8gPT0gLTEp
CisJaWYgKHBhcmVudF9pbm9kZW5vIDwgMSB8fAorCSAgICAocGFyZW50X2lub2Rlbm8gLSAxKSAv
IGxlMzJfdG9fY3B1KHNibG9jay0+aW5vZGVzX3Blcl9ncm91cCkgPj0KKwkgICAgZnMtPm5vX2Js
a2dycCkKIAkJZ290byBmYWlsOwogCWlmIChleHQ0ZnNfaWdldChwYXJlbnRfaW5vZGVubywgZ19w
YXJlbnRfaW5vZGUpKQogCQlnb3RvIGZhaWw7CkBAIC0xMDMyLDcgKzEwMzgsOCBAQCBpbnQgZXh0
NGZzX3dyaXRlKGNvbnN0IGNoYXIgKmZuYW1lLCBjb25zdCBjaGFyICpidWZmZXIsCiAJdGVtcF9w
dHIgPSB6YWxsb2MoZnMtPmJsa3N6KTsKIAlpZiAoIXRlbXBfcHRyKQogCQlnb3RvIGZhaWw7Ci0J
aWJtYXBfaWR4ID0gaW5vZGVubyAvIGxlMzJfdG9fY3B1KGV4dDRmc19yb290LT5zYmxvY2suaW5v
ZGVzX3Blcl9ncm91cCk7CisJaWJtYXBfaWR4ID0gKGlub2Rlbm8gLSAxKSAvCisJCSAgICBsZTMy
X3RvX2NwdShleHQ0ZnNfcm9vdC0+c2Jsb2NrLmlub2Rlc19wZXJfZ3JvdXApOwogCWlub2Rlbm8t
LTsKIAliZ2QgPSBleHQ0ZnNfZ2V0X2dyb3VwX2Rlc2NyaXB0b3IoZnMsIGlibWFwX2lkeCk7CiAJ
aXRhYmxlX2Jsa25vID0gZXh0NGZzX2JnX2dldF9pbm9kZV90YWJsZV9pZChiZ2QsIGZzKSArCkBA
IC0xMDUzLDcgKzEwNjAsOCBAQCBpbnQgZXh0NGZzX3dyaXRlKGNvbnN0IGNoYXIgKmZuYW1lLCBj
b25zdCBjaGFyICpidWZmZXIsCiAJCS8qIEZJWE1FOiBEZWFsbG9jYXRlIGRhdGEgYmxvY2tzICov
CiAJCWdvdG8gZmFpbDsKIAl9Ci0JaWJtYXBfaWR4ID0gcGFyZW50X2lub2Rlbm8gLyBsZTMyX3Rv
X2NwdShleHQ0ZnNfcm9vdC0+c2Jsb2NrLmlub2Rlc19wZXJfZ3JvdXApOworCWlibWFwX2lkeCA9
IChwYXJlbnRfaW5vZGVubyAtIDEpIC8KKwkJICAgIGxlMzJfdG9fY3B1KGV4dDRmc19yb290LT5z
YmxvY2suaW5vZGVzX3Blcl9ncm91cCk7CiAJcGFyZW50X2lub2Rlbm8tLTsKIAliZ2QgPSBleHQ0
ZnNfZ2V0X2dyb3VwX2Rlc2NyaXB0b3IoZnMsIGlibWFwX2lkeCk7CiAJcGFyZW50X2l0YWJsZV9i
bGtubyA9IGV4dDRmc19iZ19nZXRfaW5vZGVfdGFibGVfaWQoYmdkLCBmcykgKwo=
--000000000000f532e3065e7a17bf--
