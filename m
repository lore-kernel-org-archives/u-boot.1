Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01549C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E2182B3D;
	Tue,  3 Jun 2025 17:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jpyLCevQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8188482AFC; Tue,  3 Jun 2025 17:00:50 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 432C98091A
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4fdc27c4aso1916478f8f.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748962848; x=1749567648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZf1V44IzkbYOH3/wqkpxfMXAK8kX10gXlzj4UDd9AE=;
 b=jpyLCevQocfclOEwyFNs02J5zrIOTH00RGMN4Yrlw/zfOeSVIUYk6lKOpvtWugGVyB
 CfqV5eGsQeQehpsphzmWFP+vtlXQTAtavx+V4fzJi273/9dXL5OyQ2AfqD3uee5lF2Ti
 WOaBKHLkEjuDFYnmNshlmWB4YPmQv/rI75NzohQDfle/OdS8Wd9owh/keQnNeqj2vUG1
 atKL0F3QzwShqMIcbw+EUybH+BgQiqwfFWWivCxGLt8mSwHopeBM5Ok5YkSSxHZ9Vg2k
 pGra8Dhng1p00gcx3OYydGQeTy2BwadE9VxMJJ5yhKiHO7n55TtpbY/1oSwq9ZdvkLo+
 dipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962848; x=1749567648;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZf1V44IzkbYOH3/wqkpxfMXAK8kX10gXlzj4UDd9AE=;
 b=cUHmQ3C3rU5lyM7lp3kKsv2dGS0vKWNgHqCXut4goOWbTPnpOYreHYf631QDTSBmBr
 N/bKmJK92OsSeD/qfxXQJeQaKyW4lUHzLO8ORZU6J5GacQhpo/vtJaEA5zSkpcACjOvX
 mU2zOVwBmO7TTDLHjYpoRKcoNsqM/4pwoUEXKnteH8QNyhDaa3N1uC7sVHbhdCD1V3NB
 gFgboAjzZAuDgv2UEXZq8hAtvbDSDCbtgZOEGKHBspyjOKy2tbSTIrbyi0AHzPOnG6rw
 cVt3bd9c0I5U9CtNPsnw23cB66yf6ko4Q6fEfc10GKOvpFot6kgYt5f0Ry5D/8+yUB7D
 6HXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm7DwZGuLvEddcrFjg4hpiAMGRcCLVb8yAcDaGdgRemOEefjh7JbsPb4hQaFuKB6ijHR7Uic8=@lists.denx.de
X-Gm-Message-State: AOJu0YwiHJhsh4fd/MPZJ2WsBEEbSqtjtI+feZ4JXCxKMzh7rprB4s3k
 WY2IvYAOU+PNqrj0TKcrBHon1baYJ4GIzsIgcZYWgK4hlVO35j9hEyFLfM6VduZlkxaRy1yisLZ
 i9a73
X-Gm-Gg: ASbGncsSnrW2gOTJNSVUAs/PciZ6gIKR50R/UVzYHfAJ9gTsiU1U7bbwTTmTTdyIsuY
 DmXCbZU86IQnw52afKNgN5669Tki75wpviXLmsSmhSaLLr2t+U5HJy9ifrD6xxZ7gFG9Fb7nxBF
 esCNzsrQxOw8Tf9Sh7Km3/fL/glsmRjEkXX+oniH98SWHQ84kaBSJ/CkyXteqUqB2nhKeyMB8D5
 phgnZTyDH5HO5TM6H1OG5zDJAkOJ+Ge0mCvhVF4N8gKSjPCXxqH6AEGB513axl/a8fsCDGx1ihL
 eklFOCC6vbRdDqFKIDtjHzGZFhwKsiOT0D+cBEPfweDK2iw/HjyRa3lKwkRuAAwCNBKW6+pEd71
 x8edbgoVldaU=
X-Google-Smtp-Source: AGHT+IHwomGusfr7kL1BPBw+m/cbxNLYmOj5Mesb4r9mKW9+hE+L0eEU9AIc2//v5oUs4+lGdqBFYg==
X-Received: by 2002:a5d:64e7:0:b0:3a1:fed3:7108 with SMTP id
 ffacd0b85a97d-3a4f89e2c02mr13105604f8f.40.1748962847524; 
 Tue, 03 Jun 2025 08:00:47 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e5496282sm19845165e9.1.2025.06.03.08.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:00:46 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com, 
 loic.minier@oss.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20250505124333.12344-1-sumit.garg@kernel.org>
References: <20250505124333.12344-1-sumit.garg@kernel.org>
Subject: Re: [PATCH v2] mach-snapdragon: Update fdtfile logic to work for
 RB1 and RB2
Message-Id: <174896284621.1020546.12888859517240124285.b4-ty@linaro.org>
Date: Tue, 03 Jun 2025 17:00:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Mon, 05 May 2025 18:13:33 +0530, Sumit Garg wrote:
> RB1 and RB2 have three root compatibles where the last one can't be used
> to decode fdtfile name (qcm* vs qrb*). So rather just rely on the first
> compatible to retrieve the SoC name.
> 
> 

Applied, thanks!

[1/1] mach-snapdragon: Update fdtfile logic to work for RB1 and RB2
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/14315b73a8e7

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

