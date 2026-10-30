Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2C606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tz8tYtCR;
	dkim=pass (2048-bit key, unprotected) header.d=me.com header.i=@me.com header.a=rsa-sha256 header.s=1a1hai header.b=XZzbAp6+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00AD66079D;
	Sat, 31 Oct 2026 01:58:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2dxSSN7zvcq4; Sat, 31 Oct 2026 01:58:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4169F60895
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793411914;
	b=bzcTosjcQNforVg80IelGimnuZFtPiixAvQIG5WFSLG2kP+KD71DdJ/NUDODc7aB1Xi0
	 V1WYEJZLc9YHQPLfNZF/wu0Yl9oaXSvrR+59jO6byORMxKL3Yz82fp6aJuDGnqdakrudo
	 LV3mofOy3j6E37r6Ug8aTdkKoR1gb23BihILrw+/FYXSGzJ5EtAOH0TdZcleENUlhClrn
	 c43URFUITMOLGsOegfjvjtHKLxPL/l2Tclo7PX8vg1/7u4CkcbJ9jntklTTkULmVIl4yH
	 qP58mHp77GaCJywXL8IH7hD302jBrlBS802KxhWhY08Rm+D3dZqLc0Wc719JSIUKTcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793411914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Authority-Info-Out:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-JNJ:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Dkki6UiCgHsCQ86Afdtf8W0EDLfKP2DzwgmqrBhRpz0=;
	b=AK3Xo6aYQ2cZdgJCWEFWXzru+0tOV1ZmY95fktgMedIEA54LX1TCweKaZKYt1AZhBKka
	 k5K+HV3/b4SjDlmUYjzss3tbdeBoxnG+EDeH1B6zeM3ozCuG57uIWQmG9eaPWF2qsJA/c
	 a4i9LczwOOxN6hq1IQNksuZRNgfqeHeQBbA2XZ7AQvbc5Ae+SvunTEj9JecD9OGSe/QoT
	 210GKlP4JO8MFiMO+FzrXZIMc4dHMWfxNDgHop6mloNAw+/4dYsS2KpGW5AQCcmM1/kZV
	 qjc5SYthylKDPF8NbMUEOCGdOXYVMagpGMT2bMejdMHNRq6vhiIdAjHk+ohiVN5yEdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793411914;
	bh=Dkki6UiCgHsCQ86Afdtf8W0EDLfKP2DzwgmqrBhRpz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tz8tYtCRBw+eAV05zNcosPUQfJbNMcX1t3gcKnOEItAcpKyd4kEFlMotwNVJFsqmH
	 2Ic/K+l9iusJZIMikYWxiqjATqBgNZEtVvpx4KfYTbWsYRW0Ql4nRPXCV4KnwzX8yj
	 f7V6Oi0YpY4VBwOgIm47PlrKQZPmDGUnRjFHHw8A87D271WuXattGTYfjMKVp0VF5E
	 j47LwDV/W9sp5HKp4fHd/2oX89veSfX5yqV1CqT7n/GIbLCOK/cD/rcbqpxonNT1EB
	 8MzAjvEo94sBK05RRZjwm4ciGZURrdotVYPvbajom/xMELN57Rgn0JhC/r4mHxBrh8
	 3lmsoVcSpwJOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4169F60895;
	Sat, 31 Oct 2026 01:58:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 538962AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 22:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AAF6810DF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 22:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e2UvFONEgGmj for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 22:38:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 87E71810D9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:b747:3003:204::33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793399883;
 b=GYx4VMiqXzQnuOoxNIooKXRxR2uqbSZXU+9lyt6FK4WBmb9xb+/h6IJvE2cd3b8TepZz
 6J9laioCeBqHkBIvRj2l+F4VSIqy0GVUWU37aChzpwrAACQBNcU9v7ixz5qgKfrBiJbav
 2adeYvdwNR3cblDfgIYWseROlcJ7z4Don/bwJqJh0XqXrfRKNWaTOmo/hC9UusLsiYY5V
 22cSbUS5qkI9R8abyy9YGFL+o5w4UdPKLkQkoiM0geAkqTAs5bDLjT4NBBGN+UvK1OOzH
 xDUtlQt4LzbacGTVsefSBerqDAX6Db5TcWC3SpNBBQ/ZQizfak9A1pM17sv2xaJIm9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793399883;
 h=X-Greylist:Received-SPF:Received:X-ICL-RepId:X-ICL-Out-Info:
 Dkim-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Authority-Info-Out:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-JNJ;
 bh=Dkki6UiCgHsCQ86Afdtf8W0EDLfKP2DzwgmqrBhRpz0=;
 b=stdckASI/J5Gr0jaTpaRrijE4ofyoSDcqfzXygR/9dookCiO3zU21UhESqYMsQg9N7U1
 OwKM6LVBtNbf+fVCMGVr7zVUUv+ltD11CZ4EeR57uRnIaSK/QBPpl4XfUwTJaqUc5Wttx
 NJbHT/bfNKzsd70QXcYbIaTSptILWIb2i7wDuCfloYemX4MJyR6KSUdGgW+tcAFhtSQ7t
 qICsWrOtVX0bqYnlcpIfU1BYz47kKTBfzi4g2c+QPo1m364lEjTGbhnfAAXgNJ4fAW0XF
 pfvcrHwbeKyNLMYVdTGxsnUxs3Xb5+AsSrB6YnEF2J8Nkgp2nZ+gTLZMUo4O/I6lYjw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=me.com;
 dkim=pass header.d=me.com header.i=@me.com header.a=rsa-sha256 header.s=1a1hai
 header.b=XZzbAp6+; 
 arc=none smtp.remote-ip="2a01:b747:3003:204::33"
X-Greylist: delayed 154 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 30 Oct 2026 22:38:03 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=me.com header.i=@me.com header.a=rsa-sha256
 header.s=1a1hai header.b=XZzbAp6+
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3003:204::33; helo=outbound.pv.icloud.com;
 envelope-from=pepp@me.com; receiver=<UNKNOWN> 
Received: from outbound.pv.icloud.com (pv-2006e-snip6-11.eps.apple.com
 [IPv6:2a01:b747:3003:204::33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87E71810D9
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 22:38:03 +0000 (UTC)
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPS id
 3694B1800458; Fri, 30 Oct 2026 22:30:07 +0000 (UTC)
X-ICL-RepId: 01a18eef-425b-7522-8015-358f9c0d22cf
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhBBkMCUxxBC0sdXAdZEhVdRUMIRxtyHVxWUAJaS1QUBBVWQ1QEX1BLGw5bFwNXHFZFXBhDCV0FVxwdHUFFWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQWg4cE1YVEwBeDw9MC0gBWwZbAUALSgFUAl8cSAlKB18aWh8AXAhDLVoOHBNWFQ1NQxJCFQQRUAFYHlY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1793399407; x=1824935407; bh=Dkki6UiCgHsCQ86Afdtf8W0EDLfKP2DzwgmqrBhRpz0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XZzbAp6+9xKSJz7HUljtRY1dagUUFfvUzy4A2hO+BAH891dNfEF/FuYgHdGORHDH6BeH3hiPiq/gz8IxGy8G9ZUkEItj5Vu3ElDc27EQ11su9qwnhkZrqy4VZtxnDqUuhLCalsp8Fvw+ExMFJViKfOT1Y9+WXMJMmMl5F26uNkQm+iLJTY5JRbui0d7NjzDk2WRhQcqdTmjvYCFYdvA1QtBwnY8oxe0WEbHNGnWll13rLSi+17+QmR0P0Gkzv5eBcbd2nq5OC5tccUCZvD3EP2O/4Y+CjGwccKEwfKxcL87aVfiaiUrVk2UqTMsny2vXYDUXb0FoHJGrRZV/oN0uHQ==
Received: from Fox (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPSA id
 6F0C11800450; Fri, 30 Oct 2026 22:30:05 +0000 (UTC)
From: Peter Esselius <pepp@me.com>
To: u-boot@lists.u-boot-project.org
Cc: duwe@lst.de, sjg@chromium.org, mbrugger@suse.com, pbrobinson@gmail.com,
 trini@konsulko.com
Subject: [PATCH] board: raspberrypi: rpi: add nvme to boot_targets
Date: Fri, 30 Oct 2026 23:29:54 +0100
Message-ID: <20261030222954.80242-1-pepp@me.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925105432.0F27E68C4E@verein.lst.de>
References: <20260925105432.0F27E68C4E@verein.lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MvpfKmae c=1 sm=1 tr=0 ts=6ae51a6f
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10
 a=deLJwN4FMxAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=lT8QMgGdXQhgYjgtZ2sA:9
X-Proofpoint-GUID: P8ba9TTrJC65X8OdZ1e0u_l50vUGF0zi
X-Proofpoint-ORIG-GUID: P8ba9TTrJC65X8OdZ1e0u_l50vUGF0zi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OSBTYWx0ZWRfXyV+dwJ3054qh
 5YS2UU0xAiKHJSRnd9qYfDz2/uirnpXSOMuodXNPMeLHVvPfwVn3lZX4xCUIhWtSXKbMfxIKleV
 I6UKGLeKI/tCRorNbQZTsOjQtucc4RH6KYj50HPEsfUDHPsnBMuG/hdhd51ILcqJuHPwZxP2c0B
 Wz5YPxURFHyisLN9m2hL3xMOsyceo8E5SFCqW9ldYKSYtSji++jONKmBxi93SjHBkqGUUnOsA6v
 rBq7fo08haGya7lsLwxduUoag0ucGR46peYtDEu1k+w5Jqfv1FjdbAv6KRqk//Ndbyj3W3OBeHm
 vJ+E24afI2UMruZNG/TgrfFNthiv7dE/6BdxLK/hD9JKkXzv3riZ27SBZdN5U0=
X-JNJ: AAAAAAABaWa+XDSTM+x/R4/oLBDnmT1k0MTwLnE0CEbCf55izMaL58EglTEBjqFMn3u8j/
 hBFzTHDFccNl4CBJUdeTO+oIwopqlgYD4uvwalINH8dgeNoXZDL3DwDLOP3DU/N4XcwHoA
 6+k93ha677/Ky0jzF8Mom1uXnNRurKquXAJJBaYoYPf68BfCYKXtMrjYA/grXVUiohoMbS
 2E68r6XaG+zAL2wFd1Ez6PJIk37K1XAT8JhMpzNTkj/NyRxlbeg2kFKlpxZG9g1pYtTbL/
 yJ4Yj2Fn5Rjf1AdDZcuXv/RZtg35lFPHNMOsbFQECGeMSdYDilenDNdY8a7Ou0s101n7Yi
 f9xuPzdBlHwR0T/9sCgGMbfmmbKrtiNqE3tKhQAN4fhG/8Ud36UOKfp+lPHoSJiEZPIv88
 38j+VrlAwMu4Vy7mFRJT6HtXxI+sI+7q4l4Ozzp/8fmoalgqZ3Z/j9AmMwT4WthpNbVxSs
 UCBX2rxKgbIEakZNFqvtPyY128ZsOOGcJUXrTajuguOQJSdXtQZv2hFMkWCFJKTP5ci11X
 5eyHHRxd1r2Va+QCxJPmjXaA6yjfvyzAzA9Jc8gTrdCsF91scHt7YMC2pVDLfsVcu1NyYN
 6p1OIQWdmxC0utdiKtzga3vxBH9H7pk7Ece/XLNzxx5uuVI+k9xXXL3zaOSeEDq35pYoJk
 rUM+veMv0fbx5IX5CK13Lc3ZNZtrIfL1SLnt6+Xs3uRuAs4Z2YpHMDC35REcyvR4uaTqjH
 InTyPp9uospTTcLr9gJ3Qz2OJ36pD6f5Yhqol1s1Bk0v/XnzH48sS9zAUtk7HDTDVAug9P
 xKeSoQRzGLlj5c84C+KVHx/WApqcdS8QUH2fNmfoAqcASRBZOwCMoDzImDr9HQb3u3zC2Q
 1aClGLRy5S4xfrNaVZtfse5q6OqUJgTn0izf85ZOhd8J9FxCQvTuIkRq6n9QhgEdAnJweo
 GyezRP9aBaMHqNvXsf/4cE4Lc4js8Ymjh+7K1/QstrbJuA8KFiFPTjCONEGk6ov3u55GVN
 ecTBHU0IvUtgb8NFPuZkPEiJ8ZvDE4wIDnOU8Ob2/CyCh2oNH0NKi1eoUo+iOJubfNat3F
 +U5Jy6i1Z/Jtn+FgcJZbQrOjyK4mcFhHW6hjsfrnjf8i48GE0mAH7MPnSFErFkUvfb8JX6
 GWJy7Fj5UO0umDA4xtL4FcQXVF8UV5TAmtKRZZURe0xAOb7vco/Z2bNMNiWn4b7kU+EQs5
 5IY=
X-Mailman-Approved-At: Sat, 31 Oct 2026 01:58:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

bootstd only scans the labels listed in boot_targets. The NVMe bootdev
is created by "nvme scan", but automatic boot never considers it because
the board environment only lists mmc, usb, pxe, and dhcp.

Add nvme after mmc and usb so the existing SD/USB boot order is
preserved and NVMe is tried when neither produces a bootflow. This makes
an NVMe-only system boot without an SD card while keeping the SD card as
a fallback.

Tested on a Raspberry Pi 5 (4 GB) with a BIWIN CE430T5D100-512G NVMe:
with no SD card, U-Boot 2026.10 scans NVMe and boots extlinux from the
NVMe ext4 partition; with the installer SD inserted, it still boots the
SD first.

Signed-off-by: Peter Esselius <pepp@me.com>
---
 board/raspberrypi/rpi/rpi.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 9ac9d676..6104f3b1 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -77,4 +77,4 @@ pxefile_addr_r=0x05500000
 fdt_addr_r=0x05600000
 ramdisk_addr_r=0x05700000
 
-boot_targets=mmc usb pxe dhcp
+boot_targets=mmc usb nvme pxe dhcp
-- 
2.54.0

