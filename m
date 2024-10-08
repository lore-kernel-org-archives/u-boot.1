Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F1ACF0427
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 21:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49F788FD5;
	Tue,  8 Oct 2024 23:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YOa6L7yL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D72CF88FD6; Tue,  8 Oct 2024 23:39:17 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 572F388FD5
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 23:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ecb7=RF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1728423543;
 bh=A99IlZIQBc1PuxlDULbMWv9wr4Rvz6aUC5LFkmmfQYA=;
 b=YOa6L7yLTOQogMwU9+ZBe6FNUjsSc4d//8Zf4n5RHxyNKBpmHmo/occtKKEG9QSJfKQdFLTFM
 lTBi9mtrfzh9waHGzLVuDX/w+76HbMpjYWbOt9DLD0Fjkb+gpCdsipnQgQmoc9c6f/Z+uWlf5+8
 T8wVX/FtBx0mqJJ33WAb37B+ldrmIaQHZ3MG3vlynqyJ87G4qoaJLK6/Eh22x46418K84u80q3J
 kGMfX156/n5BRQT7/kfxlAw7J48yv3lA4z8GszWLK4SOTMpL2dbjjW3CHOkhX20AMN3ihLtaeFO
 pxVmyLmkydVGV7vINUb7Z2VO/ldmwF4tN7W0hX2CAqTQ==
Message-ID: <313d1b40-f37b-42f4-bf77-182bb868eea3@kwiboo.se>
Date: Tue, 8 Oct 2024 23:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: Add Hardkernel ODROID-M1S
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20241008200641.2203023-1-jonas@kwiboo.se>
 <20241008200641.2203023-3-jonas@kwiboo.se>
 <CALeDE9Oi5fgYW2OeHsWG3Bu=C4oacyrqjZwG2fQcn88Y8+i4Vg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CALeDE9Oi5fgYW2OeHsWG3Bu=C4oacyrqjZwG2fQcn88Y8+i4Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6705a67406ac2fc4dcc6816c
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

Hi Peter,

On 2024-10-08 23:22, Peter Robinson wrote:
> On Tue, 8 Oct 2024 at 21:07, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
>> RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
>> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.
>>
>> Add initial support for eMMC, SD-card, Ethernet, HDMI, PCIe and USB.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Link: https://lore.kernel.org/r/20240827211825.1419820-5-jonas@kwiboo.se
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>
>> [ upstream commit: 10dc64fe0f980c47c7e747885ddf7a8c12780337 ]
>>
>> (cherry picked from commit f811548e758b52896f725753086c42b49dc42c0d)
> 
> Will this not just come through with the dts sync process?

The Linux DTs is synced to U-Boot before/during merge window closes, so
for U-Boot v2025.01 dts/upstream will only sync Linux v6.11 DTs.

This board was merged into Linux v6.12-rc1, so we need to be pick DT
from devicetree-rebasing v6.12-rc1-dts or wait for next dts/upstream
sync in time for v2025.04.

This patch picks the DT so that we can add the board for v2025.01.

Regards,
Jonas

> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: No change
>> ---
>>  .../src/arm64/rockchip/rk3566-odroid-m1s.dts  | 663 ++++++++++++++++++
>>  1 file changed, 663 insertions(+)
>>  create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-odroid-m1s.dts
>>

[snip]
