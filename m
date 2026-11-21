Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B4606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N+y7tf2R;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=gbALVVJV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E723D40D11;
	Sat, 21 Nov 2026 12:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNUprr81OLdd; Sat, 21 Nov 2026 12:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B1E440DBE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264553;
	b=ekRc9wrcX2v/YDVmecxmfvf4+cWTXxysaosI/RRC2RTqlg/JTIvORze2pSpIGTYsu8Yp
	 VVSJeYNvy9QRPsgjvrfS61Kn3xifTW0jPuPLULjVQvK09JwP6nYx5pDt3BZb7G7qzAPoX
	 FZFPVMff4wFhITRW2UnKb36GyAAQAC82akyijV3FMprlt8floHpbCzZIIBQYBdc+Lmo8D
	 7bK71IpqUIFYYBcRRYiHjauhkNkhnXqX7i6g84u79b/fHCA4CaBOZqjx5wc26kLvjLmd5
	 M8GmCoRbJZpQOfEm4ON80sq0xmhc4wcWsmscogQgJHcmT8U5sOZFXB4DAG49iyZ9rSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LdMVktRqQ+G1lUImiErS59B2EoeiL3V2psUL7JeXibo=;
	b=TP9iZYsUXc2RLbRnQuwp/cPqE9S3Mkn7Ku0y3eXclG+kd8QFXjeY9Q7Fdcs93MibBT4p
	 TsN7Puq1uk4Nps5cR+0I8m/16LiIvmVS3Ar6JXgho8V61L8xOb814qFrnJsCbI+eDo5wE
	 rcM07GrsL6qn6atbjwv69NA87rTP+4ISfEn8i5dLGD2bCSJWb8yPsRewj+bUs3dQfE7tu
	 JvPgnjQXB8jASC440HQSkQ4eFT/U4z9C8voFBWir7h8NT+jkQEIeY44g0Kr3D2/ELRvLR
	 NevwVjpr6t9kOwJ1aHSKBNdJAtmABSu/wKNDKtq87Y7gftTeOk5ca1lVTtGQdepaLtQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264553;
	bh=LdMVktRqQ+G1lUImiErS59B2EoeiL3V2psUL7JeXibo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N+y7tf2R2/zWk4U9/0jIPET2Yayd25mkdsF4UGAUsLxENiuBaLlvkMzAWwqq9Eac+
	 /Gi/6YCbe0X4CEUbN/lJHqoyHW7xZ8rL5Y7rJMO5dUPOd5g5w1e6UglXYReTUDtYq6
	 rZIvXAnSwlpJfNiXv9m1/46XhYEJjFyJ+O6AfQ4aE0w5sMifqTFOByKv3dczReERz4
	 8nxsoZg+ih5N890ofS3fNajDRoscfPfwBwnq0ijjQmXDyYicJPnYroQgYvTNkOBAs3
	 Cmu0YXfnU1XGfAX0WMijYnDHNFLLkfqwL5TBmezK/InDXsIzLkJ5rnzuHQbv7zxuy/
	 Q/bvmC2GvOqhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B1E440DBE;
	Sat, 21 Nov 2026 12:35:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FF4C9C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74E7960765
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FlFBgk7_sfKp for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1237C60653
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=gbALVVJV
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1237C60653
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:47 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so1532485f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264546; x=1795869346;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LdMVktRqQ+G1lUImiErS59B2EoeiL3V2psUL7JeXibo=;
 b=gbALVVJVRTSKswuief+bBgjsuZmAzzasKAdYCTPafRogebSlGyqlZs/QOU6pZwUbjz
 AoD8dmoocdd9zVn/cgacX3kH7wNlfmmetRQ1LnXnznXp64dpHSsp4yfZs7PaMsD5mPwV
 6dtSyFu31ayzD9fj6Ut1uyZyYRnwuFyruWI3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264546; x=1795869346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LdMVktRqQ+G1lUImiErS59B2EoeiL3V2psUL7JeXibo=;
 b=TLWfXO/WuUWwe32KPlJ4Ym5EjmIebYuw8tIdl0M+SVf8Jh2AVZNc6nQcDTSpk3stnT
 +HW4wgzzArV84cnN5yaWfVp8Adj+iY0UH8KKEYA09DKXIYT85XpIfaDDic6AARuM5Rv2
 IidLFH8aKBDtQZNYrYtdZN4Ff/50MjEN4MITeiuX8PDpprlyaz5W8noF7QQBbzIS2h50
 YH1m07dXkWhqvi9C6aZG1xNK72yRSn3Kh5nBLPubgemK6PojHqHDabjfmTkXCFA9BI+w
 qlT/OFYLt9cc0WGFTVa6DFuF8wXRBymT1XVn7YeoNK+4RWmi9edX8/2D+edCgHbClPLk
 5u6g==
X-Gm-Message-State: APuU4Z98c5x0+a3GK6OI4rvN/bW66uuY46irhSkgQ9XfK/T9QMwgUztK
 qalWj1JOTYLNZ9Q/Q0zFrQG/YbBLJX/7mZv7R4QKzhilJaXcpwVkrKOql4G3W58XwsICf8UI5Td
 K13uN
X-Gm-Gg: AZFdTZeK1x23+h5WDv4F009eLF23ovAEI8D+gqhHWBRLlNF88v/Tp0AepW9BpK6Ykpn
 hdTpMEyF9Q8vSoEqOsv41sU44Hv+k7J7YfaxK/trwGZMNytNXncFz49yfsdZZsEVACXTgEIGkWS
 pVt3UYOSn6+YM0DLmgJEQ4nt309fYLdfo9wlaKpwwfo1mqNPO4dJ6lwM2/0HGWsPwD8CJ2g71hB
 3zUv8QC9ckFjFvpsprfjskdH3silhLp1FkF5jjmOBBGgKatATMT7M9zoSGH9gODMDj6XnXHckOY
 TifW6zGhSw2gGqABYzbgbr5EAg6nbbatLBq85e9JdN+dQZImRznp+Z5hVpYz7i2iwIo/4Pm9YKb
 4rbC0dYWjE51Mc+Kykrsvz4xPIk7aALTW0JOvMPDOV3X54kjAhslkw1ZYhqescG63xtY1pTD+Tj
 zEIdqmepskzbFTUTIUQWOMQ+k+/tBGjYC15MtmCjEbTleqL7ZJ5hAobiW1EUy57kDxXty7Bo/KL
 he0pV6UcDrCDYlIp/MaJDcN0xLdWvaaH9jiXCs/gujzrSZjrDLDrKJ/IKMC3x7t264xNGJCWfw7
 EcofokFnIim6Qg9La2eJ5M3mdb0GzLz+GRPLQmqpIUjNPnRKmSw2AETUCSDZ8qGc2U3/ej885GB
 ZcTkzwizdbjo/v4bs+PS+NILmjKDv6GCRfi3vRHZPuV+uT/tzPi7BLJ9kc1fH90e5BCbe2b/wCf
 N3FwNzVaBZY5pHA8Kbq5BLw1jLmQ==
X-Received: by 2002:a5d:6f07:0:b0:4af:7577:65c0 with SMTP id
 ffacd0b85a97d-4af75776767mr2478427f8f.5.1795264545917; 
 Sat, 21 Nov 2026 04:35:45 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:45 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 24/25] imx8mn_bsh_smm_s2/pro: enable simple frame-buffer
Date: Sat, 21 Nov 2026 13:34:14 +0100
Message-ID: <20261121123451.2471185-25-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 configs/imx8mn_bsh_smm_s2_defconfig    | 3 +++
 configs/imx8mn_bsh_smm_s2pro_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index f63948806ed0..fd463981d91f 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -28,7 +28,9 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_DEFAULT_FDT_FILE="freescale/imx8mn-bsh-smm-s2.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2067
@@ -122,6 +124,7 @@ CONFIG_VIDEO=y
 CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
 CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
 CONFIG_VIDEO_MXS=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index 713121eda886..304e8dd0266b 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -29,7 +29,9 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_DEFAULT_FDT_FILE="freescale/imx8mn-bsh-smm-s2pro.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2067
@@ -111,6 +113,7 @@ CONFIG_VIDEO=y
 CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
 CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
 CONFIG_VIDEO_MXS=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
-- 
2.43.0

