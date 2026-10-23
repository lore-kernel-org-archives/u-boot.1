Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A20606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k+PtJWHs;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ovkf2o9S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 878B680C97;
	Fri, 23 Oct 2026 11:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFZn0H5FVQTt; Fri, 23 Oct 2026 11:19:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EB1B80B12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754348;
	b=UowJlrxC4vVb9EAgh4rkRZa1WK0OAXtRg+zHxKSV0eYnHMSQlFhime2uyLPB/VSeJXX6
	 AoA9AnA9Pnw0MXaw/txVtXXOkZoc0PdIscB3eVTknZqZTYK9+oWaUmhaBMeQSt0vXdwbr
	 Y2AgKSmCt1Ys/QCWo7UPKiMmhv3LdejHUkHjv1IIkB1QNX4zTWZ4pGuPaJOlvs+024lqc
	 jTLReH7Q+fLIE9Fvamxy/rTw0me9ZwEPN0crLrH4burnTrTJipACY0ggoLz29cruW5QGW
	 fg3byk5LwhX6EQkKTaesL086lXGxXWdPtudpg/nLXNRiyva6RsOAsB7Y1VzkNo5ifhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cw+TYRdqBmbYD0I44Zkax2zP73J2PYeuUod6FREve38=;
	b=V7gH9EKhGc1AwQmWxxtfnF/mUUmUHdZWCFekDuA8h8FTrpk/Sdo73opQNDDEcupt32dF
	 xNGbPVjES8uml5FZ0exrQnX/N/IkK2xCrWcZqbqMrwlvv8YVevc9qiiPBI3ZnM76VnwcR
	 ghL4TT2h1IJc6KIO9t4oQo0Sv5BrC+KFhjkmstNnqVh/aXmP/Txi5JXXxnokKivRK7uKX
	 oyRpIeOTv8HSsA0JtubDHQcDL+FZjQbR2VLrmmlLIzX5osynUMxF8AUdqGv9xlroAS8ti
	 asx2ura8WICkub3eRqLqTdjlJtkIoNyoWbq3LRqlmzDCgOE2N/U+xl4Hkkn8nffK/eQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754348;
	bh=cw+TYRdqBmbYD0I44Zkax2zP73J2PYeuUod6FREve38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k+PtJWHshYnxzgxNHzKU9cpiviMsamrlsL+kGUtAGTGnymMewwGQgpZFuoyZw9jS/
	 D0YyzgeFVWNUquFaw2OTAZpsncboKA/h5uJEKo36IZRLfSr5/NeKMR4KE7G1OqtzbV
	 7kSxmeX2DQEZcau0fc9Hd0yZPbWdwVXlDX/3m/2nfWpCiHvw4H58X4zKiRk1xc7tmm
	 cYxBdUEZ+xpsO0OA37241S/hkBVdaRenUGUeOgmheGLTgVRVpSg1uN2C9uXF8i323H
	 Uu+fbwSifseLVzJx/ShxKkHufuF3PQQc3keivjrTVtR7g2dPcAnA4iJCA8dFVf00lC
	 Iel72AlZPe7xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EB1B80B12;
	Fri, 23 Oct 2026 11:19:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 451BC3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2ADCC40099
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Ev-166r4MbR for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 91E7E4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754345;
 b=TCGojh9JYN84JEpRnNbAZE5ieZmcHboBjBHIEFST1GwOJUs4jMJq9cQ81YX/GAR/aAeM
 634diefX+Uk2R1kJ/1gfCZ7cx8NfM9G5GeNjgsciT56l1RVdRn65ao8r9sUH+kTX6iiwl
 ETGAEvhdUv7BLiLT/WkHpp5MiD7IccwVNv76CGZl0KB7Mq3nshT0W+DFdUTNC5lWd9/PW
 O6m+nyaKEk0qkr9a0XZB6Ab+0Nkg8E5/XLZ/J1XAPZbQyESyd8RYStH2CPW/SAXglsfmr
 OIFUhdQm99AVewogK7h1uMBVo2TrSwG+nSgygmRVPMjdbFJ9FYUwGnThbV85ujr9whQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754345;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=cw+TYRdqBmbYD0I44Zkax2zP73J2PYeuUod6FREve38=;
 b=C8VcuoUiMdVeTpJh+7RJVwe8B9mW63bR1N78qPMVh/rOE8JBlhJS0vyFgF5mZdk72J0N
 CnPu8/TTBzOgmfV4Isg89Vmr21+YSQxzbdKiKGx2NXwH0roAC2KlcY+aoF9Tsr6jJo2pw
 5bbFyVN2q/x+ViauyJshkYnS/dralyCHEhscymo7Ax7HmBz8evHTuBD4ZEuNpml7yf5z8
 GAhF8B4kEtE2cUGfpIGE/b4yYpLHO2nWxYPTJv4g8TvQP6G6tfhQGZOKfTP2KCJiDq9h5
 S2S0H1B7NLa4EtPneKlXGeW994PrFsqCLX43T0ZPfg47p363BqtpamtYIfRXXw6GOaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=ovkf2o9S; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ovkf2o9S
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91E7E4008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:19:03 +0000 (UTC)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B84E03F339
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792754341;
 bh=cw+TYRdqBmbYD0I44Zkax2zP73J2PYeuUod6FREve38=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ovkf2o9SMX6YL7pW4271rpYejMiWJ/+gFoqp3Ik9se2wHt+BPZR2YmqKmuCOVIoDw
 hHXjfq1h+ypubE47rByn64FLjZHLhUa58bqWV/6TvCo/W097pLEgQxaIeb0bzs2T6y
 WFvwvQtfy9H+R4O47mOEWVu/6aClbUj5OOlnFHGkc9XH+wz3Dm026UgXY73De0Ao+A
 vRBXPCKbJJ1yfGpbTxhtQQpy/GpUmMg6u+R+irx916NG1qI+opGSoxV4m8MuS3cSfq
 qE3GNk5vwN0BQpYKHf3rrGz6ibkDfuANEJ733tAQ8GWXieRGPn65IEzyRIemu3NKH+
 OUMDK75VgrMYmDh8XFVFLRcLOcNoV9kErM5Ew5J+3tP2bvZ+x9/mVX3TQD7iYs3uPN
 FQtgFo4nf7V1Yugefxt9U6x+I0bhMrW9MgJLHftliuTQRfWW7QwVo+nhO8Lm2qG9/z
 k2hSvizingiFwh9muE3IIOGHl8pXcRAi5Io5DBjri5+UUaV+3Phm20lpcmigttiMhO
 O6pKBH+PjqJCRQSsyq6PkrJmqljfsaoU+HiF4+CySfHyEVJbh4aPUWajQrSCZrSLMO
 APDg+itrAjV1QqtAuxjRolVgxz1+8jMvHQ3J9lUrlw7JixVGnbK4GlqBFOb1+y65kY
 LkXEPk+PO3fpMZO16dTpTn1Y=
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8afde3fe132so13430477b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754340; x=1793359140;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cw+TYRdqBmbYD0I44Zkax2zP73J2PYeuUod6FREve38=;
 b=Ffueflgx2H2gvhvOfbIRUMT5+SMuxTmlc/aLN92+AG4GhxL0k4b/6GmXjg7nJD5LJJ
 f9QQ5b/UQa/wRuPNDx2hbUZi+sEsKpPo6T8lJB97YoB9TkJfmq0joqe1DGUx1mjtTaui
 iUCdzTAL3rtooN0wvxjjmZCix5EK0rOwr5rWld6D+BxFSjZLrDaBknKgMGlZsAMqCFNa
 1Z/emRznnQaanoR9KVRaRe6vBlE8VLbLAcxwGOB+Wz6i4gdjW3+Qg207O15/kV5BOcmJ
 rNiHsW2aNLsD6ZvU+1KumP/hYxncQu3vrDVI6YXU8MfNofTo6tWTtnm6JOmEJwMwVTnB
 6yuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqvzi3qGyRFqzrIgB7/Yoeb7ZdO/Yy3uko83yHS9B1dmF72nT6TIRjnsKfZV+8CCXeuHV9DEQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIB/fUXafrptmS2cP7OQTcqwtZe2h0C2b3rWdxIQbRPVkI7XT/3
 X9pauP0iaGaA9Omj64F4Y3+bWO5c9puFGbr60Nd6uk6m0nUP2dXHM2Gus8IR7AhxsiYxK8l8FG/
 z8mRafh2tAad+DTkj3afL1dxt2pd1nF6pkpbzDFVVYQ7x+J6eDSzxEEr66D279loQFUpLlSPkyW
 Xe0QhWBDEyZD1+ntkc7Fdj
X-Gm-Gg: AYBFou19NG3V5VSqhB8la5Cr3M8kzq719IDwAUVEbfCliFLg68kJoSj/AGKqEZUFY/x
 CLsbcSxHEFuywayRBdNmh4p2Bnz0YUR7SdEIOgbx7MsA+cpzIvWpAMQ/V7ycF87QKQnJYUcfzi5
 Dr92kdkZao0NHivKSsV7yu1/xCWhCnx1kNphP1uTAr6TJkpNFDurWJBHhzcEreaaP/9FfCDotph
 BsnyCQO2yw4jkZ2p4OWACaYOmrvmrVK8wML096l4VqtykOJXnUFCIyIhT+INp1iu+VI2LKy6yx+
 4gDr6Ezs6wKQHTtUelUf7GBlGXXSQErNqcNwQNQY6JQ9Km3gbuNzPg4aAQBqD0W9z7CBCPVG4nm
 iuKmZMauPg8OFBXhBOAQuLfvId2xTX1pSYUIszbEpx/KwG5V8D8pjHaU6pica3Rda8KbpFPFBnp
 G7uTYHibgEoVP3F42Obhac
X-Received: by 2002:a05:690c:78d:b0:8ab:37e5:6678 with SMTP id
 00721157ae682-8b157e3fa65mr16758237b3.44.1792754340481; 
 Fri, 23 Oct 2026 04:19:00 -0700 (PDT)
X-Received: by 2002:a05:690c:78d:b0:8ab:37e5:6678 with SMTP id
 00721157ae682-8b157e3fa65mr16758097b3.44.1792754340110; 
 Fri, 23 Oct 2026 04:19:00 -0700 (PDT)
Received: from [172.21.9.158] (host-209-35-187-178.broadbandcancun.mx.
 [209.35.187.178]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b155f8be89sm11996747b3.1.2026.10.23.04.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 04:18:59 -0700 (PDT)
Message-ID: <81cfd720-f3c2-4807-9fd8-867d465b755f@canonical.com>
Date: Fri, 23 Oct 2026 13:18:58 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: fix HII GetString()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, u-boot@lists.u-boot-project.org
References: <20261022235602.221357-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKOd0LSgJhAxDE=emrzgn7pW8CygaSCPSvkK_nyzYD7Lw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjKOd0LSgJhAxDE=emrzgn7pW8CygaSCPSvkK_nyzYD7Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 09:25, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Fri, 23 Oct 2026 at 02:56, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> * Add missing parameter checks required by the UEFI spec.
>> * Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
>>    language.
>> * Handle querying the string size with *string_size == 0 and string = NULL.
>>
>> Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v3:
>>          Update commit message to indicate that parameter checks are added.
>>          Correct a misspelled variable.
>> v2:
>>          string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
>> ---
>>   lib/efi_loader/efi_hii.c | 34 ++++++++++++++++++++++++----------
>>   1 file changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
>> index 90dff91e5d4..47325f7d8aa 100644
>> --- a/lib/efi_loader/efi_hii.c
>> +++ b/lib/efi_loader/efi_hii.c
>> @@ -910,41 +910,55 @@ get_string(const struct efi_hii_string_protocol *this,
>>   {
>>          struct efi_hii_packagelist *hii = package_list;
>>          struct efi_string_table *stbl;
>> +       efi_status_t ret;
>>
>>          EFI_ENTRY("%p, \"%s\", %p, %u, %p, %p, %p", this, language,
>>                    package_list, string_id, string, string_size,
>>                    string_font_info);
>>
>> -       if (!package_list || !efi_hii_packagelist_exists(package_list))
>> -               return EFI_EXIT(EFI_NOT_FOUND);
>> +       if (!language || !string_size || (*string_size && !string)) {
>> +               ret = EFI_INVALID_PARAMETER;
>> +               goto out;
>> +       }
>> +
>> +       if (!package_list ||
>> +           !efi_hii_packagelist_exists(package_list) ||
>> +           !string_id ||
>> +           string_id > hii->max_string_id) {
>> +               ret = EFI_NOT_FOUND;
>> +               goto out;
>> +       }
>>
>> +       ret = EFI_INVALID_LANGUAGE;
>>          list_for_each_entry(stbl, &hii->string_tables, link) {
>>                  if (language_match((char *)language, stbl->language)) {
>>                          efi_string_t str;
>>                          size_t len;
>>
>>                          if (stbl->nstrings < string_id)
>> -                               return EFI_EXIT(EFI_NOT_FOUND);
>> +                               goto out;
>>
>>                          str = stbl->strings[string_id - 1].string;
>>                          if (str) {
>>                                  len = u16_strsize(str);
>>                                  if (*string_size < len) {
>>                                          *string_size = len;
>> -
>> -                                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
>> +                                       ret = EFI_BUFFER_TOO_SMALL;
>> +                                       goto out;
>>                                  }
>> -                               memcpy(string, str, len);
>>                                  *string_size = len;
>> +                               if (string)
> 
> This is always going to be true since u16_strsize() include the
> terminator. It's a nit so I am fine fixing it during the merge
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

string is the pointer variable passed into GetString().
The value of string is not changed by our implementation.

The UEFI specification allows to call the GetString() service with

     String == NULL && StringLength == 0

to retrieve the length of the buffer before allocating a buffer for it. 
We must not call memcpy() if string is NULL.

Best regards

Heinrich

> 
>> +                                       memcpy(string, str, len);
>> +                               ret = EFI_SUCCESS;
>> +                               goto out;
>>                          } else {
>> -                               return EFI_EXIT(EFI_NOT_FOUND);
>> +                               goto out;
>>                          }
>> -
>> -                       return EFI_EXIT(EFI_SUCCESS);
>>                  }
>>          }
>>
>> -       return EFI_EXIT(EFI_NOT_FOUND);
>> +out:
>> +       return EFI_EXIT(ret);
>>   }
>>
>>   static efi_status_t EFIAPI
>> --
>> 2.53.0
>>

