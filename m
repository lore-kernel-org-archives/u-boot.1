Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDA606A31E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V6xtmPz0;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cj79bZe2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 813B4608E7;
	Fri, 23 Oct 2026 04:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UIkn8tzV2kGT; Fri, 23 Oct 2026 04:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C8E660674
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731572;
	b=iSV8v5Hf6tfjs5HVaoeUSUqEIq7r9gpj3cE1tjcNkFPTBx/AsMs6GeK5Gzm+MMh30O+e
	 e3aqwmsL8MEL9utdUuVz1vGJTv9/WUfkYs6ASo1bISDZuKRc9MrPnN+/8V0B2zJs3/wPm
	 PXXF+/JKg4aStaroMNS9Wyn9Pf1ii2Jw6CWXBDV4XUtfIRQ1k/PYLJmO957gp6HlwetN2
	 ec1jMFxW1DbakCu0L7mnJ3AzV+3zLZKiVlb4+XbbqPxauC3dcNAwDDvSczJIK4KQ56J+G
	 Wh9gMt45/dYO95OPGte4nV24LcnsozyOcGnRQcvI7N0fpu2C6kp1UPKcAFyK9WCjiBQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kaHWTIsNWL1YeeQ7NkZ1Zfyu1HQ/Akb1LJT3XbWf3J8=;
	b=PIYbERfuLLhejWqOwejBF4Sx+JZSXEo6GfNQWjxZCacEwwkq9WVE4Ck/wkTcq28K7nVO
	 eaGEEddTDQDyGAxJsTYzbRUbrnoGqwt8mpQ9cQTsitl14+aSN7GlvjP490ofP6DVOGkTM
	 JND/u8u7YRFRvzMiFEATskE0v+wnbvHSj2+EkTQ7HwMpeRxvMAOet2Ybs8GlG+H5bq6rD
	 qqWNgEACimuE5BqsoipDJjw0F6WZi9m5hgBGGsq5b81hTIPLcC4d4n7uqiZPk6HP0pDfZ
	 JTmIPaISnSGhxkYTR6EWCginK5TnhHh6ljBA3TkLox4zmg5be2pVxNztmvWiow9DrMg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731572;
	bh=kaHWTIsNWL1YeeQ7NkZ1Zfyu1HQ/Akb1LJT3XbWf3J8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V6xtmPz0vHGPOb/gjRTgaw/wt9qi2uJy5UMd+zguR1rjNZLAnr+lokYrH0OrUiN45
	 0tHO3Itn0Ttnvj6W2ySe8YCho+ip+DZWL/VVdJzc8UJwnHE1ZRTEy/KucZOTHPUkx6
	 swLdWLTLfOkLGNhszF8JIgQd6NMmwojjs5NSp6jBbArp1Lur5E34PT55w1QBJI77Vy
	 yNVfucb1R0mHFhrESoGicZtOrRIa/BOX1nFan1n5SNhzQoNiDqgV+UzTy40YsC0eWN
	 lic843ES+d55USR0qm0rVBbjVy0LAyW0Z5zm9+7Ul18CoIFkJkVY4UwC5xumh0kLWE
	 d2TySpb8e8zfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C8E660674;
	Fri, 23 Oct 2026 04:59:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 428381DE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27B8F8127A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Xkfqaz2mJmL for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 04:06:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C0868126C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:32::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792728391;
 b=oMJIJOXg/N5WIJTaZ/AWuhGU0YqYrHus5hhGXR6FMJqxs0EUYhgrL5hA4JLDpA0+f9U9
 e+rZlbfOpNM74VT2L0sr9/7B++nxm1kfCBXPk8QG+soSKja6magLSIg8suqjfZq2f6exJ
 EmKpJ2+ZsIlZEh+Oo+SRPGcgBwC5/OPE6Sss+TvtGJeuHg8xixrTHyXDUid+5MtvrzYZW
 JiSOpITCjSKBvKdo1Dx8724/Nt/6zOTW3I1srpP4hT5UVru9M2QnB2UqbDnn3ASFPGC5q
 0uiKpxOKK4QjscOHEH6aR/ozZQ2CfkMxcnxaL+O1IxvqJaachH9dQkZ9JvH96Icxh+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792728391;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=kaHWTIsNWL1YeeQ7NkZ1Zfyu1HQ/Akb1LJT3XbWf3J8=;
 b=gu+TvEyPb0g/yxs5Om6NGXwklUVurYbU51P/IA15Mu3SI9IVf79ky2FBXcpIjDs7NUbs
 bJEtzjU5cBVPsF5GoQ1iKy1UCaPvWbymZcvXABrgLJL94w2ZHGilCjVmof/4ZdMOjx2O1
 EeUzQXebSE3sSKfiZK4VjfRo/QWGBaoQfpWZIJa7dB6h/nggwRo33znpeb0pjwcKERugo
 WqxCBpNYwwWDummOzsT9ykYXWAhgv6yY+0OPreZzrQFsrFtK724HsJjZ/V+MI+Zj/PLoT
 iDvs+DvADc0ROWXokDHHhFPQa8TrV7wm6sbbD5SJqYfaGXwYWDBkaoZ8XOcqTZPL6oQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cj79bZe2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:32::3"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::3; helo=mail-oi2-x03.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cj79bZe2
Received: from mail-oi2-x03.google.com (mail-oi2-x03.google.com
 [IPv6:2607:f8b0:4864:32::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C0868126C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:05:46 +0000 (UTC)
Received: by mail-oi2-x03.google.com with SMTP id
 5614622812f47-5413fa881a9so169310b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792728345; cv=none;
 d=google.com; s=arc-20260327;
 b=S8fSNsZaXzMv+XYllqILFuedpZwkKwYq3eTjgpqJVtPjFcULYwhOLZSV3ogX5N1OjA
 02UtlcDY77H1Bh2vjCxGIMb1fw2BI/JvGTwWriMYLLaf+LKYBX2zGUV3MTNb0l9jSoe4
 dUe3Y7cqAZ75k7/qo1GZWz7YwhbUPeKQFW+mPDfWSel4kWkCpSTPLYHhC1jC3dqbRxAK
 Zf/B36DVUcu/eFyqJSeNRJ5i7laaNLBT8T8nHoKumRTZBi07h3LThgX4e4+aMXXNuwz2
 aFW2XVGUrxy3jILxViZ/hBFuCMZ4aaYmmo9YFsXt/ZVqVfbbKyUfjiN9lnDCfreLXFXt
 fYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=kaHWTIsNWL1YeeQ7NkZ1Zfyu1HQ/Akb1LJT3XbWf3J8=;
 fh=fO/i0n3hYJ74cs21KGuyGF2OazYql2f81AfdSYYrRi4=;
 b=Jmt5YET0DsXhoFIUY6mVX2zUABjfxm9CczAdyGy29IiXRm3rmXeYsLO90oafyWscDl
 JGONdMVhQ0aVKWT14rrdZTyJumjkyqh5ipafdvAdsUa2yXdFyQxjVHu8T3VvebYTx5uL
 bVSE/DlQw3OGMBPTqBOWBpiW5eSUuYmh8hkrlQbXXKuZlKPX8h+Py6xKmMZxwCW2RzU/
 Cr4JY+FzU1M++wmBUYoNUQRb7z5xnQW4T8Yg2q2XfGwnMt400wDD8L4v82tZXYUWisNZ
 v0krS6SuZK2oQMH3v8yMNmeS4guXWZkmkep7yHrPGi7wbidBEvgp3scM9pc5q32v2mVa
 fGkg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792728345; x=1793333145;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kaHWTIsNWL1YeeQ7NkZ1Zfyu1HQ/Akb1LJT3XbWf3J8=;
 b=cj79bZe23teINck7kx7JA2TcGsZ772gs/646ySGdTO5p/OEpr5TmVr5Y5WVZTqLjvF
 tAQuMUbuN0qEXxhwED8rbrcFOfPBZuz4F2HwRzQ6gMgELQfj+Pc539kJ4r6Mp7gYelI7
 bXO9cYSynxJwMAJSZOXfNMjvPgcjaf7aSd3MQkMnrFqrMr72qkJ6Ieo/4TIH+4IhePMg
 Rqitpg87JI68cZc2KhaZB36EAd872eisQaSKJcaAHafwfunNYaTtDjI0+l9vYD5AlAOw
 dQm0mreWNOVpOQxPT2yN86edXpPPQgfv+B+CnIJg6HX7KMTdlqeqkgZeUlAVOVSYUaR5
 HHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792728345; x=1793333145;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kaHWTIsNWL1YeeQ7NkZ1Zfyu1HQ/Akb1LJT3XbWf3J8=;
 b=uGgfOkbZXIZuq1Q/4G/uYywaoFOqDRQgObUNykEpGp/dpc2xvzzGf0m4oDo6NfhBSO
 qR4uo18jXjvfzlSBCwbhfvQ7iO3TCPmjwiytPojwHreWkvmCQPofvVi/3ReK6cupdXI6
 AvFuP09jVj8Ky7p9bXtpQZKXHk+ndwqd509p9PIxOLeFv1ykrtTufPgDoGELOuwuyyK3
 Uis3vhBHpue7YYFUiKPSmpnUk7Qxnq36iPSRICmPj1v82GCUrFRWlUlYk/ORKVG3HFYV
 //uOoLhwpssCOqNK9FH5jo41tVybbt2YM80C/gDxCGZdC3yy6yalXh046J5pj2tLL8WQ
 EMdw==
X-Gm-Message-State: AFq9FYJJE2PNlMlsI2J4mYgl6uAYAF6U5Y+ZvB2JRY9Fd4o9AH8fu+Zi
 fyyXBEtxpmfuvGxzhA/46KawZkH3ioaa3Yq/TuPekMf0+h/32Q6iO9sLNi8ux28AgvBSpiQPmtA
 zSjCM60+3uc7AVWwaR7e4TZTb1mLTL77ldczqDyI=
X-Gm-Gg: AYBFou3vdIlvOoN0LRVOWjMbR6fgzxEtA+IZesjGqbP5D+EjFkh1Hz6GkSRqcdgsK1U
 wUkvudY3YnXRT9OJiFlVOkE+1RBXL7Gp4Sael+rj5I98W5Up2LJYrCw4r2Qkg8wDxRfGzv2t3TU
 pGAA076hVsJP6HYUZ4l1vBxcDtLB/4sFhUoaiaeVm8EwNOcTPRCldFpALe4AAGeC99lwRvyYaCU
 lo86c/MArmVrK5NY5SsBNSsEdyh6K5fBVaB13Y+DKDxzPwL86gNG0EtsZopMuaaqOWNy2SiiNFQ
 oT+0ODRmbL4IHkOXCqQ8We4uQHFJDI/xbOxltCiTb52HkOldFej6fKioWv5yXxpSspFE32WVfTB
 rMXgrL+J3pVLDyDXusNIQtoU=
X-Received: by 2002:a05:6808:1686:b0:4b9:e65b:8c30 with SMTP id
 5614622812f47-55be863e88cmr657308b6e.30.1792728345411; Thu, 22 Oct 2026
 21:05:45 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:44 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:44 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
References: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 21:05:44 -0700
X-Gm-Features: AclHuK9BK_q3MP8qhO-_0_-tmTnHbPqIOyM_mXMLHrlWvVF7psUXoBny7gAVe8M
Message-ID: <CAJnxHshd==k8e=Ddwcw01hS9RGPsNHjbbFZkdJ6pnNM600Vvww@mail.gmail.com>
Subject: [PATCH 6/6] test: fs: ext4: add tests for corrupt on-disk indices
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: multipart/mixed; boundary="000000000000351d07065e7a1812"
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

--000000000000351d07065e7a1812
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--000000000000351d07065e7a1812
Content-Type: text/plain; charset="utf-8"; name="0006.patch"
Content-Disposition: attachment; filename="0006.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 655594f1f3f4d7d4_0.1

QWRkIHRlc3RzIHRoYXQgbWFrZSBhIHNtYWxsIGV4dDQgaW1hZ2Ugd2l0aCBta2ZzLmV4dDQsIGNv
cnJ1cHQgb25lCm9uLWRpc2sgZmllbGQgYW5kIGNoZWNrIHRoYXQgVS1Cb290IHJlamVjdHMgdGhl
IGltYWdlIGFuZCBpcyBzdGlsbApyZXNwb25zaXZlIGFmdGVyd2FyZHM6CgotIHRlc3RfZnNfZXh0
X29vYl9leHRlbnRfaGVhZGVyOiBhbiBleHRlbnQgaGVhZGVyIHdpdGggbW9yZSBlbnRyaWVzCiAg
dGhhbiB0aGUgaW5vZGUgY2FuIGhvbGQgbXVzdCBnaXZlICJpbnZhbGlkIGV4dGVudCBibG9jayIK
LSB0ZXN0X2ZzX2V4dF9vb2JfZGVsZXRlX2Jsb2NrOiByZXBsYWNpbmcgYSBmaWxlIHdob3NlIGlu
ZGlyZWN0IGJsb2NrCiAgbGllcyBwYXN0IHRoZSBlbmQgb2YgdGhlIGZpbGVzeXN0ZW0gbXVzdCBm
YWlsIHdpdGggIkludmFsaWQgYmxvY2sKICBudW1iZXIiCi0gdGVzdF9mc19leHRfb29iX2dyb3Vw
X2xheW91dDogd3JpdGluZyB0byBhIGZpbGVzeXN0ZW0gd2l0aAogIHNfYmxvY2tzX3Blcl9ncm91
cCBvZiB6ZXJvIG11c3QgYmUgcmVmdXNlZAotIHRlc3RfZnNfZXh0X29vYl9kZWxldGVfaW5vZGU6
IHJlcGxhY2luZyBhIGZpbGUgd2hvc2UgZGlyZWN0b3J5IGVudHJ5CiAgbmFtZXMgYW4gaW5vZGUg
cGFzdCB0aGUgbGFzdCBibG9jayBncm91cCBtdXN0IGZhaWwKClNpZ25lZC1vZmYtYnk6IEFuYSBC
b2JpbGxvIDxhbmFib2JpbGxvM0BnbWFpbC5jb20+Ci0tLQogc2NyaXB0cy9weWxpbnQuYmFzZSAg
ICAgICAgICAgICAgICAgICB8ICAgMSArCiB0ZXN0L3B5L3Rlc3RzL3Rlc3RfZnMvdGVzdF9leHRf
b29iLnB5IHwgMTQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDE0OCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9weWxpbnQuYmFzZSBiL3Nj
cmlwdHMvcHlsaW50LmJhc2UKaW5kZXggYmMzOWUyMzg1YTMuLjRjNjE4ZTRkMDMyIDEwMDY0NAot
LS0gYS9zY3JpcHRzL3B5bGludC5iYXNlCisrKyBiL3NjcmlwdHMvcHlsaW50LmJhc2UKQEAgLTUw
LDYgKzUwLDcgQEAgdGVzdF90ZXN0c190ZXN0X2ZzX2ZzdGVzdF9oZWxwZXJzLnB5IDQuMjkKIHRl
c3RfdGVzdHNfdGVzdF9mc190ZXN0X2Jhc2ljLnB5IDEuOTAKIHRlc3RfdGVzdHNfdGVzdF9mc190
ZXN0X2Vyb2ZzLnB5IDguOTcKIHRlc3RfdGVzdHNfdGVzdF9mc190ZXN0X2V4dC5weSAxLjQ4Cit0
ZXN0X3Rlc3RzX3Rlc3RfZnNfdGVzdF9leHRfb29iLnB5IDguMDAKIHRlc3RfdGVzdHNfdGVzdF9m
c190ZXN0X2ZzX2NtZC5weSA4LjAwCiB0ZXN0X3Rlc3RzX3Rlc3RfZnNfdGVzdF9mc19mYXQucHkg
Mi41MAogdGVzdF90ZXN0c190ZXN0X2ZzX3Rlc3RfbWtkaXIucHkgMy4wNApkaWZmIC0tZ2l0IGEv
dGVzdC9weS90ZXN0cy90ZXN0X2ZzL3Rlc3RfZXh0X29vYi5weSBiL3Rlc3QvcHkvdGVzdHMvdGVz
dF9mcy90ZXN0X2V4dF9vb2IucHkKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAw
MDAuLmE1NDBjODIwMGUxCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdC9weS90ZXN0cy90ZXN0X2Zz
L3Rlc3RfZXh0X29vYi5weQpAQCAtMCwwICsxLDE0NyBAQAorIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMCsKKworIiIiVGVzdCBleHQ0IGhhbmRsaW5nIG9mIGNvcnJ1cHQgb24tZGlz
ayBpbmRpY2VzCisKK0VhY2ggdGVzdCBtYWtlcyBhIHNtYWxsIGV4dDQgaW1hZ2Ugd2l0aCBta2Zz
LmV4dDQsIGNvcnJ1cHRzIG9uZSBvbi1kaXNrCitmaWVsZCB3aXRoIGRlYnVnZnMgYW5kIGNoZWNr
cyB0aGF0IFUtQm9vdCByZWplY3RzIHRoZSBpbWFnZSBhbmQgaXMgc3RpbGwKK3Jlc3BvbnNpdmUg
YWZ0ZXJ3YXJkcy4KKyIiIgorCitpbXBvcnQgb3MKK2ltcG9ydCBzdHJ1Y3QKK2Zyb20gc3VicHJv
Y2VzcyBpbXBvcnQgcnVuLCBjaGVja19vdXRwdXQKK2ltcG9ydCBweXRlc3QKK2Zyb20gZnN0ZXN0
X2RlZnMgaW1wb3J0IEFERFIKKyMgcHlsaW50OiBkaXNhYmxlPUUwNjExCitmcm9tIHRlc3RzLmZz
X2hlbHBlciBpbXBvcnQgbWtfZnMKKworCitkZWYgbWFrZV92aWN0aW0odWJtYW4sIHByZWZpeCwg
Y21kcyk6CisgICAgIiIiTWFrZSBhbiBleHQ0IGltYWdlIGhvbGRpbmcgL3ZpY3RpbSwgdGhlbiBy
dW4gZGVidWdmcyBjb21tYW5kcyBvbiBpdAorCisgICAgQXJnczoKKyAgICAgICAgdWJtYW4gKENv
bnNvbGVCYXNlKTogVS1Cb290IGNvbnNvbGUKKyAgICAgICAgcHJlZml4IChzdHIpOiBwcmVmaXgg
b2YgdGhlIGltYWdlIGZpbGUgbmFtZQorICAgICAgICBjbWRzIChsaXN0IG9mIHN0cik6IGRlYnVn
ZnMgY29tbWFuZHMgdG8gcnVuIG9uIHRoZSBpbWFnZQorCisgICAgUmV0dXJuczoKKyAgICAgICAg
c3RyOiBwYXRoIG9mIHRoZSBpbWFnZQorICAgICIiIgorICAgIGltZyA9IG1rX2ZzKHVibWFuLmNv
bmZpZywgJ2V4dDQnLCA4IDw8IDIwLCBwcmVmaXgpCisgICAgc3JjID0gaW1nICsgJy52aWN0aW0n
CisgICAgd2l0aCBvcGVuKHNyYywgJ3diJykgYXMgZmlsOgorICAgICAgICBmaWwud3JpdGUoYid2
aWN0aW0gZmlsZVxuJykKKyAgICBzY3JpcHQgPSAnXG4nLmpvaW4oWyd3cml0ZSAlcyB2aWN0aW0n
ICUgc3JjXSArIGNtZHMpICsgJ1xuJworICAgIHJ1bihbJ2RlYnVnZnMnLCAnLXcnLCAnLWYnLCAn
LScsIGltZ10sIGlucHV0PXNjcmlwdC5lbmNvZGUoKSwKKyAgICAgICAgY2FwdHVyZV9vdXRwdXQ9
VHJ1ZSwgY2hlY2s9VHJ1ZSkKKyAgICBvcy5yZW1vdmUoc3JjKQorICAgIHJldHVybiBpbWcKKwor
CitkZWYgcmVhZF9hdChpbWcsIG9mZnNldCwgc2l6ZSk6CisgICAgIiIiUmVhZCBzaXplIGJ5dGVz
IG9mIHRoZSBpbWFnZSBhdCBvZmZzZXQiIiIKKyAgICB3aXRoIG9wZW4oaW1nLCAncmInKSBhcyBm
aWw6CisgICAgICAgIGZpbC5zZWVrKG9mZnNldCkKKyAgICAgICAgcmV0dXJuIGZpbC5yZWFkKHNp
emUpCisKKworZGVmIHZpY3RpbV9maWVsZChpbWcsIGZpZWxkKToKKyAgICAiIiJSZWFkIGJhY2sg
YW4gaW5vZGUgZmllbGQgb2YgL3ZpY3RpbSB3aXRoIGRlYnVnZnMiIiIKKyAgICBvdXQgPSBjaGVj
a19vdXRwdXQoWydkZWJ1Z2ZzJywgJy1SJywgJ3N0YXQgdmljdGltJywgaW1nXSwKKyAgICAgICAg
ICAgICAgICAgICAgICAgc3RkZXJyPW9wZW4ob3MuZGV2bnVsbCwgJ3cnKSkuZGVjb2RlKCkKKyAg
ICByZXR1cm4gb3V0IGlmIGZpZWxkIGluIG91dCBlbHNlICcnCisKKworQHB5dGVzdC5tYXJrLmJv
YXJkc3BlYygnc2FuZGJveCcpCitAcHl0ZXN0Lm1hcmsuYnVpbGRjb25maWdzcGVjKCdjbWRfZXh0
NCcpCitAcHl0ZXN0Lm1hcmsucmVxdWlyZWR0b29sKCdkZWJ1Z2ZzJykKK2RlZiB0ZXN0X2ZzX2V4
dF9vb2JfZXh0ZW50X2hlYWRlcih1Ym1hbik6CisgICAgIiIiZXh0NGZzX2dldF9leHRlbnRfYmxv
Y2soKTogYW4gZXh0ZW50IGhlYWRlciBjbGFpbWluZyBtb3JlIGVudHJpZXMKKyAgICB0aGFuIHRo
ZSBpbm9kZSdzIGlfYmxvY2sgYXJlYSBob2xkcyBtdXN0IGJlIHJlamVjdGVkIiIiCisgICAgIyBp
X2Jsb2NrWzBdID0gZWhfbWFnaWMgfCBlaF9lbnRyaWVzIDw8IDE2OiAyNTUgZW50cmllcywgZWhf
bWF4IHN0YXlzIDQKKyAgICBpbWcgPSBtYWtlX3ZpY3RpbSh1Ym1hbiwgJ2V4dF9vb2JfZWgnLCBb
J3NpZiB2aWN0aW0gYmxvY2tbMF0gMHgwMGZmZjMwYSddKQorICAgIGFzc2VydCB2aWN0aW1fZmll
bGQoaW1nLCAnRmxhZ3M6IDB4ODAwMDAnKQorCisgICAgdWJtYW4ucnVuX2NvbW1hbmQoJ2hvc3Qg
YmluZCAwICVzJyAlIGltZykKKyAgICBvdXQgPSB1Ym1hbi5ydW5fY29tbWFuZCgnZXh0NGxvYWQg
aG9zdCAwOjAgJXggL3ZpY3RpbScgJSBBRERSKQorICAgIGFzc2VydCAnaW52YWxpZCBleHRlbnQg
YmxvY2snIGluIG91dAorICAgIGFzc2VydCAnYWxpdmUnIGluIHVibWFuLnJ1bl9jb21tYW5kKCdl
Y2hvIGFsaXZlJykKKyAgICBvcy5yZW1vdmUoaW1nKQorCisKK0BweXRlc3QubWFyay5ib2FyZHNw
ZWMoJ3NhbmRib3gnKQorQHB5dGVzdC5tYXJrLmJ1aWxkY29uZmlnc3BlYygnY21kX2V4dDRfd3Jp
dGUnKQorQHB5dGVzdC5tYXJrLnJlcXVpcmVkdG9vbCgnZGVidWdmcycpCitkZWYgdGVzdF9mc19l
eHRfb29iX2RlbGV0ZV9ibG9jayh1Ym1hbik6CisgICAgIiIiZGVsZXRlX3NpbmdsZV9pbmRpcmVj
dF9ibG9jaygpOiByZXBsYWNpbmcgYSBmaWxlIHdob3NlIGluZGlyZWN0IGJsb2NrCisgICAgbGll
cyBwYXN0IHRoZSBlbmQgb2YgdGhlIGZpbGVzeXN0ZW0gbXVzdCBmYWlsIGJlZm9yZSBpdCBpcyBy
ZWxlYXNlZCIiIgorICAgICMgTWFrZSAvdmljdGltIGEgYmxvY2stbWFwcGVkIGZpbGUgd2hvc2Ug
b25seSBiYWQgZmllbGQgaXMgYmxvY2tbSU5EXQorICAgIGNtZHMgPSBbJ3NpZiB2aWN0aW0gZmxh
Z3MgMCcsICdzaWYgdmljdGltIHNpemUgNDA5NicsCisgICAgICAgICAgICAnc2lmIHZpY3RpbSBi
bG9ja1tJTkRdIDB4MDBmZmZmMDAnXQorICAgIGNtZHMgKz0gWydzaWYgdmljdGltIGJsb2NrWyVk
XSAwJyAlIGkgZm9yIGkgaW4gcmFuZ2UoMTIpXQorICAgIGltZyA9IG1ha2VfdmljdGltKHVibWFu
LCAnZXh0X29vYl9kZWwnLCBjbWRzKQorICAgIGFzc2VydCB2aWN0aW1fZmllbGQoaW1nLCAnKElO
RCk6MTY3NzY5NjAnKQorCisgICAgdWJtYW4ucnVuX2NvbW1hbmQoJ2hvc3QgYmluZCAwICVzJyAl
IGltZykKKyAgICB1Ym1hbi5ydW5fY29tbWFuZCgnbXcuYiAleCA0MSAxMDAwJyAlIEFERFIpCisg
ICAgb3V0ID0gdWJtYW4ucnVuX2NvbW1hbmQoJ2V4dDR3cml0ZSBob3N0IDA6MCAleCAvdmljdGlt
IDB4MTAwMCcgJSBBRERSKQorICAgIGFzc2VydCAnSW52YWxpZCBibG9jayBudW1iZXInIGluIG91
dAorICAgIGFzc2VydCAnd3JpdHRlbicgbm90IGluIG91dAorICAgIGFzc2VydCAnYWxpdmUnIGlu
IHVibWFuLnJ1bl9jb21tYW5kKCdlY2hvIGFsaXZlJykKKyAgICBvcy5yZW1vdmUoaW1nKQorCisK
K0BweXRlc3QubWFyay5ib2FyZHNwZWMoJ3NhbmRib3gnKQorQHB5dGVzdC5tYXJrLmJ1aWxkY29u
Zmlnc3BlYygnY21kX2V4dDRfd3JpdGUnKQorQHB5dGVzdC5tYXJrLnJlcXVpcmVkdG9vbCgnZGVi
dWdmcycpCitkZWYgdGVzdF9mc19leHRfb29iX2dyb3VwX2xheW91dCh1Ym1hbik6CisgICAgIiIi
ZXh0NGZzX2luaXQoKTogYSBzdXBlcmJsb2NrIHdpdGggemVybyBibG9ja3MgcGVyIGdyb3VwIG11
c3QgbWFrZQorICAgIHdyaXRlcyBmYWlsIHJhdGhlciB0aGFuIGRpdmlkZSBieSB6ZXJvIiIiCisg
ICAgaW1nID0gbWFrZV92aWN0aW0odWJtYW4sICdleHRfb29iX2dlbycsIFtdKQorICAgICMgc19i
bG9ja3NfcGVyX2dyb3VwIGlzIGF0IG9mZnNldCAzMiBvZiB0aGUgc3VwZXJibG9jayBhdCBieXRl
IDEwMjQKKyAgICB3aXRoIG9wZW4oaW1nLCAncitiJykgYXMgZmlsOgorICAgICAgICBmaWwuc2Vl
aygxMDI0ICsgMzIpCisgICAgICAgIGZpbC53cml0ZShzdHJ1Y3QucGFjaygnPEknLCAwKSkKKwor
ICAgIHVibWFuLnJ1bl9jb21tYW5kKCdob3N0IGJpbmQgMCAlcycgJSBpbWcpCisgICAgdWJtYW4u
cnVuX2NvbW1hbmQoJ213LmIgJXggNDEgMTAwMCcgJSBBRERSKQorICAgIG91dCA9IHVibWFuLnJ1
bl9jb21tYW5kKCdleHQ0d3JpdGUgaG9zdCAwOjAgJXggL25ld2ZpbGUgMHgxMDAwJyAlIEFERFIp
CisgICAgYXNzZXJ0ICdVbnN1cHBvcnRlZCBibG9jayBncm91cCBsYXlvdXQnIGluIG91dAorICAg
IGFzc2VydCAnd3JpdHRlbicgbm90IGluIG91dAorICAgIGFzc2VydCAnYWxpdmUnIGluIHVibWFu
LnJ1bl9jb21tYW5kKCdlY2hvIGFsaXZlJykKKyAgICBvcy5yZW1vdmUoaW1nKQorCisKK0BweXRl
c3QubWFyay5ib2FyZHNwZWMoJ3NhbmRib3gnKQorQHB5dGVzdC5tYXJrLmJ1aWxkY29uZmlnc3Bl
YygnY21kX2V4dDRfd3JpdGUnKQorQHB5dGVzdC5tYXJrLnJlcXVpcmVkdG9vbCgnZGVidWdmcycp
CitkZWYgdGVzdF9mc19leHRfb29iX2RlbGV0ZV9pbm9kZSh1Ym1hbik6CisgICAgIiIiZXh0NGZz
X2RlbGV0ZV9maWxlKCk6IHJlcGxhY2luZyBhIGZpbGUgd2hvc2UgZGlyZWN0b3J5IGVudHJ5IG5h
bWVzIGFuCisgICAgaW5vZGUgcGFzdCB0aGUgbGFzdCBibG9jayBncm91cCBtdXN0IGZhaWwiIiIK
KyAgICBpbWcgPSBtYWtlX3ZpY3RpbSh1Ym1hbiwgJ2V4dF9vb2JfaW5vJywgW10pCisgICAgIyBQ
b2ludCB0aGUgL3ZpY3RpbSBlbnRyeSBvZiB0aGUgcm9vdCBkaXJlY3RvcnkgYXQgYW4gaW5vZGUg
bnVtYmVyIGZhcgorICAgICMgYmV5b25kIHRoZSBpbm9kZSBjb3VudCAoZGVidWdmcyByZWZ1c2Vz
IHRvIGxpbmsgYSBtaXNzaW5nIGlub2RlKQorICAgIGJsayA9IGludChjaGVja19vdXRwdXQoWydk
ZWJ1Z2ZzJywgJy1SJywgJ2JtYXAgLyAwJywgaW1nXSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0ZGVycj1vcGVuKG9zLmRldm51bGwsICd3JykpLmRlY29kZSgpKQorICAgIGJsa3N6ID0g
MTAyNCA8PCBzdHJ1Y3QudW5wYWNrKCc8SScsIHJlYWRfYXQoaW1nLCAxMDI0ICsgMjQsIDQpKVsw
XQorICAgIGRhdGEgPSBieXRlYXJyYXkocmVhZF9hdChpbWcsIGJsayAqIGJsa3N6LCBibGtzeikp
CisgICAgb2ZmID0gMAorICAgIHdoaWxlIG9mZiA8IGJsa3N6OgorICAgICAgICByZWNfbGVuLCBu
YW1lX2xlbiA9IHN0cnVjdC51bnBhY2tfZnJvbSgnPEhCJywgZGF0YSwgb2ZmICsgNCkKKyAgICAg
ICAgaWYgZGF0YVtvZmYgKyA4Om9mZiArIDggKyBuYW1lX2xlbl0gPT0gYid2aWN0aW0nOgorICAg
ICAgICAgICAgc3RydWN0LnBhY2tfaW50bygnPEknLCBkYXRhLCBvZmYsIDEwMDAwMDApCisgICAg
ICAgICAgICBicmVhaworICAgICAgICBvZmYgKz0gcmVjX2xlbgorICAgIGVsc2U6CisgICAgICAg
IHB5dGVzdC5mYWlsKCdubyAvdmljdGltIGVudHJ5IGluIHRoZSByb290IGRpcmVjdG9yeScpCisg
ICAgd2l0aCBvcGVuKGltZywgJ3IrYicpIGFzIGZpbDoKKyAgICAgICAgZmlsLnNlZWsoYmxrICog
Ymxrc3opCisgICAgICAgIGZpbC53cml0ZShkYXRhKQorCisgICAgdWJtYW4ucnVuX2NvbW1hbmQo
J2hvc3QgYmluZCAwICVzJyAlIGltZykKKyAgICB1Ym1hbi5ydW5fY29tbWFuZCgnbXcuYiAleCA0
MSAxMDAwJyAlIEFERFIpCisgICAgb3V0ID0gdWJtYW4ucnVuX2NvbW1hbmQoJ2V4dDR3cml0ZSBo
b3N0IDA6MCAleCAvdmljdGltIDB4MTAwMCcgJSBBRERSKQorICAgIGFzc2VydCAnSW52YWxpZCBp
bm9kZSBudW1iZXInIGluIG91dAorICAgIGFzc2VydCAnd3JpdHRlbicgbm90IGluIG91dAorICAg
IGFzc2VydCAnYWxpdmUnIGluIHVibWFuLnJ1bl9jb21tYW5kKCdlY2hvIGFsaXZlJykKKyAgICBv
cy5yZW1vdmUoaW1nKQo=
--000000000000351d07065e7a1812--
