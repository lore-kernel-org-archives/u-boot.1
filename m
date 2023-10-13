Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BCACDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 12:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C156E86EA6;
	Fri, 13 Oct 2023 14:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WE3zD9wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46ED586EA6; Fri, 13 Oct 2023 14:42:32 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A59E86D62
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 14:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b95622c620so362015966b.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697200949; x=1697805749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrEQseoQfandmdZHaVAOLfvXz5KXgGsPGECEqRK7cOg=;
 b=WE3zD9wf0A5wYBJ7QoyIU8ZkLBdD1x3mUTFRwzhfwAxunkABfUCVAFyKCNfbUg3205
 Nc9D1W/wOnX8WcLLvmVj4XbkPNc72SqeUH2eZqrxaXpYBWKILEH15bByuY8wiEWb+QIH
 dnisak4yDKt/ef9+464cX7qx91PI1SvC+sHXtTpi3SR0a9w4EeZGjgAJEHaLabJxtF52
 hlmXUTp2cKHjqwPLf1eSZehGS1bCNrekW9DqLJvH4Tu722t8w8bbL/E6IcWxIKW5kA5E
 qwtNi36AdxpI2PXScX1rC7/jkhfw7K7FxSzDqw70rxwfcZvoacqd0ck7Le6AhHlyp9py
 I4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697200949; x=1697805749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrEQseoQfandmdZHaVAOLfvXz5KXgGsPGECEqRK7cOg=;
 b=hh0Jptk9gejJm3cUcUt+Yfx9vw7glxZIUc/c04a9gRQh/S0+4h+6zJNTaZU7TMvKTj
 hq4c9gOsRsxUa60fkoCxHjU5RfIo/dR+EBG6XfiwweDNc5f2PGymy5VxJ7onAINkcf1m
 3cbs5weh+Yi2KCAVxmbl3pI6LP+7IJZbG//55XA27a9ry65aD7dyssGxaGNUX621962o
 iDEfy9qVeWG/dP0Iwh2iPF1sYjPrAT9GKuxjPxNGLwdDFnUUhpvwdlP86hBA7g6m9aoj
 oL4ascmcfzrZy8o6hTDDwMvl2D2FsazCqRavBvFYEnnV+J0sWDQby3UPWXGsyizsARQg
 VoEg==
X-Gm-Message-State: AOJu0YwP7CKCVPvO7x0M8Kv1QY+oD1Huw8S3moyMxkzwSr4MUD1Z/+b5
 0QzcxP48pzukF6AMAw6BA1RKmgp5NNc=
X-Google-Smtp-Source: AGHT+IHsb92snxYuh93LGdips31ewULoYAzEnZIaxS9MpKGmuQBHQJ7Bwrjo/+Kk4quUBXH2N74S6Q==
X-Received: by 2002:a17:906:5a6b:b0:9a9:e3a9:af02 with SMTP id
 my43-20020a1709065a6b00b009a9e3a9af02mr24524028ejc.8.1697200949384; 
 Fri, 13 Oct 2023 05:42:29 -0700 (PDT)
Received: from localhost
 (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 qq25-20020a17090720d900b00977cad140a8sm12393315ejb.218.2023.10.13.05.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 05:42:29 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 00/16] General tegra and board improvements
Date: Fri, 13 Oct 2023 14:42:26 +0200
Message-ID: <169720063880.3883235.16994100616965861860.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Thierry Reding <treding@nvidia.com>


On Thu, 24 Aug 2023 22:25:47 +0300, Svyatoslav Ryhel wrote:
> This patchset follows Transformers, Grouper, LG X3 and Endeavoru
> bringup and contains changes from v9 of previous patchset and
> some new improvenets.
> 
> List of changes:
> - separated tf600t and p1801-t device trees since they use
>   different video path bindings
> - enabled booting from usb devices (USB > SD > eMMC)
> - fixed tf201 dock usb line binding
> - removed transformer board pmic gpios setup
> - refresh USB option converted into enter console for transformers
> - updated device trees for future DM PMIC migration
> - re-synced defconfigs
> - added base voltages setup from board for t114 same as on t30
> - adjusted ebtupdate to work with non-encrypted re-crypted devices
> - attempt to move setup of some env values to arch
> - config fragments moved to board/vendor/device/configs/ dir
>   (requires pending u-boot patch)
> 
> [...]

Applied, thanks!

[01/16] ARM: dts: p1801-t: separate from common transformers tree
        (no commit info)
[02/16] ARM: dts: tf600t: separate from common transformers tree
        (no commit info)
[03/16] configs: transformer_t30: support booting from USB
        (no commit info)
[04/16] ARM: dts: tf201: configure dock USB phy
        (no commit info)
[05/16] board: asus: transformer-t30: remove PMIC GPIOs configuration
        (no commit info)
[06/16] configs: transformer_t30: convert bootmenu option
        (no commit info)
[07/16] ARM: dts: transformer-t30: complete missing bindings
        (no commit info)
[08/16] ARM: dts: endeavoru: complete missing bindings
        (no commit info)
[09/16] ARM: dts: lg-x3: complete missing bindings
        (no commit info)
[10/16] ARM: dts: grouper: complete missing bindings
        (no commit info)
[11/16] configs: transformer_t30: grouper: lg-x3: endeavoru: sync defconfigs
        (no commit info)
[12/16] ARM: tegra114: enable base voltages setup from board
        (no commit info)
[13/16] ARM: tegra20: tegra30: support EBTUPDATE on non-encrypted devices
        (no commit info)
[14/16] ARM: tegra: board2: add generic late init
        (no commit info)
[15/16] board: tegra30: remove nvidia_board_late_init calls
        (no commit info)
[16/16] board: asus: lg: move config fragments into device boards
        (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
