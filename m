Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FC606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VrV6F54P;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e3wFeZvm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74DDB6064F;
	Fri,  6 Nov 2026 12:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mS8B9sySKKSm; Fri,  6 Nov 2026 12:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6FBD607C3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793969323;
	b=iHYz0tHXfd5Yxl+DkXiAz7e/As7ATc5L2RubWwzyjnC1WfDY3OBdiMQZVEsI9ppLLVTp
	 qLK5Sq0JC2i3c7roNFdMCvlRvxu2QQhr3n7bfOZ/bj97GUzA/XOaThPCEYIjBgJpnNik5
	 dFzRKg+yYzkoFkeOJRuOUM7G8ONb/L00wr/o2BjCt/f11vM7ifsE+UNjaIMU1wcRPuNu8
	 KwDftDHHejRprSJeI6ySEpMOi8MIGiEc4K0VCe7zRB9K16VKr4L44O2zbw5XfgNkVMfrh
	 EV/+IBRV0fEv+bRtTgoIe7UeteGze/5gZEwLc8Sa+rl4L3ocJyk4mxi1cRbv+XUgnGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793969323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=N5wnarlTU4tCR/CF5M3XCMxD40nlpAcokxFLngbjfZA=;
	b=HMNG97xUe2MIkeHfeqyZWly3CpLj2BNmSkXm3n/p99P3zVUeML5CbhrJRXbuR/PM5NHt
	 CZI44GAdCYJ+91MjFjvq7JhiBNvEtBIQyEtkGUitdnRHXG3aP7nIYGdKlzIAa5QUxaovF
	 i1ju4zM0n12W4BOJvpVDYcau+E96IOAH3POPVbsg8TFtJ9yTYHqdub95ThX8izbpqRqNl
	 ywxT+nmmbxOm33IdOJ9lytOtyR6rYzZtm1L62t8aWUJJDC2kJbYLKcDOVdqwFfxHhb0pB
	 fronskeIZH3agc1p0dll1d31yL7Kcv1VM3BJgeBVUwpQaHH4eIjhuT3aYpSD1WVjTPA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e3wFeZvm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793969323;
	bh=N5wnarlTU4tCR/CF5M3XCMxD40nlpAcokxFLngbjfZA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VrV6F54PdUGLFrF9bdKZy7WLIsMP94N5uEEuLJ/o92H7fytcJJpqfPeq5TMIRIWhJ
	 tQmSlXCS4hNClhxIslJgpvk17GT+LOUYeTz1pFYKIsdY4Pw3vBEZEOJhc1tpqTqLBO
	 Z5iBta6texrJXbUl7CWY2tU54l61xwvX+nbrqwDPWr4sR0ENARxx6YkItMIv15jfs/
	 FzXr9NDHIyzebuyUxWrReniOmTPdWUx4ggS3nvkmcPheDWdt3uzlfD3HaSStq7W9ve
	 4+/bbSO6uVQ9iskdrJzeinK3SkFlLNlDe+wNIHaYUzhc+1e5tSDv53n/RehjG4XQBN
	 qrpn7it2IS6rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6FBD607C3;
	Fri,  6 Nov 2026 12:48:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18EEF211
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 05:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0AA7A606D3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 05:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ETwFoLvSrAT for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 05:14:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D97E605D0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=e3wFeZvm
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D97E605D0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 05:14:01 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-535179e995bso2297091cf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 21:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793942041; x=1794546841;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N5wnarlTU4tCR/CF5M3XCMxD40nlpAcokxFLngbjfZA=;
 b=e3wFeZvmfWlXcgbiwic9PTgMncN8fwtLZTtHPXC6/PhRD/mb8aAwPZagJ/OPbgLq9z
 akqOQJRuA61dBbMGTAbRHap/UpRgGiTOOG2hk2d3o+fu6Kf0bzqcUYT32sjJ+/3zhzYn
 qrPWfBMHAuYpwt8V+9OcW6M2bJXjy3s/fK/Bf+dYwO4pDZSbVoYboR/ZOJYPIeUIkosS
 8fwVYng2jZf6rcwIzjDKniiVzuwfpat0effwn+8x1icpvA6PsPLs8CWH7U/hpA8+Sd8p
 q1DWHkKPLZdVuYQu4JefphcKYj8bev8V0Q061IsymeMr18TrHAFxQU+m4/YjnD9rnOWr
 /Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793942041; x=1794546841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N5wnarlTU4tCR/CF5M3XCMxD40nlpAcokxFLngbjfZA=;
 b=jStnuj/1eeWa0h+qZ7Huc+ZB99Q4B2iko9kewnAZvPSM5+nncz+RkicuT2d3Z7xR7J
 KOFRtkRGJy7ofhDFrwlHkLroyPFPoUqA536ocOBVYDO0W9t3d1mnbaRC1vWK8X8v2ocK
 S9xKiUZYAYvn+0HXydC4A6odKxaW1FdCH6a48v5HpDqy6onAUcqYoqaHAy/Uzxf/S44p
 eBCdznNecYdduv8bYQ0zdMDqJBjPdy1DLHGtFMn0liNp8X3QkAfteXjJ7Qsb4zoeArz8
 plSkJed7z5tSkxIs0QkXrcDXZTciaquPWOfsCP4FE0mqzb1yTZi108m3bwJqSqg+eyas
 RvNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxK5WI0xQGqLmdLZq+RuwRwJ1thxNV6D3PASOBAViaZIK/QYn2FRwKuE952zTGQI09lNdTaFOI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9ycTKHkZenoVrzUiX9YL/ntW2W2bvniogGMsGLkf9Z0U4vjn69
 b3l8vbBx3tgQx8WKF4zAK0m/XINj2khudUe4lBT96yjTPUPMLVoAT1ld
X-Gm-Gg: AYBFou2t1JNY3aSkN89y1f9irBYvUPqh4CnEIEcAYyx2Sl5vbn9W4L1KUV4FA/fden3
 lmkGWHD/utEMR7/s6mRYOySSkCJ4l2aSzG0tAm4qSDX734QLg+woky16jrlAMMSJtlwTi3tTKuG
 NnFX0AeHi6ooRlzRo12DKLQ32uepCDWRwSRUGUzhpdihj0JRBFC8/GjfmYLReUAUgkhCK6Yx3FD
 0vB2LeEt0jV7I6LUmKePucqElFb/4naLg0ynSO9X4D134v22Jym572nIQzUdOKhns4a2WuemTSp
 nZzMCtkPJ0hFCQC0nvECrAxRLH3vR8zMdkyB9FIZJkAvyLV9f0pjEATCZCrXP/vip8VoU/qkvrs
 wBtVMgSuBC9/KQYlksHWFTiqrg5FUxFf5QsMBuUPnKuRDrMyXrTzlcdmfgRzjFzHBfxqEb0PzQ+
 FfqQdKD5yz8p+MfLqJsCtrAv1tdOb0Zo/uxpCcWbICWzfUh03PcfCJJ7I2v/P4OOmL5RrUBTOqR
 mY3IgFADm2YLmO/Qj9CRGPaN4BLF8KCK8VzQQ6KzZUpvqk59x84aaJPq/77BuUjgFqJiH441EIF
 lm98mmniyBYXsiB/zfPqhmUfnmGvCTHApA62OrU4mYYRNWvWwkHc
X-Received: by 2002:ac8:5c8a:0:b0:535:52c:a2d6 with SMTP id
 d75a77b69052e-54e100e5abbmr21623291cf.3.1793942040666; 
 Thu, 05 Nov 2026 21:14:00 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54e27502132sm11246211cf.28.2026.11.05.21.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 21:14:00 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.u-boot-project.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2] efi_loader: unload image if efi_run_image() fails before
 starting it
Date: Fri,  6 Nov 2026 00:13:01 -0500
Message-ID: <20261106051357.265179-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 12:48:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

efi_run_image() returns without unloading the image in two cases where
the image has been loaded:

- efi_load_image() returns EFI_SECURITY_VIOLATION when an image fails
  Secure Boot authentication. The image has still been loaded and a
  valid image handle is returned, and it is up to the caller to unload
  it.
- efi_env_set_load_options() fails after the image has been loaded.

Each such attempt to run an image through 'bootefi', 'bootm' or an EFI
bootflow leaves the relocated image pages, the image handle and its
loaded image protocol behind.

Unload the image on any error before do_bootefi_exec() is called. For
its other errors efi_load_image() either sets the handle to NULL or
fails before it creates one, so initialize the handle to NULL and only
unload when it is set.

Fixes: 6b95b38c41a6 ("efi_loader: rework bootmgr/bootefi using load_image API")
Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- Unload the image on any error before it is started, not only on
  EFI_SECURITY_VIOLATION (Heinrich)
- Add a Fixes tag for the efi_env_set_load_options() path
- Reword the subject and the commit message accordingly

Tested on sandbox only (LTO disabled, gdb). Forcing either a Secure
Boot authentication failure (efi_secure_boot set to true in
efi_load_image()) or an efi_set_load_options() failure for three
'bootefi hello' runs left 8 handles in 'efidebug dh' without this
patch, 3 of them with a Loaded Image protocol; with it the count stays
at 5. A normal 'bootefi hello' still runs and gets its load options.
Not tested with enrolled keys or on hardware.

do_bootefi_exec() also leaves the image loaded when efi_set_watchdog()
fails before efi_start_image(). That affects all of its callers, so I
will look at it separately.

 lib/efi_loader/efi_bootbin.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 12db8f517c7..5bcb8c2540f 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -170,7 +170,7 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
 				  struct efi_device_path *dp_dev,
 				  struct efi_device_path *dp_img)
 {
-	efi_handle_t handle;
+	efi_handle_t handle = NULL;
 	struct efi_device_path *msg_path, *file_path;
 	efi_status_t ret;
 	u16 *load_options;
@@ -192,9 +192,15 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	ret = do_bootefi_exec(handle, load_options);
+	return do_bootefi_exec(handle, load_options);
 
 out:
+	/*
+	 * The image has not been started. efi_load_image() also returns a
+	 * handle for an image that fails authentication.
+	 */
+	if (handle && EFI_CALL(efi_unload_image(handle)) != EFI_SUCCESS)
+		log_err("Unloading image failed\n");
 
 	return ret;
 }
-- 
2.43.0

