Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DC2C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 14:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1E4C60BB9;
	Fri, 24 Jul 2026 14:02:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lveYbGOk_d-b; Fri, 24 Jul 2026 14:02:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC23860BB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784901740;
	bh=GGoFdWVcKU6TtdkumP/90q9JkBGMIuh3WJlvgYilo34=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kvOhrse3P4W+sSsPpgnAsMZk+1byVBH70mgE6c0C+qWqjiLbcuwqgug6B3fqEbsfQ
	 RVBYtejCO34wt+0j35kU+47Ht4CdPB3GoL6XTK6AgOAH8lu5j+ED2CyXsONRETIf0/
	 KCzU7az4VHNHtzXw/boTR9DeFtlwa+dDuf0wbShjjWXLuqUd1xClBaxG2J1Rg9Himi
	 zkO14wla+lNP8iiNg04lCiUoL8ltH0oGvh8rsSt7iHqCdMbNa2XGWENiQno49AwMAg
	 CAIkKRQj8PdU2fl7iWeE3Yxmx702m3r2a8YgLzUYx+jFg+4TyAedY3I6PQzAfAX4YZ
	 J2Zv11eM+EsGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC23860BB8;
	Fri, 24 Jul 2026 14:02:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3E8AA47
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA33E402E7
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TH_qQgMbueHe for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 10:34:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5E48840074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E48840074
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E48840074
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:34:28 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so453663a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784889266; x=1785494066;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GGoFdWVcKU6TtdkumP/90q9JkBGMIuh3WJlvgYilo34=;
 b=gq+zHbksayMBbA+kZ0jzD8OLcKVyAGZ9HBNVD6SxsiPCCzk1GUuRko+lg+USfuac2h
 /kOXaUns5OPjvUMrrIWMcy9VljMUOuJ3tPQmSH/4S78upDgmjv3ortgSW6SkWjOYKhTK
 0WVIwMTJcY9Pl/1LYcgwvl/l/BSw1AIBfiyW3n/hJJ5Js4FjOSXYfziF1cf0LLKAnciv
 GE47/q36EpZEHTBT2+kbzkQAni5TIiFSs/s/+Fqi1WYFdKwsixw2whEenI9qv3UwDMhf
 qbpntFvHrVXLK9yAWA9Kdqw8VVPwxoZ4xhaT3bn7xogzyI+09R+KPqjsYaqd9g3MhJOa
 /9Vg==
X-Gm-Message-State: AOJu0YyAES5xkZfjDtaTuXHnppqzf7kjlQD6ECKR8iZJBRMY1VLgy5uO
 rOSqzc/uKcpJlVsHA4UFM2ybhmnZSpHV2ZciPoHjP2aPgcy0vNryqh8S9+ikBwGNoNT2PoR3m4F
 SSh6rdHc=
X-Gm-Gg: AR+sD12V7XdznSX+aVe9QSAURqfBTaTjPupHDIa7JA48s3v/j8V8mDuaPMwVZ1x0rZB
 fgsG206hw+xjNne3qfToREOSp5AuOFGqDgNWvzGLTP7UGY2mjOiykFA34XokCfqssl8xdWfMgIC
 O3omnCVmbt6GDxwKRgbgrf4+k+ZlGzN8kPOZ3iIp8YWtkpKVqPxi9b40n4D+utiLOjntqoJd+19
 lBebxxbfRZUE7A+Vb9LYX+jaun4mfAexPw6uBp+6gfF/zpvOdDUKzrPIRk25kkYJ7u5Qjz2auDn
 yK19QXeOBPWGG/1VmI0tOlXRA26GENgGNJegasQKAL8jP/IreUNi+iZknYtRMnPHk8a+a6jhvY4
 hIdIzlPuz9Zr8rvx7+1k27u83YLOvGY3sCjIFtsHej3J/q09fC3IKGdaLcHEnWs3Xv3DI1yoa1P
 WCy9t9IKOw0Si9lUHwXnm6WP6wbGVxJWgpOvBBVsFsnB0le1xxYUlFgum7uGks2hXj2SU=
X-Received: by 2002:a05:6402:241f:b0:69e:9b48:f3ea with SMTP id
 4fb4d7f45d1cf-69f6bf04a6bmr2932541a12.15.1784889265705; 
 Fri, 24 Jul 2026 03:34:25 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed0011f41ca2fcfee2bf.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:11f4:1ca2:fcfe:e2bf])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f345b1decsm2957563a12.4.2026.07.24.03.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:34:25 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v2 0/2] tpm: bounds-check device-reported response lengths
Date: Fri, 24 Jul 2026 12:34:13 +0200
Message-Id: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKU/Y2oC/3WNQQ6CMBBFr0Jm7ZDSIiSuvIdh0dapVCM000JsC
 HcXcO3yJe+/v0Ak9hThUizANPvox2EDeSrA9np4EPr7xiCFbEQrFabwxsTTYJEpBmyaWiujjau
 sg20UmJz/HMFb9+M4mSfZtFd2o/cxjZyPx7navb/xuUKBrdTnWlslXO2uJidinUs7ltMLunVdv
 4b2ZX7CAAAA
X-Change-ID: 20260723-tpm-trunc-resp-664a3babf1cf
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Che-Liang Chiou <clchiou@chromium.org>, 
 Dirk Eibach <dirk.eibach@gdsys.cc>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 24 Jul 2026 14:02:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784889266; x=1785494066;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GGoFdWVcKU6TtdkumP/90q9JkBGMIuh3WJlvgYilo34=;
 b=z+w91CR64gvh+WkrcyUwjw1JBG6HjALQ/oKFJL3hgZDxjLZxcwMcB8wmolZ6HF/Qf4
 DZKII3JsjN6RhyICHVr+CIfJKx5qBgqHBLr/tDpDQTvFs+O+TbNlT3iBwHct06E9+tNt
 8dXbXMRnqT9PRYtOs+8h35+9AW3fyT2A9Y9wBTwXgHGJBoqnSloakB9f95JGPwUEBwJT
 7CSFcjeChVKSGO6LDf5jFiDkj4ar84+mrJ32Xv3R9MTY0vd3Q8QXyhW21hNF6O3udgo+
 /yfuGUFYGrh8x7rFLWgYKapcC/bg35HsL8DHLP6XUw2jjT7Nxf0G/cjszTRz93zasAQY
 Abng==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=z+w91CR6
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A TPM reply's length is taken from the device and only upper-capped, then
several callers use it unchecked: the TPM1 OIAP helpers and the TPM2
GetCapability parser subtract a fixed header length from it, so a reply too
short underflows the subtraction into a huge memcpy; the GetCapability
parser then copies that many bytes into the caller's buffer, so a reply
longer than the buffer overruns it. Because a TPM sits on a physically
accessible bus, a cheap bus interposer (the kind used to sniff
disk-encryption keys) can inject such a reply, and on the TPM2 path this
parsing runs during measured boot, which is exactly the physical attacker
that measured boot is meant to resist.

Patch 1 bounds the reported length against the header and, for a properties
query, the caller's buffer. Patch 2 adds regression tests driving the TPM2
parser with a truncated and an over-long reply through the sandbox emulator.

Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v2:
- Use my real name in the From and Signed-off-by (Miquel Raynal)

---
Shahriyar Jalayeri (2):
      tpm: bounds-check the device-controlled response length
      test: tpm: check malformed capability responses are rejected

 drivers/tpm/tpm2_tis_sandbox.c | 27 +++++++++++++++++++++++++++
 include/tpm-v2.h               | 10 ++++++++++
 lib/tpm-v1.c                   |  6 ++++++
 lib/tpm-v2.c                   |  8 ++++++++
 test/dm/tpm.c                  | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260723-tpm-trunc-resp-664a3babf1cf

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

