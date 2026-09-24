Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18574C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 08:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C342340E81;
	Thu, 24 Sep 2026 08:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F0zVzWV0RzuL; Thu, 24 Sep 2026 08:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2634040E79
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790240361;
	b=qP4Z11qtAy3RNFEV5QYzxJaXbt5WQMM90lmbKR4LEiwLHCpUAAbXeo8K/Z+qMImxQznC
	 i0YZO3VvV5LdoC/62kcx2cZS31P2cH/Khh4V3/yy1ht7A/Gj/HmhAFSi5JzjQKVZE1fA1
	 t/c9KxbBEjN9jej1kFirZ7nMxK2c3whgVl6p5SIYoj2Oy5+BrIz3p97DkbhPIXlkWlmbf
	 MoBEgtIkpZvs1Ypa19oKnMyFIX3NIope1UDRPFRvovI9bOJieG4oqp16iuyJB/QLxw+9q
	 lBdoByQ95KD2oEnv+VuHLRH6ylit5ibDFku1eNbEL1moZUDoi6DcFBwNYMsVTCHcivQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790240361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=egkpId2a2U1nMcHyDKjjGVSOEWcUywEurRQLVBLzP0g=;
	b=H6+R8q0OWy8dvcjm2KZv/ZNn6pjqP4MNUoxbz7usDCtrCQI18+TSznLz5QN41lvzr/rK
	 0rG4EKOPthAvqbIFGbIBopu6fFqPocNsCxN5Pufh8rzFcXicXNoTFxSkPF7uvZscLN2tM
	 qIpa6SA4QEyID6NFBz8HZbn3rHYuI8sbzqXde5EvtCShhpe91EzKGArwM6EvSFnNKHUUX
	 oyQNDRKf9C0l+Wg+Wxtk8hgpZJkxBSmnurFXygR90QwXKH9Sw+NKSshc3iskIsii6orNO
	 UlcvQjPQg8gYZjCQNG14Hiew/acSZveWV7MxTmstD0EuVPiatWENOA0KShpNI8yV49g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=cdnm.at;
	dkim=pass header.d=cdnm.at header.i=@cdnm.at header.a=rsa-sha256 header.s=201706 header.b=rYipyyWS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790240361;
	bh=egkpId2a2U1nMcHyDKjjGVSOEWcUywEurRQLVBLzP0g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E1Dil/NOXyF6wcrVUC58JiFiJZhFyrxL2G8VI8gE49uYQNeLXht46IyTcJbCIzMHB
	 FS7NjsCDpAQ7caD7HKAiPchzo925ubSmvA6cGqCsfstazrlNsJ2Jdb/NG+kQh3FnDn
	 gV6vvKDkvpZ9/r3HJjmdUqShoUsar/3+KX8zdiJSzPADjqIOMNTTf9DxdYlbj3R+cM
	 88f6ags35blu2eInmOZN7lWjoCqkXlYfaAww0e/6hVFGfnub7LfeeII5vvLr9gS/af
	 CpSgRoAyF1SRdaWZHS+21i7yBeuU0arj6AFkG7Dx+MJn8ZnZTVR21rMmmGPKYoVUiA
	 OSKmIBL4NxfKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2634040E79;
	Thu, 24 Sep 2026 08:59:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CE0B2F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F29A040E1A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9H5hu2iJdTcS for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 06:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ED12940E17
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=144.76.96.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790231191;
 b=rix4hi7tqhHlCSdSgG8W2AdCrG6QwHveK068In+PPBEZ7FoVw8qmt4A0+jzQw4T/q9NR
 XRKglggUprwUsGGENf6sXGetsxMgVCptpFcOOY3BJJ6LxJQZ6aq7q+9bwV6kTE5AkB4L5
 8vlZ9MaMYpj5Ry6c+CuAh/tOKYcUuM6ViifnXi9h6BN1H/wNSr+gK9kNEtthSkH7j/wJF
 SfpPzA2iyK54lBJsp7cNzUg8Km5ysLqUHKWMq3z7K7K/kNL5a6jqAQ22xi534sfBjniSr
 cfi0VpFsEcmfnHhMg8IyyRYIakAsFpo48XtVCoITmc+oY5FcsDZtgNo7TTyu0neq3GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790231191;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=egkpId2a2U1nMcHyDKjjGVSOEWcUywEurRQLVBLzP0g=;
 b=USHahK0mqCFW68D0wR2gfnqP4Rv8Q0FBGSrjZct9p3qp/g9xth7fJvVmrDwaj/MqXTUW
 qiR2Sf0i03lF4s9sylUfHr2rcwqWpyZ1aAweg3wucsudj+hr973amf89TmZR5Dk8jVcgh
 tQKhhizi8NXGnHztUk3lQzdvlUe0I8Quv0YjEk/3penOumo+7H8oKIJvajESEJFkPsHPE
 /rj+9Yna1szq6lKi+xW5l69jQ61MFzuw9i/Rvg7tTSHwl37cdZt/w1RKyw6SsfVMw2W0D
 ohRvh3b4BVl3ZVV8p/ZQuCkZiIVHEq3UdsLqvCoA/+8qz3qetltDpAcchL2ERNOuIYA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=cdnm.at; 
 dkim=pass header.d=cdnm.at header.i=@cdnm.at header.a=rsa-sha256
 header.s=201706 header.b=rYipyyWS; 
 arc=none smtp.remote-ip=144.76.96.11
X-Greylist: delayed 409 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 24 Sep 2026 06:26:30 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=cdnm.at
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=cdnm.at header.i=@cdnm.at header.a=rsa-sha256
 header.s=201706 header.b=rYipyyWS
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=144.76.96.11;
 helo=mail.merlin1991.at; envelope-from=christian.ratzenhofer@cdnm.at;
 receiver=<UNKNOWN> 
Received: from mail.merlin1991.at (mail.merlin1991.at [144.76.96.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED12940E17
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cdnm.at; s=201706;
 t=1790230777; bh=QP1ZuVbUifdkHbp1Tfa0oFdpAfX6Wu8Vg2vDBFAcyZI=;
 h=From:To:Cc:Subject:Date:From;
 b=rYipyyWSiNWK0t+yDEp9FrMj74KluBCokljDvQgkotaVX5BjgElXlcECmBaaNXhRM
 d0TbtJe96/TZtS/ib8NGby+JcMyNqmDIv7IL0lE87vh9NUHwEpb8pLy6lNpJ5fASEv
 PTP480IAguFEgiJg+H79301joML2c51e8bZdUH2LKsmvCINOSCSU7vivm4b+7Rof9t
 ykDpeFlIwjh/0LZQD2bq9IXOEN40IJMFFHaOy9376MQPlumzZv3OwLVm5Rb5EVzQvl
 cbhJZGOucFhLWDEgePLKYpnowEyTpwjkEes8Xw1ZtdPvgvL3GuP8LNYo7K/8RbHn5y
 nYVPgF2Avby3uO8LZV/nAJKhS2Cko6NSDK/qa0FuaIthU8oaIbFV/GfHoIdP8/nm9c
 CJ14c4+jEcI5aM1BVmfRXOlXkxDHhwANqiFawpB/4Och9UKL/YEB1ncmc9GPLpJMev
 z1YE/U5rMvzaZkKTFr+KGPVBEEKM7M52+5fpZOj2uD0UdJkxI92b1PAyhZ6CZ0onxv
 mTihZM1je9dCqrW7tW03EJMq/LndNSyQdYa3vZXRyURIjDZgFb78S5eZ5a0oDPYhHW
 XHsmkUvmSPN8G2TzA9u1YMZ57NZEn5hpjklSRnRemakEbXV0tvRtJXjjpRRkjIv03o
 oE4mAj4uumxZYA1nr4TK7x6I=
Received: from chris-laptop4.. (unknown
 [IPv6:2001:4bc9:d041:6811:84db:d787:740e:c756])
 by mail.merlin1991.at (Postfix) with ESMTPSA id 374026C00212;
 Thu, 24 Sep 2026 08:19:37 +0200 (CEST)
From: Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
To: u-boot@lists.u-boot-project.org
Cc: Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
Subject: [PATCH] sunxi: Reduce inrush current on Olimex OLinuXino-A20-Lime
Date: Thu, 24 Sep 2026 08:19:14 +0200
Message-ID: <20260924061914.6187-1-christian.ratzenhofer@cdnm.at>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 08:59:03 +0000
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

The OLinuXino-A20-Lime suffers a simmilar problem as the OLinuXino-A20-Lime2
fixed in 8311e84b18627d836b4f90df268bb6890c2576eb.

Depending on AXP209 state and without the inruqsh quirk and slope adjustment
the board hangs on reboot.

Signed-off-by: Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
---
 configs/A20-OLinuXino-Lime_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/A20-OLinuXino-Lime_defconfig b/configs/A20-OLinuXino-Lime_defconfig
index 0a65dd05f57..fa33da73cfe 100644
--- a/configs/A20-OLinuXino-Lime_defconfig
+++ b/configs/A20-OLinuXino-Lime_defconfig
@@ -18,6 +18,8 @@ CONFIG_MII=y
 CONFIG_SUN7I_GMAC=y
 CONFIG_PHY_REALTEK=y
 CONFIG_AXP_ALDO3_VOLT=2800
+CONFIG_AXP_ALDO3_VOLT_SLOPE_08=y
+CONFIG_AXP_ALDO3_INRUSH_QUIRK=y
 CONFIG_AXP_ALDO4_VOLT=2800
 CONFIG_SCSI=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.47.3

