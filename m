Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575BE60A2608
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0Rn9x/61;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2gQFyIk7;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=T1OcXzzl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADBA981119;
	Tue, 17 Nov 2026 13:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7R38dMo9uRm; Tue, 17 Nov 2026 13:07:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6660810D3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794920854;
	b=SInv4jPSZyj1/CtvES7zWkiy5s24pBYuDmB5nDEePOYw7polkPAmE6mAqm76ESM319S+
	 jgQsGNb/m7Xq7Adkl56f30ly0l9QvIL8EfXantbVB4vabSBasr4yalQvKItyMKaIuJ43P
	 ohWmXkKyXGZlIRs0WGgHxgPG7jsXfrbsUefmcfsarwlPeQiHBsADnnlSlMhWupftkto+R
	 CUlCdZaKVA7bi7/Qr+rOBrzw3arANuSzbvHIwwhCqCkKw6ryiAFcmbLhtCumG5yqFxPOD
	 MElIWVMv0O/qRaT5VM3w+NTN4PTTJlcfvhS8lnfjiu+5KfGwtLCVRhngvN3tQIWalvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794920854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Date:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PC3/gbXKnaBKVLWA7nkhikC7c/ncv1cKJRsnywocWgM=;
	b=YaYBfsyKfnWykEBLqWqqRkb3ax2sOpNBFcMgUnzuY27NJ9xxL87ycSebc6P3sOW7HRJH
	 ZKcrvgUU247i3ABqq8I52sQOonNsZ/dvlDvG2mNIXYqD34By7nzVBk2eZaTpSNbbrIwAR
	 pUORJ3Y97RFbMg7Xd2gWVHgnMwSVF085S50rhERmUASwpjJHUBJe3yT+itT9MRq6MYpNq
	 PWZqHF4BQhLxnwKHSyZ86gHUWKuc+jszMMhGIaLEe6SZThtEy/nr5e4KewQro/1Z+tIJu
	 4xUolC3VA8v29TOi/gBMlWj1nJNoyC6YtcdnOVJv24/MLh2dmYMIm93wzJK9Q1gSeFA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794920853;
	bh=PC3/gbXKnaBKVLWA7nkhikC7c/ncv1cKJRsnywocWgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Rn9x/61Avp07S9hGkis5ttD4uroYhWpReAq1PK0j1B2j1t5gfIlDUA8+CRqONZRc
	 6rCxGngdMm4BkEzfN1LG3ucBub+YyCj6BBVd97Q2kYEsoRimnz8g7qj/2Wf63Sev3z
	 bO0f6O/gj5I+JFHRHrwzymg77vWyPchG45oi6/ba/nx0GIf1pRxmS98MiocnH4VIa9
	 sevsC+hv7qXSG5ZlWrr1c6ki3T4HPwqcgI7BAtub/8zNvc+jxNP8CGs0OtK8dU8s0M
	 Ej8/M9EtgHq3yeWTJVjG5INWnV87OwGuYuts39y19tLX3670qDZbb729oQc578lENS
	 XB0UIlEcOGpKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6660810D3;
	Tue, 17 Nov 2026 13:07:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 47D421A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D98860872
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7U_2W8WaZbLJ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0CA2360863
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=193.142.43.55
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=gregor.herburger@linutronix.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2gQFyIk7; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=T1OcXzzl
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CA2360863
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:07:30 +0000 (UTC)
Date: Tue, 17 Nov 2026 14:07:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1794920848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PC3/gbXKnaBKVLWA7nkhikC7c/ncv1cKJRsnywocWgM=;
 b=2gQFyIk7AICJGxYrv84AlChADYXox552RbtndaTmP58KhCqRoLPAHlJiN16qgZ5bwJ+onc
 PPBsEEiQUGVyzC0lrrP8qKL0tdh4dBLJjfnqt7CMgl7OkYXIuPmNpyn0y5cuCev2OxyTZV
 KPhkeGGfo0go/7BPQIDohybnACp4eN7eIgptpmFLqT+lggGaUNLDkoHnIzU2hLtkf/YjhP
 hJL8L3mmTKKBO37kfOoLZmE9R+dHK+KsWUo9H+V+bXd1sGuD+Io+wwu9xXuiDtqzgSimKx
 1XJ98+sunYsBnbzMRHusWkA0IPRtwNGRrQj93WEv6dgQ1aWYFSeEyBNU2zvWeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1794920848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PC3/gbXKnaBKVLWA7nkhikC7c/ncv1cKJRsnywocWgM=;
 b=T1OcXzzlkViuyD/5evPXlZnPqnavJLn+HSOLScpjHZsefqB8tqO5muLqPzjMmEaRw8YnNT
 lvVFbmLuz1MwplCA==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Matthias Brugger <mbrugger@suse.com>, 
 Tom Rini <trini@konsulko.com>,
 Filip =?utf-8?Q?Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH RESEND v4 0/2] rpi: copy /chosen/bootloader node with
 properties and set boot_partition
Message-ID: <3urp4kepg2inxxx5n6fgqfbs7nzlndgojr55idsjgalojpar6t@an4npiosmgdp>
References: <20261117-tryboot2-v4-0-d59fa66de789@linutronix.de>
 <CALeDE9Pay-8Szx_kxFBx5de08BNOZrxvELtthjECij7UvuUr-w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALeDE9Pay-8Szx_kxFBx5de08BNOZrxvELtthjECij7UvuUr-w@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,
On Tue, Nov 17, 2026 at 12:57:43PM +0000, Peter Robinson wrote:
> Gregor,
> 
> I have your series in patchwork, doing multiple "resends" doesn't put it
> any higher in my review and testing queue. I am sorry, it's on my list, I
> am in the process of getting to it but unless there's any changes needed
> this doesn't make any difference.
Sorry for the noise. This iteration of this series is around since August so I
thought resending it would be appropriate. As I know now that it is in your
queue I will not send any updates unless changes are needed.

Best regards
-- 
Gregor Herburger
Linutronix GmbH | Bahnhofstrasse 3 | D-88690 Uhldingen-Mühlhofen
Phone: +49 7556 25 999 35; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy 
can be found here): https://linutronix.de/legal/data-protection.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-Mühlhofen | 
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700 
806 | Geschäftsführer (Managing Directors): Dr. Wilfried Wessner, 
Katharina Kopp, Alexander Gieringer
