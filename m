Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8587C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 09:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1387831BB;
	Tue,  8 Apr 2025 11:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tWZEmGVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A12BD833D3; Tue,  8 Apr 2025 11:13:47 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19066830F4
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 11:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so4513234f8f.2
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744103624; x=1744708424; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fcqQ8CuF12MfuZd/Ln7j72IF/EkSBJwZHJ96PvPK6KI=;
 b=tWZEmGVKnReRLv7AJSNKJjm+RHdTfnEzTWjsM4yXdtH1DWHBoH6yG9PcbcIOsuNSm7
 PEkdeAzuIz915f/QZPMewlLDFWGvNm+EdS7Y7U74IDBbnS4mL91Bx8LYEDPhzjBL0WnD
 F5jD6O0WkXtXNUvCVp5BG/uzidLiDfhenXj1CQOIXsEzfJtey9wlFyOG7pLe6H2I7cq1
 8ZLuf7SKDnBfV8JXY+Eg1cVrG5sbqEzOJUQ76fCArjViPnExjdE2hIGUOUIj4+U3hfmN
 NJEkzRTPWJ4qTrklh7XfKz7hKO+0yQWFi4fMtr4Wysawx+t2sSeJWISN15CAySteEcwX
 yWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744103624; x=1744708424;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fcqQ8CuF12MfuZd/Ln7j72IF/EkSBJwZHJ96PvPK6KI=;
 b=QOsUOUbRYedTulQ9PETfpKx9zaAID4lPfpghV6xa2r8luPWh63+bgfErmYWgOOHiT/
 Y1sbmGr0HN7cUikFoWQJWnUjBYV/2zNe2Ow3wUzh1OOcEkWxSPXG3tTrt+Ks7XHyF0as
 rHaCak378PY4QzWmYftJxUSJJlN6fGZO6gkZj4ueVh73TfOFMgc6pvCOPMjPMw8BgO06
 Mi3ObLEzGlhhIsOPEPFvEJDxK0r67pJVqnpWETY8n2FUaMmLGTa3qC+k31fWrW3pgA1T
 m0kd/1jR/ddzBjiTYeMeM7bFsfN3KMYCFu+48HAwbhgSjuVy5I8PPU3zuotj9CJi+gi7
 IY1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUnTaIo/HXlsJWUGO/HlbH/rWmSpBF4BiH45Rg/EU9GOMuntN22apcwLCylZQcTyfBJEG9Klc=@lists.denx.de
X-Gm-Message-State: AOJu0YwvgD2Somiy/+ZkMYATaoqGo0sRw2xsaGKzOeRzHlkS7Mhd3A8O
 NClmMMPu+n/r8c1IuWYpL1DjxiNQCK3qm0e7drZEY69der7HV0vNgmYMDZDHojU=
X-Gm-Gg: ASbGncu+Iiv0DDFwOPXCowwfV07Wf2nTVB2IjhkYWOFeidTuHXRsdKJhcwNtiUJIi2q
 b4q6izb5JlIt7vwbKTWYmyxzZOOasSvwt/C5IEMJsFfnJ6vaeOmnscD3gjMAhDJlElOsATDFP0b
 4Ome5Wpitbk6lMBxjjM5gSBcWuchsc6opwxld7zhPOkiXy1+sMIlorMK9W17ogVjSakVVxcz/Cc
 eK1xSjTsqkNDnrzuZx7PA+a9mCtUPIIvjJdP5POGnTaL5fBa1BBYnRbDVJLEfKNMZnBLNct7ovz
 Yij1tdIOSh3V1Z904/e39VFgRGHYIxSoLyJH2WLv4TbxlldZjSd6iRB+WvLH5Cyfqw==
X-Google-Smtp-Source: AGHT+IEWR7Jpv70ISqyGyLB+/6DvcRjNYXCNcQRuALtho9oevmI7h1HcIsbkxWjJXltw/hWiwfHl9g==
X-Received: by 2002:a5d:6da1:0:b0:391:2d76:baaa with SMTP id
 ffacd0b85a97d-39cba9826d7mr13490877f8f.46.1744103624516; 
 Tue, 08 Apr 2025 02:13:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366aa29sm155056555e9.39.2025.04.08.02.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 02:13:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] part_efi: cache last scanned GPT for next partition
Date: Tue, 08 Apr 2025 11:13:39 +0200
Message-Id: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPo9GcC/x3MMQqAMAxA0atIZgNtUBSvIg4SE83SllZEEO9uc
 XzD/w8UySYFpuaBLJcVi6GC2gb4WMMuaFs1kKPedW7EMyZj3NOJvPIh6L0Og9OO1AvUKmVRu//
 jvLzvBztbjEthAAAA
X-Change-ID: 20250408-topic-gpt-cache-11f770f42f1e
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Q3aXiY6SF/qS+8iySflhI2v7tanipHEIh6JSxZcaYWc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn9OjGY/Pv2SISMGWKcI1p2vHaxZLyiVi1FMgEaUWK
 1EjmegeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ToxgAKCRB33NvayMhJ0fqaEA
 Cg70nAAPwJxYT98BNcFKcuaJej+FAP43OWbqW5YyHCqn5joK+SAODvqRR2Niezlk/RVpEmB+7982yh
 STb1p7wd4ml0QVklTrhebDo5aKYq8M8F6BsWSfmIcXzzTtmdIbTt9wefCWdBCJPhIZG6y8EyBOnc07
 RJ2jjfufMTpf4Uj+ihW1D6WRL4MGoFoeLSKAvjJx3jX6PgqjSVkuogG4HeJ2y0IMrbJCORa8QfmAOO
 /V97Ga9hOG1ipTDPeMtrOhtGu72RYH6SYDXp9a/UQehwcJ5kJyBvcVGOmUF4MnhPqyitV4SYTLX1d1
 8JEuJDpXJwVoFCGO8NFq9Kj68JtuSGFYmpBBwGgquI/PJaBRle5ehbtBN3YjOCecFFNZwnD/2HEVwo
 /wXKSKm/m9x4fmAvVBgiEzQDcmrZ79deYLoixOXdOLIT3xUb0AOzWtBz3KmE2kF2v8wOzeD/IOUvDD
 mjeJWXhZ1GxTaaSvr9mjd7TsKhRzfVXy4vuAZSxJL/0PRNTgIVs9i7CkHzlnrq8VO0HwmCGauZiykf
 CoAtZUyhXk7h7v97uqcgrf6aa7OaLi9pykVYopmFI2YFhKgHui0oD40/1BUpWKh+vrAa+pGEQnBEZ/
 Yv4lICSWXxhV+6MCKOb1hAc9QJ0IO8YDFmQTh10UhiI7hIFipZWV2vU7XamQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The actual architecture of the EFI part parser means the
entire GPT partition table needs to be parsed for each
part_info() callback.

Since the default part scan code will always scan up to
128 partitions for a block, and devices with an UFS chip
with up to 8 LUNs are very common in the field, this means
a complete GPT parsing and validation will be done
up to 1024 times instead of 8 on such devices.

The GPT parsing can be cached between each part_info()
call speed up to 3x on the worse condition when the CPU
i-cache and d-cache are disabled, like in the SPL.

The new part API implementation does caching each time
a correct GPT has been parsed and verified and will match
the blk_desc and LBA to serve the cached data or force
a re-parsing.

In order to allow GPT manipulation, the new API is only
called when scanning the partitions for a disk, all the
calls will be called uncached.

On the SM8650 QRD platform with a KIOXIA THGJFJT1E45BATPC
configured with 8 LUNs, the scsi scan takes 0.2s with both
CPU caches enabled, but when disabling both CPU caches it
goes up to 4s to do the full scan of all 8 LUN partitions.

With this change the scan takes only 0.18s with both CPU
caches enabled running 1.1x times faster, and with both CPU
caches disabled the full scan takes only 1.27s running
3x faster.

While 20ms could look negligeable, it's still a 20ms gain
in the boot flow and a non negligeable reduction in
calculation and memory allocation since for each scan
it would allocate and free the gpt_pte table up to
1024 times, now it would only do 8 allocations, reducing
memory fragmentation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- add part_info_get_cached API
- only use cache when called from part_info_get_cached
- Link to v1: https://lore.kernel.org/all/20250327-u-boot-efi-part-cache-v1-1-be6b69c0698b@linaro.org

---
Neil Armstrong (3):
      part: add part_get_info_cached() API
      part: efi: add GPT PTE cache used with part_get_info_cached() API
      block: use part_get_info_cached() API when scanning partitions

 disk/part.c                |  55 +++++++++++++++++-----
 disk/part_efi.c            | 114 ++++++++++++++++++++++++++++++++++++++-------
 drivers/block/blk-uclass.c |   7 ++-
 include/part.h             |  44 +++++++++++++++++
 4 files changed, 189 insertions(+), 31 deletions(-)
---
base-commit: 5ca70325b64f760bf4190f206a0e88dda495e3d2
change-id: 20250408-topic-gpt-cache-11f770f42f1e

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

