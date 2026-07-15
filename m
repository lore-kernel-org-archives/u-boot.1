Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574AAC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC4F84CE9;
	Wed, 15 Jul 2026 16:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="DACytU8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C840884CC9; Wed, 15 Jul 2026 16:30:38 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F6C84BB4
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15c7d22070so724153966b.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784125836; x=1784730636; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NXoQCV8wV+DNoTsEBCQyTed23qXIIyy3V4aWmw7c/LM=;
 b=DACytU8jxc2nrDc3I5qgo37vd5YYXsanEvjc/SE3wenZ2GjU0/q8oai9jAJaGQI7yA
 PNUz0vaq4RNbc2y4vVlVE8cBiQb9HPKec0X7IMf2/LN5wvTkQYx1hPYCu/tBFEEzBvSP
 Js3Bqh+JP5S4v51XNAZxiEitvQjN9oTHARrJs6Oc41g9Wi4xqJGkZzNycAYPnGrkQQh8
 co66Z8AoArLofb3SGegr0lHtmyqMBJ9lOlQjVhSaLADUCYchE2jjsRG71dxISsDtOAoJ
 IsOrXvjvf4tzMvHjCrwm9ta9ZDwmlqIBC8KZPSTXAruK1b3OvzkVGuPMfmmSWEBNkwuf
 bi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125836; x=1784730636;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NXoQCV8wV+DNoTsEBCQyTed23qXIIyy3V4aWmw7c/LM=;
 b=GnmmVeshhJKcHlxrmstBP+9UGUddHtmTs/wOMpGK1ko7H20q47fhlodLFsHXiLU9UJ
 yq0HbmCCBvhT+r/0Zye31YkrwanUnyqlSqsa2FjTROhFIcVVY/wEnF1rKBDao1eMttZ2
 MGh/LTHSzSNwkoJ+hgnCgFFjA9D4A5jrlCWmAaLD9lbBVMszjq8/QZe3hNXqJsMtSech
 0DyCA6WONv92cvA7Ys1YJLs+reyqaNUFLqV8WKsytPyP4IJVSic2C/xM2rZOfroBcWCI
 DTDiaINM7R5NsMa3ZbFghT7QyUvpu1o41Rho5iWG7qx+o7EmVtvLFcG6sN7vBlMBFvc6
 gsrA==
X-Gm-Message-State: AOJu0YzM6TO1FiahylY2TEd2sMxlt/GIowv4dxVte+1JURAnTnxnEnxF
 Kd799tgoO3O0MRUxsB0La9HSLTDpdeUMBhqye9gvCt+BPqYY3ub9OJuZIuahKStQeFk=
X-Gm-Gg: AfdE7cmVdjiVZfpo0D+q0dq9aw1vg6MMH3stlX9KKGi3iEh5kylQmUd6eOqKz8U8jfJ
 egZxbheUNbdzaLiy4JtqGaegyPoQuGjMv7MuK3XCqAYVyhv0ZJn+0yDHhtIa+V0Tic/T5ZGeMdF
 X4dmT4e1MJqbE72R5jqpdZNoVhhvxeMUs9ssQos4fX/HxprAWFRdWzTEdQsFGTP84AipxjDeLB3
 7Nww9TNtktjUVika1hRDTlIyS4jkWjd8JPHPtir2zwEdkDo4JV/40o47T56DsZYuvZBFraIaFWZ
 C9UydF9Qth0+GyZSgayx6rPOR5Qb2nv38W4bhYJAu8pQeiEMAQEW6MHlPO4ECklulA9zehor/Fp
 ZP8C8694rzddXuu0+rFQVCPDKBY3jq5s1a/157YEhVZWb4MhwLodtzoMC8vvgzwjRWrvyOYjxz6
 EIKUO28aAQIhgwSRWg42KAnYkMhHFQGjcyF7l5dNXA1cuEJY0Q72s8AG+hVYD3HNuMfvw=
X-Received: by 2002:a17:907:9704:b0:c16:579e:ae13 with SMTP id
 a640c23a62f3a-c1667a4d04emr399762566b.37.1784125836190; 
 Wed, 15 Jul 2026 07:30:36 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871262casm44827966b.6.2026.07.15.07.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:30:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Support qcom,rpm-proc with smd-edge child and qcom,smd-rpm
Date: Wed, 15 Jul 2026 16:30:31 +0200
Message-Id: <20260715-clk-stub-smd-v1-0-af9232571ef9@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0NT3eScbN3iktIk3eLcFF3T5KQkU4OkFEsDE0sloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAZvb1AHAAAAA=
X-Change-ID: 20260715-clk-stub-smd-5cbb50bd9049
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784125833; l=561;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=uHLXkuZTLlSX64pwmc9CBklUW+RKaSV+4nPS1dAJnCc=;
 b=VhOrPMcict0OwWMGfegPgFTG2OCRnlXvGU++3SzO4RCjHkndLIwpg0ifj08/lkwRLJP3LeIV1
 WNsTJ28ODcTBTA9K22EdD2fGANxcEk/w3xqude5jyJYjJ5Boi0IlZNR
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 16:34:36 +0200
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

Support older SoCs like msm8953 by adding the necessary support to the
clk-stub driver.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      clk/stub: Support qcom,rpm-proc with smd-edge child
      clk/stub: Add qcom,smd-rpm compatible

 drivers/clk/clk-stub.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)
---
base-commit: 501d76ca801343cce6dafb17740a8b679ed17072
change-id: 20260715-clk-stub-smd-5cbb50bd9049

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

