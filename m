Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93548606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ijIk4GYt;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mhdb3njZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AF7A60D7E;
	Thu, 19 Nov 2026 13:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kdru2VP7f2mh; Thu, 19 Nov 2026 13:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B330060D96
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095226;
	b=pzHgvpuY1kRtIlTSB7fEZYGYCZMWOYNmdQzaQZZ23StZwNQcxTe5jbFYR9jrX8a0fnIw
	 WXIGatGJK4xr1ZATiuS9PhXXWWekMM7aevHasuwPwej0TED6QyWLx7exQgNADYeL2w5fe
	 9emRf02xSVYR5EMcecBK+TvJnkWoEXQitbjSMY5eikmT7SLM/GOIBsV7fpDpx0f4u5nFe
	 45gE1rZcZOOdJ5WsrLlQ2dDNCgDkiPGi3hwv2fut9WEzv6hCbmUgcJCS8ltcAcDNhmE/h
	 YadE+xRYsaFhfXtDA3hfywoCIFH36DeG7bB/wLtwDzcdfdXlHjJw8DVIdst1evpHvJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L00WSZI6+yxL0UmaGCpDmSXVP559JB3ienBJfIhFBUo=;
	b=TwavvM5UGbfDf8PH8OvB6vNgHg9XfNAMcX2n1u13ntrk5snpIfmWMHhhq/YXWvtP2THs
	 wZdbVcJN/CNCasjLX5DbN9bCmeiZienp2RLjzpeE6zQKFwU529Wx8WvoEaw920U0nfStI
	 svQb8dP5SKmoo+EexAndGea/dC0IULA2rdBq8tnC3Lg2puv6JN3C1axhsCeSKpcXaEfna
	 SqD08wcNT5s8LyF5ot7I3kr617irZfNH+FlxkZ03QJFsEF3+6XLnvzPaaUnce394TaTo5
	 FIgkBgcr0acEhHTWYtsQbXeNqWfXW8xpj5a5oPIPwHVRlTUksdptSAUJrHe2o3iu0Yw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095226;
	bh=L00WSZI6+yxL0UmaGCpDmSXVP559JB3ienBJfIhFBUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ijIk4GYtGpApQuNJ4TItMwFgrkSHma9gps0HJ0bLgqsDCAaBgMge94ZyuhTqrESfv
	 6lS3P+uLb+Jf1yFL/LCuvyPrZ/let5AYtwQfciMk8pYLLrQLQTH3qP7d+wwKpFQ1Iu
	 9TPhPPkweyLIUPPymONgYiqRU4GmdKMTkVDRng6DH8Jzf6+3lsWfQbUkUR6Ng0ZHQ8
	 J7usfYNAvOgC7y/OvfdOW0mSXYejiRtSNIhscWfzr5eeMcLfcp4dqItgZbq7UVVCtT
	 gKQVfUuI5MkXzMUyawYvuGjQKw69XBPP/0QTKN093rcJWUURjHka6LJTvgVzj8VETw
	 KuWShEtA+Wbtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B330060D96;
	Thu, 19 Nov 2026 13:33:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B56D5A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A151740CCF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huSwPdYBJWQu for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E63C40C78
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Mhdb3njZ
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E63C40C78
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:32 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so1323460f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095211; x=1795700011;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L00WSZI6+yxL0UmaGCpDmSXVP559JB3ienBJfIhFBUo=;
 b=Mhdb3njZ5Ajs/O3NnBFl8NwWCKxml34fmT3WeYnM6/D3kkxK9XRc/TaFEyj6On3V1x
 /OK/pLI8PPNVmehwPROLzfATH46Z86XOF3K/3ReyttZbtkfdspxTamTM9QW9wEUG5xBr
 aUJkOIpdDnNwx1uBDXP8u+1KT/g1oI1WNR7J5+YrQ4AS26pNT5JEnfoJpQa0+mt+DyWq
 oAqQaOdFVklATob28rA3iZy897Dl+18qy6OV8ikQXvP+6JhdrbKUugZCyaOMdDGfwzMZ
 hBa+UdNlbsw4sHJ03X2Wpnjr97HtvgIiSWBrV8uemz4oZIjBssNIaZmbhmkdWPGQA0/t
 gdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095211; x=1795700011;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L00WSZI6+yxL0UmaGCpDmSXVP559JB3ienBJfIhFBUo=;
 b=kIJGrYfDv/AjPQ0Ja4/O+cOPVyPgz6OlkDJOjeosKtUo80SXNzfmsv3ITFK2yBqvl5
 y5fEmyerw7vGOJzXzxQuMa+B+SWoNt9zxkse0HCZ3UP7u552gA0xMt1GmBFHDyzZwCk7
 9cju8RysbZ3y21Tng49CRhVvrJs4v6IePdo+o1wVWAxawN9LgsL3+XdgDZgNeWJSjocY
 DfLr1EIeYbtdJeujr93dUSx8AVILXj3XOXUaauSt753d+nUKuCUU6UAIuacP7hZxDsfj
 rzj85in027QVuGtx+deKceiiGOUWinacG27NYTb1s8eLhgVa78j3wlTaUjoHEsZXe0dL
 1/dw==
X-Gm-Message-State: APuU4Z8+mdjdL1p6escrZpbo78NuvEozVqc+7drM5xEHDsFAJGpRKUfj
 xL2SG673xIUa0K1Bm0RGLXac//rInTHRq+Pj62GYJDbSgUeB1NF1SqvB+v7NLZlw
X-Gm-Gg: AZFdTZfKrzs9isIMSupPtVzcp0GcRBB4TAlfCgEblXk6LJMTmgYnyMwBtBxyMOAvqVm
 kNiG8dRKaThYpYKCgDs5Ylh4n1Afz4iTDw9Cp5/y4x31PzJmBXsazeCMAjmmqfGqOA+2hjT/UeP
 v1PsiqQKo1nd/Vg+uwAZCSgJHqz2YPIC7QxX6iDQ6wstKne0YoV3Ces/DQJ4JF3l4Nt8MEVpESB
 Yty90gaqmEzpnYJA6wCujCupE1KH049GFuiJ83LhC8+Uzow1NYGbKEpc5bgb5/N10Y79IGlzR8G
 irmd5hHuhiWnm+2l7DnU0ml141poXpbxnpkOkGLe2mOGRLfTHeYyU1ufM/KpqZkKExWGiJi0qIE
 v77wIqbWeIs2GvnBRQRqUmfi5dubQ3E74E6NCFiWGIPz/FNAVB+11cViB7Mia8Y1r8BPj+cjB6r
 aXG7mZp27ofhpki7cc8SrvMAbxOvQFLMCbp/X8bMxnbgbBvKbWTRo5EccIOPqOwk3AlNq3RUAx7
 lznU/Hk3TvkQs9jhjcW5nWSLJEGDhAYv6ia49ND1cn9wy969bAjlGEHbbzp3xWllZ+De958hpyk
 tFuMMOndh6WYOPqxAnfMEVt+RsEA6HPJBhA+BUgu7ueMnKp2HMkDLs3cF3G1nonHclnZXl5VAKl
 2Q7sxblt0ocQguFfB6xAdp77QqNNJNXMgcisctxHdlp3l3zUXwl2I7guoXqntMubjvgaxKy3K8a
 0czMMRPdH8ieNXFmHq2bqjPkil5es9dA0zJgXWdVaGO+2U9zrxPoAx
X-Received: by 2002:a5d:5848:0:b0:4a7:b365:19df with SMTP id
 ffacd0b85a97d-4a7b3651b17mr9734264f8f.35.1795095210764; 
 Thu, 19 Nov 2026 05:33:30 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:30 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 13/14] configs: turris_1x_nor: Enable CMD_UBI,
 drop NVMe and SCSI
Date: Thu, 19 Nov 2026 14:33:09 +0100
Message-ID: <20261119133310.22732-14-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable CMD_UBI so that the NOR build can boot a kernel from a UBI volume
on the NAND. CMD_UBIFS, which defaults to y with it, stays off. A kernel
inside a UBIFS volume would need it.

Even with LTO, the ubi command does not fit into the 768 KiB NOR image
next to NVMe and SCSI, so drop those from the NOR build. The SD card
build keeps both boot targets.

Tested on CZ.NIC Turris 1.1: with the MAX6370 watchdog stopped first,
the NOR build read the OpenWrt kernel from its UBI volume on the NAND
and booted OpenWrt.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
(no changes since v1)

The default environment does not call ubi. The boot above used:

  setenv bootargs ubi.mtd=nand_ubi,2048 rootwait console=ttyS0,115200
  wdt dev watchdog@2; wdt stop
  ubi part rootfs 2048; ubi read $kernel_addr_r kernel
  bootm $kernel_addr_r
---
 configs/turris_1x_nor_defconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index 35df37fbc70..c5aaf55a75c 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -55,6 +55,8 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_FS_UUID=y
+CONFIG_CMD_UBI=y
+# CONFIG_CMD_UBIFS is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_INITIAL_DTB_READONLY=y
 CONFIG_ENV_OVERWRITE=y
@@ -63,9 +65,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth2"
 # CONFIG_DM_DEVICE_REMOVE is not set
-CONFIG_AHCI=y
-CONFIG_SCSI_AHCI=y
-CONFIG_AHCI_PCI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DDR_CLK_FREQ=66666666
@@ -101,14 +100,11 @@ CONFIG_SYS_MAX_FLASH_SECT=128
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_FSL_ELBC=y
 CONFIG_NAND_FSL_ELBC_DT=y
-CONFIG_MTD_UBI=y
 CONFIG_DM_MDIO=y
 CONFIG_MII=y
 CONFIG_TSEC_ENET=y
 CONFIG_PHY_FIXED=y
-CONFIG_NVME_PCI=y
 CONFIG_PCIE_FSL=y
-CONFIG_SCSI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.54.0 (Apple Git-157)

