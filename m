Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2A5C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ACC480762;
	Wed, 15 Jan 2025 14:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R02xeK/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42AA8806EB; Wed, 15 Jan 2025 11:33:16 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47972800C2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1301975566b.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736937194; x=1737541994; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ALUmAbTwoTOR+zoE/2+KTsGsUydfs3IgFVjCGlwqBnc=;
 b=R02xeK/nM3Epp89wZhSYhic6huDBWGHKjM8kRB373IYQvKO3ngKL2VxkPHLD+6/i8E
 RYnO0Dred9zMTNAycoCVHP0Xhk8ZwiW0jwG0pxFQVmSknnbag9wuVdqOpLg3tXgmkqOV
 dKDS+QKO+oWL85yDQShr8RbHwrYSywIVGGz5CIP8qHUOPUWExUX0/aBkuE8+UXdkLuLS
 NpusyUpALQOR9mrX2BT34rlqRDY/Mg+dXr4PRmNPNBey6uD7MtTmYfIDABApJbu1kfWz
 P8kMBcVaPLzkGfR6gV5O1J0vQXKhjqR1UyER8ihFfaRj/g8dQKjvs5TSdIXvcDl4L1et
 H2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736937194; x=1737541994;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALUmAbTwoTOR+zoE/2+KTsGsUydfs3IgFVjCGlwqBnc=;
 b=XEW1ouiOnleMhyT/5/K+jTmfAYtfqy1KM98Ux6P+F3knVboJlf8ZcoioKOkcZ/IywJ
 sRudNSdZYjGges2FtERBvJMiOeW9t0kgYw5lOoT2YJXYajnSwFh80spJkwg+Wf/O9fa1
 XUCNmv8UuvjnaX33lu0P3NUqCILJ9wyjUyVlc+o3eoGarK/MQwPxsW7LcpBae4ldHVN8
 KOIFRFUV1rNzUiH+El0YJy3HbBTpDC5PsEneTvyYe8SYioAquOiC5Wdl1zIBCBXLjviE
 zSi5NnvIKiaD7eNt1A8OLMucgcgiCvQJAxYoG0AkkBv2+xm38lg8aCCxtUOBauq8frI1
 LxJg==
X-Gm-Message-State: AOJu0YxICwC9pdng4aIT3J9N6t44eM72pjVFyEJKzUqX/MfgBBZvT41i
 e9LUss+FBOXP00/+jLy+DhGaCZ6TFtNJEkYmpF+fIlePTiTuIYUqyT8WQYBuaeU=
X-Gm-Gg: ASbGncszQpbuchvjKoPr5pyhVRoTuK+SwbBeLixw7SmNPB1epUmH+pcJdbfPVvs6trQ
 VFIhwKlK2uBTkSAhtzKGzx0LAoe0I3KkURL9sL+0DLPzHnUmWYwXViZ2TfOcNIQS4X3jX+2Q8YP
 FsNGlzy3O5G0Az3yUvyBnzfS0V9dpdqhOMUxMXeZVtG+mOK1oa7TiYdKoJzBbg0TWC5GrOnucYd
 VvCxa144h/m4T2s5ilDtgJ3V4Pu0+74cXRThuMNYJBe1mvEtxy9yMwSvwRIeT4dR3AkcSc=
X-Google-Smtp-Source: AGHT+IHe61Ope1sohWjbYRvF9REZqrd+iefqWumKb0aDONeB1h9dHFtJY6vB0H35WD1nkB8DIoq1rw==
X-Received: by 2002:a17:906:7314:b0:aae:8841:2bba with SMTP id
 a640c23a62f3a-ab2ab6a40e9mr2574345866b.22.1736937191262; 
 Wed, 15 Jan 2025 02:33:11 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af24bsm742045166b.134.2025.01.15.02.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 02:33:10 -0800 (PST)
From: Christopher Obbard <christopher.obbard@linaro.org>
Subject: [PATCH 0/2] Update my email address
Date: Wed, 15 Jan 2025 10:32:57 +0000
Message-Id: <20250115-wip-obbardc-update-email-v1-0-0b4cd69c91fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANmOh2cC/x3MQQqDMBBA0avIrB0wqZrWq0gXEzPqQKsh0VYI3
 t3g8i3+TxA5CEfoigSBfxJlXTJUWcAw0zIxissGXemmUqrBv3hcraXgBty9o42RvyQftOZZG0P
 aPV4t5NwHHuW41/37PC9OSfMQagAAAA==
X-Change-ID: 20250115-wip-obbardc-update-email-b78477a2d396
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=640;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=K/vgDYxqHLBAzbDgRLgxQ9FVh/7c7SkagyQz7osGayE=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBnh47mdt25whYxMSvQ4nZXFf2g9rjujMmlusuDK
 NNMMM7ZYTiJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCZ4eO5gAKCRBjTcTwaHBG
 +BHsEACeeMLOa4k7VgXrHY0ne7AP+MlJSXiB3xpQAZ1/7N1jigpcF+IrQUJLd3Vo2mfjwlNK4PJ
 Tre1okFOHL/KpeeUgLrMLllW9pLZIFOTHp5Q7SBFTH32t9IjBTrpjUB/2DZsYJ3RmQ3nRStBavV
 jgQin0Fh8TFfsN5cHNf+d+E2SbeTlY3pkUt+QmhXsrn2bnFNIvGUsO8Qcf+v5khhbJGGeBgyvXi
 9moFlFJw4tvnBYU9cSf4DuT0bIPC+T9cxVHklflOWh/a7J6TLzsvIsEWAUI53V97XEGRzjrNDwx
 g4xIw4735CUo0A/RUUHMrWmwZCwqd4X8R87I/d5esss5hkQMdMBbf2rsaPdDnTmXZjEjSqQGBgQ
 dhBkM0LVR8fn/hMhxfzvWCYoYBXN4qk1KU0klqOtHa3EDv2Ts1/CjERYCzd4Xgfyjl0GjqCKzQh
 sHHLCQxrfHJfSVRdwYEwtVhdyMSQ+TTiaGtf4GxgryLaB++Rckhc79XlA7jEYOqy0RVsWX9RaM4
 eRsyRqUXQY7cIYGreLymgnAm34aSHly1te/47rUkSGgtJ8MTVLpeJDpHQKbVyMNN6tAFA3qVYhJ
 xDfkKsaSBfg5owtCX+tkBvFz29TmGUBn8JOeY3vg0/HFDCqtrv2XCJuCvFTwTN28JoJuIB3Cq5c
 grftqwvzUVm8QUw==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Mailman-Approved-At: Wed, 15 Jan 2025 14:37:07 +0100
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

Update my email address for various locations in the U-Boot project.
This will (hopefully) stop any mails from going to /dev/null.

---
Christopher Obbard (2):
      .mailmap: update email address for Christopher Obbard
      board: rockpi4-rk3399: update email address for Christopher Obbard

 .mailmap                               | 1 +
 board/radxa/rockpi4-rk3399/MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 4eb937058ffd9d413929f566246eb684efe8eab5
change-id: 20250115-wip-obbardc-update-email-b78477a2d396

Best regards,
-- 
Christopher Obbard <christopher.obbard@linaro.org>

