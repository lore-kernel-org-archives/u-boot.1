Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03D606D807
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HO2fUdEw;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i4OxWaiC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8609F8138E;
	Fri,  6 Nov 2026 16:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZ-zS_OPGFvf; Fri,  6 Nov 2026 16:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C662D81241
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793983547;
	b=TAbOzlnADM2sBro0WHkpGoqEHy4UrzNaNgQUupoLcW1e+y4mCE3dLk8ykSSbAsP3DQvz
	 X1bDPcg+l7cVZWsH1uVJ85uioxJT15UduW0t00ob2uA2U3JN6ultUhoC7/2+BhrUVWuaB
	 6w7k56hIc+2HfRHlcHzFhw7Bar/wADXH4tRzfImAJIpVxYUEg7b0uicg46c/l0ZnWs/F9
	 SWmZONr+fAm6AeIYPR76FhMU9DG8jQzso4VIVgP1jn4i8cPrhSKSSLSSR6K8WfSqAyIaB
	 rC2ujGsITv5l/8sVMqYjY4AZ1TSuMZvVq7RA8Bs+OylpT/XtzpStPlI1jSG/463+VaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793983547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h1tDUy2b0yxerIshXh/vX9x6oYuy01J6BgQHVw8z330=;
	b=qZrKm8Cu2FAwwRotXXc3n7IGNZWyN0yH1sX+M31bxciJOhcnVpMisyAsgeF16JHWZYgJ
	 Y3JXPH6x3SeuJOqYPSVHOLdnJ4MI1Pw/v9TrnSL/m0by0TNDbGcDQ8AK9sRdj6pk1VAPi
	 2LI2on+o30z90nS1PWPcStLrPljVcNAIE6qLTL4OzyJv/9pmpYrx2SPBOSkMfFgxsNM6l
	 WrteCsFSbmC7p332TonXQlpjDc4gulzWED13BLgW4z/Rq8XPpe6kjTwaMcgm0koP817+z
	 H97paMBtzaJx36OLVtzHxxkNEeSk0QWWT4KBWz0e9LOjtJzKxUnfJCjcFIdTEl9vaOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i4OxWaiC;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793983546;
	bh=h1tDUy2b0yxerIshXh/vX9x6oYuy01J6BgQHVw8z330=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HO2fUdEwziTHAJgqPDKsUadShXiLpQgSUFdsS9f2/lOG08TDYZpXcCTlhMSoETMT8
	 UuGU2/SYp/xY8VKWff+YGxD7AYM9FkQr1Uzp3yGV3k/kwNdnuPng1H05g3g7Q24N03
	 dfEK7pqXRTzqQHPovOSfyyiEoLWsEKTkPS+VAm/1QXIFX8gRlKYlAXvxLwevCQvIYd
	 1bhtW52yuw7pp2/5VGp2vzH8vPEAbbPIeH6YBFy1tZ4639FI0gr58SHS9ieP5cARKc
	 NdVN6iVFZBeVMaxntATHt9VoMBuUitydV7RkL7dEG+ShrHyOSZvmo35ywIRiPei+eO
	 gionByNDEL7Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C662D81241;
	Fri,  6 Nov 2026 16:45:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE57F4B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D03B481771
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:45:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDI7dilLra4R for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:45:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5D1981241
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=i4OxWaiC
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5D1981241
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:45:43 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso585460f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793983541; x=1794588341;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h1tDUy2b0yxerIshXh/vX9x6oYuy01J6BgQHVw8z330=;
 b=i4OxWaiCRBt+eGkFpICsDp1QpMvwpBIdLGYkHtM+XpYx/irfVFQioMWOkDs24/X0jz
 oXBWsV84hU0hVxoCUWL4kANwqvB9fX4YkpQiEzWObRjhYUaaEJytNEcZvXXgUO7GH7g8
 h3+EGB8/akFlYn4HPvPIkdMnggkcL9E+tWr6XHJsk0dG2MFju5tI0NrH4prAhNdrQVwI
 2fQ9+Gy5SlIqu7/B42AbrgH5tN4d8zCBgDwIUmaXFvJ7DvGG6ZG5h4iWI1F7G93HQeLo
 2fsdMsWfwbWX6MvEJnLcXWqeO9MiE0NddKCwcfl2YEzCqJ7rYkglG2rj9n+tuOfvYiv3
 msaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793983541; x=1794588341;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h1tDUy2b0yxerIshXh/vX9x6oYuy01J6BgQHVw8z330=;
 b=pHGfD+5iIv8A0cH5DaskbIlpCfBQZna9FEq6A7dnmQF+5gD5gT3E39APDnxXF7vn8j
 2xM+1+qt+DrMnGv3waCmB3VIK8dX9U8GsU043Vk0u/AG8tjNPICSgvxQvbY92ulMIJvn
 +3lDFuEqkF/UFKNWDI61WP11kwzNVUStPmsQB+mYHu509h+5rzIAhu8LbEZrvjXxitw8
 JH0pE0cXy+xWffrut1g4XkNyMIQvmp/NoM1SJPUQ6FigI0mDUbVetZ/OPBoR1nXC1UxR
 MJ/TMatZbiFYq3fHbDcVMUZ99MutAio+hMZVlrTTGr2vThbtJx3HlYB3y650NxpbxvPZ
 XTig==
X-Gm-Message-State: APuU4Z+O/+p4rccevMNb8yWIAU9aeMirlLB9/tjaVUE0BaJomTy4zOoo
 9R7jOkcKRsOnVlL3OiEf5B+XOR6OE4t3eYpqsXGXDPatv6niqj/njEZZ6vmB70Z2Vnk=
X-Gm-Gg: AYBFou2aQN45rOz5iO3OigAPwPAc0meZaZ81KZ3L7iOaY8SgxrR0pNBYkYtI9kUJrYq
 ff0WTnqua3VOtk1pikbvxRiAEMUwymXMQ/jzhOk1lCtGBef+0MfLVE12LiJg1JwNwPRLWNpGkaC
 pkJ4/3+5Pa5Ycomo1mBDLMKbEVzHj/7NRuBGho2urK7g4o5bA70IyQOuvKgetryo08iBrR4I4TX
 u4f0cXKlqDL6WoSAF2umgOaufOgS2IUNOtqbOvzPj2rY+sPr9N+tHVRg7qb7ZJ0yGaH1vLb8YDv
 KnkSrgPV9itCVIje+Cgy5H/utrf21N0NfirYPM9EYDR47E4LBaKhqLCBIvdRefV+S4UlA+OtwAq
 pnuCQ/IKIZ7Ui10N4MFZK7nGlkZaUdUFr6TeL3EWtMgIgvBWZRirSeBVWDKLzQlQ3vOKraAZ9ZH
 dKH9DVzdJYjTQzbyFNs2Bmbf+6saKNaUcsngVucXvkwc0qQwy7HWAVk1wDVRFZ/8X4jRrmUmMuz
 EH3Cy4GiQmb6ytbb6MkyGMZAUCgV2m4hhuoFKBN88y5RykWEh7v1EFncU2FPME+ufRwH8UDvtap
 XQzToUJu6oHLAdHeIqRhP+2xAqrEw2jqw5IL+aEaZNh061XSC68xotJBwixdkw6zP8RE
X-Received: by 2002:a05:6000:24c8:b0:492:3982:a80c with SMTP id
 ffacd0b85a97d-493aa4fbc64mr1583660f8f.29.1793983540692; 
 Fri, 06 Nov 2026 08:45:40 -0800 (PST)
Received: from [192.168.1.37] (p5b29ebc8.dip0.t-ipconnect.de. [91.41.235.200])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d63accsm4828689f8f.17.2026.11.06.08.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 08:45:39 -0800 (PST)
Message-ID: <fbc41e04-88de-4ac7-8267-dba976929fff@linaro.org>
Date: Fri, 6 Nov 2026 17:45:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-2-18ce3e431320@oss.qualcomm.com>
 <20261021173537.GA3275858@bill-the-cat>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20261021173537.GA3275858@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 21/10/2026 19:35, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 09:48:21PM +0530, Balaji Selvanathan wrote:
> 
>> In snagboot mode, U-Boot is loaded directly by XBL without PSCI
>> firmware support. The functions show_psci_version() and
>> qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
>> CONFIG_ARM_SMCCC is disabled, causing build failures.
>>
>> Hence, added CONFIG_ARM_SMCCC guards to both functions.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v7:
>> - No changes
>>
>> Changes in v5:
>> - No changes
>>
>> Changes in v4:
>> - No changes
>>
>> Changes in v3:
>> - Added CONFIG_ARM_SMCCC guards
>>
>> Changes in v2:
>> - Newly introduced in v2
>> ---
>>  arch/arm/mach-snapdragon/board.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>> index 87adb100edd..daee2ed4fa0 100644
>> --- a/arch/arm/mach-snapdragon/board.c
>> +++ b/arch/arm/mach-snapdragon/board.c
>> @@ -35,6 +35,9 @@ static void show_psci_version(void)
>>  {
>>  	struct arm_smccc_res res;
>>  
>> +	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
>> +		return;
>> +
>>  	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>>  
>>  	/* Some older SoCs like MSM8916 don't always support PSCI */
>> @@ -58,6 +61,9 @@ static void qcom_psci_fixup(void *fdt)
>>  	int offset, ret;
>>  	struct arm_smccc_res res;
>>  
>> +	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
>> +		return;
>> +
>>  	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>>  
>>  	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)
>>
> 
> Do we even need this, patch 1 of the series disables SYSRESET_PSCI when
> you're doing this special snagboot mode so we shouldn't be calling
> show_psci_version at all.

Somehow this show_psci_version() function has managed to stick around
mach-snapdragon since before I took over, I'm not sure why it's here, it
can certainly be dropped.

The second hunk unfortunately seems necessary still.>

-- 
// Casey (she/her)

