Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F1AD66BBB
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 22:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EDD83B55;
	Wed, 17 Dec 2025 23:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g7cDYxA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C50883B55; Wed, 17 Dec 2025 23:58:21 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D2A83B49
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 23:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dWq2x2yXxz9t9K;
 Wed, 17 Dec 2025 23:58:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766012297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIwxoBRt2TT8zE13xDCXJ+6xcwHvEodaAPQVXmp0Kv0=;
 b=g7cDYxA6e4vONzsXXeD4+AxmH/J4wYt2Np+xNl3k9hCPO2hgKSDts2bLgfFMOAhofW1DmC
 3TYAPnTXoCuqtRVjuI1kowkgbtnQONbR/Eo2pCWk+neiOxVbB/MynrQKFIV+YTjQSOKgI4
 6L8RHxnjdIxzoIMRZrtBy+V0a06HJBuPG6IpNH1AlGEKFzGE+Ypf/ypADX7d5snO6eQDqr
 c11xkqsVPcWlpWcVu6tZGArYKJNjx7dubHSA0YqtiLe7/hFgbxcUgzpHzaHL17xLwyJOZk
 b09u+07T6N/3cS9q0UG0IyH4Int6iHrLfzKHoPRh0ILXsJ8ReYeqQSqR1blMiA==
Message-ID: <bdfbfcbc-74f3-4191-b4e9-b4de0e8cbd16@mailbox.org>
Date: Wed, 17 Dec 2025 23:58:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] env: Add single to redundant environment upgrade path
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>
References: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
 <20251217201323.756419-3-marek.vasut+renesas@mailbox.org>
 <20251217205610.GF303283@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251217205610.GF303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 29dfd9993b2c077b34e
X-MBO-RS-META: dgxbcpupk3r1jcbhue1winemr9dbxdag
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/17/25 9:56 PM, Tom Rini wrote:
> On Wed, Dec 17, 2025 at 09:12:33PM +0100, Marek Vasut wrote:
> 
>> Add support for converting single-copy environment to redundant environment.
>> In case CRC checks on both redundant environment copies fail, try one more
>> CRC check on the primary environment copy and treat it as single environment.
>> If that check does pass, rewrite the single-copy environment into redundant
>> environment format, indicate the environment is valid, and import that as
>> usual primary copy of redundant environment. Follow up 'env save' will then
>> store two environment copies and the system will continue to operate as
>> regular redundant environment system.
>>
>> Add test which validates this upgrade path. The test starts with spi.bin
>> which is pre-populated as single-copy environment and then upgrades that
>> environment to dual-copy environment.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
> 
> For merging, a cover letter makes things so much easier, please add one
> for v2. And, I think this needs a Kconfig option. I'm sure you added
> this because someone has a valid use case but it's going to grow too
> many platforms where that feature isn't likely desired. Thanks.
Do you actually observe growth ? Because this is calling existing 
functions, so the growth has to be in units of bytes tops.
