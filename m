Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED0606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f3b4ztey
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6733A40A95;
	Sat, 31 Oct 2026 11:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q4qC5Wl58tfe; Sat, 31 Oct 2026 11:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B297840AAD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445026;
	b=s4xOYlBVuQmsjaElZfKoDAToIgVkxbJkBHIm6ccsrIib8sfrdaG/aejdsw7RIUeCN+yJ
	 XJdk/W7yNjx5GDjgzL30KPBGg2iUuXe5PKo/kz2nyje8pfasa37I8V73637dtxM7CGhUD
	 PLciImYAbgUgbmk7SSwz4KXThSK7J8MXvtFKtq9S5rUh/JkoDOKpo2PvW62aFey0ZB2Gw
	 MpNUcVI5WNywxxNgQ/qAQvshXTPGHUth+cN7H/oAcPXm5hRKta1gO32N/G2owdfSCF2qK
	 0GVF0aSxFbau0K4WPGqVOc3GGa6131DNGBIEqf2zNzQ5H0AVTvfDdBSAZz5gHeCFroA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IMqwDIb71qTjnY52/6qIAijlNQyQ79H9Z82uB2+UZbQ=;
	b=IXxxZGsTaDhjPNnNF63079XxHEvtk1Dyd2RIWVFYrqZwFCW8D5mavY5e87MluF7b6q7G
	 I74BFmdF78QZ1OwSxlQB2eZscqxHbWO0mjaYGE5karLwd68UghB4SDcyRkyX7u1zJJS6U
	 +y3XLo78IjDBzr/TXCq31UdeOS432WwrR4pd8Q2+xImNJ2ylQGFdf2Y9QC9pLZ8cXCwEQ
	 vfoOgh1w9aTwqVOQcrvTqAF9m9uZiruBG9FFH5F1XS0ouQJzPrdNJEW9IQLergxtiZU3T
	 3nuX/YliVbe9sBSbetSYOciT6hD7gJqTMW1nX5mUCX4PzhdNGkCk1g3A1k/6RnIf0eg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445026;
	bh=IMqwDIb71qTjnY52/6qIAijlNQyQ79H9Z82uB2+UZbQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f3b4zteyxbhyFkGNDH0RRvh/230gM0/0C8g3DO6UNkf5uNiz80f7LgTh9eP0mszWp
	 KpOQ0R90is2UMSV6ZOIAMoMpPKudEZl0o9HCIRNW74XmSdGn8KMbdJp/UXls8/2Vbj
	 jVOz7VmKX6Sf9Z3OqsfxWlT6tU6OT3pvHunWlsKPiVtyjmhV7es5wOrDDW/7Sm5OK4
	 cxrvNOzbAAKSCe01pLzvOB90dqxdvlkAjEUYXHBdEKVXt78X+oEJ0GrxX54ZUz6f19
	 FZUvw6/CLvQWb7WgS5oKizH3BDFOabkC9x/0h6cJJCx8Uh6pUBPye9mMhbRjc0JKCR
	 Qbet0fAVFszrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B297840AAD;
	Sat, 31 Oct 2026 11:10:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D1D1473
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F303C81119
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4FsLZX7nugTs for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:10:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57FFA810E0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445024;
 b=GN+fcAJaw/yJX17nwkqv1SpcoAgsY/zQSu/srLEyTrWlaiSJo2NzqSn/72VGIOY8TWNS
 U6psRGMQKAq41qW6E/Hr3Si1+cuVsexKpAPJ9iMkB+YScbnpHqEV7nSz35sEE2GxBVYYO
 VuT7wLSmaNpiQLm682gbblN3YEPN4p7wMvlgzqu5Aig2n45oD7LIlA0GoO3XSNcC1ymbW
 si1F+X+o6Rj7NmVHKDRhsFEMaeNDJ0tmT/YA00mLeXIxufX26m5fLQoaVlvd+sP3she2d
 balB4cpY/GsM+tR9bhorgbL75hDlelqTsZy3LF3y2ArMme/YOYCzB5rGgiuY/CZ+IiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445024;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=IMqwDIb71qTjnY52/6qIAijlNQyQ79H9Z82uB2+UZbQ=;
 b=NmytJP+ZVgdSjkxrfD4C+ZrgO8cs0Hhye552gxT/4jif0cXhYQ3KBv6YKHledow9d1M3
 AwPxp/w4oijKNDFA7nEStvIQsdKuDb8b0g+bm4sibCLXemIKVd2JP3xg3YmuLW9xzC7Wb
 WiqIp28cUG8IGvtJC7c7z2JWyl9qvGLuVYeZBx3JfqoB/yXQttlvePlf4xiy600mDfDPg
 Nu5Feo2NaNXd/6Ce1fklmhcSb41Xt+we/Iix9Y5UerdK+tn5N8wmHdMYnKp601MevVt+M
 0Up8GCXElwMGqnFjkQMhwchw1erAl/OGDPASt6W8i3rSF+P78hEdKt5EjnMleuZVQ5Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57FFA810E0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:23 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6vS-000000003MQ-2MMs;
 Sat, 31 Oct 2026 11:10:20 +0000
Date: Sat, 31 Oct 2026 11:10:17 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 02/11] boot: bootm: derive the header probe size
Message-ID: <f00b70b3f0640c6dd6e421ee871417d04407c3cb.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

boot_get_kernel() maps a bare 64 bytes to identify the image format.
genimg_get_format() reads at most a 40-byte FDT header or an 8-byte
Android magic, but the legacy branch that follows verifies the whole
64-byte legacy header, so that is the size the mapping has to cover.

Say so with sizeof(struct legacy_img_hdr).

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: No changes since v1.
v2: No changes since v1.

 boot/bootm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 92c8452a5d3..b9aa83c3328 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -158,7 +158,8 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 		 * parsed any #config / :subimage suffix so the FIT
 		 * selection variables are populated.
 		 */
-		buf = imagemap_map(images->imagemap, 0, 64);
+		buf = imagemap_map(images->imagemap, 0,
+				   sizeof(struct legacy_img_hdr));
 		if (IS_ERR(buf)) {
 			puts("Cannot read image header from storage\n");
 			return PTR_ERR(buf);
-- 
2.56.0
