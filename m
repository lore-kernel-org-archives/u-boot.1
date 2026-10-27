Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12C606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j6UaemDg;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=B18Ik2Gj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26263605D5;
	Tue, 27 Oct 2026 12:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xW8T-9mGYp_c; Tue, 27 Oct 2026 12:55:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4044A605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793105725;
	b=S8WaeauleAxsctt3+xiTsAiXCQQ1iyuTLC5dcfCybtLzkJZKtS7TKvP2PC5has0FBTUe
	 sHhV6QKxf8zv6UT5m0L8GF3NiCp7WDhbYUNu3sE4eH64aekfdCo8VHLwcVLn/qnyv4Njt
	 Vc3hVPxKMcSwG84ECgX7HrcmunNzsg8gQdpL9pe3AhOfIAyqSxanVDOi9cZK7Q3wsazzU
	 3dVufXWTkvePqaTrVR3zTGdDwTVpaSnMaQBlONoYTFOoWmVR2Pg5I0PY5gEyzzuH3Mosx
	 aJZhIj/CzcKHzkspgWyk7krgx0hIiYe/wm0JP1+YOXtf6FF/AbR5PskOb3Zu2dOYtdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793105725;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fUI+uCkZKUY+G/T/h+H3SQewmK+ouSMjclnVMNyio1E=;
	b=SM1RjldP6pwBkaU9HWns9KiYPXEvuygdTUjcYx/43ANW1J3lR/Lx9LcjOn4teZfiyRUc
	 ncfct2PcIY/71JaVoWCl8p9w+sxzZhXtBcpakjF6JewuMvEgUy2VCuNslMnhDbGc9KVaF
	 1RGPwQ9yxo8Va3lPwjlcRpfgdOGWaVc12t6LS95u+rn9fxbbyjzddGuJggUmns5h2zyEv
	 hZ8uyiOIEAkci6K288FMj/1HiR6zyfXQ7UUGfPauMd5ygLcwn/ym4O753PdLc4F/JQgSq
	 Xbu4965bKEYBhkE4oGZ0byoYSucWAU/5Pt7x2NTTIE2gBksiwW/5+jykU+fVVWyyumg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793105725;
	bh=fUI+uCkZKUY+G/T/h+H3SQewmK+ouSMjclnVMNyio1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j6UaemDgd7V0rXlwYiFj5kUUSFOFdYzcKj1UfVu/euXTJHWmdf6Btaam+9nVczYaM
	 505Yva+lSqwtJbFOpwyCjeY3RjBnV+tSF/7dUyf7tmGbN2ohGcmG97yquyfmkqbKAD
	 k0iBbfqOOJ0FONSSgrdUEjFm003SPIlFhMlPfbfQTpU/pNepfmLgq0gINXUInjxklo
	 /XLjqvhkz8eVBvaPLs6qkhVWduLbUUS5E7fZoAEzaFaRRbSnhn+9ZE3iASGMvaKOqS
	 5mX+kzpFrdJm9HfQrRHFA3pdsxXHDG7KGZclgCwy9TAEVsbTs0D+pZShqtMCfDgrJZ
	 bTEOiqESHDQQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4044A605EF;
	Tue, 27 Oct 2026 12:55:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A6BF2279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CF7080D1A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:55:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nf9Lnh39qBiP for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:55:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CA5180CA9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793105722;
 b=nDLrYAole8AVSiK/EPO8SHYcrL5zM6vF2Mpparyxch2XbA76chqjmJ6uxs2xz9PL6yW1
 wiPVj2UwNP+EpW0+ABKYcBBchWNPgQI13mZfn1L/S/oDGqqC7u6Ofnc2zWWi1yJguJ0V0
 t3gvWTM/kQeQob6waVQHYFPwoVqXWZEi3kJ+dCb6NDs1LeIZzqx08YSva7co0a8MCteky
 RBaMDpGp82pWdjSkuc1mM3RNJ5REPbwl3bPKfnsuGgMP9RXr5uPqznmQn68mQ3TJ54bYn
 qIroBI6fWNtnIw0bcAuamPhV0NXTj/hkzJGYw3MxKZu7OXCxFmtcSoW9byYtocLbsrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793105722;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=fUI+uCkZKUY+G/T/h+H3SQewmK+ouSMjclnVMNyio1E=;
 b=Rc/RYJl68L1MiOtfUoPecuUfqVqkBsIJlGF/Bd0GV7x9KIXZCjL36y5yGX6YNMC07Z0X
 NRmeJohdqMm7WfCa3+h3iYj4qqqXusXQY6Nq714mb6jchEHO/5oQ8AdaNWKD5ty2eVY3/
 SM5Y9EuxI2q3v9r2ulT5YGCVr0thrOUv/Mgk4fUyeMSpQf14CsilvyfX6lYRJ90+c9VSy
 /IF0otBKiuXadPir+2c1JPlleMSGl7IQylJU+qgeXllQI9SJ4sc33TGHoX8brg3X+ijJ/
 wTl8KYzk/Bkwtq8v2BQHdZMdMagx5wubLpuW/lwUS56i3AD17rc1HMhcAZGSB9XlWug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=B18Ik2Gj; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=B18Ik2Gj
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CA5180CA9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:55:21 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jDVpD58w4zKnQG;
 Tue, 27 Oct 2026 13:55:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793105716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fUI+uCkZKUY+G/T/h+H3SQewmK+ouSMjclnVMNyio1E=;
 b=B18Ik2Gjv5Xbg+Z6kEY6GfaIWhY/xxmJaD4eIT4KWw9KlfIieDjlSRWuK0ar7twGepN9oI
 FKd7RYJkxdp5BTIzJOPcWOrffumFvRhem8kYXiD+jctpq/WXtGKYOcfbX7ev2XDV/NoMNU
 BKWGdgSOR1QZ8eYuDw4ZejZm1CKmC5mtPg6PtH1YDliLB2I2Zvy/2rmPWT9GHxlj4V9qU/
 7EHFOYCXlOZweYOmTSJa1DFLN6lOBJ/n/GPdareVkhWQiMROePVPsrl7IEqsIOWOTAb1qb
 qg4sU30nMZ1BZPfw5uauTJvbeJZLa4z2VP/eHaxrLftWkgj2fR7GSh/FJ2vLLA==
Message-ID: <62de2755-54f5-419d-a570-d293e9a03d7c@mailbox.org>
Date: Tue, 27 Oct 2026 13:35:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: optee: Do not warn about TEE_ERROR_NOT_IMPLEMENTED
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Jan Kiszka <jan.kiszka@siemens.com>,
 Jens Wiklander <jenswi@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20261026201046.400670-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjJ_TuNMTJwmCm_KRCzbhVTKF3LprtK3RpwC1VJNQ6Q+9w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjJ_TuNMTJwmCm_KRCzbhVTKF3LprtK3RpwC1VJNQ6Q+9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: j9emdkb5stxczrbobq9egmfzu46wqxie
X-MBO-RS-ID: c2fc663b8d2324b1fb5
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

On 10/27/26 12:49 PM, Ilias Apalodimas wrote:

Hello Ilias,

> On Mon, 26 Oct 2026 at 22:10, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> If the RPMB is not implemented, then do not warn about it.
>> This occurs with older OP-TEE OS 3.x :
> 
> I don't really ming getting this in, but is there no value in
> TEE_ERROR_NOT_IMPLEMENTED?
> IOW maybe we should move it to a dev_dbg?

What kind of value ? If TEE_ERROR_NOT_IMPLEMENTED is reported, the 
dev_dbg() in the else branch will trigger, will it not ?

> Cheers
> /Ilias
>>
>> => mmc dev 0
>> optee optee: Enumeration command 0x2 failed: 0xffff0009
>> switch to partitions #0, OK
>> mmc0(part 0) is current device
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>> Cc: Jens Wiklander <jenswi@kernel.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.u-boot-project.org
>> ---
>>   drivers/tee/optee/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index a47c76811cd..9b18310776d 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -112,7 +112,8 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
>>
>>          ret = tee_invoke_func(dev, &arg, 1, &param);
>>          if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
>> -               if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
>> +               if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE &&
>> +                   arg.ret != TEE_ERROR_NOT_IMPLEMENTED)
>>                          dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
>>                  else
>>                          dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
>> --
>> 2.53.0
>>


-- 
Best regards,
Marek Vasut
