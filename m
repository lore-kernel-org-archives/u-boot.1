Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5E606A97A
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LoA0+0b3;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=Yd2PAtnY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFAAC80DE2;
	Tue,  3 Nov 2026 08:44:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZGUxmsZzy7d; Tue,  3 Nov 2026 08:44:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DAC3E80C5D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793695484;
	b=n2gd77X3DpeSXjkflUdwp0UqAAcn63NDKDHoANCmSAsORkT278r7UEtx0paUIp5VgXWy
	 4QhAEgqo6favZN2c8e+SX0YPjaKUM6yOyddN/fUd3mOMTGoKtMx3swBiE/7qJWN9Ob0/+
	 FTHv1EQ8opBgNHOvIhmCJSC1Ml7TRaNetXONJn8McpsoXadgKY5okZSEYzpn5BQDKFDX9
	 Bs7QQyqR4sHFfBF0CdxSPEWZRBEvoSxXhdiJ53XqLLzwgxaFcd0K7+fSYYA1Ie2zISlt1
	 aAKw+ZyqkBSYiwPnLqG9WDiuXJgQS65O8IPWTlS+BxQrMu8JQdnGC3GugSQJLEdZNqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793695484;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F8FL+zvtquEEOQT4ZzfLUyNR7PX2JYZ+klgX1InLHH8=;
	b=kNmiTTs5ZHMSINKDCxsIMuxtY3cA4BdMde0c9I+3kdkmTRk0wweUQ4lhPTlNvqtgpZDp
	 RkzYkjTsANz/COvb87fu8MMDxjanaqlndX2RBO+pEA1Lr2DnsFTtfpLXsnnrp0mP/Qze9
	 3yB1zYZgrH8iHTi8AT7fvdxDgTqmyTiEQQeqs/amZyEZnGXBMD4GMABnlJTQPxA9DchjL
	 35D22gkCbpcSmEO4IvOkp7gSXv5TmZwORqCenyfLwfv+glt5YmiZJHpQHcXaIXgKSQqdM
	 5fbU8ShQTmTyNwPbwGEEmSqV0rbqwfXBdjRuJEJWBYaHglcqKjx0lJUhqzyEve4cFNA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793695484;
	bh=F8FL+zvtquEEOQT4ZzfLUyNR7PX2JYZ+klgX1InLHH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LoA0+0b3ynZJOH4dvGBEnHIvK6rgKBjzhfI59Tosapirw+MwA95cwHqpLRWleihds
	 M5KRBgeb7q8Mafr3z7bubUG8AHLRHFv0bEAE7jKxIYbDmvW/g18ck5254+eAWJwkUP
	 KUClU1cRtL9oYfdbqI8dli9nN5eq9d75HDnnGFo7i/kHcOSeMNLrUfKtBtRIymfpkH
	 CHVGQLuvLhTsNghd63DKsNfaI9d7dNhh5A347wn/9dhLlShUqIHa6IxIpuB5v/kaiJ
	 087d6syK/q5jRYTxCtxAg0hiXa6HAriecGnNCV8HsJ6Y2gZnvZIyRdXd2cvspKho1m
	 bvLfc/fgQjIYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAC3E80C5D;
	Tue,  3 Nov 2026 08:44:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A5E4411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6398A401DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LSQ82Iej5vS9 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 08:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 93BE040080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793695481;
 b=ONH7uccTb6bXu+aTPmEn/RcGuFd7sFlLbfZxVvFGTWCScPxELYpsIi43Dna5upvGGWpX
 Y+e/nnPX/6TZIRAltv3GEyvxWZpe2JWU1eHkHomk1YdbhxGAYQmbR3N8W+snktyIl2KyI
 jrmvuxwsIQ+RiJfRMbpz7jbIJ5X3gQwVtnBSvNQkpbwmZK9xQ1uE83P/JbbetdJ4r3jjl
 W9J7xSBP1ELIhw00o7fDsmtRlfHHF2OjjkOxVBnOg1wTjjMvD/5XU+jUXEMmu2nSWgnn4
 xBq3Foo3pTme66nXCczrelUbyhLqsC/I9wB1v/61xKduVcibr5UUggnbfV7uHruYckQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793695481;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
 X-Virus-Status;
 bh=F8FL+zvtquEEOQT4ZzfLUyNR7PX2JYZ+klgX1InLHH8=;
 b=dM8X31qscNS9aOwDXWBYSG4gt/kZOnhRQ0jP54oEpuZehZid4skW0/vtlOOCpLaYsVJa
 vWWd5C4HJprNLhRul3T25ubTrBumrk1sc0u1dun4FmYXSQiXM5Syvo4QVpa50D1q+abJe
 j2iHGFo9adLwTpDomoOMn0qaA79xVBHMhG4qurxEjUPKPr1Q+TGUTFwjjTW4sj0whTZVU
 DHlZFthbSwO/OP++LQPgGTjrt5eWF8qTzff0yUXMh1rL1mOEC5dDinOtJrnCzUXwcHjhg
 AJAMwBP9c2xB4VamENFd17GWpbHGAWPdUJU5Uk3tNqo2vtDEfzyTwmB0wsWXmQEXROg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=Yd2PAtnY; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=Yd2PAtnY
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93BE040080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793695477;
 bh=F8FL+zvtquEEOQT4ZzfLUyNR7PX2JYZ+klgX1InLHH8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Yd2PAtnYLjPM/VFy39T6xtj/yu4T8XH3suWX5nW4KenO8Iwxtra6/uoFAl4SJur1O
 dZNl15npqAAACN7hndcVrzvYQ6Y/KcUia8TBa4RpbrBd+FrY35hmd+Lzxwxw8n8Idl
 oyIwEFAIOzw45N0Li12Mre4myXJxSotGWNTLN2ZwKIhLXdWTlPxrVDQ2ED3Bk1hbU+
 lnWRuELhIgQnp3xKo8qEisRHnvuvXBHjzshctMqDCKe78JTZqzFrZ+zu+WF/ubCEl+
 sKC3sM3mZg6YGVSGvlw2wn/6wnhhuhWx4ReGvzTgVEOkd0jNovggLxw1bO5Y4QVJgh
 Ihef8pM5sr1dA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 2B4875F82C;
 Tue, 03 Nov 2026 09:44:37 +0100 (CET)
Message-ID: <a71d2e80-f36d-4e54-b85d-917a7d494a31@emlix.com>
Date: Tue, 3 Nov 2026 09:44:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tpm: deactivate unsupported banks in tpm2_auto_start()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
References: <20261029150906.1558380-1-tkirchner@emlix.com>
 <20261029150906.1558380-6-tkirchner@emlix.com>
 <CAC_iWjLX_3RAzxeCy7HQHEy+fZS4Jm-J_E6wnv_QG5+DWpX+GQ@mail.gmail.com>
 <64f49638-bcf8-45ca-bf88-2e96e2d8d68c@emlix.com>
 <CAC_iWjLwGpmX3jfeo2h=ERDuYZo-a5scgBejzV_euCgazHimQA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Tycho Kirchner <tkirchner@emlix.com>
In-Reply-To: <CAC_iWjLwGpmX3jfeo2h=ERDuYZo-a5scgBejzV_euCgazHimQA@mail.gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

Am 02.11.26 um 22:00 schrieb Ilias Apalodimas:
> On Mon, 2 Nov 2026 at 12:35, Tycho Kirchner <tkirchner@emlix.com> wrote:
>> I would rather keep it as a fallback: callers may use tpm2_startup()
>> directly instead of tpm_auto_start(), e.g. custom board code or
>> "tpm2 startup" followed by "tpm2 pcr_extend" on the command line. For
>> them, the check in tpm2_pcr_extend() is the only place where active
>> unsupported banks are caught. With patch 4, it only deactivates the
>> unsupported banks, and only with CONFIG_TPM_PCR_ALLOCATE.
> 
> Yes that's what I was implying, but I wasn't very clear. Is there a
> reason we can't move it to tpm2_startup()? tpm_auto_start() is calling
> it anyway unless it's already initialized.

No, that works. For v2, I would deactivate the unsupported banks in
tpm2_startup() with CONFIG_TPM_PCR_ALLOCATE, but only if the TPM was
actually started there, i.e. TPM2_Startup(TPM2_SU_CLEAR) returned
success. If it returns TPM2_RC_INITIALIZE, an earlier stage (e.g. SPL
or TF-A) has already started the TPM and is expected to have taken
care of the banks. With an event log, tcg2_log_prepare_buffer() still
aligns them afterwards. TPM2_SU_STATE, i.e. tpm_resume(), is left
alone.

The fallback in tpm2_pcr_extend() from 4/5 stays, for the case that
the earlier stage supports more algorithms than U-Boot.

I suggest something like:

```
ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL);
if ((ret && ret != TPM2_RC_INITIALIZE) || !bon)
    return ret;

/*
 * Only the stage which actually starts the TPM deactivates the
 * unsupported banks. On success, this resets the board.
 */
if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE) && !ret &&
    mode == TPM2_SU_CLEAR) {
    ret = tpm2_activate_banks(dev, 0);
    if (ret) {
        log_err("TPM: failed to deactivate unsupported banks\n");
        return ret;
    }
}

return tpm2_update_active_banks(dev);
```

What do you think?


Thanks,
Tycho




>>
>>
>>
>>>>
>>>>   tcg2_create_digest: unsupported algorithm 28
>>>>   Cannot extend PCRs if all the TPM enabled algorithms are not supported
>>>>
>>>> Deactivate them in tpm2_auto_start() already, before anything gets
>>>> measured. If this fails, e.g. because the TPM refuses the allocation or
>>>> no supported bank would remain active, return an error. The rationale
>>>> is that with CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to
>>>> manage the banks, so fail early instead of at the first PCR extend.
>>>> This is in line with the TPM_PCR_ALLOCATE help text, which does not
>>>> specify at which point during boot the allocation takes place.
>>>>
>>>> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
>>>> ---
>>>>  lib/tpm-v2.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
>>>> index 18ec9eb960d..bd049fed748 100644
>>>> --- a/lib/tpm-v2.c
>>>> +++ b/lib/tpm-v2.c
>>>> @@ -232,6 +232,18 @@ u32 tpm2_auto_start(struct udevice *dev)
>>>>         if (rc)
>>>>                 return rc;
>>>>
>>>> +       /*
>>>> +        * Early deactivate active banks with unsupported algorithms. On success,
>>>> +        * this resets the board.
>>>> +        */
>>>> +       if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE)) {
>>>> +               rc = tpm2_activate_banks(dev, 0);
>>>> +               if (rc) {
>>>> +                       log_err("TPM: failed to deactivate unsupported banks\n");
>>>> +                       return rc;
>>>> +               }
>>>> +       }
>>>> +
>>>>         return tpm2_update_active_banks(dev);
>>>>  }
>>>>
>>>> --
>>>> 2.47.3
>>>>
>>
>> --
>> M.Sc. Tycho Kirchner
>>
>> emlix GmbH
>> Headquarters: Berliner Str. 12, 37073 Göttingen, Germany
>> Phone +49 (0)551 30664-0, e-mail info@emlix.com
>> District Court of Göttingen, Registry Number HR B 3160
>> Managing Directors: Heike Jordan, Dr. Uwe Kracke
>> VAT ID No. DE 205 198 055
>> Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
>> Office Bonn: Bachstr. 6, 53115 Bonn, Germany
>> Office München: Am Knie 16, 81241 München, Germany
>> http://www.emlix.com
>>
>> emlix - your embedded Linux partner
>>

