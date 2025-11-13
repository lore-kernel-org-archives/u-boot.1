Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FC8CD8CBD
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 18:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC6383E86;
	Thu, 13 Nov 2025 19:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PkWz5eCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9122583FC6; Thu, 13 Nov 2025 19:40:37 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E36083E76
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 19:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d6pxF4JqDz9tZX;
 Thu, 13 Nov 2025 19:40:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763059233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFCJbatVRPBl1q2L7isPmuEi/ekuimB5jqKJ7E3mYxk=;
 b=PkWz5eCYk3c0EAc154nQi7lcOVQ6r/3HJyvwIsFCG1x99fgvryHLIoOUWWERHxjBaZBvbA
 ONqlOlEhhc2Zj2q/NIw5xu58mjxlPJgvjgFgaCrPMTAcQvPebpjFNvFMNbL5AohFpXHaND
 18eMSd4NzM19YxWns0whtt9m2e6S9XQLqdwWYp1HckkSicLThHr8KAOBiaY2F8QmIgMg2V
 XLQALX7rcbR5C7p8KnlNNT3RwJapXPn+bQul4BwsS8F7Ngme43HJW7Z3kwqi6o7mRR9mn9
 C+iz2BmHatDBX4CZY2qbVoVxsRQ6LYzXvGn6LNXhTg3/lyykPeRdnMlUoXHQHQ==
Message-ID: <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
Date: Thu, 13 Nov 2025 19:40:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251113175700.GM6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1e94580e94cfca04995
X-MBO-RS-META: 567jcpjyxujo6hdxe9w3dmkuoa9coqfh
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

On 11/13/25 6:57 PM, Tom Rini wrote:

Hello Tom,

> So, taking a look at the test branch you pointed me at, my big concern
> is size growth. On imx8mp_dhcom_drc02 (where we're already LTO'ing),
> with the CI gcc-14.2.0 toolchain full U-Boot grows by more than 6KiB and
> SPL by a bit more than 2KiB. This is a bit of a worst-case, imx8mp_navqp
> is a bit more than 3KiB / 548 bytes, with the average feeling like
> ~4KiB/1KiB for aarch64.

Do you know why this growth happened ? Is that in libfdt ? How did you 
find it ?

[...]

> Rather than a full-resync for the last time we needed a feature found
> upstream.

I really don't want to do partial resync, it will only make it harder to 
maintain obsolete code base going forward. Even this resync was hard due 
to that exact current divergence.

> There are things we *need* like to be 8-byte aligned and also the
> phandle resolution thing I believe inspired your investigations here,
> but I don't know if we can take the whole sync. Or maybe needing to work
> with upstream to shrink down some parts, I'm unsure.

CI does show that no boards went oversize . If there is some growth on 
existing devices, maybe we can shrink that, but maintaining obsolete DTC 
code base going forward and picking random updates into it, that will 
only lead to increasing maintenance pain, so I don't want to do that.

-- 
Best regards,
Marek Vasut
