Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDABACA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 20:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94AA581368;
	Fri,  2 Oct 2026 20:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BTDmZjmOaSIw; Fri,  2 Oct 2026 20:54:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 96B8A81365
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790974472;
	b=Uif+R9OUIqM10QzB5arD9+M6kdGF8STpjURyX2auIdOPfG9nfYZmh2+et0vgjQDbeaB3
	 JA+Lg+KPcfDFO4EKj+XNXsNcIDvEZtXuQpFIYFH5uqMzeCFvDrPnmdBsErBJMHBphKxKp
	 W9RKIRygLKPNBSS0oeZd6oihMD4aM3IzADZ4J4eIWLkmjA3fvyzUGQl1zcrgffgjPslCS
	 EQQ3fUNcyj4jB6ODs1OSqFFrGvvZtinJSu5vxM3YvH+UlF4rqpuoI1Sn0MS7GBHFgdJXw
	 Ms5+LJhSHKCyW8JClPJm7+TMv8jAeX4b9gEMh4wiWPtecZBzW8uaIXvpGpcORsxK8xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790974472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=T8OTI8YxFhbYMqYa6RsUbz+qrTeHLDvXfCm19GB8VFs=;
	b=r1NHSYsnwVY4sCPDfon75j9+xUQfeHkAJ4BjULdAw5T8lPVawOYS3a6oY9fbemfBxL0r
	 Ci72sac4cME14xeiPQJ5jXe3EYKkbiT1TVi8x0hOMWHbpG25PYK636GJKkampVp69tXPI
	 SGPqc544fEAT/6qBjGJPjQzuMT9M5oJ7VKfxvPcXdTFxM4ySQ37uav6LGdEDgVjWRqk5M
	 BfDPln0kGbZ4fpSMrd9bw+IUnFMNVEMaT/ULIZykQ0iRQmKMKt+uxHfPmuPQrhw6IKZE1
	 cahwu1ONJfxbIhefn4ZChBytOaXaw2FZF5xNc2m352l7yeJdzNkufyh8D0vP3jO74zg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790974472;
	bh=T8OTI8YxFhbYMqYa6RsUbz+qrTeHLDvXfCm19GB8VFs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OGJdm4dOsZFlzZcSvFpHsIsg6tvFwUV9/jdYT/JHOhtojdSy5YZTYASsYoYpwXi4Q
	 MnHO+pFGjdNeTuPJhH72tVTviAGPuu5rkDm9WIl6Ar6jfKozBODoOpx39/Ee9uuG0n
	 kc3YmFv7VkiXUHfMz/zG1Ljp2cM0l3NtpYjm+XpJm7OSns8Z4Np5zHsIM6JssEmvZT
	 pDZl+U+MyG7+Yx9ekm4OmdZQO9odnvPy1SMmDHiXgVnJI9ds37EzdpHgRlLiN2DruS
	 bJOzAlNisvPi1Iyx2utc1cBZcctank6D6hKqNphMsdvBwCBzC244bFYSLV+eOsDM99
	 ZhGd076fYUeIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96B8A81365;
	Fri,  2 Oct 2026 20:54:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D15A34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7244460D70
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:54:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zVC_mJ_wE_i8 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 20:54:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9306860D6B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790974465;
 b=cJ/ne9gN1ZuUdP4VXclk0oqikO3JOaxvekhlfaYiGg+15KbCOcsZ1FEGG0XPXiFzR75g
 iapw57wJF/urHKbnuiAr0YvuYcva7wOqtncCOv2zrAF86kk7R28JBHR8x8cxES2kB/L2g
 OgR0b4hq7IhgGfU9kbOIN/7XI2VK4mIFFgNUN0KECWJ7Kii8VbCvmlhKrXT/LdD0PPG2W
 xENvKPnxhwEu8TDTZEaLQWGYVPS6Dl41pIvvooZnjrozx/wwizwxE79uk3iuLOSLMpuVM
 VpsZQzlQ1XEyTKLdbDc5uEaDw73ZTEA871+jCtQZvq/D6mykxjw+MJI6y/IfzfC37PQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790974465;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=T8OTI8YxFhbYMqYa6RsUbz+qrTeHLDvXfCm19GB8VFs=;
 b=FTjPvowL6a0c6hDBcE0OKGnCrAJxLXSBTxJ/IHGcpv4YvzGHXrQ4VBwTwBIa4xmKb7yG
 vOLTioefvlXe89qGRmzh2H0sEzR8ZqMgwkDqIeGmshQbZp9hUtm+fRWjsVnGRoJMjKd/R
 FrB7i+UR2Kc8POW9W/6xqYt4h5ZUJkJLGL4FTct+TF1fKor1sMdcIsTMEzVa4luTn8BzX
 dFHG2/g+W+smp1F1oUJ0msYLSkAWcVKR+7ywd3w0eQIhbpXImZpQuXuMBTl4XIPLDXRyg
 toRn0i6E59wVq4qiNDE281lY5FhTzOTWJA2IC5nNre3PkBS82L4nC4nbm3h2AMXlHFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XQyL86Z9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XQyL86Z9
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9306860D6B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:54:25 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e50968489so416586d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790974464; x=1791579264;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T8OTI8YxFhbYMqYa6RsUbz+qrTeHLDvXfCm19GB8VFs=;
 b=XQyL86Z9lLml29IU2u6EUOHF2FD2KcQSLeLPs9EnWhCjTg6/w46Js0rbGO2xpOmUh7
 v3M+i0uqwicdhZW8fNsIsYzPdF9yjoURGpfKFDEC12Ri9/AtgGYCn64q0wVzpEhlxbqk
 DVMwGYOowstHFsa2VgEhZ6sWrg2z+Mz3LEa+z42GE3y2nYGXJvXdqcT1W/qO1+9lrsn3
 J3S8lQc39Sok1OesnB7twsaQA/Z6tUYk9LpUE8T1bmqdINg/5SYtDs97cm3ml6x6Lzad
 P2GiJtdyn+//BH0yKaXFS+AuxJtwPgljmlvFSeXH1aJPj0jvi/amEUFgUiAqFoKRPmp7
 m+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790974464; x=1791579264;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=T8OTI8YxFhbYMqYa6RsUbz+qrTeHLDvXfCm19GB8VFs=;
 b=eEh9nlUstDjMZkSsMu203QDMI2r9W28UfNcDE2PbicO9PNNH1p6YSSIeb6+C1LmYI0
 R2g6NWySXjBA2msYDdo36qxxrs8PvYrX5CDtT8szbKcadty99FDJfglnKbBZHkQ8AXbC
 a+G3SIY64/3FTLjGctnpX9jBHX+Cr9fGjmM4hdsjQmII9g/nmgfkYFboAqxBh1bQXfYG
 2qVps+TJnIHmA3Sn9MlBEmpC4zKPQymX3gSbSVs0OhcpK9uPYG2YvnXtVbm+Y+P/XKxa
 MZFhWcOh8d0acjkigrtqsJkNa0gtOKFHWngkk7zNMS9w5sru9TBaD1fUKz4i+SqDbviT
 bywA==
X-Gm-Message-State: AFq9FYJ/b8JlDBkkS1SVuYk9DMtM9Mr2aKfO++5woI9vFqSjzVodEWyp
 CL8zG4S4yMPZZq9v5OZKyjEWvhN/frDZeq0T3JW0P4/52VkFTcfMjtvvKMRLdQ==
X-Gm-Gg: AYBFou31vPP7e+kG/0MRnQm+cxaoeLeP5sY5phFijSgC/oG2HE/jlhs+SYDGHp56t0F
 iUWYkcgqSH7cnG6jUcNHmQpV80fi013up5xB6Z86nq60BCubncQBfiNUmna5/PAVTwSKgsQNupH
 MLNqtt6y7l7eGo7p9vqIlt7CFZWw1vb/6LBV6Ju08pfCUZKwkLCg28yhE3Xlppsq3Jvj7p5ZWwE
 2yBE7/e8hmH5GY8NGYuK/sttkAToM6/AipVhK3E009bEZsC2tjwgBfejjblMxbUNLcabRZE7Xyl
 G3cOO893nQc04fvnbS2LCm22IgSSJRly6Nc+N2HT0Nv3q/fXTSkphBinmRMODuqS77tVZ4EnUzQ
 M0/cPwy/s13RBCQiIhBqj/7/iNA4VlQkXiVDViHHAqbq/frMD14xpmKTADJf+rVrFB3nHlO70uY
 TfT40kX5lR5ml6eidfM1wb7ZDjdyHLN8Ed7ELqcwGF0T4GkfBbcIHOBWq3ntq+FDa1TqqzWNokc
 mhSZmik543C+m82gROhlMJBqFnPpBtu82a5eBPBYjrYNN/idVSRV2YZ1N5u7IQLm0O2KF4=
X-Received: by 2002:a05:690e:138c:b0:677:ac49:ebc4 with SMTP id
 956f58d0204a3-677ac49ed8bmr2053431d50.67.1790974464131; 
 Fri, 02 Oct 2026 13:54:24 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-677ac571441sm1565313d50.10.2026.10.02.13.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:54:23 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 02 Oct 2026 13:54:05 -0700
Subject: [PATCH v2] arm: kirkwood: remove obsolete configs for Zyxel NSA325
 board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-nsa325_configs-v2-1-56dcaf092b29@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOwZwGoC/3WNQQ6CMBBFr0JmbQ0dqIor72GIgTIDY6Q1LRIN4
 e4Crl2+5P33J4gUhCKckwkCjRLFuwVwl4DtKteSkmZhwBQPaaFz5WKVoblZ71jaqIzhpkDM6Gg
 QltEzEMt7C17LH8dXfSc7rJXV6CQOPny2x1Gv3t/4qJVWTZ6eCs7Y1MyXtq/ksbe+h3Ke5y+Sr
 C8xvgAAAA==
X-Change-ID: 20260914-nsa325_configs-55fd9223e752
To: u-boot@lists.u-boot-project.org
Cc: Tony Dinh <mibodhi@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <stefan.roese@mailbox.org>
X-Mailer: b4 0.16.0
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

Zyxel NSA325 board has been updated to bootstd, remove obsolete configs.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---
Changes in v2:
- Fixed b4 quirk with Signed-off-by
- No functional change
- Link to v1: https://patch.msgid.link/20260914-nsa325_configs-v1-1-d4089f3f5bff@gmail.com
---
 configs/nsa325_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/nsa325_defconfig b/configs/nsa325_defconfig
index b496fb2797e..47a5179e71b 100644
--- a/configs/nsa325_defconfig
+++ b/configs/nsa325_defconfig
@@ -19,8 +19,6 @@ CONFIG_IDENT_STRING="\nZyXEL NSA325 2-Bay Power Media Server"
 CONFIG_PCI=y
 CONFIG_LTO=y
 CONFIG_BOOTSTD_FULL=y
-CONFIG_BOOTSTD_BOOTCOMMAND=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_BOOTDELAY=10

---
base-commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
change-id: 20260914-nsa325_configs-55fd9223e752

Best regards,
--  
Tony Dinh <mibodhi@gmail.com>

