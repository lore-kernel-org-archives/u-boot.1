Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B91CC6B2D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 03:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 545BD608CD;
	Thu, 15 Oct 2026 03:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9QdKH6kXsMx; Thu, 15 Oct 2026 03:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5FDF46084C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792033702;
	b=S2MAIT4KH6X16TJp5sbNOaq9rF6F3QYwZx8Hl6l4j5Wlt2P+0/eNnPD7m0n9go7/3RHj
	 +pcrik7UGYOlSTiAsYhIDyeWOSrYSf58ctwBUtbGzTf2j8I/M4FoZ2TOczZMPWry9k9zO
	 ky5JQzDY2Q/NxyygtGJPqJ4z7PXRVUYMHY9Gvg6z0SNMpL0E7kS3g/eM8MBAhLvLvucYt
	 hyMzBoFyVj3NMG06siJeVr6Kh8Wk1nqmON26l398lzhYKO6ysqVY3i2obDOarTlhjBPyO
	 zHNce+JybB2B6tdJiSfRRTX+y34x0OWEFjbj0P4hAribXiHoM4KO/A5SDWHmZAJimqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792033702;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/P4F7FC8juVQhw1erlu1na9XTEezcPZmNqCroTqgbFo=;
	b=mxQsw35vNRsjPVN5rgGISuFcB4WO7ChKZfHomWwgxqytaEUlxa15TuZHII/sly7p2446
	 mZxo89du7BMK4VlLYv8nCM5JajHM4PEjq0hjSZx1OnDoPDzEZp6RqweEI6e9gjwFoQFCj
	 G5p0gzTBmKlLaxxWdd//XKt2j9WonvOfURP10GX2fObMl22ZZXheMdUbKp0heRNBSTNm9
	 iLhv3ssGnLSOOKxqM5y0/vCMjdi1rKX7V5zd8zRXEOsNj5MnhFRTxRfDUFLmvg0rECLCW
	 aXj9HBF1yYwioDqDzmL09QDIHKKzAOIlN6aiY8s2pCvw0Uim8W2tdh6bEZBuW8q9S/w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c8stgyfN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792033702;
	bh=/P4F7FC8juVQhw1erlu1na9XTEezcPZmNqCroTqgbFo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MjU38vcLR/jb/mFl1ImtDVJTx89kwXfissqhwAXUUeAYzBmI8zM34OHNAcYv078uH
	 ieJn01Xjt1/HoQH/kTU7plXdS3yr1lR8wZyhw4z2BwHz3tvJGJQr1YB9us2Dzv0xR3
	 Peo1IGqZAhXwnGvPUqyuQdq5hpucJkBmldaoEzxTq72wbDGPuQENqZdaL0wLl84ZjC
	 TfxwQSmbiSJgjLgdVeJddZTVb+aPZuMX4AZqFpUzUxTmA6MCtANeW4ZcJvpxOEvz4w
	 MuRyWctBJy13OoP8kUqF2yeYlqKRhNQ1J9GIbCiuuyAt/TjGxF9nmDzxhbIlA8qAvc
	 MJocfRZFMoFQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FDF46084C;
	Thu, 15 Oct 2026 03:08:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 480222E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DFCC6084C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iko9UA-RnVI8 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 03:08:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2BEDF60848
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792033700;
 b=lzvt3Gt/0RJ67L0o/4y6vp5PFQXuulSDYPm/32x29t14k0v1s3rOCvJQCrh1dTdrrewA
 Wm0t44UovQsMbQGXhXaOu46iejBKJ/nVrp0CoPJgiGsYguGyJsWyAgJb7N9Itvoef6yXy
 Vhy8gd3FvusU9JHbp4H1f7xwF6Vm7GnDdCX7Jjv0JOtegwKqY6ckZrWJL+w2K2/kg34Py
 0h+/5imzQfFt1B+mUp3N1+ZFn4uOUHCgRVbsNqZOx7KngcAJ125d80GQpOwuFLvZzkZYb
 5sZocEirWDzorjy9jwMoMZIJcR9bfyKNLGYYLFKV0ER14OIJC6Av/NJ1WIZxDZfG9rA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792033700;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=/P4F7FC8juVQhw1erlu1na9XTEezcPZmNqCroTqgbFo=;
 b=li6hBCRbRFNTq2pY4SRq9W9hHRQ1WfGQXvl6wHy7zdCxykKfraA7xljOLfi+sF7RmBCM
 UvbEwe5HDN01/gxfpV3N2wMKhU5i1JUZQQUoKMSZhwhfrehhKAM6/UVvtuMUYawSC6kHa
 VEa7kXL7i5+Aly0rV7U9WU/yzcJpmqsjBMY6wO0jBvogUJ1hZJuNWpbjS99br+PvcQYc0
 gDEmnAoChBIfeBRTzQhJwGp5YjRsR1DEq53dyLqe1M42z0wNre5J06dP0otqeyETAPlqu
 6fI+4fh3gw/sPp6zfOmvmn6TMDsl4fUQC1FroSq+A9Wcdyeviwh5z9grQVAFUtzVASA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=c8stgyfN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=semen.protsenko@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=c8stgyfN
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BEDF60848
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:08:19 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7fccba9c675so8248744a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792033698; x=1792638498;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/P4F7FC8juVQhw1erlu1na9XTEezcPZmNqCroTqgbFo=;
 b=c8stgyfNyuKxZJjkCSWRMUv3DoTTcXU5oELN3X3a9I1n+RDhGHYAoFwgcp6mpaWpZ1
 //CCxbHEv+TXdFAGzPCgJFmAb3pOqprscRGKuMvRlrHgx5NWuiferChku0HKAxpXw045
 4hmPF7Wa3kPBqgYHXZbOIbBfM2IQmNh0YaddcRmnQdVgRGqUTAqwsKCQqWbTOcTYPrca
 26JOpM2sORNqr3JcEMpDttyfvgd2HCqRLXdAnNhMIH+vU63F1lGFzc4Wifk09DwKi6DO
 9drgeG6cMcIBZS9a1BgIOJZKR+fv8Bl9PJbGSDuZ0SGDhoxYAH84DpH/XuEQK/+fYsU+
 Ck5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792033698; x=1792638498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/P4F7FC8juVQhw1erlu1na9XTEezcPZmNqCroTqgbFo=;
 b=hY7fiezqKpwgktccZRUU/QwL3MZ55lJU+RHyqd03M5nauZ+8tG/mU33c0uXeUS5HUF
 exMa6YIwp4gnKevhZIwGZaC1GvO8KVinV/Vq+LzYL5ARQ915ZbvHyUC4RljgLblGiKoG
 mdNZBbyfrWow1uDXlTifCHoFwZtezv1sCf+VrBQN9vsNil4b2SpSGPg5TUPJv4IX3xpI
 78VeFKiPlJy3jmGIfXoeICr7ifK+3O7HpIY/NPCiTRuf8NrVOd2gdaUvB9tEohDkRuAF
 oi1hdICFRrPwjVXFbTaVxSwcRnuERcRWn5xKSuPZsrNTcRIgrobMcMWgfRMX5cqyLbvB
 nCpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyOX1+qXeV+td5oP5otXdsBKXCpeG/3GfdTCd6HOMxjzqSOdTBLSxA9/tnWz1J+fe6BxGtm88=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJi6DsupknzgDB1FKgk/fdA9kiep/FaE2WktZB3eOLEbF78cv33
 KX/TRVm4rHsakw4pLyRn7qQ/6lH+wMdp2kulivRPAPx30LzoF2kYuoq/8X9wyB81gdY=
X-Gm-Gg: AYBFou1KB8+eFyp9nXVSOn959TV28ftD/AKtA1gxSXdTp6QwaDhMbFhhTIgMpqT5zx2
 jPivh9dpqPT7nv2gxRkfYYBmlrKMr9l8ARdTa1MYYiBG9grDhG1wMslvJdK43lKhCY5OdY7P8Wx
 UUNiUgrZpcebyTx0SEXGT1N8GZpXadw8OhY1ae1ipU2/hTeoVSy0j2964thjj6O6MxbTkAeN3Mx
 urQnoA2Ap34+bn1BmFz/tF56D39Nd/6eDv0zIg07z0VML652Gi+Tu/JMFrumwGosPoBouXe+Llb
 A7bIBjPt2zOngLN3rHb+R67m6Q+x7tB+Bd0tRNU2tORmIak8qudPIMLOLccU6BWAu4xL0Y22s2n
 RaC+TbvFUXpE39JKmP456YTkjRDUixC6WNHWMbHEOY3XqjsqYnmUHFAGuGFfOEb40EpigWKjmCo
 ni2O2L5LhFTwSyt6vsBeYuWWf4fb1Mvb8JBpS2akJl3g/bCvw9i+UEuuFQxe03qadbjPvAPFrqN
 h6xUUw=
X-Received: by 2002:a05:6808:e89:b0:4f6:710e:4813 with SMTP id
 5614622812f47-50b518dd86amr14139078b6e.7.1792033698464; 
 Wed, 14 Oct 2026 20:08:18 -0700 (PDT)
Received: from localhost ([2605:a601:1514:4f00:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 5614622812f47-50c1a325a38sm18912943b6e.12.2026.10.14.20.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:08:17 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH] sysreset: syscon: Get regmap from parent node
Date: Wed, 14 Oct 2026 22:08:15 -0500
Message-ID: <20261015030815.17896-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Follow Linux kernel example (see [1,2,3,4]) and deprecate 'regmap' field
in "syscon-reboot" and "syscon-poweroff" drivers. Instead take regmap
from the parent's node, which normally should be a syscon node.

The fact that 'regmap' field is deprecated is already documented in the
corresponding upstream bindings here:

    dts/upstream/Bindings/power/reset/syscon-poweroff.yaml
    dts/upstream/Bindings/power/reset/syscon-reboot.yaml

This also fixes 'unable to find regmap' error message when running
'reset' command on the E850-96 board, as the recently added 'poweroff'
node doesn't declare the deprecated 'regmap' property.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2140d68d69d45e4a74ec09ca381d2c8879165d2d
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3d80522237b71480109fc397975fe4146ed2550
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=716293381a0f9a400d0010628a9ba4354c2bea40
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92bbb93aaaefe14c01eac18df46f8260ee4c2825

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/sysreset/sysreset_syscon.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/sysreset/sysreset_syscon.c b/drivers/sysreset/sysreset_syscon.c
index 57144fa1e3bb..d853830d5ae4 100644
--- a/drivers/sysreset/sysreset_syscon.c
+++ b/drivers/sysreset/sysreset_syscon.c
@@ -47,8 +47,13 @@ static int syscon_reboot_probe(struct udevice *dev)
 
 	priv->regmap = syscon_regmap_lookup_by_phandle(dev, "regmap");
 	if (IS_ERR(priv->regmap)) {
-		pr_err("unable to find regmap\n");
-		return -ENODEV;
+		ofnode syscon_node = dev_ofnode(dev_get_parent(dev));
+
+		priv->regmap = syscon_node_to_regmap(syscon_node);
+		if (IS_ERR(priv->regmap)) {
+			pr_err("unable to find regmap\n");
+			return -ENODEV;
+		}
 	}
 
 	err = dev_read_u32(dev, "offset", &priv->offset);

base-commit: 65a7532545336e4b73e049a69436e255da7df961
prerequisite-patch-id: 7f17e13b8b63210378a74f089ee8fee9cb8dd587
-- 
2.47.3

