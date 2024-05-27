Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144C4C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 06:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286D787D5F;
	Mon, 27 May 2024 08:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716790455;
	bh=In4KfhjlzmVbyRKmIftnN6/BurAkIsEgeGggq5xEtAc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=C8DLEx6q514z0Yf8Zc09ixKPo+7X9Ggaid/PMDdFIki+OCjOIsL/fyeUGXHOLXkkZ
	 iAezyjM3WojQ0yEZT++/pAxYoxpuq+FVdo0O/f5kE2SCMTKqM08jtvSsNm/UAq+uWW
	 iW+KshdFLh3BeblOhMYbRmXRxwmRftwjZ8XwFSkMyw3Rj9NvajYKYlQBrhYve59MD1
	 Hojm8bYwNqPFxkNef0qHa5kPY86QfZqIJ3AtTtR6L1JiSpf60HzkAVc2HXORa6Q1JV
	 KOUDQNEM0771rObSY76CVy3iu0vhU+F60mRqI+LggiPn42Bc0HA29NzviDJpbw4Dj8
	 uAfgPfMJqvueg==
Received: from [192.168.1.107] (82-131-156-226.pool.digikabel.hu
 [82.131.156.226])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 63A0787F4B;
 Mon, 27 May 2024 08:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716790453;
 bh=In4KfhjlzmVbyRKmIftnN6/BurAkIsEgeGggq5xEtAc=;
 h=Date:Subject:From:To:Cc:Reply-To:References:In-Reply-To:From;
 b=hmB8uhtcmPuuMI1sJJVg/C3E7NQ8Jm3ksql8J5EMpe7NHADyyOTUk4sWzVvR+xuHH
 5/wHqG4p8Chyx922UJd1cHdhj0o8pNgu9q3ofGI/4dh1LZt3CE3XDF4nahgzWnvhJs
 xnaazGUcNyYnMfTePwj/8qZOye+MFo9X7teTapY0880YcLULoXI4yrPK02k5HeU19G
 HGtdgfNAgvC7jHJOsChcmXhdOTkEuYW4Y4GhdGfjt9qRPrYHBPsVtd5Kcs6ECrCrn4
 QlJqdR9j1v3hD7uJqK/0AZwMMxIItKSOGNInO3EkOA5F19A6ZQ5bP7sZKLck6WFv+4
 zROYluLwVpRiQ==
Message-ID: <2f9b3e7f-5830-ec03-7ada-6b1fb605d5ee@denx.de>
Date: Mon, 27 May 2024 08:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: Add support for ZSTD decompression
Content-Language: en-US
From: Heiko Schocher <hs@denx.de>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@sifive.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20240430102358.11163-1-piotr.wojtaszczyk@timesys.com>
 <c02ef9dd-669a-9ea5-b764-c03ddff7ee75@denx.de>
In-Reply-To: <c02ef9dd-669a-9ea5-b764-c03ddff7ee75@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Piotr,

On 06.05.24 16:07, Heiko Schocher wrote:
> Hello Piotr,
> 
> On 30.04.24 12:23, Piotr Wojtaszczyk wrote:
>> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
>> ---
>>
>>   fs/ubifs/ubifs-media.h |  2 ++
>>   fs/ubifs/ubifs.c       | 55 ++++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 55 insertions(+), 2 deletions(-)
> 
> Looks good to me, thanks!
> 
> Acked-by: Heiko Schocher <hs@denx.de>

Just tried to apply your patch (sorry for being so late) and checkpatch
dropped some warnings, see below. Could you please fix them?

Thanks!

bye,
Heiko
[1] checkpatch warnings

WARNING: Missing commit description - Add an appropriate one

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
#160: FILE: fs/ubifs/ubifs.c:30:
+#if IS_ENABLED(CONFIG_ZSTD)

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
#172: FILE: fs/ubifs/ubifs.c:50:
+#if IS_ENABLED(CONFIG_ZSTD)

CHECK: Alignment should match open parenthesis
#174: FILE: fs/ubifs/ubifs.c:52:
+static int zstd_decompress_wrapper(const unsigned char *in, size_t in_len,
+                          unsigned char *out, size_t *out_len)

WARNING: braces {} are not necessary for single statement blocks
#183: FILE: fs/ubifs/ubifs.c:61:
+       if (ret < 0) {
+               return ret;
+       }

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
#199: FILE: fs/ubifs/ubifs.c:99:
+#if IS_ENABLED(CONFIG_ZSTD)

CHECK: Please don't use multiple blank lines
#212: FILE: fs/ubifs/ubifs.c:112:
+
+

CHECK: Alignment should match open parenthesis
#231: FILE: fs/ubifs/ubifs.c:215:
+               ubifs_err(c, "%s compression is not compiled in",
+                               compr->name ? compr->name : "unknown");

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
#239: FILE: fs/ubifs/ubifs.c:280:
+#if IS_ENABLED(CONFIG_ZSTD)

total: 0 errors, 6 warnings, 3 checks, 101 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

mbox has style problems, please review.

NOTE: Ignored message types: COMPLEX_MACRO CONSIDER_KSTRTO ENOSYS MINMAX 
MULTISTATEMENT_MACRO_USE_DO_WHILE NETWORKING_BLOCK_COMMENT_STYLE PREFER_ETHER_ADDR_COPY USLEEP_RANGE

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
Wende an: fs: ubifs: Add support for ZSTD decompression
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
