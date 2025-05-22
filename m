Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE607C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 12:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E15E8309A;
	Thu, 22 May 2025 14:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ditigal.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ditigal.xyz header.i=@ditigal.xyz header.b="OwazW3vG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D839B8301F; Thu, 22 May 2025 11:19:37 +0200 (CEST)
Received: from mail.ditigal.xyz (ditigal.xyz [IPv6:2a01:4f8:1c1b:6a1c::])
 (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD84F82F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 11:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ditigal.xyz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rutherther@ditigal.xyz
Received: by cerebrum (OpenSMTPD) with ESMTPSA id 93a9ba15
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Thu, 22 May 2025 09:19:35 +0000 (UTC)
Date: Thu, 22 May 2025 11:19:33 +0200
From: Rutherther <rutherther@ditigal.xyz>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] phy: zynqmp: Fix sgmii clk ctrl GTR lane bit shift
User-Agent: K-9 Mail for Android
In-Reply-To: <fb1cc6f0-ee3e-4aeb-8fac-23b7e43d6a31@amd.com>
References: <20250521181620.8175-1-rutherther@ditigal.xyz>
 <7d8ba8c8-49f6-43a3-af45-8a17d106af55@amd.com> <87msb5hxeg.fsf@ditigal.xyz>
 <fb1cc6f0-ee3e-4aeb-8fac-23b7e43d6a31@amd.com>
Message-ID: <420C02B3-274E-4F9F-8A62-788A7A452B68@ditigal.xyz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ditigal.xyz;
 i=@ditigal.xyz; q=dns/txt; s=20240917; t=1747905575; h=date : from :
 to : subject : in-reply-to : references : message-id : mime-version :
 content-type : content-transfer-encoding : from;
 bh=iRhETPhKOyhceo3pu4mpm/ldQ6LO/pT4KJIfqd3h/fY=;
 b=OwazW3vGJB3EeJkjaHZaOgTMye2aOow9yl9HPlitlGvN+vR7TDZ5zr8NJtwD4aPoFPNb4
 4YgV2d+tN8QK10YJJgf9N0Oc8MLFB6T3VTslkYvrdOiBefC5zKC4G6gZlcyQpFZyYvJ9z/Y
 oK/Kw/2c+Wj1ryW/JVhxJJSGwGLwRdo=
X-Mailman-Approved-At: Thu, 22 May 2025 14:30:51 +0200
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



On May 22, 2025 11:03:33 AM GMT+02:00, Michal Simek <michal=2Esimek@amd=2E=
com> wrote:
>
>
>On 5/22/25 10:17, Rutherther wrote:
>> Michal Simek <michal=2Esimek@amd=2Ecom> writes:
>>=20
>>> On 5/21/25 20:16, Rutherther wrote:
>>>> The bitshift in GEM_CLK_CTRL register is five bits, not two=2E There =
are
>>>> four bits for each GEM, and one bit reserved in between=2E
>>>>=20
>>>> This has caused that using more than one GEM is impossible,
>>>> additionally corrupting the GEM0's configuration, leaving GEM0
>>>> unusable as well (ie=2E if GEM0 and GEM1 are used, GEM1 configuration=
 is
>>>> going to write to GEM0's registers wrong value, leaving GEM0 unusable=
)
>>>>=20
>>>> Signed-off-by: Frantisek Bohacek <rutherther@ditigal=2Exyz>
>>>=20
>>> You still have the problem that address which you are using for sendin=
g is not
>>> matching your SOB line=2E
>>> Author:     Rutherther <rutherther@ditigal=2Exyz>
>>> Signed-off-by: Frantisek Bohacek <rutherther@ditigal=2Exyz>
>>=20
>> Sorry about that, I forgot I configured my smtp client to replace name
>> in the From header=2E Should be fine in v3 I sent few hours ago, I hope=
=2E
>
>But your v3 is not in lore=2E

It should be after it is manually approved in the list, like all my messag=
es have to be=2E=20

>
>$ b4 am 20250522060703=2E4863-1-rutherther@ditigal=2Exyz
>Grabbing thread from lore=2Ekernel=2Eorg/all/20250522060703=2E4863-1-ruth=
erther@ditigal=2Exyz/t=2Embox=2Egz
>That message-id is not known=2E
>
>>=20
>> Is full name a requirement to contribute to u-boot?
>
>It is generic rule to fully identify yourself in any open source project=
=2E
>
>Thanks,
>Michal
>
