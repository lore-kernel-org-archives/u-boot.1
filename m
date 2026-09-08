Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B391CC79FAA
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 16:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBDB480C6C;
	Tue,  8 Sep 2026 16:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hcXQvB0_CEsY; Tue,  8 Sep 2026 16:30:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1DC1480C47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788885030;
	b=B17bq1PCHodGIyyAhnmvRT/T505L+EaWtotsf6mN0m5uVt08p+Fse8zhNI1mGfxZNFry
	 rBdMtDELNma3A70KhDhlltKjZBXBrmI9TuEMrNJZSZ89kAofK3SIqkjWLU0Nj3NCvOsu6
	 yPKAAW49FSKtzy/PxFtn2/2REQTLZ0OuZCA4oy2cCVfdmFJonnHyT6ISb3a/oxHG3Mx/x
	 JJCCtUgUapEe+s7+ekZHQlHXylzR5HrKOOWsrCfO+IPy+tGlKJTSQo5DwY9fW/bbzVINg
	 9+WjLZJTOqZVWY1cQ80A8PRf7EKWnMehUfRqNt4mrVVIZVQTb7E78fAeQuCNI+srlLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788885030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kCD6hYfkHhxPDWk5VM290dhMRqclS6Cui4OcHi7cz/Q=;
	b=noII0A8inTHOeXfTF1FEPmJJqKOq5VFE9tFGxqow63QZLHAF4JjdLfE+68z78eRlDCjc
	 lrtTR8TOWm4jscAtot6UctZ4Aznl9+qqOvhqzjzxFqIEmmaDEHXmiIntV6zlgeRXwxKWQ
	 JzgDw9BXnaLoRMblEw5uWVzG7usIuoX+5ma4OafWGLvHs3DZ2t+RAKqJVawnY00gVLqWG
	 U2qN6ilM37RUJSJ0O5vov1MbmVUP5d2hgHkNctzj1ScVV/AFnj/sC+mHlE/CdXNlRcqTJ
	 Qf9itHUABcUQ2Kox0wFXBqJ6340olh0YsBg69h/03z32ICQSMo46WBJeF5kYJJviyEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788885030;
	bh=kCD6hYfkHhxPDWk5VM290dhMRqclS6Cui4OcHi7cz/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lv/NLC5l47rj9ZvGP9Q8s9+1k6rjkdr97KFqLRlAjWmr9hoMCdxep8l8UYnLSI7O4
	 tOpKYDiTp6jKgvxPQaJ09iXOdq/08ODK3GSmlFv3PCF5Kw7F81gaiiX14wm9Ck/csn
	 PVowAjahBlJrwQIk7t86GGC0aZXR8hYh3aSgD31RjU9OWHdPXL/JLRiUg1J+XyMpWy
	 pDedor2/jEv7w7CvP/sxSqAfN70ycL2AwaTk6ngYUYvBGJsXdtCAR1GWShwugm/2sm
	 430BCYcxOKaZ5V1pzOxicFLVapA6q9w2Q+WP1F4zHgTXKDfxkQeWM7W5UZsUdwYeVH
	 ldgR9hMK48Zww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DC1480C47;
	Tue,  8 Sep 2026 16:30:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09C29990
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 16:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFF716072B
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 16:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k4lvH8WdZwGo for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 16:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8562A606F3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788885026;
 b=SSNcsfZrN8qs1NkJntzTqrJLp97gCumSMw68GB04UxnD/tBEapWe4UmRxXqj3ulONI7y
 11/cfs8gH3DnUHYWdTUD2GQDdma97fok71RheVGNkgZbbATQilFFs5qQoLYueiEJvlrq+
 GO2xpH5IPLIDy+Wif2EBYzAC7Uo2q0nwwrZZCI5t71VMadm1A3AwSTSM8dfBJdFBfnpY+
 eWdaQh3PKU1v2Qsc4Lp5svuNn1WQK7ZXrumCpbsnutTi3VDokhZCgwgfc29jbcpjtBA/G
 ZdbGSxNR2oCF5CKxml4V93qF3rjhRSE8tdhH60erHtODfn374tU4+gyU2L2wqhdbC0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788885026;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=kCD6hYfkHhxPDWk5VM290dhMRqclS6Cui4OcHi7cz/Q=;
 b=Crv4IJiU3xyT0CRwqUD0qnx+LroOoICNnOn3uVBdD+XVSahBKstJcm03CjzaV2EgBh8p
 Rn6wwqzhamJcB+tcBxMXJh2g0HYMJxXBBwXurmlvGhnEZ2iSTMmDTfBCJP6aUDaT73YIw
 sr9OUvZRbc5lddXf9NVAzyjzINs64t7PiKC5U16Jr6IoNLxilp9PbPHPGEKZkd7eBW4Xe
 T/vs1GvXj35TsD1o8Rek4T4YsDrmNaKWhoRsxySrPtDqltuWZWAY87JH9XAZVRMoV/QJn
 iCKM5M6A/mWXwRNdbTuGtWAsFkgGhEkie50cfgJErc6iDJmA99BW6QAmVllh1n0QPYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=PThhN0FD; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=PThhN0FD
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8562A606F3
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 16:30:26 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hfTv23c6tz8tyL;
 Tue, 08 Sep 2026 18:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788885022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCD6hYfkHhxPDWk5VM290dhMRqclS6Cui4OcHi7cz/Q=;
 b=PThhN0FDNB1bsn/PPZnoRbJb+8Hjhdi/8yug1AS6MpIbUIoS/2RU91mJFgRAO0wf9GGthH
 n5HLwnUX8NS7uhCeNoCFKHx34UMJVEi24FrVq0njxDdy46KffuH6QvIfT/R3FJsenAXykZ
 JDPAgMUfQ8a8aKaAahYZD6ezug6B4dlp2AndBau6iQWGsu9/EzZhD9VxPnTqRkxLUirP8P
 IRgT4SjTZNauCai8u12lPcX+f2QUryuX/Vne7BiHuDkqzZ8q8aZgpPZE8faKvtg4wzIa+Z
 7S0nTSsBdeOgoblKKuNuF7WSj/xjYnAkEkJcXz4UYG1GkQal5DzLzbYV2NHafQ==
Message-ID: <7308a087-a490-4e66-b1d0-d382c6409c27@mailbox.org>
Date: Tue, 8 Sep 2026 18:30:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] dfu: mtd: probe before get_mtd_device_nm()
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260908-rzn1-2026-10-mtd-v2-1-6a99d054d61a@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260908-rzn1-2026-10-mtd-v2-1-6a99d054d61a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7545f8f64041aa52cc6
X-MBO-RS-META: raja36f95rndptb9ogit9ypwp95cfmrz
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

On 9/8/26 5:03 PM, Ralph Siemsen wrote:
> Parsing of dfu_alt_info depends on matching MTD device names, so it is
> necessary for all MTD devices to be probed first.
> 
> This fixes a failure of the "dfu usb" command that occurs when:
> - dfu_alt_info contains SF devices listed as via MTD
> - there is no persistent environment stored in SF
> - "sf probe" has not been executed prior to "dfu usb"
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
