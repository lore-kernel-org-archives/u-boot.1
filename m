Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7000CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6196A6066D;
	Mon, 12 Oct 2026 14:22:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwcmkwJO736K; Mon, 12 Oct 2026 14:22:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5448760607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814950;
	b=jyoRHhnhEWqO++JCPTc/BFRjWGhYUelZq0cl1tAf6vkNhiPQQnjN/LvSv+UEmWYO7OaH
	 V/CFOnwix6s2uXulPLFEnL/ImqsoEVWxHA63PmfG98xAai53FNjL41ZOLjE4djadI5AF5
	 DO7p32/OcD1aWYPTezXgqiIsgAFCAU/VSlRJSBhkzAo8nccFJCIueO6w9R70FlpVKNesT
	 dZ0zotdARR01IOSwGkGdXHnPKKXkaXOB8yEGArd2GAxf7n5+XFeMN2N+TYm1neoQTm+Rz
	 WZovPQycy2vjqMzu2no+nOHxeoHmJUfcfW9VNt8SfVfrQhSl4MBbV1pTSynO8Jsq+AQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791814950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=McQoQBhRH9LRAlMRfoSCqztEeCmrQjDFgKpfOZrctjQ=;
	b=LKQ/e+YhvbE8myyZXeeszEBHsvilMG3f2UI+AgZUFu9kqyhndsYaHg73wZv7kNYvbWj8
	 Ik9J2oOOeR7vqsV+RaMyCdEMu79JEWj12+n7hohVGUdj4JXzyUtBlks+7HrJFrKbKcnQq
	 UWN/OnGsI6quksJ3jk/AGEXz3eodWk7GnA79l95z+SKg2eqyXp03Pb3Q+r4+uk9U3jsEN
	 kKvqnKYABa8/INgNNHiVF2AOiHl9zqMHF/53O+n5BxH1yKMZ/cjn0IlQTCJ66JFzwA00q
	 sCgWXI4ggennda7khUk0mPRoVutO/Io0zG/nn+VUqvi1Jd4dkeB4BmjkcBTddIPZxYg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791814950;
	bh=McQoQBhRH9LRAlMRfoSCqztEeCmrQjDFgKpfOZrctjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oZ+usYiOO2It/uca20uweQs/Szs5H8CoecTnIMPdkG6gDBc2GGMKnCr3mjuZsrKi5
	 oKtIp4wOWCDKdK0t0bYTrGdVeOkC0zJxxPuO8rBTD4zXn45XusayIKH/Fg3FNxaRNB
	 +XFk/viDrw/0n+m9qepkU6QWdL9rPAnsfR2GsYTpbreLWCw80Q2EE5rjmyiLwrEyQm
	 yo6ckLuLYx9quNlUzNcx4YgQwf0QwKU8RVmrSkkvszqWnZ8XBegg7gKPtefvdthYhW
	 loTC1Bh4PwDE+5KMz1aFHoU7wkC67b+8h9MhPL43Jyf2ieDCfXudfTLB6ltWZ7oKvk
	 Ugu7RhbNbpXOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5448760607;
	Mon, 12 Oct 2026 14:22:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E701156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1498A40382
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:22:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lL8OVBv88Y77 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:22:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 175A840346
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814948;
 b=hXdcV3/7QeZrCqCwwgd7uMQuNXRzD26AAc2NzNT7vVUN+Up8+hIMg7HiS26wwy2hhjn/
 YOht3AarTJxoKY/SNRY4B3bRBxa8tObiQMeR/KjX5qpk0lcQnrHg+YywxFid3NsI7qrz1
 psuskFgL4TBGTpRKKdzUtP/cIqsH2BbjBD8ibOozEF1uUYMx+9cvmvYFsB6mBgqrKzyN2
 GbsvGagfK+otjgg24LGmrT0siL2xAyOdm1+yAvJ1nkdKBGVsdsEe001yO3oNtDhelbf9J
 GBiuNuMdAVZYfO6IBq2EBQ7t8BrKSAi6AKA+/4Pyhu0AdAVno2kO59v1oCV2BenxIAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791814948;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=McQoQBhRH9LRAlMRfoSCqztEeCmrQjDFgKpfOZrctjQ=;
 b=jY6lk0AuDn/3om6y1bCeE4iFHYZuOKFWHkEWV4FhpZu+gbaUNgLWyCLbMR+yCm1KJvwh
 lD53RISmh5mX7B1g0BwC8oCzc/WEZA+Jl4We4/oPOoUeOmbVfVrRObNtug4QoMRCoXJlu
 arShLu9s/x1OBtrxN0bRFZUnUEPztodWnQs/gLgJ1JvMSZFsELT0NCTjlX8MGwWgfX0Lw
 j6Pjs7gMX0dbEWvzpwdnNlPKfyybX1QqHQhOPevpdY4hfXY6v4+87hoh73tik+Kwm7KVb
 ViXBvmxnXLJ4hygfcu4SeMXhNjNNQENRm19BK3Repua2hMMPRP/q+6Bgr9Oi919hFhw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QbLckef1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QbLckef1
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 175A840346
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:22:27 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3a80d1c98f5so1072576a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791814947; cv=none;
 d=google.com; s=arc-20260327;
 b=e2PvwMeAEt7Yye0WmUmnZanWO8NVBZT7cn8m/PQJ8MiQEyGtNTHPEMIbS0HPMUhQ3w
 F1xqX8YNCmISNR9amHlwbMTXUEopEdFbZ6FJPfjU+1NkYavh2Av1Dmgv/OaJxn2m/RLF
 ucpyVWnX/Dit9qRYM/DvYzwa5Re8AKBb7N73elXWjiyqBgHJCRW1KmdmDYwzOBK4+Rgl
 eW7dHiS3HDFbLYy0ckFOMbNU/S2iZpBbjTN4ZRwDm9vw9YfUkM4nGYack+s/CE4yNcWA
 jnhNMAmHt5nkWpIAK9Lt8ZAjAaaRQwkRigtn9sWAL2J4A+70TVRtfF1bg11h16jYSuls
 ZrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=McQoQBhRH9LRAlMRfoSCqztEeCmrQjDFgKpfOZrctjQ=;
 fh=8i3QXvZ6MkPBZ6C8QdOFuFXMaD16QkYnfny0yrwv/rY=;
 b=kK0R6auuy9la0VIEakEnE9dK+VXCz4e4R/tPYFTy18grT88lnVCi+EJxI6X+gjlNXp
 94lA9FcRjNf+I4UARESjs80p139O+m5VdKfCxPj813Xe++8sSqEHK6ZHfXRQFlBVj7q7
 EWuvUK1PmTXvPwTw86lBwbypE5wQNvvSqqmhLUFGAb/CEmsacDt6HCYtzGL8xGav9QfP
 MwUilD0xhObjXvyofypijdGgf53TwtU9kIZ2DBZ5AWM/94bZRLHdy8GdepBb13CapGZE
 xs3L//XaeXMnctaKS0ee7LGTwSddHayfoAq3uq+bO5c7KWo+d14EGtF1tsZ/4tZ/gpOi
 FwbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791814947; x=1792419747;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=McQoQBhRH9LRAlMRfoSCqztEeCmrQjDFgKpfOZrctjQ=;
 b=QbLckef1k4k80mYO3r8Y2LX5oNodmk5jh6OjKMY4SN8Glqugq4Vqu090Vdl2PEunAY
 TsbQCoxQ+EXZA9fy8xpKgH/CDz7hACGZWaJTbYpbxd9TCaHIyoZFUFU6ePAkhGESp3FI
 wYQ29bNvVn4wp2krjT4EiG7pKQaenA6ebQuqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814947; x=1792419747;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=McQoQBhRH9LRAlMRfoSCqztEeCmrQjDFgKpfOZrctjQ=;
 b=JHga5edotkdFD+9qoNbRrvS6mVrT7bWrTgnLpwbS8jCWvg6rgvad4V7gJMPEdQ7d3z
 uyfZ6rbCxJ9Arpqor8nugOUEsKPI4qc2ZB6DwrqA+si5eGdMjFoZ3vLFuLBmzhXxjzNC
 ZRVqGfZkl59vuFkgzK+lQap5ypHJWYELErnMh420hh9nYbml6E3V8qnKi6t2xToJVH4H
 MQk6M05hQgLc4I2I3ZU2U1/6ALSTKCJS8kon2G1vjHnmOs4uwL55EtBw5OQmOejBAlbR
 9QORrmpDygz5tzyIVSQE9NjLneuk+Wx47O+YEvnu2Gl8sPEJMJ/dC4aafh9I7ZqN9ygS
 tcew==
X-Gm-Message-State: AFq9FYIU5PXESWvUpfXi+97XxiEXVmHGKLfsRzvP1+RtOJRYoHOYwmUw
 AjAtRy12FE/VHJ2jS3r651sLIfJheeLDtOHJJV7wxntSoLEfhDKk2VVZnfD9DK6TtVm6PrpOhbV
 xp6e4ixSjsI5wgLXs7+w9EcqTSfx/FUnixzVYdaqMc52uikMM5GFMLOuHlHc=
X-Gm-Gg: AYBFou0pa8/dhisBSfzcr9LAm/eVVOdVDsEPfTEoKT9yQtC8JZBMK+y2EZuD71PyS27
 8ZUeEDs1xw2fQjRnToSABSpB624kwG+fO7xHSnvp+LIgZV/ZpdU7tuiI1w3RpADVtPwB03YYM7Q
 GFlvb7SzRUB2L2Net6eQ4bq2kxOflLMGf0hN7yq1cnBV5Q4ROYJ/UBEEmzLxMBf7ewMKEvCPE9G
 nBptnrKHGGPKhT+/Fd35voDLJwGXL7r198A+lg6z572KBTvll9+e5aGVUBJcf8DN1Lbk9AR/wSO
 tiIxrnthwacl3JbytQx6oVD+37KFIqw8iOgIxtx+iK1Ne9KU8lhlYQM=
X-Received: by 2002:a17:90b:384b:b0:3a0:c276:1ec0 with SMTP id
 98e67ed59e1d1-3ab3a9536cfmr7309761a91.28.1791814946906; Mon, 12 Oct 2026
 07:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKnvs4fEmyqAbNFobx1UR_KXhvrA_MqttNEpktrjNAH3vjv7w@mail.gmail.com>
 <CAFLszTgHB4tZz7=eEk0QvOxVwUvSwC7zy1QqtUMtMtEmKXcJsg@mail.gmail.com>
 <CAFKnvs5V4mv-nsFfe7UYeiE79wO8R3=pi82Ubu=dWswCoUfLaA@mail.gmail.com>
In-Reply-To: <CAFKnvs5V4mv-nsFfe7UYeiE79wO8R3=pi82Ubu=dWswCoUfLaA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:22:09 +0100
X-Gm-Features: AclHuK97j1IzEvjzQf7TtRIYnWj9un1-Z5g4yVe-ogVftpC8I0HZGmerzINxo-0
Message-ID: <CAFLszTgCakkQ9=BFa-gikOzC6pR5bMXMWLcMK7q=wg1xnET8yA@mail.gmail.com>
Subject: Re: Can u-boot UEFI provider implementation boot systemd-boot /
 systemd-stub?
To: Umut Tezduyar Lindskog <umut@tezduyar.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Umut,

On Sun, 4 Oct 2026 at 12:46, Umut Tezduyar Lindskog <umut@tezduyar.com> wro=
te:
>
> Thanks Simon,
>
> Yes, ultimately I want to boot a UKI containing systemd-stub, but I am al=
so interested in running systemd-boot itself as an EFI application.
>
> The chain I have in mind on arm64 is roughly:
>
> U-Boot -> U-Boot EFI implementation -> systemd-boot -> UKI / systemd-stub=
 -> Linux
>
> My main question is whether U-Boot=E2=80=99s EFI implementation provides =
enough of the UEFI services/protocols expected by systemd-boot and systemd-=
stub, without having to use something like an EDK II payload.

I expect so, yes, but I have not tested it.

>
> The EFI call logging you mention sounds particularly useful for this. Do =
you have a pointer to those patches? I would be interested in using it to b=
oot systemd-boot/UKI and compare the EFI calls actually exercised against w=
hat U-Boot currently implements.

It is rejected for mainline [1] but is in the Deinde tree - e.g. see
this MR [2]. It is indeed very useful and I have used it to get
Windows booting, for example.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/cover/20241202001243.1283274=
-1-sjg@chromium.org/
[2] https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/1331

>
> Regards,
> Umut
>
> On Sat, Oct 3, 2026 at 4:30=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>>
>> Hi Umut,
>>
>> On Thu, 10 Sept 2026 at 13:14, Umut Tezduyar Lindskog <umut@tezduyar.com=
> wrote:
>> >
>> > Hello,
>> >
>> > My understanding is that u-boot has its own limited UEFI provider impl=
ementation unlike some other boot loaders bundling open source UEFI payload=
s.
>> >
>> > Has anyone tried to use u-boot's UEFI provider implementation on arm64=
 with EFI applications systemd-boot and systemd-stub?
>> >
>> > Using AI, I mapped all the API calls done by these programs to UEFI se=
rvice / protocol. Most of the text input output functionality and graphics =
functionality is irrelevant for my purposes.
>> >
>> > ASCII text mapping table below:
>>
>> I think you are referring to UKI (which includes the stub)? I have not
>> tried it, but there is a good chance that it works. I did send some
>> patches for an EFI log which keeps track of the calls which are made.
>>
>> Regards,
>> Simon
