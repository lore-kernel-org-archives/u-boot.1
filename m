Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BC7EA3C4E
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A44E84181;
	Thu,  9 Apr 2026 15:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nuJ9uQx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD098416F; Thu,  9 Apr 2026 15:33:22 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A4F4840D8
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48374014a77so12226655e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775741600; x=1776346400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ncf5CGqxvO5twq8XmgDTVmMycW8ixnJNHA/TGHwyw7Q=;
 b=nuJ9uQx7T7uaKjGC1xe9t9SmVWodqezP1yYMmi1BiMUq42QFVCROFD+/dVEyYISocC
 Bn9kpsM0L7mg/V70ipevS1lrb+9YYpAgtyxM81RHPaeJzga3P986IB0WlxdL+o3uNCrU
 V03WrSI/9oUHQGQe1NhRdY1OM5KxXb78xC5klwYTDvcyOgaO28PKx6N/m4p0YUoDmXyG
 Xh6YGqJeGAblCaTt3EOniSK71G/cM6GH2cUFFCUsLvmEXzxgMl/a1pwZ9iN+CB4fooOW
 gBrsOd9VoDV8kkQdI/626yi6OUrlDWTi6wJxvzi6mznRfSeMuNoDUvn5wlcolDOALM/i
 UPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775741600; x=1776346400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ncf5CGqxvO5twq8XmgDTVmMycW8ixnJNHA/TGHwyw7Q=;
 b=MK0xcCNifL87O3eMzCsLnEw3njfL/juotEwEN97J+45ZYl6RKmtXxQnA8MPHEmw9f0
 ph4D6LJSyS1f1nPcJxSzNVvl/jfwMbGMOGYGYp3v5PtCMBX9uyVlAh1vltRVdYBNroyu
 dAO+bOzPg+M+T9/D+4hgEBJZql6A4w8kbohtfZ9Sps40TAW2q3cwhe2jVoEpFEiQp1E6
 lSE67JmyotAmBOYi5wY5VvpsFVSwXt6VXBAOITW2cx/bxXTh8y9W1kSFZi4/p52nPw29
 sSv0IQqIDPaTqWM/OK7jyvW9PUjeDG1H0UGUeEoHjaZ5Fr5hUT5P+SpWJIljY1v2VoG2
 8F4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfRNMZcCMi7OlQcZas4F2SKS6u4uDVwC+cD32C3iW2xOZljob/1aPFMCj7v2aEHQJ68cM0fA4=@lists.denx.de
X-Gm-Message-State: AOJu0YzOK2V0fWupBZFkuvRt0ZcKI5MjibXzHpnQccTvabloTozr+sHM
 k6okhwSzvzOxbhXFqABuf7yDbQu/nw1ROhD6hO0Ho9QYKKPytMaDerBA
X-Gm-Gg: AeBDieuQIDuMZ9v9fn+n8RPhJTsRZ7R1HqML8QrSLV6ZM8qRE/WXg4SrpAKNPf9dbuT
 pyBP7SqcIyRxuNjT5bw3LwCZSTD0MeODFnJAA3mplMkcCBOAnopeu0RB/R4SxaTS5eurVNjnxip
 EhdOj34py8DHXfUgkQurNTRrKV/2346nai/9MotUeMcFI5Q+3CSjHp3Mrv97oQ5q9sM3yoy0hrf
 jRIqe5l9RhkNJO4LMWfVMvLcPOflUMSfRJzWXuVx75tzMdRYBRSajslc8c1Vnl0blPXlhzknfRR
 MwqZa+TeaBDI1pMxrcDukgM3fgDBbceu5uXri3P1IxOz785KuEqSD0YuNLWxV5gdSZeaVhEZu4+
 TFqvuraa5JKt9mmeP1RQighgkzpYvtTIoCCAxibB90Rd/nzKEEwQ88i9N3x8QhHN+ABYSs8e6w+
 fWPTFWS1Ay3FN4Un/wVzmJG4taQ1CHEavbQCI3ep6o4qV7yO8yv5h5JY0o+SSrG9yM0JA1dmU=
X-Received: by 2002:a05:600c:42c4:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488a82fbd86mr163806475e9.26.1775741599851; 
 Thu, 09 Apr 2026 06:33:19 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-61-192-155.retail.telecomitalia.it.
 [82.61.192.155]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-488ccf9b919sm52876215e9.0.2026.04.09.06.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:33:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v6 1/6] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Thu,  9 Apr 2026 15:32:57 +0200
Message-ID: <20260409133303.31875-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133303.31875-1-ansuelsmth@gmail.com>
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
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

When dev_get_priv errors out, the ubifs is not umounted (if used).

Correctly handle this handle condition and while at it also return -EINVAL
instead of -ENOMEM as a better error since no memory is allocated but is
actually an invalid scenario for fw_get_filesystem_firmware().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/fs_loader.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 6af4c7f15e7b..cd4695b08eea 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -175,8 +175,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 
 	struct firmware *firmwarep = dev_get_priv(dev);
 
-	if (!firmwarep)
-		return -ENOMEM;
+	if (!firmwarep) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
 			firmwarep->offset, firmwarep->size, &actread);
-- 
2.53.0

