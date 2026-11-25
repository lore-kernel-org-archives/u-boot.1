Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D0606A327
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=THW0COGs;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bYG0IW2+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B6F7407AD;
	Wed, 25 Nov 2026 13:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cmLslkj8A_gp; Wed, 25 Nov 2026 13:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69FBF40572
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795614208;
	b=gZePf5QeicDf6S/KjuHlhSgtd9c3Q+/aOq8LwN2bBjWVTp9RDs9VcydRlnRPxLlSd5Vp
	 3lLIqyHYLzFZj+Ij67TcOusznI0bw0glpyKgDyzfvboxibGLh4VVRTpluZn6Qk/5ZARpv
	 nRsX8Rsc3RCOMCN610MtpAfy9KRpn4zNe1brODOtTlW1bCvh42dgQgQIBCpxzdDgG7O69
	 aIevf1TFh/md/RclCxXqXKAThMW4iXuPqUDt1hhTbj2HTCSTW3X1brCvZ5adogE+s06Uo
	 ofNqDdoxTmgsD9TT5V8+ll2wEG8AybqWgJdf4PVS/Zv8nH8xeYBgGL6NmELqEca9xxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795614208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kI+dqYC5hfP3aXOl909ztD5iR8s6THHVGEdWb6RLpeE=;
	b=P2sI0mBb978SDp8YaLkEhixEy/EjcqoAeeTsXGHyl3lcm5AYwqpFbGiJHYkqM7rAUjeQ
	 kW3QtAAfsEPEgDV3FozRmb8jXu3SAEF9OyoMSC05qb5QgojurOkzZ/j6viuOvTW1CO9kA
	 C5fHGZ1kMunX2CA9ufb3qtJ3agTnICIV2xG2+v3EQF8G9GLN+UtQWBfPG1UKoX1Xlh/uC
	 g9EUfLJpNq8mzOal8TC0v/2hobIC/OXeF9HKqpVJiRieHFMGTs/NXq7MPwUawVVcqVCga
	 U6afQT+UdJWMZjzxm9gASGcK4l3uOnKauLELqY12uZB+Y0ahdWgJ2dmeDzxIyHfQn3Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bYG0IW2+;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795614208;
	bh=kI+dqYC5hfP3aXOl909ztD5iR8s6THHVGEdWb6RLpeE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=THW0COGs25OjcexWDW7/KsXattIWetc5ELgjX6lFX2DBjeJlUGHK81CGjgLbj9Oio
	 HsrKKX3Ii5VI4eDlTOcU9djC4jVn6bGvKuSBzso+zII81imPNF0/DW+73CXjTZhb09
	 BiO+lUy0ZRBid0b4+2S+tFqOpRZwQ4epQB07mtGqVtziGPjtz+iJbV6SF52qYA62eM
	 zH0jOQpdVCFOsZwMBYF9K91D0dnVxWg/ZZis/RdS4qtrrJ+sIaWvSPHksk3goIbxZH
	 Lh13LBvvXEV926bhMCGYMBACHcvja/x7qUYiyoCEvPrFSH1+LzF306dGA0Qqny1VIE
	 TXMStLf009h2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69FBF40572;
	Wed, 25 Nov 2026 13:43:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EC442F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FEDE405A9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ygaa-TXnM19e for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 13:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5BEF94056F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bYG0IW2+
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BEF94056F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:24 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-499f20c7054so3057749fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 05:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795614204; x=1796219004;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kI+dqYC5hfP3aXOl909ztD5iR8s6THHVGEdWb6RLpeE=;
 b=bYG0IW2+qDZkCsY9INLgLd0J7J2lNR75jOdb9KX9qGPgG9xJicsZgi1p6A/IOmi/19
 agt4xMqzYVkRn7/wz9tUp/7FjbneB/5WlL8BqXq0w4x39qf9KbzV3RJUB4YCIDq0xDln
 U+eYR8pci0PvsNit0KlS25oo9/+93dktaLjn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795614204; x=1796219004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kI+dqYC5hfP3aXOl909ztD5iR8s6THHVGEdWb6RLpeE=;
 b=yHVfJUuxslY+0N/v6iuJUQehFOLw4xJH0lhmUT0ATGFC+sst03dzMON4F34ZXx9Vcx
 N6K0HRmsKO05dEsQbRnfnrpgchQLb3LywGxGYtUEzu3xvb2g14+iiXpEri6LgciyOSsI
 1QcdaPQDujIBxv2ggyu6DInXY2R48Z7FYoj9Y8uWt1Q1gKVVIIbACNJKPempiojZxO98
 SYETvkppP6oevfOpEzZa6ieQlOEsZvk3NfRRv9Pa1gRJOJErFFSE/DChTcHuR8VGafLN
 ylMS50mtjTl2KM43wal4yqRtGiEXg2SFV+7k++91HWJdGylkoORIOtfLmIhFrUsvmmJm
 mOkw==
X-Gm-Message-State: APuU4Z+kFh6HXXzMLf4/s+7N5/QnkmmbjKknoGup6pSMNuamZKFdXz72
 omHOLDw7UIOBDdeAFoJdf1o6GpC1wZAS+DagYWHlPzF3LE1f7S9PJOXfQk83aCwdoOxJO76GZ/O
 KGbBJ7aF9QvEo
X-Gm-Gg: AZFdTZeM3txKtZVtIYesUI+R6FD3mGbQruigwbIZnzWXB1R0JIXk7pdm5zZfIx52uzo
 mK39BLyWuRp/K0ZfNMQsr7HJ/FUVv6z0lLEpqEX47LQNV+KEyHdSGyu1d1zYZxuEk6x/06RqcE2
 WQAQICTCslu0kWJvWB6DwokbYu2Xyx5tJlcfLLVeE+hkpijK6jL7mul7ognhldmaSmhZN/qrbOw
 vmCGXkIGXIoWom64ju9xJzppsujMlyUVQbhwHSZXN7cu7iWZiFVJwnk3o8N+00jhIu8AuixEmLw
 0wZUdlNqwoGfcmxPXGNdKhvjWU8kfLLR2EA4X9PZIJkHK/W82EVA2MnYScPTmUOwXIQjrA3Qkz5
 uG47xyCLwqvejiFv2stO7xbasv8IuMcLCGjg8h4f4PCePh5/lmYoHP6Xh4Nv4Nj7jnq9Sr4ZlQX
 652XrGXtw2Z9/34c/UGanpINyeWAk8wgQVuA6ohH4XoRNgktGKsdrAz9wKeOQ+75KvCcQWbRau7
 FEforB8KiyRx/GqeDXYd+gcZjuzbQZ7wERMhBoPrjR9lelxb9DZ9aKOmxTz82NEZsOuw5ZIPwNA
 BUmb3iZyYRiy6mdYYyDS6br/CIKLBzCL3ZpmE5LiSEjb2oLqpW+8sc7Cwzj9Jgky/LDkv2s5Y5K
 A4TR2WmVAoCDnkvfuHfS/MdM95bVzTGhdvLGZRbl9ePyhhsVkodXyTFJhrEQKHSgO3WQpQ0hyLk
 iazfggUQv7O2u1DiQDHWXqUaGIPNSj/lkkv40RVn33bLfAyYMoOleDLL4=
X-Received: by 2002:a05:6870:7008:b0:49b:ef98:3f62 with SMTP id
 586e51a60fabf-4bc81d9f7ccmr15904588fac.35.1795614203892; 
 Wed, 25 Nov 2026 05:43:23 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5b07d766sm16204806fac.2.2026.11.25.05.43.22
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:43:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH 2/3] Dockerfile: Be more polite in two git clones
Date: Wed, 25 Nov 2026 07:39:18 -0600
Message-ID: <20261125134317.2479815-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125134317.2479815-1-trini@konsulko.com>
References: <20261125134317.2479815-1-trini@konsulko.com>
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When cloning grub and qemu, stick to grabbing only the tag that we
intend to build. This both saves time and their bandwidth, which in turn
makes our build more robust.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index ab001a4d34df..d5f1f6d697fc 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -155,9 +155,9 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit, and LoongArch
 # 64-bit
-RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
+RUN git clone --depth 1 -b grub-2.14 \
+	https://gitlab.freedesktop.org/gnu-grub/grub.git /tmp/grub && \
 	cd /tmp/grub && \
-	git checkout grub-2.14 && \
 	git config --global user.name "GitLab CI Runner" && \
 	git config --global user.email trini@konsulko.com && \
 	GNULIB_URL=https://https.git.savannah.gnu.org/git/gnulib.git ./bootstrap && \
@@ -241,9 +241,9 @@ RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
 	grub-core normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd && \
 	rm -rf /tmp/grub
 
-RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
+RUN git clone --depth 1 -b v10.1.2 \
+	https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v10.1.2 && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
@@ -397,4 +397,4 @@ RUN /bin/echo -e "\n[toolchain-alias]\nsh = sh2" >> ~/.buildman
 RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
-RUN git clone https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
+RUN git clone --depth 1 https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
-- 
2.43.0

