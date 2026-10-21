Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C8606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PhTJNaWA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1983F811A9;
	Wed, 21 Oct 2026 14:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VlmJ6iddWrjf; Wed, 21 Oct 2026 14:09:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55FDA811A6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591764;
	b=cAX7TE9yVtf7OkgU7aqqbxdshg9stIomCW8r5oUx7VNDL1+SjQpI26YCziC7+gsZfmbE
	 +t6XQPBWqfTcrPzjMKaANC8iO51Lw7HowmsyIABLrlHE/+ko2WDU2osCJ4MzWH4+lc6UK
	 +6D2dw8M1sYw2C9V/trYpAS98lAASabuKine6Ik0BFy6TUuc3YbRcs1yQYXE7m2oP8KI4
	 jaO8f7DJzIFJWO0gvXnyDCzwa+fwxrwbn8MWQtGDNwZMVrAKY7K64VEmuAHNu2FEoVblw
	 SvnxPyexSxZprJVeNQWEoUiPFIulL84rtbDJhnIvvoPP8C7TjoxgdBnbfN3DTHmN2RQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JnV6/EqLeshGngWUQG4Cu2FwYfr0VPTC3Xn63GUNPpo=;
	b=ipiQta58sUU42ayx7OoHQYS3CQWGWBLqPovAuUqaUuSImcLTzKGTnUWFbqbPpiKnTpzy
	 F4r2IFa7x/zeA2ZDC5WNYV6rUzx98dceZ0KCSGLiuFZPJr6s3deF4fTDblC/RaxEYlRYc
	 pb+8o1qUKnP3v7ulTm8SzdsG1Kx+CH7NH/khz/4Cji1sFvHCOXZ53RTQKrYkJlHLOT6ui
	 uzZzZdSIYJEy+z8/6qbpwQ0FrIOBNnhCy1FdgVxGa/HMPZ/8AQkpfyZv5HMdC/TWFU0pZ
	 A6DQc9TstHSCgisW9/AiKFoPmtDM4TXmYY2pjzYjkZPWiKOz4/mAaBM/8oXeA+JOCig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591764;
	bh=JnV6/EqLeshGngWUQG4Cu2FwYfr0VPTC3Xn63GUNPpo=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PhTJNaWABE3w8fAe5NETmBSMlqvoE1CbhveAb0iowca9kwJHsBt6ZUHii5zKXMgbg
	 i2zz6nyliBeYwHi4WQAqhMZc0juaBLFhixa68aNmMXdvZ8MnID7KfFMCAbqu49cdlg
	 jN2Z2rR3E+SnurptQOEoMK0M3/jKdUEh65gfyYO4SCZ0NOP6DqtPUbkA4GnJNPtF4c
	 HMAbtgAUWEBF3p0mc8LoUQ7W5Yz8GMaOoUqpYybpT85NJcj+44tayi8EltFfMLyeVk
	 gYpCGuWgInzRHvJs63FHkGgaVY3WC/K/Gmc+z1qH93nhSnOjvs0MTK9Ao7e20dRAZL
	 XOLu3UlzcUqPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55FDA811A6;
	Wed, 21 Oct 2026 14:09:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC8DB3AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0C9C408E8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fkLqIvXQnN5 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:09:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8385D408CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591761;
 b=h0gkvF3St298+xCqqdBLFH+u7euDnpDTcjF7XEschjbLSrxXVy04frruh/RSzKJEthlC
 3mwCbuUFhdw01gzeqw6J9BBZesvWSBYgbdC/c4yjuChydSFIbi8MUor2GUOOJf+XxgRHq
 tt0v3sJDFvE9Gs5QuQPF/nlz0T2Y4ZTssT6P3RWUJfmMdTT3T3ldUuld9RbBC46GrOV66
 C3oAwPTjV3C7CI6G7imaRuA3Isem16crSs6zKgCwZTdcVSE12RXE+sUQSM6zMI6Hy0pvO
 xETB5dYQ76XxxF98ZteXDqPS9F4RhNNu6sNIU6GlMl7Piv8lJ1Wn15ecFrQlCdcDpTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591761;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=JnV6/EqLeshGngWUQG4Cu2FwYfr0VPTC3Xn63GUNPpo=;
 b=OMBJ5sNjgHqW1RmXqH/nZXeIdD5Q7LGVrZ9FD2b8vldAvv8tAUrlzWNY4vgLaAwyXIy9
 3X2qBlgyBMGZbEpYykls7Ap9+gd2XzOM7fsfxuvtYtbpmF0GqqYLKiLGAo7c4lUIG9snA
 F4ng4V/Lg4GFEUW6xlgluikvMBqaK4AxjAgppd2CqAvrHEwtNXu5gqU6V8PbRckHrS/sK
 o2JdeQmpxaBUSi7F4DGz5IBKXKj0BRu9A9RDYt2RLOUeRdd449pO/Nz7mawchce3KojqL
 EwPkgaurP/p9prTBORinmdq9hLu4uPvfuvyVLWdWFjkqf6PsivM+C+KZJsVEB+kxGxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8385D408CC
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:20 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWx9-00000000233-30IS;
 Wed, 21 Oct 2026 14:09:17 +0000
Date: Wed, 21 Oct 2026 15:09:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 02/11] boot: bootm: derive the header probe size
Message-ID: <c3859c682695b1c8c55bf471131ecbef3aa0d113.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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
