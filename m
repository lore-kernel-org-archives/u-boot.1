Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71645CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 15:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CDE860611;
	Sat,  3 Oct 2026 15:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kgbyz3z06OT5; Sat,  3 Oct 2026 15:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 791D76061A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791039798;
	b=sApW0zwEnEpOFu4TvgKRcKvZCTu9kSUlSAxFP5S07KnWJFylFfuozryL+n8/VVxO2sBS
	 g6JtgsCJI4cK9qzuPDDjAhSpwda1efCd0UeRN39wFY0eOALTpwVZ4H25m4a5uQ8+874Rp
	 DE7DkZvWc4mAIXEsJBWW1lKhdzBcqlwKUYRllxWGrDH/gZahF4zB+j8oxYNPtKB/AQzan
	 biI/XpS+bJq9QS20+FIrvVntQSV2ivqkUwhQLEp6GzolliE+EOv7AxCN3FvlTXVbw8NVk
	 yShY6b8XrMH+xFtZUAk8TqiTwL7E0wB85Kf5dRrIQA6kDjAuzPuKZpGqSGBayjSKkyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791039798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gWIH/pyBdLMxpSrGbMjrGuzjjiDXd2EgQafaLvDrhOU=;
	b=c+4BCCGvk2WoEauXAtYbpMCkkq3K9g54IdxlTYFHl+cclwX65BWOOe9vzSF4uus4gf4e
	 afC3uqMwXbhE6sFsVQKSsKtHarWl3F3g5mBGpLBysDCfBiQrc204jBkT3XYo47mFHrCn6
	 LkLTpVE4vqh/UC2GtyczEbUHdhbR2ksoDZLbcR4M3XLIqlMH+RgO37TTfuGzMk7Dy9eDr
	 LdpO9EvDLocEctupt+g7piNoLuvzbimcYht4BfroUXdk11ctpRMZr30vtn+/E1nYdRTml
	 dJZEcb3Cpj9jFwOrVVijkN8VpuqdExBzT80Ug+zbYxb89cAEBaFlj/dNNeWIZVqYBfA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=qDDzIuPh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791039798;
	bh=gWIH/pyBdLMxpSrGbMjrGuzjjiDXd2EgQafaLvDrhOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sRkx9lfp3d7Wiv5036hwUP36yWyafqxxZFXrzVfdQNadBV+ORsZrQcc2kBecRaiO+
	 LIzI5ksHUhi/ZsSHog9WcL5QC2Z8s5n835+XiE0dn0gBUb3MDiIrM2xWyims+mzJVC
	 oL2dYPaGnY/iI4kQiR9lrtrelcBHdHi5NSci2kecvyHiqdgAI+1J+Mx6v9+r847qXc
	 1rW+G1rO8PXex3UmDRG73FumklvSZ9av+RNBIMChUCaRITUk4EtEBeJzOQAWVlA1Dm
	 F3DSOA23yHup962IbxGf5hf+VIZus5sVeeDXUnSRPqo5TcW5lIt/+33NA4LaTpgSIX
	 zzagu4qjB8DAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 791D76061A;
	Sat,  3 Oct 2026 15:03:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C5171263
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 15:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C21886061A
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 15:03:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ckSsGhyw_R3R for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 15:03:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1092460611
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791039796;
 b=T5UlMW27rN/cxnbc1g29wTt6zHjTRy89fQ9DzXe82z5SyiQ1R5Kq79Z2kE/kdilkCSoJ
 WQyijFC0sshG+BUPYicVeFmbOt5w5AfDT1Q+q+1qXx7pnhs1ZBPXW24D1Q7fJjQ2MFnS7
 3mXeWjd73RdEaASfhye/NsPJQUw7QX0g5hPaPYbNfFq5uihjBetkoZxc1jAEokKJ7zgZX
 A5v9t5MckZaHX7mX6wKu0IAa2XKLou9hAaKOgJ7+BC2PW4yVX+CoaKKxmV3z0gQps0hdc
 d1JAQ72yWKt2qCaKf1PA//ZkDR+9lDvvdVLuvMJIjnPmFglUNKsnCet1GHIC1Jb8kQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791039796;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=gWIH/pyBdLMxpSrGbMjrGuzjjiDXd2EgQafaLvDrhOU=;
 b=mkwZE2BAvaSwubDzlPeMA7Bi7wMrO4SlP6Gbi2dkd6Yk4HoHzHtOXaplnTfS4TBB35n5
 6EbOkc8FvxZviiQfz1cC03P2yIM09GRtVW3zZXdtkUswet7oUDQpwlHwNvcJi5j2Y7BNj
 tslFpg7CghnU0rgn4pGVo7uy9jwsgqgsNO45L4K8gEq4mIgeo60n9HSHvbNMpggdpmYpG
 gFCysQ2zi5e0rUPQwQ6bWdxyHdlbqi5VVZu2MA8FbAZbJ3J2LJ8PandrNnp0m4UKJt8cW
 iEytLTEphTUE3qQXSeB4eybuocAByT4Zm987FBR/RWW1/ZbuYnMtPo9n185YMKxi85A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=qDDzIuPh; 
 arc=none smtp.remote-ip=185.136.65.225
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 03 Oct 2026 15:03:14 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=qDDzIuPh
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.225;
 helo=mta-65-225.siemens.flowmailer.net;
 envelope-from=fm-664519-2026100315020892466bd2e300020703-segetf@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1092460611
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 15:03:13 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2026100315020892466bd2e300020703
 for <u-boot@lists.u-boot-project.org>;
 Sat, 03 Oct 2026 17:02:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gWIH/pyBdLMxpSrGbMjrGuzjjiDXd2EgQafaLvDrhOU=;
 b=qDDzIuPhbgFfnneK0ozj6Kee9TxDwNsOi379fOl/5sCdmF7tYhG9b13m3LSh1vR7E0eQgR
 bxGB0yn8h3ses9nvgtaSqW8utg06FdSGArd/RKIHb6wcbiy4AaF4X7WL8ceVq4XB4/y2gIv7
 H7HUjt/Tz+Te+QCexOCXBpproU+B4Igc+QGwopThGRj8HLm4aYBoqIz8M2K+ZNt3Fv6TMwc6
 nCjY4QxKxyRxEe094C2yKNJ8ijLWLPff/L48iLn3qj2dEZfYWXhitOh+pl8mQ6Z0wL2IpDtO
 mTMqRH54dWhjBcbQd1dNXciKCx5t3fjSpDjYq+P4sKq4WXw+BJgFzsVw==;
From: Michael Haener <michael.haener@siemens.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
Date: Sat,  3 Oct 2026 17:02:07 +0200
Message-Id: <20261003150207.75919-1-michael.haener@siemens.com>
In-Reply-To: <20261003144048.GF2658242@bill-the-cat>
References: <20261003144048.GF2658242@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
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

Hi Tom,

On Sat, Oct 03, 2026 at 08:40:48AM -0600, Tom Rini wrote:
> This does show a concern I've long had which is that we wrote this "test
> this in sandbox" in mind, rather than "make real world use of this" in
> mind. If we need to refactor the sandbox tests so that they become one
> of the "reset the system" types while making real world usage match
> expectations and requirements, I'm fine with it.

Fair point, the failing sandbox tests are not a reason on their own,
and I am happy to rework them if we go the probe route.

The real-world case behind this patch is a plain booti/bootm without
MEASURED_BOOT or EFI: nothing probes the TPM, so Linux finds it not
started. Starting it in probe only helps if something also probes it
during init, e.g. via DM_FLAG_PROBE_AFTER_BIND or an event like this
one.

I am fine with either direction and will wait for Ilias to decide
before sending v2.

Regards,
Michael
