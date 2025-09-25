Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAE3CAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 15:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0438206E;
	Thu, 25 Sep 2025 17:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEF88206E; Thu, 25 Sep 2025 17:47:12 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79632800D7
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 17:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.29]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 02007B2201C7;
 Thu, 25 Sep 2025 17:47:05 +0200 (CEST)
Message-ID: <c80dcbd0-17ed-4490-a16d-d5b26f13f010@freeshell.de>
Date: Thu, 25 Sep 2025 08:47:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: Aristo Chen <jj251510319013@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, sjg@chromium.org,
 alpernebiyasak@gmail.com, al.kochet@gmail.com,
 paul.henrys_ext@softathome.com, bb@ti.com, y.moog@phytec.de,
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com,
 n-francis@ti.com, afd@ti.com, d.schultz@phytec.de, d-gole@ti.com,
 ravi@prevas.dk, carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de,
 alice.guo@nxp.com, Aristo Chen <aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <20250924135139.GH197373@bill-the-cat>
 <20250924140524.fy46p7ifr4oxh5mc@uncooked>
 <CAJwFiG+M8v3RA9=E296s8xc+NnK3HxwBspw30LsXUBMpzB18ew@mail.gmail.com>
 <CAJwFiGJAkESqDDpsuMe1jxYcZD=G+m+2OFuSW3Jzqh4=Jxm_Qg@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAJwFiGJAkESqDDpsuMe1jxYcZD=G+m+2OFuSW3Jzqh4=Jxm_Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 9/25/25 06:49, Aristo Chen wrote:
> Aristo Chen <jj251510319013@gmail.com> 於 2025年9月24日 週三 下午10:33寫道：
>>
>> Nishanth Menon <nm@ti.com> 於 2025年9月24日 週三 下午10:05寫道：
>>>
>>> On 07:51-20250924, Tom Rini wrote:
>>>> On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
>>>>> Hi Aristo,
>>>>>
>>>>> On 9/24/25 04:43, Nishanth Menon wrote:
>>>>>> On 06:37-20250924, Nishanth Menon wrote:
>>>>>>> On 10:59-20250914, Aristo Chen wrote:
>>>>>>>> This patch series enhances FIT image robustness by adding **memory
>>>>>>>> region overlap detection** to `mkimage` and fixing existing overlaps
>>>>>>>> in DTS files and `binman` tests.
>>>>>>
>>>>>> [...]
>>>>>>>>
>>>>>>>
>>>>>>> Looks like i see a build regression in linux-next after this series.
>>>>>>
>>>>>> I fat fingered that one.. sorry, I meant u-boot next.
>>>>>>
>>>>>>
>>>>>> Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
>>>>>>
>>>>>>>
>>>>>>> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
>>>>>>
>>>>>> I  believe there are outstanding comments on V1 that have'nt been
>>>>>> addressed either. Can we revert/drop this series for now while the
>>>>>> comments are addressed?
>>>>>>
>>>>>
>>>>> Similar to Nishanth, I am seeing a build regression, itb.map:
>>>>
>>>> Sorry for the noise all, I've reverted this in next now.
>>>>
>>>
>>> Thanks Tom.
>>> --
>>> Regards,
>>> Nishanth Menon
>>> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
>>> https://ti.com/opensource
>>
>> Apology for introducing the regression, I will find time to fix them,
>> and thanks Tom for reverting my patch set to unblock others
>>
>> For TIFS stub entries on AM6x platforms and the starfive visionfive2,
>> sounds like the image in the FIT will be selected during the runtime,
>> so they are not really overlapping each other. I will need to figure
>> out other way instead
> 
> 
> Thank you all for the feedback on my FIT image overlap detection patch
> series, and apology again for the issues that I introduced
> 
> Currently what I have in my mind is to have the following 2 changes in
> my patch set
> ### 1. Add support for mutually exclusive image groups
> Some platforms load only one image from a group at runtime. In the
> device tree, we may have something like this
> ```
> tifsstub-hs {
>     // ... existing properties ...
>     mutually-exclusive-group = "tifsstub";
> };
> tifsstub-fs {
>     // ... existing properties ...
>     mutually-exclusive-group = "tifsstub";
> };
> ```
> The overlap checker would then skip validation between images in the
> same mutually-exclusive-group, while still catching genuine
> overlaps
> 

I am not keen on stuffing more complexity into that data to solve a
problem with its data checker. There is already a common compatible
"starfive,jh7110" shared among starfive_visionfive2 supported boards in
U-Boot.  May as well rename starfive_visionfive2 to starfive_jh711x, now
that there is confirmed JH7110S and JH7110I CPU variants differing only
in QA'd voltage, divider, and operational temperature set points;  so
instrumentation of common compatible into the proposed classifier would
have to allow expression that one compatible is equivalent to itself or
a list of other compatibles i.e. "starfive,jh7110" equals
"starfive,jh7110s" equals "starfive,jh7110i". However you want to
implement that, is the data checker's job not the responsibility of the
data to forecast what it may or may not be similar to. MAINTAINERS file
in my opinion is the data model, but instead it would be to silence
warnings, and in one big uniform file not spread over the whole code base.

If you can show me how this removes complexity for say, adding another
variant to starfive_visionfive2 as a thought exercise, I'll buy into it;
we did this once or twice already with removing the need to give a name
and explicitly list each fit definition, which you see now as fit-(n)
and as it happens these generic number-sequence names are more than good
enough; the transition to OF_UPSTREAM allowed to drop per-board dts file
maintenance; whole classes of maintenance gone and we don't worry about
it again. Adding a new variant is simply add to CONFIG_OF_LIST and also
whatever eeprom data comparison logic at spl.c to select it at runtime.

But then, what of one board (not visionfive2) that has two very
different configurations with overlaps to itself? Something with
multiple architectures but only one may be used, selected at power-on.
Okay, well those are named by their dts filepath as named in OF_LIST,
then for example. Again the MAINTAINERS data model I think fits.

Thanks and do not make it so that every variant added needs some
additional edit or created file or commit just to please the data
checker. Wildcard-ing is good, the ideal is that you don't need to do
anything in the normal case, or only a broad one-time wildcard saying to
silence the warnings because what is needed does obviously and
intentionally overlap.

-E

> ### 2.  Change from build error to warning
> Given that there may be edge cases(such as
> starfive_visionfive2_defconfig) not covered by current CI pipelines,
> changing overlap
> detection from a build-stopping error to a warning initially. This would:
> - Alert developers to potential memory layout issues
> - Avoid breaking existing working configurations
> - Allow time to refine the detection logic based on community feedback
> - Enable a gradual transition to stricter validation once the approach is proven
> The warning could later become an error once we have confidence in the
> detection accuracy across all supported platforms.
> 
> Feel free to let me know if you have any concerns or suggestions
> 
> Thanks for your time and guidance!
> Aristo

