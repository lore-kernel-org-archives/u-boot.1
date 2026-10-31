Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35477606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xtVJZYTQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V13r/Y1u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EBE8810A2;
	Sat, 31 Oct 2026 11:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ady_R-H1sVFz; Sat, 31 Oct 2026 11:56:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C609810B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793447814;
	b=l/Yf4bwrTgOfidPjknGhwEQGgWzlCLtJwpOTPP/ERcZq1X55ZAFgYdRqaeHgzl1McThV
	 dMioblJT6gMQ21JE8LOFInZ+0noJoRKqs7IUdNS8xsvCZfvhx7apv1oCpAneXbwwKf4uS
	 v5+kmr6/b20inFj3+49pevNO87Qzmi9926IynC5JhpFXbrzeZI4WRLQ10tMHujJKkO0c8
	 UnoH5xACIXiCNkJBHwEZaRdNf2FuHN8rxwKpWf1PbFsMOnCLKngDnMSpfcWHrr0OeTJBx
	 RXX5UEPVA4NleJnAX6ct/SNlsRHIA1glyh3Q0ZcEoJ654ltJvE+GOdrF82Vpv0c8YLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793447814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UODUSJ+f2A1aKk0POkGyCr5GF329z9Lwl3cfllOeS7E=;
	b=LZ8DJmAqc+FRGRuhVvBYe/g6WIJsC1OYqeQgNbqJYIqE188NYc0zTFezh4YRMcrDjhJs
	 1NRJ2dAsmzC5+xOa4pMEayT+J1Ie28ZGUJoA0eB8lBnCHGdtngQMp+LScDEpmNahWtY0H
	 TGuYtLzJRX62qlobnXxPJvg92E4S/MpHktIfBGcKTJRzSPkpgf4k/Ri/2xljZfV/3kIFF
	 J9ub27uRCwhLx/ebJlszMTdi47R71Y/jPVFPDNIderca1WEVNXWzIIOe1L3wg1t8sjTYL
	 lOTNSNI/tqEypv7sI0F14S8j9Wlr83pRQmeDCVzNK/3YwddBXV07fh7AnurWzkuB/Xg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793447814;
	bh=UODUSJ+f2A1aKk0POkGyCr5GF329z9Lwl3cfllOeS7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xtVJZYTQFh03JcVbnmhtqE0nqux6VaocAEEcFLv8/2ypUACAICKLhflPkL0rkoMAf
	 r8vsj/O2BPca48LFe35SUn2xch11A/WKPvMWISOJUYDmuppClKX4X5M9I67vjAoPWg
	 yz6ynE/yfg7T2wGQaeee6PJwfKmy0a2Cm1Z0JE9SEpGXdWDeRq4pa3jwNOn5nC9w37
	 YJmnGtk5H9GTgKU/B60tne2iz47n3xRYBECsrphWvIQ3knxDd9WS4EfrpXdc+YSPWS
	 6CvXcAwc20kHnTiohhkKt5F0pkIwxqC7q9NbSEpt+v7uBx5231k9TC8SiceoitCNnN
	 vodfPspR/L+3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C609810B3;
	Sat, 31 Oct 2026 11:56:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 20072235
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 060526064D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:56:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q4xXX9wzZ2V0 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:56:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2850A60648
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793447812;
 b=F7aNS7bosKpIVQA7FIzjQgt/JwIr2JpbGjIdwUEjXF4Ej2thMcNjalb3Dhq33LOoKHS+
 u6L0SMfYauOOzk5ye3cRcDpx1SPb6oPACdAhFi+Gs9Ro1LVCrxOkqEuJFYNeyKefS7Rzu
 eqFXHKy1ZFq4VNxPf5y1ogx4wa7qwMLk0TIFUhsZ3hXLVOgwNfoKbnXqE0VmqarKgIV07
 SBlqxh3FlxTQFTa4SSJxwpAnSKWwyt58XrTfczI4dPGAz8bFNVmkCyp7FKht4g59RdWVk
 jZi0APNHVxgDaTv84ufGzuO3JEbMvqtr70/Dzf+uKYfbZFhtI9HijUOvPC07eTvf3pQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793447812;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=UODUSJ+f2A1aKk0POkGyCr5GF329z9Lwl3cfllOeS7E=;
 b=dolpHQnBA2NSKKYi4fmZGj11Y/7YGHaaKzMXLyx4dmQluNlOkWlhRRN5z23wiyVmbOPH
 kZPcThrrX94ZFf0JtFyM9KJIrosIOagh1Grxe+cHRMtqw8B6AzbxrUtCBttgIK3svWRkw
 jJqI8qvYT0PaQeSLw+q/1Vq2h6+z6+b0GnUwGs3+QVx7zrOC0MObLLrlE0sVNlpEFChxr
 fVQa4pJaH3hAQ4UqWwXUMVgeCcLMFDb3mW6lY3xXSh4fMMEICjiTlA6LbSoXTsAZC37J4
 BbAX1DIiLeWzwFKp6oYplnkcsaMAXHuQKqy52vzwrZgCL/0Rlke9C90bsp0ATTewWMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="V13r/Y1u"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=V13r/Y1u
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2850A60648
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:56:51 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2e946155442so13991885ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793447811; x=1794052611;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UODUSJ+f2A1aKk0POkGyCr5GF329z9Lwl3cfllOeS7E=;
 b=V13r/Y1uHqqgLM+XWDY4Z+MdFDVvtr3tAOhScrQuyu3po7ywR12qfbDLZAX2T2+51C
 JgrhI6j/FA+MsM70P6IPM2+nUxW1toQWYFr8sMbFukaJfHcvuo6J1SE5eybSRrGZHDjp
 SlTsG4Ecnd9DsTZO6skDR3vLj1B214O8RMOaBIl4WgQPVxZ866cJ2e/00HnlGMzLTTHS
 FQZmZs48pZktAhiyYyHQs9HeF7aMwlsMR3abi1i3yyGwDf25a6lQ2mMG8xty7OeIA2Nz
 e0Mjo3L2dHYe0MkCHNDybDem1Q68jYIyXN66/ehrZ0sGLi4xYxPIhNZA1OBWuxuEkmew
 xpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793447811; x=1794052611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UODUSJ+f2A1aKk0POkGyCr5GF329z9Lwl3cfllOeS7E=;
 b=wmsZpnkGq3g7ewXqagLzEMG2cZyDpDkxiunQDiMqpKK0cF0Dbzc6bYRgBqUDwOYTaq
 UogSG3+6sSYcjyptHs0TO7Q27VuAylEiXsyD2K7KAGfIeZFwUNYi+6ZRlzjTaTk4R1al
 rsePgEKA0yiES1Af8VDcALvvNLyQdZh6QL71qPt+7AkzdqcNZMEwfFpWiqHx/cKcTuPM
 SWlHasbhvPKEbs64OavEDrTfVzYcair9l2gYGMabSJXSbLSXsVBc5cj6aC3TNiZixr6n
 MCUzqnHdJM4SPX6mQJYNUDJbxRUWmzkFK8mmr82+B+v5+CO7gDkjxszpdpyAj8/5RaiE
 tCSQ==
X-Gm-Message-State: AFq9FYLC1bCAuOJwruSj6l2mYOIgV9HR3GVoU1z2Pq25LqA7NZ8fwv9p
 r4uBusxlTmeBvcEiAj2gL0TkhZalt6ceVuX6QGH7yqwjF0Wz9ij9GneU
X-Gm-Gg: AYBFou3WsFoahJ3xnk83kNt2Yzw0G4D/AJxyEVfAGh/ki74si2addg2LQdi4iGziUKq
 broM8wdDFhmZ/4nIvm0llNSX3dhrIUHP6xHeNj8RKirYmYa2ZYKIUH2dTOoMKGtkfmYFiCbPyyO
 d768GnUZm3SEuyKTb7uXXzbFM/mqUlCMMAn7kr81x+A6PQv+KwI8UPndyzYUzFhn6q5pwoLpY+a
 3JtSW/QB5A8Oib4U3VC86TiRQ3f4RkLFGfPhzaqMTPPKx8fAoxmGNQLWefYGY3AjSINSK3T9/Cw
 KzZo9bCaP5wzs+5t9m6xRHY5kzmC8D9WHGVdHleU6ijYPWiFiBcIu6CcRpwoxk7K6lmpSr6YOSy
 qVn9QHOBqDVGUMcPgyJMJPFsNPoMD7p9xbNJI0Soa1iobMvHIBgSJMyEf/Z7qMMldwf633b2B1g
 xHM6PG5OaaR5FLopoqaccnUn1G+UF63x4PulW4GX+WhcvlzVJkppXmOKBXI/5xdzc0/QWAemtJA
 9NzymMxuPnJqOXUrrUlcwgldsLxEnUlBnAK5fzutWHXIwMY5jM9GhWqn9gPyV1G51sgWy/Q/7zd
 pbiqHaDjWqn0iDq6oLp32zu3oJO1iGlRlOnRBIk9UZQdr1JgOBGS+Q9cWQjiyQelGd5z1RwMTyH
 S+repVGxWUz45twRs01BBAJ9NPOEoB6ITNhVeI6xY9bAlLK4Qtv7xdC+NbWVdVdxXutUmqrzcBu
 Rby6LQ3lzN
X-Received: by 2002:a17:90b:1b02:b0:3ac:929d:ba5c with SMTP id
 98e67ed59e1d1-3ae89847b50mr3813746a91.45.1793447811349; 
 Sat, 31 Oct 2026 04:56:51 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae84596e3bsm7652995a91.9.2026.10.31.04.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 04:56:50 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 DaveWK225@protonmail.com, eric.chung@riscstar.com, e@freeshell.de,
 dlan@kernel.org, pericycle.cc@gmail.com, tim609@andestech.com,
 leo.liang@sifive.com, me@ziyao.cc, trini@konsulko.com,
 docular.xu@gmail.com, raymond.mao@riscstar.com
Subject: Re: [PATCH v1 1/6] riscv: dts: spacemit: Clean Up K1 U-Boot Device
 Tree for SPL Initialization
Date: Sat, 31 Oct 2026 19:56:45 +0800
Message-ID: <20261031115645.3197359-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029134705.3767-2-linux.amoon@gmail.com>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
 <20261029134705.3767-2-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anand,

Thanks for sending this. I tested the series on a Milk-V Jupiter,
booting from SD. It reaches the U-Boot prompt, but the SPL no longer
finds the PMIC:

  Get board name:k1-x_milkv-jupiter
  No PMIC (-19), leaving rails as found
  DDR firmware: [0xc0820740]:0xf0227179, size:0x8d98

With a Jupiter -u-boot.dtsi that has the same i2c8/pmic block this
patch removes, the SPL sets the rails before DDR init:

  vdd_core, value:900000
  vdd_1v8, value:1800000
  vdd_1v8_mmc, value:3300000

The commit message says the regulator configuration moves to
dts/upstream, but k1-milkv-jupiter.dts there has no bootph tags and no
vdd_core/vdd_1v8/vdd_1v8_mmc names, so the PMIC is not in the SPL
device tree and pmic_init() skips it. It works on this board only
because the rails come up at usable voltages. How do you plan to let
the SPL find the rails?

The new file is also not picked up until 6/6. U-Boot includes
<dtb>-u-boot.dtsi, $(SYS_SOC)-u-boot.dtsi, $(SYS_CPU)-u-boot.dtsi,
$(SYS_VENDOR)-u-boot.dtsi and u-boot.dtsi (scripts/Makefile.lib),
which on K1 means k1-u-boot.dtsi or spacemit-u-boot.dtsi. Nothing
includes spacemit-k1-u-boot.dtsi until 6/6 sets
CONFIG_DEVICE_TREE_INCLUDES, so 1/6 to 5/6 build without any K1
overlay, which breaks bisection. I have not built each step. Naming the
file k1-u-boot.dtsi would get it included from this patch on, and 6/6
would not need DEVICE_TREE_INCLUDES.

The MusePi Pro overlay also set sdhci0's cd-gpios to GPIO 80 active
low, while k1-musepi-pro.dts in dts/upstream has it active high, so
removing the override flips card detect on that board. Was the
override fixing the upstream polarity?

Two other things I saw, neither caused by this series: the SPI NOR on
the Jupiter is a GigaDevice part (JEDEC c8 40 17), which needs
"configs: k1: enable GigaDevice SPI NOR flash support" [1], and
U-Boot reports 8 GiB on this 4 GiB board, a known issue in
ddr_get_density().

[1] https://lore.kernel.org/u-boot/20261027154347.1392094-2-alan.tseng.cs@gmail.com/

Thanks,
Hung-Chun
