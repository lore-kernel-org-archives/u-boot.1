Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91107CA5FE6
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 18:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E0CE80A96;
	Sun,  4 Oct 2026 18:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9c9UOPNzh_M; Sun,  4 Oct 2026 18:31:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7D30880D5E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791138689;
	b=HBoAk4M228/m+Yzd1vn183L9ouj8gNsvEsCSHqRhPJH+av+GWp5EtNrB9i6x2XLYI4WJ
	 5T6C0gcOkEm8E9cLEHDaqqtsL5CsOdkok37Q9tuAGG2LyL+epyPyRte36ftQoOoXGOzwC
	 I3xe+cT5YiTFzKQ70Vvvp2nVdsBrT/18UEdQK2Lh6dS1KdnwR0Z+EyeEia+nwWEc6OAQG
	 p5GgQlckbUdUUmpl9n6u2HKz5e0UXAuqLrCIwicMYEHeKuRZUrl9Q+xoPTB3x+ovd+Mkg
	 HqcgCSpxX/ImTtqq6HezCAzPSxp42q64nVUUwWhq0ouxy49zEW1941obqfivnCprI6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791138689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fE4EGLtPru4CDYJY3RJ+YeBfBn4vDykozEn0otxu7/k=;
	b=Xj2chSUBAGmKWST1ihIXQUpAafpAaGOHuKNAGCr88WBMZ5n6pa8lHgnewyqxPOV0W7IM
	 8B/f64kwU9GU3G3d41AsO0x63JuA8ZSECyZho3dbI7LWyXDR6AC4TJ6pBdv4jPOmgFWPd
	 6Ne6+AsdI1nBovsqJ26vZ2ApbfQ2MyOavtuCQ43XVf5eLPn+ObzXN+ZkrCuPO+bSncwED
	 nibn3pBN2Z7Jm+ff2nR6zkC6a9cevA8Ymah3FZSr//JHB28/ahM47Kt0HmosQgVEANMhJ
	 I1r9p16t21lJhc/6js5VOn5gkPkUHqcsGST3DYsEa2z1YepSP6FwfVFZXeS9wcbNkOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791138689;
	bh=fE4EGLtPru4CDYJY3RJ+YeBfBn4vDykozEn0otxu7/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f0CI1pPO9S6D3zBerglfcuHRzCebjTTNw9A2Bcgl9yht4klbOhZ+m3LWs/LF+2Xny
	 Y7RVQBhTTt4fCruBeMKQNtMVdmLeRi5uWtchE5A5PVQFG3F9fJo+XJS3cbaLfSyNWe
	 4rfnHM4vjoI53/bCi09wIsXsC+8ITXmffbt4uTP/Nf8UEwmxdxv91kjcK/A5ZmmtG8
	 +HJ9FtmZGiwJ+Z8AnnF0qwG49ABEG1U/uvUgmvFxo0WarRTkwVPJ0wdG/ED8FmWHyt
	 fGsbl8rTvOZ3y5uKA/Cy8jhLVPwTkD3B7ZsaqcWvTS0mqr+uEf37jJi+8YeI7ZQJkP
	 BXKa6zKg6evTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D30880D5E;
	Sun,  4 Oct 2026 18:31:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E90B22B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 18:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8062D400C8
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 18:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1lcF1Dt-oMm for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 18:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7C8B440049
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791138687;
 b=suZsMY+XqprM+DTOGeQFS3jQiPFvY8dyEXEs5aTkOEuXFnUMeqCMQ/ZGxa8JVqv58XQX
 5/X1Z86hLSPxawqW2EAy4O+kR7dvd+ACTKg3zp2FAOxeL1fYIlYF23Fk8dTj0ZNVZPTaD
 JNjRozQV+1rESmD1fCjrx9s5S+NKaS92Soea2q3voCYxJcoL3GOX76+wfxa1aLvis/6m2
 kDGFg2n0w53hyNLBD9NGh5Ya28Ljhuhchn3+UVU/iiWuVfJNtvXMRTF+ZEIgxbikHOaAb
 dVnMg4fF9b47lFSPcCdkbRUPsQ3kmdaQKjewHOeKTNrDJClu/6n/xgzqx+Z822wlWvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791138687;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=fE4EGLtPru4CDYJY3RJ+YeBfBn4vDykozEn0otxu7/k=;
 b=RcdCAZ+Udlpv8L6tBpmeikwyJIIYrewhFwarDnixQDFLMM0ItK8wbSeWwQH0ij51V2YF
 4kSnOAS1pWruyTkhkR514fpvSG9HvkQUh7SOXjcdXnem47Pf/dgGgM8viN4EEOCaV9Ovd
 tjGuGKialdz67d9XrYGOMlS10NsxQ8xuZ2g+QczN5T3aJLLkjMp8/OxJcc+gwmyDzAcNd
 PB2sfaqarZh8tXCN4pKWyW0dCCUXcN4vS5y0MmZ/ft1qVaUc4laUArOQePrIhRWk/7mkN
 eeMdKV/1Da1xyfuT5ayWt3p/GKpIgQz5MXpsNiI1T1UsYC3HIiIY4ka+Bzt88caGaEQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Yd5sT0gg; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Yd5sT0gg
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C8B440049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791138684;
 bh=fE4EGLtPru4CDYJY3RJ+YeBfBn4vDykozEn0otxu7/k=;
 b=Yd5sT0gg4XO0WzqrPm7XZsZwUTovRWiJTWTfclyk3Exsb4bPr7oKw4ZjgSi+JWKUzNIc0fqVO
 Bu484XKG5xaov1IH9a9xDHcIFpRhGv9UqRR18LVBpvMgFAXJkxScM6oDmyQaTX8IMfqROAZwGy8
 T0aZX2vbRVYKT2lqNSA9ijhs3vwyW7KGGKByWTu5uALHbic08AwXZIqAnmukxm/LqVZ0HO0MrxC
 SYFgFAwUkoGAxAugyPTw/vlhLW8bN65AiDC0ezDmARyMIXs6aGOlU9UDx+QYa+xzeinrwlJxLjD
 LyesXEsfQ+570LnvTLlHh9sB6UIuwwoggULXHE5U3Dcg==
X-Forward-Email-ID: 6ac29b7b7fb3674e61ad06d5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c6ba727a-1c2f-43f3-96e1-f82be3ec5eda@kwiboo.se>
Date: Sun, 4 Oct 2026 20:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] board: rockchip: Add Xunlong Orange Pi 5 Pro
To: Peter Robinson <pbrobinson@gmail.com>, Quentin Schulz <u-boot@0leil.net>
Cc: Dennis Gilmore <dennis@ausil.us>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20261002031334.3285687-1-dennis@ausil.us>
 <20261002031334.3285687-6-dennis@ausil.us>
 <a2d13cd0-7704-4152-8b29-73328cdbad01@0leil.net>
 <CALeDE9OM7+EbN1FCSver2wg8H_JBrcVvJ10L0hGELd1q5d_wKw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CALeDE9OM7+EbN1FCSver2wg8H_JBrcVvJ10L0hGELd1q5d_wKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Peter and Quentin,

On 10/3/2026 11:05 AM, Peter Robinson wrote:
> Hi Quentin,
> 
>>> +CONFIG_USE_PREBOOT=y
>>> +CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
>>
>> I know Jonas has been pretty vocal against having PREBOOT set by default
>> as it drastically increases the boot time in all scenarios.

Correct, this is my main review remark of this series.

>> We don't
>> have many Rockchip boards that set this variable, do you really need it?
>> Shouldn't bootflow set this up properly when attempting to use
>> PCI/USB/NVMe storage to locate files?
> 
> I patch all of the Fedora builds to enable preboot so yes, I think we
> really do need it and it should be on all boards. Bootflow doesn't set
> this up by default, and if it does would it not increase boot time in
> similar ways?

To my knowledge there used to be an issue with efi_mgr being loaded too
early, before 'bootflow scan' had enumerated possible storage devices.

However this should have been solved in v2026.01 when efi_mgr got a new
priority and now is tested just before network devices are scanned. Was
this change not enough or is there some other reason to need storage
enumeration in PREBOOT?

U-Boot is primarily designed to lazy/on-demand load devices, so any use
of PREBOOT to circumvent this is sounds like a workaround for some
underlying bug/issue that should be tracked down and fixed.

> 
> Ultimately these sort of things are always a compromise, for the
> defaults what would most users prefer, a system that just works with
> whatever storage they use, or a boot that saves a few seconds. From a
> Fedora, and likely most other distros are similar, I would prefer a
> system that works as it means a *LOT* less support tickets/complaints.
> Users that care about a few extra seconds of boot likely are doing
> other custom things as part of the process and likely are changing
> other things in the build config anyway so disabling the storage they
> don't want to boot from likely isn't a big step.

Please enlighten me what issues the PREBOOT workaround fixes, so that a
proper fix can be worked on. And if we truly need a PREBOOT workaround I
expect that 'bootflow scan -G' or similar should be enough?

The issues I know of that PREBOOT have been used help solve are:
- EFI not finding all storage devices, should work since v2026.01?
- Custom boot-scripts not doing device enumeration themself.
- Use of VIDEO and USB_KEYBOARD to stop autoboot.

Are there some other use-cases/issue I do not know about?

Regards,
Jonas

> 
> Peter

