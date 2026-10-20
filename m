Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9F606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aQds9c77;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=UtIa5eYz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBD4C40952;
	Tue, 20 Oct 2026 17:26:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1xC-9eP1niJE; Tue, 20 Oct 2026 17:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1138540930
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517181;
	b=LaMsth9Ap5RxIetFFCbcFwHTkKBGIaS1593kmIsmsCaytatdKPAH6x0F1AyMO2DcQJQF
	 SeNziiczHOjktST85cr1S9ZqG1wT+gDoo7WzArS3x8aHodx2vlL8KbcsjC6BA6bM4oPPz
	 YVlCRbSXnL2j1zpAHpwkenxbeof2fks6UYH8tfufcLCqflkL5vnuhCjpIrKzxPUcUuvAB
	 AlXIanWeod6C/qinhXdaaYJdkgzq6XTOZ6dhzqTHTvHYqz0jYIbmkbbIcav64voKJE1bs
	 wzNKK4Hrj10T4/z+cbWXa2T+1iOJZTSajmqGMnvo0RXoBn4yXZlQLAwGHd8zoXTqJGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517181;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F+tDMOSrXba5CMLbDTA/wLbHx6hLDz1ca+A2C7lYA9M=;
	b=F+jjMltGO2aRmcY3LU4dG/rU9jl0GoGVpe9Ge+rQclsiATyHYEDGhRFKpHbD34cfrXlv
	 hhM1ijYTjciAHGFT49O42QGpqFzTpBfgrDJ/2SWLOF/NHKKPWYE2VbLxrwwIxSWYUeXSo
	 NsK0GJEKzqojUjUqJ4RsKqfaAg4nAFiC6/dT3WLzZYTjUJ/7vYN1WBTkzB+jyKkPXk4dv
	 YTeqcUyZo2pdhpnnVxneTLr3zMG1o3FQCAuYYkPOWrziO0E4UpZdT8ShGjRJ8kmi4Cj29
	 iGn/LoOyi5SJwssJ9dnS7PfRNcqPOVmaofyWLG9S3q5qe0P6IQV7gQ1gTrg0/LoYsjw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517181;
	bh=F+tDMOSrXba5CMLbDTA/wLbHx6hLDz1ca+A2C7lYA9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aQds9c774dryGzNSLe+JYy5ZVKwUT5VLZmSXcIsyxMXoGrnAvfO+0Ocgkj5iKMoZC
	 Bqm6ITfwlITtpooumrWIiV9v1USpcyhyOw9J6tkDc6FNk46MpyxKKL+kU19GDUTMk2
	 qq9x6DIar+omeeqnu/nFn3hp73Q2w4br7fj13pwH7d6kMl6Pc0XA+Tbjg7AopFfELp
	 ZmNZyGwEc4X+DG8CpkDl+mbjzfQAijCNBO4j18Xb+3FeFnCgfs3iAWeti9iN6sw5Q7
	 o2rTA+bJc+IWX4l0GhO6J5MQEL84TFf03McNYl+DEbR4T1LmUhBeN3wPwMSD5zJw0F
	 VOFm2zKP2vbpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1138540930;
	Tue, 20 Oct 2026 17:26:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 842D7930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75F456078A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8nvp2hvRg-pO for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:42:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 801356071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514548;
 b=Y3ogSrlpy6tqtPcz+LajncG24HGLceOqCIOdRA4+MVZZyAmlrahrB9DpmBaJM70Bgrb+
 CnV92gLo6MBjYBRp4Vwe6oxpgoxW2JyusLDX3htrLtZMa1J7PR0wgOPngcMNSKpK/sd+U
 Oh6uiNs2fhreH31idm7IsZFF8maOeUpbDzcxdVRKCLKQw6LuJ/LokiFcsV+Ai55nc2lwX
 SXzucPmjaz2cOTFBfYfl9sWx7ShXKSlM+xYd6yRlfDD2GqPoSq07NTvHbrvR9mUrMR4Yj
 1LyvSvatvmC52nQ3L2NRTOOn8vqM/7rFxUbBh7+NmgJwaY1CBWeLQ+IiIIC89OkKm2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514548;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=F+tDMOSrXba5CMLbDTA/wLbHx6hLDz1ca+A2C7lYA9M=;
 b=aytvOIYY2/d2VqdgW6DEc4ZJd2DzTKYCCfhQGYKdIOiXGnR6Oh3kykIQHAebN9cWOBok
 IM1mtgwyFDiC7a/QpNk29Qidwlr6GuStRkYI1erSu7gBfKs1/ZTAaY7t1rkAUSIJP+t/Z
 tj8DhNCeUXOVOlCPlNDDnUgARG3YHId9LJiJ6YW+fLPzwmRSTnNPZ3yx06yDhruW4x4F6
 ioW8gaksd5yr7+ldzl08uQ6oOomxmc+wy0lvj0ZbBFm586wsGV7pKw5IgY9W8rNjMErfp
 zbTWskHXhIxqGNFi9tijP2HEqyeruv14zwjbvfIxiJCBPePm+rWVcVk7KI/mT1ttpEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=UtIa5eYz; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=UtIa5eYz
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 801356071D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:28 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so29041785e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514546; x=1793119346;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F+tDMOSrXba5CMLbDTA/wLbHx6hLDz1ca+A2C7lYA9M=;
 b=UtIa5eYzdGdWQd4sbHojVi1IG6MyufN1OVKuYqexh7Qkc1icsemSaSFD3G5wxSYFY1
 UPzbeo3iriPJtbhPyaCOrAKyeJSVz/nJnqAQp/ysJ5CKnXsLjFLdsW/2sjmsyRLY4mSE
 MUkmTt5QKwJxz9cMALhVNFpTbN0h8EsxCQbQ/xQ0acpPRwYygFKJ4kubyu9C1sIxY92Y
 5/unYZUDIUdE2HqVAzqWXqeRYH3bJvSKm7pIQkIHt0/jPEm2zOpSiVGHCVzdmuFcaFG9
 0suyI0Sn083puS+KyN1V+BwlJwAiK6RX4UTIgKb3aOGh5sGnLSSmW1EGGFme4q20gGhE
 pf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514546; x=1793119346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F+tDMOSrXba5CMLbDTA/wLbHx6hLDz1ca+A2C7lYA9M=;
 b=jCP0oQ0BaAAiMkI1RclSv6z7UbP2JxSbtvuIp4kM4WeUYensAiSJjZxAJIdvkkhTAb
 Hq6bYVhVDkmgWBdGPp7OzS6QEjnnkxPIdPPcmT/7L8HCUo02+xhth/wxPhVQr/TUu3FU
 KgB1ykw9cMGoWovF6j4S/Qfn+23ML2SKchJ8xCBVnAsXOVDf6ex/nyEho4AnYsZ8fwCc
 0csInGrEB2tPBDDmjkkvwf6x0bXh0DWvfDxEjcW/Dn0Bexyh32qWIdC197LdmUFnnjn0
 mt7iH32x+7Ic73A37OZ06t0mnxyHOA56u5Jgv5XILnm19Tsdzu+1B0jecOT539RJnaEi
 oj5A==
X-Gm-Message-State: AFq9FYK+xQJdvsne5Lw5jKwIHwLReij18VzYJFa3noypmWxX+gEHC8ce
 n7sj71vk5zRQICL+AV0nTSH3M0KJpkSV3WeJ+J2t4R3xjnn46irLhkhfijiKJND492Y=
X-Gm-Gg: AYBFou0PZnWTj5ZUYAtg+029rxMGEfKgm2W4vax7NXzz2+OtvKUwDzoHicC5WndwYHv
 3OKsLYt1KkwKah/RvJPd87vqerFwCRQ11vuLMSdWAHKT3aU6YfsF2ckGjAVEqXB7MxdiS6gdD+t
 9Poll8DfRHWLAODDBujv219h3jj8pvsMYXKeuK5RUkcmpA0dEFLLW9T7v7LGQAio0XdAxsoCBL9
 Za+r3d6dZ9bXn3S5JnYrkJzREPoRLJdDZD2CvmWlhN9eUaKvkOPCFfW5nFRrSl4d0sVEzcpgVPE
 OkhoZmbI3VU/qsd86dRTLd65PrvG4rDZn4+cEVYdGIUdZSe/ns/IxeWTxPOucXU/Syc29qFWu30
 J3/Ynu/HU8djYdBslhrM7zV7T8X2E/zDxxnSsPZTCi1/Ligl6/cM4Y0cCYlJeCFsgPYwPflVvoX
 g8NusebyHDZJo+FO69IUkaXiZHZIiPoBRd8dEj95gexLDkuMTMq5MR11KogpQdS+8TEGlW5Ppf7
 pB098+lKQbdZbu8NFr6dD+hm3r9DE9OLVwNptVCVm66c0buVLD9Jj4809RGp9P9
X-Received: by 2002:a05:600c:8219:b0:4a1:85d9:13be with SMTP id
 5b1f17b1804b1-4a1d76031bfmr266418805e9.20.1792514546049; 
 Tue, 20 Oct 2026 09:42:26 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:42:25 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:58 +0400
Subject: [PATCH v3 11/23] sandbox: Move SYS_LOAD_ADDR away from the
 bloblist
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-11-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=alchark@flipper.net;
 h=from:subject:message-id; bh=MOENpO/+fnyMFda0q7yIvJ0FeufmLa/SW35oKYvBvrw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7nq1Ze9S7OX+rcu7L85f0qOh5eL58lTfzhYRecG5
 u58vWnqnI6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx1jHiIGLUwCm+kshI0Pfzl2F2defPTE8LuVgWfb6Q3+eou6uhikzFR4JcC5Q3byfkaG939W
 XX7lWf0b8ZoWLyvc9DjnNmh4eadgrteUpsyXbAXYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sandbox_spl and sandbox_vpl load at address 0, while the bloblist sits at
0x100. SPL stages compressed external FIT data at SYS_LOAD_ADDR, so even
the 2.8K canned LZMA payload loaded that way overwrites the bloblist, and
the next handoff fails with "SPL hand-off write failed (err=-2)".

Use the 0x1000000 that sandbox_noinst already uses, which is clear of
everything else these builds place in memory. This also moves the default
loadaddr of U-Boot proper on both.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/sandbox_spl_defconfig | 2 +-
 configs/sandbox_vpl_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index b1112fd45e74..46036ea9f9eb 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_SPL=y
 CONFIG_PCI=y
 CONFIG_SANDBOX_SPL=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 07cf968f8ed6..39cc8e266ab4 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -11,7 +11,7 @@ CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_TPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_TEXT_BASE=0x100000
-CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_SPL=y
 CONFIG_PCI=y
 CONFIG_SANDBOX_SPL=y

-- 
2.55.0

