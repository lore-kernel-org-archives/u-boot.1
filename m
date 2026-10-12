Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A187CA9EDC
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46D2780DFD;
	Mon, 12 Oct 2026 14:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jld_l8PWOj7L; Mon, 12 Oct 2026 14:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48AD980DCE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813699;
	b=ZuEXqQ+SRHx6H6zRMftTRr1p+yIQfbYcnss2tIB8eMg40IzcDBRHa+FZri0icv0Vga+B
	 HMVeKgCIIbI0zJXRKFkqHX8I5E+zgy8a3bJquCMkyVCf2DXxI/9h0JivG70KVInKp4DCh
	 STaYNl8Id2lq3rjZWheIMwGBggASoUA1Ya+0Ln4JLFGvl20iUrmOddgv3ESiNfUWWYydy
	 3b8Tyes+g/ZRyaoA9LRNO+8G7TSh8CNHo1eDN83fS8s88F00wi5ANEGPl/epIMUEEyx5S
	 An0EvCg+QD8CTRqj9ogq6fGC3iLV0FbngWUopREuAB0EMO13L5wNJ+hX8ahdarIZRlw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZpyPkCM2OmCVsTIISEek/uiqLTljPdzJxXvO5dBg+Tw=;
	b=ginz77jr21zAc7vvYG/GmavPib/lpOr6KttKwuP7SoUI0boFjzcs6lyUyvhSWZp+VeF+
	 BlIdny3GBvtUZNfgP678NGogOKVYZDaPLHGkeOnfqRDyjMWVh/uAiHu+bO/6Ow2goiOBJ
	 N+KdBQRUnYKuA+MP1Db5Weswcvz6vlAUldLLwA3oIfZr1iQbM2k+RTdKxhnOCH9B5vE4L
	 kZkOpQDUsub9DFXM9GZbM0wYCOCNuvbFfxyyZlN8NgAv+KdeBAe0NvfZccIxTAU1xLJLK
	 2syg4JXJm38C2KbtMfkNNRH/D4bNfAJ69XeBiuAFzMfpMdbayBl5gLSbiPP8l2mwQZQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813699;
	bh=ZpyPkCM2OmCVsTIISEek/uiqLTljPdzJxXvO5dBg+Tw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vy5rOo1PflMRnNuXRDMVrZzt6LBytue2pmwT78222X5cCOD6P2c7xSSLnSu40jUxP
	 FOwSmK0B9nsvTI+vDaGqNKyr1pKU1+DMXhrAeyQfWBao6mFZErrmcoJ4zY9Ls9kJnG
	 H/J/Ql3kyHJl05rL62GQJcROKdx3GBWHJse7mGR8EAr3qKIQnEFlsBXFJf7dGgH/ou
	 sPPCl2vxE2Pp5FdkFEdZMS0RkXG4p+0Jitg9MeM2hrPA7ZwZD+nMIc6csyRCBUPssZ
	 BJhREcvfW9+RXUIiFmDAIMQev/VqsuDPv/yM7s3ApvIiavDoDk8S+i8npnL6cL6kqj
	 EBcDSeMa/a2Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48AD980DCE;
	Mon, 12 Oct 2026 14:01:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 460512E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3810F6066D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBTsy_emOcvx for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 504F9606CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813697;
 b=NoSSUzJmYXmk2dyjRuvIBRsyHrj6gN3YZJtKg0+otfLJ9n41y60vw83/niDD2xtt14WN
 6EhcmfOq8J1VX16V3iLqdGum93K+9Fcpjc0rR7JzFmtmkdj69Qts2FjkzKNE9PnoMiruE
 3MC6SycyTby6QY2CJsyQycZizLPaLFIfRN38CHttZf0jMy4TnD9qEnBNkZcZQ98nP3l+z
 ZI7d4XSfbT70CSiyaQ9A+02toZY5f2gwquEAaJOFQZVlP9yvhyGom5U1r2tZlWKOBBBrC
 TBMTBAuWv3c7fb854J2I0tXPQVo8h5GOHon2qEwiFoAFuM5RhqPJhmZHtU8iOfs7QiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813697;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=ZpyPkCM2OmCVsTIISEek/uiqLTljPdzJxXvO5dBg+Tw=;
 b=lOtQ3C+/3zcuuD2u5KlfqIJwfJ5C6eL0SUAqGLOmV572/P/Y2Lb1oEalvVj9UqNsdw7f
 vLJFh1J8pJOaalDMG8kI8YkkQ+cVyxpWC4ZUGPyOJwdHGM0V+wsVHwFyQJ00WhizjxprA
 Ki0ds2fZBOnSICKKaEb1IZkqUYmASwpTS7FI8e8kst7IhHpGWbGuHBt/Zmj+HdZjwlqSh
 TgLE9IOSFBf3eEWwvO3efDUhG5pq7MLbL8yaHY1e5ccLCeGLwBAaAXMUyz9gzskzaUAD+
 kdW153cmJo3o7aEp81RMTB+iCUif3JbrIggEWYWnRX6rTr04XsDEwhCyMiKxaAtiflQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GUwFiLEm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=GUwFiLEm
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 504F9606CE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:36 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b1b13e09ffso1394666a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813695; cv=none;
 d=google.com; s=arc-20260327;
 b=Uzrm3UhnLUzUtgvRELagg+/3Fe9w+vWZNDBmjoJmvqrt5Ap6dgCEgPF2KWPU2Mfvqj
 1pdJBSbhzOf3kN+23RAAetxKVapEJnGfkftPcXBWQZGzWOV1uxhogzJuu6oGeuEgxNF+
 /efJRCs+6u2Vj1lJdGmmoHRK51GqNYLYhEo+45yozs+PdozfhfxJkt1MgopgoiQlL8Jv
 GBOikv9V5fyFutzDq7IvY3YauEVy0QVWoLNLLA/g+e70cIo36Pd3FLoDZe5FKIGWa+Cb
 v1OtoXsL4QM6MjrZJkyIpiU9K7sV1MchYM+TfZmM5C9gIDhXXRs9GqeW4RjhWcCRqT8T
 QyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZpyPkCM2OmCVsTIISEek/uiqLTljPdzJxXvO5dBg+Tw=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=MiOWezXOU/9UXp3mg5mH2rRUeeUc3VFawwjTRtp2So3sEwtXOo3T+Cn2vl3fB8sCNj
 BUHEyOdEjxe5ZFT0nV0QpA/LX7qB4edWe/EEF7W8L/+fLjuSwZ15Jbc6u+aSxCBfGfbx
 eCrAJ+nhwRXA6GyrH9oOWsLgcUTCIZgpL8xNpkDnMTAiqABGydbME5Pg5jpEqq3qagjp
 6o+wWAtpkfoy/gM/vZzji0nZbXSZhIMEh0eR5b+NMeIOQCeOHGeyUDpPTDRX6wP6hzv8
 WGPKrWKdzmRha44BJIyXCJQY40va1B4plwoTtyy6brrPz9iUvAsSqFP6BK7iq824ah7A
 AweA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813695; x=1792418495;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZpyPkCM2OmCVsTIISEek/uiqLTljPdzJxXvO5dBg+Tw=;
 b=GUwFiLEmrvPhBlFRJofqSaqhTaqBqAtjKCqtrHCz4DwtfnntV1iuJJtBmulv3vmh3j
 UkGjLGZ3EaUiBHUnoGtrsY0eHgWHBrapqF1PsEAQwBwrzyt0e8IwYirmwrME+DUnxs+a
 eupckic4M6o9AA4vFBIzE+Mp9THuco8ZHz80Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813695; x=1792418495;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZpyPkCM2OmCVsTIISEek/uiqLTljPdzJxXvO5dBg+Tw=;
 b=AHYLyWY3m5hcj3Ij3dhFBc2H1WerR+txxXRGOFKC4k/1VxN9bgivMgRvRx5V/bq7Zu
 jcOGFQrz7zf8sFY+4zSKHMhqGLtDPre6F+7aziKGb+ZK3NbgII4xeJSeUSW2ZsziuIdk
 VPsYg0mO66FALLUcbsMBCytYz9MmTyCL4TZYiBW4/fvII5+gK3tHwFQYn36EvSSoLf2G
 BluBlvV6qQlpnl4p0bQaIQyBDH8mDBKx1xNR1ICyVz9aqvfFILBvPiAmXkEzFjV1k1B3
 7DePeSZBxhMFa4Rn61dB/4TCDSQp2eSSofj5DhVg/aAWacq+evKQS9yLzEUFjRGuAweX
 FVHg==
X-Gm-Message-State: AFq9FYJ7NtQLDgdeCQ0csiV9gKE18Bd7E9UZK9D5KM6bjXy31BjhUe4Z
 +QqwfNWm7d6dktozWk8E27U3AzzjBwA47iLGyXSKyqY0ixi50EekND28TW9mYGniQ4FJ2lFn8Go
 lr2QyKxUMZautFNF10SS5FZu8KAriQADZLu6LONYr
X-Gm-Gg: AYBFou2YlhbvuZCtMjJY+cRgHIeyw03UR5wuxLySmk3tnbi60ZwBuzzgrDgs6hZiwIc
 RVg1FnqqhUk/SRG/JCY+s1vjgWT334p/cfTvCVo0VuLFvtcuHm5O5HzAY31YqXf4zIaQ1p+DBH6
 69VisVE3w6+MnBvX05+yUCFPYqnRiK+22tPj7MrLi25mu5Cxx9XuFSuMX8QleOpCYxVUr+qchPe
 r7P/MlkC2hxWXyDKP+qIEondrGeUYnbxp4bKdT/4NZ7D67Scpmz3/3GGowKxjibepZ6AwRshzhc
 Jl15uegfh7q7sIN6pa+pp5gZ6eWpcUnivvN57mtZeselzcKT9RjOqLM=
X-Received: by 2002:a05:6402:3248:10b0:6aa:fce2:7b30 with SMTP id
 4fb4d7f45d1cf-6b17c243791mr6121569a12.18.1791813693968; Mon, 12 Oct 2026
 07:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
 <20261010-b4-button-live-monitor-v2-1-004f47a4a7b1@protonmail.com>
In-Reply-To: <20261010-b4-button-live-monitor-v2-1-004f47a4a7b1@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:01:19 +0100
X-Gm-Features: AclHuK-_7QKmzLPAOHaZkU6PRhl7qQnmz-TkepZ06VB-XGznDoUb5ufzJH8L1RU
Message-ID: <CAFLszThwq03FVFHk6OyqxKQsLEN62QH_D++cqtx56=8SquP3Pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] cmd: button: add live monitor subcommand
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Petr,

On 2026-10-10T12:27:54, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> cmd: button: add live monitor subcommand
>
> 'button list' prints state once and exits. The new subcommand 'monitor'
> loops the input states with default timeout 5s so live verification
> on the device is easier.

'loops the input states' is still there. Please can you reword it?
Please also mention Ctrl-C, what a zero timeout means, and the move of
the state printing into show_button_status() so that 'list' can share
it. Something like: "Add a 'monitor' subcommand which redraws the
state of all buttons every 100ms until Ctrl-C is pressed or a timeout
(default 5s, 0 for none) expires, so that buttons can be checked live
on a device. Move the state printing from list_buttons() into a new
show_button_status() so both subcommands produce the same output."

With the commit message fixed:

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> cmd/button.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 95 insertions(+), 9 deletions(-)

Regards,
Simon
