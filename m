Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00D606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N6WzGkO+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l7rGwvwg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A633460A41;
	Fri, 30 Oct 2026 12:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZtqRdTTPHVY; Fri, 30 Oct 2026 12:49:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E59C0607D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364569;
	b=r+DMRwl4xDXcyL9fbFYvYTJBjhL2XIGcgY5vCbjV8JGvQIfLbF3FJA8NLxlE95x57kSv
	 5Szo8Kasazs5M7BxQDVWIfQkJzb++Nz9LBeYR6/5KWrVkIas5ZU9cvrufPywIlmqAXA4M
	 i0RarDqusdTGsyRsTB/n0mX2rYjdBkaLB6a+GEmPthBvGBpEJbf4HB+UJDtXszcSZ36Q+
	 sqGp7bQ5TjGMTFtbDjpglZV6Ylkf978fx3P2Rj5GdbWc4TGQ2pNz4E3EX2Hy5EaQiyDz6
	 LCCdxz6qIxqYw9FoNXdwQYAbnCGt00AwdjWn4uSwAcie+hqVTUmQhsZ861U47QcqSxA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793364569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VlKYSEPGyIbrWEXVSq9iHxU4pMdp8eGHG7yuOopfurA=;
	b=P3Lzch0ijcwCMcemEEZbJmRlM1Tiv5HpCrrdfOmb6NyUweJ2LyVazDsxE+pJ4MbRlMzq
	 BnAA/scquDsFdR3l9Y7FFHgorMRoM6BUJLqZvlvjgnClvUPlV/4rsRDfY13DU5SN3DicJ
	 d6OF6MhTsU0VThUurTr7v3XV6NMyJkzVh1BVA2iMNCPuEQeulIR3mxgNVX2DSn2qwV3a1
	 igNH32ewOOvLJFttDu1alYMor43sTlHNEVuG3YCoealu4y+qe2vmx/+683b13NSu2VkeG
	 WN/myKI+sgOFfsEUqPbmXNpd2omGEQkgQ3DHxKAzg48LMwOwIJQFT9wZLCxUE7+BqjA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793364569;
	bh=VlKYSEPGyIbrWEXVSq9iHxU4pMdp8eGHG7yuOopfurA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N6WzGkO+6g5p04rV4fyCp5gb0dry/Qzu6FcwFI3DmmZowjkf6y0/6hdzDVA/YC+zQ
	 +QtE+BHPt14BEtV2kMGw4hlHL9VsRFGqldsNzb5A/oQ41s5ULXFjZJXsWBmANzBniu
	 AKLVoEsvpDK3EuyTyLvO3JJvRiv/9tCyJAicYNfVDOC26aKChCb6WQ0vB5HbyA+Zol
	 oi0DwAU68RWrtchHvMUb4Gle7Fy1apEHvpGi4VPBNPDobHORhjNX7X5cpo5rQChJTd
	 oNyWwIKcMtadwZEEQUR4ehLh6rcxf7sCrLT5PlsxuyiwugQRdUj7vCtxTrV45+w52Y
	 bPqkHMevE7uHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E59C0607D6;
	Fri, 30 Oct 2026 12:49:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D5CC3D38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7B1640ADC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQjXgpN6ZSJJ for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:49:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1657340729
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364565;
 b=B6OeeOPwAyikUMwIpE/OcsERse+eqDoyOlIBFwSgwZJ7CW7OZKznkSi9iaQg90D1zJiK
 qy8XqVBwYY2Lq+pYZ76QKQ86vlRBJWto3hVIqEd5Ldu3SvfD3FHbIqSY7Kxm+luN7MRP4
 +N8N2b6eS9JCAwZhrPeuTId3ab2rBykliJ6zVUu1VwM+PoIyAIknbpnxeTv5Pm4Gcfpzl
 XwlxbGTx+HaY48o8aBwlzRX14QZsT9BwIRcBxwLs3zfX6Ead77GWN5TIacXh2pFfqOnnO
 THl2srdmKxvb6XZvIUauhghljLhZjKaw13NTqTRH9c7H2PDAZ5mzX3+57pwqBoHS8HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793364565;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=VlKYSEPGyIbrWEXVSq9iHxU4pMdp8eGHG7yuOopfurA=;
 b=TWye+080JfSgyCdyJDcCm/o5Gn8QVll+3Pri4jZbnNnpp5vL1cFXDJWnZZ3CzeixLPvB
 4dVUdlfNZvzulmBXSYPMtcXE0BG4gZzeGsKibdZAs59t0JD7PwGfpKW7pS9mflGmk30+5
 EAhsLZMt24c8kVMr4FOQMq2elH/gyWYgBRKy+2zqCQfdtvWpbxnn1KIgDUy6mYQmNnlNa
 85V1jQYtJQiy4E2g8eRBgu90f603u7Yn+oU0uPtO8s1b2AvE4jmEou/F8BIBAaPms3Fxj
 28ghhMIrgwN2OXX8DmXeh0qiGZ2s3/YK3ACkF56f7NtoTb0CXm8BauJRgaihpsQDwew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=l7rGwvwg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=l7rGwvwg
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1657340729
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:49:24 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4ed6d69bdfaso422793b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793364563; cv=none;
 d=google.com; s=arc-20260327;
 b=NCJRVEbCkJJyQBixuctYFowD0PD57Kta0CWK6pGbcSeyUp6BM52RP4YlJN89f6iwAl
 gItA9GGT0qoVKb0+iKs3Lb8VcT/wMdiQBSlPcGV8CtzRQFU7sTVuRqkxqZJRoz9WZJI1
 oCOOxrnFjLKrRhy45N8E996UliABLryLxN+suTdA9benoe0tqk2Hbll0eutSANqebQdc
 4Sawcu3GDFpKJL6uSJOXT4BDW0IFke4wp4UtsHGkgBp+phwnnzcUL83h/as7zuWgzDqQ
 kzuO7Q2QS1yyhSrh+/+EfAmEwWdz0k/NVsgDY9MlQruFU40hd/zmSWmSXdY5yD4ZesA2
 casw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=VlKYSEPGyIbrWEXVSq9iHxU4pMdp8eGHG7yuOopfurA=;
 fh=5ZpXdkq1X56xC0fX0cXww1sF5OLjnClYsBrZHgXQU5M=;
 b=IYmrOVmvEDNzvbg9pPvw0PXKxbwhKs9r+HHBRmNSKLmXBKWbolAheuqNHBXKq34RV9
 2owX2Zg2/p+Hu0mlPTSySl9V1UGSWaPzldNh8vWuMb5gKH/+pt2kaq1yw0YmCNaIresf
 8tO0QEDanxn99lvHnGmPjzsHyiohXHgGrz9Lo1f2SkmrMF1Vo6XfJwzixiGlkL849Nmz
 Vncc/2leMXloQ9TZ+8UlAy20rMorMoV0x62vB0TCvQwa+OhYWYBsSBI2PuZW2zt2kczg
 X53I76aOgk2UWUzhl6v2Wt9vmXzfqnfJNYCcK36Fuua6gDiuinEEFRq53U2vdaYUq3bJ
 D0xQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793364563; x=1793969363;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VlKYSEPGyIbrWEXVSq9iHxU4pMdp8eGHG7yuOopfurA=;
 b=l7rGwvwgWKy7zwjeImo2BUN8Q/Tzmbj0piKyP5P1DiYXgZOHtjOX8o7KAyJT7rJ/Jf
 KHbwY9otlKl5fvJkvsDkwbfH5fAuSx44gOkZiova7Mi6UOydT7T6uU5xSM7pZLaOk1JL
 jvlNhQ8S0PPtz79+LSDJAy1fsr8ChdyHbzC87KDE7OCHUoSS/HZNYOBLUdOP6omCMJ/L
 lME3MPfXZlA+TfJvoGaQGHPCbXBiBD4FlImAJ0fRPxN92kc7fuM7x4kRcxB/M0FLH8ES
 txCluQJWtM/0yJ+kzA40QZ7n7tTPkJBvprhXL6pxsQOv5Cq2jnymYWYponD4l6kGNdjF
 Su+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793364563; x=1793969363;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VlKYSEPGyIbrWEXVSq9iHxU4pMdp8eGHG7yuOopfurA=;
 b=Q2JY5eF82kQzCwJ5q6QyYAkNz7ftqgfTZL2QFLZjhsQIH5eWOZlVpJxgW4031Hejvc
 9sHMUSwnJYYt0/pj42WEIxhOuAxHm8pZ/vZjjjBuQOC6ZlChxNZYBuNDAjHbrj5onqxl
 9wF3fYsd8AzWhYu4QVBYkA6g1EiY6QY7G0O/pHBewWdE5N2oZb0OJykvo4y/9qaGHCmM
 BtBckRWVEaoIuEYOEX/yBPTjM76728+f5wBm+SqJ+mIfot4vrSf8pl+i/jbvCoFpURLp
 YZoT/t7WvMGPkyWIBHeTUohS1yZzos8MDPz0jbyHveMIsYH0vHsoz1xHQdWTw3bqyh/t
 /MGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8gUdLqC7huWY86SowuyGp+RU3o5d0Mzd2FAxsH3yKqr8P3kPpxNyofc6iI0f69hDTG55sF4I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLClkDaJIV1rOVlBVVxUkm3Pr/MlAZ+yjQSqPdZgHa1mfdjXuv7
 1gR+L1k9fbkrzHj3aysQ4G4ARGwuvVZ2aDzwnTUnGcYIMWRkI0iZRTSvQ+BLa5S0to66EbCrUN7
 c6TgSCT4ou1txHKpZfCLcuF9gmTS7bnM=
X-Gm-Gg: AYBFou2r/HaF1Cu+0f3tzgnra10+hTVg6WIpxD2weJ/LEEoksHmNp9mjEkxcQuaie4T
 7upzNVZLbZWUujiUfiQCSnpVvpeeeNmMztw3xnz0vXg/Mm3G+5umtr6tQuS5JM4UUZY0juvsUxE
 FJdhVMFbwdcDAExGUdNQvKjTAJ7cAN8C4l4s0nx3sDmnCyvvE4dBOFV0/YVDIewjrCiLW6XXDxa
 jZuhNk5z9ID0n/6JjPDOs0OFsxPGes1CqUZtnQXYiGmZnXzAHEQHj42wOq2uRPb5LpcOgAuiO9c
 HVLgWG8JBrkQ/LBXCKG+dgs1ifQHF1/xG7YsKr3Et8fdl02u8ZE6viAZ3O4iG/U8l/kpq9Si6vN
 VOGYho+yVnhpsh8a5NDq8ZBaNSiJ9sDOW+Mgsog==
X-Received: by 2002:a05:6808:6404:b0:4f2:4d2f:7ba with SMTP id
 5614622812f47-5640d953debmr1604646b6e.8.1793364563557; Fri, 30 Oct 2026
 05:49:23 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 05:49:23 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 05:49:23 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <f3dbda99-feec-4f5b-90a1-1b1b8242f5ec@gmx.de>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <5b986292-b889-4e1e-9e0f-9012ea225366@gmail.com>
 <f3dbda99-feec-4f5b-90a1-1b1b8242f5ec@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 05:49:23 -0700
X-Gm-Features: AclHuK_hItlz9Ha8e_5ITCq3GSGdJitx6JNZoDrBRZUGCEfv1QXLLD9TZA_QdcE
Message-ID: <CAJnxHsj2eDKSiY7kiongtGA_GBOL7V1PC+P9P7Sxm63sQRmUaA@mail.gmail.com>
Subject: Re: [PATCH 03/10] efi_loader: reject a PE section whose end wraps
 around
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On 10/30/26 13:35, Heinrich Schuchardt wrote:
> We use  unsigned long virt_size. So wrapping around may not occur in the
> original code on 64bit systems. I think the comment should be tweaked a bit.

It does wrap on 64bit too: VirtualAddress and section_size() are both
u32, so the sum is computed in 32 bits before max_t() converts it to
unsigned long. But the comment should say so. In v2 it reads:

	/*
	 * VirtualAddress and section_size() are both u32, so their sum
	 * wraps around at 4 GiB, on 64bit systems too. A wrapped end
	 * would make virt_size too small for the memset() and memcpy()
	 * below.
	 */

> The comment above says "Calculate upper virtual address boundary".
> The parameter name virt_size only makes sense for a variable holding
> (max(end[]) - BaseOfCode). We should probably fix that misnomer in a
> future patch.

Agreed. I left the name alone here to keep this patch to the fix.

Thanks,
Ana
