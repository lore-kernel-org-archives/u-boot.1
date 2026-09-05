Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7F2C79F8B
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 00:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ECD060C12;
	Sat,  5 Sep 2026 00:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2T9a61SfagZS; Sat,  5 Sep 2026 00:14:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3187060C2B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788567287;
	b=TYyG1iLTzgQinYuGIUvu5PWeDUbbOmWgezML/B13/9HnZcecQ6YE6eSMxZIzps0fnP0h
	 6R7sjTpkKX1VRBwFSBJjWpuv9vL9UmikB+E98GFHsDE6DnfEWKcclUC71M3KmuCxlyHHl
	 pVaussimOcZgUthUewSe2AGxje2hAFRZXLmu/oEzGSWfS1QKJE4DDkQo/RhZrbf760A6c
	 0fd6ZsaIH8SBPbKBpQjkPHQLGO2j43GMilydN79iBfFfBJ4xc3IEA9bWUH1y+aosfhpcZ
	 JNyUldlVSRGx9JZwSqM0seOw2mcnsH+SOUW+CCZ2gU5JB8Hq7mhp8QtMhMqVsxjZq1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788567287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sreCo0UJCuxk7GqJPfxly5HXE8i9rfudQIYjH4Cn3q4=;
	b=FcoMt3rUsU+LEc6gV+PQUqH/qGRRc6miolk/9bRJwJbOjy2tyAOp9NpZpGXPeNoQp5NZ
	 sSfcKTvW+t9XxeLCQQ5ixPc66LoxwkzHrSWoB7lpd3t6+1xzSbemTepyTrvZidDRzrYN4
	 mGgl7HJxm2nZd+0kyN4qoTdUOLNmv77S1hcoQgkyBloBqFvdRTpMyRJKg57QXMPdcZAH6
	 Mg6o71n5HvMAS87bEOQvsVJXkP2iGNwa+eN7Uf3/2bK5SDVemOoM86BOrWFML/m6bOSz9
	 J+WTEXXtof/6A260oGBXhbYLxcYElTaDOVyALxGRLvs+ynJ1xS7tZd62ofB1ZECEAMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788567287;
	bh=sreCo0UJCuxk7GqJPfxly5HXE8i9rfudQIYjH4Cn3q4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mTNLqO7T+NZIJnsT2TCUyDmBiMEGttEFtjC/CvYgjm4uv+PcWNdz4BnzMsxjDGDJs
	 /kNqx98o6P6TI9bCG04w48MkDHvc1Jgn32lChIOgsFfwuwXUuJvK6xDbh3Aj3XMVy8
	 Mcu5p8ZDsoy1tL5ZX/NFZGaBPrQPmF77lhv4GZTN0H1VfLtgWHjBTMFznWbUBMZfM5
	 ThNBQnGCePMnxL4KPQwyfeq6i6G1bl8nd32aA6HwLWUSuPlwhWGxifuP9JZ7PLVC45
	 drzalJc5doufNDcWnzoGnLOiLlFQnlC7J9GHWwejwBfYZDQHBvz2QL/utWGoAzHKUF
	 IiYf9XBFt6G2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3187060C2B;
	Sat,  5 Sep 2026 00:14:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 75613970
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6745040A91
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tcby5aAtkpZc for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 00:14:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9D07B40853
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788567281;
 b=PKTrJLeLsDPkuaPK4ja3ECnCUPr4fECz9C1J2tIb/nPMT35S9v6yW5MV6BZt/iswMbmi
 pzC1CKTcgWYdwuCHHHwc0ouTYmXeUB1exoi9maH+4vEI4j5OlIwnMzZTwWvHFsLV8VE66
 zzJSxXGWGnfLOBmayuc2NiWzHW+9cJxUksnmt1vwCK3spSmptw27U1S5g7qdwBoiGaMaa
 W6Y7+Et0pgMY34pXz8KFj88TRwL9wPlPaJtKmXcRwcyrqKkoAy/8AUT1S1wA6g2Je4lWT
 xFjwU8LPitTLfTS1fTiBwkIodHyKmf02RDuZztuY/lOeVnC5rCCbYkm1GDw6vNFwyuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788567281;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=sreCo0UJCuxk7GqJPfxly5HXE8i9rfudQIYjH4Cn3q4=;
 b=Cun+CygWSJ7wmGUJ50vCOEMN8CMfONNOdvF3a+PAwj/tpTzttVz4rMlOoI9uIvIWM4Ri
 MG+Mc5QD3x5b/Z7B6D+RaicR5jbjs9vtx9gvmQxMVc9QS4VOviA/w/EWeeILvtCEeZkqK
 h9QNt1o0+xYa0bAkA9DPaxFG79LgNHRMSbUY7xpMOM8ZlzhnnXNbAcM0XHmlvEJuT1IZD
 hDv7CigIiBik7x1iRb6Z8zcICGjAtEse5KjdXhslKvEiqqeZ8o5bHE6thKNKuKUVwRWAl
 2WufpxbIMLa2n4vRqqoHtJZp7+sl+QWYzcwnbe1yljGX+f8H3AsjbmWRHn1PoPJmUOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sbQJpmZ6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=sbQJpmZ6
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D07B40853
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:41 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4ab47c40e7eso1112943b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 17:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788567280; x=1789172080;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sreCo0UJCuxk7GqJPfxly5HXE8i9rfudQIYjH4Cn3q4=;
 b=sbQJpmZ66+AzHgYvxrXhVoKkFuugbZy0ql/dM20PSEYkWPsIODm6zNSiSOBscCDJBX
 Qxz+VM+WjVz9ykh9uZSMj/vOvnTtXm97NkM9m1RmLX9Z6dQ/nWXUbZDSbmIWrlDYn0Np
 wxnqxYbzTTascPMZvhr4iugDTb+3VC7ZWPM6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788567280; x=1789172080;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sreCo0UJCuxk7GqJPfxly5HXE8i9rfudQIYjH4Cn3q4=;
 b=FQTuAUnbhw3rdysrv0pEClR3E5FwWNBAeyq5O3sYPBAujko9JfC6D+6jKSIYgMt9yc
 u9lY/1kE3fSwDZ45sev+Q/Mlw9BnffbFHA7Ftw3aIAA7B+wlo9gls4+hFDuyxu+lmeFO
 ZGOYsp4QT1umQniIxhTDR31yiYvA6QucjTo8H52K4LrFnDuFzmgQaC5TsnbPPwN4/VW3
 gLFaUhQhq0/VMl8pbMZ4mFLNBclpU1aCXVL7VekZVCHe2KC6iz/ShYPEB36hgumYlAKn
 f2PT4avFEHLnCwrLHti2yI1zcR85bih1m6SHw78ndqW/7z4EG8+0S1SbwAzbz8v0uLFc
 om7A==
X-Gm-Message-State: AFuF++k5EbaHNxLvTXjqbuXF9yDCU2RD2HEiFBNTZOzBJ2OtdGJPh2dl
 UqFLRf47s9fNVuEYxT0NFZzK8Ii951eDargIESHRp/RegLFw7ls+gUx25D4/MNE9kjN06BCIP8V
 TNzCTujmlKm7I
X-Gm-Gg: AYBFou1TI6/vUiSu1rkqVmKXXMd5jyp1sDosXyddKOjmh1acQt+9QerUaGzEalvg7yT
 0wDz+GtcuCJbNzxvKJ7NytQxtO0wNfHXFypJ1xjUW8ptes0PNeOWYW6qlZASedaNfPVvOHauaPi
 e8IANSp5fadz7AqvP5h3JaYwXsgKWO9W8L+4AHpuj1EueSxPhKCxW54WaJdUUk5jC0KeFR0p1QL
 BWp/GrQ00bHFW04ClwkIrcgqcOmwWKxBPygRk0Mt7+Ed6EknWfaYRzhIb1kW1qSQNbAprp9ZDHg
 lVkkZnauHZAUBmEhX1iG3P1wHPdcgwZg35R6IrT1MVbYOzMkm/EEZ8WJ/cqAgZfBCpnawVP1k1K
 3kci1I5jbUDfo66ihpfgqfeG9O2EZIcGiaFuz17Lg4bXm5sLPcb+tRwN9IRacSLCWUOxdYujbXz
 gBYFTb65M43fbnOnRxdnMBP80O3zicrpTzMOPtvlaCYDQK7m3x+pPxP26MlaErdRVrhcsQBoVtl
 3uCN9pyB/3SdA3l0Q+wg7/plwaQps3xd88rpL7Pi3rNrYKc1/7B87EEyMOJKxyzqPPW4Xqrt0c7
 usNbX+qC
X-Received: by 2002:a05:6808:1443:b0:495:fb79:7712 with SMTP id
 5614622812f47-4b95c1b0410mr9116235b6e.0.1788567280252; 
 Fri, 04 Sep 2026 17:14:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b971b97c72sm4027463b6e.15.2026.09.04.17.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 17:14:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260904225055.3069347-1-trini@konsulko.com>
References: <20260904225055.3069347-1-trini@konsulko.com>
Subject: Re: [PATCH] board: tqma6ul: Add missing include
Message-Id: <178856727917.3086907.8568323766221752225.b4-ty@konsulko.com>
Date: Fri, 04 Sep 2026 18:14:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, 04 Sep 2026 16:50:55 -0600, Tom Rini wrote:

> This file requires <asm/arch/imx-regs.h> to know what IOMUXC_BASE_ADDR
> is, and had been getting this via an indirect include path. Correct
> this, so we can fix other bugs which happen to expose this indirect
> inclusion.
> 
> 

Applied to u-boot/main, thanks!

[1/1] board: tqma6ul: Add missing include
      commit: 7ae612085af409ba06372547ab81f9f1dbb05a62
-- 
Tom


