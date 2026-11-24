Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55F606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yN5usQEU;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQ5Lek7W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 550E280CD9;
	Tue, 24 Nov 2026 19:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CKlRVN5Xkcdc; Tue, 24 Nov 2026 19:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ADEC380D01
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795550173;
	b=UYRtxDiMGXCz8A3ZXLQOL1juxWsUn3Iv7NfcSupUXdrezzLj8DAd7d3+iNwyA8YnY2Se
	 KtSj0KGodbQIWElS3FZG8W/ng+pTW5/nudi0OVbiw6MpK7BoLIkAAEFbYrQPdv+I125yG
	 o6Yu2wEiiRfW8leGeic5KzDNsnImQPjU46WzsWsnYNvSuJ3MZMOsvZ2U2sjExyNV9f2le
	 Be7YNYvaPA/ifmd5LMkuBmVuVcPg0aUSUYkr0E4CX9qsE8VXUuZGK3usWhNGJErJnznDR
	 sQjf7ul2xCHUX2ToMQCrG8kHMuegPoPg3l1gY3zVmtak3fYben2memh1giU8erfvuLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795550173;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rFd2t3fp5ZkYdYKOIBKY1jPex9DYoPEH24eb/x17e3Q=;
	b=KDAg2KTwE4ZRHuYleOMN1l3uOn8glRg4LeVr+k4c6043AGJQtmItdo8vMafBM6eHL4mP
	 9AnK8ANXRn4Rz5D+X/3qtMipbYEYPZhZ4FlIDz0eecgbJFrq7SYXMDB9g/6qWF/GUJQUo
	 Pax+vQf+uPk91r6qrjnTwMxzMDivKnD3OgmdHitnB4WFoXfpG02t3UcIHXWSUg8AL8AJW
	 SPd8Hw7IZMvtOtQSYS9Pq8WSREPXijLFjGl+WNXJG1JJifD/i9wtr3oDgXRF9EGRPs8x5
	 ZL7Bzp4rJqmgPV9iOYuRzAbYJWw1bQAM7s9tEUxv0ikW+nUXyLSnmYE5we8wVHY+HMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795550173;
	bh=rFd2t3fp5ZkYdYKOIBKY1jPex9DYoPEH24eb/x17e3Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yN5usQEU8IzA0GOvdU/o9NksNjsIseOPwRaJ0ZwghdrFE6lF1OEhHlMZa2oHmIlFk
	 8/kD+t8dvVU0S4eIkoKo34JxrOSvybj2LZ5EkQH3Vug4ifMWRNUb/96Nodjdw7Xn6V
	 IufqpoztPxk+dOXGC3xuve39748wVgctApzYY3MT670ez/RkUpAQGBkdS5lvhTYrPZ
	 jgLIoRHiMgPECVjumESAj5gRD9BkMSFNp9f5lAHgvn50/ZYv/5LgkVWkjarRp6jxX5
	 vWybyIU3npvQyMpegbLH2tAKGWo73CYpC9ITlU7O2k19cQUD/qazkkkL/zB/suFiLl
	 4tzXeuW92kwDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADEC380D01;
	Tue, 24 Nov 2026 19:56:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 17CF7325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09B7D40573
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sumj5vUIJMlA for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:56:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A05C740572
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=alpernebiyasak@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=FQ5Lek7W
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A05C740572
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:56:10 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so2611351f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795550168; x=1796154968;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rFd2t3fp5ZkYdYKOIBKY1jPex9DYoPEH24eb/x17e3Q=;
 b=FQ5Lek7WwNg+7J/WBefnm4MTh025+0UdBmkVpS5kMmys8He3A3HpiXxBXYf1tsQ5HA
 /R939Kg6tKCWpveYa2xuMxbonsiUFjxzXXbbyQPOtrL+QVPTUVxN+fpZKfFi4KmVUwgY
 caMH2zCLmMCCPtDLa2HppMC5GyMe4fPoXIggfOE5All1hpPJlP6VVhkRAXGL38gQxWlX
 q5laRXECW+CRzQVKZu2k9/obadzm2wgClzdu3zIS9sfkeG534d1L5bCTvxconR07Dyks
 gg3bh6ZNGV+oPqm+fBsqY7+9GHjRIK1QaRF+kK1y9s/Vo3bTi4VAqaAkBujBve1Wc+kA
 7y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795550168; x=1796154968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rFd2t3fp5ZkYdYKOIBKY1jPex9DYoPEH24eb/x17e3Q=;
 b=kqJ/CR8QoUEiaD9kun1411XMsfa0vKyFINn0KyvMsdnutM5w5nTJ7FryToVD8tZENx
 eieHAV/QIowu36u9tAq1hJoCn4u7Aklvb/Y3aobs2WmtuLd6ePVpCDvfNAKtck8OBnaN
 zIqavEZCNVuzEaqVhzRjeWYv0KCxE7RbpZ6OdKMnpHEj2jC+ZYtVM43g+adKpT2hkFXj
 iW9dDgRbDEGp48YtqbsXYbrZQAGtt4K5UUee6Rgp/1CA270yyaSYa4O7S+a2V/ZNfGKt
 zzq2UxJl4wUgArCoaZEFarieXRxGPN0n4u/EzHxYI+um74DQnIj9YVv2NbbNbh8Xa8pa
 Z4Lg==
X-Gm-Message-State: APuU4Z/cYJLNkrLjHHQcXhvljg/Dj0eYnztcvHkHylDK/W5ztXfgpvaC
 SVhAqEOcF85AqTo+3ncy/sGdZPXl0WmU2ZSa5joW3IvpJb0/P3uhzmB6hZsJLxgO
X-Gm-Gg: AZFdTZdyk0LJYDRAWLwKSyjsfSHppWgMDRWnJNYqAyvRA+WixdM1y5HYvT0rXG0brtc
 X/GXo047k5Hdxp0CocBGAv/bEO03lrXESva+A88fm4WPS4Fo3kEA36Y4TT0GySBspQDMurhGZDa
 e4kgHjIbLTHRLMBvsalYB02wkEUAMnRZbkqCQu6vQSuRKNBfRMIyovCPd7YRyULBpOuoDL72qGV
 DHTFCbOVvZgDKdqDaJlaEzigFCMA9J3Tzw5Abgys5UmkRwFOJsoapK1eJ2TurCAjnTB/1GnpxNx
 sdopZmILm7tIJFPLy5DNPM61Eh5wxy0RLyuthQfcRogIKbESbzo6eW27eNXGFX3ixg1GMxYsoRC
 gsqSQOi62DM8im6WhKVlI/MaTEMqO5gSc6k3Y3HzHiXmSiHcvsK6HZPaMaHFdxLGVoPFWjIndi7
 bV76/GVPvFNbhYtNUoSUaV+IW6JiVM5ruBk4k6cLqi+ru8x65OSW9+v0ETWCS1IQuleN2DEIeSf
 ua2MOwzk6V9D91TEYA1J4b665ctxrCknyHM9U1MOS+NuTfDBL62RDYwtljSH68cuJRQgNsN2ncA
 8Wz2rAtMyHul1Yf/gPg41vXhQ9cQ44AJJ83AGWIaCOm68TuMYZJYd+5bpjj/NjWd4BxaQS+Oumy
 w
X-Received: by 2002:a5d:64c6:0:b0:4a5:1789:90fe with SMTP id
 ffacd0b85a97d-4abb19c1749mr32388685f8f.32.1795550168186; 
 Tue, 24 Nov 2026 11:56:08 -0800 (PST)
Received: from ALPER-PC.koi-vector.ts.net ([178.233.26.179])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm34096616f8f.24.2026.11.24.11.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:56:07 -0800 (PST)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jeremy Compostella <jeremy.compostella@intel.com>
Subject: [PATCH] coreboot: Add Alper as a maintainer for coreboot builds
Date: Tue, 24 Nov 2026 22:55:54 +0300
Message-ID: <20261124195555.261178-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I have some experience building and testing U-Boot as a coreboot payload
since I wanted to use that combination for Chromebooks (mostly ARM64) to
reuse the work that Google upstreams to coreboot for this class of
devices. I intend to continue working on that project again soon. It
doesn't look like anyone has offered to take over maintainership for
coreboot payload builds yet, and I would prefer if upstream support for
this use case can be kept alive and hopefully improved.

Add myself as a maintainer for coreboot-related builds. Drop Simon from
maintainers per project decision.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
 board/coreboot/coreboot/MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/coreboot/coreboot/MAINTAINERS b/board/coreboot/coreboot/MAINTAINERS
index 5166e7a762da..e235fe127f5c 100644
--- a/board/coreboot/coreboot/MAINTAINERS
+++ b/board/coreboot/coreboot/MAINTAINERS
@@ -1,15 +1,16 @@
 COREBOOT BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
 S:	Maintained
 F:	board/coreboot/
 F:	configs/coreboot_defconfig
 
 COREBOOT64 BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
 S:	Maintained
 F:	configs/coreboot64_defconfig
 
 COREBOOT64 NO SPL
 M:	Jeremy Compostella <jeremy.compostella@intel.com>
+M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
 S:	Maintained
 F:	configs/coreboot64-no-spl_defconfig

base-commit: ee1b3477e3af6af1ae9b8f98bc84d2cc6f32a3a6
-- 
2.55.0

