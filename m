Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64960828AC
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y9cNE2Ic;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=QDRCBwKm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0625D4089D;
	Thu,  5 Nov 2026 19:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kkMJRXBz8tSu; Thu,  5 Nov 2026 19:31:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3DDB94084B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793907060;
	b=sSXfgsUoaXLVJz0FohSTYvabyOcs0HfhfUSd4xYBuwtsUzP0on8CTvq5G0xd3Xeb2q1l
	 JBaeTJ5J83EqeJF5WLAYYu0nyUGDT8GkxJx06i1HrvHOuNGs2LKXfYBFhvlcS/fg2Ai3r
	 xUq0hq47JaUzs7SOI8zjJ70sgVXtwy7htz1WRWqSfBAgOc3a6Dh7zSS7Mr5REodduXkA6
	 faurLU7s95Ry/hzkNH3ixreLvuGtX0jQw6EKnKIeebT3t25PUnYC2JPnWrQZN1ksKRvVT
	 na48mBBZEpOA+TDfn15ltEKT3FP/fOXkSmRq9h5gFEpPiUDBe6lv681T9U4HwXIKlJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793907060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2GI0B7Afa33mcygN6MMz3pVqmFhzGgXJQXXFg607vak=;
	b=QUXpHYxSBo5tAUkodS3/mpuJm5Cv0YsDWTm0sqhvvz8UQETa8EuXO/Y2sez/FjK3zGrC
	 LDQvg5ibZJ5blRzv0n/Gv0TadzF90YMDq9AaF2lxNVyR0hF/IFkxdPXZJ7CuxlhWHRspn
	 6rlWg11Et9A4LFl0t61wwIDA0lfhcwT0QiaADkgC9Rz/Dq0hBeMh8I8RSrtDxmiSM7GwJ
	 7TQjnVkQTQLx99MEbG8VewiW89Ge2PdHyeXFgA5DvHa7TFS7k8Cy4NGDEej+ljbgv9G+e
	 FJ/4LgfYaSRxD7EAuVdn0sCxDLW5Emw+P+PbO1utIR9yoRmo13NlmXs5RAowYXkWK/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793907060;
	bh=2GI0B7Afa33mcygN6MMz3pVqmFhzGgXJQXXFg607vak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y9cNE2IccQhAWFgTZVOcDa2f1AaadILy0fYTI+eP1oPRrPq5uDma6mPgsxgy4ANM/
	 JDiqHNM11/vT8BjdVOM9j859vhVh8gMfmU/F5fKRWgO0vnEOrpZJY7VV3GcNb7IOM5
	 oEJT75UwE51zDx5PAMpja1ewGKeVktKzwJN/xnMelin7Yuv+wSkTVXDaSDMHkb5VMo
	 qsVLRE0fgtqIXH7I8Pjvp8xAVV0EU2JFlwfmWx04X8XWPRHqByicVjeaXlGwXYd7mB
	 jMcC2s6oxa7Stm1TacaKApez16NJbCzb139qZJJR0MXbHxVu0MR+Dhznj4NKRLgGUV
	 pBJzCvQ2dAqeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DDB94084B;
	Thu,  5 Nov 2026 19:31:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C0F4235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21D3740363
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:30:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yiI0V4tnCSRR for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:30:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 00396400FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=QDRCBwKm
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00396400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:30:57 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jLC8Y4h3czKmGJ;
 Thu, 05 Nov 2026 20:30:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793907053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2GI0B7Afa33mcygN6MMz3pVqmFhzGgXJQXXFg607vak=;
 b=QDRCBwKmb8GlkpYMiIGjwOnNSluwj+xBCsJMPS6y/Zs9o/kwU/frZreuBtEna64LHqcfPk
 lORj2SEWf9HFMMEMbxlLI2hCYmjsmIeF7ej+cKxeONHIa69uNunnyvjdKDxLx0l9Qnrnpk
 wwvhvTy6+Rxlrccj4IFnFFB2hG84MtOQQMLjZUf6t7corr3jDuTGl6zY+x5aQtLUPpH6c9
 bMhxG/BzFqvND72IwoWnN4BCbVhq4u7uyb/P0PC3c1bLoX4bWiqOm0C9JejQk7KA6WfafT
 ZyEqRE/MS0ysu5O2Ylyc3siqCGVLdEWuO0NQW5Hu9WPsKXgkAP07/p7yT6RclA==
Message-ID: <4990ee4f-bab5-4a34-9b96-4608a69555eb@mailbox.org>
Date: Thu, 5 Nov 2026 14:56:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: renesas: gen5-cm33: Start the generic counter
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com>
 <bfbc69c2-32fb-4d2d-858d-a4ed36ccf592@mailbox.org>
 <4c9fc2c7-c131-4e6e-908d-0a7e8e6ffb17@baylibre.com>
 <4e720f9a-be35-45a2-9d90-d574ca7b488a@mailbox.org>
 <7fc1e0d3-c7f4-45ae-914f-d485f1ed25eb@baylibre.com>
 <172cda1e-2147-4ce6-8d2d-27ddcb7cdbc2@mailbox.org>
 <26d469e1-b752-4da5-ab1a-424cb3411ab9@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <26d469e1-b752-4da5-ab1a-424cb3411ab9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t61cjnogt7fhz6bpe17jyxm3rzi68t6w
X-MBO-RS-ID: 16fca0302b3f7b75839
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 11:08 AM, Clément Le Goffic wrote:

Hello Clement,

> On 11/5/26 2:41 AM, Marek Vasut wrote:
>> [...]
>> Why not start the timer using the SCP when there are actual users of the timer ?
> 
> I tested it and the SCP can start it. I'll move it there, so this patch can be dropped.
OK, good.

-- 
Best regards,
Marek Vasut
