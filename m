Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531CF606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=saxwY+74;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=lSzfgY7L
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EE1580E26;
	Tue,  3 Nov 2026 08:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q3Ucecr4I0KY; Tue,  3 Nov 2026 08:55:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E0C8480D84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793696126;
	b=qfW2nXxxQ8h3g3cXBa+axOio3QfUw+Le4roS+JxUgsmgbmCwCWs97N/FcFS3wLhJmdBv
	 rt4NipcU2DbUdKukP+ugWehIjpCFHGppbV/+H6uUItRWnC5XI8LqdziwYSUzBMGN5zMa8
	 KMcBUme3zYnArdeS5OATcwvGWEYcvmwlhfsHsSjLyQcwzcKt7V76bCnztAkHw/9tdM61m
	 F3SNMfBJvRGoy7TXK1RjSuW2yK8y0rGjSiET7PrCkAbfsP/JHKUtdiVc8xe2qACBEkKFk
	 A80eDg5sYnAE3PhO6MRWtnBd6gWceuUONSxYSUbulMORY6tH3py2GlBcxW+N6Ffdmvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793696126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QRf99eRMxvTs2amFmjmDOeSDysl8ssPns6xMzIeHLtk=;
	b=cBz7SZe7Garc8NYuZHkD7wor4EXp0PfJfvsTVbhLvVLPiphYV0o/RQgJ+jrTo6/4FYW+
	 IH2YuNl4sHupmE8ONhkgiWuXiuV7+ENtYFAi26Wj/f0xcJ327SDLD4U6JSM5Wz1wnUu6o
	 h6v5y53dumLFIiWsPDE2NhabFhoklPp9h8LxBWWBhupPLYEPi2Wbw1M0JA3NUn58dmlaF
	 70lm2qBybfSFNcsYSlrhJ5p6sfeYnOHhPeieqpJNoU/43cjkn7Eh05V4FL62gCEBdUyNm
	 KQKKO//4gRs783yYyqBDM1D420j4zvJ01mWHtSY7k2AVO//9UvtI+ZKioTeX8YmOQvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793696126;
	bh=QRf99eRMxvTs2amFmjmDOeSDysl8ssPns6xMzIeHLtk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=saxwY+74UHWzMauXy+HTBKmJxLT1cJd10WwBA3EXWFswKZ8j6HHlpox3MD3luW3Ke
	 qVJPz3RPuDr7jVpoXvXPCMwig8Ds5xTXpAevm1wGwq9XkeyzC1la8NFhUOnrgzxRyQ
	 TDN+Oe8Q77k1nO1Wtt6Fn0ZTlzcPM9wMw0NnBLHKbwJygo9CpYcyIQd5aNydAe3HPE
	 XOQ6RI6I41ahDCUsNRo+tSNImPxpkWT46XVzFC3T04EEQ5P6LBjveyQkuMgzmGIviV
	 BVomIqBZ1PBxB2Ipf7POt0Yjri9DyXRamXrRwPL+c3iBLKyrBRzYT62Ur2PsvB1Int
	 Kq40RMDATwOzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0C8480D84;
	Tue,  3 Nov 2026 08:55:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DCE3F411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2B326069A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:55:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id umJhQhx8Iv57 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 08:55:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7BF89605CC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793696123;
 b=e1pjuC645Qig6o35z2rqnXv71N8uZ/ashb7euOTOHg4kDmc8JwYL3U4/XhUU51YNDBXy
 yezch7kNViodgnxKdxRXcDgLQ5ehebxPaso8YA1l80VM31LoUFEhjhNsu1x/+wK1blCEp
 9P5Gm5auV8S6AhOs7kCooDibLLMTt5vZr643kr7usW+gyv4dhYCS8gz7/4oOHxYOCXW/4
 iXf96i0nr8+85RmMkd52Nb1/BvhcDu9M+xhB4CuV+6btJnSMoiQGu2BD5jLLV9tuDHIdQ
 5e/xjDk/p79foUoVTvuEo1uC/rWZ6RzmyEa2IYtQaN8z2cBqB3sf8nMFi/vbupI0s9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793696123;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=QRf99eRMxvTs2amFmjmDOeSDysl8ssPns6xMzIeHLtk=;
 b=Z6iS4XnSurff6wkj1CKxIHGODthOdIGKR4e0mpv64gT9BztvuXgzLjgRAy84Qxv/tBx9
 DAEDOaPlb4Ti7iKIrx/pAQ5rSqhIAq0PJXqJMbqSQp14C5Kew96GkS6qwn12ZOq8GEsHG
 L8EnlrwxGpTEVRpsMaTbUrLv8LvetZsIok2FLzYDxjikVrLOHtF9bAssEZA0nkfyybFZS
 JEN8fH9xpTW9kc6DXyJ0nsrK4gMSQUnQDecBV/o5y8JMl/5OzhThTJZoaqZsPN22KHnaJ
 j+f0XFezovnuR9YFx8KIEzq+1DtkQAS99pQ0ragimAHrWqc6J+Yu+c54XUqp4XXNJ0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=lSzfgY7L; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=lSzfgY7L
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BF89605CC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:55:20 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 433173F32F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1793696118;
 bh=QRf99eRMxvTs2amFmjmDOeSDysl8ssPns6xMzIeHLtk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lSzfgY7LKe46zTVdXF1k5M6oG+nX5hioQB0mgDJopYx9l0gYc1HC/yPKaCvRKqByL
 8ohj3qwPNhWW5tCt3fCPnsE36R3f0Irdt3VuOwWIKJ82F1yBrtA/1vshl/KEDAwGrl
 HgIiGDd1vwLBbglYkmBBvArD0KFH2Kpq/WQIMyNi8LyqNrcrsyxnE9FI3QIJhUMN2/
 yWXrCJmx0Msa00XcUdaMi8+HrRk06Exow0C/3v6ZGt9E65EcA3Rr8ZOiZlPcgmthOS
 QViuHSDC+6p07LG6gKqMzOyJ64vUYWXkP1DzmptS2zAhtVEtxzk8nyJr0pM6f02h9m
 w3MgyyZmSBhACqw8IoluG24XT0FJ7tizywUuAI2t9HWOstZcRqedO40HZ/M1QBrsbh
 69p3aBeG98vuKoyo8uRnddtezsBuHGadbiALuD4D4v9G5CPj3nNWG6Y4dptPImCvsz
 jS7NgPEcu4dJqO4jYzRHt2Qh8gZHEBgI/xUf/xqeg9vfHmyKzxqAfasy14IIV5inas
 YgMkmE/6d/OGXAyVsgLMJ+kFEfNlUNpbEvrMZtizK2sUbof1ItEVws0GTm2wRlF6Uh
 axBTFug6HNjuPJuLt1o1Vy3Qi4to1luKYh0MjzgIN4fDG2yC+e5rbso3YhlDbBLPkZ
 BPJ0P38RPlp26TlsJax/vIW4=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48df5b058ddso2544960f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 00:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793696118; x=1794300918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QRf99eRMxvTs2amFmjmDOeSDysl8ssPns6xMzIeHLtk=;
 b=Wp0P7AHkMpchO04xkhKEOki9XfpjZhlKEluFOzpjj6f48yDBoPCsbO2vRyhCKFr+oO
 3EJ9rech/atmSXMudQmC7llSVnfcj5xOP5YnzPxZcRj9x7eukUiUHzsAZw/1/XUdB/WD
 fi2+iB6LsAAoP1lAlHTw81ZqPgavT+kiJ1yXaK2IzFoT0SlrQY/FOPyO1L4RMMRYv1Zv
 /STfJBYY3KOaIgFxfPHnuS9/iJ35VNGIutMt9I06MFfXZZCdzhT/Q4q3S0xH6aI0NaiL
 s4bJqZPBnStrLkBjwbkXrzp4K1Ogm0oYHCiRyWWbJp3vlyPhiKCJ7RLZiXcZEhUMJBrS
 RNUg==
X-Forwarded-Encrypted: i=1;
 AKwUvByyHfxCHa2rrcmKesxFxJ4J4oY8dsKREhI+bltA7NPpKQnGpHjF+pncXZ/tYy4dnYd61/N4xXE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/9LitDnOhFlC5PFJcCKM93xgnHSvSkRjdpGVpCOovGlB5M3MBU
 nB+hBlkCoiT/uOH/Euy1zsKaed3hX4ZMgDU4MNNwABOSWiUfdE2cEAGlZORCpqSv2g1Ukd7jX2a
 q6iN8IpYW75KH8TZ+Jqp4B8XtcZypu0J9RZDgs2UXIYgHaoXknfGa+R1EzRAu/7v5JYltKkuYxG
 6pf23lHLMJQA==
X-Gm-Gg: AYBFou0RakoFWz9gT2OftOTSJ1cvBWTQvIB963rCKNDn+7lBHc+Oe6Or6WyYSioKccH
 ZhgA+RsIt+CaqbWVZx+J9fOFVok3k1yZqm8fe9pObZVAtzEYEAD9n6vK0KfwW/XIEY3G556AVRs
 WrXeq6k6o7VmE492Ti9fl2IBZz4yP9a9uEI2v51vkkvmS3SD0qoX385lP6dESxHGLgUtsS8Z8qI
 P3+aoZNTZWqpvRmXfvG9aqnTKYrc7YsKzVzLqXArQn1UbKh8Rtd6GZDRHqkpS60VpRo2klUgJwq
 CPcTWprsq48laj0czO6yvYgZouiC/udjLlzgrzLEMZJ+oDSa1ehtOdJ0ppyXRIRuOO0KWDkh6ug
 13fBDGOa2b4Qy4391/30eTyepTHbJiDbpJwKrkytGqIl9b2+eOnakzYWEbgPUIxz29mHcxJwj7x
 99oGYih2cVAQ1nx5fkl7IRkS/15RNy3Q==
X-Received: by 2002:adf:f007:0:b0:48b:174:eab1 with SMTP id
 ffacd0b85a97d-48e6e509b48mr21917330f8f.36.1793696117789; 
 Tue, 03 Nov 2026 00:55:17 -0800 (PST)
X-Received: by 2002:adf:f007:0:b0:48b:174:eab1 with SMTP id
 ffacd0b85a97d-48e6e509b48mr21917312f8f.36.1793696117469; 
 Tue, 03 Nov 2026 00:55:17 -0800 (PST)
Received: from workstation5 ([2a02:908:1242:30e0:a04c:46f7:da56:996e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789ecsm22932274f8f.29.2026.11.03.00.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:55:16 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: handling of missing TPM in efi_load_pe()
Date: Tue,  3 Nov 2026 09:55:11 +0100
Message-ID: <20261103085511.74079-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In efi_load_pe() if efi_image_authenticate() fails, we completely load the
image and afterwards return EFI_SECURITY_VIOLATION.

If the TPM device is not found, we also return EFI_SECURITY_VIOLATION
but the image header and sections are not loaded.

This difference in behavior does not look right. Handle the no TPM case
like any other security violation and load the image header and sections.

Fixes: f9b51dcf294d ("efi_loader: correctly handle no tpm device error")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_image_loader.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index f9a2d2df405..a03866c2907 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1004,9 +1004,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		 * this is not expected.
 		 */
 		log_err("PE image measurement failed, no tpm device found\n");
-		goto err;
+		handle->auth_status = EFI_IMAGE_AUTH_FAILED;
 	}
-
 #endif
 
 	/* Copy PE headers */
-- 
2.55.0

