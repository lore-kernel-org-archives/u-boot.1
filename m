Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAD606A32C
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CbpSwxZG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxAIEadC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60B1460721;
	Sun, 22 Nov 2026 02:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ey9iy59zy_If; Sun, 22 Nov 2026 02:34:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A2B06073B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795314879;
	b=RtL9jQxTWNJymSQ8vigDIR8zS43Ztn7K1LOGbV+3qyGZctdOCQ84xBYUwUqQKMRORtIe
	 08KhSkJeBiZHFoxkKYV1YZPte6pTIqneFgO4JRbFUQV+KEqUPJUwH3QFuJmYkU3VOF433
	 CepwoKeIfjTVc5EVsFKzPVLfb5zf3pRq8GRIY4aFCBjYftabWe8aB9z/cMoYUiO5L7jd0
	 QqJnBrOK2IDkz52JqetHitGS8cPMzXj2UTjQsT82Sbrz0ZJVAT8Bz27A9GX8qrhntBZ87
	 /qkwegaAkYt3rjp75TY8SaT7h20V45eILfrvKzf9veji6LRlc9JP/gsTj6OrAIIQiDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795314879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/C/D8SI+XzmOhBSXO94TQ0QOzENliRSxhR0hNIea82Q=;
	b=AEPxDmDmhrMkmjRyIoOtagDP2CrRN6FE/TUdTRI9GouqGtihjyywNHDFNinAapP38ISR
	 I81YwDXOO2m9BZgXCelOkNMwmoqxHB119QkG7YeAaYQP/y2/CSnwbGOwNKkTJ5N3hup2T
	 fjJEaFjRAd6wnsIJ301NxHzBnuE13QNuw/LSh9cepVDOKQ/Xj5kxl3gNWbGVDMmRQRcrO
	 vR4lTPDo4JVx/PZgqUsqSDAL2F0hdJE3G7RfL33PM3bGvrLoxjBMdKa0U7aYKczOaw2zH
	 W/EGb9h50cQxI4EAwBTxlPmHhcOf0E8YmBcLH2D4QIx/dNcCokoSBzrPUQ0CYojkuQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795314879;
	bh=/C/D8SI+XzmOhBSXO94TQ0QOzENliRSxhR0hNIea82Q=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CbpSwxZGHaSMxKYsuvlk9jKUwfm/f41UzLEKNouNHsW/yWWjLo5RzsDUHRV1vdRQa
	 96slf1SAte5ibzm5j2GnQJ7HE4kxYQ0KNfKNxpqDKJc1Gk/afazvhXynWIEgo80DTd
	 u50yIKmhpk4UdZ/VxDwubYAFxMPPQZn+yz4wB4TctFM58AUVBsMNvjHVaU6xRDjUK6
	 6+DmrSwrTELwwfu1vrBrv24QXVxhUe7RmWpOmlDz5faePa7y4Xgotj4IScUV8A/4du
	 fiMTLhPcyaAkPP3eZzcC8vW24X8nm0q/u6jOGZpZWAFxo57XH+bcdXUKjy70p/bFTc
	 jS5cu+lkbe5SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A2B06073B;
	Sun, 22 Nov 2026 02:34:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A50D6260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 969C840569
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVKVC6VA605Y for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 02:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2DDC140565
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nxAIEadC
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DDC140565
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8698407C4;
 Sun, 22 Nov 2026 02:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439891F000C0;
 Sun, 22 Nov 2026 02:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795314872;
 bh=/C/D8SI+XzmOhBSXO94TQ0QOzENliRSxhR0hNIea82Q=;
 h=From:Subject:Date:To:Cc;
 b=nxAIEadCuoGnpZ7ck8V+3VjaVDi2yRZBvkwuCqwInLfgyQupoe04ct3faw0pYr2O5
 XiJim9wt4UsH39KORZSj+eXdyTQqBC23f7FCV1EjQZi0PWCjVeygV2r5asur+oMjFD
 2lVDBZcfFZ2hVsfsa4adrMmLaLgjx//ceQLWQ/pyWzSoHO7DG3p8DPiPmpRfAMBzO3
 /3m3QP9LIPN5qK4csdYnLVTrBPBOr1CJrRx0uXzDuD/vhWglbyDyUD52NnDUVKrQ80
 ZAUizKTf2uaoxRFA0hkY3EpLPpJofu+7+PslkO3n9zK5hokFbpONBOZNlm5dFmDbz2
 jdnyrtmWoFnlQ==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH 0/5] riscv: spacemit: k3: Enable boot with SPI NOR flash
Date: Sun, 22 Nov 2026 02:34:08 +0000
Message-Id: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5EQBCF4VeRWk8luseI9iqTWdAK5dKkC5GId
 9fD7nyL8x8g5JkE8ugATxsLTy5AvSKwbeEaQq6CQcc6VUprjFOUubA08oL9O+wB3eTRZsknM8Y
 kZWUgnGdPNe93+Pt7LGvZkV3+NTjPC6WfYyh6AAAA
X-Change-ID: 20261122-06-spacemit-k3-spl-nor-c84589994bd9
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435; i=dlan@kernel.org;
 h=from:subject:message-id; bh=qSB8xOL3YA84jCWROqBDWNngQlmonzkCZ2bIccnbnoA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrAlSjTKad+UaHobsZdzoQ2a+/cWv1jKM7aX8z7
 NcIMH2Wq/GJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawJUoxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1cWg//abOLwUK05YVy058ZR0ZVLYbl9ZL5ereQKCodcnYpmIdIv1UqQ2vsE
 3r8CvMOwJVGIrfiEOOCUBFXVMRSbQ/oBzg6z4/a61gc4yj2dFRQUF6e3kfgIlIVxbfRUEbgv5l1
 Cvk5HLtQ7CxG8rYGjIy6XTGSBza9FiVF0ltz8bQDoCBlfgM47zGNQcJKzMW3MdRtdO3Rdrt4mvW
 AjY2bINN529tj35cKd4A0PQxeBKK32jz5f8cFyBBwZJ+Sxnlu7ik3S5b4BYA+c48TlrG1fDt/HA
 Qm/qEC3g/wj9Ib/n/Iu+JI7yguTFOJne/BEubOuoo5TVjPs/m09cNHLfpAt/nC0iOrzB3vihMVT
 N5qrCaIi/5v+J+TvhME49vJm9yCgXV6cL1x57mZp7sehjdRK6oTYsNv5AEvgzQyUIIxMb+N7g91
 8Me/BS0HflAwyCq29KPX0uUahgaJADVRzFsUSDLOWutKKhfD33ResLf0MuV3lhh01Ipmg3QEfPa
 ZmC4v4rR2KpkjTXM1NNkHnDjD/J4/Yd0iorctMoEwdz/Rmk3YCAIuoq2THbYjRVmN2FAOhDhv2P
 +ER1psgviiu699fOJ6Leo3bB5lN1xassQMg7PZG9MBAsSXbKYBEl0FBscmv7DXjfiG4gRidLss/
 CQ47NdjkCglR4cbbVcXHRtqCcFK7as=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Goal of this series is to make K3 boot from SPI NOR flash out of
reset without relying on any vendor code. Add necessary bootph-pre-ram
marker for device which will be used before DDR initialization, also
adjust defconfig options accordingly.

Only two prerequiste patch series are mandatorily needed.

pinctrl: spacemit: Add SPL support for K1 pinctrl driver:
 https://patch.msgid.link/20261029134705.3767-6-linux.amoon@gmail.com

riscv: spacemit: k3: Add SPL LPDDR5 initialization
 https://patch.msgid.link/20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech

Patches can be applied and tested on top of upstream 'main' branch,
using Pico-ITX board here.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Yixun Lan (5):
      riscv: spacemit: k3: Allocate SPL FIT load buffer
      riscv: spacemit: k3: set boot device to SPI NOR
      riscv: dts: spacemit: k3: spl: Enable various devices
      configs: spacemit: k3: spl: Enable pinctrl
      configs: spacemit: k3: spl: Enable boot from SPI NOR

 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 40 ++++++++++++++++++++++++++++++++++
 board/spacemit/k3/spl.c                |  7 +++++-
 configs/spacemit_k3_defconfig          | 15 +++++++++++--
 3 files changed, 59 insertions(+), 3 deletions(-)
---
base-commit: 94800d1744336bcfe1daa615e03456e2c64e857e
change-id: 20261122-06-spacemit-k3-spl-nor-c84589994bd9

Best regards,
--  
Yixun Lan <dlan@kernel.org>

