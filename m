Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A429CDE002
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 12:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B864E849BA;
	Fri, 26 Jun 2026 14:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=syss.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=syss.de header.i=@syss.de header.b="F4v5MOjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7EE8404D; Fri, 26 Jun 2026 14:28:06 +0200 (CEST)
Received: from mail01.syss.de (mail01.syss.de [185.142.186.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3008404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 14:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=syss.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Robin.Trost@syss.de
Message-ID: <193e3448-abfc-4954-a34a-2a2c9b227bdd@syss.de>
Date: Fri, 26 Jun 2026 14:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: SySS Responsible Disclosure Policy
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: <dario.binacchi@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 <andrew.goodbody@linaro.org>, <u-boot@lists.denx.de>
References: <6d1d17a4-d914-4136-a90a-0d9073bcf135@syss.de>
 <4428b405-ea06-4af4-a84d-095d4cbf4609@syss.de>
 <CAOf5uw=Ymi_L98crSKdzX12hWGTEohz1MVHchg8mgdoUH+_1=A@mail.gmail.com>
Content-Language: en-US
From: Robin Trost <Robin.Trost@syss.de>
Autocrypt: addr=Robin.Trost@syss.de; keydata=
 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
In-Reply-To: <CAOf5uw=Ymi_L98crSKdzX12hWGTEohz1MVHchg8mgdoUH+_1=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFpYWFhYWlleWV5aSFlRSDoHCgEGRjwaBxscKBsRGxtGDA1IWUhbXUgMCRoBB0YKAQYJCwsAASgJBQkaHQQJGwcEHRwBBwYbRgsHBUhYSFpIWVpIWVhGWVhZRllGWlhfSFBIWEhYSFxIWEhYSFhIWl5ICQYMGg0fRg8HBwwKBwwRKAQBBgkaB0YHGg9IWEhbXUgMCRoBB0YKAQYJCwsAASgJBQkaHQQJGwcEHRwBBwYbRgsHBUhYSFlQSBwaAQYBKAMHBhsdBAMHRgsHBUhYSFpYSB1FCgcHHCgEARscG0YMDQYQRgwNSFg=
X-FEAS-Client-IP: 10.101.1.207
X-FE-Policy-ID: 4:7:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=syss.de; s=syss-de-2105;
 c=relaxed/relaxed; 
 h=message-id:date:mime-version:subject:to:cc:references:from:content-type;
 bh=JIC0lEalO29UBjSnTi00EH6QHXhcpTvZJ4EQzk7BK7I=;
 b=F4v5MOjvRg6CZ4mgaqEwg278vulb4gwzrlAc3+laG08MfF/Z+qJzDhEAYUY/2NBMPI09VvzqGU0k
 /pV87L1SPjs9TUit9C0Jekln/m5uhvSMI4V8HA7C3UnlzNX/D0dRrtFAwzpFKkA6UVsz4DcpolAp
 4Vtdrr5SqYARtv1WFnJZ1cXWqaQHN9VEew43Ad7LNWaN8Qt9QLhw5yCvU4U0Vuhh6HJ5RtBs3fTe
 ErEOdcB/dC6Shbu/hG9IRJ/9Xwoo5ENnw418togm2Hx2/5RFQeXRtE219em9PkLbG+nJN2YLqLdH
 CpMUuVCmGDZJWCUnZj7SH3DYjpRLHv61lkagfQ==
X-Mailman-Approved-At: Fri, 26 Jun 2026 14:45:55 +0200
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

Hi Michael,

no problem. I just asked because I didn't get a response to the first 
mail and was wondering if it reached the right people.

Thank you for looking and if you have any questions regarding the issue, 
please let me know.

Kind regards,
Robin

On 6/26/26 14:03, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> I have long queue, I will take care of it, but coming out some down
> period. Please I will look in weekend,
> 
> I have already other patches to send
> 
> Michael
> 
> On Fri, Jun 26, 2026 at 12:02 PM Robin Trost <Robin.Trost@syss.de> wrote:
>>
>> Hi,
>>
>> any updates regarding the issue?
>>
>> Kind regards,
>> Robin
>>
>>
>> -------- Forwarded Message --------
>> Subject: Fwd: SySS Responsible Disclosure Policy
>> Date: Fri, 12 Jun 2026 22:47:10 +0200
>> From: Robin Trost <Robin.Trost@syss.de>
>> To: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
>> Tom Rini <trini@konsulko.com>, andrew.goodbody@linaro.org
>> CC: u-boot@lists.denx.de
>>
>> Hi all,
>>
>> during a recent assessment I identified a vulnerability in the OOB data
>> parsing of the NAND chip. As you are the maintainers regarding [1], I've
>> sent you the advisory advisory (SYSS-2026-038: Arbitrary OOB Heap Write)
>> including a "optional" fix and a reproducer script which illustrates
>> that the vulnerability can lead to arbitrary code execution in the sandbox.
>>
>> If you have further questions, please do not hesitate to contact me.
>>
>> Kind regards,
>> Robin
>>
>> [1] https://docs.u-boot.org/en/latest/develop/security.html
>>
>>
>> -------- Forwarded Message --------
>> Subject: SySS Responsible Disclosure Policy
>> Date: Wed, 10 Jun 2026 15:46:26 +0200
>> From: Robin Trost <Robin.Trost@syss.de>
>> To: u-boot@lists.denx.de <u-boot@lists.denx.de>
>> CC: trini@konsulko.com <trini@konsulko.com>, p_mailqueue_disclosure
>> <disclosure@syss.de>
>>
>> Hi all,
>>
>> The SySS GmbH deals with security issues in a responsible way. In the
>> form of a security advisory we report security vulnerabilities which are
>> not in products of our customers and which are not excluded from public
>> disclosure due to contractual agreements with vendors.
>>
>> The attached security advisories contain detailed information about the
>> found vulnerabilities that allows the vendor to reproduce and further
>> investigate the reported security issue. Vulnerabilities will be
>> disclosed to the public if a solution was published by the vendor or 45
>> days after the initial report by the SySS GmbH, regardless of the
>> vulnerability status, for example if there is a patch or workaround from
>> the affected vendor. In well-founded exceptional cases, this standard
>> procedure may not be followed and an alternative, adjusted publication
>> schedule will be negotiated with the vendor.
>>
>> The goal of our Responsible Disclosure Policy is, to weigh up the need
>> of the public to know of security vulnerabilities against the vendor’s
>> time to remedy all security issues effectively. The final publication
>> schedule will be based on the best interests of the community overall,
>> considering both positions. Before the responsible disclosure of a
>> security vulnerability, the SySS GmbH allows vendors the opportunity to
>> analyze reported security issues, to develop effective countermeasures,
>> and to test them thoroughly.
>>
>> If there are any further questions regarding the identified
>> vulnerabilities do not hesitate to contact me.
>>
>> Kind regards,
>> --
>> Robin Trost
>> Senior IT-Security Consultant
>> ______________________________________________________________
>>
>> SySS GmbH
>> Schaffhausenstraße 77, 72072 Tübingen, Germany
>> Tel: +49 (0)7071 - 40 78 56-6169
>> Mobil: +49 (0)151 - 42209330
>> E-Mail: Robin.Trost@syss.de
>> Conf. Calls: https://syss.zoom.us/my/robin.trost
>> Web: https://syss.de
>>
>> PGP-Fingerprint: 85FE 80E2 04F3 6177 C61A 4618 61DE F14F 698E 6EB3
>>
>> Geschäftsführer: Sebastian Schreiber
>> Registergericht: Amtsgericht Stuttgart / HRB 382420
>> Steuernummer: 86118 / 55809
> 
> 
> 

-- 
Robin Trost
Senior IT-Security Consultant
______________________________________________________________

SySS GmbH
Schaffhausenstraße 77, 72072 Tübingen, Germany
Tel: +49 (0)7071 - 40 78 56-6169
Mobil: +49 (0)151 - 42209330
E-Mail: Robin.Trost@syss.de
Conf. Calls: https://syss.zoom.us/my/robin.trost
Web: https://syss.de

PGP-Fingerprint: 85FE 80E2 04F3 6177 C61A 4618 61DE F14F 698E 6EB3

Geschäftsführer: Sebastian Schreiber
Registergericht: Amtsgericht Stuttgart / HRB 382420
Steuernummer: 86118 / 55809

