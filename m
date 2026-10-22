Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CB9606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MzCUnkSq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ict8hfMn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B165440A48;
	Fri, 23 Oct 2026 00:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hq53aHOvK20Q; Fri, 23 Oct 2026 00:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C16A40A42
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792714397;
	b=UUtP6enKDROHK9xhvj/ID0GKXqVIwhGUJ8wCvz0dE+cz/4jiIMNc8LFyZG7tc/hnjztc
	 80z3+QF3ekOu/6ds15NKSiOgq7ykyL1UlumkedIVl8SXfAHZNAkRX8/JKY/8iVUeKkaRC
	 h3uotK8VjQYLvVehzJbSuUR4kOZRNsR+gIKjHUZQrOAdN33K6SWm9ud7cQET1JNT6YRyc
	 DB/5sOWhY8PPqBVhcT0tTYN3MI/vffn7Utcr5mymE5fzUQzvOnyXTW+JCYv3tGiK1Ea6V
	 F9K7HRsyYaolySf+Dsh1Npq3O9h/HJBF0BGYfMd86V8TJJTFF3/FbWHc1BMYs3qYDug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792714397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pUev4sIx8txMQQXXZVG/XeKQHLwc/HHNImiGAayDhWs=;
	b=KyX6p9zqL0APdMABL3QbhomHymcHd+IUkjKfl+L7HPzFwcqae5ObMLydHo6yP4al3+9P
	 fywzNouniwRq35Lm6xNqAYU7LU7w/SG/GdZWPdTMIgLqSBg5zw4UQiVAFTRkvtEjPGxPG
	 AoZU0nrG82NukSpP3WysvwdAwjnyowbfBNowS89U1v7q2vxHFW3OwzRqoOVbRT+Lb0BUd
	 NCKQcCTALR7v6lpI0vECGIBFLk5ZB5PxAbTkEtrb3abdfDSPSdXahxD/6Phw2+fbeSwZ4
	 IB4ix7REpKfixwRbFFnvr8Frkk5LSRZ5l5SzcPT6mN9WxgD5lH7JxBn12piB+SQTFoQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792714397;
	bh=pUev4sIx8txMQQXXZVG/XeKQHLwc/HHNImiGAayDhWs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MzCUnkSqVAQgaj12ObrxegI+bmHBI2yZDhb0nAvcdWhCUWZE0P7KbNj/7Gkaw0DrW
	 z01uKBjZlWvj4SdrE2nSbKl7A29X/xiVCF8egk93+Ceh0Js5ilCT89jqQlP9nU2q7W
	 kkBxL+Myx6Shpz5B8tsFW2mwwwAyUFFHTmGkL1g8QAeUllqMTuNcC5PLfeXj8ba7b4
	 wmPHO49i/xJrO6h1ae2lBJoCiCg2s31x/Lt79T2J1SzQ5V1XpuI2E3tZcMSQ9edrST
	 HwkkChdRvHtYAZBz7DwLN7G9aiiRzYywVUay1/ws8dPi9oDGvXC74pPliNykldPB7I
	 TWSyaNeM0/T5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C16A40A42;
	Fri, 23 Oct 2026 00:13:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D6C249D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F42380DBB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wku3d-HZfKtg for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95A7080D88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792713230;
 b=FZ2yVtscvGfRi2poD8gXdWXGQFvOvyDIZGN23iuglzGsdg1ZgH0fJwe46uDDyyGLOZV7
 mLYPu0LLlmvAJeeH2ZbGn+82dj5Nvz4Fq8vg0TDAmHHF+MV9B7l4gIb7Lke6TAkjRG0bL
 PJ+Lcc38LQuZuo1hnluBUJttEdaeOS33AwLofjcu5P0rlNxqzIUJ+14fuuR7S318dvmM9
 VKfkWVvSp8JHJQaPzatqumOgi8qmwq4kaRU7F1FZL39iudhGmRVogkxGIu+KsU9AMgXsi
 t0NVCcDBhpT2gluae0tCzLtfyZXK1GXDt7rbjEHcpDhWEaW5nYwb+wwfEjOG7Vt1zQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792713230;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=pUev4sIx8txMQQXXZVG/XeKQHLwc/HHNImiGAayDhWs=;
 b=SXiPRSf+Rwx3GLtDAj1l3NaVDSDJff6EFYuCzIMfj56Fcwj7knL9yYfbMGa518uO6jL4
 +2g2BCI7Pqbdo//FGbxQOIW4Cew6vm3OQRtP5/TqWSq9zTQvl4zq3/D2m3UV1jbD+TQqU
 /6fHGPy+L1dN5Aw6TjPOi1casrT9ZWsShXN4UFBcoTllj5+GCekzQ8Qf6LamyAhgtVzUw
 WGxTiQRT71jjeyv+jbvwszMmDPF/M9hpdp3fMZU/PzWHTNAF68/aQMjibDmhupQNywfm8
 2Ynpm8kbCc0kPEb+LDIWrabNrjdAu3NKxFE3OtCYm256l3dTYFdyYU1Vjn1dncn4Kdw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ict8hfMn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ict8hfMn
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95A7080D88
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:50 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-833e671ee9fso262478a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792713229; cv=none;
 d=google.com; s=arc-20260327;
 b=rxnhXP0VapQeguxkA99oHRWEbF7ZbdJo1zHnS0JEY68uh+MlsBm4vJKfEU3H4EOuOj
 6Rc9m7o38AaVDoQ4psYYLhKB6qe6ZtXk++KY3TecrBbVpS08UFK6LY/n1A9EsyBKip2s
 +OtpYnCiEK86yt5zk0kflnF+M/515Xl9/hRJXtwxnzqoGFhlWN9OuV9KYKZbJWKJrwft
 LxODhA9cKMM2d8r+b6Sk+5F8IJDG8+AgR4gXnmbN3GD1ShETszjYHZW1/NGEy0IS7xWY
 IZhVzfOLMAB9VY/014Q7w2Lvx/bms1Ep//HkZNIlCHLFRhN6e5CMzfzoyab/dZDvMeSm
 aU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=pUev4sIx8txMQQXXZVG/XeKQHLwc/HHNImiGAayDhWs=;
 fh=u4xG2KwCOaAX3LACWiWdBW7foS+n2V4JX1MkoNaREaI=;
 b=GKWhWcCHAAL9oV+cMzB/449Fi8jZc4tWrwZmp1ddQP5aiZ+4R0YroS9kTtojBzVNOC
 hON6zpELREqP26LXe1S+p23QQsdU6RJ8DUKFZvNUfFfs+j2cjgQxe2UewXiHtka6/goL
 lmr5/8Cm98IW9ycbcidrSiTC2LbvSPyukfVnH5GdhBzZ8M5zxPrFdH9f33vp0UkzUEEx
 yAKCRSsYoJn8eAmO8F5rVvQ825D9lDsH16dm6jR3WtMnqGjFkqa9CNaYJG7o4EUrYQ/e
 btqaMuFzQv31wOvi30dy3pOU87SUkjWUSQ8UrYLyD50/xUxZ0+xb3tE9ZyAs6sdrSmvd
 ugrQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792713229; x=1793318029;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pUev4sIx8txMQQXXZVG/XeKQHLwc/HHNImiGAayDhWs=;
 b=ict8hfMnviTuuioQD72lpGq6EsBBgUCBFTogO2OFsp0CHmh3Z98ftmj3ee6SK/2AV4
 jQDJVXNHtzAMeBtSrYmNJfoqUeOW11vbCGVCpgK+vb0AgSfahVUOTpqrJPhrOIJqCYAT
 qFg5Orr2kf8eqJiCUIbs/hmzLTr2wnWFUtN4Qlyj45yaBE5XgK2U8fNdNUZovYEVcT00
 /RY8lnExdK4+R+GiUPWKN+w5v+5FCR3F3DNVQIzxxKsiB77GO/lDWzLCwtg273mB6hDR
 +3mdShOEyRFn00xwaVvfGKZbcC55WmqDeaIArPXLQlMC5XIejP2871YR+x8vrvNEdUxU
 tfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713229; x=1793318029;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pUev4sIx8txMQQXXZVG/XeKQHLwc/HHNImiGAayDhWs=;
 b=1KJrJrIIleRRl5E0zB71qo5t+ah6mEh+nIsBmkblgAHyCaMgZeRLujtRLXRK2NWRLw
 mg0MUsYvkWKDvN24wLGtjeY8f4eUbB7JdNCegQ5hxdz/40ahAh/+3xrjgF36f5zAnWK4
 J6GCIXZ1T6Qy9l0GS8Xy6h3XQyyXYjpaV+m34tCiPIXXAL/MaFRIjhlfeq/rJA6uT1O3
 jnf7//6ZfCxyMqXzoMvi7xIQpLg/KK2hbJ8/DOPD+4gPhSR9AFWgASXbIYpVSf3FaaSy
 HG+h+jBaKrd+mBVIFynFgeuqTE6z8oB5j57dlGQoKXS5Y9NrZ3PonAF6gyu10dr4YP+Z
 geVw==
X-Gm-Message-State: AFq9FYIY9AuHJlKMiCULOHaSLoi/79bA6VdB3uaKNZfP+T69cA58YC/G
 aCbgByLdSkdqhqhWmIjtwjqO37vYJO/eTbiNAcRzZ6HkNWmDDWr3CWo4ywtVNe+wUZ4CknRsMJj
 Zq1I2lOJ9lmLkCBRRKy8WW2ANWZO24poaRNja
X-Gm-Gg: AYBFou3zgQOU9VoPrT1La27sGxuw7UeIK3FX4u1Ai4NLZr6cnywfw5LiV+HA+KiGR79
 91tPm1DGv9QhRiKmE3WJ3T0qeyBGb1Ej0HGs3T824XUMMp+TG8bcntafVK45+N2+xwbpYij5Sgm
 Y8LYdcFjZ21n/ExtcYtQjxglWuzMcIz3rRG7MtFEcZd3K5tlcqqE2xhOTDmFBO1zPY1Y1o4cRpU
 Ck4hBABHrVXVLorRxgaSGTa9Grgu1UHEzRtbOkZzS4s96Qmq7yDzdn7owwFW8GHvjat9vWFNPo6
 Xj86X2dBNfUUNkG/2D3r3Tlinv3b3khiftMzxB5fqBW4n0rmfKrkyNXg5SqxkkBLVXd5Senf4gQ
 EdLRKOV4ZBFk7/S7qJ30Fak0=
X-Received: by 2002:a05:6808:178b:b0:4b2:8d7b:390b with SMTP id
 5614622812f47-55be80ce141mr415465b6e.19.1792713229378; Thu, 22 Oct 2026
 16:53:49 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:48 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:48 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
References: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 16:53:48 -0700
X-Gm-Features: AclHuK8bpo1V0eE8gh6ZFd5YbtHETFCBHZsYJMjx9gKXMhmXNpImndAUM7Gn5jc
Message-ID: <CAJnxHsiWa3KD+Xaep2WDxeC0sPo4RTHXSRS_v5GPLpAeLKuixg@mail.gmail.com>
Subject: [PATCH 5/6] efi_loader: firmware: check the FMP payload header size
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: multipart/mixed; boundary="00000000000038bf88065e769335"
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

--00000000000038bf88065e769335
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000038bf88065e769335
Content-Type: text/plain; charset="utf-8"; name="0005.patch"
Content-Disposition: attachment; filename="0005.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6aad02a90308625a_0.1

ZWZpX2Zpcm13YXJlX2dldF9md192ZXJzaW9uKCkgcmVhZHMgYW4gRk1QIHBheWxvYWQgaGVhZGVy
IGF0IHRoZSBzdGFydApvZiBhbiBpbWFnZSB3aXRob3V0IGNoZWNraW5nIHRoYXQgdGhlIGltYWdl
IGhvbGRzIG9uZSwgYW5kIHNraXBzIGl0IGJ5Cml0cyBoZWFkZXJfc2l6ZSB3aXRob3V0IGNoZWNr
aW5nIHRoYXQgYWdhaW5zdCB0aGUgaW1hZ2Ugc2l6ZS4gQQpoZWFkZXJfc2l6ZSBsYXJnZXIgdGhh
biB0aGUgaW1hZ2UgbWFrZXMgdGhlIGltYWdlIHNpemUgd3JhcCBhcm91bmQKYmVmb3JlIHRoZSBp
bWFnZSBpcyB3cml0dGVuLgoKT25seSBsb29rIGZvciB0aGUgaGVhZGVyIGluIGFuIGltYWdlIGxh
cmdlIGVub3VnaCB0byBob2xkIGl0LCBhbmQKcmVqZWN0IGEgaGVhZGVyX3NpemUgc21hbGxlciB0
aGFuIHRoZSBoZWFkZXIgb3IgbGFyZ2VyIHRoYW4gdGhlIGltYWdlLgoKV2l0aCBDT05GSUdfRUZJ
X0NBUFNVTEVfQVVUSEVOVElDQVRFIHRoZSBoZWFkZXIgaXMgcGFydCBvZiB0aGUgc2lnbmVkCmlt
YWdlLCBzbyB0aGVyZSB0aGlzIGlzIGhhcmRlbmluZy4KCkZpeGVzOiA2NzViNjJlMTJmOWQgKCJl
ZmlfbG9hZGVyOiBBZGQgbG9naWMgdG8gcGFyc2UgRURLSUkgc3BlY2lmaWMgZm1wIHBheWxvYWQg
aGVhZGVyIikKU2lnbmVkLW9mZi1ieTogQW5hIEJvYmlsbG8gPGFuYWJvYmlsbG8zQGdtYWlsLmNv
bT4KLS0tCiBsaWIvZWZpX2xvYWRlci9lZmlfZmlybXdhcmUuYyB8IDIwICsrKysrKysrKysrKysr
KystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9saWIvZWZpX2xvYWRlci9lZmlfZmlybXdhcmUuYyBiL2xpYi9lZmlfbG9h
ZGVyL2VmaV9maXJtd2FyZS5jCmluZGV4IDg0ZGU5NWY1YzIzLi40YTUyNDllNWQ0YSAxMDA2NDQK
LS0tIGEvbGliL2VmaV9sb2FkZXIvZWZpX2Zpcm13YXJlLmMKKysrIGIvbGliL2VmaV9sb2FkZXIv
ZWZpX2Zpcm13YXJlLmMKQEAgLTQ5OSwyMiArNDk5LDMyIEBAIGVmaV9zdGF0dXNfdCBlZmlfZmly
bXdhcmVfc2V0X2ZtcF9zdGF0ZV92YXIoc3RydWN0IGZtcF9zdGF0ZSAqc3RhdGUsIHU4IGltYWdl
X2luCiAgKiBQYXJzZSB0aGUgRk1QIHBheWxvYWQgaGVhZGVyIGFuZCBmaWxsIHRoZSBmbXBfc3Rh
dGUgc3RydWN0dXJlLgogICogSWYgbm8gRk1QIHBheWxvYWQgaGVhZGVyIGlzIGZvdW5kLCBmbXBf
c3RhdGUgc3RydWN0dXJlIGlzIG5vdCB1cGRhdGVkLgogICoKKyAqIFJldHVybjoJCUVGSV9TVUND
RVNTLCBvciBFRklfSU5WQUxJRF9QQVJBTUVURVIgZm9yIGEgYmFkIGhlYWRlcl9zaXplCiAgKi8K
LXN0YXRpYyB2b2lkIGVmaV9maXJtd2FyZV9nZXRfZndfdmVyc2lvbihjb25zdCB2b2lkICoqcF9p
bWFnZSwKLQkJCQkJZWZpX3VpbnRuX3QgKnBfaW1hZ2Vfc2l6ZSwKLQkJCQkJc3RydWN0IGZtcF9z
dGF0ZSAqc3RhdGUpCitzdGF0aWMgZWZpX3N0YXR1c190IGVmaV9maXJtd2FyZV9nZXRfZndfdmVy
c2lvbihjb25zdCB2b2lkICoqcF9pbWFnZSwKKwkJCQkJCWVmaV91aW50bl90ICpwX2ltYWdlX3Np
emUsCisJCQkJCQlzdHJ1Y3QgZm1wX3N0YXRlICpzdGF0ZSkKIHsKIAljb25zdCBzdHJ1Y3QgZm1w
X3BheWxvYWRfaGVhZGVyICpoZWFkZXI7CiAJdTMyIGZtcF9oZHJfc2lnbmF0dXJlID0gRk1QX1BB
WUxPQURfSERSX1NJR05BVFVSRTsKIAorCWlmICgqcF9pbWFnZV9zaXplIDwgc2l6ZW9mKCpoZWFk
ZXIpKQorCQlyZXR1cm4gRUZJX1NVQ0NFU1M7CisKIAloZWFkZXIgPSAqcF9pbWFnZTsKIAlpZiAo
aGVhZGVyLT5zaWduYXR1cmUgPT0gZm1wX2hkcl9zaWduYXR1cmUpIHsKKwkJaWYgKGhlYWRlci0+
aGVhZGVyX3NpemUgPCBzaXplb2YoKmhlYWRlcikgfHwKKwkJICAgIGhlYWRlci0+aGVhZGVyX3Np
emUgPiAqcF9pbWFnZV9zaXplKQorCQkJcmV0dXJuIEVGSV9JTlZBTElEX1BBUkFNRVRFUjsKKwog
CQkvKiBGTVAgaGVhZGVyIGlzIGluc2VydGVkIGFib3ZlIHRoZSBjYXBzdWxlIHBheWxvYWQgKi8K
IAkJc3RhdGUtPmZ3X3ZlcnNpb24gPSBoZWFkZXItPmZ3X3ZlcnNpb247CiAKIAkJKnBfaW1hZ2Ug
Kz0gaGVhZGVyLT5oZWFkZXJfc2l6ZTsKIAkJKnBfaW1hZ2Vfc2l6ZSAtPSBoZWFkZXItPmhlYWRl
cl9zaXplOwogCX0KKworCXJldHVybiBFRklfU1VDQ0VTUzsKIH0KIAogLyoqCkBAIC01NDMsNyAr
NTUzLDkgQEAgZWZpX3N0YXR1c190IGVmaV9maXJtd2FyZV92ZXJpZnlfaW1hZ2UoY29uc3Qgdm9p
ZCAqKnBfaW1hZ2UsCiAJaWYgKHJldCAhPSBFRklfU1VDQ0VTUykKIAkJcmV0dXJuIHJldDsKIAot
CWVmaV9maXJtd2FyZV9nZXRfZndfdmVyc2lvbihwX2ltYWdlLCBwX2ltYWdlX3NpemUsIHN0YXRl
KTsKKwlyZXQgPSBlZmlfZmlybXdhcmVfZ2V0X2Z3X3ZlcnNpb24ocF9pbWFnZSwgcF9pbWFnZV9z
aXplLCBzdGF0ZSk7CisJaWYgKHJldCAhPSBFRklfU1VDQ0VTUykKKwkJcmV0dXJuIHJldDsKIAog
CWltYWdlX3R5cGVfaWQgPSBlZmlfZmlybXdhcmVfZ2V0X2ltYWdlX3R5cGVfaWQoaW1hZ2VfaW5k
ZXgpOwogCWlmICghaW1hZ2VfdHlwZV9pZCkK
--00000000000038bf88065e769335--
