Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDAEC77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 15:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B541582E25;
	Mon, 23 Jun 2025 17:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="r214972p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F2382E27; Mon, 23 Jun 2025 17:26:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0AF682E05
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 17:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750692387; x=1751297187; i=xypron.glpk@gmx.de;
 bh=MYpZ8Rp2x14iAMpYhIqG9GOQLE2N66xcfU6ac60uYuo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=r214972p5djqiyUQ356YqPYKnVvZI7xBEDQBw1fmXVEqb2u3XcWIqWVcLLHejNAq
 1d8y0HoyyqcaQ0mhbWgX+69lxKqM9vK5AondLzudaFtbQYEzki7FvEajSFKRccGht
 2y49/GTNJ3NfInGc4b0pC7zGmqTXvfvaldI+YTqqPm73e/vtcHGFSvqRR4tP4TI9g
 30WSZES+3RsTwDh52nztgUYVowA7jk7gyj6m3ulC/072DGavi9Ke/kYKHcmIht0ci
 DWjsOuNacaY2viJpcpCqqKBfsndlZurIXow8R+PTjEtNw0JnwFLqEhY1ul8Eh0Nun
 bYG2vFYYjuXvY5jdyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mKJ-1unpDF32nj-00zPWY; Mon, 23
 Jun 2025 17:26:26 +0200
Message-ID: <5458b145-0486-4cb9-b98c-47fd350ce334@gmx.de>
Date: Mon, 23 Jun 2025 17:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Was plain U-Boot affected by CVE-2023-39902?
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Rolf Eike Beer <eb@emlix.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <5896532.DvuYhMxLoT@devpool92.emlix.com>
 <20250623151335.GD4003484@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250623151335.GD4003484@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w8QIDwnwsPUxdguIZAkxZBUMqefglaVtXXdmqkPCjJzjdF0IucY
 hhoAJLg0L45u8OeAn16QAbNMTyZH7IGwQ7FdmFXvQm3zbhhvQ6gSJ6yz7AgOtJW0WcYh9+u
 4iUeL1CUZ+1ANQRHxFebFnpHmkLubNidChzf2WDZEby0OpGUIXU3yJm9a8MIG9n3+vaP5o4
 t7zH6I1JWO5L8C+imiZLA==
UI-OutboundReport: notjunk:1;M01:P0:uN/eG8J/DL8=;bOl1H2khn2vSfiGQ1cPhRRUm2Rr
 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
 pxyRDqSsoKSmbW1WvKoC//L5Q
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

On 23.06.25 17:13, Tom Rini wrote:
> On Thu, Jun 19, 2025 at 09:35:25AM +0200, Rolf Eike Beer wrote:
>> Hi all,
>>
>> for entirely unrelated reasons I came accross CVE-2023-39902:
>>
>>> A software vulnerability has been identified in the U-Boot Secondary P=
rogram
>>> Loader (SPL) before 2023.07 on select NXP i.MX 8M family processors. U=
nder
>>> certain conditions, a crafted Flattened Image Tree (FIT) format struct=
ure
>>> can be used to overwrite SPL memory, allowing unauthenticated software=
 to
>>> execute on the target, leading to privilege escalation.
>>
>> This links to https://community.nxp.com/t5/i-MX-Security/U-Boot-Seconda=
ry-Program-Loader-Authentication-Vulnerability-CVE/ta-p/1736196, which lin=
ks 4
>> patches. The relevant one seems to me https://github.com/nxp-imx/uboot-=
imx/
>> commit/0746cfd931de8f7591d263ff60dd806ffe23c093, and for my limited
>> understanding the actual fix is the first hunk.
>>
>> A similar change has been made in 6039e0edc8540bd2a ("imx: hab: Simplif=
y the
>> mechanism"), so I wonder if this is just an unnoticed instance of the v=
ery
>> same bug?
>>
>> Opinions?
>=20
> Lets add the iMX folks..
>=20

MA-21597 check spl fit pointer before parsing it
https://github.com/nxp-imx/uboot-imx/commit/6cb283bb4e19da6667abaedd83efc2=
3a15fdc48d

could be improved:

The check should better be in fit_config_verify() to cover all usages.

Best regards

Heinrich


