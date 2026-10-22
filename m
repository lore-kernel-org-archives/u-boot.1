Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85788606A32D
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kRSfgZrE;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KUcZYLkv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51E7140810;
	Thu, 22 Oct 2026 09:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzvrIRLQ0Y90; Thu, 22 Oct 2026 09:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4243840769
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792661188;
	b=T2JIhAeZeXBal0MYT1BRQNjc1qKKW5LxVxgYsILA2GfuvDmgKdyA+PWCGp1SOjUDamAJ
	 rPDOGTy70rqEVmhuJGcAi5497ww/aaAbQxO3Tfvgl5GM+ekMj7skWG10kk5LcsJ3BmEx1
	 AUDvup4Z7NhxtD1k0QUTmKVT8deIdbeBjNRr2SHpxBzpYR4hGBvs90scpL8Q2C3gLz9z/
	 thaYgvphX/QQUTsGmEpPGLXZMuAfTKvgxf0rzWE46mkaz2cdiYwwsFF52IfTtfVKnehV5
	 UNM0GE0FANRvNmRxha7ynYmkOM3VghRBx5uU40RlbtF7sStCulimjfOmm721tnC1Fuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792661188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hHMAmoIV6iyryLNoEs+8RCZGWovmBM4qFjappdhuqdg=;
	b=qrXgK/RpTrph/M2QD4YB5UUJScu5MFQF4OB5qMpbKpVpp6B8GYjdWabc6s85Y6894z9S
	 mi6lU/kazwaeZ+ycymS2ayU0ROLqniaJvrUBUYtXxfy4fBa5HJ00bvqpG0Q9+tiL3U3Lc
	 1xeZF10dnh7X5rE9mUv+XX7qY1lCDyC8g0dgcvCAAIJD8ycNK1uTZWYv9yV13qA87Yu09
	 usbAJcO+sfQPtIdMepqPD5o4kelT+004Ymet8kEbRfUjVy6GUwYRfQbjxU6McPiefa3CT
	 ePv2g5DbfwqnpncQLlt3gRPDOKSOBVc5gBqKHTUMAuiLRBEtKp6sqBokzj1v9NT+xzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792661188;
	bh=hHMAmoIV6iyryLNoEs+8RCZGWovmBM4qFjappdhuqdg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kRSfgZrETF8w8HbFqTQrsy2aH5DDiw1ntSL5+b318/7QsQqfKjfONKhtNRHW49Bii
	 y6XrnDt0EcRKtzSQCW1smB4U33VCcSFKfUuj8Tme+85x3VrXnnUeqsaEYldHgnlTGl
	 Xr9SFNMjU4ckmeSydlATgVD/hcubTbnwOc5+b5gHAI1c/WmgTNApk3SYH3MPJ6vjD2
	 9yqcWQJbHrdpHcaru6lafemK6ZEy71v3ngZ1hWpX9V7MQzJ6EI3xi+WJzwvjqqIuS+
	 UjaPI4ZQ6QdoWDGIx3NkQipD2Rw6PrCj9qmARBQJJI1NiMB+3FFsQ5YFr3hWRXp7DI
	 H12ctr+ZU8uWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4243840769;
	Thu, 22 Oct 2026 09:26:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 71A3195C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57D4760865
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M_R2InF_464Q for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 09:26:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0BA660846
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792661185;
 b=LvDgnqKDE9ZpbjwXCVIogoM1ndgP402hfCx+RtglqJVVxK5Nr2GruxBxujNy7kWSCTiK
 qLZEHN23zLnXuMv1Kfiz+FL2QVkJOfKpCv3iI9XYiE/AK/wkLjOFHADJAT+9h53Z06Yvl
 uak38D9upHfjBmAUs89CDVuc31195DnLpNWG9+84mw0vRzi4Ffbo79bPrjmczkdK2IcwU
 nkyt2efUlL6MrZl6z3urPX9flEkLGjgqm5Idmf4WOR+Iu8P8gXG6Me9R/KsbwKhe3BOQN
 6eJQJYoE/6Bj8rSjBzWOH0oyYRaN+Lmxvy/oGS/8jPSr65ZWfvQpMbAccmpTiBhjdlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792661185;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=hHMAmoIV6iyryLNoEs+8RCZGWovmBM4qFjappdhuqdg=;
 b=tclDpMy1upOYkavu0bE/kWQuS+dgF08mFwE5IIpiUMiz/FkpzrPy8Eh+WVi1CSwQCqxc
 a4LCTzi4ZG7th9+F5ovy/bfBmDJIDD5PCB04Hq1DmmB8pjkJlyl/gUjUqKqga0L5aQBaw
 gUpbfbqfhZD67qTW9eEKNxZf5x9Z5s+ZzTIzGM6DqqTHgh96z/sWiOYw51oPYquCa7zAt
 clw7Uh3U93R/aczs/2WBEswi7SgpS/6mvpw1+xKAZI2AiR0d8mt3GgFJVVsnPa4ornDGI
 ud94xRCSlseJlJyYqU1df/OeVYs3iETdeJEMMtkzObnPwdCchMjuU9fC95XL2A6KlfQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KUcZYLkv; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KUcZYLkv
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0BA660846
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:23 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1067412f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792661182; x=1793265982;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hHMAmoIV6iyryLNoEs+8RCZGWovmBM4qFjappdhuqdg=;
 b=KUcZYLkv27LC3aUJv1PkdnW6fMOWinCacSUkyM6oBR8jSVQqCzeecpO2SoZmXlvDZT
 rOkc7GvCKSkZoPwUsZknJz8jfXeZjF6Bp2e+c0cjLCJB5CglpWzdgwQYOyWoRTBzLOvm
 BGvuuJcP5RPdkE2gnEwh5e42MF6GprPeJ0Wvcv9Y18zKIv3r2VRGAzlCdGnkcfsBI8EG
 QecsoyUheMONMeFG8U0XnG04qHhwoX3wCcXBD0rnYgdoK/xois0xaD0pBbeKDdPsbanb
 HFeCUJTfvwszE0cPuAcjBCaTKjVMy67zgEDkBR71tRHMoubxMzebXttf7xSgJ1fY1dOB
 MbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792661182; x=1793265982;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hHMAmoIV6iyryLNoEs+8RCZGWovmBM4qFjappdhuqdg=;
 b=Rk9W48Tm26CF310onS/fIUHzze3dAld9YcEHDf+UbooOqoJ+5q7DADq2R/pSH+ouQj
 82mbwOHnKWe4l+/Fxai69zj1E6HwJihtVNZ9jYBZGMFWhETl5nYsM/BKxIwJCfyFQqPm
 E9l4bB8eon7Kr7zmDqkiM1kc7arMYHePwqalF0KzD3FoL1Wgp1eP4zJaeYfx/00vSPQr
 7hbi4BBZbAdDI35qbw7Ey97rTo04UkFk61y1Bqrwz3D8w7IZWfxm9DkUvogbRZvXNxXJ
 EwOA5/qdQmwjOKNESIg4kYPRefJsxWL8al8M+mBW2125VQBz8IfKcK89WpVotGzwe+jz
 nYKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBweSmD6Zp9HSKvXmflJJa1SYzLVSbPk6aORfYeQiUy3FOaqVD0H485MQUAhgBn10qghuZHRQoM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL7Yg3hAW/sXlWEFx0pjRXIoAwUSATEHVIksl5x9jldZJbiEVcL
 IHf/y1FagqD9+fRKPvJO5CWfKhsXHFfzur3aGkt/cRdiI1RgyOXkE9skMdx5HFiKnzE=
X-Gm-Gg: AYBFou3xbYCKzDqjSgXVeMnNjs+n69MQS7aNkqh/yZg9mqFvhhzzQ6EOvYNh+opbQW3
 dR/zO15ZZY1Ou6nY0JVj3llgCboG8MG3zdXdLB6xscf/lYyrWJQiyR6jUPdvXytns+zL/evvcrw
 6rARs0t726Mqjqup77Jh8qQgOzE9qZP8/9jEDtoIY2RmtUX0ONVFD3g1tbLGaf72mLXrMDaHt3u
 YOhMut0cnFfVSQrzTUtIvwryWfFBDG7k9x+isVTk9hDrtFPcfEqNPk25XZ/vBElzAAQE1Fiaq1Q
 GFXR0EP1wK7E0/iAxZS1tPVlrwWErmiIljSVIN6Rd2eTCiTn/aMzfSoruu3ezC/rh5OqPBt6OAI
 rGhEBD87FdavSLsghoyehh1p+9/e8FmUK/ua+q0lui6tSV4zsmU38LVdfpPmTbEXDNYCczDE0d/
 mtyFRKEPeFnVLM9mLDCaD691Z2KSWPjCYb3aBYhUL9dfAUl7sHrUnKIEW6cX671aTHMwqCXOIaR
 SnztkoubM9rSK9SL4qs8QjnG04cn7ozKaRvEFT0dQRjl9pxFnrLjH7vnPL1E0txQw1ppAV7e2qP
 3CedaQ1DruOAkLU0Jb2VhjBYyiOCuq8kbPRXcRTnwSfeVrxwRTXmnL58zsQIUQrWr2jFcpyfnyH
 oeHMLfBWRKeEY1U4=
X-Received: by 2002:a05:6000:1608:b0:487:a15:b4cc with SMTP id
 ffacd0b85a97d-48e264b1611mr6784325f8f.23.1792661181836; 
 Thu, 22 Oct 2026 02:26:21 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-21-165-229.retail.telecomitalia.it. [79.21.165.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583522esm11426793f8f.35.2026.10.22.02.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:26:21 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v5 0/4] Add Genio 510 and 700 BootROM download agents
Date: Thu, 22 Oct 2026 11:26:14 +0200
Message-Id: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Ry2rDMBAF0F8xWldFGsl6ZNX/KF2MpVGjUudhO
 aYh5N8rO6GEErwcGI7u1VxYoSFTYZvmwgaacsn7XR3al4aFLe4+iedYZwYCjPBS8BCwrhA/Hco
 4EPa8H53ygkfkCZLT0mAH6FgFDgOl/LPg7x+3uZy6LwrjLN43Bjqe6qvjbY11WIiHfd/ncdMYC
 N6JNrrY2oBRC5sE+NZZH4JHIx1E1EbjQuEYtjXsppE2gXKt1xFTq30MyjvXdhjJiTkiWNBSWmJ
 zpm0u4344L/0nuUS4V9VrVSfJBe+sSZ6UwKDcW4fn79wN9FrDL/IEDxqoVQ2q5hIYbazDAP6Jp
 h40tXqGSVUNae4QLEUUTzT9p0khzKqmq2ZUtFGCtvUH/2nX6/UXHKZe4EUCAAA=
X-Change-ID: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Genio 510 and 700 need a way to provision blank eMMC and recover boards
with unusable boot firmware. Add RAM-based fastboot download agents that
can be loaded through the MediaTek BootROM download protocol without
relying on the installed bootloader.

Fastboot in U-Boot proper is preferred when the complete download agent
fits the platform's BootROM payload limit. It provides U-Boot's shell and
boot facilities as well as flashing. The SPL variant offers a smaller
executable payload when including BL31 and U-Boot proper would exceed
that limit. Both require an external DDR loader and run fastboot from
DRAM after DDR initialization.

The two paths start USB fastboot at different stages:

   Fastboot in SPL                   Fastboot in U-Boot proper
   ---------------                  -------------------------
   BootROM USB download             BootROM USB download
   (host -> SRAM)                   (host -> SRAM)
     |                                |
     v                                v
   DDR loader                       DDR loader
     | Initialize DRAM                | Initialize DRAM
     | Copy SPL to DRAM               | Copy SPL + FIT to DRAM
     v                                v
   SPL                              SPL
     | USB fastboot <-> host           | Load BL31 + U-Boot from RAM
     v                                v
   eMMC provisioning                BL31
                                      |
                                      v
                                    U-Boot proper
                                      | USB fastboot <-> host
                                      v
                                    eMMC provisioning

This series is based on upstream main plus "arm: mediatek: simplify SPL
boot-device selection", already picked up for mediatek-for-main. Generic
SPL fastboot is in main.

---
Changes in v5:
- Drop the SPL boot-device cleanup already picked up for mediatek-for-main.
- Rebase onto upstream main; drop the separate SPL fastboot prerequisite.
- Introduce the phase-aware build rule in the SPL DA patch.
- Use the architecture cleanup helper to disable and invalidate I-cache
  as well as clean up D-cache and the MMU before handoff.
- Link to v4: https://patch.msgid.link/20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com

Changes in v4:
- Use standard SPL/proper phase prefixes for the fastboot DA options.
- Simplify DA FIT-key handling and include the board-hook declarations.
- Enable MMU and CPU caches to improve SPL fastboot download throughput;
  disable D-cache and the MMU before handing off to the next stage.
- Link to v3: https://patch.msgid.link/20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com

Changes in v3:
- Rebase onto current upstream/next.
- Separate the boot-device conditional cleanup from DA enablement.
- Use normal VBUS detection without changing the MTU3 driver.
- Apply the SPL agent's eMMC preparation to the U-Boot DA, including
  reset-pin enablement.
- Reduce the U-Boot DA heap from 144 MiB to 16 MiB for sparse flashing.
- Document that enabling the eMMC reset pin is permanent.
- Use wildcard MAINTAINERS entries and clarify signing and heap-size
  rationale.
- Link to v2: https://patch.msgid.link/20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com

Changes in v2:
- Rebase onto upstream/next, which now includes Genio SPL support.
- Align shared DA filenames with the mt8370 Genio naming.
- Use fixed USB peripheral mode instead of the private force-vbus DT
  property, with corresponding MTU3 driver support.
- Limit RAM boot to the U-Boot DA and use phase-specific MMC settings.
- Separate shared and per-agent configuration, and make DA and normal
  storage-image configurations mutually exclusive.
- Build the SPL DA entry only in SPL and simplify FIT key handling.
- Keep the SPL allocation limit large enough for sparse image writes.
- Select the eMMC user area when resuming boot with SPL fastboot continue.
- Explain the preferred U-Boot DA and the SPL alternative for tighter
  BootROM payload limits; clarify DT requirements and continue behavior.
- Link to v1: https://patch.msgid.link/20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com

---
Carlo Caione (3):
      arm: mediatek: enable U-Boot fastboot DAs on Genio 510 and 700
      doc: board: mediatek: document Genio download agents
      arm: mediatek: enable caches in the SPL download agent

Julien Masson (1):
      arm: mediatek: enable SPL fastboot DAs on Genio 510 and 700

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |   6 +
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           |  64 ++++++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |   6 +
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       |  14 +++
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi   |  62 ++++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |   3 +-
 arch/arm/mach-mediatek/Kconfig                     |  59 +++++++++
 arch/arm/mach-mediatek/Makefile                    |   1 +
 arch/arm/mach-mediatek/download_agent.c            | 111 +++++++++++++++++
 arch/arm/mach-mediatek/spl.c                       |   3 +
 board/mediatek/MAINTAINERS                         |  12 +-
 common/spl/Kconfig                                 |   2 +-
 configs/mt8370-genio-da-spl-fastboot.config        |  21 ++++
 configs/mt8370-genio-da-uboot-fastboot.config      |  29 +++++
 configs/mt8370-genio-da.config                     |  12 ++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |   2 +
 configs/mt8370_genio_510_evk_da_uboot_defconfig    |   2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |   2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig    |   2 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 135 +++++++++++++++++++++
 20 files changed, 539 insertions(+), 9 deletions(-)
---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
prerequisite-patch-id: 17f238594daf549dc39885bade80f2f82724117e

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

