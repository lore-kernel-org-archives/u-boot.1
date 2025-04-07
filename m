Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1BDC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F22D8309A;
	Mon,  7 Apr 2025 22:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QMGXkK8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B6C82EAA; Mon,  7 Apr 2025 22:02:37 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB2A582F83
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so4157967f8f.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056155; x=1744660955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MAhmRFd74I3yT9uRFvKNock/ejiQI0z0vKOX86u72Ec=;
 b=QMGXkK8/AguJ9+CQCG3ATDHkJTCFkF2JR+0jYarmtfthv0pQ1lSgl6m5GkATOg5MUL
 x5DMfhZtcDmq087DVv06E7qfpRxWE4AGBqjb6Lwr/f5BXncakxwacNh04JHzhA6ImIn5
 /3kqAzhbMT4+WSqZRk/hVI8N+sZ/fftXHVqY/eM/xpWR2nawEiFa6Y4XXbqWVPO3jkIK
 oS6zA5Hl7Gd6vY23nVDLBuNf/45etp/rPi33TpgZyfPM2FSqDlW37/y1GiGyHsjYv5R6
 iKcFyVL4OQYBqz7NK5lg+6z3jMmVFnrLv3DCtr1aWqxUHbgVs/LzLUXv97ou9mj7Mn6h
 r2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056155; x=1744660955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAhmRFd74I3yT9uRFvKNock/ejiQI0z0vKOX86u72Ec=;
 b=RmZN1pvVx9e3kWHBB4TMTGEm6lCWSd7g+Sx8DXrYOn48drzWYZCne2G0GHthqWuGXd
 xxrrKrEszFE8rGnIt3/mP8oEBBwJ5pSSuvC7dmI7Du2BFi31VwZLmbK3T2p2TweiV5em
 qVOq2d4raNJc60eP1KP3PH0wVSWlV1ySVL0Npt4RF3JwMKVDyycrr0OFOxmWmVLJpO7j
 Axs4rBTpwuKAoxnri6ihsIFcss0+qDDG3AUsSeK4BFnD4v4Y9jLtCcN3FqjJLuHmwixW
 u9ssuxj2MYRuPJw0uDmgazNmFg5VIPu8qVgQ1kq4jH3/PYFnUahF3VA1fANaO94RAbvG
 NfUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ/9CCC3edjuPEQseTyfnuBOMKp4AU4gokjYclHiTJsTu3hyaoqET8r8LYK/FKFhX4KMVF9nM=@lists.denx.de
X-Gm-Message-State: AOJu0YytRf2obYiY/xuYF6rVwng2SshNy2tGad7fTL37/BEJgJukpJZX
 fAd3Us1X90TcmTzSCpomLL83z4Cjb4onJsQ076gfJQoswOr2z+Ie
X-Gm-Gg: ASbGncvHzIKDhhMpRooMrEmSH1/BWyTrNPCFXzg4GdOGRPwgfJLZtBIGaGuI7pwBrte
 kr32k588vaERKjnA8PCKiCpKYQKka/w7QvNjyWgeF5eV89V+jfRVs0FsAmVHjc09sNajujz82u3
 yeeuYFb8+zxWj47Ldm/yAWPQgJSkLmd/hTIJNMMtVuwwimvUSBvrPMRZM9euJgCZ3xBkMeWktmk
 KIfuZPrvUjteMKDR6rS5VPtLe3cHKSWRHU2Gk2BUZTW9abn7z2IzP5p14phyhjA91DFPF/Wketp
 pkmOJq1R0D4a4pQD4oNuGt7dGdVT+Lng07nPxSJlL0cuCN3tD1dFxElEDL8m/kZbYF2oNmpTGq5
 5vSMQoKFWv0fKx3obXdbz6zh8
X-Google-Smtp-Source: AGHT+IEhknhjkpO8HjJ+AksyfkNx/UE9SSfUXeQj0GxEh7mWtY/JYXiWGW0ZleV35EoBZBPxPa5Z3g==
X-Received: by 2002:a5d:64cd:0:b0:39c:dfa:ca71 with SMTP id
 ffacd0b85a97d-39d1466350fmr9020795f8f.49.1744056155240; 
 Mon, 07 Apr 2025 13:02:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 01/14] arch: arm: dts: an7581: add Chip SCU node
Date: Mon,  7 Apr 2025 22:01:45 +0200
Message-ID: <20250407200208.25594-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

Add pending Chip SCU node for clock node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index 0316b73f3a5..9f8abfc3bcf 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -11,6 +11,13 @@
 			reg = <0x0 0x80000000 0x0 0x40000>;
 		};
 	};
+
+	soc {
+		chip_scu: syscon@1fa20000 {
+			compatible = "airoha,en7581-chip-scu", "syscon";
+			reg = <0x0 0x1fa20000 0x0 0x388>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.48.1

