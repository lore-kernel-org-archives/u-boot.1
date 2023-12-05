Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49F4C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 11:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30608878BD;
	Tue,  5 Dec 2023 12:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6D8878B1; Tue,  5 Dec 2023 12:16:12 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A457386D12
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 12:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1rATPF-0002Xs-96; Tue, 05 Dec 2023 12:16:01 +0100
Message-ID: <653b592b-bd6a-48f8-acca-c617c5c8c1a3@pengutronix.de>
Date: Tue, 5 Dec 2023 12:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 lkml <linux-kernel@vger.kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
 <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
 <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
 <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de>
 <CAPnjgZ1iyxk0bb56QR10N5aSphRYhLsw7Ly=z2i6rQCxP_AYPw@mail.gmail.com>
 <5e8f42f8-2b03-4033-b6d2-9b3139f081d5@pengutronix.de>
 <CAPnjgZ2RjNzqJTRZSWvuscQhs+f8CG=fDcEO=qKXNeQLP53LnQ@mail.gmail.com>
 <CAD=FV=WXQrbnjeVOLp--vmLzScvW9VLFRu+apSY4WnL9JFk-AQ@mail.gmail.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAD=FV=WXQrbnjeVOLp--vmLzScvW9VLFRu+apSY4WnL9JFk-AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hello,

On 04.12.23 18:52, Doug Anderson wrote:> On Sat, Dec 2, 2023 at 8:37 AM Simon Glass <sjg@chromium.org> wrote:
>> On Thu, 30 Nov 2023 at 19:04, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>> On 30.11.23 21:30, Simon Glass wrote:
>>>> On Wed, 29 Nov 2023 at 12:54, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>> On 29.11.23 20:44, Simon Glass wrote:
>>>> I don't have an example to hand, but this is the required mechanism of
>>>> FIT. This feature has been in place for many years and is used by
>>>> ChromeOS, at least.
>>>
>>> I see the utility of a FIT configuration with
>>>
>>>     compatible = "vendor,board-rev-a", "vendor,board-rev-b";
>>>
>>> I fail to see a utility for a configuration with
>>>
>>>     compatible = "vendor,board", "vendor,SoM", "vendor,SoC";
>>>
>>> Any configuration that ends up being booted because "vendor,SoC" was matched is
>>> most likely doomed to fail. Therefore, I would suggest that only the top level
>>> configuration is written into the FIT configurations automatically.
>>
>> Firstly, I am not an expert on this.
>>
>> Say you have a board with variants. The compatible string in U-Boot
>> may be something like:
>>
>> "google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
>> "rockchip,rk3288";
>>
>> If you then have several FIT configurations, they may be something like:
>>
>> "google,veyron-brain-rev0", "google,veyron-brain", "google,veyron",
>> "rockchip,rk3288";
>> "google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
>> "rockchip,rk3288";
>> "google,veyron-brain-rev2", "google,veyron-brain", "google,veyron",
>> "rockchip,rk3288";
>>
>> You want to choose the second one, since it is a better match than the others.

Now imagine, you are building a kernel that has no DT support for the Veyron,
but instead has support for the Phytec RK3288 PCM-947:

  phytec,rk3288-pcm-947", "phytec,rk3288-phycore-som", "rockchip,rk3288

As far as I understand U-Boot code, A veyron U-Boot would boot the Phytec DT
if CONFIG_FIT_BEST_MATCH is set, although it's a bad match and a boot failure
should rather have occurred.

>> +Doug Anderson who knows a lot more about this than me.
> 
> Hopefully this is all explained by:
> 
> https://docs.kernel.org/arch/arm/google/chromebook-boot-flow.html

Thanks Doug, this was helpful. The missing information to me was that
depthcharge only compares the top-level board compatible in addition
to runtime generated board compatibles, unlike what U-Boot seems to do.

barebox only compares its top-level compatible against the FIT configuration
compatibles, so adding a full compatible list to the configuration nodes as done
by this series should be ok there as well. I think U-Boot could run into
issues though as described above.

Out of curiosity: I only heard about Depthcharge before as exploitation toolkit
for U-Boot. Can you point me at some documentation on what the Depthcharge bootloader
does what U-Boot (which was presumably used before?) doesn't?

Thanks,
Ahmad

> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

