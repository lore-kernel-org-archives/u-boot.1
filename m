Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66758CD37AF
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE0F84DD6;
	Sat,  9 May 2026 17:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="awwGhcPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D029984D3A; Sat,  9 May 2026 17:35:11 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D003684DBE
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7de431da8fbso2426761a34.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778340908; x=1778945708; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JH6UHWycJxDVH2te8jbbF90vQwqlxfVP3QpWyoRT2GA=;
 b=awwGhcPj2ooFIVMpsAcmiAyp3GLX2bjMjweMiyWw+pq5DWAmOSd+p5y3qcJ51HXtgZ
 0mbDyS76QQciAjKSCkvtxN79KRh7TfPJSSXs2NQ4e0MrnxHqMtH3jrk6gsLZAtKKlN02
 iqzCeB/gxg/o51R7MAn5pdqd+WyxM6wXV2X+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778340908; x=1778945708;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JH6UHWycJxDVH2te8jbbF90vQwqlxfVP3QpWyoRT2GA=;
 b=KpGgSpD7NNOSQd9KuKn6KVcAIMjllrktMytH6KeXAK8XNHu26I20UK1YdvHxgmLFW9
 0yDObVMimz5CY/gRZUnGF/qUszUOb6Z83oICuTbGHS4MyzoGEtr+ryetQ+C+Sgt0uB55
 GEktkqt9jS4DMEQBrOAr0mHY5cmbGNED7tRsZ48zR5UmzT/77qF1Wl5E6HHPGpr7cazf
 5cyWYN3Vg8prePQpvLqnvDopgDZoav2JKC6pTiFFOM1Iv8nwnbNhnEpVArGFjkqeBNV/
 ViwkG1r7HvAvQzm9wN764lFDdbJh54U8JGRtpyOmlWAORsIl3lrVQCna92dJOfcsVAoK
 lnFg==
X-Gm-Message-State: AOJu0YzzgaveufeSTP1KE2kVPLnG3N1GmJkKWdRF+O9a358pkXYuejvx
 karOPtCZsn86kFGNbgiRBdK0P4urtwarj9a2LSalfvGxPdIzPmWJoZ6CXOzbWJyou5zwPKk2J8q
 +DIyH9kPjcmR6
X-Gm-Gg: Acq92OFPw3aN61m1xygQlEA2logh5xtyKf6Isd5o+RgVIcRbC06cQUzsofsTdsRqsiG
 o63UofGoXr150uGcxQt9YLUnJZmJUu1EgcxYtRXTKjKTiOd+t11gq/y86fqljUkH01iMhGr+7j4
 4l8gg/SqkbTen5aSuPA5PUbry2PhNwGj3Hmp+MeaaCPkMWnDPMBJjoZh9vSxVnIyTplox45muhp
 bUPyLZkmwQcwxSKc5EGQm0BEMnQiCHwthSXAAwJCkkR9XMUZIXD1I+HpA2VDaUSrveCXo6c5AKC
 9iuWeR37WoH/05zgSBAzcX5Ig1Y+vHy0Xlo8owbdKJe2pVeOYMaYvKSdrQgUVbORPrzhvHbf4ay
 YXk8a6svZM0rwgVcKKLAas91FeG8X9104LzCmwqWFAI6ESlGWXhdovOEPdisKs1Nci4BdAoPHpA
 HtlgC52h7yayC2XDX45MHGv/iu4jiApFpzPBaJqZOTknXDhPdBbysnTAysDwnpEGWdNkYTntVXF
 MyqNq17dMb67+KfYUd6b1KkNT10eSMm6127z6QDlZSszCbK5A==
X-Received: by 2002:a05:6830:25d0:b0:7dc:5899:c711 with SMTP id
 46e09a7af769-7e381f0fac8mr1836899a34.3.1778340908639; 
 Sat, 09 May 2026 08:35:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d5061csm3245952a34.15.2026.05.09.08.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 08:35:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <ehristev@kernel.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <3262be87-a39c-4676-ae3e-c8efd2f4ec17@kernel.org>
References: <3262be87-a39c-4676-ae3e-c8efd2f4ec17@kernel.org>
Subject: Re: [PULL] u-boot-at91-fixes-2026.07-a
Message-Id: <177834090811.3582249.4486134720128632781.b4-ty@konsulko.com>
Date: Sat, 09 May 2026 09:35:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Sat, 9 May 2026 16:06:23 +0300, Eugen Hristev wrote:

> Please pull tag u-boot-at91-fixes-2026.07-a , the first set of at91
> fixes for the 2026.07 cycle.
> 
> This is just one cleanup of some useless code.
> 
> Thanks,
> Eugen
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


