Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD44CA5FD9
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 08:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C27E80D66;
	Fri,  2 Oct 2026 08:38:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mn2h6QokubOC; Fri,  2 Oct 2026 08:38:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EA9F680AED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790930288;
	b=cJ3n6jZGqdJ/NxkUXhKbcMtpckSfvlarwuy7YbwyYW77poHaWpimsGUQk4095etwVRN5
	 5Y8wcwIVPlxr4HuofC9Bdq4tMiBgyrLs1ry6FW8vofCpxyZEjqOYDwwsEb+N5NnFhXZ90
	 k9JcDe3S7DRmuUS+KEFxUpePa3vndSsr2Z9peXT2/WaeeLDlDSzrxmHMrGWX1vCYIqy+a
	 yois3Wv4Auz0c6aUZ0TP5NKDfRGs3wwj3SnY4cSeB3D1njqXPmH/5fINt0izFr2QDFRdg
	 R5uieiGmJpHRZIUwQwIP4ocu7OOFBmYzX6qj0vRsDuRPjRc57D1KSGK9GBgVO8tLntA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790930288;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x2M8Bh6vIE2NNhZTsg5nbhzXMnh841nSjxhCzVYpvOE=;
	b=QQIG0zKkQrkAaz1R5woD6IClAM9SfeQDJi1iOLlEgm+rtWydCp3Sduq3FHm/9zsfCwEU
	 /JAgvnjrboB3Ai44A8MtkF8GeHFXotlHUj7gZNC5pkDOH4D1cKY81ayTiz1+CrAj29X7p
	 9D0YsS/VSukAZYa864s9VkqqcccXo1Vs533hd6VjTbQj2C6Z00fJbspLbNzPjbhoxDBc+
	 k8wdT6DkdQ55N/E44QKqwkG1T2lKX+iBpORLwXb4etwvaveoIPpZIF/v+t1xE7rVusGa7
	 fldBhmFjiVCzUxhNMxAdIN2lQuwyZWH9MkWuBE8WHb7iuCtmstmb6P9xpqr5lidTcsQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790930288;
	bh=x2M8Bh6vIE2NNhZTsg5nbhzXMnh841nSjxhCzVYpvOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ezd229Gdx8Rn0XpaqFIGgR71FuBqgYkZqB3LMp1ohfQIC9gUiuDOazk9DlaGotCAJ
	 jsgimq5lu6aDsfVsXzaeK2w03NYraAvx/zFXyZVqq74STLE+k6Ys0H/RLqGTkzXTbm
	 qA6H1YkGb6icAOMoACg9hRNqZnA34ASgvzTftCF7O5dkPg0V9QmGWjMvjTDmclkWrJ
	 fiKm+AC9BJQdw1axKFbw6Md5Is57zH8GrDco+YLz0roOhciaRnMT0aiwHIstq3Hg+R
	 gJnQ2w/tWQf4HjnEhL0m499I6DSOH6V7XvUTzMDviSmgFbpgxcMPhRyrJGqV9/QrOD
	 PAnQIWrT3sJ3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA9F680AED;
	Fri,  2 Oct 2026 08:38:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B8CC73AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ED3040382
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xJ28AULmLABk for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 08:38:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 023A4400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790930284;
 b=oJzf35hKUZLJNY7gWtxlG2SZ2hqdQfGfq4Ro4dZ4V25w64nr4PCm2FV998pIXS0m+438
 INKLP7ktth6mszv67Cs5IuZw0uDwANEHd8cnCXBxjhvJncl4OSnw5D0oR13wVC4Cwv3qj
 USZl2kmGOMbvKSDQfcaYWrI1wMjS69DRFmZCP64n/nPqQQ0VV5TSWZTkIjBQIZ1SMPEsx
 vdyzyf0+Y0YWiPI/6RGTWk20fYgYO0kNwx+Nb1TM1ZHj5zb6wiNO9IkGDXRjOYkKKYVJE
 PEFsYNVkLgriMlWicMSX1ujcNZCrPVuC777pqtiOKc+jgBRDqFCu0mn9FRfLYAdmpRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790930284;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=x2M8Bh6vIE2NNhZTsg5nbhzXMnh841nSjxhCzVYpvOE=;
 b=DWO5BpC/zUzKbKn1bFvZiivYpJrxOR5L/ZtiIlHI+mY2njlty8t/OE41MYW9Iy6gDPcA
 04C+0lMKEsdWuLbbQonLa+tW5tjY38bP2X/5aUUmp2Sp9a2ZiHMGxaaZbdUOBm9VzAtvt
 hj2VZ6wnLa4klYQtWNG9q0UUwZDzEBKl5W1vYu9qCje9qAuOGn+KL0/OKqybUPsbNdhLN
 73xIhp2NKe1gI2OIt5xbXuQEuA1//uyQ6wJN+YDM544hj9yUc2NAhxOWQIvuVMpfYmtdi
 k8oo3WZ5h51AN3VpqPTQz469cTi9XUHkqU77l5utLvQADVRYa0si94JkjXPvpr5K2dw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=rGar3LHu; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=rGar3LHu
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 023A4400B3
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:38:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C60B1476;
 Fri,  2 Oct 2026 01:37:59 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.11.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD9C13F85F;
 Fri,  2 Oct 2026 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790930283; bh=GSZnFjIv/vcZz1XyfXVJpbrgi5izeUSqIeRUMVXyOJ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=rGar3LHunlZfnttQlNg0cigZBIwHl38XK7CrmSzKZqDc27nNhYMdiiv8NTrawqoYo
 BUoz84fuiUknCe3bxQrkWOUYFnHvQgr21JVL2csWopQDWsSFLfYxc1bmpkrGktYRCT
 6PmCsNbh5BodGcNtXGyIARRwjflHOYFpdEcXKqEQ=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 02 Oct 2026 10:37:47 +0200
Subject: [PATCH v2 1/2] efi_loader: fix image info authentication attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-authi-v2-1-900f6f9141d5@arm.com>
References: <20261002-authi-v2-0-900f6f9141d5@arm.com>
In-Reply-To: <20261002-authi-v2-0-900f6f9141d5@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=GSZnFjIv/vcZz1XyfXVJpbrgi5izeUSqIeRUMVXyOJ4=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqv21lw8VWfrPGFemXEcinG/vkUkKX2gp1O3uk9
 rhwmtbg9zaJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCar9tZQAKCRDLSfhWdqMG
 lK+DCACe2oJT/qOlRZu4vnqA8HunpnBUaxkimh7t4bbwDSjdSVw0uL5+5xwllRITpubyIodOeP0
 TYKr1H1ybnmSQ2f/KxyfrXlyYI1bP8vUwm5n0XWCPHqpnsxKCinF5wHF9ugINPkAsmiCbzl31SN
 rsvESoWzBssszSGP9acPssqHBissK7GDETNobugg2pdM1D7azwFlP2xWAK9oSJ0sTYlG00QOD4s
 lUjr0W1DBRO7Rtg6GSt3uKp/3i9SNTyu36lmzM/fAK9vsJFNRFZP2qM9TfAAtUOKGTpGdrA63gq
 HhcQubEAiphJE1o53rb1XbiHDw2KJurnNkJcr8HADXguB1Bw
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

The GetImageInfo() function of the UEFI Firmware Management Protocol
returns the authentication required attribute correctly in
AttributesSetting only for the first image; fix this.

Fixes: 88a2ef2720f5 ("efi_loader: Enable uefi capsule authentication")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
---
 lib/efi_loader/efi_firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index b41969c70fd..84de95f5c23 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -364,7 +364,7 @@ static efi_status_t efi_fill_image_desc_array(
 
 		/* Check if the capsule authentication is enabled */
 		if (IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE))
-			image_info[0].attributes_setting |=
+			image_info[i].attributes_setting |=
 				IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED;
 
 		image_info[i].hardware_instance = 1;

-- 
2.53.0

