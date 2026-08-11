Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7069BC5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 22:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C221A608C5;
	Tue, 11 Aug 2026 22:50:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l0YxWyZDHLHf; Tue, 11 Aug 2026 22:50:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C7F9608B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786488612;
	bh=1j5I2+sqH+ZIuO88WEj777tIESxXOYZq75nM/nJaazQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cFJDBdb0jWFFSu7+MAjNBHnh4NkI0BreCfTh7tqGMaP325aJObb6MSmmyPLzcX303
	 GRTAfh7laGQgKzWRMuG+gb/HLQr9FeaXiXw6qGiNCIMNqLefbNx5XgL2vw+chBB9gf
	 697ZveRVw32UD6wAeULm+T7HvAREGktPkSNXz3bUviuKtdHInMJIX0RZUMZbWFTEot
	 CpYT9lpIWzqgsYS+dh0UuMpJMmcpvG9b1PtwPdRPZCh+Fc9vqjAQm74kPzNYtci2fI
	 lxJKbfe0LbeCZeF9hcR4TQVxQgm/IuurrgpN/vjX8ohV5HUvjpc8UJNVsxyeHa2TVj
	 DvdLd4k8DiBOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C7F9608B7;
	Tue, 11 Aug 2026 22:50:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 283F51B8
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E94080B22
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJBmCRN2kKpe for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 22:50:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 556AB80BFA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 556AB80BFA
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 556AB80BFA
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:10 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7ee50eb2db4so310656a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 15:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786488609; x=1787093409;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1j5I2+sqH+ZIuO88WEj777tIESxXOYZq75nM/nJaazQ=;
 b=l1YBtH2LQw646dnOnRGrAm/ly8dZxAM14Hw+hcu6f5Cw39esdCWB2/dT02A8dPio2y
 ziPDt9uqncCfrloekaE/d0qYhBrwCIoKZSPppBOCLzX0p/5nGdlRl98DABkfYOzNBrpT
 /ZIcoVgd81jb10Qv5vd1y99an1S+dfiu4GvwFcHyKOqY2cxO00GAnx9NjF0NDgZRq6Ql
 +VCgCK/ompjtcFYOlL7iVASZZPdGK9ZT4dynz8rBXogXUFPM1GkGV+mQYSJ9JChhQAkI
 PQXb603ltQitqB+UcXGiFF4Krtq9aS72DXJVcowGuSZjPXGm6CBQApPBWnf8AtFaKRO3
 0dcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRXSiDNkOgmKHPG/L0gWSod/B78Dx/v9Zgi2efR2mzSCTVFjjwFc/zjT6DTdE5W5+bMHK9+iU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzUG3iXscWyWBQHoozyrnopIpwFfSDUP6tMsV7WuMZU6OhxwRN0
 qcv2b6fMmZeUM8ZwY+IvxOVD+SW+vPhfPLI19rkLAOdiObftswp8qcACbKRrl5CNm+/GsgLd5K1
 0CTEEUhc=
X-Gm-Gg: AR+sD11E6+QvsjBaE378+A2AVAo6ZzGios+4cBmf2lgS+w0QGF8aNYutWqCN62umEKU
 +xJ7q9MnWE/undcLMc1L3TnhQgcphIDfE0DFYlUTgGOH+HHn3V7t6RMGJ/mh0Pf/2cbwdLsJrAc
 8IiozJPStT2E0/t93QVnF8adyJZvvsKGKe2mInpTQUGBDa/BpFbbK+8nICc2fNGwdokJCKHMLwI
 1app1suTGnmabZbbf7dXIxHb+HwAQjhshaLQxTiDmhVccbqsNIRsDFqzlbxDpKdTnPc4wXZ50zG
 sB6pyk6scXEMUOIYC8pmlY1AhMQ9U4XTdPzQkx4yAMPHD4B681qZZ9yWxY2eGUS4wb86eQuloPQ
 fW9/hSHuqLIvxjmcJgFZpspbfY9KfqQDXYKdWlAdTD2YCxeHAggrraRy+BJ959ALwq4O/kTyFNk
 V1daQEzfOoBUeeReAz3ZnqiKRomeiExUq2N66mRZRyxf1tRVAJPbWEICeNEHa/7fwZX8zER1JD1
 j4kbjnZJLmnulUiek27y1Et1y6FkH7H6DQqjCVQIk/PVvLOIrY98xN+7v2tcnSC8DFHBQbtE6WJ
 VguVGDoe
X-Received: by 2002:a05:6820:1c9b:b0:6b0:4e2b:17d0 with SMTP id
 006d021491bc7-6b0b2bf6bf3mr282738eaf.30.1786488609195; 
 Tue, 11 Aug 2026 15:50:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0ad500d37sm972541eaf.7.2026.08.11.15.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 15:50:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins <nick.hawkins@hpe.com>, 
 u-boot@lists.u-boot-project.org, u-boot@lists.u-boot-project.org, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
Subject: Re: [PATCH 0/8] HPE GXP: board information and dynamic DTB
 configuration
Message-Id: <178648860775.3127030.17019919972171091272.b4-ty@konsulko.com>
Date: Tue, 11 Aug 2026 16:50:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786488609; x=1787093409;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1j5I2+sqH+ZIuO88WEj777tIESxXOYZq75nM/nJaazQ=;
 b=DVGxhk8PVR1GsJ1tycAje0b3jEs4YexCjOOJgScZmcA0xSmo1oD7tXQm5aO92Op62e
 YOckcqYF1OrM6BOAsbdjkb50G33trl4b0NJbejDFT4o4wSHjplcceWotiGi1zc6mAPep
 u3lPzEFY95hVXPz5u3SKMxQYb09bLVJW4ZZss=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DVGxhk8P
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 23 Jul 2026 15:30:01 +0200, Tan Siewert wrote:

> We have teamed up with HPE to extend and maintain the upstream code for
> the HPE GXP, a BMC-specific SoC found on HPE ProLiant systems, via an
> OpenBMC distribution called Canopy [0].
> 
> This series adds support to dynamically add the matching runtime FIT
> configuration based on the server ID, and also to display the board
> information on an HPE GXP SoC. For querying the data it also requires a
> GXP-specific EEPROM driver.
> 
> [...]

Applied to u-boot/next, thanks!

[1/8] MAINTAINERS: GXP: Add Marcello and Tan
      commit: f4bfc451ec34db9d3c7ec66bebef88e20b712265
[2/8] misc: add HPE GXP EEPROM driver
      commit: 2b1309286571ff761f356d51c3903c4650adbdd0
[3/8] arm: dts: hpe-gxp: enable GXP EEPROM
      commit: 9cc25e33cc5b06bbc12ac6bbf28ccaabd8a44a63
[4/8] sysinfo: add HPE GXP sysinfo driver
      commit: d44c3a7bca77533427dac117507659e22d5929ac
[5/8] board: hpe: gxp: dynamic dtb configuration based on server id
      commit: cdf6ddb420891c68509fd0cfe7c2b3acd045085a
[6/8] board: hpe: gxp: add boardinfo support
      commit: 732957df8c10a0ff79bbc67f845aa67ac2e8f2e4
[7/8] board: hpe: gxp: display product name
      commit: 8a5b0750f98af2ac70f14834297e92301b693c71
[8/8] board: hpe: gxp: configure PCIe device ID in board_init
      commit: 338d2b47463487666f54d6d9d9f9263ebaff5e8b
-- 
Tom


