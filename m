Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F260A2604
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C9NIq16M;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=SLqyqdwD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TDOpDFvf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 600F860E97;
	Fri, 20 Nov 2026 19:01:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BF0WgrHXELqV; Fri, 20 Nov 2026 19:01:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA0A4606C2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795201289;
	b=HjR8hUw5yo7FkukU5T7mi009hKw6pVUZ0UsIJ0vjYGQshz359zltvIz30RJcJBAj7FuL
	 hg0tws66xGG79T6DuYr3h9Zd5AR4ym9kFhy21vSfMlU+3Pw1pEeGjkuSGZbM2M2tfRWCM
	 NfF16PIVxMIE3ucHE+/Kcw87cyHbpXMYFWVBPCxaifi/NGMTHj5JVmVJ40htrCnFZRnpW
	 gMmqyvGeALVvUq1xCwV5ken9M1lKMpHO0i0T+iDfXnOhadtWW5AfGTuAiB+ZE6WBOK6MH
	 T8BQrNFCPbIVP1Jz5gIX3VGdLQlGF2d8YDsmVOjwauw7pBuGBO8h7NBXIE+vR1nFRgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795201289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:DKIM-Signature:DKIM-Signature:X-DKIM2-Info:
	 DKIM2-Signature:X-DKIM2-Info:Message-Instance:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uO8hhcf6pNq2EIeWH6GAWTYoNfq5iN9KqfrBWd5euuw=;
	b=Tl3yIxvyNd+Gb5mmfvy0FQ/AncrxpVv1Vh6BRYyNwsKFAj/lW0wWn/VexMb6NuduutsL
	 eOb7hjixHpgobFEfjdM3GALY2KxuG8zEb7/fs1htxaJCNzEtqvJ5FIWo5/QBvibHwpP8D
	 397TisoX3HDvHz3/9Q2JWH/W3SU1WblNOHkdPfz2C1oz6KHxWV3UUz3pB+crabAl9o5vs
	 HOOAsvAj4JW7cWz+Hcgjam0LChxqLbN+45TMqscgEj3Mc/ZEbmYnQ8SKOuct5na2Dgtlm
	 GOBcQ3cdAg2goswaq6ktccSYhlHVC6vQFXKrBqUJ7lxCSUHboXzpWvLz1QzM6XkWTVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795201289;
	bh=uO8hhcf6pNq2EIeWH6GAWTYoNfq5iN9KqfrBWd5euuw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C9NIq16MizS5czZdeQqF41I3bkLep2MLwac+wVGYyvPHVtPYw3S4LApjSsAz00MZF
	 HneWn+83yNFsx27T90SdSMzto969HvnTzYGfZ4N5xQiQr4s6h8vvOFxiNa35CDTSOR
	 MpZ+HG71x+PWK11qu79sOuU277Zukdnrr/bphD/9gb2FmT3M3GA7x18HlUdF4atOHy
	 dttFcAoaza4ei0ygTj3LJnoXSprSuI3Xysqvs42mpJo7up1O5QWN2ii85ka9sQ+3FG
	 hZ/pzNGMg4tDaDQra7xp9z/r7Nz6FXFvVTMSs4D1bn6NqRv1RQxciCJ1wqWxs31BCA
	 1LqTrxyTuY8/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA0A4606C2;
	Fri, 20 Nov 2026 19:01:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F814169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74D34400A0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pQB7pUNtbuH for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 19:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 93DD94004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.151
X-Greylist: delayed 484 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 20 Nov 2026 19:01:19 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm2 header.b=SLqyqdwD; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=TDOpDFvf
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.151;
 helo=fout-b8-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93DD94004D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:19 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 35A5E1D00466
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:53:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 20 Nov 2026 13:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1795200802;
 x=1795287202; bh=uO8hhcf6pNq2EIeWH6GAWTYoNfq5iN9KqfrBWd5euuw=; b=
 SLqyqdwDhryIllE1fuISmYAqvC+6nz28MW0qWHdkxjWGmJOvxV+5khxWB5lEWNwg
 Dgr8gtJOHUvz+TobVFl7S7aO+CmtOZ6wIAtyEeleEiiVW8uWrYINQlLXBsvSvnYD
 0OK1orLLcklFV6QIyKOobg3U9pAwU2osB/HiPDJWcGjouq+Z0+GXXE1t0BzyC+O7
 +mUyoAHFgaug+zE9sh+Mmnd5Y60gzgEtaOTgVAvRZBsFuI9YCfv7100wlW/8DQVt
 B5Gskn4zr9nOR8ktBop8sXKv0nYNDtugx9kbR01g5E3Z7tSLxUNaRjMQ57bHiXQM
 Mng3EI5tyS11jjqVT//ouw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795200802; x=
 1795287202; bh=uO8hhcf6pNq2EIeWH6GAWTYoNfq5iN9KqfrBWd5euuw=; b=T
 DOpDFvfJZxTg7Vb+x6IA2XoYgZVMGhRSo6FOIAlI6pFc+ztNKZkka6q4215aNr4Y
 xlmujFT0+bsPilGlTXFHbaVbH9hmVD/wu6g75z0fRBVPUWTctJN0XKpwP+uN/0ZG
 oeB8Cecg7MyQLD+rBSeSteBwI9+msUPPjk4dKvG4AkcmZU0imX66D91dpRBggphX
 f7qchFwa0xc6mBeOY7XmycjDQkaMchQ0/v0rT9/eFeSWgqZlLu7pvY3/ePbR9ZO6
 Wrv2VMQitgE028XhCC9H/Bj+8Mz2OeDkW2C5o+57AAu4vxIw9rskH0ylM1nzeJtQ
 TBiPsxO2ME7mcUvMA7V0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795200802; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+;
 s=fm2:rsa-sha256:zAZZbAmvfa5+g+stKwCTiN29uzdK5A/vcTR0wVTZmmNVw1C
 QGASHjzapE6uvwzxU8y5dtq2ZcYMOmIRTB17wrhIlM78CfsDEhh54th8JGW6tTQ7
 NewwgeV3Obco4jLKzzhl6yn9pHfKpESd9K3vB0qj0hzmJPFL17ebKgCPtMW5F1O0
 8wRY823wKiGWFI2g7rC9CTsmAVHhMXAs0+3GY8LpxH4si/F8Yms7Dv2yzAAmNOAw
 LuphSs2WYVmNDLdK84qO++7Yn4Zv3II59NIJ8QKg53SwQ2hKQ+obOhnXDNrB/Tuy
 9Ejs+alhfmkIg4oFwU9/rfZGpBUOBxWpUQcAMyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:HfMXGcECEE3NTvgWgkUBgIGdd7XI/kMjzAQtgz46wSI=:BxPgJ26EiLxcWZaYK1ULaZMu3i0juzxwFRxRYwvQpuU=;
X-ME-Sender: <xms:IZcAa7FJSz5KdT986jHFVDE0AJ0m9jQbHeI60ZdYM9RMk-4ReBdoWA>
 <xme:IZcAayWEWAwGvROehNRWVy_eyZpvJvsEiAeKEGio6qj83XFdK--kdjIQzzI17J-5b
 3T7FV5QFua4wf0_0l1Uv_i5xCwypcycWSWbwEduH2URy9WKaoqEBuY>
X-ME-Received: <xmr:IZcAazwQxNgWQkeYFiRtxplmE7rPv03dZfqfC6a2mj7-4aQOomCOyPpbs4H_e0EuPbJCVzWRLStBbR8hZuB8VsNoueg_nybN6-fkHQ>
X-ME-Proxy-Cause: dmFkZTGapyfSQRDw4r21J1qEmKy1ptk4WwEgHmHSCgto70IUJIdu25VXg5VrJoddqn5sG7
 G74ftYJhv10VDm/fJ/UBP/BaNn9qbnl8BcgaU49INNj5QbefiGNNXBGUBIj1SCvmMtkfSY
 drre1DpfkD7EK9AoSKGsu/JlKf2v3IMM/lnkwbgeUloBvcYaZVkErlg0zolb7jtBKhFA75
 3tMgT11HL0pzOUNjnlnF1pJs0y5z9u2Aw6IZLkL6ozCdM24O45gub6qxCkAQk30fa2l/4y
 yZgYSEsszfN9aOUiiT+VsEnhmC+OQzOOmfhzmUSIcc+rztYL04ZnJZ6gocKXWtMfreFbbI
 v2J8RTbxyJBmArwbc8x1BkWW0HCWVPtY/mx/w/iH7BE3i3LUzT+DV/xYG0t8Xcms2T9Wdg
 vlS++GcIIMt5L2hLGQyCyfsfE7GQtBmRJwUWhi94o3w7YUuoY78qSWNPlvXoPSafIgk0Or
 xtNokyMgk9BrppRFleqLlMT7CA2mT3sJk4bkEFu3TanTjdfkYxeThU3ocmhPL3ozLhb+4q
 aP8XdI/irtE3el9pIoicz6ZaOSqaxZdL+zskphwOu7mDN1EY/Uv2muQkwCCpT5gTCMzsM8
 RVNqQTaciC5lIVhzS1+p29lntg900yB4+ajSuGqXFdr2EQeWsnTzfsybrRqg
X-ME-Proxy: <xmx:IZcAa3TPGFKpvCjas7Fku24ml-gS4esnGKIux5VrUR2RDXecuovGBg>
 <xmx:IZcAa_jcpZib7hJVp-eYuL3gBgO5iEdqz-AnAq0hWFeAkniKgyh-iw>
 <xmx:IZcAa-nFefoyFcE_QkVpaxs3rSvql8FQV1X9sAetv06c0lslJvYuQw>
 <xmx:IZcAaytvkhUPvluFaZ-yrgs-I7RQSsZjOy7_hQX3jKunkIz0ueZ-IA>
 <xmx:IpcAa81rDmXR5d1F_QIgpfDzR00Rfs0AG6FjShSz_WvD6SdIcZQ3M6F_>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 13:53:21 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Nov 2026 19:53:08 +0100
Subject: [PATCH v2 2/4] arm: apple: Move memory maps to separate files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-apple-t603x-support-v2-2-606b4f5fadc5@jannau.net>
References: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
In-Reply-To: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, asahi@lists.linux.dev, 
 Anshul Dalal <anshuld@ti.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=41126; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=BxPgJ26EiLxcWZaYK1ULaZMu3i0juzxwFRxRYwvQpuU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhmyG6eIFLUfStj5/o88U45HkGvpc5eb2VxkeHQVvnhjv1
 J+wXyCpo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwEQylRgZ7jTF8kt2xMoVqqUn
 KEeLSH8JT5dv1C5eLvnkpP8iMbldjAyvBTm/G9+unnY+pJv5VFUhI9cmAf6gJZ6Xg/XvW9+WCeI
 EAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The hundreds of lines of memory maps make "mach-apple/board.c" hard to
read. As the list will grow hide them in separate header files as
suggested in [1].

Link: https://lore.kernel.org/u-boot/87a4oaypsk.fsf@bloch.sibelius.xs4all.nl/ [1]
Suggested-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm/mach-apple/board.c        | 739 +------------------------------------
 arch/arm/mach-apple/memmap/t6000.h | 104 ++++++
 arch/arm/mach-apple/memmap/t6002.h | 177 +++++++++
 arch/arm/mach-apple/memmap/t6020.h | 128 +++++++
 arch/arm/mach-apple/memmap/t6022.h | 225 +++++++++++
 arch/arm/mach-apple/memmap/t8103.h |  80 ++++
 arch/arm/mach-apple/memmap/t8122.h |  88 +++++
 7 files changed, 808 insertions(+), 733 deletions(-)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index e74a5a76919a..6b3a0225f9ad 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -16,739 +16,12 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-/* Apple M1/M2 */
-
-static struct mm_region t8103_mem_map[] = {
-	{
-		/* I/O */
-		.virt = 0x200000000,
-		.phys = 0x200000000,
-		.size = 2UL * SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x380000000,
-		.phys = 0x380000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x500000000,
-		.phys = 0x500000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x680000000,
-		.phys = 0x680000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x6a0000000,
-		.phys = 0x6a0000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x6c0000000,
-		.phys = 0x6c0000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* RAM */
-		.virt = 0x800000000,
-		.phys = 0x800000000,
-		.size = 8UL * SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* Framebuffer */
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-/* Apple M1 Pro/Max */
-
-static struct mm_region t6000_mem_map[] = {
-	{
-		/* I/O */
-		.virt = 0x280000000,
-		.phys = 0x280000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x380000000,
-		.phys = 0x380000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x580000000,
-		.phys = 0x580000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5a0000000,
-		.phys = 0x5a0000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5c0000000,
-		.phys = 0x5c0000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x700000000,
-		.phys = 0x700000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0xb00000000,
-		.phys = 0xb00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0xf00000000,
-		.phys = 0xf00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x1300000000,
-		.phys = 0x1300000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* RAM */
-		.virt = 0x10000000000,
-		.phys = 0x10000000000,
-		.size = 16UL * SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* Framebuffer */
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-/* Apple M1 Ultra */
-
-static struct mm_region t6002_mem_map[] = {
-	{
-		/* I/O */
-		.virt = 0x280000000,
-		.phys = 0x280000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x380000000,
-		.phys = 0x380000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x580000000,
-		.phys = 0x580000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5a0000000,
-		.phys = 0x5a0000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5c0000000,
-		.phys = 0x5c0000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x700000000,
-		.phys = 0x700000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0xb00000000,
-		.phys = 0xb00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0xf00000000,
-		.phys = 0xf00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x1300000000,
-		.phys = 0x1300000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2280000000,
-		.phys = 0x2280000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2380000000,
-		.phys = 0x2380000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2580000000,
-		.phys = 0x2580000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x25a0000000,
-		.phys = 0x25a0000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x25c0000000,
-		.phys = 0x25c0000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2700000000,
-		.phys = 0x2700000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2b00000000,
-		.phys = 0x2b00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2f00000000,
-		.phys = 0x2f00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x3300000000,
-		.phys = 0x3300000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* RAM */
-		.virt = 0x10000000000,
-		.phys = 0x10000000000,
-		.size = 16UL * SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* Framebuffer */
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-/* Apple M2 Pro/Max */
-
-static struct mm_region t6020_mem_map[] = {
-	{
-		/* I/O */
-		.virt = 0x280000000,
-		.phys = 0x280000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x340000000,
-		.phys = 0x340000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x380000000,
-		.phys = 0x380000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x400000000,
-		.phys = 0x400000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			PTE_BLOCK_NON_SHARE |
-			PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x480000000,
-		.phys = 0x480000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			PTE_BLOCK_NON_SHARE |
-			PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x580000000,
-		.phys = 0x580000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5a0000000,
-		.phys = 0x5a0000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5c0000000,
-		.phys = 0x5c0000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x700000000,
-		.phys = 0x700000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0xb00000000,
-		.phys = 0xb00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0xf00000000,
-		.phys = 0xf00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x1300000000,
-		.phys = 0x1300000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* RAM */
-		.virt = 0x10000000000,
-		.phys = 0x10000000000,
-		.size = 16UL * SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* Framebuffer */
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-/* Apple M2 Ultra */
-
-static struct mm_region t6022_mem_map[] = {
-	{
-		/* I/O */
-		.virt = 0x280000000,
-		.phys = 0x280000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x340000000,
-		.phys = 0x340000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x380000000,
-		.phys = 0x380000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x400000000,
-		.phys = 0x400000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			PTE_BLOCK_NON_SHARE |
-			PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x480000000,
-		.phys = 0x480000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			PTE_BLOCK_NON_SHARE |
-			PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x580000000,
-		.phys = 0x580000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5a0000000,
-		.phys = 0x5a0000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5c0000000,
-		.phys = 0x5c0000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x700000000,
-		.phys = 0x700000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0xb00000000,
-		.phys = 0xb00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0xf00000000,
-		.phys = 0xf00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x1300000000,
-		.phys = 0x1300000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2280000000,
-		.phys = 0x2280000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2340000000,
-		.phys = 0x2340000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2380000000,
-		.phys = 0x2380000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2400000000,
-		.phys = 0x2400000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			PTE_BLOCK_NON_SHARE |
-			PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2480000000,
-		.phys = 0x2480000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			PTE_BLOCK_NON_SHARE |
-			PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2580000000,
-		.phys = 0x2580000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x25a0000000,
-		.phys = 0x25a0000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x25c0000000,
-		.phys = 0x25c0000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2700000000,
-		.phys = 0x2700000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2b00000000,
-		.phys = 0x2b00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x2f00000000,
-		.phys = 0x2f00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O */
-		.virt = 0x3300000000,
-		.phys = 0x3300000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* RAM */
-		.virt = 0x10000000000,
-		.phys = 0x10000000000,
-		.size = 16UL * SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* Framebuffer */
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-/* Apple M3 */
-
-static struct mm_region t8122_mem_map[] = {
-	{
-		/* I/O */
-		.virt = 0x200000000,
-		.phys = 0x200000000,
-		.size = 4UL * SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* NVMe */
-		.virt = 0x300000000,
-		.phys = 0x300000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x580000000,
-		.phys = 0x580000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5a0000000,
-		.phys = 0x5a0000000,
-		.size = SZ_512M,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* PCIE */
-		.virt = 0x5c0000000,
-		.phys = 0x5c0000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O ATC0 */
-		.virt = 0x700000000,
-		.phys = 0x700000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* I/O ATC1 */
-		.virt = 0xb00000000,
-		.phys = 0xb00000000,
-		.size = SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* RAM */
-		.virt = 0x10000000000,
-		.phys = 0x10000000000,
-		.size = 8UL * SZ_1G,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* Framebuffer */
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_INNER_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
+#include "memmap/t6000.h"
+#include "memmap/t6002.h"
+#include "memmap/t6020.h"
+#include "memmap/t6022.h"
+#include "memmap/t8103.h"
+#include "memmap/t8122.h"
 
 struct mm_region *mem_map;
 
diff --git a/arch/arm/mach-apple/memmap/t6000.h b/arch/arm/mach-apple/memmap/t6000.h
new file mode 100644
index 000000000000..fb0f41e6e86c
--- /dev/null
+++ b/arch/arm/mach-apple/memmap/t6000.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2022 Mark Kettenis <kettenis@openbsd.org>
+ */
+
+#ifndef APPLE_MEM_MAP_T6000_H
+#define APPLE_MEM_MAP_T6000_H
+
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+
+/* Apple M1 Pro/Max */
+static struct mm_region t6000_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x280000000,
+		.phys = 0x280000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x380000000,
+		.phys = 0x380000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0xf00000000,
+		.phys = 0xf00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x1300000000,
+		.phys = 0x1300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 16UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+#endif /* APPLE_MEM_MAP_T6000_H */
diff --git a/arch/arm/mach-apple/memmap/t6002.h b/arch/arm/mach-apple/memmap/t6002.h
new file mode 100644
index 000000000000..b60401ee06c7
--- /dev/null
+++ b/arch/arm/mach-apple/memmap/t6002.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2022 Mark Kettenis <kettenis@openbsd.org>
+ *                    Janne Grunau <j@jannau.net>
+ */
+
+#ifndef APPLE_MEM_MAP_T6002_H
+#define APPLE_MEM_MAP_T6002_H
+
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+
+/* Apple M1 Ultra */
+static struct mm_region t6002_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x280000000,
+		.phys = 0x280000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x380000000,
+		.phys = 0x380000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0xf00000000,
+		.phys = 0xf00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x1300000000,
+		.phys = 0x1300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2280000000,
+		.phys = 0x2280000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2380000000,
+		.phys = 0x2380000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2580000000,
+		.phys = 0x2580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x25a0000000,
+		.phys = 0x25a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x25c0000000,
+		.phys = 0x25c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2700000000,
+		.phys = 0x2700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2b00000000,
+		.phys = 0x2b00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2f00000000,
+		.phys = 0x2f00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x3300000000,
+		.phys = 0x3300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 16UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+#endif /* APPLE_MEM_MAP_T6002_H */
diff --git a/arch/arm/mach-apple/memmap/t6020.h b/arch/arm/mach-apple/memmap/t6020.h
new file mode 100644
index 000000000000..ed6c2cbb3358
--- /dev/null
+++ b/arch/arm/mach-apple/memmap/t6020.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2023 Mark Kettenis <kettenis@openbsd.org>
+ */
+
+#ifndef APPLE_MEM_MAP_T6020_H
+#define APPLE_MEM_MAP_T6020_H
+
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+
+/* Apple M2 Pro/Max */
+static struct mm_region t6020_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x280000000,
+		.phys = 0x280000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x340000000,
+		.phys = 0x340000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x380000000,
+		.phys = 0x380000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x400000000,
+		.phys = 0x400000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x480000000,
+		.phys = 0x480000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0xf00000000,
+		.phys = 0xf00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x1300000000,
+		.phys = 0x1300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 16UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+#endif /* APPLE_MEM_MAP_T6020_H */
diff --git a/arch/arm/mach-apple/memmap/t6022.h b/arch/arm/mach-apple/memmap/t6022.h
new file mode 100644
index 000000000000..2c09f50974cf
--- /dev/null
+++ b/arch/arm/mach-apple/memmap/t6022.h
@@ -0,0 +1,225 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2023 Mark Kettenis <kettenis@openbsd.org>
+ *                    Janne Grunau <j@jannau.net>
+ */
+
+#ifndef APPLE_MEM_MAP_T6022_H
+#define APPLE_MEM_MAP_T6022_H
+
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+
+/* Apple M2 Ultra */
+static struct mm_region t6022_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x280000000,
+		.phys = 0x280000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x340000000,
+		.phys = 0x340000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x380000000,
+		.phys = 0x380000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x400000000,
+		.phys = 0x400000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x480000000,
+		.phys = 0x480000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0xf00000000,
+		.phys = 0xf00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x1300000000,
+		.phys = 0x1300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2280000000,
+		.phys = 0x2280000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2340000000,
+		.phys = 0x2340000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2380000000,
+		.phys = 0x2380000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2400000000,
+		.phys = 0x2400000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2480000000,
+		.phys = 0x2480000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2580000000,
+		.phys = 0x2580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x25a0000000,
+		.phys = 0x25a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x25c0000000,
+		.phys = 0x25c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2700000000,
+		.phys = 0x2700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2b00000000,
+		.phys = 0x2b00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2f00000000,
+		.phys = 0x2f00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x3300000000,
+		.phys = 0x3300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 16UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+#endif /* APPLE_MEM_MAP_T6022_H */
diff --git a/arch/arm/mach-apple/memmap/t8103.h b/arch/arm/mach-apple/memmap/t8103.h
new file mode 100644
index 000000000000..08370201b190
--- /dev/null
+++ b/arch/arm/mach-apple/memmap/t8103.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2021 Mark Kettenis <kettenis@openbsd.org>
+ */
+
+#ifndef APPLE_MEM_MAP_T8103_H
+#define APPLE_MEM_MAP_T8103_H
+
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+
+/* Apple M1/M2 */
+static struct mm_region t8103_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x200000000,
+		.phys = 0x200000000,
+		.size = 2UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x380000000,
+		.phys = 0x380000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x500000000,
+		.phys = 0x500000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x680000000,
+		.phys = 0x680000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x6a0000000,
+		.phys = 0x6a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x6c0000000,
+		.phys = 0x6c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x800000000,
+		.phys = 0x800000000,
+		.size = 8UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+#endif /* APPLE_MEM_MAP_T8103_H */
diff --git a/arch/arm/mach-apple/memmap/t8122.h b/arch/arm/mach-apple/memmap/t8122.h
new file mode 100644
index 000000000000..046a6aca027f
--- /dev/null
+++ b/arch/arm/mach-apple/memmap/t8122.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2026 Janne Grunau <j@jannau.net>
+ */
+
+#ifndef APPLE_MEM_MAP_T8122_H
+#define APPLE_MEM_MAP_T8122_H
+
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+
+/* Apple M3 */
+static struct mm_region t8122_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x200000000,
+		.phys = 0x200000000,
+		.size = 4UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* NVMe */
+		.virt = 0x300000000,
+		.phys = 0x300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC0 */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC1 */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 8UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+#endif /* APPLE_MEM_MAP_T8122_H */

-- 
2.56.1

