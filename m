Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43DDCD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C9584894;
	Fri, 12 Jun 2026 14:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=syss.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=syss.de header.i=@syss.de header.b="i/6HBKg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5319B839A8; Fri, 12 Jun 2026 08:32:58 +0200 (CEST)
Received: from mail01.syss.de (mail01.syss.de [185.142.186.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1131C8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 08:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=syss.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Robin.Trost@syss.de
Message-ID: <a1cc399a-b31f-4c91-8310-8d61e7985732@syss.de>
Date: Fri, 12 Jun 2026 08:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: SySS Responsible Disclosure Policy - U-Boot vulnerabilities
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <a19a63a0-c654-4c71-88af-3b868da3deed@syss.de>
 <e46d45fe-a917-4252-864e-deb431b88270@syss.de>
 <20260611140508.GJ382693@bill-the-cat>
Content-Language: en-US
From: Robin Trost <Robin.Trost@syss.de>
Autocrypt: addr=Robin.Trost@syss.de; keydata=
 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
In-Reply-To: <20260611140508.GJ382693@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFpYWFhYWlleWV5aSFlRSDoHCgEGRjwaBxscKBsRGxtGDA1IWUhZUEgcGgEGASgDBwYbHQQDB0YLBwVIWEhaSFlaSFlYRllYWUZZRlpYX0hQSFhIWEhaSFhIWEhYSFlQSBwaAQYBKAMHBhsdBAMHRgsHBUhYSFpYSB1FCgcHHCgEARscG0YMDQYQRgwNSFg=
X-FEAS-Client-IP: 10.101.1.207
X-FE-Policy-ID: 4:7:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=syss.de; s=syss-de-2105;
 c=relaxed/relaxed; 
 h=message-id:date:mime-version:subject:to:cc:references:from:content-type;
 bh=clIAKfovSI2KnzsSlGs8aFTKrCSDgn6m0OnmYe5Kdy0=;
 b=i/6HBKg682bnRT19ezX6QpGCCpSdYNC1V14MUDbd0M1d5Pr6XzfdhwJYVzE37p3JJ1M6MU6h4KzW
 2aEUbkrq2LsmvLzRHF+1mqlDYmihJ/e6mbvUd72IDNtsfJrbS59BWs8vNoLj6rlzL5vMFj+fqgrO
 gJqk4Xttn+EF/DAFUP06zIU1Ngixq68UtP0v3TWVb455dO59iMdxgeJpzouNkS4FrquHfTk7Hmc9
 B7m7yOwHyIV3rSNO1A0y0JZ18wCz87jcNW2Cg1vdruAkgz+FN9ZuNS1sjVRdiikHD32EAjERkVWW
 cLTYJuwPbRbOSgMk3xNbCqjQQUqNTSwQnyYaOQ==
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

Hi Tom,

thank you for the reply. I will forward each advisory to the associated 
maintainer.

Kind regards,
Robin

On 6/11/26 16:05, Tom Rini wrote:
> On Thu, Jun 11, 2026 at 08:33:49AM +0200, Robin Trost wrote:
> 
>> Hi Tom,
>>
>> I've just seen that my mail regarding some vulnerabilities I identified
>> within u-boot was rejected from your mail provider.
>>
>> Therefore I just forwarded you the mail (without the advisories attached).
>> The identified vulnerabilities are:
>>
>> - SYSS-2026-038: Arbitrary OOB Heap Write (NAND)
>> - SYSS-2026-039: Arbitrary OOB Heap Write / Integer Underflow (RSA Public
>> Key Parsing)
>> - SYSS-2026-040: Arbitrary OOB Heap Write (Ext4)
>> - SYSS-2026-041: Arbitrary OOB Heap Read (Ext4)
>>
>> If you would like to have further information (or the attached advisories
>> files, including reproducer scripts), let me know.
> 
> Hi, please see https://docs.u-boot.org/en/latest/develop/security.html
> and
> https://docs.u-boot-project.org/en/latest/develop/sending_patches.html,
> and so please start separate emails to the list, and CC the relevant
> maintainers for each, in order to make sure the community is aware of
> them and that if you're unable to work on the issues as well someone
> else can. Thanks!
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

