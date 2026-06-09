Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56291CD8CB9
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8209784942;
	Tue,  9 Jun 2026 21:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FtvZMgbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EADB8499C; Tue,  9 Jun 2026 21:17:55 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237C5848DF
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-69e1eae4eb4so3926775eaf.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781032672; x=1781637472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBXpjVja4CpD7vA+tpOr5RhgTyMIWPE9IexzZNympxk=;
 b=FtvZMgbnoKXtKcyIxRAvrdTaM5lrdBO4SuY+jPI7RCwBZZPDiZ9qeglndd1pUF5D0l
 Sd4RKQWmEzvxsvDPv0SgGKJaNnY8Fsa2FOTBWjlePefAVsRooE5qPBmGVIrzmDEboIrh
 wGo180hLLhbLy3uVmyCWBhmbx+0bP0GdFHLLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032672; x=1781637472;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aBXpjVja4CpD7vA+tpOr5RhgTyMIWPE9IexzZNympxk=;
 b=AoemxUiEKL2pP4cLO2syQsdrdubI7uICqcJnouNaaJQf78x+BgQ5/Tl3dyak9FkEup
 nMiAnGqZWSNytl/yw8IPCk+Wr48mIhm4kEX7UHZ0al3KhNAKmFVSXa4ELtbue6VDriSm
 imm5ung/gv1/i/CAnymMe8ZLuGqeFK/oxmRAUlFuRC/OZMl44+YFa5nvJXn62nouad9E
 4ipyqcslj9phQ9Z3w6zKuo67ZcFnA6VO5APWTeSVDU4AOU9gtynJOF6Ifwt4qaIUxZ6S
 XOBL2F4SbOckJJbpkoSljTbNWWHKRNin1lsyEjzEPc85HqpVK1zpD7wUhK5NHRwAGVwI
 DsoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kpms+iR/JLup7crCxlOQf75vhe9vZyaSDIqFsKagrYtxH6nN7u4A9+u4+xMDI6sAm4RWAuOs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9iAV30URUAEhaKotqUcuOXENEOTl9szemJXhSQAsYYycAHWb9
 esEtBZVv05ktFd87XxOjBzKU/4pRuyhiVjGPC/KFQEJiDnqo70oM9p6J4PJl9PhOgAMm4Dv+9jq
 DLWP/SiQ=
X-Gm-Gg: Acq92OH2dxgdbUFelTPo70oPij35zKEQKX3u93aFlH2NG5+OdnBwdTz4zrBCnvFU82c
 P5hcp/Ljhggz3gG4kVhJMRmu0+CSBnatEXsFoxmIvbdhtL9p8rx2oDnpm6le6tzzpeh74EigkFQ
 tKf2BU5E0dtHSLjbV57RnvWoSpXyinJmCEXAbUJIy1lDBeZg+pYKRy/030LELVSWq9kWIxxrxN/
 jNK/2pWX4iLZ+PULPCi+K+nH4v9hha6O4zSLZCp/+iyJ3UHJRRbd48lFm5+9TtgeWBYyHOqxSLa
 AJ73Yq80uqzo40hdL7YscSaojFLfGBbPvCliRW1d3uc14rmHvS742xocisZrnOo0fr8Y3MVgDTN
 ZmJZLEqpFgkbHcBLb+Dy7R+hVtph0o0VN9Q5JSVlP7X5mM9i3V7BNCsnoPMajoX4vLlkLBvmEWK
 5sSpq8iVpIPCF9wi71jtd5oI1EpKKq7BVRM61AcSWzl6B3CzFO1tW6mckuIaHWcYWDGSojpB92M
 3946JEaPgDv9HUB4SjpOFnLWFCshoPd1BwF8xxPZY3dD2RpKr0KzKVaSiFK
X-Received: by 2002:a05:6820:208c:b0:69d:f5b8:e11e with SMTP id
 006d021491bc7-69e68b84172mr11791287eaf.26.1781032671863; 
 Tue, 09 Jun 2026 12:17:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46405105sm11198449eaf.10.2026.06.09.12.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:17:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: s-k6@ti.com, bb@ti.com, Neha Malcom Francis <n-francis@ti.com>
Cc: m-chawdhry@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com, 
 gehariprasath@ti.com
In-Reply-To: <20251103071035.674604-1-n-francis@ti.com>
References: <20251103071035.674604-1-n-francis@ti.com>
Subject: Re: [PATCH v2 0/7] ti: j7: Update to v0.12.0 of DDR config tool
Message-Id: <178103267093.3800924.68505494878393839.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 13:17:50 -0600
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

On Mon, 03 Nov 2025 12:40:28 +0530, Neha Malcom Francis wrote:

> Update all DDR configuration DTSIs to the latest auto-generated output of
> the Sysconfig Tool (DDR Configuration for TDA4x, DRA8x, AM67x, AM68x,
> AM69x (0.12.00.0000)) [0]
> 
> The auto-generated files must not be modified, but effort will be taken to
> change the tool output to adhere to the latest checkpatch.pl rules. J722S
> and J721E will also be updated in a subsequent series.
> 
> [...]

Applied to u-boot/master, thanks!

[1/7] arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR config tool
      commit: e126a99992aa323fc9d570c879a60e75c039ea04
[2/7] arm: dts: k3-j721s2: ddr: Update to v0.12.0 of DDR config tool
      commit: 9627d70840ababb8d89dc73fb697edefb1732648
[3/7] arm: dts: k3-am68: ddr: Update to v0.12.0 of DDR config tool
      commit: 168681795981a07d0ff301ffb61d9a596127decf
[4/7] arm: dts: k3-j784s4: ddr: Update to v0.12.0 of DDR config tool
      commit: c70fd4e5a291147151da1162effe5e20f6aed413
[5/7] arm: dts: k3-am69: ddr: Update to v0.12.0 of DDR config tool
      commit: fe22382b6454d9e92b5f32343ba8eac2e0d838d8
[6/7] arm: dts: k3-j742s2: ddr: Update to v0.12.0 of DDR config tool
      commit: 54fb646ca42444f0756a6f1f4ecff7d027a70a96
[7/7] doc: ti: k3: Add section for DDR configuration
      commit: 11dc7c06089c2c7e0f720d36cb0335d57aac0ba1
-- 
Tom


