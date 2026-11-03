Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC9606A331
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GUSb8Xy+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WssDD0K5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F6E380F1C;
	Tue,  3 Nov 2026 16:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bluKn6gTdggM; Tue,  3 Nov 2026 16:12:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3CF9810BC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722377;
	b=aa65ad6ytR+NhwKA5D0AxTa9vFwiJ0fWjC5V69vw9tH+N0VoF0S3L65epYlUEHdjVRDj
	 rewym8OwnrF3xKR8PJMESINkOdixnHmauyC+op75LR5TMh0P9OMmkptKhbcIDATMuPMg8
	 i6VwzMNu97B4zc9fa2Jql1e5A2UXAIMxRH0ruSDlrWHrty6x7MfCyuIeqpOkw+BhcR8Cc
	 Pre4Vr9JBbEgXJtWEdeCb6SUrezcGh4YAsVBOyMz28q3YEAFDUStfzjAmwdBLaKsH84t9
	 hJ4gGwUfpiUPpKK/W98bFagT5ThpwmN6yAhD+QSF87EPWxhOPQ6GUJ5XU88QJAt44Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TkN9M/zHAG62/JlcbivT2pRACg5dqKGhQjLpQD/OkKE=;
	b=aXeupZtBcxdJCf396E/doKoTPfFNQ1D4uhNDJzrc/0dPkL44AM1j/YB/M/tfrnXsbwcy
	 jUg3Pr+P+y08bFC5eVPVsUA0DKKIDSi6rc++ddOPLPSfA8bDMGMAgO5m23UT4kTHoE9y7
	 23yc2nJocEyD0xjOc9HatskpqDzsudqrYbkZeTmDwvcKfLVcD82NARcdMB09r+T1LUr0l
	 3drIXBsDGwvvkRJdBzIWFnDiLSH8AGZ4OyHjV4QK0bBLTLDEgzPlFiUHYuMqVgStoE5mY
	 NtrnFa+o03VZV4ky460I7pApzjES1VRs89QyYXIY4a+b+JQLNOr16MDyBWGTprR4COA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722377;
	bh=TkN9M/zHAG62/JlcbivT2pRACg5dqKGhQjLpQD/OkKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GUSb8Xy+JkXWdKKYqr/o9ahe8WEmP5fkUCVgQitNNzuMaOp0pfLfaoIEhOBzXjW5C
	 IBt4FTKBpg/8Mn0LQLIGa+2We0GDJdHF2RpikkIGtof+BTK0BTSBtH9bvaB2ex/OLN
	 HeLl7lp1ccFyWzwfQQDDv1cuwQgCfgFpQBTFG8/fX2aNaBIjls5z0GRE9tbZj0XMkq
	 NssYBJGlRRVywmS0GFokaTERdCCVwedptItpgd5EeJsiDWqb4k6T8a6VzQy+eK/R1s
	 VAxi/TimG/zFwnhdqluYSKZDvbGpXPY3ubOjFw7gqw3q0oJhDWf5lounbrFLBU15k3
	 5fS51vY45WIww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3CF9810BC;
	Tue,  3 Nov 2026 16:12:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60A03235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 465B840704
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sGq_MRSuEdM6 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68263406FA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722375;
 b=emI32ro//Tiwkh+zIhRq02PI6Z6gtKJncOHMTTe2Ck6zu3jFFyJNu6jnSvznCeGHXqj4
 T62hv9M6h9/2wxTJNubq7STBrkdHbbQ6nDHzdUTDVd6/YaptyI4l7InWKILqbhBiAzKUo
 tu+oYXmxUut9xHqp6SnkSjTcTb7zaJ4OHSqIZtXayDeSZyE/XDgC0KNouYpVFQF/NOzEt
 02dkaeQkU+xNBCEtuQ17R+dSAPIysgKC6L2snhbdS0OqTjzFimCkrLoMafSv+GDsQWpyV
 CfyPNzRhYUA2Qp0RH6GU1wFDhOPPNL69YxGzYdFxUVtF4E6Dnr/6/YPk6POcqKhzNYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722375;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=TkN9M/zHAG62/JlcbivT2pRACg5dqKGhQjLpQD/OkKE=;
 b=SclRCWS/I3pSBQmun497CfLdfrvJuJtFgc52psiGi6USwT7mR45BynomLEhn9XmftvTQ
 GQMMV2uBmC1FcHNKfbHYCzNL/KlB/EOgvUBuD8bu7eEoQNMYh1E9+v1pRC2RBjtk5vRIB
 mPBP8tfIEyiEdx3MPhCwMn6vFt0N4jS+nKmGUkfjKk96lLVy8uOKJbIIV+TnIpwsG1TFV
 fcMERtkrWva9TMBVURjJYysfYvBhfJoA3dUQ9ZyT/CBhzHYcRfEFkRGN1OzxRqd/KAwTo
 WYj9hRqGZDXxqr0RTahOS2l8rbngG52T2OtJbMlgcLMwBXENTwRCz13cBOGd4n+lQqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WssDD0K5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WssDD0K5
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68263406FA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:54 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so2673898f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722373; x=1794327173;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TkN9M/zHAG62/JlcbivT2pRACg5dqKGhQjLpQD/OkKE=;
 b=WssDD0K5QCZtALCc58Co6VtV6rUjuaQQKIQq6S5n9eIiiCTP9HcWkQxTKUVVzUtMbb
 NoYi0fh+tmIk+Za9pnlbtaqPAEbocSNU6JK8tOIPBEw6h9FOx33Hvsc09UA9ygrtbEXH
 LoXUKiH1Lvpp7m4QkIKlvqjgrT55Z/Cn39ly1us/16Yn6FHjhq6z1Z5elSxCouH7HV65
 QbPTRXhPp2Rt/QXPW/dpQaABIgt+jOiQGjtlcmAO5QC3/b7TgdrHfLgQmfNqxQcMwBqq
 /0rKSxkf1O9spfNaNR7iO5lXcFirHwcw+ZWkxfkGDs6G55Ye+JX3oOJMqpa2lBwnGlte
 OGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722373; x=1794327173;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TkN9M/zHAG62/JlcbivT2pRACg5dqKGhQjLpQD/OkKE=;
 b=Zvy7ongrTVvJS9+Aq8fLRJa0t3erNYhoQdT42C93L840miwrvQogKzifJTsF6MK72J
 DZ2tABcGn3TncoGB9r1ZRK6qNbCC5IHeVj+ccfAR7pVz1sgVAV3vFuq8VZyfEaYCu/cP
 LsNUEkphfAcJ2Z3BBa0t6fUVNqvciXwHRfWMPJR1HRBZZA6ic+xWh2rlsLLBuVnShkwN
 K9tafvmS3P4dBRsWXLOgvO8Z7mtGtS2Wen1R7C1oNA6zV7gWlU5lhKBPoFJhy0DKlOCq
 ZcFHmsv3OdeRQLDZsl2GTCBzazeWsj3c+g9zmars2C3EebKa3px0/YQl4wtSQXyOaPIr
 jwiw==
X-Gm-Message-State: APuU4Z89mlNBQYhuBrtFB1MJCkUs2DOkJ7diy6+7AhauHuf+Iua+AhCB
 pJ/XyKqeZtA46ahF5ql0/SZgmnNhQMtRAOBnXkB0Gc4tLLjE8UW7YKsSi5QQAQIpGE0mAP0M
X-Gm-Gg: AYBFou2JYdlhEbafoUYtDjBQmJzzU7vLwhk3C9BOKiT5pZD6qNkyMue5UEP/svasU5+
 iBNd7sV85H5Rqp2AyRNoExsCIho6PgFDZkqR3z8o8PF/55z8m8WC4NwbCrUtdG8Eoc6ccm0zgoh
 P064yt2n2X7396VAxDfuGNSKwzn7OS978AFGvkDzGtXcW5I06XH9dAXY/Q3zw+EOO2T5M+lA1bK
 2b5vDHVQPoLaADndFyTQb0FPsS/CJnyCKto7QHs9Tk7FqA0e8yOZK/ZeKso8/+Z9YUSm/avBTMX
 tvRVZAPQeWi6hqwJGRf40EFbq9DsoDp6X03MDQDL/VFpxakKkEaTFNwhjYXEaoIP+CT2Epa1Q3q
 TFF7SoMMqdmFAToeuR1MA56Z47tJcmzHkroVmgIyY8E6Q0ItLMvIIsd4QdmSSDGbVJqllp/uz/k
 uxSZS7we+tF6WR2XGibVSVVzxn/PmkjIrbz6lv8PWtVehS1lpRA8ls9OZQOQ009KXIFcR7xHl4F
 YwyG9jazuQfEIgC2GWbirtEBTiQEY7kQf7t1TDSTzVAduYUmst395Vs749elJEhcFG97zv1++hl
 ZkBHUXF4amSWuz88nxBdoZp8iU1Vm9c=
X-Received: by 2002:adf:f0c6:0:b0:48a:fb1c:c2a1 with SMTP id
 ffacd0b85a97d-48e6e526dd7mr22198000f8f.47.1793722372736; 
 Tue, 03 Nov 2026 08:12:52 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723cdsm26664993f8f.12.2026.11.03.08.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:12:52 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 01/11] efi_loader: check the NT header size in
 efi_check_pe()
Date: Tue, 03 Nov 2026 16:12:51 +0000
Message-ID: <66634415-21ab-4de7-9b61-0863c9f3f55f@gmail.com>
In-Reply-To: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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
index a03866c2907..c2c3109ad1d 100644
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
