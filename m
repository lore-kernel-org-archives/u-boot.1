Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D982C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7440188524;
	Tue, 18 Jun 2024 09:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NOpIwEhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07DC288516; Tue, 18 Jun 2024 09:55:34 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE36988476
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-36087277246so2079693f8f.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718697331; x=1719302131; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ifSUqzbxUY6x/Pi88EcP6Nsq/YXt+oMGhK+7nGodMcA=;
 b=NOpIwEhzK0EAMQjlIkmXQQBGZy2rD5+wjL0YrmtSSBt6EzWMIw3JSVIis+rU2ZtZyP
 fTq0R193geosg72ybHqji6CnbmYeVg6S2ksKLAwWL8VRTRPkrs+eaCZI9BsvbvnMc/2S
 pT6junxf+wUKmXd+9zu3mkH6RePAVhFTE4Hn/e6tVfIQujpyySaktpfFQpquecpdMJIc
 S+M4rTccWeQwHRuV9ISYpxF9w3im0Fpxx9HZv8T3Uf4dKkpInfrRs+fHFNScWt6tg4p2
 UrxfKYrtCXgOZW3pxQ+rAbCaqdz6MO2IvdBH27p0EJMixpa5HXzKk6O57NoVdxgQYn/C
 hw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718697331; x=1719302131;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ifSUqzbxUY6x/Pi88EcP6Nsq/YXt+oMGhK+7nGodMcA=;
 b=iwdzBFOrIMsvxlg4zqWjKj+FVXo4OCa7e2V6wsTWg7qWI9nhD1tBZj6HSZPJWuqPjP
 dOU8q8AUAlGesEGpqNhiUrJkqNjxlrrX5WUH1OGnglxsuc6przPEtvg7kydM+ImFVMO1
 gO5ezKM2CNzD6sXRuBsNUco4SukQ/+2LU3GUzndUUuq+GjBgc1JbUKnEnEbnuPaoQ+gy
 lfYW7DO2vCbruf0yr9vazqQyJas4vh6jhUE1+dgrH7QN4x4B6dBikN2cAf2eMmwOodkL
 lN+DTsi90yaAn7uNlt8foHEtNN5HM/hikAXFc4L1iU9IoQl5iWAnaVCFrwNNwp0hmZYL
 MPsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFo6kBsff/ho/BXWy/Pgdlo9cP5lU8WkpbceB+HU4VixRVksVqlLJfTkF9eM/Pi2QUeB8Gxj6StyvFpFtlcU+CC307UA==
X-Gm-Message-State: AOJu0YwYJDfASD3qICLCCU9pTQyRN/DtGiBtUN9cKTU3vwmgwsStsz+O
 uYkk1OLC6kVtTGjY6Bi0tZYmcDNqNDWEnEMmdUPnVFd5bfX+OeuctCCKsziVN0M=
X-Google-Smtp-Source: AGHT+IF06XO8x5fofPm2HSzRdoTISK3600S8uKZ4YqWDr3JQRAVFHslhY/EbIMbmVanlzSLRsvEHaA==
X-Received: by 2002:a05:6000:1243:b0:362:2e9b:f113 with SMTP id
 ffacd0b85a97d-3622e9bf2a8mr799578f8f.21.1718697330992; 
 Tue, 18 Jun 2024 00:55:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:55:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/5] usb: meson: switch to set_mode callback and other cleanup
Date: Tue, 18 Jun 2024 09:55:24 +0200
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGw9cWYC/x3MQQqDMBAF0KvIrP1gUlu0VxEXmow6YI1ktCji3
 Ru6fJt3kXIUVnpnF0X+ikpYEkyekZu6ZWSITyZb2LJ4mQo7+hA27NpjPGas0wnlDZ/gGe5R18Y
 9B+M7S2lYIw9y/Pemve8fE8cIIm0AAAA=
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=COa0uKveM80+HUFmQ0U8IK1ivU0skAfYMWOcBdLjo3M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1vrzzMSFDUQtjw1e+m0SgU/WBeHuIzkUyYiPHW
 BykgGWaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9bwAKCRB33NvayMhJ0T2CD/
 9ERyYsoMP85p6DIvCypMC9n79hUQ5oAeNx0w/acaQw0f/MkNjRoibq5Fzq0NLCAu3eZE17TlOHUO9X
 Bg5ZqWVnwFp8P1DdgC5XUx6q44a31w+kURyvXWBeQccH1VXkWkLEpoPt14oJnUhixro3RWukwZE2mE
 glvdKFtZ8y38u6lUyIWocODgheDIhGV+4/Iwz69wMBI4pVticLKwTAiDzMyQjtqP3tmVjRjgMkQqvl
 1p1GsOPIbzORp0TA+VTC8dwkGEDz7sHRCYBgjfBhJukrM+2gjw6f7PJSv9FslJi3J+KtXeX75Zd+9/
 Ut6EDx99nVPxK2/GsqOIQbLQDds3n614QZn7c2+KkwFd/Sdpf1SU+66I0jmaJFegigWP+zJpXsal/j
 7BL1cHIDUeojQbGvBdVaYJgulNqW9yZVuUdNPKHwFbHc1F+aStfGf63y5lTvQCFHy55cEoXMQlaYYK
 elo4GM7iIyqveDxS+A54t4Jx/GfKYZKw48LB0J6JOe+vK+W9RrV7aaapWpR1igbpcc6oGGgDuFNcru
 ARz0KreLvRQPDhItoM1dYRm+/P+Jek42ybXIhWMVAKXxA1PbudPSc2SOCL6masOQ9l9eO9vvOrYx6e
 3h/Qw1QksQ31VY1ElWxHGuZ3mpoTsAtKp8RG8LHrdn0+ceoW/uq+tB9i3S7A==
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

Switch to set_mode callback now it's available and in the same
time make public functions static and drop useless mach-meson
headers that are no more needed.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (5):
      phy: meson-gxl-usb2: add set_mode callback
      usb: dwc3: meson-gxl: switch to generic_phy_set_mode
      phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
      usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
      usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static

 arch/arm/include/asm/arch-meson/usb-gx.h | 17 -----------------
 arch/arm/include/asm/arch-meson/usb.h    | 12 ------------
 drivers/phy/meson-gxl-usb2.c             | 30 ++++++++++++++++++------------
 drivers/usb/dwc3/dwc3-meson-g12a.c       |  2 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c        | 18 ++++++++++--------
 5 files changed, 29 insertions(+), 50 deletions(-)
---
base-commit: f1de28e67aa9b66bfca0fad3dc18446a6ec0b504
change-id: 20240618-u-boot-usb-gxl-phy-set-mode-c3991c5f1da2

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

