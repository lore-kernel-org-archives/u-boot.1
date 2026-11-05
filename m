Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8F606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JEMHowie;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QTGOMSyy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED94C6085B;
	Thu,  5 Nov 2026 18:52:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GyOiuQhh7bhG; Thu,  5 Nov 2026 18:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 37CDA60884
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793904721;
	b=V0khx2bgHK/90ia27mnuAi7ANLgdqLYg4+Jzl9zdD2IxXdbgiOjIB+Ams2pKImoplfb5
	 /Wb3QjVSYugxvLfZjeFcuCTleZTTJAw2rpKT3uPCtkHVLxBF04MfH2RJHdv9cBS5RK5gU
	 CEMWCbPDKG8e0sKFcs8Y23cHzA+9nQohIFFavLEoueHQ1kPULLYZp0DkhLZHJdbjr5pNK
	 Fby0yaZzpliwVOmOm1iv6aOBMTxKBvtYJ4x5RX5smdht+2bP7LyFecXX8iPxAWiIYnXGn
	 ZpQoM/iKzYFgtTA/92R3OeyEXQSN/DtseGT0j83AZomi9KVzTz+L3jRceQQ5dJS4+FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793904721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pz2qpse45k4CQYAjHdh1r7Avi9XBY+bV1ryUVrt4GzQ=;
	b=G33L9E8Gn1Xo+kopKvuYKWG/2FSu2M85tVPTdj/bArBVFYEmIV4+iGFEY0lFITC2yqOB
	 9fTgK2xHDjEG2pjtpySRETJzbqK/5zAh3x5SrZu9ZRRujtfyT+SbmedWmokJ6sU+ocDKJ
	 YCz6xXKCvdQcyy0dimZ9fV1tnvoHQewAgKAZiolWLKb7eJZygC2wYW2f2qTcLVXUAYAI3
	 AkZcCqaR4wVcx0kAkgo0xxPhVb6RJkcflZJUCHzHV84fIhT/jOmmwXyRY5QccnqDHaOcK
	 hXYXCIXm76I1wevfTcOnRRjqL8eK11zyEaNCn6XbVyiCMtc3h3ggU9k/vO7zjfrBG6Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793904721;
	bh=pz2qpse45k4CQYAjHdh1r7Avi9XBY+bV1ryUVrt4GzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JEMHowieVfQZNqC9+BvmY97gDCiCqpKWF2wxdgwpm8oFNWs72oNTfYPZyojIv0Jli
	 QbY/umTXy2a8V9c3Pz2q7uEg1ROEQ7YEEpRdCNVPBqaplXwYCIDTuozaU9rRayTuy1
	 HgmhAgoWE/HBWLEZDfYVNjqBcFvSRhvpLeI89nJ5X6+eLx79USdq8yoFHrqLgNtGkP
	 +7lQGbAP7Zva4DQJsHza4YdDH/jTZI8YxGNBG/3ZG0tADfYWCdawUjsJDM3+3LhY1W
	 VmAO3q9K75iYUeONUrqGGt2dNBLof1zf/TpD0FD6Bz/Ag7InXWoOIxnnHz9pTrTSw5
	 sAF4oI7kMXlDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37CDA60884;
	Thu,  5 Nov 2026 18:52:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E18352B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44CAB400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:51:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZzxkYVhxzEf4 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:51:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3A98140012
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=QTGOMSyy
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A98140012
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:51:57 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c4ceaee6770so332026366b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793904716; x=1794509516;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pz2qpse45k4CQYAjHdh1r7Avi9XBY+bV1ryUVrt4GzQ=;
 b=QTGOMSyyyfCtHS72FpUbt1nDOWTJJrmfvxUwEi5yCKoeoZ80wCQwGISsBe/QDHDjHk
 DK/vwo8SVcRg6qyqJxuX13QTT4gk5sIMskGsn+JIwOZBNDiPVe7rtqeF3OC1aQKBlb4S
 63T7qbWXghrpxBRiaHgqWxTKTmWAZjOPxBQAPc1ZxHGC1xghbWvllpFwMHBKWESeoeZF
 7a2XfNWcNaGPBFwFfBUpJs/vs1ErExbB1oaHufPOUCIGU8YsTfUsULUfm3UDFPa8jF0x
 CLaFJQEx7O4KD6zLWqgJQhdc1Maubc2JJlT5G9m3eQWm4zKG5P0q5Fz41k0Azm/f46be
 lsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793904716; x=1794509516;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pz2qpse45k4CQYAjHdh1r7Avi9XBY+bV1ryUVrt4GzQ=;
 b=CHJseBDFI4STcKGLTYzpkw+x1SdJhkTLx0SKXwAnmjN5lFrHrBrpG2bar1nUi3gh/h
 3PEFDQMXE3XQZZjqYArJ1eP7Y+7qJp0JGlqDT52ouhapAQeAHVXsmVHKG1nyP3duXaoP
 tGBeVBgTLrIIGYFInwy9AgRKvZ4ASEOBSu4eYo4rNcMa+krqU0oYjuFRck4RH/uvyDxa
 778Y9r9zl/AXr5HUmHeKIsz7dHIl/r4ZdrYRhb/afbzdEgSX0ILcHMgH4WPCwzhE7Dkf
 8e6+t7+CgyGIOAHR2JAGhedhoTJxP63oTF2I7WzN+pL8RrHL8iF/a0ICC3mTpX29EnoO
 lktA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5P0+ByO0f/rpCJ5jt1KUfuOuE/8/kSZZzzXXmA20Es/O348sH20XH5Oc440W5kSQkoHAXANA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8IPQxqkQV45tGr6BH96PKvFADFDHVjHmS6NFDzhG4faBBYyrIr
 qp7D5xCYmb/EGX82ohUXYC4H/YJWNk1srCHrAnKC+3sde6oXngG8J7yuj+Y4TY/L8XgvoriHOdM
 3KjlcmJJNFqANavNe/AFC8WGSehSdS+M=
X-Gm-Gg: AYBFou1yc5uJUGp4tVuP3tIVK3s5JAbObytSZ5Iig9AxfMyWvd20K/tgRHRIdNf6dYt
 Ezk1VhF4zSxop77UQPRb6A871pYEdDRH1XwUNWJK5VT5/XyhoXgZkwZClAW+c4LedZpVmtayriM
 sPGOoLTCRBMmMg21nOZW5Uo5zkbjwaSGc2syoJWIN1RJ+9LHyHGPx9EYdZxlGbX2G+/t2hi/OKt
 2ROmNRRYQan7ZTkkNe1Bl6hcgsQizEX2WWH6lidxHqmynP3AOXIbAKUJ9fYUTgn0DnYwyp0z5MN
 5XwPhtp0tQ8osIgA2uy5ox/SX7vl6AUsed/ncZNY2fJ33DCRVicnpx9L5ZUAIb2DAR05tIlLitc
 iuOD8fZ+W6J57cjb2bTY6JRkkNUXpvUWIJRMsXg==
X-Received: by 2002:a17:906:2744:b0:c49:c76f:dad3 with SMTP id
 a640c23a62f3a-c4d354d2c02mr18100266b.34.1793904715735; Thu, 05 Nov 2026
 10:51:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
In-Reply-To: <20261105144209.GL1164024@bill-the-cat>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 5 Nov 2026 19:51:44 +0100
X-Gm-Features: AclHuK9e6njhhCy8e-UFOLsgaEFRcnMh6F2PpI_eeN_7vm2uhszO9ZpUTzgx7J8
Message-ID: <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Il giorno gio 5 nov 2026 alle ore 15:42 Tom Rini <trini@konsulko.com>
ha scritto:
>
> On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
> > On 11/4/26 3:29 PM, Tom Rini wrote:
> > > On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
> > >
> > > > Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
> > > > configurable boolean, and update all defconfigs and Kconfigs which
> > > > previously only selected REMOTEPROC driver to also select REMOTEPROC
> > > > itself.
> > > >
> > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > ---
> > > > Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > > > Cc: MD Danish Anwar <danishanwar@ti.com>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > Cc: u-boot@lists.u-boot-project.org
> > >
> > > Unfortunately this misses some handful of at least TI K3 platforms. I
> > > think using qconfig.py to confirm which configs have REMOTEPROC set
> > > before / after, and that they match would make sorting that part of the
> > > problem out easier. Do you have time to do that, or should I pick it up
> > > and do a v2? Thanks.
> > I can respin this, but do you know which platforms got missed ?
>
> I lost the list, sorry. It was a number of the r5 builds. Perhaps some
> fragment got missed? But qconfig.py -f REMOTEPROC, with a db built with
> and without the patch will quickly show which oens it is.

This is the result of comparing the two qoconfig.py outputs:

am65x_evm_a53
am68_sk_a72
am68_sk_a72_ethboot
am69_sk_a72
am69_sk_a72_ethboot
aquila-am69_a72
imx95_15x15_frdm
imx95_19x19_frdm_pro
iot2050
j721e_beagleboneai64_a72
j721e_evm_a72
j721e_sk_a72
j721s2_evm_a72
j742s2_evm_a72
j784s4_evm_a72

(I had to drop also the select REMOTEPROC for the new REMOTEPROC_TI_K3_HSM_M4F
which landed into main but not yet included in the patch)

Could adding an "imply REMOTEPROC" in arch/arm/mach-k3/Kconfig, where other
REMOTEPROC sub-options are implied, help to simplify? Avoid need to add it
to defconfigs.

Regards,
Massimo

>
> --
> Tom
