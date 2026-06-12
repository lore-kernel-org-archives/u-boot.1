Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B62CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4883984717;
	Fri, 12 Jun 2026 22:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=syss.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=syss.de header.i=@syss.de header.b="S1pCpNfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4662684878; Fri, 12 Jun 2026 22:47:16 +0200 (CEST)
Received: from mail01.syss.de (mail01.syss.de [185.142.186.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57388063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=syss.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Robin.Trost@syss.de
Content-Type: multipart/mixed; boundary="------------ZQx1TmcDskqNbDpSPqpWWk2Z"
Message-ID: <6d1d17a4-d914-4136-a90a-0d9073bcf135@syss.de>
Date: Fri, 12 Jun 2026 22:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: SySS Responsible Disclosure Policy
Content-Language: en-US
References: <a19a63a0-c654-4c71-88af-3b868da3deed@syss.de>
To: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>, Tom
 Rini <trini@konsulko.com>, <andrew.goodbody@linaro.org>
CC: <u-boot@lists.denx.de>
From: Robin Trost <Robin.Trost@syss.de>
Autocrypt: addr=Robin.Trost@syss.de; keydata=
 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
In-Reply-To: <a19a63a0-c654-4c71-88af-3b868da3deed@syss.de>
X-Forwarded-Message-Id: <a19a63a0-c654-4c71-88af-3b868da3deed@syss.de>
X-FE-Attachment-Name: SYSS-2026-038.zip
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFpYWFhYWlleWV5aSFlRSDoHCgEGRjwaBxscKBsRGxtGDA1IWUhbXUgMCRoBB0YKAQYJCwsAASgJBQkaHQQJGwcEHRwBBwYbRgsHBUhYSFpIWVpIWVhGWVhZRllGWlhfSFBIWEhYSFxIWEhYSFhIWl5ICQYMGg0fRg8HBwwKBwwRKAQBBgkaB0YHGg9IWEhbXUgMCRoBB0YKAQYJCwsAASgJBQkaHQQJGwcEHRwBBwYbRgsHBUhYSFlQSBwaAQYBKAMHBhsdBAMHRgsHBUhYSFpYSB1FCgcHHCgEARscG0YMDQYQRgwNSFg=
X-FEAS-Client-IP: 10.101.1.207
X-FE-Policy-ID: 4:7:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=syss.de; s=syss-de-2105;
 c=relaxed/relaxed; 
 h=content-type:message-id:date:mime-version:subject:references:to:cc:from;
 bh=7elkSIusR/thHnyPdpK47GewZkO5dFdL0ZiQLnEzPMs=;
 b=S1pCpNfdRoac4LFiY6+NO4kFvM1i/JcPqCK/I1TTVLrZchKIWPZ0OHJzHwzplD/7Sry1iwtPvLFN
 RQEjOvamRtFNnOvofObEBVz8Hcqs8Pj7nebHpGoVzljNnFTjQazfB+hyR+NWf1zpYpXbKdbf8jHY
 GOcbB7G96wj2ywHMLjMAngJycETTE5Ig9QaRFKm/V+Ojc9gghISLlDrH+zghAadrj1sL3OjrKdk8
 jyyhDvlT4E4rTnCYq/48Nw0KoK8LomE9BboQUVjn5taPbGxekKU94nuo6/4m/b0uSySIsNFa+rWq
 Jcx0YObwchW7nXt+Jz3u+uwiH0ZxvbK46UON6g==
X-Mailman-Approved-At: Fri, 12 Jun 2026 22:49:56 +0200
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

--------------ZQx1TmcDskqNbDpSPqpWWk2Z
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

during a recent assessment I identified a vulnerability in the OOB data 
parsing of the NAND chip. As you are the maintainers regarding [1], I've 
sent you the advisory advisory (SYSS-2026-038: Arbitrary OOB Heap Write) 
including a "optional" fix and a reproducer script which illustrates 
that the vulnerability can lead to arbitrary code execution in the sandbox.

If you have further questions, please do not hesitate to contact me.

Kind regards,
Robin

[1] https://docs.u-boot.org/en/latest/develop/security.html


-------- Forwarded Message --------
Subject: SySS Responsible Disclosure Policy
Date: Wed, 10 Jun 2026 15:46:26 +0200
From: Robin Trost <Robin.Trost@syss.de>
To: u-boot@lists.denx.de <u-boot@lists.denx.de>
CC: trini@konsulko.com <trini@konsulko.com>, p_mailqueue_disclosure 
<disclosure@syss.de>

Hi all,

The SySS GmbH deals with security issues in a responsible way. In the 
form of a security advisory we report security vulnerabilities which are 
not in products of our customers and which are not excluded from public 
disclosure due to contractual agreements with vendors.

The attached security advisories contain detailed information about the 
found vulnerabilities that allows the vendor to reproduce and further 
investigate the reported security issue. Vulnerabilities will be 
disclosed to the public if a solution was published by the vendor or 45 
days after the initial report by the SySS GmbH, regardless of the 
vulnerability status, for example if there is a patch or workaround from 
the affected vendor. In well-founded exceptional cases, this standard 
procedure may not be followed and an alternative, adjusted publication 
schedule will be negotiated with the vendor.

The goal of our Responsible Disclosure Policy is, to weigh up the need 
of the public to know of security vulnerabilities against the vendor’s 
time to remedy all security issues effectively. The final publication 
schedule will be based on the best interests of the community overall, 
considering both positions. Before the responsible disclosure of a 
security vulnerability, the SySS GmbH allows vendors the opportunity to 
analyze reported security issues, to develop effective countermeasures, 
and to test them thoroughly.

If there are any further questions regarding the identified 
vulnerabilities do not hesitate to contact me.

Kind regards,
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

--------------ZQx1TmcDskqNbDpSPqpWWk2Z
Content-Type: application/zip; name="SYSS-2026-038.zip"
Content-Disposition: attachment; filename="SYSS-2026-038.zip"
Content-Transfer-Encoding: base64

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
AAQAewEAADgYAAAAAA==

--------------ZQx1TmcDskqNbDpSPqpWWk2Z--
