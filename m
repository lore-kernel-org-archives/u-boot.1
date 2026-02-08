Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79848EE0AEC
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 00:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7160E83BD2;
	Sun,  8 Feb 2026 01:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TMY8GCxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4CE83BD2; Sun,  8 Feb 2026 01:27:48 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382A183642
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 01:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-66f747175d8so221882eaf.0
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 16:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770510465; x=1771115265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gB9Wyb/tHtwZwHyK7FobEeC4Zp0YpSZ5/05G+ywUaD0=;
 b=TMY8GCxTVht3RgiNMVZbsCcWwVCzktAqjlJzqaXd0HEPb0IlxEXbv6Y21p+S6ZYoHi
 nF6yD4tKLscSZgKWQjY81sEE7ehCG+caRLmxymxu1p426itBQHEnzhOBYSNr160a3w4P
 Ixd7TLXPC7RJcwWy2hMfu9xtl0CNgsP9F+Q70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770510465; x=1771115265;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gB9Wyb/tHtwZwHyK7FobEeC4Zp0YpSZ5/05G+ywUaD0=;
 b=CHL0xjZkDOnVutR9t3CR/Cq5kZ1V4OnqT0FlCn89PVcLD4XluQ5oOmj/k4MTCb1P7d
 zPBYgwcWa8j38BokEuc2f5Ummp9VYHJrlGrnXyICz6L6eiLJYh2B/uBQV76BeBdSGJBK
 HikjMN4C8NNVvIslNX/Arg/Bq4w9PWFboD2rLzDXC+KpLZ5BajdrCCGSoWAp+B05MyeE
 0U9nJoRFOqXI9K0EOZWIgVf4NlpuHujeoBe209ZR1P7ZSaiDKhQ8NrenfQmE4hvOxuC3
 UrjiRqJ4YdYtIxHg3FjEXxxH0YYWiSH47FOFLOaM5JtiYsZOyKUqilp3oZ4/3rdldGES
 Dt8w==
X-Gm-Message-State: AOJu0YwoL+eFcsFPjI7eruaTB7GpYGydLc8TsDvBLTo6wzCAzSHeUu27
 4Z3hqsq06eeH/LNZWC23vaYPRAOYXrfzW39O3bH97IIQ3Eg29smGG5LL/ehfMEZeS/g=
X-Gm-Gg: AZuq6aLzLpGpejl4/SIJ3KiQnBuNO2QcwA0oBP0dvSRoG32d4bsnTOgPg7tJbVFzdF9
 i/AiaKKuNoo7iqrIS5q8W+bA25gefHZyCbJp5/a7ZTaHZJlu2XPEpnWoVuIrefS7EgX2sSNqgCx
 ysoq+zxyaeOc08lfyHkvTGGl7rl5Kkb+cFC5fLBcySmYNdr8sD8uFWo6AFCMEtky6FmF+qIPee6
 V8WJsMAL98lYeIHPK2Ljl8gHBbvk8r1+7VIrNrnKzJiVI/XSBjxJDJ4q2eteOjHOmN/Ug2drayN
 2BEqEIn99TIebknzzeHhZjaarVnZlzIipK6D+G3uKozIZXmi7EKq836pG9ZREMhrbwN6tXL/pqV
 4X2q57CocjQTCgjC+vv5vg2BgpwzDMS/9jRG2GNoG2O7ci0dwpxlwPM7r8ZrAUlNM72zlssOxOh
 YcIoicSL5/NIDfcGYZqLZLnuJTs9BSSb3bwkXtWWXIBFCCztA+qEDr4YqwgRY2NR80nhH1RU6+I
 LJ7lGMnWH3vK+OzT60to3CP8fcvXFiWFp2CNZR8dOrMHxP8Xw==
X-Received: by 2002:a05:6820:f028:b0:663:23a:cafc with SMTP id
 006d021491bc7-66d0c667837mr3310295eaf.67.1770510464789; 
 Sat, 07 Feb 2026 16:27:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3b2a6c16sm3552448eaf.16.2026.02.07.16.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 16:27:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Suhaas Joshi <s-joshi@ti.com>
Cc: vigneshr@ti.com, n-francis@ti.com, s-tripathi1@ti.com, 
 k-malarvizhi@ti.com, kamlesh@ti.com, vishalm@ti.com, d.schultz@phytec.de, 
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
Subject: Re: [PATCH v3 00/10] Firewall ATF and OP-TEE memory regions in Sitara
Message-Id: <177051046349.295305.12660645263422972585.b4-ty@konsulko.com>
Date: Sat, 07 Feb 2026 18:27:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 27 Jan 2026 13:46:42 +0530, Suhaas Joshi wrote:

> This series starts by replacing hard-coded addresses in firewall templates that are defined in
> k3-binman.dtsi, by Kconfigs. Using Kconfigs makes it easier for someone to move ATF and OP-TEE to
> another location, since they wouldn't have to fiddle with the firewall configurations in dtsi files.
> 
> The rest of the commits in this series add firewall configs to each device's dtsi files.
> 
> I have only tested this patch series with TI boards. For non-TI Sitara boards, respective board
> maintainers are requested to test the relevant patch and confirm whether it works.
> 
> [...]

Applied to u-boot/master, thanks!

[01/10] arm: dts: k3-binman: Use configs for ATF/OPTEE addresses
        commit: 24338c81ec2f689f09d761afbcf28c8661d536b6
[02/10] arm: dts: k3-am625-binman: Configure firewall for ATF/OPTEE
        commit: 27f105fbbda22291173155f105ae5242c6f08bd9
[03/10] arm: dts: k3-am625-phycore-binman: Configure firewall for ATF/OPTEE
        commit: 0cee13fe86b8e2a4e2feb9cb447baaca914c0f97
[04/10] arm: dts: k3-am625-verdin-binman: Configure Firewall for ATF/OPTEE
        commit: 13c54cf588d82b9df073933844443b5dabbdd739
[05/10] arm: dts: k3-am62p-binman: Configure firewall for ATF/OPTEE
        commit: eaaec18f7a189dd5a46cb47b23366301b75ca13c
[06/10] arm: dts: k3-am62p5-verdin-binman: Configure firewall for ATF/OPTEE
        commit: 0c3a6f748c90b88ad9af5c937f2c967cd0d6878a
[07/10] arm: dts: k3-am62a-binman: Configure firewall for ATF/OPTEE
        commit: cb238a6b66ac0f6fe9b1e01d30224c30880ad8c0
[08/10] arm: dts: k3-am62a-phycore-binman: Configure firewall for ATF/OPTEE
        commit: 3c6c2f3f5c228a869ec9d342852e201a7a662968
[09/10] arm: dts: k3-am64x-binman: Configure firewall for ATF/OPTEE
        commit: 31d5d1b378b204f2743e317c44496a3869d0a83c
[10/10] arm: dts: k3-am642-phycore-binman: Configure firewall for ATF/OPTEE
        commit: 64daef1ada4e29a4fe6975bd7ad2f9f128cefe04
-- 
Tom


