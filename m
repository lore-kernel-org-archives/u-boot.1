Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBB4E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 08:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904988021D;
	Thu, 19 Dec 2024 09:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=epsi@gmx.de header.b="FMzp7MN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C42228022B; Thu, 19 Dec 2024 09:10:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC01E8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=epsi@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734595821; x=1735200621; i=epsi@gmx.de;
 bh=+HEQYM4U+34TkAA4xXQ6LQGD1vcaXDFwsXJr0o2njNA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
 Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FMzp7MN+/npf9RsetUkp4U5/oCs1fb9cvAV6taEWIQjLI3I9MDpe9FZDzjgH+Q+R
 mA9CTvo+rjnVtUViBwj8Yxk/kNv2r7pE1YQmS3gv/wqeASk0u1MUYOIhd6b7hwQa4
 hM3FSZ1zf00OlY2LyBeS5G0untReT1kSyQJPPw7LCw6d3+X5rhFgUUmnTvrbBTWDX
 8mhI68Fmb+vhJpfdBQkNPTGuE4LQEhZOjPizPGkTofnECfnmxw3Xzsb3/3JevhbwU
 AA8OwtrxmcYYDrr7wIr131b8PsfblxrZq6cMvSRSrn2x/0uXJW2ikJoxvAG0ROXB7
 ZcOyNGCqM/HNHammFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.179.8] ([84.185.236.138]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnJlW-1tpZnd1WTc-00fI7d for
 <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:10:21 +0100
Message-ID: <249ef954-794b-4b89-bc88-a2e79f49eb60@gmx.de>
Date: Thu, 19 Dec 2024 09:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-US
From: Elmar Psilog <epsi@gmx.de>
Subject: imx8mp / Can't support legacy image
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0SJpFaWD7FqlBJ2SPKar/cSUPeY82U8TYiEX+uh2EdIMjtZ3Fvv
 0IV+nA+RvWhHrL1PylcBuzUqDl3NKYIHXUXIo2DKSuAMxTSnZtOhDoBVxsYSEHKMjD086Gu
 congsmDNjlXHL4EXWslY9bLAUAakmupJYxpHiUzIpL20XLiOlCgKqTwKXXjyJJsUi8bVV24
 ScdJJUqd9A+SM6yshwHhQ==
UI-OutboundReport: notjunk:1;M01:P0:2f5Y5qPw1jA=;ttj+IPddDzsqkYQ5n00ySnogdX1
 9kjlq7VKemE+jqCR1G2/DT0Xm20JboZxiwLcLlqIcF43RcF3UypHvauNdKlq08g4k0aaAM1iA
 MysCPGsuG3WBeXxjMOiApWIoO2Kccp4lSVHhA4StJat+5QQqduJsl6TD9m/hJucAIJdbiHDFc
 t2Cc0pLkopvkjEI9iqBiAW1uILB/5dwnpSED16cr2jO6JGDRyXCU/9kAtB9441D0sGtsSqWLL
 0zt5JEG6M7dkN/fwtZU+h06JtR9uRnjnX/abXR51UgFZefCJs0R9FveI+Z/1opGLylTViinnx
 jNEkMOuZO0WE164ulHAA0Ip+3zIVKpz2wK0tJcJLHVOkFUiEvmda5TCusedjT4qG0uPo2PLo0
 A/6o+iThr6zX2PkVkUv4KqDVUAk91DLWMrl8jFUtsJCFDDp175gMniDr7RSUicFvggldzJavC
 bnXmJd5NbrhdQpQrB9x9HB50L8PdRq26JFTnujes/U5MYhj7xnob3IihzuR5T2EHROyNXGRZY
 JrSBPP48b/fX9VFkm/CNEPBPK5mUyLe7aDaIuzqHd3bQtNuDk8I6KZCnaSj3yA13yPGon4UWx
 yklvLrTcv7+DPEUqRZBgUOicWgp72MygQnsfzK1kEflBzZEzBCPDNfw3+mn+3/EZbQ8tkg6/A
 XAZjPMLGE2XLWvIbp2STmXYixhPxrCNfdNwi+TaV+QeiAtt/ur8USOpjInj50lb0IU02XlUQ5
 OIzbqZOXrU43Py3j+dabDWJgtBgb58Lcjfi+nWG+cMDdTUGX7efqEI4WW/G1VFJqZg6/4gWRQ
 vZrUFJHljhBn8ssLxQJVsZ6bvOOaOM6c8HAGBB27wtzy56/VMr76NDvwDTXIjacLkzcTEMoh7
 K8pix1RaQoWgik3Pz0TcUg9EXf6mHNyRfu1FWqjLEfhNKspOYZlJDzNDYVTgffJuFiu1XZMQJ
 0PG9bZtTX/gw/EdoLsu4gVZSygRoaWweOLXNm9NUsvhl6wRUQeNqBM6GsueiUzbuf3GdWZIos
 bQN00DSX6hNGVEkUNx0OlcGEBnsOAyFvRt4SV13FHlESTzPK/s6bbSQ2D+1otBE6bQPrmaa2M
 zBk+nyn2CGLIwOt5rnzajVz9gXPwWa
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

After switching to a new RAM I am suddenly facing an issue that
Uboot/SPL stops with:

U-Boot SPL 2021.04-00020-g2b6bb90793 (Jan 25 2022 - 11:47:36 +0100)
Normal Boot
WDT:   Started with servicing (180s timeout)
Trying to boot from BOOTROM
image offset 0x0, pagesize 0x200, ivt offset 0x0
Can't support legacy image
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

We running a imx8mp board where emmc is preflashed with an Uboot and
environment. Originally the board was equipped with 1GB RAM.
We switched to 2GB RAM of another supplier. The board still boots fine.
That was important, as no new preflashed emmcs are needed.
Of course (once booted) we reflash an uboot that recognizes full 2GB RAM
and have adapted training data.
Now we switched to another supplier and have this issue above.
So far I can see RAM init was successful (no errors here), so I am
wondering what might be the reason for this fail?
All I found points to some ATF stuff, but there is no change?!? What
does the RAM deal with this?

Additional weird: When booting the uboot with 2GB support (which is
2023.04) via uuu it seems not to read the environment and reports:
Loading Environment from nowhere... OK
.. although all parameters handling ENV (position, content, settings)
keep same in this newer uboot.
Ok, there is a mix of newer uboot and environment that is saved with old
uboot but that shouldn't be a problem?

For us this is a pain, as we have a lot of boards already soldered with
this preflashed emmc that doesn't boot new RAMs and has to be handled
with UUU.
I would feel better to understand the problem here...

And one important question for the future: How likely it is that switch
of RAM needs new training data? Or isn't that more a board specific
thing (if parameters like size keeps same)?

Thanks for any hints, and Merry Christmas next!
