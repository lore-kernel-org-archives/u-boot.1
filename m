Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A426C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 18:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8F583AD1;
	Wed,  6 Aug 2025 20:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="MjnWN56u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D0978439F; Wed,  6 Aug 2025 20:15:08 +0200 (CEST)
Received: from mail-io1-xd64.google.com (mail-io1-xd64.google.com
 [IPv6:2607:f8b0:4864:20::d64])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A156080C83
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 20:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-io1-xd64.google.com with SMTP id
 ca18e2360f4ac-88350d4008fso1493639f.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1754504102; x=1755108902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4kK/uOZE3u2RPArwblhtpt7KznQMX0nNRKDXS9W4o6s=;
 b=MjnWN56uTIzmEVw4GZKyrjMmvGZlxU3zB66ha2jf+Kf0d68j/q5Cl8A8/LDSqjIXPc
 ieMnKeMqdgxlNMAAHIML7puO9zjeDdRE5PWwVD5MWhuHYOFBaGR+Vk9FqIHGaaWv0mx6
 GtBoMBvWm5z0+BRXeustv6kXk0S/IPDTP13b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754504102; x=1755108902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4kK/uOZE3u2RPArwblhtpt7KznQMX0nNRKDXS9W4o6s=;
 b=N0k3C/5oERJoy+5GXEWHCy5W1udZmo5+bwtr+vrura2eUYf7JNXBOikyBzSUokCeDn
 tm8dVbx3dnLv7JMM7r1gvu91R9/QLcnMo4cdMe7mH2hunaskmsOfjKScUcjc5kcPnv9v
 SxjDsrzNzK7vZ7Ca7DsBVGV2j5gnVmeAD0eNRMsIsTxQLNDEhSxmNxxXeBTe9ayyi309
 DvRqT2AahXUxVjWgCW5NLkFZqZLzNpFMRFUf2d2zJC/VQSMCEo9tkTtrB2IDabBNbTWl
 tbVQadbxICAgpLxTO2hjBMyhY7C2TnTFG8ZMIRgCrb4Tlyev3if+pYDSvoO2il+VcejF
 qMWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx2r3zLUr4k5uM+7bsZXSyTZ3owXcKv4SXUVv4yx1f3d14kuIP15YbvCIh94oaOHrdk6sLmh4=@lists.denx.de
X-Gm-Message-State: AOJu0YzpnAPYBdFWdRhh7MSdNKugxLETFqhBtX5+Or8Wdh3mN+imwYz7
 GiMEbsexV/ycUvMqkOGy46dGEU7wqHQkM24QWp+fkMMwKOHBApvWVLlC3Yw5hcl0NcwL5DIIz+h
 z0O0xaSh+2tN+DEjYUePA4e7bK8UTRO4WOQ==
X-Gm-Gg: ASbGncsht5gEjaZVDBpLCnp26/GKZROmSpSnTHvt6TnmU6m758eXByESYZhh+qMuqRO
 0Dikkn9E2OIlhDXflXk7zvYqdCcvL+fI6UMd4JDylGjjFCuskcqWXyQWP0if0IzmCbI+XRxslGu
 Zsev/VKxED0M0xJeFR0IphXCpDufXPBhr5azzEPmFOz7plK5ktkdikyigXmeSl5Y3IdvRfP+eD5
 jAefoht1w+hC/Y472+Kud9c/cVD7JJa9KgOCWLbhpkRqKWh/79Q3vUoieVowX6jxPA731zBJncg
 9JrWbKgBHlluYWFnaRH7UsipC2jC8aBHAzYuShw8WG5h3zOBhHgw6XZwYibTgye3nvywBll7ZMS
 8KXUmM/TVCi27pQ==
X-Google-Smtp-Source: AGHT+IG4wx9hNK5fUzT7M6DaHSdUxahA+l7H4Sv2+fW3Ka/EilSgBD10UnZ/AtPONW0VNXYgc00Aihw7biEf
X-Received: by 2002:a05:6602:14cc:b0:87c:516c:2a66 with SMTP id
 ca18e2360f4ac-8819f149e5bmr179490139f.3.1754504101989; 
 Wed, 06 Aug 2025 11:15:01 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-50a7e17fbfasm434156173.50.2025.08.06.11.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 11:15:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: dregan@broadcom.com, dregan@mail.com,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 0/4] cmd: nand: various updates
Date: Wed,  6 Aug 2025 11:13:59 -0700
Message-ID: <20250806181450.2324488-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Aug 2025 20:44:29 +0200
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

Bug fix of name changed OOB placement option
Change ambiguous 'count' to 'pages' for read/write raw
nand dump display update to show ASCII characters and data offset
  into NAND
Add option to nand dump with ECC corrected data

david regan (4):
  cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
  cmd: nand: more descriptive help info
  cmd: nand: nand dump display update
  cmd: nand: nand dump with ecc option

 cmd/nand.c | 56 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

-- 
2.43.5

