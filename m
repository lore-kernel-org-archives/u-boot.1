Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5BEEED618
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 16:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B00783C01;
	Thu,  1 Jan 2026 17:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XUTF0sVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A903983C04; Thu,  1 Jan 2026 17:57:48 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6617283BB1
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 17:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dhtL01Wnlz9scY;
 Thu,  1 Jan 2026 17:57:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767286664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXHXjFUTi8XhTRQxOpB3eEWlXBJLUh+YKYQUWQ3t5q8=;
 b=XUTF0sViMmEfmOMj/36aB6Y4VSC0uH383p0BnYVsLSAsC8L74UtkXZoxhgjZ1ERm64l+Ab
 ki3qScgqBaAU1nabrFtA2OR85gm2xl8pqsg4TlIVPbaRNjXVyIyMfgsbxgTmUVnuXUumQQ
 7yhQU7lGf0m2GYTzk0koOPR2o5GdGn9agD6M1Zb7konbJi05VhCBIdW5skmJPXTWpTZnc0
 dtyjgXisbNxUcsE8eQioOoucmd+IdpuhHGI9TOdGSrOli7E0C+Wdggdnqf3N/wWdjGtZwk
 zpokg3I/HS0c+XjxkrUp0rwrjObC4y+zy3S7ow97o7lHRQlVEIUQV/ynlP68AA==
Message-ID: <10d320db-2e8a-460b-8ae6-7583c5f2fd57@mailbox.org>
Date: Thu, 1 Jan 2026 17:54:47 +0100
MIME-Version: 1.0
Subject: Re: Smatch report for drivers/net/phy/marvell10g.c
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <623c39a5-2438-42d5-aafe-bb80dfd12b82@linaro.org>
 <20250806145315.GO124814@bill-the-cat>
 <8a05c8a6-a0eb-4f84-aa48-0d0e0f532fa4@mailbox.org>
 <bxuuwcj7jm33go7yj4jnafoowrttu2qvbxej7nvdn3pm5az4sj@6xpf3ym2s2ek>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <bxuuwcj7jm33go7yj4jnafoowrttu2qvbxej7nvdn3pm5az4sj@6xpf3ym2s2ek>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ba07e8266c97420238a
X-MBO-RS-META: bpqkihyyxno56hqrtok847k39qgz4sk8
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

On 8/7/25 10:36 AM, Marek Behún wrote:
> On Wed, Aug 06, 2025 at 05:36:27PM +0200, Marek Vasut wrote:
>> On 8/6/25 4:53 PM, Tom Rini wrote:
>>> On Tue, Aug 05, 2025 at 05:30:49PM +0100, Andrew Goodbody wrote:
>>>
>>>> I have these Smatch reports.
>>>>
>>>> drivers/net/phy/marvell10g.c:384 mv3310_select_mactype() warn: was ||
>>>> intended here instead of &&?
>>>> drivers/net/phy/marvell10g.c:387 mv3310_select_mactype() warn: was ||
>>>> intended here instead of &&?
>>>> drivers/net/phy/marvell10g.c:390 mv3310_select_mactype() warn: was ||
>>>> intended here instead of &&?
>>>>
>>>> Now there is obviously incorrect code there as it cannot work correctly as
>>>> is, phydev->interface cannot equal two different enums at the same time, but
>>>> simply swapping the && for || is not going to work either. Could anyone
>>>> please point me in the direction of a fix?
>>>
>>> Adding Marek as r8a779f0_spider and r8a779f4_s4sk are the only two
>>> boards which enable CONFIG_PHY_MARVELL_10G (aside, ./tools/qconfig.py -b
>>> and then ./tools/qconfig.py -f CONFIG_FOO is handy to see what boards
>>> enable a given option and helpful when get_maintainer.pl has nothing
>>> specific).
>> They use the 2xxx series PHY, so this code is avoided. However, it seems
>> even linux-next has the same behavior in .select_mactype() callback . They
>> use test_bit() in there, but otherwise also use && instead of || which looks
>> odd. Maybe that is a genuine bug which got ported over from Linux and needs
>> to be fixed both there and here ?
> 
> In linux there is a bitmap of supported interface modes given to the
> function. Then for example we test whether 10gbase-r and sgmii are both
> supported by the host (SoC):
> 
>    ...
>    else if (test_bit(PHY_INTERFACE_MODE_SGMII, interfaces) &&
>             test_bit(PHY_INTERFACE_MODE_10GBASER, interfaces))
>            return MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER;
>    ...
> 
> If both 10gbase-r and sgmii are supported by the SoC, we tell the PHY to
> use mactype 4 (MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER).
> 
> Obiously this does not work in U-Boot it we translate it to
>    interface == MODE_SGMII && interface == MODE_10GBASER
> since the interface variable is not a bitmap of supported interfaces,
> but rather the current interface mode (maybe from device-tree).
> 
> Looking at U-Boot's marvell10g code, I also see mv_test_bit macro
> and how it is being used:
> 
>    #define mv_test_bit(iface, phydev) \
>      ({ if ((phydev)->interface & (iface)) return 0; })
> 
>    mv_test_bit(PHY_INTERFACE_MODE_SGMII, phydev);
> 
> This is completely wrong, since the ->interface member is not a bitmap
> (rather the currnet selected interface) nor are the PHY_INTERFACE_MODE_*
> values one-bit values.
> 
> So this code will not work correctly at all in U-Boot.
> 
> 
> Now as to why Linux also has interfaces bitmap in addition to the current
> selected interface.
> 
> The reason why in Linux we use bitmap of supported interface modes is so
> that we can select the best serdes mode switching behavior for the PHY.
> 
> For example if the host only supports 10gbase-r serdes mode, then the PHY
> must always talk to the host in 10gbase-r mode, even if the RJ-45 copper
> speed was autonegotiated to lower speed (i.e. 1gbps). (There is another
> complication called rate matching that needs to be done in that case,
> but this is not important now.)
> 
> If the host supports both 10gbase-r and sgmii serdes modes, we want the
> PHY to switch to sgmii if the RJ-45 speed is 1000/100/10, and to switch
> to 10gbase-r if the RJ-45 speed is 10000.
> 
> The register configuring this behavior is called MACTYPE in the Marvell
> PHY.
> 
> The following table shows how the PHY will change serdes mode depedning
> on the RJ-45 speed for some of the MACTYPE settings:
> 
>                 mactype=4   mactype=6  mactype=7  mactype=0
>    RJ-45 speed  sds mode    sds mode   sds mode   sds mode
>    ---------------------------------------------------------
>    10/100/1000  sgmii       10gbase-r  usxgmii    sgmii
>    2500         2500base-x  10gbase-r  usxgmii    2500base-x
>    5000         5gbase-r    10gbase-r  usxgmii    5gbase-r
>    10000        10gbase-r   10gbase-r  usxgmii    rxaui
Thank you for the excellent detailed explanation. I have finally 
submitted a fix:

https://lore.kernel.org/u-boot/20260101165317.25595-1-marek.vasut+renesas@mailbox.org/
