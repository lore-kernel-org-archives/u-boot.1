Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673E0C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 12:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 968D98676C;
	Tue, 15 Aug 2023 14:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692102372;
	bh=T0KCecgTcMjAkR+VouEUq/vIUW9zzYufGgVl/mSGBck=;
	h=To:Cc:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=orhZOGPq+XEcTWojg/IlCgCiEt8nMAUhBsJ7kq65YGfqZZstWlkD4yWjWZbhQMxZR
	 heUSb04fV/7AA7OCg+u/abuYZ2XzLI5oygahoRuMs1aKvjLSeWgodjgb+Pyav96kkl
	 gJeypuK0Yni3kACWGNFw8kxrdWwmYwFfVtu14/HZAwtbcU3pqUVQhsL1vFdaKUHduT
	 6Zp0Z01lYJYwn7aJPYCIs8+nVPzXsHpoNc5FR3EfbX80VaFBwqs1MSQSGq0nqQ9CWP
	 aOtgbqsepsSUcI8l8ruuTm6bIfmkIZGFzUqmJfCR5+gA1nM9lZt6q3C0k6Ax22j/DV
	 dibNU2Of00D0Q==
Received: from [192.168.1.107] (89-186-114-123.pool.digikabel.hu
 [89.186.114.123])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C7F1286264;
 Tue, 15 Aug 2023 14:26:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692102371;
 bh=T0KCecgTcMjAkR+VouEUq/vIUW9zzYufGgVl/mSGBck=;
 h=To:Cc:Reply-To:From:Subject:Date:From;
 b=NhHIq+8rhPqRG9EM1RYskIK84yYg60aIP67prbd2xz2tnacTwiHJBzG8u92LXV1XW
 kx/BfZudrPMq1GQIFxfXoXrMbNjKt6r1+GVMfLNsu+vQCk7hh3XpK0A3xUnu3d5eTD
 sxP5txTVNtDYdGJkZjcfqJhCDava3D92rx8Hw1YaxmpotE+7qmqA3EIZKb8XkLxL/J
 gezGj2D12Q5FCx85Wie7dF/lKbpPEi5AoOoOkeozUBjtfQUDfch56lpYCvn/Gn4vcc
 SoA5Q9JBcBsIHFTe3ehXqMnf1irq/6YqnRA+VJ8/ODpWDv+6HLw76cH0eMwwSxxI+q
 6fu8bRQqK2v3Q==
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dmitry Dunaev <dunaev@tecon.ru>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-ubi
Message-ID: <f8f83f82-4515-c237-8748-c89fae24a60c@denx.de>
Date: Tue, 15 Aug 2023 14:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hello Tom,

please pull from u-boot-ubi.git master

The following changes since commit 832148f675e427060be074c276956962fa9b5cb6:

  Merge tag 'u-boot-rockchip-20230814' of https://source.denx.de/u-boot/custodians/u-boot-rockchip
(2023-08-14 09:11:09 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubi-updates-for-v2023.10-rc3

for you to fetch changes up to 34031e9cce91de323ed711d7e8614c0d12fada1c:

  cmd: ubi: Fix 'ubi list' command arguments parsing (2023-08-15 07:32:13 +0200)

----------------------------------------------------------------
ubi changes for v2023.10-rc3

Fix:
- Fix 'ubi list' command arguments parsing
  from Dmitry

----------------------------------------------------------------
Dmitry Dunaev (1):
      cmd: ubi: Fix 'ubi list' command arguments parsing

 cmd/ubi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=108&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
