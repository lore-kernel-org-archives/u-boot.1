Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303D606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wk0CwX/d;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=NCK8QW8N
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 921D460781;
	Mon,  2 Nov 2026 10:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g1lGbT_whbxh; Mon,  2 Nov 2026 10:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6CBD86076F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793615716;
	b=O6q4CICcYbeMn+0Zz+RHafS6mdFZoT9rjuYQHUVuGR4DRrXGxgKtQ4QjcFo6akrd2Sgl
	 8Q589BUOAaHydR/38c4MS53c7rKxy9KwbBzq1wA0Vsa1/v2Wcdn050wK82Sbydd4wr8VI
	 HzVOvun373gNXCuYf2raMmAedyx466uw0Psw+AlX5XZdbow6o+q/a5zvXkQiWPmRh4A2i
	 TzduYUhFTyo36SmUBM6jWyDkHHruxZI9J/9Nk9WigBRmJ4mtH85o2ljcOGHB7CZROpd4d
	 H1q50bILdsbVJhEjP0poAsS7Qv5Qn3Qf8AHla8GcmGWaiQMP4gqYyWEgNLtgQrfiVRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793615716;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IZCntnTRvxveX1vJ+zCBuHqRoHRKwEOW2laO/QKT5+Q=;
	b=Grm+hO6bzO+f17fE9/jYdyQZDrpInjYXl/KRVH/gxwerHvUl6Q4Lv2hf8kYgDnEImZ/+
	 bBdsMmbPQTP9wndWMWst2YkPSSlUKXopx7yQP/jAwEgCxPexX/AuwmsWg3vv+YP3/Dw0P
	 sp5D7UAd3OG6H4ALa4acRS3UolIyI7SyOeU/I+jd5kvu+c6jjr4Gr78Wjh38Kf3sGuyQC
	 MDYYuWDcgaZvBBraD5AqEwMnlbhZ11mCE8tHPtjRDrFjp7QcagepDZWvN+FzNDFmC4SdC
	 XYmPn1C+V8AMRgOMHXsWm6JzaaNRjemTVyHpmDDE0/8JWGQ+wSb3EpKsf588undB0ag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793615716;
	bh=IZCntnTRvxveX1vJ+zCBuHqRoHRKwEOW2laO/QKT5+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wk0CwX/doc+ub1PfraJenNzGKxmuT9//OROts93dZlAwDpLzLuhUO9H12hOT/FJWX
	 ur85zdHo5EX09vykTesNX3xs5uoeMrKbFsQxsp9qJhD8VxELIxU+/MEaLx8hdBBZIM
	 YsHQDvrMWaKOZhAEqny6KqRURDJRJxISxr1f85FVBzwyafrPD4j1+Xpl+EYhshbX7e
	 oi0o7D0wqmptVe0EpH0Cujg5nWJThksG/h7vUrc9//8Dq0Qc1q2u3E/Y0Ry0411J4m
	 urmyO3HGlgqw2W9o23E1egTOAxsS4pNB+a3A8cEO7UTkoZE/bHn4jBD5W3B54H1Tt7
	 m/MtK/bhAj9LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CBD86076F;
	Mon,  2 Nov 2026 10:35:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF04F435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4A5B400F5
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S2Ol4sCBVyo5 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 10:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E4B83400A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793615713;
 b=KFu23v62voy2S+DVWMyoJXYPYf9aBMj8+PKjc8upwt0M6DuqaLPWIqJsxliHnJRLuCtT
 qJ4Ovj3lM1WKhaebCkx3ZbkZa4s6W6bji+pH8Q5i9JL3yz7FILt1eI8KMQXsXBBbNfBcF
 P/C3BsWpuU2pYBlW0qJEozPcdy7ptOzkvwMIsd17QpdJJDLKHkD0qc0X+Bq4iMVcQ5n4P
 A9AWZN1BKgN3gsonwWO6BthYghXQP8zUMapb1vlueSTQhXWC5yoqFsuOl2XTZVbmVs1wj
 5wBj/nKCGHbryJhftB0bQLrQHIxhnKgL1E30wHzogLRCSXj2sKviRNjl7gh9oFzgiNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793615713;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
 X-Virus-Status;
 bh=IZCntnTRvxveX1vJ+zCBuHqRoHRKwEOW2laO/QKT5+Q=;
 b=XPm03ay8fO+AKQJyEp5e7inUnSMizIDfgUnd5zmpPIi2sFqLcNPAZdHHtacyu/4UfoCY
 ouMzNppmtBCFK/NkVKHv8MGNNei2k3sqZdkWi0DvfrC34e/jqFieiN4OJBvoQdn0FQX1Y
 l/0/SzwASeCwsQcBX/DLTwDALkyv95dKZrqqjhWxdVGYA0ggGf9RxN69X0nEkgbxm/bAg
 8sIl2E79XqtJuKIat5l0ihFexNsUxNOEX41ZxEUjzJakDjw6hhwDxNCWjDCo08enWBWcI
 MYD/YdK2qu1pnJxp+89NLteGzqfbItBXpuOLR6IfBljoIVFDBC3740CBifbd3lVobiA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=NCK8QW8N; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=NCK8QW8N
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4B83400A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793615709;
 bh=IZCntnTRvxveX1vJ+zCBuHqRoHRKwEOW2laO/QKT5+Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NCK8QW8NGPXQF1GGTLahD71CiSkvjtn4Ar/0PjAkT0Hv4vlFAtdyBEu52B7TlUGPZ
 78L6MJwEl4X7U4SHv0cjaatfnheSJ8xpdk6iHBl3uFTvJ1SyT3MM7KPY6wUeY9IgP/
 /e3gmlRkotV03aTNoE782dPw1S4vA0/0QXT7PH3tfBDCnp62IsQsD7hWhw/cZnpIny
 Gp7ONa4Fun2V8uYGZ1UpBs9172rkI+x/MAATukY8HdV0GJgtX3SJ3fsEZHnB2/krum
 pZQOUca06SsPPFSV/a5NkUi2lD6K9dHD4TnwddNajZhlte7AsUK8GJjBtyAEtUmSr0
 /MhT4i62VpzCQ==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id B63935F840;
 Mon, 02 Nov 2026 11:35:09 +0100 (CET)
Message-ID: <64f49638-bcf8-45ca-bf88-2e96e2d8d68c@emlix.com>
Date: Mon, 2 Nov 2026 11:35:07 +0100
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
Content-Language: en-US, de-DE
From: Tycho Kirchner <tkirchner@emlix.com>
In-Reply-To: <CAC_iWjLX_3RAzxeCy7HQHEy+fZS4Jm-J_E6wnv_QG5+DWpX+GQ@mail.gmail.com>
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

Thanks for the review!

Am 01.11.26 um 12:52 schrieb Ilias Apalodimas:
> Yes, but users that will call measurement_init etc will have
> initialized the TPM.
> The PCR code exists because some users want to use the TPM only as an RNG.

My use case is a custom measurement implementation on top of
lib/tpm-v2.c, which cannot use the tcg2_* functions. So
tcg2_log_prepare_buffer() never runs for us, and nothing makes sure
the unsupported banks are deactivated. I think the low-level API
together with CONFIG_TPM_PCR_ALLOCATE should be able to handle this.

Regarding RNG-only users: TPM_PCR_ALLOCATE depends on MEASURED_BOOT ||
EFI_TCG2_PROTOCOL and is off by default. Its help text states that
U-Boot sends a PCR allocate and reboots, without specifying at which
point during boot. So a board enabling it opts in to that reboot. With
MEASURED_BOOT, the first measurement resets the board anyway (with
patches 1-4). With only EFI_TCG2_PROTOCOL, the reset currently happens
once the EFI subsystem is initialised; boards which boot without EFI do
not get it today, but arguably should, if they enabled
TPM_PCR_ALLOCATE.

> IIRC we can't get rid of the EFI call, because it's there to configure
> algos that where handed over to us from a previous stage loader that
> only handed us an EventLog.

Agreed, that call needs to stay, since only there the banks can be
aligned with the event log.

> Can't we fet rid of it in pcr_extend though?

I would rather keep it as a fallback: callers may use tpm2_startup()
directly instead of tpm_auto_start(), e.g. custom board code or
"tpm2 startup" followed by "tpm2 pcr_extend" on the command line. For
them, the check in tpm2_pcr_extend() is the only place where active
unsupported banks are caught. With patch 4, it only deactivates the
unsupported banks, and only with CONFIG_TPM_PCR_ALLOCATE.

Thanks,
Tycho



>>
>>   tcg2_create_digest: unsupported algorithm 28
>>   Cannot extend PCRs if all the TPM enabled algorithms are not supported
>>
>> Deactivate them in tpm2_auto_start() already, before anything gets
>> measured. If this fails, e.g. because the TPM refuses the allocation or
>> no supported bank would remain active, return an error. The rationale
>> is that with CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to
>> manage the banks, so fail early instead of at the first PCR extend.
>> This is in line with the TPM_PCR_ALLOCATE help text, which does not
>> specify at which point during boot the allocation takes place.
>>
>> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
>> ---
>>  lib/tpm-v2.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
>> index 18ec9eb960d..bd049fed748 100644
>> --- a/lib/tpm-v2.c
>> +++ b/lib/tpm-v2.c
>> @@ -232,6 +232,18 @@ u32 tpm2_auto_start(struct udevice *dev)
>>         if (rc)
>>                 return rc;
>>
>> +       /*
>> +        * Early deactivate active banks with unsupported algorithms. On success,
>> +        * this resets the board.
>> +        */
>> +       if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE)) {
>> +               rc = tpm2_activate_banks(dev, 0);
>> +               if (rc) {
>> +                       log_err("TPM: failed to deactivate unsupported banks\n");
>> +                       return rc;
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

