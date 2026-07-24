Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AEFC531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 14:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4258540B50;
	Fri, 24 Jul 2026 14:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8p6Dyb3yxt0; Fri, 24 Jul 2026 14:02:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CD8340B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784901735;
	bh=Dt8ity6aKm1YV7JvCEDH/sb7cB985DV7KfpCQbtrhds=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RnNTz+dTJumizCH5No0tDQy8uSN3Lj9GzMDRtt+hybTFeB4/X4/tQYyfSPhtJXlJZ
	 W3vGQhzoJUAMI/MzVFlKwBQh39egJmrYf2IXmhMNYAMk6a/+f6cTHjW4LosmCEiNtl
	 s3jtzeDZutMsIyV4iv27qh+QnYR0YBoexxME8zBw7q2xwfCDylmW9j6jqZCRVHNhtD
	 FLYs54fE9YgyaQHUeLHOqL3Jx4he3tSp2uAk2sGtJhEt9kjIqwMLv8uI/w2qWMB4wT
	 k16RAT6KNMRxSk3lSb3+4m25kUxhcFiauJCpcgA1h/6EX8MY8ceuEgFQLuh6ZazPC7
	 LLIFFmvZVdejQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CD8340B48;
	Fri, 24 Jul 2026 14:02:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 955283B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BF8B60B0C
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kogq3qcBeOxJ for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:47:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6F7DE608F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F7DE608F0
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F7DE608F0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:47:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8AC844E40EE0;
 Fri, 24 Jul 2026 09:47:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5D57A60395;
 Fri, 24 Jul 2026 09:47:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C3C0411C11E11; 
 Fri, 24 Jul 2026 11:47:51 +0200 (CEST)
To: shj <shahriyar@byteray.co.uk>
Cc: u-boot@lists.u-boot-project.org,  Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,  Andy Fleming <afleming@freescale.com>,  Reinhard
 Pfau <pfau@gdsys.de>,  Che-Liang Chiou <clchiou@chromium.org>,  Dirk
 Eibach <dirk.eibach@gdsys.cc>,  Tom Rini <trini@konsulko.com>,  Argus
 <argus@byteray.co.uk>
Subject: Re: [PATCH 0/2] tpm: bounds-check device-reported response lengths
In-Reply-To: <20260723-tpm-trunc-resp-v1-0-72a54ac30f4f@byteray.co.uk> (shj's
 message of "Thu, 23 Jul 2026 16:01:27 +0200")
References: <20260723-tpm-trunc-resp-v1-0-72a54ac30f4f@byteray.co.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 24 Jul 2026 11:47:51 +0200
Message-ID: <87pl0cra60.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 24 Jul 2026 14:02:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1784886474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Dt8ity6aKm1YV7JvCEDH/sb7cB985DV7KfpCQbtrhds=;
 b=bnzFZeRbbf1qaFnFsB2A7azNP+ikgiIiyEzv5U9C2A20Qv8Ejq0RJJuJVW09c7PE52wqOn
 61EfO/yswRHa6l22b/EPieVnxMpQDWSeVKUoT7p+VuiiVKS797IlsVAjPGx5u8aKn8fY2W
 F4yxR6PPwP2YyAmhtmfB7erIT2lSUMkbv9wjknbGoyWjS28WUixl7tD5FrXAVc5Or6jh9L
 yb11LX/t/0gP7V06uLxiwHb8YynShLK7RwFkk5j5YeaZV/chYtXxHp5orHC15Vaq0rfNIz
 iS40jyl7Z3GmIJJslAogCg8z0hgs4FPIHqM5gSlTsuW7xor2SLCc3khTrePr5g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=bnzFZeRb
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
From: Miquel Raynal via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Miquel Raynal <miquel.raynal@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello,

On 23/07/2026 at 16:01:27 +02, shj <shahriyar@byteray.co.uk> wrote:

> A TPM reply's length is taken from the device and only upper-capped, then
> several callers use it unchecked: the TPM1 OIAP helpers and the TPM2
> GetCapability parser subtract a fixed header length from it, so a reply t=
oo
> short underflows the subtraction into a huge memcpy; the GetCapability
> parser then copies that many bytes into the caller's buffer, so a reply
> longer than the buffer overruns it. Because a TPM sits on a physically
> accessible bus, a cheap bus interposer (the kind used to sniff
> disk-encryption keys) can inject such a reply, and on the TPM2 path this
> parsing runs during measured boot, which is exactly the physical attacker
> that measured boot is meant to resist.
>
> Patch 1 bounds the reported length against the header and, for a properti=
es
> query, the caller's buffer. Patch 2 adds regression tests driving the TPM2
> parser with a truncated and an over-long reply through the sandbox emulat=
or.
>
> Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.
>
> Signed-off-by: shj <shahriyar@byteray.co.uk>

Thanks for the contribution. Unfortunately, this is not a proper SoB
line, you must put your real identity there.

With this fixed, I am fine with the approach,

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
