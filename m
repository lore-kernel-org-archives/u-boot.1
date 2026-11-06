Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E98606A328
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wh7Ey61i;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=MRxDLJnx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3023640956;
	Fri,  6 Nov 2026 09:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n9a7IJqyi4UG; Fri,  6 Nov 2026 09:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2986D40952
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958706;
	b=lF7kCswym0qLsW85sQdB6ZcE+0VKrgq/d0R2g33qzVS8nPT2wd86X2XRDZd7vsBtxZiC
	 9RfhLLTzkoI6OiAfmt4xIceyUJ+72PG0LKyXG9zdCI5onIjQqhAYPZoYsTWZrF5kzaLTH
	 HQoB0K4zwScrYZLskcQLWAXypw4YNHOyeJajuBHsmiQsyZAXMTBI/E4Xrjlmm92wipzDJ
	 zsC3WKBtmbAgSs0D8K+mx7J3TedWYTwHl4yaAFZ1BpEhLTxwuHJLYeehnJmHk0tZunBas
	 PQOGQgBRfSKlBdvzX+RCKRTmKf55USA/odv1Cj0FfYB4uh/z7dOhGbJftaxo4RAPrNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5jdVhJ9jnCgpp96/4YWmKqKyQC+ctPYGK4ahkt+S9L4=;
	b=jpJKrkHY/GJMqQZmltULdaHlnnDj2Htyiaedq60IFugJzXs8dT+OLXvRRLzWZJQMgKBi
	 ccbTcqd5OGYV1AxRnLHLpdlpZAvVxuEUUe6GgvXIhfty6pNfyqETFe2FU18nDsF97Y1iB
	 WlHN8YSlTkmo+vZUqhYwjHyDbVSoXD9mm6zFSthvG1vPDj48hhp+23DlrjXqJHMovLRyR
	 df8gj7EypU6QhKrVPRCS+Vr7Hr8hLgGLu0OvD08+Y2N+cSNdu6vQE+pzYXUevETTFilI9
	 1KAMjcjQjJO6oKkKczBrXBBEVNTlQK5eSsGSJ9bw+wWtOpPH++SfYCf+gtH4GzHAz8Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958706;
	bh=5jdVhJ9jnCgpp96/4YWmKqKyQC+ctPYGK4ahkt+S9L4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wh7Ey61iUhk0Xhbv97JC9R3ejJqjLk6YZd5z5QOmwCW11s9qLzcimlEqGOM0aDL0U
	 FNMpUi24nTd4iUEY/TsU5zHOV7ZmxCFMs+/VlanH358m5ElIqbGTXUOI5tWcgEf1AC
	 NHKkgfiz+Hwi5KRmu8zVKpmyAZqkoO4u/ya9Dpb8915azJpYLNWROWM1AI21qTyTtg
	 hlr1pZqvY3p7/GYjUDrFDNkSN41dxRsG5KZm8c85IlmBdkyTRG+f8l8usxNL8GFqsO
	 cCxQSSn97EVCvRXfhwxXyTU5MOGck2JWcUAKmGjvDDdIA1wxDaZCxn0ndCiR8tt0Nx
	 jEnHBqKNCgTfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2986D40952;
	Fri,  6 Nov 2026 09:51:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 010C931F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2A1D811F9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gHI5YLdoBMxB for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:51:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A91D81137
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=MRxDLJnx
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A91D81137
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793958699;
 bh=5jdVhJ9jnCgpp96/4YWmKqKyQC+ctPYGK4ahkt+S9L4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MRxDLJnx/Eh45fG7ba7vbKT6SkznxxcRXSScE4Xs74Z3mTDCRR03FXtfoSWz9y0U2
 KFmSPKXes9n/AKWhgF7XSM+yKE+LkLbTKLBuolbR0btZtbVVXsqMSw8DTfwguvhZKz
 CCRdbMuMqNhLAo26Lo1sd8v+vHazj60qvzZan1akxUs1SZVvEjyX4ZOlz+M19Ro6e1
 bLVFA84XWBZo5NwnTYZHInHplHvFcdkJUCI4tqYWmCrFzbWc/uTP51pdm+OwZedmYH
 AMCgwfokNo1Vq9p+LWiC+KiF56fqYZJH6OrwdxckbvXaBo4u3oUOMxlsaEvry5jhYz
 NwU24Kj4Ll2tw==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 6DEFE5F8C9;
 Fri, 06 Nov 2026 10:51:39 +0100 (CET)
Message-ID: <65cf8b81-31b0-4a9a-830f-741fa6830c6b@emlix.com>
Date: Fri, 6 Nov 2026 10:51:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] tpm: deactivate unsupported banks in tpm2_startup()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
References: <20261106072729.1714418-1-tkirchner@emlix.com>
 <20261106072729.1714418-6-tkirchner@emlix.com>
 <CAC_iWjLSSGbQ=s_r7YFD=ZXaPP9X9Wj-cuJrhxThma-DkeLGJA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Tycho Kirchner <tkirchner@emlix.com>
In-Reply-To: <CAC_iWjLSSGbQ=s_r7YFD=ZXaPP9X9Wj-cuJrhxThma-DkeLGJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at mx1.emlix.com
X-Virus-Status: Clean
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

Hi Ilias,

Am 06.11.26 um 09:53 schrieb Ilias Apalodimas:

> I don't mind keeping it, but if the previous boot stage supports more
> algorithms than U-Boot, this is actively blocked in the TCG code,
> IIRC.

Right, with an event log tcg2_log_parse() rejects algorithms unknown
to U-Boot, so the fallback is not reached there. It is meant for users
which do not go through tcg2_log_prepare_buffer() at all, e.g. a custom
measurement implementation on top of lib/tpm-v2.c (my case) or, more
importantly "tpm2 pcr_extend", if an earlier stage already started the 
TPM.

Thanks for the review and testing!

Tycho


> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> TPM2_SU_STATE, used by tpm_resume(), is left alone.
>>
>> If the deactivation fails, e.g. because the TPM refuses the allocation
>> or no supported bank would remain active, return an error. With
>> CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to manage the banks,
>> so fail early instead of at the first PCR extend.
>>
>> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
>> ---
>>  lib/tpm-v2.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
>> index 18ec9eb960d..6370b97a7d4 100644
>> --- a/lib/tpm-v2.c
>> +++ b/lib/tpm-v2.c
>> @@ -201,6 +201,19 @@ u32 tpm2_startup(struct udevice *dev, bool bon, enum tpm2_startup_types mode)
>>         if ((ret && ret != TPM2_RC_INITIALIZE) || !bon)
>>                 return ret;
>>
>> +       /*
>> +        * Only the boot stage which actually starts the TPM deactivates active
>> +        * banks with unsupported algorithms. On success, this resets the board.
>> +        */
>> +       if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE) && !ret &&
>> +           mode == TPM2_SU_CLEAR) {
>> +               ret = tpm2_activate_banks(dev, 0);
>> +               if (ret) {
>> +                       log_err("TPM: failed to deactivate unsupported banks\n");
>> +                       return ret;
>> +               }
>> +       }
>> +
>>         return tpm2_update_active_banks(dev);
>>  }
>>
>> --
>> 2.47.3
>>

-- 
M.Sc. Tycho Kirchner

emlix GmbH
Headquarters: Berliner Str. 12, 37073 Göttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of Göttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
Office München: Am Knie 16, 81241 München, Germany
http://www.emlix.com

emlix - your embedded Linux partner

