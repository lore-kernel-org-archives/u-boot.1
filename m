Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3A606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b/f69Er5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mLSZRg1Q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D876404FF;
	Wed, 28 Oct 2026 09:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e3jd4MkcdPjD; Wed, 28 Oct 2026 09:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58ECD40540
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793179949;
	b=iiceGEu1MBBijIUrVcQA1sJb7CNCjI58O6Mt5/8YPysY2jtce50DlSMroygIL+sjwPor
	 fSoerCU0v6KOq6NREY6GTyCQFKNzTcJb5WZ0ryk8RicBfy/jtsFh0MEZK8d2I6qm75XFn
	 e35CSB5+H6RMqKItGAqXK091MdStwOAXHfPEHK3S0zEKN+Le8qjqMiOXdY9+BEqUjeNCu
	 sQddOxCpdlNtomwlZNrtJpjL7d+s6IBp3YdJnYcWZmqUN3Wwg4aF/vaYJ1fdTS6nrFhve
	 k/4B8x4OqS9D8qRE7/pKOqpPyYtqAk3ce9a8LSYduCs6cKo0KCJ60b8MRqaJS0AjT1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793179949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sTCi0VbMG5yaLHPpwYuZWavCoWrVghnUoOPEeEUQIio=;
	b=gAObWA4NwA76EHGOwVX64wL7NIhf8MkGIb6zKL21K2jZ3HwxBR3drxtsb3nsKU+OBoYb
	 esbTT+qFTHHh8oXBA/54ATtIF+/g39DRaMhU3rD+Kb8PqIDEgUcwRHabd46gWL3FrCtw1
	 /RwheicB8K+jpKjvD+Cbchy/qzAnUlUUQM7nKLb50v0h1JxwBwF9dHiBAnMExHxMAvTCF
	 yXbM5vXLGNcDMJO/V9oC+5S9PjrVvvtcSm+GGfWebcd7hCgcTKlKcDCsl4YXI66TTOnoD
	 ZUgMTU01P9fNAWkMQR7DntRDGKaJkkJTLiM7unwre7xo58tkMAna3VvXCC8khz6mcgg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793179949;
	bh=sTCi0VbMG5yaLHPpwYuZWavCoWrVghnUoOPEeEUQIio=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/f69Er5XSW8iABrMFTiBaXE1MRCl7pRPXJd/ieBDfm5PidRy3s7kWZ3S/Xx3FCUZ
	 oAFRekLF5d0SP8+N9MIxkfq7LbKxandtqGS/197+pPPwmX0p8PLwFqSmC2uRnGP/Kp
	 hCau6SScKB8uigcSLrPjWRd+gPNSASiv08l5lm+valuov3UgyV2eYnVU8JdvW9QoV8
	 7QOfDCjeys2XtcztdFUsbvSiZsy6TyLeNPgnU+6CRmTeCHblEtqdLeNO1lUjnjDdi5
	 BUR9bLfYE5MGz9NteuB4gk7f8dLMRPLtKQc1TGIikCvvk2yBkrRnqlUUStWmUBuLiV
	 phwQwnwrxBgLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58ECD40540;
	Wed, 28 Oct 2026 09:32:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 95851529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BC6660665
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qKVdjAT-F9yS for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 09:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8C2A605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793179946;
 b=WiKu3dYZ8CwhInbGTS/bmZ//B1hGXGqkSdkHo2G67OV+LZnVm79cJ2ndygHcMdzwQf5s
 nbAnJ3dG06vfGv5WsfUztDmoklkBKecVco/ouzk5hqlDyngx2wOScYKvFTMTOsW/4GEqf
 wNAMIPJjXmtJIRa3GsS18FxAYGnwlrcBsswDRf+Q3VWH1YliLixd0AkWaMXyw3dSyuhy2
 UR2TxVrQV5YWu6kYsJauixi8JLVKEk4JkgqXHjHnqGdc73pm2ilVTB+St5Y5fM4HAWETQ
 GYdSR3SYnrhR5gZERVU3yVzJJQ1+1/+LBww9avBckhhOSVqhPUa1bsbciG0ZV/DnNAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793179946;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=sTCi0VbMG5yaLHPpwYuZWavCoWrVghnUoOPEeEUQIio=;
 b=Ut/NWEgDRNb0V583Oz1pnR6KIh/KuWSNnyyXg+ehfw8aoHgyIQr1haK2H9hmWB3Y/GDD
 GTufSubEBBsnHiJ47HNa04yJO81uM92T1JyIDf6SPJa8RCtxAD/QGesWFWUXfJoH9yE+W
 FcNbzyZLe8YjbLmC4TQOIPCdh7V5qFcNkxTcErUtyxl41lY+Eo5z1Nxe7zpM+lHvtBvWZ
 0xTEzbZu6AnxLzSXNq0zZYh4o5ImZbmfDLJulKQDQ/aHy8Zar/kKm6VbiCKNLrXBfW6Ou
 czpt4FHjTJzW41M1vkU67TiVLyH3L8Omu7PR9jW+9lJydaNSWNYWCaANOIxtYZNeBRQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mLSZRg1Q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mLSZRg1Q
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8C2A605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:32:26 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4b21f71613fso528211b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 02:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793179945; cv=none;
 d=google.com; s=arc-20260327;
 b=VTPmUYfKBRfQpDe92+8Fxyoa3NVOAChqCDx/6669XrmmBg+8ZjKxBW727GXAlFqFfv
 cEZX1xO8Mg8gpSgmKTogU9VZbjgqcvUH0INOIkh2GZhQn47ti2uaMM6mxKWTOIddZ1c/
 Y3z/3CEWdMjoQo/2aaAVkMm7f9Zkj97eT5cO6WCxtD/S4AoCsBM43MxBVciKvSkA1EiT
 C48ZWorYdPHdXg19rat6NwHkE+XlZBxNslN+GeuZg+RRXh/4Ysnw3gAd5uXPcoNiUu7W
 an++bpMDbTNl51r627SrXVs62Y6BA//ugttLv9bSSWGTHvL1ugoKARwgtb2KlGioTMSB
 L+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=sTCi0VbMG5yaLHPpwYuZWavCoWrVghnUoOPEeEUQIio=;
 fh=jBId5TlJaU87/tZVwYmZd5HkQU5k+P5ZrkyisAc1cAw=;
 b=CQkgBogOwvsRN5KiDECRsjA+ZoMWV3upURKjM49netSfarZmB6HnptvHwV4XsWiaZt
 e3EWXpZ5vcEDquVUzMmNgxqsABtOH2/nhwRt5a4WkeX5Cd7XeTKWSUctd9us37OlZrax
 CXWgV7gMA3RkroDn3CHIFHJJU6YxdK9tGKrMXB4/4kr1sUfYR+tyXbchf2u792GAVAaS
 918yOxS/2V0m58kJ+GN6h2JWX4c5R1NTDVwhRLIf3ZFP3tAt4CyH3bbbIFna33jPTx7s
 crmKdTzRbBwnyiHj7MurYeaYyyK1q6rBmfOFQhHNj+54y5pvnK4/Zvbv7RbHTXvCskz4
 q4Hw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179945; x=1793784745;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sTCi0VbMG5yaLHPpwYuZWavCoWrVghnUoOPEeEUQIio=;
 b=mLSZRg1QcKcOlJTVZAkBebuifBtCLPzazlMiqzFmVP4vtdMrn/8RtRRjjpWCPcGId5
 po3GXaug0MsyLI2wRe4mGB3wn43Hx9OM/LbkMgxjOibJm8EEjAEDEWPwZ/wSWFpc1eC3
 K8RrEkmUOkPXmIOGE9X4AgrIoyKF9fWx5PsKvEjYLNZYVFMNG5JEqSUs/EiW3TKg7bPw
 Dt2o8nShIv0jmZQ4yG6DfBGtw1lPdG1aGtmdTG3hm1caxKGNwLhiXzjcoSsVRpoLdBmQ
 Sq+xeZg9KpmcPsFvfnjSzi/DJFG0Cv8zA0XpOr4rwuvlCtimTZ+SCRiaZJRTUAwLvYv4
 iubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179945; x=1793784745;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sTCi0VbMG5yaLHPpwYuZWavCoWrVghnUoOPEeEUQIio=;
 b=nw3ONk/3qdF5tLOUDCsSOkBsiVnHr3RAZpT6fgcYQXkmsVR2MIXeK7lwHxOWSOE6U3
 83voHM3QXJNkV+aWkRVH2b0NX+xwyYTmYTkC9TlmNxCfH3XHg/IMk4mv7hFVcEMX5yQV
 lasLYK8hFR6tluMNvuAufOjjSwPxsSd0gGd6ca8NvjDjvo1sIJn6IJaQ85nmGmzBSGNw
 NdCkKjx4WNZjp+m3jBia5nNj00Rnsrl+D67wl1Y0s7fu7KxTAwQis2C4AwNVex+xqvtR
 5uBf9g1/IPgc16hfdoV9EcJ+6CdGY5FmhpHROB4y762d8LJUvKtDxjHTovqayi2DvBZy
 mgDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfb2kq3fF8uiscicDT6IvhS2YuhhaqCzhq52M3RpMlw3Odmi6gdZuaohSqGOXXQAjo41pKPMA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLgndfX8gDion0vf8vbUACf0z6UaKjDGxo7aNFk3MaHcrZBVuSd
 d2jpO11eCRg2PnhsBzcTI34gyr0jzzD1K4j0Hiw5RfooXenTFcvL3/Pj6ovrmpFdglCFYRwEF1i
 ceVxZpkPROKcJFdwNjoLZULkKwo50msY=
X-Gm-Gg: AYBFou0Zi4aFfpl2Buin9/+nB2Q1aCoYpH+lM7QIbpbvR65DVBX3XZuB3q0spLZONfi
 7Uz82ePiEnzU4VJ6CFqw8zi4bZNJ1NB3zDo/A08sfjHjT4zjMY9ze1PTZRaTy5FBnLCx/3Drr3N
 7rv4ZGFKGGbCW68K0P3Bz6GZlxAOB0d89KqKQWhdlpZ+X28kCteg/TDsVuv9cHl+Lk6FpWnzl+O
 qSNxsDgQGmjgWkfNGtRd2ERi0Ar4yPw1ZwFLFkh1bB+16IzUeXTxzqFDbd+dZ6qDBCMOcTWRyF+
 UgOTUdWQ/Ezm6/x4Ne9EA550FDHBkESQoIqKEcO60mqUaVJyhMrTWvC3IommTjxV1ua8cNqN3+I
 nwEiDeanf4vWtN2r6NMxrOLE7FpX32fYImpBI5Q==
X-Received: by 2002:a05:6808:bd6:b0:4f1:6c9c:78d3 with SMTP id
 5614622812f47-563a264b4d3mr795945b6e.26.1793179945059; Wed, 28 Oct 2026
 02:32:25 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 02:32:24 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 02:32:24 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAFLszTiprHQ7o0DFL2fZPZ5OK4zb6LB9jNAtuT5SU5uuMGuXJQ@mail.gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <8dcede4f-fba2-4635-b8e6-93fb35ae07ce@gmail.com>
 <CAFLszTiprHQ7o0DFL2fZPZ5OK4zb6LB9jNAtuT5SU5uuMGuXJQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 02:32:24 -0700
X-Gm-Features: AclHuK84Fo201mo44vUEHuIMrf9MJFQ71cz1x9bOo_Wwg8p29I41epyLLfZy1Js
Message-ID: <CAJnxHsj8eWu17cgJv=giyCWv2HeWBSsHZiSkyDEkYmG-Oi+eOg@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] efi_loader: Measure the GPT the partition driver
 uses
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, 
 Javier Martinez Canillas <javierm@redhat.com>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On Wed, 28 Oct 2026 at 08:57, Simon Glass <sjg@chromium.org> wrote:
> The commit message is very long for the change. Please can you trim it
> to the problem (the GPT measured is not the one the partitions came
> from, and its sizes are not checked) and the fix? The EDK2 comparison
> and the test-case details could be a sentence each.

OK, I'll cut it down to that in v3.

>> +int part_get_gpt_primary(struct blk_desc *desc, gpt_header *gpt_h,
>> +			 gpt_entry **gpt_pte)
>
> The name is a bit confusing, since the GPT may come from the backup.
> Something like part_get_gpt() or gpt_get_used() would fit better, with
> the header comment saying that a backup header is turned into a
> primary one. What do you think?

Yes, part_get_gpt() reads better, and sits well next to
part_get_gpt_pte(). I'll rename it, and say in the header comment when
a backup header is turned into a primary one and when it is not (below).

>> +	if (le64_to_cpu(gpt_h->my_lba) != GPT_PRIMARY_PARTITION_TABLE_LBA)
>> +		restore_primary_gpt_header(gpt_h, desc);
>
> This comment does not hold for the ChromeOS 'IGNOREME' case. There
> is_gpt_valid() returns 2, which gpt_repair_headers() treats as valid,
> so it never rebuilds the primary header. The measured header is then
> one that no 'gpt repair' would ever write. Since the primary header is
> deliberately ignored, I wonder if measuring the backup header as it is
> would be more honest. Either way, please can you correct the comment,
> and the matching claim in the commit message?

You're right, I missed that case, and I agree: with IGNOREME the backup
GPT is the one the disk is meant to be used with, and 'gpt repair'
leaves it that way, so the backup header should be measured as it is.

In v3 part_get_gpt() calls is_gpt_valid() on each header itself, in the
same order as find_valid_gpt(), so that it can tell the two cases apart:

- primary GPT not valid: the backup header is turned into the primary
  header that gpt_repair_headers() writes from it, so PCR 5 is the same
  as after a 'gpt repair', as discussed with Ilias on v1
- primary header marked IGNOREME: the backup header is given as it is

I'll correct the comment and the commit message to match, and add an
IGNOREME case to the tests (lib_test_gpt_sizes and the PCR 5 test).

>> +		log_warning("No valid GPT read, not measured\n");
>
> It would be worth including the device name in the warning, so the
> user can tell which disk it refers to.

Will do.

> BTW now that validate_gpt_header() ensures sizeof_partition_entry
> equals sizeof(gpt_entry), the two loops below could just index
> entry[i] directly. They also use num_partition_entries and
> sizeof_partition_entry without le32_to_cpu(), which could be tidied up
> in a follow-up.

Good point. As there will be a v3 anyway, I'll add that as a small
patch of its own after this one, so that this one stays about the fix.

I'll wait a few days for comments on the rest of the series before
sending v3.

Thanks,
Ana
