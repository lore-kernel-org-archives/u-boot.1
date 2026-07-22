Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7994DC4451C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E8CD80A7B;
	Wed, 22 Jul 2026 06:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h7IhqrRd004O; Wed, 22 Jul 2026 06:55:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AE5680CC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784703306;
	bh=3dthoKZqNHHTuCdDmpuDegKGEyhUrCaK9PhhNcs2tt4=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SsidLtM5MC1vEEbtZFyYnLKsjY+NWI+qwh3iCqASvv6fN9IpTlWoCvBfQdoNxKNsY
	 unBbmB/8luE2RBp4ZCSEXkMFfsJVtx8/oRhNnTpmbGCUzEc9MSpRSRjWTqg7MCy3Rs
	 gMPWiGLeKXtHvFhdM06yED75HL2bqVAlP8oIt6sBy6fIRRp1s3xwLkWmBRHHum+A7f
	 olaSJEDPGjKWEcyPem1d+AH3zjzxnKwUFh2O3dj67O6MN2GKa66xM2Va8b9RMyrWRd
	 vJ/7oSjuV9IXMDE6XmJnZYPuCBaQ6g1qhPbj+b+sxFpA0qjPc5XCj0A03sHpzYARDD
	 ewLuz6b8gB84g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AE5680CC5;
	Wed, 22 Jul 2026 06:55:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A690842A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 983B5406FC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:55:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mgCMn0iXpG1B for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:55:03 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8900A403EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8900A403EE
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8900A403EE
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:55:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9642848BA; Wed, 22 Jul 2026 08:55:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9F8803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:54:58 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A337543429;
 Wed, 22 Jul 2026 06:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC601F000E9;
 Wed, 22 Jul 2026 06:54:55 +0000 (UTC)
To: u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20260626142840.305478-1-marex@nabladev.com>
References: <20260626142840.305478-1-marex@nabladev.com>
Subject: Re: [PATCH v2] cmd: ums: Set Device Descriptor iSerial based on
 serial# env variable
Message-Id: <178470329369.163835.10555173122638201570.b4-ty@b4>
Date: Wed, 22 Jul 2026 08:54:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784703296;
 bh=3dthoKZqNHHTuCdDmpuDegKGEyhUrCaK9PhhNcs2tt4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=RmU6dKaOUp4GvY5enzrXLxcbDgTlSwagC0TmJvKFvoR8h6KiHpBA8grqQWJwS3lxu
 J2avIdnEPPWXexT1TW0zFnTOmwqSaYOl/EAarroWtKq5RBbP5kh5nsHkT7XgRaBh8Q
 nI4anPavupYc/byCvEGl57FF5mi9+xyLsF2T7xTBOkBIjMapEt8MBUpSokMJS2F5um
 /WyIeuFugLNvqAInTQKBbSxgicBnlHerAdSbXe9fUZZsnvpocsbLQflr+qObRrr5Dl
 hvFfr38vfd/Pxczyte5RZfHCZ7ojugqctRSy6gXHvR8utU2bqE4uwIN8kprEdM4bbl
 ecc48gYuPoh0w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RmU6dKaO
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RmU6dKaO"; 
 dkim-atps=neutral
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
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On Fri, 26 Jun 2026 16:28:17 +0200, Marek Vasut wrote:
> The DFU code currently sets the content of "serial#" environment
> variable into Device Descriptor iSerial field. This is useful when
> there are multiple devices connected to the same host PC and they
> have to be told apart. Replicate the same behavior in the UMS code.
> 
> Example without serial# set, which is the original behavior:
> "
> u-boot=> ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] cmd: ums: Set Device Descriptor iSerial based on serial# env variable
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/3caa8f42e1f657177780be5a445502cbb9181e43

--
Mattijs
