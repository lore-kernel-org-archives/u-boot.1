Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98E7C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 07:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7690380C53;
	Mon, 27 Jul 2026 07:38:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K80ctciIxZpr; Mon, 27 Jul 2026 07:38:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8728780C5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785137909;
	bh=+Alq/PB08CFRuttnDy+at5kk6XBNUdG71kzZO1kCdOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ByHg5Y1LlVKZiGbh3Ym14SNEc7Vf2T7P0QMeUB6K1O7Sl0RWc353T2m88Odf07L3T
	 wBI451nlrQO6Pfg0fz/Xulabpc8nay7L2k4cbfOzyPa+ZxnDxio9e0KHYtcNfGXW0Z
	 W2IIiwe9Xz3ZBiVNdHCumQtt231ou5Lhz2Bt4nOeKlPojyOU8hbrXKpiIVjORdhmX5
	 hHMU14NCUoitbC/sgAbGz8ykpxKc8iGOoMTvefJxcNQXQY2l98r2jrRxLCCkcguZno
	 O0kS4XagA0Pn/foYAms/j202dTGi1PGJe7AUZAfRO9itjvknXshkcuSNDSxf/3vLX7
	 7TzLCdvI/pcRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8728780C5C;
	Mon, 27 Jul 2026 07:38:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF17D2E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC7D6400FD
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8DBcvE9Ilor for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:38:28 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A54AF4005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A54AF4005F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A54AF4005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:38:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D619484671; Mon, 27 Jul 2026 09:38:24 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC31E82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 09:38:21 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEEA143A82;
 Mon, 27 Jul 2026 07:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ED01F000E9;
 Mon, 27 Jul 2026 07:38:18 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/2] libavb: update to AOSP 1.3.0
In-Reply-To: <178489889597.185493.15058174427127039022.b4-ty@b4>
References: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
 <178489889597.185493.15058174427127039022.b4-ty@b4>
Date: Mon, 27 Jul 2026 09:38:16 +0200
Message-ID: <87fr147uhj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785137899;
 bh=+Alq/PB08CFRuttnDy+at5kk6XBNUdG71kzZO1kCdOU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Nc73oyJ9JM46/qSIJi1KN1MAn/slsrrheHgsUpmnCNrWNDa5dpJCLvXh1BVRZgqt6
 m/8UpOF8asJw6T8RYNJrCamzpzbZsY9tgexLzjC7qX7wbSDrY+XASiUJlGZZRPivMP
 YuBlesLZ0JJERrwpjaRXsLu4hQS46ZGrbKbO+dlj1y6a9BfhJFHodyclT8x4YNgAhh
 VyXWSV9nUm9zVmXVEU63P2u92yWn7oWXhmUDN+gf9TZNZ6vstkznj+UJalLQmmRGbm
 Zk+lqRSuGfKqOCapZPFWyItexYvfpREVgnROWT69oE/7JJC4btn4RffeB6ZTwJyRPD
 kEc7vunMbP6dA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Nc73oyJ9
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nc73oyJ9"; 
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

Hi Igor,

On Fri, Jul 24, 2026 at 15:14, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi,
>
> On Sun, 12 Jul 2026 16:07:09 +0200, Igor Opaniuk wrote:
>> The vendored libavb under lib/libavb/ has been frozen at a ~2019 AOSP
>> snapshot (AVB version 1.1.0) for about six years. A v1.1.0 library
>> rejects any vbmeta whose required libavb minor version is greater than 1
>> with UNSUPPORTED_VERSION, so an image signed by a newer avbtool that uses
>> a 1.2/1.3 feature fails to verify. This series re-syncs the library to
>> version 1.3.0 and picks up the accumulated upstream fixes.
>> 
>> [...]
>
> Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)
>
> [1/2] libavb: update to AOSP 1.3.0
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/963ec1af8a4b6d5d185ad289dbb0178ef2199d5f
> [2/2] doc: android: refresh AVB provenance and pin libavb reference
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/f8aba1d9c54c19a7c863bd5b4d035aa46a10bab0

This seems to break sandbox build/test. See:
https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/48391

Some relevant part of the logs:
$ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --board ${TEST_PY_BD} ${OVERRIDE}
Building current source for 1 boards (1 thread, 112 jobs per thread)
   sandbox:  +   sandbox
+lib/libavb/avb_cmdline.c:371:48: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
+  371 | AvbCmdlineSubstList* avb_new_cmdline_subst_list() {
+      |                                                ^
+      |                                                 void
+1 error generated.
+make[3]: *** [scripts/Makefile.build:272: lib/libavb/avb_cmdline.o] Error 1
+make[2]: *** [scripts/Makefile.build:497: lib/libavb] Error 2
+make[1]: *** [Makefile:2210: lib] Error 2
+make: *** [Makefile:189: __sub-make] Error 2
    0    0    1 /1              sandbox

Could you please send me a fix for this?
If not, I'll have to drop the patches from my tree in a couple of days.

Thanks
Mattijs
