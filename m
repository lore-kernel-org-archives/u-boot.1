Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8AFCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4441E80D34;
	Tue, 13 Oct 2026 08:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UxwAAAjAyu50; Tue, 13 Oct 2026 08:45:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F4DF80D2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881102;
	b=KBtnHAuDDH/Tof7j/fZ0IsViYoxE7rer5kGgwYSvKn7ZD2dT/ovhthgId6h0cSoLJ26D
	 cTwBmk4XhF4I9s55LIqb74nPv5SJzZtKg+pJI9MEvdRoRczUfDQ223fKgKJk4f2qM9Niq
	 gvIYbpU755+zoAdhvvM8r4QDD+DEe0N2Fu1r8xXH2Heu894GhAhwPleCw9g+pRwNhPtW6
	 4OH9VAQr8r+k6c77SVCZM4QOv/lGt6l/BXntfLwSC3uNsLB3VrM0Je79oFtaRcRNTdEvx
	 lGB2dawNk/mVnIfUcTyE1izl+kN1WFkhyrJmpxup+O25QsAonb6AwgfGw4rBfQWeRQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881102;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oGwsidsRN152V8mJzkZFpoMCnLvEtn9raig9vTYcezA=;
	b=caIGe+gVRHbr2XEYfOuqoiiuOnS4Qg4wG3dv4Y4UBvhub8j0DajtO4LE0ht8NYzjP6X4
	 fweYTIX1yTCIG88RKFUgQGh8+aDajhqY1QR1AsY1UG1SvltZqgbtRKBrdj1mM34EuoS69
	 JumfNn7fa1S0wUMG7wlceEbokJs03GDnXe262e2C2Zl9V6vcofTQQiF9q+5ngWn3/arex
	 +/4sa4183IjpwQlS7nnHdtu2J46/qWP7OK4jTZAxTM5RtiBMCzTMVbqwYRkJB56Omt4E/
	 GBfKxp0XejCRUHR6ddjGYHiqlBHmQTVlzsStPmLKd41CWeaU5EpOTBInZGsJYZbLZcQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881102;
	bh=oGwsidsRN152V8mJzkZFpoMCnLvEtn9raig9vTYcezA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M9GZCxFujEyrtnkwhDeMltfnURRZrFYLhURsdVcRddmqZYR61Tw5P+hfOPAcQpe2I
	 zXXXEEtk9J9v0wdkVSAM5TuvDboeLy1KxumpVo7vTLARuP2AJRuGNB1KiZ2IUTH7YZ
	 P3v1IzcaWOZagShjkkumA0b/q9NeA/8e+/LjqyaKw7RWYuZMvoPJZIoT96vnJpKEhg
	 SwemsaU1/fU6cN/qWTI1j2yoFUj9OrBltXPnTttEHTwGIT9mu3nuT+yGDbb/XxLdhN
	 yoYEHPSURGEurGTLUcEE1TgzwGB+dXGzNL5awXL+gKqYM9ae0sN8mk6ssx/wK3767y
	 GTPvd87d7kY/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F4DF80D2C;
	Tue, 13 Oct 2026 08:45:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92B381399
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 780D0606CF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p3RzEnn5loPj for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B507D606AF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881100;
 b=CTk+cQexCBddhFZbFzk5sFAd0ZPy75tr+67NDaWLMb844kxGbxgEnbS5pWyQbET9xSG9
 AvAnTNZ7KBAvDfbpMPvV73h41IdMqi4cKRDOPMVN8lFQIfE8TZZoWnxokWo5jL0azpIxA
 pGie3oMQsTMaO5yE0vutzqn+Cm0mznUMM9z/cnAB0DIXLfczyJTKUv96vmCsKtfYNZstI
 /xX9CYBbe1EM7nEpEn5IA6jnL5d0mDi99KBabBv+skz9awD89pr7nIfSyp+qq/RWW5klz
 Ipf5G1QhsL3ItM7bJN+V0aGG2Aba3vTzZ6HzLiGc+vVcV/luO7JYwXqIrsjQ/gs6o5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881100;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=oGwsidsRN152V8mJzkZFpoMCnLvEtn9raig9vTYcezA=;
 b=jtLgsOm9FjHrqFLrUyhfmBFU6izM9kJcVRy9b7qBuM3GC95j3O+OUw0GHl0W5Ri8POkh
 bXCl2DhL57EgsM0F6VJ3Law8Be6r4SW/acizFEszCsnBWyNhvXibi8j7QkDXIlzemwlrO
 KlDOdikUIEFroHnQdT0zcBsQJ7gBU9TFLKJyPKoRxrmRSpsy//g0yRiMnuC4vfk84YND/
 CjPa8XKIlI4Z9ECkkE7tBJhYqj1JTryROHK94Kzmb0QcrU+qT9hvMbVrHQVhrvSqb97k7
 G2lF79K6SuFioX8NEBSPZyVJhkrpxQ6CL4Lafr2d8rkZ3cZle+LwyLvS0a0wYNupk7A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jAF1kroM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jAF1kroM
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B507D606AF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:00 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8899a204034so1144198b3a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791881099; x=1792485899;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oGwsidsRN152V8mJzkZFpoMCnLvEtn9raig9vTYcezA=;
 b=jAF1kroMeoP1ywJWu9ukPpL7HZmZO7I2hPEADZgj4NznBvbyUuvf1rvbuNUsTmEOLA
 pezyqa76n5x8glgCjRzKanDaLZfIPHyKJjPEb0qkam4XOSWFv76T2ZBmy1cke4tGJ7o0
 xWSvlRXHzbMfK5Hix25bGzjr3He3Kl7PgCMoTZ/bd37zUac0YNn+JWonuVWDth8BsAAZ
 X7ZbxjzBdQKrZR7e65tRHblUvs7O4pxgjLykzHz+xYoC1ZyRvFCH7BYSTO82DGUwZNxn
 WyJSuDtJlEbiag5NN1oDNp6hNXJmOcGrq3LQs/BSaA8Vf23D1LwI53tApW6VlEtxjDH1
 bhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881099; x=1792485899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oGwsidsRN152V8mJzkZFpoMCnLvEtn9raig9vTYcezA=;
 b=NdnqsfogxBTTDyOsgn0Aw/poSDBNqBGdqcpSv3lgziArUhHaP1iJ0vvyM9fdTWAsdK
 NJe2UowBfn4Oo3R92wX9VW6m57jE7hhTqqQjvquOccdHKl2ebFu+Ypl4ojtfPBVZriOQ
 XeGvZZ0aMJjlsXTCry7zGDhBtLC3GviVj+2J2Hqfo6jIU7zn8NA1CfSNJjn+PJf7Uwzu
 bnZy1hg41BYUXuyY47muLr2UD2be4RykaH5HUZ2SEsoXDlo+XTJ8SxgLEVoCfbbD4agz
 reau1XwfAR+gxBiEY8UmkO4VGYER5PllRgR4VMcslPhqUvO1bImEAMbb4a7Gy2pfamIx
 GP1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByel+5QanYz9l8kZxMgn3+MMU5zQ1IZ1Edzie5iod28xg4GHewpmfeTqitpFHngBw6NIHIA+RQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKKs9T7qVFYwxtua5w4PXcvVPYvQO1q2NdIEuGPZxARXy4nNHFJ
 kr9OVInSbInerjMXwO4KSdP2h0kPncP/lpxCE7TxDwnGgRbeKbhDWQIudbiEPq6Dtk8=
X-Gm-Gg: AYBFou3nkYHogNc9ttJ94wTI67R5WmHySRc8zKWJRbVWLzFlvlAST6jzPqQV1Uv0dcd
 A8RoDwvr23unVjsJPvFg2mRYYyu9EOkw0bWc4mfgzzNKILZAcMQDtULsNEV+QuWnk3wQRWnfO/K
 +q9vz6vMgd2i/MUnxMda2bGW4BWOss/qaFdWoCvAH+doDhT0C3anggG1o47lICJjMq6hRylM0iY
 tSeo0PJbo5xJuhQwIYDWunH8V4QzHX6uq4vzT0XKmCFBL6QqINid8ecyJYyzH/JIj5U4+GyRUTH
 n9JVQu7UUagRC0vQoPkn4yNqB1HcKPB6vyssOrT5Auj+t3QPDspf/tC75H8DOTbQ7OVRuLspr3Z
 oOwZKPsOjdCnGUPgrDQs8N6ZFgb4ujUaL2b1dQruB5NYLanguHUxjYPla8TNPlsei6MeSnstXx1
 7qjv/0hiuL3CC6yLYHzGeQEP3FsIN76QCswiekcTtqoGnNhq2xwhb9Vp+GK2wWRf461vuelhHsl
 gQSjxVQqSY5WivrlvBfYcwDry3oJRwzVqR5TYPn3H20GfdYmQIVn0ngnm0YKDnhn1GKHGwcp26m
 uPU9khlQagGy35dRPrU7XNQvNlH0Do8GBWfuJ3nL8AnbTGPzyLIXeURP/YHGAtyy
X-Received: by 2002:a05:6300:2787:10b0:3e1:898f:a10c with SMTP id
 adf61e73a8af0-3e1898fa485mr4012274637.84.1791881099347; 
 Tue, 13 Oct 2026 01:44:59 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da0596f9sm5383924a12.31.2026.10.13.01.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:44:59 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: E Shattow <e@freeshell.de>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [RFC PATCH 2/2] riscv: dts: k1: drop max-frequency from the SD and
 eMMC nodes
Date: Tue, 13 Oct 2026 16:44:48 +0800
Message-ID: <20261013084448.433298-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013084448.433298-1-alan.tseng.cs@gmail.com>
References: <20261013084448.433298-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The K1 SDHCI driver now falls back to the io clock rate when
max-frequency is absent, so the BPI-F3 and MusePi Pro overlays no
longer need to carry it.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 2 --
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 3077cdee5..fbbf1fb81 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -89,12 +89,10 @@
 
 &emmc {
 	bootph-pre-ram;
-	max-frequency = <204800000>;
 };
 
 &sdhci0 {
 	bootph-pre-ram;
-	max-frequency = <204800000>;
 };
 
 &binman {
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index d6299c969..cb0560c14 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -126,13 +126,11 @@
 
 &emmc {
 	bootph-pre-ram;
-	max-frequency = <204800000>;
 };
 
 &sdhci0 {
 	bootph-pre-ram;
 	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-	max-frequency = <204800000>;
 };
 
 &binman {
-- 
2.43.0

