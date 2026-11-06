Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3E606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aBIaklub;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OyGhfrRm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E81EF60909;
	Fri,  6 Nov 2026 21:56:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EUDyvPhlrqIF; Fri,  6 Nov 2026 21:56:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44FCE60AB9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002193;
	b=QFqO+W2K5gVZ/cYLpVtSdXRI5GK5ix4IcsolCrnFrjKV/bTFn1ptpBWtPRzNjqUrYfLo
	 qR3YhOTXbDbqCa62zvNVVXZUYTPAzkEbYE3NiWzPfnKdZJKvNtZHTW09WopxqmPpBO0xX
	 aLisS8po6f7Em4VD+Gs0faw2x5mWdvlSCxdG4NT7DfgKDFrHgaSpQqFCn/iEGtxBz2XVl
	 owgrRmWqxvb/bSTx+1UI1pL7zaX0xTTJ7aqQsy7RX1QQf0GypoRQumDB6uwghxcvPFtLH
	 ZFDMn6b6dbwKwvHAjLswYVhbI7fi6PBeVQJ4AUN6viFPIAq5Ud6oXFTpMf4PKx0uJmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YvhZY51H18jLzX4EB9NWENudwXj5quYQGF2p6b6IsHE=;
	b=sv64LQigt09SjPhGrTknf2JoPIfqU4qNHPH7p+Tx12Y5OyTA/tAcld8IH6LIBX5c8i9S
	 acJ9bLZvIfpEChzw3yYYEAclFBW69gbb6ViFPAlN/r3XfeuyW4HmLUcOhF/hc2B8RSJhX
	 JU6918dX0Sek29qWCCprAxn9fZUSqs7755+aAcKuyAjN3oZ5VqfwPjcWiFft7GBKqDKRi
	 90jRQjT+OIAyvKJCx8e6GuvMPwd3m3aLlsFgApGlwLlsMeAMelBJWYqtuI6TjfNDyIpGf
	 Rkyk9v0AEcDvQPO7iz5M69H3Q4S2mp23Y+6E4S3zehBMPOYOlaacyVrruyOUXNe4daQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OyGhfrRm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002193;
	bh=YvhZY51H18jLzX4EB9NWENudwXj5quYQGF2p6b6IsHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aBIaklubSeLKd430yQRWr2I715mxnRcipIMNuSJXVlF9YmF/zPWzTGbCfT98TPwvm
	 U5LOYUi/3GWsRqtJes1U5UHwxMbHfTPAjP/D8qZ350nxrKlrDxfX3ds1lqsMJK00gx
	 f19Wz/ET2QjXO/sQcK3/MavTePivJg0dth7iqo6BnsWzaTrFBy65gPtsxWIDot4xtv
	 w0BawAhgU5xGKAJktUvYjeAROXauWJN+pnSenRDpWMhwZGk9W2qA/S5TbrC8D/g7RD
	 HKNteS1ZlbxjWzAHobN7k42m+EPVgkEy7LtTYAYB+xFYf9aUTYC92VOhKqbIvQUP7N
	 ngYLh1nG2MCZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44FCE60AB9;
	Fri,  6 Nov 2026 21:56:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A201631F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8735E60AC0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T0tguBoFxqd8 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9522460909
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=OyGhfrRm
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9522460909
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:28 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so11602975e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002186; x=1794606986;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YvhZY51H18jLzX4EB9NWENudwXj5quYQGF2p6b6IsHE=;
 b=OyGhfrRmAIKF0Bc9OxOCFT8b31B0JMyalMQJADkmIPcKFqJR5otPrKONAG4tohJpzP
 oc0XGpod50CMd/XsZ+nrmPNktOFwWyDV9WXm9syB0cEZWcUeRVHjUhhDQa4xILKLKAfk
 fW2jtKSjtG2Y+L8b2b8or2gAYQWaN6YxN2pdftbT8112Z1vmFE0UqfoZAXUgaVEYyx1T
 Exkk5H7C1xwqrg6vSMplqbiSRYD8gfwuUZ36Q3flpBbGecYHYPzQlP5GRJewJE8/0339
 We7cpL6mJG/7+mLtxWEJaNciEUy7bfNlgVzfxvm/tslXDB95NcT0WHk6eSgOW9OB8OAj
 Rz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002186; x=1794606986;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YvhZY51H18jLzX4EB9NWENudwXj5quYQGF2p6b6IsHE=;
 b=0075xa7nvvOY+BXWwURy38npdAhjVO2ThsZd+3mK6Ksk0SABADDvkiWhV1FpU2tDTx
 30PR+lBdH18GLVRoEGOJ8JpHUC7oMmNLU58Hh+4Y1g1Vr38AL2w34XC5v+LhoGOvM64M
 tcu3B7pa8E1RlxVbt9HYSUMpIq2gU3w2tHyHRkSaEd9DvWvIkAS2heHUToabK5nX51ww
 /FYgAO9vzXhrmOqsHNNmT4GzXG9jdb1QQURjYYTTmITyFYUBABuEbTn7+MNHbczy5vyM
 hKPTKE+uv1VbxqfO9eLvVTKvGL1dQ+qaDuctwnuhr7i2WA9jD27eTSeG4qKzEYrHZ+A/
 lP9A==
X-Gm-Message-State: APuU4Z8ewQOFwUmjgFm+ckDIMlclJfumYwtLDPdxYEYAqZnvSy4SrBhZ
 Af8zs5xO//J2moGMMqq+kSDS2prvebTKAfIXlnOlttSZLDDS2w65NnZfo2iOtiZMDiw=
X-Gm-Gg: AYBFou3sFlKsmVVV6jEBxH0QAqg34Njo30DxfF0Kp5Iz3P6uvIVh22vjzuFz7rfl6fz
 yNH/2akKUgbQUNmDqN+FtfSIcJ6ntbuQMcKuSn5c17g/UV2AYP5AzovJLFgModfsv51BJdn9/Ca
 SBYSzm/M2biYTFVzBKIK422pL5hDTHKFj7Cck/v8o9pkkT3b4LQsNg+No28UAqXwOOUU3gQ27bq
 QQkReoVKSsEZzu087oHLvaO96BhCqYNDHstuqyBMTRuhcV/pFkFSp549HGkT19MEEBt7qHfY7qr
 p4bxm+J/lqm55jvanLQcWdFMHI44rlyGPLrzUjT/zVH6AxG+IpKgIQhYqRX4dIwRc3CaWOukQIK
 aLM/ESMdUOTFRiuvcVuYw3KQMCjU3fZRw1z0/FAx9rMXXhad8s3YUlt9ZeM7Q5eIY6/kFTGRujT
 J3BCYRPDf1TjJDYWhwnYpLeyGJXAfa+70ta0PAX31eStkeePQjBop6X+e4izy33vfeic6xq1Xvy
 WyDaEvUKGWM6qhvxKM7HvWsRQ9/H/g4mJ/Zw/LihT3Lb1b49IZrVSsOxsLZhNVl9rbswtPB0udq
 uaZUvX0YkqKWR6cCp7J8ZuLuit+ETeO1DCNusfd9ndRDvv7u7XTf
X-Received: by 2002:a05:600c:5307:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4b6de973c39mr61995705e9.7.1794002186149; 
 Fri, 06 Nov 2026 13:56:26 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7d54d6f93sm20765105e9.0.2026.11.06.13.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:56:25 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 01/11] efi_loader: check the NT header size in
 efi_check_pe()
Date: Fri, 06 Nov 2026 21:56:23 +0000
Message-ID: <39ff272a-175f-43f0-a9bc-3f9a2b49b486@gmail.com>
In-Reply-To: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_check_pe() is meant to check that the image holds a 64bit NT header,
which is longer than a 32bit one, as its comment says. Since commit
5dad05a0e61d ("efi_loader: carve out efi_check_pe()") it checks for a
32bit one only, so the callers read the optional header fields and data
directories of a PE32+ image past the end of a truncated image. The
addition of e_lfanew can also wrap around on 32bit systems.

Check for the size of the 64bit NT header again, without wrapping, and
declare the header pointer with that type too.

Fixes: 5dad05a0e61d ("efi_loader: carve out efi_check_pe()")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 lib/efi_loader/efi_image_loader.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index f9a2d2df405..7cda338882c 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -835,7 +835,7 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
 efi_status_t efi_check_pe(void *buffer, size_t size, void **nt_header)
 {
 	IMAGE_DOS_HEADER *dos = buffer;
-	IMAGE_NT_HEADERS32 *nt;
+	IMAGE_NT_HEADERS64 *nt;
 
 	if (size < sizeof(*dos))
 		return EFI_INVALID_PARAMETER;
@@ -849,9 +849,10 @@ efi_status_t efi_check_pe(void *buffer, size_t size, void **nt_header)
 	 * least one section header follows we only need to check for the length
 	 * of the 64bit header which is longer than the 32bit header.
 	 */
-	if (size < dos->e_lfanew + sizeof(IMAGE_NT_HEADERS32))
+	if (dos->e_lfanew > size ||
+	    size - dos->e_lfanew < sizeof(*nt))
 		return EFI_INVALID_PARAMETER;
-	nt = (IMAGE_NT_HEADERS32 *)((u8 *)buffer + dos->e_lfanew);
+	nt = (IMAGE_NT_HEADERS64 *)((u8 *)buffer + dos->e_lfanew);
 
 	/* Check for PE-COFF magic */
 	if (nt->Signature != IMAGE_NT_SIGNATURE)
