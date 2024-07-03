Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1081AC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 09:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3FE8875D;
	Wed,  3 Jul 2024 11:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719997996;
	bh=JFk8u21y7dmdsjIizpZDch/WWRpPv5qLsZboSEddApU=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=b7bZMyWgOiFQhc66A0/1IMAZx9XekJlmeMoAGy+u1zM7Ydxw3n7jaNyJUv2yS9bZa
	 emFta/T9DiCHMgvbULsZevnTRAhVAQLZ6vVXUrkUJsanTY06RqaYIncal0kBNg7vrU
	 n+luMRw4HN3z+GxfMFZKl0cN69B8zdksdc65C5QWT/eZgHCEc14E0GW5jYr0LfBFPA
	 f0dfNnrsbNN75YivQRV+q6MSxpc0w7jq+Afsmr9Bgmm9jhDNUr+txrjlnZwh8x29Qt
	 b0180hXFyAL8izSDsSeSHL+y4l6LBBR4fQzOvXvV1MkbI8eSZdNi5C+jjt7Zu6gS1p
	 dJvRHmyMTKBqQ==
Received: from [192.168.1.107] (87-97-108-210.pool.digikabel.hu
 [87.97.108.210])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AC9278836C;
 Wed,  3 Jul 2024 11:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719997995;
 bh=JFk8u21y7dmdsjIizpZDch/WWRpPv5qLsZboSEddApU=;
 h=Date:To:Cc:Reply-To:From:Subject:From;
 b=A9AMJQYEEelkEmAsk+iBHIBElPo903uEA8ETSKoUI2tu9aDmhYEZFJUAJH4UhOWiK
 XY5khmrnZQHOqDEtNol7OeWuFPQtyznad4wAYM40QoWYEsO6AYWi6PpkxJIXdxkMPO
 Wo/iEeNjHrZ4T6XvrZu11yBcGBPkO1mcSzEkHDWP8GWUtj0cyBD/cJL9Lxy/UtqHh0
 iP5j9lcrmI6QMDnCarkkjZpA7GWUpJUuSmH2ZHXN2fMj2pp10poEdWOSHBnxRd4NZd
 skBIHfbqVB70ETbJLRhsXS4Fhxx+Gt+wFRXfp44nPIRXAlhOoPbfiF/fcjPFdo9/18
 0HXVVMZMs8ugw==
Message-ID: <2961fe0d-61b7-0c67-3bd3-d5f96cb7d918@denx.de>
Date: Wed, 3 Jul 2024 11:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-ubi
Content-Type: text/plain; charset=UTF-8; format=flowed
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

The following changes since commit 65fbdab27224ee3943a89496b21862db83c34da2:

   Merge branch 'next' (2024-07-01 15:00:56 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubifixes-for-v2024-10-rc1

for you to fetch changes up to 27b169f9d0bed978bea1d86ab8d584da6ada54d0:

   cmd: ubi: check 'updating' before calling ubi_more_update_data() (2024-07-03 08:05:19 +0200)

----------------------------------------------------------------
ubi changes for v2024.10-rc1

fs: ubifs: Add support for ZSTD decompression
   from Piotr Wojtaszczyk

Fixes for ubi command from Martin Kurbanov

----------------------------------------------------------------
Martin Kurbanov (2):
       cmd: ubi: remove redundant initializations
       cmd: ubi: check 'updating' before calling ubi_more_update_data()

Piotr Wojtaszczyk (1):
       fs: ubifs: Add support for ZSTD decompression

  cmd/ubi.c              | 21 +++++++++++++++------
  fs/ubifs/ubifs-media.h |  2 ++
  fs/ubifs/ubifs.c       | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
  3 files changed, 68 insertions(+), 8 deletions(-)

Azure build:

https://dev.azure.com/hs0298/hs/_build/results?buildId=113&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
