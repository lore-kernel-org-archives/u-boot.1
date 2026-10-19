Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20867CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2B966073D;
	Mon, 19 Oct 2026 09:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iBMlxtwTpAl7; Mon, 19 Oct 2026 09:59:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73B35605E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792403958;
	b=sQr9N0mn6LNJ1NCulaW3026Znc9YOpnw3Ae6uqn1an/+R9PdaFs5ME5Op4+WkgGcoqek
	 oCRpyVXyTM9ptdFoco16+QjnuMMpOELjdPVMJXyWGmOudLa9YFXi7IIeeVUeWpthEbn+H
	 ohIRnuimWBA4kURAKER5ezQrzWmPnjoJhWEb3gEtQI5pDgL0y4Vbls7BbTX1yVSypvgL9
	 eySQ4s+X9OIzgScNigvkOfZU5sBSwH/0XI21OQvQLcjjt7/sqqCUzVhj3JJV3ZQ0Rl7E+
	 w2RnuxK7aLYVQfhSQcbnFn2dM4kPj4ETGY7/1rFAzIRa/TBVM4bNThiJNvmXSkMa6jQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792403958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=721rIvHurXvzbsv3ReoZHJIOA30PI2Ctef7JDRu3I5Y=;
	b=jBYpmEkvFRTgZTkAefpZaf6yhA+724eo9DgIvTjt3NUTF949jVfyofWPpi9NLPRLOBNq
	 ZamdYPYV8M5axt1fKh3VCttH8B8ziqVJzv7IzZuU8lLwYDUkGVD2P63bUk6GmTTLseKOi
	 Gnd6tXqnW8/u2fUusQo/35IUcb4sO/QSb0PFYOEB1QF3Nn9FVPHTjS6QSu7ouo9edm5E+
	 AZkuCi4w/zq963iUlF0GOnZusX0dBOy+exRUkxNw8vQjgqhKbeZkF1uIgbd7jhmmB/yis
	 ab4IkVkuOyUIOxhi/nCpb6+rmBXY+O8aQdw2EvXCJANPB54tZ3+cJgUaHy8vcSBEggg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792403958;
	bh=721rIvHurXvzbsv3ReoZHJIOA30PI2Ctef7JDRu3I5Y=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1QCsevZ8JfZda4wNiOmrwXE8ZRUEhjX5peUCDVILa01KwZfBw+tV0UEVR+C6t3Ahp
	 7HaPPeQnP/NGgEdce/0i3VII2xMYIawSR8VyJnkTs1z9k81yxLuGhj04VibZeyS33m
	 /TDPeochDtuY13G5kgt38E9cJs7x70jABHjmnvAplEcm8owJL3gkNBwU0l+WykQ1MH
	 QvZLIHnZORliGGXud6+LYh22WH8oNoI0Kp1tqyvJeNuYTIY2k4oefg7sdRM1VGysWb
	 3CDfpDSVX1zNuk9KPivmn4oFrBnGJd2uC29b8dK6rKFSc52vAGF3lMp+HPzwTSWwFH
	 uKJWCmn+longg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73B35605E6;
	Mon, 19 Oct 2026 09:59:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D1124769
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B67FF405E0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XgK3xim1af3w for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:59:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 92E64405DC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.169
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792403956;
 b=ZTzFwTUvm/8u2oAOygvHbINBl1+2q6qmTR1GfOYZXRHqkErP5G6maC71wO0H+FBYwNEU
 PfdlhVbu6VJAe2tnFBglQI47zNPsdvtR9umA+kE3chanOVme1IJ0AA2RhfsxLidjGpTrf
 GeBT+ZjK78CdGr6CFRwHzwqr+/QA6FlqJzXxrLbWtwGBZA01gxMJxT3v6vIFOk83UUbig
 A7N42SKkDUflUu2cK5PAx/47fM408aJK+UvnAcz1H4JqxfWRudmniyXJLlSYe94LcU8+d
 54J0odfEO5pVmYTOKk9E6KEcDSgJor1i/ypPy1RuSwMCJQsuvA/YXw81qbdBZx5c1kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792403956;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=721rIvHurXvzbsv3ReoZHJIOA30PI2Ctef7JDRu3I5Y=;
 b=eT59oDlliYOFwEAf8/iTMo5DEFzJfTXDWi5AlFFBov+1B3jR9VmCgZjZJytbtJRTYWZj
 wej/C815+vWl5Ad8ar/iOU2/WWb5HqyjdSBKx8GNxTwZs2b+GqmEnwjyqh2EzugpAxJmx
 DUCZA1sGfHUrtc+NoCSMqrKG6Wi50bWDuS2rCm/hyJ5UDPzh2gSyIidYAW2CIapanY44n
 xB4dU6PJI147loeJDPE7RefXM3ONJl7sle3G+g7587694YT9RJ4BRlNyoVznFHoff5paM
 sOg1gQo3hBqaz1DCo1oZ5NAoMYPws1GK4pk4F9BRIfqf4QGEpyHHr5yiG2Nrd9oTNKw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=xs4all.nl;
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b="A/7K5J4c"; 
 arc=none smtp.remote-ip=195.121.94.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.169;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=A/7K5J4c
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92E64405DC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:59:14 +0000 (UTC)
X-KPN-MessageId: b9d2bcf2-cba3-11f1-a05e-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id b9d2bcf2-cba3-11f1-a05e-005056abad63;
 Mon, 19 Oct 2026 11:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=721rIvHurXvzbsv3ReoZHJIOA30PI2Ctef7JDRu3I5Y=;
 b=A/7K5J4cd2ApTzLbyJKdZPQOGEUtI0W8Gm7xPjX8ecPuEaQfxGhymB49bQmaYW4//+AZcmO1l8WEk
 rT+91YMHPX8wenZSNxRYHoJiBXPxmQpTPjNTrAFq1lM+tv73XAqHdzvkKm3ntQS4PXDfA1+hvQJ64i
 bi4L8hKkYPfQskeB+dHN4dGdcMB5VqERK3pl21sFCnP+yzjXPLl+svh4cwsb9ODnfs0u+bDsaEVeED
 IIhAd3n6KDhXTSzKQ2O/IBqSP/xhs7MXEFwxcHZ06BoA48txoR/cntJl3s6E94EUG4VXTilEaX/RkQ
 sJeP/p6PK0pnpVGpm19E9A5ao0e2e8Q==
X-KPN-MID: 33|lT89nFkYjxKx1DAwBAr16pf1XzDFaOinkIbIlSIvSt6fEju8meFiBqp1PpIdXaX
 LYb6tlX50IDHOGpl9sWi15zubzxJQdvODR4HpReMKMvQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pugamrQRUnMwWgJiCK6kVC0V6jmSKdmXfgCrduLNU3m0dScKgMXwoSx0ayi5Nkl
 sI0qhM6LRmaEgyix2e8ypyw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id b95b93b6-cba3-11f1-bd32-005056abf0db;
 Mon, 19 Oct 2026 11:59:08 +0200 (CEST)
Date: Mon, 19 Oct 2026 11:59:07 +0200
Message-Id: <87a4oaypsk.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, kettenis@openbsd.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 sjg@chromium.org, asahi@lists.linux.dev, anshuld@ti.com, j@jannau.net
In-Reply-To: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
 (message from Janne Grunau on Sat, 10 Oct 2026 14:13:56 +0200)
Subject: Re: [PATCH 0/3] Apple M3 Pro, Max and Ultra support
References: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Sat, 10 Oct 2026 14:13:56 +0200
> 
> Hej,
> 
> this series adds memory maps of M3 Pro (T6030), M3 Max (T6032 and T6034)
> and M3 Ultra (T6032) to arch/arm/mach-apple/board.c and lists the SoCs
> as supported. It contains a missed documentation update for M3 (T8122).
> 
> The memory maps for the SoCs are becoming long (alomst 1000 lines) and
> Apple releases multiple new SoCs each year. I'd propose to move the
> arrays to headers (one per generation, i.e. "mem_map_m1.h", ...) meant
> to included only from mach-apple/board.c.
> I Can do that either as v2 of this patchset or when starting with the
> M4 generation.

I like that idea.  If you we keep it to a single memory per include
file, this would make it possible to diff the files to see the
differences?

> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (3):
>       doc: apple: Add Apple M3 as supported SoC
>       arm: apple: Add Apple M3 Pro and Max (t603[014]) support
>       arm: apple: Add Apple M3 Ultra (t6032) support
> 
>  arch/arm/mach-apple/board.c | 224 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/board/apple/m1.rst      |  14 ++-
>  2 files changed, 236 insertions(+), 2 deletions(-)
> ---
> base-commit: 5508406582f6f7120dce0c4b3059819a41788db2
> change-id: 20260907-apple-t603x-support-9e77ba0bf855
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
