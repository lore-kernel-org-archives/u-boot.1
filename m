Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F2ACD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 04:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D7F846B0;
	Wed, 17 Jun 2026 06:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="okbT18EX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D2CC848D8; Wed, 17 Jun 2026 05:46:21 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77C91848A2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 05:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hemparekh1596@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c0c1e0d00bso47435155ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 20:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781667977; x=1782272777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YlB290O1aNU9njPLMaByWTim2QSDXkRxN9rJjuiojd0=;
 b=okbT18EXkZfabOZCjoTJmRiuXJJHV16kcgMA17pWqMGppZLev7teSkQ4bRKooCgGTI
 gnZJqUxHFnCqqpPbECfMZ38Nt319UBhCFEl53vLwXFPqEY3YvV+6y8e7ioQp7LwKYbH7
 fhS5np+OJlts/f9O+6HiEwQwOQxBPesmC8ML+TADCIykqtCaWVwTfVtsG7FijPIFR//t
 jvbJ4Fgj9Rc3BZ1FYEkncEhIKzQhBzOxSeMgIc3bBplTRBtYS2nSgL7YnezwCxHem3H2
 XYsrEpDLb5wvC0YvqWzzlToduvGiw1yLZqJZ3auky8fJrUAOMs/zNe9znfZBJtw+FjPB
 x07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781667977; x=1782272777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlB290O1aNU9njPLMaByWTim2QSDXkRxN9rJjuiojd0=;
 b=rTMxAmt1wnLOBIDX6Jhg9mguNY5zGKfCHBy8r5bRzsjAxkmS/icg6DZrkeClg/fG1z
 5plNnymvRdf777KqIMKQCCD6p943t0l+48i3UGLsaTbUJZrHInsYsAbJr+065XbkWMk4
 8I3KsMNLST1QOWcvn2WZqfw9C+uafGEvvKvNg3oMTZx0AE3Nob+MRjcZyRENktVbmy7x
 YaPR889XLsFZYSQlp0nb6l7Yre1rdnVr0+tcpe7itygBuLN3o2QyWJfrzGSkwYiamMok
 bInJGb2lGAPRSrkvag693sgcLH8dTgP5zDs+F0Ju18kAKdkvqboXMArHiLJU07u+ioim
 jPuQ==
X-Gm-Message-State: AOJu0YwapydaalPhC58NEpamNMsRYNKhMge5903Aj1pEYNTahkiX/g/N
 jJOXIt1FC+0GPcHJhH3/RhDiXR0oJwTPLf/jFwMvqwt/ymzT3owNSzOwQxObw1Qf
X-Gm-Gg: AfdE7cl0zhnOd6UxucWGB8POdau4Jh1ig9Owe+w7redcvKSZVYsr+zxmWbdv/3E4rSy
 pIoerbMFGM2eWjWiSG6zMcQS3macZnFLsVe69xL9TBnr3C2z8WD68RW3UhfV/D8sDcx3IJHY94n
 iVC7IDVjSt/o0MKWCMIyprgJR87ePMoWTgt/Fi7OR5kLshM4glnV7uxyF44ahsM3o3PGnI9TVUx
 bJzSg/FA25G/Coe7NMExTS1fChVcBukY8CfDKG6yI7Qx6xD59HjrVxqkXEtsNWVg21b/c7q/PBC
 n4mP0DtHvYT5JmiKRqoINqxj1pYfu3JTa2H4UeDFvIu/AtSKCaAw/ctuhjRNv2dmDm+eT3TlG7x
 WnJWuDJWa1qbKdRSHHcsLQUs49qE7vgZT9WaFSYQNe1OVTSnbqyM64YrH1iJtAWMCU7yl8+BvrH
 ZDj8eVFRobRxr/ZDLWQWwA89OyOP5/86fh05wpAc8pj5I9Gukg7SgfZg==
X-Received: by 2002:a17:903:3dc4:b0:2c2:b173:dd9 with SMTP id
 d9443c01a7336-2c6bc22589dmr11862545ad.25.1781667976700; 
 Tue, 16 Jun 2026 20:46:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8280:28f0:59bb:e029:cf0a:263])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f7c91b2sm150279535ad.28.2026.06.16.20.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 20:46:16 -0700 (PDT)
From: Hem Parekh <hemparekh1596@gmail.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Hem Parekh <your.real@email.com>
Subject: [PATCH] efi_loader: check efi_deserialize_load_option() in
 get_dp_device()
Date: Tue, 16 Jun 2026 20:46:12 -0700
Message-ID: <20260617034612.64477-1-hemparekh1596@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jun 2026 06:56:31 +0200
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

From: Hem Parekh <your.real@email.com>

get_dp_device() reads a Boot#### variable and passes its contents to
efi_deserialize_load_option() but ignores the return value. On failure
efi_deserialize_load_option() may return without having initialised the
caller's struct efi_load_option, and even on a malformed device path it
sets lo.file_path before validating it with efi_dp_check_length().

As a result get_dp_device() can proceed to walk lo.file_path with
efi_dp_split_file_path() (via efi_dp_dup()/efi_dp_size()) on a device
path that was never validated, or on an uninitialised pointer when the
variable is too short to be parsed. A device-path node with a length of
zero makes the walk loop forever, and a length below the 4-byte node
header leads to an out-of-bounds read. The Boot#### variable is
attacker-controlled in threat models where writing EFI variables does
not imply the ability to execute firmware code, so this is reachable
during capsule-on-disk processing at boot.

Check the return value and bail out, as every other caller of
efi_deserialize_load_option() already does.

Signed-off-by: Hem Parekh <your.real@email.com>
---
 lib/efi_loader/efi_capsule.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 52887f7c..01c86bc4 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -860,7 +860,12 @@ static efi_status_t get_dp_device(u16 *boot_var,
 	if (!buf)
 		return EFI_NOT_FOUND;
 
-	efi_deserialize_load_option(&lo, buf, &size);
+	ret = efi_deserialize_load_option(&lo, buf, &size);
+	if (ret != EFI_SUCCESS) {
+		log_err("Invalid load option for %ls\n", boot_var);
+		free(buf);
+		return ret;
+	}
 
 	if (lo.attributes & LOAD_OPTION_ACTIVE) {
 		efi_dp_split_file_path(lo.file_path, device_dp, &file_dp);
-- 
2.43.0

