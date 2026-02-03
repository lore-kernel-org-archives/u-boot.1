Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DD3E8B361
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 21:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA2483DDF;
	Tue,  3 Feb 2026 22:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ES4CySi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF6483DC9; Tue,  3 Feb 2026 22:12:33 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD5383D77
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 22:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-668fdb244c4so468728eaf.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770153150; x=1770757950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IW5vyPc2HruEYJPjQzH4YLyCRiiSeCMSf6RkyUYRvP0=;
 b=ES4CySi5UiWNsDw7gBHaIBn1FGT3VoBPQPJTHpuWWoSu6tGwFFDI9HSiqwhGfYw9ms
 v27waAdXTgdB0lwIfOrwGuNj4tENTsg5vJGPN1tDbGSgnG4Oeof/uwTTJWJbCHcLUvWj
 YRu17uCwGchH5uOJLO4kWeE53p1cFwWRzCVg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770153150; x=1770757950;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IW5vyPc2HruEYJPjQzH4YLyCRiiSeCMSf6RkyUYRvP0=;
 b=QOqbQUp4JEMAz5cIvtwpqsyLDAXa3dn7k57oepggsxTWyKwH+DkcV0KLtJffmGGiam
 3JO0YA56rYTp01AwuMByrrSLpJZxr9uDn36PQABVdtfdFL9qDptMm7Zt9DWKveGYzo1T
 RcZsyNNGDmT1cOG1uVLcxqjffWQXU3wgT4oYRXXCsvPGd3J9PjjDaaQbUnepcYbDdO/H
 MiemniPmsYqjJg7Bzc6O+dUkHHWqgm4h0FchWiXQMtVDxd/Qqcex/UuMLz5zIcRgnIhe
 7EV1o0EWkGu16DuWY9+Y2xpkWVuFLugNO6BRQeeT8hpmEI+xij88BMvvcUCWwSZ0Vzu4
 xOdQ==
X-Gm-Message-State: AOJu0Yxs288DiJjs/MCHifXOH2Vje3/OxyeV1T1TL5qz4CSl7Xk0yA83
 LyaDubwaz/j2enQcQTlZ1ht0RHv7fJgEnCmeU7LC/MLhhI1Wo5WXszT6LHLGxuJO9+y4gsbPdbw
 zNrWfR6Q=
X-Gm-Gg: AZuq6aJPngCGhPlmWDB65BqlIKRqxPud+f4J80Xq/Jw60AXnpdeb/aH7XwA43h+4Y+g
 M4jT9gfJmgiPzp3lgcFdcUOGPcUAAnCmW4lykguKY7SDv6d8XBgwWFBMFH20M37me4z7poR5J/m
 LvP2zcqVZ+50oo4Bssw6ePtD5FOeTbX3kZ8ZeOOOLDo34NlCWxI/5D8ECg26My4dlCfIImAJH4v
 he6TcJm3GTjtrO/XwfFCkqCD4KRca/0j/0TORtARq8ok5anmtc+b+EmzgtDTKqtZcqDt33Pteat
 zUKWN4MgzbT+s4VgmzmHIqJdyifWBsHWMfwAMpAC/vEKSzW79FtbuLrSEceHILq+IUCxRZHzHrV
 8n2KmxHleEfUt0BDVQ7ohce2Diusj9JLDXaCV4ztkn5Myv9k4e7rlLqJiLtdryJlK0SBsWuvjRf
 K9dnJ8XTrOtYLa3vo8+Bwmhv9g8FWIWJoDihLN/N32x1lOhBdoZg7aujUxq1H+cjzVwgmPuQDZe
 LGty1Jf7SHWqtAcspfONbYqKL/ROLJQwoYBMhJhG+/hR0qt
X-Received: by 2002:a05:6820:62a:b0:65f:6c31:8dc4 with SMTP id
 006d021491bc7-66a23337880mr434361eaf.60.1770153150271; 
 Tue, 03 Feb 2026 13:12:30 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a35f7a4besm324630eaf.17.2026.02.03.13.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 13:12:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>
In-Reply-To: <20250724163156.1372667-1-eric.schikschneit@novatechautomation.com>
References: <20250724163156.1372667-1-eric.schikschneit@novatechautomation.com>
Subject: Re: [PATCH] x86: Fix TCPA bloblist size
Message-Id: <177015314958.1503561.8371006247314624551.b4-ty@konsulko.com>
Date: Tue, 03 Feb 2026 15:12:29 -0600
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

On Thu, 24 Jul 2025 11:31:56 -0500, Eric Schikschneit wrote:

> Excessive default value causes crash on hardware: x86 baytrail E3845
> 
> It is unclear where the data is being populated being 'BLOBLISTT_TCPA_LOG'
> is not found elsewhere in the u-boot tree. This leads to confusion about
> how much space for TPM log is actually needed.
> 
> This was tested on hardware using TPMv1.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] x86: Fix TCPA bloblist size
      commit: a22a4fbe437b85a5b7f4b601dbd0e273e95fca4e
-- 
Tom


