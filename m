Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8BDCC6B27
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80914406DA;
	Wed, 14 Oct 2026 08:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xTc2PECswgG4; Wed, 14 Oct 2026 08:39:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4B3D406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967145;
	b=eP2pCOmX4BUbRVlZ8ZB1i4jQXDYiLNL82b3+lf+HFUW7fqKnN+e0+Q0ZRwQ3/UeQrN/Z
	 OcEP84lgioBFYjXojEg8OYWw26Qg4w9dG+nj+czX/m3lbcTuPwK6QusKWmUowR9WKdRJh
	 bkv5eQEK5EJ8xwI5edBMpI2Wmkaqlf00L+B5S0zwFrApK7PpAtRBdc83EWE64FrYhVJGA
	 h/rhbulAWjYW7UFBxWnGMCHtKnNgwlDsut/njENASbIDFyyFYwVT8a2Yas37uxHsCc4NH
	 +r2qpW/2O4cZTGVv5aAZauAOXNtoFQ9iaQEKRAS4pKUkMU986P+eujydhWeg+zALxwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y2wtCFL59/ULyVd4fqUJ+kl9xghKTO4+9aBUlgonTCE=;
	b=e2AlEEel+7e9TuATqA9S+Sx5Y/VYEdMMT8+C6aLa8+33dWuZvTY6/6xFHSbx9ekcqH7W
	 PkWrVQqywWzxk2o56zW/oJLyVu8ScOwoPFvotHUo+Z1kOsGQ3BuWpAg3o/HQuym6L6UNv
	 V0WSKathk23dpwcqpMR9NSX2jIFITHP73WzvzJPFUERNmr8ztYj5XBm73n/yvXU33ti/n
	 cfHaYwF7zhSODYbBklh4xQe6Zf74ZIF/DGqBXWQPbkGU1qRxPI86VKYuHD48fhL11VmMy
	 cdWZetseOMlMq0+pb/IPSQ6ILEVf2ez3AxAZQD0+h32J6RdS/dENuae7JT5xDIqdONg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967145;
	bh=Y2wtCFL59/ULyVd4fqUJ+kl9xghKTO4+9aBUlgonTCE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OCJk8kkNTmkYxhugmU/q9o0cwob5ztRiLm1klY2mVMHbWcJIydO/oOGXwY8s4IioR
	 oKqHxPzPCsn5svmFwJewdFb85LBd4KIVNvzcWYvLF60daGAikDUg8hmWWjZKV3vZyW
	 fV0N6qeROzgzL8K16GZZKoDzZupN6oOq23LDC4zrOiltRGpxuI0JQ72eD7ikiiBumM
	 MieA5oUv0hCQaUPWy0a7u0T7VXT2Jl33HvpwScip3zqP7Z+yUCSsN/pZbNS/+sSR8B
	 oBYUqS6zJ+iqVqIC1A9HZ88WWwNHWJD0T2CEjRbNYWbMwemhRXOVqxU+c9Z72be7fY
	 30U+DDjsViCSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4B3D406AE;
	Wed, 14 Oct 2026 08:39:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31338255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EC1580DA5
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KuTI7FK8Uicb for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:39:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5EFBC80A95
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967142;
 b=EvlOZTScC22i3JhNcJowqTe2xPz+0czERtsrpIF866GaS3Za0PoWR9NibNIfw7IEdgJl
 o99ulfUX4U2MYwVtvkgLioO04IjFTNKfy6bzL6ozogT3W9UBoNmV2uOSm22yigqE45qaG
 Gf9T5jnvuq1UdG6osLPHhccv5OvWZOdq3qP5J5S5AjdWg7YoIrHz08R9X41iuC+knJ2mO
 uz492AFZwxZOBa2z2/TOw8fYeBuEOHyTaHZ4X5d6Zq+hHLE+pVyRsBmUucY1eEFFcLc3H
 VsvYnN2ZrJK0k1ZrV3wPAh7var0uENBZlbahGLa8nOHlXmCV80aIUZI1sz/6u0FitVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967142;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=Y2wtCFL59/ULyVd4fqUJ+kl9xghKTO4+9aBUlgonTCE=;
 b=A24BRxdOrMC31oJV4cH78c7TZE/B0XMyY9iDReSDsPpBYK7MxRp6CzpOmHtkMx8/LQSt
 9h9Gjj+HOYTXTAYz04tZmnwkU3mZfGxcYMxpuWCsYSt5p+RZREh7JG6NwyJ1CSc13dAF/
 P/ntyK39ZDzjXOdRNlF/sG/KXdh69wBaBu7v/i+6U6ZfPeURNHqTlglw5EzzrUF4858a4
 FOSMfjjmAM76PlnmPL8aM6Te57fwPFCVh9Ab5/CibzE9sjk9jd2ge9lfqcaslLo/rLm5I
 WWl8dr56eXLDXLBJm7qmBRbdA1hrujW3dBZv4OqwivHcb0yTutVeTM+JoDN+ZPCGRvg==
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
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EFBC80A95
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:01 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuVm-000000005a1-3HYS;
 Wed, 14 Oct 2026 08:38:58 +0000
Date: Wed, 14 Oct 2026 09:38:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 02/11] boot: bootm: derive the header probe size
Message-ID: <8fa208dda8b261c8683d8144086cfe6417658a32.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
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

boot_get_kernel() maps a bare 64 bytes to identify the image format.
genimg_get_format() reads at most a 40-byte FDT header or an 8-byte
Android magic, but the legacy branch that follows verifies the whole
64-byte legacy header, so that is the size the mapping has to cover.

Say so with sizeof(struct legacy_img_hdr).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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
