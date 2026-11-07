Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E05606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fOJDbDFr;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=LWpPP3VU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62D6560761;
	Sat,  7 Nov 2026 09:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4seFqLQqZ7Em; Sat,  7 Nov 2026 09:02:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F0BB60812
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042148;
	b=ncjgbEuL4RbnjGFUI0anUvEWmLnciEdRxVTNE6sWkRoXxGeqVvC9Il4vpmiT+9y6FpXA
	 xTri67cLMldvwbeyiUUnZuJYWc6sKKgbqL35InO72MkGTv7gLrq5ILMrb9M7fNiBdpU7X
	 6/0LVBsfAJKsEddXx35aHn+RawB+fqx8spxXHurctS3XUELGN1L1tRqNbwwoVWAribfo2
	 Exnh8j3ODhZUT0PhglrukWbaPcuALxYXVMTFCL5hx/kzizdCyE4fGqKfSho7H9SjWYQ77
	 HF2XAqze6iyJ6f7m5X6wrB9UId/YgfoAi8GdZLHDvNE/0JAQhV3XX10FZbHxeZZbqyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042148;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Im/tU++G14jjjjHOJZeTYHKa9n/Ab54iPQIWNd1ggTA=;
	b=HObL561OE2Myyd+BABBIB5laLfOUEJlDl94Tc8y25/oGwHciSKhjY4BFVNVcUIBL6SUW
	 qfgalKIZstdDu4DPmH8jGifzaWseA4396mzcybuwVE1Oo60UznXb6mQx6/tmXJ7MxnuHI
	 0G05Vf+jQCDRUOY2QZ50zD5Jm9SpZ6HJOvpBOPxpzPQIKfaTdAEtUpnL7sKBFdt+SQrT2
	 YKMmRq6bWscazcGR6iwfymIlGWtrw3wdM+VqHcfnEUenVoliMFnNBjrMz7eROMCyXCaya
	 AoIQr+F2P1Zb3rBbFxmznRvmpnsJSKMBVIzNmA/FD8nOMov6etd/Qw90ku/pGFaqfHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042148;
	bh=Im/tU++G14jjjjHOJZeTYHKa9n/Ab54iPQIWNd1ggTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fOJDbDFrQAvbBS0kVgF6rN3897aFnjjCS4HSSUkPLH5WvVQLRUoKAdAhczHWSn3j0
	 KVW8Y7ZBqWIwN65vnqezM3bye5043Vi9fWbp8yVzkLBw1JDQWPKdQd1+zuNKjn2iPH
	 2e7PEqr6KHjlYBL/CcWgA0vt3ZtVQO5hzC85FNkRr22daOFfzg7vjvZRaH26d43OBX
	 HOSUuZKqlVcdB3acTTO4sP54FvrunFqY0oN3wwdjVbtHRZrtOph8jlRIO+SVos0v/8
	 NHFrof5F/6qk3vioSGJ7SXPQzyseP9Rg3cvX3xI+fzl/FP5wt5AlyXx/+XoenhnxE8
	 WxA7ClEVR4aFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F0BB60812;
	Sat,  7 Nov 2026 09:02:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAEDF1C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD37780DDD
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SXSOQTI8Uc8k for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E78BC80D8D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=LWpPP3VU
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E78BC80D8D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:18 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jM96H24GLzMldb;
 Sat, 07 Nov 2026 10:02:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Im/tU++G14jjjjHOJZeTYHKa9n/Ab54iPQIWNd1ggTA=;
 b=LWpPP3VUAomaTqIrD2nkVi8Nbc2A7NV27RDxBCXtrpEEK29u30DV0J1mPb/OUBvMmp3YSL
 57SQqaRYbFTsNN/j1C6LJ1kRtO/CKPS+hZt6fgSq7uCQY7wTZ92DnB/r1YAaDhECG4B7oV
 6Q7UfOkA3Wenw9b3SMdmK3iPj+eU3lXkbzS6al5mx3pyKPE4KfoY0ps0FbF9SAUdZq/lyj
 MHaeQfJtL6yqYwqS4uVKOaeI/1F8cqAe+n8v48+g2WHFcmcbjkzNPKlLj8vj9bclOMEIhq
 PGg1k7/VwPVO8AmOIhomEdMIvIgkwBP8nmpVqD+l83kYY9GHolRk4diHL8eSCw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 7/9] watchdog: max6370_wdt: add get_timeout operation
Date: Sat,  7 Nov 2026 10:02:01 +0100
Message-ID: <20261107090206.2015512-7-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-7-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-7-07de25b6312a@nokia.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 38nat8pz8uy8bwa7jak7q3ji7qoqxqof
X-MBO-RS-ID: 2f0bb55e95d34c06ef4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:34, Juuso Rinta wrote:

> Implement the get_timeout operation for the max6370_wdt watchdog driver.
> This is useful because the device supports a fixed set of periods, so
> max6370_wdt_start() rounds the requested value up to the next one.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/main

Thanks,
Stefan
