Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0418BC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE29080DD2;
	Mon, 27 Jul 2026 12:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CQaXIlPwxZJs; Mon, 27 Jul 2026 12:29:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91E5980CAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785155388;
	bh=lm5QeYg402wI8mvoI3h1utqrYrqUDku1uYOffnb5k7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tZMxUZ3cAjm8ptve9ZWXHOBvibezaq6WURN24Gmac3IxhXrQMegFyHpHLgN2a42Ug
	 3Vt1RgeZgKcEnUE87lx4viU2ZpB0cZLvhg5ANm+zpR0WaaI4pu1AzhjChC28PXUDv8
	 jUTpEExMBkkE++CMqsrplXkvzHK0TFOCyXQbGxFmJRPK7Ra+Zgdjra47jgPi22oTh3
	 dpE2OyQGmEgq4JK2G2rzSKKZMcSu5f41asw2MZ2lk07Zy3uc+iuJN/PjwVDfQotwwh
	 WQn9i5HU60EU6yCN6VEGP94z/xPuXhGYQwOtAWM4wroVQ0UeqjY3mBm+jvSAgCpXes
	 yt6N5t1JIJelQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91E5980CAF;
	Mon, 27 Jul 2026 12:29:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC34E69
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D95B24069F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7hGVNX_a5Iv for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:29:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9A65D40693
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A65D40693
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A65D40693
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:29:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 906C940263;
 Mon, 27 Jul 2026 12:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51131F000E9;
 Mon, 27 Jul 2026 12:29:44 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH v2 0/2] libavb: update to AOSP 1.3.0
In-Reply-To: <20260727-avb-libavb-1-3-v2-0-fcad1a79af24@gmail.com>
References: <20260727-avb-libavb-1-3-v2-0-fcad1a79af24@gmail.com>
Date: Mon, 27 Jul 2026 14:29:42 +0200
Message-ID: <87qzko39ah.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785155385;
 bh=lm5QeYg402wI8mvoI3h1utqrYrqUDku1uYOffnb5k7g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=L+WgOqXp+7GLs0zwd+qMRiohgV4t8N6yNGQQmEh1hV1OSVuLL2LPOIw17wDjfFAFC
 rZAzoHRbA0KSLKMkHKc98XL3LsHguDn04XLO6JgZrncAi0sIgD3qLwglw541FL89HB
 2kWUsLC/IQ+vJ+Mwrv3JZS27fOYTT6CeJj1PEqP4oKysHS4sOygCYGoMRhFl0wLZZy
 F8xbCEH73o98Qb5euXsrKLNB6k+BkgORB4dVlGq0moe7jWYhHFfEzOsvirn1wN/KHi
 l9/4hEOYv45/ecrr2atkLW1pN9887FWVSLJdba38iUrRfob+qdCf88+QQzt9CsA/ek
 dhoURCzdXqeTw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L+WgOqXp
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

Hi Igor,

Thank you for the series.

On Mon, Jul 27, 2026 at 12:08, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> The vendored libavb under lib/libavb/ has been frozen at a ~2019 AOSP
> snapshot (AVB version 1.1.0) for about six years. A v1.1.0 library
> rejects any vbmeta whose required libavb minor version is greater than 1
> with UNSUPPORTED_VERSION, so an image signed by a newer avbtool that uses
> a 1.2/1.3 feature fails to verify. This series re-syncs the library to
> version 1.3.0 and picks up the accumulated upstream fixes.
>
> The vendored files are taken verbatim from AOSP external/avb commit
> a1fe228b8654 ("libavb: support chain partition no ab"), the commit that
> introduced version 1.3.0 [1].
>
> Functionality the library now parses:
>   - AvbVBMetaImageHeader.rollback_index_location (v1.2)
>   - AvbChainPartitionDescriptor flags / DO_NOT_USE_AB (v1.3)
>   - AvbHashtreeDescriptor FLAGS_CHECK_AT_MOST_ONCE
>   - AVB_HASHTREE_ERROR_MODE_PANIC
>
> Scope / integration impact:
>   - The AvbOps callback set is unchanged between 1.1.0 and 1.3.0, so the
>     U-Boot integration in common/avb_verify.c needs no changes.
>   - The U-Boot port is preserved rather than pulling upstream's
>     BoringSSL-oriented crypto restructure (sha/, boringssl/):
>     avb_sysdeps.h / avb_sysdeps_posix.c and the flat avb_sha.h /
>     avb_sha256.c / avb_sha512.c are kept as-is. The SHA API signatures
>     are unchanged, so the retained implementation stays compatible.
>   - Per-file licenses are preserved (avb_rsa.c stays MIT OR
>     BSD-3-Clause). The Apache-2.0-licensed avb_crc32.c is not imported,
>     as it is unused by U-Boot.
>
> Note: patch 1 is a verbatim upstream import and therefore triggers a
> number of checkpatch style warnings. The files are intentionally left in
> upstream (AOSP) coding style to keep them diffable against external/avb;
> they are deliberately not reformatted to U-Boot style.
>
> [1] https://android.googlesource.com/platform/external/avb/+/a1fe228b86543a21739c51352f5ce72f134fccfa
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Applied to u-boot-dfu: https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu

