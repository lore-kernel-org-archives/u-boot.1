Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE63FCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FE2260851;
	Fri,  2 Oct 2026 13:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pO-D_X3-hWQC; Fri,  2 Oct 2026 13:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 673BB606AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790948120;
	b=MmSQXmXOhXbYbChF7kyl1XuWsGHf9cjOXd39zMFTWDlKitnypx8oaIxK01vzO6NXjAc3
	 P8Zy7H139iMvLDJKFASefV2kolKugPb7A1OGzXPuWiaUqIzxFPvtPWkzLCnvaFrI6PQmC
	 mrneIqURACxwBTBj8tl9GZucGeqnzSra3cifmVWXw9AdN8LjSVkbrdheJ9i+uZJNmvUKV
	 ArKVTIV5A+BuDNWb9jf8Oe0xMTi0z9RVyvgaQvKx7GfIcF/+yr8fdFfeDj1aD7DsBog/Q
	 qZc2TFlaxe/Z+ijQ+MuFKy605KJ97TDi2fVO/Kzp+xoF+3o0tWPF/GK1072rwMypirA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790948120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5BfTIINIwL0XK3aXxEA5zmDJxNNCnJe1onAAYAdxGj4=;
	b=JC5ENlYxF62fMGbRC5oOalBjzE2+M1fjjkW5HJxjRd2+LoZksDo/k2zem0ERBkOqAJxN
	 QPq5rqBpLBh802dRv+Qyr1MJEaH8yDqg0pwQIY7ESGDNiCr3J/Ef3YbHOI4Ar4IRKGTks
	 o/vYlIJ3P4S2UZXRu2m+ENvLOb03Fq4KX246EFfQuiEwsoEAwWb8waYdWhWteySoxNKaw
	 +kG8B0BftBln3QOHTh72miy96pUjinaTAWsDMtV4mTyuObdshgIv1WcyxaqUq3frN8UHC
	 Iis+V4CZAKb4HiwPAY1bY1WzXB5pHQ9LSLFJTT3mIwrJNa3SP8IIsexw1ztDiMNIsGA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790948120;
	bh=5BfTIINIwL0XK3aXxEA5zmDJxNNCnJe1onAAYAdxGj4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D3+3Eyk3+KkzXRSaGnwobiCBtAacPzPCfaqkOoQmko0PVB9+O0z0pKjGgtZToX4fO
	 GJTFEUDxPPGIFDaHJLvqUCC3waZ4VHizNCRLlDKjqOW9PqnODBqDjaWpUCpfb7x/U0
	 51X8lnk8jNV44RMX3uRmq+/L0cMvVy47Z1mhk5iboZKSOQNgScY9odYbIw1D8bRjru
	 Ah3eGprtaBYi3QaJ+M7XH0AAfDK0plwYHJ2hExHrO5GO03Ist0+qRH62+riK/u9892
	 7UJDTZOY8f8a89duW6ja+1Ck2UhmZOVC1kozSnlo8dnEiqrHxaw7LXqIWz0h2mx+Il
	 MZTRKlhJfFLoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 673BB606AF;
	Fri,  2 Oct 2026 13:35:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F98A32F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20F5D81291
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsrStk4w1ZtY for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 655148127D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790948116;
 b=qupQJBHnjXCggMCB264Y33cCIiYMrzKFzi3G7W7cn5txsVc0B2PU4scAfABvcs1BZoh2
 Me9vnOVg7GKGruBZfpDYuSgkOiwArhL/lmqmGajHUKpEzX/ZE3jHXz1vlEC532jtDOEuu
 WSCiRayY79ruS9Fah2qpQsBxTk8te4B6jg3SC/4B4YsE/0FOGGVdozPVLRWVBecYYI61Y
 f7Z4ucuvCERJIzM/7l1x7pxTM/Z6FmgbvCXLirdlxCNKQycToLV7S0Ugiv+N4Ym1L28dS
 7HrmqeRMsUfjmniNPovsZwA+krHHAhBOOH8EdFMPkVgWEmiRnrPdvxUlmD1p84dgR/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790948116;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=5BfTIINIwL0XK3aXxEA5zmDJxNNCnJe1onAAYAdxGj4=;
 b=FAsVAKJkAMjlI4ZHUpfflrPwK575r+3MKgI7QsUvMAEOBZsG551yX6RFYeMRhPKiHC36
 G8M7TUySBeR08mx69mq3k7pPaPT+TN/aHWWTSYCVOZq4gj0WYHi57v38MDZqtY86AmGDI
 umIyTHU37QtuihWFtx7JidV2SLJppmP6KPm2PRg4gQLacYbo++iLNX9vMu0BaEZ7YERhh
 oBmZ5OE7S2YKMeg2Kt3zA+0b8JGgSjmKoBUCpSX2j0n6a88No4VU+HxLznotKhn4r9m5N
 oZhIEY1dXGRzeis2cbC5W7Evhfve4kjNxNVBiS13w/OxSnW1P7bNQ2Tjq2BTHRfyxyQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=vCTTxnpz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:36::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:36::e;
 helo=mail-dy2-x0e.google.com; envelope-from=alchark@flipper.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=vCTTxnpz
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com
 [IPv6:2607:f8b0:4864:36::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 655148127D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:35:15 +0000 (UTC)
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-33e630052ebso8686259eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790948115; cv=none;
 d=google.com; s=arc-20260327;
 b=GJOgF4KH48tIJFK9RG/ZI2P/nzWMC6eh0j0wqiynYNeqB95yMDOpSIPxvrMQXw/St8
 vemB3UILIzXenfwrzKDh+clkZP9MtTRmnlnglu0ezzg4Q6Aror1A9/vhDIrlzCdq2UKb
 w5xz8zoZ4PUf+uHl3ZHOI70kowuJlmhU4SFNcFhzXX78dEo9tSmk8Ak2kIocF7ZsjX9+
 3fKKvJwoyAeke7ippNfsen4JYM3D/51yxTLYBWf8ZMU8bDwUCXgY4+jBuof/LgHY5I7g
 RwfmU59NRjvjw9Zxe3cVzVhltrqWxJOxns+qBhUObeafl89qv3In+hEjqJ+BpbBZfuYG
 VtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5BfTIINIwL0XK3aXxEA5zmDJxNNCnJe1onAAYAdxGj4=;
 fh=k9kY7a1Wi14n0cNiG9IiAoGAT2s4BttBHc0XPc+Ktys=;
 b=Um4u0Bzf6g6TDAraCCRE9OZzm8TWYbngnenbBCa0S7d2tnFGkweyzKWE27kGUuQNfQ
 /J0CEkca9BzJVtXl5tgiLAf9SfUfNTj4jf154bkHpBo/HlnS5ykR84Y+Ofc7rcjYGlnF
 1zRM/2YtHL8jWxbRmEol0aAVfxYBYVw1mzkVvqEbV08cOCL2pn7kMopZdB2yhE9Xi+E5
 kIde9K0TzmWlt5gA9UlF/MXqRZbeiPEMBIvkYCymc0k1ORLfuy0ugNHoqJGPCZODLjVh
 G8PjI6oNMPfiNHAbAv0T/Y5WYFDmkAzu2PL7mRPmDi4e2H/NbqXU5Wxrx7Sl73ix79r3
 YGWQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790948115; x=1791552915;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5BfTIINIwL0XK3aXxEA5zmDJxNNCnJe1onAAYAdxGj4=;
 b=vCTTxnpzoSju4kugJRPmJPmc2I5GbJbyYlEf2V5A+SHw+WnhuRBuXyQ3X9e+69DK0c
 epLysSUYTinBxZinFPq31a6BeWj/Dai/zalKVW22rcC+/ugGqtaO2hpjjpvceMm5sMwx
 p+NG9AkNJmH2sz0ASOd8oOGhLaz4rR1YZ3S4KQu3xcRa9Bwmzy2okVY6mV9S3dw3qiAl
 TRdpcorinG41nNcfXTDWyi3kLkS5XI4MSI/z1hSY5a8jW0hk9VnfgHjjTGe0rJ0mAeLf
 VxlJsYdPkn+RnkP70Je9Zb+6Ky3h9Du27YAxXBnj5Z5nOzDgijI6ACAwKgiQVPwHS5a7
 iC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948115; x=1791552915;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5BfTIINIwL0XK3aXxEA5zmDJxNNCnJe1onAAYAdxGj4=;
 b=uKrsIgo5Fxp0NIzE4pUt6Y/LJOsMKBZLfr7DFdw8ULh0tEI1WUTBLaskuq1Y8w9qeO
 85LGXZWYyeMW3RI/DqIEk1dZ/hevxkmv6kPwFKk0WHp9e1O/6lDbu/P/mzkm6xVtSAXP
 /ufp3oqGrz3hhE8hKWOsMt/DLbKe1H1tSmks+WxtwlEWpt5rHvYOvpomwO/DgavnWi2I
 SMunqBD55yMujaTp7ZhA42JCjraT1Z7TmM8XYy9yMmWCz7eOilxhDfRRbZDgM2spLXRN
 uejWW1y7fZr9PYGvaD0vfFrtUaz2Fq+JLNCcbD2hGt0aAh9Epyn1AL7OSL+tm6Wk/pSo
 B0Og==
X-Gm-Message-State: AFuF++m6D3JhjFVKU3tgMvg4vZTDgqIp3knXWabAZw8G3PQDlbeiH2Q1
 ryJ+SbzjZWkEHPqK6am7iyc/pQXOhsivv29KwJhQ/MtebdZ2t+wAFeHc1bKpMAmvAPSkZCW12tJ
 zWMA4SvVy0v7CHR25gAIFkgXzEM2vgM6PP/Vzt7WFKQ==
X-Gm-Gg: AYBFou0ijILpQoal0AInBvWIbyDz+qsu3TMm1Y8/PRCYQFc3wXOybEK2j8De4i5t96D
 Rj30eZoOiMO7VGy1ptL3sGTjncbc+LedVt+2rc4epTvSowoEb3Ovr3LnhqYxtZ5OSFKIvk0/3J5
 vWX7BJapSJK3Ezuqrby10PQrkKYTPelLD++uLh4fExo5g6ZFEOpqXWHTe0iC6r10eZvQswXdUU3
 OPhkQYb/RlWtwywaVzoWRJ1fQw0BDMLW2Kc4V9m1BfOHkjjBhblXYt7WdJ1mtn7dfxG+/wKGhaD
 q7IJ5crk0nMZHw7gkcNymXStvkVEcXODuKxkFHcA8W+xxhGw3+5QUj3H8Rq8PNfEs7cUK9lbwJ4
 VN6RYVLiyIPLv6Rv/l6Rh/PQ=
X-Received: by 2002:a05:693c:41cb:20b0:342:810b:9554 with SMTP id
 5a478bee46e88-34f21854311mr3006356eec.32.1790948114763; Fri, 02 Oct 2026
 06:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-1-28e946f57357@flipper.net>
 <33e01488-7295-49d2-b9b8-c194e064f5e3@cherry.de>
In-Reply-To: <33e01488-7295-49d2-b9b8-c194e064f5e3@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 2 Oct 2026 17:35:02 +0400
X-Gm-Features: AclHuK8cLxgfWX9bRUQ6gSs4p45K9OKO0PiSBPt72qfVe0jWw7Q6spV-xBQVNPA
Message-ID: <CAKTNdwG21H+pxO+BaKRcPQc0XQZOaxRhWkp4Et-L00M=f=pf2w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] boot: image: Keep the image-type table out of xPL
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
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

Hi Quentin,

On Mon, Sep 21, 2026 at 7:27=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 9/18/26 12:52 PM, Alexey Charkov wrote:
> > print_decomp_msg() names the image it is about to unpack, which drags
> > uimage_type[] and its strings into any phase that links image_decomp().
> > That is about 2.5KB, measured on a Rockchip RK3576 SPL, spent on one li=
ne
> > of progress output in a phase built for size.
> >
> > Name it "image" there instead. U-Boot proper is unchanged.
> >
>
> Would it make sense to also print the hex/dec value image type stored in
> the type parameter? Considering we have:
> ## Checking hash(es) for Image u-boot ... sha256+ OK
>     Uncompressing image to 800000
> we know which image we're trying to uncompress so maybe this isn't so
> important (provided you have access to the original u-boot.itb and know
> you can run mkimage -l on it).

In fact, we aren't even parsing the image type by default in SPL,
except in limited cases defined by CONFIG_IS_ENABLED(FPGA) ||
(CONFIG_IS_ENABLED(OS_BOOT) && CONFIG_IS_ENABLED(DECOMPRESSION)), so
printing the numeric type value won't be helpful most of the time.

> I tried reverting only this patch in the series and I get
>     Uncompressing Invalid Image to 800000
> which is a bit odd since we actually should have a known type instead of
> invalid image (standalone program is what we have for U-Boot proper). So
> it wouldn't actually help to print the hex/dec value and would even be
> more confusing to the user (well, except if we fix this type being of
> unexpected value).

It would have been "Unknown Image", had I not been overzealous
replacing the initialization values in patch 5, as mentioned in that
patch's thread. IMO "Unknown Image" carries about the same descriptive
power as "image" alone though.

Best regards,
Alexey
