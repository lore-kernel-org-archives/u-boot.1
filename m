Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104A6C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFC7A40B4F;
	Fri,  4 Sep 2026 07:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ZdPYALWW_W7; Fri,  4 Sep 2026 07:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A300740B52
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505975;
	b=TJnUjhDkWQZ03MlQomxL3N2Y8aQXW3X/8fwvEir1HWu9yvzgVz/pdBli3M6/bin9rN7h
	 /fgT8jltuiAmPRzE1tAeU+LCBEMv/T3yYhuzk2s+S9AXhwJ//6f3fi5suqynuuqrn0G2t
	 yfkBASIGeHB5nEJFJtdQMiM4EtDOua3sgBciYhULPbatBY+cthHvpv4qbf0c5zlk6Gdsl
	 6GpQ4KZhGVMi5ykipTjkmAT2XGobbphiVpfTjhoaYvajGGJD1EThFj3Hkje1w0IiTn80n
	 3wJaxB4pYSBY5PKFjb71XstCAFNKDXmAcGUbNwUmbx7qvsldQHd+k3p4zj7B1EaRCFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MEhsdW9L9mqwGe67ZlKupJQZmGQj0ZfKrw13SDsMw1Q=;
	b=c3f3HK5aOBib3PF0/jgV4sQv6UJn/05lvXdy7/S89RaEfKoPuY0n90/iIWSZzMoxJy2g
	 FStS9UNpYthWrEWc37PcX5zxPqTg1Kr0dQFQCVW76QAvg8DbhZoyfbuL2p0h+N1tawsF6
	 /TDxA8xzo1x+sEqZH6wmgA9TEwhs3+zFcKnGyL19pZizx35l2XwOLNfHHCwroi2mpQBjd
	 uIRes33sAQ8q3w1Lo9ZhukisUVkstppquilR9W1FMMNyoXutTwG6nLuz0LuvB0Heqb6WF
	 cAcHjcGs5MD6TU2p0Z+atsm/ZCyT4dWJtqH3sQ3vllzyq69/iYIDv7J9j3Wbha1lAAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788505975;
	bh=MEhsdW9L9mqwGe67ZlKupJQZmGQj0ZfKrw13SDsMw1Q=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X98mJtSvpFAvykOWPI69Mv4AJMahodn99fnL4Fa8T1OB+7scwVWDhVOU6ww7lQboh
	 NeYi+ICiW66lx8QTZAtI07aGKBk06myGNjT04NbeqV0B6lsneeIXcny8oiC1yH7ZDG
	 3IZbncf/HVixNhe73hswgFr7oduNQxmNvIh5G17RnNGmsTe4cjpL9cm8zOWeLf7MLB
	 4ZQjIijmaGbD2OBZZsU2tN/ZxIi+lKzJVqgQkQS9on6EYoJE4rBrc3kEeT7Owbx9R2
	 AXaEx8maFEvbnosDSj4XPSQu+yIbsyH1scU0aoqMs3mEEJeK3ByR8uqv/9E5NMm+XH
	 QldBblVJOb5Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A300740B52;
	Fri,  4 Sep 2026 07:12:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8980B2C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEC2860BB3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-waUAwpQEsm for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 84FB060BB2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788505974;
 b=VJK+6ywUWyZf+0eHld4kMAL/u8tyLc7tHvJz+6GpboJuxw5GS/FOHv/X8NmfAge1K8n8
 yQ2vevRrHBPl21fykucYX3QwIwzDMdY0wqR+gh8JN2JcQUqApJCF6fHX0bTVkz4V1sKti
 NspmJKKXBGWRLAzqQtZRoZ5buTYvbKLJUonnDQD4yj+YDb55RMkfpzR+4V+HfQP146eAj
 kWDmClXiHdt7JcCH+715tt+ASDyeiFyZy3XdYLKtHoVAEJkhvmBc4PS/PnSqh0C5NRpfF
 9y33XwMXDbxmjBQxLKwH+voDsu0X7I2bmtqem1DpXbPLRxOH1fJg6VWmwlos10wAj3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505974;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=MEhsdW9L9mqwGe67ZlKupJQZmGQj0ZfKrw13SDsMw1Q=;
 b=Zx8zR52LqHJjGUkZ7MVTxIgrcQZvtKmA+cGdkyQUrDihzS1sYVf4IL63jmWaEJp847Wu
 qL8wW8zlEd5nOF6WbOHPXDC5RzvzXx6xCzWWozJXZv1sFXrJ4h7lDtz0xO+k4/1/beb49
 82C02FNlzUnLZAsSlGA1dg6q8qmgM/QymKzMR3wE/2WZ5xXdv6QUg3Fq7b0Yli/qv5oIT
 qtp+2PqOz2vAiMMIOA5eoCjniebrgSRFt9mLpTh7xZ9qLqUTK7cmflosgkxwdeGhn7H6z
 1HauQUetR25tq+/Oleo0zWnDVMnbUG8tYGd6QXyMF33bUus4ST8T4AQaF43fgUFk7FA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ZLIhfXOU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ZLIhfXOU
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84FB060BB2
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:12:53 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-484374f54d0so374778f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788505971; x=1789110771;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MEhsdW9L9mqwGe67ZlKupJQZmGQj0ZfKrw13SDsMw1Q=;
 b=ZLIhfXOUFi6qHv+fuoDpQDbJpQcwhSpot0MihVWM11d9f7FZqIrnpSoR/5G9VI++b+
 YRqMTwmvLSb/VcP9TvuAJ5xEjMjr4Y+r9I7QZebE4Lj47RQ5d2HyzmnuaGaBGrXvDuZ3
 hYLD7+/BSJT41tP7y0Ywc/k6ZU7l56YAJx3RtRV7t/kseG6t8/uZBNPZToTRONz7Mg1f
 atFZZzfEgMbDnCG2RO0wnPXHQGoSojxlntakWujlwFcVFhQpiWSo6/9vcOxyxeEKVvJr
 knEa0r/7yRt6HvjfpVCuaRbyrc5DL7XQhvmfDshJHWzGI2rWwqT71+5yEGmuD4ZImQNd
 w16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505971; x=1789110771;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MEhsdW9L9mqwGe67ZlKupJQZmGQj0ZfKrw13SDsMw1Q=;
 b=lCrlbsdf5sy2oN4/eh0SqRC73rBpmVyr9hR0et3SM/LRPpa83wpgIxhH7rKuPHcotc
 D2VOw/n9oEx6dQaMoMujL+P66MkFWJjOzlJLLnuYh82Ooexgqq9eR2YJsAS1cz971cu9
 dd7l5+E0jj43jp6+Ynbo1rJOZ4WkyQEoArZwyZryDMFF6ZviCrOxq6EBLxyKbsm9U98+
 Jrxxwj9XqYP5fOD1TNzYp+dLYBTmjQS4fDpi7pkbFqYPIZx04zYZXBJvUhsrz7VvK7Vl
 yhTTSrAMluar2xCpRkHI7Abje0PjyyL83ffw5J1gMANyGvxlkjyKhaB4xqi1KCBc0Kay
 ga7A==
X-Gm-Message-State: AFuF++n3y1glh61qHHD525027vdUelan8Q3mlLvXyPe/aHDHVy4M2Ll6
 h9fjhXrt4E95PSU+Q5Bzn7ekuZ8KzdQPXK9yRr5E448x767mYzeiGnYrLxJsI3nVRNw=
X-Gm-Gg: AYBFou3kq4HbMXfqzZJcBXeOHkLMqFkx1TxEQaHo0dtGEUDF5QmlmHVvJm3PhzB7SVX
 uvqAMWiG2sW1H7erECljd7ieIxykqT2M+z7x2uAhK5ZmSCYNnVFOrAkBgk51hTR0jSaS1MU+7yc
 oUiYo5B5iueAjv7i6cpfJOvr5l6As11vOT7DVgbtM6DEM0kx09B9vps9VS//KtzdkgHUbj2IIZp
 U67Nag1VRFkv+lImwS3Zy/eCOEthwU41WzrL1utzbIwNsjEyM66e8MkjnzsGh8H+iweBLjQaPO4
 BhjVF3c0Dqa6FZpQcPcqvuQy/chSdiaOZvGpkqQn2QPe7p3oDte9nckMlDGgvbeTNBXvJPvCePr
 ZnbZiY4iPc5I8AMo3oJOnQKyQslk33F4YaFHInz3UCLetCupUln80kycy+qVA/gVzHadvW2EhAj
 2dqUDcAIk2p0KqKRlT7mH2gLAaTOxlUfmy81h5cs9JkFMcDQfYT+kLelLJphZW62KAqqf6V39Ub
 Yq/NH3n7FKILG8Vai8QPVUtf8HC+QApe6JWIfeJT4q8r6IAZWk=
X-Received: by 2002:a05:6000:2999:10b0:482:ea08:8c97 with SMTP id
 ffacd0b85a97d-48587046b35mr5878735f8f.2.1788505971013; 
 Fri, 04 Sep 2026 00:12:51 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:12:50 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 00/10] spl: ufs: Add support for loading U-Boot from boot W-LU
Date: Fri, 04 Sep 2026 11:12:35 +0400
Message-Id: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQxFbQq0gXJk50RIxkTCuId
 ze1y7f4/wChyCTQFAdE+rBwWDL0owA3dstAyH02GGUqVasSkxeUdUYbwobfOaFWjgzpp/X6BTl
 bI3ne72X7/luSnchtvw+c5wVEgmkidAAAAA==
X-Change-ID: 20260903-ufs-spl-boot-wlu-10ce2e14bf15
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3375; i=alchark@flipper.net;
 h=from:subject:message-id; bh=0IvFRAMQCx597g5XJRQbV+X3yb9XWTzHoL9nCCFwnyw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNys+oPPmpPSl5Q3bom9NvRYKdprEmrljd//9YgIje1
 ZUTmedN7JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCq34Uz/NPZGdkwb0lVyLbruY136le0hjswfVmvM2X/8RerMhpMCo4x/GbLWaH
 ftnvrXKlblZu+evZp/XR4+/9yeWnn/J0a+otTG7gB
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

UFS devices have a built-in A/B boot mechanism implemented via the "boot
well known logical unit" (boot W-LU). This works by marking two of the
provisioned LUs with a flag in their unit configuration descriptor, and
setting the active boot LU in the whole device's attributes. The device
then exposes a special logical unit 0xb0 (the boot W-LU) which is
internally aliased to the currently active boot LU (if one is set). It
allows reading and writing directly through the 0xb0 LU, but doesn't
expose the LU geometry, so it is not quite a full-fledged block device.

Given that the normal use of this mechanism is for symmetric A/B boot,
real world scenarios will usually have both W-LU-A and W-LU-B provisioned
with identical geometry, so the geometry for the boot W-LU can be inferred
from the active boot LU, while its special 0xb0 LUN can still be used for
reads and writes to have the device itself abstract away the actual
request routing, even when the active boot LU is changed.

This series adds support for loading the U-Boot proper from the boot W-LU,
allowing to use the native A/B boot mechanism without the need to hardcode
the "real" LUN in the SPL configuration.

Two classes of prerequisites are handled by the first half of this series
before the enablement itself:
1. The SCSI core needs to learn to repeat inquiry requests when they
   return with a transitive non-zero status, such as the UNIT ATTENTION
   condition, which the W-LU returns when it's first talked to and which
   is not an error (patches 1-2)
2. The scan itself needs to learn to look beyond the normal LUN range when
   the implementation supports W-LUs, as they are numbered above 0x80, and
   "borrow" the geometry from the physical LU the W-LU is aliased to
   (patches 3-5)

Patches 6-10 are the enablement itself, split by logical parts.

CI passes all green:
https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1175

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (10):
      ufs: hand sense data to the SCSI layer
      scsi: repeat an INQUIRY that a unit attention interrupted
      scsi: size a well known unit from the unit it stands in for
      scsi: allow a controller to declare well known logical units
      scsi: add a lookup by target and LUN
      part: name the well known logical unit device type
      ufs: define the well known logical unit ids
      ufs: report the logical unit the boot W-LU presents
      ufs: expose the boot logical unit as a block device
      spl: ufs: allow loading U-Boot from the boot logical unit

 common/spl/Kconfig         | 30 +++++++++++++-
 common/spl/spl_ufs.c       | 18 +++++++--
 disk/part.c                |  3 ++
 drivers/scsi/scsi-uclass.c | 32 +++++++++++++++
 drivers/scsi/scsi.c        | 98 ++++++++++++++++++++++++++++++++++++++++------
 drivers/ufs/ufs-uclass.c   | 76 ++++++++++++++++++++++++++++++++++-
 drivers/ufs/ufs.h          | 28 +++++++++++++
 include/part.h             |  1 +
 include/scsi.h             | 45 +++++++++++++++++++++
 include/ufs.h              |  8 ++++
 10 files changed, 321 insertions(+), 18 deletions(-)
---
base-commit: 1c5004ffc5e3f000eca6cada32af7c83bd925c2b
change-id: 20260903-ufs-spl-boot-wlu-10ce2e14bf15

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

