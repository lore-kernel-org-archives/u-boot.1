Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0F606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GaLzGTDf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KhSUKNnw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04DB260658;
	Wed, 28 Oct 2026 05:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NZYYoTsRYDuA; Wed, 28 Oct 2026 05:50:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A301605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166603;
	b=lwjxFvnrJYRLDQrQb+Kmdz6UxFllnjmnI28toafdKxMGMnYrJE3A9zvjRMMNX0eSGCZn
	 k0Go8qUO4aMExltOAyF/lbLSti554XQ0A7DFgMrtdKGITdTDDlATdLbqbi49DYMHmnpN7
	 EAUJMKf2oCN3j80kPfOIu4aOmd8MkFvuG7Vi4NMASc3XHDC0Dsj7T+47ekaSC6Kt/xSXM
	 xT1AI+1wHUJX2Hqo7ijpWb1B89ap4EWvaNvROaoZL3d/5hdSshMjfncK9xp4CD+EKV8yM
	 /PSjnXWRc0Yr2Zjy2CT/5YO+FYlTqOJal5V/IDtNgTc8zr2e0bBFbTaxdtsP7rAlbuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
	b=CynBAM5UkkcpKHAuwsoLpedaDxQA5IlGR/C1FZ77pXOTTxH8EITIUw0ZRv14RV6YQcvq
	 fy4QTdS8PT+W1Qfl2wWd3wZPYeNGPv+g4Qy04Wh+qXvq569NOgRgIOuN6ZdM2fypjtWnh
	 MdRiy9bmh2147pzXgXbdioOfjQ1NFUQcVUuQrfaWW7lSuCOaO3irOrf41KCOZFWrdARXY
	 I9ZMvNK4QNrqp/rRJJppfpXkbaJ7D7pBMItfDkwov94gRoRtkw60nykoAscV3kqVHEAZC
	 1ekt8d0+qQ9paI0ylSV9zgryORpi1CmPMgm89dr+kMOai5uoMqKOce99rwO8Ja2lFIQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166603;
	bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GaLzGTDfgQt0qnpWFULRcpjU5SSb6oKoffzD4D5BnVfMehyWwTyULapf0ZFXW6Ffd
	 Hp+jEaKaDAFBPdEThXXqpmpqBsgPZW5rcPRcf/qT8uMeklXN1UmouUNro6jK1dAWV8
	 DVIiBYgaOL1MpPpGp+JGeEGdoDMkVxdpspb6UWlJbnKqz5L4sB6qd4gt1VWnTN9CbN
	 oOlyl+yv8MLxepwmLdz5KYel5hVGZUf7NKPxb/wcr4zQ+oqhs10LOUFp0AG4ib4rQ1
	 vLXYlN1B11dR6uPwA5Imj41Q4X2RYDRVgEznCqZJHGXlMT6NPB0vuBh0d+v/dt0xuc
	 JF9hq5RE3Sczg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A301605F7;
	Wed, 28 Oct 2026 05:50:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31EF04D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1862340576
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a_ME2cgdkP-L for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4307040574
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166601;
 b=syCbYnjxDtCbhGKCHORiKeoZDDGWI2m/0nU2efGvrCa+rj4twMU018a8x6sGpYYzT/VU
 wOdMQRwAjA2wkqmkRGSgoPfxE+3pcCUvhSJkzdUmuqg8z6U4dV9I5mmpuBZudyh9O2cN4
 XQdcV4Mqqx09pSqyTG4G/wPoYR+ydChI9XefHKXmSLeWxxuTUROdgoR11QGnMgOtfI0DD
 gWm3zqE1NBZYZaFNTqnM/lMOhYZzW+tvvszk6YSXZKMcci5N9EM2c4NqWNFET2H5VA+8s
 6Dxn9Wo5czPZblg0swURiaTPzRA/HpsE5baZpjUr7AjIjATZOvxNBhqQNieWUClB3Jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166601;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
 b=pKzIwe8B/nEdSGcul4r1SEDsR8ZNaryUANV647j4RW137YhmuwOvOSseZegZev1x6pij
 0+8RhZwmVNJdT7p0pwUo0Wh6rBwbdw8mpgU4lt8LmUIT3KTMC7227/5OTKcqA7otLoTWs
 7qQBGWD9J91zYEcDsGYRY80CVgo2hYbE0vB0zamK0IbBmzzlv5dIGc/E7KHXpw1+pezJO
 AYD7Bto57RJaXdElx4/+MHRtkk5e6daTwBV3KTPcdujfEU12X9LcbWkyBouzuuW2NNbf4
 ZhClXFkToxQvWeoONuPbAKM52YFQAw28ZVWf+b1sKEDwLjEBVq1craV6tC1G3PI5pyA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=KhSUKNnw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=KhSUKNnw
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4307040574
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:49:59 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso5541275e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166598; x=1793771398;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
 b=KhSUKNnwObQx3cpTGazyLL3qWwwwR8nkJZJrrV0MQtnzZIcwYITEKbEmoj7SlOM4jQ
 SEjy3uF05ttiCiw/17XMYNS7Joa0jq8NyPP75LiItUrsv+1xdvRs0xR+VwqhZ+Z0jKFM
 Tzs0u2QV4vpMzze8ftFXvM9Uw4X8X7hUGUnvckJXS/S/ugA+/LZNhTYG8tTGeuSxDTwR
 2LNNrOyW/UzyQGe75QfO0QNSynkXv31Lah+9tLKOUSIw1lKglT4Vof6Xbyw2p+W3V7Yh
 UzmT+TX4yivjGzItzIdj55g0maBTNjqc2lMAXoXP3sTpdk7Treg5ojNo9121uctREhyS
 lELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166598; x=1793771398;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
 b=Z/11db8451h29yWpHVgysE2fTEYIr2Qy9UeOj/ycDi5L6/4/OqISlPtA07ckC/ilz+
 hGcOxCYuKIOysotWhSbdmX0bMMlnwVtXtF+V6rbOX9aSgVbal/t9pHSB6fJuB9n5G99V
 dZYu2CJmzNCOvKj4qamWsw9hjl1t6c2jLb6QZgv7oT7EqBVLl2LbeiqjrIKEa3m38Z2v
 caLYJP5L8Mk2poEcqquDsJxfKouJUp/X/vvk4z0o3FKZLOOolXNjrt+4T/HXGBHfgn5r
 Zr1JQBnBgez96/Z+JSM5cvA9K6RVmIx0jDXgJ0KT95RZ/WgADTf/ccob19d5T6PDbIut
 i4bw==
X-Gm-Message-State: AFq9FYKoqTmKsA/7TpUl8Vkj2SuBDCTZ32yHjCFDQd1Oo1dWpdPEAw56
 /ES9gdSKt/45Y13EStvh+UscvJC2jdCeKMz+qd6ie7w6cNmtOR3qPHkg40YsWV5+tFs=
X-Gm-Gg: AYBFou2Zu2oj1LVZd6w0j9ljDZ8UxPSAvOXG4YRGYjeDQAoMadOVI06/QGlStx03nNY
 19BSaYIpAo/H2DWO85lI90SdEH5jdOx8hUrTp4JMNLfyI8hZXJEg77SPr3FThdpmBK3nv64nG7c
 GNkYuDfJ6leqqsHlSlUFaNqUI3JNwVA5GyzXtmyedVVTmo5muYle/aIllrKsjI+ELhCqh8kOPHR
 wsRhFOB5AyPy5NyjrZLTU1VEpOb/xveZO2Ticm1auYgevXrCkX28HnMcOoCBFLpm87WHccwFGem
 e6RhX8zVDh/2iWhN7ltmRczgSoSHyKMO30riDvulrEpGYp1PXXNghs2i9Ux7E4qeGKw+bmOEnEG
 XPyH7bnug5iiviMUmwSp1jPAjxgUt75ouBHF8YZarjh3v7Ixg6E0Pgv7gDDChXRYXmkWpZyzvkp
 LzZZdQAs2TNfB9OJAjZ41Z89KFOaSt5+eAReHJlEU5PZ2SSBlS0fX0bBr8zxt+7LHXtijJe1HkO
 MKaWoHeN302TQ6dmZgdkhSP85NOReuC5rQBZazkrkv1aWVULk4SEfn9hMGMwlBXx89K+xCSZJJz
 dQlaewxhPvRCqegOdHP9EyZxU1YbZlQ=
X-Received: by 2002:a05:600c:154d:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-4a967202a2cmr19552845e9.20.1793166597970; 
 Tue, 27 Oct 2026 22:49:57 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a9797e98a7sm18020585e9.15.2026.10.27.22.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:49:56 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/7] efi_loader: capsule: check the capsule header size
Date: Wed, 28 Oct 2026 05:49:55 +0000
Message-ID: <60ff1e72-dead-4ab8-a1a2-e6dfbac3dc91@gmail.com>
In-Reply-To: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
References: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

On the capsule on disk path, efi_capsule_update_firmware() is called
without the header checks of efi_update_capsule(). It only checks
header_size against the size of the FMP capsule header, so a
header_size smaller than struct efi_capsule_header is accepted, and the
empty capsules of the FWU multi bank update are handled before any
check at all: fwu_empty_capsule_process() reads the image GUID of an
accept capsule at header_size, which may lie anywhere after the
capsule.

Check that header_size covers the capsule header and lies within the
capsule before handling any capsule, and that an accept capsule holds
the image GUID.

Fixes: 8d99026f0697 ("efi_loader: capsule: support firmware update")
Fixes: 86794052418b ("FWU: Add support for the FWU Multi Bank Update feature")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_capsule.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 54c118736cf..e8835315e86 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -445,7 +445,14 @@ static __maybe_unused efi_status_t fwu_empty_capsule_process(
 		/*
 		 * Image accepted by the OS. Set the acceptance
 		 * status for the image.
+		 *
+		 * The caller has checked that header_size does not exceed
+		 * capsule_image_size.
 		 */
+		if (capsule->capsule_image_size - capsule->header_size <
+		    sizeof(*image_guid))
+			return EFI_INVALID_PARAMETER;
+
 		image_guid = (void *)(char *)capsule +
 			capsule->header_size;
 
@@ -544,6 +551,11 @@ static efi_status_t efi_capsule_update_firmware(
 	uint update_index;
 	bool fw_accept_os;
 
+	/* sanity check */
+	if (capsule_data->header_size < sizeof(*capsule_data) ||
+	    capsule_data->header_size > capsule_data->capsule_image_size)
+		return EFI_INVALID_PARAMETER;
+
 	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
 		if (fwu_empty_capsule(capsule_data)) {
 			if (fwu_empty_capsule_checks_pass()) {
