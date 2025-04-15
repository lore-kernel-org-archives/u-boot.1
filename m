Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42656C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 14:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56BFB82AAF;
	Tue, 15 Apr 2025 16:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hwQdG5tz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 484BC82ABB; Tue, 15 Apr 2025 16:26:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEF28294C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 16:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744727201; x=1745332001; i=xypron.glpk@gmx.de;
 bh=4RdvAH3v3BHE2Y3Wq9nJJKyFZjCYoBm6loPHKOWgWmE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hwQdG5tzXlnl823T5wNW2ulSLBcgDbtJJVNQGoAaLxRkzxiAIUAFlcKgYP2NktOv
 1QsXjpNUkLd1E5u/SXQIkm9zFaOo3ZexVlAgXQGTsSrGPpbhjZEBkLPiIl9QNH1Qq
 fgCnR/4jeJWyOEg+qBDwgmZKffCeEJoqYanzC7VOOQUzALn3f9CepcpbuqdH6quJK
 T+awSUDYX7X84xUX71mtsB1i5NlIdAJh76UuomPvJ0ML24mTCqIBQjkK9dSR9H3Mm
 umtrU4s7pvLURR0UE8LW9FgBMudHiQHrCPRKV3jh/92FKNoLp6O13CcHyB3pJQBP+
 mXVZJqG7C1VJ+Ne/2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1tF6g13NpU-00aLlc; Tue, 15
 Apr 2025 16:26:41 +0200
Message-ID: <c517a968-0ea4-4374-b477-c9f06f104e19@gmx.de>
Date: Tue, 15 Apr 2025 16:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] test: fix print_guid()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, U-Boot mailing list <u-boot@lists.denx.de>
References: <20250415125345.427420-1-jerome.forissier@linaro.org>
 <20250415125345.427420-2-jerome.forissier@linaro.org>
 <b4d515cd-57de-4094-96b2-54749129a284@gmx.de>
 <e84b805c-49b9-41dd-84d8-1b40dad0b2f5@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <e84b805c-49b9-41dd-84d8-1b40dad0b2f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ml7q/OdqdV7XOQ/piGLuX0mAYxisOSFMlKJ99nl4W4e3E/B0jet
 D4xjzI+Q60JrjBxEhqiJjr4qmQQeT+fPqCHBvc7WddMt/RIOz4y5DkjfE+Ni+7a0P30mFew
 FwPtrsV8uF9klyKN8kH3GHkJKT8UzFOY69jUXHvncBYasX3qlB/ENOYJCbKROYb14Bu6iVU
 EROseUJzdTvIypac7MIPA==
UI-OutboundReport: notjunk:1;M01:P0:hhjtIH+lrZ0=;tbWqMQjqQR01/mjkgCHzTNgXzTy
 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
 Q==
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

On 15.04.25 15:51, Jerome Forissier wrote:
> Hi Heinrich,
>=20
> On 4/15/25 15:25, Heinrich Schuchardt wrote:
>> On 15.04.25 14:53, Jerome Forissier wrote:
>>> The %pUs format specifier prints the system partition GUID as "System
>>> Partition" if PARTITION_TYPE_GUID is disabled but either CMD_EFIDEBUG
>>> or EFI are enabled. See list_guid[] in lib/uuid.c. Fix the print_guid(=
)
>>> unit test accordingly.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>
>>>  =C2=A0 test/common/print.c | 2 ++
>>>  =C2=A0 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/test/common/print.c b/test/common/print.c
>>> index e3711b10809..574c84b2eee 100644
>>> --- a/test/common/print.c
>>> +++ b/test/common/print.c
>>> @@ -47,6 +47,8 @@ static int print_guid(struct unit_test_state *uts)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(str, "%pUs", guid_esp);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_PARTITION_TYPE_G=
UID)) { /* brace needed */
>>
>> I would not know why a brace should be needed for a define using
>> {( some expressions }).
>>
>> The problem should be resolved since fa847bb409d6 ("test: Wrap assert m=
acros in ({ ... }) and fix missing semicolons").
>=20
> Most probably, yes. I'll reformat in v2.
>=20
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq_st=
r("system", str);
>>> +=C2=A0=C2=A0=C2=A0 } else if (IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_E=
NABLED(CONFIG_EFI)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq_str("System Pa=
rtition", str);
>>
>> Printing two different strings depending on configuration settings is n=
ot very helpful for users.
>=20
> Agreed.
>=20
>> Can we print "ESP" in all cases, please?
>=20
> Fine with me in principle but...
> - Don't we risk breaking things which would depend on the partition name=
?
> - I find "ESP" a bit cryptic. I would suggest "EFI System Partition" but=
 it

Fine with me.

> is quite long and I see that CONFIG_PARTITION_TYPE_GUID defines only sho=
rt
> names ("system", "mbr", "msft"...) so there must be a reason.

The place where the string is printed is part_print_efi().
It is on a separate line:

Partition Map for host device 0  --   Partition Type: EFI

Part    Start LBA       End LBA         Name
         Attributes
         Type GUID
         Partition GUID
   1     0x00000800      0x0003f7ff      "EFI system partition"
         attrs:  0x0000000000000000
         type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
                 (system)
         guid:   3795c782-a55d-490b-b0f6-c1da67bef048

The gpt command uses GUIDs and not strings.

Thus any string value should be fine.

Best regards

Heinrich

>=20
> Regards,

