Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A01CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 06:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29028838BB;
	Wed, 17 Jun 2026 08:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZGES2qfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8B5848D1; Wed, 17 Jun 2026 07:31:22 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD5784971
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hemparekh1596@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c8584bbbf2cso3138743a12.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781674278; x=1782279078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YlB290O1aNU9njPLMaByWTim2QSDXkRxN9rJjuiojd0=;
 b=ZGES2qfXhAOsCo6TOa7B8Doa93+OmhCzrC43s8byxtIxnb9Wza5J/Nlhe50AEqG9hh
 nw5cI/fjI+GmmeX/E4tN3b3iOL23LiC3AUTeft91ckGdbLzFKh15zlEFIIIM7JaANGXG
 C8fFWaUz1Kdi4CurG5CSWWM4t8zxf/dyUERq23VpnicLiuGAoZWS/VYjyG25dTI38wZH
 ToPbZU5Kk6BVnIrsWxqMwcUc2Vv4wBddRxkzqNWAaKn6vHtikfQOC1j1/T2i0ejn4YU3
 td2Rp1lFqe0X7GW3fxcSWov/rei8D+ekh9lyzsBcw5fMj/F/Jy64bezqLeoPHe8tmbEW
 krFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781674278; x=1782279078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlB290O1aNU9njPLMaByWTim2QSDXkRxN9rJjuiojd0=;
 b=kHM/4rwL917eFigP8wAI8o1CpcpwA4bcjhtB5OfP+b0t8wRrI5XhwlR3NuNZZHc7s4
 RXPsHpn8nDcUeykuPhK5/e54ibDE0EUkNG2cbxEtBMLdpKODzrOxuYr5ZsGL0CncnF4A
 PrkAQM2HemRWFbe8hYgGTz9bpEkL31ogG9MlQPQucxhPGIwkdjwjbPTTO0jZsyhu4xzV
 fxdoOmWIVNOtVE3ciAXO7rmWBYCUAD2i/lrIvUzDndh4zHTK1peuOEvLh7KrNhsLKYGx
 XbH68tTk2SuueqZTwiAfkIhZRYKBW1S54Yz1I+uKZbnEsaKIjV6xb1a8HFyqBy3QKZoD
 VwoQ==
X-Gm-Message-State: AOJu0Yyf2NHkXKkI/WlvGpshCCLeQ28mb/X9sDHwCmFSkaAb3PYUryHg
 3wpOkR1KbdbJ+cen4N9p4LE66UXnP5yl1gxXGzh8ZYnF+UN/L3r3hzv4+TLNnaEO
X-Gm-Gg: Acq92OFahXFLLZpSElwqFCAaUYxP0FpgeweFhuorenB9Z/SSfzBjF/YOwnr0Qbm3Beh
 +30zOKci/KvCNRQZqAjq9mKwiUuVvHLnzuZx8hse67BzWApjaCW6JK+0uOvJu9XRELgEwFJT7GP
 WxAykXf+HBfUw4drbQOhqmk328nj+7IfAlRprX3GbZyQ/A7DOgmc992sftpTcVwo0+h1MPVB1Mn
 cibDLwuvil9PWB/hsp96jKgug+e+ykhcihtvt6RWmrWZdjns3ZwP7YLYlMHcot7BCsBuXWPz3Hi
 P5MfPsmGAdUVsBVTHfK2tlyHM1aRW1k/QjymfuoMHbQAAAhrurPCkvHiopVfqHRqFHQoDCslsBM
 azYU1OM6n6VE4tv7TJP2m4VhovT7nJ9JfpWpAuq74BCOFX2Un8muhXoc5oJmh/udxZEXDln5LK1
 mzxyNX2v7JsyOj2hHP6svk4jJceAU+WwC90jzz7xXkyLNyCwj9n8avYYoEUfFn9H3U
X-Received: by 2002:a05:6a00:1f06:b0:842:4612:55f6 with SMTP id
 d2e1a72fcca58-84524555a41mr2271540b3a.21.1781674278040; 
 Tue, 16 Jun 2026 22:31:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8280:28f0:59bb:e029:cf0a:263])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afc8fc7sm16063087b3a.37.2026.06.16.22.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 22:31:17 -0700 (PDT)
From: Hem Parekh <hemparekh1596@gmail.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Hem Parekh <your.real@email.com>
Subject: [PATCH] efi_loader: check efi_deserialize_load_option() in
 get_dp_device()
Date: Tue, 16 Jun 2026 22:31:14 -0700
Message-ID: <20260617053114.66650-1-hemparekh1596@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jun 2026 08:59:32 +0200
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

