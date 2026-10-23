Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD6B606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sx2Ua4E4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FvmUrVE4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9298C409E8;
	Fri, 23 Oct 2026 04:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPpwmPNy20bj; Fri, 23 Oct 2026 04:59:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A9D4540A0B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731563;
	b=MiYSXQQF/9ML/LU7P673J+X6rphSe9J0IjmGiowqXb5gKWp4v8t140lu9i/ehaA3V7SV
	 8b2BwkZBVY54jj5pz/5EbCjr2y05TJ70Kb7J6xuy7/UBuqQV01k7Aex3dsT0rBoNhiIYY
	 jrcvinNdFBfz5jCjwGhYCuYd67paoV4uUFnjkxZJMaM1NuHCRTLhrmBZ3QXYn2yUpU6g/
	 /NX+GHfFGuQWT8niPoQ1RqFG5Md5U9FE2/3iUqiYfZWntzGMvEraXdpSErAgxY6dUsfEJ
	 oTuipEi4dd81eDTSTyXQ3J6fOYk0rLM01VEth2QtAIJ9NADLXRwrx/k9t0aSDA56btQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4vQReqQepDqO9dunKiXd1YOycqU14WT3/w3LggFUBxw=;
	b=aPdzwWtXne7MOk7vpgn08QrHEEqIgnP5dZoOEab9ZztY+SfKI8YTsNcxXpbTtF4bpNL0
	 G8hjuB4L5b3mYsBx3YeJr7wAVvCvkBcYeU50U4UzBDNxyoQOFgCc9w62I/fsnGfAqiVQU
	 GdvCWFKuGPwIhqU5k6v1Now02/qDOxvG95Ux3DNvGzTuYJWNxOwCX8j/65NWlbrSUNg9z
	 WG3xh5mBGwOngqqHcZ57GvUBdI86brS1gLuxt0niROBZl/tnR+iZ6b21ZUlvZu6RmJiHj
	 6uy/REUbGX4a76gjLVH38kW/1bneARZcE99i/KRg1sG8h40FpswhH6m6IqE643ffdBg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731563;
	bh=4vQReqQepDqO9dunKiXd1YOycqU14WT3/w3LggFUBxw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sx2Ua4E4WwQ38iPPGk1QCfx4juFgDNdyv9oLpeDD1x7m2q/Mra5432LNJcEfVy7Zm
	 UjdShw+zVGyOtgE1hwsaDPPLO/LEHZTaIfWE87vW6SBRq2onzomfbC+yvnnUu+41ru
	 a0rQ2H5UNZ6Iowxd7DgmUpLafaa+s89Rwlwy0FIl3ZNelH3lwm1c7SRlJXBnNInUdO
	 akqL17ENxXkyYX2z0ew4KKFO3x5xFIWofw9X6j/jS2ofJ54SI+Zh7UaAKPRM98marS
	 1/QVIBnCb8CjR4VM2b+TKqsF4rc1MdTz703R25jNwQmBCl3Ec5HTytgRK9GnEU38vi
	 pX3mbr10tDCuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9D4540A0B;
	Fri, 23 Oct 2026 04:59:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 816C7499
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7226960666
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKe_kZh9cQY0 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 04:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9DE6260604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792728366;
 b=XLS60Q0mHt0erZgwpL6jpP4HZM/clPBLqE0siFqZF7P9FTHonjfyRWR/mCHHoxKRq3UZ
 cUA4Id4fXRmqTg4Tn3qJ7wC6ITnpyEDZJspz+LQ1Ovt95REaReahM0DK5IktFdFQHs/d8
 3FIhREXfsk1aNDt9IEHVe0zVBFvLzsz7Qs4I/nJ+u/RanTYVg1QALco9R85zCbKNjz7gp
 rMWCDaGInko9hBNaIGNycknrcPQ2FxcqkmXoQovUUvTmfcSAfTE2kXGEp62WtBLPEf+wS
 wlb/DGgmT3w3EcNqwzoh8ZzRrBvqgIwt3B1EuQO/n3AYrcSdvgN3h2Gfvp3+MrbyTuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792728366;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=4vQReqQepDqO9dunKiXd1YOycqU14WT3/w3LggFUBxw=;
 b=OxB3YQ/0b17YStezIjtnUi54w5RCmt5OaW/eUlu6wACG4boXh6MRXqvXuAY82UlZb2EO
 6OM9wdUfJsG1otoZV1ZzbD8pE/R6kzHKcJqXr6+cPJ9m7lX0wOHeR1vkUsss8OsLYI91N
 RD3zIDIz8ZXG5BPjI9lZzVgijHVLAugpUbDkMpOh5bWgCMn/seFvyTAG7nGNbKatlhXd/
 UAVlNqXdRiF2UmFyrOcNMWdViHBe8vJ5vt6LrSJeCw7cbYv/C5UYBqZU0b71YGdUjjWOd
 11dt8s0itkANwgX2qrnm2ga5czzj3KKoc4sfoZOrq/s+ISQIGrniTtCBPVZx9R1nFJg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FvmUrVE4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::b; helo=mail-oi2-x0b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FvmUrVE4
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DE6260604
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:05:24 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-539edfadfa9so232126b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792728321; cv=none;
 d=google.com; s=arc-20260327;
 b=Xn6+FwD4gO6UM0Eqn0RNsSkj9ETE9tB76PkeBbegmqLte8itUaipLt+MRC9xTSQmVK
 bjEgR5KJa37lxLQafgta5liprtZYYgGBkdr8PBt6gjMZm2qcv6b7GSDYfII4bILm6kC6
 NnYoX11Gm98UaCbxRxihNMTq83uKuXheashDbbSgOijsRt3TwRoikXX9JSsUEEUYOpu1
 iYXRUayV7d/Na6ynUIWaQ+gizVGMAeDLJA/3hId+m4+jHUxCoKwlc47TS4deTFZDY4/z
 sKXML/3BnyslLDlSZzj/ptJJQfTwVFzMi8YyiawQAVLwD4vmEIRecrew3jkDLJeZ80TF
 a3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=4vQReqQepDqO9dunKiXd1YOycqU14WT3/w3LggFUBxw=;
 fh=fO/i0n3hYJ74cs21KGuyGF2OazYql2f81AfdSYYrRi4=;
 b=KIoG5RD1Oc2p8LxslsAR/Pqtcs5Fcvchnl6gucS5nFys4ozacEcaPzKo5jdtMvDfgr
 /39nweKD9KLFAcXfRkC0chNikYrEUNBHB5O54ryIw8zVSJe1ppwcYrIvRfAnFaNWvT05
 0JQ/Azrt2iZsb0hpfWn7dg8c4pyxFR/BiqKzg+K3xjNehE8mGxz1m7dyZ4C6VO+CHghq
 VTXBEjZWmLo9ZkTTs0/0VS1klr+kIVmfuNvPYsiz/VCuUHflNHaht5j3FPfMgA13ndOl
 TsyIewnYcWkYvTuLNZJUdPoqlP9J3PeNGj0sc4TN3ECJYWjHXQM/AoDS2mJESPjprhO1
 cLog==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792728321; x=1793333121;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4vQReqQepDqO9dunKiXd1YOycqU14WT3/w3LggFUBxw=;
 b=FvmUrVE4xEBitC2w2j/9qCCWAVCMF41fIp+6c/PRoXZSDXDhY//a5rmYCEvxTiJblq
 yGqP5KFY1/Bqk/ZN35YbZZY7gpPfPkyUUZ9lWsnTSkS6tTL3SrxF47FdpYgF20zLKDcN
 tye7TllD8xz+D/ptQ5gU4aI8aIfZGXihLoErUGM5wctnK91sHfq9UMphRL+5HTrAow+0
 LShfZ6VM5IIxkFFD5TL+h/MDQ7pAi17g4uDYKIZo67C3+lJuh+wSM4YfnXDr4FAIW28s
 ClfTTo+qmmZtmLIdIBJ/Z3ioP3pWWvW3GSW4TiE7QocozCXler3DqgaauG5X1n95m8Ap
 fFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792728321; x=1793333121;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4vQReqQepDqO9dunKiXd1YOycqU14WT3/w3LggFUBxw=;
 b=I061vCgqH1/QpNUnCnDwVzLS2rQBjj5k6maUiKSCfFuSPY6ocBdLapA4StScNrjINf
 WDQ7Eov/3tS6T6VqoCO++Hvc67BbulGiJyL8381JoNRUTF8BhwbSViV4HkQUzyLfZ4fY
 uTEe/at6N//8Y9KH4OBUzVlc4xRF+O3b0gyNFi5HkMu5kf3N5EMe97NRC6dsw5Nwkvt3
 sOJPQwgTxw6mf9fsiKcn9H2foXxCLsDh065G9FKOSq/IfyFZ7lSygwxdUWhU60elSi0g
 9RhF3lBb2NkznFmusUz14mIgT9adM92Z37b1hb57DEjAIZo0AgQshcX8mQ3jDau34e44
 aT4g==
X-Gm-Message-State: AFq9FYKYbXV/cOsrq44LE7cbuBrkT4FdIYnQknxiPleKRlKnTIRpt1f8
 ahsK3AAivMcWsR3xzm4sPSWUlT8nZ+846Uhz5EVWTEQ5VSSm5Ry/H3IFKHTU0U66J6X08TPLUuQ
 /5xoQzs6pPl1Wk7eWgT3ETZUQ8zQrrdo=
X-Gm-Gg: AYBFou1Uyr2bzYmaQBDCll3YeUqma6K2PXjsowbVNHHqHzn5QIcLTl1m+QvptkPmXv/
 fy3JOzGQgk0qmQrtDNfZhk1nBU9AajWIEBCZ7B1x8uyan4aQhnVWU4jf5LfRswlJzfq6K7iUD6T
 BAvL3Vr0fHko39Ly0fwKgoKPjiyh4tDOFX6GBl2BHdlR4XY0EvlUHymq/xPtKUcZZnx1XCBbGiX
 93MYboAjaMwNZCu46Nt5K7mV76zeBykGijeYHoCraPWZ9RFCeWjENrOLoEihKT4oDh48WRWYqrq
 vXnKh2PZsq5JvMykSpPxdNozW/OLgI6L3BNXZ9HeKXOCHMPyxucSRDpG/FX/4PhlWxyfOLcrwR7
 94P1S/AqlNjwauGsVpRK+GNI=
X-Received: by 2002:a05:6808:120b:b0:4e4:627a:e0a5 with SMTP id
 5614622812f47-55be82d90f6mr639839b6e.40.1792728320971; Thu, 22 Oct 2026
 21:05:20 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:19 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:19 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
References: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 21:05:19 -0700
X-Gm-Features: AclHuK_F8_hiD_g5Krdq_rQyTEp78lOuY2N4CA9eSAZ4UuI3ZN6xnndUFG-AJlo
Message-ID: <CAJnxHsiA_aDx2bp799-gwS3Z2BfcWswtO+2iuwSXtagoCggR6g@mail.gmail.com>
Subject: [PATCH 1/6] fs: ext4: check extent tree nodes before walking them
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: multipart/mixed; boundary="000000000000c03073065e7a16a8"
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c03073065e7a16a8
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--000000000000c03073065e7a16a8
Content-Type: text/plain; charset="utf-8"; name="0001.patch"
Content-Disposition: attachment; filename="0001.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 370a2d87753dded0_0.1

ZXh0NGZzX2dldF9leHRlbnRfYmxvY2soKSB3YWxrcyB0aGUgZXh0ZW50IHRyZWUgb2YgYW4gaW5v
ZGUgdXNpbmcgdGhlCmVoX2VudHJpZXMsIGVoX21heCBhbmQgZWhfZGVwdGggZmllbGRzIG9mIGVh
Y2ggbm9kZSBhcyBmb3VuZCBvbiBkaXNrLApjaGVja2luZyBub3RoaW5nIGJ1dCB0aGUgbWFnaWMg
bnVtYmVyLiByZWFkX2FsbG9jYXRlZF9ibG9jaygpIHRoZW4Kc2NhbnMgZWhfZW50cmllcyBleHRl
bnRzIG9mIHRoZSBsZWFmIGl0IHJldHVybnMuCgpBIG5vZGUgY2FuIGNsYWltIG1vcmUgZW50cmll
cyB0aGFuIGl0IGNhbiBob2xkOiB1cCB0byA0IGluIHRoZQo2MC1ieXRlIGlfYmxvY2sgYXJlYSBv
ZiB0aGUgaW5vZGUsIChibG9ja3NpemUgLSAxMikgLyAxMiBpbiBhIHRyZWUKYmxvY2suIEJvdGgg
bG9vcHMgdGhlbiByZWFkIHBhc3QgdGhlIGVuZCBvZiB0aGUgbm9kZSwgaW50byB0aGUgcmVzdApv
ZiB0aGUgaW5vZGUgb3IgcGFzdCB0aGUgY2FjaGUgYnVmZmVyLiBBbiBpbmRleCBub2RlIGNhbiBh
bHNvIHBvaW50CmJhY2sgYXQgaXRzZWxmIG9yIGF0IGFueSBub2RlIG9mIHRoZSBzYW1lIG9yIGEg
Z3JlYXRlciBkZXB0aCwgc28gdGhlCndhbGsgbmV2ZXIgZW5kcy4KCkNoZWNrIGVhY2ggbm9kZSBh
cyBMaW51eCBfX2V4dDRfZXh0X2NoZWNrKCkgZG9lczogZWhfbWF4IGlzIG5vbi16ZXJvCmFuZCBm
aXRzIGluIHRoZSBub2RlLCBlaF9lbnRyaWVzIGRvZXMgbm90IGV4Y2VlZCBlaF9tYXgsIHRoZSBk
ZXB0aApkcm9wcyBieSBleGFjdGx5IG9uZSBhdCBlYWNoIGxldmVsIGFuZCBhbiBpbmRleCBub2Rl
IGhhcyBhdCBsZWFzdCBvbmUKZW50cnk7IGFuZCwgYXMgZXh0NF9maW5kX2V4dGVudCgpIHJlcXVp
cmVzLCB0aGUgZGVwdGggaXMgYXQgbW9zdCA1LgpBIG5vZGUgdGhhdCBmYWlscyBpcyByZXBvcnRl
ZCBhcyBhbiBpbnZhbGlkIGV4dGVudCBibG9jaywgdGhlIGVycm9yCnJlYWRfYWxsb2NhdGVkX2Js
b2NrKCkgYWxyZWFkeSByZXR1cm5zIGZvciBhIGJhZCBtYWdpYyBudW1iZXIuCgpTaWduZWQtb2Zm
LWJ5OiBBbmEgQm9iaWxsbyA8YW5hYm9iaWxsbzNAZ21haWwuY29tPgotLS0KIGZzL2V4dDQvZXh0
NF9jb21tb24uYyB8IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQogaW5jbHVkZS9leHQ0ZnMuaCAgICAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXh0NC9leHQ0X2NvbW1v
bi5jIGIvZnMvZXh0NC9leHQ0X2NvbW1vbi5jCmluZGV4IDllMWQ1NzRlNWIxLi4zYWFiMWM4NzIz
MyAxMDA2NDQKLS0tIGEvZnMvZXh0NC9leHQ0X2NvbW1vbi5jCisrKyBiL2ZzL2V4dDQvZXh0NF9j
b21tb24uYwpAQCAtMTUyOSw2ICsxNTI5LDM4IEBAIHZvaWQgZXh0NGZzX2FsbG9jYXRlX2Jsb2Nr
cyhzdHJ1Y3QgZXh0Ml9pbm9kZSAqZmlsZV9pbm9kZSwKIAogI2VuZGlmCiAKKy8qKgorICogZXh0
NGZzX2NoZWNrX2V4dGVudF9oZWFkZXIoKSAtIGNoZWNrIGFuIGV4dGVudCB0cmVlIG5vZGUgYmVm
b3JlIHVzaW5nIGl0CisgKgorICogU29tZSBvZiB0aGUgY2hlY2tzIG9mIExpbnV4IF9fZXh0NF9l
eHRfY2hlY2soKSBhbmQgZXh0NF9maW5kX2V4dGVudCgpOiB0aGUKKyAqIG5vZGUgbXVzdCBub3Qg
Y2xhaW0gbW9yZSBlbnRyaWVzIHRoYW4gZml0IGluIGl0LCBhbmQgdGhlIGRlcHRoIG11c3QgYmUg
YXQKKyAqIG1vc3QgNSBhbmQgZHJvcCBieSBvbmUgYXQgZWFjaCBsZXZlbCwgc28gdGhhdCBhIGNv
cnJ1cHQgbm9kZSBjYW4gbmVpdGhlciBiZQorICogd2Fsa2VkIHBhc3QgaXRzIGVuZCBub3IgbWFr
ZSB0aGUgdHJlZSBsb29wLgorICoKKyAqIEBlaDoJCWV4dGVudCBoZWFkZXIgb2YgdGhlIG5vZGUK
KyAqIEBtYXg6CW51bWJlciBvZiBlbnRyaWVzIHRoYXQgZml0IGluIHRoZSBub2RlCisgKiBAZGVw
dGg6CWRlcHRoIHRoaXMgbm9kZSBtdXN0IGhhdmUsIG9yIC0xIGZvciB0aGUgcm9vdCBpbiB0aGUg
aW5vZGUKKyAqIFJldHVybjoJMCBpZiB0aGUgbm9kZSBpcyB2YWxpZCwgLUVJTlZBTCBvdGhlcndp
c2UKKyAqLworc3RhdGljIGludCBleHQ0ZnNfY2hlY2tfZXh0ZW50X2hlYWRlcihzdHJ1Y3QgZXh0
NF9leHRlbnRfaGVhZGVyICplaCwgaW50IG1heCwKKwkJCQkgICAgICBpbnQgZGVwdGgpCit7CisJ
aWYgKGxlMTZfdG9fY3B1KGVoLT5laF9tYWdpYykgIT0gRVhUNF9FWFRfTUFHSUMpCisJCXJldHVy
biAtRUlOVkFMOworCWlmICghZWgtPmVoX21heCB8fCBsZTE2X3RvX2NwdShlaC0+ZWhfbWF4KSA+
IG1heCkKKwkJcmV0dXJuIC1FSU5WQUw7CisJaWYgKGxlMTZfdG9fY3B1KGVoLT5laF9lbnRyaWVz
KSA+IGxlMTZfdG9fY3B1KGVoLT5laF9tYXgpKQorCQlyZXR1cm4gLUVJTlZBTDsKKwlpZiAobGUx
Nl90b19jcHUoZWgtPmVoX2RlcHRoKSA+IEVYVDRfTUFYX0VYVEVOVF9ERVBUSCkKKwkJcmV0dXJu
IC1FSU5WQUw7CisJaWYgKGRlcHRoID49IDAgJiYgbGUxNl90b19jcHUoZWgtPmVoX2RlcHRoKSAh
PSBkZXB0aCkKKwkJcmV0dXJuIC1FSU5WQUw7CisJaWYgKGVoLT5laF9kZXB0aCAmJiAhZWgtPmVo
X2VudHJpZXMpCisJCXJldHVybiAtRUlOVkFMOworCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBz
dHJ1Y3QgZXh0NF9leHRlbnRfaGVhZGVyICpleHQ0ZnNfZ2V0X2V4dGVudF9ibG9jawogCShzdHJ1
Y3QgZXh0Ml9kYXRhICpkYXRhLCBzdHJ1Y3QgZXh0X2Jsb2NrX2NhY2hlICpjYWNoZSwKIAkJc3Ry
dWN0IGV4dDRfZXh0ZW50X2hlYWRlciAqZXh0X2Jsb2NrLApAQCAtMTUzNywxNiArMTU2OSwyNCBA
QCBzdGF0aWMgc3RydWN0IGV4dDRfZXh0ZW50X2hlYWRlciAqZXh0NGZzX2dldF9leHRlbnRfYmxv
Y2sKIAlzdHJ1Y3QgZXh0NF9leHRlbnRfaWR4ICppbmRleDsKIAl1bnNpZ25lZCBsb25nIGxvbmcg
YmxvY2s7CiAJaW50IGJsa3N6ID0gRVhUMl9CTE9DS19TSVpFKGRhdGEpOworCS8qIFRoZSByb290
IG5vZGUgaXMgaGVsZCBpbiB0aGUgaW5vZGUncyA2MC1ieXRlIGlfYmxvY2sgYXJlYSAqLworCWlu
dCBtYXggPSAoc2l6ZW9mKCgoc3RydWN0IGV4dDJfaW5vZGUgKikwKS0+YikgLQorCQkgICBzaXpl
b2Yoc3RydWN0IGV4dDRfZXh0ZW50X2hlYWRlcikpIC8KKwkJICBzaXplb2Yoc3RydWN0IGV4dDRf
ZXh0ZW50KTsKKwlpbnQgZGVwdGggPSAtMTsKIAlpbnQgaTsKIAogCXdoaWxlICgxKSB7CiAJCWlu
ZGV4ID0gKHN0cnVjdCBleHQ0X2V4dGVudF9pZHggKikoZXh0X2Jsb2NrICsgMSk7CiAKLQkJaWYg
KGxlMTZfdG9fY3B1KGV4dF9ibG9jay0+ZWhfbWFnaWMpICE9IEVYVDRfRVhUX01BR0lDKQorCQlp
ZiAoZXh0NGZzX2NoZWNrX2V4dGVudF9oZWFkZXIoZXh0X2Jsb2NrLCBtYXgsIGRlcHRoKSkKIAkJ
CXJldHVybiBOVUxMOwogCiAJCWlmIChleHRfYmxvY2stPmVoX2RlcHRoID09IDApCiAJCQlyZXR1
cm4gZXh0X2Jsb2NrOworCQlkZXB0aCA9IGxlMTZfdG9fY3B1KGV4dF9ibG9jay0+ZWhfZGVwdGgp
IC0gMTsKKwkJbWF4ID0gKGJsa3N6IC0gc2l6ZW9mKHN0cnVjdCBleHQ0X2V4dGVudF9oZWFkZXIp
KSAvCisJCSAgICAgIHNpemVvZihzdHJ1Y3QgZXh0NF9leHRlbnQpOwogCQlpID0gLTE7CiAJCWRv
IHsKIAkJCWkrKzsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXh0NGZzLmggYi9pbmNsdWRlL2V4dDRm
cy5oCmluZGV4IGZlM2ZiMzAxZWM4Li4xOWVkYTE1MGNiNiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9l
eHQ0ZnMuaAorKysgYi9pbmNsdWRlL2V4dDRmcy5oCkBAIC0zNSw2ICszNSw3IEBAIHN0cnVjdCBk
aXNrX3BhcnRpdGlvbjsKICNkZWZpbmUgRVhUNF9UT1BESVJfRkwJCTB4MDAwMjAwMDAgLyogVG9w
IG9mIGRpcmVjdG9yeSBoaWVyYXJjaGllcyovCiAjZGVmaW5lIEVYVDRfRVhURU5UU19GTAkJMHgw
MDA4MDAwMCAvKiBJbm9kZSB1c2VzIGV4dGVudHMgKi8KICNkZWZpbmUgRVhUNF9FWFRfTUFHSUMJ
CQkweGYzMGEKKyNkZWZpbmUgRVhUNF9NQVhfRVhURU5UX0RFUFRICQk1CiAKICNkZWZpbmUgRVhU
NF9GRUFUVVJFX1JPX0NPTVBBVF9TUEFSU0VfU1VQRVIgIDB4MDAwMQogI2RlZmluZSBFWFQ0X0ZF
QVRVUkVfUk9fQ09NUEFUX0xBUkdFX0ZJTEUgICAgMHgwMDAyCg==
--000000000000c03073065e7a16a8--
