Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B7BCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34E5F40623;
	Mon,  5 Oct 2026 08:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fNlhjHfkebmN; Mon,  5 Oct 2026 08:24:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ACA7540561
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791188674;
	b=pSkJMvuNHPWhsLxoUfcmrFWQZOA8LDzRKy+tqr6a7EDAwjSDlbzMO/ODojGMXmK81eWQ
	 y3KD+V6mIgQ/tDXyJ2bwiRMimwTjxrIAKA+A3XDZAe+IuDIKUiqmyUqvqNNL7LfegWtuw
	 RbwSzQT56PSQ4WrXrU9D0/o/QxRhg4tDjdV+8Om9bPWQV9gq+AMeTKSnGCBHCaCxfbtFu
	 82ghbjTkmyAqdXjRGWmg/kQqEc59R16e2sSIJUZ14igdLouGlJLcyzcmUaIOcWDylBxCo
	 9OfAQIEmRI8PRk0ErmNkCDNgoBLAn+Dx946Wa3gIaMJ0uiq0r4iW61M9JjOp/BICRTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791188674;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3Gcn45F8iKqHW3XdpRB9CELj4iTJOUmZdi8MDN47XlU=;
	b=sqxOXhQSySuYIt7bkIVCZFdYWa0rCrxNNZtbnwCAtnw1yIdm8Zriw96HRnI6rl5UHhYa
	 15lJbFRpJnt/B2Mwt7bW57wyFDNSHoDf5guQbTACJV8QhkrruvaWlxmaIqARIzlY5k5iL
	 3j6/2CK9j+QI/nBBvLzJ8cn6Ycd1XPM++hRTHn67vo9BIQFDIhU3JELMe5WHkf5fvNrVj
	 7vgaTqjW/d+DGBYdSfRxQkVO582FYlts8s2vbYIyZBtk2NzVmhc694Zr8fNhx8pm/d1+a
	 Y3AeeLxjzXs8qMSCmvq3Lc9HV6SoFPjBkH/x9KAI/nUOQYvVJinXuJIUsV1C2AIKHHQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791188674;
	bh=3Gcn45F8iKqHW3XdpRB9CELj4iTJOUmZdi8MDN47XlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mEC+QHYR4IUeTHsMMtjOevI1x4guwdx68S5BkMyuJh2cgInd83cwGUv3bprfd3TAF
	 GREosgPSHLjk9X9rXvdy/cLmNOU+AZapme6ebw2oNzx8SoWrEETtBF+fMnFm8sJw5e
	 4ig5WliENUhTz7t4+YOsH9Nw2T0Pw/jPygIemo5JFy1vdDwl4KDAQAvP5ns2owJvo2
	 U0k6dk2fWXDFSmwaqzLC3NyH6e2M+VVxHkafaKUzMJdVimWTDjRbB1Gh73daq9ZPx6
	 rrC1iYZr23sqG2V6XiKHZWSIbmB5USUZXQJfcQgOwe6BTFWJny7Oa+D6pyrd5/Xi4d
	 xGIpMD7T1fIIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACA7540561;
	Mon,  5 Oct 2026 08:24:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B10A32F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 688CA80C74
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:21:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_yaJPdfxYQ1 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 08:21:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 88BA880C68
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791188474;
 b=ssibPbhBFXemIZb+v4fLbX2fWOpN7Hh4uyIAQirO9l3G09I16s03n2hHFimYkR9FwHOf
 JzFC4wsrF65VFIdKTN7WdrLpSB9Nft244oiKpmwsfYfG4rwyWUHnyZrmh6wAmA2w6wVRv
 7rYIjPG1bOgbYe1MgfdDtZsxxNddaAWfdSvwepcDY+BBOisxI7QM/PpeDAqnobjyAOZvK
 YgprTAbkyBtvaHWfmWiUoew8w0Jj7OxZHzNrh2U9aWzhhI4pKw7odpCzx3eaEOemQnyar
 XcyCKUaxNn4637HhSRILHopm3rnx763JVvwdJupV5ZqBBUqcTBQ0CL7mVnqZT9HCWdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791188474;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=3Gcn45F8iKqHW3XdpRB9CELj4iTJOUmZdi8MDN47XlU=;
 b=rMqgiqBqFnUNR38e3122G4maiuW8L6Epa70mvpKyDOonTA3Vn7itXVyQy/z+UKHCMkSn
 nlyHdMmqXLk0OdH17EOpQFRS2oRQlD1T/266loGF48cPpAaNsedEvEdjYhicxmLTfwZNw
 SFrxoMSdGfnB/mq3Az+YMRa1y1UFJ+Tv59gfplLJ0qytjYeCXbnDhFopw6Q0TA8wAIxT0
 zEFC9VToJEL1xjgNTKjY3MMkiJve13Pp656Z6GIAW0xJirA+hOQoSWL5d+Kh5gLkMeNpL
 U/lrI4o0IP4Y9PgQe3pVgw4Cl0dnZBO19D8vk2uEiUAywt6SEXHjnnvttaSZiGoYm+w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=oxC3fdwM; 
 arc=none smtp.remote-ip=185.136.65.226
X-Greylist: delayed 65 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 05 Oct 2026 08:21:11 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=oxC3fdwM
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.226;
 helo=mta-65-226.siemens.flowmailer.net;
 envelope-from=fm-664519-20261005082002bf1c29aa08000207c8-eaqdx3@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88BA880C68
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:21:11 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20261005082002bf1c29aa08000207c8
 for <u-boot@lists.u-boot-project.org>;
 Mon, 05 Oct 2026 10:20:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3Gcn45F8iKqHW3XdpRB9CELj4iTJOUmZdi8MDN47XlU=;
 b=oxC3fdwMh7X2CWc9Du7un/kiJK62r2eoZo5WtGSd/13fvpRkVgXYmGTHMiEc2EBQUThEt3
 fL1fiqHu/nkflFBXu1Lu+mcyaSzUOTdROE0cP+J7XrfFYdvo+j7zaSLrCQGTM9zIQamCHeSW
 Kh3cXaUopl+taWfDsCUDUvuGvQcpJFIKlsameDHgOLfKv6XiDvvPXm7raKiqDJLukRt5auMq
 pV/rFMKCwWvBUZHfLfuCMjc+QZ3q/EsFcBWWZ0XiVfQ6j/Ag5viH5vPs2vaDMmcplRn/CX1N
 ZAq5TtIQumdZtn0g/bdHn4YCP9HW7w6JLo2hMmY/QTnKHxvv2ZNzdQyg==;
From: Michael Haener <michael.haener@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
Date: Mon,  5 Oct 2026 10:20:01 +0200
Message-Id: <20261005082001.52271-1-michael.haener@siemens.com>
In-Reply-To: <CAC_iWjJpDTRXWjQk2mfmSxens=1-J2Gbba79MUwVHu440uRUXA@mail.gmail.com>
References: <CAC_iWjJpDTRXWjQk2mfmSxens=1-J2Gbba79MUwVHu440uRUXA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
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

Hi Ilias,

On Mon, 5 Oct 2026 at 10:48, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> Do you have a real world use case where an OS wants a TPM with zero
> preboot measurements?

Yes. On some of our i.MX8 based devices Linux uses the TPM for disk
encryption and for device certificates. Platform integrity is
established by other means, so nothing is sealed against PCRs and there
are no preboot measurements. Disabling the TPM in the DT is therefore
not an option for us, as Linux needs it.

What I am really after is that Linux finds the TPM in the same state on
all our products, whichever SoC they use and whether or not they use
measurements, as it does on UEFI platforms where the firmware always
starts the TPM. Today that depends on the boot path in U-Boot: EFI or
MEASURED_BOOT start it, a plain booti/bootm does not, and Linux then
logs "A TPM error (256) occurred attempting the self test" and starts
it itself.

How U-Boot does that, in probe or from an event, is less important to
me. I am happy to implement whichever you prefer for v2.

Regards,
Michael
