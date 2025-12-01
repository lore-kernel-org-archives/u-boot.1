Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7134AD111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 09:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EAA83A8D;
	Mon,  1 Dec 2025 10:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fc7ZwLqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4F1183A8E; Mon,  1 Dec 2025 10:29:01 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F7A83A2B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 10:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c7613db390so1927538a34.2
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764581338; x=1765186138; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vrbJNEDbF/izUKweKTbC9svyK2CAnEiu7VN7glMN11w=;
 b=fc7ZwLqJT7AnwnYBErHGuVuB4DFmINmBCEia+V9H7a+SNlrcmzVXMSR1ABcoi/AoUe
 q7zLWy5zRgGAbM3BBM3WEhPI0N8dJPXnk1yyy/cU6TVmIIXCjWKHIe3a6Vl29RRY8s89
 8kYOywjTffNoeYFBIrfjwHyhya6QLanM3iG/7P8qD7w71pkakPy5JkUlSF22kgi7lpXK
 u8MATlKVn4RioQQ56kQVMjA1M59qBXxhuXOawNqIHTcLI2bn7KPpfvMX7XGe4KaziWKI
 8fTy/nCQz88q8UKDHEb/pzL11oPucESJSxnrsdgdbrK9dMkG+AhSrOJL+Xa78qef0NRj
 OJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764581338; x=1765186138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrbJNEDbF/izUKweKTbC9svyK2CAnEiu7VN7glMN11w=;
 b=JTZcl9G/bhheE1eJ1RvpsJdXDkJ2szsH5O5MvzeVkcGXz3Y0iwUd23TDHv8ZO3UfkU
 guniEKTOQo9Lipw55ts02zvk0WL9yHI1VJamo10KVeaVrdKRbUxLkeqlggkdCSkm5ejB
 SQ/PAnAz83MlirfmIdjyQmv4RDFlYFH3m+pK9ixlKPb8KgOGmUACQlOnteliHYP3KD+A
 +KDfFLqIldkErT+QNVlSLDWZP3PCUE8BOYn59cTiytuuDms9IX3eZAvGdEvRKONciStb
 s4ghJrIAOGAaZYRLBM6p/TYWNxqKLP3Pso6iTIZCeb2nBQAwqu8fxsRS1NxOG09gq4h7
 Q3cw==
X-Gm-Message-State: AOJu0YzE3dZzcFbGGAlWmViLnv5Y8ch4q4t8QJ7GpCL9Pt5bf3r/X6kT
 d+FDiiXW8GwQNPfcYKXPvVFRvA70h546Mrx0s32n9JdwcYUBXDBCfYUD55ixMB2pPxBreJjlRbJ
 dKukVbwW6DNADBAlg2F2sUScNK6h3x+CZGJm0tmmJ9g==
X-Gm-Gg: ASbGnctzHW2T5Ldz4vcbDOTqI1Yyt0NvbZaBWZtZAJeY87XY358JH2jGxQCn2e9dS7p
 FW//yQC4Q/2QooOn5YtZYW+bEo/3TNIh+45yINf8RYGN/guDVUqtbMfyLmBiAhcEo8fMqzqARpp
 COpN8tRtOOvUVMtf8hwTpnrx14wzXlPkzJ2c0uHdTvS9YxpWdZepPUn4ZkE+EP1bGspYtWh5mC2
 0uK6Alc9zlRxANBTO7IPgqD/hMRoePL0Z02ed39a0NECDi03TNH5Yv+LPywt9vYPZFDlY45
X-Google-Smtp-Source: AGHT+IFe1hPvOUQ/EW3uf3vW5F2y2T0my2c8RPo50a9dNFY+yODnk89WltovOn/zpdXwKTu4Ce8gL+J7Dog0Ybk9pFM=
X-Received: by 2002:a05:6830:2b0c:b0:7c7:6da2:6d6d with SMTP id
 46e09a7af769-7c798c4acb9mr21547318a34.5.1764581337827; Mon, 01 Dec 2025
 01:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20251119111653.456-1-briansune@gmail.com>
 <fcb799fb-4eba-4155-aa0c-46b5279b7171@altera.com>
 <a2600334-a459-4063-a76c-cd14b8698356@altera.com>
In-Reply-To: <a2600334-a459-4063-a76c-cd14b8698356@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 1 Dec 2025 17:28:47 +0800
X-Gm-Features: AWmQ_bmn5ohsGfPTHAwx79o-L5TN5iOsFsOZpg3BpWXlt2XoS9Rek2eBRXEgF3A
Message-ID: <CAN7C2SCEQ=hkgB9cDkNz7qNde85qtz5isjaWkCYS6H2QFdgvpA@mail.gmail.com>
Subject: Re: [PATCH v8] Add optimized Makefile support for SoCFPGA handoff
To: "Chee, Tien Fong" <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi T.F. & Tom,

> >>   arch/arm/mach-socfpga/config.mk | 50 +++++++++++++++++++++++++++++++++
> >>   1 file changed, 50 insertions(+)
> >>   create mode 100644 arch/arm/mach-socfpga/config.mk
> >>
> >> diff --git a/arch/arm/mach-socfpga/config.mk
> >> b/arch/arm/mach-socfpga/config.mk
> >> new file mode 100644
> >> index 00000000000..df1eb909129
> >> --- /dev/null
> >> +++ b/arch/arm/mach-socfpga/config.mk
> >> @@ -0,0 +1,50 @@

> It looks like the patch file may have been corrupted during generation
> or transmission (possibly formatting or mbox header issues).
>
> Could you please resend the patch in clean git format-patch (mbox)
> format so that I can apply and submit for PR.

No thats my mistake on manually modify during V7 to V8 as you
request A10 is not involved in this flow.
I simply removed the lines but for get the fix the # of modification
from 50 to 48.

Sorry for that and script/checkpatch.pl cannot detect that.

Bests,
Brian

Hi Tom,

It is possible the checkpatch.pl can detect patch heading
and sanity?

Thanks,
Brian
