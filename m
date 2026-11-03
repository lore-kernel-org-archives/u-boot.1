Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA914606D813
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NE72NSaA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SAecmggV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7EE9810D1;
	Tue,  3 Nov 2026 16:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Iz6SGirrdWp; Tue,  3 Nov 2026 16:13:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 202C8810E7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722384;
	b=KBRlLn7mCtfHDKflcKNEfY3T7cQhOCdL2Don044WlzZPB0Gh1Ei9w9EF+2ecSrUpwJyM
	 oOAdFD/e3JqzMRpmVlOEgAw+AAWMqn6GpWVMq4IstUoOG+/8kX+eieI5oK+8EXJsBybjx
	 Uvc+cE5XgHqUh4aXJyMl/SuiVs1GAB1OwAueJyAXXqoOb3XVBNIYW5RHCLRxb9UVdxozq
	 ugibdOAn1hKvt1UmQaqBMDUloZl2/UwYeqaitXynwh7ljb0RzlF24ozlcN0FvsdCJ++ua
	 KCdpXmNGxvlK3kZ548GokADu2B8V2+YA31q25/xTN5IpFgUM4hGNoSgpc0m9fj7/m7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aJLf+XNOGWm5bre13IhzWkPMUx6yHfJ1ks7UbQQaYI8=;
	b=m3fa7SztAnfjzJNwk7TIUYleJw/x3/qKo1KkHMKD/tkovvNp+KRBsOrJ+smgW2EUPewU
	 NY9CE7aNzJRWp/Kc7WTCInR8XBgNi14kd+VB2/URqNjpQOm0TDvNv7GeEXVUbtvLgKPAa
	 t/+g/R6m/6LSBPAxVmhLPT2jB9QX3zAiT5p2Y+esqnZwXL0cwwRT/rnW/nKTj5L3VLo9d
	 GsH/yUbyuA0fudR0/9ltOn2uLWNPg7zdQrZ4+VfI4kCm/sO9l1MTqlkZwxjSW7Y/4erZo
	 F9sFLMpug2GJpdJeYhZCE9II3SujF1vEqkvsj//fO8WGVdifhxO7m6DxlWH2KAmikzw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722384;
	bh=aJLf+XNOGWm5bre13IhzWkPMUx6yHfJ1ks7UbQQaYI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NE72NSaAMzmW9mUb6+o+YHrYJjOfyirWWunK2loAlTy4dxDx3Q6EPh3oFmh03C/Ne
	 Ayw+5WO/oKvOqEpN7RPDPaGn11ujsgcXElhqLjsDSrHuGIvTQsjZLunJBiS0tmL02z
	 qaDqZMGjjLbPnQ66vPt0kAcuheP/tJJD4LboK6E1NHxnWvyuDJB+9oI00vHAjhT1+f
	 TczbiIVFnKxUm9y/0SOvIIw4SQXMwYVWk75pM5oO+AXYNnVDAmqL+Te/XhYsDYphKj
	 QFsVxLQu96ZID0Of5nDA8f1X71Uv2nFqgeShbCF/9gSvLdclCRzpyW+IILk+YHvYWH
	 m2qKyI8KTBNlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 202C8810E7;
	Tue,  3 Nov 2026 16:13:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 27F66235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19CEC400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0-FvOeuUVGB for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:13:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0E52640068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722381;
 b=hPUbtSFldEsck1677uSIwjHNHDWNMS+ABHO50rGrmUNycrIZb5V3eiG+kqooNKKO8RpH
 d5UGuL7r6GY9qiRufwh3dFDnsrDkeSY4Lj136WYw3uThHMvK1MiI9GDfuWXh8GWhKt0eX
 qhZ+xiEjfdViYpUKBZE5bHN9DYaxmvHr/KJKsKjoAhOJHEboY2TeBff/jnEaPEKkaHba3
 0wPImsCuZqAeX3lriQ9cSeh5E9oSfdP23+2iME6imat0XzDvHIYSxz4o2ruaoCwF+HT+B
 wDJn0KBjdrLCy2Te+6BcEheVyHRAB/IaQSZBdrz4jx5ofxzbaECFtOav2ELApb0b+bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722381;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=aJLf+XNOGWm5bre13IhzWkPMUx6yHfJ1ks7UbQQaYI8=;
 b=G3sIS29nNjmlbL6E9126o4S7xO/bYYuVXRP5Leb1R/1YQg5rgRCoTLtc4dzsElz5p3et
 hHnqpauSBm4ymAREyNwwMetT/8MxW4uQZyOpOcv26C5x/A5IHVMMMOlbE7nzPZkKY6HNY
 Dpet6jGoNdrO+O5pegR9Ixfd2rFBLHDRSqgo70raV7sBPVZHHip8PGV91G1oxJmBQerPe
 uK+3kMqoXCAj3+pG8yce0OKSULc+mvWxy2QIjAnV8CNaA++VR5STpPMMb1FB8BihEaHRp
 qaxyt9fCTBey5+fCCcAnmMndt337B1y5NNNEd37iseMGLPq1OOFdEsqkBg3obCcHR1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=SAecmggV; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=SAecmggV
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E52640068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:00 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso20803745e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722379; x=1794327179;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aJLf+XNOGWm5bre13IhzWkPMUx6yHfJ1ks7UbQQaYI8=;
 b=SAecmggVvw2xiLV/qLPqBfAz8eX4FDc8npdAoeYkO9Q0+sx3eK4qUV5DdeNcMKdOCi
 qGY9HE/SDX1j5t+QU2+oQJGNvZYQ+lscMaP8u4UWZJK5cb6WNE/DdrIdqFgY+LIYexAK
 hppiZqAUfYroUL6j9R4Wom/np4PGZbe8PRYe5uYHE2mWjz7LC20b5+AVXculkO+Plm42
 Pvf/YKbm2T/BIrpqQ6n5e2bcUetrD2fKFgYUv0AJWFr2YpunedxuQoLOiAP7QYgvSIWY
 KW1JyJ1UdJnAoUICaa7K3ue6MVVaCUbjyoyvPHDCK7cY4FPpwF/DllYla5jFGwUquXkT
 WfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722379; x=1794327179;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aJLf+XNOGWm5bre13IhzWkPMUx6yHfJ1ks7UbQQaYI8=;
 b=YosiN5/JfxiAYrDPuWLrWIY245lO8SHiYhm7ZvzYO0GG59AC6gGzgRk8AUBRFgmuAJ
 YpTQORXJ7RZFXSREca4uNTuHNOeEEL0nbISgDiIOMJhnAao76CMbGy/KInzVbC1GUVXu
 WLTeOzirnWykB8hQ4L7dADIOocamBB2nnuV30kzK3wzqeStTOoV+MCvTYW0LYf+kMAIm
 obFjl/I13BaUb7W44BzuG8QwWuib/Xs8gSVH4aHbGs1Be2Kr9AIUE0NW/MhDmSNoW9JC
 rvUuQDjkMhd4DIzEFa4PCmGFifJHONHp/OaJGss7u6bk87KSsdR980Ogy6dGot/E8ofB
 yQ2Q==
X-Gm-Message-State: APuU4Z9eX3KxrRtd4MUnfUn0IJc4PUijcJDa2Q9exGNBFCsMFZQCNHZE
 SW+nCBA65v7neUUKRI9Dn9AIxctB3QXRL5RFI/iRrMlEjC7NUGbxfOS9IEogMO72R8IOkw8n
X-Gm-Gg: AYBFou3Bw51z0VUxlNCCPD80ppD4c0URwJsgHIy9ChYPl/Nac2c7X1ee5UTicxF8tcC
 RXBCvShhIIXMkm6nOzDi3VYOPj0yqULWxVRN0IGzAQUGWf71HQEELMRbhdzX/TX6XEi4drcWX9N
 iw/SjacbhAV8YYMgElIVczuqC4TYrhuXCxNeinyhWlK0KIQhPRmmHAx+HJ2uZSnkusypGUYQ94T
 yVBQET7M5mZXRwSunZl/pbh2d6zYCXMi+CKEZymvUdQ8lPRu0ZDb8g9zVIrVw7ivxQoMNMOOtfJ
 Nn+8VzavfX4UTVOJnfTlbIs1cuyyVSRr8LXfIW1il6paWD4dBoI2W/tagnIPPElFJu4g8gLaPgE
 kqNLVnShNl1zzxnGytLfP9tjlV2LMMIDE+qXVR/2rb0KR/z0Ah7drRkuHcB0vpl0uyPyfiFwSp1
 ly/u1nxv27UU9JhL9JGRo8XiBH1A1iLNuEG+n3DdSeDBxdDZAQCXjNsKTN/KmoNDoeQpOa4OjdD
 UW9XaT9RL1beGOVyuHOggJjiBUnzFXRPZNTa7O895kYD04Z0S0mNKyKXj2eDUQvMKKdseI0B9nU
 Z5NtduMAELiQ6Qax65JAEtISaritLaE=
X-Received: by 2002:a05:600c:5246:b0:4a1:f377:5c6c with SMTP id
 5b1f17b1804b1-4ac16acfe48mr316003885e9.10.1793722378526; 
 Tue, 03 Nov 2026 08:12:58 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a96fc933sm73319845e9.11.2026.11.03.08.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:12:58 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 04/11] efi_loader: check PE section raw data against the
 image size
Date: Tue, 03 Nov 2026 16:12:56 +0000
Message-ID: <9b5ff0a7-bb32-4203-a62a-5095f01a0395@gmail.com>
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_load_pe() copies each section from PointerToRawData in the image
without checking that the copied bytes lie within the image, so a
section pointing near or past the end of the image is read out of
bounds.

Reject a section whose raw data does not lie within the image before the
image is allocated, also when VirtualSize is smaller and only part of
the raw data is copied. barebox, whose EFI loader is based on this file,
checks the copied part since 552a54e4d357 ("efi: loader: validate
section raw data bounds against image size").

This runs before the image is rejected when Secure Boot fails to verify
it.

Fixes: cb149c66342c ("efi_loader: Add PE image loader")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index f81ccd62ab1..f9594189bef 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1062,6 +1062,13 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			return EFI_LOAD_ERROR;
 		}
 
+		/* The raw data of the section must lie within the image */
+		if (!pe_range_ok(efi_size, sec->PointerToRawData,
+				 sec->SizeOfRawData)) {
+			log_err("Section %d exceeds image size\n", i);
+			return EFI_LOAD_ERROR;
+		}
+
 		virt_size = max_t(unsigned long, virt_size, end);
 	}
 
