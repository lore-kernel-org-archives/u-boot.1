Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BA7C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 16:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A999848BF;
	Mon,  6 Jul 2026 18:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pwth8TaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4387084942; Mon,  6 Jul 2026 18:40:15 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F107384852
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 18:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-43bfe209e45so1501963fac.0
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783356012; x=1783960812; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hPjLIIT6fF/L94A2umomwxZXLkdVycl227K2Q4bR4ik=;
 b=Pwth8TaRcp08NHVqttsbeDHaACtdLsv8CDUQujnHLxvtg2RtFNtKMBGeXqgfEP6rQS
 uzxJHiXcQilRvlCkNBM4cptWLadGoGdFACjX/4fRpD4fO8QyULg7X1AVRZF7sV8uAb1m
 Fyrz4cRse03kTME/y254q/m6e0sCF35wdVopk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783356012; x=1783960812;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hPjLIIT6fF/L94A2umomwxZXLkdVycl227K2Q4bR4ik=;
 b=jQEC8domoIevhDnCgcb78Kyd2XC4xuK15hqBk318otFDvKpstHvMlO2j48VoCNHc2K
 GWjWc95ltOddzZtqulGyeWhpCIOYUaIKj+5HI6AjpxursEiiSNZ3JBB2gzkjnJ/9jff3
 wI4O/wrdOt+6OwmhODS1SfQxZgd4NMfTu5F1eezNpYgmbJcXUk7oWtkss3oMKgUq9LBC
 c+D6mgFRTvo+YaMuSo4oPw+V0KZhIWFnjL15sbF/ZbUAOK7TGY/sZyOp1/NljNsmv4Hz
 45dMe11g2myCtl2EWjnFeVaN1KobI1jmVV+BLRoYvyy0npGyWA3RX7XUyAqbo225MDcI
 84hA==
X-Gm-Message-State: AOJu0YxfueqnK03yVI3Og2X4KwTFedJYZhPLZ6r092q1okyK4hkrsXnh
 AKAGZbqrQgz97KBOJ1A36KikjdnERhZvV+V1WEZ/zysRd7+HPirP57H0gagOGbGdnoA=
X-Gm-Gg: AfdE7cm94YEGErX8yMUryiKAIdda1awTfYspVC5+DKvW05sjEQKd2VO1pNdM3mOb02j
 cEgQ92dQihAlpPHT9H6ZRyt5/VaZlid+VVS8zQFVzgaqmUvJPiK505XnNf5qKedWu+X2NPZ6LJ4
 zKDOe19Rj3ZPvk/jjchd8RWmCj274m55xq4umGmByBj02z4Y3Ygp/4fK8hU6k7SnrKQXGE4kjoP
 78ThtVH6mdvfhu2x7HuLzwey7hyWZiVedpg87D6+NyotFcC83KqmZAbgQ1OOFSev2+hN2BwKniv
 OAKInKAsvmqvA56njE3Z6kDSsdDdk+/mN4IxPnw4EKNKNkK/dm3ptx9tRGgUigyC5LI4tgI1Grg
 Ruaus5jSkouSpVpnluljlJBldE/+uOJg1p3yAkZrESyTuLE4Fsr9DvvAoO4Te59iTeLIYnxEZNY
 LH3xp/q7YFPmDBe/kse7OEJGzjKumXyeLFr5/y/pQZWWJ/FW22VY+d+xgdXIU+1HUs7Dhhk7GKl
 WraWFXVdIOIeA02XXoZXBLlnQglU2Gvnzci
X-Received: by 2002:a05:6871:580d:b0:448:558c:d8ca with SMTP id
 586e51a60fabf-451064cb84cmr795601fac.40.1783356011267; 
 Mon, 06 Jul 2026 09:40:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb67156csm11355120fac.18.2026.07.06.09.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 09:40:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, E Shattow <e@freeshell.de>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Tony Dinh <mibodhi@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
In-Reply-To: <20260705193251.2190705-1-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
Subject: Re: [PATCH v2 00/11] Remove patman from the U-Boot tree
Message-Id: <178335600970.1167284.2662625647640111951.b4-ty@konsulko.com>
Date: Mon, 06 Jul 2026 10:40:09 -0600
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

On Sun, 05 Jul 2026 13:32:11 -0600, Simon Glass wrote:

> patman is now maintained as a standalone 'patch-manager' package, so
> remove it from the tree. The command becomes a stub that tells people to
> run 'pip install patch-manager'.
> 
> buildman still imports the shared modules commit and patchstream (along
> with their dependencies), so this series leaves those in place. It drops
> the tool's code, tests, CI hooks and packaging, and removes the in-tree
> documentation, moving the b4 contributor guide alongside the patman note
> in the patch-sending docs. It also adds a .patman-defaults file so the external
> tool is set up for U-Boot, next to the existing .b4-config. Where the CI
> jobs relied on patman's requirements for the setuptools that pylibfdt
> needs, they now install scripts/dtc/pylibfdt/requirements.txt instead.
> 
> [...]

Applied to u-boot/master, thanks!

[01/11] doc: Move the b4 guide into sending_patches
        commit: 08183ba1af1953c1a4dcdea94d1f6d8f4b5254b3
[02/11] doc: Remove the patman documentation
        commit: f6c56009f6600ad87336484d258849d2bf36d010
[03/11] patman: Add a .patman-defaults file for U-Boot
        commit: a24a86b547700359e46b4ae87731985661fe3334
[04/11] patman: Replace the tool with a stub for patch-manager
        commit: f2cf4315339271d48b40628c04c25be24c231a4f
[05/11] patman: Remove the test suite
        commit: f7a4848a9ca37add093628a3f60fb79201eb5fe6
[06/11] patman: Remove the patch-management code
        commit: 91b94aff149d2c6efe3afa81adaf5edcc6119221
[07/11] CI: Install pylibfdt's requirements in the tool jobs
        commit: d4e3ef0b0ae95406b5c235c06ae8d4b80efdb6c5
[08/11] CI: Stop building and testing patman
        commit: bb74c34fd6439463827db07d0198457f1202ada0
[09/11] tools: docker: Drop patman from the CI image
        commit: 5c2d490539e9c15e863d5d8e476467724c60f87b
[10/11] tools: Stop packaging patman as a pip module
        commit: c2f2085b1540146fd2a229342366622d1970cd90
[11/11] test: Stop running the patman tests
        commit: c8db1555251aada7478f4fbad7e643bed02a8cbe
-- 
Tom


