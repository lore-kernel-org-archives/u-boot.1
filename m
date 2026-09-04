Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA20C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 17:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F7B181114;
	Fri,  4 Sep 2026 17:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9FgvG2hIslD; Fri,  4 Sep 2026 17:26:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D48EA810ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788542792;
	b=HxZ1fE+FuirKgXjIQP6L0ybogeS3gOUF9MVH3ytQuOHC6xljC5cDDy+NRUBYlbS8Bugl
	 I+67QwGmIoSRBjq1mACB4eqoFEWDKBMZZVVMy8kz++Ohed6RUWSBV1UTgHyJ/70s6NUwI
	 h11LTee5g4OGSG6DMzaCI1OTZUC5tiYXZ4iJNaL8RrGzfmL9q13KSFAx9HDY4sNsg60H5
	 OkTTgIsQC16G1jPjcwTePil05ZnV0pBkDJAqQ2zOy261lYLuB2F1hEV7Sy/jLOPu1Hgfv
	 /69c8c1AjFoh7+1t3IC0yWuXhodmArU0V/ZPUFvhNV/3tcREpsMoifHvXHlvD+BschQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788542792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T8eCzYBCNRN8YAKaRKqateXolLXvRgCfDyBWJ0Mb+Og=;
	b=UpCNPdcsKdYtZ+5slkPH+YkNffDcpOKBtEmDNVn4hduya23IWuEq0x2PMYfK5Ih+KcIu
	 pQa4MAcEnXp7Ogd7yoFlIJeO9Fs4C8tKIgsZiCvOE5KEHRLeeuqyq6iVrYyZmgNOQ2P1A
	 uyrASTwsKEawrAg2J1WNa4gxLzosD3LVnuL5jp/aX4BR2KumK6vg0jA90Vu4XHa5Jm5sl
	 rPGTYFWblIwTRgnr2t9Ltx8vH518W5GPTg+hLIwO12fHeqUKnMfO2Mb7o497TxIInYVBg
	 tX0oeL+c46lhyJ8G2tQ/fVJYmd5+x0umyYBm2j8L0C9IwPEv83zA5lVtnPagelEVOvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788542792;
	bh=T8eCzYBCNRN8YAKaRKqateXolLXvRgCfDyBWJ0Mb+Og=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=og0s3M/XbXOtuCQFS3n31GAro/849JSD87wxTUCHGM1zu4bvBPSTKUnSgv+0bt4vb
	 6AMineaiFRDeqe3ipeC6BuCk2w7iMy6vxw8RWjbtvkVGCEL7vz/NG/B3fgRpN96oBj
	 oPo3Fg44P11x50IIT+Bw/kg6qO2OYdMhiyN8Do6YxCq14i+61W78kd1oOepeRZZ+H+
	 NIcj3hkF3OTobyJB0/BAPcHeZDecZDf0tT9HfNoUc4LIfIkL5YBHqIrFquttxmpoNm
	 lwqfew/OhfrXl9eTbjjelAuKjIi9NtqhdnYFiQQBD08AHgLaXMKMQvLJmSIUo8RaI+
	 wuUVDNtXDPctw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D48EA810ED;
	Fri,  4 Sep 2026 17:26:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C771B363
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 17:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADA2260645
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 17:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P7-oPfTEo9mq for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 17:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9E9C16063F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788542789;
 b=qNSlYRZb2CzMRtoB2TdZ+F+mgLSFeHKSZNk+/lUS6vKY0Q1gZabqn+lNnwh2XTOZouJH
 vSHP9sACr1r6b6IpLJSw7juJG3kl6DKcVuXzqjiUeUSAuMwtTPqem3ua8EmY3bvUTg8mR
 g1C/USCfzfOp2Tk5Us/pvx4ahn0B56KwGIrYMLJrTNvaFg/iTWfjkFpNvJ+E2UXIlww5U
 op/MF9K7Ub4YNh0aJccWcAyBnnJTm229ZQlkxxeM6fkx5dBHn8d3+ctEUtiue4oX9/ii4
 lPd4Fq+4nwn03tD4PZCPICD35ivIpe8+bMTNuZ7XXgYZdKPVbac6Kr/GPbXvCJyQ75Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788542789;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding;
 bh=T8eCzYBCNRN8YAKaRKqateXolLXvRgCfDyBWJ0Mb+Og=;
 b=kB2bL0aqDqvxB/v9R2wo2KURA3T8r0WkmPH+kqzWHOt8tOGbJO6CnLJVzH8rVUY2p28c
 wIwHvaKMf6DIeFm5f/CbQhBWvGbJHb8ze9entERbxWEoHYoopVnH5cL48Nh0aF10rU56K
 2uYXJbMHwO6eSy+Gkp35f1jy9rCEYLWbfx1LrCqBLiZDBpOzM35YAtEoYHK2taoDVBIHs
 vP/Y5DtutI/7HQulmR9MFCagdcqEN/hwMwlYqaNlsnRYCS6sEaFqkaReRY8lQT1aK0lKv
 cesDAtu+aHbBWdF29X4tjrtJslOJZjbLEDbP1dv7bcn2cSzVIJiAtZZ358XEICR5NiA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=monstr.eu; 
 dkim=pass header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=xl4QX64n; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=xl4QX64n
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E9C16063F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 17:26:26 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1677c91969so128205666b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1788542784; x=1789147584;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T8eCzYBCNRN8YAKaRKqateXolLXvRgCfDyBWJ0Mb+Og=;
 b=xl4QX64nMom5IUEq1EspZjnyCga0HrTFw07D/Wo2I/jARbEnF0grNb/b0My16sZlCf
 E1EBlQGDaVxrR7U83Uv/VyzE/fAHbk0C8ibWgvfxxFEa+0beFjRf2ueBDrx+olfVgmaV
 nhWMOaAY30kXW3naIlzv4qIvlXzm+nn0G7mqYhisN75D6YQv+Pap48rB0cuYAJaOxw5i
 U9+P1S7d51DWwau59DBNEmbYYKIKNkM74p75it0KSNkaCYpVSVJcb5fAxIaXsfwK+Ce3
 8A8RDt/6cK0emyrpAb5/aTgfzrGrsw/+B+hquRL1uMGA5hxkeY4uPLvASe14onvfGmvF
 l2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788542784; x=1789147584;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T8eCzYBCNRN8YAKaRKqateXolLXvRgCfDyBWJ0Mb+Og=;
 b=Sx9fg2eUNIbBfMo3kdO6o3zA8VqfOIWyt3KhBZhuYrkvu7QOxtpnxlo/C8rw2Z7k7B
 IC1gCRGGCNEcWSMlXYddvQNvyvxPYuI1iBZNyrG7G0su6x9fyr7+4llaXp70fwDOr69K
 KdwZ/AbJA0sy0xzQSPDABsIWf1sPqLZxSlGDocZ+Z7v+TpnT4FjGSTw65o6NwOVZJ3aH
 BnwsCyTr0tdZpIcPv/xmGSdffSKoChFs4A7pT933GbDDxFmpe7aEX/T5L5O+dGdsThZ2
 Rh48AKI/8wRMtCi8rXPA5xn4VCy5yiO3OECTCDmuNmvXW0G1NaZJQ8fG6dLlx6ubiHm3
 l+mQ==
X-Gm-Message-State: AFuF++kQs8V19BuxyBhVAK0MJIkD27ADt58lKICmRUhTX2STsnOF2dAe
 BvFNigVqrHS2Pwk4WB4lxZmB2aGKEn9qPMMa8LsTyQ2A2yYei1J3QNkjeFPl8JFs4GEhmHrAPjK
 Ec5kPDuxr
X-Gm-Gg: AYBFou1WMZVPY/r4GweO9MLVI+btEdd/izuHZZdAuwfqRtuczlMtPu8LisGs/THR+d6
 hgL7O2KaKznZvrOmElK2OBKufMygMDoVHYDNJOqBuwMiTl28sOako64qV4fRU0s9VMbzkUnrFT+
 MAU9UzlOrp9bj/bNdHa0QWbuxEZOCnYztgBtYSmB6mT+ajI6HlhARKEoYneV635SDH3zHrgWx3K
 2lMW5MoO53LFHbaL46QUiWrq9LxB1NYELNYKNLStFjGJW9ufAKSFQM8wuXJUxAXz+6CLQdtBdwA
 X9jcy/2qiRjG2+Mn1OgeSbOx9RhbM8JObr9IYmdyYyVeucxp19VAKsjR0Q22vgHbJ16hAxkYaaz
 m4gboF79pnL9yGxIMq0mwOSORp09nmJLuQw3uLcmrr1bcSgT24lkdD568XrTvNtsAZecpur4Xot
 QH8whbrKAl0l9Z8FMTy4hBr20Z+Q5MTmifvbIfytgy60NhuCD7kt7aO1VlClNNsaZgPidRE1xfp
 8CmXAMDEjiUB36QOybq78fkG6acEL1nfGmWMlMsN7mRLXw=
X-Received: by 2002:a17:906:2083:b0:c26:1649:47ba with SMTP id
 a640c23a62f3a-c26164956afmr153398766b.48.1788542784290; 
 Fri, 04 Sep 2026 10:26:24 -0700 (PDT)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d582304sm138535266b.43.2026.09.04.10.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 10:26:23 -0700 (PDT)
Message-ID: <0b148859-b63e-4da4-8269-a3e23abb155d@monstr.eu>
Date: Fri, 4 Sep 2026 19:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx/fpga patches for v2026.10-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

please pull these fixes to your tree.

Thanks,
Michal

The following changes since commit cc557af4553382f6f50e3ed62b9577054e7bc54f:

   configs: sc5xx: set default FDT file (2026-09-02 10:07:50 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git 
tags/xilinx-for-v2026.10-rc4

for you to fetch changes up to 21114d5463956e31b18be0b199dd47f404696fc7:

   fpga: xilinx: Check bitstream length against the supplied buffer (2026-09-04 
12:44:20 +0200)

----------------------------------------------------------------
AMD/Xilinx fixes for v2026.10-rc3

AMD/Xilinx:
- MAINTAINERS fragment fixes

fpga:
- Check bitstream length against the supplied buffer

versal2:
- initialize num_banks variable in dram_init()
- move platform_id/platform_version to .data

versal-net:
- move platform_id/platform_version to .data

xilinx-spi:
- fix premature transfer termination at low SCK

----------------------------------------------------------------
Michal Simek (3):
       MAINTAINERS: Move u-boot-microblaze to u-boot-amd
       xilinx: Move u-boot-microblaze to u-boot-amd
       board: amd: versal2: move platform_id/platform_version to .data

Pranav Tilak (2):
       arm64: versal2: Initialize num_banks variable in dram_init()
       fpga: xilinx: Check bitstream length against the supplied buffer

Suraj Kakade (2):
       board: xilinx: versal-net: move platform_id/platform_version to .data
       spi: xilinx_spi: fix premature transfer termination at low SCK

  MAINTAINERS                         | 14 ++++++-------
  arch/arm/mach-versal-net/cpu.c      |  5 +++--
  arch/arm/mach-versal2/cpu.c         |  3 ++-
  board/amd/versal2/MAINTAINERS       |  2 +-
  board/amd/versal2/board.c           |  3 ++-
  board/xilinx/versal-net/MAINTAINERS |  2 +-
  board/xilinx/versal/MAINTAINERS     |  2 +-
  board/xilinx/zynq/MAINTAINERS       |  2 +-
  board/xilinx/zynqmp/MAINTAINERS     |  2 +-
  drivers/fpga/xilinx.c               |  9 +++++++++
  drivers/spi/xilinx_spi.c            | 21 +++++++++++++++++++-
  11 files changed, 48 insertions(+), 17 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
