Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23C606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wXe/AjmJ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VTtEiqYL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2CB8606BB;
	Sat,  7 Nov 2026 04:42:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDEzFOODLGdA; Sat,  7 Nov 2026 04:42:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1872F607F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794026566;
	b=PTYlKFMt7feTtxNi5H8Qm8zmTEQqOHWs7aqk8D3+ob5Ex+dAZUcOD5xOXbOfJuMI7f8H
	 99Acans+eU8ZotNkRo8PJxapnxD2vflLEfdmFNrgJ6YVEQeNIRS0GCOqu/QQDuj64IZOD
	 PUo2kFb67cyE9I2kR0PmZtrlmyVKge141383N+ofTrFKgHagXpga8EAoGGdQ5UX4jCFb3
	 ePBPTtKUKhlYTTiLtoRycBDLdRHt0MYyaXiaoOvDWowfMFrxQSOutWG9mqMmuNiO5gUsu
	 uRj98IJJtNGyLCR+vs4B2uzBX24pGvnw3dviA7ZYrFO2kEmb9vPKEhgBeOLrAFhgBWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794026566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DE1gWsf4bL5129faBcqci0aM1Sx6puGyGHY7JZQR0uE=;
	b=Ps1X7wzSxjMrQLpMnRQrB0D+Uf/zB2DGCgGbIh/D5QcUxMTdKjSd9+zN5k4l4aClxIyj
	 wVVoTzt4jbvfsOY8tFTpncfi1srpgTzsxf+psr5dDoVTJfndjn+dqGNopwhTcJQ+7MQiQ
	 hPsk+CIyJGnXV8x4rBZ9EkFUp5BCONviQ2AcpD9YR4lqfcfH0e80PjsnyvHtYul4sAm4g
	 sRKQCaXiuX5I6mCFhEzJe7QoiYhpXzHF5NS1CRgLV7CGUKfvBswLEsBPTlLAbkirysMnA
	 yZ0W+IV2/JlnG+/cbrrcEQ4WRewZOY2KcvZR6YloQV7kBZRkORWlCIUnHaetJQjI7bQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794026566;
	bh=DE1gWsf4bL5129faBcqci0aM1Sx6puGyGHY7JZQR0uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wXe/AjmJvSICnAbBlMqPTtai35Bq00MnDnNa2jzgNnLoIcwgSLnKqt+UIPf4AF9TM
	 5hyHkXcxFhC1NPXGdecTFa6MOJ/rNch2xVPMhgIMTez8X4pm+LaEbnpujcvEQ8n+Th
	 2CcVoHCAagiEeXSziqba9nAseG+SlV3nKWa8JRjuXnIs2rgEfQ5uEZRv9WAFoKmHWf
	 wb3FvdJM8YQNX7x1JiSVwFOX1e5Dl2v7Ubjjk8dwHaNWRgZV951g9tsUORoVDuXIsU
	 N8MAhV0fGSUj59VmqV9ejuQllsp1JcW1xAq3hTD25BczfwZ5HfNMa+JftyD8Jqb68g
	 3Auwcs/ppx/Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1872F607F7;
	Sat,  7 Nov 2026 04:42:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B2032AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5831C81565
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxpLoKFJS5M8 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:15:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4A2081542
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=VTtEiqYL
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4A2081542
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:57 +0000 (UTC)
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-7c33cc572e6so62057137.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793999756; x=1794604556;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DE1gWsf4bL5129faBcqci0aM1Sx6puGyGHY7JZQR0uE=;
 b=VTtEiqYLuzTyQcCwdypXI4X2prxVAxuNcRkSY19p+B+cRqFDv3mQD7/pQrP6w7QSdW
 LsAdHrRTmLa4zhStaR3WgeKI4MRIQyrGWjxs6ZfN9w+o4J0h7hNhLOZjXtRK1PE1Yilk
 wTjNlMdVz03GASLNSdfRN/muMz8/3mIzS5fdnogqrE29xu6RulcgMQSQPjTRChOzmUJ2
 qNflfZ1tMtFKeYU+EtFP5tYcwBbfPs/M6UT/uuzeZRpjO6ZYJ1WJTldq6Dua34oL9DOX
 JTN9y2fGckvd0/H+kAdiTW6UFY8CCScFrWKEGrlEAsKDRrrbTrwoqdnZQn7p+bCcjJNc
 J9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793999756; x=1794604556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DE1gWsf4bL5129faBcqci0aM1Sx6puGyGHY7JZQR0uE=;
 b=CZ/cKkBI60PLulNoP2f1CaIiNikBfgIQz3P55XmLCqfFwq7x7YiMFNE1iEwgouviN9
 qSRFLB45w6BJSjaOkIUnMr8mkurR/cACQ4l/n8ChuGtZHQl75NNiEFx8Les8zoVgVHcp
 N2STmbn2XORJbAv9qZEk50IaWEULQxiaRPfbJIq6bfDoveLoHEdDb6yAODJwv0SUxuqD
 9imtctovUH0YZbzrULnW8Bv6hhFaCPBWp15qR/upKWXIW6a+5MuFxI5DIhVbMfdlpsgu
 S0069fui3FBMkTSIykT/Os4npD0JkGTXzqIPVjdJFIa/1c9EXA5TwL8ETlNsrrBCASl8
 aquw==
X-Gm-Message-State: APuU4Z8J3UCvZFMNeCkOeJo5gy480BKKTQ9HoUCa19SBmVke7KnlEKyd
 ojZAF7TBHGIWdR+79xXcFHFgrO/rE1YfFI9BjzlACkhoNlv63klqKALzb5e5plHN
X-Gm-Gg: AYBFou3doYs2tcDKDh1fH6Ysjrt0T3WQKA7GPasHSmM5gSVEvl6n2KU4nvsXw+hgXJL
 K5LJxbMLT/2mLQbFpN2XGZJHvhD57vfBk5ELiL9cg/jZ+35wVMoKsvCICwth9/tuT+6SF+VevJ3
 I3WaVzWMus9JPFKk4CCUTqPOPt9ifoyAMWvkejhg9JXkEO4xqU3yZZpSI4b9FbvK/cH+gjFsHHf
 qs8MIMJNm5kWwgxeEODP1PYWYgFNVxkmOBuj4ySvZwBzhDA5xbQMt1PyXubaPzKwwNTP97BkPtZ
 bCMbqB6SUX0LKHINsXGK14H3LIrw6hMfgN1rTdnS2DBTkRchqXX+e0n5NA8InY+Htti8Dg7prYx
 NRMEx2brwC/2qnh0tSVVOz5fHZfr7D3URRr5a84odAQPhIkck3lGk84k8aSLIESmnnAjleCRTfJ
 51TYlJiOvxLZI4Bug+2dsfn1vQyzViKVdX3J1ko1R6ijRBiQr3fvuQJWJDZVvEea4iF+dZn2sd2
 2eSXM+pArAqOkYlOE6fPETehi8gyde9VrMdEp1uy88s1Aci9vHGoYLiztt35n7ZuPtvd2JW9cG6
 XGkgwTdMIeRwq5yQlY9YxpOi5BStRtpS9UQRIEldIXGDU+4VF5K3SRT95ULMpmZPWZ8=
X-Received: by 2002:a05:6102:390f:b0:7cc:14d:52e4 with SMTP id
 ada2fe7eead31-7d2bd7ede38mr54986137.8.1793999755653; 
 Fri, 06 Nov 2026 13:15:55 -0800 (PST)
Received: from mateus-laptop.. ([2804:1eb0:a0:15ff:e3:543a:df0a:607a])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99bab48acb7sm2614087241.1.2026.11.06.13.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:15:54 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>
Subject: [PATCH v2 3/6] configs: ls1021aiot_sdcard: Reserve 1 MiB for U-Boot
 in the SPL memory map
Date: Fri,  6 Nov 2026 18:15:35 -0300
Message-ID: <440b21dd8dd6a3d13b1fe246256eec30cae6924b.1793999703.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793999703.git.mateuslima.ti@gmail.com>
References: <cover.1793999703.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 04:42:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As more features were added, U-Boot for the LS1021A-IoT board grew
beyond the 512 KiB that CONFIG_SYS_MONITOR_LEN reserves for it:
u-boot.bin for ls1021aiot_sdcard_defconfig is 604 KiB on v2026.07. The
SPL malloc pool starts right after that space, at 0x82080000, so loading
U-Boot to 0x82000000 overwrites the pool, including the struct mmc used
for the load, and the SPL takes a data abort after "Trying to boot from
MMC1".

Reserve 1 MiB for U-Boot and start the SPL malloc pool right after it,
at 0x82100000, as the LS1021A-TWR and LS1021A-TSN boards do. The same
adjustment was made for the LS1021A-QDS board in commit 7ee52af455c2
("ls102xa: Adjust some macros for SD boot on LS1021A QDS board") and for
the LS1021A-TWR board in commit 9b6639fa85bd ("LS1021ATWR: Modify u-boot
size for sd secure boot").

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>

Changes in v2:
- Rebase on main, no other changes
---
 configs/ls1021aiot_sdcard_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index 6327ca61d86..1fb8f7b0f6a 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -13,7 +13,7 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ls1021a-iot-duart"
-CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x1001d000
@@ -49,7 +49,7 @@ CONFIG_SPL_PAD_TO=0x1c000
 CONFIG_SPL_FSL_PBL=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x82080000
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x82100000
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
-- 
2.43.0

