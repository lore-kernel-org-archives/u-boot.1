Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D85C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBC587115;
	Sat,  4 Nov 2023 08:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QBK8ohe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23D087113; Sat,  4 Nov 2023 08:48:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E45D387007
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699084107; x=1699688907; i=xypron.glpk@gmx.de;
 bh=B4smjJfepZYgQTDKFwxo5XCYmGBksONVJsFeFVI1jm8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=QBK8ohe4JZKeZNU7nbltmzaGS98oiyU/mlyK6PZf6Gdr+8aivtoOKWnW2l/UL27Z
 V3sFRwI8FMciiL3R4gSPHetvtGt3N44Mm4OSRgeESViMGtEBsd3gZ348uPenvZiY+
 SfkOd3yhWlUtfwlmmkPtkWg/2GlkgBAhWk6fZxHcB/JTB8PQqQhcopaqKs0QWCLIq
 jjc9QXyj7/BUkJnR4ynml29kcXlDyQeDZms+6BCFcA3zL0/nRP/+/IJWOo9M0ag/z
 LIPh20vxxvZqtsvyHDFKIfIBgv4XZPVo6Xu4418kYGE5wgX2dioNQD4pNKo1zlFFb
 YPMkY+oMTEU6Rfygbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.29.1] ([159.148.28.2]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1rgS6f1zNe-00jp2T; Sat, 04
 Nov 2023 08:48:27 +0100
Message-ID: <bd79e1f1-3192-49ab-9429-a0ade36aa248@gmx.de>
Date: Sat, 4 Nov 2023 09:48:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net: bootp: BOOTP/DHCPv4 retransmission
 improvements
To: Sean Edmond <seanedmond@linux.microsoft.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-3-seanedmond@linux.microsoft.com>
 <5d6aba63-d050-4365-8a4d-9cd2b528e804@gmx.de>
 <7dd18ad7-6d6c-47ea-9dc0-3b59ddf25460@linux.microsoft.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <7dd18ad7-6d6c-47ea-9dc0-3b59ddf25460@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8qcL104knzQpr8lMiWobRPjTDO/zGexGJXOzqHBHWlN53IZRwm1
 XWta98yi98w5QJnVL9CktnZ644lHxb0MC89yMGZT1KqHEiylIKKStRp1NKzJkQr+VDT9hwN
 2h9BIHRDcLSVfvUrvQETJ/4xdyWTUyOCRE4Ipvgqh7SzhUKQKsWqmitEVIBFfgfN5rDNELM
 yB7eWuosl47byYAT01hRw==
UI-OutboundReport: notjunk:1;M01:P0:bg9u6dWA/Cc=;+oaYvmMO2u3lPsVh+5vjbIpjhFM
 4980BWqaASl6ivT9D3iCN6wjSqKF64sHtGqd14uJ6ijoMUSDXPliVskW/iUZuDLmFIRVCgV5A
 UaN5aU0bQbZWv+NIHTo7VKdIMxyu06a+lA43kV1vDfcHCsxlzx7rXznpegkIZw1LlWoybVZuK
 CkS3+Sr6ufGGz3U3DstLVE+naDX99TEPcazzUo2ww0pFfJVTimuNZhaXDyGkC04L2dPp+5ZI/
 kazyeK1sX9klInJC0JxBrz64dSfX6WuJGNgu5FUwVUbs1qi0qwB8CIShkJmcvRfZxOl42TmQB
 +RsAehJdLyl84hAxGE214STyQyftgk641VZaLFsVafd1n/No7GCpx6pX5NY49lfkY5Vc4d4NM
 pDXlN4UPLvUcrVVBP7LeLeqUKMkWdAw2Azgm6HvaVWOEAYbsuusxNV2e9j6yyS1X2Ooim/lcP
 +fwo/at200kP1LI0bUQSH3tQ2slahYjsrY0sZqvrfiXeLUYFGbzqLEIYvtooqm01tZDb8SmX/
 ijnNK4jiW6LtiAevQjFCPZBh5H2JB4RGhDvoYkqwd2eDxaB3GOe7tEaalZ5OMRG7YJ3BJ8MSa
 tzSQ4lXApVwvMfFnrGmEeZaReKqa6xwn/ErczC6biLXoLz6xsVeTcqEdh+rJIrHB1q8xl1T9M
 cp82UGQn/nxAEWFAulOnhPf49kL1A0weKY4fJDWUCUU8N0qxlQwyPmFAkaOGqYOiJ1/q6/IVm
 irRg8EVYWjDQrOK7M5U/QE6KFrRSjWOHn6jo87OdXbKVoYJ/06q1fwD4AhXjMR5rcQhzDsXoE
 HtCnU/G1lsLDe8k+GlLeeI7boJB4M0hBacaQ3DL++CuKiGOdOmft+sT9f9uB0N7XgzaSH6DtH
 AR5gGdmjSwF1iwDLu8YAJ2HLtc1i8Nz/rPgl/66zHFp1UVi0lgRLqol59NPNz+UNiK5pWQX+l
 xT7vrw==
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

On 11/4/23 03:04, Sean Edmond wrote:
>
> On 2023-10-23 11:06 p.m., Heinrich Schuchardt wrote:
>> On 10/24/23 02:21, seanedmond@linux.microsoft.com wrote:
>>> From: Sean Edmond <seanedmond@microsoft.com>
>>>
>>> This patch introduces 3 improvements to align with RFC 951:
>>> - retransmission backoff interval maximum is configurable
>>> - initial retranmission backoff interval is configurable
>>> - transaction ID is kept the same for each BOOTP/DHCPv4 request
>>>
>>> In applications where thousands of nodes are serviced by a single DHCP
>>> server, maximizing the retransmission backoff interval at 2 seconds (t=
he
>>> current u-boot default) exerts high pressure on the DHCP server and
>>> network layer.
>>>
>>> RFC 951 =E2=80=9C7.2. Client Retransmission Strategy=E2=80=9D states t=
hat the
>>> retransmission backoff interval should maximize at 60 seconds. This
>>
>> %s/maximize at/be limited to/
>>
>>> patch allows the interval to be configurable using the environment
>>> variable "bootpretransmitperiodmax"
>>
>> If there is an RFC defining the value, why do we need an environment
>> variable?
>>
>>>
>>> The initial retranmission backoff period defaults to 250ms, which is
>>> also too small for these scenarios with many clients.=C2=A0 This patch=
 makes
>>> the initial retransmission interval to be configurable using the
>>> environment variable "bootpretransmitperiodinit".
>>>
>>> Also, on a retransmission it is not expected for the transaction ID to
>>> change (only the 'secs' field should be updated). Let's save the
>>> transaction ID and use the same transaction ID for each BOOTP/DHCPv4
>>> exchange.
>>>
>>> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
>>> ---
>>> =C2=A0 net/bootp.c | 56 ++++++++++++++++++++++++++++++++++++++--------=
-------
>>> =C2=A0 1 file changed, 40 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/net/bootp.c b/net/bootp.c
>>> index 6800290963..bab17a9ceb 100644
>>> --- a/net/bootp.c
>>> +++ b/net/bootp.c
>>> @@ -42,6 +42,17 @@
>>> =C2=A0=C2=A0 */
>>> =C2=A0 #define TIMEOUT_MS=C2=A0=C2=A0=C2=A0 ((3 + (CONFIG_NET_RETRY_CO=
UNT * 5)) * 1000)
>>>
>>> +/*
>>> + * According to rfc951 : 7.2. Client Retransmission Strategy
>>> + * "After the 'average' backoff reaches about 60 seconds, it should b=
e
>>> + * increased no further, but still randomized."
>>> + *
>>> + * U-Boot has saturated this backoff at 2 seconds for a long time.
>>> + * To modify, set the environment variable "bootpretransmitperiodmax"
>>> + */
>>> +#define RETRANSMIT_PERIOD_MAX_MS=C2=A0=C2=A0=C2=A0 2000
>>
>> This does not match RFC 951. Please, why shouldn't we use the standard
>> value by default?
>>
>>> +#define RETRANSMIT_PERIOD_INIT_MS=C2=A0=C2=A0=C2=A0 250
>>
>> This constant should be described too.
>>
>>> +
>>> =C2=A0 #ifndef CFG_DHCP_MIN_EXT_LEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* minimal length of extension
>>> list */
>>> =C2=A0 #define CFG_DHCP_MIN_EXT_LEN 64
>>> =C2=A0 #endif
>>> @@ -53,6 +64,7 @@
>>> =C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_ids[CFG_BOO=
TP_ID_CACHE_SIZE];
>>> =C2=A0 unsigned int=C2=A0=C2=A0=C2=A0 bootp_num_ids;
>>> =C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_try;
>>> +u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_id;
>>> =C2=A0 ulong=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_start;
>>> =C2=A0 ulong=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_timeout;
>>> =C2=A0 char net_nis_domain[32] =3D {0,}; /* Our NIS domain */
>>> @@ -60,6 +72,7 @@ char net_hostname[32] =3D {0,}; /* Our hostname */
>>> =C2=A0 char net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN] =3D {0,}; /*=
 Our
>>> bootpath */
>>>
>>> =C2=A0 static ulong time_taken_max;
>>> +static u32=C2=A0=C2=A0 retransmit_period_max_ms;
>>>
>>> =C2=A0 #if defined(CONFIG_CMD_DHCP)
>>> =C2=A0 static dhcp_state_t dhcp_state =3D INIT;
>>> @@ -414,8 +427,8 @@ static void bootp_timeout_handler(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_timeout *=
=3D 2;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bootp_timeout > 2000)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo=
otp_timeout =3D 2000;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bootp_timeout > retran=
smit_period_max_ms)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo=
otp_timeout =3D retransmit_period_max_ms;
>>
>> RFC 951 requires that the backoff time is randomized.
>>
> I added randomization in v3.=C2=A0 Note, in that update I haven't put an=
y
> guards around the use of rand()/srand() (as is the case in net_rand.h).
> Perhaps it's safe to assume it will always be present for inclusion of n=
et?

If you need rand(), you have to ensure that CONFIG_LIB_RAND=3Dy, e.g. let
CONFIG_CMD_BOOTP select CONFIG_LIB_RAND.

Best regards

Heinrich

>
>> Best regards
>>
>> Heinrich
>>
>>> net_set_timeout_handler(bootp_timeout, bootp_timeout_handler);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_request()=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -711,10 +724,14 @@ static int bootp_extended(u8 *e)
>>>
>>> =C2=A0 void bootp_reset(void)
>>> =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 char *ep;=C2=A0 /* Environment pointer */
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_num_ids =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_try =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_start =3D get_timer(0);
>>> -=C2=A0=C2=A0=C2=A0 bootp_timeout =3D 250;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bootp_timeout =3D env_get_ulong("bootpretransmitpe=
riodinit", 10,
>>> RETRANSMIT_PERIOD_INIT_MS);
>>> +
>>> =C2=A0 }
>>>
>>> =C2=A0 void bootp_request(void)
>>> @@ -726,7 +743,6 @@ void bootp_request(void)
>>> =C2=A0 #ifdef CONFIG_BOOTP_RANDOM_DELAY
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ulong rand_ms;
>>> =C2=A0 #endif
>>> -=C2=A0=C2=A0=C2=A0 u32 bootp_id;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct in_addr zero_ip;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct in_addr bcast_ip;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *ep;=C2=A0 /* Environment pointer =
*/
>>> @@ -742,6 +758,9 @@ void bootp_request(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_taken_max =
=3D TIMEOUT_MS;
>>>
>>> +=C2=A0=C2=A0=C2=A0 retransmit_period_max_ms =3D
>>> env_get_ulong("bootpretransmitperiodmax", 10,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 RETRANSMIT_PERIOD_MAX_MS);
>>> +
>>> =C2=A0 #ifdef CONFIG_BOOTP_RANDOM_DELAY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* Random BOOTP delay */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bootp_try =3D=3D 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 srand_mac();
>>> @@ -801,18 +820,23 @@ void bootp_request(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extlen =3D bootp_extended((u8 *)bp->bp_=
vend);
>>> =C2=A0 #endif
>>>
>>> -=C2=A0=C2=A0=C2=A0 /*
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 Bootp ID is the lower 4 =
bytes of our ethernet address
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 plus the current time in=
 ms.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 bootp_id =3D ((u32)net_ethaddr[2] << 24)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ((u32)net_ethaddr[3] << =
16)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ((u32)net_ethaddr[4] << =
8)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (u32)net_ethaddr[5];
>>> -=C2=A0=C2=A0=C2=A0 bootp_id +=3D get_timer(0);
>>> -=C2=A0=C2=A0=C2=A0 bootp_id =3D htonl(bootp_id);
>>> -=C2=A0=C2=A0=C2=A0 bootp_add_id(bootp_id);
>>> -=C2=A0=C2=A0=C2=A0 net_copy_u32(&bp->bp_id, &bootp_id);
>>> +=C2=A0=C2=A0=C2=A0 /* Only generate a new transaction ID for each new=
 BOOTP request */
>>> +=C2=A0=C2=A0=C2=A0 if (bootp_try =3D=3D 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 =
Bootp ID is the lower 4 bytes of our ethernet address
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 =
plus the current time in ms.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_id =3D ((u32)net_eth=
addr[2] << 24)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
((u32)net_ethaddr[3] << 16)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
((u32)net_ethaddr[4] << 8)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
(u32)net_ethaddr[5];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_id +=3D get_timer(0)=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_id =3D htonl(bootp_i=
d);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootp_add_id(bootp_id);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net_copy_u32(&bp->bp_id, &=
bootp_id);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net_copy_u32(&bp->bp_id, &=
bootp_id);
>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Calculate proper packet lengths=
 taking into account the

