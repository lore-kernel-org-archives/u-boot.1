Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41659606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LoYz6YLD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ARh8tGWr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC98B40AA4;
	Sat, 31 Oct 2026 11:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ciMdXHVFRH5N; Sat, 31 Oct 2026 11:54:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F3E2440A92
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793447673;
	b=TJwT9ham8+K0kpQ4W/ZA48MtpX62azGF3mVhHAXN503LnCMBg9tCc9ieJbh76qeISWli
	 aqcgpnuOSXMEW/xdZb5hGvRcQTZNDYElBdS6IY0sHkGhnEXgOuaK7DG3/CJFEw232Z+C4
	 YJbT52sTkj06K1mdUFPyDgOCSsbRx0MoWu055f/y/K0bBNqSyiO0JwPrlYgrtW+jMG86G
	 7qMgh1abLfFL8ZBooN+n6atvvZ0bb79ZEw1Ly6OXqRk+4PpphfBLxL/YRpRhJ7wAjlTQ+
	 PBjbigfq9CDmX0om8cIol357dmOXPVYBb/mVi4aBtix58zAsImpF22KQ/tfrfkjnBTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793447673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lTWu8DN9RQNCm9MJdlp8y+Pi4KB//t85TXSp0FRlvt0=;
	b=Oo3WHPu2AkzxkYekNRoEJyrqFYalh0aBttU/MAwe/Z08ECSUkDRtRNBkKAVoCRC30aKk
	 6rbOLH1BqFH2hhvJgQy9BdBRj1k3MrqLrnbBauNSV2q3/a8tDYsH7KLvbSWgWKxrDbhUf
	 +EXIacEckHh2jQwt/Ivkekkug5NnwV1i4xET+l+LJUUxYKmZ/My2UtmOlzZYWwUHY0vnl
	 K52E7q/1B+J/Zgl5NOO8P4PMKXQ4V70RyHS7qz2KVhDGR9gvU7Ckp5bDJeKtO45qmILKm
	 VUlbXVxPqW4irS3y1d/+Dc9N77co7286ipgg3w4UKgn0pE7bx3DiX0xIk4Kx4PJqKAA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ARh8tGWr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793447673;
	bh=lTWu8DN9RQNCm9MJdlp8y+Pi4KB//t85TXSp0FRlvt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LoYz6YLDu7/RvI6ceOcvkSeF46B1/jJLkr21I6Ez28/YhngAOjmi+K3gAgNhghJgo
	 pOMzsixcdQjn7nFVu5edwQA63OJSyKB++OuJxN3H5YFJhz9yuFa6zYiexnkRqet//C
	 Qqu9iUZ7Pz5jHTgk8whos2zBmF9FtL1PcvstBfSmd+Lj1jwnSzZTMJw8EW+muoQnjb
	 Ssz9wVasGtRXeauTEjMy/QmsFzspkplnMnO3c+pDLJQILRtBCwI6UHyn3B3r9oUpJq
	 cM89hhyj0o7onF+e2haAF8snt/7QgCFq5v4yBvC8t4HVFn1AZb4lRxn07TObdm98Yl
	 m6YJLOmuxVdVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3E2440A92;
	Sat, 31 Oct 2026 11:54:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E4F124BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB77240A93
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SO5NypsCkA5y for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:54:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE2F640A92
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793447671;
 b=O7DbwLpnp4/LbUXGAbjkKE4VAHD8kbxVS+LYkHGj1EpZc0e+99x8Rw0v1qUsNCfk4s6r
 OmsqF+8HDrIFpCnPGnkNBVeyNhzxmQFlY0ZGpVFBQFNmLOBjhak0rRsyNsR6+SyB5FEDf
 AC5JhkEhs+YOnpEYCMpZ6zc7eNQ+htgQwcjKz7EdVkwuhbmvRXfs3+wSVNDIDjbzyQ8jP
 V9/OSXIxNnbbxLhDo3XJvVorzeGwYWamC0euHvk4LeISZkcQsGA1gdFBG8FSzMQXWnk3X
 yPRbXhaQSY53KXgWsaz7vjUjVsmik+NR50MWds6UudZdvNYkYPFVJtfakEred5jp1ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793447671;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=lTWu8DN9RQNCm9MJdlp8y+Pi4KB//t85TXSp0FRlvt0=;
 b=UrZnZOK0je9XPp9NCtWEF1rig0VU9XwL2728OQmnz3lcrUtJttd8fxuEb0E+L84NDpQn
 OpG8TCYgPk41kZd54ChfGY+7IYnpeuGqyQ9Op0F0/BbZbHTzbpCaeX2P8aSt9x2rupGvB
 VcGK9gA+iIRv7DLoYm9CLEY229RZVFciFPiRAkqkYdlF6H/LbgjCq2xqwz9h3jLpHfYAJ
 +2JLcQ1Y65UrweSh2Bn6fsnKq5w6XYJuLxNALYjol8sDRBAmm0/vRe7kV4xZjYH0RVV9s
 g+jDfr44zPS3V9Jp6ivQKNDYsqmedXalsVU5nl7J87zQBaqkX4WOkbVU016FTqp+40g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ARh8tGWr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ARh8tGWr
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE2F640A92
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:54:30 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cdab938dc83so642549a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793447670; x=1794052470;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lTWu8DN9RQNCm9MJdlp8y+Pi4KB//t85TXSp0FRlvt0=;
 b=ARh8tGWrfgjB6Zzfi20kcd4ZS2ZPIc0Gejkm3UsYOtoJ4z1mZPr/29HQQ82HTu7iHa
 aMwaZ9QVckOxfBRZo+8gcTjehteTq8GYKGFTGn+cUi2XtViB1RjSrJVPyp/P8KhSmrwL
 83xkpEIHhtUwKaFBHzuaWgq6mOgz8BTWCZdyOzy5jiGOJcAKMtn18XAlFzOeV/8/FJAd
 lxjPvVvLxG9klfe49bwflZxmqxghbK4bzntsPdJMuXKMN5H9twqcp5QtuPKzDvQrLgGL
 lcx+gniUmpVacaVUwffuws/I5288lxSEtRGck4mFko7O+vDhVbwLVd5+3JW4gE5Vn4wT
 ggkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793447670; x=1794052470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lTWu8DN9RQNCm9MJdlp8y+Pi4KB//t85TXSp0FRlvt0=;
 b=LYBdzzPSxrcFRwpw+jS6h+etIu06+CubLuXMiB4y5P/CEZp4GX+7SpY5VxMuuKP7Yd
 aR06P8acKLf0DLHlK7/p4WHo3iDvlEbCWMXLEYsDz9KWm0bijd4f6MFUujTK5BR/8SMs
 pH+Qs8TvynrULeHyz1VCoNplfgk8TOMDcHSqQX8Blp+dXGjWJiWVSAm7Qp2zhwdv0L+3
 VCew9P+32NmSzzyiP57E1ds2CRxzrzrpPjrtWKQfFSB9E4fU3enLks+sb0ueELT6GzQu
 EdPq+vq39Joc6pmcy9Y9yUD5F5rSG6JxfpAOd2lQo3DVJOAAcgs/y5Vn4STBaNeN/c+0
 Cd4Q==
X-Gm-Message-State: AFq9FYKRpBKO0v5Ua52y22u+fBdvY/0BFA9zWLDD1b1HK9NFhdX20WoE
 Qp8yDCRF/eNCbxVsJuoia1iPeA8ceYUdWB3jJDqzG6D3oGqao2Xvl+Jh
X-Gm-Gg: AYBFou09mm5mEHoPwMK0wRXWcL76zBfX8rLhS6RsBJA8Q9VfqxKs2kZ3NxyYWKQiIpe
 JWV63eNEX5EBHJjNAjg7KzuwqYtahHtxR2ADBtHZx8/NcOYiQg3fgnA2kBgTEFXq7M/tb9xLq9r
 77s6A9+sHnI2CFxRtQLAd6UnEW/pzmt6xWI4E5ACz4bBhekFcutlswHiDBYRvz8F24ui+tWWLrb
 iwSCRAXFX45DywmAIcFdOQtIWAtAa7zI16z6NRv5YDqQK9+WpXBvZi+93tfJbLeRYk8pzd6UqxE
 DNTzZY8Mjdg9AF5CZ3+AljCt2XLUMeXt/NGVN2g+CTd+S1T4k6sbR3Nzp0GWZT9wJNpkteACo3+
 5cSyTmLncV30BldosCXo8btm7JVc8RzhifjcyRCN1LfaHrDaFb7C2JNi05Bla64J3uQJMwX5qhD
 4LMFCxLPYiqk9MhCF5HdJvDD5YywiSevWIyyZCpwAwnF2HJL6jWjdCdflqSwf4Mf6k+9Bze5fAz
 Orh9HRsO36YcPqwri1pe176JK/IUYcBE+YHc5duaR6cAj9xsZPOvOfLrmUayK1T/UwofnBt9Q6p
 HZVFpdKJuvGULV+J0IZnSG5ac7JpI3Rmk0cMgod8tmP/6f7J14nYGi4PiUqGr+CAGUYb79835c2
 q9jp8o6BEB3NTYtzJDNX9EISrMxcSvXt1jIZKMm0Es9BmkMHZ3IoZeoF9ZZzS0wu6mQbm1/ZtbY
 fontcOB1UkMmtxSdQuj5Cwf9/0BeH0eQ==
X-Received: by 2002:a17:90b:380c:b0:3ab:3437:554f with SMTP id
 98e67ed59e1d1-3ae89749415mr3857192a91.29.1793447669777; 
 Sat, 31 Oct 2026 04:54:29 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb096b7ba2sm1659117a12.8.2026.10.31.04.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 04:54:29 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 DaveWK225@protonmail.com, eric.chung@riscstar.com, e@freeshell.de,
 dlan@kernel.org, pericycle.cc@gmail.com, tim609@andestech.com,
 leo.liang@sifive.com, me@ziyao.cc, trini@konsulko.com,
 docular.xu@gmail.com, raymond.mao@riscstar.com
Subject: Re: [PATCH v1 1/6] riscv: dts: spacemit: Clean Up K1 U-Boot Device
 Tree for SPL Initialization
Date: Sat, 31 Oct 2026 19:54:23 +0800
Message-ID: <20261031115423.3196145-1-alan.tseng.cs@gmail.com>
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
because the BootROM leaves usable voltages. How do you plan to let the
SPL find the rails?

Two other things I saw, neither caused by this series: the SPI NOR on
the Jupiter is a GigaDevice part (JEDEC c8 40 17), which needs
"configs: k1: enable GigaDevice SPI NOR flash support" [1], and
U-Boot reports 8 GiB on this 4 GiB board, a known issue in
ddr_get_density().

[1] https://lore.kernel.org/u-boot/20261027154347.1392094-2-alan.tseng.cs@gmail.com/

Thanks,
Hung-Chun
