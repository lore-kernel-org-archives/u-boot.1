Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72247FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 17:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC14849AA;
	Tue,  5 May 2026 19:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nAHkX4QH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 667D3848BB; Tue,  5 May 2026 19:57:36 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9D48486B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 19:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-42321c8b8f5so129108fac.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778003852; x=1778608652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4XuuIxJoXftAhXEWX0zVN36mSOP9Q9YRjMdQ9dkHz0=;
 b=nAHkX4QH8BCmPc/Z+Wg1D2meAg4/5yJrbFARXXny/PENVaIOGL8255bCM0DXb1mF8o
 CnsVk09S8/EBbCYPj3eZ11MZNLhuAOBnxQHkpfE+7yU33vedlX4ACNCStHl0B732tOAd
 Y3V2HFq+u+N9W5DZ+5wEL3Ne/PEt8YTqhSJl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003852; x=1778608652;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y4XuuIxJoXftAhXEWX0zVN36mSOP9Q9YRjMdQ9dkHz0=;
 b=EQ+jlvPuD5CD7JZ3jhWaQzpEmQ5f8/IsQbwegE/R6JEbs09pHL9BZygMeX0ZpdsXNx
 YAV5R7yWQM3Vpv+EOKJHalKDh94KLepxuAqVHjbF5e0jxhv66aaSq3xoU5fNsz1V6fJG
 4SZQx5BGk/6z6YqRgYddk7Tvsva8PKOdMAVbMQ/crIfvqdBrDb71b6z5XDWXHLU+och7
 TVFyifjtLadcQ8FxBQMyp9xcWTSi05t8jqLdJLdQu27rU6aC/VqTHgT3luDthi1AeCv6
 zr5aDNwCOqaHZkYSVPJIaetW6AeDpWFdrAHOC7gN1PzovRGiiOUqFytD1AzFbWefTftg
 bfow==
X-Gm-Message-State: AOJu0Ywb20SZHK9lF8Zew4EyYQZ46xtifVZKsjuSfwCzeB9J34J+eNqv
 haFbXnpKYvfjCV3tDdKYDZSULZHj2WR/YRJyVabm8+H7p76D4GDbhfl1Tome8KTEVJM=
X-Gm-Gg: AeBDiesuoDQTBpUvOZ6n31OlBuIccIPdwYUnp/lPFXg1xWFJQdbF7yz9Ua+yuXytSrU
 xslr9nJoRJwBZfhSatSnluVxBgCPuF7eG3gGWiXlYhIHS1zszx2F+3y8PrbpNIH7H7vi2oe7ns1
 rX3u0mMqpApEnGXjWP5f/0fiVHQ/QXSSkd8FFJcl9Tb9x+NN/O9GKdBEgDVhmMT4S+4inzhQvH0
 g1T5kAMXzSJW8tjAq36ol6J+MjEK26r20giKnNFTpZWan2XmcW3OlGWuTuOkEKthTRsb/9MIRxY
 mVGKt62S0E+qa7nSBaTJLA788UQucKn2D375EFZG9EpOyQYU4xcmgvzFfHg/Vai9lOGaVjbTDpn
 4a/RPrWQOKATR97PML3mb4ZIXDVBJ3iMmrKNzW1zLI+FLpZKOlXu188xRTgPU54qmAo5Jouu10/
 UE3GwglwpuvDR6FK5dHNzOdNiiHRuWgGw2Hb4YgkhpaiQdEKps7fIoX2AUs+bGOEQtHBMc+8ZRA
 QODhVxKfquMuqWJSAw9WIJ6rdyXfWNQO+9Q/y6jtVJ1CG86SOOaRCAU+QeK8ogFQqDsjLE=
X-Received: by 2002:a05:6871:e494:b0:430:16b5:909 with SMTP id
 586e51a60fabf-434f9b80866mr14525fac.15.1778003852360; 
 Tue, 05 May 2026 10:57:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d324e2sm13561561fac.13.2026.05.05.10.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:57:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
Cc: ggiordano@phytec.com, w.egorov@phytec.de, 
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com, 
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com, 
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com
In-Reply-To: <20260421074523.4930-1-aristo.chen@canonical.com>
References: <20260420145353.3923395-1-aristo.chen@canonical.com>
 <20260421074523.4930-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 1/3] configs: r8a78000_ironhide: Drop duplicate
 CONFIG_SCMI_FIRMWARE
Message-Id: <177800385119.2525131.10521350424253151856.b4-ty@konsulko.com>
Date: Tue, 05 May 2026 11:57:31 -0600
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

On Tue, 21 Apr 2026 07:44:38 +0000, Aristo Chen wrote:

> CONFIG_SCMI_FIRMWARE=y is listed twice in the defconfig. Remove the
> redundant occurrence so each option appears only once.
> 
> 

Applied to u-boot/master, thanks!

[1/3] configs: r8a78000_ironhide: Drop duplicate CONFIG_SCMI_FIRMWARE
      commit: 7c3945a231700e80612bed5bc42fcc8cf545aa57
[2/3] configs: phycore_am62ax_r5_ethboot: Drop duplicate CONFIG_SPL_MMC
      commit: f7f2864e19fd207f743bee104976e51cd3c3b1bc
[3/3] configs: phycore_am62x_r5_ethboot: Drop duplicate CONFIG entries
      commit: e6112ab2d7261dc606f2d25599904f9d20b237ac
-- 
Tom


