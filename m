Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9916606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O3HOpqEC;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=GLORNIiZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8680A40825;
	Thu,  5 Nov 2026 09:39:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXit-tw4wYIU; Thu,  5 Nov 2026 09:39:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8FE4740801
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793871586;
	b=PECGWwmDdfcZ1UaH7nTDO4GxZjs1cULWclvQ9S8Xh/lVuOwNSoOq6jrQxO1Cz7AHTYlG
	 Wbb9UHYIto16GSYRyJ65DV6N4+zzoVbCy+Jqe6tpoB1ivd6uHkupx9nprX/mB6bX1UVvc
	 uzTDmrWHHSd0tSC5r50wLzZJYiQ+mt4Uxpwwb1BFYIY3HGDqZ3fbr4iiaVT+y2RV8cCOr
	 nFMeuYK+Hh9+rJOlO6f7Vzj3YgY7i1taAQrgf/Qr3IxIOoC/oE0Me8y0kwyJFH8eEhnP8
	 qUUInFhKdXE7n9LYn0Zf/2Cj9nNdLp5YgnrIWCMfMHqo8ZnBt29RJ24rQGjrcKr9jXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793871586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tcHqG4tRc6vTeCd9EGh+NRYhshlRYxU9Vr0Equ2hYuM=;
	b=pjqwFy6yH2PbcVzncAcYh0qv/4d2MDQ7COqucgb23dLmBtffNRLQyzbTKDNbRmc7zP2y
	 3hPHC+i8W5AU2JfnRomhWvKrTCwfJDyzQv0nydzJoLJMCyXoO5Q+YR2kn99Kn214dpaun
	 kDbgkFI68i1rsvOv1zW1r/zD0qfKkCwO3dGK8GgjMRQYUBjzToHXQ1atvTG7J2FOm38u6
	 HRADqSWgGpguGPl5NsBHWI2kOUWOSP/fLjXZRTCtUX/Zn2PZQZSjKK8f4DB3aakJxPG2r
	 nnWL76zd8ci7CA91Nsww5ewNnY2bx5wIYz9R6/8uoslYIs+WJ22V8llJi9TOYRw62zA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=emlix.com;
	dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=GLORNIiZ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793871586;
	bh=tcHqG4tRc6vTeCd9EGh+NRYhshlRYxU9Vr0Equ2hYuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O3HOpqECpJqsiaWLkfPvSjdDRtMoDCfgQrVd3uGwiJ0qHpGXJ7uBTilk3tBlmPgm4
	 hBNphnrhEIqMCUxlVys9UdgN9oLDrklOrrPfbuXFO+asDKpGZjpj0zNWS5U6wXTkjh
	 pPsTPuMRYltklRqhNVOwrX9mz7HXsdpic5WpW9UP2ASKb5F/3k+lcz0K5YdAJ+4s5f
	 /Mj+U3ICY9W2lICXkdf9hFIRRCjv9x+P1bMNYToxPzcLsP35FEpSlun9ZJFge7CfR0
	 9bLYsy4rDfXqzJfAYf0/Pz6DAfr6lzMWJkxcfksmudw/7MkWBEgdCX0JEQ562Mylhn
	 IKFjKaUg1cdgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FE4740801;
	Thu,  5 Nov 2026 09:39:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7070362
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8DE2407FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9chC-Qf_KNu for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:39:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00ACA40801
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=GLORNIiZ
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00ACA40801
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793871579;
 bh=tcHqG4tRc6vTeCd9EGh+NRYhshlRYxU9Vr0Equ2hYuM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GLORNIiZldJZZUw4L/mspFRvPffhjh1ddNqP9wUk+NgkbOSVjMrjdz+ke9Ak8sThk
 j2GgoOs6P+JSufjxQ7l6P3BEcdTP5wESKtavDhRi5Ksp2fYJW1qTDDzffnxfzSzHKA
 e6jcAds1DdtIFLvoswzt2EBD/PF8C3Ai7QUVaWkHQw/s2ByNWdGfYHUOWgiaUMnfGh
 /T/cga5tsKKBychlxVMH6sd2Yz33W1a2bZT92KCPwQnet4XE/boBGrStIeE+b8WbLZ
 jVCgagRZIiv9EdIc39h4VRHxMQtN2c69n+uvQ5xe2oUHSeMu52nLv6Y1IE2CUmxAM+
 CgVeAMgrG65oA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 6991B5F7E9;
 Thu, 05 Nov 2026 10:39:39 +0100 (CET)
Message-ID: <8d672101-07e6-4f6c-b15a-53973d58c34a@emlix.com>
Date: Thu, 5 Nov 2026 10:39:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] tpm: fix handling of PCR banks unsupported by
 U-Boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
References: <20261104094238.519111-1-tkirchner@emlix.com>
 <CAC_iWj+5qjivBQYL_3-J9P7AU7fqMky_GuWn4+48RaaNhT-Jeg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Tycho Kirchner <tkirchner@emlix.com>
In-Reply-To: <CAC_iWj+5qjivBQYL_3-J9P7AU7fqMky_GuWn4+48RaaNhT-Jeg@mail.gmail.com>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

Am 05.11.26 um 10:35 schrieb Ilias Apalodimas:
> 
> Thanks for the update. You havent appended any of my reviewed-by on
> previous patches.
> I think this looks good overall now. Can you send a v3 with my tags?

Sorry for that. As this is the first time I submit to u-boot I'm am not 
so much into it yet (;

Going to send the v3 soon!

Best Regards, Tycho


> 
> On Wed, 4 Nov 2026 at 11:42, Tycho Kirchner <tkirchner@emlix.com> wrote:
>>
>> A TPM implementing more PCR banks than U-Boot knows algorithms for is
>> currently rejected by tpm2_get_pcr_info(), even if the unknown banks
>> are inactive. Ours implements six banks, including SHA3-384:
>>
>>   tpm2_get_pcr_info: too many pcrs: 6
>>
>> Once this limit is lifted (patch 2), the existing code for deactivating
>> unsupported banks with CONFIG_TPM_PCR_ALLOCATE turns out not to work:
>>
>> - the result of TPM2_PCR_Allocate (allocationSuccess) is ignored, so a
>>   refused allocation goes unnoticed (patch 1)
>> - active banks with algorithms not listed in hash_algo_list at all are
>>   never detected (patch 3)
>> - the fallback in tpm2_pcr_extend() deactivates *all* banks and does not
>>   reset the board (patch 4)
>>
>> Patch 5 deactivates the unsupported banks in tpm2_startup() already, if
>> the TPM is actually started there, so that this happens before anything
>> gets measured, also for users which do not go through
>> tcg2_measurement_init() or the EFI TCG2 protocol. Note that with
>> CONFIG_TPM_PCR_ALLOCATE enabled, this lets tpm2_startup() fail if the
>> unsupported banks cannot be deactivated. The rationale is that enabling
>> the option asks U-Boot to manage the banks, so failing early seems
>> preferable to failing at the first PCR extend.
>>
>> Tested on a downstream U-Boot based on v2025.04 with a TPM implementing
>> six PCR banks, with the unsupported banks both inactive and active.
>> Build- and unit-tested (ut dm tpm, ut lib) on sandbox against main.
>>
>> Changes in v2:
>> - 5/5: deactivate the unsupported banks in tpm2_startup() instead of
>>   tpm2_auto_start(), and only if TPM2_Startup(TPM2_SU_CLEAR) succeeded,
>>   i.e. not if an earlier boot stage already started the TPM, and not
>>   for TPM2_SU_STATE (Ilias)
>> - rebased onto current main
>>
>> v1: https://lore.kernel.org/u-boot/20261029150906.1558380-1-tkirchner@emlix.com/
>>
>> Tycho Kirchner (5):
>>   tpm: check allocationSuccess of TPM2_PCR_Allocate
>>   tpm: allow TPMs with more banks than U-Boot knows algorithms for
>>   tpm: detect active banks with algorithms unknown to U-Boot
>>   tpm: deactivate only unsupported banks before PCR extend
>>   tpm: deactivate unsupported banks in tpm2_startup()
>>
>>  lib/tpm-v2.c | 76 ++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 65 insertions(+), 11 deletions(-)
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

