Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB5BFF60D8
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 07:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73BE384010;
	Tue, 31 Mar 2026 09:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UaPlz4f9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E59F83DBF; Tue, 31 Mar 2026 09:53:52 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E49283F0A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483487335c2so56801315e9.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774943629; x=1775548429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ncf5CGqxvO5twq8XmgDTVmMycW8ixnJNHA/TGHwyw7Q=;
 b=UaPlz4f93d/zD9LU9IUoQK6B5gv6WMoZPJ3MfnOOH5VBF3RUSA9gxmCfWVbuO7P9iH
 r0d0+ZGnA5f5l1ryEoLOpb8Rls4UyhMnFRIIg7+kPjVu9xDJgu6x70mOiFJ5jv672tbG
 zQoGtj+bWofploP0wbuPzuVHLB7wgDYvG/4wNRkgav72ufyIJeWxEeEhD7W0/erLsvcO
 SgR3AN5Ozm0jSHbaWEE9faAFxuZVmJM5+daQpVQ/u0HD8tPHTbF+We/zmXgJEq14UuBl
 1hSnfgT0l5xgFwByrxJwttV0e/+4r2g8S+dq/gxC3U3jk2OJWUOfPOPYAcQcn0X2JXB5
 3yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774943629; x=1775548429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ncf5CGqxvO5twq8XmgDTVmMycW8ixnJNHA/TGHwyw7Q=;
 b=MCOTyBR+WK1HnvIy/giFwN4BYrcFIG5S81sh4FPzPV0OXAB1Yo/9ggCY39v3PBjGfy
 HDnibFrAeKMj+2VTRBesFHN2gPC2NNo6HI4LvGMfb4TKqfuRaabP4peyd/DVn/bvL7hT
 5Z6ExHowISMrOQhtgkd2W2kl3D0ofmTnmf7x2XZsUw5kcZj+M4JhbjYCSytGfo4YXO+E
 RaXbj0Fpcs72rErj5PUjX3BsOiqNrmQNfB7MsdMOg+3iYcexbkg0MWXYQx8J/htiKaok
 yn4BqsE69CLOsQP6IaUeUGS5hLultD6C2oIQkAmNKgtckjeFerNE70OqPJqwiFWxPlik
 9b+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXB9ye0gCk0RS7d3miTvRf4Q2w1/g1TYIe5VIlcBXI+xV9HHVt743cFNRP/wTHCqXzuzEyXLE=@lists.denx.de
X-Gm-Message-State: AOJu0YyxdoKNO2x6nXZA/wwhx6X8Eut4UOCbviw3FSRxX7b5xe09hkS+
 Yg1RqNKmGNjSYNhK6vSESjRKud9pHb0ciMn4wIuVd9aiMmfjE+fguiLk
X-Gm-Gg: ATEYQzyipcYFqM/6nRVmeSXvzzqtiUhJBxZCPO+ao0fqtiCk97VUhIwsEfUNf4kiuWE
 y5gD+/U/CcLkaf5Z3N9OVQ5J9rleHLw/yp1+WiiyAf7osWY35I5WInplMN0uV2HGtpCfGZHAJyG
 qEsb+VDN4PIii9fVfJasFdHFrI4aov2oNMHJ3F+AYJXHeZxD0lY0HYyIwg+ipTl473zy6iu6DcZ
 eRsdxmH85mJz15zI41/Nt5s2AyvJEtndY+Ugh81IZMqNp26fyuMpdpNUxqK7I41csaveieTo12O
 7nWg0ANNeW18hWuhvRw3w/7LU+PB1rQiksysm3jwPTpG4yWkN3pbIt2lWnnUjJbOBSAcO67Y8+d
 q5qYDTb59EvCuGEz6KbkckUPw0atU3a6E3YGdB91/Hwt3JkDEg8IY4xawOcwEhh88nP2kGSn+FJ
 stEoDsDNJPswXwn0VJEy2pFlOkZyrkZwY4AGQpGHwdxEtOynl/rBfo0lE=
X-Received: by 2002:a05:600c:8b66:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-487280b2f9fmr269291885e9.29.1774943629336; 
 Tue, 31 Mar 2026 00:53:49 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4887c561750sm23889915e9.2.2026.03.31.00.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 00:53:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 1/5] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Tue, 31 Mar 2026 09:53:20 +0200
Message-ID: <20260331075338.2391-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331075338.2391-1-ansuelsmth@gmail.com>
References: <20260331075338.2391-1-ansuelsmth@gmail.com>
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

