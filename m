Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61883C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F02B828F8;
	Tue,  6 May 2025 18:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S+35Ln0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1DA78210D; Tue,  6 May 2025 18:10:20 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A6CA820F6
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso6235525e9.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746547814; x=1747152614; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fKlXVlCpdS4zU4d5kGur5+0G98FjLU9O5r1xLBLWaCo=;
 b=S+35Ln0gmKz3FZMJwjxaAG/Bd3elnDJ2lyHQa3yZfLS9pyR/2TuVpQCi6lV3q4WxK4
 Z41p03F2VTBGtqe0ry8Ejfftc1H18RhlVRypP+gbQkxoHEodYk9xXDDcbL9QDGbFY2V0
 PXO8DSo+HoDZSf1wTdcj15FL8hh15RbKRb7Kh/g2Pv/5VXhlTbtM7P3zkJxN9jfQS18F
 kS+uf+IpbXZHZ21GDcY8fEzxbsg3uydjvBe6L1zM15nmpF2xZaye2UvbyTk9D+hGbHhz
 /Ui3P7hST9ZxwNqnT6fvSVl2XZDaNajDNFs6RWY3UnGyHJ5AxSV6JysoYq2/gttB0quJ
 LEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746547814; x=1747152614;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKlXVlCpdS4zU4d5kGur5+0G98FjLU9O5r1xLBLWaCo=;
 b=Ou5oN/VAuqCi2mZ/O8eN8KNVTmIXnCGeR+5F0UH6Uim6qVieSiznT/Fut+vBdHXYh/
 aw8jUjEU7/q0IVzQrSulp8ptMv9Qn0RjyluL1kJ3CB9H6+r0cQGRIYvo3EK+bgCvhzfG
 2muDJX5xy+E7BynRzOfAmekoD/Bry8UMvpoOfIvOz2IERcWeHevHwbHXls5OITch2d6M
 7PIcSs+2ASwM+JLeWdd8uRXG7Bq1wtpHmu7VoGDd7N1RcIzto3XK3kUFFBk/6hbCeILz
 TS2C11p+tO2BjoB9/lpDt5BVKTfS3Rm/Qxu/XEgmj9ltzM8xwwa1plclPfSu6KQd2Rz0
 FDIA==
X-Gm-Message-State: AOJu0YzR5J/El55NBfr8WheLCgr1objg+zxv+KEYivRKAWZvNPPa4N8v
 w0rp1whg7YR5SC9g5wRiu6cAxh0tREirqCAZwfF75U8x2dL8OxyXLh+NtOyGe0mt0VL58dCkFgr
 P
X-Gm-Gg: ASbGncuHZSxpD1yTUHS3J+766ZdEZUZ19+CKKn7PFNXTeyrtmDYoc8j6G5kv0H0nS/S
 xONUtRZmbqOOPODn/4mfWPUXommo+/NyuUmvLoMhrWyk0RSXvu2CVNH9ZplINtiVYZAHNKgncG9
 5djWkuOnDxfJRFvKnqiAWM9PT4nrO2C279KkVavwQonxexmXw6/LX/MloJ110JMfklRwpnlNmwl
 1K6tWXPm5yFU9Vbu48imaUwfqxod0ahdcsa7HISbRzKwH8SKxHP72vNOg/f40+/wauUm3e8dLFR
 NQ5GPFMZz0wx1kCIZ3QbvYpvQQhTA1sPaaRuaAaMA7VcFcZobm6WWA8twFTP5w==
X-Google-Smtp-Source: AGHT+IFMxyIIbmsVWlSlWA5JM0gxL4n9eG9+gvFkj1iOC41pxJrIcM6KFLP13qDEDUjtArIqCBbzyA==
X-Received: by 2002:a05:6000:1883:b0:3a0:88e1:5e18 with SMTP id
 ffacd0b85a97d-3a0b4a0506dmr45438f8f.1.1746547813844; 
 Tue, 06 May 2025 09:10:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b0dffaa1sm2103960f8f.31.2025.05.06.09.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:10:12 -0700 (PDT)
From: neil.armstrong@linaro.org
Subject: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
Date: Tue, 06 May 2025 18:10:06 +0200
Message-Id: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF40GmgC/22NwQ6CMBBEf8Xs2TVlLSiePPkBxpvhAKWFjYQlb
 UM0hH+3IR49vpnMmwWC9WwDXHYLeDtzYBkTHPc7MH09dha5TQykKFdanTHKxAZdHWIjErEZXmh
 ym2nT5iWRhjScvHX83qRPuN8eUKWw5xDFf7ajmbbq5yz/OWdChaY4FY6yVmfaXQceay8H8R1U6
 7p+After0+6AAAA
X-Change-ID: 20250408-topic-fastboot-blk-c5e14cd59224
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KLK76K8YFdV3RfinJ23LsM+vFOE+DLKODTKB4dtLlAM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoGjRiZ3Ad1nvTxtw+46h84D4qsygk9Nb3qXfWbR5S
 xYtT0AOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaBo0YgAKCRB33NvayMhJ0U5qD/
 9IE0p+1zef3ZeG5uFcHZWJ5DgkwxlT1uEg8WXuDSbhQ/zJwCY/xkGrv/vUyebX2kteDfqKi6BWUwNd
 n9N5YnYpY6xXLCF8CV2bVkMMMatjAXaoju44IMYzGps5i0FZkTTKSScKp49GlmGBBEzxxijpKhqQyT
 zwQVxAI6LoMCqiZmtB70JLEnURPctSch3VqgcABpCBfMRlTbqGjYbne4chHxUkZxTtWnfoZJB7Db8G
 sKrcHk3wUn9h54QmZtVI/4/Faq7XF2awNcYtNL7SaGjrWOCx3sCZqb78HWWE72ZA0c9Nl1VLzGuZJE
 vRTRy9CaZrqYU73r9aT5AXwnrOVIsORAat0KgYbKSC6bH0pqU1IqXmfl8AGhR/FbLPYhqkLjGHrnRa
 TAhCor6EtcajjnbF0K7jEwES5o5PjDUJlwUUS9r+nX1mX5C4O+vZDDBJK9DHg1B5zwrX5Up5Kgay2e
 eO2uyEFQYSgTiu0O5Rr2z1IISzB4SlHGMmMh41c65va0MGLooXihxDs/i29JwlF/kx+g8T1bqWfd1u
 aEPYak1GbWkOHISNJhHJp96i048YcbX1yIW6Elg1I9Is2wDzrDDWntkCghEKAwskYoN+HHXcGdBoLA
 r6jrNgbsLM2HWRD9AuUpcrq7pDjUaA04Kf85pZXzPQO59QXcJnOWeoeD4/gg==
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

This serie permits using any block device as target
for fastboot by moving the generic block logic into
a common set of helpers and also use them as generic
backend.

The erase logic has been extended to support software
erase since only 2 block drivers exposes the erase
operation.

Tests are welcome to make sure this series doesn't
introduce any regressions on the emmc backend.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Move Kconfig/Makefile changes over the 2 patches
- Relicence to GPL2 with Dmitrii approval
- Move soft erase in a separate function
- Update help text of Kconfig BLOCK entries
- Add warning at init if MMC was selected with BLOCK backend
- Link to v2: https://lore.kernel.org/r/20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org

Changes in v2:
- Dropped applied virtio erase patch
- Reorganize patches, introducing helpers first, using them in mmc afterwards
- Added soft-erase logic
- Added move helpers to handle the partitions erase & flash from emmc
- Fixed const var on last patch
- Link to v1: https://lore.kernel.org/all/20240306185921.1854109-1-dimorinny@google.com/

---
Dmitrii Merkurev (3):
      fastboot: blk: introduce fastboot block flashing support
      fastboot: blk: switch emmc to use the block helpers
      fastboot: integrate block flashing back-end

 drivers/fastboot/Kconfig      |  28 +++-
 drivers/fastboot/Makefile     |   4 +-
 drivers/fastboot/fb_block.c   | 323 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_command.c |   8 ++
 drivers/fastboot/fb_common.c  |  22 ++-
 drivers/fastboot/fb_getvar.c  |   8 +-
 drivers/fastboot/fb_mmc.c     | 210 ++-------------------------
 include/fb_block.h            | 105 ++++++++++++++
 8 files changed, 502 insertions(+), 206 deletions(-)
---
base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
change-id: 20250408-topic-fastboot-blk-c5e14cd59224

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

