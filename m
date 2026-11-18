Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26813606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=emLJKH+U;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TwZXa3Gq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBA0640844;
	Wed, 18 Nov 2026 00:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AuYTvQyVnOa2; Wed, 18 Nov 2026 00:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F4AF4082F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794960499;
	b=fcdAuEMELvegZJCF29GtOqKIjhege9FMXamXCR8MbYeVudYCudOHkNCQUnR68OPr2DDa
	 vfxGHRy/o6VGgS94x4ZWoh8WyljMW9818p9xY5NER/LrwkBl+r8jBLGGIQBFVUsV/V3EJ
	 z9MbCewbegpVxbWiskBzPmOuSlxO4Uql84RBZGhbDO7gUBO+kkOxkeFk2jbvV1zC/noJ1
	 ittT3fOoOLe503ov7rS78mItYl+ljf5FAfxGonofQlqGdyQVagTRU/vAZ51wWxzUE/L4J
	 /hL1VLbVYQlD4GDV6nXq+2K+R7qNaf2aKBNIvtlYAX0oqROKeFH9ZD6fBbnMfr6g4Nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794960499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3nj2oDebac4orm+63oUu525plADQQyFrMEBBAF24UXk=;
	b=XEqTZfXTVHwMxCKUZcSUn7UtkDnVLBDQaJ9Jh3Fcyle11T9byB9Qxpdckjd0ftUw5dw0
	 1dPKauADV4Z9ogkE15r5rLOlBg9hRVX3gcCqAzjP2OBn6rgKKhnpu7A2CEek07tljMsOr
	 Jr25qV9808W+Ixq8Vsw+iKfXNS4Gt+Ta6AgxVxLlo3J3x9pcdXNu3TlxbOm27CJoZ66LC
	 pKiPrYV0OdHOBOrl1f8tkYHIqO6TVefu0bD3hDCY2hhdKMbrBc33vh0gQQSeEOCU/MPb8
	 bcedPS+0I0fPOLMUad2GrUw9oNhRTTIbBuqCZ5kEa/hbiIVxSRCv6xIDmRrdoDRrizw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TwZXa3Gq;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794960499;
	bh=3nj2oDebac4orm+63oUu525plADQQyFrMEBBAF24UXk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=emLJKH+Ujp/t21GnERMwC5BFAEHzjTPmC5ypua3hmJQ3m/D4GtHa3WRPxs/QTvpaj
	 4b3Go/Zwed80UfO32PdsK8NaAf6GVhvKnsT9PVVlJ2zyeTglkbd//9gANftpSoUckR
	 nyfr13wIsuU+PeI4AzAH80I/aoq80E78klb1/WUlQzJXVJzshcEIUsMLPxPoWBWsgJ
	 Q6JWU/5VAPeB5O5Iaij+vNyoz4XMdBmGbfZ1xQ8vmJkQyV1c59SodZtM1NAg9wBpmi
	 jhNTnukxuD/3xrgN9tvloMOpd44vg6cQWba1IPZrGpfpgQKAC3zO52mijAcC6mWVX8
	 aFQskDyjivDHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F4AF4082F;
	Wed, 18 Nov 2026 00:08:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 16356105
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06D314082F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:08:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzUKRG6gmbVZ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 00:08:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C7F6D40822
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TwZXa3Gq
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7F6D40822
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:08:14 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-716d052dc23so224185eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794960494; x=1795565294;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3nj2oDebac4orm+63oUu525plADQQyFrMEBBAF24UXk=;
 b=TwZXa3Gq1ADmT4gtcLwDBH+im6qDxpPKKcmvbRg4pL6M+oa0dOOBrLV6ilCwXkiAm8
 Wka4xEuPdHPMnVdrEtXZ3uTHGvapX0B///z26wR0CxSGuMP+7eUYQlrvXcYfIFHUIXxG
 nACyhdCJmN3r0S86f89ej4EALQWYFt9KqP5yXafU93Y4SHUz6I3xxSl19Vc2lHUwaopS
 BVRBJkPACMQIuAcGZAyrCz+kEGb4gL5GCP8HMWWgaVrPcuOHRRXoLPbsHJR/Nqi1/G0p
 Sv5T0Dfxe8aRTNmGbhxISdV9lhs/iUshHSBNl234AO+rO4T9H3qqStG1mbkp89AOdqOo
 qo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794960494; x=1795565294;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3nj2oDebac4orm+63oUu525plADQQyFrMEBBAF24UXk=;
 b=CdvxYB4cn4SGJ1DdBOVAYu6Ki3VFqmAtpXcmSW7X4r9W3YeG7exAT3trwK/VbV0lUG
 O/2Nbgzw53Yp46B5k66As7dYnVqq0VtDpWrKwQpt7HkVOw2socicURdyulJn2e2EfMQ/
 s+4odo/qnjRYZd4gUtlo4Jw0H6A2zAZLBwWPRMA/iBBI4n1RZRwsHi1KvscZh4BqF/5A
 SRXnjmsJleDYYQkZ1TlhZU2SEMjnnuTmPDrfSurG9qDNXmW2X2a6QFqjo+ZsTvMW66Rz
 LkuRwEbYg8gEI0MrvGQom7jQKesfmy4RjhndhIcBIn/lBkq8axtMBpTb6ODvwLMpxxPO
 pa+g==
X-Gm-Message-State: APuU4Z8D0VnWkHR7aBVY93QbCDWjrjJPtwTdpwi9NUjZPIM0B2doLoge
 5FZrzyjaVKG3w+K608hDa4VYW3q1XXPcbc1bMAj+VOShAwQTUMc+P5XHjQOt3p1zI2M=
X-Gm-Gg: AYBFou2luGSOnDQicDq0aFnZatrkgvPz1Tcsw9IQKaICrRm8AG54VcDBDO1qS/xBzwW
 BSzw7jlLA9YvZEMXEO9gykkHk2uR3ZIC0WX9UrgqX9TdRKQYfFxQg7eRzkIJy7iOY7Tz9TWq4R3
 t1kBvGnYZTKu8fxg+EyAjNuJhSqDq4u2KKnqPkKOlqSBMhVvi/SnhOYjTdiWiHX9q8FGdR9xCcG
 Sl6NwgUGoQTPG1JcPzjkswJNNC5VlAf4SMc3BRdjSSV+qNPyQ2eCeA50r2+odshe38hL3kJzcof
 3i/5DKEH3jUGHOTyFOu1t0x2uO2BW7O59DnTT65bC3eH2cgGwekjQ4HtZ7Tah666HHbfnxColp8
 dD9rZ/5Jlev1FqaGQFbdcx8K4u0PsmA9E4LK/iMcmDBcVzIbOiNCo0PXGWWv+JhOPcj+h5tMvMC
 tw1EE9io+MeQD8uf9wjf1EpwPZj3AjxAycKr8jYBOqb0V6qlIh/T8GJQMPZJR+23iturTKmtwfg
 q6LTO5/Z300R86EEtUQxKN1Fn43kfhbRM4jcdtw2DHZtqZTW4Y8i6UaWayyjgtDwYiVIKTiXHSG
 wIl2o4VY9q8mIz19KHV72opyzMC62pu11g==
X-Received: by 2002:a05:6820:83cb:20b0:71a:f253:8ac9 with SMTP id
 006d021491bc7-71b1864d6e6mr574309eaf.78.1794960493997; 
 Tue, 17 Nov 2026 16:08:13 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c3c:99a4:6f4a:ad27])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b73f876f2bsm766922fac.2.2026.11.17.16.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:08:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Nov 2026 18:08:01 -0600
Subject: [PATCH] fastboot: block: fix wrong device pointer check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-fastboot-block-check-dev-v1-1-31f05c746bfc@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAyF4atI1g0Y7Sj0KqULJ0ZNW5wyGUUQ7
 95p3Tz4Fu/fwSSqGNyKHaKsahrmDLoUwFM3j4LaZ0NVVg0RtTh0lnwICf078At5kry9rMjOUd2
 KuzZcQr5/ogy6/dP3x2lb/FM4/XpwHF977xCefAAAAA==
X-Change-ID: 20261117-fastboot-block-check-dev-c55137e546c0
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=AJVNOFznryjupSE7AZ4scU3MB7m0UGQAMxEGPzFadn0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/OxkW0f3t3zGSNYZfcc9NrpfDAWVU8BOG6coi
 sBOpbWJ0oGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavzsZBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A03wIAJm+ueP0duWD5r5BU9qMN1OLAHMQLv7B3dUXHbF
 uQU79MS0YODCF2Nf3vPPfbBgpHBijsORi8BVUgt/Ia3j2sjRLIbasKM7HW6/EPqdCK4rctB9yd2
 N+7bN9agDuBIHLAnfQryTgMrJUSSz7BC4MWHog+wlImgXNGJ0KTHF6MnekSHXCAaHLBU3bZxez6
 dvAx7aefDkvnqOMKzbPJybAPMuX80NuGDjK71bIHIojXfqHCbLupOoeywhjkgFCFO0q+mZR8Nit
 ZSMQSpowndBuutAZiBiuWgjKTGyATc8qNfk4eNtJUFA4K3eoXrbHgrQI6Kq86wU51MuLMnDx0W5
 VHkk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check the block device returned by blk_get_dev() instead of the pointer
to where it is stored, which is never NULL, so that a missing device is
reported to the host instead of being dereferenced later.

Fixes: 4bf92b541af6 ("fastboot: blk: introduce fastboot block flashing support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/fastboot/fb_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 68593244ab9..16b94b8a0b2 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -147,7 +147,7 @@ int fastboot_block_get_part_info(const char *part_name,
 	}
 
 	*dev_desc = blk_get_dev(interface, device);
-	if (!dev_desc) {
+	if (!*dev_desc) {
 		fastboot_fail("no such device", response);
 		return -ENODEV;
 	}

---
base-commit: 6201222134cd704b5717211fc917e2ca6263577a
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261117-fastboot-block-check-dev-c55137e546c0

Best regards,
--  
David Lechner <dlechner@baylibre.com>

