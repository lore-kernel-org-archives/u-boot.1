Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDDAE74AC1
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 16:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B9E188EA8;
	Tue,  3 Dec 2024 17:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dn+6mUWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB6588E6F; Tue,  3 Dec 2024 17:13:45 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407B2893D6
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 17:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aadb1so6811757a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 08:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733242423; x=1733847223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cKsOx1urn+2JQO0EPZ3H4Hcl2nAYRVvr8/ZVUkKMYaE=;
 b=Dn+6mUWAH6B2KDWVAOPo+10fbAyqxOe0YctjDnWpGYbUhiBxh2fypHtwfa+2FrWWh4
 F7ulzX+orTcACZWi+LQWxh5i1KGg0TmjOXViw8MVAfhrByNXYWo33k1gqvo4Rd8D1uXM
 5HMBibrNvslU1YKaygtjqFp82Zclo0ufTXwphqsp8ti/bIe2mZK8/1VM5f1ciuG0XXnM
 HINpyfSUG6GFB+SIUMpt6t2ql1lOQ4sx40me8kBzRF2iZKxZRWBUO8wA2LDTe0szU2ds
 QBB+sx8SWitodV636cKLfhWWyC7OU7M+YEWeDsU3rMiIRKlTCT3g/ZagaylKNVFyk8R+
 O5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733242423; x=1733847223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cKsOx1urn+2JQO0EPZ3H4Hcl2nAYRVvr8/ZVUkKMYaE=;
 b=YMwvaOpG31jykdNuYSvV4IflNcQR9ugei4P1WqwMMpiklUxRzRvL2l58FL4KrOL0Mu
 A0KrapM/lOcQc1spIgUvFnPj7nDLNKOMgBZ9qmIzklcFziYJTvRmsdHnJLDtxe0A4uPZ
 nebOC8fHkkCMHOlXkM5u0nOcYL+vMxYQy3dpZx2A++i07QdRf37GMDg09ydloSG4sA9c
 vz2rFULAv4AGgMG7Qc1jjTyYaR/DbhZtRTZu4ssDx9JOTW+G/vZzjy1nx6MamjEUrgeV
 /TY/XMmFD6LypsSu98HWDT1Ne3CIoZKYsGL1uLv2JsPqngQMvc4O7xCMgvektqpfXBkC
 Fxpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIZnxHw7B5dCeJp6vam/23HhRWGUrIxVB72R2YuqIhai3ax8e9y2MAHWYHy1VY7Qs4tkN6hPI=@lists.denx.de
X-Gm-Message-State: AOJu0YwKXkTtYKKR6YrlUOX+UtsH/DL8wKrKIkCMuvJYBIvusf3sPJD8
 992otdkxGeNlbHgBo1kgI/k42Sm0W0cazwZMrbgoawhi5JGUwnq2QhRoE2d4wj8=
X-Gm-Gg: ASbGnctevksvNH4EIQUe42yXRXmLRXDmRlm+99XFh+OMJ5wtb62EEorDoRnENGs0xDk
 DnU2f3ZHmJRocoHOaRTamywT3fRrMEH2q2x/zApvwXlepnmZpTqwDdQDICluQQG73vwfaqfV7Wf
 9lXJ3byFyQUHZJgxzkoUxiTfz79BuTsa/d6fX0w3cAsKCyvip/7kkYKQyEOeSNzKElg3zkwnkMp
 ZoAqaAjEI5a4MwBNxpHFeVm5v5Nyoa9UcOwtzdFUnE9REa0ZYpsSVE8/oqiFXV+uomj8PRTHTXB
 Ja5QfN7RmtTb26P9fdwd/dUbJMs=
X-Google-Smtp-Source: AGHT+IF/Wuw2282yq+iq2nhYmFqJJ+yvj5FyHiR/8rYaXwOAJnl1Ur+9jiHxI86BmzTtkG/M2rgJaw==
X-Received: by 2002:a05:6402:378a:b0:5cf:c0d2:698 with SMTP id
 4fb4d7f45d1cf-5d10cb5baf9mr3129039a12.18.1733242422579; 
 Tue, 03 Dec 2024 08:13:42 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d0e04ec755sm3139262a12.62.2024.12.03.08.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 08:13:42 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Check for a valid fw_name before auto generating
 GUIDs
Date: Tue,  3 Dec 2024 18:13:37 +0200
Message-ID: <20241203161338.1814537-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The gen_v5_guid() is a void and does no error checking with pointers
being available etc. Instead it expects all things to be in place to
generate GUIDs. If a board capsule definition is buggy and does not
define the firmware names when enabling capsule updates, the board will
crash trying to bring up the EFI subsystem.

Check for a valid firmware name before generating GUIDs.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_firmware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 6650c2b8071d..112775daf4c3 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -281,6 +281,10 @@ static efi_status_t efi_gen_capsule_guids(void)
 	}

 	for (i = 0; i < update_info.num_images; i++) {
+		if (!fw_array[i].fw_name) {
+			log_err("fw_name is not defined. Not generating capsule GUIDs\n");
+			return EFI_INVALID_PARAMETER;
+		}
 		gen_v5_guid(&namespace,
 			    &fw_array[i].image_type_id,
 			    compatible, strlen(compatible),
-
2.45.2

