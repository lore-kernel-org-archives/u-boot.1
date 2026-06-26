Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BA1CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 03:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D3F8496E;
	Fri, 26 Jun 2026 05:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="crcVVwjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCE184974; Fri, 26 Jun 2026 05:46:53 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E668B8495E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 05:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c7ee3952ebso7036615ad.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782445609; x=1783050409; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ryPftU96rHZ3Vcxpg55xyV670lIemcWvLjMO6qZue48=;
 b=crcVVwjIRCoi74I8DfB0GKHj+muE8S36tA3WtT7B5qHXDZDBccC+rNZ/P5IZZsat84
 Ft4RPW3s4oWAUQGhwOpy+G3efAi8/uxKYtZYeZWcoh5HP8Dgb77tXqByqML2ut/A+iTf
 DQMDJY0rhQkTfXatEqo9uJVMa+qC6b+WOHpRaSfRE7elM8vVlezsNh9inqXtoTIWRYpd
 QvTOhk89MwJZrrgYI3OUvh66AiwMBlDQUje6KTZmktNromxzBp3NuIrIdHnVS2/zVL/z
 wwXRqe1ebqmV0nRPxfQUxaddMJlF8cdcBH5V7Z+R9ZR2spg4OanKY8eP28W/DDC+4sU+
 k1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782445609; x=1783050409;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ryPftU96rHZ3Vcxpg55xyV670lIemcWvLjMO6qZue48=;
 b=SmcvxcDJj0zBfN1XeYw/EW+Pll43fgHuIiypS2xCsDs880schUs7s3SaD81EbJCUhd
 OJRrOawF5Si9RamfAGpyP2VRrGrqh9K+JTTMm3DUHX39i/vWW/Lfia+qFgHMXqG757kJ
 Y/EMO+5u5zIsfev+1LHkmzeR1rFs6K7CIXfP0ZoXk4SiHM0GRJT2Qn64S4YveN9wr2Rx
 zHpP2DGu1NZ2RE5Nnscq1TVWQ632MciV2W8C3Fscy9yIbieKRIAOnH97ko+mMG2dAx0G
 8+e7df34L3VRPRSRAz/mJNfLDO1zgTK95FWr3UnbUO/FosEXv7Kin155WRrst34KeqOH
 oZPA==
X-Gm-Message-State: AOJu0YxSl9yPQb+fkRYJqe/t+XNw9CzvNSoGX2Du5mVfAIs/tLctx+d3
 ele3KYNeBNM8cq17TbGgENIzVY2GWzrc0zKjh3FFhO3wwuQejRZkzpzR5/cLBGbf
X-Gm-Gg: AfdE7ckpIA5GgP+zk+ruVXGLiY1ItAQ8Af8ciJRS0wBSgMvj5NT7Hj0QaJd5LvmN4Br
 reLAkXiejdR2sm5bBT6Rqx9//TWpsh5Fn8m7BUIq9Ftmdx6V5+laJ7ae7ryeYE4WyoYbdUfMaU0
 KZmpKy1d6C/VKmh6MQJlxetxoDwzc0TKlkPyFtX1t2vgidRS2o2V3SlHeUE8C+PKr/2TPd5NsTg
 nc/A31h7h0MzwFWQ345eX5c9W3gd+/1ovFIpMuhNIq83H7fOwZtAw1rYSsNMoz9dAd/qf81hi/H
 pOnewa3b6Hg9YJuggAYlR4eVkknpz9/Rd+I2MwdyrA8J88ZoC+qq/r44ObdEC2RqZZvC6PgYca8
 KY54b8k9KP2SxZZuOV1r4QStnDb0EmhXmfq7mhGqf7J8enxtRMOSGPKy/rvVxu87+37WChSceKc
 4IOI0+4uWR19Zxcg==
X-Received: by 2002:a17:903:2ac4:b0:2c6:ad70:d870 with SMTP id
 d9443c01a7336-2c7fc6b9535mr55771015ad.13.1782445609279; 
 Thu, 25 Jun 2026 20:46:49 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f63b2bc8sm30480125ad.39.2026.06.25.20.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:46:48 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:16:46 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com, sjg@chromium.org
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: host: fix duplicate device_unbind and wrong error
 message in unbind
Message-ID: <pkrfunq5wqzbioom3k3xw7vsxmahlskafrcczcoefqviaygvbi@z5grmsndxzly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

do_host_unbind()'s error handler for device_unbind() prints the
misleading message "Cannot attach file" and then calls device_unbind()
a second time on the same device, both of which look like copy-paste
mistakes left over from neighbouring code.

Remove the duplicate device_unbind() call and report the correct
failure with the device name.

Fixes: 952018117ab ("dm: sandbox: Switch over to using the new host uclass")
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/host.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/cmd/host.c b/cmd/host.c
index e03576b4d2d..47a59f5ff20 100644
--- a/cmd/host.c
+++ b/cmd/host.c
@@ -132,10 +132,7 @@ static int do_host_unbind(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	ret = device_unbind(dev);
 	if (ret) {
-		printf("Cannot attach file\n");
-		ret = device_unbind(dev);
-		if (ret)
-			printf("Cannot unbind device '%s'\n", dev->name);
+		printf("Cannot unbind device '%s'\n", dev->name);
 		return CMD_RET_FAILURE;
 	}
 
-- 
2.43.0

