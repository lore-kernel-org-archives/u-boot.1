Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FD606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jRw3ilUa;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ktfmwyKk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50A6B4057A;
	Tue, 27 Oct 2026 00:47:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vh-BhsB-ofVt; Tue, 27 Oct 2026 00:47:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9FFC94056C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793062032;
	b=eFfMJ2fWyBr9a9Mt0AUYYgX7cwaVPIbSx4lCQNn99HMFAivVrMym+nAmFyY8nvEpT8MZ
	 lqaD77JLGzO8IMXjlToSgfvtT7Sx+vp0Hz4feHtL5p12qmoBYYpFB8to4yqQryiUf1i6P
	 0BvIvJNJuSmSL/x0eanAJMWmnynhetTeLQDdD1RFioBZnNgxr3MA2/kn5O3TGPc50ytto
	 58IkJ5XQrT1fTfZk/LQZ3brwnxWr9n39VOPxAWr1aU8A9czVLisBHwm023OqBTz9zEPnu
	 3AKCn67U21sOSo7AUcqwwusJf30ZIWEypvufO2OQ9vO9qdBEUJOOvu29htGo8cVIetA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793062032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=djSCGN25zrysD2YJ9tlZGVPz8HQ5smGo3bpna3yq+vI=;
	b=fPdHQ+JqKxQ7KtIIs1BqKPsx/h9NEBpqpIwFjDphiaIfbpPMDj/NT+c8/lU0aqkyicPn
	 eVY6/AR4MfABydBpLWr3fjZoRRe4cklxHdWfjuLV+BuI0JPwQTVlSGroXSrsBPhGG3iUf
	 diEpHYonCd8XL93R6QLPYljzufkKkoJreOLSLb+eHqFVrGRZdec92skr/2oOVwvbAQQCX
	 OF7hG4urzi0qbtolTxu+SY9v31OMYtd2GqA+v8+lnnqHvoCv4lhQSLcbCxeelxdjiWNd5
	 p2j6Dq2V3A7TEDSvnuRgdCJY9nWl0t9HwEObXTArVbDBDz6AuPVO1eLs1lkLbovTHRg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793062032;
	bh=djSCGN25zrysD2YJ9tlZGVPz8HQ5smGo3bpna3yq+vI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jRw3ilUazbWejj+XWUS7WkNZO5ftgpgIw7CkGw8h+fbAO3JP/GgyM7tVZYYOpzYOR
	 Sfcj7Rc9Gcroh1gi7LCNhc78uxZ58u7oO+Mg0Sn2sxjBww+Qaxe67HXWo71cL2we+D
	 H/o+WwvCdlPt0mSOccf1uQksp4lcWX/f0di7dyXGh9Fn2MIJXnZMZYa6+MM0RdIkCM
	 UVBTM78BDuDaf7QNVenawrAK3yHIX5xCWYxrNMptCW7ATOlQDOFbFIskSZxvW5PDxz
	 rQrXsur5TtgI+Ovuh/usNgZiLQNDHZsr3njjxGHDsONAE4eX0Xz0rGQMYbUZpXUKZY
	 ffwu7xkEjIrxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FFC94056C;
	Tue, 27 Oct 2026 00:47:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 171FE2F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08FA880B09
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:47:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9Jf-Ukdo8VB for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 00:47:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8FCCC80AC5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793062029;
 b=HmU63RUaUoBwhSnKHDQIh4ZTaLshFxOEj+qc3Kz2tURJm53J2yHY6v5LYYjtF2VQo9TS
 XacID56xpZ++PR4+Xf5+syRQLLpkP2tUSxBXoBsDlMwcPezWLPrrQVuPNlwc2FhK9xdjm
 +Bw8kfmpSolLaoQxULBiUL0Dz73FSpIjQrxVQ8MHgbY1uyIVYK5I8zIQQRvU1y9f9ORzo
 GPHY7dIP3C612FakvxHbYN5seMZ56v3aM1oriK0AhqnXm5+tQ5vjyqsM0MGcUC+MA373b
 S53vsFBYSDpqlNUzE8mRKES02evYAuxFr1ELqA3Otg18RIDHjuNhz+k6oGNU8MnmVAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793062029;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=djSCGN25zrysD2YJ9tlZGVPz8HQ5smGo3bpna3yq+vI=;
 b=cJG3E2nLfkUbHdnTF6f7YqX6/J2EEXuFhcQ+rnfGK0vkJXy+jMjHzKltKBaStm+uD4fi
 2/pnupRhjx9BhSTE8qN9smJVuy5sVRCexUC8MEvfHJSs3loV6D8AvmzdCqdCTWj3BDNki
 kop6IpBkhfQRIvsgZGLSPt8Bxmvm8AxjaqgDo1kXRBw78V8gK/J4vM7TtaA+CTCk663od
 R7hVLzfGx/gS4rbpq9YHlXtGYDk9IQiL/R4C2TwIwU0dHX0s16KsJ3IuBKxi2zYGUzcB9
 QC1nEA0HLn+c0SMSAppjJ3uXocxavzbPFYC9JITEcx6yvbuCcb7jjphegVGpfkFo+pw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ktfmwyKk; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ktfmwyKk
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FCCC80AC5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:47:08 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jDBf02WSCzMlbw;
 Tue, 27 Oct 2026 01:47:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793062024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djSCGN25zrysD2YJ9tlZGVPz8HQ5smGo3bpna3yq+vI=;
 b=ktfmwyKkLt/nX99Pe6iYcaAhE9v5zbQyPRjkADyK6C9XddsI48tOiCO0ocpfSGw5385GBZ
 UrgB1kUSVdFEc0FB5WDQoQhz+6ssy9PtX9nEeUQDcoJPuHPN9cfzHDeDIxIy9Sr+uP300x
 OLhtVcGRMumU0/Vp7hmL/DCAprPCOLEU0sZdBdwlnWzhDuvQX5HZB/K+m2caSrUVJphrFI
 LxS5Gtg9XO3fHmLoJbGh5jYevus/b/6zg2BS8z0Pla2vpqBWtmfxd5sJI+7Bt2XbDbBnKS
 t5kK/4EgjxzrGvagxj3N+vYe377DmgchU32kP/fLXAjcIVsiOy4pp+/o+bFTVg==
Message-ID: <67a6e9cf-8ead-4efa-b943-68c856b307f4@mailbox.org>
Date: Tue, 27 Oct 2026 01:47:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: lwip: Make timeout configurable outside of TFTP
 loop
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
 <CADvTj4owSzHUg2xMqqw3uW_XFKbFXjN3bU48COrtxxgVzXaH_w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CADvTj4owSzHUg2xMqqw3uW_XFKbFXjN3bU48COrtxxgVzXaH_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9c905befd8887909fc3
X-MBO-RS-META: z88bwz34cjrzw5suympyjqjr4nxwttek
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 12:59 AM, James Hilliard wrote:
> On Mon, Oct 26, 2026 at 3:28 PM Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Make timeout configurable outside of the TFTP loop invocation, and store
>> the timeout in TFTP context. This is a preparatory patch for porting of
>> the DFU TFTP to LwIP, which requires a different timeout than the LwIP
>> default one.
> 
> There seems to be substantial overlap between this series and one I
> recently sent, maybe take a look?:
> https://lore.kernel.org/all/20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com/
That seems to be quite intrusive, is all that necessary to get the DFU 
TFTP working with LWIP ?

Also, are all the LWIP changes being upstreamed back into LWIP or are we 
starting to grow U-Boot specific LWIP fork that would be hard to sync 
back with upstream LWIP ?
