Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6222EE7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 04:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D0D801BE;
	Sat, 11 Jan 2025 05:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="m3sVFyXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33AF58036B; Sat, 11 Jan 2025 02:55:58 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00648801B0
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 02:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.lin@sifive.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21654fdd5daso43947745ad.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 17:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736560554; x=1737165354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pxl7/cZbOSZOVftBmT/2k4zGJnL0fqkUCn5UnJH07/A=;
 b=m3sVFyXTYXcMRHuw4+QeVuhSp5uv4Gp4BhNtKc5NffIzJW8UP54dcZfLUnp7728Quz
 7QOrPVBC0zzdMj1+a+Vtq11rUcqBx9zBGu8rbvi2JB8Z9oSjUGDVQLuG0DT7BShbqImW
 2X41dMFlPCAJfqLZCSps+wYEcfCPDkrYpH+UDDQaLq1G3Xzc00DQzT1hJPE64kqXfGHu
 yo1Z7RLSw1Injvn1zRVXpp3oNfgNbxy+pflxBdY7elQk7TvssgHyT8ZdXpHOMdgBtu4K
 pIv1gYm+hm38YcgDurtXdpxtHJImefdteJIxsgX7udXSD10uA2w4MaccMmH8b92vWfhc
 D0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736560554; x=1737165354;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxl7/cZbOSZOVftBmT/2k4zGJnL0fqkUCn5UnJH07/A=;
 b=XkeluFox8z41qMNpxII0XRFWuxQH4H1+8RrFFREPNsmA8xCUajT3f3RdmD2UAk7Ty2
 3OGJUT1eiTQV6WoRf5CnT1/JrhdJSgIbvZ7PHIcyR+/cN+CxQ1N/kWo/dYhiRpC+AQcG
 gzD1DKFonB/En7CRoACjolCiWokyNN9bN1kZ8B2E5k80gF1zN9FPSWDnMrhTxvrk52o+
 9wU5bFOq19347er97Njef334yBUdJE77NpZ/Zyo0eJ0PNb30MBzM7/07el/LGQM3xNns
 E5oZQntRo6HAjlP/LA5y+8Woh9B7GEVHvOBGAiHqHktd3C/1w+CprC12Uw+BhAN+oqGm
 d4Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY3IoyJPtN9zZk5X/SavYdLUyFBOZ3ttMxaCh18f94toEx+0JcIBKz6B0WuPR9WmptqPK5cmA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/50dtRUUkVcOrSgJLUROlIE5Pu00Fak5j8XYfmiV1i4HjDrse
 2Z0RYKYxXfLLpHA46rAA8GdTq8BgxroCqGkDlTnE91lGJoxCpNmtRlEtTb4DNY95xV7KCBi2owG
 0yvaxUCUF
X-Gm-Gg: ASbGncs118w7EUpNEbKY16QA/7o2zaFKXGNZjiV3C9HzhqLOk6q1WH7w12IRaJtyh+v
 /o/M9jWxs2ttK8bSUQSPikDxJyymDCSe/J/NleV+B6SWz/gpkZNm6u8EkfPj7w8xojnufXJ0Rwo
 CVby1jntmqvhMDpGQODKSnW8mciWLd27Mc/Cw/T+0oxWkA30sy3ckX3di+jPgz669Qw+IxJ1lOr
 JQM8QNxiBHq2HjyuLnCfjdCLZqWv8m5nr7u6fs2Jpc6uSmOJhp/8FDWl25wOJt8bOSQyqgDeWT2
 lhn9e+NDyGty3wvAhAFXUTvPz8BVD3YFfirqcq1BlZQ7ph7OV/YOdmxKUjwCwfA=
X-Google-Smtp-Source: AGHT+IFMaHBzWwwH8qg0a/PM3+m7ChfKNHbZvpLYHTtZe9UyTbRrCh93O03aX3Cv1ojHiPWQYwYHrg==
X-Received: by 2002:a17:903:2308:b0:216:779a:d5f3 with SMTP id
 d9443c01a7336-21a83f546c3mr212771025ad.14.1736560554392; 
 Fri, 10 Jan 2025 17:55:54 -0800 (PST)
Received: from peterlin-1873.internal.sifive.com
 (111-254-79-27.dynamic-ip.hinet.net. [111.254.79.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10e0c4sm18901555ad.24.2025.01.10.17.55.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 17:55:54 -0800 (PST)
From: Yu-Chien Peter Lin <peter.lin@sifive.com>
To: ycliang@andestech.com, trini@konsulko.com, xypron.glpk@gmx.de,
 seashell11234455@gmail.com, dan.carpenter@linaro.org,
 mchitale@ventanamicro.com, ben.dooks@codethink.co.uk, u-boot@lists.denx.de
Cc: Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [RFC PATCH 0/2] Integrate OP-TEE into the RISC-V boot flow
Date: Sat, 11 Jan 2025 09:55:25 +0800
Message-Id: <20250111015527.35528-1-peter.lin@sifive.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Jan 2025 05:43:13 +0100
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

This patch series adds support for integrating OP-TEE OS into
the RISC-V boot flow. It allows specifying the load address
of the OP-TEE binary and updates binman to include the OP-TEE
OS image. 

Yu-Chien Peter Lin (2):
  riscv: Add CONFIG_SPL_OPTEE_LOAD_ADDR
  riscv: dts: binman.dtsi: Include OP-TEE OS image

 arch/riscv/Kconfig         |  6 ++++++
 arch/riscv/dts/binman.dtsi | 26 ++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.39.3

