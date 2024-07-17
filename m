Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DF0C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346FB88A8E;
	Wed, 17 Jul 2024 16:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="LP/Z7Mpc";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9zK8YL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE09E888FB; Wed, 17 Jul 2024 16:30:33 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E71F88A87
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 8A2561140140;
 Wed, 17 Jul 2024 10:30:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 17 Jul 2024 10:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226629;
 x=1721313029; bh=dHJrCMHVNZN7ZWukk46VAYTMdtRotM8I7rbU2c5JXNQ=; b=
 LP/Z7Mpc1kxlw2sCMaWxOBBEp3HMz9nNIvkar32MhNJ4D1bGSlzptWUxXcjFFsD0
 MViPsOUmrdNI/hE1yxF9RGCFJuPvofFMA+SBiKgIiKUvilk/lGsJmSTWJ4YrL4Jk
 rQT72AeTkJMOFC+eUZwV7gyegIjTO7UDS124EO8wNXDpqRc98uUPGkrzEAuKXiZh
 DEriMTOkDgJU9ytgnAqjMeDkN/t694Q07O0we6ctEelCJbvF9zeCBqT5374QE/rE
 50yajQGXlAxfbjrYpYjKj4xmwGcKkyrroBd2qqTYmpZqrQMQjLsyOvbHe/7ozRN+
 eqPBULiaKQx/te4IXKgRHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226629; x=
 1721313029; bh=dHJrCMHVNZN7ZWukk46VAYTMdtRotM8I7rbU2c5JXNQ=; b=u
 9zK8YL0OHhQXCMeKstQGaMZ0Czv14e4eSqeH5VPiYZjyxXZ5yUs//blUmBok2M2o
 qZsq6Vim0hsCfz0a5GwPvWPCTEa6tfkOOuCpunAx6C1QX9P9rahF/dKen1aT1I2/
 soO08G8w+L52hS1h5EWcUXyDWaXRt/aPUaObKzQ+Vf/g7YXEzpoXiNJeHXvrnwUV
 zd0xZiRrIoIvtW63uTu+eKHZlUp+rm7QeoX7KnY66zvWVWKNh/8V/iPhukH/NHmC
 FZeYw13pM/qQ3thN8bPSP94Nn0PwbxVskLK3pOBI9mHnwp+9njBosuCng6OK7qCJ
 qcsYYp5kLqB4NDyn7bTAw==
X-ME-Sender: <xms:hdWXZvdnyazMsdxbGZhWOGs6wysGTax8AfkAc60IUjUhcDw0eokSew>
 <xme:hdWXZlNK09bDbi40_3Rpa3RWt1zp8aY9cEIV79EeWnFIq-5CAjqNMo4yzgni9Ij6O
 F36ZXrxQzX4y_DeqvA>
X-ME-Received: <xmr:hdWXZoiPocIiZuz8yK5dlIZwMHOMnaznLNs12AK11ksBDZXnZakynJFv2mP5aFMbGc8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeetvedvleehtdfftedvjeetvdelvddvfeeuheehiefgfefhleff
 udefffehjeegtdenucffohhmrghinhepghhnuhdrohhrghdpghhithhlrggsrdgtohhmne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgig
 uhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:hdWXZg-5AYyY66Xr7rbEQH3t15naCSGD02tmec7OrnWAPHuCuErLxw>
 <xmx:hdWXZrsJFwHYDN7mkBzvXuqe5cg-ARqOOJvfABAvGMVL7RKbbijA4g>
 <xmx:hdWXZvHC18wx3mAtf77kmDmFKf82vRYMrhgfjALhMVNWPmG_iCOp4Q>
 <xmx:hdWXZiMYzDcPN2V_CqautgFY2d-enf1KG03s2Pi5NSSrJhJrIq1Udw>
 <xmx:hdWXZk8PQPL86k5zHe2E0sgcUe-CRZcNxLb523Ps26iepBi27K42uJDi>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:26 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:23 +0800
Subject: [PATCH 12/18] CI: Dockerfile: Bump QEMU to 9.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-12-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=HM2LBNgzHWDaF8FdxyCvLf+IKD6xpvG0Knu8BlriYVE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV10Stx58tqSi+zTHwzXC6ozTD92eeKdq27EpTg+cZ
 U9wr55b2lHKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQATMXdnZPi1ebpgJuvjM1s9
 jgu8WK8ee579t+zUS1pe02s5GNol2S8wMvTtviLKOquv72Fhwq3ID49uvXl9+7zP8rleqa+fMEY
 V/WQCAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Previous patches had been applied in 9.0.1 so remove cherry-picks
as well.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/docker/Dockerfile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 8e144a2b64e9..8e242d08297a 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -184,10 +184,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v8.2.0 && \
-	git format-patch 0c7ffc977195~..0c7ffc977195 && \
-	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
-	git cherry-pick d3c79c3974 && \
+	git checkout v9.0.1 && \
 	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu

-- 
2.45.2

