Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62934CA6004
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 12:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0444D6067C;
	Sat, 10 Oct 2026 12:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oR_RKVopUnjE; Sat, 10 Oct 2026 12:26:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1929A60663
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791635160;
	b=Z6ryJY8IKwwl8tlt+/vPrao/jP6HyVIRhzu4elkMGiapsI2gOkLXVTDPxqq0Fs2STnT3
	 d5XR3kNj6fOeHEHZ9zSwkNW0P+Yht95lVbjzGMPeY2499sPcIq4EDZz9IgRiX6deIwcKx
	 wrkhI+Zu9feTaPf5qxqksCXOUygA9Xvo7JyIXWUFfuvh3OnjEPkF4E7vlEoJmTjpC7/9J
	 vAMWhMH4eGjfV8tSCMi9dVfqYYd9uYuWOVtfm2fzisMC8jE7Xwr++meFapc5rSz+z2hgg
	 cMCrO5rCyjpNuqABmT2G2pNLbVQWaTGUVOxnN+3mmxq6qnRCQwRtof7Ix2ddMqqyytQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791635160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1GOElZNacPzAJKlIBaoA8r3GKnUWS80had0CKpanbCQ=;
	b=o5Q40RcWFQXA/bzLCc3mbpYtptShVGpJgSu5/uUdhpFa94NTi9Fth+WsDEWH9q/Djf+Z
	 z5OOTt6cWKtvtnH5TCYUKlrwQZNSwPLYzt4SoiFT2GhKBvMdG5eqNXNZAAiKzUflmlkSN
	 NZD6TJtSe04wmHATbOsaRovJ6uD0YvuraW3iViu15PAjwnh+3ibF0nPflxgH5AvUA9iB9
	 shtg9ZlGqBR0rN+dSKxqlS6jh93J6l0kQUZnLHkgb2CAIggLIB++QZPsq4apMfnj6DPF+
	 cmMP+Qklhj8hpHFaqb5EkXsFs4oaSIf372DuTRmqrC+SkI/y9RCMNxV1qXo36QEBMlQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791635160;
	bh=1GOElZNacPzAJKlIBaoA8r3GKnUWS80had0CKpanbCQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OEKKG/8iw12Nv3S5RopVpdRSMI8YN862RiK0yrtGgO1Q997w6yJKSd7rMj09up1mK
	 xW+w4zhfA5vMdA2/ihMSvGi4Had0YRv1eh39yLn9AgcxuLeo5hUiwR8QJloB6ktGkf
	 epFdH0ZPf902VmkehhO4tbh8yx+uJtWO9Qy892csEBty6JVnGEXWfXqBPkT0keTdRo
	 xlMoGBcswnCJOFsD1nKrB3FgiZWmozMM9K1UF3UahggBaVz7rf55pNzI88JoFNSPp6
	 qiiWXgczm84K+7K+puXWzfFRcgAhomjak3p4bIWM6G5MvOSHIi130rkoeBQcqWFH03
	 0Qt/A8oKCcMGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1929A60663;
	Sat, 10 Oct 2026 12:26:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FE7022B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C9AF40975
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ExaspxDGOK72 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:25:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D9494097A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791635157;
 b=QUEMNT7fFbgHW5N2hN4EkFzrh3WgDl88PJ9+02McS2ajS9q5Ev2l4h2dsI5/RQNEIUiq
 ZnDtxB2joKSfnJaZv7QJxmbwsmLtZbqC7UZiGcOZKx9vo39xQWQDD0vi2DU1RHB0eNEn+
 CBd69589kzQWphZxtMwvHGYRv/fxLsfY6mZEqn10y+McfyY2sgP+NlK5e9gpYxnQ6iORp
 Mv5OqUoa8Yu26Qry7FqpIG9o8N91jWElrVBLRsrjmPWQHw8hYYA6MI+LDai3GVTNvVIwS
 aL2X5AqAkg4GGkuHBGIysGwhiUxZ5u9Owpp75AtyiT/v4hyl6BSBCIdODKwu88ZewvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791635157;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=1GOElZNacPzAJKlIBaoA8r3GKnUWS80had0CKpanbCQ=;
 b=Ki9hLdDcqR6TSqrkGQRhUjAZ3YHJrgvb0qpyLSS/Egfo3nHnBSdi90DYYLV62buPXn/8
 6bVsOnXWqzlV17QuU9dODKKOrZMZm0uFxs0nGyN6FPjsWLSv4fqQUOFvRCCzw5XY8lm91
 sCnRZgieH1Gsd4q/cWO/Uh8eP8EJnWxXIjPb4J3/xC+vlHR4d+e9mkP4fvOlht1Msk6c+
 jpLF9+msaHH78FtfB/knQEQ3m24HJ7+/ACKpzWTB+QH6smWJUv3bewseMqTbc3Aikl7yr
 l08pnbZGXfNFyosUEAuGLniUaKHUIiqRI1k4fRIIP33RrE0KQUMVEhyqQSRNBnFmJdw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=6QfbdVx6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=6QfbdVx6
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D9494097A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:25:56 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c29c6a3930bso77923066b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 05:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791635154; cv=none;
 d=google.com; s=arc-20260327;
 b=BlD4NGXDdJjm5ot4LL5cpbIPnMPJsQBj+ipcn45+vcC9ezpQn9KJBlioRL1O4uwQz4
 neEyoC+tmC16X8BkzrnUR1rgSUV6xjFh1hSCw5KliCKEMiZmP69TxnoAUjOqfjQJ6Tb7
 0bNuxF4W4xO5PuR/qEwZ72jJP+PULiBR+ey8DBhDjAYwlV7gPluvce7uyyHwhgU7TVV1
 IrfawxSiCuxwyDw/L6jGkdV6Lsj18vkfOTFnHCoeZIwFa9qqNbK7EAZzoar1ZEgcueIR
 A9tZtGnvmKxA1fyle6ZvnpVn6xpWsnR8U4Ws7ddqw2p+9k5yRLfT8voDMF1sOKYIKwXA
 ViZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1GOElZNacPzAJKlIBaoA8r3GKnUWS80had0CKpanbCQ=;
 fh=qgasSHWK9ABu1C4X6rYrv/IN0O2UMctworj4pvZ1u7s=;
 b=eX50eH+NbJhF05BJmT9pAva2XHVyzysu2J+nG6N7OcgdyLpwBjtWKd0hndUnMM3Fx8
 NYmc9LDWigK4AetGahILspUC23CMJxYS20KbRGX66JqHsfQ83OaDxMk4upeEEFeNJ4Fk
 g0RouRbjEH5zGdV4+fFA/5q6GyvzX7CxvhbpivM30lIxTf+YmlXX9kc5aAqGzXuT6sqV
 funaXhgUJKPTp+L7POpHFDGXTcTAUwBiNLDju+j8wBdR5zhER9iPNlUAlTA0WmIISDSa
 FgCY+2fexgVgaKprIEElh5T5/tjrv5z3ydASckfsE8iooVHLLI9Y+IU8RQmNuyATffwS
 p4MA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1791635154; x=1792239954;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1GOElZNacPzAJKlIBaoA8r3GKnUWS80had0CKpanbCQ=;
 b=6QfbdVx6mNUUZ9tdJvKeemV+IYSpfD9juaeFxzIkdmSM3hgoBKQaUXC+tvBJ0Q2YYh
 etNb0u4cb5eH3jtoQnyklwJ33NTPcXaqrIcAKX4/WDbTJaLMtZ7yI/i+B8W+1rdlNWf4
 iJGAet78GAHR5d9wwRER2CGOAaGzDfbRQ7eYD2fZrUek3BKGAcBwdHGw5w7+Kl8jUNWk
 bcKDh8n47FfS6M6S6/o1tOcJfhNQApiqUbOE2BKExxVE1QcyL5tcy05Le4z355qTezd1
 DA/GPFwco2pzEXNGieKflHx966ueFjIjG5IE73V4lO0OzQtUD6LjiT4UX46qrqJEeIE9
 AgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791635154; x=1792239954;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1GOElZNacPzAJKlIBaoA8r3GKnUWS80had0CKpanbCQ=;
 b=einkFpDJNx8Xu2emKEnhbyP8gZicgzMbkxR9aRs3+HjoZi5SPk6IET/oBWyCdXcZdD
 sngEAhvEjuuhDl/3Br77kahciV8PilLr+YpXf3l3uNZPGWnNb2HW5SH5Q3bbZ3JIyGcx
 6WZIQZ5wKucoXhA8ak36UB7LBgs0qDPsqNYTeU8mJRmo0K6ZFGWFP6sCRgjAXyJp7wHK
 HzKlRc/yPz/66C2eLV7Ji1HYKCnmMLS04g1bf768EBoKpwHlkJabdb5vDglRAofyI4OS
 a8B0r4ox4YNY8gWXtoeT9oH0D4t/8d0iOi0/Eb32HfRNpqG1AkukfOtrjZ+gc1Aw1JLk
 ZGog==
X-Gm-Message-State: AFq9FYLw3+fo/C8XrDFXxwbD9KAWNXeBZSZg5o3T6oFqQI+VVR2WWIIc
 X4IXMH11N6Huvr0x2N1d4/5DqTj9Vke+7qQcF3K53k8376gMRKplZZUQ5zJ+Kxx8HghQCEGZzoI
 WEVVK4/Bsi9yX/ovW/dgehMRjkQCezEvAqgPbDwGVv2RHVOqFpHSOvsDIzQ==
X-Gm-Gg: AYBFou35Zp6zeg6HdX3WWPF/q6vvXfbGuh+l5m3LNLF6+x//3GGOhz557jRs9LRVJI9
 rYVN+xQaQdXNiUM6yZocTXgSb2Egc/Rkp3IQCGayB8OX6TDP3HYb3qRkF8m+dSpPDpZp4Ihzk7B
 CkC3GzoPmOQ6Hi3qIchH0VAwDIb9AXvNqPEop5en7LCSM9KBczq0mMEO1Yp8sFf7uBEyJj0hsyY
 EZCYgpHg7cqfakNV1ZQG7RwXlPDFFPYa3/oDSwro/6uSNdfXDW7LL5sQ0c0hHtiDXc4CtnmJTAn
 vTiPMNpsd07c0D7xU/2wFMpizbzQrDCvJrjhrl6sVByeCfvP6czp8VC64Md+qgeIxCZE
X-Received: by 2002:a17:907:7296:b0:c2e:4f16:fbf with SMTP id
 a640c23a62f3a-c31a9f8af14mr478551266b.31.1791635153490; Sat, 10 Oct 2026
 05:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
 <CAFLszTjpAyratAmqYepsBDd4Y6trt3DkGJb9ZK-tBViom6JjXA@mail.gmail.com>
In-Reply-To: <CAFLszTjpAyratAmqYepsBDd4Y6trt3DkGJb9ZK-tBViom6JjXA@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 10 Oct 2026 16:25:41 +0400
X-Gm-Features: AclHuK-2xpQ0yOTOi6SFs-bCxTu3Y2546c7yt0ootvxnczRMKPJhA9lHk7iAfLo
Message-ID: <CAKTNdwET0R1c3KxA6H0Q+B7pY04kxESA4=4F6V=4kBmhV2-XRw@mail.gmail.com>
Subject: Re: [v2,
 0/7] disk: Fix the GPT layout on media with large logical blocks
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

Thank you for your review!

On Sat, Oct 3, 2026 at 8:47=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-09-18T12:13:49, Alexey Charkov <alchark@flipper.net> wrote:
>
> > Patches 3 and 4 add the C tests, which are complementary rather than
> > alternatives. Patch 3 drives gpt_fill_header()/gpt_fill_pte() with a
> > synthetic descriptor, which is the only practical way to sweep block
> > sizes from 512 to 32768, but it can never reach anything that touches t=
he
> > medium. Patch 5 backs a blkmap device with plain memory and does a full
> > write/verify/parse round trip
>
> The blkmap round trip is patch 4; patch 5 is the malta64 defconfig
> change. In the change log, the 'unbind the 4096-byte device' item is
> listed under patch 6 but is in patch 7, and there are two 'Patch 3'
> entries, so it is hard to tell which numbering (v1 or v2) each line
> uses. Please can you fix the numbering if there is a v3?

Yes, will fix. Deleting a patch between versions is messy in this regard :)

> > Partitions given without an explicit start=3D will be placed
> > lower, though, and on sunxi first_usable_lba lands exactly on the 8 KiB
> > SPL offset, so sunxi and Rockchip folks may want to look at patch 1
> > specifically (none of the devices I have override the default).
>
> It would be worth copying those maintainers.

Ack.

> Just to check, has this been tried on a sunxi or Rockchip board where
> the first partition has no explicit start=3D ? If that case can
> overwrite the SPL, I wonder whether the series should deal with it,
> e.g. by having those boards set CONFIG_EFI_PARTITION_ENTRIES_OFF, or
> at least mention the change in the documentation, rather than leaving
> it as a note in the commit message. What do you think?

I've rechecked, and all of those boards that set $partitions also have
a fixed start=3D, so no existing users should really be affected after
all. Without $partitions any gpt write would fail anyway, as seems to
be the case on Khadas Edge2 (hinting that it was likely never tested
in the first place).

> > Patch 5 enables EFI_PARTITION and BLKMAP on malta64 so both tests are
> > actually built and run on a big-endian target.
>
> The blkmap can only be created with 512-byte blocks, so the round-trip
> test in patch 4 has a single case and the 4096-byte write/read path is
> only covered on sandbox, by the python test in patch 7. So the full
> write/verify/parse path at that block size has no big-endian coverage.
> That is fine for this series, but please can you list it in the 'Still
> not covered' section?

Yes, full big-endian coverage is quite involved - will mention this in
the cover letter on v3.

> BTW the discussion with Heinrich on patch 2 about converting names
> with the charset functions is still open. If the outcome is to leave
> the lossy conversion as is due to SPL size (I tend to agree), please
> can you mention that in the cover letter as a known limitation?

Will do, thanks.

Best regards,
Alexey
