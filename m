Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8DFCD1292
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 11:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D9A882E0;
	Mon,  1 Apr 2024 13:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JeflIuKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D35D882E7; Mon,  1 Apr 2024 13:04:33 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF725882DA
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 13:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1711969460;
 bh=sahmdiPJ2CmNsqqjqn0E0udG1RAA6E5GD9/nZ/oayLU=;
 b=JeflIuKJx3VY2Go026J7hCPh8cw95FgLla378kP7rwajKOTRiZE2BJ/0uH6qY94x/KZgMw1nP
 LrGG5TKBrJi52XGE3NM4wp906Rr9ap0S3MMmzZsyj7QzGKeBWMUZORiUZElQX+YLpBfhY+nAQfz
 QyxaMcQODwwntVdMhQf9Yai6z4w/UAFAOUpnD/JrmM5NfpoTJM0Zv4brDs9U0a5zLP1pVawwWz+
 FW9YG7+b+Ka0x48u9cLikyPlAVgDnz5Y/5Aqmh9SIA1rayM0OuLPUf2rNkLleXZ9jnhiNyESdYK
 nnx2LcufzwRRvets7tHuPtWdSPOLRfYjfN4r1JBuPW7Q==
Message-ID: <20774ea8-2e06-4f27-b62a-d2b1e06b71da@kwiboo.se>
Date: Mon, 1 Apr 2024 13:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] rockchip: rk3399: Sync DT with linux v6.8 and
 update defconfigs
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <CAFA6WYPMqRQRpcN--3Mz7czh6MK10W75e19h9VWWp5P6KKbBJA@mail.gmail.com>
 <63f29606-ad3f-4883-9e8b-4d80194c12ab@kwiboo.se>
 <fc5a4ae1-21d6-4b72-a9d8-a551e3753f17@kwiboo.se>
 <CAFA6WYPtay4Z6W7GWsJQA+ejd2XhmSkcVPnDX0xhjPrAf1essA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFA6WYPtay4Z6W7GWsJQA+ejd2XhmSkcVPnDX0xhjPrAf1essA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 660a94b4370fe2807879250f
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

On 2024-04-01 12:53, Sumit Garg wrote:
> On Mon, 1 Apr 2024 at 15:31, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> On 2024-04-01 11:45, Jonas Karlman wrote:
>>> Hi Sumit,
>>>
>>> On 2024-04-01 10:52, Sumit Garg wrote:
>>>> Hi Jonas,
>>>>
>>>> On Mon, 1 Apr 2024 at 01:59, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>>
>>>>> This series adds support for new clocks used in linux v6.8 device trees,
>>>>> enables use of FIT signature check for checksum validation and fixes
>>>>> loading FIT from SD-card when loading FIT from eMMC fails.
>>>>>
>>>>> After this series it should be possible to move RK3399 boards to use
>>>>> OF_UPSTREAM in a future patch once dts/upstream move to a v6.8+ tag.
>>>>>
>>>>
>>>> Thanks for putting this effort together. A switch to v6.8 tag for
>>>> OF_UPSTREAM will happen as part of patch [1]. So if you want to save
>>>> further effort then you can just rebase with a switch to OF_UPSTREAM
>>>> once that patch [1] lands in next.
>>>
>>> Because this is a jump of device tree files from v5.14-rc1 to v6.8,
>>> reviewability and being able to cherry-pick these changes to my
>>> rk3xxx-2024.04 branch, I think it is much more appropriate to first sync
>>> everything to v6.8 and then in a separate series move to OF_UPSTREAM.
>>> Else it can be very hard to understand some of the changes that has been
>>> and was needed to be made to u-boot.dtsi files.
>>
>> Also forgot to mention that these synced DT files still contains some
>> minor modification in #include dtsi paths of files that is shared
>> between rk3288 (armv7) and rk3399 (armv8),
> 
> I can only see rockchip-u-boot.dtsi being shared which should be
> handled automatically. Is there anything else I am missing here?

The following is a diff of arch/arm/dts rk3399 DTs after this series
compared to fully synced v6.8.

Also the content of cros-ec-keyboard.dtsi was excluded in this sync
because it initially caused compile issues.

diff --git a/arch/arm/dts/rk3399-gru.dtsi b/arch/arm/dts/rk3399-gru.dtsi
index d90fe4d40d48..789fd0dcc88b 100644
--- a/arch/arm/dts/rk3399-gru.dtsi
+++ b/arch/arm/dts/rk3399-gru.dtsi
@@ -684,8 +684,8 @@ ap_i2c_audio: &i2c8 {
        status = "okay";
 };

-#include <cros-ec-keyboard.dtsi>
-#include <cros-ec-sbs.dtsi>
+#include <arm/cros-ec-keyboard.dtsi>
+#include <arm/cros-ec-sbs.dtsi>

 &pinctrl {
        /*
diff --git a/arch/arm/dts/rk3399pro-rock-pi-n10.dts b/arch/arm/dts/rk3399pro-rock-pi-n10.dts
index bf026786fa92..c58fb7658d7a 100644
--- a/arch/arm/dts/rk3399pro-rock-pi-n10.dts
+++ b/arch/arm/dts/rk3399pro-rock-pi-n10.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 #include "rk3399.dtsi"
 #include "rk3399-opp.dtsi"
-#include <rockchip-radxa-dalang-carrier.dtsi>
+#include <arm/rockchip/rockchip-radxa-dalang-carrier.dtsi>
 #include "rk3399pro-vmarc-som.dtsi"

 / {

Regards,
Jonas

> 
> -Sumit

