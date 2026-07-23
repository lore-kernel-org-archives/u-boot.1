Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2D0C531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 18:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6390080E01;
	Thu, 23 Jul 2026 18:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcrTJ2_41WR3; Thu, 23 Jul 2026 18:35:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3823810EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784831719;
	bh=/qoH+VU+vq6CoPAqdMT6WgNdZ7DhL4yVwlnZJn9zMT0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=y0mtVknhcWkL0PHfg+xwszSfDyqd3hljUo6qB7NHZUCQiFTIMxjLcZnjSyC8yiwGr
	 yXGds7rZDxJJq5lR0Bq8Kh30eP/YFSmpQxLY5UGTp9s6AdPZJvV33jWqFklaMZs2qB
	 SN0Z/bFcERUC9bHpCty++mavUoZ/d+judGvfJbTx2b16eSpJu+pW23FdA+rRSTtbzf
	 znLL6Q2MPWjAfx84DxgnUtFOMM5VQ6VFABpyWH/a7uIYODP6TildVSusgnoHAyj/ic
	 NsItVHzDAgqXHyhZjMHRBDyV232EA4skNF2mEGSlvAxC/oNoCxjr+NsXSh7Auo16Qy
	 QlQux9QvNWDwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3823810EA;
	Thu, 23 Jul 2026 18:35:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 216231B8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F10E240A31
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xmDEZmTZM4zn for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 18:35:14 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0EABB40A43
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EABB40A43
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EABB40A43
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:35:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9E080287; Thu, 23 Jul 2026 20:35:08 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B4F800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 20:35:05 +0200 (CEST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h5ftd14BTz8tYs;
 Thu, 23 Jul 2026 20:35:05 +0200 (CEST)
Message-ID: <23084e8e-ad4c-4f37-872a-9d2a8feb325f@mailbox.org>
Date: Thu, 23 Jul 2026 20:35:01 +0200
MIME-Version: 1.0
Subject: Re: Regression on colibri-imx7 due to commit 9c1b13b3fd27 ("cyclic:
 reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
References: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
Content-Language: en-US
In-Reply-To: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fmpg8sukyq1fs9gsmen7enezqaks8418
X-MBO-RS-ID: 881eee983ad6637354c
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784831705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qoH+VU+vq6CoPAqdMT6WgNdZ7DhL4yVwlnZJn9zMT0=;
 b=ezCb/gDo8KZ66t7JNrxChNbGTMRiv1DjCj5UH9OM64orXMhEzpcm9cun1Hmkk9VCRNCQgb
 yexf09FhDyOAyTg496Np/AfsTKXIlkfZegchcKqDbxE1u6sE6959ERYC4fyu3Z4hGLme9h
 vhrp9AKXOnC/DwkiGIwHWV/pter9UHK6BQl5DBmKd2gSRMuvGRrkdJSEmZaAszl+R/IAne
 lpi3zNo7742YKGolcQCShZRpkbglEcCAX59/WJoPPa0QebB6xpfjZ4V2LkW9pp9g9s+tbH
 xKyc4jU25vP7v+Lt/sWRw1JE6YNoCr5eU/xa9sqs5WaaDD+EHd1o6GjD3L4DZg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784831703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qoH+VU+vq6CoPAqdMT6WgNdZ7DhL4yVwlnZJn9zMT0=;
 b=HI8aVxgX/GgaUW6ucLinNpzWEgLEw+sm27bp0hLGM33d7vd2bX3LunbcjM4iTtLW/SI0n1
 ekWsfoWKZW7xDsXjcWC8OA3lJ3k1kik2lAHSzX8KsiZ2kzqQDOPFfFeC6ElCp66zPnPG8e
 zMSq1Ucfbz9S+GSJJEFzZ7BLRIvLt70uJn3lNC4Zfbkp5tn/UzvxzCM5Lbnn1ZKA4VvLvb
 lJyerrYsMgUA6AYzT0atWk890nP7CEodExcOW8bnlynD9qNq+TqzcN7D2pdmzlTfRhiZMs
 Jc9kV/uK5vA9R5HBSYL+x9jxp09LXTsWkFy0TDXXwAv7mdpv3M2J4QuiaIKtIQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=ezCb/gDo; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=HI8aVxgX
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="ezCb/gDo"; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.b="HI8aVxgX"; 
 dkim-atps=neutral
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/23/26 4:53 PM, Emanuele Ghidoli wrote:

Hello everyone,

> I found that Colibri iMX7 no longer boots when commit 9c1b13b3fd27
> ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
> is applied. Nothing is printed on the serial.
> 
> I bisected the issue: booting the parent commit works fine, and
> reverting this patch on top of current main also restores
> boot. It's not yet obvious to me what in this change causes the
> regression.
> 
> Would it make sense to revert it until the root cause is found?

Give Patrice a bit of time to analyze the problem.

-- 
Best regards,
Marek Vasut
