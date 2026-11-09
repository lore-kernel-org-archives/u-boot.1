Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C574606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AFMbwtVy;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P/yMOSt7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD9CF6073C;
	Mon,  9 Nov 2026 08:25:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_KuDa9BQBTO; Mon,  9 Nov 2026 08:25:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D90D960716
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794212717;
	b=oDzVQF0d1T9Nm0q2XGD3y0SZPCdfK3Iyzj8XjmhJhn9+PbNkZtkFW9xbqujKcU4Tn2bL
	 jQzvA3XaGalZ77B08RJ1W2O0c0K3nKuIu+dg8UFxsXfHnsAZAK83JRbjA84U4pyCZCm2Y
	 hEXB23Z+Q80mA/uAnhouXps4/v1rHaVFx71Gt2c1ATNgnhf/AKs5QX32rzw6HRQ3/a3l/
	 aBIBvMNQaXjjGGwdyh3d+noOCYZglyM/A5LdW5p8N380gofyd1W5PvvDUJxmNcHK0yqG+
	 RXgfB3JFwUQ//WV/43ErIn23LkrHW/9Aa2i4RP01gPid+sISZrG08wsgaJGqq9VHqOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794212717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rTXMAoenpXIhqzpglXrdZwBRAz5JtTV5Z4BTP/K0lDo=;
	b=gJsfJgi9uy2iNR9MRmQdoWXBqKCjlPFBnZgPBXi5IXL9VfFUjcIQ7Q3v4E4o2h0tF0Me
	 luYnJYcEl5VRNKAHMbnyfqoRMSSxawRmsgHwTBCD5UPmvyv207G+DOZ0Y/CgbNqClRQGc
	 0Ax5tlWEKqLCmisKdDmrLSH7I/OgK1gyTyHeBHGRFEDbVdla7e0pLxNDp1aM4BGB/DAe0
	 zooE3cswj0a3RVtpLHAFnXihNgSMvWXod1oTBlCsex0C0hx6OhxYagl0Iszn0MmHho+xS
	 ZPAT78TPL2nhqrsrJxNDNUh14gxPG2MObvTh2DLVd73gYii9b2oiV/RWSMfqCc04TgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794212717;
	bh=rTXMAoenpXIhqzpglXrdZwBRAz5JtTV5Z4BTP/K0lDo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AFMbwtVyDSyiFlC8CyRx7Vz7XwJm83fVrf8jVBD/g/mSd9QDwQFsgk0VNXb/22fxo
	 KF+mLgqk4PtJlU1BtrH+ahZ8WALq8R+HreBddMUSTDlhNcuNYmGjVfpFQKTUjODLKA
	 gUlny9jFO9aAmkKc7sx80OUoDBTjCKeuOHwmFHwejketXKc1j8ZTpLpe+Eq/K6B7YB
	 TBBHpFD070vKNtQy7LEqkk4Qr/GfDS8AL7/s4/t717h2PvvwrsEcVp6ZhxFlS0liZa
	 ECHXJnOWEDD5XAtCGQ3goTkRpAvC/VLOW+dzGPKZXZiiBuoHQ7UaHkCxFxGR2a3coF
	 z+xW7/VQdQsZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D90D960716;
	Mon,  9 Nov 2026 08:25:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CAB1A362
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC7AF405F0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:25:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id syUo5VmKTgMJ for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 08:25:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C4E7405DA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=P/yMOSt7
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C4E7405DA
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:25:10 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so5135165e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794212708; x=1794817508;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rTXMAoenpXIhqzpglXrdZwBRAz5JtTV5Z4BTP/K0lDo=;
 b=P/yMOSt7DMkcOP+yJdvYnmsj7/8Ky6DlA9pvopWqgOb4oLHVL0MXNj7G4RnnrRAQEa
 Zi7tczTQG286fBcXx7wFNQmCn+ESzGvDmg7SP3XJwPPXKo9+SqNIoG1AVVH9nVlO7Ln3
 DY0cx8z38LGMo7xjaEOtuOiRrtuIFvR9xn5a3dq4/Cynfg/LdOxMny6MHiWWP1tU3pQU
 CydrVSXTab4ojV6uJ+Z0UTfiXoSVWib1+FjqLzoQKXV/2GqM8hBKnvVfLJJDsBK6GukM
 EvcAWhMSaB+mtQ6BGw1d8Ue7besTFJlygTlfooddGj8Y4LtW4tBmBH/fOhqIjAcPkpKE
 0dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794212708; x=1794817508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rTXMAoenpXIhqzpglXrdZwBRAz5JtTV5Z4BTP/K0lDo=;
 b=pITR4ymoS9vhuY4ou4Z52yj9cGSAu19A6zfBvZ4HXqEbJHlxy43FE9T36jsjfqIn+L
 3GZLUeAaGMhXuBc+FNhitzD5hAVnC6b8sBkiy1bD4YfNsg4oTaQdrMXzrbTzUpl2QDg2
 LyH0cExp/++Dzpyc9oQkIarD/BQCPNrssin66pspmcmCrkaLEmWCoKNzIPMvQUWyQcZZ
 iqdssd6uIbDjJuPeWGs0OVFX+wYtwOUlUOMZJ7jDhozUgdsfGqnmvc+iOpqaPRzG3gEg
 nfNWSjYiK/revAoFBepfakqDTYltB/MmYyb+Y4gCuIXdc4RiX7TTKHnwjMtVhnddqf3F
 fdZw==
X-Gm-Message-State: APuU4Z8MWLi4JP2UXqFZMC7ilZ2hTctj98sXEYgDvMVBUXnGKpWepOLg
 m9unhYeSAeYnQeGgfulrC3zbWCc1UO9oEinJ/Fn89jRgTV+uCOjLX8lZn46Phzrogl0BVg5Ornp
 hirmw4Bg=
X-Gm-Gg: AYBFou00YHhyr4Y8ERag9c5KFKNU7cpWLN6inQpxqaVcnealxAaW1mDTOQ/YGpMG6ih
 Q4cMUrmpMmXYn9oFhDz0OOIeBNa8N6uquADA6kLzQMWtO0mpUTetsddZEvZjzcch29/v7gynYPr
 2qfNkPmxENUbvsfTlwCYKfQmkPL2+6YFbCd2EYn/1p5UU+AeYsSQCIMdvOYX4pDgDPz0Ek82FKr
 HLAFmcyWMMByhfWkWBYxt9cB1W0Za2GOTus4RTMPlDokPdbHVXKkRy6SVZIFuafqxX6zISiyFzz
 Xhm1JUC3qTjMdkcecJrcB4XZoyJ2r4HNOfDQ7C13cfzimSwaPWDHgOsEAX0L/hCfWM3c6v4LiXR
 V9Dfxt67wUV/i2nfwaBLAp3/lcfIt4aWW/a5DZIDeyrgYRMUFPnBFxm61WEk/fvyd2C1wT6/NH6
 inBSHNaseBcVGQILez5CGMVqAiP1bb8IG2ism9Jrz1qyxcoOa3nNygefsAn3Cd+wx9/QSwMQskj
 V1/gS2vkUlLkjjLk3C30pNC3LiudEERnbb1RdRpUiFftDW752oDV1EBbOBXRAoWxuvGjz0YZaXd
 roBLQ28qzgwn6Hyc+a2v6fwECQSmwBrDpfQRUgdAZifePkVOP3UAksWWJDtIERne7pjgEkQkVhv
 8WDxpEQ38OwmTLVIeJeDYg+of1uIpkcCVPfqNYnm8SuM3s3yLY74RScV+f/Huqcd7AFoRy4+4vo
 miZ7bf3vn8g/ZqhbxqacT6GY9fqXSti3S7xnX9mqyRmgy/VaD0kO2BzQ3ek4s8DhMoJqDLv4TXM
 A0Nebr4pPwnSSqzYA3Au1b0k2ShBn0vnhStp5yPu8hExt2aG5basIO8vmjZwqiJW1E4UAwvaJrQ
 Xx+4nR/r2RTb/1SnetUa4bgPZUYE6wS1gdth6ky4WtEwY32LY1ABjk9XfBeVffNvmZDAYAN0JEp
 GOylr8e7g1BR711n22/l4O9QIMJiXC6OqqTNqAGnwCaSvpFZD
X-Received: by 2002:a05:600c:4747:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4b963c7e7e1mr66955255e9.17.1794212708385; 
 Mon, 09 Nov 2026 00:25:08 -0800 (PST)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7c4afc8e8sm88644805e9.3.2026.11.09.00.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:25:07 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	tkirchner@emlix.com
Subject: Pull request for tpm-next-06112026
Date: Mon,  9 Nov 2026 10:24:58 +0200
Message-ID: <20261109082458.847569-1-ilias.apalodimas@linaro.org>
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit ed869863c7e2aca50d57a05d843830dd843138c4:

  Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git tags/tpm-next-06112026

for you to fetch changes up to 8465d8859e2081cef363d5e0ca94c61961cd0f18:

  tpm: use phase-specific CONFIG check in tpm_uclass_post_probe (2026-11-06 11:46:16 +0200)

The CI https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/pipelines/1859 is happy

Please pull!

----------------------------------------------------------------
Tycho fixed some issues on PCR allocation in case there's a mismatch
between the U-Boot and hardware supported algorithms.

When there's a mismatch U-Boot is trying to automatically reconfigure
the TPM and then reset as required by the standard. A TPM could
return success without performing the allocation, which caused endless
reboot reboots. There was also a case where we turned all algorithms off.

Apart from that we were limiting the configuration to algorithms U-Boot
supports and we only accepted SHA1/256/384/512. We can now  work with
TPMs that implement more PCR banks than U-Boot known algorithms
(e.g. SHA3). Instead of failing with -EMSGSIZE we simply deactivating
these banks.

Lasty, the PCR allocation process moved early in the tpm init chain, instead
of running it the first time we extended a PCR.
----------------------------------------------------------------

Tycho Kirchner (6):
      tpm: check allocationSuccess of TPM2_PCR_Allocate
      tpm: allow TPMs with more banks than U-Boot knows algorithms for
      tpm: detect active banks with algorithms unknown to U-Boot
      tpm: deactivate only unsupported banks before PCR extend
      tpm: deactivate unsupported banks in tpm2_startup()
      tpm: use phase-specific CONFIG check in tpm_uclass_post_probe

 drivers/tpm/tpm-uclass.c |  2 +-
 lib/tpm-v2.c             | 76 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 12 deletions(-)
