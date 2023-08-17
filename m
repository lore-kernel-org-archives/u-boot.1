Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65287C64EAE
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 21:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B50F86BB3;
	Thu, 17 Aug 2023 23:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="EQlO6QTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 100B886BB8; Thu, 17 Aug 2023 23:37:12 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DCEB86B9B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 23:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=GfT0hOmuLDjhprTXVUnU5N6+vSdNbWo6r5cBJ23Jt9E=;
 b=EQlO6QTOLF/jqRtIdIELW6pwifzNyy5+eDLGN7arhJ/4+g8VBEPsLShdtDo0BRP+9xUq
 cS0hAvDoF5sApwl3502jwfWAZMLi+zj7UxZICD4JUwIwvvmvIRZyDqTIHCGuvJK26V5ml1
 DaQcxynnhZAoBjNTek7DjBgu/4JT3aWGzCwwRjDkPhEpybuBq+Cc3B8IHMbRKGnPOWaCEP
 SzSC1FKqCMMR3cxW4LsaIVtPqruP1OJh/WlayhzCo9/x5wjkdO9ZnFUNA5QSCcFd8cYpXL
 7txB5IOUNn8Se4jNLnIbV2g2FRKanUTXNKrfNFFJs3uRxzDeYYVqx2Oz6Dwpbtuw==
Received: by filterdrecv-65f68489c8-qxj4s with SMTP id
 filterdrecv-65f68489c8-qxj4s-1-64DE9303-1F
 2023-08-17 21:37:07.550793631 +0000 UTC m=+8546464.596685853
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-canary-0 (SG)
 with ESMTP id DFCCg7vBSFWj-tEzLk8stg
 Thu, 17 Aug 2023 21:37:07.178 +0000 (UTC)
Message-ID: <064e8282-27f8-602d-ff0d-a12fa23972c0@kwiboo.se>
Date: Thu, 17 Aug 2023 21:37:07 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] doc: rockchip: Add supported RK3566/RK3568 boards
Content-Language: en-US
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-2-jonas@kwiboo.se>
 <32a6441a-cafe-2cef-7b36-cad3fb0232c3@rock-chips.com>
 <20230817192919.GT1515023@bill-the-cat>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230817192919.GT1515023@bill-the-cat>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h93sMGeU+MZNetf36?=
 =?us-ascii?Q?nQlthIq3oAb4We4reR1DImd9MADdAF+V8Ta62Hi?=
 =?us-ascii?Q?HgCmNE3vjbSFWbjIfAmx6CFTh1JmC7tjgKTfldG?=
 =?us-ascii?Q?d7T6PzleAjLy8c1VFn=2FSBbBXwMKGVfRPMRaCE=2FT?=
 =?us-ascii?Q?kriHX=2FuO9PtPLIRqV0YU2TlGjENcjkokSS0CVE?=
To: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=iso-8859-1
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

On 2023-08-17 21:29, Tom Rini wrote:
> On Thu, Aug 17, 2023 at 04:32:41PM +0800, Kever Yang wrote:
>> Hi Jonas,
>>
>>     Thanks for your patch.
>>
>> On 2023/8/17 14:04, Jonas Karlman wrote:
>>> Update Rockchip documentation to include RK3566/RK3568 boards already
>>> supported. Also list Pine64 boards under RK3566 and drop defconfig to
>>> match other listed boards.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>   doc/board/rockchip/rockchip.rst | 20 ++++++++++++--------
>>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
>>> index 31aeb8567607..4668e598515e 100644
>>> --- a/doc/board/rockchip/rockchip.rst
>>> +++ b/doc/board/rockchip/rockchip.rst
>>> @@ -91,18 +91,22 @@ List of mainline supported Rockchip boards:
>>>        - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
>>>   * rk3566
>>> -     - Anbernic RGxx3 (rgxx3-rk3566)
>>> +     - Anbernic RGxx3 (anbernic-rgxx3)
>>
>> This board is using anbernic-rgxx3 as defconfig name, but I would prefer
>> update this defconfig to
>>
>> use name rgxx3-rk3566_defconfig instead, to follow all the other boards with
>> SoC name.
> 
> Sorry, in my rush to get more MAINTAINERS entries updated / correct I
> missed your feedback here.  Jonas, please update and I'll make sure it
> gets in to the tree.
> 

Thanks, will send a patch that rename to anbernic-rgxx3-rk3566_defconfig
and update docs to reflect the new name shortly.

Regards,
Jonas
