Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4E8C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 13:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C939840B0B;
	Fri, 24 Jul 2026 13:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjLmEgaBP3zg; Fri, 24 Jul 2026 13:15:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0901A40A0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784898908;
	bh=BmgAGDHhvbvMucgIeUsGoY094ORwEGom3glKa9Ak2VI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T3dV0lJGtWws9LtX97xJ9JqtpY4U03y1lV37/kcPxcoAzASZnNt8b9RekXP5xKFhW
	 vyRT9Z5QmqQl9fc6+SHxwfscrM0xQ/wCSnDgrdlTp7YWSBQakd6EAnbs++aSiy+Uj1
	 Stxzo6EkSenmgOvTxKzHlkOw/u/5t3OjNx9e8jZk5COPrUBTKuQ7W35oJgauGiRz3k
	 fv8dCUNBbhQWWa3CaQs7s1IwJmIOSLaSgtL+XnOaP24NW29pCrqGLXNXrwfx8xzy8W
	 9XNzqdp8y7mHa2K/K0Chdk15eszsTz3UTm7l2roskIQjcVFRqX9cayR11WAuTxrn7S
	 qZXV+K7e2sfFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0901A40A0B;
	Fri, 24 Jul 2026 13:15:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A0FB350
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 13:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C72640A0B
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 13:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fqQj6iEYBALu for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 13:15:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4E26840A0A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E26840A0A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E26840A0A
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 13:15:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BEA83E76; Fri, 24 Jul 2026 15:15:03 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C512800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 15:15:00 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14BA6600AD;
 Fri, 24 Jul 2026 13:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246E91F000E9;
 Fri, 24 Jul 2026 13:14:57 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
In-Reply-To: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
References: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
Subject: Re: [PATCH 0/2] libavb: update to AOSP 1.3.0
Message-Id: <178489889597.185493.15058174427127039022.b4-ty@b4>
Date: Fri, 24 Jul 2026 15:14:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784898898;
 bh=BmgAGDHhvbvMucgIeUsGoY094ORwEGom3glKa9Ak2VI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=auaFoADcHZ0Wp2yjZTgMGB59/6rgmaCEyPIxhzx9/GfG/6h6hV+ovZVvPGl/5qeyj
 0SLfwOodjhih9IMSt9tqp61rmtnTO+w1hOszU87nLjFoQM7uV4ZPYuPEWBR2/ANloq
 nLTEuPpLUcfdgIbaJ1WHQ+xOqGeoiVDHI12kgAn1DmhwfJB0QABWxkvuCveo9r81fa
 +Y4WIndGJHHEfC03q1NtEcBqQFfo/XTKRliKw0mMht7sdlQQ75BLGYvhoMzqu8TCOP
 w2yTR77NghpbSZU6chwjzskfKrRNAbcaymzpVfwieA5+x4OEbaYRgTZIPSqrAdL1lD
 Mb4Twr4IoHLpA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=auaFoADc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="auaFoADc"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On Sun, 12 Jul 2026 16:07:09 +0200, Igor Opaniuk wrote:
> The vendored libavb under lib/libavb/ has been frozen at a ~2019 AOSP
> snapshot (AVB version 1.1.0) for about six years. A v1.1.0 library
> rejects any vbmeta whose required libavb minor version is greater than 1
> with UNSUPPORTED_VERSION, so an image signed by a newer avbtool that uses
> a 1.2/1.3 feature fails to verify. This series re-syncs the library to
> version 1.3.0 and picks up the accumulated upstream fixes.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] libavb: update to AOSP 1.3.0
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/963ec1af8a4b6d5d185ad289dbb0178ef2199d5f
[2/2] doc: android: refresh AVB provenance and pin libavb reference
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/f8aba1d9c54c19a7c863bd5b4d035aa46a10bab0

--
Mattijs
