Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D991CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10F4760761;
	Mon,  5 Oct 2026 17:57:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WENCst2ih65f; Mon,  5 Oct 2026 17:57:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4146F60770
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791223027;
	b=ONr3DNPuNs7afaDWjVV7A10SCk+FhzIopA76enzb7mbTcOQqZbJZ9GuqOUvfl19Zy40j
	 gb2Vbj5Ug3vniIQ5YhShVALdZEmW2sMkS3bkHO9DNjdWPHgWFdpCXGFvFgCPN8L6+h17V
	 Uc7aEsZ3WeL2YKTRRtgYZoMe5Q7MnEvHmFp5m+w1CaInEUSIW1TIR6qVboVbWmzqHvWib
	 OZc7bXCal3BB7wHlovpSpIWJPAl4B76BzXipc5jxXkfLB6ueVHxOOu+AkcL8F6EjIvLW1
	 nXegMSibivk0AgXjDgcaGUxAjQ9ljv3LQwheNFQsKXdQ8lk0oz9BIDiFI3UPMPfswZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791223027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vHrAEuXR3gUEN1ZdhrQX20pKzQNtv5L2PqeOuduHyhE=;
	b=XRTfxvmqid1km/nALSvH99rvp3dAg/zZmjKkupwqidXHs1sg8HTBpPgnTNFXzPmqSBPd
	 +E17F/rFvo7RmaVwEQiuRD2jwh6MBlmhikNIXZY+pGQeOYp3Llk47R0ENWd4q3lSvwm32
	 Mj7XR/MXqwYxaqsMRniMzMNwUMOSIU9ulY/+Wfo4gZoS/rH4wehC7Y5HKTS9I6g/LEuja
	 TjlC7FySHT4BsOtNm2tzaV/ATBGsB8gCaPq1fpDcWoPIhuVOzPaGre+mi8W++E+579LvC
	 aYISmvwJayd5Kud4mGtmncunHLMYlomcMKeZrPuO6pPYJmpwvyERCiOAYYo2GUKy2ag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791223027;
	bh=vHrAEuXR3gUEN1ZdhrQX20pKzQNtv5L2PqeOuduHyhE=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J+ytbenKOg+ycZ4MDqennTGlmDJt2a/9J1LnHITVELWLLK8RGSs25qNz2wIFTx3+a
	 3I5RHCtvtvouiu4cv/HOqhVAFhdC5DBitw0UAiZ3Du6gbxhtQeR1jvieI/aIjK6+MJ
	 n7bI+CG9LP5EIMW2eMJHT6/jozqyREAlX4HOMtOv6SooZmPqt9PbjX9e1eZTld+yAk
	 GMrE6j6tczrlAJEKCZz99opQus4whK4YXH+e/nOh742u6TPmpm/oOnj4aOBWUBJUBa
	 P0AvyeLT3h1iuXs6WAT+2ko3kPC6ymS44ACFZ1o4S+Bhtkt8KwWyT5k+8kDvmwQeB0
	 k0kKwORQzf12A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4146F60770;
	Mon,  5 Oct 2026 17:57:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C1AB338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8276A405F6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Ys1Y62pCF_f for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:50:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B618B405EE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791222628;
 b=Dml35OXVQkml/O5g2KCD1zrWAP20SAsRdwIe+8BagflbebQUYr3ZMvcD5BX8HwIZFNrJ
 LAmsqW1ZUsvPyy0E17ITdUQGk7Ev037reRcBDdtf5tcQWCHo8gad63pciRVDpsfT/HPbV
 pBQfK/i7VKNAh4ocLIEifY3dX4KTSROrE59RR7LG4+tS4MNaM70/UjmtEUKV8qjvVGwLU
 Mtc2DNjJktPMo/iy4mtjMuqy2KV97bFvJCQKEvRnowv5HXV0TrNzKE6x/vtbGdPaUUWMG
 qUp5fRmMSkh9eDQNAUhG9ssDllhT7znRGBhaaUrbwgWy7zUPKIi4nNv2I5raqqycPxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791222628;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=vHrAEuXR3gUEN1ZdhrQX20pKzQNtv5L2PqeOuduHyhE=;
 b=QGzU19gk0i1b5/3iYdNXhhBb9QKXacknxvuzM4cGm+gLX/IUdeTXdSFiE+5tMz4n3Qho
 NdMYnMqlfvyxWaxEd73Hi52MZEyk93pd0bqJMfotUSsKMl02ObKv0CbUr3KSLZIfdZWw2
 m7HjQZTmBcyYiPZBltIy/IPQGhImxRIgUI1rwhlN1ng9nD4455my8g9Xd9UZHRzotIMER
 /qA5EGKFZ2pgb73vAoZlQdxdFqiX1sULiF8Kf7qr2g/SSl7UkZ1wBbNX2Y5IDEn997Z6k
 NzyOztJZ3Z+Cu5GIB/DURY/WJc0fyuEG2GuP9FfX9TD7gxPCZPrv1jq+SPtcZcmoXtw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=Afe9mUIy; 
 arc=none smtp.remote-ip=185.70.43.103
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.103;
 helo=mail-43103.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=Afe9mUIy
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch
 [185.70.43.103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B618B405EE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791222626; x=1791481826;
 bh=vHrAEuXR3gUEN1ZdhrQX20pKzQNtv5L2PqeOuduHyhE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Afe9mUIyDTOjpRzcfnYW63jIlNc26XwClYg6WTbTY17GLTjuSXsdYpdKyo2Qj2B3K
 YowoF+9r/P3y85EUfF0+1PGOmbw7WAlPRmfvD+V81fqaa9vAcR4r0XOAmEDlfC4Lds
 kiHXiUPk27SQTyEzfwljHlM4hi740BMlSs+Hfq1b0Hzq6tYO3MxSYEiVMkXatpXRUn
 QpNIBr2/jFThYm8IqivGIi/aLm0U01DCjr1kb8fwAlGlRbz9gdQo1+857RrxG/Ldy8
 GJzwQgTIiJDszwDtwFnX0ELMxjqJzh4eBXt/5QdwaYthJKgPz1ltgdhWdRoYi/1nPS
 gAAh+kJ2IlBLA==
Date: Mon, 05 Oct 2026 17:50:21 +0000
To: Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/3] mmc: k1: fixes for the SpacemiT K1 SDHCI driver
Message-ID: <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975596.git.DaveWK225@protonmail.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 568c1301654464555906682ae47478cf14534600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This revision addresses Tanmay Kathpalia's review of patch 1/3: use
ulong and IS_ERR_VALUE() for clock API results, and validate the current
clock rate before narrowing it to cfg.f_max. Preserve the actual error
code and reject a zero current rate.

Patches 2/3 and 3/3 retain Tanmay's Reviewed-by. Patch 2/3 also explains
the intentional reversal of the driver's v9 single-block SPL policy and
the MMC core's CMD12 path; its executable change is unchanged from v1.
Patch 3/3's executable change is unchanged from v1.

Exact-base source replay and checkpatch pass for all three revised
patches. Both R2S and RV2 configurations build successfully.

An integration containing this series, the clock-mux rename and a
separate DDR firmware overlap fix passed warm-boot tests on a 2 GiB
OrangePi R2S and a 4 GiB OrangePi RV2. Both reached DDR/SPL, FIT
verification and automatic EFI boot to their existing FreeBSD 16
installation, with the expected memory and eight CPUs. These are
combined-integration results, not isolated tests of this series.
Cold boot of the corrected firmware, alternate cards, missing-frequency/
clock error paths and error recovery remain untested.

Dave Klotz (3):
  mmc: k1: handle a missing max-frequency and clk_set_rate()'s return value
  mmc: k1: let the SPL read SD cards more than one block at a time
  mmc: k1: do not release the shared AXI clock and reset on probe failure

