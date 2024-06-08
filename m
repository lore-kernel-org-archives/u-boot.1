Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D30BC25B76
	for <u-boot@archiver.kernel.org>; Sat,  8 Jun 2024 04:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB5F87F68;
	Sat,  8 Jun 2024 06:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rC5duKSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFAF88005; Sat,  8 Jun 2024 06:35:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F04387E50
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 06:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717821303; x=1718426103; i=xypron.glpk@gmx.de;
 bh=JBWg4hacpvojr/xtW1WH5Nr6D+D9/mHSffh2Qzm1W/k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rC5duKSlZ6UA3qHsdAikNTJMpDG0LbHgFcg5w61RDKrYc0rZ16Ebmils4jQ/AAk3
 fEUwYJlE7/M8nmNndvJ78rUEvwmG7Re1fCY3mdRUkA3lqizBLL3jNTpX26LNmg+Kx
 CyGPaQTG7yaQuOuXB5xrjg5fIeJlgndkAqZv+HN2RBHSAV7oPNJsZyWjrhNKvtUso
 3g+LKLHyCgOvh4LdTSTosUBpP8uAtHNhoF7zsSEgLkjdM8BhAEWPKRyhk0vYjNSQs
 R2WJSHARRKYp7JhvLPKWIsGYomQXY9msleB4sWRNlVK7UEAnbnriJFVmR7RNSmUTC
 486yn5MDD68OLcVQoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKlu-1s49j30ud8-00RiDE; Sat, 08
 Jun 2024 06:35:03 +0200
Message-ID: <4e1d5e85-15ed-4d88-9397-87acd837e58e@gmx.de>
Date: Sat, 8 Jun 2024 06:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/31] lib: Kconfig: add a config symbol for getting
 memory map updates
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-12-sughosh.ganu@linaro.org>
 <388854D8-E73C-469F-A214-EEC175CF000A@gmx.de>
Content-Language: en-US
In-Reply-To: <388854D8-E73C-469F-A214-EEC175CF000A@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GI6lX0pnaoyeFP1o6/5QUVnhpeqCSQIT7iO34PqLJr78MBRMi0E
 XG4OKKKDYIUODRw90pr6lz4QD4OxR6oVjQ2o4jqk9dVU94Scvth2wliVFhi3MlaTfOpf8Dg
 /WJ1qiMrN5Sb1YniGuyAs2lm5VjsRSiLLvGah0AA5r/AZDrEH65t2fu5AU5oNIhxHPff/bo
 DZK5GC+82N68uMRmgyM+w==
UI-OutboundReport: notjunk:1;M01:P0:D7bNsYPMgik=;WdCS9PXH3++hTDtZzJ9znmLKabn
 TDNbjMQ+fJXFg0segxGh4kAMTzmIKCdZ0gJW345XO843QbbM2/ERa9rDEJJU/eII0/HWrWq0f
 gGXDtwjcO0y3WWpTFe0gNh0z5Nx4y66SQNJuhkEK4zIrKa7mp0ry9C3tvRfkZnJdrZzFShB+O
 svLAchTLZW8tgJdgLfv3oGdg9DdAoxhfy1xNULn5+x6flLlPplFot5EK1z8askVIu8kwIdU44
 3Af2TRB04WF27qAoPchlBnCsJvUfsYhJ8u+XYTn/yLk/90K/Kq7sxI+A7ZcaGnxJ5EAmbHqC0
 y+58Jw2Y+fIjaWxfNV6Gv/eW7+JT4+3OhkEBeV3S8ntrNUL3sXNPboYhUp/WJPavnXMIRx8Ma
 LJmY5w0jIf+ISqdm1ii1gcvt/oMYUwrdivq/LSNoXLjV444KkxOxnF9Vq+8Y9542e7U/Rpel+
 RbJ73rrRmkDMrbjrYtUSUEdBKppc0SM/14eqweLm/ctbrOnv27kuBm35aDVK6Ajzk6XiftD+O
 yzspEzDd8YE0/Am9vayU2tL8R6Wp7D7e/PKu79qYsH3fKprOVfjLQDK8ph0jFDYGSIdE1vMq5
 oSr+48bRnNJV9W0sKU+MJ/knqCa4psDHI4gU2T595mcZAhtlXnEzwi+/pVo2ctFmINYPJts+2
 pOxHbd+Nj4TFlWhZ3+XpN/Bt8puXgUnusa/RZzO20rMio2SrUQWxMs+aephAemD7HsKIIzh4e
 QdZgFC1uwb9qNegMtZ0lrd5QcZaCvwHBRRQaSsEcqb8f0HYkh7G+WCC8kYZlAGpaVpLWT2bRW
 IRE0tBvitZQAWIAZVUIz8wLU883GQqocWxcjiX12r/JZg=
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

On 6/8/24 05:53, Heinrich Schuchardt wrote:
>
>
> Am 7. Juni 2024 20:52:20 MESZ schrieb Sughosh Ganu <sughosh.ganu@linaro.=
org>:
>> Add a Kconfig symbol to enable getting updates on any memory map
>> changes that might be done by some other module. This notification
>> mechanism can then be used to have a synchronous view of allocated and
>> free memory.
>>
>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>> ---
>> lib/Kconfig | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 189e6eb31a..9ea02ae006 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -74,6 +74,15 @@ config HAVE_PRIVATE_LIBGCC
>> config LIB_UUID
>> 	bool
>>
>> +config MEM_MAP_UPDATE_NOTIFY
>> +	bool "Get notified of any changes to the memory map"

Looking at later patches it seems you are sending memory map events from
different memory maps: LMB and EFI.

%s/to the memory map/to a memory map/

>
> To the "LMB memory map"?
>
>> +	default y if EVENT && LMB && EFI_LOADER
>
> I am missing 'depends on EVENT && LMB' here. This should allow to simpli=
fy the 'default' statement. But why not use select?

Sending messaging makes only sense if two memory management systems are
present. How about:

depends on EVENT && LMB && EFI_LOADER
default y

>
> Best regards
>
> Heinrich
>
>
>
>> +	help
>> +	  Enable this option to get notification on any changes to the
>> +	  memory that is allocated or freed. This will allow different
>> +	  modules that allocate memory to have a synchronous view of availabl=
e
>> +	  and allocated memory.

Mentioning LMB and EFI here would be helpful:

help
   U-Boot manages memory allocation in multiple modules: LMB and EFI.
   To keep them synchronized memory change messages are used.
   Enable this symbol to ensure synchronization.

Best regards

Heinrich

>> +
>> config RANDOM_UUID
>> 	bool "GPT Random UUID generation"
>> 	select LIB_UUID

