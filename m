Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69263C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 06:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF1087841;
	Tue, 26 Dec 2023 07:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zNiFHK+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25EE3874CC; Tue, 26 Dec 2023 07:30:24 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD00874CC
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d3ed1ca402so33111615ad.2
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 22:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703572219; x=1704177019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SDlFCq6tq7266PmIPgtf9g1sxLKsj7rk9DKgnQ8rk+8=;
 b=zNiFHK+w8UoFhswvMd/MMYYIeDrahV+913AZM22Gaz9Ag5uifm2CNmi556hLw+Jc4E
 RqgsxrWQEeaonICP1YD0EzEFH9cyRu12aAL3kcYk87BvJt+YKsLnWjnYaZZ2t3DyQSzS
 ruYOmz7CeojRap2SNe64QwG0LeAMolLheuMa0tUBqwPmHFXvIJWA7nIV9Re4HUTmQIYv
 psDf6GBYbrsPm5wv9929tJq8sRMDzlT2Ri+kphR+XlPgMSWCBapVkPKJFWadTRWHIzmg
 i8dUBnctHIj+Cm2656vx/mlvtOQT39QoSVgxg5z7lw4+9OiOst441utnL5pHvnLSMZiE
 uw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703572219; x=1704177019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SDlFCq6tq7266PmIPgtf9g1sxLKsj7rk9DKgnQ8rk+8=;
 b=snvt3iU9Bf0OMFNBKyq2GgtlNL/GvvtW1aH+MaZ6d028tJnZh2m+DncDcecvIsCFH4
 Bj9YER1ptaKBDRTDugb1C+XWsWcIYUp+Xbj1nA4ttDlXlhqvLv1GM/lR8UM2kg48ylHd
 9XqCtnH0uzU7iI5L7KXGAOYOaH4nshZXxQdxM3g0bi0lw8X6Z7EXdNrPTCJYqswH+5lE
 UsaMtxUMBzmxsvVOOgpfaC2BdqaI+20bXiQTJsJNmIcIXo1pS+MP4eTdilahTjNM4LMW
 KbHGdYi843XChhYfRJZeglfbV8aXiwvWIg4gW/I1RJNaIJUXppeupEa9iNZA6flvIj5y
 ER1Q==
X-Gm-Message-State: AOJu0YyKTkSeVFJqYFrZIQO7OwlygoPEPSUP3Oa1Il6fB6QcaA72VxTy
 BqA2hYVeL8qOD6lcRuJ4OEhQ6Te+WScK8/pZ/HFifhThxcI=
X-Google-Smtp-Source: AGHT+IExT3HDOGwVr9T+E76QsLzGg+qbhj3M8/OU0f68YJfr3g3J++QwTP7Mnet3bq0EPDj1/EUJUw==
X-Received: by 2002:a17:903:48e:b0:1d0:b42f:e41b with SMTP id
 jj14-20020a170903048e00b001d0b42fe41bmr7452018plb.64.1703572218844; 
 Mon, 25 Dec 2023 22:30:18 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 ix9-20020a170902f80900b001cff026df52sm9280634plb.221.2023.12.25.22.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 22:30:16 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 0/2] fix auto-generated boot options
Date: Tue, 26 Dec 2023 15:28:18 +0900
Message-Id: <20231226062820.722358-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This series aims to get aligned to the EDK II reference
implementation for auto-generated boot options, and tries
to address the following issue.
https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/13

This series is based on the efi-next-20231217 tag.

[Changelog]
v1 -> v2
- fix make htmldocs error
- fix bootmenu python test failure

Masahisa Kojima (2):
  efi_loader: auto-generate boot option for each blkio device
  efi_loader: auto-generate removable media boot option first

 lib/efi_loader/efi_bootmgr.c | 121 +++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 27 deletions(-)

-- 
2.34.1

