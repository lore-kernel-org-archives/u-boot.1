Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391E5C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 13:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6E58815D;
	Tue,  9 Apr 2024 15:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zMlEtfW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 744E387E86; Tue,  9 Apr 2024 15:56:05 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2C388116
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 15:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a51e452a1ceso172888066b.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712670958; x=1713275758; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4sVEXEcLhiur/9gfwDQ3BmR3V9AVLhd2cig0WrJoydk=;
 b=zMlEtfW2lyah8qlssjWfSFPB/AaX8YYBmR497K6RVEOzC5JT79XDZpd5hG4JHMmPB6
 Ua0gqKBfXyBoz1x6aI1P9gj/25ss8t+UTd6wG4DFIVUk3Rvzyu54yF/bbpWKc7QlpmXu
 6hNT8tq64vcFIV13Dh7DM9FfBV9+4AjGQPzqB/OWiX/gzZVZIb8jhhR3yKOFadD0nV+f
 XFGrwbIpCaqFVqxGFqhZVU4zbIuuxEFMEenkSwRdH1m9Z/IPrTMMh1zIUls2pHaAlNXE
 lNKVmI963I+VYutHO9usjfn7lLSmvQ3DNY6Rrn098L6+t7EVnGTmDcLEYNg0XT7mVB09
 8CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712670958; x=1713275758;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4sVEXEcLhiur/9gfwDQ3BmR3V9AVLhd2cig0WrJoydk=;
 b=gGRI+freY1N4T9pJ77pThHjqsfaHrBYDVKlHi49b/8Jf7Ijel4XqiFziuoYiuvaMsL
 N9xWyQXQvPEH726HLsmh0MYzUQsOtJhutccw83ndHjGzG6l5aHQXm13YtZSIdalilOje
 nZqlgR723fMxlJLp8UTMeKN3UuJ+N49tWniffEb8yKYQRVE9rw+hRPwY/9eG9Eifba8p
 1iu1ENpm7RmgoMx9UiliUN5XIlxBgQeyB7B2679uvCj+g0qwvKj3qvvWBy6cqMqdDBon
 WCyQuNUmPI7V1PwuwxLL91ubHOFLL1rVfqCPUdkiraCyoqZz9o8eBKMimMRW2tHjUwNJ
 I2HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnXbmw2q0TaAKTOX/5j24G7cWgNgWsc1TvJqJ7Np2Kf+C9AELErB7jrcDbHpcB+TJhnP0dIizCdvRmnOppufCbPpykBA==
X-Gm-Message-State: AOJu0Yw7EvStFT+TWSnM5thakSj9CTV2kvf8sgTY1ZBvkegKW6QCLoi7
 i2/Q0Lnvc9n+FDMCGAZipiS8DF9sGoj5wi325AbKWicDm//eT58uily9OXA73g0=
X-Google-Smtp-Source: AGHT+IEJsuFUfe0Gq83Q6zecMJuE40i5GLroongKTLZ4UNBZZrUwqj0nZ+on4a2RST143b9en5dfXw==
X-Received: by 2002:a17:907:1b29:b0:a51:da1d:c0e1 with SMTP id
 mp41-20020a1709071b2900b00a51da1dc0e1mr4230223ejc.50.1712670958047; 
 Tue, 09 Apr 2024 06:55:58 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a1709067c0100b00a46aac377e8sm5720612ejo.54.2024.04.09.06.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 06:55:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 15:55:53 +0200
Subject: [PATCH 2/2] disk: expose partition type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-dfu-scsi-v1-2-3e1441a60376@linaro.org>
References: <20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org>
In-Reply-To: <20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=DEXhszI+R2DsevUMsbpCot+O+CpOwnI7AYx/ubweVA8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFUjqlmm2pddKUXq3uj7SfB5jc5wrBeNgUWOEy
 z7stAQPgnWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhVI6gAKCRAFgzErGV9k
 tggaEACVELl0qrOLNwhk6KE2VtT3cAOsCRbqTFNPGlN2YiJ5qj87+PqVITHRKrUrgSTNXe2/NZb
 MgAKWUKdNYIIt/9wghGNNIg16nMeLurKXUzQePnUUt3j48HjURNIqq2SvMG8CWlVeRTITKXhYv5
 41BX38nuS6z+H7Gdw6nCa8uKv9ZQqxEdf8TpuLNRDBtWfFFg8R5MhD9SljqZn1SaYyWWo8tJBU6
 lzm+0CtELISPLIEn4iKheqCSYvNFSwNvKbITVgRay+fOORMKIfpuRVJl+UJPkCu8/j/gNIBEAeI
 wPa1t5Qd1ztGCxtaV/zStLw1D8RsmEfy+8YzZna55ou5dePUiGg/8UFHKzlfPYG+GaMS985lmyj
 GVqbdMY/fOOJVyFQnSW0hijkKOuTVaP0N965a5htf6VoPmS9KINjT/9RD6Br+6hYVoLspbbkaqz
 V6Z8UIZF2cGvTDZcc9fQDjzEHVQy7qILxAuuxz7nrFCEn/dgvgLHENkaN6C8GEtcd9ZLnv8hnYx
 mACr79kH4Cm1IXWxiYuBPqdEnD5oISKN6cjT7QoSpHPNHwWJFO/DcTf5xqS4eQQUF2jqGxtNUCi
 KH2f6+9FydLGg3KJ9bDAgHyjgGtukoShwoaSmICR1b9pJCmtTZnTDMOgFZCpzCMZQE/B3+XjLHP
 1mEZ/HOn6JJ3LeA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

GPT partition tables include two bytes worth of vendor defined
attributes, per partition. ChromeOS and Qualcomm both use these (with
different encoding!) to handle A/B slot switching with a retry counter.

Expose these via the disk_partition struct so that they can be parsed by
the relevant board code.

This will be used on Qualcomm boards to determine which slot we're
booting on so that we can flash capsule updates to the correct one.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 disk/part_efi.c | 1 +
 include/part.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 4ce9243ef25c..d3ce4dd01dcd 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -292,8 +292,9 @@ int part_get_info_efi(struct blk_desc *desc, int part,
 	snprintf((char *)info->name, sizeof(info->name), "%s",
 		 print_efiname(&gpt_pte[part - 1]));
 	strcpy((char *)info->type, "U-Boot");
 	info->bootable = get_bootable(&gpt_pte[part - 1]);
+	info->type_flags = gpt_pte[part - 1].attributes.fields.type_guid_specific;
 	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
 		uuid_bin_to_str(gpt_pte[part - 1].unique_partition_guid.b,
 				(char *)disk_partition_uuid(info),
 				UUID_STR_FORMAT_GUID);
diff --git a/include/part.h b/include/part.h
index 32ee40488563..afae51f1b933 100644
--- a/include/part.h
+++ b/include/part.h
@@ -68,8 +68,9 @@ struct disk_partition {
 	 * PART_BOOTABLE		the MBR bootable flag is set
 	 * PART_EFI_SYSTEM_PARTITION	the partition is an EFI system partition
 	 */
 	int	bootable;
+	u16	type_flags;	/* top 16 bits of GPT partition attributes	*/
 #if CONFIG_IS_ENABLED(PARTITION_UUIDS)
 	char	uuid[UUID_STR_LEN + 1];	/* filesystem UUID as string, if exists	*/
 #endif
 #ifdef CONFIG_PARTITION_TYPE_GUID

-- 
2.44.0

