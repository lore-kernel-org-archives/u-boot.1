Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEECA606B369
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zt3nai9D;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=OG0GJXIO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F808405DE;
	Tue,  3 Nov 2026 10:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJPFjndKhsox; Tue,  3 Nov 2026 10:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E738405CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700080;
	b=jUGX8FDJ68EKu8tun5g2RDSWiieizTctZ3GIeq6+ObDYDwT3QWFWWmcSb8kXUy6sL/sB
	 oxkwOCXs7N+dMFb1J8OKem99cddB9GAxJlcGw7U8NIjN0e3hnPF+OK8CCOHbE0/R0yBVu
	 ptkFg8gK1JPlTOlcu+kDPVoKC1qjW+XW20U5fmBRpEUfuiek/xcjMctc4o2C4oBCY6/bg
	 XhvbsHg/oqokf4tpQcAbQMfAW0gosPrjjO7FYX8f2xi6+zM2YhIlNrIBq9hMTTtnhuT85
	 mX27zIlZrDG8qOPPoKuDF55v6k2k/MP0x5E05dkCf+lfRupHnDU0m6RHW01j3y0/MZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1w18zzQr9y3xJ+33dk7BuUl0e0w6tiN296KnH9a3sjk=;
	b=I+0CeHaPB03HtRTQmGali+YLnFeu7NN0SfeILP4WSu36J2L5uq5S61QITO6JO5Q90mcU
	 Ykyd5zZsDr203yfa8F4umQSHLtyGWgnVlGipmX5fBMdaew4xRtR3ejSmYAUTpcIme6eNG
	 tFILfPcG8ysOC9tlp7OJaEoEskrs6q7CdRwhMIYUnSUqFpZePQij9ZnsJxje+HRbSddEV
	 DCIkk4HvBc1NbADw7ZhzFqrRL315COIqpB1UArXnWVIPfTtpoVBhwi75yqjBeHSOEDYIM
	 NjRPp7wVFTQoVty3KhcXD+xB/uqyN+BCygcfPnMg4Ozn2O1B9QWWXuMOuHcRRm7AFGA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=maquefel.me;
	dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=OG0GJXIO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793700080;
	bh=1w18zzQr9y3xJ+33dk7BuUl0e0w6tiN296KnH9a3sjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zt3nai9DcgUFOpx9Cm+DzsXl67Gr9Wlda8NFK4hxPnSp8f4X0icXJdM+/hpVheKs7
	 yN1mUepSOTHFzx/ZDxn6U5pDk9TKVZaFZjlxVWegrqLxGffvncHTDbfHZWQrHcW0Lc
	 +2lTJAWQ9R9/Ylr5Hwidp7KsZP0TqTZUs/RtJ3ieuti0uZOiGwFlgJu1Y86fUTI4hj
	 +WFtRUvdK7+BIeHoD3gN91b/+n8jBJifWJtG4hodcXpMt4SP3jCBaiznWluicmw6L/
	 UQthq6fkEb/EAStyEN23arXeF69MlXDipiEHK9k0fK/aAmIiLTgHCNAot/fAbIOWjU
	 foJNSK4WECj2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E738405CD;
	Tue,  3 Nov 2026 10:01:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09DC7D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3917405C9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T-p9TADZFGbX for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:01:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F2B6405B7
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c32:0:1:45:d181:d200"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700079;
 b=ni3L4duUio/i5Urn2XN494o7TeCjWYXfSx5G+EwlIht687Oq6bqr5UBBbjoQ+YYVvOPj
 NodKCC6WzzxHN113k96GHO1m+q6MkAvmgmAD6x6t4PCkEZ5azD85mpILAltZeotlV0ABn
 krztglUWKUK8KWVOH0o1cPXOowdSp5oonxprprJ8kKDdBhRMUBpIhekN6Wvl9zHuDieWw
 hQo+TaBe18slHJrIV3gNF543nwixXqUn15rpAhgxKJa7zvcyCycNf2JbLpfnhFxHwEMDS
 GcTVPGTH7vH5dGy8PDOL8EXpcPOeg6j4WKq4aOI2as2su9kEF7AyoeJCbkHLJJ1yYOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700079;
 h=Received-SPF:Received:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=1w18zzQr9y3xJ+33dk7BuUl0e0w6tiN296KnH9a3sjk=;
 b=AhVw6sKjBuULBu9ncL2uoWPeSqjWkyTEYW+xBH7MsZq4tlJr5boplaFaKtK4SJC8uSlf
 Z/q95WpNCHvMq1fLz04ilM5WRc3Cuz3tnNeDw5mEjYMLFRUhqhhRhHbVfUmMpmI45NPQw
 FasJl8skcsK0kqpiCugZ9cPafA0zlX/IhN9ROsFNnfXxydxrm8pjdnFn83nfG+BDxYZRq
 q+D+VdOuW8CXrFUYCPb0k9/eCtR4YIXLSsU7C/2C3tJ0UAgrcxCBzfuV3nJ1K1DDIcNUG
 ItaJ/4h5uFjqbGiQN83XBpkylKnMoI+8V3tsnNTenxeFyGOniQHi+1LDNZyHwt82wJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=maquefel.me;
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=OG0GJXIO; 
 arc=none smtp.remote-ip="2a02:6b8:c32:0:1:45:d181:d200"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c32:0:1:45:d181:d200; helo=forward200e.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=OG0GJXIO
Received: from forward200e.mail.yandex.net (forward200e.mail.yandex.net
 [IPv6:2a02:6b8:c32:0:1:45:d181:d200])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F2B6405B7
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:01:17 +0000 (UTC)
Received: from forward100e.mail.yandex.net (forward100e.mail.yandex.net
 [IPv6:2a02:6b8:c32:0:1:45:d181:d100])
 by forward200e.mail.yandex.net (postfix) with ESMTPS id 3330DCF896
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:53:39 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-70
 (mail-nwsmtp-smtp-production-main-70.yp-c.yandex.net)
 by forward100e.mail.yandex.net (postfix) with ESMTPS id 1F1EEC0034;
 Tue, 03 Nov 2026 12:53:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70 with ESMTPSA id
 OrH94I7pRiE0-e6TkKbq1; Tue, 03 Nov 2026 12:53:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793699611; bh=1w18zzQr9y3xJ+33dk7BuUl0e0w6tiN296KnH9a3sjk=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=OG0GJXIOYlX6UkZlVOcalToGf2gKe3Div9CDIs1Zg5vWI5g3q12dnKjDAiIDRSupj
 a+/Px1EF2vxo0omG/kvuFVTxUuMDEfnMVm8AXnM9NukOXPg3rkvXbck7nULRtrW/Uq
 GFigf1cT1XNKXvOGyv4q8/yufjMPr20aNcwoWReA=
Authentication-Results: mail-nwsmtp-smtp-production-main-70;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Tue, 03 Nov 2026 12:53:02 +0300
Subject: [PATCH v3 3/6] spl: fit: Use map_sysmem() with buffers for fdt address
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-riscv-full-fit-support-v3-3-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
In-Reply-To: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699606; l=917;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=kxKXw6OTDDbx+E3kua2PPXwGjNfUwO4Fg/clI/EDc1s=;
 b=ONQ1EfaPxCidcieNH/kk+PrVaqzT2LKiMCdCYcSya1Qf/8o9CA4cnAEO8Nc331gcXgXihzPfy
 HshvFHt8cZGCrPfyhQXjLcD7wnhw41qL+hreh9AInHWX1LOfP8tHrsz
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current implementation casts an address to a pointer. Make it more
sandbox-friendly by using map_sysmem().

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 common/spl/spl_fit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 64e5f95546f..26c6cfad116 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -1090,9 +1090,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 			debug("Relocating FDT to %p\n", (void *)fdt_hack);
 			memcpy(map_sysmem(fdt_hack, dt_len),
 			       map_sysmem(dt_data, 0), dt_len);
-			spl_image->fdt_addr = (void *)fdt_hack;
+			spl_image->fdt_addr = map_sysmem(fdt_hack, 0);
 		} else {
-			spl_image->fdt_addr = (void *)dt_data;
+			spl_image->fdt_addr = map_sysmem(dt_data, 0);
 		}
 	}
 

-- 
2.55.0

