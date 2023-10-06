Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC45E94107
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 19:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7E086672;
	Fri,  6 Oct 2023 21:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HYvvfRAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C73E86CFE; Fri,  6 Oct 2023 21:51:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D1D86504
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 21:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696621858; x=1697226658; i=xypron.glpk@gmx.de;
 bh=T/FxwjNo3XS61R+UPLQBI2ZN93fE1SCIfpa5BbHaeUI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HYvvfRAKifr678MlfPYjYGlqg9VrltnjjOxJBxNRPU4lCiiL5JdJtKkLQl2pyj7A5W6ufb6P/wl
 EoYv/sfKlLxMGTPG+oUOOwYc6EO//L6vtwNnpUfsIoBTGt9ctanketrEC4Z+iV4ctmTKxXlkbLhQs
 ZyiGZuNxMJijxPI9yKvzttlpkEWLy1Sg4QSFBfV/i+j/pWAhebPKOb+Eg+cdWcoq0pgrXwUmTJkwt
 o/ySTlTU4901YyWBh8d5nxrdca9humFMCR7X1gcq2yS8r5jDSHluuJq+w3IiS8LI1Oe6TAOgEGr1U
 Bm6md5qoxGTuajzuNs+0El0y072+8FsXVCDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1qs9hl434e-003LSs; Fri, 06
 Oct 2023 21:50:58 +0200
Message-ID: <084eb86a-080b-4b0b-ad35-98497a290071@gmx.de>
Date: Fri, 6 Oct 2023 21:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sphinx: Bump urllib3 version
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@google.com>
References: <20231005162738.3327197-1-trini@konsulko.com>
 <CAPnjgZ2w-u68LQSoy_0140PrkGDgrEGi+Wvypcunn0p_shfb6w@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ2w-u68LQSoy_0140PrkGDgrEGi+Wvypcunn0p_shfb6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gPXebYR4zqp1J/APnNg114o0zxAB7vxz+gtjCHXJkdqLuN885wu
 mkGCAHFIngfvzUm79/pcEnpH/isGhD1uqs6C2MTEWsLxc1EiOG1IE+5VVoWW66xDh1294dc
 jCROLZCKtJPdUt6oPqIGhxhmyIOHHa4EHCS5RiuMoMDFIURwEz0RHv/r6gcuBa+YhNxLYFr
 Xs+GK2rMWI0riiyAd2J5w==
UI-OutboundReport: notjunk:1;M01:P0:DsXtX8nAHaI=;1C3gQR4906Qvr876G7JXVcfDW0T
 r9JazyREMpi/x5zK9YE8GaxgfhV8A41H3vxqD88YThVpbfdbqFnKLo2Z8DMjH1qcS75s8OM6+
 ZpdaBRiEJROsQjXZWAJJ/G5+oBhV2Iyf25KawgfZrNkk3Y6BPDS6JMFJsYpHgV2Z1fH9me34z
 RQGtBduaauuy7yVWvRt3oLep0QRYiyc+1vi5JenuWnYs9dxhLSAV2S3jDA25JOZucGvTzDGD2
 u0RUOa5v8RI0V4N5l+UiELesnlhfIyGek/3MCKw9TtMCJcJVSba50UGRAfwbrAfT0UMnieuT6
 EQTdD6fHBJxK41zVsvDtCnKufgGPBZ7TjdxnTUqco8GDOE8G9SZxf56Ip6AXcsMA0wSdz5rKS
 U1MkKUPPgXuMEgtwjAk3WnsOEylJljXirQCuHZKSgATkFjjjXtUdBXDH788qA1ISfvykhWNL5
 8pFm5tvookzuxn4PmhJ3ROZE7C62GMtPXHi2tVuqmjb7vAKER8ZMVA/KAvz62u1PPr6nRvYHf
 5ZmifFnaJJwyh1TzEgcvgD5uQbZbO8ULN9yh8Mrj83TwoGLTsXTGEzEJRx4rFNYhAEO7qjJl8
 Jj9FP1+2McdQ/CusAusZj9CbgtvULW+zREaE+Ef9oUPeQpCBSsU0L0rZ5h4D0qjTS3qaDLD6J
 ICfGJFtCgvWhcWsq6//ltJOW6EEaHTICPY/NTTLxM3bWWKjAUAO7cIXBBUKOrw+FhgTCr8kgc
 pZhR05YkqXyQDvSbFvDvT0lZKeAFrFk2xaZO4J9NI4wbdamJIcn9zORPc9Hk1JHWBOdTbNXL4
 0lnRJKswrtodu3mcwGQVbHHgDZu4HOjq6AIwsgI8618utH56t7erWL4Vo3YJPjwaf9NSU7r68
 pJqKtwGz6mQO3iQRQEBY+KwguBIE6XYuRoUeTfWXbTzoaDPqI1CRzGt0IYudWYbbQ4c3k5Ul4
 77y7+lw6P/Z5ygegBupVas72oqc=
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

On 10/6/23 03:41, Simon Glass wrote:
> On Thu, 5 Oct 2023 at 10:27, Tom Rini <trini@konsulko.com> wrote:
>>
>> While not a direct issue for us, urllib3 before 1.26.17 is vulnerable t=
o
>> CVE-2023-43804 to bump our version up.

The same bug is also fixed in 2.0.6. Why should we stick with the old
series? I could not see any issues building the documentation locally
and on Github with 2.0.6.

Best regards

Heinrich

>>
>> Reported-by: GitHub dependabot
>> Signed-off-by: Tom Rini <trini@konsulko.com>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>   doc/sphinx/requirements.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

